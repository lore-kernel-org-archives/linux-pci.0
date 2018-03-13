Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 1/2] PCI: Tidy Makefiles
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 17:35:30 -0500
Message-ID: <152098053022.43178.8975082302619060013.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152098048688.43178.2089454526004328425.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152098048688.43178.2089454526004328425.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Indent things so they line up neatly and remove extra blank lines and
superfluous comments.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/Makefile      |   69 ++++++++++++++++-----------------------------
 drivers/pci/pcie/Makefile |   16 +++-------
 2 files changed, 29 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 941970936840..952addc7bacf 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -1,61 +1,40 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the PCI bus specific drivers.
-#
 
-obj-$(CONFIG_PCI)	+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
-			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o setup-bus.o vc.o mmap.o setup-irq.o
+obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
+				   remove.o pci.o pci-driver.o search.o \
+				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
+				   setup-bus.o vc.o mmap.o setup-irq.o
 
 ifdef CONFIG_PCI
-obj-$(CONFIG_PROC_FS) += proc.o
-obj-$(CONFIG_SYSFS) += slot.o
-obj-$(CONFIG_OF) += of.o
+obj-$(CONFIG_PROC_FS)		+= proc.o
+obj-$(CONFIG_SYSFS)		+= slot.o
+obj-$(CONFIG_OF)		+= of.o
 endif
 
-obj-$(CONFIG_PCI_QUIRKS) += quirks.o
-
-# Build PCI Express stuff if needed
-obj-$(CONFIG_PCIEPORTBUS) += pcie/
-
-# Build the PCI Hotplug drivers if we were asked to
-obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
-
-# Build the PCI MSI interrupt support
-obj-$(CONFIG_PCI_MSI) += msi.o
-
-obj-$(CONFIG_PCI_ATS) += ats.o
-obj-$(CONFIG_PCI_IOV) += iov.o
-
-#
-# ACPI Related PCI FW Functions
-# ACPI _DSM provided firmware instance and string name
-#
-obj-$(CONFIG_ACPI)    += pci-acpi.o
-
-# SMBIOS provided firmware instance and labels
-obj-$(CONFIG_PCI_LABEL) += pci-label.o
-
-# Intel MID platform PM support
-obj-$(CONFIG_X86_INTEL_MID) += pci-mid.o
-
-obj-$(CONFIG_PCI_SYSCALL) += syscall.o
-
-obj-$(CONFIG_PCI_STUB) += pci-stub.o
-
-obj-$(CONFIG_PCI_ECAM) += ecam.o
-
+obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
+obj-$(CONFIG_PCIEPORTBUS)	+= pcie/
+obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
+obj-$(CONFIG_PCI_MSI)		+= msi.o
+obj-$(CONFIG_PCI_ATS)		+= ats.o
+obj-$(CONFIG_PCI_IOV)		+= iov.o
+obj-$(CONFIG_ACPI)		+= pci-acpi.o
+obj-$(CONFIG_PCI_LABEL)		+= pci-label.o
+obj-$(CONFIG_X86_INTEL_MID)	+= pci-mid.o
+obj-$(CONFIG_PCI_SYSCALL)	+= syscall.o
+obj-$(CONFIG_PCI_STUB)		+= pci-stub.o
+obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
-
-# PCI host controller drivers
-obj-y += host/
-obj-y += switch/
+obj-y				+= host/
+obj-y				+= switch/
 
+# Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
-# Endpoint library must be initialized before its users
 obj-$(CONFIG_PCIE_CADENCE)	+= cadence/
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
+
+ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 223e4c34c29a..7d1648bd0766 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -1,20 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for PCI-Express PORT Driver
-#
-
-# Build PCI Express ASPM if needed
-obj-$(CONFIG_PCIEASPM)		+= aspm.o
+# Makefile for PCI Express features and port driver
 
 pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
 pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
-# Build PCI Express AER if needed
+obj-$(CONFIG_PCIEASPM)		+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer/
-
-obj-$(CONFIG_PCIE_PME) += pme.o
-
-obj-$(CONFIG_PCIE_DPC) += pcie-dpc.o
-obj-$(CONFIG_PCIE_PTM) += ptm.o
+obj-$(CONFIG_PCIE_PME)		+= pme.o
+obj-$(CONFIG_PCIE_DPC)		+= pcie-dpc.o
+obj-$(CONFIG_PCIE_PTM)		+= ptm.o
