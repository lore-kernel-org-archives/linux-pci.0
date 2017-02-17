Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 17 Feb 2017 13:58:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci-hyperv: Use device serial number as PCI domain
Message-ID: <20170217195855.GB17762@bhelgaas-glaptop.roam.corp.google.com>
References: <BLUPR03MB1412C010C2F994101438FC5ACA590@BLUPR03MB1412.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLUPR03MB1412C010C2F994101438FC5ACA590@BLUPR03MB1412.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 13, 2017 at 06:10:11PM +0000, Haiyang Zhang wrote:
> 
> This allows PCI domain numbers starts with 1, and also unique
> on the same VM. So names, such as VF NIC names, that include
> domain number as part of the name, can be shorter than that
> based on part of bus UUID previously. The new names will also
> stay same for VMs created with copied VHD and same number of
> devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>

Applied to pci/host-hv for v4.11, thanks!

I assume Stephen meant a "Reviewed-by", not a "Signed-off-by", so that's
what I added.

> ---
>  drivers/pci/host/pci-hyperv.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 3efcc7b..b92b565 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1315,6 +1315,16 @@ static void put_pcichild(struct hv_pci_dev *hpdev,
>  	get_pcichild(hpdev, hv_pcidev_ref_initial);
>  	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
> +	/* When a device is being added into the bus, we set the PCI domain
> +	 * number to be the device serial number, which is non zero and
> +	 * unique on the same VM. The serial numbers start with 1, and
> +	 * increase by 1 for each device. So device names including this
> +	 * can have shorter names than based on the bus instance UUID.
> +	 * Only the first device serial number is used for domain, so the
> +	 * domain number will not change after the first device is added.
> +	 */
> +	if (list_empty(&hbus->children))
> +		hbus->sysdata.domain = desc->ser;
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	return hpdev;
> -- 
> 1.7.1
> 
