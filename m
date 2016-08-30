Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:57740 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbcH3NLh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Aug 2016 09:11:37 -0400
Date: Tue, 30 Aug 2016 15:11:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Joao Pinto <jpinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Yehuda Yitschak <yehuday@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH 2/3] pci: pcie-designware: add support for external MSI
 controller
Message-ID: <20160830131131.GA8295@lunn.ch>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1472561830-20932-3-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472561830-20932-3-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 30, 2016 at 02:57:09PM +0200, Thomas Petazzoni wrote:
> The Designware PCIe controllers have a built-in MSI controller, which is
> already supported by the existing. However, in some situations, it might

                                   ^ driver.

> be a better choice to use an external MSI controller, especially when it
> provides a higher number of MSI interrupts than the built-in one.
> 
> Therefore, this commit extends the pcie-designware driver to support the
> "msi-parent" DT property, already used by other drivers. It contains a
> phandle pointing to the external MSI controller to be used.
> 
> Following this commit, the pcie-designware code supports three
> possibilities, in this order:
> 
>  1. If msi-parent is provided, then the MSI controller pointed by this

                                                                 ^ to  

>     property is used.

>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		if (!pp->ops->msi_host_init) {
> +		if (of_find_property(pp->dev->of_node, "msi-parent", NULL)) {
> +			struct device_node *msi_node;
> +
> +			msi_node = of_parse_phandle(pp->dev->of_node,
> +						    "msi-parent", 0);
> +			if (!msi_node)
> +				return -ENODEV;
> +
> +			msi = of_pci_find_msi_chip_by_node(msi_node);

By this point, device tree tells us the external MSI controller
should exist. So if we get a NULL here, should we not return
-EPROBE_DIFFERED?

	Andrew
