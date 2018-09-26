Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968D9C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 09:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5058C208E4
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 09:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5058C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeIZP0Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:26:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55022 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726404AbeIZP0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 11:26:16 -0400
X-UUID: df93d8d3a50d4c868d2368b4e29edf10-20180926
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1658049086; Wed, 26 Sep 2018 17:14:06 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 17:14:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Sep 2018 17:14:04 +0800
Message-ID: <1537953244.14753.12.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mediatek@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Date:   Wed, 26 Sep 2018 17:14:04 +0800
In-Reply-To: <20180921171033.GB27651@e107981-ln.cambridge.arm.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
         <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
         <CAPDyKFpFpR_NhtNW6rChMFw4KLweut8zC3x2V1ZBbdrV05iuTQ@mail.gmail.com>
         <20180921171033.GB27651@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 13E84A48FC5F68F2FAECB5E6C370588173698A855C32A4186885255FAB0ABAD42000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2018-09-21 at 18:10 +0100, Lorenzo Pieralisi wrote:
> On Fri, Sep 07, 2018 at 02:33:09PM +0200, Ulf Hansson wrote:
> 
> [...]
> 
> > > +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> > 
> > I am not sure I understand why you need to suspend the device in the
> > "noirq" phase. Isn't it fine to do that in the regular suspend phase?
> > 
> > > +{
> > > +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > > +       const struct mtk_pcie_soc *soc = pcie->soc;
> > > +       struct mtk_pcie_port *port;
> > > +
> > > +       if (!soc->pm_support)
> > > +               return 0;
> 
> I have an additional comment on this. Isn't there a nicer and more
> generic way to detect whether the soc supports pm rather than using
> this utterly ugly pm_support static variable ?
> 
> Can't we sort out at core level (ie by not "registering" dev_pm_ops) ?
> 
> How is this situation handled in other drivers ?
> 

Hmm, yes, this pm_support is removable, I guess we add the system
suspend callbacks for MT7622 is fine, if MT7622 is not supported system
suspend, I guess these callbacks will never have a change to be
executed. Adding these callbacks will have no harm for MT7622.

Anyway, I will check other host driver, and try another approach to
distinguish those SoCs for system suspend callbacks.

Thanks very much for your comments.

> Thanks,
> Lorenzo
> 
> > > +       if (list_empty(&pcie->ports))
> > > +               return 0;
> > > +
> > > +       list_for_each_entry(port, &pcie->ports, list) {
> > > +               clk_disable_unprepare(port->pipe_ck);
> > > +               clk_disable_unprepare(port->obff_ck);
> > > +               clk_disable_unprepare(port->axi_ck);
> > > +               clk_disable_unprepare(port->aux_ck);
> > > +               clk_disable_unprepare(port->ahb_ck);
> > > +               clk_disable_unprepare(port->sys_ck);
> > > +               phy_power_off(port->phy);
> > > +               phy_exit(port->phy);
> > > +       }
> > > +
> > > +       mtk_pcie_subsys_powerdown(pcie);
> > 
> > Why not gate clocks, unconditionally not depending on if pm_support is
> > set or not, during system suspend?
> > 
> > I understand that you for some SoCs needs also to restore registers
> > during system resume, but that's a different thing, isn't it?
> > 
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> > > +{
> > > +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > > +       const struct mtk_pcie_soc *soc = pcie->soc;
> > > +       struct mtk_pcie_port *port, *tmp;
> > > +
> > > +       if (!soc->pm_support)
> > > +               return 0;
> > > +
> > > +       if (list_empty(&pcie->ports))
> > > +               return 0;
> > > +
> > > +       if (dev->pm_domain) {
> > > +               pm_runtime_enable(dev);
> > > +               pm_runtime_get_sync(dev);
> > 
> > I noticed, Lorenzo wanted me to comment on this, so here it goes.
> > 
> > I guess the reason to why you make these pm_runtime_*() calls, is
> > because you want to restore the actions taken during
> > mtk_pcie_suspend_noirq() (which calls mtk_pcie_subsys_powerdown ->
> > pm_runtime_disable|put*())?
> > 
> > If that's the case, I would rather avoid calling pm_runtime_disable()
> > and pm_runtime_put() via mtk_pcie_suspend_noirq(), simply because it
> > isn't needed.
> > 
> > Of course, another option is to follow the pattern in
> > drivers/mmc/host/sdhci-xenon.c.
> > 
> > Overall, I am also wondering why only runtime PM is used when there is
> > a PM domain attached to the device? That seems to make the logic in
> > the driver, unnecessary complicated. Why not use runtime
> > unconditionally and thus enable it during ->probe()?
> > 
> > > +       }
> > > +
> > > +       clk_prepare_enable(pcie->free_ck);
> > > +
> > > +       list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> > > +               mtk_pcie_enable_port(port);
> > > +
> > > +       /* In case of EP was removed while system suspend. */
> > > +       if (list_empty(&pcie->ports))
> > > +               mtk_pcie_subsys_powerdown(pcie);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct dev_pm_ops mtk_pcie_pm_ops = {
> > > +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
> > > +                                     mtk_pcie_resume_noirq)
> > > +};
> > > +
> > >  static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
> > >         .ops = &mtk_pcie_ops,
> > >         .startup = mtk_pcie_startup_port,
> > >  };
> > >
> > >  static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> > > +       .pm_support = true,
> > >         .ops = &mtk_pcie_ops_v2,
> > >         .startup = mtk_pcie_startup_port_v2,
> > >         .setup_irq = mtk_pcie_setup_irq,
> > > @@ -1210,6 +1275,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> > >
> > >  static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> > >         .need_fix_class_id = true,
> > > +       .pm_support = true,
> > >         .ops = &mtk_pcie_ops_v2,
> > >         .startup = mtk_pcie_startup_port_v2,
> > >         .setup_irq = mtk_pcie_setup_irq,
> > > @@ -1229,6 +1295,7 @@ static struct platform_driver mtk_pcie_driver = {
> > >                 .name = "mtk-pcie",
> > >                 .of_match_table = mtk_pcie_ids,
> > >                 .suppress_bind_attrs = true,
> > > +               .pm = &mtk_pcie_pm_ops,
> > >         },
> > >  };
> > >  builtin_platform_driver(mtk_pcie_driver);
> > > --
> > > 2.6.4
> > >
> > 
> > Kind regards
> > Uffe


