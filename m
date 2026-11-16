Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831072;
	b=CgD79C9EbZqbQdb056FQSlsEeaHs8MwfiT9uEX2NUr6KftHEU9qfmSyLqCYkhfrZTzYD
	 C96/MCqywQqeyXIvZ+5whi3j7qZQ6oEL1YwVVzKwTa0tqiXjtX1QUQmllGtyX6Os2xC5Y
	 RU/eVtFC4dIy+TnTyLzUXtwFKWNCy0ot+mlrqx1/ygmXc4FJcwUwi9uTw1SyjPebesGyO
	 ib+lGMaOPV/H+BPS0tLJ7tYD1yyWQ6BeN27gNOubsZrXSuJ7nqkbv2icIYTrkw3MNGkmw
	 wZopufI9GJA2ESS16RDwj84nKJTYWo2rxqXOi54M5mBcgxX+YWSNmyde7k5ZZMbvANg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831072;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=d1QNaqA4UuxT165UtFo9MygMRqXbXgGBeQ/kJMNr1F4=;
	b=xGYMSqwMFYHMGZcPCU1WsO892slI06zNDHiZR8SDVELP9lb+dSmPcHCAVi1qPPMftqty
	 1ULWGMVHV5kc3OiKeiqJf29Y92qz9ZtpVea2Dk3oJK0iRRW0pKiqIXYrFvEKiJi88WDRm
	 bRmgMXDxPgUowTngTFa+DNmWjVJ99nPEUzwhepuR7s9nhTTfoaBaKSMe5tBOeSRyfmLR8
	 Wz7YuVURdqyX1gCLJXtyo/Hzg3suGvpttPczcPtjGntW7LmYuk/xbFuXI7+FXfUBdZsxJ
	 aI4Wp80trDIUod6XAWJYFpHMBbNEkjceodSHinbusnmpHT/oAccFjm79tDB9cJjOm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkukwzGb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9C606A31C;
	Mon, 16 Nov 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkukwzGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF391F000C5;
	Mon, 16 Nov 2026 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831072;
	bh=d1QNaqA4UuxT165UtFo9MygMRqXbXgGBeQ/kJMNr1F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JkukwzGbEvTcRYQiQbZwmA/mk2PVHTyXM6F56jbB+ZEQcpOrHLIY5pxO7kKiM6rQz
	 0EwP5ZgG9DLK7jFGiSx9rNSP3jecoIEKdDYTO14xW1IttoAG5v+N1Aez3pwlJjjX4h
	 b9xMXEbfDclbyVeamtQyzfwSgbEfbMjF9uY6+FyAidTnAxdoFPAPVSLekGMi7QSJU1
	 emdILX1T7g10aAXHkb+Ax2GF/b+k8KVztp14ydhiNTchkHtPM7YD2i4zOANkI1QD4j
	 LDuHomhf5257ArYnxVdxwLVpbtGt22Thq3Isp2WsCen8vZYobgCtY7pslu+Kg9qXRm
	 chRxB8ZndPC5g==
Date: Mon, 16 Nov 2026 14:11:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v2 11/19] driver core: Introduce a generic device trust
 level
Message-ID: <20261116121108.GK11319@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-11-3b12d9a9f861@nvidia.com>
 <de5772b3-c340-4822-a49a-1434ece1b144@ozlabs.ru>
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
In-Reply-To: <de5772b3-c340-4822-a49a-1434ece1b144@ozlabs.ru>

On Fri, Nov 13, 2026 at 10:30:23PM +1100, Alexey Kardashevskiy wrote:
> On 9/11/26 18:33, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Device setup needs a common operating policy before driver probing or DMA
> > configuration. Userspace must be able to hold devices disabled until it
> > authorizes them.
> > 
> > Add generic trust admission with an immutable global boot policy. Restrict
> > the compatibility attachment API to explicit global full policy and full
> > operation, checking admission before probe. Keep the operating level
> > stable until teardown and retain normal locked admission for other callers.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> this got many CCs except the one where I was (eagerly) looking for it: linux-coco@lists.linux.dev :)

I will pay more attention next time and will CC CoCo list.

Thanks
