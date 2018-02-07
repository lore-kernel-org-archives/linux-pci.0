Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32783 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753654AbeBGHCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Feb 2018 02:02:02 -0500
Received: by mail-qk0-f182.google.com with SMTP id c82so5655992qka.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2018 23:02:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CY4PR02MB3221824AF76CFC24FC7B9A99DAFC0@CY4PR02MB3221.namprd02.prod.outlook.com>
References: <CAJ2oMhKJ5ECtr5-F1M_PjO+ev_8-UfpLu+jT9hG7XEwoDV0A_Q@mail.gmail.com>
 <CY4PR02MB3221824AF76CFC24FC7B9A99DAFC0@CY4PR02MB3221.namprd02.prod.outlook.com>
From: Ran Shalit <ranshalit@gmail.com>
Date: Wed, 7 Feb 2018 09:02:00 +0200
Message-ID: <CAJ2oMhKbYhbF28b=L1hhYs39oxJNA4whXv=D3eFfNnOdiTE+wg@mail.gmail.com>
Subject: Re: understanding DMA in PCI drivers
To: Ravikiran Gummaluri <rgummal@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 7, 2018 at 8:12 AM, Ravikiran Gummaluri <rgummal@xilinx.com> wrote:
> I am assuming DMA as on Host side. In this case Host DMA will me master for all transactions(Tx or Rx).
>  Point 4 may be not relevant ,as DMA on host is responsible in RX also.
>  All this points will be relevant when DMA is working on memory mapped mode meaning transferring from Host memory to EP memory.
> In a simple example , Tx direction DMA descriptors will be programmed with Host buffer and BAR address. Host will program DMA register to trigger transfer. DMA on host will move Data from Host to EP.
> IN RX direction , DMA will be preprogrammed with host buffers, Host will program DMA registers to fetch data from EP to Host.
>

I tried to check pci-skeleton.c as an example:
It allocates dma buffer in host, but triggering dma is done by writing
a register in EP memory (as if the endpoint is actually triggering the
dma transaction), so I'm a bit confused here. I think that it triggers
both tx and rx the same way (writing EP memory register).
Are you familiar with a simple example or tuturial which explains how
to operate host dma in PCI ? I am a bit confused with this topic of
dma in pci.

Thank you,
Ran



Thanks,
Ran



>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> owner@vger.kernel.org] On Behalf Of Ran Shalit
>> Sent: Wednesday, February 7, 2018 12:33 AM
>> To: linux-pci@vger.kernel.org
>> Subject: understanding DMA in PCI drivers
>>
>> Hello,
>>
>> I write a pci linux driver, and after reviewing some examples in kernel, there
>> is issue I am not sure about:
>> DMA seems to follow the following steps in PCI:
>> 1.  driver allocate dma buffers and map them to BAR.
>> 2. driver initialize device to be familiar with dma addresses.
>> 3. tx from cpu to device: driver trigger dma, by writing into device BARs.
>> 4. rx from device to cpu: device is responsible for triggering DMA (driver does
>> not do anything here) 5. tx/rx completion: interrupt from DMA (in cpu) 6.
>> interrupt handler of section 5 above checks that device finished tx/rx.
>>
>> Is the above understanding correct ?
>> 1. As to 6, I am not sure about, is it that device knows that transaction is
>> finished (DMA is in soc , not device) ?
>> 2. How does device triggers DMA from device to cpu, is it by simply writing to
>> BAR ?
>> 3. How does device triggers DMA from cpu to device, is it by simply reading
>> from BAR ?
>>
>> Thank you,
>> Ran
