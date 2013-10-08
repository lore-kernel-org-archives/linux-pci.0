Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34776 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab3JHRNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 13:13:48 -0400
Date: Tue, 8 Oct 2013 18:13:44 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC] Architecture independent pcibios?
Message-ID: <20131008171343.GB25606@e102652-lin.cambridge.arm.com>
References: <20131008144211.GA25231@e102652-lin.cambridge.arm.com>
 <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 08, 2013 at 05:32:57PM +0100, Bjorn Helgaas wrote:
> [+cc Grant, Rob, devicetree list]
> 
> On Tue, Oct 8, 2013 at 8:42 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > Hello,
> >
> > I am working on adding PCIe support for a new architecture and looking
> > at various existing implementations of pcibios functions I've realised
> > that some architectures share a lot of common code. As I don't like to
> > repeat the pattern again without any good reasons, I am wondering if
> > there is any appetite for carving out those common functions into
> > a generic place under drivers/pci/pcibios.c where they can be reused.
> >
> > Things that I am specifically looking at are pcibios_{alloc,free}_controller,
> > pci_process_bridge_OF_ranges and anything that will make adding support
> > for PCI/PCIe in a new architecture easier. Candidates for promoting
> > to a generic place are the functions found in both powerpc and microblaze
> > as they seem to be mostly identical, they support DT bindings and are
> > 64bits ready.
> 
> I'm very much in favor of unifying code to reduce duplication across
> architectures.
> 
> In general, the pcibios_*() interfaces are things used by the PCI core
> (drivers/pci) but implemented by the architecture.  The specific cases
> you mentioned are not actually used by the PCI core, so my inclination
> would be to name them something else and possibly put them somewhere
> other than drivers/pci.

There are at least a handful of architectures that seem to share the same
implementation for most (all?) of the pcibios_*() functions. (PowerPC and
microblaze the most obvious offenders, x86 to a certain extent).

> 
> I wonder if pci_process_bridge_OF_ranges() would fit somewhere in
> drivers/of?  The implementations I looked at are mostly concerned with
> parsing OF resources, and they don't have much to do with PCI
> directly.

Andrew Murray did sent a patch that was placing pci_process_bridge_OF_ranges()
in the drivers/of. I can update that, as I have taken over his work.

> 
> pcibios_alloc_controller() is implemented by microblaze, powerpc, and
> xtensa.  Each of those arches defines its own "struct pci_controller",
> so it won't be completely trivial to unify this.  I tried to start
> some unification with the "struct pci_host_bridge" in the core, but
> haven't made much progress there.

Do you have anything that you could share? I would pretty much like to take
on that as well, as I don't want to create yet another
"struct pci_controller." BTW, powerpc and microblaze again share a very
similarly looking structure.

Best regards,
Liviu

> 
> Bjorn
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

