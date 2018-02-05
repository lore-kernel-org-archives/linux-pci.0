Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46995 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBEPxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Feb 2018 10:53:17 -0500
Received: by mail-qk0-f193.google.com with SMTP id d125so12611217qkg.13
        for <linux-pci@vger.kernel.org>; Mon, 05 Feb 2018 07:53:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205084025.52129a85@w520.home>
References: <CAJ2oMhKRmSb-XFp2eeGEWqivL60C0uD22Yx1EdZ5ziAMOvmUUQ@mail.gmail.com>
 <20180205084025.52129a85@w520.home>
From: Ran Shalit <ranshalit@gmail.com>
Date: Mon, 5 Feb 2018 17:53:16 +0200
Message-ID: <CAJ2oMhLvugz1=-J+nBiOeD7_EKGTxWdtfZhrff55a1co=dkJ3A@mail.gmail.com>
Subject: Re: Q: uio_pci_generic
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 5, 2018 at 5:40 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 5 Feb 2018 15:58:22 +0200
> Ran Shalit <ranshalit@gmail.com> wrote:
>
>> Hello,
>>
>>
>> I can't find in uio_pci_generic.c any usage of DMA.
>> Is it that the driver does not use DMA in transactions between device
>> and host ? If not - isn't it a sort disadvantage ?
>
> AIUI, uio_pci_generic doesn't officially support DMA because there's no
> way that a userspace driver can safely support DMA without an IOMMU
> isolating the device.  Otherwise the userspace driver can use the
> device to read and write data anywhere it wants, which is also sort of
> a disadvantage.  Of course this doesn't seem to stop anyone from doing
> DMA with uio_pci_generic, but you're not likely to get much support for
> such uses.  Instead, you might want to be looking at vfio, which does
> make use of (and require) IOMMU support in order to more safely allow
> userspace drivers to use DMA.  Thanks,
>
Thanks you very much Alex. I will check vfio.
I would like to ask one mote thing on the issue of generic pci uio:
I also did not find  in
https://elixir.free-electrons.com/linux/v4.15.1/source/Documentation/ABI/testing/sysfs-bus-pci
that there is "irq" for registering irq, only msi-irq, which I don't
think it is the same.
Yet, in code it seems to use irq.
https://elixir.free-electrons.com/linux/v4.3/source/drivers/uio/uio_pci_generic.c

I also see in wiki guide & example that irq can be used in userspace
(in the code example there is a wait for interrupt):
https://www.kernel.org/doc/html/v4.12/driver-api/uio-howto.html
Yet, unfortunately the same wiki did not show how to register irq from
userspace.
Is that possible ? How ?
Should it be done with something like:
echo "3" > /sys/bus/pci/drivers/uio_pci_generic/irq



Thank you.
Ran


> Alex
