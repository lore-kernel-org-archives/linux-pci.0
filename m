Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Oct 2014 16:01:49 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Robert Richter <rric@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Goutham <sgoutham@cavium.com>
Subject: Re: [PATCH 3/6] pci, thunder: Add PCIe host controller devicetree
 bindings
Message-ID: <20141007150149.GW4652@e106497-lin.cambridge.arm.com>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-4-git-send-email-rric@kernel.org>
 <3082935.e3X4GsVUDn@wuerfel>
 <20141007142744.GE31556@rric.localhost>
MIME-Version: 1.0
In-Reply-To: <20141007142744.GE31556@rric.localhost>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 07, 2014 at 03:27:44PM +0100, Robert Richter wrote:
> On 24.09.14 18:06:04, Arnd Bergmann wrote:
> > > +               compatible = "cavium,thunder-pcie";
> > > +               device_type = "pci";
> > > +               msi-parent = <&its>;
> > > +               bus-range = <0 255>;
> > > +               #size-cells = <2>;
> > > +               #address-cells = <3>;
> > > +               reg = <0x8480 0x00000000 0 0x10000000>;  /* Configuration space */
> > > +               ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>, /* mem ranges */
> > > +                       <0x03000000 0x8300 0x00000000 0x8300 0x00000000 0x80 0x00000000>,
> > > +                       <0x03000000 0x87e0 0x00000000 0x87e0 0x00000000 0x01 0x00000000>;
> > > +        };
> > 
> > If you claim the entire 0-255 bus range, I think you should also
> > specify a domain, otherwise it's not predictable which domain you
> > get.
> 
> Liviu's code assigns a unique id to the domain if missing, see
> of_pci_get_domain_nr(). So I don't think we need to add a "pci-domain"
> property here.

Not anymore! That function is gone in v12 onwards. What is in -next has
a new function called of_get_pci_domain_nr() (slight name change) but
that only gets the value set in the "linux,pci-domain" property of the
device node. It is the choice of the host bridge driver to use that
function or to use pci_get_new_domain_nr() which *does* generate an
unique id every time it gets called.

> 
> Liviu's DT implementation that assigns a unique number differs a bit
> from ACPI which states: "If _SEG [aka domain number] does not exist,
> OSPM assumes that all PCI bus segments are in PCI Segment Group 0."
> 
> Maybe of_pci_get_domain_nr() should be similar to ACPI. If there are
> multiple root bridges, the "pci-domain" property could be forced
> instead.

Indeed. But the enforcing is left as an exercise to the host bridge
implementor for the moment.

Best regards,
Liviu

> 
> -Robert
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

