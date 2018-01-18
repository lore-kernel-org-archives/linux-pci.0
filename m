Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v4 1/7] PCI: Regroup all PCI related entries into drivers/pci/Makefile
Date: Thu, 18 Jan 2018 23:52:46 +0100
Message-Id: <c7603864a0a3618fdafddb9f42a11e0bf774c94f.1516314953.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
References: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
References: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Clean up drivers/Makefile by moving the pci/endpoint and pci/dwc entries
from drivers/Makefile into drivers/pci/Makefile.

Since we don't want to introduce any dependency between CONFIG_PCI and
CONFIG_PCI_ENDPOINT, we now always execute drivers/pci/Makefile.

Hence all Makefiles in drivers/pci/ were updated accordingly so no file is
compiled when CONFIG_PCI is not defined.

Also, we add a comment to reinforce that EPC and EPF libraries must be
initialized before their users. Hence built-in EPC drivers, such as
those of Designware, are linked after the endpoint core libraries.

Finally, we add another comment to explain why obj-y has been chosen
instead of obj-$(CONFIG_PCIE_DW) to parse the dwc/ sub-folder.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/Makefile          |  5 +----
 drivers/pci/Kconfig       |  1 +
 drivers/pci/Makefile      | 13 ++++++++++---
 drivers/pci/dwc/Makefile  |  2 ++
 drivers/pci/host/Makefile |  2 ++
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index e06f7f633f73..8189b1edec00 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -16,10 +16,7 @@ obj-$(CONFIG_PINCTRL)		+= pinctrl/
 obj-$(CONFIG_GPIOLIB)		+= gpio/
 obj-y				+= pwm/
 
-obj-$(CONFIG_PCI)		+= pci/
-obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
-# PCI dwc controller drivers
-obj-y				+= pci/dwc/
+obj-y				+= pci/
 
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-$(CONFIG_RAPIDIO)		+= rapidio/
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index bda151788f3f..7eeb969ab86a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -125,6 +125,7 @@ config PCI_PASID
 
 config PCI_LABEL
 	def_bool y if (DMI || ACPI)
+	depends on PCI
 	select NLS
 
 config PCI_HYPERV
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index c7819b973df7..ddb5aa6640d7 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -3,12 +3,15 @@
 # Makefile for the PCI bus specific drivers.
 #
 
-obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
+obj-$(CONFIG_PCI)	+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
 			irq.o vpd.o setup-bus.o vc.o mmap.o setup-irq.o
 
+ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSFS) += slot.o
+obj-$(CONFIG_OF) += of.o
+endif
 
 obj-$(CONFIG_PCI_QUIRKS) += quirks.o
 
@@ -44,10 +47,14 @@ obj-$(CONFIG_PCI_ECAM) += ecam.o
 
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
-obj-$(CONFIG_OF) += of.o
-
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
 
 # PCI host controller drivers
 obj-y += host/
 obj-y += switch/
+
+obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
+
+# Endpoint library must be initialized before its users
+# pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
+obj-y				+= dwc/
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
index a9d8a6fb48e3..5d2ce72c7a52 100644
--- a/drivers/pci/dwc/Makefile
+++ b/drivers/pci/dwc/Makefile
@@ -25,4 +25,6 @@ obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 # ARM64 and use internal ifdefs to only build the pieces we need
 # depending on whether ACPI, the DT driver, or both are enabled.
 
+ifdef CONFIG_PCI
 obj-$(CONFIG_ARM64) += pcie-hisi.o
+endif
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 34ec1d88f961..3b1059190867 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -34,6 +34,8 @@ obj-$(CONFIG_VMD) += vmd.o
 # ARM64 and use internal ifdefs to only build the pieces we need
 # depending on whether ACPI, the DT driver, or both are enabled.
 
+ifdef CONFIG_PCI
 obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
 obj-$(CONFIG_ARM64) += pci-thunder-pem.o
 obj-$(CONFIG_ARM64) += pci-xgene.o
+endif
-- 
2.11.0
