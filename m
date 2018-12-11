Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70CBC5CFFE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 10:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9372081B
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544523323;
	bh=Ka0ivfetdG8R6q71brWHEdJYH8urzTD+rbaHcJqsz18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uwqDP47LQxkiuHDjGS5FWcV6kCKA8T4139+NCQrJeU0nyy3V8KgkK+Dr/wIlDf2Zo
	 9rTVm5XTTkRdJNFAED9rqCwhRltijLSFLq1abxfUG0oV9R60TXi7nYC3864wgjEeWh
	 zbbAVa5iVOcR66RNRw1QdDT41oSwiyMXIUNmmmsE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9372081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeLKKPS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:15:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38249 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKKPR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 05:15:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so13480408otl.5;
        Tue, 11 Dec 2018 02:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2/HjXQk90vqltSEB0PRcazYDDBkbE8C+8BmOZL5LpQ=;
        b=MuCrEFbHh/WrPraCx5Ve4ddveoB/99q5C0IrhCMKOaqlbtrBHESTzOp+5IbPW37mhx
         CiHa9tjhbdoFq9i7fy1pV2UQu6CTpSeq8D/xzkGBHCHYTnfkoSgQomyHh7wjwsux5+JH
         reB6RUxaFd1jEFuEh/581bUyR5B9fZLJaaqEa3/1E3NIXwQaKj6mIacGD6pKXDHkgSSO
         yUmMQJvFo6OWhEaxR5pYZTN+MRhZ55PYbqGZnzAEWMn3COz5Vf85fvMl83Ad54LD12Fs
         y/o9d5AmVGP8JFvDxPO1b3IwwM/b7Z+4lKkKaGG6ADUI3W6Qb6l06kZuHV+E3rKY/9FT
         AzSA==
X-Gm-Message-State: AA+aEWafx5mGU3x7uANGnmvAyo5wCLDrNvFu3dpEcvUxAGluVTtwF0KM
        5YDr6asRcUhgpnMUr5A0ybaVb2lRv9vWk9Yic/A=
X-Google-Smtp-Source: AFSGD/Wi5HCkN2HxAfgFPZSGZWG/PnhZqymO3DXYt4Xc+4Jc+bIM0VJtHKB3NQ2oEcaBwFndNnuglyNVvx4EOvGQyXI=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr10332185ota.244.1544523315557;
 Tue, 11 Dec 2018 02:15:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544199754.git.robin.murphy@arm.com> <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
In-Reply-To: <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 11:15:04 +0100
Message-ID: <CAJZ5v0g=RSXxFWU-Yu0UA2AFV+qNoW7Q6t1S8ecydrTrHJZwXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI / scan: Refactor _CCA enforcement
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 7, 2018 at 5:31 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Rather than checking the DMA attribute at each callsite, just pass it
> through for acpi_dma_configure() to handle directly. That can then deal
> with the relatively exceptional DEV_DMA_NOT_SUPPORTED case by explicitly
> installing dummy DMA ops instead of just skipping setup entirely. This
> will then free up the dev->dma_ops == NULL case for some valuable
> fastpath optimisations.
>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Len Brown <lenb@kernel.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

The changes in this patch are fine by me:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c      | 5 +++++
>  drivers/base/platform.c  | 3 +--
>  drivers/pci/pci-driver.c | 3 +--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bd1c59fb0e17..b75ae34ed188 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1456,6 +1456,11 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>         const struct iommu_ops *iommu;
>         u64 dma_addr = 0, size = 0;
>
> +       if (attr == DEV_DMA_NOT_SUPPORTED) {
> +               set_dma_ops(dev, &dma_dummy_ops);
> +               return 0;
> +       }
> +
>         iort_dma_setup(dev, &dma_addr, &size);
>
>         iommu = iort_iommu_configure(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 41b91af95afb..c6daca875c17 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
>                 ret = of_dma_configure(dev, dev->of_node, true);
>         } else if (has_acpi_companion(dev)) {
>                 attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> -               if (attr != DEV_DMA_NOT_SUPPORTED)
> -                       ret = acpi_dma_configure(dev, attr);
> +               ret = acpi_dma_configure(dev, attr);
>         }
>
>         return ret;
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..f899a28b90f8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
>                 struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>                 enum dev_dma_attr attr = acpi_get_dma_attr(adev);
>
> -               if (attr != DEV_DMA_NOT_SUPPORTED)
> -                       ret = acpi_dma_configure(dev, attr);
> +               ret = acpi_dma_configure(dev, attr);
>         }
>
>         pci_put_host_bridge_device(bridge);
> --
> 2.19.1.dirty
>
