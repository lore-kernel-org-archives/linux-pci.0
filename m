Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40765 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753254AbcJGUai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2016 16:30:38 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/2] MAINTAINERS: add DT binding doc to the Aardvark PCIE driver maintainer
Date: Fri,  7 Oct 2016 22:30:31 +0200
Message-Id: <1475872231-3199-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1475872231-3199-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1475872231-3199-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f6fb8c..c0ac3dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9019,6 +9019,7 @@ M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
 F:	drivers/pci/host/pci-aardvark.c
 
 PCI DRIVER FOR NVIDIA TEGRA
-- 
2.7.4

