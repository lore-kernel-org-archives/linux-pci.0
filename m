Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 20 May 2015 22:22:38 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.10.1505202215230.2642@hadrien>
Message-ID: <alpine.DEB.2.11.1505202219290.4225@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com> <alpine.DEB.2.11.1505201750280.4225@nanos>
 <alpine.DEB.2.10.1505202155420.2642@hadrien> <alpine.DEB.2.11.1505202209470.4225@nanos> <alpine.DEB.2.10.1505202215230.2642@hadrien>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 May 2015, Julia Lawall wrote:
> On Wed, 20 May 2015, Thomas Gleixner wrote:
> > On Wed, 20 May 2015, Julia Lawall wrote:
> > > Scripting this may be a little complex, because the variable can be used
> > > in one way in one execution path (eg if branch) and another way (or not at
> > > all) in another.  Let me know if help is needed.
> >
> > I feared that, but at least identifying all functions, where the irq
> > argument is used inside the function itself is really key for such a
> > massive rework.
> 
> It's not impossible, but I may need to think a bit how best to do it.

I pretty much expected that you would say that :)

But seriously, the first important thing is to find all functions and
to check whether they use irq internaly. Jiang has done that
'manually' or such, so the number of function which need an actual
change are not that big.

But I certainly don't want to hold you off thinking about it. Such
stuff is not a unique problem :)

	tglx
