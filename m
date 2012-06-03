Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:47042 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754019Ab2FCT0n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 15:26:43 -0400
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Marek <mmarek@suse.cz>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Kumar Gala <galak@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/9] powerpc: move PCI fixup hooks from __init to __devinit
Date: Sun,  3 Jun 2012 20:48:24 +0200
Message-Id: <1338749305-22558-9-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The fixups are executed once the pci-device is found which is during
boot process so __init seems fine as long as the platform does not
support hotplug.
However it is possible to remove the PCI bus at run time and have it
rediscovered again via "echo 1 > /sys/bus/pci/rescan" and this will call
the fixups again.

Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/powerpc/platforms/85xx/tqm85xx.c    |    2 +-
 arch/powerpc/platforms/86xx/gef_ppc9a.c  |    2 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c |    2 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c |    2 +-
 arch/powerpc/sysdev/fsl_pci.c            |    2 +-
 arch/powerpc/sysdev/mv64x60_pci.c        |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 4d786c2..3e70a20 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -102,7 +102,7 @@ static void tqm85xx_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-static void __init tqm85xx_ti1520_fixup(struct pci_dev *pdev)
+static void __devinit tqm85xx_ti1520_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index 1fca663..563aafa8 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -164,7 +164,7 @@ static void gef_ppc9a_show_cpuinfo(struct seq_file *m)
 		gef_ppc9a_get_vme_is_syscon() ? "yes" : "no");
 }
 
-static void __init gef_ppc9a_nec_fixup(struct pci_dev *pdev)
+static void __devinit gef_ppc9a_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 14e0e576..cc6a91a 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -152,7 +152,7 @@ static void gef_sbc310_show_cpuinfo(struct seq_file *m)
 
 }
 
-static void __init gef_sbc310_nec_fixup(struct pci_dev *pdev)
+static void __devinit gef_sbc310_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 1638f43..aead6b3 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -141,7 +141,7 @@ static void gef_sbc610_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 }
 
-static void __init gef_sbc610_nec_fixup(struct pci_dev *pdev)
+static void __devinit gef_sbc610_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6073288..edbf794 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -36,7 +36,7 @@
 
 static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
-static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
+static void __devinit quirk_fsl_pcie_header(struct pci_dev *dev)
 {
 	u8 progif;
 
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index b0037ce..364b14d 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -104,7 +104,7 @@ subsys_initcall(mv64x60_sysfs_init);
 
 #endif /* CONFIG_SYSFS */
 
-static void __init mv64x60_pci_fixup_early(struct pci_dev *dev)
+static void __devinit mv64x60_pci_fixup_early(struct pci_dev *dev)
 {
 	/*
 	 * Set the host bridge hdr_type to an invalid value so that
-- 
1.7.10

