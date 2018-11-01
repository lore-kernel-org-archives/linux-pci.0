Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44051C0044C
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 13:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067B320820
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 13:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067B320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeKAW6l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:58:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbeKAW6l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Nov 2018 18:58:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 707CEA78;
        Thu,  1 Nov 2018 06:55:36 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B1963F5D3;
        Thu,  1 Nov 2018 06:55:35 -0700 (PDT)
Date:   Thu, 1 Nov 2018 13:55:30 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v2] PCI: imx6: Check for link training status in link up
 check
Message-ID: <20181101135530.GA8020@e107981-ln.cambridge.arm.com>
References: <20181031194944.19233-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031194944.19233-1-tpiepho@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 31, 2018 at 07:49:59PM +0000, Trent Piepho wrote:
> This fixes a regression introduced in merge 562df5c8521e.

A merge being a commits collection, the regression was certainly
introduced by a specific commit in it, not the merge itself.

Please remove this line and add a proper Fixes: tag below.

Please use the canonical commit format:

git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h
(\"%s\")%n" SHA-1 ID

Also for the Fixes: tag and all references.

> Prior to this the link up check done by imx6_pcie_wait_for_link()
> consisted of a polling loop on imx6_pcie_link_up() (via the former
> calling dw_pcie_link_up() which called the latter as callback), and
> imx6_pcie_link_up() polled the link status register checking for link
> up *and link not still training*.
> 
> This was a polling loop inside another polling loop.  And the outermost
> loop was duplicated with minor variations in a number of other dwc based
> host drivers.
> 
> This was addressed in two commits.  Commit 4d107d3b5a68 ("PCI: imx6: Move
> link up check into imx6_pcie_wait_for_link()"), changed
> imx6_pcie_wait_for_link() to poll the link status register directly,
> checking for link up and not training, and made imx6_pcie_link_up() only
> check the link up bit (once, not a polling loop).
> 
> While commit commit 886bc5ceb5cc ("PCI: designware: Add generic

One "commit" is enough.

> dw_pcie_wait_for_link()"), replaced the loop in imx6_pcie_wait_for_link()
> with a call to a new dwc core function, which polled imx6_pcie_link_up(),
> which still checked both link up and not training in a loop.
> 
> When these two commits were merged, the version of
> imx6_pcie_wait_for_link() from '886 was kept, which eliminated the link
> training check placed there by '4d1.  But the version of
> imx6_pcie_link_up() from '4d1 was kept, which eliminated the link training
> check that had been there and was moved to imx6_pcie_wait_for_link().
> 
> There result is no link training check.
> 
> Then commit dac29e6c5460 ("PCI: designware: Add default link up check if
> sub-driver doesn't override") added a default check into
> dw_pcie_link_up(), which could have been used by imx6, but wasn't.  Then
> commit 01c076732e82 ("PCI: designware: Check LTSSM training bit before
> deciding link is up") added a link training check to the default from
> 'dac, but this code was still not used by imx6.
> 
> This commit eliminates imx6_pcie_link_up() so that the default
> dw_pcie_link_up() is used.  The default has the correct code and is what
> the imx6 driver used to do.

Write one sentence in imperative form, eg "Eliminate imx6_pcie_link_up()..",
see Bjorn's guidelines below.

> Fixes: 562df5c8521e1371f3cbd0b7b868034da376d714

Report the commit you are fixing, not the merge commit and report it
in canonical format.

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

This commit log is a tad long, I would appreciate if you tried to
summarize it, I can do it for you if you wish so.

Please read:

https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

You should CC at least what

get_maintainer.pl -f drivers/pci/controller/dwc/pci-imx6.c

reports.

Thanks,
Lorenzo

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
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
