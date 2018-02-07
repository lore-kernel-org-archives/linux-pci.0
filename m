Return-Path: <SRS0=3y12=FB=gmail.com=ranshalit@kernel.org>
Return-Path: <SRS0=3y12=FB=gmail.com=ranshalit@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180207143954.GA30525@bhelgaas-glaptop.roam.corp.google.com>
References: <CAJ2oMhKJ5ECtr5-F1M_PjO+ev_8-UfpLu+jT9hG7XEwoDV0A_Q@mail.gmail.com>
 <20180207143954.GA30525@bhelgaas-glaptop.roam.corp.google.com>
From: Ran Shalit <ranshalit@gmail.com>
Date: Wed, 7 Feb 2018 17:03:34 +0200
Message-ID: <CAJ2oMhL4rGWxN2nOQBC=ncFSFhJbb682ZDDoEMkFbS+SOftifg@mail.gmail.com>
Subject: Re: understanding DMA in PCI drivers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 7, 2018 at 4:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Feb 06, 2018 at 09:02:49PM +0200, Ran Shalit wrote:
>> Hello,
>>
>> I write a pci linux driver, and after reviewing some examples in
>> kernel, there is issue I am not sure about:
>> DMA seems to follow the following steps in PCI:
>> 1.  driver allocate dma buffers and map them to BAR.
>
> The driver needs to allocate and map buffers for DMA.  See
> Documentation/DMA-API-HOWTO.txt for a start.
>
> DMA has nothing to do with BARs.  BARs describe address space on the
> *device* that can be accessed by the CPU.  BARs are used for
> "programmed I/O", not for DMA.
>
>> 2. driver initialize device to be familiar with dma addresses.
>
> When the driver creates a DMA mapping, for example, by calling
> dma_map_single(), it gets the DMA address.  It can then program the
> DMA address into the device.
>
>> 3. tx from cpu to device: driver trigger dma, by writing into device BARs.
>
> If you mean the device is doing a DMA read from system memory, the
> driver must first allocate and DMA-map a buffer, then tell the device
> what the DMA address is, then tell the device to start the DMA.  The
> driver would typically use the BARs to give the device the buffer's
> DMA address and the "DMA start" command.
>
>> 4. rx from device to cpu: device is responsible for triggering DMA
>> (driver does not do anything here)
>
> The driver *always* has to perform DMA mapping, regardless of whether
> the device is doing DMA reads or writes.  In this case, I think you're
> talking about a device doing a DMA write to system memory.  The driver
> must have previously performed the mapping and told the device "here's
> a DMA address where you can write things in the future."

Is it that in this case(external device->system memory), unlike the
previous (system memory->external device ), the driver does not
generate the transaction, but the device should trigger it by himself
?
>
>> 5. tx/rx completion: interrupt from DMA (in cpu)
>
> Typically a device generates an interrupt when DMA is complete.
>
>> 6. interrupt handler of section 5 above checks that device finished tx/rx.
>>
>> Is the above understanding correct ?
>> 1. As to 6, I am not sure about, is it that device knows that
>> transaction is finished (DMA is in soc , not device) ?
>
> This is device-specific.
>
>> 2. How does device triggers DMA from device to cpu, is it by simply
>> writing to BAR ?
>
> In most cases the device itself performs the DMA.  It sounds like
> you have a case where the DMA engine is not part of the device itself.
> I don't know how that would be programmed, except to say that the DMA
> engine presumably operates on DMA addresses, and something would still
> have to DMA-map buffers to obtain those.
>
> BARs are typically used for programming the device, i.e., the driver
> would use them.  BARs are not in the data path for a DMA transfer.
>

I think I have some basic misunderstanding which makes me confused in
understanding DMA with PCI:
I first thought that Linux drivers should memory map DMA buffers only
when DMA engine is in the cpu host (  internal dma engine->controller)
>From the above clarification it seems that memory mapping DMA buffers
should also be done even when DMA engine is in external device (
controller ---|--pci--|--- dma engine of external device).
Is that correct ? If yes - Why is it that DMA buffers are needed in both cases ?

The above is just for my understanding of linux pci drivers and DMA.
I Actually have another case: I need to use DMA-engine which is part
of the soc (armada chip) and is connected through PCI to FPGA.
It seems that most drivers do not use this case. Is there any example
which does ?

Thank you very much,
Ran
>> 3. How does device triggers DMA from cpu to device, is it by simply
>> reading from BAR ?
>
