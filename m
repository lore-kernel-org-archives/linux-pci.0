Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44931 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933436AbcDYTVH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2016 15:21:07 -0400
Date: Mon, 25 Apr 2016 21:21:03 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
Message-ID: <20160425212103.0f646a3a@free-electrons.com>
In-Reply-To: <20160425172846.GB1759@localhost>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160425154611.3e7e9dc9@free-electrons.com>
	<20160425172846.GB1759@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Mon, 25 Apr 2016 12:28:46 -0500, Bjorn Helgaas wrote:

> It *is* pretty trivial.  The reason I'm hesitating is because we have
> all these DesignWare-based drivers (dra7xx, exynos, imx6, ks, ls,
> dw_plat, hisi, qcom, spear13xx, and now armada8k), and they're
> *mostly* similar, but they differ in minor, annoying ways.  This is
> becoming a significant maintenance burden for me, and I'd like to
> figure out how to mitigate that.

Understood.

> For now, I don't have any great ideas except that it would be nice to
> remove needless variations.  The following is a typical code
> structure, but it's not universally followed:
> 
>   XXX_pcie_probe
>     XXX_add_pcie_port
>       dw_pcie_host_init
>         XXX_pcie_host_init
> 	  dw_pcie_setup_rc
> 	  XXX_pcie_establish_link

Indeed, the first step towards having more common code is to make the
code to be factorized look as similar as possible.

> There's a hodge-podge of ways to get related resources (clocks and
> PHYs) and initialize them.  IRQ setup is not really consistent across
> all the drivers.  It's sort of disappointing that most of these
> drivers have a "dbi_base" resource, but they use different DT property
> names for it.
> 
> The armada8k driver doesn't have a DRV_add_pcie_port() function or a
> DRV_pcie_establish_link() function, and it has its own "wait for link"
> timeout loop instead of using dw_pcie_wait_for_link().
> 
> How about if you just shuffle those bits around into
> an armada8k_add_pcie_port() and an armada8k_pcie_establish_link(), and
> we'll call that good for now?

I'll take a stab at that tomorrow and send an updated version.

Thanks for the feedback!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
