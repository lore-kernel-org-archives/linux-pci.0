Return-Path: <SRS0=Tu5X=K7=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=Tu5X=K7=h08.hostsharing.net=foo00@kernel.org>
Date: Thu, 16 Aug 2018 14:28:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
	linux-pci@vger.kernel.org, ray.jui@broadcom.com,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
Message-ID: <20180816122807.6xof2u3hbhv57ua5@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 07:52:06AM +1000, Benjamin Herrenschmidt wrote:
> I would also like to use this rather than the bitmap atomics for is_added
> etc... (Hari's fix) in the long run. Atomics aren't significantly cheaper
> and imho makes thing even messier.

PCI device enablement isn't a hotpath, so the performance saving of
acquire/release memory barriers vs. full memory barriers is hardly
a strong argument.

Atomic bitops have the advantage of being usable in atomic context,
unlike a struct mutex.  And they don't require any spinning if the
variable is accessed concurrently.

Last not least an atomic bitop needs just 1 line of code versus 3 lines
of code to acquire a lock, update the variable and release the lock.
"Elegance is not optional."

That said, the race *you're* dealing with appears to be distinct from
Hari's in that a lock is unavoidable because (AFAIUI) atomic_inc_return()
is called before enablement actually happens, yet both needs to happen
atomically.

Thanks,

Lukas
