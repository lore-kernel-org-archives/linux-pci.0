Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079267;
	b=oe/01eGRgVJtfU5ZpAHks57waH1OqtbyH+xfTk5Db0ABrDxHaDQ+iIMuc1WaJNrxoZUP
	 LoyI6u9dB9Q2dRapAYXZFEeQXBXOy7bVgv8I68KqV4zXGjNNFqIxPZJ+zqY3qwodfihkD
	 ZVXaNzfOu1q4JWWe7aFKeSKTLdjdMyM4E6ButERPKT7zkpH5+ApSdBunWmIcxtd70NoDh
	 LrUfpGUIr4iIZwgZ5yt5QlMkdkryMOIXBDA1g73x0jHDf3ojw6XjdeOfhByPh+bIGq3qj
	 vLWdi3fIg3CYEV28FUlVyvvK3wMfH840o01Ula+ZynvAP37XMsrLKf5fKWMyBR5g4lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079267;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yY5LP8ICr1JF2g7v9NnKIHypc3U29cN0UuFVz/ueM4Y=;
	b=aJCd7W4XsdxKHvji5GGiBOG8o1QCEpygfPGmUEPstT/IYeRwbYLohX81kVl76zFOAAGy
	 Qa/zZASR2BltYje4gmNPJ0DcKL8Qlfwq200irD/ai26d5IHZsr/va+9pn7rWUKyWTV6jp
	 aDuEX43ZcjT0n+dSjxsrwB3ldzZvm587Xaurf8FNIEZmovzzVzHYM4Vr9Wq5o/ltu7/YE
	 yIamEV5YorO4/w3JnDMJpQ3eVurHaSFwHXCEnTCx7M9LU0gmmY4hAK5CrQw82T8pLlhgO
	 x81dx8cBieirKph2TRDUnz8V0hy9RGVZhX89+kB7ciCv7uhFDzIN0yJf1hB2gu4JQzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLUs34fc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75D606A31D;
	Tue, 27 Oct 2026 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLUs34fc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED07C1F01825;
	Tue, 27 Oct 2026 05:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079267;
	bh=yY5LP8ICr1JF2g7v9NnKIHypc3U29cN0UuFVz/ueM4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hLUs34fc/902ITXB31PAbg4PZ4/JcjJ4VHF46IPQTHz5khvL6FkOjBc3o/faJ3WEz
	 2vkZ7AaBydc2/14rTpHjOrFm65/P256OO8ZFQ8tMj1Fhvaad07SZwaqJA2220lPOLV
	 zRaZXxKDQi5yEaCO1DSg/n0xxDMsyP9hnMQVZjEM+4WDJEk8PlV1cChEBnZ5mw8wR9
	 IUfZif0nQfAy96JPKHWXIBTC+I7DKwb28KWDwYf559fn5WtU4+lAsOTNezOIyYL9wA
	 62Qf5YY+Bi6QQ9PrNIrwwXcyRDzRkWbMGd7ug0ZpxzjphCjbRI4t/VEQi2iRL4ZPAo
	 NE7RKeZuc61kw==
Message-ID: <sashiko-outbox-186124@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/23] rust: device: Expose Device from_raw()
 publically
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-9-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-9-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:34:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rust: device: commit message claims to expose from_raw() instead=
 of as_raw()
- [Low] rust: device: missing #[inline] annotation on public Device::as_raw=
()
--

commit 4612538f4ce0b7f345e904370c4f1a9efe8adc51
Author: Alistair Francis <alistair.francis@wdc.com>

rust: device: Expose Device from_raw() publically

This commit changes the visibility of Device::as_raw() in
rust/kernel/device.rs from pub(crate) to pub so it can be called from outsi=
de
the kernel crate.

>     rust: device: Expose Device from_raw() publically
>    =20
>     We are going to call the from_raw() function later as part of the SPDM
>     library, so expose it publically.
>    =20
>     Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

[Severity: Medium]
Should the commit subject and message refer to Device::as_raw() instead of
from_raw(), and fix the typo "publically" to "publicly"?

In rust/kernel/device.rs, Device::from_raw() was already public prior to th=
is
patch:

    pub unsafe fn from_raw<'a>(ptr: *mut bindings::device) -> &'a Self {
        // SAFETY: Guaranteed by the safety requirements of the function.
        unsafe { &*ptr.cast() }
    }

Whereas the diff below actually exposes Device::as_raw() publicly so that
callers in lib/rspdm/lib.rs and lib/rspdm/state.rs can pass the raw device
pointer to C callbacks.

> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b6849e..a355ac9803410 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -262,7 +262,7 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
> =20
>  impl<Ctx: DeviceContext> Device<Ctx> {
>      /// Obtain the raw `struct device *`.
> -    pub(crate) fn as_raw(&self) -> *mut bindings::device {
> +    pub fn as_raw(&self) -> *mut bindings::device {

[Severity: Low]
This isn't a bug, but since Device::as_raw() in rust/kernel/device.rs is a
small one-line accessor in the kernel crate now exposed across crate
boundaries, should it be annotated with #[inline]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D8
