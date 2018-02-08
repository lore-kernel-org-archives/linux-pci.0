Return-Path: <SRS0=Utot=FC=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=Utot=FC=rock-chips.com=shawn.lin@kernel.org>
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: understanding DMA in PCI drivers
To: Bjorn Helgaas <helgaas@kernel.org>, Ran Shalit <ranshalit@gmail.com>
References: <CAJ2oMhKJ5ECtr5-F1M_PjO+ev_8-UfpLu+jT9hG7XEwoDV0A_Q@mail.gmail.com>
 <20180207143954.GA30525@bhelgaas-glaptop.roam.corp.google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <3d427721-7489-040e-791d-4963a1d5941c@rock-chips.com>
Date: Thu, 8 Feb 2018 09:41:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180207143954.GA30525@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

[+ Kishon]

On 2018/2/7 22:39, Bjorn Helgaas wrote:

>> 2. How does device triggers DMA from device to cpu, is it by simply
>> writing to BAR ?
> 
> In most cases the device itself performs the DMA.  It sounds like
> you have a case where the DMA engine is not part of the device itself.
> I don't know how that would be programmed, except to say that the DMA
> engine presumably operates on DMA addresses, and something would still
> have to DMA-map buffers to obtain those.

I have a question that why it's always device to performs the DMA for
no matter memory read and write? We have builtin DMA engine inside the
PCIe RC controller, so could the function driver submit the DMA request
to the PCIe RC controller driver and let it fire the DMA to access
device's internal memory? Given that we now support PCIe EP framework,
and now linux-pci behave like a *device* per your saying, so that is
quite possible for us to consider how we would submit DMA request with
current PCIe EP stuff.

> 
> BARs are typically used for programming the device, i.e., the driver
> would use them.  BARs are not in the data path for a DMA transfer.
> 
>> 3. How does device triggers DMA from cpu to device, is it by simply
>> reading from BAR ?
> 
> 
> 
> 
