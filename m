Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57078 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858Ab3DVGg0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Apr 2013 02:36:26 -0400
Message-ID: <1366612577.2723.21.camel@pasglop>
Subject: Re: [PATCH] PowerNV/PCI: Fix NULL PCI controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de
Date: Mon, 22 Apr 2013 16:36:17 +1000
In-Reply-To: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-04-22 at 02:13 -0400, Mike Qiu wrote:
> In pnv_pci_read_config() or pnv_pci_write_config(), we never check if
> the PCI controller is valid before converting that into platform
> dependent one, this is very dangerous. 
> 
> To avoid this potential risks, the patch check PCI controller first
> before use it.

I don't think there's any remote possibility of that happening, is
there ?

If it does, maybe it warrants a WARN_ON...

Ben.

> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index b8b8e0b..e7b7f1a 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -286,11 +286,11 @@ static int pnv_pci_read_config(struct pci_bus *bus,
>  			       int where, int size, u32 *val)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(bus);
> -	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_phb *phb = hose ? hose->private_data : NULL;
>  	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
>  	s64 rc;
>  
> -	if (hose == NULL)
> +	if (!phb)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	switch (size) {
> @@ -330,10 +330,10 @@ static int pnv_pci_write_config(struct pci_bus *bus,
>  				int where, int size, u32 val)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(bus);
> -	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_phb *phb = hose ? hose->private_data : NULL;
>  	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
>  
> -	if (hose == NULL)
> +	if (!phb)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	cfg_dbg("pnv_pci_write_config bus: %x devfn: %x +%x/%x -> %08x\n",


