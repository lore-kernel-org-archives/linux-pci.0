Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634DBC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 19:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327F92084B
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554232914;
	bh=mUJl9GjIhaTcalhVS05kGWKKcfEf8ElNfTEsbhSNwf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v054jGtHDa9NAgjC/jNnKjan6i1ECmj6W8lN6AjCqEY3Y8cL5o9RfYw9i5rl2CvVS
	 iIIM6Z4YF9Q+WoN0d5IHsOMo6433AdqsGogvfJqWAj8cGQmFQ32XfFqnqOtf/krarR
	 2ByeP2HIqD1DL1d9iq2vRo3FvooKID1Odn1p0nWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfDBTVx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfDBTVx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 15:21:53 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA37F2082C;
        Tue,  2 Apr 2019 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554232912;
        bh=mUJl9GjIhaTcalhVS05kGWKKcfEf8ElNfTEsbhSNwf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5P9FGFDbpYMpH0GL+c0OZBKn1SUopqqVSdewo44BeykQt+Xfim3gkd/68GSCicA4
         LHrMrlSZ5+U4Adrd580pEILaiU6UxooXfuC6ntkvxHfLTWTa/EhToOFuLUMPfBEJzg
         qqUdZmQu3iipUTjblYjs7YV7uBrj7aIhZYn+wRq4=
Date:   Tue, 2 Apr 2019 14:21:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, mark.rutland@arm.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        maxime.ripard@bootlin.com, catalin.marinas@arm.com,
        spujar@nvidia.com, will.deacon@arm.com, kthota@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com, stefan.wahren@i2se.com,
        lorenzo.pieralisi@arm.com, krzk@kernel.org, kishon@ti.com,
        tiwai@suse.de, jagan@amarulasolutions.com,
        linux-pci@vger.kernel.org, andy.gross@linaro.org,
        shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
        mmaddireddy@nvidia.com, marc.w.gonzalez@free.fr,
        liviu.dudau@arm.com, yue.wang@amlogic.com,
        enric.balletbo@collabora.com, robh+dt@kernel.org,
        horms+renesas@verge.net.au, bjorn.andersson@linaro.org,
        ezequiel@collabora.com, linux-arm-kernel@lists.infradead.org,
        xiaowei.bao@nxp.com, gustavo.pimentel@synopsys.com,
        linux-kernel@vger.kernel.org, skomatineni@nvidia.com,
        jingoohan1@gmail.com, olof@lixom.net, tpiepho@impinj.com,
        l.stach@pengutronix.de
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
Message-ID: <20190402192150.GF141706@google.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
 <20190328131508.GB5518@ulmo>
 <e5a12742-2dfa-e8c8-2a29-24838f4fa939@nvidia.com>
 <20190401150740.GB4874@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401150740.GB4874@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 01, 2019 at 05:07:40PM +0200, Thierry Reding wrote:
> On Mon, Apr 01, 2019 at 03:31:54PM +0530, Vidya Sagar wrote:
> > On 3/28/2019 6:45 PM, Thierry Reding wrote:
> > > On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
> > > > Add support for Tegra194 PCIe controllers. These controllers are based
> > > > on Synopsys DesignWare core IP.

> > > > +- nvidia,disable-aspm-states : controls advertisement of ASPM states
> > > > +    bit-0 to '1' : disables advertisement of ASPM-L0s
> > > > +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disables
> > > > +                 advertisement of ASPM-L1.1 and ASPM-L1.2
> > > > +    bit-2 to '1' : disables advertisement of ASPM-L1.1
> > > > +    bit-3 to '1' : disables advertisement of ASPM-L1.2
> > > 
> > > These seem more like configuration options rather than hardware
> > > description.
> > Yes. Since the platforms like Jetson-Xavier based on T194 are going to go in
> > open market, we are providing these configuration options and hence they are
> > optional
> 
> Under what circumstances would we want to disable certain ASPM states?
> My understanding is that PCI device drivers can already disable
> individual ASPM states if they don't support them, so why would we ever
> want to disable advertisement of certain ASPM states?

The PCI core (not individual device drivers) configures ASPM, and if both
ends of the link implement the spec correctly, there is nothing the device
driver needs to do.

There *are* a few drivers that fiddle with ASPM-related things.  I think
this is because either the core isn't doing things correctly and we haven't
bothered to fix the root cause, or the device itself is broken and we need
to disable something the hardware claims to support.

Bjorn
