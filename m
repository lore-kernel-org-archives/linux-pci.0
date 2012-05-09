Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755724Ab2EIJyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 May 2012 05:54:18 -0400
Message-ID: <4FAA3EB0.1040908@redhat.com>
Date: Wed, 09 May 2012 17:53:52 +0800
From: Amos Kong <akong@redhat.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org, rjw@sisk.pl,
	alex.williamson@redhat.com, kevin@koconnor.net, liuj97@gmail.com
Subject: Re: [Qemu-devel] [RESEND PATCH v3] hotplug: add device per func in
 ACPI DSDT tables
References: <20111214010645.GA2044@morn.localdomain> <20120509072452.14872.92530.stgit@t> <20120509084447.GA14189@redhat.com> <4FAA3205.4030300@redhat.com>
In-Reply-To: <4FAA3205.4030300@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/05/12 16:59, Amos Kong wrote:
> On 09/05/12 16:46, Michael S. Tsirkin wrote:
>> On Wed, May 09, 2012 at 03:24:52PM +0800, Amos Kong wrote:
>>> Boot up a Linux VM with 8 pci block devices which
>>> are the 8 functions in one pci slot.
>>> | # qemu-kvm ...
>>> | -drive file=images/u0,if=none,id=drv0,format=qcow2,cache=none \
>>> | -device virtio-blk-pci,drive=drv0,id=v0,multifunction=on,addr=0x03.0 \
>>> | ....
>>> | -drive file=images/u7,if=none,id=drv7,format=qcow2,cache=none \
>>> | -device virtio-blk-pci,drive=drv7,id=v7,multifunction=on,addr=0x03.7 \
>>>
>>> Check devices in guest.
>>> | vm)# ls /dev/vd*
>>> | vda vdb vdc vde vdf vdg vdh
>>> | vm)# lspci |grep block
>>> | 00:03.0 SCSI storage controller: Red Hat, Inc Virtio block device
>>> | ...
>>> | 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device
>>> |


Discussed with mst, NAK this patch by myself.

>>> Func1~7 still exist in guest after hot-removing the whole slot
>>> through qemu monitor.
>>> | vm)# lspci |grep block (00:03.0 disappeared)
>>> | 00:03.1 SCSI storage controller: Red Hat, Inc Virtio block device
>>> (rev ff)
>>> | ...
>>> | 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device


In this condition, ALL devices already removed, but the sysinfo
(/proc , /sys) of func1~7 are not cleaned, this is why we can
still see it in 'lspci' output.

And Windows hotplug works fine with current seabios. In thread [1],
Kenji Kaneshige and Bjorn Helgaas accept to fix this in linux pci driver.

So NAK this seabios patch by myself, I will update original pci patch in 
thread [1]
[PATCH] pci: clean all funcs when hot-removing multifunc device


[1] http://marc.info/?t=131597601700003&r=1&w=2

>>> (rev ff)
>>> | vm)# ls /dev/vd* (vda disappeared)
>>> | vdb vdc vde vdf vdg vdh
>>> | vm)# mkfs /dev/vdb
>>> | INFO: task mkfs.ext2:1784 blocked for more than 120 seconds. (task
>>> hung)
>>>
>>>
>>> Currently only func0 is defined in ACPI DSDT table
>>> of seabios, and only hot-adding func0 would cause
>>> a ACPI event for notification. Other funcs except
>>> func0 wouldn't be registered in linux pci driver.
>>> (we can only found func0 in slot->funcs list of
>>> pci driver).
>>
>> Isn't this what your patch 'PCI: Can continually add funcs after adding
>> func0' addresses?
>
> No.
>
> This patch fixes the problem that some funcs could not be removed.
> the question is sending ACPI event for all functions (in same slot)
> or only function 0.

One event is enough to remove all functions, the real problem is in
clean of linux pci driver.

> I found all funcs are defined in ACPI DSDT table in microsoft's example:
> http://www.microsoft.com/china/whdc/system/pnppwr/hotadd/hotplugpci.mspx#EUH
>
> Is it a useful attestation ?

-- 
			Amos.
