Return-Path: <SRS0=SupU=LB=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=SupU=LB=h08.hostsharing.net=foo00@kernel.org>
Date: Sat, 18 Aug 2018 11:22:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
	linux-pci@vger.kernel.org, ray.jui@broadcom.com,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Jens Axboe <axboe@kernel.dk>, mr.nuke.me@gmail.com,
	keith.busch@intel.com
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
Message-ID: <20180818092214.jjodm4mtxea53b2p@wunner.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <535f823d185b6c17b90bab326df268a56db0af36.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 18, 2018 at 01:37:35PM +1000, Benjamin Herrenschmidt wrote:
> As-is, what you have is a bit that is private to drivers/pci (why ?
> devices might be interested in knowing the device has been
> disconnected...)

It is private to drivers/pci because Greg wanted it so:

   "> The flag is not intended for a device specific driver to use.
    > The intention is for the pci bus driver to use it, so no additional
    > work for other drivers.
    But the driver can see this in the structure, so it will get used..."
    https://spinics.net/lists/linux-pci/msg57744.html

   "I applaud your attempt to make this "private" to the pci core, just
    don't know if it really will work, or if it is worth it entirely..."
    https://spinics.net/lists/linux-pci/msg58017.html

Greg is of the opinion that drivers should check for themselves whether
a device has been removed and he was happy that they are barred from
using PCI_DEV_DISCONNECTED.  He believes that drivers should verify
for every read of mmio and config space that that the read value is not
0xffffffff (if that is an invalid value) and consider the device removed
if so:

   "If you are worried about your device going away (and you have to),
    then just check all reads and be fine with it.  If you have values
    that can be all 0xff, then just accept that as a valid value and
    move to the next read where it can't be valid."
    https://spinics.net/lists/linux-pci/msg70793.html

However Alex Gagniuc recently countered:

   "The discussion is based on the wrong assumptions that reads are 
    symmetrical wrt to a device being present or not. However, completion 
    timeouts and unsupported requests blow that assumption right out of the 
    water. Best case scenario, you just waste a little more time waiting for 
    hardware IO. More common is to end up crashing the machine.

    Greg's ideas work in a perfect world where PCI and PCIe are equivalent 
    at every level. And in that case, PCI_DEV_DISCONNECTED would have been 
    pure, 100% genuine Redmond bloatware. We wouldn't have gotten complaints 
    from Facebook and other industry players that it takes too damn long to 
    remove a device. We probably also wouldn't be seeing machines crash on 
    PCIe removal."
    https://spinics.net/lists/linux-pci/msg74864.html

The reason I'm interested in PCI_DEV_DISCONNECTED is because hot-removing
an Apple Thunderbolt Ethernet adapter locks up the machine a due to the tg3
driver trying to access the removed device.

Now, tg3 does call pci_channel_offline() and refrains from accessing the
device if that returns true.  If I make PCI_DEV_DISCONNECTED public and
check its value in pci_channel_offline(), I can hot-remove the Thunderbolt
Ethernet adapter without problems.  I posted a patch for that 2 years ago:
https://spinics.net/lists/linux-pci/msg55601.html

Thus, I'd be more than happy if the PCI_DEV_DISCONNECTED state could be
folded into enum pci_channel_state as it would immediately fix Thunderbolt
hot-removal.


> Fundamentally both mean, from a driver perspective, two things.
> 
>  - One very important: break out of a loop that waits for a HW state to
> change because it won't
> 
>  - One an optimisation: don't bother with all those register updates
> bcs they're never going to reach your HW.

Right.  PCI_DEV_DISCONNECTED was introduced by Intel on behalf of
Facebook.  See slides 13 to 16 of this slide deck for the details:
http://files.opencompute.org/oc/public.php?service=files&t=4ff50715e3c1e273e02b694757b80d25&download

There's a graph on slide 16 showing the speedup achieved by
PCI_DEV_DISCONNECTED.

There's also a recording of that talk, the relevant segment is just
10 minutes:
https://youtu.be/GJ6B0xzgvlM?t=926

Thanks,

Lukas
