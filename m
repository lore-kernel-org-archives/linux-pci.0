Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:57475 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab3A3EYt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 23:24:49 -0500
Date: Tue, 29 Jan 2013 21:24:46 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130130042446.GC5734@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5H08j=dZx9zapDaf1c9x6VUfuJ5oB=J0M1UFF55pg=mw@mail.gmail.com>
 <20130129055508.GA3339@obsidianresearch.com>
 <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
 <20130129184157.GA29274@obsidianresearch.com>
 <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
 <20130129191853.GB29274@obsidianresearch.com>
 <CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com>
 <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 03:27:43PM -0700, Bjorn Helgaas wrote:

> I'm not sure the existing emulation in these patches is sufficient.
> For example, pci_sw_pci_bridge_write() updates bridge->membase when we
> write to the window register, but I don't see anything that updates
> the actual hardware decoder.  That might be done in
> mvebu_pcie_window_config_port() via armada_370_xp_alloc_pcie_window(),
> but that looks like it's only done once.  If the PCI core updates a
> root port window later, I don't see where the hardware decoder will be
> updated.
> 
> Maybe you're counting on the window assignments to be static?  The PCI
> core doesn't guarantee anything like that, though in the absence of
> hotplug I don't know any reason why it would change things.
 
Agree..

Thomas, I think you need to directly update the Marvell hardware
registers when config writes are made to the SW bridge. If this means
it is too hard/complex to keep the code general then I'd say make it
part of the Marvell host driver.

> I also forgot about the bus number munging in mvebu_pcie_rd_conf().
> The PCI core can update the bridge secondary/subordinate registers.
> It looks like you don't support writing to them, and the read path
> (pci_sw_pci_bridge_read()) looks like it doesn't do any translation
> between the hardware and Linux bus numbers.  I don't understand the
> system well enough to know if this is an issue.

I was chatting with Thomas on this subject, it looks like there is a
HW register that needs to be set to the subordinate bus number of the
bridge, that will solve this weirdness.

Jason
