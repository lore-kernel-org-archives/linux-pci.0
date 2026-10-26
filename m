Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054781;
	b=eY7MfgvIKMVexMWErf6N5Xy2hmmwGI6wtkj36Gq79fyeoYiK5bqjw84fs0rchZxjrEP7
	 0Txpjofs4uoXV1oW7+cQb50jKfin2D34IDRrdWXZ7vfu4n1gb1cUNk13VoPn2vzEXjlVu
	 RzVNuBDLIAPa37Jd5aXrdXjTKnS2apGG7ftQS1iCw5JP1uMg0W9USY2AKscnmX9qcsdFy
	 q4kgEslyp1dWTB1O7C46qIo49sFGGXPuz+sz69AZ14+wvI1H+SuxC4k2v9cYI7nzes5xb
	 vgUTEPdhaL2uEhDBEufR9T5UgZ/kQVpjm4uCgGd33lI4KU06k8UQbhcrE7eo0WcISIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
	b=Ve6T54MTMmcrYawzhedcLV7539c2nEeMqwHdpcsJY/XeyRFt6iRHSTJ2OC/LWz2bJCoJ
	 dDYg3dAMCDsDw145gN4bhbPUkMMJb0RlGQg5xANutoSms2VLE6DvbiZrg5yAJxpOz1I2P
	 faclwWamaYDmPwfM7xZJQW/90eQhfoZdXmVEmRUAIWjdowRM83CksxR0D3+GQlylUk9gc
	 e+B0h02ee1SCC8Av4kLr/JDNQ9sOAV+58bAIWZy/ZpC197bLL5jH9uDtYZw7gxiry3WTA
	 NtPo35eyF2O2MhjPjsagKOSycbNI3pL4klTg5jLwd4C5Kwn6Ob5yqC/635+b8B2q6yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FkMZwh2x;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF7606A324
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54EF7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FkMZwh2x
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f1cf92c9eso430062085a.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793054775; x=1793659575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
        b=FkMZwh2xzPGwRXd/6L6YakG28E0XxcbpH4yKhlkVxLiFKRDjnkg0rF4SuQFtOzIsX3
         f5EydNInmzCSCkyh6zkwX5LrW6pJx+yykjP8eF8zTTd4GpSQj2j9YnRNaZqf70z8RmUZ
         V0j9HOG4zRyyPYbjGh8fDJ0CD1b0yexVSSPmIWU3JWr5lLooPlsfB7nv06CCSg5v12eV
         SoxqEP3dz0sh5FDLSqHEK/sK60fYdYH1JO0HlXuGIhkW+uO84PFYtLiQpk8JsiURcZjY
         uPsNy3n6D4nHtcEj11lG1ob2im6ANFeMkqY+1XCA/fQxPdUxjOQ6lMGPBUzC0mYbVssK
         Q32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054775; x=1793659575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
        b=upH9AnCt/yqkzQTdSlylVHybLpgI12h3YpWoa2O5Mi6LZq/2UkkiKJ1hJYCYPhLxAH
         Ifdx+Vot3UgsJvxjnwa5FhsXOtrnTy8QCbBsi5gzhs6X9t8po9XNEaJpdSzDGMzBwy3G
         UcZJE83IfKI6quk7/yMDKDsc7ixLLXtY5eZ3ibUXn/Su98fhApV8cNlc488a8ZNq6NFj
         2QKyWMlwLi05yzA2lUF2UnCuXelh86C1lYUSQAQUG/cWt5LgJa+2+lvbvUsE/7xpwLur
         dAT6/fROvPAJ6dmNOj/xkyW0NC9Gmjmlj0FAW6R3J2kVCd59c2Sl3eVL+IpWy4dbRnTZ
         Ap1g==
X-Forwarded-Encrypted: i=1; AKwUvBygrU5/EHYmHd4PXRu1z4lIcIHLkESqucercq2WK3OGrx/IffhR7vI/KdEEoT9q0Qyk0YIzHa7R578=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeZL0Vjfggj0FwUM5TPh/vsZHiRBFU6U+LPNrPRvGMz6kAHoWj
	UaLbHeJqUr0jXFnWm9/uogKPNbFgXfq/0Uera1GhrKqRCUi0w3oL+CBN2dmb1AkM7PY=
X-Gm-Gg: AYBFou3i/vxQVedz36UxFDqmZR+nAAn9H6o8T8OqHg+MrKpb2W/RxELpaYwTQok5CWj
	3PDZgcnZtEAC38XAr+mwZIlcWO7Vut5kn1AE9NMoGOQRGJ6zzrPjjQf0CFcAtjltBO8/8U5RTXH
	LUb067mzGlomIcCqXR0M3EPFtUuMDqc9xvON0giNwyezG4TcWLmnmqAqdvTUEh0gkatXo1ACJ+Q
	GOGZuseGK9ZC07C49drErRZznT+e2rLCme73lGN7Y54jPi+Dfpw211Gqpu5cGr6dP6YUQm38UgA
	FgloWczIblZVrP891G0eODOcLaAYEiKPosVtAftzuNRHghCaGy8UG47nSzsDv6H2tDVhkOpgwUR
	OQZrs4aPnJZPLI3LmrAseDnEAp0J76N9iL9XAd4ur39B4m5gbqW0Pj77t4vU+ZZ5vc5nDrLXvrb
	FH3QSmcK1HaaoR6SxGBZc0X0eYaVr8jLWP/x6QRYs4DuCAms5Lf0SXHetiIZtJxSvF1gsHlq34I
	tfnXcb6dAlek5dU2YM2kaOStFA0m8r5j+OW001UebKxgXZzFDG/nVPwVt3AZreoQtCtn3kRYAG9
	XQdwvS7fDAq3ViPXeNuD/Pnqg4aLC6tcVrvUcA==
X-Received: by 2002:a05:620a:4728:b0:93f:2eaf:64cc with SMTP id af79cd13be357-940ef942794mr1259449285a.44.1793054775098;
        Mon, 26 Oct 2026 15:46:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f05b20e0sm810207185a.3.2026.10.26.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:46:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLTSF-000000087nJ-1Z9f;
	Mon, 26 Oct 2026 19:46:11 -0300
Date: Mon, 26 Oct 2026 19:46:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026224611.GB1685504@ziepe.ca>
References: <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
 <20261026184312.GA1685504@ziepe.ca>
 <2026102604-tint-catcall-433e@gregkh>
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
In-Reply-To: <2026102604-tint-catcall-433e@gregkh>

On Mon, Oct 26, 2026 at 09:05:06PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Oct 26, 2026 at 03:43:12PM -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:
> > 
> > > This is needed for two reasons: to save hardware and software resources
> > > when creating a large number of VFs, and to allow the PCI config space to
> > > be configured *before* the driver starts using it.
> > > 
> > > There is no in-kernel alternative.
> > 
> > Having userspace involved in driver binding has also always been the
> > plan for confidential computing needs. We cannot have a device driver
> > bound across some of the HW transitions like TDISP shared/private, so
> > there has always been an expectation of bind/unbind.
> 
> What, why?  What forces that decision?  What's wrong with the proper
> driver for the hardware being bound automatically to the device?

It would be a proper driver, with a real match. I would expect this to
be done with sysfs driver_probe, which is like bind, except it doesn't
override the matches, AFAIK.

There are two sort of related isues. Userspace is in charge of
sequencing the new PCI features like link encryption and TDISP. They
have complex authentication policies tied to them so the kernel can't
reasonably do it. These features change how the CPU does address
translation, effectively it adds/removes the iommu - and that can't be
changed while the DMA API is active or it breaks every translation in
effect.

So.. We need a gap a system boot when the driver is not bound so the
PCI stuff can be done prior to driver_probe, and a gap if there is a
PCIe error of some kind to do error recovery and go back to the start
to reauthenticate and reload.

> > For this case the existing sysf drivers_probe is good enough for bind,
> > but we must have taint-free unbind for PCI devices too.
>
> Why?

See above. That should be the easiest thing to ask for! PCI is hot
plug, disabling unbind makes zero sense from any way you look at it.

> > I think this patch should be reverted ASAP, it is a pretty major
> > regression for a lot of users.
> 
> But this use case hasn't even happened yet, so what would regress?

I'm reflecting the other commentators, I care about VFIO too. I think
tainting every hypervisor is unacceptable.

But for CC I find myself one of the maintainers for that now and many
people have been diligently working on this bind/unbind direction for
a long time now. If it goes away I have no idea what could replace it.

Jason
