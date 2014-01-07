Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v7 05/15] agp: Use pci_resource_start() to get CPU physical
 address for BAR
To: linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Airlie <airlied@linux.ie>, Yinghai Lu <yinghai@kernel.org>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Date: Mon, 06 Jan 2014 17:55:47 -0700
Message-ID: <20140107005547.10786.23438.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

amd_irongate_configure(), ati_configure(), and nvidia_configure() call
ioremap() on an address read directly from a BAR.  But a BAR contains a
bus address, and ioremap() expects a CPU physical address.  Use
pci_resource_start() to obtain the physical address.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/amd-k7-agp.c |    8 ++++----
 drivers/char/agp/ati-agp.c    |    8 ++++----
 drivers/char/agp/nvidia-agp.c |    4 +++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 9898ed6d5b9a..e8c2e9167e89 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include "agp.h"
 
-#define AMD_MMBASE	0x14
+#define AMD_MMBASE_BAR	1
 #define AMD_APSIZE	0xac
 #define AMD_MODECNTL	0xb0
 #define AMD_MODECNTL2	0xb2
@@ -205,6 +205,7 @@ static int amd_irongate_fetch_size(void)
 static int amd_irongate_configure(void)
 {
 	struct aper_size_info_lvl2 *current_size;
+	phys_addr_t reg;
 	u32 temp;
 	u16 enable_reg;
 
@@ -212,9 +213,8 @@ static int amd_irongate_configure(void)
 
 	if (!amd_irongate_private.registers) {
 		/* Get the memory mapped registers */
-		pci_read_config_dword(agp_bridge->dev, AMD_MMBASE, &temp);
-		temp = (temp & PCI_BASE_ADDRESS_MEM_MASK);
-		amd_irongate_private.registers = (volatile u8 __iomem *) ioremap(temp, 4096);
+		reg = pci_resource_start(agp_bridge->dev, AMD_MMBASE_BAR);
+		amd_irongate_private.registers = (volatile u8 __iomem *) ioremap(reg, 4096);
 		if (!amd_irongate_private.registers)
 			return -ENOMEM;
 	}
diff --git a/drivers/char/agp/ati-agp.c b/drivers/char/agp/ati-agp.c
index 53cb310d433e..ba83c11186ce 100644
--- a/drivers/char/agp/ati-agp.c
+++ b/drivers/char/agp/ati-agp.c
@@ -12,7 +12,7 @@
 #include <asm/agp.h>
 #include "agp.h"
 
-#define ATI_GART_MMBASE_ADDR	0x14
+#define ATI_GART_MMBASE_BAR	1
 #define ATI_RS100_APSIZE	0xac
 #define ATI_RS100_IG_AGPMODE	0xb0
 #define ATI_RS300_APSIZE	0xf8
@@ -196,12 +196,12 @@ static void ati_cleanup(void)
 
 static int ati_configure(void)
 {
+	phys_addr_t reg;
 	u32 temp;
 
 	/* Get the memory mapped registers */
-	pci_read_config_dword(agp_bridge->dev, ATI_GART_MMBASE_ADDR, &temp);
-	temp = (temp & 0xfffff000);
-	ati_generic_private.registers = (volatile u8 __iomem *) ioremap(temp, 4096);
+	reg = pci_resource_start(agp_bridge->dev, ATI_GART_MMBASE_BAR);
+	ati_generic_private.registers = (volatile u8 __iomem *) ioremap(reg, 4096);
 
 	if (!ati_generic_private.registers)
 		return -ENOMEM;
diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index ab65d55272c4..a1861b75eb31 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -106,6 +106,7 @@ static int nvidia_configure(void)
 {
 	int i, rc, num_dirs;
 	u32 apbase, aplimit;
+	phys_addr_t apbase_phys;
 	struct aper_size_info_8 *current_size;
 	u32 temp;
 
@@ -152,8 +153,9 @@ static int nvidia_configure(void)
 	pci_write_config_dword(agp_bridge->dev, NVIDIA_0_APSIZE, temp | 0x100);
 
 	/* map aperture */
+	apbase_phys = pci_resource_start(agp_bridge->dev, AGP_APERTURE_BAR);
 	nvidia_private.aperture =
-		(volatile u32 __iomem *) ioremap(apbase, 33 * PAGE_SIZE);
+		(volatile u32 __iomem *) ioremap(apbase_phys, 33 * PAGE_SIZE);
 
 	if (!nvidia_private.aperture)
 		return -ENOMEM;

