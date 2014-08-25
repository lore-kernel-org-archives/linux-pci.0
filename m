Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:60186 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbaHYV1J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 17:27:09 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so3191807wiw.12
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2014 14:27:08 -0700 (PDT)
From: Mathias Krause <minipli@googlemail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 1/5] x86/PCI: Mark DMI tables as initialization data
Date: Mon, 25 Aug 2014 23:26:35 +0200
Message-Id: <1409001999-23161-2-git-send-email-minipli@googlemail.com>
In-Reply-To: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
References: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The DMI tables are only used in __init code, thereby can be marked as
initialization data, too. The same is true for the callback functions
referenced from the DMI tables.

This moves ~9.6 kB of code and r/o data to the init sections, marking
the memory for release after initialization.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/x86/pci/common.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 059a76c297..7b20bccf36 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -81,14 +81,14 @@ struct pci_ops pci_root_ops = {
  */
 DEFINE_RAW_SPINLOCK(pci_config_lock);
 
-static int can_skip_ioresource_align(const struct dmi_system_id *d)
+static int __init can_skip_ioresource_align(const struct dmi_system_id *d)
 {
 	pci_probe |= PCI_CAN_SKIP_ISA_ALIGN;
 	printk(KERN_INFO "PCI: %s detected, can skip ISA alignment\n", d->ident);
 	return 0;
 }
 
-static const struct dmi_system_id can_skip_pciprobe_dmi_table[] = {
+static const struct dmi_system_id can_skip_pciprobe_dmi_table[] __initconst = {
 /*
  * Systems where PCI IO resource ISA alignment can be skipped
  * when the ISA enable bit in the bridge control is not set
@@ -186,7 +186,7 @@ void pcibios_remove_bus(struct pci_bus *bus)
  * on the kernel command line (which was parsed earlier).
  */
 
-static int set_bf_sort(const struct dmi_system_id *d)
+static int __init set_bf_sort(const struct dmi_system_id *d)
 {
 	if (pci_bf_sort == pci_bf_sort_default) {
 		pci_bf_sort = pci_dmi_bf;
@@ -195,8 +195,8 @@ static int set_bf_sort(const struct dmi_system_id *d)
 	return 0;
 }
 
-static void read_dmi_type_b1(const struct dmi_header *dm,
-				       void *private_data)
+static void __init read_dmi_type_b1(const struct dmi_header *dm,
+				    void *private_data)
 {
 	u8 *d = (u8 *)dm + 4;
 
@@ -217,7 +217,7 @@ static void read_dmi_type_b1(const struct dmi_header *dm,
 	}
 }
 
-static int find_sort_method(const struct dmi_system_id *d)
+static int __init find_sort_method(const struct dmi_system_id *d)
 {
 	dmi_walk(read_dmi_type_b1, NULL);
 
@@ -232,7 +232,7 @@ static int find_sort_method(const struct dmi_system_id *d)
  * Enable renumbering of PCI bus# ranges to reach all PCI busses (Cardbus)
  */
 #ifdef __i386__
-static int assign_all_busses(const struct dmi_system_id *d)
+static int __init assign_all_busses(const struct dmi_system_id *d)
 {
 	pci_probe |= PCI_ASSIGN_ALL_BUSSES;
 	printk(KERN_INFO "%s detected: enabling PCI bus# renumbering"
@@ -241,7 +241,7 @@ static int assign_all_busses(const struct dmi_system_id *d)
 }
 #endif
 
-static int set_scan_all(const struct dmi_system_id *d)
+static int __init set_scan_all(const struct dmi_system_id *d)
 {
 	printk(KERN_INFO "PCI: %s detected, enabling pci=pcie_scan_all\n",
 	       d->ident);
@@ -249,7 +249,7 @@ static int set_scan_all(const struct dmi_system_id *d)
 	return 0;
 }
 
-static const struct dmi_system_id pciprobe_dmi_table[] = {
+static const struct dmi_system_id pciprobe_dmi_table[] __initconst = {
 #ifdef __i386__
 /*
  * Laptops which need pci=assign-busses to see Cardbus cards
@@ -512,7 +512,7 @@ int __init pcibios_init(void)
 	return 0;
 }
 
-char * __init pcibios_setup(char *str)
+char *__init pcibios_setup(char *str)
 {
 	if (!strcmp(str, "off")) {
 		pci_probe = 0;
-- 
1.7.10.4

