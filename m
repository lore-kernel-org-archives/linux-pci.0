Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFC3D6CB6;
	Tue, 28 Apr 2026 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366974; cv=none; b=fnpqO0U7mo3vSk4YcZ56tsy9yn7oGtuxk9sY4IGpaba1j9sqSccYKfAcUksbsr8NZjUXmUttl+Riys81NvmKZcJecPFZKPphqA4ldpCjTkU7JE1t1L+eNOo1Z8ou63jxhbn57f3hbBMAjAwPBuJr3QJet7l/0sxfeBUmNOgYQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366974; c=relaxed/simple;
	bh=8yzRRXLfiwZ2u7ZWEAZNz76TJ2spxwIMhj+GhPigBKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tFIlW0zKuLtHkCKuJ8rAgHNzhfL9l9tljgYpKwh1YmciKLdaSer+vhcwND5Twuiby/P+43EFCkFjQd6G2dDny/dnq26+NXwHSZO1Zs7dCSgYMcUQGMRi4Rr5edGce0Vmodfy9ag+PQSz6g0c0kFMuIPuFZVKvvnbIVKQR4SI3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAK5XUKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAK5XUKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850B2C2BCB8;
	Tue, 28 Apr 2026 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777366974;
	bh=8yzRRXLfiwZ2u7ZWEAZNz76TJ2spxwIMhj+GhPigBKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NAK5XUKFRmLvqRelgIUloT12JrGj0EmUjRNIskUaTVK2a5V/ox1zt+THQitdNIg9c
	 RqGpzHBeqlKpoaJq4I4DoXIo/SECYCRRAqBZcxsYI3YegEMHORAK+l/81mLmRYoki7
	 qP4nEhF/iftVYz6t6sSWxhVv63EnzjjbXykiPMSwQxa62dPSmrJH1afsQZoLOkhm/3
	 QE83XQUuL+MeT3hqVsqg3QynmRI9RU8UhyjT0l9o/ucbSFZzLgoTR4liXiKzYHweiE
	 luji4sr8gPkUUwLuCu+dE49xwvCG4M4W9ED397hh5YoBfZJB6l/rMhQ1z4WHhlhtc4
	 +4bziSKpNX6zg==
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
Subject: Re: [PATCH v2 05/11] rust: io: restrict untyped IO access and
 `register!` to `Region`
In-Reply-To: <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 11:02:34 +0200
Message-ID: <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
> `Io` region itself is typed, then it might be weird to have
>
>     let io: Mmio<u32> = /* ... */;
>     io.read8(1);
>
> while not unsound, it is surely strange. Thus, restrict the untyped methods
> and also the register macro to `Region` type only.
>
> The way it is implemented is by adding a generic type to `IoLoc`. This also
> paves the way to add typed register blocks in the future; for example, we
> could use this mechanism to block driver A's `register!()` generated macro
> from being used on driver B's MMIO. The same mechanism could be used for
> relative IO registers. These are future opoortunities, and for this patch I
> just restricted everything to require `IoLoc<Region<SIZE>, _>`.

Does this not prevent `usize` from being used to index anything but
`Mmio<Region<_>>`?

It is my understanding that the following would work before this patch:

   fn do_read(io: &Mmio<u32>) -> Result {
       let v: u32 = io.try_read(8usize)?;
       Ok(())
   }

But I think this will no longer work with this patch. Is that the intention?


Best regards,
Andreas Hindborg


