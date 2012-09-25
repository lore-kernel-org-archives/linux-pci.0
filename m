Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47822 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab2IYOvu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 10:51:50 -0400
Received: by pbbrr4 with SMTP id rr4so232149pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 07:51:50 -0700 (PDT)
Message-ID: <5061C4FD.6070407@gmail.com>
Date: Tue, 25 Sep 2012 22:51:41 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 12/29] PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org> <1348561590-28067-13-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-13-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/25/2012 04:26 PM, Yinghai Lu wrote:
> use bus_find_device to loop host_bridges.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/search.c |   23 +++++++++++++++++++++++
>  include/linux/pci.h  |    3 +++
>  2 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index bf969ba..f072b54 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -178,6 +178,29 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
>  }
>  EXPORT_SYMBOL(pci_get_domain_bus_and_slot);
>  
> +static int match_pci_host_bridge(struct device *dev, void *data)
> +{
> +	return 1;
> +}
> +
> +struct pci_host_bridge *pci_get_next_host_bridge(struct pci_host_bridge *from)
> +{
> +	struct device *dev;
> +	struct device *dev_start = NULL;
> +	struct pci_host_bridge *bridge = NULL;
> +
> +	WARN_ON(in_interrupt());
> +	if (from)
> +		dev_start = &from->dev;
> +	dev = bus_find_device(&pci_host_bridge_bus_type, dev_start, NULL,
> +			      match_pci_host_bridge);
> +	if (dev)
> +		bridge = to_pci_host_bridge(dev);
> +	if (from)
> +		put_device(&from->dev);
> +	return bridge;
> +}
> +
>  static int match_pci_dev_by_id(struct device *dev, void *data)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cc8b558..1e45d6f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -394,6 +394,8 @@ struct pci_host_bridge {
>  };
>  
>  #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
> +#define for_each_pci_host_bridge(d) while (d = pci_get_next_host_bridge(d))
> +
>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>  		     void (*release_fn)(struct pci_host_bridge *),
>  		     void *release_data);
> @@ -758,6 +760,7 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
>  int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
>  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>  
> +struct pci_host_bridge *pci_get_next_host_bridge(struct pci_host_bridge *from);
>  struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
>  				struct pci_dev *from);
>  struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
> 
Hi Yinghai,
	I'm working on a patchset to get rid of pci_find_next_bus() by using
class_for_each_device(&pcibus_class, xxx). I think your solution is better,
which removes both pci_find_next_bus() and pci_root_buses list. So I will give
up my version.
	Thanks!
	Gerry
