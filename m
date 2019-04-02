Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9168C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 18:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A202084B
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554229874;
	bh=bBK0mOmQqPA7igI3xWqeoM+YjrKteUXPb/r5liiVdxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=keiAFELoQ4nDSaMeGOONZNHgRDYxk9Kx7f+K5GAECG2547gE05PiI6eG/m5uI4a1Y
	 6PNrxtOmuFLIcsDDYasvIB5zhst2U/1C+fM4pGyuY7de7+vdOeqDBxNZlkqPHvSDPX
	 83q2800RJbZhVyLzSwe97wajQgUls5WjtuMOzK1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDBSbN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBSbN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 14:31:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC7C2082C;
        Tue,  2 Apr 2019 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554229872;
        bh=bBK0mOmQqPA7igI3xWqeoM+YjrKteUXPb/r5liiVdxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuRjfHyjvuAF7k0CNnnrLtGv6v4vF20iW1GFufBKtN/qIB9XZCogW88glLzYcXh+Q
         8m5QwYqWfvJHwMyLlq811WlMirl4LCyX8yp9v2qfxy7vZAsiboQcIpDNN3wB5lSzL5
         AzA3GEbSPvfeqJduu/Kon5icX6hHOiUkHt3lZca8=
Date:   Tue, 2 Apr 2019 13:31:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, tiwai@suse.de, spujar@nvidia.com,
        skomatineni@nvidia.com, liviu.dudau@arm.com, krzk@kernel.org,
        heiko@sntech.de, horms+renesas@verge.net.au, olof@lixom.net,
        maxime.ripard@bootlin.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        stefan.wahren@i2se.com, marc.w.gonzalez@free.fr,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        hayashi.kunihiko@socionext.com, yue.wang@amlogic.com,
        shawn.lin@rock-chips.com, xiaowei.bao@nxp.com,
        devicetree@vger.kernel.org, mmaddireddy@nvidia.com,
        kthota@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/10] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190402183110.GE141706@google.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
 <20190329203159.GG24180@google.com>
 <5eb9599c-a6d6-d3a3-beef-5225ed7393f9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb9599c-a6d6-d3a3-beef-5225ed7393f9@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 12:47:48PM +0530, Vidya Sagar wrote:
> On 3/30/2019 2:22 AM, Bjorn Helgaas wrote:
> > On Tue, Mar 26, 2019 at 08:43:26PM +0530, Vidya Sagar wrote:
> > > Add support for Synopsys DesignWare core IP based PCIe host controller
> > > present in Tegra194 SoC.

> > > +#include "../../pcie/portdrv.h"
> > 
> > What's this for?  I didn't see any obvious uses of things from
> > portdrv.h, but I didn't actually try to build without it.
> This is for pcie_pme_disable_msi() API. Since this is defined in portdrv.h
> file, I'm including it here.

Hmm, OK, I missed that.  If you need pcie_pme_disable_msi(), you
definitely need portdrv.h.  But you're still a singleton in terms of
including it, so it leads to follow-up questions:

  - Why does this chip require pcie_pme_disable_msi()?  The only other
    use is a DMI quirk for "MSI Wind U-100", added by c39fae1416d5
    ("PCI PM: Make it possible to force using INTx for PCIe PME
    signaling").

  - Is this a workaround for a Tegra194 defect?  If so, it should be
    separated out and identified as such.  Otherwise it will get
    copied to other places where it doesn't belong.

  - You only call it from the .runtime_resume() hook.  That doesn't
    make sense to me: if you never suspend, you never disable MSI for
    PME signaling.

> > > +	val_w = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
> > > +	while (!(val_w & PCI_EXP_LNKSTA_DLLLA)) {
> > > +		if (!count) {
> > > +			val = readl(pcie->appl_base + APPL_DEBUG);
> > > +			val &= APPL_DEBUG_LTSSM_STATE_MASK;
> > > +			val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
> > > +			tmp = readl(pcie->appl_base + APPL_LINK_STATUS);
> > > +			tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
> > > +			if (val == 0x11 && !tmp) {
> > > +				dev_info(pci->dev, "link is down in DLL");
> > > +				dev_info(pci->dev,
> > > +					 "trying again with DLFE disabled\n");
> > > +				/* disable LTSSM */
> > > +				val = readl(pcie->appl_base + APPL_CTRL);
> > > +				val &= ~APPL_CTRL_LTSSM_EN;
> > > +				writel(val, pcie->appl_base + APPL_CTRL);
> > > +
> > > +				reset_control_assert(pcie->core_rst);
> > > +				reset_control_deassert(pcie->core_rst);
> > > +
> > > +				offset =
> > > +				dw_pcie_find_ext_capability(pci,
> > > +							    PCI_EXT_CAP_ID_DLF)
> > > +				+ PCI_DLF_CAP;
> > 
> > This capability offset doesn't change, does it?  Could it be computed
> > outside the loop?
> This is the only place where DLF offset is needed and gets calculated and this
> scenario is very rare as so far only a legacy ASMedia USB3.0 card requires DLF
> to be disabled to get PCIe link up. So, I thought of calculating the offset
> here itself instead of using a separate variable.

Hmm.  Sounds like this is essentially a quirk to work around some
hardware issue in Tegra194.

Is there some way you can pull this out into a separate function so it
doesn't clutter the normal path and it's more obvious that it's a
workaround?

> > > +				val = dw_pcie_readl_dbi(pci, offset);
> > > +				val &= ~DL_FEATURE_EXCHANGE_EN;
> > > +				dw_pcie_writel_dbi(pci, offset, val);
> > > +
> > > +				tegra_pcie_dw_host_init(&pcie->pci.pp);
> > 
> > This looks like some sort of "wait for link up" retry loop, but a
> > recursive call seems a little unusual.  My 5 second analysis is that
> > the loop could run this 200 times, and you sure don't want the
> > possibility of a 200-deep call chain.  Is there way to split out the
> > host init from the link-up polling?
> Again, this recursive calling comes into picture only for a legacy ASMedia
> USB3.0 card and it is going to be a 1-deep call chain as the recursion takes
> place only once depending on the condition. Apart from the legacy ASMedia card,
> there is no other card at this point in time out of a huge number of cards that we have
> tested.

We need to be able to analyze the code without spending time working
out what arcane PCIe spec details might limit this to fewer than 200
iterations, or relying on assumptions about how many cards have been
tested.

If you can restructure this so the "wait for link up" loop looks like
all the other drivers, and the DLF issue is separated out and just
causes a retry of the "wait for link up", I think that will help a
lot.

> > > +static void tegra_pcie_dw_scan_bus(struct pcie_port *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
> > > +	u32 speed;
> > > +
> > > +	if (!tegra_pcie_dw_link_up(pci))
> > > +		return;
> > > +
> > > +	speed = (dw_pcie_readw_dbi(pci, CFG_LINK_STATUS) & PCI_EXP_LNKSTA_CLS);
> > > +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> > 
> > I don't understand what's happening here.  This is named
> > tegra_pcie_dw_scan_bus(), but it doesn't actually scan anything.
> > Maybe it's just a bad name for the dw_pcie_host_ops hook
> > (ks_pcie_v3_65_scan_bus() is the only other .scan_bus()
> > implementation, and it doesn't scan anything either).
> > 
> > dw_pcie_host_init() calls pci_scan_root_bus_bridge(), which actually
> > *does* scan the bus, but it does it before calling
> > pp->ops->scan_bus().  I'd say by the time we get to
> > pci_scan_root_bus_bridge(), the device-specific init should be all
> > done and we should be using only generic PCI core interfaces.
> > 
> > Maybe this stuff could/should be done in the ->host_init() hook?  The
> > code between ->host_init() and ->scan_bus() is all generic code with
> > no device-specific stuff, so I don't know why we need both hooks.
> Agree. At least whatever I'm going here as part of scan_bus can be moved to
> host_init() itslef. I'm not sure about the original intention of the scan_bus
> but my understanding is that, after PCIe sub-system enumerates all devices, if
> something needs to be done, then, probably scan_bus() can be implemented for that.
> I had some other code initially which was accessing downstream devices, hence I
> implemented scan_bus(), but, now, given all that is gone, I can move this code to
> host_init() itself.

That'd be perfect.  I suspect ks_pcie_v3_65_scan_bus() is left over
from before the generic PCI core scan interface, and it could probably
be moved to host_init() as well.

> > > +static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> > > +{
> > > +	struct pci_dev *pdev = NULL;
> > 
> > Unnecessary initialization.
> Done.
> 
> > > +	struct pci_bus *child;
> > > +	struct pcie_port *pp = &pcie->pci.pp;
> > > +
> > > +	list_for_each_entry(child, &pp->bus->children, node) {
> > > +		/* Bring downstream devices to D0 if they are not already in */
> > > +		if (child->parent == pp->bus) {
> > > +			pdev = pci_get_slot(child, PCI_DEVFN(0, 0));
> > > +			pci_dev_put(pdev);
> > > +			if (!pdev)
> > > +				break;
> > 
> > I don't really like this dance with iterating over the bus children,
> > comparing parent to pp->bus, pci_get_slot(), pci_dev_put(), etc.
> > 
> > I guess the idea is to bring only the directly-downstream devices to
> > D0, not to do it for things deeper in the hierarchy?
> Yes.
> 
> > Is this some Tegra-specific wrinkle?  I don't think other drivers do
> > this.
> With Tegra PCIe controller, if the downstream device is in non-D0 states,
> link doesn't go into L2 state. We observed this behavior with some of the
> devices and the solution would be to bring them to D0 state and then attempt
> sending PME_TurnOff message to put the link to L2 state.
> Since spec also supports this mechanism (Rev.4.0 Ver.1.0 Page #428), we chose
> to implement this.

Sounds like a Tegra oddity that should be documented as such so it
doesn't get copied elsewhere.

> > I see that an earlier patch added "bus" to struct pcie_port.  I think
> > it would be better to somehow connect to the pci_host_bridge struct.
> > Several other drivers already do this; see uses of
> > pci_host_bridge_from_priv().
> All non-DesignWare based implementations save their private data structure
> in 'private' pointer of struct pci_host_bridge and use pci_host_bridge_from_priv()
> to get it back. But, DesignWare based implementations save pcie_port in 'sysdata'
> and nothing in 'private' pointer. So,  I'm not sure if pci_host_bridge_from_priv()
> can be used in this case. Please do let me know if you think otherwise.

DesignWare-based drivers should have a way to retrieve the
pci_host_bridge pointer.  It doesn't have to be *exactly* the
same as non-DesignWare drivers, but it should be similar.

> > That would give you the bus, as well as flags like no_ext_tags,
> > native_aer, etc, which this driver, being a host bridge driver that's
> > responsible for this part of the firmware/OS interface, may
> > conceivably need.

> > > +static int tegra_pcie_dw_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> > > +
> > > +	tegra_pcie_downstream_dev_to_D0(pcie);
> > > +
> > > +	pci_stop_root_bus(pcie->pci.pp.bus);
> > > +	pci_remove_root_bus(pcie->pci.pp.bus);
> > 
> > Why are you calling these?  No other drivers do this except in their
> > .remove() methods.  Is there something special about Tegra, or is this
> > something the other drivers *should* be doing?
> Since this API is called by remove, I'm removing the hierarchy to safely
> bring down all the devices. I'll have to re-visit this part as
> Jisheng Zhang's patches https://patchwork.kernel.org/project/linux-pci/list/?series=98559
> are now approved and I need to verify this part after cherry-picking
> Jisheng's changes.

Tegra194 should do this the same way as other drivers, independent of
Jisheng's changes.

Bjorn
