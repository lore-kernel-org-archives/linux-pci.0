Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C4AC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9828B2086C
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 08:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hBULB71O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfBUI7x (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:59:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45924 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfBUI7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 03:59:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so28970061wrn.12
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 00:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnSbCQyycLq8oDMSUhgJQnPqOcaOQETywggOOu0R6lI=;
        b=hBULB71OefHi5mYgZdKD1NE3EtIoi6jjLVuJ5bgwUamg8KMCN/oJs++IvkvVIlDPNp
         ABMbt8JMoBMPK00QmqScGwRUU41MaM7o2M/pqgB/4tQaZZrlj2XBA9LMuh4wMmLaGRjW
         nuVR6S83wrg7GjFGcidYXG+OKmyA9jt27mTFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnSbCQyycLq8oDMSUhgJQnPqOcaOQETywggOOu0R6lI=;
        b=Bxk50mDp2Jn/+JS8LMakcl0xtzYQQU+++LwfT8D9RcWJbKzUZgBTbfI3y1jzNhlx95
         3D1f5KEBNLhaznC+oIUDzIIaf69fcJ2LC1N6MW+f3Ihda/SFyPCUfG7T9q3cYf3V3p8U
         5mIlN+l+UD/4PT0FnnnOt1dlcYOlr/OWBDjEWxyYHKePaqYEsehD+kxGqhBXIjbVONDx
         jCxwxgbze8MjBEmQz7m0cXUxfHPXTevKSg/381V4pNAJ6I2GWuJ7VLtDPGcxasuezlvk
         1UGEVvhjlnXG9MjOgLMmoq0aHPe0aiuEDoYIBruB6kFT8wYDBCVyOS41TYuzsrtCkkSu
         nQJA==
X-Gm-Message-State: AHQUAuaZl2wcGoeEZHgaDwWrZD6TBgEDBBrS91NpoO1MAnKU3MpgD4Ae
        xNfQYLf+kIWMAQTmLN8MYvFY3vIzkuzdoWWCzlxLQw==
X-Google-Smtp-Source: AHgI3IY19j2QMO10R327qYh6SDi2/lTaEV0OB3iQj9x+9KaDa+CkBDmGVzE+VdaBZnVhahb2hzzhu0py76Een5yp8lc=
X-Received: by 2002:adf:9ecc:: with SMTP id b12mr27875564wrf.83.1550739590847;
 Thu, 21 Feb 2019 00:59:50 -0800 (PST)
MIME-Version: 1.0
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 21 Feb 2019 14:29:39 +0530
Message-ID: <CABe79T66daJOditCZ-6ENKW2ugbpDUUfjn1CMHCcDtb3=HiiOQ@mail.gmail.com>
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

Please help to review this patch series.
Thank you.

Regards,
Srinath.
On Fri, Jan 25, 2019 at 3:44 PM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges. Allowed inbound address ranges are listed in dma-ranges
> DT property and this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.
>
> PCIe Host driver of those SOCs has to list all address ranges which have
> to reserve their IOVA address into PCIe host bridge resource entry list.
> IOMMU framework will reserve these IOVAs while initializing IOMMU domain.
>
> This patch set is based on Linux-5.0-rc2.
>
> Changes from v2:
>   - Patch set rebased to Linux-5.0-rc2
>
> Changes from v1:
>   - Addressed Oza review comments.
>
> Srinath Mannam (3):
>   PCI: Add dma-resv window list
>   iommu/dma: Reserve IOVA for PCI host reserve address list
>   PCI: iproc: Add dma reserve resources to host
>
>  drivers/iommu/dma-iommu.c           |  8 ++++++
>  drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/probe.c                 |  3 +++
>  include/linux/pci.h                 |  1 +
>  4 files changed, 62 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>
