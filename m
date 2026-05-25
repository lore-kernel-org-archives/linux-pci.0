Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137E26D4E5
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779744833; cv=none; b=YI+dWbQ0AAa1hOhYBOOxL6ufoEHlWE7SffZKeZGf7wXt+ZGXHgSfxEbcndLv8qz/kQB5SXaO5qnOXuL7wqDpZZo77HShs7cqw6QQhaxcXK24VpcDi2qPgpwsGYGJ/OTg7mzn1krkHipzTMk9wSa7VrRD5b2kHUdy3DWKVkDAmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779744833; c=relaxed/simple;
	bh=ejdpD7kwwDa9U/b6s5Dn/rPvsTLWZuRhIGGNNzkkOMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIIdLJrMR33CPNNHXUJ20OzBGFApNZ9fo+MWBX3uMr2HcUjvOE5Se67JcO3qk/I/05D2anzuorPPbuYt2biNVqfuqqAnwtaTZCbXkHiDQ2fMyZ/HQQ5+K4YIeXAF5ys9Sd1eAbWl+sKUgRhfRJRnzCq0xlbsooQHcbjR53rYOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff1sEEA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff1sEEA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780B91F000E9;
	Mon, 25 May 2026 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779744832;
	bh=nzrk5e3t3peo4oVSANVCwDmQp6a5zpzI8so4v8ssOaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ff1sEEA0cPmUZHz5AxauJsfWuwUMtJOXmtfD/ev5DIQFhg6H67yIvqWnLiw1iAi/2
	 7y3KehQlP07RiWLMwT9XeGKmrN/1mmG6zJWBc8w6WPPV+0NEiAzUpm4u1hbTxWc4AR
	 OT3EoNpygpXhonTrWr6nnj47wSLwMx29a6VHfyunjugohmxZy8xjAuCxS+eoZefkmY
	 mXVKr8mFScKeQyWZ3SHcjNQSvN7wBnAn3Rf/eiaKoyou+zzss3Bw2KZcdC2jrNRVSg
	 I0sgudOuxTJaJOB+2mTcKjGYW3QdiepKSuSU7tV3QUo6QUQgUOh0DgMqHWSGPcYuo3
	 4O6I5+H5jxobQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/24] rust: platform: implement Sync for
 Device<Bound>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260525202921.124698-8-dakr@kernel.org>
References: <20260525202921.124698-8-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:33:51 +0000
Message-Id: <20260525213352.780B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch manually implements `Sync` specifically for `platform:=
:Device<device::Bound>` instead of generically implementing `Send` and `Syn=
c` for all device contexts, leading to multiple gaps in thread-safety trait=
 coverage.
--

commit 1e7bb03e034e1d473f033686b8475722ba9f181f
Author: Danilo Krummrich <dakr@kernel.org>

rust: platform: implement Sync for Device<Bound>

This commit implements the Sync trait for Device<Bound> by relying on
the fact that Bound is a zero-sized type-state marker. This allows drivers
to safely store &'bound platform::Device<Bound> inside their private data
while remaining Send.

> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -565,3 +565,7 @@ unsafe impl Send for Device {}

[ ... ]

>  unsafe impl Sync for Device {}
> +
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct platform_d=
evice` is the same;
> +// `Bound` is a zero-sized type-state marker that does not affect thread=
 safety.
> +unsafe impl Sync for Device<device::Bound> {}

[Severity: Medium]
Could this be implemented generically for all device contexts, such as
unsafe impl<Ctx: device::DeviceContext> Sync for Device<Ctx> {}?

By adding traits piecemeal, this creates a situation where Device<Bound>
is Sync but not Send. This prevents valid use cases like moving a
&mut Device<Bound> across threads.

Additionally, Device<Core> remains without Send or Sync implementations.
This restricts sharing &Device<Core> with scoped threads inside probe(),
which could otherwise be useful for concurrent initialization patterns.

Since the underlying C struct is identical and Ctx is a zero-sized
marker, a generic implementation for Send and Sync would cover all current
and future contexts while removing the need for duplicate unsafe blocks
across different bus modules.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D7
