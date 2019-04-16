Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D61DC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 11:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4AA20821
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 11:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y3qzE8Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfDPL6u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:58:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51942 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfDPL6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 07:58:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so25015286wmf.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvK2sa7exPaSAS1BCNTfVTF+f0dJduiqmdfTPCXRTxQ=;
        b=Y3qzE8CuehoVU2JfivbphrYd1kXSDbWiJd15b0YraHpauEe4+3KgXpvysPrkt+d0+q
         Nie2KkJCmBPzIQ1V+zNzrgXmt6Q4MZ/+r86391Oh9LisXSvHVyF1Ifnjb5usb/3vVRCO
         +rq6v7h1N3Hztfqd3Hg9RpyDQgCgLjefkXfnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvK2sa7exPaSAS1BCNTfVTF+f0dJduiqmdfTPCXRTxQ=;
        b=gPjVaTbAcMSnHe8ATzj0LzPgU4QsOsbWAgxq2dJewehYWkYju2ZeBZGZ/5na4d1tsx
         DkV55CUym2Knnaa5KNV7JEHS2CB6zY1IfcyeJRTDB9hqornpAPm00cWtcDku0B6mU4qA
         wExKS1ZwbbhTOaRo2Z4LjHgK4oyGzgBHSz6zAVrz+GI7wpuKhTIZ9b337AC+kse2Wb/S
         05/Kh6s4nAKuhWkRdMzU0kmnzUfdRJRKNnjfvdluAYBySth209b2tgw7T7fYRcjhA0Bm
         eiQJVv0Y4BGUIEGnHSMvwsNcTUaVHCbXp9FEN4VFx+8xbDO8JlZHQCRG4zNnHZEoOLgv
         8ZgQ==
X-Gm-Message-State: APjAAAVgzi/Q34KPvR80kStLf2ubrjcm4Y2fTYMPjb+Jf2ZUKII9lkb/
        11JNwwLilHBy76ZHvhvHx/kVuc5GmuHeZq+2Hg3i2A==
X-Google-Smtp-Source: APXvYqx9pEsPdLDRVAfOZknCIo9BraQeodyvjhJEUqZ6zl8QqzmDfeG8+S2TeUCCpTnJFTA694wREsA0FbQTQGLRcEM=
X-Received: by 2002:a1c:b088:: with SMTP id z130mr26203392wme.5.1555415928328;
 Tue, 16 Apr 2019 04:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com> <20190412223409.GB126710@google.com>
In-Reply-To: <20190412223409.GB126710@google.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 16 Apr 2019 17:28:36 +0530
Message-ID: <CABe79T7h9t_Obmo3+B0MHgLZ4ff9GxpBBBLGtSf0C=zmLrWVBQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for review. Please find my reply below.

On Sat, Apr 13, 2019 at 4:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > Few SOCs have limitation that their PCIe host can't allow few inbound
> > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > DT property and this address ranges are required to do IOVA mapping.
> > Remaining address ranges have to be reserved in IOVA mapping.
>
> If I understand correctly, devices below these PCIe host bridges can
> DMA only to the listed address ranges, and you prevent devices from
> doing DMA to the holes between the listed ranges by reserving the
> holes in dma-iommu.
Yes, devices below these PCIe host bridges can DMA only to the listed
address ranges,
and this patch prevents to allocate DMA(IOVA) addresses in the holes
of listed ranges.
>
> Apparently there's something that makes sure driver dma_map_*() always
> goes through dma-iommu?  I traced as far as seeing that dma-iommu
> depends on CONFIG_IOMMU_DMA, and that arm64 selects CONFIG_IOMMU_DMA
> if CONFIG_IOMMU_SUPPORT, but then the trail got cold.  I didn't see
> what selects CONFIG_IOMMU_SUPPORT.
IOMMU_SUPPORT depends on MMU.
>
> This does look like what Robin suggested, as far as I can tell.
> Hopefully he'll take a look and give his reviewed-by.  Thanks for
> persevering!
Thank you.

Regards,
Srinath.
>
> > PCIe Host driver of those SOCs has to list resource entries of allowed
> > address ranges given in dma-ranges DT property in sorted order. This
> > sorted list of resources will be processed and reserve IOVA address for
> > inaccessible address holes while initializing IOMMU domain.
> >
> > This patch set is based on Linux-5.0-rc2.
> >
> > Changes from v3:
> >   - Addressed Robin Murphy review comments.
> >     - pcie-iproc: parse dma-ranges and make sorted resource list.
> >     - dma-iommu: process list and reserve gaps between entries
> >
> > Changes from v2:
> >   - Patch set rebased to Linux-5.0-rc2
> >
> > Changes from v1:
> >   - Addressed Oza review comments.
> >
> > Srinath Mannam (3):
> >   PCI: Add dma_ranges window list
> >   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> >   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> >
> >  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
> >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/probe.c                 |  3 +++
> >  include/linux/pci.h                 |  1 +
> >  4 files changed, 66 insertions(+), 1 deletion(-)
> >
> > --
> > 2.7.4
> >
