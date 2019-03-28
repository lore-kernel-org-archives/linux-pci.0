Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B80C4360F
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC77B2183E
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 14:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfC1Ond (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:43:33 -0400
Received: from foss.arm.com ([217.140.101.70]:45572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfC1Onc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Mar 2019 10:43:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12A4715AB;
        Thu, 28 Mar 2019 07:43:32 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5F063F575;
        Thu, 28 Mar 2019 07:43:29 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:43:24 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     marek.vasut@gmail.com, linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq()
Message-ID: <20190328144324.GA32470@e107981-ln.cambridge.arm.com>
References: <20190325194319.12850-1-marek.vasut@gmail.com>
 <20190328141822.GA156243@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328141822.GA156243@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 28, 2019 at 09:18:22AM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2019 at 08:43:19PM +0100, marek.vasut@gmail.com wrote:
> > From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> > 
> > Reestablish the PCIe link very early in the resume process in case it
> > went down to prevent PCI accesses from hanging the bus. Such accesses
> > can happen early in the PCI resume process, as early as the
> > SUSPEND_RESUME_NOIRQ step, thus the link must be reestablished in the
> > driver resume_noirq() callback.
> > 
> > Fixes: e015f88c368d ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
> 
> I'm fine with the fix itself, but since e015f88c368d appeared more
> than two years ago in v4.5, the justification for merging this after
> the merge window is a little weak.
> 
> Is there a more recent change that exposed this problem?  The usual
> situation is that we merged something during the v5.1 merge window
> that caused a regression, and we're now fixing that before v5.1 final.

I do not think that's urgent enough to merge it in one of the -rc* but I
won't speak for the authors - it will trickle back anyway through the
stable mechanism, I just queued it as a fix since that's how it
qualifies.

So postponing it to v5.2 is fine by me, just let me know how it is best
to handle it.

Thanks,
Lorenzo

> Bjorn
> 
> > Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> > Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > [lorenzo.pieralisi@arm.com: reformatted commit log]
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Cc: stable@vger.kernel.org
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> > V2: - Use BIT() macro for (1 << n)
> >     - Since polling in rcar_pcie_wait_for_dl() uses udelay(), do not
> >       add extra changes to this function anymore
> >     - Make resume_noirq return early and clean up parenthesis therein
> > V3: - Add missing PMSR register definition, dropped due to patch reshuffling
> > ---
> >  drivers/pci/controller/pcie-rcar.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> > index c8febb009454..6a4e435bd35f 100644
> > --- a/drivers/pci/controller/pcie-rcar.c
> > +++ b/drivers/pci/controller/pcie-rcar.c
> > @@ -46,6 +46,7 @@
> >  
> >  /* Transfer control */
> >  #define PCIETCTLR		0x02000
> > +#define  DL_DOWN		BIT(3)
> >  #define  CFINIT			1
> >  #define PCIETSTR		0x02004
> >  #define  DATA_LINK_ACTIVE	1
> > @@ -94,6 +95,7 @@
> >  #define MACCTLR			0x011058
> >  #define  SPEED_CHANGE		BIT(24)
> >  #define  SCRAMBLE_DISABLE	BIT(27)
> > +#define PMSR			0x01105c
> >  #define MACS2R			0x011078
> >  #define MACCGSPSETR		0x011084
> >  #define  SPCNGRSN		BIT(31)
> > @@ -1130,6 +1132,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >  	pcie = pci_host_bridge_priv(bridge);
> >  
> >  	pcie->dev = dev;
> > +	platform_set_drvdata(pdev, pcie);
> >  
> >  	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
> >  	if (err)
> > @@ -1221,10 +1224,28 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >  	return err;
> >  }
> >  
> > +static int rcar_pcie_resume_noirq(struct device *dev)
> > +{
> > +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
> > +
> > +	if (rcar_pci_read_reg(pcie, PMSR) &&
> > +	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
> > +		return 0;
> > +
> > +	/* Re-establish the PCIe link */
> > +	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> > +	return rcar_pcie_wait_for_dl(pcie);
> > +}
> > +
> > +static const struct dev_pm_ops rcar_pcie_pm_ops = {
> > +	.resume_noirq = rcar_pcie_resume_noirq,
> > +};
> > +
> >  static struct platform_driver rcar_pcie_driver = {
> >  	.driver = {
> >  		.name = "rcar-pcie",
> >  		.of_match_table = rcar_pcie_of_match,
> > +		.pm = &rcar_pcie_pm_ops,
> >  		.suppress_bind_attrs = true,
> >  	},
> >  	.probe = rcar_pcie_probe,
> > -- 
> > 2.20.1
> > 
