Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:35595 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936351Ab3DRTnT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2013 15:43:19 -0400
Received: by mail-ia0-f171.google.com with SMTP id f27so2801975iae.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2013 12:43:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <516FB479.1060601@cn.fujitsu.com>
References: <516FB479.1060601@cn.fujitsu.com>
Date: Thu, 18 Apr 2013 12:43:19 -0700
Message-ID: <CAE9FiQWtC4S52BUeDQvAJS2L=q6i_R6eZeEoAPPohg60NcY0UA@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: fix the object lifetime issue of parallel device
 removal on different pci hierarchy
From: Yinghai Lu <yinghai@kernel.org>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>
Content-Type: multipart/mixed; boundary=90e6ba1efc7081b8ad04daa7d0c2
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--90e6ba1efc7081b8ad04daa7d0c2
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Apr 18, 2013 at 1:53 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
> From 0c45a7fca2276123d0b926a22ea69158dad8ab9c Mon Sep 17 00:00:00 2001
> From: Gu Zheng <guz.fnst@cn.fujitsu.com>
> Date: Thu, 18 Apr 2013 17:43:53 +0900
> Subject: [PATCH 0/3] PCI: fix the object lifetime issue of parallel device removal on different pci hierarchy
>
> This patch is used to fix the panic issue of parallel device removal on different pci hierarchy,
> refer to https://bugzilla.kernel.org/show_bug.cgi?id=54411.
>
> [  418.775140]  ioatdma i7core_edac edac_core sg e1000e igb dca ptp pps_core
> sd_mod crc_t10dif megaraid_sas mptsas mptscsih mptbase scsi_transport_sas
> scsi_mod
> [  418.946462] CPU 4
> [  418.968377] Pid: 512, comm: kworker/u:2 Tainted: G        W    3.8.0 #2
> FUJITSU-SV PRIMEQUEST 1800E/SB
> [  419.081763] RIP: 0010:[<ffffffff8137972e>]  [<ffffffff8137972e>]
> pci_bus_read_config_word+0x5e/0x90
> [  419.189965] RSP: 0018:ffff8807b0a37c08  EFLAGS: 00010046
> [  419.253409] RAX: 6b6b6b6b6b6b6b6b RBX: ffff8807bb4a1290 RCX:
> 0000000000000002
> [  419.338658] RDX: 00000000000000c4 RSI: 0000000000000008 RDI:
> ffff8807bb4a1290
> [  419.423925] RBP: ffff8807b0a37c48 R08: ffff8807b0a37c24 R09:
> 6db5c22da55960d0
> [  419.509175] R10: 0000000000000000 R11: 000000000003ecd0 R12:
> ffff8807b0a37c66
> [  419.594425] R13: 0000000000000282 R14: ffffffff82126d40 R15:
> 0000000000000000
> [  419.679675] FS:  0000000000000000(0000) GS:ffff8807c2200000(0000)
> knlGS:0000000000000000
> [  419.776343] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  419.844981] CR2: 00007ffa898a54f8 CR3: 0000000001c0c000 CR4:
> 00000000000007e0
> [  419.930236] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  420.015484] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [  420.100736] Process kworker/u:2 (pid: 512, threadinfo ffff8807b0a36000, task
> ffff8807b30bcd00)
> [  420.203632] Stack:
> [  420.227623]  ffff8807000000c4 ffffffff00000008 ffffffff813851ef
> 0000000000992000
> [  420.316421]  ffff8807b0a37c98 ffff8807bb49b3d8 0000000000000000
> 0000000000000000
> [  420.405233]  ffff8807b0a37c88 ffffffff8138044b ffff8807b0a37c88
> 0000000000000246
> [  420.494137] Call Trace:
> [  420.523326]  [<ffffffff813851ef>] ? remove_callback+0x1f/0x40
> [  420.591984]  [<ffffffff8138044b>] pci_pme_active+0x4b/0x1c0
> [  420.658545]  [<ffffffff8137d8e7>] pci_stop_bus_device+0x57/0xb0
> [  420.729259]  [<ffffffff8137dab6>] pci_stop_and_remove_bus_device+0x16/0x30
> [  420.811392]  [<ffffffff813851fb>] remove_callback+0x2b/0x40
> [  420.877955]  [<ffffffff81257a56>] sysfs_schedule_callback_work+0x26/0x70
> [  420.958017]  [<ffffffff810919ae>] process_one_work+0x20e/0x5c0
> [  421.027691]  [<ffffffff8109193f>] ? process_one_work+0x19f/0x5c0
> [  421.099441]  [<ffffffff81257a30>] ? sysfs_schedule_callback+0x210/0x210
> [  421.178461]  [<ffffffff81093a4e>] worker_thread+0x12e/0x370
> [  421.245020]  [<ffffffff81093920>] ? manage_workers+0x180/0x180
> [  421.314697]  [<ffffffff81099b8e>] kthread+0xee/0x100
> [  421.373992]  [<ffffffff810e0f09>] ? __lock_release+0x129/0x190
> [  421.443671]  [<ffffffff81099aa0>] ? __init_kthread_worker+0x70/0x70
> [  421.518544]  [<ffffffff816b2dac>] ret_from_fork+0x7c/0xb0
> [  421.583031]  [<ffffffff81099aa0>] ? __init_kthread_worker+0x70/0x70
> [  421.657894] Code: 89 75 c8 c7 45 dc 00 00 00 00 e8 4e ef 32 00 49 89 c5 48
> 8b 83 b8 00 00 00 4c 8d 45 dc b9 02 00 00 00 8b 55 c0 8b 75 c8 48 89 df <ff> 10
> 8b 55 dc 4c 89 ee 48 c7 c7 c0 67 cb 81 89 45 c8 66 41 89
> [  421.890306] RIP  [<ffffffff8137972e>] pci_bus_read_config_word+0x5e/0x90
> [  421.970475]  RSP <ffff8807b0a37c08>
> [  422.012121] ---[ end trace 403f76cf31f1bcb1 ]---
>
> It is easy to reproduce with the following script:
> echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove ; echo -n 1 >
> /sys/bus/pci/devices/0000\:1a\:01.0/remove
>
> The 1a:01.0 device is downstream from the 10:00.0 bridge.
>
> The sysfs interface remove_store() uses device_schedule_callback() to schedule
> the remove for later. What's happening is that we schedule
> remove_callback() for both devices before 10:00.0 has been removed,
> like this:
>
>     # echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove
>     remove_store  # for 10:00.0
>       device_schedule_callback(10:00.0, remove_callback)
>         sysfs_schedule_callback
>           kobject_get
>           queue_work
>     # echo -n 1 >  /sys/bus/pci/devices/0000\:1a\:01.0/remove
>     remove_store  # for 1a:01.0
>       device_schedule_callback(1a:01.0, remove_callback)
>         sysfs_schedule_callback
>           kobject_get
>           queue_work
>
> Later, we run the callbacks, starting with 10:00.0.  This calls
> remove_callback() to perform the remove:
>
>     remove_callback(10:00.0)
>       mutex_lock(&pci_remove_rescan_mutex)
>       pci_stop_and_remove_bus_device(pdev)
>       mutex_unlock(&pci_remove_rescan_mutex)
>
> This will stop and remove the subtree below 10:00.0, but it does not
> actually free the pci_dev for 1a:01.0 because we increased its ref
> count in sysfs_schedule_callback.  So after completing
> remove_callback(10:00.0), we run the second callback for 1a:01.0.
>
> But the PCI core did this removal wrong. It deallocated the struct pci_bus
> for bus 0000:1a too soon.
>
> So we take a reference on the bus object when capturing the struct pci_bus pointer,
> in order to keep it valid before its downstream devices' removal routines complete.
>
> Gu Zheng (3):
>   PCI: take a reference on the bus object when we capture the struct
>     pci_bus pointer
>   PCI: rename alloc_pci_dev() to pci_alloc_dev()
>   PCI: Move the acquiring the reference of pci bus inside
>     pci_alloc_bus()
>
>  arch/powerpc/kernel/pci_of_scan.c |    3 +--
>  drivers/char/agp/alpha-agp.c      |    2 +-
>  drivers/char/agp/parisc-agp.c     |    2 +-
>  drivers/pci/bus.c                 |   14 ++++++++++++++
>  drivers/pci/iov.c                 |    6 ++++--
>  drivers/pci/probe.c               |   10 ++++++----
>  drivers/scsi/megaraid.c           |    2 +-
>  include/linux/pci.h               |    5 ++++-
>  8 files changed, 32 insertions(+), 12 deletions(-)

No. that is wrong.

I can not find where that reference count get reduced!
in the my test patches that I sent, it does have have that in remove path.

What is reason for you to remove that line?

After put the line back, your test still can pass?

Yinghai

--90e6ba1efc7081b8ad04daa7d0c2
Content-Type: application/octet-stream; name="pci_dev_bus_ref.patch"
Content-Disposition: attachment; filename="pci_dev_bus_ref.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hfoc4wzg0

LS0tCiBkcml2ZXJzL3BjaS9wcm9iZS5jICB8ICAgIDEgKwogZHJpdmVycy9wY2kvcmVtb3ZlLmMg
fCAgICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpJbmRleDogbGludXgt
Mi42L2RyaXZlcnMvcGNpL3Byb2JlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJp
dmVycy9wY2kvcHJvYmUuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNpL3Byb2JlLmMKQEAgLTEz
MzcsNiArMTMzNyw3IEBAIHZvaWQgcGNpX2RldmljZV9hZGQoc3RydWN0IHBjaV9kZXYgKmRldiwK
IAkgKi8KIAlkb3duX3dyaXRlKCZwY2lfYnVzX3NlbSk7CiAJbGlzdF9hZGRfdGFpbCgmZGV2LT5i
dXNfbGlzdCwgJmJ1cy0+ZGV2aWNlcyk7CisJZ2V0X2RldmljZSgmYnVzLT5kZXYpOwogCXVwX3dy
aXRlKCZwY2lfYnVzX3NlbSk7CiAKIAlwY2lfZml4dXBfZGV2aWNlKHBjaV9maXh1cF9maW5hbCwg
ZGV2KTsKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9yZW1vdmUuYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3BjaS9yZW1vdmUuYworKysgbGludXgtMi42L2RyaXZl
cnMvcGNpL3JlbW92ZS5jCkBAIC0zNiw2ICszNiw3IEBAIHN0YXRpYyB2b2lkIHBjaV9kZXN0cm95
X2RldihzdHJ1Y3QgcGNpX2QKIHsKIAlkb3duX3dyaXRlKCZwY2lfYnVzX3NlbSk7CiAJbGlzdF9k
ZWwoJmRldi0+YnVzX2xpc3QpOworCXB1dF9kZXZpY2UoJmRldi0+YnVzLT5kZXYpOwogCXVwX3dy
aXRlKCZwY2lfYnVzX3NlbSk7CiAKIAlwY2lfZnJlZV9yZXNvdXJjZXMoZGV2KTsK
--90e6ba1efc7081b8ad04daa7d0c2--
