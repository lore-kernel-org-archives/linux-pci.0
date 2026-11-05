Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910900;
	b=4JgOWyiMcTnv04b3uYbNOZdoTTOCiI9sIrhU7EjIXTTFsPrWuv21Zfnq5oK98Nd378nb
	 D45OXAVz+Y712gOd4SIYdDW4hRTtbEwl1mLM063d4XYoaze9u+4NNTKsooDwm5uJj4UYH
	 uZRR+kxkiadMVIjXrYHmfZH+S3/jyT18tzONk70Ocw5NM/f+C7b7uHIFGPxq2SRw3ye/u
	 Z5tK2rHCDZoKjKOyiaQgpi+Jro1EdYKAOR7ysF1C1kgKyBgs6edq8QX/g2Dxy2vn8nZl8
	 0sNon4CQdXd5BmkXpkLf8aAHBAtSU5/lpEXs4Ph+VOAr0RRbbKi/GyqRWe8TGF+xzcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
	b=i4mCApgieNH6HqrMLdxRabS80mK//EHFE8Qjuyp4wzqpOCgSUdkRjKk9m5i+bFBwvzPf
	 Zarw/qYfSKL73/uAcHyq0twT1glx/L1P4gj08DlSNrP3ZSV0gHNXMSmKb5gS3cra9FwN/
	 6YZPbYao5FKWH2DFlxEM6c4SS1Dc6166OMnqMSFewd1vPtGD7XIE0rfLD5hMkEJEmxN5X
	 6ve6qGvLhvJ3xaDvrUrt3NvntBPT66SW72qGAM/JkGhChksU49RcCuwG+kSJayN4cBaBJ
	 W4yv8Y1w1lNmKtvU9Bv6Nl+59lyRztYF873UaVDsvrK6DimMmRo2Rr6K0r0gdPbHxRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfDV8RqH;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA484606A32D
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA484606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfDV8RqH
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso4388096eec.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910899; x=1794515699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
        b=tfDV8RqHdxq2Tir67Fgi3R8YmRMnkFni198pbJyN+2f/wlgyg1u3H/zAskp5NHkOv7
         tIdkAuAZ8WUJ1kMmFVB+y6fHOz8B/caj8wD6aThvegmX02BzNu06iJykZNQp0y6aCkds
         RlikDnWVU951ugzrT3mYdlzvFKlHh7U4jsRYSXIG1h4+jf8Ji6Bx4VcBvQSsJCCbdeY9
         mB7Z2NGEfuJN8Celqb7oNC5peWi2IHdFiN3NSUJbZlwldHAE4GnOhIkhY+aC2WxclROa
         S4gSdge+AsM35XlqkfzkRHJ1/+Vy2cjQlMpoMljhOELSER57fCOwoNKU+WxKYNt0B3OE
         B7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910899; x=1794515699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
        b=surC1zTW5cQD23PB9P4JCCR2mYLyoAZk7IxxOfN/ISrZMX19os0BI8YpTvb9qdETof
         /vGkpBNu4bI2S8KtjJB4lqmJGKLUnsx+VwxJod2P0X7bxO1Tp0d/NSEtipnr6aXflHtc
         UZeKzq+luNk4zEgmoRdg7mrb+X2YUX+9MTWEdSiZTu0xxHm6CwsGDxAH7ozInt4rW1W/
         lehsBOR9wo0qevbObtUGmMm7Pwu0kzg2vj3BwN+efQHSbdu3C64PJx7InELnHMlZ7JQm
         Pq2tJGogq+cLWah9+ps79eGIKgHumh/u855+X6q2YdziV7YZSTuSexAE+HnkylQgDRQR
         l7UQ==
X-Forwarded-Encrypted: i=1; AKwUvBw14JmXC0UF5hkn/QASsy/UAwH5tbY44/8jRcOnw32aHN6eoXzca5XC2bR0JnzirSdS/Sreks8W/zs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KEH7Q8E53bYCipa0eSGqsOe4ZBrK6CYJiIMFzRSPsABkv6V9e
	sPTCn7QTd5Vn506e1pr7UBLi/OHWA5MtEbrBZGahbQ0lqayHLH7458g+
X-Gm-Gg: AYBFou1nQKlCsT597oX8I212nTsnqgaa07xSWg7sPtonLhH3AmXY4ejHQzX7qBPuI5S
	Ctg9CpRWINA7BsJ0K7SMK1ieXZUDUpL1yIqJJNw8omzrmXBZdvkab0+ABYuS7nbjMRxfOqtPM7N
	QAuVxuvMWBIYtYhg8nQnwbRox3DsZxWxwlY8l4T18epvey0lt3V8WV5b2D0xDvQ0toQ6uGpzUGG
	muwBvskD4GIJmxh6/gHf2OfidvD6mEzb5ANyujxxOHxsqzIU9JTHnteIdbdPjxHBXsimeuueG7y
	cZJyB5K4kIp2xoi0pBhnBo5KteNe8W/zgoOYBm+bgc3INDqPSZ2VuUT8UwnxUvaCtWtNAgK9nrO
	P9akRTV6uQZbe/usJStsiRPIbHwZmWMrB/5gy/DJYS3oIxEvYME0jbxVhOPQKNWbh9QZFdLcOSX
	dokr7mfWpk9g8e8BO6UYsyzBNEbbW8LZWQBJk3SZaOUCPnaNEbs2XvzHHeqSacir+azez8jz6dD
	jrfvS+kxeCHCiq8PwmswRfbtzUYdCKMYWCM6Zq/v3R1jStM4WNNrCJ+wKPqC1qGxTzFFwvbA+bk
	pQOly1Aq/dlCa5KQuNgTxCqOa+dHtkqfwx+6W3GGfigH6GIUDfeI+9PZTZfwc/FZRcs03TQ=
X-Received: by 2002:a05:701b:2050:20b0:166:5552:780a with SMTP id a92af1059eb24-1b25d31e5a2mr163714c88.8.1793910898553;
        Thu, 05 Nov 2026 12:34:58 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed274sm649631eec.18.2026.11.05.12.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:34:57 -0800 (PST)
Date: Thu, 5 Nov 2026 12:34:53 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-input@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 02/17] Input: serio - attach manual drivers through the
 driver core
Message-ID: <auzno3uoL5Pfojfl@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
 <auy2plYVi723Qt42@google.com>
 <20261105191940.GI8298@unreal>
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
In-Reply-To: <20261105191940.GI8298@unreal>

On Thu, Nov 05, 2026 at 09:19:40PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 09:05:29AM -0800, Dmitry Torokhov wrote:
> > On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Manual serio binding connects a driver before driver core can admit the
> > > device. A rejected binding therefore arrives after functional setup.
> > > 
> > > Keep the port ID check and use device_driver_attach() for the existing bus
> > > probe path. Driver core then serializes admission and handles probe failure
> > > before publishing the binding.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/input/serio/serio.c | 24 +++---------------------
> > >  1 file changed, 3 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> > > index 54dd26249b027..604440244c1ca 100644
> > > --- a/drivers/input/serio/serio.c
> > > +++ b/drivers/input/serio/serio.c
> > > @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
> > >  
> > >  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
> > >  {
> > > -	int error;
> > > -
> > > -	if (serio_match_port(drv->id_table, serio)) {
> > > -
> > > -		serio->dev.driver = &drv->driver;
> > > -		if (serio_connect_driver(serio, drv)) {
> > > -			serio->dev.driver = NULL;
> > > -			return -ENODEV;
> > > -		}
> > > +	if (!serio_match_port(drv->id_table, serio))
> > > +		return 0;
> > >  
> > > -		error = device_bind_driver(&serio->dev);
> > > -		if (error) {
> > > -			dev_warn(&serio->dev,
> > > -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> > > -				 serio->phys, serio->name,
> > > -				 drv->description, error);
> > > -			serio_disconnect_driver(serio);
> > > -			serio->dev.driver = NULL;
> > > -			return error;
> > > -		}
> > > -	}
> > > -	return 0;
> > > +	return device_driver_attach(&drv->driver, &serio->dev);
> > 
> > I am not sure how safe it is, serio (and gameport) have pretty elaborate
> > structure and locking rules because they can recurse into themselves (to
> > support case of Synaptics touch-pads with pass-through PS/2 ports).
> > 
> > But this call is for user-initiated probing anyways, I am not sure if it
> > even needs "trust" handling.
> 
> This patch does not change the locking; the lock was already held on paths such
> as the rescan path. This change makes that explicit.

Does this enforce synchronous probing?

Anyway, I would like to get rid of this special probing in serio core.
Given that the code path is only triggered by explicit user request I do
not believe we need to worry about supporting trust notion here, so
please drop it from the series.

Thanks.

-- 
Dmitry
