Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeDCQ4O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Apr 2018 12:56:14 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Add missing /drivers/pci/cadence directory entry
Date: Tue,  3 Apr 2018 17:56:05 +0100
Message-Id: <20180403165605.26035-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for
Cadence PCIe controller") created the /drivers/pci/cadence directory to
keep in a single place Cadence host and endpoint controller drivers.

Since code in /drivers/pci/cadence falls within the PCI native host
bridge and endpoint controllers mainteinance remit, that maintainer
entry should have been updated too by adding the /drivers/pci/cadence
directory to it but it actually was not.

Update the MAINTAINERS entry accordingly, fixing the omission.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Alan Douglas <adouglas@cadence.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..969426969438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10722,6 +10722,7 @@ L:	linux-pci@vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
 S:	Supported
+F:	drivers/pci/cadence/
 F:	drivers/pci/host/
 F:	drivers/pci/dwc/
 
-- 
2.15.0
