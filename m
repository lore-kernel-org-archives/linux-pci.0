Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHDMOY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Aug 2018 08:14:24 -0400
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: add support for Xilinx PCIe root ports on RISC-V v3
Date: Sat,  4 Aug 2018 12:13:59 +0200
Message-Id: <20180804101402.10022-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

this series with patches originally from Palmer and Wesley adds support
for the pcie-xilinx host driver on RISC-V boards.  The interesting part
about that is that the IP blocks is limited to 32-bit DMA internally,
which didn't seem to be an issue with the existing users, but shows
up easily with the Sifive RISC-V boards that have physical memory
wired up above 4G.

Note that patches 1 and 2 depend on changes in the dma-mapping tree
to add the bus_dma_mask field to struct device and would have to merge
through the dma-mapping tree or a shared stable branch.  Patch 3 could
be merged independently.

Changes since v2:
 - rename the add_dev callback to add_device and allow it to return an
   error code (to allow it to replace pcibios_add_device in the future)

Changes since v1:
 - move the add_dev method to struct pci_host_bridge
 - use the new bus_dma_mask field
