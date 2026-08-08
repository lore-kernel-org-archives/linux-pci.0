Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E981413797
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194494; cv=none; b=QPxZP2zS2asybODXJGVOG4+EhhdvJ5TEvg5QXIad8jAuRBHUuJX9XELdKV0BA/XDsGN07FkMeAucFnr6nAdythsjUh/784DdVVviKdXOm+V90NN3EXBMvMCKkScy7R/OtbtjtB/ciyJ7t6oXYhnK7XNvzCBZ5jSUq4i6T8X0kJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194494; c=relaxed/simple;
	bh=GwhrTKCAlSl7hU2RyOnT+4NutiWEf9BBN09MOKeCbR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcWmJVN3rjTx3mw+Ucd/LaiKugQq8Uw3fI2EHvJ+/sanFivw6xbJTnR/cSR42eGFOHbyKlBdb+04dDLKZPxWlZ+MkmuWvpaj+iwm86zPxp4HLdc4ufOyHbOsiRtvydxSun2ryiFwoTEiunxtWqCl4mvS4rh5QIXYk3/zpeVy0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vf8gTwkH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vf8gTwkH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 250131A14DD;
	Sat,  8 Aug 2026 13:08:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE4EF6045E;
	Sat,  8 Aug 2026 13:08:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4624211C484AF;
	Sat,  8 Aug 2026 15:07:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786194475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ClGEAPMJrUrIAPf3I4J7siyiOrLD1L2Dp/wz05pGPJM=;
	b=Vf8gTwkHq6yQajcRFlm+fSn+kLxl8YAnX3+QoVivp8YugpNiQuLprPFY0RKx0Z4rIEC+sh
	A0xu3gKObPE2BUbcyZ4nYmftKZ6YTNlNli0Qb6Jlzdz2GOi5PNp+/5DtFRoNs+7Aqai+bw
	ID13oTWQxwsIJSKQhgd64sECxqNMBAfMk684IdUiFHVnH/9PMgipv06icQ3j221jgLck10
	HtQH1UKa1NFObu++mIXJUCd2sqrsWV9Ji+cSZfdyVbC4gApjyTGVqbuNfXsOuY+DckFy0K
	Sqfe+Jf4S3egLOz7z+O2U1sn+duUDVPFU10ihjN5MTzLH/WhxLedSHyJg98K6g==
Date: Sat, 8 Aug 2026 15:07:52 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Frank.Li@nxp.com,
	akhilrajeev@nvidia.com, mukesh.savaliya@oss.qualcomm.com,
	rafael@kernel.org, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 07/14] i3c: master: Fix potential UAF in
 i3c_device_match()
Message-ID: <2026080813075281786283@mail.local>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-8-adrian.hunter@intel.com>
 <anY1dU59JIvV-6BB@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anY1dU59JIvV-6BB@lizhi-Precision-Tower-5810>
X-Last-TLS-Session-Version: TLSv1.3

On 07/08/2026 15:43:49-0400, Frank Li wrote:
> On Fri, Aug 07, 2026 at 05:56:31PM +0300, Adrian Hunter wrote:
> > i3c_device_match() dereferences i3cdev->desc without holding the bus
> > normal-use lock.  Since the descriptor pointer can be replaced
> > concurrently, the dereference can race with descriptor replacement and
> > result in a use-after-free.
> >
> > Protect access to i3cdev->desc with the normal-use lock.  While the lock
> > is held, the descriptor is guaranteed to remain valid, so the NULL check
> > is also unnecessary and can be removed.
> >
> > This change depends on "i3c: master: Fix recursive locking during device
> 
> Remove "This change",  just depend on ...
> 
> > registration".  Prior to that change, taking the normal-use lock in
> > i3c_device_match() could recurse on bus->lock during device
> > registration.
> >
> > This fixes "i3c: master: match I3C device through DT and ACPI".
> 
> It should be fixes tag, but this patch still not in linus tree yet, not
> sure how alex handle this.
> 

I've added the Fixes tag, this works as long as the tree isn't rebased
before send the PR to Linus.

> Alex:
> 	Maybe rebase i3c tree,
> 
> move "i3c: master: Fix recursive locking during device" before
> "i3c: master: match I3C device through DT and ACPI"
> 
> Then squash this into "i3c: master: match I3C device through DT and ACPI"
> 
> Or simple ignore "this fixes ..." sentense.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> Frank
> 
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >
> >
> > Changes in V4 and V5:
> >
> > 	None
> >
> > Changes in V3:
> >
> > 	New patch
> >
> >
> >  drivers/i3c/master.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index ee771ac0b203..83e04a2c202a 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -347,8 +347,10 @@ static int i3c_device_match(struct device *dev, const struct device_driver *drv)
> >  	i3cdev = dev_to_i3cdev(dev);
> >  	i3cdrv = drv_to_i3cdrv(drv);
> >
> > -	if (i3cdev->desc && i3cdev->desc->boardinfo)
> > +	i3c_bus_normaluse_lock(i3cdev->bus);
> > +	if (i3cdev->desc->boardinfo)
> >  		static_addr_method = i3cdev->desc->boardinfo->static_addr_method;
> > +	i3c_bus_normaluse_unlock(i3cdev->bus);
> >
> >  	/*
> >  	 * SETAASA-based devices need not always have a matching ID since
> > --
> > 2.53.0
> >
> 
> -- 
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
