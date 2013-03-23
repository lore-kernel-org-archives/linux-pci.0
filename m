Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59528 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab3CWEGw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Mar 2013 00:06:52 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Andrew Murray' <andrew.murray@arm.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
In-reply-to: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
Subject: [PATCH 3/6] pci: infrastructure to add drivers in drivers/pci/host
Date: Sat, 23 Mar 2013 13:06:50 +0900
Message-id: <00c201ce277b$d88be2f0$89a3a8d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

As agreed by the community, PCI host drivers will now be stored in
drivers/pci/host. This commit adds this directory and the related
Kconfig/Makefile changes to allow new drivers to be added in this
directory.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/Kconfig      |    2 ++
 drivers/pci/Makefile     |    3 +++
 drivers/pci/host/Kconfig |    4 ++++
 3 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pci/host/Kconfig

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 6d51aa6..ac45398 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -119,3 +119,5 @@ config PCI_IOAPIC
 config PCI_LABEL
 	def_bool y if (DMI || ACPI)
 	select NLS
+
+source "drivers/pci/host/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 0c3efcf..6ebf5bf 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -67,3 +67,6 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_OF) += of.o
 
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
+
+# PCI host controller drivers
+obj-y += host/
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
new file mode 100644
index 0000000..cc3a1af
--- /dev/null
+++ b/drivers/pci/host/Kconfig
@@ -0,0 +1,4 @@
+menu "PCI host controller drivers"
+	depends on PCI
+
+endmenu
-- 
1.7.2.5


