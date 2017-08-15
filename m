Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:38297 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbdHOTLg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 15:11:36 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v7 0/3] PCI: xilinx: Optimisation & MIPS support
Date: Tue, 15 Aug 2017 12:11:14 -0700
Message-ID: <20170815191117.19882-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series implements a couple of optimisations around interrupt
handling for the Xilinx AXI PCIe Host Bridge IP, then enables building
our driver for the MIPS architecture in order to make use of it on the
MIPS Boston development board.

The INTD fix was moved out of this series in v7 and is now part of a
"PCI: INTx interrupt fixes & cleanup" series which should be applied
first in order to avoid hitting the broken INTD interrupt issue on MIPS
Boston boards.

Applies atop v4.13-rc5, ideally after my "PCI: INTx interrupt fixes &
cleanup" series.

Paul Burton (3):
  PCI: xilinx: Unify INTx & MSI interrupt decode
  PCI: xilinx: Don't enable config completion interrupts
  PCI: xilinx: Allow build on MIPS platforms

 drivers/pci/host/Kconfig       |  2 +-
 drivers/pci/host/pcie-xilinx.c | 53 ++++++++++++++----------------------------
 2 files changed, 19 insertions(+), 36 deletions(-)

-- 
2.14.1
