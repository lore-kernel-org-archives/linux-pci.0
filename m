Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216189;
	b=gwne/rXXPA7GS5EQd4T9sm1FKdCSVT+kUJp+lW27nIFJt+aTT7nYLzX0IL4h2834ERLP
	 LkLxjzLr9z4l+KFX0pnBcainOs4FfNvPlOcNLdqFz28KVvXgQSn//hZRFIiOsylsEBQ4A
	 f6bHuy8TpvaXW6F5N826efAWs38IWB7xvtV9SfVXvzhyEyyLQihUO3l+Quz7vmBvvr3Qh
	 ayoMvV7iaw1AWm+zt4nxCmB2xHwZP9riiQktcIngaROR3ga4mVmrCbAAwmgGPf3z3GcMH
	 Kxo3vmHLdOr/ZyhqYH6qCEJb1739opxgkj8YpptcKGxNQzg05STpvXKtLXLD6GNdj2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216189;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3a6/w1xWJzr0AfOc6H7D9LndxRKnZcP9ByrmJVJZKlg=;
	b=4b4GDCF1BWf7T+XQ2osb3z4KXHZNEOmqh3P4f24YGzd0AXuECnlZQBS+y311ic2WUSqr
	 1u/E/4/0TTMgjORVRUD7+L7X1docHDUp1cQu42SjFoFXpHTKmWmM2WcLQgJg9UyDRCOvS
	 /qQ1AZDEtb3FVW3F1WHa7f3ulxKwMPS0CeChsbqqNVLfNOniVaZCKmgT+j0cN/L2oADrO
	 hOJ0DGvpP9crDLiCklYgbL0IT2UYtBxdNNIEfTbrrQc18QkKXm27/NQY/cAYZXwdT5jYK
	 1yl+XGBBlvDNEU3Y3xDBY5QBWYiwBCPN0iNZSnyxY6fYGqBDB9U7UQDGdWuLgE0MLsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPerqchO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65012606EEA1;
	Mon,  9 Nov 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPerqchO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C70D1F0089F;
	Mon,  9 Nov 2026 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216189;
	bh=3a6/w1xWJzr0AfOc6H7D9LndxRKnZcP9ByrmJVJZKlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPerqchOgRaBjw8X4fE92dxajm9AqaZxq/CWymw4Q92RQ0WDcbFVO1k/1PNDbaxcI
	 hGT2oMS+lRCX8Zhan8FgyX3B2GyGobWKynYHS/ynXoApxjg+DTgow/J3R6Jf6EN4uN
	 /dWDbNcHJUTRN2JieRsY+YReAOL/18x838383G1sdN/cfFv4qcUu/eSWCjlVfJ3VeD
	 n2DWeW81faiyxdDwq/o7AhuCqzQFbH4a1/fxSxT9FBJLVQBqSK9BYPkasSXMg9hQ1g
	 AHBaXva0eMOPfkUu4wYtOVUyc1s/KgOuS0Kr0ybeBztodfszj/JpEpJ+oegaxOvTRW
	 PyG1J9kzrpLCA==
Date: Mon, 9 Nov 2026 11:23:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
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
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <20261109092304.GC8635@unreal>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
 <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
 <20261105184442.GF8298@unreal>
 <bf756e50-c77e-40f2-916d-e88887426806@rowland.harvard.edu>
 <20261108110909.GA8635@unreal>
 <647f3199-909d-425f-b485-b598a18844d1@rowland.harvard.edu>
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
In-Reply-To: <647f3199-909d-425f-b485-b598a18844d1@rowland.harvard.edu>

On Sun, Nov 08, 2026 at 11:59:11AM -0500, Alan Stern wrote:
> On Sun, Nov 08, 2026 at 01:09:09PM +0200, Leon Romanovsky wrote:
> > On Thu, Nov 05, 2026 at 03:04:18PM -0500, Alan Stern wrote:
> > > >  it ensures that the lock is
> > > > acquired when the driver is bound.
> > > 
> > > That may have been your intention when the patch was created, but if you 
> > > read the patch you'll see that it includes a whole bunch of material 
> > > not related to locking during binding.  Namely, this part:
> > 
> > Once I added `device_lock()` to `bind`, I had to add it to `unbind` as well.
> 
> Obviously I'm not making my points clear.  Let me try again.
> 
> The entire patch description, as you wrote it, is this:
> 
> > Interface claims hold the USB device lock, but device_bind_driver()
> > requires the target interface lock. Without it, trust-policy writes  can
> > race admission.
> 
> This says nothing about holding the interface lock during unbinding.  In 
> other words, it isn't a complete description of the patch.  It implies 
> that the patch changes nothing outside the device_bind_driver() 
> function, which isn't true.
> 
> Furthermore, the patch does not change any of the code in 
> usb_driver_release_interface(), which is where unbinding takes place, 
> because that routine already takes the interface lock.  So to say that 
> you had to add device_lock() to `unbind` is not accurate.
> 
> Instead the patch adds a new usb_driver_release_refused_claim() routine, 
> plus code in usb_set_configuration() to call the new routine.  The patch 
> description says nothing about either of these things.  Not to mention 
> the fact that your other changes make it now possible for the driver 
> core to delete an interface claim when the interface is registered, 
> something which was not possible before.  This is another inadequacy in 
> the patch description.
> 
> I'm not saying that any of the code is wrong.  But the description does 
> a very bad job of explaining the new code.

I hope v2 explains this better. I also split the USB patch further.

Thanks

> 
> Alan Stern
> 
