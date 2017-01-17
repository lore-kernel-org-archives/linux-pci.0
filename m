Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 17 Jan 2017 16:22:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170117222229.GA6534@bhelgaas-glaptop.roam.corp.google.com>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170117151444.GE22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170117152548.GB27312@n2100.armlinux.org.uk>
 <20170117174649.GA11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117175115.GD27312@n2100.armlinux.org.uk>
 <20170117175728.GE27312@n2100.armlinux.org.uk>
 <20170117181458.GB11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117193414.GG27312@n2100.armlinux.org.uk>
 <20170117210258.GH27312@n2100.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20170117210258.GH27312@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
 David Daney <david.daney@cavium.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc David]

On Tue, Jan 17, 2017 at 09:02:58PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 17, 2017 at 07:34:14PM +0000, Russell King - ARM Linux wrote:
> > Uwe, can you try:
> > 
> > setpci -s <whatever-the-id-of-the-root-is-it's-blanked-out-in-the-above> \
> > 	0x50.w=0x60
> > 
> > and see whether it remains alive (you can check by reading the root
> > register 0x52.w - bit 12 should be set once bit 11 clears again.
> 
> For reference, this I got wrong...
> 
> 0xf1041a04 bit 0 indicates link status (0 = link up, 1 = link down).
> 
> > If that's successful, maybe setting the common clock bit on the PCIe
> > device is what's causing the problem, in which case:
> > 
> > setpci -s 02:00.0 0x80.w=0x40
> > setpci -s <whatever-the-id-of-the-root-is-it's-blanked-out-in-the-above> \
> > 	0x50.w=0x60
> 
> Having worked with Uwe over IRC, it seems that any request to retrain
> causes the link to go down, either with or without the common clock bit
> set:
> 
> # setpci -s 2.0 0x50.w=0x60
> # setpci -s 2.0 0x52.w
> 0011
> # memtool md 0xf1041a04+4
> f1041a04: 00010201
> ... reboot ...
> # setpci -s 2.0 0x50.w=0x20
> # memtool md 0xf1041a04+4
> f1041a04: 00010201
> 
> which doesn't point towards ASPM itself, but the problem is caused by
> a side effect of ASPM's setup code which always triggers a retrain.
> 
> Bit 5 in that register is documented (at least in the Armada 370 docs
> and Armada XP docs I have) as:
> 
> 5  RetrnLnk  RW    Retrain Link
>              0x0   This bit forces the device to initiate link retraining.
>                    Always returns 0 when read.
>                    NOTE: If configured as an Endpoint, this field is
>                    reserved and has no effect.
> 
> Bjorn, are you aware of similar situations where a request for the PCIe
> link to be retrained causes it to fail?

The only one that comes to mind is this patch from David (CC'd) that
avoids ASPM-related retrains when we know the link doesn't support ASPM:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e53f9a28bee3

Side note: it looks like we don't use the recommended retrain
algorithm in the implementation note about avoiding race conditions in 
PCIe r3.0, sec 7.8.7.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
