Return-Path: <SRS0=kyUp=LA=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=kyUp=LA=h08.hostsharing.net=foo00@kernel.org>
Date: Fri, 17 Aug 2018 18:39:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
	linux-pci@vger.kernel.org, ray.jui@broadcom.com,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
Message-ID: <20180817163919.wxrk5bnexqplgm7z@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
 <20180816122807.6xof2u3hbhv57ua5@wunner.de>
 <6b610ee94bcef718db97600ae0ee931de3501e40.camel@kernel.crashing.org>
 <6ce65522aee9a2edbc6c116624b1b0b60a7b79d8.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6ce65522aee9a2edbc6c116624b1b0b60a7b79d8.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 11:12:50AM +1000, Benjamin Herrenschmidt wrote:
> Allright, looking at those atomic flags, we have two today:
> 
>  - PCI_DEV_DISCONNECTED
> 
> Now that's a complete dup of pci_channel_state_t error_state, yuck.

Guess what, I did suggest to use pci_channel_state back then:

   "We've got three pci_channel_state values defined in include/linux/pci.h,
    "normal", "frozen" and "perm_failure".  Instead of adding a new
    "is_removed" bit to struct pci_dev, would it perhaps make more sense to
    just add a new type of pci_channel_state for removed devices?"
    https://spinics.net/lists/linux-pci/msg55411.html

This was Keith's answer:

   "I'd be happy if we can reuse that, but concerned about overloading
    error_state's intended purpose for AER. The conditions under which an
    'is_removed' may be set can also create AER events, and the aer driver
    overrides the error_state."
    https://spinics.net/lists/linux-pci/msg55417.html


> Also the atomic bit is completely pointless. It only protects the
> actual field from RMW access, it doesn't synchronize with any of the
> users.

Synchronizing with users?  There's nothing to synchronize with here,
once it has been determined the device is gone, the bit should be set
ASAP.  Places where this bit is checked need to be able to cope with the
device physically removed but the bit not yet set.  They should just
skip device accesses *if* the bit is set.

The bit was made atomic because Bjorn wanted to avoid RMW races:

   "This makes me slightly worried because this is a bitfield and there's
    no locking.  A concurrent write to some nearby field can corrupt
    things.  It doesn't look *likely*, but it's a lot of work to be
    convinced that this is completely safe, especially since the writer is
    running on behalf of the bridge, and the target is a child of the
    bridge."
    https://patchwork.kernel.org/patch/9402793/


> It's also tested in __pci_write_msi_msg, why ? What for ? If MMIO is
> blocked it's handled by the channel state. Again, you notice the
> complete absence of synchronization between the producer and the
> consumer of that bit.

Well, a quick git blame would have led you to commit 0170591bb067,
which contains the following rationale:

   "Check the device connected state prior to executing device shutdown
    operations or writing MSI messages so that tear down on disconnected
    devices completes quicker."
                      ^^^^^^^

>  - PCI_DEV_ADDED
> 
> Now the only reason that was moved was to avoid the RMW races on the
> bit itself. There is, here too, 0 synchronization with the callers.
> 
> Now I forgot the specific details of the race Hari found, but this is
> definitely not the right way to fix things. Plus it forced powerpc to
> do a relative path include which sucks.
> 
> The latter would be much more cleanly handled using the mutex I
> proposed.

I disagree, a mutex is not cleaner if it adds 3 LoC instead of 1
while the only point is to avoid RMW races and not achieve any kind
of synchronization.


> The former should go a way, that's what error_state is already meant to
> be. As for the locking, this needs to be looked at more closely since
> this is inherently a racy op, though testing it in the MSI writing code
> looks more like a band-aid than a feature to me. The original commit
> lokos like it's meant to just be some kind of optimisation. One has to
> be careful however of the possible ordering issues when the bit is
> cleared.

PCI_DEV_DISCONNECTED is never cleared.  What sense would that make?

Thanks,

Lukas
