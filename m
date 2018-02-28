Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:46006 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeB1GfS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 01:35:18 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/6] jailhouse: Provide detection for non-x86 systems
Date: Wed, 28 Feb 2018 07:34:46 +0100
Message-Id: <558f5cbae432ae029e2d8ee9b0ef44d837318625.1519799691.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519799691.git.jan.kiszka@siemens.com>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519799691.git.jan.kiszka@siemens.com>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Implement jailhouse_paravirt() via device tree probing on architectures
!= x86. Will be used by the PCI core.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
 arch/x86/include/asm/jailhouse_para.h           |  2 +-
 include/linux/hypervisor.h                      | 17 +++++++++++++++--
 3 files changed, 24 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/jailhouse.txt

diff --git a/Documentation/devicetree/bindings/jailhouse.txt b/Documentation/devicetree/bindings/jailhouse.txt
new file mode 100644
index 000000000000..2901c25ff340
--- /dev/null
+++ b/Documentation/devicetree/bindings/jailhouse.txt
@@ -0,0 +1,8 @@
+Jailhouse non-root cell device tree bindings
+--------------------------------------------
+
+When running in a non-root Jailhouse cell (partition), the device tree of this
+platform shall have a top-level "hypervisor" node with the following
+properties:
+
+- compatible = "jailhouse,cell"
diff --git a/arch/x86/include/asm/jailhouse_para.h b/arch/x86/include/asm/jailhouse_para.h
index 875b54376689..b885a961a150 100644
--- a/arch/x86/include/asm/jailhouse_para.h
+++ b/arch/x86/include/asm/jailhouse_para.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL2.0 */
 
 /*
- * Jailhouse paravirt_ops implementation
+ * Jailhouse paravirt detection
  *
  * Copyright (c) Siemens AG, 2015-2017
  *
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index b19563f9a8eb..fc08b433c856 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -8,15 +8,28 @@
  */
 
 #ifdef CONFIG_X86
+
+#include <asm/jailhouse_para.h>
 #include <asm/x86_init.h>
+
 static inline void hypervisor_pin_vcpu(int cpu)
 {
 	x86_platform.hyper.pin_vcpu(cpu);
 }
-#else
+
+#else /* !CONFIG_X86 */
+
+#include <linux/of.h>
+
 static inline void hypervisor_pin_vcpu(int cpu)
 {
 }
-#endif
+
+static inline bool jailhouse_paravirt(void)
+{
+	return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
+}
+
+#endif /* !CONFIG_X86 */
 
 #endif /* __LINUX_HYPEVISOR_H */
-- 
2.13.6
