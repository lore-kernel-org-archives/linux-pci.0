Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4B456297;
	Wed, 29 Jul 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353300; cv=none; b=sVToAoafxOCBkkuYPG/Mcj7v17WckIQlIgYhySwvKoP14/qw0bmCw0HH5GzFHkRw2tU4MbzNDo7IW0RyzDquaAZhihaJJOgy2iCQMK1ZxSMySIdEZFLEJPUlF7zz5K/wiDhtxGcq0G23YxOpkJxongp2gLjMe9D4oxuJ+UeJahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353300; c=relaxed/simple;
	bh=8ImxKQKuYw5sw1oUP9bkTp8XSTLsuH8+8VjuAe+A//w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FxdpdlBo8jCef6mzpfszfeExQZnOxqutipYLDCmUYKg+yrvwxg9kZXK5IRo6ZSOK0T3b71bBEUfn8z1sAfy8m2FagdGnOw3BflKU//ltdQf+OtepVT7maBybYSCIzpL8YwnMQG7CkiveRBESLscFvZe7neqJb1xXUo59Vt++2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRXtw6tS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRXtw6tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3292A1F000E9;
	Wed, 29 Jul 2026 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785353287;
	bh=4R/0n+N4ulmB6HFZBWN2atbMsZoR5KA7qt0R9Wi8aQY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=dRXtw6tStg1MZ/KeEAAJu3mjRuTvmyqH/7b1K78OvAkXMNWtRjfTJTPJ9MA6dD3Qx
	 I6TvbmMxkSK2nmERJTC/FhDkn3BZsPJwh2KTT4FX4loX0jINNzP4Q2mBJyFXaPJZ9V
	 liz2QQtK5MrEePIFbIE74S7BAwu8j2e0oOfVn3WHt6zNFM7S1b3bUR7mf1eVbyqnKA
	 m66DrWmjAXM7hsA59hVLqBBrtFqfxlVp1SMwMj/tmuVSHsBqm6Oyqj2S0yxcaS/Qps
	 CxobFI9nr3txmUlDx8JCeONUXajcBW7n1V1DZjei2PpIyz6U9Gf9btpBYymG5mhiNq
	 P15efMzPuJASw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 21:28:01 +0200
Message-Id: <DKBAX2P3POG1.3CVTICXR9RYHS@kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
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
 <DKAH4S5IE3RZ.10VD33NMVVLDR@kernel.org>
 <DKAZD90KWY0L.2E1289J71UF8Z@garyguo.net>
In-Reply-To: <DKAZD90KWY0L.2E1289J71UF8Z@garyguo.net>

On Wed Jul 29, 2026 at 12:24 PM CEST, Gary Guo wrote:
> On Tue Jul 28, 2026 at 9:07 PM BST, Danilo Krummrich wrote:
>> On Tue Jul 28, 2026 at 9:03 PM CEST, Gary Guo wrote:
>>> On Tue Jul 28, 2026 at 7:56 PM BST, Danilo Krummrich wrote:
>>>> On Tue Jul 28, 2026 at 8:26 PM CEST, Gary Guo wrote:
>>>>> On Tue Jul 28, 2026 at 6:01 PM BST, Danilo Krummrich wrote:
>>>>>> I may have a slight preference for a separate subregion() variant fo=
r the
>>>>>> purpose of working around generic_const_exprs, as it probably is a b=
it closer to
>>>>>> the final solution, but trait methods are fine with me too.
>>>>>
>>>>> I am not sure that's the final solution that I want. I want arg-posit=
ion
>>>>> const-generics which would syntactically look more similar to `build_=
assert!`.
>>>>
>>>> arg-position const generics would be great, but that's just a syntax d=
ifference
>>>> and not related to supporting expressions involving const generics?
>>>>
>>>> In any case, I think my point about being closer to the final solution=
 holds
>>>> regardless.
>>>>
>>>>> Personally I think most issues with `build_assert!` can be fixed by h=
aving
>>>>> lints, which is on my radar.
>>>>
>>>> I think it can be improved, but in the end it relies on compiler optim=
ization
>>>> that may or may not happen as expected.
>>>
>>> It'd be a compiler bug if const folding is expected to happen, the whol=
e
>>> BUILD_BUG_ON depends on it working.
>>>
>>> `build_assert!` is a useful tool that I'm not giving up. If there is a =
need to
>>> use it, then I'd use it compared to having two variants to do the same =
thing
>>> with different syntax.
>>
>> It is indeed useful and I don't want to give up on it either.
>>
>> But, it is more fragile than const evaluation, so we should only use it =
where
>> const evaluation is not sufficient.
>>
>> In the case we are discussing the problem is that const expressions invo=
lving
>> const generics are not yet supported, but in general it should be.
>>
>> This is different compared to e.g. read() where the syntax difference wo=
uld
>> actually hurt and const generics would limit flexibility, where we actua=
lly rely
>> on the compiler to eliminate unreachable code paths regardless of a valu=
e being
>> known at runtime only.
>
> The offset for `subregion` is no different to the offset for `read()`. In=
 both
> cases you are supposed to only supply build-time const values; and in bot=
h cases
> you can argue they are needed there due to const generics being too limit=
ed to
> what they do.

I see where you are coming from, but I see it from a different angle:

An offset given to read() can legitimately be a runtime value that happens =
to be
constrained in a way that the compiler can proof that it is within bounds (=
with
dead code elimination doing the rest). We have reasonable use-cases where t=
he
offset given to read() is not a "true" constant, and hence build_assert! is=
 the
correct tool.

subregion() is different in this regard, as we do not have reasonable use-c=
ases
where the offset is not a "true" constant. (And I would guess that this als=
o
made you choose the implementation you picked for this patch.)

It just happens that we hit a language limitation where const evaluation of=
 a
"true" constant does not work, but that does not make build time assertion =
the
correct tool, it just makes it a workaround for the existing limitation.

This is also in line with the documentation in rust/kernel/build_assert.rs.

> We probably could even just add a method that gives you a subregion based=
 on
> `IoLoc` similar to other methods. This actually might be a good idea that=
 I'd
> pursue in next version.

So, you are proposing that subregion() takes an argument of type
L: impl IoLoc<_>?

Where would this argument come from?

I assume you would need to bring back

	impl RegisterBase<Foo> for Bar {
	    const BASE: usize =3D 0xff;
	}

impl blocks? Which seems like just adding boilerplate? Or do you have somet=
hing
else in mind?
