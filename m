Return-Path: <SRS0=ocJX=GF=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=ocJX=GF=huawei.com=liudongdong3@kernel.org>
Subject: Re: [RFC PATCH] ARM64/PCI: Set dev->irq=0 before calling
 acpi_pci_irq_enable()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1520650692-62705-1-git-send-email-liudongdong3@huawei.com>
 <20180313001830.GA60197@bhelgaas-glaptop.roam.corp.google.com>
 <f5d23376-42d1-7fec-dc1c-45e419acb678@huawei.com>
 <20180313114231.GA11786@red-moon>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
	<linuxarm@huawei.com>, <charles.chenxin@huawei.com>,
	<linux-acpi@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <4c6adec3-7995-433f-3ad9-882250c21467@huawei.com>
Date: Thu, 15 Mar 2018 18:35:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180313114231.GA11786@red-moon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo
在 2018/3/13 19:42, Lorenzo Pieralisi 写道:
> On Tue, Mar 13, 2018 at 07:20:10PM +0800, Dongdong Liu wrote:
>
> [...]
>
>>> It sounds like you're saying HIP07 doesn't provide _PRT?  Per the PCI
>>> Firmware Spec, r3.0, sec 4.4, _PRT is required under all PCI host
>>> bridges.  So I think you're saying HIP07 doesn't comply with the spec,
>>
>> Yes, It does not support to use _PRT on the Hip07.
>
> Hip07 firmware will be updated to support _PRT because that's what
> the ACPI specifications enforce.

We will fix the FW and drop the RFC.

Thanks,
Dongdong
>
> Thanks,
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>
