Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736A19C540
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 04:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774412008; cv=none; b=OqPk+PwPVQ5mT3NLvhf/Ws5JibdNXMv3JzCGaNc+Bz1BMCYk2pCvgjNVqgvQ/rNTKdLcW0wZLisiIWkWhwo3gzsnAmmHCszfuEFCPm0ZZsnekPLwgoWpx99uObKLvV8az0TYg2V+6hqSwJ/K9idRwkw0Qi3Uj6clVwg2Lj5f0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774412008; c=relaxed/simple;
	bh=YWJtRNIJC9eKjyIJLS3+9nz0cFYlkBsezKB5NPwjwvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU8M1VKsqhaw2KiAG3JGlhs1EprNXxmZ0k3ZXFHL9PxXYvMFVcyCXRisYoD2HhpcpPCpRr4QLSRgqp6Ze8c1wng0WICaYQlGvSgClLESzXWefe+SkIIWPaoHU5R2dgDQZIF+8Xq57Yg3UDt1voJWc2wmHU1puslSGAPZhnTyCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQfMxbmT; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQfMxbmT"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a693cdf29so518369c88.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774412006; x=1775016806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1zx9FotWDsXciTr6vSKC3+KwJ/ZkglPq04NJzxyt/k=;
        b=UQfMxbmTrLV6eq+Zt9gmka9m+t8q+z8ZRCAYdsprOeurEdoLf8JnuYsFFVGgCP0u80
         baVPFhsV1saSqBD8V97wtaxlx7nk0+/3P1cV6GcsonqQ5viOIjo+lTuW5LAR/rs0F4iz
         vJcYlOT4lzjutaPIvtkQZ62JB1DoFdLQD3rpvUaTfw2oNXZwJHkVJBzb+6dJxqGS1rjm
         tzwDqxawRKAGM4ng9Zf2DsFhuM3vyV1r9XS5Fy2maHOQJ/WDBuvfp5SAKoZOJ/mSNSjt
         BDLh72FCChkaJg1cVlRNXL4ZVY3Vql+d8VoLDueWjsVFswkl3m9YlB3gZ8Dul5vmY/8a
         uwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774412006; x=1775016806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1zx9FotWDsXciTr6vSKC3+KwJ/ZkglPq04NJzxyt/k=;
        b=ET798ZiEU5GzVQRT01n95TqPe2a70tBr7fx2iTeh0WYbuOohD/KfWj9hfycHFCe8Zt
         DZcIsehZhqER81UtTQQMZjAvOtzeiDvEgsCKhAHK9sE0tSttUNe2xswVqpNYSliePkG8
         +gmgutOgWlTfZ/g8/1H3KYAc5XhDVdXomMaw6+vqtA0ERH31ZtMnnLCsfi3tw2OIdY0J
         5gLcYN+qidd2WAfuMhZ3Z6TPlWHzkDrAiqLvFHj7FNKZYkZWPs5ARuQ5PWh+GY6hxxpo
         szRj9NKSPW6J+tIr1qw+YML9u0utalfyNVVmKNEYto7IYXrkgDb/+8utnVPBuPAYB+rE
         jLcA==
X-Forwarded-Encrypted: i=1; AJvYcCXp0RPDpdlnq9ryJdoYmoP9ZENtu1CJ73vAKo5v5FypYPQTM9uWcqI5jOKtypnT1B1TIG/d7zDngqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyb4OhN3wY7BeoMxL/3LnpRNqI5Hg0DX3n4d8qfKgJLpeBbBo5
	3kgTxCOlplTxK64yLOuCgFw2tKc4/ddSR1XGXD7OGArxR+QWdxeuH/Az
X-Gm-Gg: ATEYQzzKXn5GDePXT0DOB6O0WKCCHZn940S2HVSZJDnNhtYfLu64D9UAMuQLiMWkxsI
	svKq/k/FhDUPbllGHn7AMHHsTgiHn1m2W1VJdG4HGQ/W+0KhUzhbMkIitJmjB5htPl5wJ+QIphJ
	9pX1QCleTd1yGg95tOfyLzMLsV7s7KKPrS/e0mGDwB4USN62gspd58BtkqR8mQj1MYT7MYXtNjx
	sQHhxgOfyIXyjRGJSBZ5O0xT7wY0YQOG08TZ7uUKvhbaFNgn3hsOo0or2OVIfJHhcxRgxRGH4qu
	IIWxqpeklkgZEb9r97pnOMCUKOENAxhrZ624DcGP17n+aamiQV20+5ttio/PrIVW9XO0y6uOLw3
	+wP+58ejg2IgoHiPTPolCSrHIvDw8BWhrk6nHy4CQOoCiJ84yLZn8FBHqrTQG4uQStoTphR6eHY
	XzpQyT5z1C/koGuO1P/f8kruZKYn+/8wQjWm5IHQv/1OvlxmKfJD07V62Ms8izBlvEoJQeBEC0i
	/s=
X-Received: by 2002:a05:7022:418b:b0:128:f1fd:78be with SMTP id a92af1059eb24-12a9684c64cmr1091744c88.5.1774412005575;
        Tue, 24 Mar 2026 21:13:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733b4a39sm12292420c88.3.2026.03.24.21.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 21:13:24 -0700 (PDT)
Date: Tue, 24 Mar 2026 21:13:20 -0700
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
Message-ID: <acNgUoWWMCi1oLU4@google.com>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
 <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>

On Thu, Mar 12, 2026 at 12:48:36PM +0000, Robin Murphy wrote:
> On 2026-03-11 9:09 pm, Danilo Krummrich wrote:
> > On Wed Mar 11, 2026 at 1:28 PM CET, Manivannan Sadhasivam wrote:
> > > On Wed, Mar 11, 2026 at 12:46:03PM +0100, Danilo Krummrich wrote:
> > > > On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
> > > > > I have a contrary view here. If just a single driver or lib doesn't handle async
> > > > > probe, it cannot just force other drivers to not take the advantage of async
> > > > > probe. As I said above, enabling async probe easily saves a few hunderd ms or
> > > > > even more if there are more than one Root Port or Root Complex in an SoC.
> > > > 
> > > > Then the driver or lib has to be fixed / improved first or the driver core has
> > > > to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is requested
> > > > from an async path, etc.
> > > > 
> > > > In any case, applying the patch and breaking things (knowingly?) doesn't seem
> > > > like the correct approach.
> > > > 
> > > > > I strongly agree with you here that the underlying issue should be fixed. But
> > > > > the real impact to end users is not this splat, but not having the boot time
> > > > > optimization that this patch brings in. As an end user, one would want their
> > > > > systems to boot quickly and they wouldn't bother much about a harmless warning
> > > > > splat appearing in the dmesg log.
> > > > 
> > > > You mean quickly booting into a "harmless" potential deadlock condition the
> > > > warning splat tries to make people aware of? :)
> > > > 
> > > 
> > > Hmm, I overlooked the built-as-module part where the deadlock could be possible
> > > as indicated by the comment about the WARN_ON_ONCE().
> > > 
> > > But what is the path forward here? Do you want the phylib to fix the
> > > request_module() call or fix the driver core instead?
> > 
> > Here are a few thoughts.
> > 
> > In general, I think the best would be to get rid of the (affected)
> > PROBE_FORCE_SYNCHRONOUS cases.
> > 
> > Now, I guess this can be pretty hard for a PCI controller driver, as you can't
> > really predict what ends up being probed from you async context, i.e. it could
> > even be some other bus controller and things could even propagate further.
> > 
> > Not sure how big of a deal it is in practice though, there are not a lot of
> > PROBE_FORCE_SYNCHRONOUS drivers (left), but note that specifying neither
> > PROBE_FORCE_SYNCHRONOUS nor PROBE_PREFER_ASYNCHRONOUS currently results in
> > synchronous by default.
> > 
> > (Also, quite some other PCI controller drivers do set PROBE_PREFER_ASYNCHRONOUS
> > and apparently got lucky with it.)
> > 
> >  From a driver-core perspective I think we're rather limited on what we can do;
> > we are already in async context at this point and can't magically go back to
> > initcall context.
> > 
> > So, the only thing I can think of is to kick off work on a workqueue, which in
> > the end would be the same as the deferred probe handling.
> 
> Hmm, in fact, isn't the deferred probe mechanism itself actually quite
> appropriate? A suitable calling context isn't the most obvious "resource
> provider" to wait for, but ultimately it's still a case of "we don't
> have everything we need right now, but it's worth trying again soon".
> I may have missed some subtleties, but my instinct is that it could
> perhaps be as simple as something like this (completely untested).
> 
> Cheers,
> Robin.
> 
> ----->8-----
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index bea8da5f8a3a..3c4a0207ae3f 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -954,6 +954,16 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>  	if (data->check_async && async_allowed != data->want_async)
>  		return 0;
> +	/*
> +	 * Bus drivers may probe asynchronously, but be adding a child device
> +	 * whose driver still wants a synchronous probe. In this case, just
> +	 * defer it, to be triggered by the parent driver probe succeeding.
> +	 */
> +	if (!async_allowed && current_is_async()) {
> +		driver_deferred_probe_add(dev);
> +		return 0;
> +	}

That means that you are kicking the majority devices (for now) into
deferral path. I do not think this is optimal.

Does phy really need to request modules synchronously (and on its own)?
Why can't it rely on udev to load the modules and signal when phy
devices are ready?

Seems like a deficiency on PHY subsystem that is stuck in times long
past.

Thanks.

-- 
Dmitry
