Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D8AC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158C921567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 17:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158C921567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbeIUXAZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:00:25 -0400
Received: from foss.arm.com ([217.140.101.70]:39578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389545AbeIUXAZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 19:00:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82DAA7A9;
        Fri, 21 Sep 2018 10:10:37 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74A1A3F557;
        Fri, 21 Sep 2018 10:10:36 -0700 (PDT)
Date:   Fri, 21 Sep 2018 18:10:33 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     honghui.zhang@mediatek.com, linux-mediatek@lists.infradead.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
Message-ID: <20180921171033.GB27651@e107981-ln.cambridge.arm.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
 <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
 <CAPDyKFpFpR_NhtNW6rChMFw4KLweut8zC3x2V1ZBbdrV05iuTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpFpR_NhtNW6rChMFw4KLweut8zC3x2V1ZBbdrV05iuTQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 07, 2018 at 02:33:09PM +0200, Ulf Hansson wrote:

[...]

> > +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> 
> I am not sure I understand why you need to suspend the device in the
> "noirq" phase. Isn't it fine to do that in the regular suspend phase?
> 
> > +{
> > +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > +       const struct mtk_pcie_soc *soc = pcie->soc;
> > +       struct mtk_pcie_port *port;
> > +
> > +       if (!soc->pm_support)
> > +               return 0;

I have an additional comment on this. Isn't there a nicer and more
generic way to detect whether the soc supports pm rather than using
this utterly ugly pm_support static variable ?

Can't we sort out at core level (ie by not "registering" dev_pm_ops) ?

How is this situation handled in other drivers ?

Thanks,
Lorenzo

> > +       if (list_empty(&pcie->ports))
> > +               return 0;
> > +
> > +       list_for_each_entry(port, &pcie->ports, list) {
> > +               clk_disable_unprepare(port->pipe_ck);
> > +               clk_disable_unprepare(port->obff_ck);
> > +               clk_disable_unprepare(port->axi_ck);
> > +               clk_disable_unprepare(port->aux_ck);
> > +               clk_disable_unprepare(port->ahb_ck);
> > +               clk_disable_unprepare(port->sys_ck);
> > +               phy_power_off(port->phy);
> > +               phy_exit(port->phy);
> > +       }
> > +
> > +       mtk_pcie_subsys_powerdown(pcie);
> 
> Why not gate clocks, unconditionally not depending on if pm_support is
> set or not, during system suspend?
> 
> I understand that you for some SoCs needs also to restore registers
> during system resume, but that's a different thing, isn't it?
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> > +{
> > +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > +       const struct mtk_pcie_soc *soc = pcie->soc;
> > +       struct mtk_pcie_port *port, *tmp;
> > +
> > +       if (!soc->pm_support)
> > +               return 0;
> > +
> > +       if (list_empty(&pcie->ports))
> > +               return 0;
> > +
> > +       if (dev->pm_domain) {
> > +               pm_runtime_enable(dev);
> > +               pm_runtime_get_sync(dev);
> 
> I noticed, Lorenzo wanted me to comment on this, so here it goes.
> 
> I guess the reason to why you make these pm_runtime_*() calls, is
> because you want to restore the actions taken during
> mtk_pcie_suspend_noirq() (which calls mtk_pcie_subsys_powerdown ->
> pm_runtime_disable|put*())?
> 
> If that's the case, I would rather avoid calling pm_runtime_disable()
> and pm_runtime_put() via mtk_pcie_suspend_noirq(), simply because it
> isn't needed.
> 
> Of course, another option is to follow the pattern in
> drivers/mmc/host/sdhci-xenon.c.
> 
> Overall, I am also wondering why only runtime PM is used when there is
> a PM domain attached to the device? That seems to make the logic in
> the driver, unnecessary complicated. Why not use runtime
> unconditionally and thus enable it during ->probe()?
> 
> > +       }
> > +
> > +       clk_prepare_enable(pcie->free_ck);
> > +
> > +       list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> > +               mtk_pcie_enable_port(port);
> > +
> > +       /* In case of EP was removed while system suspend. */
> > +       if (list_empty(&pcie->ports))
> > +               mtk_pcie_subsys_powerdown(pcie);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops mtk_pcie_pm_ops = {
> > +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
> > +                                     mtk_pcie_resume_noirq)
> > +};
> > +
> >  static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
> >         .ops = &mtk_pcie_ops,
> >         .startup = mtk_pcie_startup_port,
> >  };
> >
> >  static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> > +       .pm_support = true,
> >         .ops = &mtk_pcie_ops_v2,
> >         .startup = mtk_pcie_startup_port_v2,
> >         .setup_irq = mtk_pcie_setup_irq,
> > @@ -1210,6 +1275,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> >
> >  static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> >         .need_fix_class_id = true,
> > +       .pm_support = true,
> >         .ops = &mtk_pcie_ops_v2,
> >         .startup = mtk_pcie_startup_port_v2,
> >         .setup_irq = mtk_pcie_setup_irq,
> > @@ -1229,6 +1295,7 @@ static struct platform_driver mtk_pcie_driver = {
> >                 .name = "mtk-pcie",
> >                 .of_match_table = mtk_pcie_ids,
> >                 .suppress_bind_attrs = true,
> > +               .pm = &mtk_pcie_pm_ops,
> >         },
> >  };
> >  builtin_platform_driver(mtk_pcie_driver);
> > --
> > 2.6.4
> >
> 
> Kind regards
> Uffe
