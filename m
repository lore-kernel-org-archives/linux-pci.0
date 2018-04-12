Return-Path: <SRS0=RiBJ=HB=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=RiBJ=HB=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 12 Apr 2018 10:17:42 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Message-ID: <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2018 at 02:44:42AM +0000, Sridhar Pitchai wrote:
> When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual PCI
> bus to the guest, Hyper-V always provides unique PCI domain.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> overrode unique domain with the serial number of the first device added to
> the virtual PCI bus.
> 
> The reason for that patch was to have a consistent and short name for the
> device, but Hyper-V doesn't provide unique serial numbers. Using non-unique
> serial numbers as domain IDs leads to duplicate device addresses, which
> causes PCI bus registration to fail.
> 
> Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") so we can reliably support multiple devices being assigned to
> a guest.
> 
> Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> Cc: stable@vger.kernel.org

I am still not happy with this patch.

-  You do not explain at all the dependency on commit 0c195567a8f6 and
   you should because that's fundamental, if that patch is not present
   this revert breaks the kernel as per previous discussions[1].
-  You are sending this patch to all stable kernels that contain the
   commit you are fixing - some that may not contain the commit above
   (that was merged in v4.14), you are breaking those kernels, if not
   explain me why please

You must mark the stable kernels you want this revert to be applied to
eg:

Cc: <stable@vger.kernel.org> # v4.14+

and for kernels that do not contain the 0c195567a8f6 commit you have to
add the dependency. Please read the documentation Greg provided you in
relation to stable kernel rules.

Use:

git tag --contains

to detect in what kernel version the given commits are present.

[1] https://marc.info/?l=linux-pci&m=152158684221212&w=2

> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> Changes in v7:
> * fix the commit comment. [Bjorn Helgaas]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38eab785..ac67e56e451a 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  
> -	/*
> -	 * When a device is being added to the bus, we set the PCI domain
> -	 * number to be the device serial number, which is non-zero and
> -	 * unique on the same VM.  The serial numbers start with 1, and
> -	 * increase by 1 for each device.  So device names including this
> -	 * can have shorter names than based on the bus instance UUID.
> -	 * Only the first device serial number is used for domain, so the
> -	 * domain number will not change after the first device is added.
> -	 */
> -	if (list_empty(&hbus->children))
> -		hbus->sysdata.domain = desc->ser;
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	return hpdev;
> -- 
> 2.14.1
> 
