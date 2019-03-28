Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB02C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 10:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDF4206B6
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 10:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f1QJreBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfC1KeS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:34:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51424 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1KeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 06:34:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so3016892wmf.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Mar 2019 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZvJonE4G6rOM+u7Zr0b+pEWFruI2N0IqyQevceWziI=;
        b=f1QJreBt80Jq4qYa4bYGXHfbJwJPBqLHccZ+hL1vgPAjE1WPA11P9PYd9qHhbnLtYa
         ZGLU3D2a3kPJlpYy1yRTmpH/MlBtMSH0vWhUkZHZPhX1LU+a3uVGUWVobnL2mzd9gXHQ
         L39da5XQvfrVVVEOJWfPzCPSAJS3rkaK14fOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZvJonE4G6rOM+u7Zr0b+pEWFruI2N0IqyQevceWziI=;
        b=klm5uWnBqBGre4tW0gcU+Yku+K7ryIOiJdLSxqL+853e8WoXdTghxDIeU00M77wyFf
         rSJPp5sbOMBXbGiJWZv5kd1/ksWcnCpyKWS/SyHIwshNGMIYbgtzwP/A6RTXw014ku7d
         uW5kfOIxLXiWwmd3IKPUHaMTmnuTY0d7c5gTOod4dFrIcoj9em8dm0H0nvDysPg+NNZu
         D1ztj6kjSYrdr4Ret+RXlPSHhM3kzeEOV+2lLgT8IIfuEXcgjmdF2eSyV/WFxPWy37Ji
         kGGOluX/MnTqol/Cfl12gZTgF+ErNefPx/K5/BX/dEjrALQGBEW1jXsCF/NvJSR4QLPL
         yb1w==
X-Gm-Message-State: APjAAAV2H2BSoLLF4VcwWW7wdy81oYe6d5t3ZGF1pf/QBJkwCE0AdScZ
        wKy3FNVosbDwhbBFnRxT0hJWwxJ3qrTv6etoG/8OfA==
X-Google-Smtp-Source: APXvYqzpdc2UuNpd9Fafzm05LLWrlLCIU/A6KipYCdS95jCIY5ElM8bwZNsEfK/n4CSXYvdKXdSO9/hb9ulFUHy5OBk=
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr11146421wmg.21.1553769255691;
 Thu, 28 Mar 2019 03:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com> <c92e07d7-78b2-d4ec-bf1a-29070a9d4145@arm.com>
In-Reply-To: <c92e07d7-78b2-d4ec-bf1a-29070a9d4145@arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 28 Mar 2019 16:04:04 +0530
Message-ID: <CABe79T7BC9AO3EF23=JjYwXCHDKX5mDYSPzHfpD_tLzX6gukHg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCIe Host request to reserve IOVA
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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

Hi Robin,

Thanks for your feedback. Please see my reply in line.

On Wed, Mar 27, 2019 at 8:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 25/01/2019 10:13, Srinath Mannam wrote:
> > Few SOCs have limitation that their PCIe host can't allow few inbound
> > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > DT property and this address ranges are required to do IOVA mapping.
> > Remaining address ranges have to be reserved in IOVA mapping.
> >
> > PCIe Host driver of those SOCs has to list all address ranges which have
> > to reserve their IOVA address into PCIe host bridge resource entry list.
> > IOMMU framework will reserve these IOVAs while initializing IOMMU domain.
>
> FWIW I'm still only interested in solving this problem generically,
> because in principle it's not specific to PCI, for PCI it's certainly
> not specific to iproc, and either way it's not specific to DT. That
> said, I don't care strongly enough to keep pushing back on this
> implementation outright, since it's not something which couldn't be
> cleaned up 'properly' in future.
Iproc PCIe host controller supports inbound address translation
feature to restrict access
to allowed address ranges. so that allowed memory ranges need to
program to controller.
allowed address ranges information is passed to controller driver
through dma-ranges DT property.
This feature is specific to iproc PCIe controller, so that I think
this change has to specific to iproc
PCIe driver and DT.
Here I followed the same way how PCI IO regions are reserved
"iova_reserve_pci_windows". so that this
change also specific to PCI.
>
> One general comment I'd make, though, is that AFAIK PCI has a concept of
> inbound windows much more than it has a concept of gaps-between-windows,
> so if the PCI layer is going to track anything it should probably be the
> actual windows, and leave the DMA layer to invert them into the
> reservations it cares about as it consumes the list. That way you can
> also avoid the undocumented requirement for the firmware to keep the
> ranges property sorted in the first place.
This implementation has three parts.
1. parsing dma-ranges and extract allowed and reserved address ranges.
2. program allowed ranges to iproc PCIe controller.
3. reserve list of reserved address ranges in IOMMU layer.
#1 and #2 are done using "of_pci_dma_range_parser_init" in present
iproc PCIe driver.
so that, I listed reserve windows at the same place.
#3 requires list of reserve windows so that I add new
variable(dma_resv) to carry these
reserve windows list to iommu layer from iproc driver layer.
The reasons to not use DMA layer for parsing dma-ranges are,
1. This feature is not generic for all SOCs.
2. To avoid dam-ranges parsing in multiple places, already done in
iproc pcie driver.
3. Need to do modify standard DMA layer source code "of_dma_configure"
4. required a carrier to pass reserved windows list from DMA layer to
IOMMU layer.
5. I followed existing PCIe IO regions reserve procedure done in IOMMU layer.

Regards,
Srinath.
>
> Robin.
>
> >
> > This patch set is based on Linux-5.0-rc2.
> >
> > Changes from v2:
> >    - Patch set rebased to Linux-5.0-rc2
> >
> > Changes from v1:
> >    - Addressed Oza review comments.
> >
> > Srinath Mannam (3):
> >    PCI: Add dma-resv window list
> >    iommu/dma: Reserve IOVA for PCI host reserve address list
> >    PCI: iproc: Add dma reserve resources to host
> >
> >   drivers/iommu/dma-iommu.c           |  8 ++++++
> >   drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
> >   drivers/pci/probe.c                 |  3 +++
> >   include/linux/pci.h                 |  1 +
> >   4 files changed, 62 insertions(+), 1 deletion(-)
> >
