Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC34C433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 08:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4985A208E3
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 08:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaPJgwxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4985A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeIXO0S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:26:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33308 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIXO0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 10:26:18 -0400
Received: by mail-io1-f68.google.com with SMTP id l25-v6so3826432ioj.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Sep 2018 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Vd2bcUzLyf63wvNjTIthHSlmHgcL+mKFC6Axx8gjCg=;
        b=HaPJgwxAnKTnGQgSYc/rtRL3eK1rT94JkqhxBePESFEFcIZqa+QRi0JMXyg0XwTaY6
         v0yTDEDpjetfnrEHOdarFZ3rxyWuSFXRDJAbw7AcXZrNyb0RLJF33gKkMIhp3VYA/0bN
         TAWzzQ8VjbtH6VmLYqBa41ovYy8Kk9wZcWwT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Vd2bcUzLyf63wvNjTIthHSlmHgcL+mKFC6Axx8gjCg=;
        b=GRfBIfXAEJmicSjmhsovFctPqK1EW72OJ3Gr3y5h8IYcFK9UjPgN1QZACfNB/dwikJ
         llnPS7QhUo382JTWxNdr45Ntdmu2bkgYeAY7zOF2lzpiQcA2oOAKY3vYalRoOFN47NK9
         XvZlDeFVVO6hwMxDOAEQlACmX7FgxjSLPoYdqpJFQdYDOkQRz6r6BTYCpwLbQr6dR5Do
         CssUt872NieI71HSUXdyzZuc38QCibwglh8jWeyVOwsI+UUFSs8kBp8AGyIp+S2YkDun
         lF8/9aUYxFT5s+3otA2xfwoCNB4QovoUvLAc2Ma/g6BSQgA3BH90qckYOrIiF43KytZK
         cYVA==
X-Gm-Message-State: ABuFfog3Hg/R9QBmMWZgdHWvXFMle6FHFGn44+rUDGdSRqUL4rbbL2RL
        fiBrVjOWE0XxMP5Ps9tYN4AMpOio9NWJ4drezvRtMD1j
X-Google-Smtp-Source: ACcGV63Kxdn6n0+tDNwN8o/NzoaKKUWW4yUWNOAd3ZfNS/DESS+HlHZiDxSjkyXuIbc4LuJXv1vuHJQXfkM5y0xuELI=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr7045182iob.170.1537777522432;
 Mon, 24 Sep 2018 01:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-5-git-send-email-jim2101024@gmail.com> <CAKv+Gu_d-r0ubyqZcDzERYd5FVTSpjBk++iACHqVgtHrOK0F7A@mail.gmail.com>
 <7fa897cf-4d58-c63f-afdd-a3ec5a6a56bf@gmail.com> <CAKv+Gu8aJRV4nqq1e-5HRLvbrANQsYuMf-pwWB53BhxLgX7iWg@mail.gmail.com>
 <b74d3c16-a512-73dc-c94a-ef6adde5f757@gmail.com> <CAKv+Gu8ZbN3BDRyuFzt4o--SSUmhuOh+jnpq8ZR-Ay13DJrAqg@mail.gmail.com>
 <fa285694-c3e1-adf8-032a-202e7598de41@gmail.com> <CANCKTBsypcVS_iC1+sbW5fMKfj+tTsxbQv9CvDwcO8GV3a8_Yg@mail.gmail.com>
In-Reply-To: <CANCKTBsypcVS_iC1+sbW5fMKfj+tTsxbQv9CvDwcO8GV3a8_Yg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Sep 2018 10:25:10 +0200
Message-ID: <CAKv+Gu-+OjJi8zGLqvnsOJQ9ygMot-O0EbyMKO-yyG-+k-274A@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound traffic
To:     Jim Quinlan <jim2101024@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 21 Sep 2018 at 19:41, Jim Quinlan <jim2101024@gmail.com> wrote:
>
> On Thu, Sep 20, 2018 at 5:39 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 09/20/2018 02:33 PM, Ard Biesheuvel wrote:
> > > On 20 September 2018 at 14:31, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >> On 09/20/2018 02:04 PM, Ard Biesheuvel wrote:
> > >>> On 20 September 2018 at 13:55, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >>>> On 09/19/2018 07:19 PM, Ard Biesheuvel wrote:
> > >>>>> On 19 September 2018 at 07:31, Jim Quinlan <jim2101024@gmail.com> wrote:
> > >>>>>> The Broadcom STB PCIe host controller is intimately related to the
> > >>>>>> memory subsystem.  This close relationship adds complexity to how cpu
> > >>>>>> system memory is mapped to PCIe memory.  Ideally, this mapping is an
> > >>>>>> identity mapping, or an identity mapping off by a constant.  Not so in
> > >>>>>> this case.
> > >>>>>>
> > >>>>>> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
> > >>>>>> of system memory.  Here is how the PCIe controller maps the
> > >>>>>> system memory to PCIe memory:
> > >>>>>>
> > >>>>>>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
> > >>>>>>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
> > >>>>>>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
> > >>>>>>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
> > >>>>>>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
> > >>>>>>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> > >>>>>>
> > >>>>>
> > >>>>> So is describing this as
> > >>>>>
> > >>>>> dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
> > >>>>>              <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
> > >>>>>              <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
> > >>>>>              <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
> > >>>>>              <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
> > >>>>>              <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;
> > >>>>>
> > >>>>> not working for you? I haven't tried this myself, but since DT permits
> > >>>>> describing the inbound mappings this way, we should fix the code if it
> > >>>>> doesn't work at the moment.
> > >>>>
> > >>>> You mean encoding the memory controller index in the first cell? If that
> > >>>> works, that's indeed a much cleaner solution, though is it standard
> > >>>> compliant in any form?
> > >>>
> > >>> No those are just memory addresses (although I may have screwed up the
> > >>> order). From Documentation/devicetree/booting-without-of.txt:
> > >>>
> > >>> """
> > >>> Optional property:
> > >>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
> > >>>         (child-bus-address, parent-bus-address, length). Each triplet specified
> > >>>         describes a contiguous DMA address range.
> > >>> """
> > >>>
> > >>
> > >> Then I am confused by your comment, that's what this patch does, it adds
> > >> support for reading "dma-ranges" from Device Tree and setting up inbound
> > >> windows using that. The only caveat is that because the PCIe root
> > >> complex has some ties with the memory bus architecture it is connected
> > >> to (SCB in our case) there is still a requirement to know the
> > >> translation between a given physical address and its backing memory
> > >> controller/aperture.
> > >>
> > >
> > > Ah ok, apologies for the noise then.
> > >
> > > I was hoping that having working support for dma-ranges would remove
> > > the need for the special phys<->dma conversion routines.
> >
> > What you describe definitively works with platform devices, but I am not
> > sure this is working for PCIe devices, although, conceptually it should,
> > yes.
> Sorry for my delay in responding.  One problem is that
> of_dma_configure() only looks at the first dma-range given and then
> converts it to dev->dma_pfn_offset which is respected by the DMA API.
> However, we often have multiple dma-ranges, not just one.  This is the
> big issue.
>

Given the recent attention to getting these APIs in shape, this may be
something Robin or Christoph may care to look into?

In any case, the description of dma-ranges should be in sync with the
way Linux interprets it, so this is either a documentation bug or a
DMA layer bug.

> There is another issue with of_dma_configure() being invoked by the EP
> driver on "bridge->parent->of_node", which is our RC device,
> Of_dma_configure() calls of_dma_range() on the of_get_next_parent() of
> our RC's device node and this misses the dma-ranges property which is
> contained within the RC.  I think I could workaround this but there is
> no getting around the first problem.
>

IIUC dma-ranges should be added to the parent bus of a device, which I
guess is slightly ambiguous for a root complex that incorporates a
host bridge.
