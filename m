Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:20030 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab3HANMK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 09:12:10 -0400
Message-ID: <51FA5EA0.6030805@huawei.com>
Date: Thu, 1 Aug 2013 21:12:00 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH -v4 6/6] PCI,pciehp: identify device change during suspend
References: <1375362389-26096-1-git-send-email-wangyijing@huawei.com> <1375362389-26096-7-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1375362389-26096-7-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
   I still leave this code in pciehp modeule, because I do not find
a better place to move. Only in pciehp module, we can know the device whether support
hotplug, if we can not power off device, although we find the device change, but we
can not remove the device for safety. What do you think?

Thanks!
Yijing.

On 2013/8/1 21:06, Yijing Wang wrote:
> If device was removed from slot and reinsert a new device during
> suspend, pciehp can not identify the physical device change now.
> So the old driver .resume() method will be called for the new device,
> this is bad. If device support device serial number capability,
> we can identify this by DSN. So the reasonable way is first remove
> the old device, then enable the new device.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Paul Bolle <pebolle@tiscali.nl>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Oliver Neukum <oneukum@suse.de>
> Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/hotplug/pciehp_core.c |   34 +++++++++++++++++++++++++++++++---
>  1 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 7fe9dbd..db5f597 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -301,6 +301,8 @@ static int pciehp_resume (struct pcie_device *dev)
>  	struct controller *ctrl;
>  	struct slot *slot;
>  	struct pci_bus *pbus = dev->port->subordinate;
> +	struct pci_dev *pdev;
> +	int ret = 0;
>  	u8 status;
>  
>  	ctrl = get_service_data(dev);
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
>  	return 0;
>  }
>  #endif /* PM */
> 


-- 
Thanks!
Yijing

