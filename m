Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438D3F9F35;
	Tue, 28 Apr 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382569; cv=none; b=HlQ7i/HMDgIYj0RF0cvmB/FFcfoP9FV1DTRmKx3GQioo1kCXzzdkR28WaJkHJsuYafb3+nWVKY7pIZLrG/z5biTe2UkYBJjdvMyZIRtw9Pcq55/NALN+n/t7DamIU1w9eyrX76VgzLJ852x85PwKa7ZFZn0/FOlOb69ChgRA1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382569; c=relaxed/simple;
	bh=9rjTYTuP7L8sLjc7X69kwiggXB2C5UsAdNVY1jH4Pk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VxdlAW68fEyjc1ZeDBYYmBIUEpX+vnl473TmkyRNMVykJaKxSKXyTly+/VJTdqrt6uj2JAt1j1RPsXdYRkQEwMeOO0R2a/+UHzh+GQ//ef77YI9AhGY+okcWZcIwozU6pHqF5dfPPtwxluc3QU7QY6O689WUZ03m3DGT4oge8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kszh/63M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kszh/63M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E17AC4AF09;
	Tue, 28 Apr 2026 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382568;
	bh=9rjTYTuP7L8sLjc7X69kwiggXB2C5UsAdNVY1jH4Pk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kszh/63MBzQJEBmRrcmOOTYxhbiH13kOw4r74yEHr2fPGmknb/wxFKK+mPYoY0GER
	 gajWe17zROcN87QMYobkstYdeaU7QjKWxTkg5CN5v12MLTMG+8PSmrRItUxUKAecXe
	 J53yiINuqNVAZOGRNUKY4SydOjZvhlyTyRD1Bn50JgBrhGHcOYNyaFV0i9p2UorAJ/
	 jfwlXFH0ebYuCb5q12m19COHXFOQidwX46t2g0iSXekZgAgvt6cRHqN8jcTnjbaTk2
	 VO5oEvlFOpsHszFelT3A5Nr7qKMNK+PyOdeKk81+kMprCMYXrnLImb5xCLhVqIWSTH
	 Fida1mVcj3kQg==
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
Subject: Re: [PATCH v2 07/11] rust: dma: add methods to unsafely create
 reference from subview
In-Reply-To: <20260421-io_projection-v2-7-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-7-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 14:10:12 +0200
Message-ID: <87qznzp9p7.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> Implement `Io` for `Coherent`, so now `dma::Coherent` can be used with I/O
> projections.
>
> This allows the `as_ref()` and `as_mut()` API to be used in smaller region
> than the whole DMA allocation itself. For example, if a ring buffer is
> shared between GPU and CPU, users may now use the `io_project!` API to
> obtain a view of the buffer that is uniquely owned by the CPU and get a
> reference.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



