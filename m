Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Message-ID: <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui
 <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas
 Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov
 <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Date: Mon, 20 Aug 2018 12:10:59 +1000
In-Reply-To: <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
	 <20180817044902.31420-2-benh@kernel.crashing.org>
	 <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
	 <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
	 <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2018-08-18 at 21:24 -0500, Bjorn Helgaas wrote:
> On Sat, Aug 18, 2018 at 01:24:51PM +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2018-08-17 at 10:44 -0500, Bjorn Helgaas wrote:
> > > On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
> > > > This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
> > > 
> > > Just to be clear, if I understand correctly, this is a pure revert of
> > > 44bda4b7d26e and as such it reintroduces the problem solved by that
> > > commit.
> > > 
> > > If your solution turns out to be better, that's great, but it would be
> > > nice to avoid the bisection hole of reintroducing the problem, then
> > > fixing it again later.
> > 
> > There is no way to do that other than merging the revert and the fix
> > into one. That said, the race is sufficiently hard to hit that I
> > wouldn't worry too much about it.
> 
> OK, then at least mention that in the changelog.

Sure will do. This is just RFC at this stage :-)

As for the race with enable, what's your take on my approach ? The
basic premise is that we need some kind of mutex to make the updates to
enable_cnt and the actual config space changes atomic. While at it we
can fold pci_set_master vs. is_busmaster as well as those are racy too.

I chose to create a new mutex which we should be able to address other
similar races if we find them. The other solutions that I dismissed
were:

 - Using the device_lock. A explained previously, this is tricky, I
prefer not using this for anything other than locking against
concurrent add/remove. The main issue is that drivers will be sometimes
called in context where that's already held, so we can't take it inside
pci_enable_device() and I'd rather not add new constraints such as
"pci_enable_device() must be only called from probe() unless you also
take the device lock". It would be tricky to audit everybody...

 - Using a global mutex. We could move the bridge lock from AER to core
code for example, and use that. But it doesn't buy us much, and
slightly redecuces parallelism. It also makes it a little bit more
messy to walk up the bridge chain, we'd have to do a
pci_enable_device_unlocked or something, messy.

So are you ok with the approach ? Do you prefer one of the above
regardless ? Something else ?

Cheers,
Ben.
