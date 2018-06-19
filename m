Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937635AbeFSORK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2018 10:17:10 -0400
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: add support for Xilinx PCIe root ports on RISC-V
Date: Tue, 19 Jun 2018 16:16:57 +0200
Message-Id: <20180619141700.7842-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

this series with patches originally from Palmer and Wesley adds support
for the pcie-xilinx host driver on RISC-V boards.  The interesting part
about that is that the IP blocks is limited to 32-bit DMA internally,
which didn't seem to be an issue with the existing users, but shows
up easily with the Sifive RISC-V boards that have physical memory
wired up above 4G.  To support this the per-device flag I've added last
merge window is set through a new hook in struct pci_ops.
