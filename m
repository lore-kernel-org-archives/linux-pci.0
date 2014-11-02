Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Daniel J Blueman <daniel@numascale.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel J Blueman <daniel@numascale.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Steffen Persvold <sp@numascale.com>
Subject: [PATCH v3 3/5] Numachip: Add safe is-present function
Date: Sun,  2 Nov 2014 16:10:11 +0800
Message-Id: <1414915813-2462-3-git-send-email-daniel@numascale.com>
In-Reply-To: <1414915813-2462-1-git-send-email-daniel@numascale.com>
References: <1414915813-2462-1-git-send-email-daniel@numascale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add safe function to check if Numachip is detected, to be used elsewhere.

Signed-off-by: Daniel J Blueman <daniel@numascale.com>
---
 arch/x86/include/asm/numachip/numachip.h | 9 +++++++++
 arch/x86/kernel/apic/apic_numachip.c     | 9 +++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/numachip/numachip.h b/arch/x86/include/asm/numachip/numachip.h
index 1c6f7f6..3e1f4f9 100644
--- a/arch/x86/include/asm/numachip/numachip.h
+++ b/arch/x86/include/asm/numachip/numachip.h
@@ -16,4 +16,13 @@
 
 extern int __init pci_numachip_init(void);
 
+#ifdef CONFIG_X86_NUMACHIP
+extern bool is_numachip_system(void);
+#else
+static inline bool is_numachip_system(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* _ASM_X86_NUMACHIP_NUMACHIP_H */
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index bd083c0..c965b69 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -30,7 +30,7 @@
 #include <asm/apic_flat_64.h>
 #include <asm/pgtable.h>
 
-static int numachip_system __read_mostly;
+static bool numachip_system __read_mostly;
 
 static const struct apic apic_numachip __refconst;
 
@@ -173,11 +173,16 @@ static void fixup_cpu_id(struct cpuinfo_x86 *c, int node)
 	}
 }
 
+bool is_numachip_system(void)
+{
+	return numachip_system;
+}
+
 static int __init numachip_system_init(void)
 {
 	unsigned int val;
 
-	if (!numachip_system)
+	if (!is_numachip_system())
 		return 0;
 
 	x86_cpuinit.fixup_cpu_id = fixup_cpu_id;
-- 
1.9.1

