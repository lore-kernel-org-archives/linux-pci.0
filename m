Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 0/4] Various R-Car PCIe patches
Date: Thu, 17 Dec 2015 13:22:33 +0000
Message-Id: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The first patch removes code that is no longer used. The next two allow us to
use runtim PM. The last patch is for PHY setup in order to get PCIe compliance
apparently. For that last patch, I've been told that this is what I must set.

Phil Edworthy (4):
  PCI: rcar: remove unused pci_sys_data structure in pcie-rcar
  PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
  PCI: rcar: Add runtime PM support to pcie-rcar
  PCI: rcar: Add Gen2 PHY setup to pcie-rcar

 drivers/pci/host/pcie-rcar.c | 105 +++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 24 deletions(-)

-- 
2.5.0

