Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:35654 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbeCGHji (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 02:39:38 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 5/7] x86: Consolidate PCI_MMCONFIG configs
Date: Wed,  7 Mar 2018 08:39:16 +0100
Message-Id: <2a0ccd51ea6f7996e07162918228e23bdc1fbb03.1520408357.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Since e279b6c1d329 ("x86: start unification of arch/x86/Kconfig.*"), we
have two PCI_MMCONFIG entries, one from the original i386 and another
from x86_64. This consolidates both entries into a single one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/Kconfig | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c19f5342ec2b..8986a6b6e3df 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2641,8 +2641,10 @@ config PCI_DIRECT
 	depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC || PCI_GOMMCONFIG))
 
 config PCI_MMCONFIG
-	def_bool y
-	depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
+	bool "Support mmconfig PCI config space access" if X86_64
+	default y
+	depends on PCI && (ACPI || SFI)
+	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
 
 config PCI_OLPC
 	def_bool y
@@ -2657,11 +2659,6 @@ config PCI_DOMAINS
 	def_bool y
 	depends on PCI
 
-config PCI_MMCONFIG
-	bool "Support mmconfig PCI config space access"
-	default y
-	depends on X86_64 && PCI && (ACPI || SFI)
-
 config PCI_CNB20LE_QUIRK
 	bool "Read CNB20LE Host Bridge Windows" if EXPERT
 	depends on PCI
-- 
2.13.6
