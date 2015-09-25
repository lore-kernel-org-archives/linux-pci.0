Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVXox9UbaQKZvatLwdqbEp6k9QpRcSCeFNROdK6=5qq2Q@mail.gmail.com>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
	<CAE9FiQWY1gdpzdqToBM0sNgfCRnRfEEgJfn-J9igorLH1K80JA@mail.gmail.com>
	<CAL-B5D0f10Q6C5jmjzysowDjJ=Z8iA1tSSAQwUp9qcxW-WeMPw@mail.gmail.com>
	<CAE9FiQVXox9UbaQKZvatLwdqbEp6k9QpRcSCeFNROdK6=5qq2Q@mail.gmail.com>
Date: Thu, 24 Sep 2015 21:35:20 -0700
Message-ID: <CAE9FiQWd69=6-UvCWsPOHvnZ96grJyzEt_+WR0-Q3M9wHz69hw@mail.gmail.com>
Subject: Re: [RFC] PCI: Unassigned Expansion ROM BARs
From: Yinghai Lu <yinghai@kernel.org>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 24, 2015 at 12:01 PM, Yinghai Lu <yinghai@kernel.org> wrote:

> Or do we want to keep a white list to say which device should have
> ROM bar as mush have, and other is optional to have ?

Subject: [RFC PATCH] PCI: Add pci_dev_need_rom_bar()

Only set that for
1. if BIOS/firmware already set ROM bar.
2. via quirks for some devices.

We assign those needed ROM bar as required
and other ROM bars as optional resources.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/x86/pci/i386.c        |    9 +++++-
 drivers/dma/pch_dma.c      |    1
 drivers/gpio/gpio-ml-ioh.c |    2 -
 drivers/misc/pch_phub.c    |   12 --------
 drivers/pci/probe.c        |    7 +++++
 drivers/pci/quirks.c       |   63 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c    |   18 ++++++++++--
 include/linux/pci.h        |   13 +++++++++
 include/linux/pci_ids.h    |    7 +++++
 9 files changed, 112 insertions(+), 20 deletions(-)

Index: linux-2.6/arch/x86/pci/i386.c
===================================================================
--- linux-2.6.orig/arch/x86/pci/i386.c
+++ linux-2.6/arch/x86/pci/i386.c
@@ -377,11 +377,16 @@ static void pcibios_allocate_rom_resourc
     }
 }

+bool pci_assign_roms(void)
+{
+    return !!(pci_probe & PCI_ASSIGN_ROMS);
+}
+
 static int __init pcibios_assign_resources(void)
 {
     struct pci_host_bridge *host_bridge = NULL;

-    if (!(pci_probe & PCI_ASSIGN_ROMS))
+    if (!pci_assign_roms())
         for_each_pci_host_bridge(host_bridge)
             pcibios_allocate_rom_resources(host_bridge->bus);

@@ -406,7 +411,7 @@ void pcibios_resource_survey_bus(struct
     pcibios_allocate_resources(bus, 0);
     pcibios_allocate_resources(bus, 1);

-    if (!(pci_probe & PCI_ASSIGN_ROMS))
+    if (!pci_assign_roms())
         pcibios_allocate_rom_resources(bus);
 }

Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -224,6 +224,13 @@ int __pci_read_base(struct pci_dev *dev,
         l64 = l & PCI_ROM_ADDRESS_MASK;
         sz64 = sz & PCI_ROM_ADDRESS_MASK;
         mask64 = (u32)PCI_ROM_ADDRESS_MASK;
+        /* simple validation */
+        if (l64 && sz64 &&
+            (l64 & 0xff000000) != 0xff000000 &&
+            system_state == SYSTEM_BOOTING) {
+            dev_printk(KERN_DEBUG, &dev->dev, "set dev_flags NEED_ROM_BAR\n");
+            pci_dev_set_need_rom_bar(dev);
+        }
     }

     if (res->flags & IORESOURCE_MEM_64) {
Index: linux-2.6/drivers/pci/quirks.c
===================================================================
--- linux-2.6.orig/drivers/pci/quirks.c
+++ linux-2.6/drivers/pci/quirks.c
@@ -4197,3 +4197,66 @@ static void quirk_intel_qat_vf_cap(struc
     }
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
+
+/* from drivers/mtd/maps/pci.c */
+static void quirk_set_need_rom_bar(struct pci_dev *pdev)
+{
+    if (!pci_dev_need_rom_bar(pdev)) {
+        dev_printk(KERN_DEBUG, &pdev->dev, "set dev_flags NEED_ROM_BAR\n");
+        pci_dev_set_need_rom_bar(pdev);
+    }
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285,
+             quirk_set_need_rom_bar);
+
+#ifdef CONFIG_PARISC
+/* from drivers/video/console/sticore.c */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_EG,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_FX6,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_FX4,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_FX2,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_FXE,
+             quirk_set_need_rom_bar);
+#endif
+
+/* from drivers/misc/pch_phub.c */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PCH1_PHUB,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ROHM, PCI_DEVICE_ID_ROHM_ML7213_PHUB,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ROHM, PCI_DEVICE_ID_ROHM_ML7223_mPHUB,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ROHM, PCI_DEVICE_ID_ROHM_ML7223_nPHUB,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ROHM, PCI_DEVICE_ID_ROHM_ML7831_PHUB,
+             quirk_set_need_rom_bar);
+
+/* from drivers/net/ethernet/sun/sungem.c */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_GEM,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_RIO_GEM,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMACP,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC2,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_GMAC,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_SUNGEM,
+             quirk_set_need_rom_bar);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID2_GMAC,
+             quirk_set_need_rom_bar);
+
+/* from drivers/net/ethernet/sun/sunhme.c */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_HAPPYMEAL,
+             quirk_set_need_rom_bar);
+
+/* from drm and fbdev */
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA,
+                8, quirk_set_need_rom_bar);
Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -226,6 +226,10 @@ static void pdev_assign_resources_prepar
         if (resource_disabled(r) || r->parent)
             continue;

+        if (i == PCI_ROM_RESOURCE &&
+            !pci_assign_roms() && !pci_dev_need_rom_bar(dev))
+            continue;
+
         if ((r->flags & IORESOURCE_IO) &&
             !pci_find_host_bridge(dev->bus)->has_ioport)
             continue;
@@ -1461,11 +1465,16 @@ out:
     return good_size;
 }

-static inline bool is_optional(int i)
+bool __weak pci_assign_roms(void)
+{
+    return false;
+}
+
+static inline bool is_optional(struct pci_dev *dev, int i)
 {

     if (i == PCI_ROM_RESOURCE)
-        return true;
+        return !pci_assign_roms() && !pci_dev_need_rom_bar(dev);

 #ifdef CONFIG_PCI_IOV
     if (i >= PCI_IOV_RESOURCES && i <= PCI_IOV_RESOURCE_END)
@@ -1538,7 +1547,7 @@ static int pbus_size_mem(struct pci_bus
             r_size = resource_size(r);
             align = pci_resource_alignment(dev, r);
             /* put SRIOV/ROM res to realloc list */
-            if (realloc_head && is_optional(i)) {
+            if (realloc_head && is_optional(dev, i)) {
                 add_to_align_test_list(&align_test_add_list,
                         align, r_size, &dev->dev, i);
                 r->end = r->start - 1;
@@ -1549,6 +1558,9 @@ static int pbus_size_mem(struct pci_bus
                     max_add_align = align;
                 continue;
             }
+            if (!realloc_head && i == PCI_ROM_RESOURCE &&
+                !pci_assign_roms() && !pci_dev_need_rom_bar(dev))
+                continue;

             if (align > (1ULL<<37)) { /*128 Gb*/
                 dev_warn(&dev->dev, "disabling BAR %d: %pR (bad
alignment %#llx)\n",
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -182,6 +182,8 @@ enum pci_dev_flags {
     PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
     /* Get VPD from function 0 VPD */
     PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
+    /* Need to have ROM BAR */
+    PCI_DEV_FLAGS_NEED_ROM_BAR = (__force pci_dev_flags_t) (1 << 9),
 };

 enum pci_irq_reroute_variant {
@@ -1965,6 +1967,14 @@ static inline bool pci_is_dev_assigned(s
 {
     return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) ==
PCI_DEV_FLAGS_ASSIGNED;
 }
+static inline void pci_dev_set_need_rom_bar(struct pci_dev *pdev)
+{
+    pdev->dev_flags |= PCI_DEV_FLAGS_NEED_ROM_BAR;
+}
+static inline bool pci_dev_need_rom_bar(struct pci_dev *pdev)
+{
+    return !!(pdev->dev_flags & PCI_DEV_FLAGS_NEED_ROM_BAR);
+}

 /**
  * pci_ari_enabled - query ARI forwarding status
@@ -1976,4 +1986,7 @@ static inline bool pci_ari_enabled(struc
 {
     return bus->self && bus->self->ari_enabled;
 }
+
+bool pci_assign_roms(void);
+
 #endif /* LINUX_PCI_H */
Index: linux-2.6/drivers/misc/pch_phub.c
===================================================================
--- linux-2.6.orig/drivers/misc/pch_phub.c
+++ linux-2.6/drivers/misc/pch_phub.c
@@ -49,7 +49,6 @@

 /* MAX number of INT_REDUCE_CONTROL registers */
 #define MAX_NUM_INT_REDUCE_CONTROL_REG 128
-#define PCI_DEVICE_ID_PCH1_PHUB 0x8801
 #define PCH_MINOR_NOS 1
 #define CLKCFG_CAN_50MHZ 0x12000000
 #define CLKCFG_CANCLK_MASK 0xFF000000
@@ -61,17 +60,6 @@
 #define CLKCFG_PLL2VCO                (8 << 9)
 #define CLKCFG_UARTCLKSEL            (1 << 18)

-/* Macros for ML7213 */
-#define PCI_VENDOR_ID_ROHM            0x10db
-#define PCI_DEVICE_ID_ROHM_ML7213_PHUB        0x801A
-
-/* Macros for ML7223 */
-#define PCI_DEVICE_ID_ROHM_ML7223_mPHUB    0x8012 /* for Bus-m */
-#define PCI_DEVICE_ID_ROHM_ML7223_nPHUB    0x8002 /* for Bus-n */
-
-/* Macros for ML7831 */
-#define PCI_DEVICE_ID_ROHM_ML7831_PHUB 0x8801
-
 /* SROM ACCESS Macro */
 #define PCH_WORD_ADDR_MASK (~((1 << 2) - 1))

Index: linux-2.6/include/linux/pci_ids.h
===================================================================
--- linux-2.6.orig/include/linux/pci_ids.h
+++ linux-2.6/include/linux/pci_ids.h
@@ -1122,6 +1122,12 @@
 #define PCI_VENDOR_ID_TCONRAD        0x10da
 #define PCI_DEVICE_ID_TCONRAD_TOKENRING    0x0508

+#define PCI_VENDOR_ID_ROHM             0x10DB
+#define PCI_DEVICE_ID_ROHM_ML7213_PHUB          0x801A
+#define PCI_DEVICE_ID_ROHM_ML7223_mPHUB 0x8012 /* for Bus-m */
+#define PCI_DEVICE_ID_ROHM_ML7223_nPHUB 0x8002 /* for Bus-n */
+#define PCI_DEVICE_ID_ROHM_ML7831_PHUB 0x8801
+
 #define PCI_VENDOR_ID_NVIDIA            0x10de
 #define PCI_DEVICE_ID_NVIDIA_TNT        0x0020
 #define PCI_DEVICE_ID_NVIDIA_TNT2        0x0028
@@ -2900,6 +2906,7 @@
 #define PCI_DEVICE_ID_INTEL_82454NX     0x84cb
 #define PCI_DEVICE_ID_INTEL_84460GX    0x84ea
 #define PCI_DEVICE_ID_INTEL_IXP4XX    0x8500
+#define PCI_DEVICE_ID_PCH1_PHUB 0x8801
 #define PCI_DEVICE_ID_INTEL_IXP2800    0x9004
 #define PCI_DEVICE_ID_INTEL_S21152BB    0xb152

Index: linux-2.6/drivers/dma/pch_dma.c
===================================================================
--- linux-2.6.orig/drivers/dma/pch_dma.c
+++ linux-2.6/drivers/dma/pch_dma.c
@@ -976,7 +976,6 @@ static void pch_dma_remove(struct pci_de
 }

 /* PCI Device ID of DMA device */
-#define PCI_VENDOR_ID_ROHM             0x10DB
 #define PCI_DEVICE_ID_EG20T_PCH_DMA_8CH        0x8810
 #define PCI_DEVICE_ID_EG20T_PCH_DMA_4CH        0x8815
 #define PCI_DEVICE_ID_ML7213_DMA1_8CH    0x8026
Index: linux-2.6/drivers/gpio/gpio-ml-ioh.c
===================================================================
--- linux-2.6.orig/drivers/gpio/gpio-ml-ioh.c
+++ linux-2.6/drivers/gpio/gpio-ml-ioh.c
@@ -31,8 +31,6 @@

 #define IOH_IRQ_BASE        0

-#define PCI_VENDOR_ID_ROHM             0x10DB
-
 struct ioh_reg_comn {
     u32    ien;
     u32    istatus;
