Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Message-ID: <16dc573e5a9add534153b1236d3665b035b8d581.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 0/6] pci: Rework is_added race fix and address
 bridge enable races
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck
 <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas Wunner
 <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta
 Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Date: Fri, 17 Aug 2018 15:03:49 +1000
In-Reply-To: <20180817044902.31420-1-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 14:48 +1000, Benjamin Herrenschmidt wrote:
> The second part aims at fixing the enable/disable/set_master races,
> and does so by providing a framework for future device state locking
> issues.
> 
> It introduces a pci_dev->state_mutex which is used at a lower level
> than the device_lock (the device lock isn't suitable, as explained
> in the cset comments) and uses it to protect enablement and set_master.

As discussed in the series, I'm not using the device_lock because I
don't like it creeping out of drivers/base too much unless you
explicitly try to lock against concurrent add/remove.

That being said, if we decided we prefer using it to solve the
enable/disable race, then we have to be careful of a few things:

 - Driver callbacks hold it, so we can't take it from within
pci_enable_device(), pci_set_master() etc... themselves. We'll have to
assume the caller has it

 - The above means auditing callers of these various APIs that might be
calling them from outside of a driver callback and add the necessary
lock

 - We need to take great care about the possibility of the parent
device(s) lock being held. It can happen for USB for example. Now we
don't have USB->PCI adapters that I know of that uses the PCI stack in
Linux but generally assuming your parent lock isn't held is risky. So I
would be a bit weary of walking up the bridge chain and taking it
unconditionally.

Alternatively, we could hijack an existing global lock, for example
mvoe the bridge_mutex outside of ACPI and use it for the upwards bridge
walk, and ignore the other possible races with enable/disable.

Cheers,
Ben.
