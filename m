Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8171 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbeBVCl7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Feb 2018 21:41:59 -0500
Date: Thu, 22 Feb 2018 10:41:32 +0800
From: kbuild test robot <lkp@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v8 6/7] PCI: Unify wait for link active into generic pci
Message-ID: <201802221003.61WmAOQy%fengguang.wu@intel.com>
References: <1519208804-24512-7-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
In-Reply-To: <1519208804-24512-7-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Oza,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.16-rc2 next-20180221]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oza-Pawandeep/Address-error-and-recovery-for-AER-and-DPC/20180222-060518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.ablkcipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.blkcipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.cipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.compress' not described in 'crypto_alg'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.prev_bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2259: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2259: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:950: warning: Function parameter or member 'rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu' not described in 'sta_info'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.sign' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.realbits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.storagebits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.shift' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.repeat' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.endianness' not described in 'iio_chan_spec'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/device.h:294: warning: Function parameter or member 'coredump' not described in 'device_driver'
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/mtd/rawnand.h:709: warning: Function parameter or member 'timings.sdr' not described in 'nand_data_interface'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf.in' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf.out' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.cmd' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.data' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.waitrdy' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx.data' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1281: warning: Function parameter or member 'manufacturer.desc' not described in 'nand_chip'
   include/linux/mtd/rawnand.h:1281: warning: Function parameter or member 'manufacturer.priv' not described in 'nand_chip'
>> drivers/pci/pci.c:4189: warning: Function parameter or member 'pdev' not described in 'pci_wait_for_link'
   drivers/pci/pci.c:4189: warning: Excess function parameter 'dev' description in 'pci_wait_for_link'
   include/linux/regulator/driver.h:221: warning: Function parameter or member 'resume_early' not described in 'regulator_ops'
   drivers/regulator/core.c:4299: warning: Excess function parameter 'state' description in 'regulator_suspend_late'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.left' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.right' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.top' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.bottom' not described in 'drm_tv_connector_state'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.base' not described in 'drm_pending_vblank_event'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.vbl' not described in 'drm_pending_vblank_event'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.seq' not described in 'drm_pending_vblank_event'
   drivers/gpu/drm/tve200/tve200_drv.c:1: warning: no structured comments found
   include/linux/skbuff.h:846: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'skb_mstamp' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__unused' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'pfmemalloc' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'offload_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'offload_mr_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:234: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.rmem_alloc' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.len' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.head' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.tail' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'adj_list.upper' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'adj_list.lower' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'switchdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   include/linux/rcupdate.h:570: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:574: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:578: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:580: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:580: WARNING: Inline literal start-string without end-string.
   kernel/time/timer.c:1259: ERROR: Unexpected indentation.
   kernel/time/timer.c:1261: ERROR: Unexpected indentation.
   kernel/time/timer.c:1262: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:113: ERROR: Unexpected indentation.
   include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1113: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:327: WARNING: Inline literal start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   include/linux/iio/iio.h:191: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:192: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:198: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/ata/libata-core.c:5920: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5052: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1901: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/mtd/rawnand.h:805: ERROR: Unexpected indentation.

vim +4189 drivers/pci/pci.c

  4178	
  4179	/**
  4180	 * pci__wait_for_link - Wait for link till its active/inactive
  4181	 * @dev: Bridge device
  4182	 * @active: waiting for active or inactive ?
  4183	 *
  4184	 * Use this to wait till link becomes active or inactive.
  4185	 */
  4186	
  4187	bool pci_wait_for_link(struct pci_dev *pdev, bool active)
  4188	{
> 4189		int timeout = 1000;
  4190		bool ret;
  4191		u16 lnk_status;
  4192	
  4193		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
  4194		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
  4195	
  4196		while ((ret != active) && (timeout > 0)) {
  4197			msleep(10);
  4198			timeout -= 10;
  4199			pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
  4200			ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
  4201		}
  4202	
  4203		if (ret == active)
  4204			return true;
  4205	
  4206		dev_printk(KERN_DEBUG, &pdev->dev,
  4207			   "Data Link Layer Link Active not %s in 1000 msec\n",
  4208			   active ? "set" : "cleared");
  4209	
  4210		return false;
  4211	}
  4212	EXPORT_SYMBOL(pci_wait_for_link);
  4213	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
i/kVqKNhAAA=

--EeQfGwPcQSOJBaQU--
