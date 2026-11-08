Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136154;
	b=l1skM2H6YGtYQuaaILNdCsvpZ6qCIT8aKpK3+CXVBWuBnLcIv2+iJT+9PY3I5bFaszms
	 5hGhhWM/RPJK2MnLHR2zKz+pDs8tc6Zv3EaIVNC31Tp6fKMVL6Ff/Qa4a6SIIsEJGytca
	 bQKMwSaP5UMpfY4sRcdDJ5rZptHykZ4F4l7QRar9ACco4fYYjeibyYAcC28lU3r1LG0AF
	 BBfuM/tQYS8mko/u38oEStvC/IShILZMOL0Noit3CK5guQz7oSd4WGvciy2wzXsQAjCQf
	 mMtX73ZOVOLk8s2w/KIOnDxF3LF+yITMLJkrSor86KuuTZ7GaC17xsZURANqrsx0WBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136154;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rRMDSUzD/4dqXKQ7EKZyKnxoCi/M0piqkjg2dM9fwCI=;
	b=1ZRCRebOhBeS7O8eGQabP124RSjWW59es5u+++aT5TCVmq69xg1SbVKqyDGN7QtVSF1t
	 5sHQ8lkim3CEQfkw3JHrlaBxVdP/6L0M0M+VLDx7x72/DWrE9g34buOXaXkksBg2JqU4j
	 nxAGA7kAFiyGB4QVsoQSp/2+6kZ36uI6ertqwTFbYqmWTVrqZboP3VrBbsZut/rHNmuWD
	 DMv+bmNZkEsRXoJny/S4Qz6V5mbrM8sjx37bnusqfqUmBvOy+aCyHiQierIQ1yMVaUkHP
	 7dkhlQ4LcGjczgLce5Ynd5bHZhsQQwpnBln+5KZyr7wDFH5WNtjJK3DvdhT6/O/N77g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0YYA4cp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF4606A31C;
	Sun,  8 Nov 2026 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0YYA4cp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFD11F008A1;
	Sun,  8 Nov 2026 11:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794136153;
	bh=rRMDSUzD/4dqXKQ7EKZyKnxoCi/M0piqkjg2dM9fwCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N0YYA4cpwk2rSpGMMYuOqSqMumav/sn0wLJeni7+D5sRDUh6oQesbQll0590AxfPg
	 YHZL34AcSy3m/oA/+Mg50SxmE2ticTBJ0JeVPjSjHFm7kxxRs5L8DQMA7BTnLRn9Qu
	 2ZAZr5kKEMP1mX37TLY8VAg7PQwGUVqeJOcMERAGlH5l3zZZEjSFO6rqxrHnW3bvxF
	 j8U2+HgWFrfZqDiA8t9jLRXdMwzd73OoApHczJMktKFXOELRAAGT46mdFrtZFBMPZ4
	 MVG5MgmA0/z1plVr0CdzxGC6RsARpcD0nOIKT0WnIOzRGRQJttYGclefHMO9alDFAo
	 8foRVxDwmD7Ew==
Date: Sun, 8 Nov 2026 13:09:09 +0200
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
Message-ID: <20261108110909.GA8635@unreal>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
 <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
 <20261105184442.GF8298@unreal>
 <bf756e50-c77e-40f2-916d-e88887426806@rowland.harvard.edu>
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
In-Reply-To: <bf756e50-c77e-40f2-916d-e88887426806@rowland.harvard.edu>

On Thu, Nov 05, 2026 at 03:04:18PM -0500, Alan Stern wrote:
> On Thu, Nov 05, 2026 at 08:44:42PM +0200, Leon Romanovsky wrote:
> > On Thu, Nov 05, 2026 at 12:24:33PM -0500, Alan Stern wrote:
> > > On Thu, Nov 05, 2026 at 01:42:18PM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Interface claims hold the USB device lock, but device_bind_driver()
> > > > requires the target interface lock. Without it, trust-policy writes can
> > > > race admission.
> > > 
> > > This says nothing about usb_driver_release_refused_claim() and the code 
> > > related to it.  It is an incomplete description of the patch.
> > > 
> > > Note that nothing prevents drivers from using an interface they claim 
> > > before that interface is registered.  For your scheme to work properly, 
> > > you should make sure the claim is authorized when 
> > > usb_driver_claim_interface() is called, not when the interface is 
> > > registered.
> > 
> > This patch is unrelated to authorization;
> 
> I meant "authorization" in its generic sense.  When you don't trust 
> something, you don't authorize it to do anything.  Pretend I had written 
> "the interface being claimed is trusted" in place of "the claim is 
> authorized" above.

I will combine existing USB authorization scheme with device trust in v2.

> 
> >  it ensures that the lock is
> > acquired when the driver is bound.
> 
> That may have been your intention when the patch was created, but if you 
> read the patch you'll see that it includes a whole bunch of material 
> not related to locking during binding.  Namely, this part:

Once I added `device_lock()` to `bind`, I had to add it to `unbind` as well.

Thanks
