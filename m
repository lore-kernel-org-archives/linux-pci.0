Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593986;
	b=wSltgDbsAccVdwEGEHnb3TFBQLgkll374jz6AxmLTBR5q7/JemsgkOXX8Y/a7kz7W9Yd
	 lvjjrdNXmAdvwL7AtvJRpLgS+fcXjRY0JzkXqTBtzVNrWecqx2Wm1fHAZST+wHGViE4Cz
	 FaUDAJFa3R3tdi5eHHBcQXBPCGREn7Q/FJ8IDNKshhoEXWAasEUy1pYeZoDjtILRakBFA
	 jX1QNlb4SaRSi4hzuQ/EovSBZmgEPQKuCGU1H7qTJJn9FlgYFyoedCbd8bWaut08FaZkt
	 DOTFPJhDDOtdyEmgNBNwW2K6UENez7kfiDrBw3ECn1SXDqn9BjnfKMNVvlGv496SpJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593986;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qtWuoC5FN2MELDFAKVm54MaDOVUHKz/6gxfQ29IMYEs=;
	b=Hsfs2nAM1xkpvXqykcjYZ3W4PurNyQKOBM0CTsfEjnr5F3yE8G1pgnJCjp/9X1TXnDud
	 uqnQtnpXkseVBGYplG5wJkOIgUDDfAg5xi5AeAFwr3WVrn40cAY9rkRvdj4gwIeejCAQK
	 WsErRjR8R2BUEI9Xo8z+2uLOCCR1HsTJXfz7HuFFpnLgGKiKzN3qdPuTvP9uBzkdg8t38
	 WMtl78VLWKrtU98/ImDF29S2l53/SxAvG5I8CwZp1hQdD6UdR8Ylchy9ln97rmbA+7v5B
	 sXxjP/9S7VkH/ZBJIXQDuPMb/YHo5t3GHMdmFZdgCKiKtXXo2eZ7A03gIVGiP8IUYaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUIFb+z3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1C606A31E;
	Wed, 25 Nov 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUIFb+z3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A421F000D4;
	Wed, 25 Nov 2026 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795593985;
	bh=qtWuoC5FN2MELDFAKVm54MaDOVUHKz/6gxfQ29IMYEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gUIFb+z3EoGY/k5hBc/4s5BAcJqoX9NRdGz5EQ6vBgq3rKgAr7rBRsJERd4dmZigO
	 sgMEGylJulCdyIpDhHG6/2txMVQjqrlwfpZxIzCQD9ih0XAAV5jcvSffX4lkzrl50w
	 cDOqkERHka2UohPOATjzjz7RQTUHWII6+yvEv/39m5kvL8wGeIVNx0KY9I4eCtkGIO
	 7CyKz2J4/slnL7IdCSuRKiy7aSog5s+20Q6CNmFwovssbysi2Rs0WtFZQmgkhVyUTp
	 WzzU5qaaMeAJRyM1mX5Ul3b1ERZi7ZWbYDbm/BGlP2UbP3Rj7THpZilyDmxSEyIYfZ
	 j4WqRkjdYr7Qg==
Date: Wed, 25 Nov 2026 10:06:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
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
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Dan Williams <djbw@kernel.org>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 21/33] driver core: Introduce a generic device trust
 level
Message-ID: <20261125080621.GW14811@unreal>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-21-037eb0d17b1f@nvidia.com>
 <1bc8f048-4d35-484b-af60-2d13541e683f@infradead.org>
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
In-Reply-To: <1bc8f048-4d35-484b-af60-2d13541e683f@infradead.org>

On Tue, Nov 24, 2026 at 04:13:16PM -0800, Randy Dunlap wrote:
> Hi Leon,
> 
> On 11/24/26 1:43 AM, Leon Romanovsky wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 0b3c140babd94..8a94482f0b19b 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1259,6 +1259,20 @@ Kernel parameters
> >  	dell_smm_hwmon.fan_max=
> >  			[HW] Maximum configurable fan speed.
> >  
> > +	device_trust	[KNL]
> > +			Enable device trust with blocked as the implicit default.
> > +
> > +	device_trust.default=
> > +			[KNL] Set initial trust policy for all devices, including
> > +			hotplugged devices.
> > +			Format: { default | blocked | adversarial | unrestricted }
> > +			No trust options selects legacy unrestricted mode, preserving
> 
> By "No trust options," do you mean using
> 	"device_trust.default="
> or just
> 	"device_trust", which says above means "blocked"?
> 
> If I want the status quo (before generic trust levels), do I need to do
> anything? If so, what?

I mean that if you do nothing and do not write to any device_trust*
knob, the system will continue to work exactly as it does now. That is
what "No trust options" means.

Thanks

> 
> > +			bus policy and existing authorization. Otherwise blocked is the> +			implicit default. An explicit value wins regardless of option
> > +			order. default preserves bus policy; other values replace it.
> > +			unrestricted disables runtime policy changes.
> > +			See Documentation/driver-api/driver-model/device-trust.rst.
> 
> thanks.
> -- 
> ~Randy
> 
