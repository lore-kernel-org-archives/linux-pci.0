Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50574 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932250AbcFCIzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Jun 2016 04:55:21 -0400
Date: Fri, 3 Jun 2016 09:55:47 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
Message-ID: <20160603085547.GB24547@red-moon>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
 <57483CAA.8000005@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57483CAA.8000005@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 27, 2016 at 01:25:14PM +0100, Marc Zyngier wrote:

[...]

> > +	} else {
> > +		bus = pci_scan_root_bus(&pdev->dev, 0,
> > +					&rockchip_pcie_ops, port, &res);
> > +	}
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> 
> Why do you have catter for the PCI_PROBE_ONLY case? Nobody should ever
> use that for properly implemented HW.

I think that's just copy and paste and it is a useless check given
that the only way we can set that flag on ARM/ARM64 is through DT
(of_pci_check_probe_only()) and I doubt that systems probing this
driver really require a PCI_PROBE_ONLY set-up.

So, unless you can explain to us why it is really needed, please
remove the:

if (!pci_has_flag(PCI_PROBE_ONLY))

check.

Lorenzo
