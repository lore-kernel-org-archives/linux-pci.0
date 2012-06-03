Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:47048 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754217Ab2FCT0t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 15:26:49 -0400
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Marek <mmarek@suse.cz>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/9] scripts/modpost: check for bad refernces in .pci.fixups area
Date: Sun,  3 Jun 2012 20:48:17 +0200
Message-Id: <1338749305-22558-2-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Functions used for PCI fixups (like DECLARE_PCI_FIXUP_HEADER) are often
marked __init. This is okay as long as nobody is using PCI hotplug.
However if one does execute
| echo 1 > /sys/bus/pci/rescan

and we hit a module which is marked __init istead of __devinit then we
go boom because the code is removed after the kernel booted. This patch
help to see those section miss-matches.

Acked-By: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: linux-kbuild@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 scripts/mod/modpost.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0f84bb3..68e9f5e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -865,6 +865,11 @@ static void check_section(const char *modname, struct elf_info *elf,
 #define ALL_EXIT_TEXT_SECTIONS \
 	".exit.text$", ".devexit.text$", ".cpuexit.text$", ".memexit.text$"
 
+#define ALL_PCI_INIT_SECTIONS	\
+	".pci_fixup_early$", ".pci_fixup_header$", ".pci_fixup_final$", \
+	".pci_fixup_enable$", ".pci_fixup_resume$", \
+	".pci_fixup_resume_early$", ".pci_fixup_suspend$"
+
 #define ALL_XXXINIT_SECTIONS DEV_INIT_SECTIONS, CPU_INIT_SECTIONS, \
 	MEM_INIT_SECTIONS
 #define ALL_XXXEXIT_SECTIONS DEV_EXIT_SECTIONS, CPU_EXIT_SECTIONS, \
@@ -1027,6 +1032,12 @@ const struct sectioncheck sectioncheck[] = {
 	.mismatch = ANY_EXIT_TO_ANY_INIT,
 	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
+{
+	.fromsec = { ALL_PCI_INIT_SECTIONS, NULL },
+	.tosec   = { INIT_SECTIONS, NULL },
+	.mismatch = ANY_INIT_TO_ANY_EXIT,
+	.symbol_white_list = { NULL },
+},
 /* Do not export init/exit functions or data */
 {
 	.fromsec = { "__ksymtab*", NULL },
-- 
1.7.10

