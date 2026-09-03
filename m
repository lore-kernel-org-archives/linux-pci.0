Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD04E8DFA;
	Thu,  3 Sep 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463650; cv=none; b=eXJdip4ee1YjQyFw8QtrSgCfuncgAnwidYNIYugRnoNGtV2O4yDO25yq7zBIzhyk66ZLH4YsBHi8Fw0gJc09CnjjaO9W0xxFqOQAntdBEwiIPSwytGuASAfku8HSgTZRjRB1SmxLBtvrDVecgANPThyWVM+R06aileF/4wNJE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463650; c=relaxed/simple;
	bh=8Vi6ot/w2XeAIsbxCtE6AxvbTPQX/KxDsM0GTN26wSQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=KUhMqvN2gF27+7JAIlWqU65mNrqjrfNxkpgPLf1GsXGUcSSbFbS77WzaK631KnJS5N7BChaQyIu2Z1DykPG3bQz0ylodYbzJgsvqXTpcmguZOokWOkz434W01T9g3AePFO4LOpfBho0yYt5bDyi2gIwMh8kSKULaIMaq4CWyGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdUnkBMR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdUnkBMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845751F000E9;
	Thu,  3 Sep 2026 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463636;
	bh=eAr15of8ecyt1Pca09E0dTTN32kcaFEN8srD+2g3ffQ=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=UdUnkBMRt3wIbnqYiG7BF9CW9SRvXXG8ZgYTaapubuENY9Ij1D9RIPBtSjPD36984
	 6TrttkR/pCt3t6+o81tlkbrVEkpoE5gip/29LcjRaqAzcq9u4BCqNmRjWNGozAM5kT
	 0Lm2mLzg1AqEzzsWT7OiuvSdDxvd9gPqP7WCuITd8fN4VEnJxdvYVR1cgTbbStb/XQ
	 vxjZzt6JzPDFeTLICnx6ncHmAJXc++65olinQl0TFJtnwBv6LMYiplorKFx6CqzYEY
	 zSHENLGiV5uKxmuJoqM9SwtR9rK96ZEnjQwk1BLMVNhyrakvai+extKUToIDd6b3n2
	 MthvYZIk7Xq6g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:27:11 +0200
Message-Id: <DL5XG1N71CVV.TOAF6XQY0SW5@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 00/16] rust: io: support register projections and
 remove relative registers
Cc: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260903192248.2248560-1-dakr@kernel.org>
In-Reply-To: <20260903192248.2248560-1-dakr@kernel.org>

On Thu Sep 3, 2026 at 9:22 PM CEST, Danilo Krummrich wrote:
> On Tue, 01 Sep 2026 17:50:24 +0100, Gary Guo wrote:
>> [PATCH v4 00/16] rust: io: support register projections and remove relat=
ive registers
>
> Applied, thanks!
>
>   Branch: topic/rust-io
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/drive=
r-core.git

I've pushed this to a topic branch, so 0-day can already do its thing.

> [1/16] rust: io: register: reimplement as proc macro
>       commit: 63b2578517df
>
>       [ Fix typo in module-level doc comment and fix ArrayDef syntax
>         description to match the actual macro syntax. - Danilo ]
>
> [2/16] rust: mem: add `transmute` with deferred size check
>       commit: 82591c20bcb3
>
>       [ Fix doc heading to use plural "Examples" and add missing closing =
code
>         block delimiter. - Danilo ]
>
> [3/16] rust: mem: add `AsRepr` and `AsReprMut`
>       commit: 968f30ade612
>
>       [ Fix grammar in from_repr_unchecked() documentation and rephrase
>         confusing safety comment. - Danilo ]

Miguel, Boqun: Please let me know if you are fine with the two
rust/kernel/mem.rs patches.

Thanks,
Danilo

>
> [4/16] rust: io: perform conversions using `AsRepr`
>       commit: 1e707b76716a
> [5/16] rust: io: support register projections
>       commit: 34b6dc471749
> [6/16] rust: io: register: allow explicit base type specification
>       commit: 70a122d5a342
>
>       [ Remove unnecessary #[allow(unused)] from the 'base' field. - Dani=
lo ]
>
> [7/16] gpu: nova-core: specify base type for registers
>       commit: a07fa2c979c1
> [8/16] drm/tyr: specify base type for registers
>       commit: 573228e75c33
> [9/16] samples: rust: pci: specify base type for registers
>       commit: 54b04b9fc0ea
> [10/16] rust: io: register: make register have a typed base
>       commit: 35c21468c294
> [11/16] rust: io: register: support fixed offset register without bitfiel=
d
>       commit: ddeaaa3a0fbb
> [12/16] gpu: nova-core: use projection for PFALCON and PFALCON2 registers
>       commit: 6d5f14077811
> [13/16] gpu: nova-core: convert hshub0 from relative register to projecti=
on
>       commit: 4a7a27bd1947
>
>       [ Split nested import into kernel vertical style. - Danilo ]
>
> [14/16] rust: io: register: remove relative registers
>       commit: b6af037d9499
> [15/16] rust: io: register: remove `Register` trait and cleanup macro
>       commit: dfec6f41d053
> [16/16] rust: io: register: unify handling of register with/without bitfi=
elds
>       commit: 35423e8fd718
>
> The patches are in the topic/rust-io topic branch and will be merged into=
 the
> corresponding target branch soon.

