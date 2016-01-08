Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Jan 2016 12:08:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geliang Tang <geliangtang@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: use to_pci_dev
Message-ID: <20160108180858.GC5354@localhost>
References: <8ab09476f7fb0283031b973808740f40522bebe1.1450873511.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8ab09476f7fb0283031b973808740f40522bebe1.1450873511.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 23, 2015 at 08:28:12PM +0800, Geliang Tang wrote:
> Use to_pci_dev() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Both patches applied to pci/trivial for v4.5, thanks a lot, Geliang!

> ---
>  drivers/pci/hotplug/shpchp_sysfs.c | 2 +-
>  drivers/pci/pci.c                  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
> index 52875b3..392a40b 100644
> --- a/drivers/pci/hotplug/shpchp_sysfs.c
> +++ b/drivers/pci/hotplug/shpchp_sysfs.c
> @@ -43,7 +43,7 @@ static ssize_t show_ctrl (struct device *dev, struct device_attribute *attr, cha
>  	struct resource *res;
>  	struct pci_bus *bus;
>  
> -	pdev = container_of (dev, struct pci_dev, dev);
> +	pdev = to_pci_dev(dev);
>  	bus = pdev->subordinate;
>  
>  	out += sprintf(buf, "Free resources: memory\n");
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d1a7105..9356f90 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1417,7 +1417,7 @@ struct pci_devres {
>  
>  static void pcim_release(struct device *gendev, void *res)
>  {
> -	struct pci_dev *dev = container_of(gendev, struct pci_dev, dev);
> +	struct pci_dev *dev = to_pci_dev(gendev);
>  	struct pci_devres *this = res;
>  	int i;
>  
> -- 
> 2.5.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
