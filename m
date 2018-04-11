Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Apr 2018 15:16:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] PCI: hv: Make sure the bus domain is really unique
Message-ID: <20180411201634.GB105104@bhelgaas-glaptop.roam.corp.google.com>
References: <9496B0D1-CC19-42F4-BE50-DEA4EFC8D615@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9496B0D1-CC19-42F4-BE50-DEA4EFC8D615@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I would make the subject:

  Revert "PCI: hv: Use device serial number as PCI domain"

so it matches the original commit.  Otherwise you really need quite a
lot of driver internal knowledge to connect them.

On Wed, Apr 11, 2018 at 12:36:25AM +0000, Sridhar Pitchai wrote:
> When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
> PCI bus to the guest, Hyper-V always provides unique PCI domain.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> overrode unique domain with the serial number of the first device added
> to the virtual PCI bus. The reason for that patch is to have a consistent
> and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
> device serial number as PCI domain") will not guarantee unique domain id.

Possible alternate text:

  The reason for that patch was to have a consistent and short name
  for the device, but Hyper-V doesn't provide unique serial numbers
  (in spite of the code comment claiming that it does).  Using
  non-unique serial numbers as domain IDs leads to duplicate device
  addresses, which causes PCI bus registration to fail.
  
> For example, if the serial number of the device is 0 and there exists a
> PCI bus with domain 0 already, this will cause the PCI bus registration
> with kernel fails.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") need to be reverted.

I think the above sentence is redundant and could be removed.

> Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") so we can reliably support multiple devices being assigned to
> a guest.
> 
> Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> Cc: stable@vger.kernel.org

Regardless of what you do with the feedback above,

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks a lot for persisting with this!

> ---
> Changes in v6:
> * fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
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
