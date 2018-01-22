Return-Path: <SRS0=wG18=ER=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=wG18=ER=codeaurora.org=okaya@kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ron Yuan <ron.yuan@memblaze.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Bo Chen <bo.chen@memblaze.com>, William Huang <william.huang@memblaze.com>,
 Fengming Wu <fengming.wu@memblaze.com>,
 Jason Jiang <jason.jiang@microsemi.com>,
 Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
 Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
 William Cheng <william.cheng@microsemi.com>,
 "Kim Helper (khelper)" <khelper@micron.com>,
 Linux PCI <linux-pci@vger.kernel.org>
References: <ef16a3cc-b641-a30d-644a-7940e340eb3e@codeaurora.org>
 <SHAPR01MB173A5EA1677C2138CB528F2FEE90@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <5727b0b1-f0d5-7c78-373e-fc9d1bd662d2@codeaurora.org>
 <CABhMZUU0643U-qVc9ymA+1PMZToSLFm2dg8-cu=iQ2LGw2Pi8Q@mail.gmail.com>
 <SHAPR01MB173A36104635A8BFF9A83E1FEE80@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <0ce08a91-fc38-1288-7683-836fcbbbdf3c@codeaurora.org>
 <20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com>
 <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
 <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org>
Date: Mon, 22 Jan 2018 18:24:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 1/22/2018 5:51 PM, Bjorn Helgaas wrote:
> On Mon, Jan 22, 2018 at 05:04:03PM -0500, Sinan Kaya wrote:
>> On 1/22/2018 4:36 PM, Bjorn Helgaas wrote:

>>> Reducing MPS may be necessary if there are several devices in the
>>> hierarchy and one requires a smaller MPS than the others.  That
>>> obviously reduces the maximum read and write performance.
>>>
>>> Reducing the MRRS may be useful to prevent one device from hogging
>>> a link, but of course, it reduces read performance for that device
>>> because we need more read requests.
>>
>> Maybe, a picture could help.
>>
>>                root (MPS=256)
>>                  |
>>          ------------------
>>         /                  \
>>    bridge0 (MPS=256)      bridge1 (MPS=128)
>>       /                       \
>>     EP0 (MPS=256)            EP1 (MPS=128)
>>
>> If I understood this right, code allows the configuration above with
>> the performance mode so that MPS doesn't have to be uniform across
>> the tree. 
> 
> Yes.  In PERFORMANCE mode, we will set EP1's MRRS=128 and
> EP0's MRRS=256, just as you show.
> 
>> It just needs to be consistent between the root port and endpoints.
> 
> No, it doesn't need to be consistent.  In PERFORMANCE mode, we'll set
> the root's MPS=256 and EP1's MPS=128.
> 
> (I'm not actually 100% convinced that the PERFORMANCE mode approach of
> reducing MRRS is safe, necessary, and maintainable.  I suspect that in
> many of the interesting cases, the device we care about is the only
> one below a Root Port, and we can get the performance we need by
> maximizing MPS and MRRS for that Root Port and its children,
> independent of the rest of the system.)

Maybe, I started seeing more and more NVMe devices behind a switch every
day. That's why, I'm concerned.

> 
>> Why are we reducing MRRS in this case?
> 
> We have to set EP1's MRRS=128 so it will never receive a completion
> larger than 128 bytes.  If we set EP1's MRRS=256, it could receive
> 256-byte TLPs, which it would treat as malformed.  (We also assume no
> peer-to-peer DMA that targets EP1.)

What if we were to keep root port MPS as 128? and not touch the BIOS
configured MRRS (4k) ?

Everybody should be happy, right?

I know there is a rule to check the completions against MPS. Root port
could generate transactions that is a multiple of 128 bytes for reads.

Is there any rule against checking incoming writes?

> 
>> Are we assuming that root bus cannot handle more than 256 bytes and
>> bridge1 would be starved while root bus is passing the completions
>> to bridge0?
> 
> We don't have to assume.  Every device tells us via Dev Cap what size
> TLPs it can handle.  In your example, I assume the root's Dev Cap
> tells us it supports 256-byte TLPs.
> 
> PERFORMANCE mode reduces MRRS not because of a starvation issue, but
> because reducing EP1's MRRS allows EP0 to use a larger MPS.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
