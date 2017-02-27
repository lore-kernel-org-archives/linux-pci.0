Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 27 Feb 2017 10:44:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: Using the generic host PCIe driver
Message-ID: <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
MIME-Version: 1.0
In-Reply-To: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 David Daney <david.daney@cavium.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Will Deacon <will.deacon@arm.com>, Thierry Reding <treding@nvidia.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 27, 2017 at 05:14:15PM +0100, Mason wrote:
> On 17/02/2017, Bjorn Helgaas wrote:
> 
> > I don't know anything about your hardware or environment, but I highly
> > encourage you to use [...] generic DT (drivers/pci/host/pci-host-generic.c)
> > instead of writing a custom host controller driver.
> > 
> > The native drivers in drivers/pci/host are a huge maintenance hassle
> > for no real benefit.
> >
> > You're right that the programming model of the host bridge itself is
> > not specified by PCI specs, so it's impossible to have a generic
> > driver that can manage it completely by itself.
> > 
> > If you have firmware that initializes the bridge and tells the OS what
> > the windows are (bus numbers, memory space, I/O space) and where the
> > PCIe-specified ECAM space is, a generic driver can take it from there.
> 
> I am currently trying the approach suggested by Bjorn.
> 
> This is what my DT node currently looks like:
> 
> 		pcie@50000000 {
> 			compatible = "pci-host-ecam-generic";
> 			reg = <0x50000000 0x200000>;
> 			device_type = "pci";
> 			bus-range = <0>, <1>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			#interrupt-cells = <1>;
> 			/* BUS_ADDRESS(3)  CPU_PHYSICAL(1)  SIZE(2) */
> 			ranges = <0x02000000 0x0 0xa0000000  0xa0000000  0x0 0x00100000>;
> 		};
> 
> (I am aware that interrupt specs are missing, but I hope this
> is not a problem at an early stage.)
> 
> I.e. the configuration space is at 0x5000_0000
> (so bus_0 at 0x5000_0000, and bus_1 at 0x5010_0000)
> 
> And I defined a 32-bit non-prefetchable memory space at 0xa0000000
> 
> Question 1:
> Is there any reason to map CPU address 0xa0000000 anywhere else than
> PCI bus address 0xa0000000?

Not really.  Large systems with multiple host bridges might map things
differently so they can use the same 32-bit bus addresses on several
root buses.  But if you only have one host bridge, that's not
necessary.

> Now, this host controller is revision 1, and as such contains several
> "interesting" bugs. How can I work around them in software?
> 
> 
> Bug #1
> 
> The controller reports an incorrect class. It is a bridge, but it
> reports class = 0x048000
> 
> AFAICT, tegra had a similar problem, and the solution seems to be
> to define a DECLARE_PCI_FIXUP_EARLY hook:
> 
> /* Root complex reports incorrect device class */
> static void tango_pcie_fixup_class(struct pci_dev *dev)
> {
> 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> }
> DECLARE_PCI_FIXUP_EARLY(0x1105, 0x8758, tango_pcie_fixup_class);
> 
> Is that the correct way to work around bug #1

That seems fine, at least for now.

> Bug #2
> 
> Bus 0 cannot be enumerated, because it reports garbage data for
> devices and functions other than 0, i.e. only 0/0/0 works.
> 
> How do I work around that issue?

There are several drivers that provide their own "ECAM-like" config
accessors.  Look at "struct pci_ecam_ops" structures, e.g.,
hisi_pcie_ops, pci_thunder_ecam_ops, xgene_v1_pcie_ecam_ops, etc.

You can also work around Bug #1 in a custom accessor instead of a
quirk.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
