Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F7C43381
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 02:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD360206B6
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 02:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDBCTm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:19:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60380 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726269AbfDBCTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 22:19:42 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x322JX7L028922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Apr 2019 22:19:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4F683421A03; Mon,  1 Apr 2019 22:19:33 -0400 (EDT)
Date:   Mon, 1 Apr 2019 22:19:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Lockdep warning in pciehp (v5.0-based kernel)
Message-ID: <20190402021933.GA2966@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, I got the following lockdep warning while booting a Dell XPS13.
Is this a known issue?

[   13.836367] pciehp 0000:3b:04.0:pcie204: Slot #4 AttnBtn- PwrCtrl- MRL- =
AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+

[   13.837149] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   13.837149] WARNING: possible recursive locking detected
[   13.837150] 5.0.0-00034-gcaae0ec7396f #54 Not tainted
[   13.837151] --------------------------------------------
[   13.837152] irq/125-pciehp/165 is trying to acquire lock:
[   13.837153] 000000000f8f89cc (&ctrl->reset_lock){.+.+}, at: pciehp_check=
_presence+0x1b/0x72
[   13.837159]=20
               but task is already holding lock:
[   13.837160] 000000001b052053 (&ctrl->reset_lock){.+.+}, at: pciehp_ist+0=
x10a/0x164
[   13.837162]=20
               other info that might help us debug this:
[   13.837162]  Possible unsafe locking scenario:

[   13.837163]        CPU0
[   13.837163]        ----
[   13.837164]   lock(&ctrl->reset_lock);
[   13.837164]   lock(&ctrl->reset_lock);
[   13.837165]=20
                *** DEADLOCK ***

[   13.837165]  May be due to missing lock nesting notation

[   13.837166] 4 locks held by irq/125-pciehp/165:
[   13.837167]  #0: 000000001b052053 (&ctrl->reset_lock){.+.+}, at: pciehp_=
ist+0x10a/0x164
[   13.837169]  #1: 0000000087e07843 (pci_rescan_remove_lock){+.+.}, at: pc=
iehp_configure_device+0x1e/0xfd
[   13.837171]  #2: 00000000e9b570d4 (&dev->mutex){....}, at: __device_atta=
ch+0x28/0x12d
[   13.837174]  #3: 000000004add66ea (&dev->mutex){....}, at: __device_atta=
ch+0x28/0x12d
[   13.837176]=20
               stack backtrace:
[   13.837178] CPU: 7 PID: 165 Comm: irq/125-pciehp Not tainted 5.0.0-00034=
-gcaae0ec7396f #54
[   13.837178] Hardware name: Dell Inc. XPS 13 9380/0KTW76, BIOS 1.2.1 02/1=
4/2019
[   13.837179] Call Trace:
[   13.837183]  dump_stack+0x67/0x8e
[   13.837186]  __lock_acquire+0x9b2/0xddc
[   13.837189]  ? pci_hp_add+0x18a/0x1ee
[   13.837190]  ? pci_hp_add+0x18a/0x1ee
[   13.837192]  ? find_held_lock+0x2b/0x6e
[   13.837194]  lock_acquire+0x147/0x172
[   13.837196]  ? pciehp_check_presence+0x1b/0x72
[   13.837199]  down_read+0x44/0x87
[   13.837201]  ? pciehp_check_presence+0x1b/0x72
[   13.837203]  pciehp_check_presence+0x1b/0x72
[   13.837205]  pciehp_probe+0x229/0x24d
[   13.837207]  pcie_port_probe_service+0x38/0x4b
[   13.837209]  really_probe+0x1a5/0x372
[   13.837210]  ? driver_allows_async_probing+0x2c/0x2c
[   13.837211]  driver_probe_device+0xcf/0xff
[   13.837213]  ? driver_allows_async_probing+0x2c/0x2c
[   13.837215]  bus_for_each_drv+0x84/0xa8
[   13.837217]  __device_attach+0x9d/0x12d
[   13.837219]  bus_probe_device+0x31/0x9e
[   13.837221]  device_add+0x1c1/0x5bd
[   13.837223]  ? __init_waitqueue_head+0x36/0x47
[   13.837225]  pcie_port_device_register+0x3b9/0x41e
[   13.837228]  ? irq_thread_check_affinity+0x7b/0x7b
[   13.837230]  pcie_portdrv_probe+0x37/0xa4
[   13.837232]  pci_device_probe+0xbe/0x130
[   13.837234]  really_probe+0x1a5/0x372
[   13.837236]  ? driver_allows_async_probing+0x2c/0x2c
[   13.837237]  ? irq_thread+0x82/0x193
[   13.837238]  driver_probe_device+0xcf/0xff
[   13.837239]  ? driver_allows_async_probing+0x2c/0x2c
[   13.837241]  bus_for_each_drv+0x84/0xa8
[   13.837242]  __device_attach+0x9d/0x12d
[   13.837245]  pci_bus_add_device+0x4a/0x83
[   13.837247]  pci_bus_add_devices+0x2c/0x5d
[   13.837248]  pci_bus_add_devices+0x53/0x5d
[   13.837250]  pciehp_configure_device+0xef/0xfd
[   13.837253]  pciehp_handle_presence_or_link_change+0x28d/0x37b
[   13.837254]  pciehhp_ist+0x12c/0x164
[   13.837256]  ? irq_finalize_oneshot+0x9e/0x9e
[   13.837257]  irq_thread_fn+0x1e/0x41
[   13.837259]  irq_thread+0x138/0x193
[   13.837261]  ? wake_threads_waitq+0x27/0x27
[   13.837263]  ? irq_thread_check_affinity+0x7b/0x7b
[   13.837265]  kthread+0xf7/0xfc
[   13.837266]  ? kthread_cancel_delayed_work_sync+0xf/0xf
[   13.837269]  ret_from_fork+0x3a/0x50
[   13.837321] ------------[ cut here ]------------

It's followed by another warning which might be an unrelated issue;
least, the stack trace looks unrelated.

I've attached a compressed copy of the full dmesg.out in case it's
helpful.

Thanks!!

						- Ted

[   13.837321] downgrading a read lock
[   13.837327] WARNING: CPU: 2 PID: 741 at kernel/locking/lockdep.c:3553 lo=
ck_downgrade+0xe7/0x17f
[   13.837328] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat snd_hda_=
codec_realtek snd_hda_codec_generic dell_laptop ledtrig_audio dell_wmi dell=
_smbios ath10k_pci joydev hid_multitouch(+) dcdbas intel_wmi_thunderbolt de=
ll_wmi_descriptor intel_rapl x86_pkg_temp_thermal ath10k_core intel_powercl=
amp coretemp ath serio_raw kvm_intel snd_soc_skl btusb mac80211 snd_soc_cor=
e btrtl snd_soc_acpi_intel_match kvm btbcm snd_soc_acpi snd_soc_skl_ipc bti=
ntel snd_soc_sst_ipc irqbypass snd_soc_sst_dsp bluetooth snd_hda_ext_core u=
vcvideo cfg80211 videobuf2_vmalloc ecdh_generic videobuf2_memops snd_hda_in=
tel i915 videobuf2_v4l2 videobuf2_common pcspkr snd_hda_codec snd_hwdep drm=
_kms_helper snd_hda_core idma64 drm mei_me processor_thermal_device intel_g=
tt intel_soc_dts_iosf fb_sys_fops mei syscopyarea sysfillrect intel_pch_the=
rmal sysimgblt ucsi_acpi typec_ucsi int3403_thermal intel_hid int3400_therm=
al int340x_thermal_zone acpi_thermal_rel sparse_keymap acpi_pad pcc_cpufreq=
 nfsd auth_rpcgss nfs_acl lockd
[   13.837356]  grace parport_pc ppdev lp sunrpc parport ip_tables x_tables=
 autofs4 btrfs zstd_decompress zstd_compress dm_thin_pool dm_persistent_dat=
a dm_bio_prison algif_skcipher af_alg raid10 raid456 async_raid6_recov asyn=
c_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 mul=
tipath linear hid_generic i2c_designware_platform i2c_designware_core crct1=
0dif_pclmul crc32_pclmul rtsx_pci_sdmmc ghash_clmulni_intel xhci_pci i2c_i8=
01 thunderbolt intel_lpss_pci rtsx_pci intel_lpss xhci_hcd mfd_core i2c_hid=
 hid
[   13.837374] CPU: 2 PID: 741 Comm: run-parts Not tainted 5.0.0-00034-gcaa=
e0ec7396f #54
[   13.837374] Hardware name: Dell Inc. XPS 13 9380/0KTW76, BIOS 1.2.1 02/1=
4/2019
[   13.837375] RIP: 0010:lock_downgrade+0xe7/0x17f
[   13.837376] Code: 00 00 00 8b 44 24 04 89 83 80 08 00 00 48 8b 45 00 48 =
89 83 78 08 00 00 f6 45 32 03 74 0e 48 c7 c7 eb 6e e7 ab e8 34 81 fb ff <0f=
> 0b 8a 45 32 4c 89 6d 08 44 89 e6 48 89 df 83 e0 fc 83 c8 01 88
[   13.837377] RSP: 0018:ffff9dcbcf027e28 EFLAGS: 00010082
[   13.837378] RAX: 0000000000000000 RBX: ffff9dcbcef3a9c0 RCX: 00000000000=
00000
[   13.837379] RDX: ffff9dcbcef3a9c0 RSI: 0000000000000001 RDI: ffffffffab1=
0ec18
[   13.837379] RBP: ffff9dcbcef3b248 R08: 0000000000000017 R09: 00000000001=
e1e80
[   13.837380] R10: ffff9dcbcef3a9c0 R11: 0000000a2851b6dd R12: 00000000000=
00001
[   13.837380] R13: ffffffffab205904 R14: 0000000000000246 R15: ffff9dcbcef=
49b28
[   13.837381] FS:  00007f6b961d7580(0000) GS:ffff9dcbdda00000(0000) knlGS:=
0000000000000000
[   13.837382] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.837383] CR2: 000055a3940d7000 CR3: 0000000494962005 CR4: 00000000003=
606e0
[   13.837383] Call Trace:
[   13.837387]  downgrade_write+0x17/0x80
[   13.837392]  __do_munmap+0x26f/0x2fe
[   13.837394]  __vm_munmap+0x74/0xbf
[   13.837396]  __x64_sys_munmap+0x27/0x2c
[   13.837398]  do_syscall_64+0x5e/0x6c
[   13.837400]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   13.837401] RIP: 0033:0x7f6b96214717
[   13.837402] Code: ff ff ff f7 d8 89 05 48 ea 00 00 48 c7 c0 ff ff ff ff =
eb 8a 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 19 ea 00 00 f7 d8 89 01 48 83
[   13.837403] RSP: 002b:00007fffbd93f668 EFLAGS: 00000202 ORIG_RAX: 000000=
000000000b
[   13.837403] RAX: ffffffffffffffda RBX: 0000000a2851756f RCX: 00007f6b962=
14717
[   13.837406] RDX: 0000000a2851a714 RSI: 0000000000021557 RDI: 00007f6b961=
d8000
[   13.837406] RBP: 00007fffbd93f860 R08: 00007f6b9601a1f0 R09: 00000000000=
00007
[   13.837407] R10: 00007f6b962229f0 R11: 0000000000000202 R12: 00000000000=
00000
[   13.837407] R13: 00007f6b96223190 R14: 00007f6b961d7580 R15: 00007f6b962=
23190
[   13.837409] irq event stamp: 719
[   13.837413] hardirqs last  enabled at (719): [<ffffffffab0486c9>] do_use=
r_addr_fault+0xf3/0x396
[   13.837414] hardirqs last disabled at (718): [<ffffffffab0019d6>] trace_=
hardirqs_off_thunk+0x1a/0x1c
[   13.837416] softirqs last  enabled at (0): [<ffffffffab0b4ead>] copy_pro=
cess.part.43+0x452/0x1af8
[   13.837421] softirqs last disabled at (0): [<0000000000000000>]         =
  (null)
[   13.837422] ---[ end trace 0c20cc7bb894cd38 ]---

--SUOF0GtieIMvvwua
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg.out.gz"
Content-Transfer-Encoding: base64

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

--SUOF0GtieIMvvwua--
