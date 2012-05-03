Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51617 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab2ECPVu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2012 11:21:50 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Alessio Igor Bogani <abogani@kernel.org>,
	Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] scripts/modpost: check for bad refernces in .pci.fixups area
Date: Thu,  3 May 2012 17:23:09 +0200
Message-Id: <1336058590-18049-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Functions used for PCI fixups (like DECLARE_PCI_FIXUP_HEADER) are often
marked __init. This is okay as long as nobody is using PCI hotplug.
That means if one executes
| echo 1 > /sys/bus/pci/rescan

and we hit a module which is marked __init instead of __devinit then we
go boom because the code is removed after the kernel booted. This patch
helps to see those section miss-matches.
During rescan I saw that pci_fixup_early, pci_fixup_header and
pci_fixup_enable have been called. I added pci_fixup_final (which has no
users) and resume hooks as they should also not remain in __init
section.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 scripts/mod/modpost.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c4e7d15..b6fa8be 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -862,6 +862,11 @@ static void check_section(const char *modname, struct elf_info *elf,
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
@@ -1024,6 +1029,12 @@ const struct sectioncheck sectioncheck[] = {
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

