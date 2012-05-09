Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28051 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330Ab2EIJAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 May 2012 05:00:13 -0400
Message-ID: <4FAA3205.4030300@redhat.com>
Date: Wed, 09 May 2012 16:59:49 +0800
From: Amos Kong <akong@redhat.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org, rjw@sisk.pl,
	alex.williamson@redhat.com, kevin@koconnor.net, liuj97@gmail.com
Subject: Re: [Qemu-devel] [RESEND PATCH v3] hotplug: add device per func in
 ACPI DSDT tables
References: <20111214010645.GA2044@morn.localdomain> <20120509072452.14872.92530.stgit@t> <20120509084447.GA14189@redhat.com>
In-Reply-To: <20120509084447.GA14189@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/05/12 16:46, Michael S. Tsirkin wrote:
> On Wed, May 09, 2012 at 03:24:52PM +0800, Amos Kong wrote:
>> Boot up a Linux VM with 8 pci block devices which
>> are the 8 functions in one pci slot.
>> | # qemu-kvm ...
>> | -drive file=images/u0,if=none,id=drv0,format=qcow2,cache=none \
>> | -device virtio-blk-pci,drive=drv0,id=v0,multifunction=on,addr=0x03.0 \
>> | ....
>> | -drive file=images/u7,if=none,id=drv7,format=qcow2,cache=none \
>> | -device virtio-blk-pci,drive=drv7,id=v7,multifunction=on,addr=0x03.7 \
>>
>> Check devices in guest.
>> | vm)# ls /dev/vd*
>> |    vda vdb vdc vde vdf vdg vdh
>> | vm)# lspci |grep block
>> | 00:03.0 SCSI storage controller: Red Hat, Inc Virtio block device
>> |    ...
>> | 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device
>> |
>>
>> Func1~7 still exist in guest after hot-removing the whole slot
>> through qemu monitor.
>> | vm)# lspci |grep block    (00:03.0 disappeared)
>> | 00:03.1 SCSI storage controller: Red Hat, Inc Virtio block device (rev ff)
>> |    ...
>> | 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device (rev ff)
>> | vm)# ls /dev/vd*          (vda disappeared)
>> |    vdb vdc vde vdf vdg vdh
>> | vm)# mkfs /dev/vdb
>> |    INFO: task mkfs.ext2:1784 blocked for more than 120 seconds. (task hung)
>>
>>
>> Currently only func0 is defined in ACPI DSDT table
>> of seabios, and only hot-adding func0 would cause
>> a ACPI event for notification. Other funcs except
>> func0 wouldn't be registered in linux pci driver.
>> (we can only found func0 in slot->funcs list of
>> pci driver).
>
> Isn't this what your patch 'PCI: Can continually add funcs after adding
> func0' addresses?

No.

This patch fixes the problem that some funcs could not be removed.
the question is sending ACPI event for all functions (in same slot)
or only function 0.

I found all funcs are defined in ACPI DSDT table in microsoft's example:
http://www.microsoft.com/china/whdc/system/pnppwr/hotadd/hotplugpci.mspx#EUH 


Is it a useful attestation ?

> If yes it's commit f382a086f3129edc152b8044b69ccc6682e637bb in 3.4.

This commit fix the problem that some funcs could not be added.

> So let's class the problematic behaviour guest bug and avoid workarounds
> in bios?

-- 
			Amos.
