Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Aug 2013 14:50:36 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 8 (not CONFIG_PCI_MSI conflict)
Message-ID: <20130809185036.GG25111@titan.lakedaemon.net>
References: <20130808170822.82bf33d3cf5100f5e2646815@canb.auug.org.au>
 <5203F978.2050504@infradead.org>
 <20130809145939.GE25111@titan.lakedaemon.net>
 <52051BC2.2060004@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52051BC2.2060004@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Randy,

On Fri, Aug 09, 2013 at 09:41:38AM -0700, Randy Dunlap wrote:
> On 08/09/13 07:59, Jason Cooper wrote:
> > Randy,
> > 
> > On Thu, Aug 08, 2013 at 01:03:04PM -0700, Randy Dunlap wrote:
> >> On 08/08/13 00:08, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20130807:
> >>>
> >>
> >> on i386 and x86_64:
> >> when CONFIG_PCI_MSI is not enabled:
> >>
> >> There are many of these errors:
> >> include/linux/msi.h:65:6: error: expected identifier or '(' before 'void'
> >> include/linux/msi.h:65:6: error: expected ')' before numeric constant
> >>
> >> because arch/x86/include/asm/pci.h defines:
> >> #define default_teardown_msi_irqs	NULL
> > 
> > Do you have an example config you used?
> 
> Sure, attached. (or I have 14 of them)

Thanks, I was able to reproduce the error.  I'm not real familiar with
this area of the code, but the relief is it doesn't appear to be caused
by the mvebu changes (well, relief for us ;-) ).

At any rate, give this a spin and see if it works for you

If it's acceptable, I'll do an official patch for Bjorn.

thx,

Jason.

---------->8----------
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index d9e9e6c..6169414 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -138,8 +138,8 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq);
 #else
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
-#define default_teardown_msi_irqs	NULL
-#define default_restore_msi_irqs	NULL
+void __weak default_teardown_msi_irqs(struct pci_dev *dev) { }
+void __weak default_restore_msi_irqs(struct pci_dev *dev, int irq) { }
 #endif
 
 #define PCI_DMA_BUS_IS_PHYS (dma_ops->is_phys)
