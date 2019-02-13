Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BFDC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA06222D0
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 16:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404437AbfBMQkX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:40:23 -0500
Received: from foss.arm.com ([217.140.101.70]:57008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404431AbfBMQkX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 11:40:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFA61A78;
        Wed, 13 Feb 2019 08:40:22 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0A823F675;
        Wed, 13 Feb 2019 08:40:21 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:40:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Fix Multi MSI data programming
Message-ID: <20190213164019.GD2280@e107981-ln.cambridge.arm.com>
References: <1550067939-9859-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550067939-9859-1-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 07:55:39PM +0530, Bharat Kumar Gogada wrote:
> The current Multi MSI data programming fails if a
> end point is connected with switch.
> 
> Fix Multi MSI data, by programming data with required alignment.

I have no idea what this means. If you are fixing a bug describe
it properly and provide a Fixes: tag with the commit you are fixing.

Thanks,
Lorenzo

> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 81538d7..36669c5 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -484,7 +484,7 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	mutex_lock(&msi->lock);
>  	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> -					 nr_irqs, 0);
> +					 nr_irqs, nr_irqs - 1);
>  	if (bit >= INT_PCI_MSI_NR) {
>  		mutex_unlock(&msi->lock);
>  		return -ENOSPC;
> -- 
> 2.7.4
> 
