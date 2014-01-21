Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:56812 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbaAUByj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 20:54:39 -0500
MIME-Version: 1.0
In-Reply-To: <20140120233543.15159.qmail@science.horizon.com>
References: <CAJtEV7ZsM2YHHETRGNwXnGi7uq0mJen73i-Yp3EXoDrnni=o=g@mail.gmail.com>
	<20140120233543.15159.qmail@science.horizon.com>
Date: Tue, 21 Jan 2014 09:54:38 +0800
Message-ID: <CAJtEV7b5MKn7JshUjhVH-fmiQcD-AZR6-YSCrdUhb+8-KMM0JA@mail.gmail.com>
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
From: Andrew Cooks <acooks@gmail.com>
To: George Spelvin <linux@horizon.com>
Cc: "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	linux-ide@vger.kernel.org,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 21, 2014 at 7:35 AM, George Spelvin <linux@horizon.com> wrote:
> I'm looking over the bug reports, and I'm trying to understand why you
> need two mechanisms.  You have one table (pci_dev_dma_source_map)
> that maps one devfn to a secondary one, and a second table
> (pci_dev_dma_multi_source_map) that gives a 2-bit bitmap of function
> numbers.
I haven't found a simple way to combine the two maps that still makes
the two distinct problems apparent.
pci_dev_dma_multi_source_map deals with devices that use multiple
functions, but the correct device number.
pci_dev_dma_source_map deals with devices that use a single incorrect
devfn that's mangled in both device and function numbers.

> But as I understand it, all the Marvell devices listed there always have
> a devfn of 00.0, so you could just move them to the first table with a
> mapping to 00.1.
>
> If they also have device/function 00.1 using a requester ID of 00.0
> you could add a second entry.
>
> The only time you'd need a bitmap would be if the device ended up on
> function 2 or higher and still used functions 0 and 1 in request IDs.

Sure, that sounds reasonable and certainly needs to be considered, but
since there's no complete record of what devices get this wrong and
how they get this wrong, I wanted to
* show all requester ids are used for each device in a concise entry,
* build up as much of a record of this problem as possible (hence the
comments and bug references),
* make it easy to see the general problem and have this discussion,
* not make assumptions about which functions would be visible and
which requester ids are actually used (like a device showing up at
00.0 that uses 00.1 and 00.2 only).

Who knows what will show up when iommu is turned on by default again.

> Now, unfortunately this does not cover the phantom functions case, but
> that could be done with separate code.
>
>
> The other question is when to do the lookup.  I don't know how often
> IOMMU mapping is done, and if linear search through a list of PCI devices
> would be a performance problem.  It would be nicer to have a standard
> PCI fixup done once which sets a flag in the pci_dev to either note the
> actual secondary devfn, or set a flag to trigger the secondary lookup
> only on the devices that need it.

Yes, I'd also like to hear what the gatekeepers think about this.

Thanks,

a.
