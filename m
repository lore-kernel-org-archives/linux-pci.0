Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752627AbdCISLj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Mar 2017 13:11:39 -0500
Date: Thu, 9 Mar 2017 12:11:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "agraf@suse.de" <agraf@suse.de>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [QUESTION]: Same IO bus address in different _CRS methods
Message-ID: <20170309181134.GA15721@bhelgaas-glaptop.roam.corp.google.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E2046C6AC@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E2046C6AC@FRAEML521-MBX.china.huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 09, 2017 at 03:41:03PM +0000, Gabriele Paoloni wrote:
> Hi Bjorn and all
> 
> I have a question regarding bus addresses for IO resources in the
> ACPI table.
> 
> The question is if from an ACPI perspective it is legal to have two
> entries in separate _CRS methods using the same IO bus address.
> 
> As an example please see the code at the bottom: we have the same
> bus address starting at 0x0 with (obviously) different offsets
> leading to different CPU physical addresses. Is this legal?

Yes.

These are on separate PCI buses (PCI0 leads to 0000:00 and PCI1 leads
to 0001:e0), so there should be no conflict.  Those are completely
independent PCI buses, and their bus address spaces are also
independent.

You do have to make sure the CPU physical addresses don't conflict, of
course.

It looks like these are memory space on the CPU side, and the bridge
converts it to PCI I/O space, right?  There is an ACPI _TTP bit to
indicate this, which I don't see in your descriptors.

> p.s. full DSDT is here:
> https://git.linaro.org/people/heyi.guo/OpenPlatformPkg.git/tree/Chips/Hisilicon/Hi1610/Hi1610AcpiTables/Dsdt/D03Pci.asl?h=estuary-rp
> 
> Many thanks
> Gab
> 
> ----
> 
>   Device (PCI0)
>   {
>     Name (_HID, "HISI0080") // PCI Express Root Bridge
>     Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
>     Name(_SEG, 0) // Segment of this Root complex
>     Name(_BBN, 0) // Base Bus Number
>     Name(_CCA, 1)
>     Method (_CRS, 0, Serialized) { // Root complex resources
> 
> [...]
> 
>         QWordIO (
>           ResourceProducer,
>           MinFixed,
>           MaxFixed,
>           PosDecode,
>           EntireRange,
>           0x0, // Granularity
>           0x0, // Min Base Address
>           0xffff, // Max Base Address
>           0xb7ff0000, // Translate
>           0x10000 // Length
>         )
>       }) // Name(RBUF)
>       Return (RBUF)
>     } // Method(_CRS)
> 
> 
> // PCIe Root bus
>   Device (PCI1)
>   {
>     Name (_HID, "HISI0080") // PCI Express Root Bridge
>     Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
>     Name(_SEG, 1) // Segment of this Root complex
>     Name(_BBN, 0xe0) // Base Bus Number
>     Name(_CCA, 1)
>     Method (_CRS, 0, Serialized) { // Root complex resources
> 
> [...]
> 
>         QWordIO (
>           ResourceProducer,
>           MinFixed,
>           MaxFixed,
>           PosDecode,
>           EntireRange,
>           0x0, // Granularity
>           0x0, // Min Base Address
>           0xffff, // Max Base Address
>           0xbdff0000, // Translate
>           0x10000 // Length
>         )
>       }) // Name(RBUF)
>       Return (RBUF)
>     } // Method(_CRS)
> 
