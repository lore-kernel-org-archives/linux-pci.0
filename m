Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:56516
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756503AbcHZBtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Aug 2016 21:49:12 -0400
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v4 0/2] PCI: altera: Retrain link in rootport mode only
Date: Fri, 26 Aug 2016 09:47:23 +0800
Message-ID: <1472176045-27815-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Altera PCIe IP can be configured as rootport or device and they might have
same vendor ID. It will cause the system hang issue if Altera PCIe is in
endpoint mode and work with other PCIe rootport that from other vendors.

This series of patch rework configs accessors and move retrain function
from _FIXUP to altera_pcie_host_init().

History:
v2: change to check PCIe type is PCI_EXP_TYPE_ROOT_PORT
v3: Move retrain function to before pci_scan_root_bus and remove _FIXUP
v4: Split patch to 2 patches

Ley Foon Tan (2):
  PCI: altera: Rework configs accessors
  PCI: altera: Move retrain from _FIXUP to altera_pcie_host_init()

 drivers/pci/host/pcie-altera.c | 215 +++++++++++++++++++++++++----------------
 1 file changed, 132 insertions(+), 83 deletions(-)

-- 
1.8.2.1

