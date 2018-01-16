Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56556 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbeAPPIa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jan 2018 10:08:30 -0500
Date: Tue, 16 Jan 2018 15:09:31 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20180116150931.GA17237@red-moon>
References: <cover.1515621150.git.cyrille.pitchen@free-electrons.com>
 <990730f5c1156b3bb15f56fa877719941f219016.1515621150.git.cyrille.pitchen@free-electrons.com>
 <e3d88d5b-e770-d2e5-20b2-62551d5f4f8f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e3d88d5b-e770-d2e5-20b2-62551d5f4f8f@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 16, 2018 at 04:46:12PM +0530, Kishon Vijay Abraham I wrote:

[...]

> > +static struct platform_driver cdns_pcie_host_driver = {
> > +	.driver = {
> > +		.name = "cdns-pcie-host",
> > +		.of_match_table = cdns_pcie_host_of_match,
> > +	},
> > +	.probe = cdns_pcie_host_probe,
> > +};
> 
> In the case of DWC, designware core is modeled as a library which has
> API's to be invoked by various platform specific glue drivers.
> 
> But with the cadence approach we'll have two separate drivers: the
> cadence core driver and the platform specific glue drivers. Is this
> approach chosen for a specific reason?

That's a fair point but I do not think that's a concern at the moment.

If/when other platform drivers are built around the generic IP we just
have to refactor this driver and turn into a core library + a PCI host
bridge driver like dwc does, at the moment I do not necessarily see the
reason for splitting them.

Cyrille ?

Thanks,
Lorenzo
