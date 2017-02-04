Return-Path: <SRS0=mO1w=ZR=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=mO1w=ZR=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH 1/3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
 <1484202504-96686-2-git-send-email-liudongdong3@huawei.com>
 <20170203204042.GF10291@bhelgaas-glaptop.roam.corp.google.com>
 <20170203210020.GA24162@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <02893dda-36b3-8949-c5a0-aed964e62326@huawei.com>
Date: Sat, 4 Feb 2017 11:30:32 +0800
MIME-Version: 1.0
In-Reply-To: <20170203210020.GA24162@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many thanks for your review.

e( 2017/2/4 5:00, Bjorn Helgaas ei:
> On Fri, Feb 03, 2017 at 02:40:42PM -0600, Bjorn Helgaas wrote:
>> On Thu, Jan 12, 2017 at 02:28:22PM +0800, Dongdong Liu wrote:
>>> The PCIe controller in Hip06/Hip07 SoCs is not completely
>>> ECAM-compliant. It is non-ECAM only for the RC bus config space; for
>>> any other bus underneath the root bus it does support ECAM access.
>>> This is to add the almost ECAM support in DT way.
>>>
>>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>>> Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
>>
>> Applied to pci/host-hisi for v4.11, thanks!
>
> Oops, I take this back, see below.
>
>>> @@ -262,17 +264,23 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>>>  	const struct of_device_id *match;
>>>  	struct resource *reg;
>>>  	struct device_driver *driver;
>>> +	struct pci_ecam_ops *ops;
>>>  	int ret;
>>>
>>> +	driver = dev->driver;
>>> +	match = of_match_device(driver->of_match_table, dev);
>>> +	if (!strcmp(match->compatible, "hisilicon,pcie-almost-ecam")) {
>>> +		ops = (struct pci_ecam_ops *)match->data;
>>> +		return pci_host_common_probe(pdev, ops);
>>> +	}
>
> Please make this a separate probe function() with a separate struct
> platform_driver.
>
> That way you won't have to strcmp() for "hisilicon,pcie-almost-ecam",
> and you can use of_device_get_match_data() to get "ops", so you won't
> need to use of_match_device() at all.

Good catch, will fix.

Thanks,
Dongdong
