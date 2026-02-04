Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC643B8D6B
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201436; cv=none; b=FDTUyXMsYTx9bJEGxFkWidsB/c02rwFxbu7I1ShtMjdOFS8K1r9SyNylHTTBWVa4Go8qdc1a+XkPqT8swaLfGyxISA4E6MKUergBxH8V8qoOdnHvRhE6UBVktogQyz8myelTcNwdEtRc7RXorcoY+r+uRdjh6sQqsxdzkMFSCSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201436; c=relaxed/simple;
	bh=x23D0hsv+uFoQs4cpH6jEoI5szd/yJs94L/Z2zjXtI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qsu4uVkR6lsSRMWqSmS3IZKo+Bap9xmym+E2nj/Dn0cbhHYnyRCagnd1M42rLlk5UH0FDd3LGSpK1yRsL0Qt3iKLx3H8M8+OTiOboMDX6+9Z2ccmq9XNFYTdvMEfh0PPuZrOiIjjPMEVpnw87qKZEsbEtqGORAvJ0CAjIzB37kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krTc9oMJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krTc9oMJ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47edfdc6c1aso54115235e9.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Feb 2026 02:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770201434; x=1770806234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=80je5TC4fR0wUqvJug9PMXJE5OH/OTksMBklHWdOTcQ=;
        b=krTc9oMJCQH87liNS9URz/0fG/qIHLhcD1DraG4MDBGtdOdXYGL050vFYzT6xvIZFO
         m6TsUVE/m3asNekGU5z5QnvhRwsj1YCcsKGr/bocmWoIu2bbqneIyqHQgD0OSFDIBY53
         /5S/l0d6e6IE/EnAgyAbE6EavKPLbGrpldQiyxgJ15pFenLhMps4XVGIEqhco2NRgEo8
         RjgAdMWjo6VXfSFnwcXqr0ef9WrmYnj5HYCWhPzfOT506pTTCL3GJuDeknSMxrNytrzu
         S15rlrbguYz5GMZ/lRaoIjyzUn7AZysCU1zaeGJ3dpiUuvAYV0kA+Ih+XgH0JuUUzkwL
         g6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201434; x=1770806234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80je5TC4fR0wUqvJug9PMXJE5OH/OTksMBklHWdOTcQ=;
        b=ILuTgNfBuzH8LZeFfZ48PJN3gM4ec5YZ0/A15BSnb1dyRQA9KyBZru04jgDZdIrW7i
         ofdUv7bx4VA1NF7w70wt1YD1/LNzvxnQEbOeuEwtCGRHc3Gixnhrbxuyymba+iZwzYQ3
         p16haqLCQMVDRdLZrDqYmJ407QFjz9MYDdbyP+4HKY2tBRbjZJ5qQemxvpo/EifH3T90
         mvQR4O4LxnemkLfA5Wn0IQ/vjWD896IaRpxeTuGHzJpJldXxmzXJ5DjdXi4080HHAiN4
         Y3jbcmzKHwKw1TEVyvQ3sabEks97lNiIHVIbrsE8fSKzNfrZXiVKobIMTPu4jLo/hAH9
         rM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4QP6Z3U26O1GyS8tn/8EIiTYeKXBLL4BtzxcBKyX1a8wKA+n71pe3TlWPuJrtA8AIyMBhoZJCUf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWRUQUhQPQfEAgOSPFwZQPxDTgQpYpcOOnKls9gv6tjxD+aGH
	uDUvuT1vHCIE0zzhGXWOCtxNxiFnloPX+NGNSpMhqfe46+KH306N8n7YQDsbUOAQevd/vW8ZjM0
	AiZUPwtpUaoK5P/ByKA==
X-Received: from wmxa16-n2.prod.google.com ([2002:a05:600d:6450:20b0:47e:e20e:e9a5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6087:b0:483:a21:7744 with SMTP id 5b1f17b1804b1-4830e977f1cmr30901995e9.26.1770201434095;
 Wed, 04 Feb 2026 02:37:14 -0800 (PST)
Date: Wed, 4 Feb 2026 10:37:13 +0000
In-Reply-To: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
Message-ID: <aYMhWUTL_7c1gmrO@google.com>
Subject: Re: [PATCH 0/6] rust: io: turn IoCapable into a functional trait
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
	Eliot Courtney <ecourtney@nvidia.com>
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 02, 2026 at 05:12:59PM +0900, Alexandre Courbot wrote:
> `IoCapable<T>` is currently used as a marker trait to signal that the
> methods of the `Io` trait corresponding to `T` have been overridden by
> the implementor (the default implementations triggering a build-time
> error).
> 
> This goes against the DRY principle and separates the signaling of the
> capability from its implementation, making it possible to forget a step
> while implementing a new `Io`.
> 
> Another undesirable side-effect is that it makes the implementation of
> I/O backends boilerplate-y and convoluted: currently this is done using
> two levels of imbricated macros that generate unsafe code.
> 
> This patchset fixes these issues by turning `IoCapable` into a
> functional trait including the raw implementation of the I/O
> accessors for `T` using unsafe methods that work with an arbitrary
> address, and making the default methods of `Io` call into these
> implementations after checking the bounds.
> 
> This makes overriding these accessors on all I/O backends unneeded,
> resulting in a net -90 LoCs while avoiding a violation of the DRY
> principle and reducing (and simplifying) the use of macros generating
> unsafe code.
> 
> Patch 1 adds the `io_read` and `io_write` unsafe methods to `IoCapable`,
> provides the required implementations for `Mmio` and `pci::ConfigSpace`,
> and make the default I/O accessors of `Io` call into them instead of
> failing.
> 
> Patches 2 to 4 get rid of the `_relaxed` variants we had in `Mmio`,
> since these are not usable in code generic against `Io` and makes use of
> the macros we want to remove. They are replaced by a `RelaxedMmio`
> wrapper type that implements the required `IoCapable`s and is thus
> usable in generic code.
> 
> Patches 5 and 6 remove the overloaded implementations of the `Io`
> methods for `pci::ConfigSpace` and `Mmio`, respectively, while also
> deleting the macros that have become unused.
> 
> There is more work coming on top of this patchset (notably the
> `register!` macro with proper I/O), but I wanted to send this work first
> as it stands on its own IMHO and is more digestible from a review
> perspective.
> 
> The base for this patchset is `driver-core-testing`.
> 
> Cc: Zhi Wang <zhiw@nvidia.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Eliot Courtney <ecourtney@nvidia.com>
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Overall looks great!

With the `mmio.relaxed().write(_)` syntax suggested in the thread on
patch 3, this is acked by me.

Acked-by: Alice Ryhl <aliceryhl@google.com>
