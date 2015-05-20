Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 May 2015 22:15:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Julia Lawall <julia.lawall@lip6.fr>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC v1 14/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <alpine.DEB.2.11.1505202209470.4225@nanos>
Message-ID: <alpine.DEB.2.10.1505202215230.2642@hadrien>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com> <alpine.DEB.2.11.1505201750280.4225@nanos>
 <alpine.DEB.2.10.1505202155420.2642@hadrien> <alpine.DEB.2.11.1505202209470.4225@nanos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wed, 20 May 2015, Thomas Gleixner wrote:

> On Wed, 20 May 2015, Julia Lawall wrote:
> > On Wed, 20 May 2015, Thomas Gleixner wrote:
> > > The purpose of the script is to:
> > >
> > >     1) Identify all handlers
> > >
> > >        This can be done by analyzing the arguments of
> > >
> > >        	    __irq_set_handler()
> > > 	    irq_set_handler()
> > > 	    irq_set_chained_handler()
> > > 	    irq_alloc_generic_chip()
> > > 	    irq_alloc_domain_generic_chips()
> > > 	    irq_set_chip_and_handler_name()
> > > 	    irq_set_chip_and_handler()
> > > 	    __irq_set_handler_locked()
> > > 	    __irq_set_chip_handler_name_locked()
> > > 	    __irq_set_preflow_handler()
> > >
> > > 	If the argument is a function local to the file step 2 can
> > > 	take place.
> > >
> > > 	If it's a extern function, then the script should at least
> > > 	print out the function names. Those are in most of the cases
> > > 	the generic flow handler functions.
> >
> > Looks reasonable.
>
> Good.
>
> > >     2) Check the handlers whether they use the irq argument
> > >
> > >        For those which do:
> > >
> > >           Check whether they just use the argument instead of a local
> > >        	  variable, i.e. the first usage is an assignment. In that
> > >        	  case rename the argument to __irq and add a local variable
> > >
> > > 	      unsigned int irq;
> > >
> > > 	  If they use the irq argument for some computation or as
> > >        	  argument to another function, then you need to rename the
> > >        	  argument as well and add:
> > >
> > >        	      unsigned int irq = irq_get_desc_irq(desc);
> >
> > Scripting this may be a little complex, because the variable can be used
> > in one way in one execution path (eg if branch) and another way (or not at
> > all) in another.  Let me know if help is needed.
>
> I feared that, but at least identifying all functions, where the irq
> argument is used inside the function itself is really key for such a
> massive rework.

It's not impossible, but I may need to think a bit how best to do it.

julia
