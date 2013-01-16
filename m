Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
Date: Wed, 16 Jan 2013 14:00:26 +0000
Cc: Andrew Murray <andrew.murray@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de> <20130115154038.GA11241@arm.com> <20130115211441.GA13139@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20130115211441.GA13139@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201301161400.26587.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 15 January 2013, Thierry Reding wrote:
> Is there actually hardware that supports this? I assumed that the MSI
> controller would have to be tightly coupled to the PCI host bridge in
> order to raise an interrupt when an MSI is received via PCI.

No, as long as it's guaranteed that the MSI notification won't arrive
at the CPU before any inbound DMA data before it, the MSI controller
can be anywhere. Typically, the MSI controller is actually closer to
the CPU core than to the PCI bridge. On X86, I believe the MSI address
is on normally on the the "local APIC" on each CPU.

	Arnd
