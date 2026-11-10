Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296364;
	b=amEIUw5xTzTzxpFNvYfyF2pPAlcInmfsFMcVeeX6dTG3KrElCUDY/4GOh5+CudDgpiHK
	 fwl987UaynHn1ChnyJzMXgsBmOSPzw0YSzKd9JosEDUiLHSQqD5c8m/3dxg1bxwe+tuFL
	 9nI+8fuho4UjOwZFIKzhpAwhqgUOnhMd9Ppfu/kc1aZ6N0I2UyvACFq1y26p/Jd9FxlmV
	 yAWSv0QkIKvnlbU3PL1scefQP4ZWl44gChBcHnhmxAXXz3X+0ag91ny2l2Dw4HG6rPfYo
	 LCLFp7qpkCzQDmL+TN9CHZiZai944MnPIfUkMeUoWwd1R2NbfgwWfHJJqbgrITyNkgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296364;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=DSBlFGn4E205gXuccBzZwAAPl+yDbfuCcd3h0VNHPkE=;
	b=Ye92w12yqLwPR0BzL7dvlJW1tsryX5c/jTvgNuJfrT/WDNXA+PYHusOvKFMhiVZh63qv
	 s84dQNdF51lq4ULHOS9Z2i6gQP+wmCeuUglK8R/D4Pw0RKwongEnPfN+rIke8OkVkc2PF
	 JfPbaCvff5VlaAT1uZ4rz3NFbvxXWOhtNSR96jPUebHNwWWYN3Sm0q1Zgy60s/Z2Zp8eh
	 0E9C3xaMa9WbMxBME/QGhDTIgzjTmxz/v+7+/nfw7l/IQW1zyu2eS9SEIG9DaLQ/P4ydi
	 G8jEw9ovVkjBO00FQTHoZSTcHY90uWdtjBdpONnLvnTb752othy8JRdc9qUvlRVEA4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cua8L9GY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2F606A31C;
	Tue, 10 Nov 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cua8L9GY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1DB1F0089F;
	Tue, 10 Nov 2026 07:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296363;
	bh=DSBlFGn4E205gXuccBzZwAAPl+yDbfuCcd3h0VNHPkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cua8L9GY35tzd1wvxIkoHZWoj4b+Jnc4MmmXSS4xz1DMOhF7fnMzyvLCmrsGBqGj1
	 Jb3832ICvaaSkhpxHKzVktwY0VN55YFhe3ayOJkh72n1kK3xADULAH5Ox4aWZpDvso
	 SSbBNIbDYBnbE0pl1xpHF+Szz6q8g2PUN/I44F2G4akFrGsrJgkxavsbYV78rdzpjx
	 zQNz+Gl7ioYOpICsUTt7r4k8bgeTs/LlSH/W8tT7ufcmOxtPXhedsyuDUNY/5l3SKw
	 qP4k1ZQswUJUdtBBrFidqv9eamm01YnDLo/xUXPHRAgRbSU5FtK+emGYhLCVNfCVFg
	 cz+s7VuHGQF/w==
Date: Tue, 10 Nov 2026 09:39:19 +0200
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
Message-ID: <20261110073919.GF8635@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-10-3b12d9a9f861@nvidia.com>
 <ab062469-ece0-495e-8486-78404c580cdb@lunn.ch>
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
In-Reply-To: <ab062469-ece0-495e-8486-78404c580cdb@lunn.ch>

On Mon, Nov 09, 2026 at 02:45:35PM +0100, Andrew Lunn wrote:
> > @@ -1956,11 +1958,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> >  	}
> >  	phydev->drv_owner = drv_owner;
> >  
> > -	if (phydev->is_genphy_driven) {
> > -		err = d->driver->probe(d);
> > -		if (err >= 0)
> > -			err = device_bind_driver(d);
> > -
> > +	if (bind_genphy) {
> > +		err = device_driver_attach_full(drv, d);
> > +		if (err == -EBUSY)
> > +			irq = phydev->irq;
> 
> Just looking at this, it is not clear where the EBUSY can from? 

I relied on the comment above: “Assume that if there is no driver, ...”.
Since PHYs do not use the standard automatic probing mechanism, I have no
way to tell whether a driver is already bound.

> And why set irq to phydev->irq?

If the above operation can fail with -EBUSY, the wrong IRQ was restored.

I checked this with AI, which says that -EBUSY can originate deep in the
driver core. It may be better to remove this special case and rely on the
PHY's guarantee that no driver can be bound concurrently.

Thanks

> 
>     Andrew
