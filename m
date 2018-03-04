Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:44418 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752083AbeCDScC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 4 Mar 2018 13:32:02 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v4 1/7] jailhouse: Provide detection for non-x86 systems
Date: Sun,  4 Mar 2018 19:31:33 +0100
Message-Id: <7b24a9f00261e20e0dd12934a663ab552500bded.1520188299.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520188299.git.jan.kiszka@siemens.com>
References: <cover.1520188299.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520188299.git.jan.kiszka@siemens.com>
References: <cover.1520188299.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Implement jailhouse_paravirt() via device tree probing on architectures
!= x86. Will be used by the PCI core.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Juergen Gross <jgross@suse.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
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
