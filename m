Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37593 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754084AbeAGPG3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Jan 2018 10:06:29 -0500
Date: Sun, 7 Jan 2018 16:06:27 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/8] SH7786 PCIe support fixes
Message-ID: <20180107160627.5a1231fa@windsurf>
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

It's been a month. Any feedback on those patches ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
