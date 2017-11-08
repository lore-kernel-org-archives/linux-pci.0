Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbdKHUPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Nov 2017 15:15:13 -0500
Subject: [PATCH] MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge
 drivers
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 08 Nov 2017 14:15:10 -0600
Message-ID: <20171108201510.18601.30578.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Add Lorenzo Pieralisi as maintainer for PCI native host bridge drivers and
the endpoint driver framework.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index db412a627d96..a1f9653234cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10429,6 +10429,16 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+L:	linux-pci@vger.kernel.org
+Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
+S:	Supported
+F:	drivers/pci/host/
+F:	drivers/pci/dwc/
+F:	drivers/pci/endpoint
+
 PCIE DRIVER FOR AXIS ARTPEC
 M:	Niklas Cassel <niklas.cassel@axis.com>
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
