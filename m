Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F01C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECE720857
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 16:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCSQSJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:18:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54782 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCSQSJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Mar 2019 12:18:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90D01650;
        Tue, 19 Mar 2019 09:18:08 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C4F3F614;
        Tue, 19 Mar 2019 09:18:06 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:18:03 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
Message-ID: <20190319161803.GB12647@e107981-ln.cambridge.arm.com>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190307205013.GA208051@google.com>
 <ae3659b1-5355-e6f3-16ef-7b458383a1f6@gmail.com>
 <20190308171738.GB214730@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308171738.GB214730@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 08, 2019 at 11:17:38AM -0600, Bjorn Helgaas wrote:

[...]

> > >> +static int rcar_pcie_resume_noirq(struct device *dev)
> > >> +{
> > >> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
> > >> +
> > >> +	if (rcar_pci_read_reg(pcie, PMSR) &&
> > >> +	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
> > >> +		return 0;
> > >> +
> > >> +	/* Re-establish the PCIe link */
> > >> +	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> > >> +	return rcar_pcie_wait_for_dl(pcie);
> > >> +}
> > >> +
> > >> +static const struct dev_pm_ops rcar_pcie_pm_ops = {
> > >> +	.resume_noirq = rcar_pcie_resume_noirq,
> > >> +};
> > > 
> > > I think there's the beginning of a convention to use #ifdef
> > > CONFIG_PM_SLEEP around the ops themselves [1].  Otherwise I think
> > > we'll get a warning about unused code when CONFIG_PM_SLEEP is unset.
> > 
> > Only if I used SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() , but I set the
> > resume_noirq directly.
> 
> Fair enough.  I guess in this case if CONFIG_PM_SLEEP is unset, you
> set the pointer, which avoids the "unused function" warning, but we
> just never use that function pointer.
> 
> My intent is to avoid needless differences when possible, so when I
> review things like this I look at how other drivers do things.  It
> looks like all the other controllers use
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() or similar:
> 
>   git grep -A3 "static.*dev_pm_ops" drivers/pci/controller
> 
> In the rcar case you only need the resume_fn, not the suspend_fn, so
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() does a little more than you need and
> you'd have to pass NULL for suspend_fn.  I didn't check them all
> (suspend_noirq, freeze_noirq, poweroff_noirq), but at least for
> suspend_noirq, all users check for NULL before calling through the
> .suspend_noirq() function pointer, so I think that should be safe.

It is a matter of consistency across drivers, yes, but that's something
I can easily solve with a clean-up patch on top of Marek's one.

I would merge this patch as-is and convert all the drivers to a uniform
convention (which one I shall see).

On a side note, this patch looks like a fix to me (even though it is
not trivial for me to add a sensible Fixes: tag) and should be treated
as such, so it should go in one of the upcoming -rc* (and I float the
idea of sending it to stable kernels on which S2R is basically broken).

Lorenzo
