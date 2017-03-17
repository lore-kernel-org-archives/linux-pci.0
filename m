Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.206]:39493 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751037AbdCQOxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2017 10:53:25 -0400
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jayachandran C <jchandra@broadcom.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH] PCI: Pull struct pci_ops definition
Message-ID: <13b87220-8aab-3a80-1d74-8e31d2d59e20@sigmadesigns.com>
Date: Fri, 17 Mar 2017 15:53:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

struct pci_ecam_ops embeds a struct pci_ops. Explicitly request the
definition for struct pci_ops, otherwise gcc might complain:

include/linux/pci-ecam.h:29:19: error: field 'pci_ops' has incomplete type

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 include/linux/pci-ecam.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 7adad206b1f4..33c4750781a0 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -16,6 +16,7 @@
 #ifndef DRIVERS_PCI_ECAM_H
 #define DRIVERS_PCI_ECAM_H
 
+#include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
-- 
2.10.0
