Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80438487CEF;
	Fri, 16 Oct 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174947; cv=none; b=YD4OUQwsNAyb0dcyj3kGHgMACjLNIPCWx7xlNBg58LOOuLgaT1GtRVx6D43QXks7+HmX8E+bC9tk1pPLiN8b4jxBYwKH3N355js4xtd37ZJd+crYP7iiJQxCwJpVwhnx/Dd3FzipVEwbcG0VNAWr1uRzjmWfnRsEdRTVDsDz/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174947; c=relaxed/simple;
	bh=ROjo2f3S6aQQKew7sM8dGru/0I+lCh1q/RyhkyCAuc0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gzie4jGpt9C97orT4SlBSkO7Dn+4/P4P92jiVmG6Y5l1y9V91OsLak7kZKBGbCse14z51Ve5+Su0KE6QmHeEzbe4wqbMTfH/n8r35vAd3hD8YoIVvxl+rGFTbp9r/oWDri6YIeEbyosFYytiqBl4F3Bc1iLt6Ot1QS4sY4Ia5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyKZ9s+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyKZ9s+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D221F000C5;
	Fri, 16 Oct 2026 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174946;
	bh=Z3dKk3ur9CNua0gdt6vSR8onZqYzxdw1KrflJgSL3Go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyKZ9s+u1KGf7T3nDhEFcbKxvH2O45bBJW2vcv7+JHIZlJZN7zRYdT6QHnVCenXng
	 QPTOm0q4AwJZ8JXsPfg6PP+cnhAOzUhnoawHbGCZc2vZ6h+Hlt07sgzpUci6vSZj4m
	 1lSQ7pQcG8iHXRzyd9xmGQxi8Wc4Ua8VjQtYY4B59r0ZGwzuguvjzB/11B3nedGgQs
	 3mE/hLU5mjeuU1waFCiwn5Mu5EPKfQ/Bo6JZGcbXVf7kQEeWN7XsPfpPo2Lu+2DNO/
	 jYyb16PJIGhU3lLls/19cRvPzpARqCSL6iDrEhljo9VSZgavkFSHEfl81wbLZ7Cupk
	 rRT/7jjaDozMQ==
Message-ID: <sashiko-outbox-174765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 3/4] rust: leds: Add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261016-rust_leds-v27-3-2c296d8a8e5b@posteo.de>
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
 <20261016-rust_leds-v27-3-2c296d8a8e5b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 18:22:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: missing #[inline] attribute on MultiColorDevice Deref impleme=
ntation
--

commit 613f67478931d09e9dba3aabd68d89e0638569b4
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: Add multicolor classdev abstractions

This commit adds Rust abstractions for multicolor led class devices. It
introduces the MultiColor led mode, MultiColorSubLed, MultiColorDevice,
and DeviceBuilder::build_multicolor to handle registration and lifecycle
management of multicolor LEDs.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..aebc8a24712ab
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs

[ ... ]

> +impl<'bound, T: LedOps + 'bound> Deref for MultiColorDevice<'bound, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.ops
> +    }
> +}

[Severity: Low]
This isn't a bug, but according to the Rust subsystem guidelines, small
functions in abstractions that merely forward to a field or a C binding
should be annotated with #[inline].

Since the Deref::deref method implementation for MultiColorDevice is a
trivial field access, should this include the #[inline] annotation? Without
it, the optimizer might be hindered from inlining the dereference effective=
ly
across crate boundaries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-rust_leds-=
v27-0-2c296d8a8e5b@posteo.de?part=3D3
