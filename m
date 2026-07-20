Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B22277818
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784525279; cv=none; b=fAFIix/18MSHU7FumU7wEeK6gkzyugjtGhplcCewfTX/mozMhFEUFLjl9ZRqk7fpncMBuBail6gOrrbzsqEasWRaLRnbAOC9xnvI/Srbfz8FH9SyDHd0gGYV+/EKBNEK66QMxVxSHUwT/7/a4jLzg0iZ+sjyFx31eniKHookdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784525279; c=relaxed/simple;
	bh=hV3hmVCFcy/Pf7QbmtUHRE7zXPXJ3jzOywRyM+89BVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HoPl2bPuM/S5R6M1Uwf+io6R8S9WcMESaP4elhBAZsPZdMikONd4nqpdtuUoRsAxe7GsN9+8Ev0yGJR1xZ6sdKy0jgOxWgSLzhZxpbMzcniv91b+g83vttyVT3JV4ozuBkYMFA7iQbQfFkQ86WcpNrvkgOqqDb+K6bPukXdAnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=R6QsLCPb; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="R6QsLCPb"
Received: from francesco-nb (93-38-200-139.ip72.fastwebnet.it [93.38.200.139])
	by mail11.truemail.it (Postfix) with ESMTPA id AD8E41FDC6;
	Mon, 20 Jul 2026 07:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784525267;
	bh=uQbfFBez37Wkn4R0iQjQQgdVIH7amzo82kFj7d+pTUQ=; h=From:To:Subject;
	b=R6QsLCPbKty/FkgiZbbzO++1xAcX2/sRHzB3WneIN7KRZViZLloSWuRKRSgEctvQa
	 1JtymYJUpPTbGxCpjX2kfdUEaikDhJP8yNNNire3Px1GfEkPoUUS0aVCQkrJML2VIb
	 14pG4k6Oz8BtUf/H5W7InzinHBE2KSHwAHWIXVmj4GbTizh1sLTCudbzs8ynZQjzai
	 IaIlsw1xcCEzMYVx5FU9vm0E5LKm6ZwtlsZly9ARSQ39OeZkbXR/fdkY/rY/PntYm+
	 QExYm4YP71yTPTK9Oph5k4NXhAnsGRj2lEco1LlcrHUDy8XbPDsjYvBJRHGbrQxhtr
	 FZOhYXECoLcvQ==
Date: Mon, 20 Jul 2026 07:27:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Richard Zhu <hongxing.zhu@nxp.com>, frank.li@nxp.com,
	linux-pci@vger.kernel.org, imx@lists.linux.dev
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org
Subject: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
Message-ID: <20260720052742.GA6753@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
our CI spotted this error on resume. It is not systematic, and it is
possible that this is not a new issue from 7.2.

Does it rings any bell?

[  745.849237] imx8qm-hsio-phy 5f180000.phy: HSIO_PM_REQ_CORE_RST is set
[  745.855800] phy phy-5f180000.phy.1: phy poweron failed --> -110
[  745.861824] imx6q-pcie 5f000000.pcie: waiting for PHY ready timeout!
[  745.868378] imx6q-pcie 5f000000.pcie: Host init failed: -110
[  745.874144] imx6q-pcie 5f000000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
[  745.882791] imx6q-pcie 5f000000.pcie: PM: failed to resume noirq: error -110
[  745.889979] Internal error: synchronous external abort: 0000000096000210 [#1]  SMP
[  745.897647] Modules linked in: can_raw can 8021q garp stp mrp llc bluetooth ecdh_generic ecc uas nls_iso8859_1 nls_cp437 mwifiex_pcie mwifiex cfg80211 ahci rfkill sd_mod cdns caam_jr caamhash_desc spidev caamalg_desc rng crypto_engine kpp rng_core libdes snd_soc_fsl_asoc_card aes_ce_blk ghash_ce snd_soc_simple_card snd_soc_imx_audmux leds_gpio gf128mul imx_sc_thermal rtc_imx_sc nvmem_imx_ocotp_scu snd_soc_simple_card_utils led_class gpio_fan ahci_imx libahci_platform libahci phy_fsl_imx8qm_hsio libata fsl_imx8_ddr_perf ci_hdrc_imx ci_hdrc ulpi phy_cadence_salvo ehci_hcd roles usbmisc_imx phy_mxs_usb cdns3_imx usb3503 snd_soc_sgtl5000 flexcan can_dev imx8qxp_adc snd_soc_fsl_spdif snd_soc_fsl_sai imx_pcm_dma snd_soc_fsl_utils snd_soc_fsl_asrc pwm_imx27 spi_fsl_lpspi caam etnaviv error gpu_sched amphion_vpu fuse autofs4
[  745.970466] CPU: 2 UID: 0 PID: 53 Comm: kworker/u21:2 Tainted: G   M                7.2.0-rc4-0.0.0-devel #1 PREEMPT
[  745.981181] Tainted: [M]=MACHINE_CHECK
[  745.985018] Hardware name: Toradex Apalis iMX8QP V1.1 on Apalis Ixora V1.2 Carrier Board (DT)
[  745.993643] Workqueue: async async_run_entry_fn
[  745.998279] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  746.005337] pc : pci_generic_config_read+0x64/0xc0
[  746.010231] lr : pci_generic_config_read+0x24/0xc0
[  746.015118] sp : ffff800080513ba0
[  746.018520] x29: ffff800080513ba0 x28: 0000000000000000 x27: 0000000000000000
[  746.025761] x26: ffff00000043d400 x25: 0000000000000000 x24: ffff0000004d1e05
[  746.033000] x23: 0000000000000003 x22: ffffa79a09fe3118 x21: ffff000003a000d0
[  746.040242] x20: 0000000000000002 x19: ffff800080513be4 x18: 0000000000000001
[  746.047482] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000002
[  746.054720] x14: ffff000000718f90 x13: ffffa79a09f6f068 x12: 0000000000000003
[  746.061959] x11: 0000000000000028 x10: 000000016a2a9b62 x9 : 000000000000003c
[  746.069197] x8 : ffffa79a09861b20 x7 : ffff0000067fe800 x6 : ffffa79a0a6bf000
[  746.076438] x5 : 0000000000000000 x4 : ffff800080513be4 x3 : ffffa79a0989d904
[  746.083676] x2 : 0000000000000044 x1 : 0000000000000000 x0 : ffff8000827c0044
[  746.090917] Call trace:
[  746.093455]  pci_generic_config_read+0x64/0xc0 (P)
[  746.098345]  pci_bus_read_config_word+0x74/0xe0
[  746.102971]  pci_read_config_word+0x2c/0x48
[  746.107252]  pci_power_up+0x50/0x1e4
[  746.110927]  pci_pm_power_up_and_verify_state+0x2c/0xa0
[  746.116249]  pci_pm_resume_noirq+0xe8/0x1ac
[  746.120528]  dpm_run_callback+0x4c/0x108
[  746.124550]  device_resume_noirq+0x110/0x3c4
[  746.128917]  async_resume_noirq+0x20/0x40
[  746.133024]  async_run_entry_fn+0x34/0x164
[  746.137215]  process_one_work+0x15c/0x2a0
[  746.141317]  worker_thread+0x18c/0x2e0
[  746.145159]  kthread+0x11c/0x13c
[  746.148486]  ret_from_fork+0x10/0x20
[  746.152167] Code: 52800000 a8c27bfd d50323bf d65f03c0 (79400000)
[  746.158371] ------------[ cut here ]------------
[  746.163077] WARNING: /usr/src/kernel/kernel/printk/printk.c:4627 at __wake_up_klogd+0xf4/0x100, CPU#2: kworker/u21:2/53
[  746.173972] Modules linked in: can_raw can 8021q garp stp mrp llc bluetooth ecdh_generic ecc uas nls_iso8859_1 nls_cp437 mwifiex_pcie mwifiex cfg80211 ahci rfkill sd_mod cdns caam_jr caamhash_desc spidev caamalg_desc rng crypto_engine kpp rng_core libdes snd_soc_fsl_asoc_card aes_ce_blk ghash_ce snd_soc_simple_card snd_soc_imx_audmux leds_gpio gf128mul imx_sc_thermal rtc_imx_sc nvmem_imx_ocotp_scu snd_soc_simple_card_utils led_class gpio_fan ahci_imx libahci_platform libahci phy_fsl_imx8qm_hsio libata fsl_imx8_ddr_perf ci_hdrc_imx ci_hdrc ulpi phy_cadence_salvo ehci_hcd roles usbmisc_imx phy_mxs_usb cdns3_imx usb3503 snd_soc_sgtl5000 flexcan can_dev imx8qxp_adc snd_soc_fsl_spdif snd_soc_fsl_sai imx_pcm_dma snd_soc_fsl_utils snd_soc_fsl_asrc pwm_imx27 spi_fsl_lpspi caam etnaviv error gpu_sched amphion_vpu fuse autofs4
[  746.246751] CPU: 2 UID: 0 PID: 53 Comm: kworker/u21:2 Tainted: G   M                7.2.0-rc4-0.0.0-devel #1 PREEMPT
[  746.257464] Tainted: [M]=MACHINE_CHECK
[  746.261300] Hardware name: Toradex Apalis iMX8QP V1.1 on Apalis Ixora V1.2 Carrier Board (DT)
[  746.269921] Workqueue: async async_run_entry_fn
[  746.274548] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  746.281605] pc : __wake_up_klogd+0xf4/0x100
[  746.285881] lr : wake_up_klogd+0x14/0x20
[  746.289899] sp : ffff800080513920
[  746.293304] x29: ffff800080513920 x28: ffff000000718f00 x27: 0000000000000000
[  746.300545] x26: ffff00000043d400 x25: 0000000000000000 x24: 00000000000000c0
[  746.307786] x23: ffffa79a09861b84 x22: 0000000000000000 x21: ffff800080513a60
[  746.315026] x20: ffffa79a0a202cc0 x19: ffffa79a0a678370 x18: 000000000000000a
[  746.322266] x17: 3430306337323830 x16: 3030386666666620 x15: 0730076307330730
[  746.329506] x14: 0766073507360764 x13: 0730076307330730 x12: 0766073507360764
[  746.336746] x11: ffffa79a0a55c7c0 x10: 00000000000002af x9 : ffffa79a0a55c7c0
[  746.343986] x8 : 3fffffffffffefff x7 : ffffa79a0a5b47c0 x6 : 0000000000000000
[  746.351226] x5 : 00000000000002b0 x4 : 0000000000000000 x3 : 0000000000000000
[  746.358467] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
[  746.365708] Call trace:
[  746.368241]  __wake_up_klogd+0xf4/0x100 (P)
[  746.372520]  bust_spinlocks+0x4c/0x60
[  746.376279]  die+0xc0/0x144
[  746.379166]  arm64_notify_die+0xa0/0xa4
[  746.383099]  do_sea+0x68/0x80
[  746.386163]  do_mem_abort+0x40/0x9c
[  746.389745]  el1_abort+0x44/0x64
[  746.393068]  el1h_64_sync_handler+0x50/0xac
[  746.397348]  el1h_64_sync+0x6c/0x70
[  746.400934]  pci_generic_config_read+0x64/0xc0 (P)
[  746.405821]  pci_bus_read_config_word+0x74/0xe0
[  746.410448]  pci_read_config_word+0x2c/0x48
[  746.414727]  pci_power_up+0x50/0x1e4
[  746.418398]  pci_pm_power_up_and_verify_state+0x2c/0xa0
[  746.423721]  pci_pm_resume_noirq+0xe8/0x1ac
[  746.427998]  dpm_run_callback+0x4c/0x108
[  746.432013]  device_resume_noirq+0x110/0x3c4
[  746.436380]  async_resume_noirq+0x20/0x40
[  746.440482]  async_run_entry_fn+0x34/0x164
[  746.444674]  process_one_work+0x15c/0x2a0
[  746.448778]  worker_thread+0x18c/0x2e0
[  746.452620]  kthread+0x11c/0x13c
[  746.455943]  ret_from_fork+0x10/0x20
[  746.459614] ---[ end trace 0000000000000000 ]---
[  746.464322] ---[ end trace 0000000000000000 ]---
[  746.469033] note: kworker/u21:2[53] exited with irqs disabled
[  746.474916] note: kworker/u21:2[53] exited with preempt_count 1


