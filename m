Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231961;
	b=Rf0GXU50lNAA0degP4eXZZsWpHm0onGA6NkqP5Xd5QXqPz1rmINOkwlasDN6LS1tLOZJ
	 tjHw/FyI9xniWc07SfqObbTXhtFt6bOAHA/AYoaMGi6NL5NqnkMuPiG2smVkHPVZG9BiJ
	 vBnpvNyqVsvSRsP7nAU07punrcDN4ayZkldHfubig5yf/Nn2oTty3tSiI4g+lTbWI7X5m
	 +neR36wv3pcIa7B+tDN0bQmBxKBupa3FmV5H8Y/BpEHw5k0LGcYkwWg9nFPtvqpPcZxF7
	 ypSiCioFZ/E7k2/3Eys34nLM3WQ19CEeMVTqrwp/vGV0c9yCJjq8oaJk3UGDGV09GgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231961;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=2IttIcKgL0vKNhvKWk69gg2kUvNLqT6VNsboFSUg3kk=;
	b=aB8NikLz073EmY2uD/si/fa6LHzymTtJoh4Ifu9joLLjm/YLmJDTZp1JAtXCklxC/3OS
	 q/0XQol0ZQ6WJuQ28rb0Ts13HOzQ/l4qBzuWjm1Q/miP8jFl5+H9YSPtu1o+qSjxCjTl2
	 E4RHLlN+1jJ3hKbbl0T4jDpbO8fzM9ibJUrEFVBM74ClFRQY4Qg0qvgnI3XZlK8yCLjXB
	 uopHh45tX00nJgyK9L9uwpqwBanZRZIcwBnE7H8qNx15HClWh4/LFPGXM9siQND/DHH0E
	 /BpNRDeMpxtZb8ZMwpjhnItsjFLXqvF368e3Rxu9bV1x3EuUId2ggdJRuhcDufA8YMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=vvkpw5nC;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D7606D806;
	Mon,  9 Nov 2026 13:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C18D7606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=vvkpw5nC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2IttIcKgL0vKNhvKWk69gg2kUvNLqT6VNsboFSUg3kk=; b=vvkpw5nCLudUCzq8Vifb2DqkGx
	kGLbNSsg5SNGbUF/8eDZn3RbuZVaYN8yuFMCNN2LAuq766lfIQCtDmX4spECzkj0HnP+c+OqQ9JDg
	3SbUlhnWq+AuSrWJRvoa+pF8GnEv8+SzHYUyhyd9DTaD3r5wNDWeQrzF8ZFAL3DUt7bs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQPgl-00FGEi-MR; Mon, 09 Nov 2026 14:45:35 +0100
Date: Mon, 9 Nov 2026 14:45:35 +0100
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
Message-ID: <ab062469-ece0-495e-8486-78404c580cdb@lunn.ch>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-10-3b12d9a9f861@nvidia.com>
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
In-Reply-To: <20261109-device-trust-core-v2-10-3b12d9a9f861@nvidia.com>

> @@ -1956,11 +1958,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  	}
>  	phydev->drv_owner = drv_owner;
>  
> -	if (phydev->is_genphy_driven) {
> -		err = d->driver->probe(d);
> -		if (err >= 0)
> -			err = device_bind_driver(d);
> -
> +	if (bind_genphy) {
> +		err = device_driver_attach_full(drv, d);
> +		if (err == -EBUSY)
> +			irq = phydev->irq;

Just looking at this, it is not clear where the EBUSY can from? And
why set irq to phydev->irq?

    Andrew
