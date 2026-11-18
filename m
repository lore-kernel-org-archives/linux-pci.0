Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033360;
	b=mZlSlaww0QcPTFEv0D57H59aVHpgj3PPnVFMudMQZvfeP+KD6ZGkagSM8OCopWmWEu/6
	 QFP9ezCUCUof7aI1GqrbRjkgG+TH/mJkCqJ/wEvtlYANyb6B1hypFbkYBeOnpjCOOyhZo
	 wrdwwXPjXU9qke02DziOtzUOzhbGYUCAvNZHQA/ZGLekMSULm9vloNrAMft4sbpFhcrnF
	 tlL5lVCShA0ZOzUbP5XrQwmGlXPJqlkpYoiJWUaIAxVmzLmbeg5Mze71ouznUVnqTZBXV
	 9/Q5vgeEQgYppjmPC/Pr2jGcjDQZ+E4jHDTDEHh908CnB0u6n9+cFyOXFx6XZm9ccqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033360;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=83WZjXw0m9X3Ou7HW+EzfUQVbMPBRYNOgGwn1hvvtI4=;
	b=h+LwGdqoCMwaQVDZ45kdQSCBT6jz7n2m6Y4WRlF5U7gA0MGGVHMDVTnKCfHnIoEPyzo5
	 kbc+Hd5Kdw7b4K2FbQQJMVigT1aP84DOy0A16vIyj2SBFiNtSoOZRMVXfOn0H0C13QtRD
	 JFoorYSTXrG019wYdFBErcuOzqOKP6ibnMxQOfO1wN7TPcjh/6S1Bccx940oRBttPCR6o
	 kgN5CxT6R8g8IGShx2xZJJPLq5rmMIsZ1plhNI1Y7qy3mhjenNcd0JBlBSagXL7fhpLrl
	 JqLgvJyBg7LtDT05asLI/snmvk+mvQyqAHCYGg6wM8fP/1kUiuNMV+FQSrzHHURH+Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PDzvVA0d;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FC606A31C;
	Wed, 18 Nov 2026 20:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 627FC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PDzvVA0d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=83WZjXw0m9X3Ou7HW+EzfUQVbMPBRYNOgGwn1hvvtI4=; b=PDzvVA0dUL6X8a07m7W3FtiHvq
	LePg1RVFpWzznF0js/ikqR1IzilBKVSOUmy8h9aKRnAwxpYoxqprli7vjNifq9IrxVN+EUiCgaPNG
	4rQZEsMDX0Xmbd6Ah6hLNSO3HY0lLWTY1/+eE0gbxcfsyM8B16K+idR7+paawH6C6Uiw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xTmA5-00HVa7-0i; Wed, 18 Nov 2026 21:21:45 +0100
Date: Wed, 18 Nov 2026 21:21:45 +0100
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
Message-ID: <71c1b931-c553-46e3-b49a-51167f168ac4@lunn.ch>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-18-d655875c4bfb@nvidia.com>
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
In-Reply-To: <20261118-device-trust-core-v3-18-d655875c4bfb@nvidia.com>

> @@ -3813,6 +3809,8 @@ static int phy_probe(struct device *dev)
>  	int err = 0;
>  
>  	phydev->drv = phydrv;
> +	phydev->is_genphy_driven = phydrv == &genphy_driver ||
> +				 phydrv == &genphy_c45_driver;
>  

Why do this here?

It also makes the code asymmetric. If you set it in phy_probe, you
should unset it in phy_remove. At the moment, it is symmetric,
phy_attach_direct sets it, phy_detach clears it.

	Andrew
