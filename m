Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:45976 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751646AbeB1GfM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 01:35:12 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 4/6] x86: Consolidate PCI_MMCONFIG configs
Date: Wed, 28 Feb 2018 07:34:49 +0100
Message-Id: <76a05abd818c89032161585ba130511a5bd673f0.1519799691.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519799691.git.jan.kiszka@siemens.com>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519799691.git.jan.kiszka@siemens.com>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Not sure if those two worked by design or just by chance so far. In any
case, it's at least cleaner and clearer to express this in a single
config statement.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/Kconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb7f43f23521..63e85e7da12e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2641,8 +2641,9 @@ config PCI_DIRECT
 	depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC || PCI_GOMMCONFIG))
 
 config PCI_MMCONFIG
-	def_bool y
-	depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
+	bool "Support mmconfig PCI config space access" if X86_64
+	default y
+	depends on PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY || X86_64)
 
 config PCI_OLPC
 	def_bool y
@@ -2657,10 +2658,6 @@ config PCI_DOMAINS
 	def_bool y
 	depends on PCI
 
-config PCI_MMCONFIG
-	bool "Support mmconfig PCI config space access"
-	depends on X86_64 && PCI && ACPI
-
 config PCI_CNB20LE_QUIRK
 	bool "Read CNB20LE Host Bridge Windows" if EXPERT
 	depends on PCI
-- 
2.13.6
