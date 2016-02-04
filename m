Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34466 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916AbcBDXni (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 18:43:38 -0500
Date: Thu, 4 Feb 2016 17:43:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Vineet.Gupta1@synopsys.com, arnd@arndb.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v8 2/2] add new platform driver for PCI RC
Message-ID: <20160204234334.GH7031@localhost>
References: <cover.1454600622.git.jpinto@synopsys.com>
 <c7af1603d4f18d11cb0ccee1c07708a1455ea4ed.1454600622.git.jpinto@synopsys.com>
 <20160204181911.GA2143@localhost>
 <56B398E9.3080902@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B398E9.3080902@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 04, 2016 at 06:31:05PM +0000, Joao Pinto wrote:
> On 2/4/2016 6:19 PM, Bjorn Helgaas wrote:
> > On Thu, Feb 04, 2016 at 03:52:10PM +0000, Joao Pinto wrote:
> >> This patch adds a new driver that will be the reference platform driver
> >> for all PCI RC IP Protoyping Kits based on ARC SDP.
> >>
> >> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> >> ---
> >> Change v7 -> v8 (Bjorn Helgaas and Arnd Bergmann):
> >> - driver name was changed from pcie-synopsys to pcie-dw-pltfm
> > 
> > "pcie-dw-pltfm" seems worse to me.  We have eight existing drivers
> > that call dw_pcie_host_init(), and they're all platform_drivers.
> > "pcie-dw-pltfm" could apply equally well to any of them.
> > 
> > I think I see what happened: I wrote "It doesn't seem necessary to me
> > to include both 'synopsys' and 'ipk' in the filename and the driver
> > name."  I meant that using one of them should be sufficient, not that
> > *both* should be removed.
> > 
> > I don't know the SoC landscape, but from Arnd's comment, it sounds
> > like "synopsys" might be too generic because many of the other drivers
> > are connected with Synopsys.  I don't know what "ipk" means, but maybe
> > that could work.  It's convenient if the name *means* something, and
> > if "ipk" stands for "IP Prototyping Kit", that sounds pretty generic.
> > Is "haps" or "haps_dx" a name people would associate with this
> > hardware?  I guess it'd be nice if the driver name were related to the
> > DT compat strings, so "ipk" is better from that perspective.
> 
> Synopsys has a product called IP Prototyping Kit which is a bundle of
> HAPSDX + PCIE RC IP + drivers + Development Board. This driver was
> implemented originally to serve this IPK but it can be used by SoC that
> use the Synopsys PCIe RC IP.  "ipk" would say that the driver is usable
> only in the IP Prototyping Kits which is not 100% true, it is usable in
> any SoC with Synopsys IP or in limit serve as a base for specific SoC
> drivers.  Suggestions: "pcie-dw-soc-agnostic", "pcie-dw-ipk",
> "pcie-dw-haps-prototyping"
> 
> What do you think?

I don't think the "dw" part is relevant (none of the other
DesignWare-based drivers includes it in the driver or file name).

How do people typically refer to this board?

I really like "synopsys" because it fits the pattern of being
recognizable and pronounceable like "altera", "designware", "qcom",
"keystone", "layerscape", "tegra", etc.  But I can't tell whether it's
too generic.

"ipk" or "haps" would be fine with me.  I think it's OK if it doesn't
cover 100% of the possible systems.

Bjorn
