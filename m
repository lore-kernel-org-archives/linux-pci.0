Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321111;
	b=3udwM/MdUqUeERQFkK/hu8a+wYsEQ13+lcbtbBb8S/N1Erzg5pjt/WlG4M/HVRKFZOQ8
	 os5voYtelyo+qsE4EMkljhqAuhrr+1bNuCz4s4cfdXfWrUxhr1Vqz1SgmkrZsISHT3EYp
	 f9LXqHvn3mGuJTYUlHwqHOg403+7UQjABbaB3NloQnwyEKMnTl6OqvdP1JkXwRUZr6nls
	 ay+ugmsqUEsmSQjUfyB0IYPcuQtAXo1xGcWAjotgCT6S0HohFfNFD0scqri6bNZzmklHa
	 dU4JaggoZhSpI7BJ30gxwVux/LauRgKBp8TT9JO0+/jNkX2+nUg4dC5OCUIUwqH2N7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321111;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=oF4ltqac0ezbbEs6TWdN65bvPsCRJbHWS/4qDcsLy5I=;
	b=U2U1iMZBhQoHK0XsVx7mwAm8X8r6y51wnxYII+yDerlAhVPguasvBDLIJmNh4vxsRsGe
	 HFf6HWsGxLzFHo8jeWG4Tvjjx8rSZ+ZJTpWCnU2yggu+98uIEi+i2A7CmmyXXZT20XiCc
	 B8UZAgazgGfpzok7akf60DwA1ELVV9XmZ8D6jYzqoQ0WVVVsplvtJwJipMWTkJGmU7yuv
	 ydP/sW6uCLlktseva5x4ht2JLX0TD9RHVxbITLWTQNMYVuBbWxu3EWcIeNaIUHbSP2Va6
	 RSrOagFA84zc31uHO8SxPYML4AAzEeAU1UfH9NffSCYDp7hRyqyzi1IwKXw+T+aYlFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2cqNPi16;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6C606A32A;
	Tue, 10 Nov 2026 14:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D6C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2cqNPi16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=oF4ltqac0ezbbEs6TWdN65bvPsCRJbHWS/4qDcsLy5I=; b=2c
	qNPi16R2xVUs4julQG+1vayBeJpg57S7y/aevBMNVTA5Qu67bt0LjGyw28PR7vzH66PzaVwk21xLh
	QhFrRP59c3ctKZEnHp2gF1VgLMD74gWHfuR4O5IHLp3cXIesp5ul7cxaD7syNLMLNA+auvVZu+RdX
	Vu8XU63Tu4DEEn4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQmsV-00FVDj-4w; Tue, 10 Nov 2026 15:31:15 +0100
Date: Tue, 10 Nov 2026 15:31:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 10/19] net: phy: Use the compatibility driver
 attachment API
Message-ID: <019fceab-1b0b-44a5-8cef-1f77d7d6ac07@lunn.ch>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-10-3b12d9a9f861@nvidia.com>
 <ab062469-ece0-495e-8486-78404c580cdb@lunn.ch>
 <20261110073919.GF8635@unreal>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110073919.GF8635@unreal>

On Tue, Nov 10, 2026 at 09:39:19AM +0200, Leon Romanovsky wrote:
> On Mon, Nov 09, 2026 at 02:45:35PM +0100, Andrew Lunn wrote:
> > > @@ -1956,11 +1958,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> > >  	}
> > >  	phydev->drv_owner = drv_owner;
> > >  
> > > -	if (phydev->is_genphy_driven) {
> > > -		err = d->driver->probe(d);
> > > -		if (err >= 0)
> > > -			err = device_bind_driver(d);
> > > -
> > > +	if (bind_genphy) {
> > > +		err = device_driver_attach_full(drv, d);
> > > +		if (err == -EBUSY)
> > > +			irq = phydev->irq;
> > 
> > Just looking at this, it is not clear where the EBUSY can from? 
> 
> I relied on the comment above: “Assume that if there is no driver, ...”.
> Since PHYs do not use the standard automatic probing mechanism, I have no
> way to tell whether a driver is already bound.

They do use the automatic probe mechanism. But also extend it.

Maybe some background will help.

IEEE 802.3 specifies how PHYs should operate, it list all the
registers which are needed for basic operation etc. If a PHY follows
the standard, genphy is sufficient to drive the PHY.

Now. Networking vendors like to do two things:

1) Do more than what the standard specifies, like interrupts and
blinking LEDs.

2) Don't closely read the standard, and break their implementation

These two cases require a specific driver.

There is a lot of history to phylib, from before my time. It seems
like the current model was retrofitted around earlier code. The result
is that when the MDIO bus is enumerated, PHYs can be found on the bus
and are registered to the bus in the normal way. The driver core will
look to see if there is a driver which matches the ID values in
registers 2 and 3, and if so probe that driver. If there is no
matching driver, a call is made to user space to ask it to load the
driver with the given IDs.  That operates asynchronous, when such a
driver is loaded, the driver core will run the match again and probe
the device with the driver.

Because there can be up to 32 devices on the MDIO bus, the MAC driver
often knows which PHY device it should use. If not, MAC drivers
sometimes use the first PHY on the bus. It does not really matter, the
point is, we know the device exists, even if it has not been probed
yet, so we can get a reference to it.

The MAC most often connects to its PHY during open(). At that point,
if the driver core has bound a PHY driver to the PHY device, it is
good to go.

If however, there is no PHY driver for the PHY device, it can mean a
few different things:

There is no driver of that PHY because it follows 802.3, and genphy is
expected to be used. However, genphy does not have a list of IDs it
can drive, so the usual probing mechanism does not match it to the
device. It would be nice if it did actually have such a list, but it
does not.

There is driver, but it has not been built, or is missing from the
initramfs, or is not part of the image, etc. So we just use the genphy
driver and hope for the best.

So, if we have got this far, there is no driver for the PHY, we make
use of genphy.

> > And why set irq to phydev->irq?
> 
> If the above operation can fail with -EBUSY, the wrong IRQ was restored.

How has it got the wrong interrupt?

genphy cannot use interrupts, because interrupts are not part of
802.3. Device tree can list an interrupt for the device, and if the
device specific driver is used, phylib can use that
interrupt. However, since interrupts are optional, phylib defaults to
polling.  phydev->irq is over powered and set to PHY_POLL to indicate
polling should be used. The phylib core will look at the PHY driver,
see if it supports interrupts, and if not, set phydev->irq ==
PHY_POLL.

The binding of genphy to the device cannot fail, at least in the
current phylib code. So up until recently, setting phydev->irq to
PHY_POLL was fine. However, that is changing. There is a use case,
because of bad hardware design, that genphy is initially used to get
the device up. But later, the real driver module becomes available and
gets loaded. /sysfs is then used to unbind genphy and bind the
specific driver. Because phylib has set phydev->irq to PHY_POLL, the
specific driver cannot use interrupts. So on unbind, phydev->irq is
set back to the value in the MDIO bus.

As is said, this code is fragile, and complex. You have to assume your
LLM is producing slop, and really take a close look at the code, if
you want to get it correct.

    Andrew
