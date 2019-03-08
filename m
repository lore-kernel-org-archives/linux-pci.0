Return-Path: <SRS0=hZ+Q=RL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F116C10F09
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4112146F
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552065463;
	bh=EkbtiaVXDAkOQiYCFJJan4bXH3o/UkhaM6qN3hvBhF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bdk+vlCgpfLLQGIteNyUsttxPokWWXbazZimCxfTYYq24L/TxKoZa1vP0PFrxbmS9
	 l7IQdf/xtMSJTG307C2mgPhtURz2y0jllt787MRRftV/twmFEW7CyPp+Hp13srECKs
	 yZ1qPl+T9kk1U2UqXVHBJ33WoEa7p/bjR+7b5XV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCHRRm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfCHRRm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Mar 2019 12:17:42 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E5920851;
        Fri,  8 Mar 2019 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552065461;
        bh=EkbtiaVXDAkOQiYCFJJan4bXH3o/UkhaM6qN3hvBhF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSHgFud+gTKua3DBZ9uugUdga8vn/LDoZ6QuvV99hsYFKRqo78CISD5qVmeUvLXwA
         XEuAIgs5r3UBVK9Q0q1ikfiuSGWxlbnZKcz2IgBD8C60iTzr6GEFqMTHBhiyPj+UOK
         KNKfm9LESF4NIBwnkyfmM/tSGYjCkPSvMr0rdHiA=
Date:   Fri, 8 Mar 2019 11:17:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
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
Message-ID: <20190308171738.GB214730@google.com>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190307205013.GA208051@google.com>
 <ae3659b1-5355-e6f3-16ef-7b458383a1f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3659b1-5355-e6f3-16ef-7b458383a1f6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pm, Rafael for SET_NOIRQ_SYSTEM_SLEEP_PM_OPS question at the end]

On Thu, Mar 07, 2019 at 11:49:34PM +0100, Marek Vasut wrote:
> On 3/7/19 9:50 PM, Bjorn Helgaas wrote:
> > On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
> >> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> >>
> >> Reestablish the PCIe link very early in the resume process in case it
> >> went down to prevent PCI accesses from hanging the bus. Such accesses
> >> can happen early in the PCI resume process, in the resume_noirq, thus
> >> the link must be reestablished in the resume_noirq callback of the
> >> driver.
> >>
> >> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> >> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> ---
> >> V2: - Use BIT() macro for (1 << n)
> >>     - Since polling in rcar_pcie_wait_for_dl() uses udelay(), do not
> >>       add extra changes to this function anymore
> >>     - Make resume_noirq return early and clean up parenthesis therein
> >> ---
> >>  drivers/pci/controller/pcie-rcar.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> >> index c8febb009454..b8f8fb3bc640 100644
> >> --- a/drivers/pci/controller/pcie-rcar.c
> >> +++ b/drivers/pci/controller/pcie-rcar.c
> >> @@ -46,6 +46,7 @@
> >>  
> >>  /* Transfer control */
> >>  #define PCIETCTLR		0x02000
> >> +#define  DL_DOWN		BIT(3)
> >>  #define  CFINIT			1
> > 
> > I saw discussion after the V1 patch about using BIT() and making
> > similar constants also use BIT() for consistency.  That makes sense to
> > me, and I think the best way would be:
> > 
> >   1) in *this* patch, use "#define DL_DOWN 8"
> >   2) in a followup patch, convert them all to BIT()
> > 
> > That way each revision of pcie-rcar.c is self-consistent.
> 
> But the BIT() macros are already cleaned , see commit
> 0ee40820989b330e24926d82953ffb9e1c7a8425
> 
>     PCI: rcar: Clean up the macros

Hmmm.  Maybe I'm missing something, but it looks like 0ee40820989b
didn't touch CFINIT, DATA_LINK_ACTIVE, or MSIFE.  Arguably,
LINK_SPEED_2_5GTS and LINK_SPEED_5_0GTS could use BIT() also.

I guess I'm just old-school, but in my personal opinion, BIT() is more
trouble than it's worth.  I'd rather see a complete bitmask because I
can easily match it with the typical pictures in a spec, multi-bit
fields are easy (you don't have to mix BIT() and GENMASK()), it gives
a hint about the register width, it's easy to match with a hexdump,
etc, e.g.,

  #define  DL_DOWN        0x00000008
  #define  CFINIT         0x00000001

But I'm not suggesting that you get rid of BIT() in this driver.  I'm
fine with it as long as it's used consistently.

BTW, while we're looking at it, I think rcar_pci_read_reg() and
rcar_pci_write_reg() really should use "u32" instead of "unsigned
long", since they deal with hardware registers that are explicitly
32 bits wide.

> >>  #define PCIETSTR		0x02004
> >>  #define  DATA_LINK_ACTIVE	1
> >> @@ -1130,6 +1131,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >>  	pcie = pci_host_bridge_priv(bridge);
> >>  
> >>  	pcie->dev = dev;
> >> +	platform_set_drvdata(pdev, pcie);
> >>  
> >>  	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
> >>  	if (err)
> >> @@ -1221,10 +1223,28 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >>  	return err;
> >>  }
> >>  
> >> +static int rcar_pcie_resume_noirq(struct device *dev)
> >> +{
> >> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
> >> +
> >> +	if (rcar_pci_read_reg(pcie, PMSR) &&
> >> +	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
> >> +		return 0;
> >> +
> >> +	/* Re-establish the PCIe link */
> >> +	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> >> +	return rcar_pcie_wait_for_dl(pcie);
> >> +}
> >> +
> >> +static const struct dev_pm_ops rcar_pcie_pm_ops = {
> >> +	.resume_noirq = rcar_pcie_resume_noirq,
> >> +};
> > 
> > I think there's the beginning of a convention to use #ifdef
> > CONFIG_PM_SLEEP around the ops themselves [1].  Otherwise I think
> > we'll get a warning about unused code when CONFIG_PM_SLEEP is unset.
> 
> Only if I used SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() , but I set the
> resume_noirq directly.

Fair enough.  I guess in this case if CONFIG_PM_SLEEP is unset, you
set the pointer, which avoids the "unused function" warning, but we
just never use that function pointer.

My intent is to avoid needless differences when possible, so when I
review things like this I look at how other drivers do things.  It
looks like all the other controllers use
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() or similar:

  git grep -A3 "static.*dev_pm_ops" drivers/pci/controller

In the rcar case you only need the resume_fn, not the suspend_fn, so
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() does a little more than you need and
you'd have to pass NULL for suspend_fn.  I didn't check them all
(suspend_noirq, freeze_noirq, poweroff_noirq), but at least for
suspend_noirq, all users check for NULL before calling through the
.suspend_noirq() function pointer, so I think that should be safe.

This *does* raise the question of whether you should be setting
.thaw_noirq and .restore_noirq in addition to .resume_noirq, as
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() would.  I'm not a PM person, but maybe
Rafael or others will chime in.

Bjorn
