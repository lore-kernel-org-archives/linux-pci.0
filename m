Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:53722 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753672Ab3HBSm0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 14:42:26 -0400
Message-ID: <1375468943.1460.4.camel@x61.thuisdomein>
Subject: Re: [PATCH -v4 6/6] PCI,pciehp: identify device change during
 suspend
From: Paul Bolle <pebolle@tiscali.nl>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Fri, 02 Aug 2013 20:42:23 +0200
In-Reply-To: <1375362389-26096-7-git-send-email-wangyijing@huawei.com>
References: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>
	 <1375362389-26096-7-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yijing,

On Thu, 2013-08-01 at 21:06 +0800, Yijing Wang wrote:
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 7fe9dbd..db5f597 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> [...]
> @@ -315,10 +317,36 @@ static int pciehp_resume (struct pcie_device *dev)
>  	if (status) {
>  		if (list_empty(&pbus->devices))
>  			pciehp_enable_slot(slot);
> -	} else if (!list_empty(&pbus->devices)) {
> -		pciehp_disable_slot(slot);
> +
> +		pdev = pci_get_slot(pbus, PCI_DEVFN(0, 0));
> +		if (!pdev)
> +			return 0;
> +		ret = pci_serial_number_changed(pdev);
> +		pci_dev_put(pdev);
> +		if (ret) {
> +			/*
> +			 * first power off slot, avoid the old driver
> +			 * .remove() method touch the new hardware
> +			 */
> +			if (POWER_CTRL(ctrl)) {
> +				ret = pciehp_power_off_slot(slot);
> +				if (ret) {
> +					ctrl_err(ctrl,
> +						"Issue of Slot Disable command failed\n");
> +					return 0;
> +				}
> +				msleep(1000);
> +				pciehp_unconfigure_device(slot);
> +				/* call child devices driver->suspend() for symmetry */
> +				list_for_each_entry(pdev, &pbus->devices, bus_list)
> +					if (pdev->driver)
> +						pdev->driver->driver.pm->suspend(&pdev->dev);
> +				pciehp_enable_slot(slot);
> +			}
> +		} else if (!list_empty(&pbus->devices)) {
> +			pciehp_disable_slot(slot);
> +		}
>  	}
> -	

I ran into a problem with this change. This line, removing a line
consisting of only a single tab, appears to conflict with a patch
earlier in this series. I had to manually remove just the change that
removed that line to get this patch to apply. Any idea what's going on?

>  	return 0;
>  }
>  #endif /* PM */


Paul Bolle

