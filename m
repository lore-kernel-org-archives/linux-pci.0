Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C360FC07E94
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jun 2021 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB79B6140B
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jun 2021 15:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDPiI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jun 2021 11:38:08 -0400
Received: from 8bytes.org ([81.169.241.247]:42364 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhFDPiH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 11:38:07 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 86D2A3A9; Fri,  4 Jun 2021 17:36:20 +0200 (CEST)
Date:   Fri, 4 Jun 2021 17:36:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Wang Xingang <wangxingang5@huawei.com>
Cc:     robh@kernel.org, will@kernel.org, helgaas@kernel.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, xieyingtai@huawei.com
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
Message-ID: <YLpIcwdWDGKpw39s@8bytes.org>
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
> 
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. And ACS should be enabled when IOMMU is detected for the
> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> devices.
> 
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> ---
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/pci/of.c         | 8 +++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Should probably go through the PCI tree, so

Acked-by: Joerg Roedel <jroedel@suse.de>

