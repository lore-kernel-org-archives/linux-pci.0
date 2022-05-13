Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92816C433F5
	for <linux-pci@archiver.kernel.org>; Fri, 13 May 2022 13:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380587AbiEMNIv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 13 May 2022 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380596AbiEMNIv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 09:08:51 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753837003;
        Fri, 13 May 2022 06:08:46 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 37AA84D2; Fri, 13 May 2022 15:08:45 +0200 (CEST)
Date:   Fri, 13 May 2022 15:08:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, bhelgaas@google.com, robh@kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/dma: Explicitly sort PCI DMA windows
Message-ID: <Yn5YXKYg2SeWuBfT@8bytes.org>
References: <35661036a7e4160850895f9b37f35408b6a29f2f.1652091160.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35661036a7e4160850895f9b37f35408b6a29f2f.1652091160.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 11:16:08AM +0100, Robin Murphy wrote:
>  drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>  drivers/pci/of.c          |  8 +-------
>  2 files changed, 13 insertions(+), 8 deletions(-)

Applied, thanks.
