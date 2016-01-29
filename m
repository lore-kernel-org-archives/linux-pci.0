Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 11:30:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rafal Milecki <zajec5@gmail.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Remove redundant function number check for
 PAXC
Message-ID: <20160129173041.GD12965@localhost>
References: <1454024240-12270-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454024240-12270-1-git-send-email-rjui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ray,

On Thu, Jan 28, 2016 at 03:37:20PM -0800, Ray Jui wrote:
> This patch removes the conditional check that limits the number of
> functions to be supported by the internally emulated endpoint device
> connected to PAXC. Investigation shows that the emulated PAXC endpoint
> device can properly reject request for unsupported functions, which
> makes this conditional check redundant
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 9ae43ed..b65185d 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -204,7 +204,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>  	 * allows only one device and supports a limited number of functions.
>  	 */
>  	if (pcie->type == IPROC_PCIE_PAXC)
> -		if (slot > 0 || fn >= MAX_NUM_PAXC_PF)
> +		if (slot > 0)
>  			return NULL;
>  
>  	/* EP device access */

Thanks for checking this out.  I removed the now-unused
MAX_NUM_PAXC_PF and folded this into the first patch, resulting in
the combined patch below.

I'm sorry to say that I have yet one more question.  It looks somewhat
hacky to have the PAXC-specific "slot > 0" test, and I'm not sure it
should be necessary (again, unless there's some implementation
deficiency in that PAXC embedded endpoint).  I'm looking at section
7.3 in the spec, and it seems like that endpoint *should* handle 
a config transaction with a non-zero Device Number, i.e., "slot", as
an Unsupported Request.  This should be standard behavior for all PCIe
endpoints -- we can generate config transactions like that on all root
complexes on all systems, so all endpoints should be able to handle
it.

Bjorn


commit 46560388c476c8471fde7712c10f9fad8d0d1875
Author: Ray Jui <rjui@broadcom.com>
Date:   Wed Jan 27 16:52:24 2016 -0600

    PCI: iproc: Allow multiple devices except on PAXC
    
    Commit 943ebae781f5 ("PCI: iproc: Add PAXC interface support") only allowed
    device 0, which is a regression on BCMA-based platforms.
    
    All systems support only one device, a Root Port at 00:00.0, on the root
    bus.  PAXC-based systems support only the Root Port (00:00.0) and a single
    device (with multiple functions) below it, e.g., 01:00.0, 01:00.1, etc.
    Non-PAXC systems support arbitrary devices below the Root Port.
    
    [bhelgaas: changelog, fold in removal of MAX_NUM_PAXC_PF check]
    Fixes: 943ebae781f5 ("PCI: iproc: Add PAXC interface support")
    Reported-by: Rafal Milecki <zajec5@gmail.com>
    Signed-off-by: Ray Jui <rjui@broadcom.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 5816bce..a576aee 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -64,7 +64,6 @@
 #define OARR_SIZE_CFG                BIT(OARR_SIZE_CFG_SHIFT)
 
 #define MAX_NUM_OB_WINDOWS           2
-#define MAX_NUM_PAXC_PF              4
 
 #define IPROC_PCIE_REG_INVALID 0xffff
 
@@ -170,20 +169,6 @@ static inline void iproc_pcie_ob_write(struct iproc_pcie *pcie,
 	writel(val, pcie->base + offset + (window * 8));
 }
 
-static inline bool iproc_pcie_device_is_valid(struct iproc_pcie *pcie,
-					      unsigned int slot,
-					      unsigned int fn)
-{
-	if (slot > 0)
-		return false;
-
-	/* PAXC can only support limited number of functions */
-	if (pcie->type == IPROC_PCIE_PAXC && fn >= MAX_NUM_PAXC_PF)
-		return false;
-
-	return true;
-}
-
 /**
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
@@ -199,11 +184,11 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 	u32 val;
 	u16 offset;
 
-	if (!iproc_pcie_device_is_valid(pcie, slot, fn))
-		return NULL;
-
 	/* root complex access */
 	if (busno == 0) {
+		if (slot > 0 || fn > 0)
+			return NULL;
+
 		iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_IND_ADDR,
 				     where & CFG_IND_ADDR_MASK);
 		offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_IND_DATA);
@@ -213,6 +198,14 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 			return (pcie->base + offset);
 	}
 
+	/*
+	 * PAXC is connected to an internally emulated EP within the SoC.  It
+	 * allows only one device.
+	 */
+	if (pcie->type == IPROC_PCIE_PAXC)
+		if (slot > 0)
+			return NULL;
+
 	/* EP device access */
 	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
 		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
