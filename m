Return-Path: <SRS0=tMJ6=DD=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=tMJ6=DD=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V2 1/2] PCI/portdrv: Fix switch devctrl error report
 enable
To: Christoph Hellwig <hch@infradead.org>
References: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
 <1512467438-42850-2-git-send-email-liudongdong3@huawei.com>
 <20171205191537.GA21975@infradead.org>
CC: <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
	<stable@vger.kernel.org>, <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <6f6e99b6-aa91-fa6d-f4f4-06db0a24ffe7@huawei.com>
Date: Thu, 7 Dec 2017 20:55:49 +0800
MIME-Version: 1.0
In-Reply-To: <20171205191537.GA21975@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph
Many thanks for your reveiw.
在 2017/12/6 3:15, Christoph Hellwig 写道:
> On Tue, Dec 05, 2017 at 05:50:37PM +0800, Dongdong Liu wrote:
>> +		if ((pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>> +		    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
>> +			pci_disable_pcie_error_reporting(dev);
>
> No need for the inner braces here.
will fix.

Thanks,
Dongdong
>
>
