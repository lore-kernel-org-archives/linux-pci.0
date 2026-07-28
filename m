Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2B2E888A;
	Tue, 28 Jul 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258080; cv=none; b=VUkP+kKh+lkb4T7JHeyU77ITDFKItT0kP+xz/DtNIWQpEF4aPoajj88YQ6+MTVHGiws7VJhL/oYf/pMxSrOAjt5ytsUG3HsjLx9LqSOhGjsGZ/ZgzppYGSqsUzUzShMcc5IZyGwWUEqM79JGtNjmNmm94JvNsskEwb/K0pM3/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258080; c=relaxed/simple;
	bh=MvOyPm0OvxaBHSilVu7AshLW8XnoVziVrisixs/IqO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=a8r8yl4cpDvyO7ISAxTCVfPE5LOqEEOyRHGY748F6oUnx5NSSeONwsW2gjqB4F8yTNNctst9+0uqJsGfgfZGFyofk2R1RTV29Yogyx8xAT9zt0YTn8ox1MqcUcLj595ugDRFS+JXwOf+OxENz64ZfrFIU6uLJ+aF7JQByILaPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlspHBOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlspHBOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C524D1F000E9;
	Tue, 28 Jul 2026 17:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258079;
	bh=MvOyPm0OvxaBHSilVu7AshLW8XnoVziVrisixs/IqO8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=BlspHBOWZYLezf3OfdCf9nATqVDX9JgadDA+zhTJ+rvVUXVhS1QHNTxehILUmMgjj
	 A8djzFY3yhwu7mT0liyuqBs9QW6/2rrWJc8S7c/V6YaWx+W/bOAWjD+GGD1KEsz4/y
	 ADKWPmf8+li8WTshvYsnEud4PSTBToaNYGp4ODCf1xogVtrcjnJe0WK2rH3NaA/huB
	 JtulGZ3UJ8oVdxZlgQ5t8gpQ8Tk3YyJCkUK6u8QIkEJz8roAITzDE9BvnXLBHdT3Fl
	 uvl9365qrvzZHNxqYDTRIMDH8gh/ccEfWwqszPSjMo1wcrIOwMXXocGHSV00929ZGv
	 e5a0/BAYSUniQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 19:01:13 +0200
Message-Id: <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Cc: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
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
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
 <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
In-Reply-To: <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>

On Tue Jul 28, 2026 at 5:09 PM CEST, Alexandre Courbot wrote:
> Great, keeping this commit purely mechanical sounds good to me if you
> prefer it that way (although one can argue that the refactor itself is
> also mostly mechanical as the end result shouldn't be more complex).

I don't really see much value in this intermediate change; it's not really =
less
invasive than to do the refactor I think, so let's do that.

>>> And I suspect that once this is generalized, `Falcon` won't even need t=
o
>>> store a reference to the `Bar0` (and potentially poke the I/O of other
>>> engines) anymore.
>>>
>>> Actually I would like to push that even further and replace the
>>> `pfalcon()` and `pfalcon2()` trait methods by associated constants used
>>> to construct the projected view in `Falcon::new`, since the projections
>>> are all constructed the same way, but doing so requires
>>> `generic_const_exprs`. :/

Yes, that'd be best.

>>> We could make it work by moving the `OFFSET` generic argument of
>>> `subregion` into a regular argument and enforcing its invariants using
>>> `build_assert!`, but that would require `subregion` to be
>>> `#[inline(always)]`. I don't know if there is another trick we can use,
>>> if not otherwise I guess the trait methods are ok, especially if they
>>> are only called once in the constructor.

I think this is fine if, as Alex says as well, we expose it as another vari=
ant
of subregion(). (In general, I'd like to avoid introducing more build_asser=
t!()
if there's not much value though.)

In the nova-core case it would be a specific workaround for generic_const_e=
xprs
not being stable, so a separate subregion() variant that is specifically
targeted at this seems fine.

>> This was definitely one option that I have considered, however as `NEW_S=
IZE`
>> still needs to be generic so we're not entirely turbofish-free. But if m=
aking
>> `offset` become an effective const parameter helps nova impl, it might m=
ake
>> sense to use `build_assert!` for this.

As mentioned I'd like to avoid additional build_assert!() if not needed, th=
e
turbofish doesn't hurt too much here.

> Maybe we can have another variant of `subregion` that operates that way,
> but your call. I don't see any obvious flaw with the current
> implementation, it's just that the `FalconEngine` methods should not be
> useful outside of the constructor eventually, so it seems a bit
> superfluous to have them visible to the whole crate.

I may have a slight preference for a separate subregion() variant for the
purpose of working around generic_const_exprs, as it probably is a bit clos=
er to
the final solution, but trait methods are fine with me too.
