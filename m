Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Message-ID: <a9b999a52fc559798ad9a471aedb358f4a1c40a9.camel@kernel.crashing.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Konstantin Khlebnikov
 <khlebnikov@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>, mr.nuke.me@gmail.com,
        keith.busch@intel.com
Date: Sat, 18 Aug 2018 23:11:15 +1000
In-Reply-To: <20180818092214.jjodm4mtxea53b2p@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
	 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
	 <20180816122807.6xof2u3hbhv57ua5@wunner.de>
	 <6b610ee94bcef718db97600ae0ee931de3501e40.camel@kernel.crashing.org>
	 <6ce65522aee9a2edbc6c116624b1b0b60a7b79d8.camel@kernel.crashing.org>
	 <20180817163919.wxrk5bnexqplgm7z@wunner.de>
	 <535f823d185b6c17b90bab326df268a56db0af36.camel@kernel.crashing.org>
	 <20180818092214.jjodm4mtxea53b2p@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2018-08-18 at 11:22 +0200, Lukas Wunner wrote:

> Greg is of the opinion that drivers should check for themselves whether
> a device has been removed and he was happy that they are barred from
> using PCI_DEV_DISCONNECTED.  He believes that drivers should verify
> for every read of mmio and config space that that the read value is not
> 0xffffffff (if that is an invalid value) and consider the device removed
> if so:

Well, this is not quite right.. but close :-)

There can be valid cases of ffffffff's ... that said, this is exactly
what error_state is about, it allows differenciating a valid ffffffff's
from an error state.

On POWER with EEH, every read{b,w,l,q} will check for an all 1's result
and call the EEH core to check the freeze state in the host bridge &
update the channel state.

That does mean that a legitimate all 1's read will be much slower but
thankfully they are pretty rare.

>    "If you are worried about your device going away (and you have to),
>     then just check all reads and be fine with it.  If you have values
>     that can be all 0xff, then just accept that as a valid value and
>     move to the next read where it can't be valid."
>     https://spinics.net/lists/linux-pci/msg70793.html
> 
> However Alex Gagniuc recently countered:
> 
>    "The discussion is based on the wrong assumptions that reads are 
>     symmetrical wrt to a device being present or not. However, completion 
>     timeouts and unsupported requests blow that assumption right out of the 
>     water. Best case scenario, you just waste a little more time waiting for 
>     hardware IO. More common is to end up crashing the machine.
> 
>     Greg's ideas work in a perfect world where PCI and PCIe are equivalent 
>     at every level. And in that case, PCI_DEV_DISCONNECTED would have been 
>     pure, 100% genuine Redmond bloatware. We wouldn't have gotten complaints 
>     from Facebook and other industry players that it takes too damn long to 
>     remove a device. We probably also wouldn't be seeing machines crash on 
>     PCIe removal."
>     https://spinics.net/lists/linux-pci/msg74864.html

Yes, reality is slightly more complicated ;-) Alex is absolutely
correct. Again, this is what error_state (aka channel state) is
supposed to convey, and is meant to allow disambiguation here.

This is why I think that's what we should be using.

> The reason I'm interested in PCI_DEV_DISCONNECTED is because hot-removing
> an Apple Thunderbolt Ethernet adapter locks up the machine a due to the tg3
> driver trying to access the removed device.

TG3 is precisely one of the original culprits we "Fixed" by introducing
the channel state back in the day iirc :-)

There is no difference from a driver perspective between a device being
disconnected, yanked out (think express cards... thunderbolt isn't
bringing anything new here, even good old cardbus...), or in an EEH
frozen state which is what our error handling hardware does on POWER
(blocks writes and returns all 1's on reads on the first error from a
device to prevent propagation of bad data).

The only difference drivers might care about is when it comes to
recovering. Some of the error cases provide recovery options, a pure
disconnect doesn't, but that has no impact on all those various pieces
of wait loops etc.. that need to break out.

> Now, tg3 does call pci_channel_offline() and refrains from accessing the
> device if that returns true.  If I make PCI_DEV_DISCONNECTED public and
> check its value in pci_channel_offline(), I can hot-remove the Thunderbolt
> Ethernet adapter without problems.  I posted a patch for that 2 years ago:
> https://spinics.net/lists/linux-pci/msg55601.html

Yes that's absolutely the right thing to do if you really can't just
use the existing error_state as your "disconnected" state, but I would
prefer we don't break that up into two pieces of state and reconcile
it.

> Thus, I'd be more than happy if the PCI_DEV_DISCONNECTED state could be
> folded into enum pci_channel_state as it would immediately fix Thunderbolt
> hot-removal.

Yes I think that's the way to go.

If we want to be extra safe, what we could do is make the channel state
an atomic so that it's updated by doing cmpxchg with the rules in the
"setter" function enforcing that it cannot ever change back from a
disconnected state.

In this case the atomicity is necessary because at least EEH will
update it potentially from any read{b,w,l,q} and thus at interrupt time
(AER isn't as harsh though).

> > Fundamentally both mean, from a driver perspective, two things.
> > 
> >  - One very important: break out of a loop that waits for a HW state to
> > change because it won't
> > 
> >  - One an optimisation: don't bother with all those register updates
> > bcs they're never going to reach your HW.
> 
> Right.  PCI_DEV_DISCONNECTED was introduced by Intel on behalf of
> Facebook.  See slides 13 to 16 of this slide deck for the details:
> http://files.opencompute.org/oc/public.php?service=files&t=4ff50715e3c1e273e02b694757b80d25&download
> 
> There's a graph on slide 16 showing the speedup achieved by
> PCI_DEV_DISCONNECTED.
> 
> There's also a recording of that talk, the relevant segment is just
> 10 minutes:
> https://youtu.be/GJ6B0xzgvlM?t=926

Ok thanks. I don't know if I'll have time to review all of that
material, but I suspect we can agree that making it all a single piece
of information is preferable.

I need to spend a bit more time auditing the users next week to find a
way to make the conversion smooth without having to patch bazillions
drivers, but I really think that's the way to go.

Cheers,
Ben.

> 
> Thanks,
> 
> Lukas
