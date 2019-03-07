Return-Path: <SRS0=a/OH=RK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C7C10F03
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBCA2085A
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551991817;
	bh=1hi/Vwp2apJ/sVLtqASMN8pGP0T0d+D9yegIbgG9W1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uh1tQpzCVKtNQsu2SzGSpHjejH9HVb0cTlIDuKnvxOPcjvhLyViUTyitr6HfXylUB
	 5H74gaYkALgeWnKIuKVMGlCxlxw86k57X6MLmfMjCPxcmkKrPD2NsXtWHxxftvG+SU
	 g8XwtJECeROrAoT80ihoXqBnuN4J/RIIjG+0vsOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCGUuQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfCGUuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Mar 2019 15:50:16 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B5020684;
        Thu,  7 Mar 2019 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551991814;
        bh=1hi/Vwp2apJ/sVLtqASMN8pGP0T0d+D9yegIbgG9W1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAUfvBH2tnWtnqDf258Ygs/ejbmYA1OCX04UADWu63j7PLGF0DcPALnmzc7/Karjs
         cGKaS6SUOx0kvdXvwoCHqn5lt+csTTUStn1z9YLnEV2m+UbsJ8PgcoCph3d7dLOXNk
         //2k/WutmlWMpxJpPhpaEuJFSyiycc5aZv7yiP6k=
Date:   Thu, 7 Mar 2019 14:50:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
Message-ID: <20190307205013.GA208051@google.com>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217132441.15139-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> 
> Reestablish the PCIe link very early in the resume process in case it
> went down to prevent PCI accesses from hanging the bus. Such accesses
> can happen early in the PCI resume process, in the resume_noirq, thus
> the link must be reestablished in the resume_noirq callback of the
> driver.
> 
> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Use BIT() macro for (1 << n)
>     - Since polling in rcar_pcie_wait_for_dl() uses udelay(), do not
>       add extra changes to this function anymore
>     - Make resume_noirq return early and clean up parenthesis therein
> ---
>  drivers/pci/controller/pcie-rcar.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index c8febb009454..b8f8fb3bc640 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -46,6 +46,7 @@
>  
>  /* Transfer control */
>  #define PCIETCTLR		0x02000
> +#define  DL_DOWN		BIT(3)
>  #define  CFINIT			1

I saw discussion after the V1 patch about using BIT() and making
similar constants also use BIT() for consistency.  That makes sense to
me, and I think the best way would be:

  1) in *this* patch, use "#define DL_DOWN 8"
  2) in a followup patch, convert them all to BIT()

That way each revision of pcie-rcar.c is self-consistent.

>  #define PCIETSTR		0x02004
>  #define  DATA_LINK_ACTIVE	1
> @@ -1130,6 +1131,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	pcie = pci_host_bridge_priv(bridge);
>  
>  	pcie->dev = dev;
> +	platform_set_drvdata(pdev, pcie);
>  
>  	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
>  	if (err)
> @@ -1221,10 +1223,28 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static int rcar_pcie_resume_noirq(struct device *dev)
> +{
> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
> +
> +	if (rcar_pci_read_reg(pcie, PMSR) &&
> +	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
> +		return 0;
> +
> +	/* Re-establish the PCIe link */
> +	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> +	return rcar_pcie_wait_for_dl(pcie);
> +}
> +
> +static const struct dev_pm_ops rcar_pcie_pm_ops = {
> +	.resume_noirq = rcar_pcie_resume_noirq,
> +};

I think there's the beginning of a convention to use #ifdef
CONFIG_PM_SLEEP around the ops themselves [1].  Otherwise I think
we'll get a warning about unused code when CONFIG_PM_SLEEP is unset.

>  static struct platform_driver rcar_pcie_driver = {
>  	.driver = {
>  		.name = "rcar-pcie",
>  		.of_match_table = rcar_pcie_of_match,
> +		.pm = &rcar_pcie_pm_ops,
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe = rcar_pcie_probe,
> -- 
> 2.19.2
> 

[1] https://lore.kernel.org/linux-pci/20180531042020.GQ39853@bhelgaas-glaptop.roam.corp.google.com
