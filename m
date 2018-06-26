Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:44781 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933788AbeFZKRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jun 2018 06:17:44 -0400
Received: by mail-qt0-f169.google.com with SMTP id 92-v6so10146378qta.11
        for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2018 03:17:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625111525.GA30242@wunner.de>
References: <1529921446-20452-1-git-send-email-hari.vyas@broadcom.com>
 <20180625103742.GA20292@wunner.de> <3fa3c29e023abf67fa74d6e94a27645f@mail.gmail.com>
 <20180625111525.GA30242@wunner.de>
From: Hari Vyas <hari.vyas@broadcom.com>
Date: Tue, 26 Jun 2018 15:47:43 +0530
Message-ID: <CAM5rFu-Bo_prR5R2w2XfM6JkUWo8URiL6i=4tWjOpDuMkcNn-w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Data corruption happening due to race condition
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 4:45 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Jun 25, 2018 at 04:27:37PM +0530, Hari Vyas wrote:
>>       This issue is happening  with multiple times device removal and
>> rescan from sysfs. Card is not removed physically.
>>       Is_added bit is set after device attach which probe nvme driver.
>> NVMe driver starts one workqueue and that one is calling pci_set_master()
>> to set is_busmaster bit.
>>       With multiple times device removal and rescan from sysfs,  race
>> condition is observed and is_added bit is over-written to 0 from workqueue
>> started by NVMe driver.
>
> Could you add a dump_stack() to pci_bus_add_device() and pci_stop_dev()
> where the is_added bit is modified, reproduce the issue and attach the
> resulting dmesg output to a newly opened bug on bugzilla.kernel.org?
>

I have raised a Bug 200283 - PCI: Data corruption happening due to a
race condition.
Please note that is_added bit is lost in pci_bus_add_device() and
__pci_set_master()
functions. Added dump_stack() with one additional debug message to
print cpu-id in
pci_set_master() is called from a CPU3 workqueue and pci_bus_add_device() from
CPU2 sysfs call.

root@bcm958742k:~# echo 1 > /sys/bus/pci/devices/0002\:01\:00.0/remove
[   32.385389] nvme nvme0: failed to set APST feature (-19)
root@bcm958742k:~# echo 1 > /sys/bus/pci/rescan
[   38.916435] pci 0002:01:00.0: BAR 0: assigned [mem
0x500000000-0x500003fff 64bit]
[   38.924822] nvme nvme0: pci function 0002:01:00.0

[   38.929702] nvme 0002:01:00.0: pci_bus_add_device:333 cpu=2


[   38.929705] CPU: 2 PID: 2360 Comm: sh Not tainted
4.17.0-02102-gdcfa25a-dirty #106
[   38.943259] Hardware name: Stingray Combo SVK (BCM958742K) (DT)


[   38.943267] nvme 0002:01:00.0: __pci_set_master:3681 cpu=3


[   38.949366] Call trace:
[   38.949375]  dump_backtrace+0x0/0x1b8
[   38.949377]  show_stack+0x14/0x1c
[   38.964748]  dump_stack+0x90/0xb0
[   38.968168]  pci_bus_add_device+0xbc/0xe0
[   38.972303]  pci_bus_add_devices+0x44/0x90
[   38.976527]  pci_bus_add_devices+0x74/0x90
[   38.980751]  pci_rescan_bus+0x2c/0x3c
[   38.984529]  bus_rescan_store+0x7c/0xa0
[   38.988485]  bus_attr_store+0x20/0x34
[   38.992264]  sysfs_kf_write+0x40/0x50
[   38.996040]  kernfs_fop_write+0xcc/0x1cc
[   39.000087]  __vfs_write+0x40/0x154
[   39.003683]  vfs_write+0xa8/0x198
[   39.007102]  ksys_write+0x58/0xbc
[   39.010520]  sys_write+0xc/0x14
[   39.013758]  __sys_trace_return+0x0/0x4

[   39.017714] CPU: 3 PID: 50 Comm: kworker/u16:1 Not tainted
4.17.0-02102-gdcfa25a-dirty #106
[   39.026329] Hardware name: Stingray Combo SVK (BCM958742K) (DT)
[   39.026336] Workqueue: nvme-reset-wq nvme_reset_work
[   39.037561] Call trace:
[   39.037563]  dump_backtrace+0x0/0x1b8
[   39.037564]  show_stack+0x14/0x1c
[   39.037566]  dump_stack+0x90/0xb0
[   39.037569]  __pci_set_master+0xd4/0x130
[   39.043866]  pci_set_master+0x18/0x2c
[   39.043867]  nvme_reset_work+0x110/0x14a4
[   39.050702]  process_one_work+0x12c/0x29c
[   39.050704]  worker_thread+0x13c/0x410
[   39.058522]  kthread+0xfc/0x128
[   39.058524]  ret_from_fork+0x10/0x18
root@bcm958742k:~#


> Thanks,
>
> Lukas
