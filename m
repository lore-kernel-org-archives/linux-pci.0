Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE957C10F05
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A016920651
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfC2QX7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:23:59 -0400
Received: from foss.arm.com ([217.140.101.70]:35328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfC2QX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 12:23:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D28F15BF;
        Fri, 29 Mar 2019 09:23:58 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D5203F68F;
        Fri, 29 Mar 2019 09:23:57 -0700 (PDT)
Date:   Fri, 29 Mar 2019 16:23:54 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH] PCI: rcar: don't shadow the 'irq' variable
Message-ID: <20190329162354.GB7138@e107981-ln.cambridge.arm.com>
References: <20190317093445.7746-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317093445.7746-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 17, 2019 at 10:34:45AM +0100, Wolfram Sang wrote:
> sparse rightfully says:
> drivers/pci/controller/pcie-rcar.c:741:30: warning: symbol 'irq' shadows an earlier one
> 
> It doesn't affect the current code. But fix it now to avoid future
> surprises and for good coding style.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Only build tested.
> 
>  drivers/pci/controller/pcie-rcar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to pci/rcar for v5.2, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 7002e9ad0b81..f513058e3a70 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -738,15 +738,15 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
>  
>  	while (reg) {
>  		unsigned int index = find_first_bit(&reg, 32);
> -		unsigned int irq;
> +		unsigned int msi_irq;
>  
>  		/* clear the interrupt */
>  		rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
>  
> -		irq = irq_find_mapping(msi->domain, index);
> -		if (irq) {
> +		msi_irq = irq_find_mapping(msi->domain, index);
> +		if (msi_irq) {
>  			if (test_bit(index, msi->used))
> -				generic_handle_irq(irq);
> +				generic_handle_irq(msi_irq);
>  			else
>  				dev_info(dev, "unhandled MSI\n");
>  		} else {
> -- 
> 2.19.1
> 
