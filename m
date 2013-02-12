Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45925 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933371Ab3BLQ3p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:45 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: [PATCH 23/32] pci: infrastructure to add drivers in drivers/pci/host
Date: Tue, 12 Feb 2013 17:28:57 +0100
Message-Id: <1360686546-24277-24-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As agreed by the community, PCI host drivers will now be stored in
drivers/pci/host. This commit adds this directory and the related
Kconfig/Makefile changes to allow new drivers to be added in this
directory.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/Kconfig      |    2 ++
 drivers/pci/Makefile     |    3 +++
 drivers/pci/host/Kconfig |    4 ++++
 3 files changed, 9 insertions(+)
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
1.7.9.5

