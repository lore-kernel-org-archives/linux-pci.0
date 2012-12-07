Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH 13/15] PCI/ACPI: Convert "pci_slot" sub-driver's functionality
	to built-in only
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Dec 2012 23:26:11 -0700
Message-ID: <20121207062611.11051.39999.stgit@amt.stowe>
In-Reply-To: <20121207062454.11051.12739.stgit@amt.stowe>
References: <20121207062454.11051.12739.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The "ACPI PCI Slot Detection ("pci_slot")" sub-driver may be compiled as a
module.  Kernel modules are instantiated somewhat randomly - the order in
which they are linked as the kernel as built - thus if there are any
dependencies on the ordering of attaching sub-drivers, they can not be
effectively dealt with.

This patch series resolves any potential sequencing inter-dependencies by
converting "pci_slot" sub-driver's functionality to being only supported
as statically built-in to the kernel.  Inter-dependencies can then be
effectively handled by explicitly sequencing the addition of such
functionality.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 drivers/acpi/Kconfig |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 119d58d..988bb13 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -293,7 +293,7 @@ config ACPI_DEBUG_FUNC_TRACE
 	  is about half of the penalty and is rarely useful.
 
 config ACPI_PCI_SLOT
-	tristate "PCI slot detection driver"
+	bool "PCI slot detection driver"
 	depends on SYSFS
 	default n
 	help
@@ -302,9 +302,6 @@ config ACPI_PCI_SLOT
 	  i.e., segment/bus/device/function tuples, with physical slots in
 	  the system.  If you are unsure, say N.
 
-	  To compile this driver as a module, choose M here:
-	  the module will be called pci_slot.
-
 config X86_PM_TIMER
 	bool "Power Management Timer Support" if EXPERT
 	depends on X86

