Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23183C10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF7320880
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 13:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554816368;
	bh=ugv/q8Ir2xuhRZj8P2xjOajlKn7KtPMRbReuc9hn1SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fSKdl9bxPrjg/CB1fkUaQckfqBxM4Lk6gNkhinvw8PgpcvGnkJf/ypiXP0FHOWSmx
	 /5xK0c4ufsL4ia7KMWTEdVzh8cmojr2HrzZUNnba1Mz6iBdK3TNgFxgOzxa6PJdqAr
	 VXAZvV8Evw2OnnxVBwLdhIr3nS0NcEbLkYJ0wzpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDIN0H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfDIN0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Apr 2019 09:26:06 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDE72084C;
        Tue,  9 Apr 2019 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554816365;
        bh=ugv/q8Ir2xuhRZj8P2xjOajlKn7KtPMRbReuc9hn1SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAPr/ZsFO6E0bVq0o+Jix5xEtImduWat6Q8JeREGHtogNdo897jfJY64H0FyvpRSA
         hXaqzi0Gwtc2Q6fz3WiE8/4ZA4Zipb5fztMucXfHQTuL3LE535Qvf8H8MmcsGfkHuF
         6wXmeFqIM0X126tDLYv3kEyc5oi87xvkTZvraqXs=
Date:   Tue, 9 Apr 2019 08:26:04 -0500
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
Message-ID: <20190409132604.GA256045@google.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
 <20190329203159.GG24180@google.com>
 <5eb9599c-a6d6-d3a3-beef-5225ed7393f9@nvidia.com>
 <20190402183110.GE141706@google.com>
 <dcbfbb32-9980-7ee4-89cd-baedfe624ce5@nvidia.com>
 <20190403173641.GI141706@google.com>
 <6cc7e047-bc7e-fa60-88ba-0b69c3d5a3f0@nvidia.com>
 <20190405185842.GC26522@google.com>
 <40c97eaa-e37e-860e-111d-879a135d9f51@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c97eaa-e37e-860e-111d-879a135d9f51@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 09, 2019 at 05:00:53PM +0530, Vidya Sagar wrote:
> On 4/6/2019 12:28 AM, Bjorn Helgaas wrote:
> > On Fri, Apr 05, 2019 at 01:23:51AM +0530, Vidya Sagar wrote:
> > > On 4/3/2019 11:06 PM, Bjorn Helgaas wrote:
> > > > On Wed, Apr 03, 2019 at 03:13:09PM +0530, Vidya Sagar wrote:
> > > > > On 4/3/2019 12:01 AM, Bjorn Helgaas wrote:
> > > > > > On Tue, Apr 02, 2019 at 12:47:48PM +0530, Vidya Sagar wrote:
> > > > > > > On 3/30/2019 2:22 AM, Bjorn Helgaas wrote:
> > > > > > > > On Tue, Mar 26, 2019 at 08:43:26PM +0530, Vidya Sagar wrote:
> > > > > > > > > Add support for Synopsys DesignWare core IP based PCIe host controller
> > > > > > > > > present in Tegra194 SoC.
> > > > > > 
> > > > > >      - Why does this chip require pcie_pme_disable_msi()?  The only other
> > > > > >        use is a DMI quirk for "MSI Wind U-100", added by c39fae1416d5
> > > > > >        ("PCI PM: Make it possible to force using INTx for PCIe PME
> > > > > >        signaling").
> > > > > 
> > > > > Because Tegra194 doesn't support raising PME interrupts through MSI line.

> > There's something wrong here.  Either the question of how PME is
> > signaled is generic and the spec provides a way for the OS to discover
> > that method, or it's part of the device-specific architecture that
> > each host bridge driver has to know about its device.  If the former,
> > we need to make the PCI core smart enough to figure it out.  If the
> > latter, we need a better interface than this ad hoc
> > pcie_pme_disable_msi() thing.  But if it is truly the latter, your
> > current code is sufficient and we can refine it over time.
>
> In case of Tegra194, it is the latter case.

This isn't a Tegra194 question; it's a question of whether this
behavior is covered by the PCIe spec.

> > What I suspect should happen eventually is the DWC driver should call
> > devm_pci_alloc_host_bridge() directly, as all the non-DWC drivers do.
> > That would require a little reorganization of the DWC data structures,
> > but it would be good to be more consistent.
> > 
> > For now, I think stashing the pointer in pcie_port or dw_pcie would be
> > OK.  I'm not 100% clear on the difference, but it looks like either
> > should be common across all the DWC drivers, which is what we want.
>
> Since dw_pcie is common for both root port and end point mode structures,
> I think it makes sense to keep the pointer in pcie_port as this structure
> is specific to root port mode of operation.
> I'll make a note to reorganize code to have devm_pci_alloc_host_bridge()
> used in the beginning itself to be inline with non-DWC implementations.
> But, I'll take it up later (after I'm done with upstreaming current series)

Fair enough.

> > > .remove() internally calls pm_runtime_put_sync() API which calls
> > > .runtime_suspend(). I made a new patch to add a host_deinit() call
> > > which make all these calls. Since host_init() is called from inside
> > > .runtime_resume() of this driver, to be in sync, I'm now calling
> > > host_deinit() from inside .runtime_suspend() API.
> > 
> > I think this is wrong.  pci_stop_root_bus() will detach all the
> > drivers from all the devices.  We don't want to do that if we're
> > merely runtime suspending the host bridge, do we?
>
> In the current driver, the scenarios in which .runtime_suspend() is called
> are
> a) during .remove() call and

It makes sense that you should call pci_stop_root_bus() during
.remove(), i.e., when the host controller driver is being removed,
because the PCI bus will no longer be accessible.  I think you should
call it *directly* from tegra_pcie_dw_remove() because that will match
what other drivers do.

> b) when there is no endpoint found and controller would be shutdown
> In both cases, it is required to stop the root bus and remove all devices,
> so, instead of having same call present in respective paths, I kept them
> in .runtime_suspend() itself to avoid code duplication.

I don't understand this part.  We should be able to runtime suspend
the host controller without detaching drivers for child devices.

If you shutdown the controller completely and detach the *host
controller driver*, sure, it makes sense to detach drivers from child
devices.  But that would be handled by the host controller .remove()
method, not by the runtime suspend method.

Bjorn
