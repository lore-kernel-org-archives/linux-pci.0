Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Message-ID: <6ce65522aee9a2edbc6c116624b1b0b60a7b79d8.camel@kernel.crashing.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Konstantin Khlebnikov
	 <khlebnikov@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>
Date: Fri, 17 Aug 2018 11:12:50 +1000
In-Reply-To: <6b610ee94bcef718db97600ae0ee931de3501e40.camel@kernel.crashing.org>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
	 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
	 <20180816122807.6xof2u3hbhv57ua5@wunner.de>
	 <6b610ee94bcef718db97600ae0ee931de3501e40.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 09:25 +1000, Benjamin Herrenschmidt wrote:
> > That said, the race *you're* dealing with appears to be distinct from
> > Hari's in that a lock is unavoidable because (AFAIUI) atomic_inc_return()
> > is called before enablement actually happens, yet both needs to happen
> > atomically.
> 
> Every single time one of these flags represent more than the flag
> itself, but some other state that is being modified or updates, then
> you need a lock to cover both the flag and the other state.
> 
> So if we are going to create a sane locking mechanism to protect the
> various bits of pci_dev (not just enable), let's use it for everything
> shall we ? At least everything that doesn't need to be manipulated in
> atomic context.
> 
> That also possibly include removing some of the ad-hoc locks in various
> parts of pcie/* etc...

Allright, looking at those atomic flags, we have two today:

 - PCI_DEV_DISCONNECTED

Now that's a complete dup of pci_channel_state_t error_state, yuck.

Also the atomic bit is completely pointless. It only protects the
actual field from RMW access, it doesn't synchronize with any of the
users.

For example, it's being tested in the config ops wrappers (instead of
the channel state) but that's completely racy. In that specific case it
probably doesn't matter either way, but still.

It's also tested in __pci_write_msi_msg, why ? What for ? If MMIO is
blocked it's handled by the channel state. Again, you notice the
complete absence of synchronization between the producer and the
consumer of that bit.

 - PCI_DEV_ADDED

Now the only reason that was moved was to avoid the RMW races on the
bit itself. There is, here too, 0 synchronization with the callers.

Now I forgot the specific details of the race Hari found, but this is
definitely not the right way to fix things. Plus it forced powerpc to
do a relative path include which sucks.

The latter would be much more cleanly handled using the mutex I
proposed.

The former should go a way, that's what error_state is already meant to
be. As for the locking, this needs to be looked at more closely since
this is inherently a racy op, though testing it in the MSI writing code
looks more like a band-aid than a feature to me. The original commit
lokos like it's meant to just be some kind of optimisation. One has to
be careful however of the possible ordering issues when the bit is
cleared.

So at this stage, I don't see any reasonable justification for those
private atomic bits. They should should both go away along with the
whole priv_flags.

Ben.
