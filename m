Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:36690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726720AbeIKPWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Sep 2018 11:22:44 -0400
Message-ID: <1536661436.31406.75.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Date: Tue, 11 Sep 2018 18:23:56 +0800
In-Reply-To: <CAPDyKFqvs6St1oTvx=_0dYSOXweW03PUZ=EAkgpL3XP-Sgg-sw@mail.gmail.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
         <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
         <CAPDyKFpFpR_NhtNW6rChMFw4KLweut8zC3x2V1ZBbdrV05iuTQ@mail.gmail.com>
         <1536572566.31406.64.camel@mhfsdcap03>
         <CAPDyKFqvs6St1oTvx=_0dYSOXweW03PUZ=EAkgpL3XP-Sgg-sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-09-10 at 13:25 +0200, Ulf Hansson wrote:
> On 10 September 2018 at 11:42, Honghui Zhang <honghui.zhang@mediatek.com> wrote:
[...]

> >> > +               clk_disable_unprepare(port->sys_ck);
> >> > +               phy_power_off(port->phy);
> >> > +               phy_exit(port->phy);
> >> > +       }
> >> > +
> >> > +       mtk_pcie_subsys_powerdown(pcie);
> >>
> >> Why not gate clocks, unconditionally not depending on if pm_support is
> >> set or not, during system suspend?
> >>
> >> I understand that you for some SoCs needs also to restore registers
> >> during system resume, but that's a different thing, isn't it?
> >>
> >
> > Well, current host driver support different SoCs like mt7623, mt7622 and
> > mt2712. mt7623 need quite special take care of when system suspend. This
> > patch just add the suspend/resume support for mt7622&mt2712, while
> > mt7623 was excluded. This "pm_support" maybe removed after we have a
> > solution for mt7623 SoC of the system suspend.
> 
> Okay. So you simply want to take small steps, that works!
> 
> >
> >> > +
> >> > +       return 0;
> >> > +}
> >> > +
> >> > +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> >> > +{
> >> > +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> >> > +       const struct mtk_pcie_soc *soc = pcie->soc;
> >> > +       struct mtk_pcie_port *port, *tmp;
> >> > +
> >> > +       if (!soc->pm_support)
> >> > +               return 0;
> >> > +
> >> > +       if (list_empty(&pcie->ports))
> >> > +               return 0;
> >> > +
> >> > +       if (dev->pm_domain) {
> >> > +               pm_runtime_enable(dev);
> >> > +               pm_runtime_get_sync(dev);
> >>
> >> I noticed, Lorenzo wanted me to comment on this, so here it goes.
> >>
> >> I guess the reason to why you make these pm_runtime_*() calls, is
> >> because you want to restore the actions taken during
> >> mtk_pcie_suspend_noirq() (which calls mtk_pcie_subsys_powerdown ->
> >> pm_runtime_disable|put*())?
> >
> > Yes, that's what am I want to do.
> >
> >>
> >> If that's the case, I would rather avoid calling pm_runtime_disable()
> >> and pm_runtime_put() via mtk_pcie_suspend_noirq(), simply because it
> >> isn't needed.
> >
> >> Of course, another option is to follow the pattern in
> >> drivers/mmc/host/sdhci-xenon.c.
> >>
> >
> > Thanks.
> > I take a look at the drivers/mmc/sdhci-xenon.c's implement, it has add
> > system suspend callbacks and set the device status to "PRM_SUSPENDED"
> > through the pm_runtime_force_suspend() interface.
> > I noticed that pm_runtime_put_sync will put the device status to
> > "PRM_SUSPENDED" status in some certain condition.
> > And I did not found the pci framework setting the status to
> > "PRM_SUSPENDED". So I add the pm_runtime_put_sync/disable in
> > suspend_noirq phase.
> >
> > According to my understanding of PM, the system suspend flow does not
> > care about the runtime PM status. The runtime pm is responsible for the
> > CMOS gate, if the device want to gated it's CMOS, it need to call the
> > runtime pm interface obviously.
> 
> Well, during system suspend, the PM core disables runtime PM for all
> devices. See __device_suspend_late().
> 
> Additionally, the PM core prevents devices from being runtime
> suspended. See device_prepare(), as it calls
> pm_runtime_get_noresume().
> 
> In other words, drivers can not rely on calling pm_runtime_put_sync()
> from a ->suspend_noirq() callback to put its device into low power
> state.
> 
Thanks for your explain, that's a great help for me with the
understanding the PM logical.

> >
> > But I found that the PCIe framework will still operate with the device
> > after device driver suspend_noirq executed like save the configuration
> > space values through pci_save_state, So I guess the cmos could not be
> > gated at the suspend_noirq phase. I will update the patchset to remove
> > the pm runtime operations in the suspend_noirq phase.
> 
> That's doesn't sound correct to me. Although, I am not a PCI expert.
> 
Never mind, per my understanding, after the driver's suspend_noirq
callback executed, the CMOS should not be gated, since the PCI framework
still got work to do with the device.

> >
> >> Overall, I am also wondering why only runtime PM is used when there is
> >> a PM domain attached to the device? That seems to make the logic in
> >> the driver, unnecessary complicated. Why not use runtime
> >> unconditionally and thus enable it during ->probe()?
> >
> > I'm not sure, I thought that if there's no "power-domains = " property
> > in device node, that means the device has no PM domain. Some of the SoCs
> > does not have independent CMOS domain. So does that means it will leave
> > the dev->pm_domain as NULL or assign it as the genpd->pm_domain?
> 
> My point is, that no matter if there is a PM domain assigned or not,
> the PCIe driver can still enable/use runtime PM. It shouldn't hurt.
> 

Thanks, I will try and propose another patch for this.

> >
> > I need to do some homework to figure this out and will send a new patch
> > to fix this if needed.
> 
> I did some more re-search and maybe the easiest thing for you to do is
> to follow the pattern in the tegra PCIe controller driver.
> drivers/pci/controller/pci-tegra.c.
> 
> That should definitely work for your case as well.

Thanks, most of the PCIe host driver does not set the RUNTIME_PM_OPS for
suspend except pci-tegra.c. So my V4 version patch has followed majority
driver.

> 
> [...]
> 
> Kind regards
> Uffe
