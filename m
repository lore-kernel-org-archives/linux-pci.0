Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Mon, 13 Jun 2016 18:11:22 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] implement gpio_pci_platform_pm to put pci device into
 D3cold
Message-ID: <20160613171122.GA29837@red-moon>
References: <20160612203245.66fbd54a@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160612203245.66fbd54a@xhacker>
List-ID: <linux-pci.vger.kernel.org>

Hi Jisheng,

On Sun, Jun 12, 2016 at 08:32:45PM +0800, Jisheng Zhang wrote:
> Dear all,
> 
> I want to solve one problem: we have pcie in a DT based arm64 system,
> now we want to put the device into D3cold when runtime suspended. The
> pcie device could be power down by operating one gpio pin, this is the
> D3cold the platform could support. 
> 
> My solution is to register a gpio_pci_platform_pm with
> pci_set_platform_pm() but the key is how to setup a mapping between
> pci_dev and gpio through DT
> 
> I think this is a general case, could you please kindly give some
> suggestions?

You would like to define an "equivalent" of what exists today
in ACPI (ie ACPI methods like _PSx) through generic DT bindings,
correct ?

It is hard to say what can be really generalized and how without
having first an implementation (so that we can see how this would
map to other systems), if you have some code to share even if it
is an RFC that would help quite a bit.

Question: when you say "I think this is a general case" I wonder,
are you referring to specific drivers in the mainline ?

Thanks,
Lorenzo
