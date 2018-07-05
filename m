Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:46368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753616AbeGEJp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2018 05:45:59 -0400
Date: Thu, 5 Jul 2018 12:45:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: mobiveil: integer overflow in IB_WIN_SIZE
Message-ID: <20180705094539.xkmtfffbzl3kooum@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

IB_WIN_SIZE is larger than INT_MAX so we need to cast it to u64.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Untested...  Possibly the problem is that there are too many multiplies
by * 1024.

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 4d6c20e47bed..cf0aa7cee5b0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -107,7 +107,7 @@
 #define CFG_WINDOW_TYPE	0
 #define IO_WINDOW_TYPE		1
 #define MEM_WINDOW_TYPE	2
-#define IB_WIN_SIZE		(256 * 1024 * 1024 * 1024)
+#define IB_WIN_SIZE		((u64)256 * 1024 * 1024 * 1024)
 #define MAX_PIO_WINDOWS	8
 
 /* Parameters for the waiting for link up routine */
