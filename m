Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 24 Jun 2015 23:10:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Julia Lawall <julia.lawall@lip6.fr>
cc: Jiang Liu <jiang.liu@linux.intel.com>,
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
In-Reply-To: <alpine.DEB.2.02.1506132240500.2020@localhost6.localdomain6>
Message-ID: <alpine.DEB.2.11.1506242137070.4037@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com> <alpine.DEB.2.11.1505201750280.4225@nanos>
 <alpine.DEB.2.10.1506131059180.2486@hadrien> <alpine.DEB.2.11.1506131130490.3786@nanos> <alpine.DEB.2.10.1506131603151.2314@hadrien> <alpine.DEB.2.10.1506131652380.2314@hadrien> <557C5F29.7010301@linux.intel.com> <alpine.DEB.2.02.1506132214310.2020@localhost6.localdomain6>
 <alpine.DEB.2.11.1506132230450.3786@nanos> <alpine.DEB.2.02.1506132240500.2020@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 13 Jun 2015, Julia Lawall wrote:
> On Sat, 13 Jun 2015, Thomas Gleixner wrote:
> 
> > On Sat, 13 Jun 2015, Julia Lawall wrote:
> > 
> > > The following are the cases that require some manual attention, either 
> > > because the handler is a local variable or because it is some other kind 
> > > of expression.
> > 
> > yep, found it in the logs already and found a missing search expression:
> > 
> > |
> > gpiochip_set_chained_irqchip@p(e1,e2,e3,\(lih\|ih\|eh\))
> > 
> > This is really impressive work!!!!
> 
> Thanks :)
> 
> I'll add the above pattern, but I guess you already have the results for 
> that case.

Yes.

I did some more experiments and analyzed all functions which have the
signature

[static] void f(T irq, struct irq_desc *desc)

where T is either 'unsigned int' or 'u32'

That throws up a handful of false positives, but those are functions
which are called from a real handler function, so we want to look at
those anyway.

Now where my cocci foo ends is when I try to match both types in the
same rule, i.e. 

@ fun exists @
identifier hf,irq,desc;
typedef u32;
@@

(
void hf(unsigned irq, struct irq_desc *desc) { ... }
|
void hf(u32 irq, struct irq_desc *desc) { ... }
)

results in:
Fatal error: exception Failure("minus: parse error: 
 = File "../cocci/find-pot-handler.cocci", line 7, column 5,  charpos = 63
    around = 'hf', whole content = void hf(unsigned irq, struct irq_desc *desc) { ... }
")

I tried a couple of other variants, but finally gave up and ran a
cocci script first which does s/u32/unsigned/ on those functions, but
of course because I'm lazy I wanted to do everything in one go. :)

Aside of that the ruleset you gave me works nicely except for that
part:

// no uses of the first parameter before the assignment
@@
identifier fun.hf,irq;
expression e;
type T;
fresh identifier firq = "__" ## irq;
position r.p,p1 != {s.p1,s1.p1};
@@

hf(T@p
- irq
+ firq
  ,...) {
  ... when != irq
      when strict
? irq@p1 = e
  ... when any
}

That lacks a:

+ unsigned int irq;

and therefor missed to add the local variable 'unsigned int irq' in
case the parameter is only used for local storage.

That was simple enough to fix even for me :)

Thanks,

	tglx

