Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165CC67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879D6208E7
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="diw2Zgu4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="diw2Zgu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879D6208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeLMKrC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:47:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbeLMKrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 05:47:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6BFD16092B; Thu, 13 Dec 2018 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544698019;
        bh=8RVzQ0neZrDbY7ZmL49OKgK02r63FT7MY4uLkmtsS2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=diw2Zgu4CNfPHObRANiQZoQM4HdbqOX9w3MAMs0VBXLcxFMVaVth5p38R8/2NkVic
         qYcnw8iyaqRmjNCWMpbtmoCkqLSYAanm17+lUhBiKWuUVB5PmhIaX+LYbj9DjvyD/x
         fKZq8+gUqLIYmoDWPnZTB3dTsVi644W787DHoji8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1979B608A5;
        Thu, 13 Dec 2018 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544698019;
        bh=8RVzQ0neZrDbY7ZmL49OKgK02r63FT7MY4uLkmtsS2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=diw2Zgu4CNfPHObRANiQZoQM4HdbqOX9w3MAMs0VBXLcxFMVaVth5p38R8/2NkVic
         qYcnw8iyaqRmjNCWMpbtmoCkqLSYAanm17+lUhBiKWuUVB5PmhIaX+LYbj9DjvyD/x
         fKZq8+gUqLIYmoDWPnZTB3dTsVi644W787DHoji8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Dec 2018 16:16:59 +0530
From:   poza@codeaurora.org
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCIe Host request to reserve IOVA
In-Reply-To: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
References: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
Message-ID: <c85f7eb4740d5d76747d1e9a7212b105@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018-12-13 16:02, Srinath Mannam wrote:
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges.
> Allowed inbound address ranges are listed in dma-ranges DT property and
> this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.
> 
> PCIe Host driver of those SOCs has to list all address ranges which 
> have
> to reserve their IOVA address into PCIe host bridge resource entry 
> list.
> IOMMU framework will reserve these IOVAs while initializing IOMMU 
> domain.
> 
> This patch set is based on Linux-4.19-rc1.
> 
> Changes from v1:
>   - Addressed Oza review comments.
> 
> Srinath Mannam (3):
>   PCI: Add dma-resv window list
>   iommu/dma: IOVA reserve for PCI host reserve address list
>   PCI: iproc: Add dma reserve resources to host
> 
>  drivers/iommu/dma-iommu.c           |  8 ++++++
>  drivers/pci/controller/pcie-iproc.c | 51 
> ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/probe.c                 |  3 +++
>  include/linux/pci.h                 |  1 +
>  4 files changed, 62 insertions(+), 1 deletion(-)

Looks good to me.

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
