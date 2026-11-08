Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157159;
	b=jAXQIgZifyZqio2nlqVMgUigYb9WPwXBufSNJCiDUjAnSxIgKnnfHhMQ6/H5bvXM0iux
	 CUhl9GhySq03bEsz5iWOWW+aAOBtY9iCsB/vtH3GRyCOeBMLytI31EYpN1QENg28p9yFq
	 T6LRgU/GFijAeOmVLUMMJZC/CHMkyt4l2C/cad8XV1hOJpfacKAOb7U1kKRWKHdzC7yHt
	 fP5J4nFXZN8t6T5cIprFk6rQU/dwZeI1+O4xd/Jso5j1NsPsUIKU+NcetLHSAmLQA4NqW
	 JXE6CoUnHccjyyf/e6xu2SYkjG0hNCn40aTZPPpe85j/NM4njcyriutcmLh3QJrpMug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
	b=yr5oBcJA5nB/QEHIYAIoeUXMBUoUuWQE/6+8LvkqgwgrYFmT4JCdEmn6FDqZ1YU0hJ2f
	 ra4tRleZIULMAmwk1IcQB1MkDBJELxB+o1O+U+c6Ig40Fm3yij0sP4x82XxjTehTyXSjh
	 Dq3LZyEmgSvecSAQDBCkhEXiP64QO9zDyj4uLo8ROKhG7+9mgVCeBUhngpLTRi1p+Uvo6
	 wAKAdCO4XLcaKElH7cdTJoqWOZM6AssSXpepD5bsfjMgFL0Lee9Rzm2xBVRkHwr4Sj24+
	 ismcBuX+0JYterpTMqyq0/NHgw9K8JdBvI6mPPAEEbYUsFG68l5vQFaWsALh7UBWf2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=vVWQLNs+;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D8606A320
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=vVWQLNs+
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91eb57468feso1719816d6.1
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2026 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794157158; x=1794761958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
        b=vVWQLNs+Rnn6NOsMpjKSpUM9H3gRT4E/HZTt53PMAZ2SXIz+Low080hQm0r2oKAsG+
         HZ5TLknOMUGXKR3KUCz20FyQXU1Y7n4k67s/O97MTY2HciAv7W5/XWWVJI3wnxiYTpJN
         gDPuohXn6LbvsrECp0/Ji6cvN5My5wm8EgfEsTmjv66hd/4pZ3HhjPBADrWO+gshRLZX
         1w4cJtE0RQlZSB1u8qCDumnVcL5w0oR/W9xf8l09re306PAWvYklsReVbujjFSq7ckfb
         ysHxLPgUuyjzLYLRPYb0BIszOUV4j3JsJcseKz7sg4xVYz+KH4V8tOVQekOfo5kBRIRc
         SzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794157158; x=1794761958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
        b=F4FhUxm69BySRyChln+7Q7pMIyChhg76VKGOxhGy2x1XKnW6xshw32A3/BshpX2M0A
         YIr2zmzzI9K+66IUIdYjPS4TkBq8dnios9Io9rTsTmZx17oReUpNbsqd1zaKGzBHIo+D
         /2dsl9uyJ7yrvYzOrmfQVIm87+YIC7To9ctpFcnrO7Xet3uNlSWF5+Lh4mZqmK/3zx0E
         AN6f4KA+1tpeXHUR97iQkxzQKoG2xIY69lCWd4O/UWnTLwR72f5jwLeAo243EfgZO5rI
         EqVhS508SBea3r52iTMloknkZ0e8iJskxcV4gTxvAPpphsq589caVeF8t/Skhm0Pydcl
         FP5w==
X-Forwarded-Encrypted: i=1; AL+hErGjTDV/ijCrNYXQHHcWHzvOI2rPsMUujo0m42fQAq5uabxijUJPrJ6gqQFhpXjmyCxubwyHWG2QBi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eyKPP7gT2DzCnoNw9Vb3VCZTViBSv6WditzYNtpdVzG8vbnaP
	lqkX90GvOZ5osql3f/KWJfxMpwQrpwgiobtjWWq2/msOO6KuBeIlcbJeQxmFAG9S3A==
X-Gm-Gg: AYBFou3PNaDY/2j1diYXozB/c0xrSxkP/V03TOVlB3XvqA7gJ2go4s44nyLNf+Y4lEB
	/Wn+GLTPXikNbTxJluFEQ8VWc0h0DbsdZseNShZ+ZKJddjcwuXx5UWHK1NkYL7QZzCJ6lewiDtf
	XE2C1suKPTE9s7FAUceSVAM2Lm1N84ysvzD74oypuFJLCh+VcxwZGCwGddWEHlOWtrxPOd2JJvR
	CPt+wbfHZrVxnJwAbSZFQjYYNVuiRjr6mLmMg5MC4lb0mAugRbvGKR/OGIEdP7JHSsofkCe+2u9
	WQZwv2bdmWXAG4LB5I2duA9e44ab3OdJECEwqtJqNgKX6Qu5iK9Cp43oXke9oHoyToF7IjMbIRW
	2H6zKtPwBr/ViXYYo8NpF5Rf93EG+vl80unsQyDC3FUHeuyh7VZi2gNqoaACE1El6NSCZ8ctLb+
	66GoXWNqCrbGX9NAXG624N8QRLiMk43SUoDpegjXKxxf5d8QexgnlPnt8zv8p4G4a0wQzQ9dY+D
	vi9JwaSgKBdbdrK8Em5y4haCDRbDZJePdDfu3PFVYe+Hazxuj5XKR0XT1fWjRRAMqcbjsT+Ewyb
	vfM1TvVM95buyqQi5jw6j2AEer2G
X-Received: by 2002:ad4:5d62:0:b0:91e:9d64:3294 with SMTP id 6a1803df08f44-91ed240d34dmr24616736d6.30.1794157157397;
        Sun, 08 Nov 2026 08:59:17 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecedbefb2sm22431036d6.17.2026.11.08.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:59:16 -0800 (PST)
Date: Sun, 8 Nov 2026 11:59:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
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
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <647f3199-909d-425f-b485-b598a18844d1@rowland.harvard.edu>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
 <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
 <20261105184442.GF8298@unreal>
 <bf756e50-c77e-40f2-916d-e88887426806@rowland.harvard.edu>
 <20261108110909.GA8635@unreal>
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
In-Reply-To: <20261108110909.GA8635@unreal>

On Sun, Nov 08, 2026 at 01:09:09PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 03:04:18PM -0500, Alan Stern wrote:
> > >  it ensures that the lock is
> > > acquired when the driver is bound.
> > 
> > That may have been your intention when the patch was created, but if you 
> > read the patch you'll see that it includes a whole bunch of material 
> > not related to locking during binding.  Namely, this part:
> 
> Once I added `device_lock()` to `bind`, I had to add it to `unbind` as well.

Obviously I'm not making my points clear.  Let me try again.

The entire patch description, as you wrote it, is this:

> Interface claims hold the USB device lock, but device_bind_driver()
> requires the target interface lock. Without it, trust-policy writes  can
> race admission.

This says nothing about holding the interface lock during unbinding.  In 
other words, it isn't a complete description of the patch.  It implies 
that the patch changes nothing outside the device_bind_driver() 
function, which isn't true.

Furthermore, the patch does not change any of the code in 
usb_driver_release_interface(), which is where unbinding takes place, 
because that routine already takes the interface lock.  So to say that 
you had to add device_lock() to `unbind` is not accurate.

Instead the patch adds a new usb_driver_release_refused_claim() routine, 
plus code in usb_set_configuration() to call the new routine.  The patch 
description says nothing about either of these things.  Not to mention 
the fact that your other changes make it now possible for the driver 
core to delete an interface claim when the interface is registered, 
something which was not possible before.  This is another inadequacy in 
the patch description.

I'm not saying that any of the code is wrong.  But the description does 
a very bad job of explaining the new code.

Alan Stern
