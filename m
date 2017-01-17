Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 17 Jan 2017 11:46:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170117174649.GA11063@bhelgaas-glaptop.roam.corp.google.com>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170117151444.GE22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170117152548.GB27312@n2100.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20170117152548.GB27312@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
 Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2017 at 03:25:49PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 17, 2017 at 09:14:44AM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 11, 2017 at 08:49:46PM +0100, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > > =

> > > on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
> > > ath10k driver fails to bind to the matching hardware if CONFIG_PCIEAS=
PM
> > > is enabled:
> > > =

> > > # dmesg | grep ath
> > > [    7.207770] ath10k_pci 0000:02:00.0: Refused to change power state=
, currently in D3
> > > [    7.237955] ath10k_pci 0000:02:00.0: failed to wake up device : -1=
10
> > > [    7.238146] ath10k_pci: probe of 0000:02:00.0 failed with error -1=
10
> > > =

> > > if however PCIEASPM is off, the driver probes correctly and the ath10k
> > > adapter works fine.
> > > =

> > > I wonder if someone has an idea what needs to be done to fix this
> > > problem. (OK, I could disable PCIEASPM, but I'd like to have a soluti=
on
> > > for a distribution kernel where I think PCIEASPM=3Dy is sensible in
> > > general.)
> > =

> > Can somebody confirm that this system (Marvell Armada 385-based Turris
> > Omnia) does actually support ASPM in hardware?
> =

> What sort of "hardware" are you referring to?
> =

> From my reading of the specs, ASPM doesn't require any external hardware.
> It's all done inside the PCIe root hub and PCIe device.

Right.  My question is just whether we know that the Marvell PCIe root
hub hardware works correctly with respect to ASPM.  The PCI core isn't
doing anything special for Marvell, so problems here are likely to be
either in the Marvell hardware or in the pci-mvebu.c driver.

> The PCIe spec specifically prohibits cutting power supplies and clocks to
> PCIe devices during L0s and L1, with the exception that the PCIe clock may
> be stopped in L1 if CLKREQ# is deasserted.  CLKREQ# handling generally
> requires GPIO usage, and as there's no support for that, there's no suppo=
rt
> for stopping the PCIe clock in L1.  We do the correct thing there,
> preventing the PCI_EXP_LNKCTL_CLKREQ_EN bit being set.
> =

> That all said, it would probably be a good idea to throw some printk()
> debugging into mvebu_sw_pci_bridge_write() and mvebu_sw_pci_bridge_read()
> so we can see what's going on at that level, and maybe also some debug
> in mvebu_pcie_hw_wr_conf() and mvebu_pcie_hw_rd_conf() so we can see
> what's happening at the PCIe device too.

Uwe has already done that; the dmesg logs including this
instrumentation are at
https://bugzilla.kernel.org/show_bug.cgi?id=3D192441

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
