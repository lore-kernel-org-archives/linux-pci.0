Return-Path: <SRS0=u5Xu=7T=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=u5Xu=7T=intel.com=keith.busch@kernel.org>
Date: Thu, 17 Aug 2017 11:32:21 -0400
From: Keith Busch <keith.busch@intel.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
	gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH V3 1/2] PCI/DPC: Add local struct device
Message-ID: <20170817153221.GM7233@localhost.localdomain>
References: <1502970505-89777-1-git-send-email-liudongdong3@huawei.com>
 <1502970505-89777-2-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502970505-89777-2-git-send-email-liudongdong3@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 17, 2017 at 07:48:24PM +0800, Dongdong Liu wrote:
> Use a local "struct device *dev" for brevity and consistency in DPC driver.
> No functional change intended.

I think there is a functional change here:

> @@ -119,10 +120,11 @@ static int dpc_probe(struct pcie_device *dev)
>  {
>  	struct dpc_dev *dpc;
>  	struct pci_dev *pdev = dev->port;
> +	struct device *device = &pdev->dev;
>  	int status;
>  	u16 ctl, cap;
>  
> -	dpc = devm_kzalloc(&dev->device, sizeof(*dpc), GFP_KERNEL);
> +	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
>  	if (!dpc)
>  		return -ENOMEM;

We were using the pcie_device's device for the devres API, but now it's
the pci_dev's. That will change the lifetime of memory allocations. I'm
not sure that it matters at th emoment, but it's certainly different.
