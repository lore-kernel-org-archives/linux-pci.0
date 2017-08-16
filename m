Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdHPSl4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 14:41:56 -0400
Date: Wed, 16 Aug 2017 13:41:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] PCI: keystone: Use PCI_NUM_INTX
Message-ID: <20170816184154.GC28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170815213724.8111.96859.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170815214430.GO32525@bhelgaas-glaptop.roam.corp.google.com>
 <59948A0F.4010304@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59948A0F.4010304@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 16, 2017 at 02:08:15PM -0400, Murali Karicheri wrote:
> On 08/15/2017 05:44 PM, Bjorn Helgaas wrote:
> > On Tue, Aug 15, 2017 at 04:37:24PM -0500, Bjorn Helgaas wrote:
> >> Switch from using a custom MAX_LEGACY_IRQS macro to the generic
> >> PCI_NUM_INTX definition for the number of INTx interrupts.
> >>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Murali Karicheri <m-karicheri2@ti.com>
> >> ---
> >>  drivers/pci/dwc/pci-keystone-dw.c |    4 ++--
> >>  drivers/pci/dwc/pci-keystone.h    |    1 -
> >>  2 files changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
> >> index df60f48716d9..3b0f206590f9 100644
> >> --- a/drivers/pci/dwc/pci-keystone-dw.c
> >> +++ b/drivers/pci/dwc/pci-keystone-dw.c
> >> @@ -251,7 +251,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
> >>  {
> >>  	int i;
> >>  
> >> -	for (i = 0; i < MAX_LEGACY_IRQS; i++)
> >> +	for (i = 0; i < PCI_NUM_INTX; i++)
> >>  		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
> >>  }
> >>  
> >> @@ -557,7 +557,7 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
> >>  	/* Create legacy IRQ domain */
> >>  	ks_pcie->legacy_irq_domain =
> >>  			irq_domain_add_linear(ks_pcie->legacy_intc_np,
> >> -					MAX_LEGACY_IRQS,
> >> +					PCI_NUM_INTX,
> >>  					&ks_dw_pcie_legacy_irq_domain_ops,
> >>  					NULL);
> >>  	if (!ks_pcie->legacy_irq_domain) {
> >> diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/dwc/pci-keystone.h
> >> index 74c5825882df..69fc60129f45 100644
> >> --- a/drivers/pci/dwc/pci-keystone.h
> >> +++ b/drivers/pci/dwc/pci-keystone.h
> >> @@ -12,7 +12,6 @@
> >>   * published by the Free Software Foundation.
> >>   */
> >>  
> >> -#define MAX_LEGACY_IRQS			4
> >>  #define MAX_MSI_HOST_IRQS		8
> >>  #define MAX_LEGACY_HOST_IRQS		4
> > 
> > BTW, Murali, what is MAX_LEGACY_HOST_IRQS?  Is that something we can
> > replace by PCI_NUM_INTX also?
> > 
> 
> It is the number of interrupts going to the ARM GIC controller for Legacy
> PCI interrupts. Corresponding for MSI is MAX_MSI_HOST_IRQS.  MAX_LEGACY_IRQS
> is for number of PCI Legacy irq line one PCI bus. In keystone case, it is
> 1 to 1. So it can be changed. 

Thanks, Murali.  I have the following patches on pci/host-keystone.  I
added one to remove duplicate definitions from pci-keystone.h and
pci-keystone.c.


commit 44b5557a13bdc04fda582b6fdfa3819792fbfe94
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Aug 16 13:32:34 2017 -0500

    PCI: keystone: Remove duplicate MAX_*_IRQS defs
    
    MAX_MSI_HOST_IRQS and MAX_LEGACY_HOST_IRQS are defined in both
    pci-keystone.h (which is included by pci-keystone.c) and in pci-keystone.c
    itself.
    
    Remove the duplicate definitions from pci-keystone.c.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Murali Karicheri <m-karicheri2@ti.com>

diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 4783cec1f78d..fb8504690923 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -32,10 +32,6 @@
 
 #define DRIVER_NAME	"keystone-pcie"
 
-/* driver specific constants */
-#define MAX_MSI_HOST_IRQS		8
-#define MAX_LEGACY_HOST_IRQS		4
-
 /* DEV_STAT_CTRL */
 #define PCIE_CAP_BASE		0x70
 

commit da4c4be36dc347b9b7eb0760054caa53e31abcc0
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Aug 15 16:27:57 2017 -0500

    PCI: keystone: Use PCI_NUM_INTX
    
    Switch from using custom MAX_LEGACY_IRQS and MAX_LEGACY_HOST_IRQS macros to
    the generic PCI_NUM_INTX definition for the number of INTx interrupts.
    
    Based-on-similar-patches-by: Paul Burton <paul.burton@imgtec.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Murali Karicheri <m-karicheri2@ti.com>

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index df60f48716d9..3b0f206590f9 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -251,7 +251,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
 {
 	int i;
 
-	for (i = 0; i < MAX_LEGACY_IRQS; i++)
+	for (i = 0; i < PCI_NUM_INTX; i++)
 		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
 }
 
@@ -557,7 +557,7 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 	/* Create legacy IRQ domain */
 	ks_pcie->legacy_irq_domain =
 			irq_domain_add_linear(ks_pcie->legacy_intc_np,
-					MAX_LEGACY_IRQS,
+					PCI_NUM_INTX,
 					&ks_dw_pcie_legacy_irq_domain_ops,
 					NULL);
 	if (!ks_pcie->legacy_irq_domain) {
diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index fb8504690923..9256b04e0c50 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -169,7 +169,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 
 	if (legacy) {
 		np_temp = &ks_pcie->legacy_intc_np;
-		max_host_irqs = MAX_LEGACY_HOST_IRQS;
+		max_host_irqs = PCI_NUM_INTX;
 		host_irqs = &ks_pcie->legacy_host_irqs[0];
 	} else {
 		np_temp = &ks_pcie->msi_intc_np;
diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/dwc/pci-keystone.h
index 74c5825882df..30b7bc2ac380 100644
--- a/drivers/pci/dwc/pci-keystone.h
+++ b/drivers/pci/dwc/pci-keystone.h
@@ -12,9 +12,7 @@
  * published by the Free Software Foundation.
  */
 
-#define MAX_LEGACY_IRQS			4
 #define MAX_MSI_HOST_IRQS		8
-#define MAX_LEGACY_HOST_IRQS		4
 
 struct keystone_pcie {
 	struct dw_pcie		*pci;
@@ -22,7 +20,7 @@ struct keystone_pcie {
 	/* PCI Device ID */
 	u32			device_id;
 	int			num_legacy_host_irqs;
-	int			legacy_host_irqs[MAX_LEGACY_HOST_IRQS];
+	int			legacy_host_irqs[PCI_NUM_INTX];
 	struct			device_node *legacy_intc_np;
 
 	int			num_msi_host_irqs;
