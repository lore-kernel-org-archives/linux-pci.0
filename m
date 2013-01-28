Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:17092 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab3A1DWP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 22:22:15 -0500
Message-ID: <5105EEA6.3020703@huawei.com>
Date: Mon, 28 Jan 2013 11:21:10 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>, David Airlie <airlied@linux.ie>,
	<dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 11/22] PCI, drm: Kill pci_root_buses in alpha hose
 setting
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com> <1359314629-18651-1-git-send-email-yinghai@kernel.org> <1359314629-18651-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-12-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/1/28 3:23, Yinghai Lu wrote:
> Replace that with hotplug-safe version.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/drm_fops.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fops.c b/drivers/gpu/drm/drm_fops.c
> index 133b413..b92a9cc 100644
> --- a/drivers/gpu/drm/drm_fops.c
> +++ b/drivers/gpu/drm/drm_fops.c
> @@ -356,9 +356,13 @@ static int drm_open_helper(struct inode *inode, struct file *filp,
>  			pci_dev_put(pci_dev);
>  		}
>  		if (!dev->hose) {
> -			struct pci_bus *b = pci_bus_b(pci_root_buses.next);
> -			if (b)
> -				dev->hose = b->sysdata;
> +			struct pci_host_bridge *host_bridge;
> +
> +			host_bridge = pci_next_host_bridge(NULL);

pci_get_next_host_bridge() ?

> +			if (host_bridge) {
> +				dev->hose = host_bridge->bus->sysdata;
> +				put_device(&host_bridge->dev);
> +			}
>  		}
>  	}
>  #endif
> 


-- 
Thanks!
Yijing

