Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Feb 2015 12:27:39 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
	lorenzo.pieralisi@arm.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org
Subject: Re: [PATCH 3/6] x86, acpi, pci: Move PCI config space accessors.
Message-ID: <20150218182739.GA17462@google.com>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
 <1416413091-13452-4-git-send-email-tomasz.nowicki@linaro.org>
 <20141210231746.GF6692@google.com>
 <54E33C05.9010300@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54E33C05.9010300@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 17, 2015 at 02:03:01PM +0100, Tomasz Nowicki wrote:
> On 11.12.2014 00:17, Bjorn Helgaas wrote:
> >On Wed, Nov 19, 2014 at 05:04:48PM +0100, Tomasz Nowicki wrote:
> >>We are going to use mmio_config_{} name convention across all architectures.
> >
> >mmio_config_*() are workarounds for an AMD Fam10h defect [1].  I would prefer
> >not to extend these names to other architectures, because they should be
> >able to use readb()/writeb()/etc. directly, as we did on x86 before
> >3320ad994afb ("x86: Work around mmio config space quirk on AMD Fam10h").
> >
> >In fact, it would be nice if we could use readb()/writeb()/etc. on x86, and
> >only use mmio_config_*() when we're on AMD Fam10h.  Maybe there could be a
> >"struct pci_raw_ops pci_mmcfg_amd_fam10h" that used mmio_config_*(), and we
> >could set raw_pci_ext_ops to those ops instead of the default ones when
> >we're on AMD Fam10h.  Then x86 should be able to use the generic
> >readb()-based ops on most platforms.
> 
> While I do agree we should use readb()/writeb()... methods, I am not
> sure there is a nice way to use mmio_config_*() exclusively for AMD
> Fam10h. For x86, right now, we have three PCI config accessors sets:
> mmconfig_32.c, mmconfig_64.c, numachip.c and each are different. So
> one pci_mmcfg_amd_fam10h pci_raw_ops is not enough. I am thinking of
> having additional structure (integrated with "struct
> pci_mmcfg_region") that keeps MMIO accessors where readb()/writeb()
> would be the default one. For AMD Fam10h case we could tweak it as
> necessary. What do you thing Bjorn?

It's OK if we use mmio_config_*() for all x86 (not just AMD Fam10h); that's
what we do today.  It'd be *nicer* if we could use the workaround only for
Fam10h, but if it complicates the code, don't bother.

My main point is that I think your v1 posting requires every arch to
implement mmio_config_*(), and they will all be the same.  If an arch
doesn't require a workaround, it shouldn't have to supply anything and we
should default to readb/writeb/etc.

> >[1] 3320ad994afb ("x86: Work around mmio config space quirk on AMD Fam10h")
> >
> >Somewhere in this process, I'd like to update the AMD Fam10h comment to fix
> >the typos and reference the spec that talks about this, i.e., the "BIOS and
> >Kernel Developer's Guide (BKDG) For AMD Family 10h Processors," rev 3.48,
> >sec 2.11.1, "MMIO Configuration Coding Requirements."
> >
> >That can be a separate patch since it's only cosmetic.
> >
> >>Currently it belongs to asm/pci_x86.h header which should be included
> >>only for x86 specific files. From now on, those accessors are in asm/pci.h
> >>header which can be included in non-architecture code much easier.
> >>
> >>Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >>Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>---
> >>  arch/x86/include/asm/pci.h     | 42 +++++++++++++++++++++++++++++++++++++++++
> >>  arch/x86/include/asm/pci_x86.h | 43 ------------------------------------------
> >>  2 files changed, 42 insertions(+), 43 deletions(-)
> >>
> >>diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> >>index 0892ea0..5ba3720 100644
> >>--- a/arch/x86/include/asm/pci.h
> >>+++ b/arch/x86/include/asm/pci.h
> >>@@ -71,6 +71,48 @@ void pcibios_set_master(struct pci_dev *dev);
> >>  struct irq_routing_table *pcibios_get_irq_routing_table(void);
> >>  int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
> >>
> >>+/*
> >>+ * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
> >>+ * on their northbrige except through the * %eax register. As such, you MUST
> >>+ * NOT use normal IOMEM accesses, you need to only use the magic mmio-config
> >>+ * accessor functions.
> >>+ * In fact just use pci_config_*, nothing else please.
> >>+ */
> >>+static inline unsigned char mmio_config_readb(void __iomem *pos)
> >>+{
> >>+	u8 val;
> >>+	asm volatile("movb (%1),%%al" : "=a" (val) : "r" (pos));
> >>+	return val;
> >>+}
> >>+
> >>+static inline unsigned short mmio_config_readw(void __iomem *pos)
> >>+{
> >>+	u16 val;
> >>+	asm volatile("movw (%1),%%ax" : "=a" (val) : "r" (pos));
> >>+	return val;
> >>+}
> >>+
> >>+static inline unsigned int mmio_config_readl(void __iomem *pos)
> >>+{
> >>+	u32 val;
> >>+	asm volatile("movl (%1),%%eax" : "=a" (val) : "r" (pos));
> >>+	return val;
> >>+}
> >>+
> >>+static inline void mmio_config_writeb(void __iomem *pos, u8 val)
> >>+{
> >>+	asm volatile("movb %%al,(%1)" : : "a" (val), "r" (pos) : "memory");
> >>+}
> >>+
> >>+static inline void mmio_config_writew(void __iomem *pos, u16 val)
> >>+{
> >>+	asm volatile("movw %%ax,(%1)" : : "a" (val), "r" (pos) : "memory");
> >>+}
> >>+
> >>+static inline void mmio_config_writel(void __iomem *pos, u32 val)
> >>+{
> >>+	asm volatile("movl %%eax,(%1)" : : "a" (val), "r" (pos) : "memory");
> >>+}
> >>
> >>  #define HAVE_PCI_MMAP
> >>  extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> >>diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> >>index caba141..42e7332 100644
> >>--- a/arch/x86/include/asm/pci_x86.h
> >>+++ b/arch/x86/include/asm/pci_x86.h
> >>@@ -121,49 +121,6 @@ extern int __init pcibios_init(void);
> >>  extern int pci_legacy_init(void);
> >>  extern void pcibios_fixup_irqs(void);
> >>
> >>-/*
> >>- * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
> >>- * on their northbrige except through the * %eax register. As such, you MUST
> >>- * NOT use normal IOMEM accesses, you need to only use the magic mmio-config
> >>- * accessor functions.
> >>- * In fact just use pci_config_*, nothing else please.
> >>- */
> >>-static inline unsigned char mmio_config_readb(void __iomem *pos)
> >>-{
> >>-	u8 val;
> >>-	asm volatile("movb (%1),%%al" : "=a" (val) : "r" (pos));
> >>-	return val;
> >>-}
> >>-
> >>-static inline unsigned short mmio_config_readw(void __iomem *pos)
> >>-{
> >>-	u16 val;
> >>-	asm volatile("movw (%1),%%ax" : "=a" (val) : "r" (pos));
> >>-	return val;
> >>-}
> >>-
> >>-static inline unsigned int mmio_config_readl(void __iomem *pos)
> >>-{
> >>-	u32 val;
> >>-	asm volatile("movl (%1),%%eax" : "=a" (val) : "r" (pos));
> >>-	return val;
> >>-}
> >>-
> >>-static inline void mmio_config_writeb(void __iomem *pos, u8 val)
> >>-{
> >>-	asm volatile("movb %%al,(%1)" : : "a" (val), "r" (pos) : "memory");
> >>-}
> >>-
> >>-static inline void mmio_config_writew(void __iomem *pos, u16 val)
> >>-{
> >>-	asm volatile("movw %%ax,(%1)" : : "a" (val), "r" (pos) : "memory");
> >>-}
> >>-
> >>-static inline void mmio_config_writel(void __iomem *pos, u32 val)
> >>-{
> >>-	asm volatile("movl %%eax,(%1)" : : "a" (val), "r" (pos) : "memory");
> >>-}
> >>-
> >>  #ifdef CONFIG_PCI
> >>  # ifdef CONFIG_ACPI
> >>  #  define x86_default_pci_init		pci_acpi_init
> >>--
> >>1.9.1
> >>
