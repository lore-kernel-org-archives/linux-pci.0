Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53376 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab2GZTzg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 15:55:36 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 03/10] ARM: pci: Allow passing per-controller private data
Date: Thu, 26 Jul 2012 21:55:05 +0200
Message-Id: <1343332512-28762-4-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to allow drivers to specify private data for each controller,
this commit adds a private_data field to the struct hw_pci. This field
is an array of nr_controllers pointers that will be used to initialize
the private_data field of the corresponding controller's pci_sys_data
structure.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- none

Changes in v2:
- new patch

 arch/arm/include/asm/mach/pci.h | 1 +
 arch/arm/kernel/bios32.c        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 188fd58..31fab93 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -24,6 +24,7 @@ struct hw_pci {
 #endif
 	struct pci_ops	*ops;
 	int		nr_controllers;
+	void		**private_data;
 	int		(*setup)(int nr, struct pci_sys_data *);
 	struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
 	void		(*preinit)(void);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 5c3dd59..897b21a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -475,6 +475,9 @@ static void __devinit pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 		sys->map_irq = hw->map_irq;
 		INIT_LIST_HEAD(&sys->resources);
 
+		if (hw->private_data)
+			sys->private_data = hw->private_data[nr];
+
 		ret = hw->setup(nr, sys);
 
 		if (ret > 0) {
-- 
1.7.11.2

