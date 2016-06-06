Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17346 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbcFFNGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 09:06:35 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/4] PCI / DPC: Few improvements
Date: Mon,  6 Jun 2016 16:06:04 +0300
Message-Id: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This series includes few improvements for the PCIe DPC driver. First we
introduce module_pci_port_service() which allows reducing of boilerblate
code used in the DPC driver. In addition we convert the driver to use
managed resource functions (devm) to get rid of even more boilerblate.

I do not have hardware supporting DPC so these are only compile tested.

Mika Westerberg (4):
  PCI / PCIe: Introduce module_pci_port_service()
  PCI / DPC: Convert to use module_pcie_port_service()
  PCI / DPC: Convert the driver to use devm_* functions
  PCI / DPC: Fix whitespace in struct dpc_dev

 drivers/pci/pcie/pcie-dpc.c | 30 +++++++-----------------------
 include/linux/pcieport_if.h | 13 +++++++++++++
 2 files changed, 20 insertions(+), 23 deletions(-)

-- 
2.8.1

