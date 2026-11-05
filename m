Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896023;
	b=1lWYmmCGVg7mQYJHby57GT5w7PXjQSC5FUifqTbJUAXA9pynjFNUb6Zf8ymtYI175geb
	 M/WTJW7wGBFE2vdMmUMO9wS8GyZDGgxNUy6u1pYQyWYXJ6rgqUVsyg8XZaLuW/JgUyV7/
	 5nWOEt4bglXtgtC3G1J7y1EIocuQCyGXorpCEdJMNnOfOFHiuQL8ASnRXnGp4C3Fkglb+
	 uuDHmf+cFUWJLnHK13NYJgsxAHmsaTlxsfANl8KkKQCd9isjRD6hMA499gz4OZioHCPFk
	 yz2DqEdnD1lVmfZQ0kDcpGFrEdtbYqgHsXOLJwRBYaPobo4CgWhHMYf5THlvbfoFysQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
	b=m39ykwkQuwylk1DvxMSN4gO7xy3QgGhOh8F814rkRNVC4KT36v53t4FY5F89ZUF2jGQQ
	 jRgxuIVhkN30xdRtY4tstTcpxKmANQbP5Qs3vWgvjorrIXo3pQtT1WAuUTee729WwAKxZ
	 UIYSB5C5KicUh/NFlL2LR34pyCRvjStFmwh9KG1QKO1T59XDYGTwwRjdkE3LRMKzr/4Do
	 yCJJibafN/cww5D/FOTMLqd33PiGeSRp/0Z/KeAk/DiVnfXYsdhE5jcB7KlPWL8G653Fq
	 05XonEJnkWw2LfETwx2fchLPJFSbWd6+uloQ8a3u9SUc5O955En83Hx35Po37e4qxdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2E606A33B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82F2E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7ce77f98658so663017137.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793896021; x=1794500821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=TH080M2b2W5GU83fC4bkAl8rc89cXnFJ2JUZ1DQM2E1G7nxV0uZ+iMHWJDX5M/hBR0
         v8Q4S1dZz9e+Wy709/pkQPJoJ382ui88GBuCa7YwB1Pwv+V08ySzbQGdCs4et9sFRxVX
         1a78LWa2r/qDmkC73yn92WJjnMydzWl2HaDmNekF7y5RHwsZB7YPGLTTr3xjjmuI4LbR
         sgpTrG1DSTm++FzIJZEq0knZSmQ9xxE9IezNyVfi/1ZtU95O+iPlQHI5LWAc3/YmXStT
         Vgy3IZE07Q/+XWoEa8k60w3BygO7yb8zhuyYBqBwOLPUaUevbalW8R2MAA5wjUpSFz6r
         zz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896021; x=1794500821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=LS6vMFlIHSQmp5OEWxN23vEBQv7VsxtjuLiP59jQQDTbM0QAgPF5anRqEx2yrofpQO
         Lzx/gjfJ9Un/QPrVXNeUKSpiyjmwTw/fiiNZCcnOm9kwuQwNCTOCfEtbvSz7e50Bdxxf
         ai6t6u8cv8IW8ZM4LN0oPeSLK8fMLRc9WpJcENNT1ZqK0O5Z09+aVAe6G1nn0yGQpvwf
         CaS70pzLdhiH4pcD+sviWJfUKH1VHaz0UxwqaCYdEoAyEcJ5hztBDthzF4nbBd2WFCuq
         b6m2r/UhATw1RxIVUsnjn3jYGi7oy2A11oWOfuxxYCiHNvL+xzhDy40WJH67HtWUFcKr
         AHMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHCmCvAT8F9iibUJXDjWm9N1Xi6H2Ru6IhI35ydDgEL0y5YIyRE7RckBsAYiQjGdBjn+vs1LerpGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oysn2zevKNCcpVI2KFZhZttpDapFDGbJvP+dWuCfg+B0syM9e
	iZDVLxXcAaqW31GNcJC01AhcMbjWNPAlHEtoeF62Huvkp1JzffC6fPMGRnlV8SjFrSU=
X-Gm-Gg: AYBFou1Sei7tAZTZlXoazQhpy35MbbX9Iwk1IVtf62l6HXAfAd0xAEqHYXhanPL5Rcd
	qRWTTVqOjME2R3jzm+54s30ceObJf6dsFKzTmugM7/wLccKOVK5aQf8z6sgKfg5RqfXuk6juUfq
	eaBdvEMNNEaeGesDYEPVWwPyMEFYC+tiaXNLFrvzKFP7s82+mZmlO7Ebwuuen+tgm3MVmkohIYB
	usKARv0l26NmDCRjJPZolgvtF/CT9ebd6x76ZToAqTRgoivXcVrRVQc+2hrPRW+1BE2RZRbgReN
	jtaFIWTh/HNonx8tf0ttQgDm89h3RxMVub0Rnh6Eu36Ye2c+wsBpo5pGurVa+lsf3yr77+WAly8
	6w7wPK3sRJvLK3x4yk1SAhW866wYvIEEEhZvRebQCKhOLaZymrnzBbv0El9sUz1Y8+qGywNBN4o
	5uGg87udK/mb1Y8UiAi3VY3vX4glHc7hjde4R9RpPH7reSrscJwEoMkruCrRR3j3yss9xoqg9UH
	muKmte+a6rgeP3OyQHexIBBmQ7wo9yAw/54mTS7gFnG+rC5t7K+qGUjFhe8b5ComkLTwLz535Vi
	fiY+sv0UfOCYXZSa1iZYFL9lP/0GXwxYhBpg44j570Vj0fl5Q7F1YtKDE0ieHDJdBNgH/f/5O2/
	yJUWDw3TC++KHfQ/U6ZvKGJxdQU/ILns=
X-Received: by 2002:a05:6102:3f9f:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d2a15715c3mr29296137.15.1793896021174;
        Thu, 05 Nov 2026 08:27:01 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm4667110137.11.2026.11.05.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:27:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0Il-000000032XP-37xT;
	Thu, 05 Nov 2026 12:26:59 -0400
Date: Thu, 5 Nov 2026 12:26:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20261105162659.GB663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
 <20261105140352.GF3889730@ziepe.ca>
 <2026110558-tartar-juicy-036a@gregkh>
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
In-Reply-To: <2026110558-tartar-juicy-036a@gregkh>

On Thu, Nov 05, 2026 at 10:43:00AM -0500, Greg Kroah-Hartman wrote:

> > But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..
> 
> Yes, that is exactly what I am asking about.

It looks like that does the same basic idea of delaying driver binding
that this series does. Hopefully Leon can harmonize it to use the
shared trust level flag instead of a usb specific flag and retain all
the uABI around it.

But, even with this v1 the user can choose to use the generic trust
level and ignore the USB specific authorized and get the same
functional outcome.

> And I know there are other types of devices that will want to use this
> type of thing (i.e. SPDM seems to be spreading to other new bus types),
> so it's good to have and get right.

Yes, we are investing alot of time right now in trying to get SPDM
uAPI right when we bring the general framework into the
kernel. Everyone needing SPDM should be able to re-use it.

Jason
