Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 05/34] arm/PCI: use pci_flags PCI_PROBE_ONLY instead of
	arm-specific flag
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Date: Wed, 07 Mar 2012 15:32:29 -0700
Message-ID: <20120307223229.25669.55000.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index d13b6c2..a28c78e 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -16,7 +16,6 @@
 #include <asm/mach/pci.h>
 
 static int debug_pci;
-static int use_firmware;
 
 /*
  * We can't use pci_find_device() here since we are
@@ -537,7 +536,7 @@ void __init pci_common_init(struct hw_pci *hw)
 	list_for_each_entry(sys, &hw->buses, node) {
 		struct pci_bus *bus = sys->bus;
 
-		if (!use_firmware) {
+		if (!pci_has_flag(PCI_PROBE_ONLY)) {
 			/*
 			 * Size the bridge windows.
 			 */
@@ -574,7 +573,7 @@ char * __init pcibios_setup(char *str)
 		debug_pci = 1;
 		return NULL;
 	} else if (!strcmp(str, "firmware")) {
-		use_firmware = 1;
+		pci_add_flags(PCI_PROBE_ONLY);
 		return NULL;
 	}
 	return str;

