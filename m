Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565619;
	b=lB4Xlc8pVuj592/auq5RLnvJYYuThRy9WAbBe8ySRtG5pQ4Y+RuvpwjpKHcpQ7Buv39V
	 cuO1pxOmQjxiklg0Xq/05yriRGLG4v3dy1ZDzUypGm3JJTEv8PrLRTjtw5aignrYCo51E
	 FxtG+XdcpT8Gp7quPIjfl36sN9bMnL/tfnWrrKelDGdyTC0Ld+QZiC72xz/dKDdIQa8Q+
	 29gvfMFe8gLxc5MjLgS9AWSw3kIo79OxTlhegzK0nsxxtR6GB/43II1Kv5zLjW9jN94P8
	 kTfy966oVo+aLd894RD6QaNUbJBW1GX4Paki6aag02QfENcT7xmRml+52Pb1HerQSaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565619;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=H5JA1xiHcuO5av/TCwEs6eB3F56+e7cAUCqQUzm2IKE=;
	b=z/GVWpB5shUbdYeyEc20Nni5BwyrRwGIT+Mf/H31cdKIrVJNjDaHz2tYCCeI6QKyx3Cz
	 gBgHsPN2DaW0jqbhjZ3Qap00yfNeZUHAaA2J32M4of197qOapudL3Oj0N9rEvucSEOZDO
	 /pUy73bIEEJq+/GS67Nl/oJfKBOI2yXFObqU3p4WNcxLhhHksW4yUZYBnKX0fWXvBpzgl
	 cyke5zG3u21kRrgtpAAxP8MMg3Qvcfu77IqKf7GGdowkauBs4dXqPPoY0nvIRLMQvLbQo
	 T600N55RD04Vc3aNeUU3EFT3IFWN0nyml1DyyAWq0gHvO186h2pVKIEUli+TfeouePA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v9zYfpM3;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C80606A31E;
	Wed, 25 Nov 2026 00:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C80606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v9zYfpM3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=H5JA1xiHcuO5av/TCwEs6eB3F56+e7cAUCqQUzm2IKE=; b=v9zYfpM32kAvGWDRKN8MU6P6/i
	THgQ6XYg3TtUofGeL2k7Si7qt22CXocALWePyGThKmz1qAlHdno0YaX4hMbpi9yfZlUtHK6K1eXlL
	GeQuqTgf4XWzLJy2chYc+tSG2mRITN+XTa5/pQFz7cU8pYCeZvHTNEpGTic0Ra3Bn7X6rG9WSY590
	c+OuNmPeBIWBhoTdq/4F/GyhXL88V+9v+Cfhpu0nrLW61HOrtf46r6ZIWqNplXFPNIO5S1UpJrbac
	fYM0SjlPu530GhgWnDw17IOQ2+0z2pmZF19OsGitN/UbkR2o0ojmQxrw6eR3DwYptge1D3Fb5xrr6
	9A7gm4og==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW0dS-000000088Rc-0EKa;
	Wed, 25 Nov 2026 00:13:18 +0000
Message-ID: <1bc8f048-4d35-484b-af60-2d13541e683f@infradead.org>
Date: Tue, 24 Nov 2026 16:13:16 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/33] driver core: Introduce a generic device trust
 level
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Chris Lu <chris.lu@mediatek.com>, Mans Rullgard <mans@mansr.com>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
 Jeff Garzik <jeff@garzik.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Bart Van Assche <bvanassche@acm.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-21-037eb0d17b1f@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261124-device-trust-core-v4-21-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Leon,

On 11/24/26 1:43 AM, Leon Romanovsky wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b3c140babd94..8a94482f0b19b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1259,6 +1259,20 @@ Kernel parameters
>  	dell_smm_hwmon.fan_max=
>  			[HW] Maximum configurable fan speed.
>  
> +	device_trust	[KNL]
> +			Enable device trust with blocked as the implicit default.
> +
> +	device_trust.default=
> +			[KNL] Set initial trust policy for all devices, including
> +			hotplugged devices.
> +			Format: { default | blocked | adversarial | unrestricted }
> +			No trust options selects legacy unrestricted mode, preserving

By "No trust options," do you mean using
	"device_trust.default="
or just
	"device_trust", which says above means "blocked"?

If I want the status quo (before generic trust levels), do I need to do
anything? If so, what?

> +			bus policy and existing authorization. Otherwise blocked is the> +			implicit default. An explicit value wins regardless of option
> +			order. default preserves bus policy; other values replace it.
> +			unrestricted disables runtime policy changes.
> +			See Documentation/driver-api/driver-model/device-trust.rst.

thanks.
-- 
~Randy

