Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072696;
	b=MFcRk3HbZttDSb9YFb9/l1rxWJbe/sd8zESubT5W82Orsf3FxyZdlBDc7oW7obo6B5az
	 BD15cu7VrgioLTq77HNvyPF77gjypGLYEgDvoDwK3rGR4x5zFsRrT6ToQ/fK2MwunrReO
	 Myl0XvdnmlqjggXkai0cuiSedUy4ywP1oREWgrp2UDePs3ivbnVP1ieuXTkf3bBTYnAt5
	 S4QvJQIlM+oM4vzfy0QFre5O1didaO+rGImRRSqcAJRAFkf8I+YMab5cqM5idzWGPkwAl
	 OOIEcR4Q0GzqIMPDesiLHdeVIyOLC+Y2hmlT1Q4e4KdlZbOYHpa9NW1Scc+RJgA2zQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072696;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=APuvn7f/7sMW86yp8ozwMRqfBj0JO9PvrdgmAwgAkXc=;
	b=VyR3HPweDGlkcRHEhgyHO0XM0aQuXf21yjbO1ZZxC5fUz+36oN3nGALUqxwNz2SQ39Q+
	 4/Nt55b7ek55S6ew3gdfbIt4YLp2h7dFr9PDCpKdkggPaByl+qc3porw++3jmoIaBU8e0
	 Jy3Oqm1s6ZT8O1mP6TA34cupTPhwvRfi6bDHNYZHqc6e72WTufRi9/kK3QL6O7LHDi9dH
	 j2Ci7KwkHaUQZ+/tidgdgrcFOK7nggGmapmxbSFHKxQO0xuRtpFaoYzFcbKDYAVxcje3x
	 1F7cqEtzyVqiYy1Trf6fYInmUdzEoV7amAdWygLEqA1p0ihUodEtYEyqt/ZTYL1K8Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuLJV8fV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D5606A324;
	Thu, 19 Nov 2026 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuLJV8fV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADF91F000C4;
	Thu, 19 Nov 2026 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795072696;
	bh=APuvn7f/7sMW86yp8ozwMRqfBj0JO9PvrdgmAwgAkXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nuLJV8fVc2D0MrbPEKZ35IXVmf8L6ICWqA805Tk7LAAIPJx7UCKjmZxc59fyigx2g
	 lXSSphsOzAQfsebmstu0+O4eMgGF3exHrvIfhuxGoLmOWey18JBKmVK1Xw/VyHaPsZ
	 hfSjl8WYYm65pvvel75Be0ysgbB4Ky87xuvAoyV/SvuqTIEdmRvPaiJ7T4S3a+bVQR
	 nIn2nQUotBnrGo9Xzn8ESPCAU8Vj6UhKaMIFf33OD9RSf1ChY6r0xVN3/BxnU55Hlh
	 R9hY6EZN2X9huqMJHvsXgm3b3LVgn9x4FSZvgXfvSUj2AY4v6IcCAS4emNvE/VqD+b
	 R2bmr+esy2LCA==
Date: Thu, 19 Nov 2026 09:18:11 +0200
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
Message-ID: <20261119071811.GG162713@unreal>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-18-d655875c4bfb@nvidia.com>
 <71c1b931-c553-46e3-b49a-51167f168ac4@lunn.ch>
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
In-Reply-To: <71c1b931-c553-46e3-b49a-51167f168ac4@lunn.ch>

On Wed, Nov 18, 2026 at 09:21:45PM +0100, Andrew Lunn wrote:
> > @@ -3813,6 +3809,8 @@ static int phy_probe(struct device *dev)
> >  	int err = 0;
> >  
> >  	phydev->drv = phydrv;
> > +	phydev->is_genphy_driven = phydrv == &genphy_driver ||
> > +				 phydrv == &genphy_c45_driver;
> >  
> 
> Why do this here?

This flag marks that driver is already probed, which is reliably
happening in phy_probe() under right locks. It was the easiest
way to battle AI reviews which don't agree with how PHY subsystem
performs driver bound.

> 
> It also makes the code asymmetric. If you set it in phy_probe, you
> should unset it in phy_remove. At the moment, it is symmetric,
> phy_attach_direct sets it, phy_detach clears it.

is_genphy_driven management was moved from attach/detach to
probe/remove, so it is not set in attach anymore. It aligns now
with how phydev->drv is handled, which was set to NULL phy_remove(),
see commit 00db8189d984 ("This patch adds a PHY Abstraction ...").

So I would say that now it is more aligned with what PHY does and more
symmetric than before.

Thanks

> 
> 	Andrew
