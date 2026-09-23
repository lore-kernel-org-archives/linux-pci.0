Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84947B406
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154814; cv=none; b=jq3ULRVrTIA6WhN9HCoVOWnt3YKLGCpx5iPOF3l2+pYBnYeZJyAn2xDLhaIP2T3ywlza4Vhu1Q0Xpin25UrftqKgFWuFBtlkL+e2alr4CZAv6Qo91/mDnfe+KLzK8h0C9PTKUUOEqsWlP68Zq6W3jyfGzQEbLhN8p9Q5Fr9hIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154814; c=relaxed/simple;
	bh=1NNatIo4Do4nnMoESnHG8WZVBZR9AJJnttCtBxyBKPM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ax9thFyQhUsFT0y5KpokU36kZH5+6Jqf3sxNzRpYU6lRH9KU/h58u6UqjgxFFDdbA5uPYKrlSUydRqruZgnLNw1rF5V5z670Jqt9N0hfSTrZU4Y6hFylpHdC3aH3pD0XbW4s9Cd7elP8nQ91PWGpWOjq+wKAmRUnQo8cQ0Se/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=B0VyEGzM; arc=none smtp.client-ip=91.218.175.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="B0VyEGzM"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1NNatIo4Do4nnMoESnHG8WZVBZR9AJJnttCtBxyBKPM=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790154808; v=1; x=1790759608;
 b=B0VyEGzM0qNRVV+jr01vJ/ObOrHono2oMbUOkCta8YqwE9RC8AQQ55SbyKDrMN+lBr226Qgu
 M1VRyuTBV+JNVd1N87wzRirhIIi464GUvjJ/S7A3zDyZrpw4ATD/s3bNqHLsj4dhF1KfNARHvaE
 4OjyaQYqAJZrBYeSB2LSnOnL94xj3wSvFwQwTdrn3U09qLEoH1uPuDQu/tMSQuns7GMFMboWKvG
 tUanB3B8kbVEHFxJbWaYGqA9dW/l/8BpQ55MPQKa5SgXZh59Vdk4g0nYVk5qXGyt59NpaPzYmxL
 39f3Vc0jRx4FCHUKduyzGSOeYqO+AVXTejLYSYLUrsKsg==
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7b87e8bc8a1e6b9;
	Wed, 23 Sep 2026 09:13:18 +0000
X-Mizu-Trace-ID: e7b87e8bc8a1e6b9
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 11:13:13 +0200
Message-Id: <DLMKWV1AH8TZ.2R3JK2NPM4KZB@cknow-tech.com>
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Shawn Lin" <shawn.lin@rock-chips.com>, "Manivannan Sadhasivam"
 <mani@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
Cc: <linux-rockchip@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 "Niklas Cassel" <cassel@kernel.org>
Subject: Re: [PATCH v3 0/3] Small INTx fixes for Rockchip's dwc based PCIe
 controller driver
X-Mailer: aerc 0.22.0-24-g39041fd9f179
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>

Hi,

On Tue Sep 22, 2026 at 4:36 AM CEST, Shawn Lin wrote:
>
> This short series fixes the INTx handling around the newly introduced
> .reset_root_port() (b376b3ff9cb0), and is split in three patches per
> Niklas' suggestion:
>
> Patch 1 stops .reset_root_port() from recreating the INTx irq domain
> on every root port reset, which leaked the old domain and silently
> broke INTx delivery afterwards, the downstream devices' virqs were
> allocated in the previous domain and were never re-mapped. By moving
> the of_irq_get_byname() lookup, the INTx irq domain creation and the
> chained handler installation into rockchip_pcie_configure_rc(), right
> after dw_pcie_host_init(). This leaves .init() with nothing but
> idempotent register programming, so it can safely be re-run by
> .reset_root_port() and dw_pcie_resume_noirq().
>
> Patch 2 makes the irq domain and the chained handler devm-managed, so
> that they are released with the device instead of leaking, which also
> addresses the probe failure leak/use-after-free flagged by the Sashiko
> review.
>
> Patch 3 keeps the INTx IRQ masked while .reset_root_port() gates the
> controller clocks, so the chained handler cannot read the unclocked
> APB bus and raise a synchronous external abort.

I build a kernel with this patch set (7.3~rc4-2) and got several warnings
like this, shortly followed by a stack trace:

  irq: no irq domain found for legacy-interrupt-controller !

Then I build another kernel (7.3~rc4-3) where I disabled this patch set
and then I did not get the warnings/stack traces.

I was able to reproduce this on the following devices:
1) NanoPC-T6 Plus (RK3588)
2) Rock 5B (RK3588)
3) NanoPi-R5S (RK3568)

ad 3) Possibly unrelated, but I sometimes get this error:

  gpio-keys gpio-keys: error -ENXIO: Unable to get irq number for GPIO

      But that is *not* dependent on this patch set; I'm not sure if I've
      seen it with this patch set. Could be because I haven't booted enough
      with the 7.3~rc4-2 kernel. Or maybe this patch set fixed it?
      The (only) correlation is that it has to do with IRQs.

I don't know if this patch set caused the warning/stack traces or just
brought an underlying issue to surface, but hopefully you do.

Warnings/stack trace on NanoPC-T6 Plus (because it's the most extensive):

```
root@nanopc-t6-plus:~# dmesg --level 4
[    2.684054] pci 0003:30:00.0: Primary bus is hard wired to 0
[    2.691234] irq: no irq domain found for legacy-interrupt-controller !
[    3.043257] irq: no irq domain found for legacy-interrupt-controller !
[    3.133600] ------------[ cut here ]------------
[    3.133619] error: hwirq 0x0 is too large for :pcie@fe150000:legacy-inte=
rrupt-controller
[    3.133639] WARNING: kernel/irq/irqdomain.c:676 at irq_domain_associate_=
locked+0x118/0x1a0, CPU#7: kworker/u32:5/60
[    3.133662] Modules linked in: nvme rk808_regulator nvme_core nvme_keyri=
ng nvme_auth fusb302 tcpm rockchipdrm fan53555 aux_hpd_bridge dw_hdmi_qp rt=
c_hym8563 dw_mipi_dsi dw_hdmi analogix_dp drm_dp_aux_bus drm_display_helper=
 rockchip_saradc fixed sdhci_of_dwcmshc cec phy_rockchip_usbdp sdhci_pltfm =
industrialio_triggered_buffer phy_rockchip_naneng_combphy dw_mmc_rockchip s=
dhci rc_core typec dw_mmc_pltfm gpio_rockchip phy_rockchip_samsung_hdptx di=
splay_connector phy_rockchip_snps_pcie3 kfifo_buf nvmem_rockchip_otp drm_cl=
ient_lib cqhci ohci_platform spi_rockchip_sfc dw_mmc dw_wdt spi_rockchip ro=
ckchip_dfi pl330 drm_dma_helper ehci_platform drm_kms_helper dwc3 ehci_hcd =
drm ohci_hcd udc_core adc_keys usbcore i2c_rk3x phy_rockchip_inno_usb2 indu=
strialio pwm_rockchip ulpi usb_common
[    3.133815] CPU: 7 UID: 0 PID: 60 Comm: kworker/u32:5 Not tainted 7.3-rc=
4+unreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc4-2
[    3.133831] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
[    3.133838] Workqueue: async async_run_entry_fn
[    3.133852] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    3.133862] pc : irq_domain_associate_locked+0x118/0x1a0
[    3.133872] lr : irq_domain_associate_locked+0x118/0x1a0
[    3.133881] sp : ffff80008043b9c0
[    3.133887] x29: ffff80008043b9c0 x28: 0000000000000000 x27: 00000000000=
00000
[    3.133900] x26: ffff000100038c00 x25: 00000000fffffef7 x24: ffff0001095=
393e8
[    3.133913] x23: 0000000000000000 x22: 0000000000000073 x21: 00000000000=
00000
[    3.133925] x20: ffff0001196c9e30 x19: ffff000108e8d500 x18: 00000000000=
0000a
[    3.133937] x17: 7075727265746e69 x16: 2d79636167656c3a x15: 07200720072=
00720
[    3.133949] x14: 0720072007200720 x13: 0720072007200720 x12: 00000000000=
6ff90
[    3.133961] x11: ffffc87b581950d0 x10: ffffc87b5810cf08 x9 : ffffc87b55d=
b6444
[    3.133974] x8 : ffffc87b5817d0e8 x7 : ffffffffffffefff x6 : 00000000000=
00001
[    3.133985] x5 : ffffc87b5817d078 x4 : 0000000000000000 x3 : 00000000000=
00000
[    3.133997] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000100b=
7a580
[    3.134010] Call trace:
[    3.134016]  irq_domain_associate_locked+0x118/0x1a0 (P)
[    3.134028]  irq_create_mapping_affinity_locked+0x98/0x1b8
[    3.134039]  irq_create_fwspec_mapping+0x320/0x3e0
[    3.134049]  irq_create_of_mapping+0x74/0xb0
[    3.134059]  of_irq_parse_and_map_pci+0xf8/0x1f8
[    3.134072]  pci_assign_irq+0x9c/0x180
[    3.134082]  pci_device_probe+0x68/0x170
[    3.134091]  really_probe+0xc8/0x3f8
[    3.134102]  __driver_probe_device+0x168/0x1c8
[    3.134110]  driver_probe_device+0x44/0x128
[    3.134119]  __driver_attach_async_helper+0x58/0xf8
[    3.134128]  async_run_entry_fn+0x40/0x1a0
[    3.134138]  process_one_work+0x1cc/0x550
[    3.134150]  worker_thread+0x18c/0x2f0
[    3.134161]  kthread+0x134/0x150
[    3.134171]  ret_from_fork+0x10/0x20
[    3.134183] ---[ end trace 0000000000000000 ]---
[    3.331933] pci 0004:40:00.0: Primary bus is hard wired to 0
[    3.338953] irq: no irq domain found for legacy-interrupt-controller !
[    3.492147] ------------[ cut here ]------------
[    3.492161] error: hwirq 0x0 is too large for :pcie@fe190000:legacy-inte=
rrupt-controller
[    3.492182] WARNING: kernel/irq/irqdomain.c:676 at irq_domain_associate_=
locked+0x118/0x1a0, CPU#6: (udev-worker)/187
[    3.492205] Modules linked in: r8169(+) realtek phy_package mdio_devres =
of_mdio fixed_phy fwnode_mdio libphy mdio_bus xhci_plat_hcd xhci_hcd nvme r=
k808_regulator nvme_core nvme_keyring nvme_auth fusb302 tcpm rockchipdrm fa=
n53555 aux_hpd_bridge dw_hdmi_qp rtc_hym8563 dw_mipi_dsi dw_hdmi analogix_d=
p drm_dp_aux_bus drm_display_helper rockchip_saradc fixed sdhci_of_dwcmshc =
cec phy_rockchip_usbdp sdhci_pltfm industrialio_triggered_buffer phy_rockch=
ip_naneng_combphy dw_mmc_rockchip sdhci rc_core typec dw_mmc_pltfm gpio_roc=
kchip phy_rockchip_samsung_hdptx display_connector phy_rockchip_snps_pcie3 =
kfifo_buf nvmem_rockchip_otp drm_client_lib cqhci ohci_platform spi_rockchi=
p_sfc dw_mmc dw_wdt spi_rockchip rockchip_dfi pl330 drm_dma_helper ehci_pla=
tform drm_kms_helper dwc3 ehci_hcd drm ohci_hcd udc_core adc_keys usbcore i=
2c_rk3x phy_rockchip_inno_usb2 industrialio pwm_rockchip ulpi usb_common
[    3.492388] CPU: 6 UID: 0 PID: 187 Comm: (udev-worker) Tainted: G       =
 W           7.3-rc4+unreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc4-=
2
[    3.492404] Tainted: [W]=3DWARN
[    3.492410] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
[    3.492417] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    3.492427] pc : irq_domain_associate_locked+0x118/0x1a0
[    3.492437] lr : irq_domain_associate_locked+0x118/0x1a0
[    3.492446] sp : ffff8000818335e0
[    3.492451] x29: ffff8000818335e0 x28: ffffc87b5865ccb8 x27: ffffc87ae59=
d7818
[    3.492465] x26: 000000000000000c x25: ffff000103534310 x24: ffff00010a5=
0cde8
[    3.492477] x23: 0000000000000000 x22: 0000000000000088 x21: 00000000000=
00000
[    3.492490] x20: ffff000168464630 x19: ffff000108fb2a00 x18: 00000000000=
0000a
[    3.492502] x17: 7075727265746e69 x16: 2d79636167656c3a x15: 07200720072=
00720
[    3.492514] x14: 0720072007200720 x13: 0720072007200720 x12: 00000000000=
6ff90
[    3.492526] x11: ffffc87b581950d0 x10: ffffc87b5810cf08 x9 : ffffc87b55d=
b6444
[    3.492538] x8 : ffffc87b5817d0e8 x7 : ffffffffffffefff x6 : 00000000000=
00001
[    3.492550] x5 : ffffc87b5817d078 x4 : 0000000000000000 x3 : 00000000000=
00000
[    3.492562] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0001097=
192c0
[    3.492574] Call trace:
[    3.492579]  irq_domain_associate_locked+0x118/0x1a0 (P)
[    3.492591]  irq_create_mapping_affinity_locked+0x98/0x1b8
[    3.492602]  irq_create_fwspec_mapping+0x320/0x3e0
[    3.492613]  irq_create_of_mapping+0x74/0xb0
[    3.492623]  of_irq_parse_and_map_pci+0xf8/0x1f8
[    3.492635]  pci_assign_irq+0x9c/0x180
[    3.492646]  pci_device_probe+0x68/0x170
[    3.492656]  really_probe+0xc8/0x3f8
[    3.492666]  __driver_probe_device+0x168/0x1c8
[    3.492675]  driver_probe_device+0x44/0x128
[    3.492683]  __driver_attach+0xd0/0x228
[    3.492692]  bus_for_each_dev+0x84/0xf0
[    3.492704]  driver_attach+0x2c/0x40
[    3.492712]  bus_add_driver+0x124/0x280
[    3.492720]  driver_register+0x70/0x138
[    3.492729]  __pci_register_driver+0x48/0x60
[    3.492742]  rtl8169_pci_driver_init+0x30/0xfd0 [r8169]
[    3.492768]  do_one_initcall+0x5c/0x458
[    3.492778]  do_init_module+0x5c/0x280
[    3.492788]  load_module+0x1cc0/0x25b8
[    3.492796]  init_module_from_file+0xe8/0x158
[    3.492805]  __arm64_sys_finit_module+0x208/0x360
[    3.492814]  invoke_syscall.constprop.0+0xac/0x110
[    3.492829]  el0_svc_common.constprop.0+0x40/0xf0
[    3.492842]  do_el0_svc+0x24/0x40
[    3.492854]  el0_svc+0x40/0x260
[    3.492867]  el0t_64_sync_handler+0xa0/0xe8
[    3.492879]  el0t_64_sync+0x198/0x1a0
[    3.492888] ---[ end trace 0000000000000000 ]---
[    3.554818] pci 0002:20:00.0: Primary bus is hard wired to 0
[    3.563276] irq: no irq domain found for legacy-interrupt-controller !
[    3.569263] irq: no irq domain found for legacy-interrupt-controller !
[    8.679178] panthor fb000000.gpu: [drm] Firmware protected mode entry is=
 not supported, ignoring
[    8.871598] rockchip-i2s-tdm fddf0000.i2s: using zero-initialized flat c=
ache, this may cause unexpected behavior
[    9.004753] ------------[ cut here ]------------
[    9.004768] error: hwirq 0x0 is too large for :pcie@fe180000:legacy-inte=
rrupt-controller
[    9.004779] WARNING: kernel/irq/irqdomain.c:676 at irq_domain_associate_=
locked+0x118/0x1a0, CPU#5: (udev-worker)/399
[    9.004791] Modules linked in: mt7925e(+) aes_ce_blk mt7925_common snd_s=
oc_audio_graph_card(+) ghash_ce gf128mul mt792x_lib pwm_fan mt76_connac_lib=
 btusb leds_gpio snd_soc_simple_card gpio_ir_recv btrtl snd_soc_simple_card=
_utils mt76 btintel rk805_pwrkey btbcm snd_soc_hdmi_codec ofpart snd_soc_ro=
ckchip_i2s_tdm snd_soc_es8389 mac80211 btmtk snd_soc_core rockchip_thermal =
bluetooth rockchip_vdec synopsys_hdmirx spi_nor v4l2_vp9 rockchip_rga snd_c=
ompress mtd v4l2_dv_timings v4l2_h264 ecdh_generic snd_pcm_dmaengine videob=
uf2_dma_contig v4l2_mem2mem rockchip_rng videobuf2_dma_sg snd_pcm videobuf2=
_memops cfg80211 videobuf2_v4l2 videodev snd_timer panthor snd rocket drm_g=
puvm videobuf2_common rfkill soundcore gpu_sched libarc4 vsi_iommu mc drm_s=
hmem_helper drm_exec cpufreq_dt evdev pkcs8_key_parser nvme_fabrics efi_pst=
ore configfs autofs4 ext4 crc16 mbcache jbd2 onboard_usb_dev r8169 realtek =
phy_package mdio_devres of_mdio fixed_phy fwnode_mdio libphy mdio_bus xhci_=
plat_hcd xhci_hcd nvme rk808_regulator nvme_core nvme_keyring
[    9.004872]  nvme_auth fusb302 tcpm rockchipdrm fan53555 aux_hpd_bridge =
dw_hdmi_qp rtc_hym8563 dw_mipi_dsi dw_hdmi analogix_dp drm_dp_aux_bus drm_d=
isplay_helper rockchip_saradc fixed sdhci_of_dwcmshc cec phy_rockchip_usbdp=
 sdhci_pltfm industrialio_triggered_buffer phy_rockchip_naneng_combphy dw_m=
mc_rockchip sdhci rc_core typec dw_mmc_pltfm gpio_rockchip phy_rockchip_sam=
sung_hdptx display_connector phy_rockchip_snps_pcie3 kfifo_buf nvmem_rockch=
ip_otp drm_client_lib cqhci ohci_platform spi_rockchip_sfc dw_mmc dw_wdt sp=
i_rockchip rockchip_dfi pl330 drm_dma_helper ehci_platform drm_kms_helper d=
wc3 ehci_hcd drm ohci_hcd udc_core adc_keys usbcore i2c_rk3x phy_rockchip_i=
nno_usb2 industrialio pwm_rockchip ulpi usb_common
[    9.004964] CPU: 5 UID: 0 PID: 399 Comm: (udev-worker) Tainted: G       =
 W           7.3-rc4+unreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc4-=
2
[    9.004971] Tainted: [W]=3DWARN
[    9.004974] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
[    9.004977] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    9.004982] pc : irq_domain_associate_locked+0x118/0x1a0
[    9.004986] lr : irq_domain_associate_locked+0x118/0x1a0
[    9.004989] sp : ffff800083c734d0
[    9.004992] x29: ffff800083c734d0 x28: ffffc87b5865ccb8 x27: ffffc87ae61=
951d8
[    9.004998] x26: 000000000000000c x25: ffff0001035340b0 x24: ffff000107e=
c6ae8
[    9.005003] x23: 0000000000000000 x22: 00000000000000a3 x21: 00000000000=
00000
[    9.005008] x20: ffff0001180b0030 x19: ffff000108e26200 x18: 00000000000=
0000a
[    9.005013] x17: 7075727265746e69 x16: 2d79636167656c3a x15: 07200720072=
00720
[    9.005018] x14: 0720072007200720 x13: 0720072007200720 x12: 00000000000=
6ff90
[    9.005023] x11: ffffc87b581950d0 x10: ffffc87b5810cf08 x9 : ffffc87b55d=
b6444
[    9.005028] x8 : ffffc87b5817d0e8 x7 : ffffffffffffefff x6 : 00000000000=
00001
[    9.005033] x5 : ffff0005fdeff208 x4 : ffff378aa5f0e000 x3 : ffff0001683=
85dc0
[    9.005038] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0001683=
85dc0
[    9.005044] Call trace:
[    9.005046]  irq_domain_associate_locked+0x118/0x1a0 (P)
[    9.005052]  irq_create_mapping_affinity_locked+0x98/0x1b8
[    9.005056]  irq_create_fwspec_mapping+0x320/0x3e0
[    9.005061]  irq_create_of_mapping+0x74/0xb0
[    9.005065]  of_irq_parse_and_map_pci+0xf8/0x1f8
[    9.005071]  pci_assign_irq+0x9c/0x180
[    9.005076]  pci_device_probe+0x68/0x170
[    9.005080]  really_probe+0xc8/0x3f8
[    9.005085]  __driver_probe_device+0x168/0x1c8
[    9.005088]  driver_probe_device+0x44/0x128
[    9.005092]  __driver_attach+0xd0/0x228
[    9.005095]  bus_for_each_dev+0x84/0xf0
[    9.005100]  driver_attach+0x2c/0x40
[    9.005103]  bus_add_driver+0x124/0x280
[    9.005106]  driver_register+0x70/0x138
[    9.005110]  __pci_register_driver+0x48/0x60
[    9.005116]  mt7925_pci_driver_init+0x30/0xfd0 [mt7925e]
[    9.005125]  do_one_initcall+0x5c/0x458
[    9.005129]  do_init_module+0x5c/0x280
[    9.005134]  load_module+0x1cc0/0x25b8
[    9.005137]  init_module_from_file+0xe8/0x158
[    9.005141]  __arm64_sys_finit_module+0x208/0x360
[    9.005144]  invoke_syscall.constprop.0+0xac/0x110
[    9.005151]  el0_svc_common.constprop.0+0xc0/0xf0
[    9.005156]  do_el0_svc+0x24/0x40
[    9.005161]  el0_svc+0x40/0x260
[    9.005167]  el0t_64_sync_handler+0xa0/0xe8
[    9.005171]  el0t_64_sync+0x198/0x1a0
[    9.005176] ---[ end trace 0000000000000000 ]---
[   10.568235] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
```

The ``mt7925`` one is from my M.2 Wi-Fi+BT card plugged into the system.

rk3588-nanopc-t6-plus-intx-fixes-stacktraces-dmesg.txt:
https://paste.sr.ht/~diederik/85ee576b76934754139a496488d451ef89f88db0

rk3588-rock5b-intx-fixes-stacktraces-dmesg.txt:
https://paste.sr.ht/~diederik/c6d46b2e5e0de22316bd31ad63152afed1a2dc70

rk3568-nanopi-r5s-intx-fixes-stacktraces-dmesg.txt:
https://paste.sr.ht/~diederik/9b83b304646df3823687b75e5e07c683658d1024

Cheers,
  Diederik

> Changes in v3:
> - split devm-managed part into a seperate patch
>
> Changes in v2:
> - Moved the of_irq_get_byname() lookup, the INTx irq domain creation
>   and the chained handler installation out of the host ops .init()
>   callback into rockchip_pcie_configure_rc(), right after
>   dw_pcie_host_init(), as suggested by Niklas Cassel. This supersedes
>   v1 patch 1/2, as .init() no longer creates the irq domain, and
>   removes the rockchip_pcie_host_hw_init() helper from v1.
> - Made the INTx irq domain devm-managed with
>   devm_irq_domain_instantiate() and uninstall the chained handler
>   through a devres action, addressing the probe failure leak and
>   use-after-free flagged by the Sashiko review.
> - keep the INTx IRQ masked while .reset_root_port()
>   gates the controller clocks, responding to the Sashiko review
>   finding about accessing the unclocked APB bus.
>
> Shawn Lin (3):
>   PCI: dw-rockchip: Move the INTx irq setup to probe
>   PCI: dw-rockchip: Make the INTx irq setup devm-managed
>   PCI: dw-rockchip: Mask the INTx IRQ while the controller clocks are
>     gated
>
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 77 ++++++++++++++++++++-=
------
>  1 file changed, 57 insertions(+), 20 deletions(-)


