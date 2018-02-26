Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:50037 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBZNcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Feb 2018 08:32:16 -0500
Date: Mon, 26 Feb 2018 14:32:13 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/8] SH7786 PCIe support fixes
Message-ID: <20180226143213.6d774a46@windsurf.lan>
In-Reply-To: <20180107160627.5a1231fa@windsurf>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
        <20180107160627.5a1231fa@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

+Andrew Morton in To.

On Sun, 7 Jan 2018 16:06:27 +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon,  4 Dec 2017 16:08:59 +0100, Thomas Petazzoni wrote:
> 
> > Thomas Petazzoni (8):
> >   arch/sh: add sh7786_mm_sel() function
> >   arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset
> >   arch/sh: pci: don't use disabled resources
> >   arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
> >   arch/sh: pcie-sh7786: exclude unusable PCI MEM areas
> >   arch/sh: pcie-sh7786: adjust PCI MEM and IO regions
> >   arch/sh: pcie-sh7786: adjust the memory mapping
> >   arch/sh: pcie-sh7786: handle non-zero DMA offset  
> 
> It's been a month. Any feedback on those patches ?

It's been another month. Patches have been sent on December 4, pinged
on January 7, we're February 26, and I had no feedback.

Since it's touching a very old SoC that no many people care about
anymore, I do understand the lack of interest. But in this case, could
we please just merge those patches ? If nobody is interested, it is
also unlikely to break things for people, right ?

Andrew, would you be willing to take those patches, which are not
receiving any attention ?

Thanks a lot,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
