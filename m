Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840066;
	b=15YnUcdo6n7stjxezg4je0yIEtEcRp6PqHcFQI3mSPYWAPmF8ykCKn0YioDdux32SwBO
	 rxXpSob16mz2SoVasThlGi6N1d6U2UkUQ4NvseAk82ygypWbptUo79904T8NmBMaTIf1i
	 St3+tqcjoGemOn1V4wwrFrQpwFuAIu/gi16Xz6tHEEIR79dfLJFkQRP8v8OsbbmgHGEc8
	 rkMvNYXa9nWAPzd9YD1exisb0eRVKwBY+rugwf861yUKy4+P5WN5tAzhnU4SjtzajD5f/
	 YpVy4X6bu133y3Riepy6aEbCuCyRGAr6BPt+Y6OrC132dlMIAGky5XgMilAUb2NtjtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840066;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rck2Y3eqNJgd+mBW5P64Rjy+9DMOjDHBgfT6pXds1IU=;
	b=wZ3o6u96dM0yK6ap2YbvJaC+zUpnRE7gNJOJ1o8y3kRj9UpKLeiAro7i2QjW6g5PQkKo
	 jx2uf9DVwZy2keQeHDZ+QaURBRSm82O4XDMxSRRCqDgPk0cBTv0YcD1lFfV75b21GRKxs
	 W3LPLUwrBCoi+NIy6I/jnN0zSXzLNWHbyjWs+rM3rgxkjpe/0PYEoJpZRoCQwZ9sSOsCE
	 6JON9QhJs4RKOQTO2w6dvHwup3R/bR0Ihu1cKE/Qjtw46nYcgjQCUu70E7+l4tqLVqBmI
	 kJFI/TgNL+E2euGyYpvz2tGzblMK8N/orDq8PNUgspHucw+J3ndTe6a/t5vO1TvhR4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOouaY1x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2B606A33E;
	Mon, 16 Nov 2026 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOouaY1x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6861F000C5;
	Mon, 16 Nov 2026 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794840066;
	bh=rck2Y3eqNJgd+mBW5P64Rjy+9DMOjDHBgfT6pXds1IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hOouaY1xsoh6wz7OkDEV9jecC1eeHdUzuBJ4iKZos36b0fe+StWs/XSmsTjHsGMfp
	 e0tnBNKEzYBk5ocKoScl5rfojtpjaAq04YxAl9To16QUfCpYwnFZC1O4/NOMYIyx/J
	 6krsbqGk+aiylgCRzdnezjfMkr6lvaqVy59IDh4S8336RQTcF1BHCaLRWdCsPSIOp+
	 VVzuE3RLFUwu6bn36UH7ayClXyqoBHEqh0EEwT5lbksAWLyI95yck3v703WGi3w5hJ
	 rBBp+t1wYkX1vn71MylXuHgsWdIYHoEXqOW4MLAWG3JYv7ky1boG/BvH4HGhBbkddM
	 lkYNAFSJRMfOQ==
Date: Mon, 16 Nov 2026 16:41:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	iommu@lists.linux.dev
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116144103.GU11319@unreal>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
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
In-Reply-To: <20261116132046.GI2532299@ziepe.ca>

On Mon, Nov 16, 2026 at 09:20:46AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 16, 2026 at 06:38:25PM +0530, Aneesh Kumar K.V wrote:
> > > +static inline bool
> > > +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> > > +{
> > > +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> > > +
> > > +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> > > +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> > > +}
> > > +
> > 
> > Could you clarify how this series will work alongside device acceptance
> > and private-memory access?
> > 
> > In particular, what should callers of device_cc_accepted() use under
> > this model?
> 
> Who is calling device_cc_accepted? I thought we were keeping that
> internal to the DMA PI?
> 
> > My understanding is that trust describes the operating
> > policy, not TDISP acceptance or DMA access to private memory.
> 
> Right.
> 
> > Therefore,
> > neither FULL nor ADVERSARY alone indicates whether a device can access
> > private memory?
> 
> Right.
> 
> Once you turn on TDISP you effectively activate DMA, just like turning
> on the IOMMU.
> 
> Userspace then gets to choose how the rest of the system behavess. You
> can still run a strict viommu with an adversarial driver even if you
> enabled TDISP and can DMA to all memory.
> 
> I don't know if many people would choose that combination, but it is
> there.
> 
> > You also mention that once a trust level other than DISABLED is set, it
> > cannot be changed during the device's lifetime. If a device initially
> > operates in ADVERSARY mode and later attestation justifies FULL
> > operation, is that transition intentionally unsupported for the existing
> > device object? As documented, unbind/rebind and reset preserve the
> > committed level.
> 
> I think it should only be for the duration of a bound driver?

For now, I decided to disallow state changes because the IOMMU may outlive the
bound device. Unbinding does not fully reset the device, so we must quiesce it
to ensure complete security.

Thanks

> 
> > It would help to describe how the trust framework fits together with
> > those separate mechanisms, including which pieces are left for follow-up
> > series.
> 
> The main thing it brings is the pause to allow userspace to measure
> the device and put it into RUN if it so chooses before any driver is
> bound.
> 
> It doesn't change how any of the DMA or TDSIP flows work.
> 
> Jason
