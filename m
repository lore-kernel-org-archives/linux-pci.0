Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35516 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdEJDBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2017 23:01:50 -0400
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: [PATCH] x86/PCI: fix duplicate 'const' declaration specifier
Date: Tue,  9 May 2017 20:01:21 -0700
Message-Id: <20170510030121.19667-1-nick.desaulniers@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Found with -Wduplicate-decl-specifier, a relatively new compiler flag in
GCC7, and Clang.

list_for_each_entry() eventually calls container_of(), which
marks the loop variable as const.  The first argument to
list_for_each_entry() is a type, which should not already be marked const,
otherwise the loop variable is marked const twice.

While this particular call site does not modify the loop variable,
trying to do so would already result in a compile time failure, so we
can remove the current const. Other call sites do not mark the loop
variable const.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index d1b47d5bc9c3..925083ed1b2b 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -643,7 +643,7 @@ static void __init __pci_mmcfg_init(int early)
 		return;
 
 	if (pcibios_last_bus < 0) {
-		const struct pci_mmcfg_region *cfg;
+		struct pci_mmcfg_region *cfg;
 
 		list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 			if (cfg->segment)
-- 
2.11.0
