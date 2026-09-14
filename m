Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80E47887F;
	Mon, 14 Sep 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394944; cv=none; b=nAfMMQPux5gs7AkjHhMsGo3YJ6JoUkY2jIEV4eszb9SfAYLEHNvP+gHMgwqo6BJ81AK3fB27E+12mVNU1YkRzO5vO+aqlFhpaWk1drwEPe3eRhKc5Sc9htNBGtvBoEGIgyMA24qrpcxUAYsm3jcqRJMdNl6ycthOiyQcpbbzuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394944; c=relaxed/simple;
	bh=13BxxDSB1v30ikb7sAe5b5t/21rDEC6fKpJgn65eafw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJAokc9vHt4UbA6Z9I7q5rLA5xPAnhOia4vrkdqYrVJIq9Z7YQAZF244KWSCGwsuvu+pGLdHveUAM3k1a9dF6IE6R2bwzyNoQieC5aikBddMxEcvxyNq5fQgTdqHaYtB0j4yaBBs6/Wi3016jIHDa6EKK/GW9n4mdFhvJeeLn8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvfLwQv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvfLwQv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362EF1F008A0;
	Mon, 14 Sep 2026 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394935;
	bh=eGAj+obWoN5ra5AxI1T+gwX9Nm7s8TZRF5VJ4qcCVfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bvfLwQv4zaB4xvZBAA7r4ZiKuwHZnKGPlAoNcW67SXmc5AjricbeUXYf/UV20ONho
	 vHlIIi2OH88hUTYuyvtvaVahhVV8DcdYWFyHI3OLpInX+IVzZR9Jy01rqZ07AKsATP
	 7USwq179dVpv1hH1dpjAB0SsS68TnQo7cq0I+GslL14hVt70kiy6xXyXPivW2krQ2/
	 h45WvNuo8N3yZ5Y1Y7hZgIaDA0AR2eFxdetvPl+v4ke0HpHR9f5H5tBvm7R44YSNMv
	 Jc8YmrtnqiW0VAkZjiw+fEChsOJfFbM8WyBAnAZnFpypDYV815i/E1KRZoKHqF0JLO
	 xNdeXUlGnlbvA==
From: Arnd Bergmann <arnd@kernel.org>
To: soc@lists.linux.dev
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 05/14] ARM: orion5x: fold plat-orion/pcie.c and hw_pci into pci.c
Date: Mon, 14 Sep 2026 16:08:07 +0200
Message-ID: <20260914140821.1805449-6-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914140821.1805449-1-arnd@kernel.org>
References: <20260914140821.1805449-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

orion5x is the only user of arch/arm/plat-orion/pcie.c and of
asm/mach/pci.h.

Fold it all into the one file referencing it, removing both the
infrastructure to deal with arch/arm/plat-* directories and pci_sys_data
from everywhere else.

Aside from making all the newly local functions 'static', this leaves
the code unchanged. Obviously a number of additional cleanups are
possible as follow-ups, which would allow turning it into two regular
pci_host_bridge drivers. I stopped here in order to reduce the risk
for regressions, while still cleaning up the common code as much
as possible.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/arch/arm/marvell.rst      |   2 -
 MAINTAINERS                             |   1 -
 arch/arm/Kconfig                        |   4 +-
 arch/arm/Makefile                       |   2 -
 arch/arm/include/asm/mach/pci.h         |  72 ----
 arch/arm/include/asm/pci.h              |   1 -
 arch/arm/kernel/bios32.c                | 197 -----------
 arch/arm/mach-mvebu/Makefile            |   2 -
 arch/arm/mach-orion5x/Makefile          |   2 -
 arch/arm/mach-orion5x/board-d2net.c     |   1 -
 arch/arm/mach-orion5x/board-mss2.c      |   1 -
 arch/arm/mach-orion5x/board-rd88f5182.c |   1 -
 arch/arm/mach-orion5x/common.h          |  19 ++
 arch/arm/mach-orion5x/pci.c             | 428 +++++++++++++++++++++++-
 arch/arm/mm/ioremap.c                   |   1 -
 arch/arm/mm/mmu.c                       |   1 -
 arch/arm/plat-orion/Makefile            |   7 -
 arch/arm/plat-orion/include/plat/pcie.h |  34 --
 arch/arm/plat-orion/pcie.c              | 287 ----------------
 drivers/pci/controller/pci-mvebu.c      |   5 -
 20 files changed, 446 insertions(+), 622 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach/pci.h
 delete mode 100644 arch/arm/plat-orion/Makefile
 delete mode 100644 arch/arm/plat-orion/include/plat/pcie.h
 delete mode 100644 arch/arm/plat-orion/pcie.c

diff --git a/Documentation/arch/arm/marvell.rst b/Documentation/arch/arm/marvell.rst
index eb450095161e..28f212848668 100644
--- a/Documentation/arch/arm/marvell.rst
+++ b/Documentation/arch/arm/marvell.rst
@@ -32,8 +32,6 @@ Orion family
 	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
   Linux kernel mach directory:
 	arch/arm/mach-orion5x
-  Linux kernel plat directory:
-	arch/arm/plat-orion
 
 Kirkwood family
 ---------------
diff --git a/MAINTAINERS b/MAINTAINERS
index 5598aeaaf39e..ab572953735d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3087,7 +3087,6 @@ F:	Documentation/devicetree/bindings/soc/dove/
 F:	arch/arm/boot/dts/marvell/dove*
 F:	arch/arm/boot/dts/marvell/orion5x*
 F:	arch/arm/mach-orion5x/
-F:	arch/arm/plat-orion/
 F:	drivers/bus/mvebu-mbus.c
 F:	drivers/soc/dove/
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a362e2627337..de3d9bae33fa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -353,9 +353,7 @@ config ARCH_MULTIPLATFORM
 source "arch/arm/Kconfig.platforms"
 
 #
-# This is sorted alphabetically by mach-* pathname.  However, plat-*
-# Kconfigs may be included either alphabetically (according to the
-# plat- suffix) or along side the corresponding mach-* source.
+# This is sorted alphabetically by mach-* pathname.
 #
 source "arch/arm/mach-actions/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5421a3ec3825..f882e8a35167 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -235,8 +235,6 @@ core-y				+= $(patsubst %,arch/arm/mach-%/,$(machine-y))
 # For cleaning
 core-				+= $(patsubst %,arch/arm/mach-%/,$(machine-))
 
-core-$(CONFIG_PLAT_ORION)	+= arch/arm/plat-orion/
-
 libs-y				:= arch/arm/lib/ $(libs-y)
 
 # Default target when executing plain make
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
deleted file mode 100644
index 78f2318ed000..000000000000
--- a/arch/arm/include/asm/mach/pci.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/include/asm/mach/pci.h
- *
- *  Copyright (C) 2000 Russell King
- */
-
-#ifndef __ASM_MACH_PCI_H
-#define __ASM_MACH_PCI_H
-
-#include <linux/ioport.h>
-
-struct pci_sys_data;
-struct pci_ops;
-struct pci_bus;
-struct pci_host_bridge;
-struct device;
-
-struct hw_pci {
-	struct pci_ops	*ops;
-	int		nr_controllers;
-	void		**private_data;
-	int		(*setup)(int nr, struct pci_sys_data *);
-	int		(*scan)(int nr, struct pci_host_bridge *);
-	void		(*preinit)(void);
-	void		(*postinit)(void);
-	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
-	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
-};
-
-/*
- * Per-controller structure
- */
-struct pci_sys_data {
-	struct list_head node;
-	int		busnr;		/* primary bus number			*/
-	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
-	unsigned long	io_offset;	/* bus->cpu IO mapping offset		*/
-	struct pci_bus	*bus;		/* PCI bus				*/
-	struct list_head resources;	/* root bus resources (apertures)       */
-	struct resource io_res;
-	char		io_res_name[12];
-					/* Bridge swizzling			*/
-	u8		(*swizzle)(struct pci_dev *, u8 *);
-					/* IRQ mapping				*/
-	int		(*map_irq)(const struct pci_dev *, u8, u8);
-	void		*private_data;	/* platform controller private data	*/
-};
-
-/*
- * Call this with your hw_pci struct to initialise the PCI system.
- */
-void pci_common_init_dev(struct device *, struct hw_pci *);
-
-/*
- * Compatibility wrapper for older platforms that do not care about
- * passing the parent device.
- */
-static inline void pci_common_init(struct hw_pci *hw)
-{
-	pci_common_init_dev(NULL, hw);
-}
-
-/*
- * PCI controllers
- */
-extern struct pci_ops iop3xx_ops;
-extern int iop3xx_pci_setup(int nr, struct pci_sys_data *);
-extern void iop3xx_pci_preinit(void);
-extern void iop3xx_pci_preinit_cond(void);
-
-#endif /* __ASM_MACH_PCI_H */
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 50ddc7ce1db8..650becf39e58 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -3,7 +3,6 @@
 #define ASMARM_PCI_H
 
 #ifdef __KERNEL__
-#include <asm/mach/pci.h> /* for pci_sys_data */
 
 extern unsigned long pcibios_min_io;
 #define PCIBIOS_MIN_IO pcibios_min_io
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 3367ef0f6a37..a6c7f271e31a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -16,9 +16,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
-#include <asm/mach/pci.h>
-
-static int debug_pci;
 
 /*
  * We don't use this to fix the device, but initialisation of it.
@@ -298,191 +295,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-/*
- * Swizzle the device pin each time we cross a bridge.  If a platform does
- * not provide a swizzle function, we perform the standard PCI swizzling.
- *
- * The default swizzling walks up the bus tree one level at a time, applying
- * the standard swizzle function at each step, stopping when it finds the PCI
- * root bus.  This will return the slot number of the bridge device on the
- * root bus and the interrupt pin on that device which should correspond
- * with the downstream device interrupt.
- *
- * Platforms may override this, in which case the slot and pin returned
- * depend entirely on the platform code.  However, please note that the
- * PCI standard swizzle is implemented on plug-in cards and Cardbus based
- * PCI extenders, so it can not be ignored.
- */
-static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
-{
-	struct pci_sys_data *sys = dev->sysdata;
-	int slot, oldpin = *pin;
-
-	if (sys->swizzle)
-		slot = sys->swizzle(dev, pin);
-	else
-		slot = pci_common_swizzle(dev, pin);
-
-	if (debug_pci)
-		printk("PCI: %s swizzling pin %d => pin %d slot %d\n",
-			pci_name(dev), oldpin, *pin, slot);
-
-	return slot;
-}
-
-/*
- * Map a slot/pin to an IRQ.
- */
-static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct pci_sys_data *sys = dev->sysdata;
-	int irq = -1;
-
-	if (sys->map_irq)
-		irq = sys->map_irq(dev, slot, pin);
-
-	if (debug_pci)
-		printk("PCI: %s mapping slot %d pin %d => irq %d\n",
-			pci_name(dev), slot, pin, irq);
-
-	return irq;
-}
-
-static int pcibios_init_resource(int busnr, struct pci_sys_data *sys)
-{
-	int ret;
-	struct resource_entry *window;
-
-	if (list_empty(&sys->resources)) {
-		pci_add_resource_offset(&sys->resources,
-			 &iomem_resource, sys->mem_offset);
-	}
-
-	resource_list_for_each_entry(window, &sys->resources)
-		if (resource_type(window->res) == IORESOURCE_IO)
-			return 0;
-
-	sys->io_res.start = (busnr * SZ_64K) ?  : pcibios_min_io;
-	sys->io_res.end = (busnr + 1) * SZ_64K - 1;
-	sys->io_res.flags = IORESOURCE_IO;
-	sys->io_res.name = sys->io_res_name;
-	sprintf(sys->io_res_name, "PCI%d I/O", busnr);
-
-	ret = request_resource(&ioport_resource, &sys->io_res);
-	if (ret) {
-		pr_err("PCI: unable to allocate I/O port region (%d)\n", ret);
-		return ret;
-	}
-	pci_add_resource_offset(&sys->resources, &sys->io_res,
-				sys->io_offset);
-
-	return 0;
-}
-
-static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
-			    struct list_head *head)
-{
-	struct pci_sys_data *sys = NULL;
-	int ret;
-	int nr, busnr;
-
-	for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
-		struct pci_host_bridge *bridge;
-
-		bridge = pci_alloc_host_bridge(sizeof(struct pci_sys_data));
-		if (WARN(!bridge, "PCI: unable to allocate bridge!"))
-			break;
-
-		sys = pci_host_bridge_priv(bridge);
-
-		sys->busnr   = busnr;
-		sys->swizzle = hw->swizzle;
-		sys->map_irq = hw->map_irq;
-		INIT_LIST_HEAD(&sys->resources);
-
-		if (hw->private_data)
-			sys->private_data = hw->private_data[nr];
-
-		ret = hw->setup(nr, sys);
-
-		if (ret > 0) {
-
-			ret = pcibios_init_resource(nr, sys);
-			if (ret)  {
-				pci_free_host_bridge(bridge);
-				break;
-			}
-
-			bridge->map_irq = pcibios_map_irq;
-			bridge->swizzle_irq = pcibios_swizzle;
-
-			if (hw->scan)
-				ret = hw->scan(nr, bridge);
-			else {
-				list_splice_init(&sys->resources,
-						 &bridge->windows);
-				bridge->dev.parent = parent;
-				bridge->sysdata = sys;
-				bridge->busnr = sys->busnr;
-				bridge->ops = hw->ops;
-
-				ret = pci_scan_root_bus_bridge(bridge);
-			}
-
-			if (WARN(ret < 0, "PCI: unable to scan bus!")) {
-				pci_free_host_bridge(bridge);
-				break;
-			}
-
-			sys->bus = bridge->bus;
-
-			busnr = sys->bus->busn_res.end + 1;
-
-			list_add(&sys->node, head);
-		} else {
-			pci_free_host_bridge(bridge);
-			if (ret < 0)
-				break;
-		}
-	}
-}
-
-void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
-{
-	struct pci_sys_data *sys;
-	LIST_HEAD(head);
-
-	pci_add_flags(PCI_REASSIGN_ALL_BUS);
-	if (hw->preinit)
-		hw->preinit();
-	pcibios_init_hw(parent, hw, &head);
-	if (hw->postinit)
-		hw->postinit();
-
-	list_for_each_entry(sys, &head, node) {
-		struct pci_bus *bus = sys->bus;
-
-		/*
-		 * We insert PCI resources into the iomem_resource and
-		 * ioport_resource trees in either pci_bus_claim_resources()
-		 * or pci_bus_assign_resources().
-		 */
-		if (pci_has_flag(PCI_PROBE_ONLY)) {
-			pci_bus_claim_resources(bus);
-		} else {
-			struct pci_bus *child;
-
-			pci_bus_size_bridges(bus);
-			pci_bus_assign_resources(bus);
-
-			list_for_each_entry(child, &bus->children, node)
-				pcie_bus_configure_settings(child);
-		}
-
-		pci_bus_add_devices(bus);
-	}
-}
-
 #ifndef CONFIG_PCI_HOST_ITE8152
 void pcibios_set_master(struct pci_dev *dev)
 {
@@ -490,15 +302,6 @@ void pcibios_set_master(struct pci_dev *dev)
 }
 #endif
 
-char * __init pcibios_setup(char *str)
-{
-	if (!strcmp(str, "debug")) {
-		debug_pci = 1;
-		return NULL;
-	}
-	return str;
-}
-
 /*
  * From arch/i386/kernel/pci-i386.c:
  *
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 569768a69ffc..7db707fdf8ef 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
-
 obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index a80932210031..d13048c99d18 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
-
 obj-y				+= common.o pci.o
 
 obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
diff --git a/arch/arm/mach-orion5x/board-d2net.c b/arch/arm/mach-orion5x/board-d2net.c
index 0fe6fd1fd0d9..94f6d802f1f8 100644
--- a/arch/arm/mach-orion5x/board-d2net.c
+++ b/arch/arm/mach-orion5x/board-d2net.c
@@ -17,7 +17,6 @@
 #include <linux/gpio/machine.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
 #include "common.h"
 #include "orion5x.h"
 
diff --git a/arch/arm/mach-orion5x/board-mss2.c b/arch/arm/mach-orion5x/board-mss2.c
index 322ae29d05aa..06189aaf886d 100644
--- a/arch/arm/mach-orion5x/board-mss2.c
+++ b/arch/arm/mach-orion5x/board-mss2.c
@@ -12,7 +12,6 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
 #include "orion5x.h"
 #include "bridge-regs.h"
 #include "common.h"
diff --git a/arch/arm/mach-orion5x/board-rd88f5182.c b/arch/arm/mach-orion5x/board-rd88f5182.c
index 9e2fe74ec68a..f403a994e27e 100644
--- a/arch/arm/mach-orion5x/board-rd88f5182.c
+++ b/arch/arm/mach-orion5x/board-rd88f5182.c
@@ -15,7 +15,6 @@
 #include <linux/irq.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
 #include "common.h"
 #include "orion5x.h"
 
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index 4dc6c59bde99..9e6edac784b2 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -41,6 +41,25 @@ struct pci_bus;
 struct pci_host_bridge;
 struct pci_sys_data;
 struct pci_dev;
+struct pci_ops;
+struct device;
+
+struct hw_pci {
+	struct pci_ops	*ops;
+	int		nr_controllers;
+	void		**private_data;
+	int		(*setup)(int nr, struct pci_sys_data *);
+	int		(*scan)(int nr, struct pci_host_bridge *);
+	void		(*preinit)(void);
+	void		(*postinit)(void);
+	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
+	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+};
+
+/*
+ * Call this with your hw_pci struct to initialise the PCI system.
+ */
+void pci_common_init(struct hw_pci *);
 
 void orion5x_pcie_id(u32 *dev, u32 *rev);
 void orion5x_pci_disable(void);
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 3d1e6ad0e14b..2da278b94661 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -13,11 +13,28 @@
 #include <linux/mbus.h>
 #include <video/vga.h>
 #include <asm/irq.h>
-#include <asm/mach/pci.h>
-#include <plat/pcie.h>
 #include "common.h"
 #include "orion5x.h"
 
+/*
+ * Per-controller structure
+ */
+struct pci_sys_data {
+	struct list_head node;
+	int		busnr;		/* primary bus number			*/
+	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
+	unsigned long	io_offset;	/* bus->cpu IO mapping offset		*/
+	struct pci_bus	*bus;		/* PCI bus				*/
+	struct list_head resources;	/* root bus resources (apertures)       */
+	struct resource io_res;
+	char		io_res_name[12];
+					/* Bridge swizzling			*/
+	u8		(*swizzle)(struct pci_dev *, u8 *);
+					/* IRQ mapping				*/
+	int		(*map_irq)(const struct pci_dev *, u8, u8);
+	void		*private_data;	/* platform controller private data	*/
+};
+
 /*****************************************************************************
  * Orion has one PCIe controller and one PCI controller.
  *
@@ -34,6 +51,217 @@
 /*****************************************************************************
  * PCIe controller
  ****************************************************************************/
+
+/*
+ * PCIe unit register offsets.
+ */
+#define PCIE_DEV_ID_OFF		0x0000
+#define PCIE_CMD_OFF		0x0004
+#define PCIE_DEV_REV_OFF	0x0008
+#define PCIE_BAR_LO_OFF(n)	(0x0010 + ((n) << 3))
+#define PCIE_BAR_HI_OFF(n)	(0x0014 + ((n) << 3))
+#define PCIE_HEADER_LOG_4_OFF	0x0128
+#define PCIE_BAR_CTRL_OFF(n)	(0x1804 + ((n - 1) * 4))
+#define PCIE_WIN04_CTRL_OFF(n)	(0x1820 + ((n) << 4))
+#define PCIE_WIN04_BASE_OFF(n)	(0x1824 + ((n) << 4))
+#define PCIE_WIN04_REMAP_OFF(n)	(0x182c + ((n) << 4))
+#define PCIE_WIN5_CTRL_OFF	0x1880
+#define PCIE_WIN5_BASE_OFF	0x1884
+#define PCIE_WIN5_REMAP_OFF	0x188c
+#define PCIE_CONF_ADDR_OFF	0x18f8
+#define  PCIE_CONF_ADDR_EN		0x80000000
+#define  PCIE_CONF_REG(r)		((((r) & 0xf00) << 16) | ((r) & 0xfc))
+#define  PCIE_CONF_BUS(b)		(((b) & 0xff) << 16)
+#define  PCIE_CONF_DEV(d)		(((d) & 0x1f) << 11)
+#define  PCIE_CONF_FUNC(f)		(((f) & 0x7) << 8)
+#define PCIE_CONF_DATA_OFF	0x18fc
+#define PCIE_MASK_OFF		0x1910
+#define PCIE_CTRL_OFF		0x1a00
+#define  PCIE_CTRL_X1_MODE		0x0001
+#define PCIE_STAT_OFF		0x1a04
+#define  PCIE_STAT_DEV_OFFS		20
+#define  PCIE_STAT_DEV_MASK		0x1f
+#define  PCIE_STAT_BUS_OFFS		8
+#define  PCIE_STAT_BUS_MASK		0xff
+#define  PCIE_STAT_LINK_DOWN		1
+#define PCIE_DEBUG_CTRL         0x1a60
+#define  PCIE_DEBUG_SOFT_RESET		(1<<20)
+
+
+static u32 orion_pcie_dev_id(void __iomem *base)
+{
+	return readl(base + PCIE_DEV_ID_OFF) >> 16;
+}
+
+static u32 orion_pcie_rev(void __iomem *base)
+{
+	return readl(base + PCIE_DEV_REV_OFF) & 0xff;
+}
+
+static int orion_pcie_link_up(void __iomem *base)
+{
+	return !(readl(base + PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
+}
+
+static void __init orion_pcie_set_local_bus_nr(void __iomem *base, int nr)
+{
+	u32 stat;
+
+	stat = readl(base + PCIE_STAT_OFF);
+	stat &= ~(PCIE_STAT_BUS_MASK << PCIE_STAT_BUS_OFFS);
+	stat |= nr << PCIE_STAT_BUS_OFFS;
+	writel(stat, base + PCIE_STAT_OFF);
+}
+
+/*
+ * Setup PCIE BARs and Address Decode Wins:
+ * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
+ * WIN[0-3] -> DRAM bank[0-3]
+ */
+static void __init orion_pcie_setup_wins(void __iomem *base)
+{
+	const struct mbus_dram_target_info *dram;
+	u32 size;
+	int i;
+
+	dram = mv_mbus_dram_info();
+
+	/*
+	 * First, disable and clear BARs and windows.
+	 */
+	for (i = 1; i <= 2; i++) {
+		writel(0, base + PCIE_BAR_CTRL_OFF(i));
+		writel(0, base + PCIE_BAR_LO_OFF(i));
+		writel(0, base + PCIE_BAR_HI_OFF(i));
+	}
+
+	for (i = 0; i < 5; i++) {
+		writel(0, base + PCIE_WIN04_CTRL_OFF(i));
+		writel(0, base + PCIE_WIN04_BASE_OFF(i));
+		writel(0, base + PCIE_WIN04_REMAP_OFF(i));
+	}
+
+	writel(0, base + PCIE_WIN5_CTRL_OFF);
+	writel(0, base + PCIE_WIN5_BASE_OFF);
+	writel(0, base + PCIE_WIN5_REMAP_OFF);
+
+	/*
+	 * Setup windows for DDR banks.  Count total DDR size on the fly.
+	 */
+	size = 0;
+	for (i = 0; i < dram->num_cs; i++) {
+		const struct mbus_dram_window *cs = dram->cs + i;
+
+		writel(cs->base & 0xffff0000, base + PCIE_WIN04_BASE_OFF(i));
+		writel(0, base + PCIE_WIN04_REMAP_OFF(i));
+		writel(((cs->size - 1) & 0xffff0000) |
+			(cs->mbus_attr << 8) |
+			(dram->mbus_dram_target_id << 4) | 1,
+				base + PCIE_WIN04_CTRL_OFF(i));
+
+		size += cs->size;
+	}
+
+	/*
+	 * Round up 'size' to the nearest power of two.
+	 */
+	if ((size & (size - 1)) != 0)
+		size = 1 << fls(size);
+
+	/*
+	 * Setup BAR[1] to all DRAM banks.
+	 */
+	writel(dram->cs[0].base, base + PCIE_BAR_LO_OFF(1));
+	writel(0, base + PCIE_BAR_HI_OFF(1));
+	writel(((size - 1) & 0xffff0000) | 1, base + PCIE_BAR_CTRL_OFF(1));
+}
+
+static void __init orion_pcie_setup(void __iomem *base)
+{
+	u16 cmd;
+	u32 mask;
+
+	/*
+	 * Point PCIe unit MBUS decode windows to DRAM space.
+	 */
+	orion_pcie_setup_wins(base);
+
+	/*
+	 * Master + slave enable.
+	 */
+	cmd = readw(base + PCIE_CMD_OFF);
+	cmd |= PCI_COMMAND_IO;
+	cmd |= PCI_COMMAND_MEMORY;
+	cmd |= PCI_COMMAND_MASTER;
+	writew(cmd, base + PCIE_CMD_OFF);
+
+	/*
+	 * Enable interrupt lines A-D.
+	 */
+	mask = readl(base + PCIE_MASK_OFF);
+	mask |= 0x0f000000;
+	writel(mask, base + PCIE_MASK_OFF);
+}
+
+static int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
+			      u32 devfn, int where, int size, u32 *val)
+{
+	writel(PCIE_CONF_BUS(bus->number) |
+		PCIE_CONF_DEV(PCI_SLOT(devfn)) |
+		PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
+		PCIE_CONF_REG(where) | PCIE_CONF_ADDR_EN,
+			base + PCIE_CONF_ADDR_OFF);
+
+	*val = readl(base + PCIE_CONF_DATA_OFF);
+
+	if (size == 1)
+		*val = (*val >> (8 * (where & 3))) & 0xff;
+	else if (size == 2)
+		*val = (*val >> (8 * (where & 3))) & 0xffff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
+				 u32 devfn, int where, int size, u32 *val)
+{
+	*val = readl(wa_base + (PCIE_CONF_BUS(bus->number) |
+				PCIE_CONF_DEV(PCI_SLOT(devfn)) |
+				PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
+				PCIE_CONF_REG(where)));
+
+	if (size == 1)
+		*val = (*val >> (8 * (where & 3))) & 0xff;
+	else if (size == 2)
+		*val = (*val >> (8 * (where & 3))) & 0xffff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int orion_pcie_wr_conf(void __iomem *base, struct pci_bus *bus,
+			      u32 devfn, int where, int size, u32 val)
+{
+	int ret = PCIBIOS_SUCCESSFUL;
+
+	writel(PCIE_CONF_BUS(bus->number) |
+		PCIE_CONF_DEV(PCI_SLOT(devfn)) |
+		PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
+		PCIE_CONF_REG(where) | PCIE_CONF_ADDR_EN,
+			base + PCIE_CONF_ADDR_OFF);
+
+	if (size == 4) {
+		writel(val, base + PCIE_CONF_DATA_OFF);
+	} else if (size == 2) {
+		writew(val, base + PCIE_CONF_DATA_OFF + (where & 3));
+	} else if (size == 1) {
+		writeb(val, base + PCIE_CONF_DATA_OFF + (where & 3));
+	} else {
+		ret = PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return ret;
+}
+
 #define PCIE_BASE	(ORION5X_PCIE_VIRT_BASE)
 
 void __init orion5x_pcie_id(u32 *dev, u32 *rev)
@@ -598,3 +826,199 @@ int __init orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	return -1;
 }
+
+static int debug_pci;
+
+char * __init pcibios_setup(char *str)
+{
+	if (!strcmp(str, "debug")) {
+		debug_pci = 1;
+		return NULL;
+	}
+	return str;
+}
+
+/*
+ * Swizzle the device pin each time we cross a bridge.  If a platform does
+ * not provide a swizzle function, we perform the standard PCI swizzling.
+ *
+ * The default swizzling walks up the bus tree one level at a time, applying
+ * the standard swizzle function at each step, stopping when it finds the PCI
+ * root bus.  This will return the slot number of the bridge device on the
+ * root bus and the interrupt pin on that device which should correspond
+ * with the downstream device interrupt.
+ *
+ * Platforms may override this, in which case the slot and pin returned
+ * depend entirely on the platform code.  However, please note that the
+ * PCI standard swizzle is implemented on plug-in cards and Cardbus based
+ * PCI extenders, so it can not be ignored.
+ */
+static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
+{
+	struct pci_sys_data *sys = dev->sysdata;
+	int slot, oldpin = *pin;
+
+	if (sys->swizzle)
+		slot = sys->swizzle(dev, pin);
+	else
+		slot = pci_common_swizzle(dev, pin);
+
+	if (debug_pci)
+		printk("PCI: %s swizzling pin %d => pin %d slot %d\n",
+			pci_name(dev), oldpin, *pin, slot);
+
+	return slot;
+}
+
+/*
+ * Map a slot/pin to an IRQ.
+ */
+static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pci_sys_data *sys = dev->sysdata;
+	int irq = -1;
+
+	if (sys->map_irq)
+		irq = sys->map_irq(dev, slot, pin);
+
+	if (debug_pci)
+		printk("PCI: %s mapping slot %d pin %d => irq %d\n",
+			pci_name(dev), slot, pin, irq);
+
+	return irq;
+}
+
+static int pcibios_init_resource(int busnr, struct pci_sys_data *sys)
+{
+	int ret;
+	struct resource_entry *window;
+
+	if (list_empty(&sys->resources)) {
+		pci_add_resource_offset(&sys->resources,
+			 &iomem_resource, sys->mem_offset);
+	}
+
+	resource_list_for_each_entry(window, &sys->resources)
+		if (resource_type(window->res) == IORESOURCE_IO)
+			return 0;
+
+	sys->io_res.start = (busnr * SZ_64K) ?  : pcibios_min_io;
+	sys->io_res.end = (busnr + 1) * SZ_64K - 1;
+	sys->io_res.flags = IORESOURCE_IO;
+	sys->io_res.name = sys->io_res_name;
+	sprintf(sys->io_res_name, "PCI%d I/O", busnr);
+
+	ret = request_resource(&ioport_resource, &sys->io_res);
+	if (ret) {
+		pr_err("PCI: unable to allocate I/O port region (%d)\n", ret);
+		return ret;
+	}
+	pci_add_resource_offset(&sys->resources, &sys->io_res,
+				sys->io_offset);
+
+	return 0;
+}
+
+static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
+			    struct list_head *head)
+{
+	struct pci_sys_data *sys = NULL;
+	int ret;
+	int nr, busnr;
+
+	for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
+		struct pci_host_bridge *bridge;
+
+		bridge = pci_alloc_host_bridge(sizeof(struct pci_sys_data));
+		if (WARN(!bridge, "PCI: unable to allocate bridge!"))
+			break;
+
+		sys = pci_host_bridge_priv(bridge);
+
+		sys->busnr   = busnr;
+		sys->swizzle = hw->swizzle;
+		sys->map_irq = hw->map_irq;
+		INIT_LIST_HEAD(&sys->resources);
+
+		if (hw->private_data)
+			sys->private_data = hw->private_data[nr];
+
+		ret = hw->setup(nr, sys);
+
+		if (ret > 0) {
+
+			ret = pcibios_init_resource(nr, sys);
+			if (ret)  {
+				pci_free_host_bridge(bridge);
+				break;
+			}
+
+			bridge->map_irq = pcibios_map_irq;
+			bridge->swizzle_irq = pcibios_swizzle;
+
+			if (hw->scan)
+				ret = hw->scan(nr, bridge);
+			else {
+				list_splice_init(&sys->resources,
+						 &bridge->windows);
+				bridge->dev.parent = parent;
+				bridge->sysdata = sys;
+				bridge->busnr = sys->busnr;
+				bridge->ops = hw->ops;
+
+				ret = pci_scan_root_bus_bridge(bridge);
+			}
+
+			if (WARN(ret < 0, "PCI: unable to scan bus!")) {
+				pci_free_host_bridge(bridge);
+				break;
+			}
+
+			sys->bus = bridge->bus;
+
+			busnr = sys->bus->busn_res.end + 1;
+
+			list_add(&sys->node, head);
+		} else {
+			pci_free_host_bridge(bridge);
+			if (ret < 0)
+				break;
+		}
+	}
+}
+
+void pci_common_init(struct hw_pci *hw)
+{
+	struct pci_sys_data *sys;
+	LIST_HEAD(head);
+
+	pci_add_flags(PCI_REASSIGN_ALL_BUS);
+	if (hw->preinit)
+		hw->preinit();
+	pcibios_init_hw(NULL, hw, &head);
+	if (hw->postinit)
+		hw->postinit();
+
+	list_for_each_entry(sys, &head, node) {
+		struct pci_bus *bus = sys->bus;
+
+		/*
+		 * We insert PCI resources into the iomem_resource and
+		 * ioport_resource trees in either pci_bus_claim_resources()
+		 * or pci_bus_assign_resources().
+		 */
+		if (pci_has_flag(PCI_PROBE_ONLY)) {
+			pci_bus_claim_resources(bus);
+		} else {
+			struct pci_bus *child;
+
+			pci_bus_size_bridges(bus);
+			pci_bus_assign_resources(bus);
+
+			list_for_each_entry(child, &bus->children, node)
+				pcie_bus_configure_settings(child);
+		}
+
+		pci_bus_add_devices(bus);
+	}
+}
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 27e64f782cb3..9e317481e0af 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -41,7 +41,6 @@
 #include <asm/system_info.h>
 
 #include <asm/mach/map.h>
-#include <asm/mach/pci.h>
 #include "mm.h"
 
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 82657352acb4..5ea73b7780f2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -33,7 +33,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/pci.h>
 #include <asm/fixmap.h>
 
 #include "fault.h"
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
deleted file mode 100644
index a88b9d0bfd2a..000000000000
--- a/arch/arm/plat-orion/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the linux kernel.
-#
-ccflags-y := -I$(src)/include
-
-obj-$(CONFIG_PLAT_ORION_LEGACY)   += pcie.o
diff --git a/arch/arm/plat-orion/include/plat/pcie.h b/arch/arm/plat-orion/include/plat/pcie.h
deleted file mode 100644
index fe5b9e862747..000000000000
--- a/arch/arm/plat-orion/include/plat/pcie.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * arch/arm/plat-orion/include/plat/pcie.h
- *
- * Marvell Orion SoC PCIe handling.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_PCIE_H
-#define __PLAT_PCIE_H
-
-struct pci_bus;
-
-u32 orion_pcie_dev_id(void __iomem *base);
-u32 orion_pcie_rev(void __iomem *base);
-int orion_pcie_link_up(void __iomem *base);
-int orion_pcie_x4_mode(void __iomem *base);
-int orion_pcie_get_local_bus_nr(void __iomem *base);
-void orion_pcie_set_local_bus_nr(void __iomem *base, int nr);
-void orion_pcie_reset(void __iomem *base);
-void orion_pcie_setup(void __iomem *base);
-int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
-		       u32 devfn, int where, int size, u32 *val);
-int orion_pcie_rd_conf_tlp(void __iomem *base, struct pci_bus *bus,
-			   u32 devfn, int where, int size, u32 *val);
-int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
-			  u32 devfn, int where, int size, u32 *val);
-int orion_pcie_wr_conf(void __iomem *base, struct pci_bus *bus,
-		       u32 devfn, int where, int size, u32 val);
-
-
-#endif
diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
deleted file mode 100644
index e817f20409c4..000000000000
--- a/arch/arm/plat-orion/pcie.c
+++ /dev/null
@@ -1,287 +0,0 @@
-/*
- * arch/arm/plat-orion/pcie.c
- *
- * Marvell Orion SoC PCIe handling.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/mbus.h>
-#include <asm/mach/pci.h>
-#include <plat/pcie.h>
-#include <linux/delay.h>
-
-/*
- * PCIe unit register offsets.
- */
-#define PCIE_DEV_ID_OFF		0x0000
-#define PCIE_CMD_OFF		0x0004
-#define PCIE_DEV_REV_OFF	0x0008
-#define PCIE_BAR_LO_OFF(n)	(0x0010 + ((n) << 3))
-#define PCIE_BAR_HI_OFF(n)	(0x0014 + ((n) << 3))
-#define PCIE_HEADER_LOG_4_OFF	0x0128
-#define PCIE_BAR_CTRL_OFF(n)	(0x1804 + ((n - 1) * 4))
-#define PCIE_WIN04_CTRL_OFF(n)	(0x1820 + ((n) << 4))
-#define PCIE_WIN04_BASE_OFF(n)	(0x1824 + ((n) << 4))
-#define PCIE_WIN04_REMAP_OFF(n)	(0x182c + ((n) << 4))
-#define PCIE_WIN5_CTRL_OFF	0x1880
-#define PCIE_WIN5_BASE_OFF	0x1884
-#define PCIE_WIN5_REMAP_OFF	0x188c
-#define PCIE_CONF_ADDR_OFF	0x18f8
-#define  PCIE_CONF_ADDR_EN		0x80000000
-#define  PCIE_CONF_REG(r)		((((r) & 0xf00) << 16) | ((r) & 0xfc))
-#define  PCIE_CONF_BUS(b)		(((b) & 0xff) << 16)
-#define  PCIE_CONF_DEV(d)		(((d) & 0x1f) << 11)
-#define  PCIE_CONF_FUNC(f)		(((f) & 0x7) << 8)
-#define PCIE_CONF_DATA_OFF	0x18fc
-#define PCIE_MASK_OFF		0x1910
-#define PCIE_CTRL_OFF		0x1a00
-#define  PCIE_CTRL_X1_MODE		0x0001
-#define PCIE_STAT_OFF		0x1a04
-#define  PCIE_STAT_DEV_OFFS		20
-#define  PCIE_STAT_DEV_MASK		0x1f
-#define  PCIE_STAT_BUS_OFFS		8
-#define  PCIE_STAT_BUS_MASK		0xff
-#define  PCIE_STAT_LINK_DOWN		1
-#define PCIE_DEBUG_CTRL         0x1a60
-#define  PCIE_DEBUG_SOFT_RESET		(1<<20)
-
-
-u32 orion_pcie_dev_id(void __iomem *base)
-{
-	return readl(base + PCIE_DEV_ID_OFF) >> 16;
-}
-
-u32 orion_pcie_rev(void __iomem *base)
-{
-	return readl(base + PCIE_DEV_REV_OFF) & 0xff;
-}
-
-int orion_pcie_link_up(void __iomem *base)
-{
-	return !(readl(base + PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
-}
-
-int __init orion_pcie_x4_mode(void __iomem *base)
-{
-	return !(readl(base + PCIE_CTRL_OFF) & PCIE_CTRL_X1_MODE);
-}
-
-int orion_pcie_get_local_bus_nr(void __iomem *base)
-{
-	u32 stat = readl(base + PCIE_STAT_OFF);
-
-	return (stat >> PCIE_STAT_BUS_OFFS) & PCIE_STAT_BUS_MASK;
-}
-
-void __init orion_pcie_set_local_bus_nr(void __iomem *base, int nr)
-{
-	u32 stat;
-
-	stat = readl(base + PCIE_STAT_OFF);
-	stat &= ~(PCIE_STAT_BUS_MASK << PCIE_STAT_BUS_OFFS);
-	stat |= nr << PCIE_STAT_BUS_OFFS;
-	writel(stat, base + PCIE_STAT_OFF);
-}
-
-void __init orion_pcie_reset(void __iomem *base)
-{
-	u32 reg;
-	int i;
-
-	/*
-	 * MV-S104860-U0, Rev. C:
-	 * PCI Express Unit Soft Reset
-	 * When set, generates an internal reset in the PCI Express unit.
-	 * This bit should be cleared after the link is re-established.
-	 */
-	reg = readl(base + PCIE_DEBUG_CTRL);
-	reg |= PCIE_DEBUG_SOFT_RESET;
-	writel(reg, base + PCIE_DEBUG_CTRL);
-
-	for (i = 0; i < 20; i++) {
-		mdelay(10);
-
-		if (orion_pcie_link_up(base))
-			break;
-	}
-
-	reg &= ~(PCIE_DEBUG_SOFT_RESET);
-	writel(reg, base + PCIE_DEBUG_CTRL);
-}
-
-/*
- * Setup PCIE BARs and Address Decode Wins:
- * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
- * WIN[0-3] -> DRAM bank[0-3]
- */
-static void __init orion_pcie_setup_wins(void __iomem *base)
-{
-	const struct mbus_dram_target_info *dram;
-	u32 size;
-	int i;
-
-	dram = mv_mbus_dram_info();
-
-	/*
-	 * First, disable and clear BARs and windows.
-	 */
-	for (i = 1; i <= 2; i++) {
-		writel(0, base + PCIE_BAR_CTRL_OFF(i));
-		writel(0, base + PCIE_BAR_LO_OFF(i));
-		writel(0, base + PCIE_BAR_HI_OFF(i));
-	}
-
-	for (i = 0; i < 5; i++) {
-		writel(0, base + PCIE_WIN04_CTRL_OFF(i));
-		writel(0, base + PCIE_WIN04_BASE_OFF(i));
-		writel(0, base + PCIE_WIN04_REMAP_OFF(i));
-	}
-
-	writel(0, base + PCIE_WIN5_CTRL_OFF);
-	writel(0, base + PCIE_WIN5_BASE_OFF);
-	writel(0, base + PCIE_WIN5_REMAP_OFF);
-
-	/*
-	 * Setup windows for DDR banks.  Count total DDR size on the fly.
-	 */
-	size = 0;
-	for (i = 0; i < dram->num_cs; i++) {
-		const struct mbus_dram_window *cs = dram->cs + i;
-
-		writel(cs->base & 0xffff0000, base + PCIE_WIN04_BASE_OFF(i));
-		writel(0, base + PCIE_WIN04_REMAP_OFF(i));
-		writel(((cs->size - 1) & 0xffff0000) |
-			(cs->mbus_attr << 8) |
-			(dram->mbus_dram_target_id << 4) | 1,
-				base + PCIE_WIN04_CTRL_OFF(i));
-
-		size += cs->size;
-	}
-
-	/*
-	 * Round up 'size' to the nearest power of two.
-	 */
-	if ((size & (size - 1)) != 0)
-		size = 1 << fls(size);
-
-	/*
-	 * Setup BAR[1] to all DRAM banks.
-	 */
-	writel(dram->cs[0].base, base + PCIE_BAR_LO_OFF(1));
-	writel(0, base + PCIE_BAR_HI_OFF(1));
-	writel(((size - 1) & 0xffff0000) | 1, base + PCIE_BAR_CTRL_OFF(1));
-}
-
-void __init orion_pcie_setup(void __iomem *base)
-{
-	u16 cmd;
-	u32 mask;
-
-	/*
-	 * Point PCIe unit MBUS decode windows to DRAM space.
-	 */
-	orion_pcie_setup_wins(base);
-
-	/*
-	 * Master + slave enable.
-	 */
-	cmd = readw(base + PCIE_CMD_OFF);
-	cmd |= PCI_COMMAND_IO;
-	cmd |= PCI_COMMAND_MEMORY;
-	cmd |= PCI_COMMAND_MASTER;
-	writew(cmd, base + PCIE_CMD_OFF);
-
-	/*
-	 * Enable interrupt lines A-D.
-	 */
-	mask = readl(base + PCIE_MASK_OFF);
-	mask |= 0x0f000000;
-	writel(mask, base + PCIE_MASK_OFF);
-}
-
-int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
-		       u32 devfn, int where, int size, u32 *val)
-{
-	writel(PCIE_CONF_BUS(bus->number) |
-		PCIE_CONF_DEV(PCI_SLOT(devfn)) |
-		PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
-		PCIE_CONF_REG(where) | PCIE_CONF_ADDR_EN,
-			base + PCIE_CONF_ADDR_OFF);
-
-	*val = readl(base + PCIE_CONF_DATA_OFF);
-
-	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
-	else if (size == 2)
-		*val = (*val >> (8 * (where & 3))) & 0xffff;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-int orion_pcie_rd_conf_tlp(void __iomem *base, struct pci_bus *bus,
-			   u32 devfn, int where, int size, u32 *val)
-{
-	writel(PCIE_CONF_BUS(bus->number) |
-		PCIE_CONF_DEV(PCI_SLOT(devfn)) |
-		PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
-		PCIE_CONF_REG(where) | PCIE_CONF_ADDR_EN,
-			base + PCIE_CONF_ADDR_OFF);
-
-	*val = readl(base + PCIE_CONF_DATA_OFF);
-
-	if (bus->number != orion_pcie_get_local_bus_nr(base) ||
-	    PCI_FUNC(devfn) != 0)
-		*val = readl(base + PCIE_HEADER_LOG_4_OFF);
-
-	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
-	else if (size == 2)
-		*val = (*val >> (8 * (where & 3))) & 0xffff;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
-			  u32 devfn, int where, int size, u32 *val)
-{
-	*val = readl(wa_base + (PCIE_CONF_BUS(bus->number) |
-				PCIE_CONF_DEV(PCI_SLOT(devfn)) |
-				PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
-				PCIE_CONF_REG(where)));
-
-	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
-	else if (size == 2)
-		*val = (*val >> (8 * (where & 3))) & 0xffff;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-int orion_pcie_wr_conf(void __iomem *base, struct pci_bus *bus,
-		       u32 devfn, int where, int size, u32 val)
-{
-	int ret = PCIBIOS_SUCCESSFUL;
-
-	writel(PCIE_CONF_BUS(bus->number) |
-		PCIE_CONF_DEV(PCI_SLOT(devfn)) |
-		PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
-		PCIE_CONF_REG(where) | PCIE_CONF_ADDR_EN,
-			base + PCIE_CONF_ADDR_OFF);
-
-	if (size == 4) {
-		writel(val, base + PCIE_CONF_DATA_OFF);
-	} else if (size == 2) {
-		writew(val, base + PCIE_CONF_DATA_OFF + (where & 3));
-	} else if (size == 1) {
-		writeb(val, base + PCIE_CONF_DATA_OFF + (where & 3));
-	} else {
-		ret = PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return ret;
-}
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 69a9d77039e8..fd40bc0f6296 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -952,11 +952,6 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	return pci_bridge_emul_init(bridge, bridge_flags);
 }
 
-static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
-{
-	return sys->private_data;
-}
-
 static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
 						    struct pci_bus *bus,
 						    int devfn)
-- 
2.53.0

