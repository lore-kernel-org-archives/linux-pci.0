Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Message-ID: <535f823d185b6c17b90bab326df268a56db0af36.camel@kernel.crashing.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Konstantin Khlebnikov
	 <khlebnikov@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>
Date: Sat, 18 Aug 2018 13:37:35 +1000
In-Reply-To: <20180817163919.wxrk5bnexqplgm7z@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
	 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
	 <20180816122807.6xof2u3hbhv57ua5@wunner.de>
	 <6b610ee94bcef718db97600ae0ee931de3501e40.camel@kernel.crashing.org>
	 <6ce65522aee9a2edbc6c116624b1b0b60a7b79d8.camel@kernel.crashing.org>
	 <20180817163919.wxrk5bnexqplgm7z@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 18:39 +0200, Lukas Wunner wrote:
> On Fri, Aug 17, 2018 at 11:12:50AM +1000, Benjamin Herrenschmidt wrote:
> > Allright, looking at those atomic flags, we have two today:
> > 
> >  - PCI_DEV_DISCONNECTED
> > 
> > Now that's a complete dup of pci_channel_state_t error_state, yuck.
> 
> Guess what, I did suggest to use pci_channel_state back then:

And you were right :-)

>    "We've got three pci_channel_state values defined in include/linux/pci.h,
>     "normal", "frozen" and "perm_failure".  Instead of adding a new
>     "is_removed" bit to struct pci_dev, would it perhaps make more sense to
>     just add a new type of pci_channel_state for removed devices?"
>     https://spinics.net/lists/linux-pci/msg55411.html

So I initially added a value for disconnected, then noticed a bunch of
drivers have switch/cases around the error_state value, and decided to
just make disconnected alias to permanent failure for now, we can do
driver auditing/cleanup later.

As for Keith:

> This was Keith's answer:
> 
>    "I'd be happy if we can reuse that, but concerned about overloading
>     error_state's intended purpose for AER. The conditions under which an
>     'is_removed' may be set can also create AER events, and the aer driver
>     overrides the error_state."
>     https://spinics.net/lists/linux-pci/msg55417.html

Well, rather than adding another field that means something somewhat
similar, I would just address his concern (it's not just AER, it's also
the powerpc EEH code, which once we turn it into something actually
readable (WIP...) should probably largely migrate to drivers/pci...

But I'm also looking at issues with AER at the moment with another
crowd and I think we can sort this all out.

Funnily enough, it mgiht actually be one of those cases where we *do*
want an atomic. By making error_state an atomic, we can enforce valid
transitions, and thus simply make the transition from "disconnected" to
anything else impossible while dealing with it changing at interrupt
time (which can happen with EEH).

As-is, what you have is a bit that is private to drivers/pci (why ?
devices might be interested in knowing the device has been
disconnected...) and somewhat duplicates the purpose of an existing
field so we'll end up with bits that test one, bits that test the
other, or both, and a lot of confusion.

Fundamentally both mean, from a driver perspective, two things.

 - One very important: break out of a loop that waits for a HW state to
change because it won't

 - One an optimisation: don't bother with all those register updates
bcs they're never going to reach your HW.

So let's make it a single field. I'm happy to rename "error_state" to
something more generic such a "channel_state" to reflect that it's not
all errors (is disconnect an error ? debatable...) and we can work in
making it atomic, adding an enum member etc... if we wish to do so, but
let's not introduce yet another field.

> > Also the atomic bit is completely pointless. It only protects the
> > actual field from RMW access, it doesn't synchronize with any of the
> > users.
> 
> Synchronizing with users?  There's nothing to synchronize with here,
> once it has been determined the device is gone, the bit should be set
> ASAP.
>
>   Places where this bit is checked need to be able to cope with the
> device physically removed but the bit not yet set.  They should just
> skip device accesses *if* the bit is set.

This is true of the current 2 or 3 places where you check it, to *some*
extent, because at the moment it's just a "hint". These things do have
a tendency to grow beyond their original intent though.

> The bit was made atomic because Bjorn wanted to avoid RMW races:
> 
>    "This makes me slightly worried because this is a bitfield and there's
>     no locking.  A concurrent write to some nearby field can corrupt
>     things.  It doesn't look *likely*, but it's a lot of work to be
>     convinced that this is completely safe, especially since the writer is
>     running on behalf of the bridge, and the target is a child of the
>     bridge."
>     https://patchwork.kernel.org/patch/9402793/

Then don't make it a bitfield rather than adding some atomics, they are
really pointless and encourage unsafe practices (even if this precise
one might actually be ok).
> 
> > It's also tested in __pci_write_msi_msg, why ? What for ? If MMIO is
> > blocked it's handled by the channel state. Again, you notice the
> > complete absence of synchronization between the producer and the
> > consumer of that bit.
> 
> Well, a quick git blame would have led you to commit 0170591bb067,
> which contains the following rationale:
> 
>    "Check the device connected state prior to executing device shutdown
>     operations or writing MSI messages so that tear down on disconnected
>     devices completes quicker."
>                       ^^^^^^^

Ok so just an optimisation, nothing terribly important.

> >  - PCI_DEV_ADDED
> > 
> > Now the only reason that was moved was to avoid the RMW races on the
> > bit itself. There is, here too, 0 synchronization with the callers.
> > 
> > Now I forgot the specific details of the race Hari found, but this is
> > definitely not the right way to fix things. Plus it forced powerpc to
> > do a relative path include which sucks.
> > 
> > The latter would be much more cleanly handled using the mutex I
> > proposed.
> 
> I disagree, a mutex is not cleaner if it adds 3 LoC instead of 1
> while the only point is to avoid RMW races and not achieve any kind
> of synchronization.

No this is not the only point, is_added means more than that, and in
fact my argument (see the other emails) is that the root of the problem
was elsewhere. Here, "fixing" the RMW race with an atomic papers over a
deeper problem that this field was being set in the wrong place to
begin with.
> 
> > The former should go a way, that's what error_state is already meant to
> > be. As for the locking, this needs to be looked at more closely since
> > this is inherently a racy op, though testing it in the MSI writing code
> > looks more like a band-aid than a feature to me. The original commit
> > lokos like it's meant to just be some kind of optimisation. One has to
> > be careful however of the possible ordering issues when the bit is
> > cleared.
> 
> PCI_DEV_DISCONNECTED is never cleared.  What sense would that make?

As long as we never "reconnect" without a re-probe, that's ok. That
said, see above why I sitll think it's the wrong things to do.

Cheers,
Ben.
