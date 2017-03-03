Return-Path: <SRS0=6Mcr=2M=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=6Mcr=2M=free.fr=slash.tmp@kernel.org>
Subject: Re: Using the generic host PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>, David Daney <david.daney@cavium.com>,
 Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
 <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
Date: Fri, 3 Mar 2017 13:44:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 01/03/2017 22:57, Bjorn Helgaas wrote:

> On Wed, Mar 01, 2017 at 07:05:26PM +0100, Mason wrote:
> 
>> Another thing I don't understand... According to this reference:
>> http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
>>
>> The "ranges" prop starts with:
>>
>>     phys.hi  cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
>>     phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
>>     phys.low cell: llllllll llllllll llllllll llllllll
>>
>> So I thought it might be possible to specify bbbbbbbb = 0x01
>> to mean "I want to assign memory only to bus 1, don't assign
>> any memory to bus 0". Am I mistaken?
> 
> I don't really understand the "bbbbbbbb" field in that range.  The
> bridge has a "bus-ranges" property that defines the PCI bus numbers
> below the bridge.  As I understand it, the first number in bus-ranges
> is the root bus (the bus immediately below the host bridge).  Is
> "bbbbbbbb" supposed to be identical to the that root bus number?  If
> so, it seems redundant, so why does the "bbbbbbbb" field even exist?
> 
> If "bbbbbbbb" can be different from the root bus number, I don't know
> what it means.  The host bridge translates CPU physical addresses to
> PCI bus address on the root bus (the PCI bus immediately below the
> bridge).  Once on the PCI side, the correspondence of memory addresses
> to bus numbers is controlled completely by PCI-to-PCI bridges,
> independent of what DT contains.

The answer (probably) lies in
PCI Bus Binding to: IEEE Std 1275-1994
Standard for Boot (Initialization Configuration) Firmware, Revision 2.1
[What does "to" mean in "PCI Bus Binding to"? Is it a typo?]

> 12. Use of the "ranges" property
> 
> The "ranges" property of Open Firmware represents how address
> transformation is done across bus bridges. The "ranges" property
> conveys this information for PCI, but the use of the property is not
> as straightforward as on some other busses.
> 
> In particular, the phys.hi fields of the child address spaces in the
> "ranges" property for PCI does not contain the same information as
> "reg" property entries within PCI nodes. The only information that is
> present in "ranges" phys.hi entries are the non-relocatable,
> prefetchable and the PCI address space bits for which the entry
> applies. I.e., only the n, p and ss bits are present; the bbbbbbbb,
> ddddd, fff and rrrrrrrr fields are 0.
> 
> When an address is to be mapped through a PCI bus bridge node, the
> phys.hi value of the address to be mapped and the child field of a
> "ranges" entry should be masked so that only the ss bits are
> compared. I.e., the only portion of phys.hi that should participate
> in the range determination is the address space indicator (the ss bits).

So my bbbbbbbb = 0x01 attempt was non-sensical (as I expected).

For now, I have "hidden" the root's BAR0 from the system with:

	if (bus->number == 0 && where == PCI_BASE_ADDRESS_0) {
		*val = 0;
		return PCIBIOS_SUCCESSFUL;
	}

Regards.
