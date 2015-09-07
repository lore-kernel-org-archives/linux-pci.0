Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49967 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbbIGJMZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Sep 2015 05:12:25 -0400
Date: Mon, 7 Sep 2015 10:12:30 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
Message-ID: <20150907091230.GB29293@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
 <20150902174716.GA6305@red-moon>
 <20150902203250.GB829@google.com>
 <20150903100115.GA15308@red-moon>
 <20150903162140.GG829@google.com>
 <20150904141903.GA22997@red-moon>
 <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
 <20150904164412.GD22997@red-moon>
 <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 05, 2015 at 12:53:48AM +0100, Yinghai Lu wrote:
> On Fri, Sep 4, 2015 at 9:44 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Fri, Sep 04, 2015 at 05:00:35PM +0100, Yinghai Lu wrote:
> >
> > The problem here is not the last retry, it is the first bridge scan.
> >
> > By moving pci_read_bridge_bases() to core PCI code, if we do not
> > vet the bridge apertures (ie claim them and reset them if the claiming
> > fails) we end up calling (on ARM) __pci_bus_size_bridges() with apertures
> > that can have sizes != 0, which does not make any sense since we are calling
> > __pci_bus_size_bridges() to *discover* what the aperture size should
> > be on first bridge scan, correct ?
> 
> for x86, in pcibios_allocate_bridge_resources(), we do validate
> the bridge resources, and reset size to 1 (strange ?!).

Yes, strange, but there is even a special case in calculate_memsize()
to handle that :) it seems !

> and they are called before pci_asssign_unassigned_resources()
> 
> so arch ARM would support pcibios_allocate_bridge_resources or other
> call to do the same thing?

I could do that, but:

1) Bjorn does not like this approach (ie it has nothing arch specific
   in it - actually zeroing the bridge size on first scan seems to be an
   implicit requirement of __pci_bus_size_bridges() and that's not
   documented)
2) I still do not understand why on first bridge scan we should care
   about the old bridge size. If the bridge windows are claimed
   __pci_bus_size_bridges() ignore them (and that's right). If they
   are not claimed (ie they are free) why, on first scan, would the old
   size matter ? I really do not like the implicit requirement that
   forces the bridge aperture size to be 0 (or 1 ;-)) on first scan,
   we end up zeroing it in arch code where it should not really matter.
   Is there a reason why old size matters on first bridge scan ? I guess
   it has to do with hotplug, but I need your input on this.
   I agree we have to find a way to detect the *first* scan (there are
   various ways of doing that - possibly a "pass" parameter or we can
   rely on resource flags to detect that), question is if we should.

> wonder some arches even claim fails, they still does not want you to
> reset it.

Yes, that's what I noticed too, I have no idea how they work, but IMO
they should be patched too (ia64 is an example). If the bridge size
read from pci_read_bridge_bases() is erroneous its size is kept even
when we try to reassign it (as this regression showed) so I guess
on those archs this bug just does not trigger because the bridge
apertures are programmed in FW in a *saner* way.

On platforms where we want to reassign everything the current approch
just does not make sense (ie keeping the old size on first bridge scan)
but please shout if there is a reason for that, I would like to put
together a fix asap.

Thank you !
Lorenzo
