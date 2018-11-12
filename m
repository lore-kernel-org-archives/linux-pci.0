Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0CEC43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 19:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2312250E
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 19:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvJ2NpuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2312250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeKME66 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:58:58 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52389 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKME66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 23:58:58 -0500
Received: by mail-it1-f193.google.com with SMTP id t190-v6so14244510itb.2;
        Mon, 12 Nov 2018 11:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6Yp/2HFX5sz8LE9JBLhwnDfKKU5uQzMgiUZJCelnbE=;
        b=HvJ2NpuT+gwADQ4vgpbKXvBcC/HPAjY0uHCMefsziGMMu/CT6eGM+bpjSJNRRiuWT6
         3m7SwG2nXvLBsOm324rgvMgimPt5mKyK5o/6j+IPE3SemwVUxnhZJgpsPaZpAvZ1CGJe
         DL9V7tA0C03b4DqLjzKgd2AR9Y38wnHCMeDRoLcCfxfvH4JCyWvNO9L2pnZ7J6h3K02z
         p3jLODWO+z2k1tnV4fDImicLPDipcEoloyHWEvq28q9Ja/CS4ySCCMuooEAnFPxJ2zQi
         C/NNZ6p0WK4pTUjICeVcyol7Q7WU8jo6ysfdo8mlGvesnqDimcdtbP0HGyl1Ai53lup1
         Riog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6Yp/2HFX5sz8LE9JBLhwnDfKKU5uQzMgiUZJCelnbE=;
        b=axnwy/5xGqteV9r1wMsvsvsbhEceHzIQ4j05+Qx8UxXl3n5aRb9jspjx7idA82Vxy4
         llmFkCDwPeLT6eJdRlHpiPRF8sZ27pTPdLSHUdhPfNerKgEDuSHp4v4o7HN8jFJ6y3X6
         i6nv8rmtQn6JNDuOKDchN+E6VuJsnGpFdQvDo81ewg33j2tZfS7kFuNhAv0+Ynr48IBc
         ZoXF/q6HR9z0Zd7EyDIrdyBQyWuSgGl9KZQto0sS3HTOVabdY4ccUo/WUeJGpwTftZx5
         BlTssj8jxSgI/1ueLC3HuKsJhKl6/jL7kuXw/kVA6borrPrRE5YEb8vXM4yXWUht4Reu
         2MRg==
X-Gm-Message-State: AGRZ1gK3JlYYXBuvCxYuXW8YieIoGfH3CzpK2Wj40AGfc9Cq/tGqX9U3
        NiXTtOYR5wL8AY1ri8kQllXeOfouZ1aa4thwpQ0=
X-Google-Smtp-Source: AJdET5e132MmL9czeIkY9npQAQQw4+MFe3Sy6bTCfDgIr0/WE+Fd9FhhMVt4NR5AV4OU8FO279kS29CvkReW1NVyWEM=
X-Received: by 2002:a24:a0cb:: with SMTP id o194mr779422ite.115.1542049465858;
 Mon, 12 Nov 2018 11:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com> <20181112181214.xaahc5wni4vuwl6h@wunner.de>
In-Reply-To: <20181112181214.xaahc5wni4vuwl6h@wunner.de>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Mon, 12 Nov 2018 21:04:08 +0200
Message-ID: <CA+CmpXt4cZJRoo8U=pMt7Y65oLpXwpr2oVgbxuFj8C-SU6yZnA@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
To:     lukas@wunner.de
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com,
        bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 8:12 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Nov 12, 2018 at 07:06:24PM +0300, Mika Westerberg wrote:
> > Recent systems shipping with Windows 10 version 1803 or newer may be
> > utilizing IOMMU to prevent DMA attacks via Thunderbolt ports. This is
> > different from the previous security level based scheme because the
> > connected device cannot access system memory outside of the regions
> > allocated for it by the driver.
> >
> > When enabled the BIOS makes sure no device can do DMA outside of RMRR
> > (Reserved Memory Region Record) regions. This means that during OS boot,
> > before it enables IOMMU, none of the connected devices can bypass DMA
> > protection for instance by overwriting the data structures used by the
> > IOMMU. The BIOS communicates support for this to the OS by setting a new
> > bit in ACPI DMAR table [1].
> >
> > Because these systems utilize an IOMMU to block possible DMA attacks,
> > typically (but not always) the Thunderbolt security level is set to "none"
> > which means that all PCIe devices are immediately usable. This also means
> > that Linux needs to follow Windows 10 and enable IOMMU automatically when
> > running on such system otherwise connected devices can read/write system
> > memory pretty much without any restrictions.
>
> What if the system is booted from a Thunderbolt-attached disk?
> Won't this suddenly break with these patches? That would seem like a
> pretty significant regression.

My assumption is that either it isn't supported on such platforms (at least with
this security configuration active) so this doesn't break anything, it never
worked there, or the BIOS configures IOMMU in a way that allows the disk to work
until the OS will take control and configure the IOMMU according to OS
decisions.
In the latter case, the kernel+initrd will be loaded before IOMMU configuration
will be changed, and then the kernel should be able to config it correctly to
work. (Unless I really don't understand the mechanism and workflow of using
IOMMU, which is possible.)
