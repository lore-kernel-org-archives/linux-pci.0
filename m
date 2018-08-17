Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Message-ID: <1ffafe01887e3b760f84488b06339aba64f586e5.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 5/6] pci: Protect the enable/disable state of
 pci_dev using the state mutex
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marta Rybczynska <mrybczyn@kalray.eu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Hari Vyas
 <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam
 <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>, Jens
 Axboe <axboe@kernel.dk>,
        Lukas Wunner <lukas@wunner.de>,
        Konstantin
 Khlebnikov <khlebnikov@yandex-team.ru>,
        Pierre-Yves Kerbrat
 <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Date: Fri, 17 Aug 2018 18:30:16 +1000
In-Reply-To: <66577784.13494160.1534493390262.JavaMail.zimbra@kalray.eu>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
	 <20180817044902.31420-6-benh@kernel.crashing.org>
	 <66577784.13494160.1534493390262.JavaMail.zimbra@kalray.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 10:09 +0200, Marta Rybczynska wrote:
> 
> ----- On 17 Aug, 2018, at 06:49, Benjamin Herrenschmidt benh@kernel.crashing.org wrote:
> 
> > This protects enable/disable operations using the state mutex to
> > avoid races with, for example, concurrent enables on a bridge.
> > 
> > The bus hierarchy is walked first before taking the lock to
> > avoid lock nesting (though it would be ok if we ensured that
> > we always nest them bottom-up, it is better to just avoid the
> > issue alltogether, especially as we might find cases where
> > we want to take it top-down later).
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> 
> > 
> > static void pci_enable_bridge(struct pci_dev *dev)
> > {
> > 	struct pci_dev *bridge;
> > -	int retval;
> > +	int retval, enabled;
> > 
> > 	bridge = pci_upstream_bridge(dev);
> > 	if (bridge)
> > 		pci_enable_bridge(bridge);
> > 
> > -	if (pci_is_enabled(dev)) {
> > -		if (!dev->is_busmaster)
> > -			pci_set_master(dev);
> > +	/* Already enabled ? */
> > +	pci_dev_state_lock(dev);
> > +	enabled = pci_is_enabled(dev);
> > +	if (enabled && !dev->is_busmaster)
> > +		pci_set_master(dev);
> > +	pci_dev_state_unlock(dev);
> > +	if (enabled)
> > 		return;
> > -	}
> > 
> 
> This looks complicated too me especially with the double locking. What do you
> think about a function doing that check that used an unlocked version of
> pcie_set_master?
> 
> Like:
> 
>         dev_state_lock(dev);
>         enabled = pci_is_enabled(dev);
>         if (enabled &&  !dev->is_busmaster)
>                 pci_set_master_unlocked();
>         pci_dev_state_unlock(dev);
> 
> BTW If I remember correctly the code today can set bus mastering multiple
> times without checking if already done.

I don't mind but I tend to dislike all those _unlocked() suffixes, I
suppose my generation is typing adverse enough that we call these
__something instead :)

As for setting multiple times, yes pci_set_master() doesn't check but
look at the "-" hunks of my patch, I'm not changing the existing test
here. Not that it matters much, it's an optimization.

In fact my original version just completely removed the whole lot
and just unconditionally did pci_enable_device() + pci_set_master(),
just ignoring the existing state :-)

But I decided to keep the patch functionally equivalent so I added it
back.

Cheers,
Ben.
