Return-Path: <SRS0=/N/E=ZA=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=/N/E=ZA=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Wed, 18 Jan 2017 17:55:20 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	David Daney <david.daney@cavium.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170118175520.GN27312@n2100.armlinux.org.uk>
References: <20170117174649.GA11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117175115.GD27312@n2100.armlinux.org.uk>
 <20170117175728.GE27312@n2100.armlinux.org.uk>
 <20170117181458.GB11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117193414.GG27312@n2100.armlinux.org.uk>
 <20170117210258.GH27312@n2100.armlinux.org.uk>
 <20170117222229.GA6534@bhelgaas-glaptop.roam.corp.google.com>
 <e0ccb7a0-9cc7-c595-7f06-e63c0927f36d@caviumnetworks.com>
 <20170118142250.GB6534@bhelgaas-glaptop.roam.corp.google.com>
 <1137f732-f31e-8162-af8f-6a7f577a9648@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137f732-f31e-8162-af8f-6a7f577a9648@caviumnetworks.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2017 at 09:36:55AM -0800, David Daney wrote:
> On 01/18/2017 06:22 AM, Bjorn Helgaas wrote:
> The tricky thing here is assigning the blame for failure in link training.
> In the case in question we spent many months analysing the analog properties
> of the bus and examining/decoding  analog scope captures of the failures
> before credibly assigning blame to the other guy.  Usually what happens is
> the device vendor accurately claims that their device works flawlessly in
> conjunction with certain Intel root ports, so the problem must be fixed in
> the root port of the failing system.  If you have a black list, you may be
> disabling ASPM in systems where it can work without failures.

So what we need is not a table of just devices, but a combination of
devices... iow, "when root A and endpoint B are combined, retrains
need to be avoided."

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
