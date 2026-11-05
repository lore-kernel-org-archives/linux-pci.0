Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898126;
	b=RF9eXIa8Dp50gTbpa9yII9bqR9jAy3sVdfSNFKLW6bG/t85qW6oS2QQt/XuyobnstdmH
	 c8J510schCfzjo0d7PdzxsPhXMGkLfxAuu8j1kDBjHC+6hwEtmwkgP/Yef3JaprG+vLYB
	 OR+Jg4+4G20nfl/nImi8LcTsjAlJHvMS7m6iWN5BwCsD8ykkLx7sdHWiO4TT/jLOV/Dq8
	 OBmDuunxbI5MNv4oxEju/FGc94jjcMFrl6tph5dtCfAnNSbCcwyAYhVTkKD5bBNEqhrdF
	 6BzzLMP9dq7kb5hFKS2GhV7BxUvmO1MTVTjiEaHIuddLOPxqYwuGuo3CgqDMdqGYQLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
	b=2bjMYKEaST3quJhq+97K2yJEyFK7r117pY25UpgQwj2PaVDHRp1EJpk3iWhxrlxPnWpK
	 qo+GOZI3a2ygiuLnQC+mQrxjzxUJH5Cgr2tnuSkyxI9A62UK+ZZvXOD8mrt41Ic9ih/Ku
	 HKt2WRc9rLrRgdBCghvscLn29rfwq/6NGgDCHIWwnMjml+aIrhx28RcOniJKJBTSwP0FM
	 dqxIhWArmSuPeC4w1Bw6IpuJheU9mTebtOJM32IyfrrfU2cxktjT5vtRXHSCT1ByT1WYb
	 mR95vD5g8Pkqt4VSzLd+8V8Ru3ljWDS23FP4jc0w8/757eXUSUoMGhxKy0ZL2t5CcfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="UT/D8aSt";
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D4606A33A
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 17:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 137D4606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UT/D8aSt
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso1351511137.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793898125; x=1794502925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=UT/D8aStYb7dPEp/Z1PTR1znD76pBm0Z1nPlORuFlgDbzwSX/aHEaMIKgxREgduhMs
         7b184i+9WuyWU3kP4ECdvxL5tqJCBp+sE58xftFr07RVMuYSe2D0AHX1L8wkHJuC4lcP
         6d7IEtulMVc64pTkfBc/dFTnsuyCXdHVpF//V/K2Xgp9mPmSNI4/p7tLi2H5V42yljeY
         GtO1ChQ2JjqDeaKC4B9biWxL+z3aUuPX/f+FWBrD4U/FW4Q80YjAWhMK/Up13oskn2O3
         3V6ObKXKjzYpPS1tL8mHYVexmV3sD/kfJUj7ToJWfvaytzTBimAL6fO0bssiuf+AQf9l
         4B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898125; x=1794502925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=zQWIznN30EAGNDZKf9uRhlstD17GIwZ8YmywFMFt45cbNdPBCctLpdecPTFIe8BC2S
         2njL212CNhWHlnKTp0mp9qBKwGcqieMLYmaUNCkjGCtFajmUGWzcqJHL/V6uPszHZ8mJ
         S6mssNct1sSzyO66tNsqRKwZoKVP1ewosrAsHkaEZVgS1BC2Fy8Ntn6KR0HZRufYd4gy
         GMQ2ZO2l9R3oZlM0dmpjyv4+op5uigurOLPPqeN++tyAdl0hVfGXwnykdQYZQN6PXC19
         z7Gsk/RfV/DHa4vqUv8pKskmcIRFbZ9buOHH0AQzXFeaK/6cmkMSFqKmu7zFNjAKODKx
         DMOg==
X-Forwarded-Encrypted: i=1; AKwUvBwT4lxbjRvADz6yLFdxRAPfwXW8awAOzlcjJHFbKSdbAeJFmE4VHeJ7P2+CL7f75EygDyTbM+bYiuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8anP+PLoxAp6pkTcXauF2R+oiia/4G7Lr0mKaNLbso+PP1A1sP
	MOOdILeJifpX0UgV209RVixGo+n+K18R19DmMeY5mXt3a8YQ6mXEe6SkEDfbxKOdtlk=
X-Gm-Gg: AYBFou0dCrj4HIcjQLB2LPJOBsCCgnkJubpwtZ6WEdFRP19UkmjVHGpoPqh+eHyQXSL
	annuwOKq33j4AKN6cjt1izSc7hKQWSeF1MrTY+rnRfuVxg3zStBIKUf0heh57VMv/n3LEeIkUxS
	rxglNRwe/b1pSjzR5JyfYZI4tqSk+hdE9KMafU6Ju7P1Yb/82SIFE4WWPYGst7jwSl2mNunrpT2
	B0K6IZ4pmbBKbqJp4T3UfD3mYj8A251uHmA2sEvt1hv+bUaD0rZQer9QgpzGRgqnelAcVCKrsXu
	PvQD55AZEq5rmlEYcSWWAjNuvpHB9M8bMltDf8L343yI/hTR+zyPVv18/cSdLdx3xMXSVl/RLru
	o9WK7badKS3ImnTjwYwOvBd4sAH2xyVvZXjTaq6n6KlfU/gTbH0KpX8B0CcmcXJMZFDKPSk4akH
	EkrQft8ppfGfRFTeVADGXPniQtvQ5ndCPujoIcwfYnh4BN5IqL8qCd0/VosEWbz5CTQVAsf7lG1
	Lb3hZbZVaHc/fvk9OpFbGR0lfaCsE2YG9NTpoYTAqpOfLu2kV/zoO0x1Da+YpkFYx/KqhMTsY4L
	owtSqECeb1o0gGVflyVwaoqw7j8Z92TDEmR+eTjoAwIxqbzwJ2kPfe9lWL6a39WbzineIjh/hwt
	hx+wHNuLp7Jgh+QogqWpj84bgpzQpHQ0=
X-Received: by 2002:a05:6102:2c1b:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7d2a16c7f35mr120203137.33.1793898124846;
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm4619225137.3.2026.11.05.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0qh-0000000388I-28Zd;
	Thu, 05 Nov 2026 13:02:03 -0400
Date: Thu, 5 Nov 2026 13:02:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
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
	iommu@lists.linux.dev
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105170203.GC663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:23PM +0200, Leon Romanovsky wrote:
> +		(RW) The requested trust policy for the device. The initial
> +		value may be selected by the bus before the device is
> +		registered; otherwise it is "default". The policy is resolved
> +		to an active trust level before the device is probed.
> +
> +		The values are "default", "disabled", "adversary", and
> +		"full". "default" lets the bus select the active trust level.
> +		"disabled" prevents a functional driver from binding.

For making this more general:

"disabled" prevents a driver from binding and informs the kernel to
provide containment of the device. For example a PCIe device should be
unable to DMA to memory.

> +		"adversary" requests operation with the restrictions that the
> +		bus and DMA layers can enforce for a potentially malicious
> +		device; it does not isolate DMA by itself. "full" requests
> +		normal operation.


"adversary" informs the kernel that the userspace wants to opt into
any security defenses the kernel may have to restrict and further
validate interactions with the device. This may have a performance or
functional cost compared to "full". As an example the DMA API and
IOMMU layers will avoid exposing unrelated nearby memory to the device
during DMA.

> +		Successful resolution to an allowed level commits policy
> +		and operating level before driver or DMA setup. Both remain

"before driver startup"

> +		fixed for the device object's lifetime, including through
> +		failed or deferred probes, unbind, reset, and driver reload.
> +		Later binds must resolve to the same level, including when
> +		the policy is "default". A resolver error or disabled result
> +		before commitment leaves the policy's writability unchanged.

Not sure what "resolver error" is.

Jason
