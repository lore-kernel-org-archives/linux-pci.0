Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeG3PS3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 11:18:29 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH 2/3] PCI: mobiveil: Add missing ../pci.h include
Date: Mon, 30 Jul 2018 14:43:15 +0100
Message-Id: <20180730134316.11719-3-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
References: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI mobiveil host controller driver currently fails to compile
with the following error:

drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_probe':
drivers/pci/controller/pcie-mobiveil.c:788:8: error: implicit
declaration of function 'devm_of_pci_get_host_bridge_resources'; did you
mean 'pci_get_host_bridge_device'?
[-Werror=implicit-function-declaration]
  ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        pci_get_host_bridge_device

Add the missing include file to pull in the required function declaration.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
driver")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
 drivers/pci/controller/pcie-mobiveil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 8b45f77d70f9..a939e8d31735 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -23,6 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 /* register offsets and bit positions */
 
 /*
-- 
2.15.0
