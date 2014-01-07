Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:8633 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaAGI2i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2014 03:28:38 -0500
Message-ID: <52CBBA86.7020401@huawei.com>
Date: Tue, 7 Jan 2014 16:27:50 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Dongsheng Wang <dongsheng.wang@freescale.com>,
	<bhelgaas@google.com>, <rjw@rjwysocki.net>
CC: <scottwood@freescale.com>, <galak@codeaurora.org>,
	<roy.zang@freescale.com>, <linux-pci@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] pci: Fix root port bus->self is NULL
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/1/7 16:04, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> the root port bus->self always NULL, so put root port pci device
> into root port bus->self.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 38e403d..7f2d1ab 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1472,6 +1472,9 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  	if (!dev->is_added)
>  		nr++;
>  
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +		bus->self = dev;

In this case, bus is the pci root bus I think, so why set bus->self = root port ?
"bus->self" should pointer to the pci device that bridge out this bus.

> +
>  	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
>  		dev = pci_scan_single_device(bus, devfn + fn);
>  		if (dev) {
> 


-- 
Thanks!
Yijing

