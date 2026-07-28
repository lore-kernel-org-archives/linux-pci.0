Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4444C51A;
	Tue, 28 Jul 2026 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269259; cv=none; b=cM9EapITZQfpc25JXFaglkoqdKX7vT96lAbSSAcPi/X56gKOjk7Jy+o92dBUzvwGhcl08yEFZYWICeiIUFliIL7np3FS18g+sFpJqcOa6EYryarShqrDoEhmHEgFhOC2c8xZ4eiSpXwennr/dHuW8Qwx3jU7KNSffTRrplYWK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269259; c=relaxed/simple;
	bh=g58gRfs5c0V3SCdYvHY5lSFx4//gOQF/FXNiiAMSmC8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LL6Kdg05gpUWvf8PwZMPvqySuPnPsgl7JbkVyVs6rELH6/NUpH1di8AJXke2N8OZ1tBQ636QoFJRTb0BF/tQ0/FcvT0NItZy11yRg+e2XAZMIt2YkmD7tNsz9ZD2eeE6Glz53vxv73sQjf1JxR5aljhEzmIw/+MFMycCfQGwLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeDRXvjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeDRXvjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728331F000E9;
	Tue, 28 Jul 2026 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785269257;
	bh=g58gRfs5c0V3SCdYvHY5lSFx4//gOQF/FXNiiAMSmC8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=SeDRXvjIo0PeOAWB+qm714ij5PQEMCtF/M5mCTstkRgZ5GlDTjfpliDRdVBI01r24
	 A3mnQRZfkOZz1ImfR3pup6DRJGJAXc8bp6jDvuUQ6vmzewnNFVDqc212us6hPGnbQg
	 itJjunYpXKxrSJvCRsQsgLR+fqzJ86ZG/k7ji2fpN780oeUu1BQtUlomxQEWx9lPeP
	 e9GMLHy8TXVI55RXMR5QGi9kUQURJV8RhboPjw9lH944vH0J9PRhJKWHnK1eljsRX4
	 zXiTvp1K/R5u52VQHfNvycvV7Nuwud/mx5T2+cfbOHNA/igp4artW42pcwECRKvhMJ
	 m+39UEt+/dkIw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 22:07:31 +0200
Message-Id: <DKAH4S5IE3RZ.10VD33NMVVLDR@kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
 <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
 <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
 <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
 <DKAFMD8X5LFP.UPKPHK5FYZPH@kernel.org>
 <DKAFRETW93IW.SXUWFVB47V3B@garyguo.net>
In-Reply-To: <DKAFRETW93IW.SXUWFVB47V3B@garyguo.net>

On Tue Jul 28, 2026 at 9:03 PM CEST, Gary Guo wrote:
> On Tue Jul 28, 2026 at 7:56 PM BST, Danilo Krummrich wrote:
>> On Tue Jul 28, 2026 at 8:26 PM CEST, Gary Guo wrote:
>>> On Tue Jul 28, 2026 at 6:01 PM BST, Danilo Krummrich wrote:
>>>> I may have a slight preference for a separate subregion() variant for =
the
>>>> purpose of working around generic_const_exprs, as it probably is a bit=
 closer to
>>>> the final solution, but trait methods are fine with me too.
>>>
>>> I am not sure that's the final solution that I want. I want arg-positio=
n
>>> const-generics which would syntactically look more similar to `build_as=
sert!`.
>>
>> arg-position const generics would be great, but that's just a syntax dif=
ference
>> and not related to supporting expressions involving const generics?
>>
>> In any case, I think my point about being closer to the final solution h=
olds
>> regardless.
>>
>>> Personally I think most issues with `build_assert!` can be fixed by hav=
ing
>>> lints, which is on my radar.
>>
>> I think it can be improved, but in the end it relies on compiler optimiz=
ation
>> that may or may not happen as expected.
>
> It'd be a compiler bug if const folding is expected to happen, the whole
> BUILD_BUG_ON depends on it working.
>
> `build_assert!` is a useful tool that I'm not giving up. If there is a ne=
ed to
> use it, then I'd use it compared to having two variants to do the same th=
ing
> with different syntax.

It is indeed useful and I don't want to give up on it either.

But, it is more fragile than const evaluation, so we should only use it whe=
re
const evaluation is not sufficient.

In the case we are discussing the problem is that const expressions involvi=
ng
const generics are not yet supported, but in general it should be.

This is different compared to e.g. read() where the syntax difference would
actually hurt and const generics would limit flexibility, where we actually=
 rely
on the compiler to eliminate unreachable code paths regardless of a value b=
eing
known at runtime only.
