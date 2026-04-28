Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0E42315F;
	Tue, 28 Apr 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387325; cv=none; b=phFqTydIXmnnBF8+orX9lb60cMFXbycJVBf9QoKNZ+kp1J8ybUebuwa84md5/rpqT4gtT/NCc1LcvSVImOk9G4wIv+i0x7Kek996DVqwDYlrTSvJDWO+uuCvCLmDwgSl4LkBpl+WPlfBcS0Vfuwm4NAc7shngI3IO5BqYFDo8ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387325; c=relaxed/simple;
	bh=j9TDaxTAxDjeJyvR+byZsADBd2oV8lsBN3Q0InXYURY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KAHomc5snZkAQbDdkzDjGOwo0LY9d/9E7xgI3QcEdP8vYpwgtkeFFa6Msc9qP1HbgKedV4UygJN95PdvmxwhpRL8wkCVR6q793I2f1tXL62Zmx6s5BsQwvbLlZFvHG0T6lB0mCIqo+GEFJbkfBgRupIXXXHkuKxEJWZj1wlLKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L86izWPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L86izWPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD327C2BCB8;
	Tue, 28 Apr 2026 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777387322;
	bh=j9TDaxTAxDjeJyvR+byZsADBd2oV8lsBN3Q0InXYURY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L86izWPwCrWDdFrBS97EC2ayPfon6jIRd1JRHdDR5ndn3D/TUCpsnn+i+Sl83l4HY
	 o2IR+/XduPzcgLd/kuYM79Atz2Fr7WKOJw0Xcn4PBxVD2A+S9VQM+rVLos/E3Kd+Ll
	 0+fTEPViNfywYfzwRj34MpdW+HGTfMRRHEPdJDq59u706zq4qbeq0UUUJeYr2kJN0X
	 uGcl3sU3n7e4Ilq0n/MvPQ2BtepjIL1rjef/wekTkO7QUmgOEIpugmZalznvKa09Z1
	 pOYfsCcAhPPIOWV6S4wKtJOEd9P+nfRnrr8kmwUCgoW2SSzLpTKxxeFRqgCmuVxAcI
	 fUlfAbrfUuwjQ==
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
In-Reply-To: <DI4SY1NXU1XW.2VHPFEKIFBQVW@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
 <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
 <vYp32vOGPut322JQ-5jSBZQNd6eXvnOvg8b6YDhYcYzBqTBVUvSajCJng33oXSQ9wiMvb62VLERzLYSa4g2pJQ==@protonmail.internalid>
 <DI4QT2U1098S.3K9K7INQ86M0Q@garyguo.net>
 <87tssvp9sq.fsf@t14s.mail-host-address-is-not-set>
 <DI4SY1NXU1XW.2VHPFEKIFBQVW@garyguo.net>
Date: Tue, 28 Apr 2026 16:41:51 +0200
Message-ID: <87ik9bp2og.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Gary Guo" <gary@garyguo.net> writes:

> On Tue Apr 28, 2026 at 1:08 PM BST, Andreas Hindborg wrote:
>> "Gary Guo" <gary@garyguo.net> writes:
>>
>>> On Tue Apr 28, 2026 at 10:02 AM BST, Andreas Hindborg wrote:
>>>> Gary Guo <gary@garyguo.net> writes:
>>>>
>>>>> Currently the `Io` trait exposes a bunch of untyped IO accesses, but =
if the
>>>>> `Io` region itself is typed, then it might be weird to have
>>>>>
>>>>>     let io: Mmio<u32> =3D /* ... */;
>>>>>     io.read8(1);
>>>>>
>>>>> while not unsound, it is surely strange. Thus, restrict the untyped m=
ethods
>>>>> and also the register macro to `Region` type only.
>>>>>
>>>>> The way it is implemented is by adding a generic type to `IoLoc`. Thi=
s also
>>>>> paves the way to add typed register blocks in the future; for example=
, we
>>>>> could use this mechanism to block driver A's `register!()` generated =
macro
>>>>> from being used on driver B's MMIO. The same mechanism could be used =
for
>>>>> relative IO registers. These are future opoortunities, and for this p=
atch I
>>>>> just restricted everything to require `IoLoc<Region<SIZE>, _>`.
>>>>
>>>> Does this not prevent `usize` from being used to index anything but
>>>> `Mmio<Region<_>>`?
>>>>
>>>> It is my understanding that the following would work before this patch:
>>>>
>>>>    fn do_read(io: &Mmio<u32>) -> Result {
>>>>        let v: u32 =3D io.try_read(8usize)?;
>>>>        Ok(())
>>>>    }
>>>>
>>>> But I think this will no longer work with this patch. Is that the inte=
ntion?
>>>
>>> Your example would always fail, as you're reading 4 bytes from offset 4=
 from a
>>> region that is only 4 bytes in size. I suppose you're trying to say
>>>
>>>     fn do_read(io: &Mmio<[u32]>) -> Result {
>>>         let v: u32 =3D io.try_read(8usize)?;
>>>         Ok(())
>>>     }
>>
>> Yep, that was my intention, with the assumption that final offset
>> becomes 8*4. I think that is also what would happen here as we would
>> invoke `try_read::<u32, usize>(&Mmio<[u32]>, usize) -> Result<u32>` with
>>
>>   usize: IoLoc<u32>
>>   Mmio<[u32]>: IoCapable<u32>
>
> No, these methods behave the same as the old try_read32 macros, so these =
are
> absolute byte offsets. I think the fact you're confused is a good indicat=
ion
> that we probably want to remove these methods, or at least make them as
> inaccessible as possible :)

That is probably a good call =F0=9F=98=85 Going over the pieces again, I am=
 not
sure when and where I decided this was an index rather than a byte
offset.


Best regards,
Andreas Hindborg


