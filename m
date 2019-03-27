Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21526C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3B82075E
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e/3thYEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfC0Ioe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:44:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42259 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfC0Iod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 04:44:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so13978836wrx.9
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2019 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SR8OMb+UAUrcn8HwqSynLhn9aEhG5yowsV6vWX9jKok=;
        b=e/3thYEzcTFJAzj17ujOlqBfDVI03m65VG/zWHofex3e2sExQK71fgw0V2gPy8o9Dy
         5RT3HOgDgVmtyNn/a2PzUeFqPDKf/w/WQTls68CczcBLouuYOWZF38zEMirWr2dKUGFb
         KP6+QjGZ42eXxeh0uRlvc8XL59OW+PA4GTRyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SR8OMb+UAUrcn8HwqSynLhn9aEhG5yowsV6vWX9jKok=;
        b=Mbz6N47en8MpGjanpXzXp4pRtv98cb7qa3qfIRxgIyRIUjIlQAEdtSDBGt8VM2/U70
         XMnICo68B91Ut+yuYZ2XMDyI6/zPzIElDrQNqixz89TBWzZJBdC7/Euyz0V/7wX4PZsq
         xue2cIN9yymQmjE6VstNKtc6ydE+dZtRAatbCOBPSIzTNp42hCF23XmZ+lY7/15FVvjm
         qf3qd2F+6KFLyyMB5tXvdhNGrVrfW8u3c/TqIqWr2EEz9L4jPzPQ+BB0QtkEuALtgoS/
         qajfnN1aDbFlGv+Xg5VEEfNsxV3qiXwccRRZHjWcadaYHaAsxBAwUeAyLXapng27eDac
         JCmQ==
X-Gm-Message-State: APjAAAX0OeB0qrH+LPwVrBX7BeAXiRDCJcKUdqulGKdmQEzAV1dmnTUw
        Ne0L4OLuz6oArtBeu6Ags4/ZTNYMBSyrQlRlOLL+BA==
X-Google-Smtp-Source: APXvYqwr58NmGoeNyR1OZ04imvsDScuLPnFkvGBJ2LFR9xZnBQKVDK0mDww6tN1BpWGhrj+LZw982OG+ArBv6HMjiHw=
X-Received: by 2002:a5d:494c:: with SMTP id r12mr11555769wrs.250.1553676272048;
 Wed, 27 Mar 2019 01:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com> <CABe79T66daJOditCZ-6ENKW2ugbpDUUfjn1CMHCcDtb3=HiiOQ@mail.gmail.com>
In-Reply-To: <CABe79T66daJOditCZ-6ENKW2ugbpDUUfjn1CMHCcDtb3=HiiOQ@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 27 Mar 2019 14:14:20 +0530
Message-ID: <CABe79T6QVF-Dgajj6S_0Z9ZnfsV3vuWUasU-eLtTBPkEaBzjAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCIe Host request to reserve IOVA
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Could you please help to review the patch series below?

Thanks,
Srinath.

On Thu, Feb 21, 2019 at 2:29 PM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> Hi Bjorn,
>
> Please help to review this patch series.
> Thank you.
>
> Regards,
> Srinath.
> On Fri, Jan 25, 2019 at 3:44 PM Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
> >
> > Few SOCs have limitation that their PCIe host can't allow few inbound
> > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > DT property and this address ranges are required to do IOVA mapping.
> > Remaining address ranges have to be reserved in IOVA mapping.
> >
> > PCIe Host driver of those SOCs has to list all address ranges which have
> > to reserve their IOVA address into PCIe host bridge resource entry list.
> > IOMMU framework will reserve these IOVAs while initializing IOMMU domain.
> >
> > This patch set is based on Linux-5.0-rc2.
> >
> > Changes from v2:
> >   - Patch set rebased to Linux-5.0-rc2
> >
> > Changes from v1:
> >   - Addressed Oza review comments.
> >
> > Srinath Mannam (3):
> >   PCI: Add dma-resv window list
> >   iommu/dma: Reserve IOVA for PCI host reserve address list
> >   PCI: iproc: Add dma reserve resources to host
> >
> >  drivers/iommu/dma-iommu.c           |  8 ++++++
> >  drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/probe.c                 |  3 +++
> >  include/linux/pci.h                 |  1 +
> >  4 files changed, 62 insertions(+), 1 deletion(-)
> >
> > --
> > 2.7.4
> >
