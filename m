Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322724;
	b=lWnrTLMsksh/elxxGURgrZyMWybzeqxhyiNpaIuGzqRzYSRnk6M13jDaXojI46qq+efb
	 qMTlIch+ml5jHZ4fb8DmqkR0cJFmfNyXlcELEGT6Tf1fYM1+JPUh4GconFAedB5JrHbHj
	 R3nBBtdkpYBamCntJrdi1UCaERFqDS45sdPclsfIGdxSFoDsPLzzlEZjCn6GioCpfsab0
	 yTV0C903vUnjwDfgOKcRAt2Xwg6o4M4gMKJh/UQQqNecD+EWpV5dNVo6PS9fAENBkoVzA
	 UUvGWy6qq0x5oA1GXo14AZIt2HnzggKwZgPf495Ph4zAzD6qJ9h7s/tW8YErhIo/uCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322724;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=tM0VlaEE8Hm4AV2LmNn9XxetntusdncCzYCV4dQnv+I=;
	b=I8XogMkJxcxvfDQbyuy9mWKmHXbssvct/ZwPGnkby4RqoVA22pHbstNTqJnvuL+64cCS
	 qKuEa3lrVZJmwA5VrX4oy4PBM8vROl31639mKmoyyx6ix7RtJHInMoEuLevrj71H5/Vps
	 aLQn/6Gl/Yytp7BccV5btZUNYVBxpMS/ej+FQJXl/WJ8oH2CJCNoLhcko4ME4JbFgr5Oa
	 GaIP3hRlarlsfYcC8fuV56VB6z3td8VM4k85/4ioJXswxD+s3uY106/5w59gV8F+1B0QB
	 coatnUgKJNJSIoRlx3O1acdzb4Tbn8G/Duq4/0oPPZ4HfDwpHKtuWghTmaWaDcA8lJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQA9PJv0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7D60A2624;
	Tue, 10 Nov 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQA9PJv0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BDE1F0089F;
	Tue, 10 Nov 2026 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322723;
	bh=tM0VlaEE8Hm4AV2LmNn9XxetntusdncCzYCV4dQnv+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AQA9PJv0ksr0R09Jj0CUrcfkHSXYBK4F28o8m6CiMYTG/g9/KCHzw3ScFpsl8KHBn
	 IqR5F+5PdZW/FmiQE5hyG29Lzeqw+6oVbvf/T66VmVbH6qX4xDQsmnQP4JL1Zxz1cG
	 HcVR6UVWB0lPyXOuO2W13chI8iBCDoJd9h9o6HPo0VeGfRKefSE8g3rzFtW3SMz0ih
	 SzoL60sWHcZpYx9A8pICN24SG9Tfxgo9VRI3IPRWNgLxW2qBUU3IN0fzxr85x+mxlk
	 gJ8kIj0CwgkJ7pNfVNYYt2T2RfA/IEeZ9/nu+9CpJ89HiVlO9DCubyth7h4DhZygs9
	 tG+SC80+N19Dg==
Date: Tue, 10 Nov 2026 16:58:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20261110145839.GL8635@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-10-3b12d9a9f861@nvidia.com>
 <ab062469-ece0-495e-8486-78404c580cdb@lunn.ch>
 <20261110073919.GF8635@unreal>
 <019fceab-1b0b-44a5-8cef-1f77d7d6ac07@lunn.ch>
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
In-Reply-To: <019fceab-1b0b-44a5-8cef-1f77d7d6ac07@lunn.ch>

On Tue, Nov 10, 2026 at 03:31:15PM +0100, Andrew Lunn wrote:
> On Tue, Nov 10, 2026 at 09:39:19AM +0200, Leon Romanovsky wrote:
> > On Mon, Nov 09, 2026 at 02:45:35PM +0100, Andrew Lunn wrote:
> > > > @@ -1956,11 +1958,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> > > >  	}
> > > >  	phydev->drv_owner = drv_owner;
> > > >  
> > > > -	if (phydev->is_genphy_driven) {
> > > > -		err = d->driver->probe(d);
> > > > -		if (err >= 0)
> > > > -			err = device_bind_driver(d);
> > > > -
> > > > +	if (bind_genphy) {
> > > > +		err = device_driver_attach_full(drv, d);
> > > > +		if (err == -EBUSY)
> > > > +			irq = phydev->irq;
> > > 
> > > Just looking at this, it is not clear where the EBUSY can from? 
> > 
> > I relied on the comment above: “Assume that if there is no driver, ...”.
> > Since PHYs do not use the standard automatic probing mechanism, I have no
> > way to tell whether a driver is already bound.
> 
> They do use the automatic probe mechanism. But also extend it.
> 
> Maybe some background will help.
> 
> IEEE 802.3 specifies how PHYs should operate, it list all the
> registers which are needed for basic operation etc. If a PHY follows
> the standard, genphy is sufficient to drive the PHY.
> 
> Now. Networking vendors like to do two things:
> 
> 1) Do more than what the standard specifies, like interrupts and
> blinking LEDs.
> 
> 2) Don't closely read the standard, and break their implementation
> 
> These two cases require a specific driver.
> 
> There is a lot of history to phylib, from before my time. It seems
> like the current model was retrofitted around earlier code. The result
> is that when the MDIO bus is enumerated, PHYs can be found on the bus
> and are registered to the bus in the normal way. The driver core will
> look to see if there is a driver which matches the ID values in
> registers 2 and 3, and if so probe that driver. If there is no
> matching driver, a call is made to user space to ask it to load the
> driver with the given IDs.  That operates asynchronous, when such a
> driver is loaded, the driver core will run the match again and probe
> the device with the driver.
> 
> Because there can be up to 32 devices on the MDIO bus, the MAC driver
> often knows which PHY device it should use. If not, MAC drivers
> sometimes use the first PHY on the bus. It does not really matter, the
> point is, we know the device exists, even if it has not been probed
> yet, so we can get a reference to it.
> 
> The MAC most often connects to its PHY during open(). At that point,
> if the driver core has bound a PHY driver to the PHY device, it is
> good to go.
> 
> If however, there is no PHY driver for the PHY device, it can mean a
> few different things:
> 
> There is no driver of that PHY because it follows 802.3, and genphy is
> expected to be used. However, genphy does not have a list of IDs it
> can drive, so the usual probing mechanism does not match it to the
> device. It would be nice if it did actually have such a list, but it
> does not.
> 
> There is driver, but it has not been built, or is missing from the
> initramfs, or is not part of the image, etc. So we just use the genphy
> driver and hope for the best.
> 
> So, if we have got this far, there is no driver for the PHY, we make
> use of genphy.
> 
> > > And why set irq to phydev->irq?
> > 
> > If the above operation can fail with -EBUSY, the wrong IRQ was restored.
> 
> How has it got the wrong interrupt?
> 
> genphy cannot use interrupts, because interrupts are not part of
> 802.3. Device tree can list an interrupt for the device, and if the
> device specific driver is used, phylib can use that
> interrupt. However, since interrupts are optional, phylib defaults to
> polling.  phydev->irq is over powered and set to PHY_POLL to indicate
> polling should be used. The phylib core will look at the PHY driver,
> see if it supports interrupts, and if not, set phydev->irq ==
> PHY_POLL.
> 
> The binding of genphy to the device cannot fail, at least in the
> current phylib code. So up until recently, setting phydev->irq to
> PHY_POLL was fine. However, that is changing. There is a use case,
> because of bad hardware design, that genphy is initially used to get
> the device up. But later, the real driver module becomes available and
> gets loaded. /sysfs is then used to unbind genphy and bind the
> specific driver. Because phylib has set phydev->irq to PHY_POLL, the
> specific driver cannot use interrupts. So on unbind, phydev->irq is
> set back to the value in the MDIO bus.

Thanks for the explanation, I definitely lack knowledge in phylib
history.

> 
> As is said, this code is fragile, and complex. You have to assume your
> LLM is producing slop, and really take a close look at the code, if
> you want to get it correct.

The problem is that I also assume that the code preceding the change is wrong
too. People often produce code that's even worse than what a properly guided
LLM produces.

Thanks

> 
>     Andrew
