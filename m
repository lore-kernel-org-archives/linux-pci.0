Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184117BEBF;
	Sun, 14 Jun 2026 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464055; cv=none; b=kV2oQzrUjF0gFubzYlISJPvIbMJz2FluohV6WOpzjete6Dc9hArakGkMbp+gKJqIQVcOUl2Z9bZRW6sRFX+lh84xfnqVVtkiSWFo4KmDyN6brRYNsaRq9sVaYpjAZmpU+h+Sl+El7c2QA992RvU6+1OiREzCtYFnod/ZdqjQwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464055; c=relaxed/simple;
	bh=lCV8HzuK8/KlZJ6SPMlQucwxLMsBzs0aYL5lSpDoBxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUzMonCKAtOivcEbKpacVQONq8aTGG7GaubRjxdnwjqC0APKL5FYvca3qXSYkCrfWRzYabgeSfafUKLwLXobzOee2WkAOFw8x/s92iXTbmCDvQGh71UbUEOwkscYI6WC/j3lC3vlX+xbQrRkUewLcKEspVNVoSdZjyQGJtbI+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AOpfPWPw; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AOpfPWPw"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gdjS12nGyz9t8r;
	Sun, 14 Jun 2026 21:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781464049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCV8HzuK8/KlZJ6SPMlQucwxLMsBzs0aYL5lSpDoBxY=;
	b=AOpfPWPw+u11l/YLfolHzpcwEbnChWEvHi8tywE6sit0nBCdU4sRU0D/c61CQBqHG4mdHZ
	U/Qlk0hYmSL7E1oaua5SS3M+13uNP6aXTe8bIhGtL6o2a1bcF+fa9HCbJHwUOlT3ThLb1S
	9HCLluc9jR5RyiCO7mwmAYreMv/3xbfRU/mnw5NoExid9tsaqtkfuiNV5py/StvYKkkqFM
	fL6ZjEtj+3A1iOoZsItjSuvxaKCUiZsrHTiVk1lWfW5USORsctGPROYd9pfcD7o/4s8FEp
	Z+rwp2xwTqMcAsYrFFWePLa1vbwtng0pJzMm6ZzRPHZkQNxI3Xvrk3+MJenAcw==
Message-ID: <e29df53cef773ba2137596641f5173dc9e50a5c2.camel@mailbox.org>
Subject: Re: [PATCH 3/4] rust: completion: add complete()
From: Maurice Hieronymus <mhi@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
  Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng	 <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 14 Jun 2026 21:07:24 +0200
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-3-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
	 <20260614-b4-rust-pci-edu-driver-v1-3-e3f2471b595c@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 4774d6c576f1eb95129
X-MBO-RS-META: nzs834ijrh66oh6w4xqja9ggmecbrauo

On Sun, 2026-06-14 at 17:59 +0200, Maurice Hieronymus wrote:
> The initial completion abstraction only added complete_all() and
> wait_for_completion(). complete_all() marks the completion
> permanently
> done, which makes a single Completion unsuitable for signalling the
> same
> event repeatedly: once complete_all() has run, every subsequent
> wait_for_completion() returns immediately without waiting.
>=20
> Add complete(), which wakes a single waiter and increments the
> internal
> counter by one. Paired one-to-one with wait_for_completion(), it
> allows
> the same completion to be reused across multiple cycles, e.g. to wait
> for
> consecutive DMA transfers to finish.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
> =C2=A0rust/kernel/sync/completion.rs | 14 ++++++++++++++
> =C2=A01 file changed, 14 insertions(+)
>=20
> diff --git a/rust/kernel/sync/completion.rs
> b/rust/kernel/sync/completion.rs
> index c50012a940a3..b386b84222f9 100644
> --- a/rust/kernel/sync/completion.rs
> +++ b/rust/kernel/sync/completion.rs
> @@ -90,6 +90,20 @@ fn as_raw(&self) -> *mut bindings::completion {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.inner.get()
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /// Signal one task waiting on this completion.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This method wakes up a single task waiting on thi=
s
> completion and increments the
> +=C2=A0=C2=A0=C2=A0 /// internal counter by one. If no task is currently =
waiting,
> the next
> +=C2=A0=C2=A0=C2=A0 /// [`Completion::wait_for_completion`] returns immed=
iately.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Unlike [`Completion::complete_all`], the completi=
on is not
> marked permanently done, so a
> +=C2=A0=C2=A0=C2=A0 /// single [`Completion`] paired one-to-one with
> [`Completion::wait_for_completion`] can be
> +=C2=A0=C2=A0=C2=A0 /// reused to signal the same event repeatedly.
Will add #[inline] in V2.
> +=C2=A0=C2=A0=C2=A0 pub fn complete(&self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `self.as_raw()` is=
 a pointer to a valid `struct
> completion`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::complete(s=
elf.as_raw()) };
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Signal all tasks waiting on this completion.
> =C2=A0=C2=A0=C2=A0=C2=A0 ///
> =C2=A0=C2=A0=C2=A0=C2=A0 /// This method wakes up all tasks waiting on th=
is completion;
> after this operation the
