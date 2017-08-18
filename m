Return-Path: <SRS0=WTXb=7U=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=WTXb=7U=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V3 1/2] PCI/DPC: Add local struct device
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>
References: <1502970505-89777-1-git-send-email-liudongdong3@huawei.com>
 <1502970505-89777-2-git-send-email-liudongdong3@huawei.com>
 <20170817153221.GM7233@localhost.localdomain>
 <20170817163414.GG28977@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <23b5de50-afd9-d25d-151c-8849d986ad55@huawei.com>
Date: Fri, 18 Aug 2017 09:55:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170817163414.GG28977@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



在 2017/8/18 0:34, Bjorn Helgaas 写道:
> On Thu, Aug 17, 2017 at 11:32:21AM -0400, Keith Busch wrote:
>> On Thu, Aug 17, 2017 at 07:48:24PM +0800, Dongdong Liu wrote:
>>> Use a local "struct device *dev" for brevity and consistency in DPC driver.
>>> No functional change intended.
>>
>> I think there is a functional change here:
>>
>>> @@ -119,10 +120,11 @@ static int dpc_probe(struct pcie_device *dev)
>>>  {
>>>  	struct dpc_dev *dpc;
>>>  	struct pci_dev *pdev = dev->port;
>>> +	struct device *device = &pdev->dev;
>>>  	int status;
>>>  	u16 ctl, cap;
>>>
>>> -	dpc = devm_kzalloc(&dev->device, sizeof(*dpc), GFP_KERNEL);
>>> +	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
>>>  	if (!dpc)
>>>  		return -ENOMEM;
>>
>> We were using the pcie_device's device for the devres API, but now it's
>> the pci_dev's. That will change the lifetime of memory allocations. I'm
>> not sure that it matters at th emoment, but it's certainly different.
>
> Yep.  I'll drop this rev.  When you repost it, please make the
> cosmetic change last in the series so the important thing is easier to
> backport.

Ok, I will restore the change and adjust the PATCH sequence in PATCH V4.

Thanks,
Dongdong

>

> .
>
