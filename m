Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58228 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059Ab3A1S44 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:56:56 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 09/27] pci: infrastructure to add drivers in drivers/pci/host
Date: Mon, 28 Jan 2013 19:56:18 +0100
Message-Id: <1359399397-29729-10-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
index 6ed3db1..45392ab 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -125,3 +125,5 @@ config PCI_SW_HOST_BRIDGE
 
 config PCI_SW_PCI_PCI_BRIDGE
 	bool
+
+source "drivers/pci/host/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 5b48961..eae4db1 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -71,3 +71,6 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
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

