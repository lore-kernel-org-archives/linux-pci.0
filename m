Return-Path: <SRS0=WfuT=HW=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=WfuT=HW=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 3 May 2018 12:35:04 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] PCI: hv: Make sure the bus domain is really unique
Message-ID: <20180503113504.GA21781@e107981-ln.cambridge.arm.com>
References: <6E619990-8EFD-4688-8C01-8D9C480B04AF@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E619990-8EFD-4688-8C01-8D9C480B04AF@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 01, 2018 at 05:56:32PM +0000, Sridhar Pitchai wrote:
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
> commit 0c195567a8f6 ("netvsc: transparent VF management") avoids the need
> for commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain").  When scripts were used to configure VF devices, the name of
> the VF needed to be consistent and short, but with commit 0c195567a8f6
> ("netvsc: transparent VF management") all the setup is done in the kernel,
> and we do not need to maintain consistent name.
> 
> Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") so we can reliably support multiple devices being assigned to
> a guest.
> 
> This revert should only be backported to kernels that contain commit
> 0c195567a8f6 ("netvsc: transparent VF management").

I removed this last paragraph, the information is in the stable tag
below.

> Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> Cc: stable@vger.kernel.org # v4.14+
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> Changes in v8:
> * fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)

Applied to pci/hv for v4.18, thanks.

Lorenzo

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
> 
