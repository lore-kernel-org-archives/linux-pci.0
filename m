Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53004 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934864Ab3DIVG6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 17:06:58 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [PATCHv8 06/19] pci: infrastructure to add drivers in drivers/pci/host
Date: Tue,  9 Apr 2013 23:06:27 +0200
Message-Id: <1365541601-14095-7-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As agreed by the community, PCI host drivers will now be stored in
drivers/pci/host. This commit adds this directory and the related
Kconfig/Makefile changes to allow new drivers to be added in this
directory.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/Kconfig       |    2 ++
 drivers/pci/Makefile      |    3 +++
 drivers/pci/host/Kconfig  |    4 ++++
 drivers/pci/host/Makefile |    1 +
 4 files changed, 10 insertions(+)
 create mode 100644 drivers/pci/host/Kconfig
 create mode 100644 drivers/pci/host/Makefile

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
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
new file mode 100644
index 0000000..636bc1a
--- /dev/null
+++ b/drivers/pci/host/Makefile
@@ -0,0 +1 @@
+# intentionally empty
-- 
1.7.9.5

