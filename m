Return-Path: <SRS0=XI/F=FE=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=XI/F=FE=rock-chips.com=shawn.lin@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Ran Shalit <ranshalit@gmail.com>,
 shawn.lin@rock-chips.com, linux-pci@vger.kernel.org
Subject: Re: understanding DMA in PCI drivers
To: Kishon Vijay Abraham I <kishon@ti.com>
References: <CAJ2oMhKJ5ECtr5-F1M_PjO+ev_8-UfpLu+jT9hG7XEwoDV0A_Q@mail.gmail.com>
 <20180207143954.GA30525@bhelgaas-glaptop.roam.corp.google.com>
 <3d427721-7489-040e-791d-4963a1d5941c@rock-chips.com>
 <3d80da48-dfb6-495e-1448-5d142b3e709e@ti.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <aae1b034-bb18-9e41-c6dd-0d4704e48fa6@rock-chips.com>
Date: Sat, 10 Feb 2018 09:51:39 +0800
MIME-Version: 1.0
In-Reply-To: <3d80da48-dfb6-495e-1448-5d142b3e709e@ti.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi

On 2018/2/8 16:30, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 08 February 2018 07:11 AM, Shawn Lin wrote:
>> Hi Bjorn,
>>
>> [+ Kishon]
>>
>> On 2018/2/7 22:39, Bjorn Helgaas wrote:
>>
>>>> 2. How does device triggers DMA from device to cpu, is it by simply
>>>> writing to BAR ?
>>>
>>> In most cases the device itself performs the DMA.  It sounds like
>>> you have a case where the DMA engine is not part of the device itself.
>>> I don't know how that would be programmed, except to say that the DMA
>>> engine presumably operates on DMA addresses, and something would still
>>> have to DMA-map buffers to obtain those.
>>
>> I have a question that why it's always device to performs the DMA for
>> no matter memory read and write? We have builtin DMA engine inside the
> The PCI devices are supposed to work with different host controllers and
> instead of relying on host controller capabilities (in this case DMA), the
> device can use it's own DMA.
> 
>> PCIe RC controller, so could the function driver submit the DMA request
>> to the PCIe RC controller driver and let it fire the DMA to access
>> device's internal memory? Given that we now support PCIe EP framework,
> 
> As Bjorne mentioned before, RC accessing the EP memory is mostly for
> configuring the device and not in the data path. Having said that, there can be
> a pci_driver which DMAs to a BAR region, if thats your usecase.

Ok, I see now. Thanks for that¡£


>> and now linux-pci behave like a *device* per your saying, so that is
>> quite possible for us to consider how we would submit DMA request with
>> current PCIe EP stuff.
> 
> Thanks
> Kishon
> 
> 
> 
