Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37975C10F00
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 10:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5005208E4
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 10:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gm63wakm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfDBKq1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:46:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36561 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfDBKq0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 06:46:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so3093157wml.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2019 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j03gGqwqVdv6GcgPSmxg7WCygksnKQsO9f3F4wcW/m0=;
        b=Gm63wakmrhUm4KTsfmTMDbDNUQlbdtbqNyGtLwEdVK3YM/emb7kRQYW2FW2b+j4gam
         Mj/bayUhzlE14N0vTjoD/4X3x5XY1FN0u50WdiRqKn9i/9Y4c9RI/E85q0Nv97/S4Zps
         ixxGB8oT1xmcxk9oqN8nW+0Zha11eQKWxoFgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j03gGqwqVdv6GcgPSmxg7WCygksnKQsO9f3F4wcW/m0=;
        b=tSLc0GejtM9KNsymFuiVBsrWhVduHQUEJJV0Cczuc0wQfQiJU/4SGaIvujCLNjRBg2
         x55gFUzG5SibCud6A9L5AkF1GBbSMkwX475XhLp5NXLR+NhcVS1DGN0oyGQY8I9qz5cU
         42O0WUgCdzhz9z0PS3ijgSuOhA0hYEujocxWlbAJ1pw7MuOMl+jcSNinFWANml+qfhBb
         CZa5F+83TR0hYDlEGFZGf6xGI/5DzhD3zh4NCWjyjYFgn8BW+jL6o8yGuF5E42G1dDiI
         I6lP9ZuL+iW4MJ3U6dndb0jHpLxff8rltNTRebdbHQ9SdceCCx00rrVpG+dcmAKDMurK
         JINg==
X-Gm-Message-State: APjAAAUhTwh7ijWZNvxR+IcYaTKEWXA2YSJJepMRb993IcIQvORfZ7qw
        PKQ+D1zpTha3Ee2J5pvk24wdaSUHqjo6uI2E8M2tog==
X-Google-Smtp-Source: APXvYqzT6gAO7SqHNYjFPuV64Qiib3wNP0UXsCCNgaFM8y9JFLvIgkgLa7R+nT6if0u/FP1K3S2XpZF9hZl2FDZHZH4=
X-Received: by 2002:a1c:f618:: with SMTP id w24mr3267020wmc.3.1554201984809;
 Tue, 02 Apr 2019 03:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <1551415936-30174-3-git-send-email-srinath.mannam@broadcom.com>
 <20190329173515.GA10367@e107981-ln.cambridge.arm.com> <CABe79T7LwFLST0dwwswv8sdqHcn0T4ked5WtcNpM78XUDUN3Jw@mail.gmail.com>
 <20190401164416.GA8616@e107981-ln.cambridge.arm.com> <e7d3e5a1-db5c-8438-f10f-81b87aba0e03@broadcom.com>
 <CABe79T7uLo+68P0Yr7jpgn1+4H01qhoPRjX05gszin3FXkBZ5w@mail.gmail.com> <20190402102639.GB22708@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190402102639.GB22708@e107981-ln.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 2 Apr 2019 16:16:13 +0530
Message-ID: <CABe79T5O-1EWVrR1vZ27LWuxTBqN4_x37bkpfKxfm1ZB+oDUvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
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

Hi Lorenzo,

Please see my reply below,

On Tue, Apr 2, 2019 at 3:56 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Apr 02, 2019 at 03:20:21PM +0530, Srinath Mannam wrote:
> > Hi Ray,
> >
> > Thanks for detailed explanation.
> > Please see some more details below.
> >
> > On Tue, Apr 2, 2019 at 3:33 AM Ray Jui <ray.jui@broadcom.com> wrote:
> > >
> > > Hi Lorenzo/Srinath,
> > >
> > > I look at the commit message again and indeed it looks quite confusing.
> > >
> > > I'll add my comment inline in the code section. I hope that will help to
> > > make it more clear.
> > >
> > > On 4/1/2019 9:44 AM, Lorenzo Pieralisi wrote:
> > > > On Mon, Apr 01, 2019 at 11:04:48AM +0530, Srinath Mannam wrote:
> > > >> Hi Lorenzo,
> > > >>
> > > >> Please see my reply below,
> > > >>
> > > >> On Fri, Mar 29, 2019 at 11:06 PM Lorenzo Pieralisi
> > > >> <lorenzo.pieralisi@arm.com> wrote:
> > > >>>
> > > >>> On Fri, Mar 01, 2019 at 10:22:16AM +0530, Srinath Mannam wrote:
> > > >>>> In the present driver outbound window configuration is done to map above
> > > >>>> 32-bit address I/O regions with corresponding PCI memory range given in
> > > >>>> ranges DT property.
> > > >>>>
> > > >>>> This patch add outbound window configuration to map below 32-bit I/O range
> > > >>>> with corresponding PCI memory, which helps to access I/O region in ARM
> > > >>>> 32-bit and one to one mapping of I/O region to PCI memory.
> > > >>>>
> > > >>>> Ex:
> > > >>>> 1. ranges DT property given for current driver is,
> > > >>>>     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
> > > >>>>     I/O region address is 0x400000000
> > > >>>> 2. ranges DT property can be given after this patch,
> > > >>>>     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
> > > >>>>     I/O region address is 0x42000000
> > > >>>
> > > >>> I was applying this patch but I don't understand the commit log and
> > > >>> how it matches the code, please explain it to me and I will reword
> > > >>> it.
> > > >> Iproc PCIe host controller supports outbound address translation
> > > >> feature to translate AXI address to PCI bus address.
> > > >> IO address ranges (AXI and PCI) given through ranges DT property have
> > > >> to program to controller outbound window registers.
> > > >> Present driver has the support for only 64bit AXI address. so that
> > > >> ranges DT property has given as 64bit AXI address and 32 bit
> > > >> PCI bus address.
> > > >> But with this patch 32-bit AXI address also could be programmed to
> > > >> Iproc host controller outbound window registers. so that ranges
> > > >> DT property can have 32bit AXI address which can map to 32-bit PCI bus address.
> > > >
> > > > The code change seems to add a check for the window size, I see no
> > > > notion of 64 vs 32 bit addressing there so I am pretty sure there is
> > > > something you are not telling me that is implicit in the IProc outbound
> > > > window configuration, for instance why is the lowest index window
> > > > considered for 32-bit.
> > > >
> > > > AFAICS you are adding code to allow a window whose size is < than
> > > > the lowest index in the ob_map array. How this relates to 64 vs
> > > > 32 bit addresses is not clear but it should be.
> > > >
> > > > When I read your commit log it is impossible to understand how it
> > > > correlates to the code you are changing - I still have not figured it
> > > > out myself.
> > > >
> > > > Please explain in detail to me how this works, forget DT changes I
> > > > want to understand how HW works.
> > > >
> > > > Lorenzo
> > > >
> > > >> Example given in commit log is describing ranges DT property changes
> > > >> with and without this patch.
> > > >> In the case, without this patch AXI address is more than 32bit
> > > >> "0x400000000". and with this patch AXI address is 32-bit "0x42000000".
> > > >> PCI bus address is 32 bit address in both the cases "0x40000000" and 0x42000000.
> > > >>
> > > >> Regards,
> > > >> Srinath.
> > > >>> Thanks,
> > > >>> Lorenzo
> > > >>>
> > > >>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > >>>> Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > > >>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > > >>>> ---
> > > >>>>  drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
> > > >>>>  1 file changed, 19 insertions(+), 2 deletions(-)
> > > >>>>
> > > >>>> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > >>>> index b882255..080f142 100644
> > > >>>> --- a/drivers/pci/controller/pcie-iproc.c
> > > >>>> +++ b/drivers/pci/controller/pcie-iproc.c
> > > >>>> @@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> > > >>>>                       resource_size_t window_size =
> > > >>>>                               ob_map->window_sizes[size_idx] * SZ_1M;
> > > >>>>
> > > >>>> -                     if (size < window_size)
> > > >>>> -                             continue;
> > > >>>> +                     /*
> > > >>>> +                      * Keep iterating until we reach the last window and
> > > >>>> +                      * with the minimal window size at index zero. In this
> > > >>>> +                      * case, we take a compromise by mapping it using the
> > > >>>> +                      * minimum window size that can be supported
> > > >>>> +                      */
> > >
> > > I think the code comment above is much more clear than the commit
> > > message. It looks like the commit message was to describe a particular
> > > use case that prompts the code change. However, if I remember correctly,
> > > during our internal review, I already made some modification to the code
> > > to make the change much more generic than dealing with a special use
> > > case. This patch contains the generic change I made.
> > >
> > > Basically, 'size' is the intended outbound mapping size (from DT or ACPI
> > > or whatever, it does not really matter). 'window_size' is a specific
> > > mapping window size our PCIe controller can support. Our PCIe controller
> > > supports a fixed set of outbound mapping window sizes. I don't think
> > > this is much different from some other PCIe controllers.
> > >
> > > It looks like, there are cases where one cannot find an exact match
> > > between 'size' and 'window_size'. In this case, and when we know we have
> > > already exhausted all possible mapping windows, i.e., 'size_idx' == 0
> > > AND 'window_idx' == 0, we take a compromise by programming the outbound
> > > mapping by using a window size that's actually larger than the 'size'.
> > >
> > > Srinath, please correct me if I'm wrong. But I carefully reviewed the
> > > code again and I believe this is essentially what it is.
> > >
> > 128MB is the minimum size of window available to configure outbound
> > memory. But size of 32bit AXI address region
> > of our controller is 32MB. Also this 32bit AXI address region has to
> > configure in OARR0. so that 32bit AXI address region
> > is configured in 128MB window of OARR0.
> > this is the reason in the below to allow ob window configure only when
> > size_idx is 0 which means window size 128MB
> > and window_idx is 0 means OARR0 else continue using (size_idx > 0 ||
> > window_idx > 0) condition.
>
> Ok - I start to understand. What does it mean in HW terms that your
> 32bit AXI address region size is 32MB ? Please explain to me in details.
>
In our PCIe controller HW, AXI address from 0x42000000 to 0x44000000
of 32MB size and .
AXI address from 0x400000000 to 0x480000000 of 2GB size are provided
to map ob address.
First IO region is inside 32bit address and second IO region is
outside 32bit address.
This code change is to map first IO region(0x42000000 to 0x44000000).

> IIUC you are using an OARR0 of 128MB in size to map a 32MB address
> region, that's what I understand this patch does (and the lowest index
> corresponds to the smallest possible size - it is far from clear by
> looking at the patch).
Yes, lowest index corresponds to smallest possible size (128MB).
In our controller we have multiple windows like OARR0, OARR1, OARR2,
OARR3 all supports multiple sizes from 128MB to 1024MB.
These details are given at the top of this driver file, as shown
below. all windows supports 128MB size still we must use OARR0 window
to configure first IO region(0x42000000 to 0x44000000).

static const struct iproc_pcie_ob_map paxb_v2_ob_map[] = {
        {
                /* OARR0/OMAP0 */
                .window_sizes = { 128, 256 },
                .nr_sizes = 2,
        },
        {
                /* OARR1/OMAP1 */
                .window_sizes = { 128, 256 },
                .nr_sizes = 2,
        },
        {
                /* OARR2/OMAP2 */
                .window_sizes = { 128, 256, 512, 1024 },
                .nr_sizes = 4,
        },
        {
                /* OARR3/OMAP3 */
                .window_sizes = { 128, 256, 512, 1024 },
                .nr_sizes = 4,
        },
};

Regards,
Srinath.
>
> Please clarify.
>
> Thanks,
> Lorenzo
>
> > Regards,
> > Srinath.
> > > If so, then the commit message is quite misleading and can be changed to
> > > above descriptions.
> > >
> > > >>>> +                     if (size < window_size) {
> > > >>>> +                             if (size_idx > 0 || window_idx > 0)
> > > >>>> +                                     continue;
> > > >>>> +
> > > >>>> +                             /*
> > > >>>> +                              * For the corner case of reaching the minimal
> > > >>>> +                              * window size that can be supported on the
> > > >>>> +                              * last window
> > > >>>> +                              */
> > > >>>> +                             axi_addr = ALIGN_DOWN(axi_addr, window_size);
> > > >>>> +                             pci_addr = ALIGN_DOWN(pci_addr, window_size);
> > > >>>> +                             size = window_size;
> > > >>>> +                     }
> > > >>>>
> > > >>>>                       if (!IS_ALIGNED(axi_addr, window_size) ||
> > > >>>>                           !IS_ALIGNED(pci_addr, window_size)) {
> > > >>>> --
> > > >>>> 2.7.4
> > > >>>>
