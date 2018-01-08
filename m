Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932407AbeAHWNO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jan 2018 17:13:14 -0500
Date: Mon, 8 Jan 2018 16:12:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/8] SH7786 PCIe support fixes
Message-ID: <20180108221258.GA31640@bhelgaas-glaptop.roam.corp.google.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
 <20180107160627.5a1231fa@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180107160627.5a1231fa@windsurf>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 07, 2018 at 04:06:27PM +0100, Thomas Petazzoni wrote:
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

I'm assuming Yoshinori and Rich will handle these.  Let me know if
otherwise.
