Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49854 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBWM3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 07:29:53 -0500
From: Colin King <colin.king@canonical.com>
To: Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: rcar-gen2: remove duplicated bit-wise or of RCAR_PCI_INT_SIGRETABORT
Date: Fri, 23 Feb 2018 12:29:49 +0000
Message-Id: <20180223122949.24291-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Bit pattern RCAR_PCI_INT_SIGRETABORT is being bit-wise or'd twice;
remove the redundant 2nd RCAR_PCI_INT_SIGRETABORT.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/host/pci-rcar-gen2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index a28370bb2b2a..dd4f1a6b57c5 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -52,7 +52,6 @@
 #define RCAR_PCI_INT_B			(1 << 17)
 #define RCAR_PCI_INT_PME		(1 << 19)
 #define RCAR_PCI_INT_ALLERRORS (RCAR_PCI_INT_SIGTABORT		| \
-				RCAR_PCI_INT_SIGRETABORT	| \
 				RCAR_PCI_INT_SIGRETABORT	| \
 				RCAR_PCI_INT_REMABORT		| \
 				RCAR_PCI_INT_PERR		| \
-- 
2.15.1
