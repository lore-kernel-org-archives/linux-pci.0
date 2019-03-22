Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9AAC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 13:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845D82183E
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 13:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfCVLbm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbfCVLbj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803F1374;
        Fri, 22 Mar 2019 04:31:38 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B30703F575;
        Fri, 22 Mar 2019 04:31:36 -0700 (PDT)
Date:   Fri, 22 Mar 2019 11:31:33 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Message-ID: <20190322113133.GB24257@e107981-ln.cambridge.arm.com>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217132441.15139-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> 
> Reestablish the PCIe link very early in the resume process in case it
> went down to prevent PCI accesses from hanging the bus. Such accesses

Hi Marek, Kazufumi,

Apologies for the delay.

Just as a clarification, when you state "in case it went down" isn't
this supposed to happen for every suspend cycle ? Let me know and I
will add a comment to the patch commit log.

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

This looks like a fix (most likely fixing initial S2R support, please
help me chase the commit ID), should we consider it for stable kernels ?

Without it I understand S2R is actually broken on platforms with this
host bridge.

Thanks,
Lorenzo

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
> +
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
