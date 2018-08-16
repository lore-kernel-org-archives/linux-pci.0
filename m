Return-Path: <SRS0=veIH=K7=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=veIH=K7=kernel.crashing.org=benh@kernel.org>
Message-ID: <6b610ee94bcef718db97600ae0ee931de3501e40.camel@kernel.crashing.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Konstantin Khlebnikov
	 <khlebnikov@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>
Date: Fri, 17 Aug 2018 09:25:59 +1000
In-Reply-To: <20180816122807.6xof2u3hbhv57ua5@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
	 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
	 <20180816122807.6xof2u3hbhv57ua5@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


On Thu, 2018-08-16 at 14:28 +0200, Lukas Wunner wrote:
> On Thu, Aug 16, 2018 at 07:52:06AM +1000, Benjamin Herrenschmidt wrote:
> > I would also like to use this rather than the bitmap atomics for is_added
> > etc... (Hari's fix) in the long run. Atomics aren't significantly cheaper
> > and imho makes thing even messier.
> 
> PCI device enablement isn't a hotpath, so the performance saving of
> acquire/release memory barriers vs. full memory barriers is hardly
> a strong argument.

My argument is not about performance. Fine grained atomics are a mess,
and make you lose the big picture. The problem isn't so much that
indiviual bits need to avoid low level RMW races, but overall higher
level bnehaviours need to be synchronized, such as the enable race
above.

> Atomic bitops have the advantage of being usable in atomic context,
> unlike a struct mutex.  And they don't require any spinning if the
> variable is accessed concurrently.

And why on earth would you need to use pci_enable_device or manipulate
is_added in an atomic context ?

Atomic bitops are a giant race-o-matic and experience shows that 99% of
the time, people using them insteaf of standard locking are getting it
wrong.

The PCI code is already messy enough, let's not "fix" the broken
synchronization accross the board in an even messier way.

> Last not least an atomic bitop needs just 1 line of code versus 3 lines
> of code to acquire a lock, update the variable and release the lock.
> "Elegance is not optional."

Sorry, atomics isn't elegance, it's broken crap. The flags dont' live
in isolation. They relate to an overall function. For example
is_busmaster relates to the actual setting of the bus master bit in the
command register. Those two needs to be updated together atomically,
you need a lock or a mutex. Not an atomic.

This is true of about everything else.

> That said, the race *you're* dealing with appears to be distinct from
> Hari's in that a lock is unavoidable because (AFAIUI) atomic_inc_return()
> is called before enablement actually happens, yet both needs to happen
> atomically.

Every single time one of these flags represent more than the flag
itself, but some other state that is being modified or updates, then
you need a lock to cover both the flag and the other state.

So if we are going to create a sane locking mechanism to protect the
various bits of pci_dev (not just enable), let's use it for everything
shall we ? At least everything that doesn't need to be manipulated in
atomic context.

That also possibly include removing some of the ad-hoc locks in various
parts of pcie/* etc...

Ben.

> Thanks,
> 
> Lukas
