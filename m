Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:63468 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbaF0O7D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jun 2014 10:59:03 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so3031445lab.37
        for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2014 07:59:01 -0700 (PDT)
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH] pcie-rcar: kill duplicate checks
Date: Fri, 27 Jun 2014 18:59:13 +0400
Cc: phil.edworthy@renesas.com
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201406271859.13626.sergei.shtylyov@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI core will have already checked the configuration register address before
calling the {read|write}() methods, no need to check it again in these methods.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo.

 drivers/pci/host/pcie-rcar.c |   10 ----------
 1 file changed, 10 deletions(-)

Index: pci/drivers/pci/host/pcie-rcar.c
===================================================================
--- pci.orig/drivers/pci/host/pcie-rcar.c
+++ pci/drivers/pci/host/pcie-rcar.c
@@ -260,11 +260,6 @@ static int rcar_pcie_read_conf(struct pc
 	struct rcar_pcie *pcie = sys_to_pcie(bus->sysdata);
 	int ret;
 
-	if ((size == 2) && (where & 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	else if ((size == 4) && (where & 3))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
 	ret = rcar_pcie_config_access(pcie, PCI_ACCESS_READ,
 				      bus, devfn, where, val);
 	if (ret != PCIBIOS_SUCCESSFUL) {
@@ -291,11 +286,6 @@ static int rcar_pcie_write_conf(struct p
 	int shift, ret;
 	u32 data;
 
-	if ((size == 2) && (where & 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	else if ((size == 4) && (where & 3))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
 	ret = rcar_pcie_config_access(pcie, PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
 	if (ret != PCIBIOS_SUCCESSFUL)
