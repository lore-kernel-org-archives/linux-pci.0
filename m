Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35287 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaLQTJy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Dec 2014 14:09:54 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so12632621qcx.13
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2014 11:09:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54913290.6070204@huawei.com>
References: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>
 <5490D5CB.5010200@huawei.com> <CAGZFCEFOiY+VmTVKOnPwDaKUKogUX9gkXtHuMATL3btw4kz2JQ@mail.gmail.com>
 <549119A9.4010406@huawei.com> <CAGZFCEGF2Do4Kus+T_yg6-A1wNSXKr-RBm3eSC6Wuw02OMWTOQ@mail.gmail.com>
 <54911F32.1070909@huawei.com> <CAGZFCEEFrLBbewsKmYVQGpnumeEY0Q7ZexrU+jydfyobuM7HTQ@mail.gmail.com>
 <54913290.6070204@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 17 Dec 2014 12:09:33 -0700
Message-ID: <CAErSpo6jHcNVPj4AT6ZdT82HUeewrqCFnB19oBQXhjZ+fFLGHg@mail.gmail.com>
Subject: Re: sysfs-pci remove
To: Yijing Wang <wangyijing@huawei.com>
Cc: ratheesh kannoth <ratheesh.ksz@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 17, 2014 at 12:36 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2014/12/17 14:21, ratheesh kannoth wrote:
>> On Wed, Dec 17, 2014 at 11:44 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> Unbind won't release PCI device bar resource, resources in /proc/iomem is the
>>> physical address resource(added by request_resource()), if you iounmap the bar resource,
>>> it won't change anything in /proc/iomem.
>>
>> who is calling request_resource() ...is it enic driver ?
>
> PCI core interface, E.g pci_bus_assign_resources()

Hi Ratheesh,

There are two things going on in /proc/iomem:

1) The core should put all the hardware that responds to physical
accesses in /proc/iomem.  These entries should be there regardless of
whether we have a driver for the device.  These are used when
assigning addresses to new devices, to make sure we don't assign the
same address to two different devices.  These entries include RAM,
ACPI tables, APICs, PCI host bridges, PCI MMCONFIG regions, PCI
devices, etc.  It *should* also include address space consumed by
other things like PNP and ACPI devices, but that is currently missing.

2) Individual drivers claim address space they use to control their
device, e.g., with pci_request_regions(), ioremap(), etc.  This puts
an entry in /proc/iomem with the driver name on it.  A device may
respond to several physical address regions, and a driver need not
claim all of them, and it may even claim only part of a region.

So when you unbind a driver, you should see the second type of entry
go away.  When you actually remove a device (hot-remove or sysfs
remove), you should see the first type go away as well, which means
there's no longer anything that will respond to that physical address
space.

Bjorn
