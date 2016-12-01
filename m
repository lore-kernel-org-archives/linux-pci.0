Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754525AbcLAIjG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 03:39:06 -0500
Subject: [PATCH v10 02/12] PCI: Search ACPI namespace to ensure ECAM space
 is reserved
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Thu, 01 Dec 2016 02:29:39 -0600
Message-ID: <20161201082939.12247.55077.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The static MCFG table tells us the base of ECAM space, but it does not
reserve the space -- the reservation should be done via a device in the
ACPI namespace whose _CRS includes the ECAM region.

Add pci_ecam_verify_reservation() to check whether the ECAM space is
reserved by an ACPI namespace device.  If it is, emit a message showing
which device reserves it.  If not, emit a "[Firmware Bug]" warning.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ecam.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 43ed08d..3805122 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -14,6 +14,7 @@
  * version 2 (GPLv2) along with this source code.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -29,6 +30,24 @@
  */
 static const bool per_bus_mapping = !IS_ENABLED(CONFIG_64BIT);
 
+static void pci_ecam_verify_reservation(struct device *dev,
+					struct resource *ecam)
+{
+#ifdef CONFIG_ACPI
+	struct acpi_device *adev;
+
+	adev = acpi_resource_consumer(ecam);
+	if (!adev) {
+		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
+			 ecam);
+		return;
+	}
+
+	dev_info(dev, "ECAM area %pR reserved by %s\n", ecam,
+		 dev_name(&adev->dev));
+#endif
+}
+
 /*
  * Create a PCI config space window
  *  - reserve mem region
@@ -51,6 +70,8 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	if (!cfg)
 		return ERR_PTR(-ENOMEM);
 
+	pci_ecam_verify_reservation(dev, cfgres);
+
 	cfg->parent = dev;
 	cfg->ops = ops;
 	cfg->busr.start = busr->start;

