Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 05/14] lib: Add I/O map cache implementation
Date: Thu, 10 Jan 2013 18:26:55 +0000
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-tegra@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de> <201301100917.19577.arnd@arndb.de> <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201301101826.56248.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 10 January 2013, Thierry Reding wrote:
> I don't understand how this would help. The encoding is like this:
> 
>         [27:24] extended register number
>         [23:16] bus number
>         [15:11] device number
>         [10: 8] function number
>         [ 7: 0] register number
> 
> So it doesn't matter whether I use separate areas per bus or not. As
> soon as the whole extended configuration space needs to be accessed a
> whopping 28 bits (256 MiB) are required.
> 
> What you propose would work if only regular configuration space is
> supported. I'm not sure if that's an option.

I mean something like:

struct tegra_bus_private {
	...
	void __iomem *config_space[16];
};


void tegra_scan_bus(struct pci_bus *bus)
{
	int i;
	struct tegra_bus_private *priv = bus->dev->private;

	for (i=0; i<16; i++)
		priv->config_space[i] = ioremap(config_space_phys +
				 65536 * bus->primary + i * SZ_1M, 65536);

	...
}

	Arnd
