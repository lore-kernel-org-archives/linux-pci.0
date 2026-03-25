Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B73C4578
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452211; cv=none; b=fn8+DlG5YYWZ47klkY2B7If1cNuMsZyFjYd5Kg/jD2Rph8HeRP7hQ4R1nWRa1vAsVa5tWWY4U/aW9z/hrrV4MARjaCg1JsJpligAS0XxuXOsEvpWh0RvMvGmAsg8k1MczsOYMqamJUx5AHg9d1eMQ3h2tDQgRJpMTXX2/wmk0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452211; c=relaxed/simple;
	bh=TQMq3/Y5EPmE1jivpGAhP3Futs9HVKw7EhGZgbeH5PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCh5Wsy3bSqbIsw0UrX3LAHW/hT6zOylMyqMDsHnVhgefUSby1l13BknWG1yYFB5YNYLtsiaEQXRaKulraCQTkE2P8kXZVsKdi8Z3PXJ1FZg5KZGmBxFXPFIiJxd3AJLQi5sbevUMZ6m3oc+QkxjkDKqJQ2t/VWgqOcXlekGgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daiI3Kp8; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daiI3Kp8"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c160cb021cso944954eec.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774452209; x=1775057009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYR/VQii1eq+59yB5UylOEDiVqDDyUVcShZrPailuWs=;
        b=daiI3Kp88XchmL2uZG3xtGaHNDzn0yrjNQ3Ob5EyQIAhYuGyq3TVs/DObY0nhubx7p
         sQ7iHYeqB7e0aEPf0I9qb2abA2R+2n+reJdlbbg33geSMkhk+ijM3uWiNo+9od1AP+Yk
         lOPISDAON8sQJJZaPTI2xtNa2SOmgPUWbdd5t+pXqHVN2+Z4NqznBQ87C/Ll1gpWk3yU
         mVG08uFhvMzdChWO7UtHGOeqH+1mOWRfpO/ZP1z0xupiCCdmo4eX7dwkPNh69CJSIewU
         d3rwgc+ThLgym+nLy79oVLOikDnyquz8MRLPyKu89zxdyKYgRbH8BawprJtjItHtbYYE
         V0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774452209; x=1775057009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYR/VQii1eq+59yB5UylOEDiVqDDyUVcShZrPailuWs=;
        b=kKVqZBaRfqq3IHsuFACFEqJHJX4UnP1DTxq/ZfnqTfQXNvZwVrYdldi90yN6FSyU6N
         zqMhhoCHzZyjVSj763+IXVL7EzIe/sbFpNS5To1npdmKHNnnda0GzKe/J6sBQvMWDSly
         ccX08/OcAV2uMhLm8F+VxhkOX9qB6aDvBXMtg1okBcNbKHad6otqP5l0MqR+9j0yvOui
         ht8ZvaE5173G45MoLBFuaKIWx4fUHnBqzNsqRyQhHUgVquk18IZJ8mqbeU8SpDDbdRIF
         Q5x+N0VWq3yo7+7/Gq+uM5oy0JB/WTnD5hwcy7OntQ2Vhdxw6nZxO2k22a0FnmIsHoBE
         cYpw==
X-Forwarded-Encrypted: i=1; AJvYcCWhulTQ+UdGB8/bTbTYfESRC3SPzFwzhC3c7us0m1yC1yaBL1Qn4r74jcI5n4lpqYwvrgac0+B+nKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Vd1EvA/Y1RDvS4vB57evheyQ6oru0pHozjh1AwsW6X2afdkm
	HkKFEODYtsmDQXnt8ArMD/7LE4BCZ4J6LejJCOwvb0p+GXBX2bdGpxrI
X-Gm-Gg: ATEYQzxogIzEdgU/UvYovb+pp3OWvVdfOtPn+WsYtdX/RqNAU4n4mX5Y9hkqQpanBoL
	j87Hjud7IW3loTzCsVRCHOTQpJfN6BuOwEM7TvU5sM0c2URq6GrujlfuBadiQYZO4ThM87wPcwr
	2Tt17VZ+cdCuIlv+FNcEWY/HlfnluqbtaZpyC8u7yDpRMpc/Wvl2Q8cgo4CP+Mz8n/MZ7W79k/s
	Nf6m39Z4NyEJU+yiTvBdWTi7RVONHjxWntODpnsAMPaOgp6K4yqPNcsUT+NwnY/oJ5e2llhoLNS
	HLHu8eLgP17n9fDush8/RpWpMLSKFyfUpZeJoOtaj723hmdam/6omrJ3xTABpu7U8m0xrFkkoWW
	DyrhxT3Cqo3yzZG7lpb7fVem/kHiR3ML33yd0AgNRMh3KHZsFK4Kq/9Sgp9MDu9lm86r73Ki9pN
	3Bla//cXnh6XeH3M3HKwUcBU87+RgvnQB2vq4C9ZSAPeN0pvIKL8SUg26PbQjpEASr
X-Received: by 2002:a05:7301:578d:b0:2ba:6819:2e9b with SMTP id 5a478bee46e88-2c15d32bccemr2245364eec.3.1774452209058;
        Wed, 25 Mar 2026 08:23:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29c941sm18375747eec.15.2026.03.25.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:23:28 -0700 (PDT)
Date: Wed, 25 Mar 2026 08:23:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Grimmauld <grimmauld@grimmauld.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <acP57qjzZr1NR1zf@google.com>
References: <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
 <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
 <acNgUoWWMCi1oLU4@google.com>
 <6cc25c83-6a5a-4785-9573-335371a94798@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc25c83-6a5a-4785-9573-335371a94798@arm.com>

On Wed, Mar 25, 2026 at 03:01:03PM +0000, Robin Murphy wrote:
> On 25/03/2026 4:13 am, Dmitry Torokhov wrote:
> > On Thu, Mar 12, 2026 at 12:48:36PM +0000, Robin Murphy wrote:
> > > On 2026-03-11 9:09 pm, Danilo Krummrich wrote:
> > > > On Wed Mar 11, 2026 at 1:28 PM CET, Manivannan Sadhasivam wrote:
> > > > > On Wed, Mar 11, 2026 at 12:46:03PM +0100, Danilo Krummrich wrote:
> > > > > > On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
> > > > > > > I have a contrary view here. If just a single driver or lib doesn't handle async
> > > > > > > probe, it cannot just force other drivers to not take the advantage of async
> > > > > > > probe. As I said above, enabling async probe easily saves a few hunderd ms or
> > > > > > > even more if there are more than one Root Port or Root Complex in an SoC.
> > > > > > 
> > > > > > Then the driver or lib has to be fixed / improved first or the driver core has
> > > > > > to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is requested
> > > > > > from an async path, etc.
> > > > > > 
> > > > > > In any case, applying the patch and breaking things (knowingly?) doesn't seem
> > > > > > like the correct approach.
> > > > > > 
> > > > > > > I strongly agree with you here that the underlying issue should be fixed. But
> > > > > > > the real impact to end users is not this splat, but not having the boot time
> > > > > > > optimization that this patch brings in. As an end user, one would want their
> > > > > > > systems to boot quickly and they wouldn't bother much about a harmless warning
> > > > > > > splat appearing in the dmesg log.
> > > > > > 
> > > > > > You mean quickly booting into a "harmless" potential deadlock condition the
> > > > > > warning splat tries to make people aware of? :)
> > > > > > 
> > > > > 
> > > > > Hmm, I overlooked the built-as-module part where the deadlock could be possible
> > > > > as indicated by the comment about the WARN_ON_ONCE().
> > > > > 
> > > > > But what is the path forward here? Do you want the phylib to fix the
> > > > > request_module() call or fix the driver core instead?
> > > > 
> > > > Here are a few thoughts.
> > > > 
> > > > In general, I think the best would be to get rid of the (affected)
> > > > PROBE_FORCE_SYNCHRONOUS cases.
> > > > 
> > > > Now, I guess this can be pretty hard for a PCI controller driver, as you can't
> > > > really predict what ends up being probed from you async context, i.e. it could
> > > > even be some other bus controller and things could even propagate further.
> > > > 
> > > > Not sure how big of a deal it is in practice though, there are not a lot of
> > > > PROBE_FORCE_SYNCHRONOUS drivers (left), but note that specifying neither
> > > > PROBE_FORCE_SYNCHRONOUS nor PROBE_PREFER_ASYNCHRONOUS currently results in
> > > > synchronous by default.
> > > > 
> > > > (Also, quite some other PCI controller drivers do set PROBE_PREFER_ASYNCHRONOUS
> > > > and apparently got lucky with it.)
> > > > 
> > > >   From a driver-core perspective I think we're rather limited on what we can do;
> > > > we are already in async context at this point and can't magically go back to
> > > > initcall context.
> > > > 
> > > > So, the only thing I can think of is to kick off work on a workqueue, which in
> > > > the end would be the same as the deferred probe handling.
> > > 
> > > Hmm, in fact, isn't the deferred probe mechanism itself actually quite
> > > appropriate? A suitable calling context isn't the most obvious "resource
> > > provider" to wait for, but ultimately it's still a case of "we don't
> > > have everything we need right now, but it's worth trying again soon".
> > > I may have missed some subtleties, but my instinct is that it could
> > > perhaps be as simple as something like this (completely untested).
> > > 
> > > Cheers,
> > > Robin.
> > > 
> > > ----->8-----
> > > 
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index bea8da5f8a3a..3c4a0207ae3f 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -954,6 +954,16 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
> > >   	if (data->check_async && async_allowed != data->want_async)
> > >   		return 0;
> > > +	/*
> > > +	 * Bus drivers may probe asynchronously, but be adding a child device
> > > +	 * whose driver still wants a synchronous probe. In this case, just
> > > +	 * defer it, to be triggered by the parent driver probe succeeding.
> > > +	 */
> > > +	if (!async_allowed && current_is_async()) {
> > > +		driver_deferred_probe_add(dev);
> > > +		return 0;
> > > +	}
> > 
> > That means that you are kicking the majority devices (for now) into
> > deferral path. I do not think this is optimal.
> 
> And probing drivers under conditions where they may go wrong or deadlock is
> better? I've not yet had a chance to actually test this myself to see the
> effect on timings, but whatever it might be, I can't imagine any *other*
> method of re-serialising child driver probes could be significantly better
> (or if it could be, that might represent some improvement we could make to
> the deferred probe mechanism in general anyway).

There is serious disconnect as to what asynchronous and synchronous
probing means. You do not go "back" to synchronous probing.

	/*
	 * Indicates whether we are considering asynchronous probing or
	 * not. Only initial binding after device or driver registration
	 * (including deferral processing) may be done asynchronously, the
	 * rest is always synchronous, as we expect it is being done by
	 * request from userspace.
	 */
	bool check_async;

So synchronous means that when you register device or driver we dun
probe immediately on the same thread that registered said device or
driver, while with async we _may_ schedule on a workqueue (but if the
system has already scheduled too much async it will be probed
synchronously or immediately).

So in the case we are discussing the probing of phy device is indeed
synchronous/immediate relative to the thread where the phy device is
registered.

> 
> I have finally got a bit of time this afternoon to pick this up again, so
> I'll have a play and try to finish the write-up capturing all the reasoning
> so far (it's a long one...)
> 
> > Does phy really need to request modules synchronously (and on its own)?
> > Why can't it rely on udev to load the modules and signal when phy
> > devices are ready?
> 
> Getting hung up on what phylib does in this one particular case is rather
> missing the point. There is a reason that we're still not forcing
> async_probe on for everything by default. Many drivers will still not have
> been tested and validated to handle it correctly, and while the majority of
> latent issues will likely just be concurrency bugs which can be fixed with
> better locking or whatever, even then we should be encouraging developers to
> actively test and look for such bugs to make their drivers "async probe
> clean", rather than knowingly enabling bugs to surface in the wild as weird
> and subtle breakage on end-user systems.

No. We have identified (at least IMO) that what phylib does is wrong. I
am not advocating forcing this PCI host to be marked for asycn probing
right now, before the phy issue is fixed, but I object to adding
workarounds to driver core which hurt other cases and may lead to phylib
never be fixed.

> 
> However, I imagine there will always remain some small minority of
> PROBE_FORCE_SYNCHRONOUS drivers - either for niche legitimate technical
> reasons, or just legacy drivers where updating them would take more effort
> than it's worth - so the driver core surely needs the ability to not do the
> wrong thing itself. That doesn't even need to be "optimal", it just needs to
> be functionally correct.

Again, your expectation of what sync probing means differs from what I
had in mind when implementing it. PROBE_FORCE_SYNCHRONOUS is typically
for drivers/modules that register both a device (typically a singleton)
and a driver, and want to unregister both and free all resources when
initialization fails for some reason. Think cases like PC keyboard
controller.

Thanks.

-- 
Dmitry
