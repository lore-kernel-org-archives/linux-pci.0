Return-Path: <SRS0=RD7r=EK=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=RD7r=EK=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH] PCI: Fix MSI disabled for HiSilicon Hip06/Hip07 EP mode
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1514454812-101846-1-git-send-email-liudongdong3@huawei.com>
 <20180113000414.GC205469@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<zhouyupeng1@huawei.com>, <tangyongqian@huawei.com>, <bruce.feng@huawei.com>,
	<stable@vger.kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <e2ec400e-7db6-1858-1767-4c2bf52c6bc6@huawei.com>
Date: Mon, 15 Jan 2018 09:01:02 +0800
MIME-Version: 1.0
In-Reply-To: <20180113000414.GC205469@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn
在 2018/1/13 8:04, Bjorn Helgaas 写道:
> On Thu, Dec 28, 2017 at 05:53:32PM +0800, Dongdong Liu wrote:
>> HiSilicon Hip06/Hip07 can work as RC mode and EP mode. The PCIe Root Port
>> in Hip06/Hip07 SoCs advertises an MSI capability, but it can not generate
>> MSIs. It can generate MSIs When it works as EP mode, but the vendor id and
>> device id of RP and EP are the same. Current code also disable MSI for EP
>> mode, we only need to disable MSI for Root Port.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 72f2ff0deb87 ("PCI: Disable MSI for HiSilicon Hip06/Hip07 Root Ports")
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>
> Applied with Zhou's reviewed-by to pci/msi for v4.16, thanks!

Many thanks for applying the patch.

Thanks,
Dongdong
