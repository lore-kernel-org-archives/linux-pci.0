Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58583 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161110AbcFGObP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2016 10:31:15 -0400
Date: Tue, 7 Jun 2016 07:31:14 -0700
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>
Subject: Re: [PATCH] Introducing kernel option to force all PCI memory
 resources to be page aligned. Fixes issues with uio based drivers.
Message-ID: <20160607143114.GA14513@kroah.com>
References: <fe4f2460f9454483bb18a64c1314c950@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe4f2460f9454483bb18a64c1314c950@FE-MBX1012.de.bosch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 06:51:47AM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Greg,
> > > thanks for the response.
> > > > > Some uio based PCI drivers (e.g. uio_cif) do not work if the
> > > > > assigned PCI memory resources are not page aligned.
> > > > > By using the kernel option "pci=resource_alignment" it is possible
> > > > > to force single PCI boards to use page alignment for their memory
> > resources.
> > > > > However, this is fairly cumbersome if multiple of these cards are in use.
> > > > > This patch adds another kernel option "pci=resources_page_aligned"
> > > > > that allows to set the default alignment of PCI memory resources
> > > > > to be page aligned.
> > > > > Overwriting of this default alignment via "pci=resource_alignment"
> > > > > is still possible.
> > > >
> > > > This seems like a very large hammer for a very specific problem with
> > > > a card that seems to be not-in-spec (I can't find anywhere that
> > > > requires resources to be "page" aligned in the PCI spec).  Why not fix the
> > firmware in these cards?
> > > The issue is not the firmware. The issue is that the Linux uio driver
> > > (here: uio_cif) does not work as uio_mmap() -> uio_mmap_physical()
> > > does not do a mmap on physical memory that is not page aligned...
> > 
> > Then why not fix the uio_cif driver?
> The fix might be in uio and not in uio_cif. However uio_mmap_physical() in
> uio.c has introduced checks to reject non page-aligned addresses.

Yes, because we had real problems with that in the past.

> These checks have been introduced somewhere in between kernel V3.2 and kernel V3.18. 
> Removing these checks again does not sound to me like a good idea...

I agree, you should fix your hardware :)

> The overall question is now if the UIO system is working at all with non page 
> aligned PCI memory resources. For me it looks as if this is not the case.

How is your system ending up with such alignment in the first place?
What is the resource list after booting?

thanks,

greg k-h
