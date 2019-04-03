Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8ECC4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AD1205C9
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 17:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfDCRTI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:19:08 -0400
Received: from foss.arm.com ([217.140.101.70]:45458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfDCRTI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Apr 2019 13:19:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCDC680D;
        Wed,  3 Apr 2019 10:19:07 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE503F68F;
        Wed,  3 Apr 2019 10:19:06 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:19:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] PCI: dwc: Do not write to MSI control registers
 if the platform doesn't use it
Message-ID: <20190403171902.GB3783@red-moon>
References: <20190321095927.7058-1-kishon@ti.com>
 <20190321095927.7058-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321095927.7058-9-kishon@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 21, 2019 at 03:29:27PM +0530, Kishon Vijay Abraham I wrote:
> Platforms which populate msi_host_init, has it's own MSI controller
> logic. Writing to MSI control registers on platforms which doesn't use
> Designware's MSI controller logic might have side effects. To
> be safe, do not write to MSI control registers if the platform uses
> it's own MSI controller logic instead of Designware's MSI controller
> logic.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 24 ++++++++++---------
>  1 file changed, 13 insertions(+), 11 deletions(-)

This patch is needed regardless of the rest of the series, correct ?
A.k.a. it is fixing an issue already in the mainline.

Just to make sure we are not _introducing_ a bisection issue with this
series up to this patch, in which case I will squash this patch into one
of the previous ones, please let me know.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 498422397609..7e0ff7d428a9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -626,17 +626,19 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  
>  	dw_pcie_setup(pci);
>  
> -	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> -
> -	/* Initialize IRQ Status array */
> -	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> -		pp->irq_mask[ctrl] = ~0;
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
> -					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, pp->irq_mask[ctrl]);
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
> -					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, ~0);
> +	if (!pp->ops->msi_host_init) {
> +		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +		/* Initialize IRQ Status array */
> +		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +			pp->irq_mask[ctrl] = ~0;
> +			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
> +					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> +					    4, pp->irq_mask[ctrl]);
> +			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
> +					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> +					    4, ~0);
> +		}
>  	}
>  
>  	/* Setup RC BARs */
> -- 
> 2.17.1
> 
