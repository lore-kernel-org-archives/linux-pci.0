Return-Path: <SRS0=od7V=73=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=od7V=73=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V5 0/2] PCI/DPC: Add eDPC support
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1503133641-114550-1-git-send-email-liudongdong3@huawei.com>
 <20170824163207.GF31858@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <c34b0dfe-55ac-ca72-7a8c-2b485b18f969@huawei.com>
Date: Fri, 25 Aug 2017 10:24:50 +0800
MIME-Version: 1.0
In-Reply-To: <20170824163207.GF31858@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



e( 2017/8/25 0:32, Bjorn Helgaas ei:
> On Sat, Aug 19, 2017 at 05:07:19PM +0800, Dongdong Liu wrote:
>> This patchset is to add eDPC support and use a local
>> "struct device *dev" for brevity and consistency in DPC driver.
>>
>> v4->v5:
>> - Fix some compile warnings.
>>
>> v3->v4:
>> - Use pcie_device's device to keep consistency.
>> - Adjust patch sequence.
>>
>> v2->v3:
>> - Add a separate patch to use a local "struct device *dev"
>>   for brevity and consistency in  DPC driver.
>> - Fix comments on PATCH V2.
>> - Rebase on v4.13-rc5.
>>
>> v1->v2:
>> - Use a stack local variable instead of the allocated memory for
>>   collecting RP PIO information.
>> - Fix the condition of RP PIO error.
>> - Rebase on v4.13-rc1.
>>
>> Dongdong Liu (2):
>>   PCI/DPC: Add eDPC support
>>   PCI/DPC: Add local struct device
>>
>>  drivers/pci/pcie/pcie-dpc.c   | 187 +++++++++++++++++++++++++++++++++++++++---
>>  include/uapi/linux/pci_regs.h |  10 +++
>>  2 files changed, 187 insertions(+), 10 deletions(-)
>
> Applied with Keith's reviewed-by to pci/dpc for v4.14, thanks!

Thanks Bjorn and Keith.

>
> .
>
