Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246A1FD4;
	Sun,  6 Sep 2026 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700747; cv=none; b=utIfoIP9DBLZKnPinXGOvkk8FeNhumqUEES7a9ubDh0QF1ZNVdMkWDQwBxgEUBXeyl36x2LEC2IMBkoF4LGB65f4EQqN6j+HuQhydYOrFVnCpBPYsgbjCjqzRi4mXJxYc4trmXTIGOY4hS2Ob9DCyzUhYZ5sWSchr6TeTvzNSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700747; c=relaxed/simple;
	bh=if3VLss9cAnYFCu5pdVfMSN3YSv1tFcrsMFfsSRe6Lo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oOK300e1Sh9mGktTFXfM345nmGZehWj3HLPzWBpYiXU7lCOCS0BVmiMBFrKPYImzKuH/6WE3+JOHzQLQb0xjPATQGyC1e4HlCj66esmkvVRkeozjfKB68mRSt6rc7qDb5RGZQSgmVETyBRZY/sq+Le+5DEOBuTE9woHsz0w8Wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlqrizIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlqrizIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA001F00A3A;
	Sun,  6 Sep 2026 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788700745;
	bh=u8O4noF59z7AVqt68jjhQ9ZPuiEADEf7VS3i0hVqNxQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=jlqrizIowN2Z2NMCLCQPF7TwlbaZuIPiPCOp2PezP3+MG38jZnNIA5MRlx25r6T1n
	 LrnGo6BCReMN6wealrHO0R9aWD4sw8vo9ewJ+qE64l2obTaKGgjFJtXr46VR1uoxrl
	 zCEuQ48tt1YCKJH01TDevId7TW7969UasCocYyML1ZBk5lWizrO3Fnaw1Q/CuiL2w4
	 HmsLmAoSobjehDwrWIRnGfVnbkqfp7ASsiHq+0niTBNw5lU9wRWUZiNMA8gAvMzkMz
	 i5w+JuVyNdbj++WhzhdjR7B7SI7t68wATHQl4P1fWAIW9qny9M8xoW0sEvvaNMF0th
	 S1hcc7yCEVAWw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 15:19:00 +0200
Message-Id: <DL89HS18UM45.1U3C3BPL9QM2Y@kernel.org>
Subject: Re: [PATCH v4 00/16] rust: io: support register projections and
 remove relative registers
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
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
>
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

Merged into driver-core-next and drm-rust-next, thanks!
