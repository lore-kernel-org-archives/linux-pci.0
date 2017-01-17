Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 17 Jan 2017 12:14:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170117181458.GB11063@bhelgaas-glaptop.roam.corp.google.com>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170117151444.GE22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170117152548.GB27312@n2100.armlinux.org.uk>
 <20170117174649.GA11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117175115.GD27312@n2100.armlinux.org.uk>
 <20170117175728.GE27312@n2100.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20170117175728.GE27312@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2017 at 05:57:28PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 17, 2017 at 05:51:16PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 17, 2017 at 11:46:49AM -0600, Bjorn Helgaas wrote:
> > > Uwe has already done that; the dmesg logs including this
> > > instrumentation are at
> > > https://bugzilla.kernel.org/show_bug.cgi?id=192441
> > 
> > Grr, <swears about SSL incompatibilities>... wget's the URL and then
> > uses elinks on it...
> > 
> > Umm, not quite.  He's done mvebu_pcie_hw_wr_conf() and mvebu_pcie_hw_rd_conf()
> > but not the bridge from the descriptions given on the attachments.
> > Obviously, it's going to be a lot of work to manufacture the links to
> > look at each attachment to thoroughly check, so I'm not going to do
> > that given quite how broken SSL crap is today.
> > 
> > (Try installing elinks and pointing it at the above URL.)
> 
> Oh, and looking at some of the debug that's been added:
> 
> [    3.646322] mvebu_pcie_rd_conf(where=16, size=4, val=3892314116) => 0
> [    3.646325] mvebu_pcie_wr_conf(where=16, size=4, val=4294967295)
> [    3.646329] mvebu_pcie_rd_conf(where=16, size=4, val=4292870148) => 0
> [    3.646332] mvebu_pcie_wr_conf(where=16, size=4, val=3892314116)
> 
> Please print register values in HEX, not decimal.  Same for register
> addresses.  Hex is the normal base to print this information, which
> the human brain can easily comprehend and translate to bits in a
> register.  Decimal values are useless and might as well be encrypted.

The instrumentation has evolved a bit since then.  Latest is below (could
still use improvement, but it does address your suggestions above):

https://bugzilla.kernel.org/attachment.cgi?id=251691 (CONFIG_PCIEASPM=y)
https://bugzilla.kernel.org/attachment.cgi?id=251701 (CONFIG_PCIEASPM not set)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
