Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34985 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932714AbcBIUxx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Feb 2016 15:53:53 -0500
Date: Tue, 9 Feb 2016 14:53:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>
Subject: Re: [PATCHv2 2/4] pci: allow access to VPD attributes with size '0'
Message-ID: <20160209205347.GA32530@localhost>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
 <1452684335-46107-3-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452684335-46107-3-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hannes,

On Wed, Jan 13, 2016 at 12:25:33PM +0100, Hannes Reinecke wrote:
> It is not always possible to determine the actual size of the VPD
> data, so allow access to them if the size is set to '0'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/pci/pci-sysfs.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index eead54c..de327c3 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -772,10 +772,12 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
>  	struct pci_dev *dev =
>  		to_pci_dev(container_of(kobj, struct device, kobj));
>  
> -	if (off > bin_attr->size)
> -		count = 0;
> -	else if (count > bin_attr->size - off)
> -		count = bin_attr->size - off;
> +	if (bin_attr->size > 0) {
> +		if (off > bin_attr->size)
> +			count = 0;
> +		else if (count > bin_attr->size - off)
> +			count = bin_attr->size - off;
> +	}

I'm trying to figure out why we do any of this checking here.  It
seems like we could do all of it in pci_read_vpd().

Where is bin_attr->size set?  I assume this is the "attr" allocated in
pci_create_capabilities_sysfs().  I see that before your series, we
set "attr->size = dev->vpd->len" there, but after patch 3/4 of your
series, we set it to 0 there, and I don't see a place that sets it to
anything else.

>  	return pci_read_vpd(dev, off, count, buf);
>  }
> @@ -787,10 +789,12 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
>  	struct pci_dev *dev =
>  		to_pci_dev(container_of(kobj, struct device, kobj));
>  
> -	if (off > bin_attr->size)
> -		count = 0;
> -	else if (count > bin_attr->size - off)
> -		count = bin_attr->size - off;
> +	if (bin_attr->size > 0) {
> +		if (off > bin_attr->size)
> +			count = 0;
> +		else if (count > bin_attr->size - off)
> +			count = bin_attr->size - off;
> +	}
>  
>  	return pci_write_vpd(dev, off, count, buf);
>  }
> -- 
> 1.8.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
