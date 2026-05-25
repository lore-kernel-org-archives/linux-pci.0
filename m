Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A8184
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743755; cv=none; b=eblp4+cNmjV4IXURwmcusZPHkggWAfBPnRtPmG8DqXybqICko4JfgUp87EZHDA2PQmqeCwslS078mK51SWlYT/y3hAxh4ruPaslH2qhN/HuuC9IEssWgU05EBxSMWX5ixiJt0NvXQMVOpYLxd+niOhGUSlg40kJIPQ276Krdbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743755; c=relaxed/simple;
	bh=6eAdzlp+1ZjPn5Le89DN3qunR+WVhUNVZYIjaUgVGNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fQnz2LbviyrgMnSmF85huZ/+JrMxoq8e5U8gQJUUb/dgZ5aL0o44T7px7HCkhMPXYIKIlO/3/14L12KW/7IR/o3XyzM5iWad+AyE6/CLJylB0y16lkPJT8Vp+d+77XAr9I7k3XZ9CI1mWoekhYdwUBAGYP525dKhRxpsJX9tke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee/c+sBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee/c+sBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE06A1F000E9;
	Mon, 25 May 2026 21:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743754;
	bh=F+Jy7ZerUS7gRd5AVvK2jK1Cr/g75i9ScHtoOZIoFL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ee/c+sBc0aM//0K6ZQ7KNbUutVoBDNoheZF+AyptBskrpAQTkebprr+kAmqt1GNwr
	 9uRgJIjL3u6xguG2sTKaNgU94r1n+g53umX+d8G4a+z+8mDYKg18mID8HkDGEHr9Sf
	 vB1l6h1cnh+v84iQ2uxn/z1LeM3nHeD1ZNTFKyXxZCxzgubhvRGWumj22nQlehsoUU
	 mTXoLJth4tSJggWya8HnGpBFuGpadVoH1Nb1OLF4vi2uF4qDKzn8k4Pe97baivmTIw
	 SWkf8VD7Fjv8AccSCVnVNtYY8dC3/HZDbZjmXaPSjacWFKv28jZSTptdl6jxu5yo4f
	 tBR6nPz5cIYrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/24] rust: usb: implement Sync for Device<Bound>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260525202921.124698-10-dakr@kernel.org>
References: <20260525202921.124698-10-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:15:52 +0000
Message-Id: <20260525211553.CE06A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The implementation of `Sync` for `usb::Device<Bound>` is unusabl=
e and conceptually incorrect because `Device` is private and cannot be obta=
ined.
- [Medium] The targeted implementation of `Sync` for `Device<Bound>` propag=
ates an anti-pattern by failing to implement thread safety traits generical=
ly over all device contexts.
--

commit 6f765816705f98d508d584483f9224253a79d788
Author: Danilo Krummrich <dakr@kernel.org>

rust: usb: implement Sync for Device<Bound>

This commit implements the Sync trait for Device<Bound> to allow drivers
to store a bound USB device in their private data.

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 88721970afcb7..6c917d8fa8839 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -468,6 +468,10 @@ unsafe impl Send for Device {}
>  // allow any mutation through a shared reference.
>  unsafe impl Sync for Device {}
> =20
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct usb_device=
` is the same;
> +// `Bound` is a zero-sized type-state marker that does not affect thread=
 safety.
> +unsafe impl Sync for Device<device::Bound> {}

[Severity: Medium]
The commit message states this is needed for drivers to store
&'bound usb::Device<Bound> in their private data. However, since struct
Device is defined without the pub visibility modifier in rust/kernel/usb.rs,
how can external drivers name this type in their structs?

Additionally, there does not seem to be an API to obtain a Device<Bound>.
Calling as_ref() on an Interface explicitly returns &Device (which defaults
to &Device<device::Normal>). Since USB drivers bind to struct usb_interface
rather than struct usb_device, shouldn't drivers be storing
&'bound usb::Interface<Bound> instead?

[Severity: Medium]
Would it be better to implement these traits generically across all context=
s,
such as using unsafe impl<Ctx> Sync for Device<Ctx>?

Implementing this piecemeal leaves Device<Bound> without a Send
implementation, whereas Device<Normal> has one. It also entirely omits
both Send and Sync for usb::Interface<Bound>, which is the structure
drivers actually bind to.

Since the Ctx type-state marker is a zero-sized PhantomData that does not
affect the thread-safety semantics of the underlying C structures, a generic
implementation might prevent downstream drivers from breaking when requiring
Send or Sync bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D9
