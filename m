Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56436 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbdLDPJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 10:09:34 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/8] SH7786 PCIe support fixes
Date: Mon,  4 Dec 2017 16:08:59 +0100
Message-Id: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

The following patches fix a number of issues I encountered while
making PCIe work on a SH7786 platform (both a SH7786 SH4-AP board
running little-endian with a basic E1000E NIC on PCIe, and a custom
SH7786 board running big-endian with a custom IP in an FPGA accessed
over PCIe).

A quick summary of the issues:

 - Some PCI MEM resources were used even if they conflict with RAM

 - The addresses of the PCI MEM and IO regions did not match the
   SH7786 datasheet (the first MEM region and the IO region were
   inverted), causing the device MEM BARs to be unusable.

 - The PCI -> SuperHyway mapping was not correct in some memory
   configurations:

   - With 64 MB or 128 MB and the RAM starting at 0x0800_0000, there
     is an offset of 0x0800_0000 between PCI and memory addresses that
     the DMA mapping API should observe.

   - With 256 MB of RAM starting at 0x0800_0000, we have a region that
     is not aligned on its size, to its must be expanded to 512 MB
     with a base address of 0.

The commit logs have much more details about the fixes.

Best regards,

Thomas Petazzoni

Thomas Petazzoni (8):
  arch/sh: add sh7786_mm_sel() function
  arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset
  arch/sh: pci: don't use disabled resources
  arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
  arch/sh: pcie-sh7786: exclude unusable PCI MEM areas
  arch/sh: pcie-sh7786: adjust PCI MEM and IO regions
  arch/sh: pcie-sh7786: adjust the memory mapping
  arch/sh: pcie-sh7786: handle non-zero DMA offset

 arch/sh/drivers/pci/pci.c            |  5 +++
 arch/sh/drivers/pci/pcie-sh7786.c    | 78 +++++++++++++++++++++++++-----------
 arch/sh/include/cpu-sh4/cpu/sh7786.h |  7 ++++
 arch/sh/kernel/dma-nommu.c           |  7 +++-
 arch/sh/mm/consistent.c              |  4 +-
 5 files changed, 74 insertions(+), 27 deletions(-)

-- 
2.13.6
