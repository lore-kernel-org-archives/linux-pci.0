Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:43212 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbdLHI2P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 03:28:15 -0500
Received: by mail-wr0-f175.google.com with SMTP id z34so10002337wrz.10
        for <linux-pci@vger.kernel.org>; Fri, 08 Dec 2017 00:28:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171122080240.6bd46a28@why.wild-wind.fr.eu.org>
References: <CAFZiPx1sgxr8X9mtW11fK1XMPuk+4jUFb5Cc-pVJn06ZztHwng@mail.gmail.com>
 <20171108172424.GA19449@infradead.org> <CAFZiPx0wbm=hA0qXMjJihOaeRHhKzgZdSLTwTZdGZ2aoMM-3Rw@mail.gmail.com>
 <20171122080240.6bd46a28@why.wild-wind.fr.eu.org>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Dec 2017 13:58:13 +0530
Message-ID: <CAFZiPx2iR1-D5+8gvPjvG9qeFefOTqFqZ=UXc3aR66Wya9m3zg@mail.gmail.com>
Subject: Re: [Patch] export irq_set_msi_desc
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, jason@lakedaemon.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Marc,
I have dropped this patch off from the patch series.
I will look into generic handling of MSI too.

Thanks.


On Wed, Nov 22, 2017 at 1:32 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Thu, 9 Nov 2017 10:42:06 +0530
> subrahmanya l <l.subrahmanya@mobiveil.co.in> wrote:
>
>> Christoph,
>>
>> Xilinx MSI driver uses it.
>>
>> file path: https://github.com/Xilinx/linux-xlnx/blob/master/drivers/pci/host/pcie-xilinx.c#L286
>>
>> I used the same driver as reference to write another Rootport driver
>> which needs it too.
>
> You shouldn't need this at all. The driver you are looking at is using
> a deprecated API, and you should implement the MSI part of your driver
> using the generic MSI layer which takes care of this and shouldn't
> require exporting this function.
>
> There is a number of drivers in the tree that have been converted to
> generic MSI, such as pcie-tango.c for example.
>
> Thanks,
>
>         M.
> --
> Without deviation from the norm, progress is not possible.
