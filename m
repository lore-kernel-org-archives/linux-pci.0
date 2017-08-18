Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 17 Aug 2017 22:00:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V10 1/3] PCI: introduce pci_bus_wait_crs() function
Message-ID: <20170818030009.GK28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 11, 2017 at 12:56:34PM -0400, Sinan Kaya wrote:
> Kernel is hiding Configuration Request Retry Status (CRS) inside
> pci_bus_read_dev_vendor_id() function. We are looking to add support for
> Function Level Reset (FLR) where vendor id read returns ~0.
> 
> Move CRS handling into its own function so that it can be called from other
> places as well.

I think this is a much better idea than what I proposed.  I still have
a few questions proposals.  I'll post a v11 to show what I'm thinking.

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.h   |  2 ++
>  drivers/pci/probe.c | 44 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 22e0617..1bbe851 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -235,6 +235,8 @@ enum pci_bar_type {
>  	pci_bar_mem64,		/* A 64-bit memory BAR */
>  };
>  
> +bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
> +		      int crs_timeout);
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  				int crs_timeout);
>  int pci_setup_device(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c31310d..b1cb7bd 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1824,29 +1824,17 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_alloc_dev);
>  
> -bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> -				int crs_timeout)
> +bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int crs_timeout)
>  {
>  	int delay = 1;
>  
> -	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> -		return false;
> -
> -	/* some broken boards return 0 or ~0 if a slot is empty: */
> -	if (*l == 0xffffffff || *l == 0x00000000 ||
> -	    *l == 0x0000ffff || *l == 0xffff0000)
> -		return false;
> -
>  	/*
>  	 * Configuration Request Retry Status.  Some root ports return the
>  	 * actual device ID instead of the synthetic ID (0xFFFF) required
>  	 * by the PCIe spec.  Ignore the device ID and only check for
>  	 * (vendor id == 1).
>  	 */
> -	while ((*l & 0xffff) == 0x0001) {
> -		if (!crs_timeout)
> -			return false;
> -
> +	do {
>  		msleep(delay);
>  		delay *= 2;
>  		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> @@ -1858,6 +1846,34 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  			       PCI_FUNC(devfn));
>  			return false;

While staring at this, I think I found a pre-existing bug in
pci_bus_read_dev_vendor_id().  It looks like this:

  while ((*l & 0xffff) == 0x0001) {
    pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l);
    if (delay > crs_timeout)
      return false;
  }

The problem is that the config read may have *succeeded* that last
time before we time out.  I think the correct sequence is:

  - check for timeout
  - read PCI_VENDOR_ID
  - check for CRS

>  		}
> +	} while ((*l & 0xffff) == 0x0001);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(pci_bus_wait_crs);

I don't think we need EXPORT_SYMBOL here, do we?

> +bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +				int crs_timeout)
> +{
> +	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> +		return false;
> +
> +	/* some broken boards return 0 or ~0 if a slot is empty: */
> +	if (*l == 0xffffffff || *l == 0x00000000 ||
> +	    *l == 0x0000ffff || *l == 0xffff0000)
> +		return false;
> +
> +	/*
> +	 * Configuration Request Retry Status.  Some root ports return the
> +	 * actual device ID instead of the synthetic ID (0xFFFF) required
> +	 * by the PCIe spec.  Ignore the device ID and only check for
> +	 * (vendor id == 1).
> +	 */
> +	if ((*l & 0xffff) == 0x0001) {
> +		if (!crs_timeout)
> +			return false;

One thing I don't like is that every caller of pci_bus_wait_crs() has
to know about the 0x0001 value.

> +		return pci_bus_wait_crs(bus, devfn, l, crs_timeout);
>  	}
>  
>  	return true;
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
