Return-Path: <SRS0=xK5x=LD=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=xK5x=LD=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 20 Aug 2018 09:17:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Marta Rybczynska <mrybczyn@kalray.eu>,
	Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
Message-ID: <20180820071703.hnsyhb5pz4svb7jg@wunner.de>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-2-benh@kernel.crashing.org>
 <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
 <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
 <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
 <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 12:10:59PM +1000, Benjamin Herrenschmidt wrote:
> I chose to create a new mutex which we should be able to address other
> similar races if we find them. The other solutions that I dismissed
> were:
> 
>  - Using the device_lock. A explained previously, this is tricky, I
> prefer not using this for anything other than locking against
> concurrent add/remove. The main issue is that drivers will be sometimes
> called in context where that's already held, so we can't take it inside
> pci_enable_device() and I'd rather not add new constraints such as
> "pci_enable_device() must be only called from probe() unless you also
> take the device lock". It would be tricky to audit everybody...
> 
>  - Using a global mutex. We could move the bridge lock from AER to core
> code for example, and use that. But it doesn't buy us much, and
> slightly redecuces parallelism. It also makes it a little bit more
> messy to walk up the bridge chain, we'd have to do a
> pci_enable_device_unlocked or something, messy.

+1 from my side for adding a struct mutex to struct pci_dev to protect
state changes.

The device_lock() primarily protects binding / unbinding of the device
and pci_dev state may have to be changed while binding / unbinding.

A global lock invites deadlocks if multiple devices are added / removed
concurrently where one is a parent of the other.  (Think hot-removal of
multiple devices on a Thunderbolt daisy-chain.)

As said I'd also welcome folding PCI_DEV_DISCONNECTED into enum
pci_channel_state, either as an additional state or by using
pci_channel_io_perm_failure.

Thanks,

Lukas
