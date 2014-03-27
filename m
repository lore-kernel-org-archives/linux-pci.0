Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33828 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbaC0GNm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 02:13:42 -0400
Received: by mail-wi0-f169.google.com with SMTP id hm4so5472433wib.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2014 23:13:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5OoxphacWhCCXS7LrpgJSdmq1wgqFdKByMEoqCAamH2Q@mail.gmail.com>
References: <CANwwZzXdFsZGcjwOZURNG4=NPj0ZZ20e7euecGjgv==g=pBusQ@mail.gmail.com>
	<CAErSpo5OoxphacWhCCXS7LrpgJSdmq1wgqFdKByMEoqCAamH2Q@mail.gmail.com>
Date: Thu, 27 Mar 2014 11:43:41 +0530
Message-ID: <CANwwZzVk+wE_q6EFZPGm=SeBXncFC3M_6SV8EmY9nvMnMVsuMw@mail.gmail.com>
Subject: Re: query regarding BAR mapping
From: Bob Biloxi <iambobbiloxi@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> You should start by looking at and copying an existing, working
> driver.  bnx2x and ixgbe are examples for some current hardware, but
> they are big and complicated.  e100 is older but simpler.  A
> networking person could give better advice.

Thank you Bjorn.. This is really helpful. I'll go through the examples
you've suggested.

> The BAR determines the size in MMIO space.  I'm not sure what you mean
> by "have only 128MB at my disposal."  If you have limited virtual
> memory space and your driver doesn't need the whole MMIO region, you
> can just map the part you need.
>

Yes. I had limited virtual memory space. Thanks for explaining that I
can map just selective parts.
I didn't know that. I was thinking all or none.

> pci_iomap() is a good place to start.  That gives you an __iomem
> address that you can then pass to ioread*() and iowrite*() to access
> the MMIO region.  It maps the entire region, so if you need less,
> you'd probably use ioremap() directly.
>

Thanks so much. You're really helpful. Now I have an idea what kernel
calls I should be looking at.



Thank you so much!!
Best Regards,
Marc


On Wed, Mar 26, 2014 at 10:58 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Mar 26, 2014 at 5:50 AM, Bob Biloxi <iambobbiloxi@gmail.com> wrote:
>> Hi All,
>>
>> I am writing a driver for PCIe network device. I am still trying to
>> learn, so my question might be like a simple one as I do not
>> understand most of the things.
>
> You should start by looking at and copying an existing, working
> driver.  bnx2x and ixgbe are examples for some current hardware, but
> they are big and complicated.  e100 is older but simpler.  A
> networking person could give better advice.
>
>> From the BAR0 address that I read, the memory size is around 256MB.
>> But I have only 128MB at my disposal.
>
> The BAR determines the size in MMIO space.  I'm not sure what you mean
> by "have only 128MB at my disposal."  If you have limited virtual
> memory space and your driver doesn't need the whole MMIO region, you
> can just map the part you need.
>
>> So my question is how do i map this BAR so as to access the MMIO region.
>
> pci_iomap() is a good place to start.  That gives you an __iomem
> address that you can then pass to ioread*() and iowrite*() to access
> the MMIO region.  It maps the entire region, so if you need less,
> you'd probably use ioremap() directly.
>
> Bjorn
