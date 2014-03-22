require 'mechanize'
require 'json'
require 'hashie'

module CryptoCoinCharts
  class << self
    
    VERSION = '0.0.1'
    
    API_URL = 'http://www.cryptocoincharts.info/v2/api'
    VALID_PAIRS = [
      :"42_btc", :"888_btc", :aaa_btc, :adt_btc, :air_btc, :alb_btc, :alf_btc, :alp_btc, 
      :amc_btc, :anc_btc, :ant_btc, :aph_btc, :app_btc, :arg_btc, :asc_btc, :asr_btc, :atp_btc, :aur_btc, 
      :bat_btc, :bc_btc, :bcx_btc, :bea_btc, :bec_btc, :bela_btc, :beli_btc, :ben_btc, :bet_btc, :bfc_btc, 
      :bil_btc, :blc_btc, :blk_btc, :boc_btc, :bqc_btc, :btb_btc, :btc_btc, :btcs_btc, :bte_btc, :btg_btc, 
      :btq_btc, :btr_btc, :buk_btc, :c2_btc, :cach_btc, :cage_btc, :cap_btc, :cash_btc, :cat_btc, :cdc_btc, 
      :cent_btc, :cga_btc, :cgb_btc, :cin_btc, :clr_btc, :cmc_btc, :cnc_btc, :cnote_btc, :cny_btc, :coin_btc, 
      :col_btc, :con_btc, :corg_btc, :cpr_btc, :crc_btc, :csc_btc, :ctm_btc, :dbl_btc, :dem_btc, :dgb_btc, 
      :dgc_btc, :diem_btc, :dime_btc, :dmd_btc, :doge_btc, :drk_btc, :dsc_btc, :dtc_btc, :duck_btc, :dvc_btc, 
      :eac_btc, :ebt_btc, :efl_btc, :elc_btc, :elp_btc, :emc2_btc, :emd_btc, :emo_btc, :etok_btc, :eur_btc, 
      :exc_btc, :exe_btc, :ezc_btc, :ffc_btc, :flap_btc, :flo_btc, :flt_btc, :fox_btc, :frc_btc, :fre_btc, 
      :frk_btc, :frq_btc, :fry_btc, :fsc_btc, :fst_btc, :ftc_btc, :fz_btc, :gac_btc, :gdc_btc, :ghc_btc, 
      :gil_btc, :glb_btc, :glc_btc, :gld_btc, :glx_btc, :gme_btc, :gns_btc, :gpu_btc, :gpuc_btc, :gra_btc, 
      :grc_btc, :grump_btc, :grw_btc, :hbn_btc, :hic_btc, :hiro_btc, :hkc_btc, :hpc_btc, :huc_btc, :hvc_btc, 
      :hyc_btc, :i0c_btc, :icn_btc, :ifc_btc, :ipc_btc, :iqd_btc, :isk_btc, :ixc_btc, :jkc_btc, :karm_btc, 
      :kdc_btc, :kgc_btc, :krn_btc, :lbw_btc, :ldc_btc, :leaf_btc, :lgbt_btc, :lk7_btc, :lky_btc, :lot_btc, 
      :love_btc, :ltc_btc, :lyc_btc, :max_btc, :mcx_btc, :mec_btc, :med_btc, :mem_btc, :meow_btc, :mim_btc, 
      :mint_btc, :mmc_btc, :mnc_btc, :moon_btc, :mrc_btc, :mrs_btc, :msc_btc, :mst_btc, :mtc_btc, :mts_btc, 
      :mvc_btc, :mxb_btc, :myr_btc, :mzc_btc, :nan_btc, :nbl_btc, :nec_btc, :net_btc, :nib_btc, :nka_btc, 
      :nmc_btc, :nobl_btc, :nok_btc, :nrb_btc, :nrs_btc, :nvc_btc, :nwc_btc, :nxt_btc, :nyan_btc, :nym_btc, 
      :ogc_btc, :oly_btc, :orb_btc, :osc_btc, :pand_btc, :panda_btc, :pawn_btc, :pcc_btc, :peng_btc, :pho_btc, 
      :phs_btc, :pi_btc, :pig_btc, :plnc_btc, :pmc_btc, :points_btc, :pop_btc, :pot_btc, :ppc_btc, :ppl_btc, 
      :prc_btc, :prt_btc, :pt_btc, :pts_btc, :pwc_btc, :pxc_btc, :pxl_btc, :pyc_btc, :q2c_btc, :qqc_btc, 
      :qrk_btc, :rch_btc, :rdd_btc, :rec_btc, :red_btc, :redd_btc, :ric_btc, :rpc_btc, :rpd_btc, :rqc_btc, 
      :ruby_btc, :rur_btc, :ryc_btc, :sat_btc, :sav_btc, :sbc_btc, :sc_btc, :skc_btc, :sll_btc, :sloth_btc, 
      :smc_btc, :soc_btc, :spa_btc, :spt_btc, :src_btc, :stc_btc, :str_btc, :sun_btc, :svc_btc, :sxc_btc, 
      :syn_btc, :tag_btc, :tak_btc, :tea_btc, :tek_btc, :tes_btc, :tgc_btc, :tips_btc, :tix_btc, :top_btc, 
      :trc_btc, :trl_btc, :ttc_btc, :ufc_btc, :uni_btc, :uno_btc, :usd_btc, :usde_btc, :utc_btc, :vel_btc, 
      :ven_btc, :vtc_btc, :wdc_btc, :wiki_btc, :wolf_btc, :xcp_btc, :xiv_btc, :xjo_btc, :xnc_btc, :xpm_btc, 
      :xrp_btc, :xsv_btc, :yac_btc, :yang_btc, :ybc_btc, :yin_btc, :zcc_btc, :zed_btc, :zeit_btc, :zet_btc
    ]
    
    def list_coins
      coins = JSON.parse(Mechanize.new.get("#{API_URL}/listCoins").body)
      coins.map {|c| Hashie::Mash.new(c) }
    end
    
    def coin_info(pair)
      raise ArgumentError, "You must supply a valid coin pair!" if !VALID_PAIRS.include?(pair.to_sym)
      #Hashie::Mash.new(JSON.parse(Mechanize.new.get("#{API_URL}/tradingPair/#{pair.to_s}").body))
      coins_info(pair)[0]
    end
    
    def coins_info(*pairs)
      pairs.map! {|p| p.to_sym }
      pairs.each do |pair|
        raise ArgumentError, "You must supply only valid coin pairs!" if !VALID_PAIRS.include?(pair)
      end
      coins = JSON.parse(Mechanize.new.post("#{API_URL}/tradingPairs", {
        :pairs => pairs.join(',')
      }).body)
      coins.map {|c| Hashie::Mash.new(c) }
    end
    
  end
end