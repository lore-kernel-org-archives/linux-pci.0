Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3292FFDD5;
	Mon, 16 Feb 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249675; cv=none; b=tVW/bbwuNRmXnbzl1EIpI5NocokHrAyB64GcHyLtxeGMry+259GXGKeQfmGDhA91TJTs2UwZnLJZDsAwDLBzx/q1mprn39eTMF+el4xlV5JPd+lMDZCTrWS1ZpqHnO/ORwSWlL3/iz6aU4uJVEdMJAl8GOzqyIilL3n3aE9QT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249675; c=relaxed/simple;
	bh=PSqCtdyKnUOY3CJ6B/b/HmLs6HPDqdmQfwI4gShBKX0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=D49l0tK40Ai7n18pjnqQL4ISysAv/g490ztpZHf5RURH9RFuhoqu87BexIqHFZke86Tm73Lbvb51j+eJyNBrzs2XRPsvHQiOikq97SIpRnTU8cseUn/gH/xEF/6gznInxuGA1eABCorgR41worTTmfXhecEHS9G6vnPG0S/XZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEn35pZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEn35pZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD57C116C6;
	Mon, 16 Feb 2026 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771249674;
	bh=PSqCtdyKnUOY3CJ6B/b/HmLs6HPDqdmQfwI4gShBKX0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hEn35pZNTrmNhC3M3W93lkSHVsJnk8EkgMtY33jVPXbXzjXyzkAz1NQh6+yXgM/sE
	 nyk1CNKBMkIvCO4mfVtYnE4oaE2AWmwdM28BTIBGLk5KND2g2aOUUvEsqrvNfbjZqf
	 dQ6MJlkpiVdYu+fV77ysuGTyJD2rqpPW5NrxbdB7KQXckv6kG+D8X0clyr3CnxDkYv
	 J4yGrMtwd56JzVlR09Tl6WAeLZnNCKzEEz09V2YT8WYmLMt+VdofC2+yUblyyh3VoH
	 9Dm8lEecg+nAuaavwkIKnEvM2YjPrZUssdxcI5hToegQa1FmeR7nETlcKw0566Qw6u
	 nSAmBjCsvAKHA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 14:47:49 +0100
Message-Id: <DGGFLT2LH98S.29KNXX9XG02KQ@kernel.org>
Subject: Re: [PATCH] rust: io: macro_export io_define_read!() and
 io_define_write!()
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260216131534.65008-1-dakr@kernel.org>
 <DGGFFDUCVJX4.57KHV1JH0LWK@nvidia.com>
In-Reply-To: <DGGFFDUCVJX4.57KHV1JH0LWK@nvidia.com>

On Mon Feb 16, 2026 at 2:39 PM CET, Alexandre Courbot wrote:
> On Mon Feb 16, 2026 at 10:14 PM JST, Danilo Krummrich wrote:
>> Currently, the define_read!() and define_write!() I/O macros are crate
>> public. The only user outside of the I/O module is PCI (for the
>> configurations space I/O backend). Consequently, when CONFIG_PCI=3Dn thi=
s
>> causes a compile time warning [1].
>>
>> In order to fix this, rename the macros to io_define_read!() and
>> io_define_write!() and use #[macro_export] to export them.
>>
>> This is better than making the crate public visibility conditional, as
>> eventually subsystems will have their own crate.
>>
>> Also, I/O backends are valid to be implemented by drivers as well. For
>> instance, there are devices (such as GPUs) that run firmware which
>> allows to program other devices only accessible through the primary
>> device through indirect I/O.
>>
>> Since the macros are now public, also add the corresponding
>> documentation.
>
> The fix is relevant for stable kernels,

Not for stable, but for v7.0.

> but if we merge [1] these macros will disappear anyway, so is the extra
> documentation worth the trouble?

We are not removing it within the same release, v7.0 will remain as is, so
proper documentation doesn't hurt.

> [1] https://lore.kernel.org/all/20260206-io-v2-0-71dea20a06e6@nvidia.com/
