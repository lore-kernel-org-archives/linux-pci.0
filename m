Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Mon, 2 May 2016 22:23:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Fix BUG on device attach failure
Message-ID: <20160502202329.GA19313@wunner.de>
References: <158b8ef6bf71ae69ef54871e4762b98deb981d6e.1461162854.git.lukas@wunner.de>
 <20160502190133.GH24851@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160502190133.GH24851@localhost>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, May 02, 2016 at 02:01:33PM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 20, 2016 at 04:44:27PM +0200, Lukas Wunner wrote:
> > Previously when pci_bus_add_device() called device_attach() and it
> > returned a negative value, we emitted a WARN but carried on.
> > 
> > Commit ab1a187bba5c ("PCI: Check device_attach() return value always"),
> > introduced in Linux 4.6-rc1, changed this to unwind all steps preceding
> > device_attach() and to not set dev->is_added = 1.
> > 
> > The latter leads to a BUG if pci_bus_add_device() was called from
> > pci_bus_add_devices(). Fix by not recursing to a child bus if
> > device_attach() failed for the bridge leading to it.
> > 
> > This can be triggered by plugging in a PCI device (e.g. Thunderbolt)
> > while the system is asleep. The system locks up when woken because
> > device_attach() returns -EPROBE_DEFER.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Applied both with Rafael's acks to for-linus for v4.6.
> 
> The rationale is that ab1a187bba5c ("PCI: Check device_attach() return
> value always") appeared in v4.6-rc1, and after that commit, plugging
> in a Thunderbolt device while the system is asleep will cause a BUG()
> when the system is awakened.
> 
> Lukas, you mentioned earlier that we might want to include Andreas'
> patch "thunderbolt: Fix double free of drom buffer" at the same time.
> I did apply that on pci/thunderbolt for v4.7.  I can move that to
> for-linus and put it in v4.6 if necessary, but that bug been there
> since v3.17.  Is there something in v4.6 that makes us more likely to
> hit that double free?

No there's not, I meant that just as a reminder. The solution you've
settled on seems perfectly fine, thank you so much!

Lukas

> 
> > ---
> > v2: Split commit in two (Bjorn Helgaas).
> > 
> >  drivers/pci/bus.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 6c9f546..23a39fd 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -324,7 +324,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
> >  	}
> >  
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> > -		BUG_ON(!dev->is_added);
> > +		/* Skip if device attach failed */
> > +		if (!dev->is_added)
> > +			continue;
> >  		child = dev->subordinate;
> >  		if (child)
> >  			pci_bus_add_devices(child);
> > -- 
> > 2.8.0.rc3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
