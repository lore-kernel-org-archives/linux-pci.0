Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA253F789E;
	Tue, 28 Apr 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378126; cv=none; b=cKFF0kbQm9sQwqyoChZewU2PhuaZbDlJxxMO3me6+NXCqNpA0t6xlXj/UthN0C9H9N0xStevwPhGEwJI7FtdiK78yVH8XIs6SmnZrprJOROW9ddJiFSTHuvEyV4oUL/MMA2LqujAO3qV9/oPcpbsg8kg4g6fujuT7KH/O938Vks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378126; c=relaxed/simple;
	bh=bOwF+0GUALysM7CRy5XbgigqUCNNq+JTaQXbBGbEwis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KKG02yG4Ebj2xExdZZvX/rmhQ9wSWJ8p1pOl+1UnyZh0xXSriNQApMF5876phYpL1m/WpqNWHpurFzrMAxajUuYTZ8SI7jjkRJc3bt6YxgCTfkoe936lA/BQfpMWqo73DVifiYwEBb6IPx5wxXNWI+KcSQYYH7QOhmKDvdYYTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJSopcu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJSopcu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC4EC2BCAF;
	Tue, 28 Apr 2026 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777378124;
	bh=bOwF+0GUALysM7CRy5XbgigqUCNNq+JTaQXbBGbEwis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jJSopcu7jda15HdeY0xhBlkZIwx+pxlClsFUQyJUaur9Cx6PomSExXBNiotCduBKv
	 UyLAU3q3OED38hrsZZsx97gkH2Ej6yu+ex2+y0ZY619YfQSS+39Q86Xk9K/ryo5iTx
	 JY6irGEZSXTjjfU+vItU855lkPZTbmcSBWY299jeqK8wEoAPB5+Bsjcxf8BN9g2lb4
	 zT+dBjFhOwFCxfJ0lL51UhVvBtLq9RLhzLYGAfD+JyT7RHJudnAATVT4yoUbinp36R
	 Q/mm+t8MZyd/Eq0lUyPZ2m9qOHtMli+VaE9koZJAn6KZsCzmmYptnCgBCtAY0/sL17
	 ylekKk/IrXwYg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Abdiel
 Janulgue
 <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 10/11] rust: dma: drop `dma_read!` and `dma_write!` API
In-Reply-To: <20260421-io_projection-v2-10-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-10-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 13:16:57 +0200
Message-ID: <87wlxrpc5y.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> The primitive read/write use case is covered by the `io_read!` and
> `io_write!` macro. The non-primitive use case was finicky; they should
> either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert the
> lack of concurrent access, or should be using memcpy-like APIs to express
> the non-atomic and tearable nature.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


