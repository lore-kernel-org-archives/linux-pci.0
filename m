Return-Path: <SRS0=dMGe=Y7=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=dMGe=Y7=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Tue, 17 Jan 2017 21:02:58 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170117210258.GH27312@n2100.armlinux.org.uk>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170117151444.GE22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170117152548.GB27312@n2100.armlinux.org.uk>
 <20170117174649.GA11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117175115.GD27312@n2100.armlinux.org.uk>
 <20170117175728.GE27312@n2100.armlinux.org.uk>
 <20170117181458.GB11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117193414.GG27312@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170117193414.GG27312@n2100.armlinux.org.uk>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2017 at 07:34:14PM +0000, Russell King - ARM Linux wrote:
> Uwe, can you try:
> 
> setpci -s <whatever-the-id-of-the-root-is-it's-blanked-out-in-the-above> \
> 	0x50.w=0x60
> 
> and see whether it remains alive (you can check by reading the root
> register 0x52.w - bit 12 should be set once bit 11 clears again.

For reference, this I got wrong...

0xf1041a04 bit 0 indicates link status (0 = link up, 1 = link down).

> If that's successful, maybe setting the common clock bit on the PCIe
> device is what's causing the problem, in which case:
> 
> setpci -s 02:00.0 0x80.w=0x40
> setpci -s <whatever-the-id-of-the-root-is-it's-blanked-out-in-the-above> \
> 	0x50.w=0x60

Having worked with Uwe over IRC, it seems that any request to retrain
causes the link to go down, either with or without the common clock bit
set:

# setpci -s 2.0 0x50.w=0x60
# setpci -s 2.0 0x52.w
0011
# memtool md 0xf1041a04+4
f1041a04: 00010201
... reboot ...
# setpci -s 2.0 0x50.w=0x20
# memtool md 0xf1041a04+4
f1041a04: 00010201

which doesn't point towards ASPM itself, but the problem is caused by
a side effect of ASPM's setup code which always triggers a retrain.

Bit 5 in that register is documented (at least in the Armada 370 docs
and Armada XP docs I have) as:

5  RetrnLnk  RW    Retrain Link
             0x0   This bit forces the device to initiate link retraining.
                   Always returns 0 when read.
                   NOTE: If configured as an Endpoint, this field is
                   reserved and has no effect.

Bjorn, are you aware of similar situations where a request for the PCIe
link to be retrained causes it to fail?

Here, on my Armada 388, I can request a link retrain with or without the
common clock bit set and everything's happy (this is with an ASM1062 SATA
mini-PCIe card):

root@clearfog21:~# setpci -s 2.0 0x50.w=0x60
root@clearfog21:~# setpci -s 2.0 0x52.w
0012
root@clearfog21:~# /shared/bin/devmem2 0xf1041a04
Value at address 0xf1041a04: 0x00010100
root@clearfog21:~# setpci -s 2.0 0x50.w=0x20
root@clearfog21:~# setpci -s 2.0 0x52.w
0012
root@clearfog21:~# /shared/bin/devmem2 0xf1041a04
Value at address 0xf1041a04: 0x00010100

One curious observation I have noticed on Armada 388 is this behaviour:

root@clearfog21:~# setpci -s 2.0 0x50.l=0xffff0040 0x50.l 0x50.l=0x0fff0040 0x50.l
10120040
00120040

bit 28 is writable, which goes against the 370/XP docs:

28 SltClkCfg  RO  Slot Clock Configuration
              0x1 0 = Independent: The device uses an independent clock,
                      irrespective of the presence of a reference clock
                      on the connector.
                  1 = Reference: The device uses the reference clock that
                      the platform provides.

It seems that this bit is _not_ read-only.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
