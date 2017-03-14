Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbdCNRrJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Mar 2017 13:47:09 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0527CC054904
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2017 17:47:09 +0000 (UTC)
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] pci: Add WARN_ON() for some pci= kernel parameters
Date: Tue, 14 Mar 2017 13:46:57 -0400
Message-Id: <1489513617-9833-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, sorry for not getting back to this.  I forgot about it and was
reminded of it in a bug where someone had disabled ACPI and was wondering
why their system wouldn't boot.

P.

---8<---

Many of the pci= kernel parameters are used to work around BIOS and
platform issues.  The result is a system which boots but the problem
never is reported back to the hardware vendors.

When these types of parameters are used the PCI subsystem must output a
loud warning so that the user will report the issue to the hardware
vendor.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 arch/x86/pci/common.c |   62 +++++++++++++++++++++++++++----------------------
 drivers/pci/pci.c     |   27 +++++++++++++++++++--
 2 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 190e718694b1..4ab9c8f161f4 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -533,106 +533,112 @@ char *__init pcibios_setup(char *str)
 {
 	if (!strcmp(str, "off")) {
 		pci_probe = 0;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "bfsort")) {
 		pci_bf_sort = pci_force_bf;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "nobfsort")) {
 		pci_bf_sort = pci_force_nobf;
-		return NULL;
+		goto out;
 	}
 #ifdef CONFIG_PCI_BIOS
 	else if (!strcmp(str, "bios")) {
 		pci_probe = PCI_PROBE_BIOS;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "nobios")) {
 		pci_probe &= ~PCI_PROBE_BIOS;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "biosirq")) {
 		pci_probe |= PCI_BIOS_IRQ_SCAN;
-		return NULL;
+		goto out;
 	} else if (!strncmp(str, "pirqaddr=", 9)) {
 		pirq_table_addr = simple_strtoul(str+9, NULL, 0);
-		return NULL;
+		goto out;
 	}
 #endif
 #ifdef CONFIG_PCI_DIRECT
 	else if (!strcmp(str, "conf1")) {
 		pci_probe = PCI_PROBE_CONF1 | PCI_NO_CHECKS;
-		return NULL;
+		goto out;
 	}
 	else if (!strcmp(str, "conf2")) {
 		pci_probe = PCI_PROBE_CONF2 | PCI_NO_CHECKS;
-		return NULL;
+		goto out;
 	}
 #endif
 #ifdef CONFIG_PCI_MMCONFIG
 	else if (!strcmp(str, "nommconf")) {
 		pci_probe &= ~PCI_PROBE_MMCONF;
-		return NULL;
+		goto out;
 	}
 	else if (!strcmp(str, "check_enable_amd_mmconf")) {
 		pci_probe |= PCI_CHECK_ENABLE_AMD_MMCONF;
-		return NULL;
+		goto out;
 	}
 #endif
 	else if (!strcmp(str, "noacpi")) {
 		acpi_noirq_set();
-		return NULL;
+		goto out;
 	}
 	else if (!strcmp(str, "noearly")) {
 		pci_probe |= PCI_PROBE_NOEARLY;
-		return NULL;
+		goto out;
 	}
 	else if (!strcmp(str, "usepirqmask")) {
 		pci_probe |= PCI_USE_PIRQ_MASK;
-		return NULL;
+		goto out;
 	} else if (!strncmp(str, "irqmask=", 8)) {
 		pcibios_irq_mask = simple_strtol(str+8, NULL, 0);
-		return NULL;
+		goto out;
 	} else if (!strncmp(str, "lastbus=", 8)) {
 		pcibios_last_bus = simple_strtol(str+8, NULL, 0);
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "rom")) {
 		pci_probe |= PCI_ASSIGN_ROMS;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "norom")) {
 		pci_probe |= PCI_NOASSIGN_ROMS;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "nobar")) {
 		pci_probe |= PCI_NOASSIGN_BARS;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "assign-busses")) {
 		pci_probe |= PCI_ASSIGN_ALL_BUSSES;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "use_crs")) {
 		pci_probe |= PCI_USE__CRS;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "nocrs")) {
 		pci_probe |= PCI_ROOT_NO_CRS;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "earlydump")) {
 		pci_early_dump_regs = 1;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "routeirq")) {
 		pci_routeirq = 1;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "skip_isa_align")) {
 		pci_probe |= PCI_CAN_SKIP_ISA_ALIGN;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "noioapicquirk")) {
 		noioapicquirk = 1;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "ioapicreroute")) {
 		if (noioapicreroute != -1)
 			noioapicreroute = 0;
-		return NULL;
+		goto out;
 	} else if (!strcmp(str, "noioapicreroute")) {
 		if (noioapicreroute != -1)
 			noioapicreroute = 1;
-		return NULL;
+		goto out;
 	}
 	return str;
+
+out:
+	WARN(1,
+	     "PCI: pcibios pci=%s option used.  This implies a workaround for a BIOS or hardware issue.  Please send this report to your Hardware Vendor.",
+	     str);
+	return NULL;
 }
 
 unsigned int pcibios_assign_all_busses(void)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02ffdb9..a17a62c6908f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5254,6 +5254,18 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
 
 static int __init pci_setup(char *str)
 {
+	/*
+	 * When adding additional pci= parameters the value of warn must be
+	 * considered and set appropriately.  Setting warn to 1 indicates that
+	 * the usage of the specific parameter is being used to work around a
+	 * platform design or BIOS issue and the resulting warning can be used
+	 * to file a report with the hardware vendor.  If a parameter is used
+	 * to change the existing default in Linux (hotplug windows, Max
+	 * Payload Size settings for better performance, etc.) the parameter
+	 * should NOT set warn to 1 as they are valid runtime settings.
+	 */
+	int warn = 0;
+
 	while (str) {
 		char *k = strchr(str, ',');
 		if (k)
@@ -5261,16 +5273,22 @@ static int __init pci_setup(char *str)
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
+				warn = 1;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+				warn = 1;
 			} else if (!strncmp(str, "realloc=", 8)) {
 				pci_realloc_get_opt(str + 8);
+				warn = 1;
 			} else if (!strncmp(str, "realloc", 7)) {
 				pci_realloc_get_opt("on");
+				warn = 1;
 			} else if (!strcmp(str, "nodomains")) {
 				pci_no_domains();
+				warn = 1;
 			} else if (!strncmp(str, "noari", 5)) {
 				pcie_ari_disabled = true;
+				warn = 1;
 			} else if (!strncmp(str, "cbiosize=", 9)) {
 				pci_cardbus_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
@@ -5278,8 +5296,10 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "resource_alignment=", 19)) {
 				pci_set_resource_alignment_param(str + 19,
 							strlen(str + 19));
+				warn = 1;
 			} else if (!strncmp(str, "ecrc=", 5)) {
 				pcie_ecrc_get_policy(str + 5);
+				warn = 1;
 			} else if (!strncmp(str, "hpiosize=", 9)) {
 				pci_hotplug_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
@@ -5299,10 +5319,13 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
+				warn = 1;
 			} else {
-				printk(KERN_ERR "PCI: Unknown option `%s'\n",
-						str);
+				WARN(1, "PCI: Unknown option `%s'\n", str);
 			}
+			WARN(warn,
+			     "PCI: pci=%s option used.  This implies a workaround for a BIOS or hardware issue.  Please send this report to your Hardware Vendor.",
+			     str);
 		}
 		str = k;
 	}
-- 
1.7.9.3
