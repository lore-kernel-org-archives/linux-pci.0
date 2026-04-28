Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360EB3F9F3B;
	Tue, 28 Apr 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378119; cv=none; b=TmiEBp3V865+6NpEvl9F3H8ix5OBDqGxWd1zBzKSMQOLYoLa45hDed0mHyrc8dPADCaeoupRizhSFK7BRRyHa74qVGriQYNZdaC4kM2Nra6+7JSlgaggwyt6wOw+Fe6GfTknYqOO0nMKJzk9a1i8XtMhnYPJ91gdM0opK0yKdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378119; c=relaxed/simple;
	bh=bx1ifRArObM42P8yCs3Ae3LAphgQ1Y9Mfvr1LOcdNP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=giBZu4BQT04k70tPBTuN3cq3v2NnPxuITLj29ZKQv2Qltyx9EkPGJLh523LIjVhAFXjz2uiR+OhH9HYLF1ePSkogCsDJQcSOx5XgsBY9uoe+eJAJuH3g+HJ3L0g1/pj5W0DYEs5dLZFZcpRctO5ubshQSch7nwLjgDbBkjrkr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKwT5p8s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKwT5p8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B8AC2BCAF;
	Tue, 28 Apr 2026 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777378118;
	bh=bx1ifRArObM42P8yCs3Ae3LAphgQ1Y9Mfvr1LOcdNP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DKwT5p8sXqLksai0T4gDZsYJaBgGe5jxxcx4RdviKe4CnegOWRIq6oeEFJ96xctcA
	 HNpcFq0+xxHcc9Gtt0BkKVn3a/ff/5P31tYFcbr7fSLFi8sB0M+tkoJo6XPykqee8J
	 Ssn5NHe6xcqGqLS10l5SAK4FOig28JEOzReRi2lA28uPK/RYRuhBxNhlq//T2uZsVp
	 t7STRp7Nk4KMLQgBxzDqOSAJRLpW3PYptqwXyAbuw8eK3wuRVGXj+wQAxD4/fa0wys
	 OmUUfrBT5XX4rAsNkOWeYSHB125rLT/HpcKoPCAV1GOKs/IvPjCvhQVfDLbFBQJBbQ
	 yOKz9vYE7a1+Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Gary Guo <gary@garyguo.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel
 Almeida <daniel.almeida@collabora.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy
 <robin.murphy@arm.com>, Alexandre Courbot <acourbot@nvidia.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 05/11] rust: io: restrict untyped IO access and
 `register!` to `Region`
In-Reply-To: <DI4QT2U1098S.3K9K7INQ86M0Q@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
 <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
 <vYp32vOGPut322JQ-5jSBZQNd6eXvnOvg8b6YDhYcYzBqTBVUvSajCJng33oXSQ9wiMvb62VLERzLYSa4g2pJQ==@protonmail.internalid>
 <DI4QT2U1098S.3K9K7INQ86M0Q@garyguo.net>
Date: Tue, 28 Apr 2026 14:08:05 +0200
Message-ID: <87tssvp9sq.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Tue Apr 28, 2026 at 10:02 AM BST, Andreas Hindborg wrote:
>> Gary Guo <gary@garyguo.net> writes:
>>
>>> Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
>>> `Io` region itself is typed, then it might be weird to have
>>>
>>>     let io: Mmio<u32> = /* ... */;
>>>     io.read8(1);
>>>
>>> while not unsound, it is surely strange. Thus, restrict the untyped methods
>>> and also the register macro to `Region` type only.
>>>
>>> The way it is implemented is by adding a generic type to `IoLoc`. This also
>>> paves the way to add typed register blocks in the future; for example, we
>>> could use this mechanism to block driver A's `register!()` generated macro
>>> from being used on driver B's MMIO. The same mechanism could be used for
>>> relative IO registers. These are future opoortunities, and for this patch I
>>> just restricted everything to require `IoLoc<Region<SIZE>, _>`.
>>
>> Does this not prevent `usize` from being used to index anything but
>> `Mmio<Region<_>>`?
>>
>> It is my understanding that the following would work before this patch:
>>
>>    fn do_read(io: &Mmio<u32>) -> Result {
>>        let v: u32 = io.try_read(8usize)?;
>>        Ok(())
>>    }
>>
>> But I think this will no longer work with this patch. Is that the intention?
>
> Your example would always fail, as you're reading 4 bytes from offset 4 from a
> region that is only 4 bytes in size. I suppose you're trying to say
>
>     fn do_read(io: &Mmio<[u32]>) -> Result {
>         let v: u32 = io.try_read(8usize)?;
>         Ok(())
>     }

Yep, that was my intention, with the assumption that final offset
becomes 8*4. I think that is also what would happen here as we would
invoke `try_read::<u32, usize>(&Mmio<[u32]>, usize) -> Result<u32>` with

  usize: IoLoc<u32>
  Mmio<[u32]>: IoCapable<u32>


> ? In any case, it's intended to be unsupported. For types regions you can use
> projection. So the same code can be written as
>
>     fn do_read(io: &Mmio<[u32]>) -> Result {
>         let v: u32 = io_read!(io, [try: 2]);
>         Ok(())
>     }
>
> i.e. reading from index 2 instead of byte offset 8. If one cares about byte
> offset they would probably want to use the register macro instead or having the
> MMIO region untyped.

Right, makes sense. Again, my thoughts were not around the byte-offset,
but the `location` parameter being in count of elements of `T`.

But why remove the ability to call `try_read::<u16, usize>(&Mmio<[u32]>,
usize) -> Result<u16>`?

Best regards,
Andreas Hindborg


