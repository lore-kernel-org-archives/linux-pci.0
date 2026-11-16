Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840359;
	b=DwMMojKYT42c/MSj5tSB3XCkXR8qzpgPdhZ9vNFOFUUM9hYmneGlzvpOBaBKFkHYIpnZ
	 qGFhHXCyWhAtYHbkkRtvlKdkLjWuGxnE/WvIh1nQEkmevn8diLnqAapcXYOUt6ZWQYPPh
	 NT8u7Oh+s/KuCoPt8kc8+s5HabfPKpzSmUxErLWBbzpHRWqG7DsgN3IqWB0thbTeasMyR
	 UQw33Gv48amZixP8Hl9N0FYvhwsrzxpCg06VgkN0KfO3T5o7tK1/UIcFzfseg9wdygPo+
	 MTOZ9c0PzcP6iiCmlSlmEnqG3dLxZKMa0uhfouHHB0GL+vtgG/OI/keH2CQeXwIbOXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
	b=4xNmh9s1dN4/EpqpXEc2Lp215s6IbMyZ+7+Nt7IbSYX6VxXMTFW/ZIhvs2fm43r028HU
	 aLrISMWnfReRZVQhu41jrsuuibu79yR3/KhNn5pwFR5voDoOuiWuzIyb3elyilRTdWfr6
	 oumwCi/RMmpKKWBGcUD1LEtlWQoorOaZUdQNOBrF0MAo+ObNiAi63pa/LIjfd7ruvuxge
	 2IiVAzbNQkvFwq2mX5BPYHcnOwzpad+/Zy60K9H6XQR5dITbYHQ/hC1MRDZz4gHHEjeFK
	 lgq0879Hv7fsKNgChmnTDzb74r4HP+akYUCLCAtGyhe5afw8A2TZKE7xAya7UIg48yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dLdJyonb;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E018606A334
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E018606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dLdJyonb
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-949589c1495so290257985a.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794840358; x=1795445158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=dLdJyonbx/GT9GciisxRrbnKJNPmXRO37SMr0DcL0fOWPt4npP7q6oSEFPRBxyhYBG
         VwQv88je59xwJGF1tzvO02VHIK2UoI2gFnHM+RoqxVUasg9DyQA32ToeKqV0tOS8H2/F
         utZ+RQHXMciPdHoqR96pmDBV9oFbAflIPtcSFhX2+r9dDE0rLhaGZCPsZ1j517doL9zB
         RpfAbapy98a71EK1akS809jjM1beUX7TmDUaCrtYNcz/JJbJ2sGjj2UfCKl0NoQ68uWW
         NnufbW7FWZvXAJBZh4GXQ7J60xB7eIn/T76+zn9Pq4vvTPBJTSoxoiKRgL0R3QgrjVbx
         3mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840358; x=1795445158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=ECl78VALI2lH8jigGWm9lWrlELMyB+QzF4zELYBOYU7CHqVX0ZVu4bAvF4MO0tU57a
         wO+8vAaVXVFMKVOoszDHZ7GVhMZTO+im7y5hDSdj3YyESGl/RWfwThmLo5iBmu9TpEqW
         9dXd55EaFVoLvlnT1RpJr/7YybWuAZqm72l/j/7Bbc9fxwK3Z/0N4TVQU12Vs/Q9Hn61
         TKSbbT2AsQr9mvKX7PUm4gDpkh7WdpVhryF2yv00vii7hkj5udOrLiDmiIud9bGdHDuc
         sVUfxn/BYm5J9KBSLrJLN3iwhvNFF7JcGvbptmauAwRka9nV2O5LXNWxn15v4zlY7eT8
         z99w==
X-Forwarded-Encrypted: i=1; AL+hErG8P1bmGSpJWIctxwFQZxvFerDyckOykpOQzLzphtw57M6hV0J7mObcAQ7vEoQFKxjvzUWvy4FkiLI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gp6littjoRAUTEFRB5FaEFQyjaza90doaUnHVhaiutZHcfwKt
	F1/TZgfr9LvPgwTu9R8L1J8TXwOtw/ON25xuO61AZNkK6AsMHYedFUA8JwdJRABaz68=
X-Gm-Gg: AYBFou1b5tAKMF8K9ocRWJCaIfVVS5Ak7EsD53aH7DyI1uaT8pg9Xzske3vhysdCVHS
	cBg1Qey6WeymwQFiEe0couwE+emCwD2Vjm0Bf2gGkveQDyF/3jmOuKotc+F+DJj6G4HQxFNuPsJ
	a5QOyAfFEIWtUv0k42Rf6Lp919o4iRoh46Po1VVQN0ExgH6u3N+sVZC2cfMadz74JHa86s4wMOX
	DezZRBRI7JzMVKWH3lU+pXvHJaQQkIyKLhHcsv4uAj8sId2sFXY4MDbvm36mSWb6uEbAV8rfKEZ
	gRmFDSnOsRrRbI18iI0r1HsQkh1ugb/1z+MaoQSzzBxGLI4HuLOoPFcl4dPPqteTsJt1T3aiMKh
	STl0K/LUw4BD+FkPxoh6o9OEjn9Y1RQlThveJyn+JMdpEUotmOb8QTggxyDRG0Naii4wapCaj6s
	76r5R45XKRbNUmZ9k2OhHZ59URLkkMPykaHfFo+Ssf6UMpZCYGlXgm4fY7gmZlKg9rEtBGlvO7c
	gknrSb11lQ4AB29jHubjOFDaDwViO2NylsrgeoLCpRNRLiSs5p+6iWgJRN4AJVJT18ltE1sDJg/
	thrqKA==
X-Received: by 2002:a05:620a:a41a:20b0:949:5872:be1b with SMTP id af79cd13be357-9495872d3c0mr1015844485a.39.1794840357475;
        Mon, 16 Nov 2026 06:45:57 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836079sm858473985a.18.2026.11.16.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:45:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSxxz-00000009V73-1sJy;
	Mon, 16 Nov 2026 10:45:55 -0400
Date: Mon, 16 Nov 2026 10:45:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20261116144555.GM2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <20261116144103.GU11319@unreal>
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
In-Reply-To: <20261116144103.GU11319@unreal>

On Mon, Nov 16, 2026 at 04:41:03PM +0200, Leon Romanovsky wrote:
> > I think it should only be for the duration of a bound driver?
> 
> For now, I decided to disallow state changes because the IOMMU may outlive the
> bound device. Unbinding does not fully reset the device, so we must quiesce it
> to ensure complete security.

When we refine the lifecycle for the iommu this issue should go away
too

Jason
