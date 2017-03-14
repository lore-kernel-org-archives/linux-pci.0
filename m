Return-Path: <SRS0=9UDy=2X=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=9UDy=2X=free.fr=slash.tmp@kernel.org>
Subject: Re: Neophyte questions about PCIe
From: Mason <slash.tmp@free.fr>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
Message-ID: <94b3c89c-b116-288f-7530-15cc2611f425@free.fr>
Date: Tue, 14 Mar 2017 15:00:11 +0100
MIME-Version: 1.0
In-Reply-To: <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 10/03/2017 18:49, Mason wrote:

> /* Root complex reports incorrect device class */
> static void tango_pcie_fixup_class(struct pci_dev *dev)
> {
> 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> }

Gen1 controller reports class/rev = 0x04800001
Gen2 controller reports class/rev = 0x06000001

#define PCI_CLASS_BRIDGE_HOST		0x0600
#define PCI_CLASS_BRIDGE_ISA		0x0601
#define PCI_CLASS_BRIDGE_EISA		0x0602
#define PCI_CLASS_BRIDGE_MC		0x0603
#define PCI_CLASS_BRIDGE_PCI		0x0604
#define PCI_CLASS_BRIDGE_PCMCIA		0x0605
#define PCI_CLASS_BRIDGE_NUBUS		0x0606
#define PCI_CLASS_BRIDGE_CARDBUS	0x0607
#define PCI_CLASS_BRIDGE_RACEWAY	0x0608
#define PCI_CLASS_BRIDGE_OTHER		0x0680

My fixup replaces 0x048000 with 0x060400.

	0x060400 != 0x060000

Which is correct:
PCI_CLASS_BRIDGE_HOST or PCI_CLASS_BRIDGE_PCI?

Naively, I would expect Host/PCI bridge to be more correct
for a root complex.

Regards.
