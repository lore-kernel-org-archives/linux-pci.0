Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8481724;
	Mon, 27 Apr 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302011; cv=none; b=gEW9Y/gVQwik5sBDpUqT2J8CPJcj9TpEEKm2MYrOuz4kh8hOdCsDpmII9Tecd5dRffkqWD+JcbnzmiU9bxXo2T9Md14J70Us05484BHFSBE2MBNhe0aavOLwQEhHU0EFInfJGCdNiOJnbqKzNqWGFrLKV8XeZux9pZNngZ4UUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302011; c=relaxed/simple;
	bh=SvqjExqH1mkKWJnHyinuMQQfSa4Iy3mz1aqPW9CT0zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gCM3VztTs9tyA8ZB8b8ezMnOErjBLjP+crhcg3tU3ffcOkloDTr8SBW3b95JLoet3VxeArS+RXIKIJaM8NUSFWmO5gumeBeLptMf4eYJx6V3jbMp4GzOslpoWI0OmmLngfux4iDUXIKvoQdVoO+fYoQwC6c5W2GNz/9/oShAoTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQoslP+5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQoslP+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A590C19425;
	Mon, 27 Apr 2026 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302010;
	bh=SvqjExqH1mkKWJnHyinuMQQfSa4Iy3mz1aqPW9CT0zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qQoslP+5qfAc6xUuT5b3W86ANE5BCglrib8L2V58nIhUGL546B8mlwFODMA/aXEeN
	 e+ZpUWgoohBDO6EEUuDIA0sCeG7jmEhv5K2RA5nkEvUN2m43i8i2CThEXw4a7bzd52
	 jApJAPJSoqHHUTKGwA/QAIMJ1bh/eohogIkjjPMcvAGswqU4hed9+CNC9Lz9BQC0bh
	 71+tBearoiurULXIXnfJyydH13fRKPgybgqH71GCrPZ8kjyGCoiC7Mi0h5XEznOzE5
	 aBWxGL62oXXc62F/xCkvKagL3vo7BEuCMoSDAhTdxcx+t5FU5330gAhNtB27c59TR0
	 ZmhIvz4tOnRsQ==
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
Subject: Re: [PATCH v2 02/11] rust: io: generalize `Mmio` to arbitrary type
In-Reply-To: <20260421-io_projection-v2-2-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-2-4c251c692ef4@garyguo.net>
Date: Mon, 27 Apr 2026 16:10:07 +0200
Message-ID: <87fr4gqytc.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> Currently, `io::Mmio` always represent an untyped region of a compile-time
> known minimum size, which is roughly equivalent to `void __iomem*` (but
> with bound checks). However, it is useful to also be to represent I/O
> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.
>
> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, or a
> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. This
> change brings the MMIO closer to the DMA coherent allocation types that we
> have, which is already typed.
>
> To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
> `KnownSize` trait to represent compile-time known minimum size of a
> specific type.
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



