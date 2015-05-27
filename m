Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55661F71.3090100@amd.com>
Date: Wed, 27 May 2015 14:48:01 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	"yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
	Chris Zankel <chris@zankel.net>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"Lucas Stach" <l.stach@pengutronix.de>,
	Simon Horman <horms@verge.net.au>,
	"Minghuan Lian" <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [RFC/RFT PATCH] PCI: move pci_read_bridge_bases to the generic
 PCI layer
References: <1432214067-2752-1-git-send-email-lorenzo.pieralisi@arm.com>
 <5565F40C.8010004@amd.com> <20150527175447.GA7914@red-moon>
In-Reply-To: <20150527175447.GA7914@red-moon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/27/2015 12:54 PM, Lorenzo Pieralisi wrote:
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> > >index 062fee6..335d9f2 100644
>>> > >--- a/drivers/pci/probe.c
>>> > >+++ b/drivers/pci/probe.c
>>> > >@@ -453,7 +453,11 @@ void pci_read_bridge_bases(struct pci_bus *child)
>>> > >   	struct resource *res;
>>> > >   	int i;
>>> > >
>>> > >-	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
>>> > >+	/*
>>> > >+	 * If it is not a PCI bridge there is nothing to read
>>> > >+	 */
>>> > >+	if (pci_is_root_bus(child) || !dev ||
>>> > >+		!((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI))
>>> > >   		return;
>>> > >
>>> > >   	dev_info(&dev->dev, "PCI bridge to %pR%s\n",
>>> > >@@ -1878,6 +1882,11 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
>>> > >   	 * all PCI-to-PCI bridges on this bus.
>>> > >   	 */
>>> > >   	if (!bus->is_added) {
>>> > >+		/*
>>> > >+		 * Read and initialize bridge resources.
>>> > >+		 */
>>> > >+		pci_read_bridge_bases(bus);
>>> > >+
>>> > >   		dev_dbg(&bus->dev, "fixups for bus\n");
>>> > >   		pcibios_fixup_bus(bus);
>>> > >   		bus->is_added = 1;
>>> > >
>> >
>> >So, I have tested the patch on ARM64 system w/ PROBE_ONLY mode, and
>> >noticed that we are calling pci_read_bridge_bases() after adding the
>> >devices on the slots. This is not soon enough since the downstream
>> >devices still failing to claim resources.
>> >
>> >However, do you think we can move pci_read_bridge_bases() before the
>> >pci_scan_slot() loop?
> Right, how about moving it to pci_scan_bridge() before calling the
> respective pci_scan_child_bus() ? I think it belongs there anyway.
>
> Thanks,

That seems reasonable. I test putting it here in pci_scan_bridge(),
and it works.

....
	child = pci_find_bus(pci_domain_nr(bus), secondary);
	if (!child) {
		child = pci_add_new_bus(bus, dev, secondary);
		if (!child)
			goto out;
		child->primary = primary;
		pci_bus_insert_busn_res(child, secondary, subordinate);
		child->bridge_ctl = bctl;
		pci_read_bridge_bases(child);
	}

	cmax = pci_scan_child_bus(child);
.....

Thanks,
Suravee
	


