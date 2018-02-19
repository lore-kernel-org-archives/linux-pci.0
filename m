Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40375 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbeBSQWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Feb 2018 11:22:50 -0500
Date: Mon, 19 Feb 2018 17:22:48 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/8] SH7786 PCIe support fixes
Message-ID: <20180219172248.12360360@windsurf.lan>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Mon,  4 Dec 2017 16:08:59 +0100, Thomas Petazzoni wrote:

> Thomas Petazzoni (8):
>   arch/sh: add sh7786_mm_sel() function
>   arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset
>   arch/sh: pci: don't use disabled resources
>   arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
>   arch/sh: pcie-sh7786: exclude unusable PCI MEM areas
>   arch/sh: pcie-sh7786: adjust PCI MEM and IO regions
>   arch/sh: pcie-sh7786: adjust the memory mapping
>   arch/sh: pcie-sh7786: handle non-zero DMA offset

It's been more than 2 months, and I haven't received any review on this
patch series.

It is very likely that I am one of the only active user of a SH7786
platform, so I don't think those patches will break things for anybody.
Would it be possible to just merge them ? I doubt anyone will be
interested in doing a very careful and detailed review, since I doubt
anyone is interested in this SH7786 platform anymore.

The only patch that can potentially break things for other is "arch/sh:
make the DMA mapping operations observe dev->dma_pfn_offset" but I
believe it is useful to have it and fix any fallout (which should be
trivial).

So please, please, merge :-)

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
