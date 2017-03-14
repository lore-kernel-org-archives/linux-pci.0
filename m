Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 14 Mar 2017 16:46:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: Neophyte questions about PCIe
Message-ID: <20170314214631.GA2021@bhelgaas-glaptop.roam.corp.google.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
 <94b3c89c-b116-288f-7530-15cc2611f425@free.fr>
 <912c26d5-835f-9f39-73ba-db561b5bcffa@free.fr>
MIME-Version: 1.0
In-Reply-To: <912c26d5-835f-9f39-73ba-db561b5bcffa@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 14, 2017 at 04:54:00PM +0100, Mason wrote:
> On 14/03/2017 15:00, Mason wrote:
> 
> > On 10/03/2017 18:49, Mason wrote:
> > 
> >> /* Root complex reports incorrect device class */
> >> static void tango_pcie_fixup_class(struct pci_dev *dev)
> >> {
> >> 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> >> }
> > 
> > Gen1 controller reports class/rev = 0x04800001
> > Gen2 controller reports class/rev = 0x06000001
> > 
> > #define PCI_CLASS_BRIDGE_HOST		0x0600
> > #define PCI_CLASS_BRIDGE_ISA		0x0601
> > #define PCI_CLASS_BRIDGE_EISA		0x0602
> > #define PCI_CLASS_BRIDGE_MC		0x0603
> > #define PCI_CLASS_BRIDGE_PCI		0x0604
> > #define PCI_CLASS_BRIDGE_PCMCIA		0x0605
> > #define PCI_CLASS_BRIDGE_NUBUS		0x0606
> > #define PCI_CLASS_BRIDGE_CARDBUS	0x0607
> > #define PCI_CLASS_BRIDGE_RACEWAY	0x0608
> > #define PCI_CLASS_BRIDGE_OTHER		0x0680
> > 
> > My fixup replaces 0x048000 with 0x060400.
> > 
> > 	0x060400 != 0x060000
> > 
> > Which is correct:
> > PCI_CLASS_BRIDGE_HOST or PCI_CLASS_BRIDGE_PCI?
> > 
> > Naively, I would expect Host/PCI bridge to be more correct
> > for a root complex.
> 
> But that's very likely wrong, since the code in Linux does:
> 
> 	switch (dev->hdr_type) {		    /* header type */
> 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
> 		if (class != PCI_CLASS_BRIDGE_PCI)
> 			goto bad;
> 		/* The PCI-to-PCI bridge spec requires that subtractive
> 		   decoding (i.e. transparent) bridge must have programming
> 		   interface code of 0x01. */
> 
> So a class of PCI_CLASS_BRIDGE_HOST would error out, I think.
> Does this mean I need to fixup Gen2 as well?
> (Since it reports 0x060000)

Header Type 1 (PCI_HEADER_TYPE_BRIDGE) identifies PCI-to-PCI bridges
(see PCI spec r3.0, sec 6.1).  These devices use the type 1
configuration header (PCI-to-PCI Bridge spec r1.2, sec 3.2) and they
exist on a primary PCI bus and forward transactions between that bus
and a secondary PCI bus.  The PCI core controls the memory, I/O, and
prefetchable memory windows between the primary and secondary buses
using the window registers in the type 1 header.

So I guess if this device has a type 1 header, it should use
PCI_CLASS_BRIDGE_PCI; otherwise use PCI_CLASS_BRIDGE_HOST.

I don't know the topology of your hardware, but normally a Root
Complex itself is not a PCI-to-PCI bridge.  It usually *contains*
several Root Ports, which appear to be on the root PCI bus and act as
bridges to a secondary bus.  The RC might appear as a type 0 device
but the programming model is not specified.  The Root Ports would be
type 1 devices like standard PCI-to-PCI bridges (PCIe spec r3.0, sec
1.3.1 and 1.4).

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
