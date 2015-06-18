Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Jun 2015 15:00:53 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Duc Dang <dhdang@apm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	patches@apm.com
Subject: Re: [PATCH 1/1] PCI: xgene: Allow config access to Root Port even
 when link is down
Message-ID: <20150618200053.GG7710@google.com>
References: <1434653139-14461-1-git-send-email-dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434653139-14461-1-git-send-email-dhdang@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 11:45:39AM -0700, Duc Dang wrote:
> Even if a Root Port's link is down, we should still be able to access the
> Port's configuration space.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  drivers/pci/host/pci-xgene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 7e3cf28..2e66c87 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -139,7 +139,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  {
>  	struct xgene_pcie_port *port = bus->sysdata;
>  
> -	if ((pci_is_root_bus(bus) && devfn != 0) || !port->link_up ||
> +	if ((pci_is_root_bus(bus) && devfn != 0) ||
>  	    xgene_pcie_hide_rc_bars(bus, offset))
>  		return NULL;
>  

Applied with changelog as follows to pci/host-xgene for v4.2, thanks!

commit 979595bcb8da04381ed85d3b0eb1f471cc5863e4
Author: Duc Dang <dhdang@apm.com>
Date:   Thu Jun 18 11:45:39 2015 -0700

    PCI: xgene: Allow config access to Root Port even when link is down
    
    Previously, when a Root Port's link was down, we didn't allow config access
    to the Root Port, which meant that if the Root Port led to an empty slot,
    "lspci" didn't even show the Root Port.
    
    Allow config access to Root Port even when link is down.
    
    [bhelgaas: changelog]
    Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Duc Dang <dhdang@apm.com>
    Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 70af714..1fc8910 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -139,7 +139,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 {
 	struct xgene_pcie_port *port = bus->sysdata;
 
-	if ((pci_is_root_bus(bus) && devfn != 0) || !port->link_up ||
+	if ((pci_is_root_bus(bus) && devfn != 0) ||
 	    xgene_pcie_hide_rc_bars(bus, offset))
 		return NULL;
 
