Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844349;
	b=rhcY1zE8CSWH1jaNMcNwEPN1I8vk2VrMHXHBYcJg5p/wzoAvfQwWjZSHmWTmj9NM3R9v
	 tYkh39G5vLCTfs/q/s8RaZSkLAPdU74t1hbd5ZmKaogVq/gOGtYu1Ua2OyP+ZAwDbE8rN
	 HBdorplwXh8crIRaEW51GtgZkg4csim81PIURQwF9OO4RbeT41o65OG3HVAJI9UWg6Dtv
	 wiJIc24PqaFonJdq8U4+z5Fqze1O+bnk2qgs4yewrd5V1IGsvotPtyHxY6R9z9AGufk1p
	 ua6/7pcEWt1TSCwkBHRTF2+FbIrCCo36U0oiFydq/SNw0IkcUJrUPF7jaQZO11VGfHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844349;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=nMJerJcoZ1Adnfr1+PAoZtyg0oa83iJzpuYf4Q3jisk=;
	b=fABsnlHXQk8e4METhwNMhBff3k4luca2UiAXEj+2UN/MqTrhaV+2W9WXEzSsS2GzZ4qW
	 XXafhpTacetKjdGLuQQWGKhVZnr3t6/ivX9F6CR4pUKin94amNQsoLQWTt1b+lZ9UyGS+
	 w83x1RrDwoVD1PLCifJFMq8XnIJhuKy7BJw0RTiTGsNwJVt8HNuO961PQNIUX6AGacrzR
	 nRr55dfeSc2D0lt/vma0RREIIfqtVx30Mrj6V3R27FZqfc+N2ptiftYTI9FrF2KCYKq4T
	 7N3Ohw93cdc/gwNgFDA0nQGo+YA/rggpI2O+TJG1IfMwbezWtvHqvP7spDHQxKESeJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cqf/PBWs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C198606A31C;
	Mon, 16 Nov 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqf/PBWs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD2F1F000CA;
	Mon, 16 Nov 2026 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844348;
	bh=nMJerJcoZ1Adnfr1+PAoZtyg0oa83iJzpuYf4Q3jisk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Cqf/PBWsD5IxBgQxvgBiY9kTywVx12SlTwTmXTT8ukWkQsTUR+izYk5U8YFXU36Ny
	 VuKt687MkawSeh2PId4bqFbRWi9sMgwfnI/JSJjTIU/6KxVcy/AK8qf7rn+hv6trfk
	 Ee1pyTLlidS19SxOPSpjOIH4gugO1s5gd0mmAVUM5KUUf9dnwJ+bAvl3mUcDP9cXGz
	 X00xd/pchyAyodSkPV0qGH695K9NxXc1WkmuaQ+sFB/uhm3L44RMtQbd4LJlTnKyog
	 9tmHrt1kljrQB9N0o1IIRZoyH9U1+vjGQIjU/c8DxKA/xTbNd2EoCf0s7ezT62PTkl
	 Ppm6trUfqKBRQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
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
In-Reply-To: <20261116132046.GI2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org> <20261116132046.GI2532299@ziepe.ca>
Date: Mon, 16 Nov 2026 21:22:11 +0530
Message-ID: <yq5aa4n8ydsk.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Nov 16, 2026 at 06:38:25PM +0530, Aneesh Kumar K.V wrote:
>> > +static inline bool
>> > +pci_dev_default_is_restricted(const struct pci_dev *pdev)
>> > +{
>> > +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
>> > +
>> > +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
>> > +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
>> > +}
>> > +
>> 
>> Could you clarify how this series will work alongside device acceptance
>> and private-memory access?
>> 
>> In particular, what should callers of device_cc_accepted() use under
>> this model?
>
> Who is calling device_cc_accepted? I thought we were keeping that
> internal to the DMA PI?
>
>> My understanding is that trust describes the operating
>> policy, not TDISP acceptance or DMA access to private memory.
>
> Right.
>
>> Therefore,
>> neither FULL nor ADVERSARY alone indicates whether a device can access
>> private memory?
>
> Right.
>
> Once you turn on TDISP you effectively activate DMA, just like turning
> on the IOMMU.
>


We considered two options for doing this:

1. Via the ->accept() callback in pci_tsm_ops.
2. Via pci_dma_configure(), based on a combination of device trust and device acceptance.

If I understand correctly, you are suggesting that we stick with the
former?

-aneesh
