Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417FAC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 09:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12DF207E0
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WM1oug9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfDBJug (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:50:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33162 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBJug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 05:50:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so1962496wmi.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2019 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNIwbrU+yL4GlXLvsZmCYmdErAo63lP29z0Zx/tEzGs=;
        b=WM1oug9l+6rNupNxioIoYFBgMbEhgkHdOh9VYN7c/9sJnXUSkH5d+l07Y95LMznDV2
         B0MQhq5L5dspAs1YG21KiY13tMkjXSxv81hYvrovcoO/I4ahJmu+NWD34UsdIhy5tBnD
         zjbwEe+PEuUWGH/0LqYhzRoleXjvHIvBv6Ays=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNIwbrU+yL4GlXLvsZmCYmdErAo63lP29z0Zx/tEzGs=;
        b=nzw8z5NQKbi2Iyr+URuKBVzO+oS9d3XK6duXwX2rzzxUsqYLXh+Qu0em5M/PMYBWtX
         RuqxZ3nNdTDT4oEJSg852IrAFXZAvbGq1yXSGBb9q8ZtlafiFyouWdgfGBO9os5T5qwY
         5O8Ua7IKpfizssiW2XnyKZYW1esHg+uPi9Ct3XtLk5yWD9L6I7EzafsOlv9QNHe5rYC4
         gZoL9ZB8TZ8RK9rGsU3moX437UfnosSHHVFtvfxSq2g43EfDyzPdTw4DfZ8DIugjZjzD
         XYV85Z7Xy6T70W9CP1Kp7WnyqeRY6vuKjIaA9DoX3R8COiw4wS4B1tE+CA29+4U870sf
         Gh1w==
X-Gm-Message-State: APjAAAXP/pKv+4NWwrGJpWYbWX9ECF2FnCcG5XoJE6F82jCgiZBAQ8Pi
        3UUcF7RcJrYxwwkZlmM8jx0V3+EzfC/eXs4JSUQESQ==
X-Google-Smtp-Source: APXvYqxJ4Jw9kUEgIZ8FuuV+e4O4cGmc99wg11Jm32iinq99JO8bk8jj5p9IKwAgpq+C4Y2qXFGq+40sMErLEtlUjtE=
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr2866373wmf.5.1554198633265;
 Tue, 02 Apr 2019 02:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <1551415936-30174-3-git-send-email-srinath.mannam@broadcom.com>
 <20190329173515.GA10367@e107981-ln.cambridge.arm.com> <CABe79T7LwFLST0dwwswv8sdqHcn0T4ked5WtcNpM78XUDUN3Jw@mail.gmail.com>
 <20190401164416.GA8616@e107981-ln.cambridge.arm.com> <e7d3e5a1-db5c-8438-f10f-81b87aba0e03@broadcom.com>
In-Reply-To: <e7d3e5a1-db5c-8438-f10f-81b87aba0e03@broadcom.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 2 Apr 2019 15:20:21 +0530
Message-ID: <CABe79T7uLo+68P0Yr7jpgn1+4H01qhoPRjX05gszin3FXkBZ5w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ray,

Thanks for detailed explanation.
Please see some more details below.

On Tue, Apr 2, 2019 at 3:33 AM Ray Jui <ray.jui@broadcom.com> wrote:
>
> Hi Lorenzo/Srinath,
>
> I look at the commit message again and indeed it looks quite confusing.
>
> I'll add my comment inline in the code section. I hope that will help to
> make it more clear.
>
> On 4/1/2019 9:44 AM, Lorenzo Pieralisi wrote:
> > On Mon, Apr 01, 2019 at 11:04:48AM +0530, Srinath Mannam wrote:
> >> Hi Lorenzo,
> >>
> >> Please see my reply below,
> >>
> >> On Fri, Mar 29, 2019 at 11:06 PM Lorenzo Pieralisi
> >> <lorenzo.pieralisi@arm.com> wrote:
> >>>
> >>> On Fri, Mar 01, 2019 at 10:22:16AM +0530, Srinath Mannam wrote:
> >>>> In the present driver outbound window configuration is done to map above
> >>>> 32-bit address I/O regions with corresponding PCI memory range given in
> >>>> ranges DT property.
> >>>>
> >>>> This patch add outbound window configuration to map below 32-bit I/O range
> >>>> with corresponding PCI memory, which helps to access I/O region in ARM
> >>>> 32-bit and one to one mapping of I/O region to PCI memory.
> >>>>
> >>>> Ex:
> >>>> 1. ranges DT property given for current driver is,
> >>>>     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
> >>>>     I/O region address is 0x400000000
> >>>> 2. ranges DT property can be given after this patch,
> >>>>     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
> >>>>     I/O region address is 0x42000000
> >>>
> >>> I was applying this patch but I don't understand the commit log and
> >>> how it matches the code, please explain it to me and I will reword
> >>> it.
> >> Iproc PCIe host controller supports outbound address translation
> >> feature to translate AXI address to PCI bus address.
> >> IO address ranges (AXI and PCI) given through ranges DT property have
> >> to program to controller outbound window registers.
> >> Present driver has the support for only 64bit AXI address. so that
> >> ranges DT property has given as 64bit AXI address and 32 bit
> >> PCI bus address.
> >> But with this patch 32-bit AXI address also could be programmed to
> >> Iproc host controller outbound window registers. so that ranges
> >> DT property can have 32bit AXI address which can map to 32-bit PCI bus address.
> >
> > The code change seems to add a check for the window size, I see no
> > notion of 64 vs 32 bit addressing there so I am pretty sure there is
> > something you are not telling me that is implicit in the IProc outbound
> > window configuration, for instance why is the lowest index window
> > considered for 32-bit.
> >
> > AFAICS you are adding code to allow a window whose size is < than
> > the lowest index in the ob_map array. How this relates to 64 vs
> > 32 bit addresses is not clear but it should be.
> >
> > When I read your commit log it is impossible to understand how it
> > correlates to the code you are changing - I still have not figured it
> > out myself.
> >
> > Please explain in detail to me how this works, forget DT changes I
> > want to understand how HW works.
> >
> > Lorenzo
> >
> >> Example given in commit log is describing ranges DT property changes
> >> with and without this patch.
> >> In the case, without this patch AXI address is more than 32bit
> >> "0x400000000". and with this patch AXI address is 32-bit "0x42000000".
> >> PCI bus address is 32 bit address in both the cases "0x40000000" and 0x42000000.
> >>
> >> Regards,
> >> Srinath.
> >>> Thanks,
> >>> Lorenzo
> >>>
> >>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> >>>> Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> >>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >>>> ---
> >>>>  drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
> >>>>  1 file changed, 19 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> >>>> index b882255..080f142 100644
> >>>> --- a/drivers/pci/controller/pcie-iproc.c
> >>>> +++ b/drivers/pci/controller/pcie-iproc.c
> >>>> @@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> >>>>                       resource_size_t window_size =
> >>>>                               ob_map->window_sizes[size_idx] * SZ_1M;
> >>>>
> >>>> -                     if (size < window_size)
> >>>> -                             continue;
> >>>> +                     /*
> >>>> +                      * Keep iterating until we reach the last window and
> >>>> +                      * with the minimal window size at index zero. In this
> >>>> +                      * case, we take a compromise by mapping it using the
> >>>> +                      * minimum window size that can be supported
> >>>> +                      */
>
> I think the code comment above is much more clear than the commit
> message. It looks like the commit message was to describe a particular
> use case that prompts the code change. However, if I remember correctly,
> during our internal review, I already made some modification to the code
> to make the change much more generic than dealing with a special use
> case. This patch contains the generic change I made.
>
> Basically, 'size' is the intended outbound mapping size (from DT or ACPI
> or whatever, it does not really matter). 'window_size' is a specific
> mapping window size our PCIe controller can support. Our PCIe controller
> supports a fixed set of outbound mapping window sizes. I don't think
> this is much different from some other PCIe controllers.
>
> It looks like, there are cases where one cannot find an exact match
> between 'size' and 'window_size'. In this case, and when we know we have
> already exhausted all possible mapping windows, i.e., 'size_idx' == 0
> AND 'window_idx' == 0, we take a compromise by programming the outbound
> mapping by using a window size that's actually larger than the 'size'.
>
> Srinath, please correct me if I'm wrong. But I carefully reviewed the
> code again and I believe this is essentially what it is.
>
128MB is the minimum size of window available to configure outbound
memory. But size of 32bit AXI address region
of our controller is 32MB. Also this 32bit AXI address region has to
configure in OARR0. so that 32bit AXI address region
is configured in 128MB window of OARR0.
this is the reason in the below to allow ob window configure only when
size_idx is 0 which means window size 128MB
and window_idx is 0 means OARR0 else continue using (size_idx > 0 ||
window_idx > 0) condition.

Regards,
Srinath.
> If so, then the commit message is quite misleading and can be changed to
> above descriptions.
>
> >>>> +                     if (size < window_size) {
> >>>> +                             if (size_idx > 0 || window_idx > 0)
> >>>> +                                     continue;
> >>>> +
> >>>> +                             /*
> >>>> +                              * For the corner case of reaching the minimal
> >>>> +                              * window size that can be supported on the
> >>>> +                              * last window
> >>>> +                              */
> >>>> +                             axi_addr = ALIGN_DOWN(axi_addr, window_size);
> >>>> +                             pci_addr = ALIGN_DOWN(pci_addr, window_size);
> >>>> +                             size = window_size;
> >>>> +                     }
> >>>>
> >>>>                       if (!IS_ALIGNED(axi_addr, window_size) ||
> >>>>                           !IS_ALIGNED(pci_addr, window_size)) {
> >>>> --
> >>>> 2.7.4
> >>>>
