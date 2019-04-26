Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F7C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC123212F5
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 18:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556301912;
	bh=/qeIedzmGoBcI7iCSVmfVLzqCIkqkXp0y0G3BeOY+Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0/bCo68MnB2IFGEnhaO05lqOwkY3CK68/DKoIeJIqfmagjCXyQGhfvdOf/kLr8KHT
	 7em5M3KcmGbJVvy6+mVePt8p6EuO71UpOLyWcjX22rSy2parDMMZ/wBb4HWCa9/nXP
	 ZB3BgBh8hGEbA2p7C7ryTqmzmJLp4Ho31XXiXumo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfDZSFM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:05:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37130 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZSFM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 14:05:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id r20so2275701otg.4;
        Fri, 26 Apr 2019 11:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zQtkRNUgw/vFCvnSqmhPpYcrqE3+8B2y1PZeuVMpevc=;
        b=REwI/7H0AexLx0QjbTsszKOH5jYC4FViNjwjj2OLuXhNtNP2UehbVAEqKhrojRH2e2
         DYl76yqTlINdH3wMrHJ5P7WaSS/cJEiRQ78BmWIpSZTkej9Ylu9Sd023rjzXScWDjKyo
         +dtJ0Rz3GpHJ555al7eg+YaKDNtjriMbP3nCna0/edeiij2hMwPWwbL+Atz74g2lNqrp
         CFRzdlqGreonyIZierMLaJkYX/r65J/DmwpS0rKP5nJuZ92uCHSFY3ezNu2MUcYtU91O
         PhBqnNJEOZQEegCTUvCaBffHwX76IkIiyTQLoXlba7nU8rPaLPm+jw+XB+IQT6ty5wgN
         4KdA==
X-Gm-Message-State: APjAAAUseDPvaxoEjCFySvrgFM0j2ReRa7J+6zD4weTsUUem3JZygOU4
        YtzzgnDp7r8QO3ECOupIZw==
X-Google-Smtp-Source: APXvYqxln9A5A7iSmPQpWDOcLJGBeq023K/7OjLJn8/Ia0ahcazPhqgaXSBOoVduHyvzKGxpC/ItjQ==
X-Received: by 2002:a05:6830:1051:: with SMTP id b17mr1064827otp.341.1556301910679;
        Fri, 26 Apr 2019 11:05:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c3sm1061276otb.13.2019.04.26.11.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:05:09 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:05:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, mark.rutland@arm.com, jonathanh@nvidia.com,
        kishon@ti.com, catalin.marinas@arm.com, will.deacon@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 11/16] dt-bindings: PHY: P2U: Add Tegra 194 P2U block
Message-ID: <20190426180509.GB19329@bogus>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-12-vidyas@nvidia.com>
 <20190426154519.GA19329@bogus>
 <20190426160723.GB3204@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426160723.GB3204@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 26, 2019 at 06:07:23PM +0200, Thierry Reding wrote:
> On Fri, Apr 26, 2019 at 10:45:19AM -0500, Rob Herring wrote:
> > On Wed, Apr 24, 2019 at 10:49:59AM +0530, Vidya Sagar wrote:
> > > Add support for Tegra194 P2U (PIPE to UPHY) module block which is a glue
> > > module instantiated one for each PCIe lane between Synopsys Designware core
> > > based PCIe IP and Universal PHY block.
> > 
> > Missing Sob.
> > 
> > > ---
> > > Changes since [v4]:
> > > * None
> > > 
> > > Changes since [v3]:
> > > * None
> > > 
> > > Changes since [v2]:
> > > * Changed node label to reflect new format that includes either 'hsio' or
> > >   'nvhs' in its name to reflect which UPHY brick they belong to
> > > 
> > > Changes since [v1]:
> > > * This is a new patch in v2 series
> > > 
> > >  .../bindings/phy/phy-tegra194-p2u.txt         | 28 +++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> > > new file mode 100644
> > > index 000000000000..8b543cba483b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> > > @@ -0,0 +1,28 @@
> > > +NVIDIA Tegra194 P2U binding
> > > +
> > > +Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
> > > +Speed) each interfacing with 12 and 8 P2U instances respectively.
> > > +A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
> > > +interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
> > > +lane.
> > > +
> > > +Required properties:
> > > +- compatible: For Tegra19x, must contain "nvidia,tegra194-p2u".
> > > +- reg: Should be the physical address space and length of respective each P2U
> > > +       instance.
> > > +- reg-names: Must include the entry "ctl".
> > 
> > -names is pointless when there is only 1.
> 
> We've occasionally done this in the past for other types of resources.
> When we did it was to preempt having to verbosely describe exactly what
> order -names entries need to be in if ever a new entry was required.
> 
> For example, if we document only one clock for a module and leave out
> the clock-names property, then if ever we need to add another clock, it
> means that clock-names must be documented in such a way that the "main"
> clock (the one that was always documented) would need to be first in the
> list of clock-names, so that it's matching entry in the clocks property
> is at index 0, because that's effectively what the ABI is.

The original clock at index 0 is part of the ABI with or without names 
as long as that clock is always required.

The purpose of '*-names' was to handle cases with multiple combinations 
of optional entries. That's the exception though and shouldn't be 
necessary too often. Clocks was an exception because the kernel's 
clock api required clock names (though only for more than 1). For the 
rest, everyone loves making up names and bloating their DT. (The last 
Plumbers had a discussion about replacing DT strings with numbers to 
shrink them, so it's not a non-issue for some.)

In any case, I only point this out if I have other comments and you all 
can keep it if you want. I'm just not a fan.

Rob
