Return-Path: <SRS0=dMGe=Y7=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=dMGe=Y7=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Tue, 17 Jan 2017 19:34:14 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170117193414.GG27312@n2100.armlinux.org.uk>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170117151444.GE22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170117152548.GB27312@n2100.armlinux.org.uk>
 <20170117174649.GA11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117175115.GD27312@n2100.armlinux.org.uk>
 <20170117175728.GE27312@n2100.armlinux.org.uk>
 <20170117181458.GB11063@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170117181458.GB11063@bhelgaas-glaptop.roam.corp.google.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2017 at 12:14:58PM -0600, Bjorn Helgaas wrote:
> The instrumentation has evolved a bit since then.  Latest is below (could
> still use improvement, but it does address your suggestions above):
> 
> https://bugzilla.kernel.org/attachment.cgi?id=251691 (CONFIG_PCIEASPM=y)
> https://bugzilla.kernel.org/attachment.cgi?id=251701 (CONFIG_PCIEASPM not set)

Thanks.

The point at which things die is when we request a link retrain - I've
augmented the trace with the register names:

pci 0000:02:00.0: rd where=0x074 size=4 val=0x8dc1 (hw)         EXP_DEVCAP

pcie_aspm_configure_common_clock():

pci 0000:02:00.0: rd where=0x082 size=2 val=0x1011 (hw)         EXP_LNKSTA
pci 0000:??:??.?: rd where=0x052 size=2 val=0x1011 (sw)         EXP_LNKSTA
pci 0000:02:00.0: rd where=0x080 size=2 val=0x0 (hw)            EXP_LNKCTL
pci 0000:02:00.0: wr where=0x080 size=2 val=0x40 (hw)           EXP_LNKCTL

Enables common clock configuration on the device.

pci 0000:??:??.?: rd where=0x050 size=2 val=0x40 (sw)           EXP_LNKCTL
pci 0000:??:??.?: wr where=0x050 size=2 val=0x40 (sw)           EXP_LNKCTL

Common clock configuration is already enabled on the root.

pci 0000:??:??.?: rd where=0x050 size=4 val=0x10110040 (sw)     EXP_LNKCTL
pci 0000:??:??.?: wr where=0x050 size=2 val=0x60 (sw)           EXP_LNKCTL

Here we request the train, setting bit 5 in the link control
register.

pci 0000:??:??.?: rd where=0x050 size=4 val=0x110040 (sw)       EXP_LNKCTL
pci 0000:??:??.?: rd where=0x052 size=2 val=0x811 (sw)          EXP_LNKSTA
pci 0000:??:??.?: rd where=0x052 size=2 val=0x811 (sw)          EXP_LNKSTA

Waiting for the link training bit to clear...

pci 0000:??:??.?: rd where=0x052 size=2 val=0x11 (sw)           EXP_LNKSTA

and it's cleared here - but note that the link is still down.

pci 0000:??:??.?: rd where=0x04c size=4 val=0x3ac12 (sw)        EXP_LNKCAP
pci 0000:??:??.?: rd where=0x050 size=2 val=0x40 (sw)           EXP_LNKCTL

pcie_get_aspm_reg() for the root.

pci 0000:02:00.0: rd where=0x07c size=4 val=0xffffffff (no link)

pcie_get_aspm_reg() for the device (fails).

So, I think the question is... why does asking for a retrain cause
the link to fail and never recover?

Uwe, can you try:

setpci -s <whatever-the-id-of-the-root-is-it's-blanked-out-in-the-above> \
	0x50.w=0x60

and see whether it remains alive (you can check by reading the root
register 0x52.w - bit 12 should be set once bit 11 clears again.

If that's successful, maybe setting the common clock bit on the PCIe
device is what's causing the problem, in which case:

setpci -s 02:00.0 0x80.w=0x40
setpci -s <whatever-the-id-of-the-root-is-it's-blanked-out-in-the-above> \
	0x50.w=0x60

I would imagine would cause the link to go down.  So, the question
this gives us is why the common clock setup is not working on your
platform.  Maybe we need to source the SLC bit in the link status
from DT, though I'd like to understand what's going on here more
first.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
