Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320944;
	b=fRHhPMhMnVfqTw4ayhnmLBVtbjA0v1Q/WdvO/MOrzOfKtA84wpMPgriM599kwGTSiOEY
	 m3z6rCLImAa3KBBWMVUM9+Y2xzigVnSQ9EMlFv7+AoWobe3IzHgVAI9MZiZRYCqAssnEs
	 zEiASQ4ovCZrB4JUyuJTcqSIY6IN/lneYJodERObFj+hinPi4sm3/oVBdABNSqirvnLbp
	 yFi9n40+KkJJHBbstu6UCrzj+oYqaq3fVmjfRjxCdSHnxlRvjaslB3RQQWuxCrDkuUc0Z
	 +KR6oznjsOcHNn5HBoI3L5oR/8XCXpeCDqIbiAilBzMwCGY8Lkf4H2Xe8+4/6+422YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Y0ZCT4BLnmetwE993QplctN6lfal0N89naXDUyrvjcM=;
	b=eZfOWCAlRVxDQ+RX/0nCoPiNsZzQy81L8QGmSnkRKkqBa/B5LxBanWECEB0b3+KClWEz
	 IVQEQb6/IgAHys29hZMHErnDRZbmCuZpF8BFDG4YYAJU24yigJH6OyRpUZ9YVw+aJVSKp
	 iD5YM/Ns7JGdcP4BVgyGw82LLxqUSO+E1g9+X4JpuTUgER241v1JKmeg4qIFsNqiqouA5
	 9HJOhGRFKW1mSFNUOopHay/3UuXxhehZNGeTXqdqdQVCmMWQ0sbn3bTUCMSrxyfTNa3lQ
	 M6D6QSjzGf676FTdsaAVOiJUuI0L4Q0YcZI4KPj2VJDmWKuP1f78h/Y8vY3NlIj2/TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g/nC+X8y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D0606A331;
	Tue, 10 Nov 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/nC+X8y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E51F008A1;
	Tue, 10 Nov 2026 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320943;
	bh=Y0ZCT4BLnmetwE993QplctN6lfal0N89naXDUyrvjcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g/nC+X8ypIowiT5ms+iK6osSDYwKAxDOjrYUncLmxvaon0kSYGVitnBTMS1izmeAU
	 e3/Y9Gt278aWiDJhlT4aB1njTfYo3LwMq3+y8nmpgA2rwTlLsCZAbV9JaNktJ76d+b
	 IxPBUQqXNe/EoDOhUJkPs++d88R1BB1LHfLcVg45C+Iqoh/fhdLgqDT96Ha7LdYIp+
	 WiJY+Od/C+1zmiTghQEfMSovx0H1qQ5A1SiHCIVopn9IYmIbcPp/4wpaNXCjCHE+dA
	 wyCDgnXaIXO3mjko9cyjH77smZJaKdOiGQ52YbpIRZUFN9CLPVY5OeETLWyLDPTvI1
	 LYceNWi9CgEIg==
Date: Tue, 10 Nov 2026 16:29:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 09/19] Input: serio - use the compatibility driver
 attachment API
Message-ID: <20261110142900.GJ8635@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-9-3b12d9a9f861@nvidia.com>
 <sashiko-outbox-206509@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-206509@kernel.org>

On Tue, Nov 10, 2026 at 07:35:18AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] Input: serio: serio_bind_driver() fails with -EPERM under
>   default boot policy
> --
> 
> commit 3fd95316c0bff9166a7d599c0aa06fa861dbf4de
> Author: Leon Romanovsky <leon@kernel.org>
> 
> Input: serio - use the compatibility driver attachment API
> 
> This commit replaces the manual driver connect and bind sequence in
> serio_bind_driver() with device_driver_attach_full().
> 
> > diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> > index 54dd26249b027..b54072769ab68 100644
> > --- a/drivers/input/serio/serio.c
> > +++ b/drivers/input/serio/serio.c
> > @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
> >  
> >  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
> >  {
> > -	int error;
> > -
> > -	if (serio_match_port(drv->id_table, serio)) {
> > -
> > -		serio->dev.driver = &drv->driver;
> > -		if (serio_connect_driver(serio, drv)) {
> > -			serio->dev.driver = NULL;
> > -			return -ENODEV;
> > -		}
> > +	if (!serio_match_port(drv->id_table, serio))
> > +		return 0;
> >  
> > -		error = device_bind_driver(&serio->dev);
> > -		if (error) {
> > -			dev_warn(&serio->dev,
> > -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> > -				 serio->phys, serio->name,
> > -				 drv->description, error);
> > -			serio_disconnect_driver(serio);
> > -			serio->dev.driver = NULL;
> > -			return error;
> > -		}
> > -	}
> > -	return 0;
> > +	return device_driver_attach_full(&drv->driver, &serio->dev);
> >  }
> 
> [Severity: High]
> As reported by Dmitry Torokhov on v1 [1], serio_bind_driver() is only
> called for explicit user-initiated binding via the drvctl sysfs attribute,
> and it was requested that this patch be dropped from the series.
> 
> In addition, does switching serio_bind_driver() to
> device_driver_attach_full() break manual binding via drvctl on default
> boots?  Later in this series (commit "driver core: Introduce a generic
> device trust level" and commit "driver core: Accept device trust policy on
> the kernel command line"), device_driver_attach_full() calls
> device_trust_prepare_full(), which returns -EPERM unless
> device_trust.default=full was passed on the kernel command line.  When
> userspace writes a driver name such as serio_raw to drvctl, drvctl_store()
> disconnects the existing driver via serio_disconnect_port() and then
> serio_bind_driver() fails with -EPERM, leaving the port unbound.

No. serio was converted to the compatibility API intentionally. Anyone who
needs serio must use the "full" trust level.

Thanks

> 
> [1] https://lore.kernel.org/r/auy2plYVi723Qt42@google.com
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com?part=9
> 
