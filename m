Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:47199 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727261AbeIJOgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2018 10:36:07 -0400
Message-ID: <1536572566.31406.64.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Date: Mon, 10 Sep 2018 17:42:46 +0800
In-Reply-To: <CAPDyKFpFpR_NhtNW6rChMFw4KLweut8zC3x2V1ZBbdrV05iuTQ@mail.gmail.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
         <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
         <CAPDyKFpFpR_NhtNW6rChMFw4KLweut8zC3x2V1ZBbdrV05iuTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-09-07 at 14:33 +0200, Ulf Hansson wrote:
> -trimmed cc-list
> 
> On 2 July 2018 at 09:57,  <honghui.zhang@mediatek.com> wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >
> > The MTCMOS of PCIe Host for MT2712 and MT7622 will be off when system
> > suspend, and all the internal control register will be reset after system
> > resume. The PCIe link should be re-established and the related control
> > register values should be re-set after system resume.
> 
> Sounds very familiar as what is implemented in
> drivers/mmc/host/sdhci-xenon.c. Please have a look, possibly you can
> get inspired to use the similar pattern.
> 
> A few comments below. However, please note, I am not an expert in PCIe
> so I may overlook some obvious things. I am relying on Lorenzo or some
> other PCIe expert, to fill in.
> 
Hi, Ulf, thanks very much for your comments, replied below.

> >
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 67 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 86918d4..175d7b6 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -134,12 +134,14 @@ struct mtk_pcie_port;
> >  /**
> >   * struct mtk_pcie_soc - differentiate between host generations
> >   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> > + * @pm_support: whether the host's MTCMOS will be off when suspend
> >   * @ops: pointer to configuration access functions
> >   * @startup: pointer to controller setting functions
> >   * @setup_irq: pointer to initialize IRQ functions
> >   */
> >  struct mtk_pcie_soc {
> >         bool need_fix_class_id;
> > +       bool pm_support;
> >         struct pci_ops *ops;
> >         int (*startup)(struct mtk_pcie_port *port);
> >         int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> > @@ -1197,12 +1199,75 @@ static int mtk_pcie_probe(struct platform_device *pdev)
> >         return err;
> >  }
> >
> > +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> 
> I am not sure I understand why you need to suspend the device in the
> "noirq" phase. Isn't it fine to do that in the regular suspend phase?

PCIe device's configuration space values should be saved/restored in
system suspend/resume flow, and PCIe framework will take care of that in
the suspend_noirq phase. Suspend device in the "noirq" phase will spare
device driver from that.

> 
> > +{
> > +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > +       const struct mtk_pcie_soc *soc = pcie->soc;
> > +       struct mtk_pcie_port *port;
> > +
> > +       if (!soc->pm_support)
> > +               return 0;
> > +
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

Well, current host driver support different SoCs like mt7623, mt7622 and
mt2712. mt7623 need quite special take care of when system suspend. This
patch just add the suspend/resume support for mt7622&mt2712, while
mt7623 was excluded. This "pm_support" maybe removed after we have a
solution for mt7623 SoC of the system suspend.

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

Yes, that's what am I want to do.

> 
> If that's the case, I would rather avoid calling pm_runtime_disable()
> and pm_runtime_put() via mtk_pcie_suspend_noirq(), simply because it
> isn't needed.

> Of course, another option is to follow the pattern in
> drivers/mmc/host/sdhci-xenon.c.
> 

Thanks.
I take a look at the drivers/mmc/sdhci-xenon.c's implement, it has add
system suspend callbacks and set the device status to "PRM_SUSPENDED"
through the pm_runtime_force_suspend() interface.
I noticed that pm_runtime_put_sync will put the device status to
"PRM_SUSPENDED" status in some certain condition.
And I did not found the pci framework setting the status to
"PRM_SUSPENDED". So I add the pm_runtime_put_sync/disable in
suspend_noirq phase.

According to my understanding of PM, the system suspend flow does not
care about the runtime PM status. The runtime pm is responsible for the
CMOS gate, if the device want to gated it's CMOS, it need to call the
runtime pm interface obviously.

But I found that the PCIe framework will still operate with the device
after device driver suspend_noirq executed like save the configuration
space values through pci_save_state, So I guess the cmos could not be
gated at the suspend_noirq phase. I will update the patchset to remove
the pm runtime operations in the suspend_noirq phase.

> Overall, I am also wondering why only runtime PM is used when there is
> a PM domain attached to the device? That seems to make the logic in
> the driver, unnecessary complicated. Why not use runtime
> unconditionally and thus enable it during ->probe()?

I'm not sure, I thought that if there's no "power-domains = " property
in device node, that means the device has no PM domain. Some of the SoCs
does not have independent CMOS domain. So does that means it will leave
the dev->pm_domain as NULL or assign it as the genpd->pm_domain?

I need to do some homework to figure this out and will send a new patch
to fix this if needed.

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
