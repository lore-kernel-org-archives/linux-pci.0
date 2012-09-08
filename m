Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46826 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab2IHFxK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Sep 2012 01:53:10 -0400
Message-ID: <504ADD44.6040501@wwwdotorg.org>
Date: Fri, 07 Sep 2012 23:53:08 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
References: <50201E1D.5060200@wwwdotorg.org> <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de> <50294BCA.1070807@wwwdotorg.org> <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com> <502AA96B.2050709@wwwdotorg.org> <20120814195834.GA10431@avionic-0098.mockup.avionic-design.de> <CAErSpo4Bm_Ryx=OK+svjqAwD4N8v0vrheLVdc-N1ijx8i_-N3w@mail.gmail.com> <502AD82F.3080702@wwwdotorg.org> <502AE485.8060307@wwwdotorg.org> <504A848B.1090703@wwwdotorg.org> <20120908000430.GF13739@n2100.arm.linux.org.uk>
In-Reply-To: <20120908000430.GF13739@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/07/2012 06:04 PM, Russell King - ARM Linux wrote:
> On Fri, Sep 07, 2012 at 05:34:35PM -0600, Stephen Warren wrote:
>> I guess it's a pretty basic premise of the current PCI code that all the
>> PCI scanning happens well before any device drivers are registered,
>> which in turn means that device_add() doesn't trigger the device's
>> probe() until much later, after all the fixups and resource assignments
>> are done?
> 
> Are you saying that the PCI layer is again screwed up after all my
> hard work several years ago to ensure that PCI devices are properly
> setup _before_ they're made available to the PCI drivers then?  That
> was around the time I was looking at Cardbus stuff, ensuring that that
> worked with the same guarantees.
> 
> Not amused.
> 
> What is wrong with the "probe devices, apply fixups, setup resources,
> apply more fixups, publish" process that it's had to be yet again
> broken?

I must admit, I'm having a hard time finding when the code worked like
that; ARM's bios32.c:pcibios_init_hw() seems to have always called
pci_scan_root_bus(), or ops function hw->scan(), which at least in the 1
PCIe controller driver I looked at, in turn always called either
pci_scan_root_bus() or another similar function that I believe always
called pci_bus_add_devices(), which is before pci_common_init() could
assign the resources. Maybe I'm just looking at the wrong PCIe
controller driver, or not looking back far enough in git history (or
pre-git)? If you could point out when it was working as you describe
(which sounds reasonable), I'd be interested in tracing the history from
there to see when/why it changed.
