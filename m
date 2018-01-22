Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 4/6] x86: Consolidate PCI_MMCONFIG configs
Date: Mon, 22 Jan 2018 07:12:48 +0100
Message-Id: <5dcaec50bb59140c1cb63c35ce566ccc02188bcb.1516601570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1516601570.git.jan.kiszka@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1516601570.git.jan.kiszka@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index 423e4b64e683..f2038417a590 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2595,8 +2595,9 @@ config PCI_DIRECT
 	depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC || PCI_GOMMCONFIG))
 
 config PCI_MMCONFIG
-	def_bool y
-	depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
+	bool "Support mmconfig PCI config space access" if X86_64
+	default y
+	depends on PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY || X86_64)
 
 config PCI_OLPC
 	def_bool y
@@ -2611,10 +2612,6 @@ config PCI_DOMAINS
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
