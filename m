Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:42774 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682Ab2J2HCN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:13 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 03/15] SPEAr13xx: Add mach/io.h
Date: Mon, 29 Oct 2012 12:31:17 +0530
Message-ID: <cce9cba6020c30f0edb15e43fa51208524b59322.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In case of PCIe we need to have a different __io macro, which can write
into PCIe address space.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/mach-spear13xx/include/mach/io.h |   35 +++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/include/mach/io.h

diff --git a/arch/arm/mach-spear13xx/include/mach/io.h b/arch/arm/mach-spear13xx/include/mach/io.h
new file mode 100644
index 0000000..a0d93ca
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/io.h
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/io.h
+ *
+ * spear13xx machine family generic header file
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Pratyush Anand <pratyush.anand@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_IO_H
+#define __MACH_IO_H
+
+#define IO_SPACE_LIMIT	0xFFFF
+
+#ifdef CONFIG_SPEAR13XX_PCI
+extern void __iomem *spear13xx_pcie_io_base(unsigned long addr);
+
+static inline void __iomem *__io(unsigned long addr)
+{
+	return spear13xx_pcie_io_base(addr) + (addr & IO_SPACE_LIMIT);
+}
+#else
+static inline void __iomem *__io(unsigned long addr)
+{
+	return (void __iomem *)addr;
+}
+#endif
+
+#define __io(a)		__io(a)
+
+#endif /* __MACH_IO_H */
-- 
1.7.5.4

