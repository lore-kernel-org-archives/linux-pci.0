Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:5726 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbaHLBnx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 21:43:53 -0400
Message-ID: <53E97149.8070303@huawei.com>
Date: Tue, 12 Aug 2014 09:43:37 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Liu Ping Fan <kernelfans@gmail.com>, <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: bugfix, pci_get_domain_bus_and_slot() needs to inc
 reference count
References: <1407803481-7910-1-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1407803481-7910-1-git-send-email-pingfank@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/8/12 8:31, Liu Ping Fan wrote:
> As the notes of this function, pci_get_domain_bus_and_slot() should
> increase the reference count.

It had did it.
please refer to:

#define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)

> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  drivers/pci/search.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 827ad83..41a5738 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -258,8 +258,10 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
>  
>  	for_each_pci_dev(dev) {
>  		if (pci_domain_nr(dev->bus) == domain &&
> -		    (dev->bus->number == bus && dev->devfn == devfn))
> +		    (dev->bus->number == bus && dev->devfn == devfn)) {
> +			pci_dev_get(dev);
>  			return dev;
> +		}
>  	}
>  	return NULL;
>  }
> 


-- 
Thanks!
Yijing

