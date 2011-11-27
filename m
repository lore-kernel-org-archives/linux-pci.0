Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36674 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab1K0USY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2011 15:18:24 -0500
Received: by bke11 with SMTP id 11so7464254bke.19
        for <linux-pci@vger.kernel.org>; Sun, 27 Nov 2011 12:18:22 -0800 (PST)
Message-ID: <4ED29B09.10701@gmail.com>
Date: Sun, 27 Nov 2011 23:18:17 +0300
From: Alex <alex.vizor@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: WARNING: at drivers/pci/pci-driver.c:607 pci_has_legacy_pm_support+0x57/0x5d()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

Since bugzilla.kernel.org is in down I'm writing this letter. On every 
resume I get following warnings in kernel log:
Nov 25 22:09:43 alex kernel: [  702.991779] ------------[ cut here 
]------------
Nov 25 22:09:43 alex kernel: [  702.991790] WARNING: at 
drivers/pci/pci-driver.c:607 pci_has_legacy_pm_support+0x57/0x5d()
Nov 25 22:09:43 alex kernel: [  702.991792] Hardware name: 4170CTO
Nov 25 22:09:43 alex kernel: [  702.991797] Modules linked in: fcoe 
libfcoe 8021q lockd libfc scsi_transport_fc garp stp llc scsi_tgt
  ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4 
nf_defrag_ipv4 ip6table_filter xt_state nf_conntrack ip6_tables hdaps
(O) thinkpad_ec(O) snd_hda_codec_hdmi snd_hda_codec_conexant 
snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device arc4 iwlwif
i uvcvideo videodev mac80211 media snd_pcm e1000e snd_timer 
snd_page_alloc iTCO_wdt iTCO_vendor_support v4l2_compat_ioctl32 cfg80211
thinkpad_acpi snd wmi rfkill i2c_i801 soundcore pcspkr joydev microcode 
uinput sunrpc sdhci_pci sdhci mmc_core [last unloaded: scsi_w
ait_scan]
Nov 25 22:09:43 alex kernel: [  702.991857] Pid: 3107, comm: kworker/u:0 
Tainted: G           O 3.2.0-0.rc3.git0.1.fc16.x86_64 #1
Nov 25 22:09:43 alex kernel: [  702.991859] Call Trace:
Nov 25 22:09:43 alex kernel: [  702.991867]  [<ffffffff810589c2>] 
warn_slowpath_common+0x83/0x9b
Nov 25 22:09:43 alex kernel: [  702.991872]  [<ffffffff810589f4>] 
warn_slowpath_null+0x1a/0x1c
Nov 25 22:09:43 alex kernel: [  702.991876]  [<ffffffff81249682>] 
pci_has_legacy_pm_support+0x57/0x5d
Nov 25 22:09:43 alex kernel: [  702.991881] ehci_hcd 0000:00:1d.0: PCI 
INT A disabled
Nov 25 22:09:43 alex kernel: [  702.991884]  [<ffffffff81249c19>] 
pci_pm_suspend+0x39/0x100
Nov 25 22:09:43 alex kernel: [  702.991891]  [<ffffffff8134193c>] 
pm_op+0x8b/0x149
Nov 25 22:09:43 alex kernel: [  702.991895]  [<ffffffff81341bec>] 
__device_suspend+0x194/0x247
Nov 25 22:09:43 alex kernel: [  702.991897] ehci_hcd 0000:00:1a.0: PCI 
INT A disabled
Nov 25 22:09:43 alex kernel: [  702.991900]  [<ffffffff81341cbe>] 
async_suspend+0x1f/0x5d
Nov 25 22:09:43 alex kernel: [  702.991905]  [<ffffffff810790cd>] 
async_run_entry_fn+0x9e/0x131
Nov 25 22:09:43 alex kernel: [  702.991909]  [<ffffffff8107902f>] ? 
async_schedule+0x17/0x17
Nov 25 22:09:43 alex kernel: [  702.991916]  [<ffffffff8106efa8>] 
process_one_work+0x176/0x2a9
Nov 25 22:09:43 alex kernel: [  702.991920]  [<ffffffff8106d040>] ? 
need_to_create_worker+0x12/0x26
Nov 25 22:09:43 alex kernel: [  702.991925]  [<ffffffff8106fab6>] 
worker_thread+0xda/0x15d
Nov 25 22:09:43 alex kernel: [  702.991929]  [<ffffffff8106f9dc>] ? 
manage_workers+0x176/0x176
Nov 25 22:09:43 alex kernel: [  702.991933]  [<ffffffff810731b3>] 
kthread+0x84/0x8c
Nov 25 22:09:43 alex kernel: [  702.991938]  [<ffffffff815281b4>] 
kernel_thread_helper+0x4/0x10
Nov 25 22:09:43 alex kernel: [  702.991943]  [<ffffffff8107312f>] ? 
kthread_worker_fn+0x148/0x148
Nov 25 22:09:43 alex kernel: [  702.991947]  [<ffffffff815281b0>] ? 
gs_change+0x13/0x13
Nov 25 22:09:43 alex kernel: [  702.991950] ---[ end trace 
6d1eab899804323c ]---

Could you please fix this?
