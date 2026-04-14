Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871727380A;
	Tue, 14 Apr 2026 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176937; cv=none; b=tbGKkVBA27jXZmxQRPoPvk1ymg35UEEFLGl7zqdZuUsxyZi4914BFd8n8x6YRQ99I0Zyr/YEzUh4u6iaZ9c6+ymNxUB/eD0lXXqojpO3Dhuad287jD6LgwVz0WXPmj7dUQT90qXk0sUw2KZGlEVDNpcW8D24cV9urtyUe7Ch96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176937; c=relaxed/simple;
	bh=YmiDDaSmDuLJbvyqEyt8W0aGuX44Apje0l6ER/n649o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U4Jc+A6tZkGrPy0d+Cog1b0f+OKug5ka78x/05wjUDZ2c+l/dv5dslLf1EniaPCECzkuV/3MB3D/dXfcM+k7oTk6PIUMs4APnMx3oVkPVfxz3tnsZRPamL7kGs4Ri7RJiBR09Jj/FD+f8EVzNv14TVNyZ1mk60yTcFPl4TgruH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEXYNV+n; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEXYNV+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776176935; x=1807712935;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=YmiDDaSmDuLJbvyqEyt8W0aGuX44Apje0l6ER/n649o=;
  b=GEXYNV+nosaCUpucrfdInsx50Ej2E8r3DV6mH2J2iWvlCSsQwzDWUjxZ
   ovOjc7mQtBBz1ugZMA4UesCHjQKqclajnxzmEai44lJcFopVLXQL3gP07
   KKiLHfXONQ9dAKc6tcbSonA14pnBdusryB1WkXelOeUH5sRe/XJlUDAqo
   WlKOaIWFxebN7YDFr5sSFwi+F4TETGu3B1BabBuvU5+Uxzhip4gsc4N/G
   98NaZuFwx/Gj510Cf2XVx6OPwgijn188bsalAXXjF6/gsG4e46NGbvyQV
   H1NucRKq/OEca5kVKc5DrVSPS3ZxacycTZmMhdlDz88wLLBIxpPVN+G9M
   Q==;
X-CSE-ConnectionGUID: pzV6PsGlSlyb6tNdI30bWg==
X-CSE-MsgGUID: pgCnAlJSR5Kzz7wGiiI31A==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94535287"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94535287"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 07:28:44 -0700
X-CSE-ConnectionGUID: cqQKMDx7TCOgMUKFSRF/SQ==
X-CSE-MsgGUID: NTxt173SQlKOH4E/boA/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225806188"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 07:28:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Apr 2026 17:28:37 +0300 (EEST)
To: Rio Liu <rio@r26.me>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
    Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [REGRESSION] amdgpu fails to load eGPU after 6.19
In-Reply-To: <a1FodrO_nl6UemO3VLBk5Gsu6PjvxLU-OYhvJEMeKFem-Bpi7ZXDHrIxtwsTCmpn-WndBxnzZNtdKJy_V6PjafnFjSKz7sr1eEfGobRzpgs=@r26.me>
Message-ID: <4dfc25f2-f660-c234-4e4d-c5c76216523d@linux.intel.com>
References: <a1FodrO_nl6UemO3VLBk5Gsu6PjvxLU-OYhvJEMeKFem-Bpi7ZXDHrIxtwsTCmpn-WndBxnzZNtdKJy_V6PjafnFjSKz7sr1eEfGobRzpgs=@r26.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-47205112-1776176376=:962"
Content-ID: <b2babe66-5a55-cf67-a2cc-8d94c2ed57f7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-47205112-1776176376=:962
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <3ca4bc03-06d2-5543-8cb4-3cdd947a6d47@linux.intel.com>

On Tue, 14 Apr 2026, Rio Liu wrote:

> There seems to be another PCI alignment issue with external amdgpu since =
6.19.
> Bisecting this time pointed me to this commit
>=20
> commit bc75c8e5071120e919beb39e69f0979cccfdf219 (HEAD)
> Author: Ilpo J<C3><A4>rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Fri Dec 19 19:40:15 2025 +0200
>=20
>     PCI: Rewrite bridge window head alignment function
>=20
> It looks like the same issue that has happened before in
> https://lore.kernel.org/all/o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NO=
zOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=3D@r26.me/.
> It seems like the previous fix with min_align
> https://lore.kernel.org/all/20250822123359.16305-2-ilpo.jarvinen@linux.in=
tel.com/
> got removed in this commit.

Hi,

Changing it seems 100% intentional. Even if symptoms you see look similar,=
=20
the root cause is likely different.

> Applying the following patch to the commit fixes the regression. I'm stil=
l
> looking at how to rebasing it onto latest commit as there is quite a bit =
of
> code change around it. But the same regression still happens as of v7.0-r=
c7.

Yes, definitely, things have changed a lot. It's not possible to use the=20
"same" fix with the new algorithm which works in a different way so trying=
=20
to forward port the old fix will not be useful.

Please note that there are also some fixes to the new algorithm which are=
=20
only queued for v7.1 as is (I expect they'll be backported from there=20
though). They're currently in the pci/resource branch awaiting PCI=20
maintainer (Bjorn Helgaas) to make PR to Linus.

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 80e5a8fc62e7..12ab84271214 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1445,7 +1445,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsi=
gned long type,
>=20
>         if (bus->self && size0 &&
>             !pbus_upstream_space_available(bus, b_res, size0, min_align))=
 {

In the very latest code, this is entirely gone (this is likely just=20
because you used bisect, so it took only part of the commits).

> -               min_align =3D calculate_head_align(aligns2, max_order);
> +               min_align =3D min(min_align, calculate_head_align(aligns2=
, max_order));
>                 size0 =3D calculate_memsize(size, min_size, 0, 0, old_siz=
e, win_align);
>                 resource_set_range(b_res, min_align, size0);
>                 pci_info(bus->self, "bridge window %pR to %pR requires re=
laxed alignment rules\n",
> @@ -1459,7 +1459,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsi=
gned long type,
>=20
>                 if (bus->self && size1 &&
>                     !pbus_upstream_space_available(bus, b_res, size1, add=
_align)) {
> -                       min_align =3D calculate_head_align(aligns2, max_o=
rder);
> +                       min_align =3D min(min_align, calculate_head_align=
(aligns2, max_order));
>                         size1 =3D calculate_memsize(size, min_size, add_s=
ize, children_add_size,
>                                                   old_size, win_align);
>                         pci_info(bus->self,
> ---
>=20
> Relevant errors in dmesg:

This snippet only contains collateral damage and does not show where the=20
problem originates from. Please provide a full dmesg instead with
dyndbg=3D"file drivers/pci/*.c +p" on the kernel command line.

Preferrably test with the latest code + fixes that are in pci/resources=20
branch (you can just take all changes from there) and get the logs from=20
there. I wouldn't be surprised if your problem is already addressed by=20
those fixes but we'll see.

> [   10.166037] amdgpu: Virtual CRAT table created for CPU
> [   10.166050] amdgpu: Topology: Add CPU node
> [   10.166166] amdgpu 0000:08:00.0: enabling device (0000 -> 0002)
> [   10.166293] amdgpu 0000:08:00.0: initializing kernel modesetting (SIEN=
NA_CICHLID 0x1002:0x73BF 0x148C:0x2406 0xC1).
> [   10.166345] amdgpu 0000:08:00.0: register mmio base: 0x8C000000
> [   10.166347] amdgpu 0000:08:00.0: register mmio size: 1048576
> [   10.173624] wlan0: Limiting TX power to 30 (30 - 0) dBm as advertised =
by 72:13:01:87:79:82
> [   10.174898] amdgpu 0000:08:00.0: detected ip block number 0 <common_v1=
_0_0> (nv_common)
> [   10.174901] amdgpu 0000:08:00.0: detected ip block number 1 <gmc_v10_0=
_0> (gmc_v10_0)
> [   10.174903] amdgpu 0000:08:00.0: detected ip block number 2 <ih_v5_0_0=
> (navi10_ih)
> [   10.174904] amdgpu 0000:08:00.0: detected ip block number 3 <psp_v11_0=
_0> (psp)
> [   10.174906] amdgpu 0000:08:00.0: detected ip block number 4 <smu_v11_0=
_0> (smu)
> [   10.174907] amdgpu 0000:08:00.0: detected ip block number 5 <dce_v1_0_=
0> (dm)
> [   10.174908] amdgpu 0000:08:00.0: detected ip block number 6 <gfx_v10_0=
_0> (gfx_v10_0)
> [   10.174909] amdgpu 0000:08:00.0: detected ip block number 7 <sdma_v5_2=
_0> (sdma_v5_2)
> [   10.174911] amdgpu 0000:08:00.0: detected ip block number 8 <vcn_v3_0_=
0> (vcn_v3_0)
> [   10.174912] amdgpu 0000:08:00.0: detected ip block number 9 <jpeg_v3_0=
_0> (jpeg_v3_0)
> [   10.278772] amdgpu 0000:08:00.0: Fetched VBIOS from ROM BAR
> [   10.278776] amdgpu 0000:08:00.0: [drm] ATOM BIOS: 113-001-X01
> [   10.308408] amdgpu 0000:08:00.0: Trusted Memory Zone (TMZ) feature dis=
abled as experimental (default)
> [   10.308424] amdgpu 0000:08:00.0: PCIE atomic ops is not supported
> [   10.308433] amdgpu 0000:08:00.0: GPU posting now...
> [   10.308461] amdgpu 0000:08:00.0: MEM ECC is not presented.
> [   10.308462] amdgpu 0000:08:00.0: SRAM ECC is not presented.
> [   10.308484] amdgpu 0000:08:00.0: vm size is 262144 GB, 4 levels, block=
 size is 9-bit, fragment size is 9-bit
> [   10.308522] amdgpu 0000:08:00.0: Problem resizing BAR0 (-22).
> [   10.308529] amdgpu 0000:08:00.0: VRAM: 16368M 0x0000008000000000 - 0x0=
0000083FEFFFFFF (16368M used)
> [   10.308531] amdgpu 0000:08:00.0: GART: 512M 0x0000000000000000 - 0x000=
000001FFFFFFF
> [   10.308545] resource: resource sanity check: requesting [mem 0x0000000=
000000000-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem 0=
x000a0000-0x000bffff window]
> [   10.308550] ------------[ cut here ]------------
> [   10.308551] WARNING: arch/x86/mm/pat/memtype.c:721 at memtype_reserve_=
io+0xfc/0x110, CPU#7: (udev-worker)/606
> [   10.308557] Modules linked in: ccm amdgpu(+) amdxcp drm_panel_backligh=
t_quirks gpu_sched drm_exec snd_hda_codec_atihdmi drm_suballoc_helper drm_t=
tm_helper ntfs3 vfat fat v4l2loopback(OE) snd_seq_midi snd_seq_midi_event s=
nd_seq snd_rawmidi snd_seq_device dm_multipath dm_mod kvmgt mdev vfio_iommu=
_type1 vfio iommufd crypto_user uinput cmac algif_hash algif_skcipher af_al=
g uvcvideo videobuf2_vmalloc uvc videobuf2_memops videobuf2_v4l2 btusb vide=
obuf2_common btmtk btrtl videodev btbcm mc btintel snd_hda_codec_intelhdmi =
snd_hda_codec_hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib snd_hda_s=
codec_component snd_hda_codec_generic snd_hda_intel snd_sof_pci_intel_cnl j=
oydev snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt s=
nd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_in=
tel_hda intel_rapl_msr soundwire_cadence intel_rapl_common snd_sof_pci snd_=
sof_xtensa_dsp intel_uncore_frequency intel_uncore_frequency_common snd_sof=
 snd_sof_utils snd_soc_acpi_intel_match
> [   10.308591]  snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocati=
on snd_soc_sdw_utils snd_soc_acpi intel_tcc_cooling soundwire_bus x86_pkg_t=
emp_thermal intel_powerclamp snd_soc_sdca coretemp crc8 snd_soc_avs kvm_int=
el snd_soc_hda_codec mousedev snd_hda_ext_core kvm r8169 snd_hda_codec nvme=
 8021q irqbypass realtek snd_hda_core ghash_clmulni_intel rtsx_pci_sdmmc ae=
sni_intel nvme_core snd_intel_dspcfg garp mdio_devres snd_intel_sdw_acpi sp=
i_nor iwlmvm mrp iTCO_wdt rapl nvme_keyring stp mmc_core libphy intel_cstat=
e nvme_auth snd_hwdep hid_multitouch mei_hdcp mei_pxp ee1004 intel_pmc_bxt =
mtd intel_wmi_thunderbolt llc clevo_xsm_wmi(OE) i915 intel_uncore snd_soc_c=
ore thunderbolt mdio_bus i2c_hid_acpi hkdf mac80211 rtsx_pci i2c_hid snd_co=
mpress drm_buddy ptp ac97_bus ttm pps_core snd_pcm_dmaengine i2c_algo_bit i=
ntel_oc_wdt libarc4 intel_pmc_core drm_display_helper snd_pcm pmt_telemetry=
 cec pmt_discovery iwlwifi snd_timer i2c_i801 intel_lpss_pci intel_gtt pmt_=
class mei_me spi_intel_pci i2c_smbus snd intel_lpss
> [   10.308633]  intel_pmc_ssram_telemetry intel_hid psmouse spi_intel vid=
eo idma64 soundcore mei intel_pch_thermal i2c_mux intel_vsec pcspkr mac_hid=
 serio_raw sparse_keymap wmi acpi_pad bnep cfg80211 bluetooth rfkill
> [   10.308645] CPU: 7 UID: 0 PID: 606 Comm: (udev-worker) Tainted: G S   =
      OE       7.0.0-rc7 #21 PREEMPT(full)  78435afb69b0b07f3561902db6ca639=
5f9133c11
> [   10.308648] Tainted: [S]=3DCPU_OUT_OF_SPEC, [O]=3DOOT_MODULE, [E]=3DUN=
SIGNED_MODULE
> [   10.308649] Hardware name: COPELION INTERNATIONAL INC. ZX Series/ZX Se=
ries, BIOS 1.07.14RCOP1 12/29/2020
> [   10.308650] RIP: 0010:memtype_reserve_io+0xfc/0x110
> [   10.308652] Code: aa fb ff ff b8 f0 ff ff ff eb 88 8b 54 24 04 4c 89 e=
e 48 89 df e8 04 fe ff ff 85 c0 75 db 8b 54 24 04 41 89 16 e9 69 ff ff ff <=
0f> 0b e9 4b ff ff ff e8 48 d2 09 01 0f 1f 84 00 00 00 00 00 90 90
> [   10.308654] RSP: 0018:ffffcf4781c736d0 EFLAGS: 00010286
> [   10.308655] RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 000000000=
0000027
> [   10.308657] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff9=
b5f5e70
> [   10.308657] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000f=
fffefff
> [   10.308658] R10: ffffffff9a85fac0 R11: ffffcf4781c73548 R12: 000000000=
0000001
> [   10.308659] R13: 0000000000000000 R14: ffffcf4781c7371c R15: 000000000=
0000001
> [   10.308660] FS:  00007fdda0fa5c80(0000) GS:ffff8b4d39075000(0000) knlG=
S:0000000000000000
> [   10.308662] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.308662] CR2: 00007ffd23cf0ff0 CR3: 0000000109bfa005 CR4: 000000000=
03726f0
> [   10.308664] Call Trace:
> [   10.308665]  <TASK>
> [   10.308666]  arch_io_reserve_memtype_wc+0x31/0x50
> [   10.308670]  amdgpu_bo_init+0x3e/0x90 [amdgpu 9e1de60160a9bdc6283126cc=
89fe53e3272a6751]
> [   10.309129]  ? amdgpu_gmc_get_vbios_allocations+0xa9/0x140 [amdgpu 9e1=
de60160a9bdc6283126cc89fe53e3272a6751]
> [   10.309416]  gmc_v10_0_sw_init+0x352/0x5d0 [amdgpu 9e1de60160a9bdc6283=
126cc89fe53e3272a6751]
> [   10.309721]  amdgpu_device_init.cold+0x1612/0x22f8 [amdgpu 9e1de60160a=
9bdc6283126cc89fe53e3272a6751]
> [   10.310080]  ? pci_conf1_read+0xb2/0x100
> [   10.310084]  ? pci_bus_read_config_word+0x4c/0x80
> [   10.310087]  amdgpu_driver_load_kms+0x19/0x80 [amdgpu 9e1de60160a9bdc6=
283126cc89fe53e3272a6751]
> [   10.310352]  amdgpu_pci_probe+0x233/0x480 [amdgpu 9e1de60160a9bdc62831=
26cc89fe53e3272a6751]
> [   10.310610]  local_pci_probe+0x3e/0x90
> [   10.310614]  pci_device_probe+0xe1/0x260
> [   10.310616]  ? sysfs_do_create_link_sd+0x6d/0xd0
> [   10.310619]  really_probe+0xde/0x380
> [   10.310622]  __driver_probe_device+0x78/0x150
> [   10.310624]  driver_probe_device+0x1f/0xa0
> [   10.310625]  ? __pfx___driver_attach+0x10/0x10
> [   10.310627]  __driver_attach+0xcb/0x210
> [   10.310628]  bus_for_each_dev+0x85/0xd0
> [   10.310632]  bus_add_driver+0x118/0x200
> [   10.310634]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu 9e1de60160a9bdc6283=
126cc89fe53e3272a6751]
> [   10.310890]  driver_register+0x75/0xe0
> [   10.310893]  ? amdgpu_init+0x36/0xff0 [amdgpu 9e1de60160a9bdc6283126cc=
89fe53e3272a6751]
> [   10.311150]  do_one_initcall+0x5d/0x330
> [   10.311155]  do_init_module+0x62/0x250
> [   10.311158]  ? init_module_from_file+0xd8/0x140
> [   10.311160]  init_module_from_file+0xd8/0x140
> [   10.311163]  idempotent_init_module+0x114/0x310
> [   10.311166]  __x64_sys_finit_module+0x71/0xe0
> [   10.311167]  do_syscall_64+0x11c/0x15f0
> [   10.311170]  ? alloc_fd+0x12e/0x190
> [   10.311172]  ? do_sys_openat2+0x9a/0xe0
> [   10.311175]  ? __x64_sys_openat+0x61/0xa0
> [   10.311177]  ? do_syscall_64+0x11c/0x15f0
> [   10.311179]  ? alloc_fd+0x12e/0x190
> [   10.311180]  ? do_sys_openat2+0x9a/0xe0
> [   10.311182]  ? __x64_sys_openat+0x61/0xa0
> [   10.311184]  ? do_syscall_64+0x11c/0x15f0
> [   10.311186]  ? do_syscall_64+0x2d6/0x15f0
> [   10.311187]  ? do_syscall_64+0x11c/0x15f0
> [   10.311189]  ? clear_bhb_loop+0x30/0x80
> [   10.311191]  ? clear_bhb_loop+0x30/0x80
> [   10.311192]  ? clear_bhb_loop+0x30/0x80
> [   10.311193]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   10.311195] RIP: 0033:0x7fdda10b967d
> [   10.311197] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 63 16 0d 00 f7 d8 64 89 01 48
> [   10.311198] RSP: 002b:00007ffea5c85328 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [   10.311200] RAX: ffffffffffffffda RBX: 000055c8dfdae250 RCX: 00007fdda=
10b967d
> [   10.311201] RDX: 0000000000000004 RSI: 00007fdda0f5b2f2 RDI: 000000000=
0000018
> [   10.311202] RBP: 00007ffea5c853c0 R08: 0000000000000000 R09: 000000000=
0000000
> [   10.311203] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0020000
> [   10.311204] R13: 000055c8dfdb3130 R14: 000055c8dfdae250 R15: 000000000=
0000000
> [   10.311205]  </TASK>
> [   10.311206] ---[ end trace 0000000000000000 ]---
> [   10.311208] [drm:amdgpu_bo_init [amdgpu]] *ERROR* Unable to set WC mem=
type for the aperture base
> [   10.311476] amdgpu 0000:08:00.0: sw_init of IP block <gmc_v10_0> faile=
d -22
> [   10.311477] amdgpu 0000:08:00.0: amdgpu_device_ip_init failed
> [   10.311478] amdgpu 0000:08:00.0: Fatal error during GPU init
> [   10.311480] amdgpu 0000:08:00.0: finishing device.
> [   10.311825] amdgpu 0000:08:00.0: probe with driver amdgpu failed with =
error -22
>=20
> Best,
> Rio
>=20

--=20
 i.
--8323328-47205112-1776176376=:962--
