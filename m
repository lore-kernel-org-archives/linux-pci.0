Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:53383 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbaHYV1L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 17:27:11 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so13407524wgh.21
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2014 14:27:10 -0700 (PDT)
From: Mathias Krause <minipli@googlemail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 2/5] x86/PCI: Move __init annotation were it belongs to
Date: Mon, 25 Aug 2014 23:26:36 +0200
Message-Id: <1409001999-23161-3-git-send-email-minipli@googlemail.com>
In-Reply-To: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
References: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to include/linux/init.h the __init annotation should be added
immediately before the function name. However, for quite a few functions
in mmconfig-shared.c this is not the case. It's either before the return
type or even in the middle of it. Beside gcc still getting it right, we
should change them to comply to the rules of include/linux/init.h.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/x86/pci/mmconfig-shared.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 248642f4ba..163ef6bf16 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -31,7 +31,7 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
 
-static __init void pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
+static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
 {
 	if (cfg->res.parent)
 		release_resource(&cfg->res);
@@ -39,7 +39,7 @@ static __init void pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
 	kfree(cfg);
 }
 
-static __init void free_all_mmcfg(void)
+static void __init free_all_mmcfg(void)
 {
 	struct pci_mmcfg_region *cfg, *tmp;
 
@@ -93,7 +93,7 @@ static struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
 	return new;
 }
 
-static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
+static struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
 							int end, u64 addr)
 {
 	struct pci_mmcfg_region *new;
@@ -125,7 +125,7 @@ struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
 	return NULL;
 }
 
-static const char __init *pci_mmcfg_e7520(void)
+static const char *__init pci_mmcfg_e7520(void)
 {
 	u32 win;
 	raw_pci_ops->read(0, 0, PCI_DEVFN(0, 0), 0xce, 2, &win);
@@ -140,7 +140,7 @@ static const char __init *pci_mmcfg_e7520(void)
 	return "Intel Corporation E7520 Memory Controller Hub";
 }
 
-static const char __init *pci_mmcfg_intel_945(void)
+static const char *__init pci_mmcfg_intel_945(void)
 {
 	u32 pciexbar, mask = 0, len = 0;
 
@@ -184,7 +184,7 @@ static const char __init *pci_mmcfg_intel_945(void)
 	return "Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub";
 }
 
-static const char __init *pci_mmcfg_amd_fam10h(void)
+static const char *__init pci_mmcfg_amd_fam10h(void)
 {
 	u32 low, high, address;
 	u64 base, msr;
@@ -235,7 +235,7 @@ static const char __init *pci_mmcfg_amd_fam10h(void)
 }
 
 static bool __initdata mcp55_checked;
-static const char __init *pci_mmcfg_nvidia_mcp55(void)
+static const char *__init pci_mmcfg_nvidia_mcp55(void)
 {
 	int bus;
 	int mcp55_mmconf_found = 0;
-- 
1.7.10.4

