Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36162 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaKFFhx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Nov 2014 00:37:53 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEL008SORMWTUD0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 06 Nov 2014 14:37:45 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: spear: Add __init annotation to spear13xx_add_pcie_port()
Date: Thu, 06 Nov 2014 14:38:18 +0900
Message-id: <001f01cff983$deb4da20$9c1e8e60$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add __init annotation to spear13xx_add_pcie_port(), because
the spear13xx_add_pcie_port() is called only by spear13xx_pcie_probe()
that was already marked as __init. Also, this patch fixes
section mismatch warning.

WARNING: drivers/pci/host/built-in.o(.text.unlikely+0x94): Section mismatch in reference from the function spear13xx_add_pcie_port()
to the function .init.text:dw_pcie_host_init()
The function spear13xx_add_pcie_port() references
the function __init dw_pcie_host_init().
This is often because spear13xx_add_pcie_port lacks a __init
annotation or the annotation of dw_pcie_host_init is wrong.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
This patch is based on the submitted patch "[PATCH V2] PCI:
spear: Add spear13xx before add_pcie_port/pcie_initt".

 drivers/pci/host/pcie-spear13xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 63f869f..60f43cd 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -269,8 +269,8 @@ static struct pcie_host_ops spear13xx_pcie_host_ops = {
 	.host_init = spear13xx_pcie_host_init,
 };
 
-static int spear13xx_add_pcie_port(struct pcie_port *pp,
-				   struct platform_device *pdev)
+static int __init spear13xx_add_pcie_port(struct pcie_port *pp,
+					 struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int ret;
-- 
1.7.9.5


