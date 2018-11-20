Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E7C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AA92087E
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AA92087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKTVdo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:33:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47052 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbeKTVdo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:33:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B975D15AB;
        Tue, 20 Nov 2018 03:05:09 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 861673F575;
        Tue, 20 Nov 2018 03:05:08 -0800 (PST)
Date:   Tue, 20 Nov 2018 11:05:05 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3] PCI: imx6: Check for link training status in link up
 check
Message-ID: <20181120110505.GB19867@e107981-ln.cambridge.arm.com>
References: <20181105181117.23230-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181117.23230-1-tpiepho@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 06:11:36PM +0000, Trent Piepho wrote:
> Eliminate imx6_pcie_link_up() so that the default handler,
> dw_pcie_link_up(), is used instead.  The default handler has the correct
> code, which checks for link up and also not still training.
> 
> This bug was fixed some time ago, but the fix was lost in the merge
> commit 562df5c8521e ("Merge branch 'pci/host-designware' into next").
> 
> This was due to the interaction for two commits on either branch of the
> merge.  Commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
> imx6_pcie_wait_for_link()"), changed imx6_pcie_wait_for_link() to poll
> the link status register directly, checking for link up and not
> training, and made imx6_pcie_link_up() only check the link up bit (once,
> not a polling loop).
> 
> While commit commit 886bc5ceb5cc ("PCI: designware: Add generic
> dw_pcie_wait_for_link()"), replaced the loop in
> imx6_pcie_wait_for_link() with a call to a new dwc core function, which
> polled imx6_pcie_link_up(), which still checked both link up and not
> training in a loop.
> 
> When these two commits were merged, the version of
> imx6_pcie_wait_for_link() from '886 was kept, which eliminated the link
> training check placed there by '4d1.  But the version of
> imx6_pcie_link_up() from '4d1 was kept, which eliminated the link
> training check that had been there and was moved to
> imx6_pcie_wait_for_link().
> 
> And the result was the link training check got lost for the imx6 driver.
> 
> Fixes: 562df5c8521e ("Merge branch 'pci/host-designware' into next")
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

I have applied it to pci/controller-fixes for one of the upcoming -rc*.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4a9a673b4777..975050a69494 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -80,8 +80,6 @@ struct imx6_pcie {
>  #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
>  #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
>  #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
> -#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
> -#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
>  
>  #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
>  #define PCIE_PHY_CTRL_DATA_LOC 0
> @@ -641,12 +639,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static int imx6_pcie_link_up(struct dw_pcie *pci)
> -{
> -	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
> -			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
> -}
> -
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
>  	.host_init = imx6_pcie_host_init,
>  };
> @@ -679,7 +671,7 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
>  }
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -	.link_up = imx6_pcie_link_up,
> +	/* No special ops needed, but pcie-designware still expects this struct */
>  };
>  
>  static int imx6_pcie_probe(struct platform_device *pdev)
> -- 
> 2.14.4
> 
