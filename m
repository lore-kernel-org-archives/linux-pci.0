Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40761 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751640AbcJGUah (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2016 16:30:37 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/2] MAINTAINERS: add maintainer for the PCIe Marvell Armada 8K driver
Date: Fri,  7 Oct 2016 22:30:30 +0200
Message-Id: <1475872231-3199-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f593300..8f6fb8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8965,6 +8965,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/versatile.txt
 F:	drivers/pci/host/pci-versatile.c
 
+PCI DRIVER FOR ARMADA 8K
+M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
+F:	drivers/pci/host/pcie-armada8k.c
+
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Tanmay Inamdar <tinamdar@apm.com>
 L:	linux-pci@vger.kernel.org
-- 
2.7.4

