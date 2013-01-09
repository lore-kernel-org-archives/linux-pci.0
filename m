Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55566 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933967Ab3AIUnq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 15:43:46 -0500
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Russell King <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 09/14] ARM: tegra: Move pmc.h to include/mach
Date: Wed,  9 Jan 2013 21:43:09 +0100
Message-Id: <1357764194-12677-10-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In preparation for moving the PCIe driver into the drivers/pci/host
directory, this header, which contains prototypes that are required by
the PCIe driver, needs to be moved to a globally visible location.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Note that eventually the code in pmc.c and powergate.c should probably
be split out into a separate driver. The PMC registers are also directly
accessed from tegra20_clocks.c and tegra30_clocks.c, so that it might be
required to provide that functionality through the new driver as well.
---
 arch/arm/mach-tegra/common.c           |  2 +-
 arch/arm/mach-tegra/include/mach/pmc.h | 24 ++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h              | 24 ------------------------
 3 files changed, 25 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/pmc.h
 delete mode 100644 arch/arm/mach-tegra/pmc.h

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 3efe80b..2498f74 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -26,6 +26,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 
+#include <mach/pmc.h>
 #include <mach/powergate.h>
 
 #include "board.h"
@@ -33,7 +34,6 @@
 #include "common.h"
 #include "fuse.h"
 #include "iomap.h"
-#include "pmc.h"
 #include "apbio.h"
 #include "sleep.h"
 #include "pm.h"
diff --git a/arch/arm/mach-tegra/include/mach/pmc.h b/arch/arm/mach-tegra/include/mach/pmc.h
new file mode 100644
index 0000000..2631c9a
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/pmc.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef __MACH_TEGRA_PMC_H
+#define __MACH_TEGRA_PMC_H
+
+void tegra_pmc_init(void);
+void tegra_pmc_pcie_xclk_clamp(bool clamp);
+
+#endif
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
deleted file mode 100644
index 2631c9a..0000000
--- a/arch/arm/mach-tegra/pmc.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-#ifndef __MACH_TEGRA_PMC_H
-#define __MACH_TEGRA_PMC_H
-
-void tegra_pmc_init(void);
-void tegra_pmc_pcie_xclk_clamp(bool clamp);
-
-#endif
-- 
1.8.1

