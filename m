Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16343 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaKFFhI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Nov 2014 00:37:08 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEL0060YRLTXH80@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 06 Nov 2014 14:37:05 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: dra7xx: Add __init annotation to dra7xx_add_pcie_port()
Date: Thu, 06 Nov 2014 14:37:39 +0900
Message-id: <001e01cff983$c76f0ed0$564d2c70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add __init annotation to dra7xx_add_pcie_port(), because
the dra7xx_add_pcie_port() is called only by dra7xx_pcie_probe()
that was already marked as __init. Also, this patch fixes
section mismatch warning.

WARNING: drivers/pci/host/built-in.o(.text.unlikely+0xcc): Section mismatch in reference from the function dra7xx_add_pcie_port() to
the function .init.text:dw_pcie_host_init()
The function dra7xx_add_pcie_port() references
the function __init dw_pcie_host_init().
This is often because dra7xx_add_pcie_port lacks a __init
annotation or the annotation of dw_pcie_host_init is wrong.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
This patch is based on the submitted patch "[PATCH V2] PCI:
dra7xx: Add dra7xx prefix before add_pcie_port".

 drivers/pci/host/pci-dra7xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 5b4a644..8c69697 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -270,8 +270,8 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
-				struct platform_device *pdev)
+static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
+				       struct platform_device *pdev)
 {
 	int ret;
 	struct pcie_port *pp;
-- 
1.7.9.5


