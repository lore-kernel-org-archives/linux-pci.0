Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D31D9A5F;
	Sat,  5 Sep 2026 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640227; cv=none; b=BMhHXuM5RrlY5bvCfCg7eeUMQTkC8lZ84AjTMFqCfLbBDZZ/XKxxm3Vrq5W42FOvDmPI1VGJNvWu3DZy9RmXkBTxETFXMD5rbPF+rmbo4XtmAm1XHy/VlTzDEPf4E3xOC79rNreTqvXIDQDd0a2WTbzE5uIQLNnEblcAWybFKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640227; c=relaxed/simple;
	bh=h3hA5p6+GQOgQGc4c3qDgrkXTHcUOqGMs+AlHscWUQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OfXK+I+Ms4MgwdumtX4Ev4/+XqRv6KLSvSqTsZZfMlThiqSFx5v6VpK4JKRGRTzpDpqnyw95z3mUni99+TIFuJ82ncAMtVS6acNmnJ/LlphML/RnOMaRRZfx17P/R8pe0Z1PTq+lPbQy8EVU1qqwoL7sXU2vEzj23GXEeG40LBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=skPCZuyW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xClnT4gx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="skPCZuyW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xClnT4gx"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788640223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwgSr9LF1AaQKstntdYXF4tsMbm8X5Lx15fwX+9hr5k=;
	b=skPCZuyWro0VW6391LtWlzrr/B1W1w/re6wD9oT3npVcauGo05kkwL78ny2VUxbQ4h4nbp
	cj5IQ+1A4obQd3tT2NMZcEwGhi0c5VkXgIW/swYV/fKuOcb60G6nAD8BMfDY97pE5EUxdz
	N+J4pmuFMOZgRS3xtYHK/ZLzjFjp1dz85hlulDsMZKKwBjhzlReZuhzkcRzKmSkLjNUSNz
	p/+UYHaNiWMKrbJoxMk+kuMyrENVwuJh78/3RcXtrncBlBwN8CAy2nzvj42sWOKRkXJG8U
	2zmQrWEee/uqKDmY/58HJDUl+wCj1r8M31dMqCCj0QvWtKV3vswOf73AZpTpNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788640223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwgSr9LF1AaQKstntdYXF4tsMbm8X5Lx15fwX+9hr5k=;
	b=xClnT4gxHr/HnwlWOjClcB0G5DjEE+jqWtE0d0pRDLr92cUPXaH+71Z+zm3v2cOwKwImZi
	iqdeo1gS0rmQ50CQ==
To: changfengnan <changfengnan@bytedance.com>, Luigi Rizzo <lrizzo@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.65629680.37f4.46ab.be84.09ae39446f28@bytedance.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <aoaoERD5m1MNvMWd@infradead.org>
 <CAMOZA0JrLia8NU1-4JEJAe+p65C19HsRGU6VK7sLAjNFKm8G3w@mail.gmail.com>
 <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.65629680.37f4.46ab.be84.09ae39446f28@bytedance.com>
Date: Sat, 05 Sep 2026 22:30:22 +0200
Message-ID: <878q5f5tlt.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20 2026 at 19:46, changfengnan@bytedance.com wrote:
>> From: "Luigi Rizzo"<lrizzo@google.com>
>> Date:=C2=A0 Thu, Aug 20, 2026, 15:35
>> Subject:=C2=A0 Re: [PATCH v5 0/7] Global Software Interrupt Moderation (=
GSIM)
>> To: "Christoph Hellwig"<hch@infradead.org>
>> Cc: "Thomas Gleixner"<tglx@linutronix.de>, "Marc Zyngier"<maz@kernel.org=
>, "Luigi Rizzo"<rizzo.unipi@gmail.com>, "Paolo Abeni"<pabeni@redhat.com>, =
<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Bjorn Helgaas=
"<bhelgaas@google.com>, <netdev@vger.kernel.org>, <linux-nvme@lists.infrade=
ad.org>, "Fengnan Chang"<changfengnan@bytedance.com>
>> On Thu, Aug 20, 2026 at 9:09=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:

Can you please fix yuur mail client so it does not copy all that
redundant headers into your reply?

>> > Also how does this interact with adaptive polling code inside drivers
>> > like NAPI or the upcoming nvme variant?
>>=C2=A0
>> GSIM acts at hardirq level (so below NAPI, and above device moderation e=
.g.
>> the one in ethtool -C ...) and is completely orthogonal to those other
>> mechanisms.
>
> Hi Luigi:
> The NVMe variant that Christoph mentioned is this patch of mine.
> https://lore.kernel.org/linux-nvme/d9210bcdf73fbe1ac8b6ec132865609a3ed686=
88.99d43a8b.dfff.41d1.b07d.0592a12473d2@bytedance.com/T/#m561d1366119620556=
41f331e600e719de1e7c573
> I took a quick look at your implementation, and I wouldn't say our two
> approaches are completely independent.
> I=E2=80=99ve run some tests, the test methods, environment, and data are =
detailed in
> this document:
> https://docs.google.com/spreadsheets/d/1p3XqVpKgx18QhqTFb0KlJfEW9giWDGSUu=
oKqCZzdZLg/edit?gid=3D1100001004#gid=3D1100001004
>
> it appears that GSIM is only effective in scenarios where multi disks at =
very high
> IOPS; in some cases, there was a noticeable performance regression.=C2=A0
> If there=E2=80=99s something wrong with my configuration, please correct =
me.

So we have a NVME specific mechanism to tackle the same problem and a
more generic version which is subsystem "independent".

Can you folks please coordinate and get your act together so that we
don't end up with two competing mechanisms which make things worse than
they are now.

TBH. I despise the NVME is special approach because it's fricking
obvious that this is _NOT_ a NVME specific issue. But sure NVME is
special as all other subsystems are special.

Q: When do driver folks actually start to look beyond the brim of their
   tea cup?

A: Probably never ...

Thanks,

        tglx
