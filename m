Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095092;
	b=oiFU8PF0uZ9f346quLFQDEfXUPpT98gW9AWGuaDWyRTVu5b3K4qq6qKdY3vk9TtfWtu7
	 T9OB2wcOTVYqfW5WZTOQi8RrzSMMaMK6ibGFKUt3Jd2CymDRiBXNDp4dRSMZuLsegDN8g
	 LsOKOcOxgxXSrZh3yeJ5IBbwfGlG1LoALg/0yt9E6+zKFyGiJ4qxEISrZHFVijsx4KbSn
	 i+88lq5uTkKPbyeQjjsXOx+dDyEPEYeUhLsYSR1MjOMydYoYleUi2cjZUldcBUYgsu2uP
	 prSZVWtO5dISyk72NExduSGdzSUtoUahiU+dubDsTuX35QAcqYdDK51h5dXftpp03Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095092;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=j+Za7bMQTz/jGW5KKJ1wZv8OZM3LMy2RfyXXPrr5ddk=;
	b=ZdRUG3+cmj/6Oc6tD2jZ7NaPDFMu7XSpV1cnBeAyPmzZJC8OhoHyW7EJbAT3yHHqNVMO
	 8WJiVZTI2FNbzt4feN93k9TPaU2biv2oRotTRdIQv8+2V2NS5Rt4Qef5UesPVhEXoh8kf
	 sKkDtwP1D3efcTKvIW5vbyv3KxUv+BSDN4aIU1KONoWLrkOmbz0IjLKkeRCzvOHJv5iBZ
	 JjAvwSNITlHcUr9PxlBFSu279Z1J+ud2U4W2OfEblxOFRXHOwCd35mqBb0K566OEJrLb5
	 FQmAkSd32+DY1iK0m+iMr8Qd+WWQbc4wHejy0uzQP5RDwAcNby8ZXYYDA/n4APpB9Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mOPIqIOm;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE8606A320;
	Thu, 19 Nov 2026 13:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CE8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mOPIqIOm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j+Za7bMQTz/jGW5KKJ1wZv8OZM3LMy2RfyXXPrr5ddk=; b=mOPIqIOmu6kDdwVuemWcNK9Dnn
	3scHm6yoxWlXhjKDg88oGkRMzRyRggfFiPC7IQHuffZ0g5VsQiVACcLcbYFf/YJimxzK2sEH4Ma7z
	s46ArUotTLBJyzxjIYKthUVRWJnOH1H0QxoK1FCOjd282vF3lK0QU0S6Yx/wpK07j6KI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xU2Dn-0002Ui-FK; Thu, 19 Nov 2026 14:30:39 +0100
Date: Thu, 19 Nov 2026 14:30:39 +0100
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
	Chris Lu <chris.lu@mediatek.com>, Mans Rullgard <mans@mansr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cornelia Huck <cornelia.huck@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 18/31] net: phy: Use the compatibility driver
 attachment API
Message-ID: <7c87310f-e1c6-4a84-8161-11a6e5d91785@lunn.ch>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-18-d655875c4bfb@nvidia.com>
 <71c1b931-c553-46e3-b49a-51167f168ac4@lunn.ch>
 <20261119071811.GG162713@unreal>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119071811.GG162713@unreal>

On Thu, Nov 19, 2026 at 09:18:11AM +0200, Leon Romanovsky wrote:
> On Wed, Nov 18, 2026 at 09:21:45PM +0100, Andrew Lunn wrote:
> > > @@ -3813,6 +3809,8 @@ static int phy_probe(struct device *dev)
> > >  	int err = 0;
> > >  
> > >  	phydev->drv = phydrv;
> > > +	phydev->is_genphy_driven = phydrv == &genphy_driver ||
> > > +				 phydrv == &genphy_c45_driver;
> > >  
> > 
> > Why do this here?
> 
> This flag marks that driver is already probed, which is reliably
> happening in phy_probe() under right locks. It was the easiest
> way to battle AI reviews which don't agree with how PHY subsystem
> performs driver bound.

I've not seen the netdev LLM do a review yet. It will be interesting
to see what it says.

   Andrew
