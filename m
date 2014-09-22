Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41987 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbaIVXD0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 19:03:26 -0400
Received: by mail-ie0-f171.google.com with SMTP id rd18so3634188iec.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 16:03:25 -0700 (PDT)
Date: Mon, 22 Sep 2014 17:03:23 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/5] PCI/MSI: Change msi_bus attribute to support
 enable/disable MSI for EP
Message-ID: <20140922230323.GL1880@google.com>
References: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>
 <1408694880-8260-4-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408694880-8260-4-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 04:07:58PM +0800, Yijing Wang wrote:
> Msi_bus attribute is only valid for bridge device.
> We can enable or disable MSI capability for a bus,
> if we echo 1/0 > /sys/bus/pci/devices/$EP/msi_bus,
> the action will be ignored. Sometime we need to
> only enable/disable a EP device MSI capability,
> not all devices share the same bus.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

What's the purpose of this?  Is this just for debugging?  I assume that if
you have an endpoint that requires MSI to be disabled, you'd have a quirk
to do that, not a sysfs interface.

This should probably be mentioned in
Documentation/ABI/testing/sysfs-bus-pci while you're at it.  I know it's
not there yet, but this seems like a good time to rectify that omission.

> ---
>  drivers/pci/pci-sysfs.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9ff0a90..b199ad9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -251,11 +251,9 @@ static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	if (!pdev->subordinate)
> -		return 0;
> -
> -	return sprintf(buf, "%u\n",
> -		       !(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI));
> +	return sprintf(buf, "%u\n", pdev->subordinate ?
> +		       !(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> +			   : !pdev->no_msi);
>  }
>  
>  static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
> @@ -278,8 +276,10 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
>  	 * Maybe devices without subordinate buses shouldn't have this
>  	 * attribute in the first place?
>  	 */
> -	if (!pdev->subordinate)
> +	if (!pdev->subordinate) {
> +		pdev->no_msi = !val;
>  		return count;
> +	}
>  
>  	/* Is the flag going to change, or keep the value it already had? */
>  	if (!(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI) ^
> -- 
> 1.7.1
> 
