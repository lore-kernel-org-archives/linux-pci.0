Return-Path: <SRS0=MpAE=ES=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=MpAE=ES=codeaurora.org=okaya@kernel.org>
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
References: <5727b0b1-f0d5-7c78-373e-fc9d1bd662d2@codeaurora.org>
 <CABhMZUU0643U-qVc9ymA+1PMZToSLFm2dg8-cu=iQ2LGw2Pi8Q@mail.gmail.com>
 <SHAPR01MB173A36104635A8BFF9A83E1FEE80@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <0ce08a91-fc38-1288-7683-836fcbbbdf3c@codeaurora.org>
 <20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com>
 <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
 <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
 <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org>
 <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <09bd3f5c-4671-d9dd-fa39-4d7619ee5860@codeaurora.org>
Date: Mon, 22 Jan 2018 21:27:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 1/22/2018 7:16 PM, Bjorn Helgaas wrote:
> On Mon, Jan 22, 2018 at 06:24:22PM -0500, Sinan Kaya wrote:
>> On 1/22/2018 5:51 PM, Bjorn Helgaas wrote:
>>> On Mon, Jan 22, 2018 at 05:04:03PM -0500, Sinan Kaya wrote:
>>>> On 1/22/2018 4:36 PM, Bjorn Helgaas wrote:
>>
>>>>> Reducing MPS may be necessary if there are several devices in the
>>>>> hierarchy and one requires a smaller MPS than the others.  That
>>>>> obviously reduces the maximum read and write performance.
>>>>>
>>>>> Reducing the MRRS may be useful to prevent one device from hogging
>>>>> a link, but of course, it reduces read performance for that device
>>>>> because we need more read requests.
>>>>
>>>> Maybe, a picture could help.
>>>>
>>>>                root (MPS=256)
>>>>                  |
>>>>          ------------------
>>>>         /                  \
>>>>    bridge0 (MPS=256)      bridge1 (MPS=128)
>>>>       /                       \
>>>>     EP0 (MPS=256)            EP1 (MPS=128)
>>>>
>>>> If I understood this right, code allows the configuration above with
>>>> the performance mode so that MPS doesn't have to be uniform across
>>>> the tree. 
>>>
>>> Yes.  In PERFORMANCE mode, we will set EP1's MRRS=128 and
>>> EP0's MRRS=256, just as you show.
>>>
>>>> It just needs to be consistent between the root port and endpoints.
>>>
>>> No, it doesn't need to be consistent.  In PERFORMANCE mode, we'll set
>>> the root's MPS=256 and EP1's MPS=128.
>>>
>>> (I'm not actually 100% convinced that the PERFORMANCE mode approach of
>>> reducing MRRS is safe, necessary, and maintainable.  I suspect that in
>>> many of the interesting cases, the device we care about is the only
>>> one below a Root Port, and we can get the performance we need by
>>> maximizing MPS and MRRS for that Root Port and its children,
>>> independent of the rest of the system.)
>>
>> Maybe, I started seeing more and more NVMe devices behind a switch every
>> day. That's why, I'm concerned.
> 
> Are there a mix of devices that support large MPS and those that only
> support a smaller MPS behind the same switch?

I guess we should understand the environment from Ron Yuan. Can we see
lspci -vvv output of your system?

We could maybe detect coexistence of slow and fast device condition and
put some suggestions like moving the card to another slot as a best effort
solution.

> 
> I don't have any actual data about topologies of interest.  I'm just
> guessing that high-performance devices will often have their own root
> port, without being mixed in with low-speed devices.  It's OK to have
> switches in the path; it's the mixing high-speed with low-speed
> devices that causes the problems.

Agreed. Mine was just a general rant. I was curious if we could make it better.

> 
>>>> Why are we reducing MRRS in this case?
>>>
>>> We have to set EP1's MRRS=128 so it will never receive a completion
>>> larger than 128 bytes.  If we set EP1's MRRS=256, it could receive
>>> 256-byte TLPs, which it would treat as malformed.  (We also assume no
>>> peer-to-peer DMA that targets EP1.)
>>
>> What if we were to keep root port MPS as 128? and not touch the BIOS
>> configured MRRS (4k) ?
>>
>> Everybody should be happy, right?
> 
> No.  In your picture (which helps a lot, thank you!), if you set the
> root's MPS=128, EP1 will be fine no matter what its MRRS is because
> the entire path has MPS=128.
> 
> But if EP0's MRRS is larger than 128, it's in trouble because it may
> issue a 256-byte DMA write, which the root port will treat as
> malformed.  The root port, as the receiver of that Memory Write
> Request, is required to check the TLP against the MPS in its Device
> Control (not Device Capability) register (this is in PCIe r4.0, sec
> 2.2.2).

Yeah, this breaks my theory.

> 
>> I know there is a rule to check the completions against MPS. 
> 
> Sec 2.2.2 says a receiver must check "data payloads".  I think that
> includes both Completions and Memory Writes.
> 
>> Root port could generate transactions that is a multiple of 128
>> bytes for reads.
> 
> If the root port generates a 256-byte Memory Read request to EP1,
> that's fine because EP1 will only respond with 128-byte completions.
> If it sends that 256-byte Memory Read to EP0, we have a problem
> because EP0 may generate a 256-byte completion, which will cause an
> error if the root port has MPS=128.
> 
>> Is there any rule against checking incoming writes?
> 
> Sec 2.2.2 says a receiver *must* check the payload size of incoming
> Memory Write requests.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
