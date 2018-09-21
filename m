Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F4ECE567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562E221479
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 17:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj6qTXSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562E221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbeIUXbI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:31:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38773 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390433AbeIUXbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 19:31:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id z186-v6so12133301lfa.5;
        Fri, 21 Sep 2018 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdn0FP0mzVeQeT3EBawRAzkjQsRIZaRd6cBM7471M2Q=;
        b=Tj6qTXSpe65h7mulLbspqBQwgA3wEAUZ67XZzpjJ5xUSn6Yy9bRiyGe78+8XWhtGzO
         a72rWYa6c9FMiineQyAVyvZrkD5vbF1PDugEpjhwmjn3oxOu6Uix5MIl6MpP6/kyRUJB
         hJZrWlHZDqIRfhEFSmJMIr400dAsdq4ydEz+A3ej2AFzzVvhEh4lGc5wQYSfRRf4+1F9
         ljUPaYjef/vIU/MH9Xg/7YaJIfeVDvdJE933ZX80C4diDEi0/ST3NycwLcdav8wBckny
         icf03keObbygZr+hJfMrc30rQcV8nfeIqwj9RKQ/6YuiE4Ho5egggEGU3QUDyYEonYyR
         azXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdn0FP0mzVeQeT3EBawRAzkjQsRIZaRd6cBM7471M2Q=;
        b=qanDICcGXMO5YeyG7BGwE61rE9tDiWs4e9mjyExCZBQg+TwAj8xb4Jobka7uGUui8i
         NQnwX8Eta0XDHrPeCqsz0RqHZuFtEkzBAFito000VKgX8bi8P91GewIsMwuNjF13jnbo
         wO3/mcxIQys8gYFdmPogWLjn91fyFbwB79ZU3QR6PvsGdwQ1NgTAjiaPFX/Y6ofGzV+A
         crX+5xNMu9qSC+6ESi25fv3vRy/EpI9a26hbDQoi251Ln7p5Lt6lSwB1Y9x14gmxOj6w
         qjw7bpVWZFkIWbmI4Znv9f7ZkrYe6BKDl/aQtpmB9UKDrUIDvHxdjSUb1TLPVklgoTu1
         uD7A==
X-Gm-Message-State: APzg51BWAa8JAnmFtwkDBAoaKA52Pt9jVafeoN86JoxCfZ+Ilm7gaWF9
        AxZDHAkTQPhPHAZ4CbJTQsi+bOUopWmHyNcjhO0=
X-Google-Smtp-Source: ANB0VdaS+KhPGgshhjjSSL4Hn6mNRb3uwcg8C7HVBw4u7XtWO+w3PLfGG8YR6dMJcNe7CFP1SYqvkqmVo/Rr4d2nte8=
X-Received: by 2002:a19:2583:: with SMTP id l125-v6mr17348646lfl.135.1537551670390;
 Fri, 21 Sep 2018 10:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-5-git-send-email-jim2101024@gmail.com> <CAKv+Gu_d-r0ubyqZcDzERYd5FVTSpjBk++iACHqVgtHrOK0F7A@mail.gmail.com>
 <7fa897cf-4d58-c63f-afdd-a3ec5a6a56bf@gmail.com> <CAKv+Gu8aJRV4nqq1e-5HRLvbrANQsYuMf-pwWB53BhxLgX7iWg@mail.gmail.com>
 <b74d3c16-a512-73dc-c94a-ef6adde5f757@gmail.com> <CAKv+Gu8ZbN3BDRyuFzt4o--SSUmhuOh+jnpq8ZR-Ay13DJrAqg@mail.gmail.com>
 <fa285694-c3e1-adf8-032a-202e7598de41@gmail.com>
In-Reply-To: <fa285694-c3e1-adf8-032a-202e7598de41@gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 21 Sep 2018 13:40:58 -0400
Message-ID: <CANCKTBsypcVS_iC1+sbW5fMKfj+tTsxbQv9CvDwcO8GV3a8_Yg@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound traffic
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 20, 2018 at 5:39 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 09/20/2018 02:33 PM, Ard Biesheuvel wrote:
> > On 20 September 2018 at 14:31, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >> On 09/20/2018 02:04 PM, Ard Biesheuvel wrote:
> >>> On 20 September 2018 at 13:55, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>> On 09/19/2018 07:19 PM, Ard Biesheuvel wrote:
> >>>>> On 19 September 2018 at 07:31, Jim Quinlan <jim2101024@gmail.com> wrote:
> >>>>>> The Broadcom STB PCIe host controller is intimately related to the
> >>>>>> memory subsystem.  This close relationship adds complexity to how cpu
> >>>>>> system memory is mapped to PCIe memory.  Ideally, this mapping is an
> >>>>>> identity mapping, or an identity mapping off by a constant.  Not so in
> >>>>>> this case.
> >>>>>>
> >>>>>> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
> >>>>>> of system memory.  Here is how the PCIe controller maps the
> >>>>>> system memory to PCIe memory:
> >>>>>>
> >>>>>>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
> >>>>>>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
> >>>>>>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
> >>>>>>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
> >>>>>>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
> >>>>>>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> >>>>>>
> >>>>>
> >>>>> So is describing this as
> >>>>>
> >>>>> dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
> >>>>>              <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
> >>>>>              <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
> >>>>>              <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
> >>>>>              <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
> >>>>>              <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;
> >>>>>
> >>>>> not working for you? I haven't tried this myself, but since DT permits
> >>>>> describing the inbound mappings this way, we should fix the code if it
> >>>>> doesn't work at the moment.
> >>>>
> >>>> You mean encoding the memory controller index in the first cell? If that
> >>>> works, that's indeed a much cleaner solution, though is it standard
> >>>> compliant in any form?
> >>>
> >>> No those are just memory addresses (although I may have screwed up the
> >>> order). From Documentation/devicetree/booting-without-of.txt:
> >>>
> >>> """
> >>> Optional property:
> >>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
> >>>         (child-bus-address, parent-bus-address, length). Each triplet specified
> >>>         describes a contiguous DMA address range.
> >>> """
> >>>
> >>
> >> Then I am confused by your comment, that's what this patch does, it adds
> >> support for reading "dma-ranges" from Device Tree and setting up inbound
> >> windows using that. The only caveat is that because the PCIe root
> >> complex has some ties with the memory bus architecture it is connected
> >> to (SCB in our case) there is still a requirement to know the
> >> translation between a given physical address and its backing memory
> >> controller/aperture.
> >>
> >
> > Ah ok, apologies for the noise then.
> >
> > I was hoping that having working support for dma-ranges would remove
> > the need for the special phys<->dma conversion routines.
>
> What you describe definitively works with platform devices, but I am not
> sure this is working for PCIe devices, although, conceptually it should,
> yes.
Sorry for my delay in responding.  One problem is that
of_dma_configure() only looks at the first dma-range given and then
converts it to dev->dma_pfn_offset which is respected by the DMA API.
However, we often have multiple dma-ranges, not just one.  This is the
big issue.

There is another issue with of_dma_configure() being invoked by the EP
driver on "bridge->parent->of_node", which is our RC device,
Of_dma_configure() calls of_dma_range() on the of_get_next_parent() of
our RC's device node and this misses the dma-ranges property which is
contained within the RC.  I think I could workaround this but there is
no getting around the first problem.

Thanks,
Jim

> --
> Florian
