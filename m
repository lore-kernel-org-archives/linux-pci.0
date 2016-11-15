Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:57161 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbcKOQK5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2016 11:10:57 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com
Cc: pratyush.anand@gmail.com, CARLOS.PALMINHA@synopsys.com,
        Jose.Abreu@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 1/2] pci: pcie-designware: Change Maintenance
Date: Tue, 15 Nov 2016 16:10:46 +0000
Message-Id: <c4b8fcc50069ce8ea2091100e52a68dcc30e1021.1479224720.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I accepted the invitation from Pratyush to replace him in the
pcie-designware maintenance. This patch makes the maintainer replacement
and symplifies a bit the pcie-designware* maintenance structure.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>
---
 MAINTAINERS | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa6bf..2c64d7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9293,17 +9293,11 @@ F:	drivers/pci/host/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSIS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
-M:	Pratyush Anand <pratyush.anand@gmail.com>
-L:	linux-pci@vger.kernel.org
-S:	Maintained
-F:	drivers/pci/host/*designware*
-
-PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
-M:	Jose Abreu <Jose.Abreu@synopsys.com>
+M:	Joao Pinto <Joao.Pinto@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
-F:	drivers/pci/host/pcie-designware-plat.c
+F:	drivers/pci/host/*designware*
 
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will.deacon@arm.com>
-- 
1.8.3.1


