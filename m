Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631953;
	b=r/bk0EqQ25U0+80Tx9i/74cIFOU5R/SJHPbLfVfFi4j5pt88KwyFmpL+fYsfpFG7FYsQ
	 BVVEdqjvL7WDSBx70SKYssuaLZKWrBdc3qwT9B2G0OIskDIW0GVRPndECqPm/52Fy+wI6
	 PsG7eatjFs+i8ubJHKVOZA4M5AmGXxp5OLxNZB8Y8RjVUo4huyHDes22wr9DVEXsdcT8P
	 /HX/wYm0CWP1Eqenxy7P9YHyEZEfiwZRSQv1mwOynfl9sa+xTzkvxLfB1z1zOnywU4TQ0
	 lE1Ih2ROlstMdYE1fph7V2k/YT34mlm7+dnhL0PSdduhZfthQ15TV7zAnPJu3x2gdQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631953;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9d3njOaM+jpukQAUMoZ7qHi0GXB4V8UIPA4xMogK59o=;
	b=odTwPeRPZCK/+7LCbpo66e2zoR6+sxCqQuW0E99yCfM7VG1Q+AotWf9s4XDHuqD0/IE0
	 69H5u4ruTGQYyIC/G6ba/SBAxeDqAZFYjT82uuohiHJwDo9gjNzF3R4j9a5DjHhVb2xmx
	 rvUPRWrjaauFReQ0XfgcfPUzqC1Q+oM7UsUpqjsizBaAu3LxmdYHLaKLLY94TFhZhQ/Ix
	 6TkkjHOMk+pB5hZHmyrEbdmsg5LxRgze14mc46MKTnmQUfKljJ/FwgBbpkSHhoUM9stAJ
	 nzTTyvqB4RmGfRoaiPswUdvo/zqxRmkpNAAkkYxqjRYJGaR6crECy6SgTiRsn49Zblw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="em17U08/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2473606A326;
	Wed, 25 Nov 2026 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=em17U08/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE13A1F000C4;
	Wed, 25 Nov 2026 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631952;
	bh=9d3njOaM+jpukQAUMoZ7qHi0GXB4V8UIPA4xMogK59o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=em17U08/0XXMA2BOtnbDOEQWOm0Hx+v8HJwsVpEY1NTUliqxM9s5IW5VvrSS1HM1t
	 E7QhSsCM7Zb9HJOkR2/lSMMWGQSnQDx9RglqoBRiOFTkFt2GME/m+zuZaim1U7k+Qd
	 OXZCK7algOn7ZTfrmstJd6VL4Sn1ABTpNjlWqUY+j+sa1kxqSnCIRqBg5CXy8Se4li
	 cR101JQq9kiufSiw/izepb0b3gVrw4i2wj6DJakKzIzzGH25XSN0QbESXbH+ZKAC6R
	 lGUlxhaW1tE53kLR6vyp2gMB/4mTHhN3r/wNqvTAzMGbxfhPDzF6+wjjQtzOGE0hQ6
	 aoZsF6YXK1ZXg==
Date: Wed, 25 Nov 2026 20:39:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 32/33] USB: Authorize interfaces through device trust
Message-ID: <20261125183908.GC774860@unreal>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-32-037eb0d17b1f@nvidia.com>
 <sashiko-outbox-233069@kernel.org>
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
In-Reply-To: <sashiko-outbox-233069@kernel.org>

On Wed, Nov 25, 2026 at 09:46:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] usb: core: premature trust commit before
>   usb_probe_interface() auth check
> --
> 
> commit 505017564cc702a2bd1b592d03460ab7095ffbb2
> Author: Leon Romanovsky <leon@kernel.org>
> 
> USB: Authorize interfaces through device trust
> 
> This commit integrates USB interface default denial and authorization with
> the device trust policy mechanism.
> 
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index 1d488111a70fb..80f4d2644023b 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -338,7 +338,7 @@ static int usb_probe_interface(struct device *dev)
> >  	if (udev->authorized == 0) {
> >  		dev_info(&intf->dev, "Device is not authorized for usage\n");
> >  		return error;
> > -	} else if (intf->authorized == 0) {
> > +	} else if (!usb_interface_authorized(intf)) {
> >  		dev_info(&intf->dev, "Interface %d is not authorized for usage\n",
> >  				intf->altsetting->desc.bInterfaceNumber);
> >  		return error;
> 
> [Severity: Medium]
> Can probing a deauthorized interface prematurely commit its lifetime trust
> level before usb_probe_interface() rejects the bind?

Trust commitment happens before driver setup and intentionally survives
probe failure.

Thanks
