Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:43048 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbdJ3MnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 08:43:22 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] PCI: dwc: artpec6: Remove unused defines
Date: Mon, 30 Oct 2017 13:42:13 +0100
Message-Id: <20171030124221.20690-11-niklas.cassel@axis.com>
In-Reply-To: <20171030124221.20690-1-niklas.cassel@axis.com>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit b015b37e6693 ("PCI: artpec6: Stop enabling writes to
DBI read-only registers") removed the only write using these
defines, but it did not remove the defines.
Remove the defines since they are now unused.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
V2:
* Changed commit message to include correct prefix.

 drivers/pci/dwc/pcie-artpec6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 6653619db6a1..4b8ef266dc2f 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -37,9 +37,6 @@ struct artpec6_pcie {
 #define PCIE_PHY_DEBUG_R0		(PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1		(PL_OFFSET + 0x2c)
 
-#define MISC_CONTROL_1_OFF		(PL_OFFSET + 0x1bc)
-#define  DBI_RO_WR_EN			1
-
 /* ARTPEC-6 specific registers */
 #define PCIECFG				0x18
 #define  PCIECFG_DBG_OEN		(1 << 24)
-- 
2.14.2
