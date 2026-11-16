Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859754;
	b=KrP9wL1jprA6ZGQSOYQ+L/4/e6HQQynWgfSzZquoMsA9Uo7BIEdOPD/6+NXgQlp6Ahiw
	 uLBF9VUdW5tkkEM/iT4oVqX9PKTgscAW66ncrpCzE9wSX5yR7hYX7SQnbkSVichkWdGp1
	 YV3OgYdxOU8RPlZLQ+CphYFVWrL1V17SIbKH/b4v43PvUESJLalQ+5VpEgEMj9bXR4pU3
	 UyNQQQt6VyIiTuKkGVbPLnv6wbX5V7LwLK/v8uFALbOU2qAsNQ7zkpczGpl2XRQHEokSk
	 g1iX6DHARbtAUzMjllTo4FN39oDwPnPZSmANPE3XT0qXT+YKxiA9nHxEE+0hFY10M4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
	b=Dwt2dnLO4NpHYgAzZlqWGzmhxPluk/1sOjVAYgLQwzUfeqpxBBwJwaASEQlyJmEzAdHL
	 /1AwjIbLDixCYoW0k4sCQ2GIcay65WJ2Tb5G0vJMF2rJlffHnPlxmJkSFmfdgkkdi706y
	 iDocE3NnMtRaRtd7PzFd3OZe9uDBjBXS1LkZ1OigY/TdLeApGcBneS6M1W0apk/9eM5CW
	 QqqF5MX7sSXWFrv6CU12czzpRtVd+iB/MWtkCFMTdn7ljSzm1r+qirW/Nxj9q4GFyu4do
	 McVy79tcoPAA4l8HGtPWpM0zjBv2cgQ/L6jzFKdySw8fgYcVRcSrdk2kKwMkmM9947A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbZUyxTk;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319F606A333
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 20:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5319F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbZUyxTk
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5366ae57896so46203591cf.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794859753; x=1795464553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=nbZUyxTk1xDDi9/JiN9In9kNH24m3xvR3W8MPaMB063K/nb6P74sDih4ebpP83k2np
         SjqTAYuPLCHW+FRVrjLKSTbDX5aM/IVbZZxu+ASYJ/ssH0gDFbMJvSJmLcdHAAsDSEL+
         FG47SOuU8PRulqvpOebFRdp+iKyncNtYeoKxWrzhMSjcb9i+1jD4cThvDUO+7PnMd3zc
         ImV7NXhI8pI4k1LW/eM2oLltJhXP6hUveoFekGEVH6+oWgooyZkYdcVCIAs0jW9hoXxW
         5IGbSHDAmwoeFMTug5VO+bv+VKknP1f2hoIrUsvWYeNqALAO8eTePO8ZOjSwRNnR3p0b
         L2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859753; x=1795464553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=vcadAHjb9vdOsnJoYv++N67AeKqh8SSNYhttHFtK6KWpYy9RopP/XRSgJXOjRc1QF2
         YmFxkP5qfxAmb8U7KbYWzyDklwFS5HVxMC9Q5tWy/NpaQ88pi8YHCi7Mgp9ncC1pWnjE
         +8sODAg0LYF6CwL5p1KXxxuXZxUPrPLRHDR5B7vmbo77AALPkE5Bt7nPZM3eIKQkAyS2
         42XFajru6YziU8toDqTBsPCbRA2nzNIh5a4cexqO07Ew6tNM9R6jtqh3lVU/UaNp9ve0
         SVELFKN9t5mDrcMIzLswlDjLUM7LP9S3kMaX4QCa5PLEPRPsqF4J2IfepKg+eDgrleA9
         tFQw==
X-Forwarded-Encrypted: i=1; AL+hErFa2OfZT2PsxuuKwkbPDOaluJ7aPAxILuV3oafosFaP+k7pt2/obASSu4EJNtdWU10E7Gr2aYv1tWI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wxoNVOg1b1MVt8vdFM6bsLLKnNZYTpuz/Xbh1NX8M++iW0GmC
	Odxknfds2gIcHWT0gEfACDamtf3spjAzsREyWcldBNHAVb+5qVHYua91GQX/Viu02n0=
X-Gm-Gg: AYBFou0Zwkr9HJy8uqs92tj3/Ygxze3OLqLLqRbNeaIy7n3TYBuvPnuGzSWBTYakScq
	GGWIoluVnAO3w6vENaicWDwNsBzv5fudJ/bBs8snw7GPF0/WHpqS1G2D/ynBLihkRl6J5MZgIL1
	0nvEb5ScXH1hEqA2RGKHW5+o0bClQuBBdoxueaAz+J/fTfR2Urw0jx+FH0zV0kOXxEimwFZY7kI
	YH1NuXzFJX2w34K94d//HonJ8FmGrg9jUlK2HoTajw2bIomXl9sdpzFJ9iH1wfGmNSakiVmD/E3
	rHsnGwk4p0vP1uEB+MHcJef1887ek1MLDuvhq5WwUcT6kerV/kDj8/GD37gFZLXJJbHqoo8VKip
	bRhYJ2zvZq/cd7w56vXR4r5dMV1JxBsgqI2b/QbWmNMS8Xoiik/p+koZW53J5YCJOOSimf3zJK8
	kXrGpDmtBN2gNDpcagnaWB14nMr6R01j+QnxbU4/DoUqXWIE6UOGM8Lb1cXivRLabDJuyS6MqPN
	HkYsJsz6hgXuxh04oElHs82wWyp/gbBdiD5A96whnCrYbE3dMSxgO9rg3uINfVAvn0E8j0aWUJj
	7Toqbg==
X-Received: by 2002:a05:622a:5144:b0:536:98da:f790 with SMTP id d75a77b69052e-55ac43909femr187873791cf.6.1794859753196;
        Mon, 16 Nov 2026 12:09:13 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d445d1sm92856046d6.8.2026.11.16.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:09:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT30p-0000000ANtb-30lh;
	Mon, 16 Nov 2026 16:09:11 -0400
Date: Mon, 16 Nov 2026 16:09:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261116200911.GA2473219@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
 <20261116190417.GD2299285@ziepe.ca>
 <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>
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
In-Reply-To: <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>

On Mon, Nov 16, 2026 at 11:24:17AM -0800, Kameron Carr wrote:
> >> My scenario is pci-hyperv in a confidential VM with a paravisor. The
> >> paravisor is inside the guest's trust boundary and owns TDISP. It locks,
> >> attests and accepts the device, then answers a VMBus query describing
> >> which BAR ranges are private and whether the device's DMA may target
> >> private memory. Before a driver can bind pci-hyperv has to:
> > 
> > Sounds like a user in such an environment just wouldn't use the trust
> > level mechanism at all.
> > 
> > What use do you see for enabling trust level but having all the
> > devices unattestable and accepted already?
> 
> Previous iterations of device trust used the trust level to make
> decisions around DMA bounce buffering, etc. Is that no longer the
> case?

It is not, this is now just about userspace attestation really.

> I am looking for good hook candidates. I was hoping that trust levels
> would end up directing DMA behavior, etc. but maybe I am
> misunderstanding the design direction for these trust levels.

I don't know, I broadly expect some flag in the struct device to
indicate that it can access private memory, but how and when hyper-v
could get involved to set that flag I don't know.

Jason
