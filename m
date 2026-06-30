Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623843859D4;
	Tue, 30 Jun 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811211; cv=none; b=ZfqJ/mHt0g00WV1mr9UWu3UQiOHY/u6mFNr/1DUcnWDS5QDSeelBy1+aJNzQwWlty8oe6XIr2zWaIc0I1kS4zy7zCI2EFrvjBRKoMnRRQJ93XEpwBfcwtmLRp57zbrc/haI8N4zFUq+u5KGJhTyB3d5IRKtDE2r0LSqbSz9MX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811211; c=relaxed/simple;
	bh=w9Ca3yd8bq4VGES83veompJYAgMV7WaDVXrkSB/l1wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2EpYSKuCQOInL39L+Zk5sBLNVpRoK1uXG/G44kInIaEKmL8Z314hKyLmn9yUGhtSOevGW3oPwKjubuapKY08OWdl+ItS/4UecCHohe6GFC44cMBHDlfy8xHxqMGrb36nT7HfrO0cB1tUJMFTik1av5IUz/61R7Ga3BgcLbvN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rh/Xb+6e; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rh/Xb+6e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782811197; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V/Da2vG/bKnsKPYA3vWYR82EK4JSWuvqO/NWYtt0FaI=;
	b=Rh/Xb+6evCNWk9IhXe7+JaeYswvR6BYn6Ea/KBf/TMwfeNkOT+cKsVV7rDGTMlcSKC1iH6nAhTiilEOrpK2AI7ds7vP6L+71Xb+G+BZm5S9bzpCn08+nG55M4SJQv8Yu2FlZtG8F4by6Fxedwj7G5v+EH+OZhnX63snP3utS/vI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X6-zmWo_1782811196;
Received: from 30.246.161.179(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X6-zmWo_1782811196 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 17:19:57 +0800
Message-ID: <530a5e65-8bcf-4aa7-bd1f-aba8bc8a878d@linux.alibaba.com>
Date: Tue, 30 Jun 2026 17:19:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] perf/dwc_pcie: Convert to faux device interface
To: Yicong Yang <yang.yicong@picoheart.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jingoohan1@gmail.com, mani@kernel.org, juwenlong@picoheart.com,
 geshijian@picoheart.com, douyufan@picoheart.com
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
 <20260629092717.74946-4-yang.yicong@picoheart.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260629092717.74946-4-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/29/26 5:27 PM, Yicong Yang wrote:
> The DWC PCIe PMU makes use of the platform device interface but
> is not the real device, it's actually the RAS DES capability of
> the root port. It's more appropriate to use the lightweight
> faux framework to abstract this, it'll be more simple and no
> need for the complete device and drivers model. So convert to
> the faux device interface.
> 
> Move the cpuhp state registration prior to faux device creation
> since the probe depends on this and will run by the faux device
> creation.
> 
> No functional changes intended.
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 101 +++++++++++++++++-------------------
>   1 file changed, 48 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 7ec8302d4090..3a9965b5abf4 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -10,6 +10,7 @@
>   #include <linux/cpuhotplug.h>
>   #include <linux/cpumask.h>
>   #include <linux/device.h>
> +#include <linux/device/faux.h>
>   #include <linux/errno.h>
>   #include <linux/hrtimer.h>
>   #include <linux/kernel.h>
> @@ -17,7 +18,6 @@
>   #include <linux/pcie-dwc.h>
>   #include <linux/perf_event.h>
>   #include <linux/pci.h>
> -#include <linux/platform_device.h>
>   #include <linux/smp.h>
>   #include <linux/sysfs.h>
>   #include <linux/types.h>
> @@ -110,9 +110,10 @@ static struct list_head dwc_pcie_dev_info_head =
>   static bool notify;
>   
>   struct dwc_pcie_dev_info {
> -	struct platform_device *plat_dev;
> +	struct faux_device *fdev;
>   	struct pci_dev *pdev;
>   	struct list_head dev_node;
> +	char *name;
>   };
>   
>   static ssize_t cpumask_show(struct device *dev,
> @@ -658,6 +659,12 @@ static void dwc_pcie_unregister_pmu(void *data)
>   	perf_pmu_unregister(&pcie_pmu->pmu);
>   }
>   
> +static int dwc_pcie_pmu_probe(struct faux_device *fdev);
> +
> +static struct faux_device_ops dwc_pcie_faux_ops = {
> +	.probe = dwc_pcie_pmu_probe,
> +};
> +
>   static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
>   {
>   	const struct dwc_pcie_vsec_id *vid;
> @@ -684,31 +691,41 @@ static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
>   
>   static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_info)
>   {
> -	platform_device_unregister(dev_info->plat_dev);
> +	faux_device_destroy(dev_info->fdev);
>   	list_del(&dev_info->dev_node);
> +	kfree(dev_info->name);
>   	kfree(dev_info);
>   }
>   
>   static int dwc_pcie_register_dev(struct pci_dev *pdev)
>   {
> -	struct platform_device *plat_dev;
>   	struct dwc_pcie_dev_info *dev_info;
> +	struct faux_device *fdev;
> +	char *name;
>   	u32 sbdf;
>   
>   	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
> -	plat_dev = platform_device_register_simple("dwc_pcie_pmu", sbdf, NULL, 0);
> -	if (IS_ERR(plat_dev))
> -		return PTR_ERR(plat_dev);
> +	name = kasprintf(GFP_KERNEL, "dwc_pcie_pmu_%x", sbdf);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	fdev = faux_device_create(name, &pdev->dev, &dwc_pcie_faux_ops);
> +	if (!fdev) {
> +		kfree(name);
> +		return -ENODEV;
> +	}
>   
>   	dev_info = kzalloc_obj(*dev_info);
>   	if (!dev_info) {
> -		platform_device_unregister(plat_dev);
> +		faux_device_destroy(fdev);
> +		kfree(name);
>   		return -ENOMEM;
>   	}
>   
> -	/* Cache platform device to handle pci device hotplug */
> -	dev_info->plat_dev = plat_dev;
> +	/* Cache faux device to handle pci device hotplug */
> +	dev_info->fdev = fdev;
>   	dev_info->pdev = pdev;
> +	dev_info->name = name;
>   	list_add(&dev_info->dev_node, &dwc_pcie_dev_info_head);
>   
>   	return 0;
> @@ -743,33 +760,25 @@ static struct notifier_block dwc_pcie_pmu_nb = {
>   	.notifier_call = dwc_pcie_pmu_notifier,
>   };
>   
> -static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> +static int dwc_pcie_pmu_probe(struct faux_device *fdev)
>   {
> -	struct pci_dev *pdev;
> +	struct pci_dev *pdev = to_pci_dev(fdev->dev.parent);
>   	struct dwc_pcie_pmu *pcie_pmu;
>   	char *name;
>   	u32 sbdf;
>   	u16 vsec;
>   	int ret;
>   
> -	sbdf = plat_dev->id;
> -	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
> -					   sbdf & 0xff);
> -	if (!pdev) {
> -		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
> -		return -ENODEV;
> -	}
> +	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	name = devm_kasprintf(&fdev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
> +	if (!name)
> +		return -ENOMEM;
>   
>   	vsec = dwc_pcie_des_cap(pdev);
>   	if (!vsec)
>   		return -ENODEV;
>   
> -	pci_dev_put(pdev);
> -	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
> -	if (!name)
> -		return -ENOMEM;
> -
> -	pcie_pmu = devm_kzalloc(&plat_dev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
> +	pcie_pmu = devm_kzalloc(&fdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
>   	if (!pcie_pmu)
>   		return -ENOMEM;
>   
> @@ -789,7 +798,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   
>   	pcie_pmu->pmu = (struct pmu){
>   		.name		= name,
> -		.parent		= &plat_dev->dev,
> +		.parent		= &fdev->dev,
>   		.module		= THIS_MODULE,
>   		.attr_groups	= dwc_pcie_attr_groups,
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> @@ -811,7 +820,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   	}
>   
>   	/* Unwind when platform driver removes */

Minor: a stale comment.


Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
