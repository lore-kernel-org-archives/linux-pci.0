Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088E2DEA7B;
	Wed, 12 Aug 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564665; cv=none; b=fVLGj/tLC+xaGOiqd6UTwNzOhtgFJE+AEZsfsNRcn7X8ZFeNVDKQoXQMiXs4j4FmtBbIBBTn0NXPa6pVXISwlzyGPTGsbkq1uNk12meZtfAtqUbnjrK/czAERfuffw0R7m9AoGJeCz8uXfKJqJtaGmpYEzVsP/yjc0WNiBOku7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564665; c=relaxed/simple;
	bh=teSbcK8YfazPkNdIbehrOFLgujsO4hQooFuTPtYQV4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uqXzmOGT/BnlvauFsmyxuFVplfpNBrzJaSpFvKhNWKfE9qqw2XOcX9k4siIcmRdAOKxhdZ9fkdb9rd0rrw+Q3I7Q538hKgt2t6NHvgbj+l9NOGIFrJmPRyym40SlTBcJbfYlQxbOqf8qRl2gI/SVvyU6RTeyKebIq9mIkA7vN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/GK8mPF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/GK8mPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60061F000E9;
	Wed, 12 Aug 2026 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564664;
	bh=A+Wk3BV8+0nSVtbUop929wSiFkTbjDQfpbfypmbDngc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=M/GK8mPFPE/jDMDxhvQOmPlOvr+iX6jzAywBy61SEJMc/iaVgSccLC4+VXJyXFu9k
	 rG0GUIo8CYlFCN7GvFVrwVVICS2qfCSiga7yriYsKyKK8kkFDwJbExNtSghCvsgsOs
	 9lmXkNASLO+jBpwC/A4k090hkyv+zQS1hIfNRZy6EQY5p6XfW7BjOTXQMJpDGdCTSc
	 NziONSGA0EDr+j0tXRShP2M6HwQb6V3t/0zkgQZvi0ooYauL8XlcibIcWGaorgrUg/
	 LNSagEPlCPftQFRy/5aacp6O9NbYE6o8+e3tuwP0BLdsyHFOMpHugIS2HdFoXwdOTn
	 Jfx8KnKYUGGMQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 21:57:38 +0200
Message-Id: <DKN8BDODRXVT.RDQQIJX5316G@kernel.org>
Subject: Re: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a
 lifetime-managed owning type
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <ttabi@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <shashanks@nvidia.com>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-2-dakr@kernel.org>
 <DKN3U000UGRL.2MOXT25O11UE0@garyguo.net>
 <DKN5C359PZP3.2BPH5HLM9H0HY@kernel.org>
 <DKN6203R3WD1.1NLN19VVBZJO9@garyguo.net>
 <DKN6TRRJ2OY3.2U6M6TQDNSM27@kernel.org>
 <DKN74N3E3NUK.1I4LFP3LLH5AM@garyguo.net>
In-Reply-To: <DKN74N3E3NUK.1I4LFP3LLH5AM@garyguo.net>

On Wed Aug 12, 2026 at 9:01 PM CEST, Gary Guo wrote:
> On Wed Aug 12, 2026 at 7:47 PM BST, Danilo Krummrich wrote:
>> On Wed Aug 12, 2026 at 8:11 PM CEST, Gary Guo wrote:
>>> Well, I'd expect some drivers want to do `.vector(v).expect()` rather t=
han just
>>> propagating the error if `v` is a constant that is less than `min_vecs`=
..
>>
>> This is nothing we want drivers to do; this API is only ever called from=
 a
>> fallible context anyway and propagating costs nothing, but on the other =
hand, if
>> the driver gets it wrong, we'd BUG() the whole kernel for no value.
>
> Well, if you ask for an interrupt and got one, you'd better got one! If t=
he case
> is actually "we'd BUG() the kernel", then it probably should because some=
thing
> is catastrophically wrong. I'd even consider `unwrap_unchecked` to be val=
id
> there and in my view `BUG()` is less damaging then UB.

If the driver calls vector().expect() on an index that is actually out of
bounds, because someone made a mistake, e.g. because min_vecs changed and p=
eople
forgot to update the code, then nothing went "catastrophically wrong" to a =
point
that we need to BUG() the whole kernel.

> I don't like the fact that we propagate error code because we can. Propag=
ating
> error comes with a cost: it's one extra control flow that developer needs=
 to
> consider; more code is generated because the destructors that's currently
> available still needs to be executed; and the code will have 0% coverage =
because
> it'd never occur as
>
>     /// `dev` has an allocation of `count` interrupt vectors
>
> is the type invariant of `IrqVectorRegistration`.

I do not disagree; those points are all valid, but I think it is a case by =
case
question.

For drivers and in an already fallible cold path, I don't see a lot of valu=
e in
compromising on robustness against human mistakes for those reasons.

Quite some drivers are poorly maintained and patches don't receive a lot of
review before they are thrown in; Rust has a chance to significantly compen=
sate
the downsides of a monolithic kernel by increasing the robustness of this
weakest part.

If we encourage drivers to use accessors that potentially end up in BUG() f=
or
cases where it doesn't provide significant value, we may also diminish the
potential for additional robustness.
