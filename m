Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45192 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbbINKJS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Sep 2015 06:09:18 -0400
Date: Mon, 14 Sep 2015 11:09:29 +0100
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
Message-ID: <20150914100929.GB18886@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
 <20150902174716.GA6305@red-moon>
 <20150902203250.GB829@google.com>
 <20150903100115.GA15308@red-moon>
 <20150903162140.GG829@google.com>
 <20150904141903.GA22997@red-moon>
 <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
 <20150904164412.GD22997@red-moon>
 <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
 <20150907091230.GB29293@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150907091230.GB29293@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai,

On Mon, Sep 07, 2015 at 10:12:30AM +0100, Lorenzo Pieralisi wrote:
> On Sat, Sep 05, 2015 at 12:53:48AM +0100, Yinghai Lu wrote:
> > On Fri, Sep 4, 2015 at 9:44 AM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Fri, Sep 04, 2015 at 05:00:35PM +0100, Yinghai Lu wrote:
> > >
> > > The problem here is not the last retry, it is the first bridge scan.
> > >
> > > By moving pci_read_bridge_bases() to core PCI code, if we do not
> > > vet the bridge apertures (ie claim them and reset them if the claiming
> > > fails) we end up calling (on ARM) __pci_bus_size_bridges() with apertures
> > > that can have sizes != 0, which does not make any sense since we are calling
> > > __pci_bus_size_bridges() to *discover* what the aperture size should
> > > be on first bridge scan, correct ?
> > 
> > for x86, in pcibios_allocate_bridge_resources(), we do validate
> > the bridge resources, and reset size to 1 (strange ?!).
> 
> Yes, strange, but there is even a special case in calculate_memsize()
> to handle that :) it seems !

Any thoughts on that ? I would like to understand if there is any
reason why on first scan the bridge aperture size is relevant, whereas
in my opinion it should not be, I need your input on that.

Put it differently, I do not see any reason why arch code should
reset the bridge resource on platforms that reassign the whole
PCI config space, if you see any please mention it here.

As I said, ARM is not the only platform affected, MIPS and possibly
Alpha suffer from the same issue and I think it should be fixed
in core code (I think __pci_bus_size_bridges() should ignore the
old aperture size on first scan).

Thanks !
Lorenzo
