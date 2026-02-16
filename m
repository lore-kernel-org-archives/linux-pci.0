Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF1255F2D;
	Mon, 16 Feb 2026 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771243731; cv=none; b=Bq03u5RBPChtFkE+0bTM5NsjUJiWWaltgSecXy2ai4JOcZnYmWoStwIbFVbRYyUDzo0zVl/c82xNEkMnYo++LCaP/ftOEIUoT8doUL17A+99qURmcu6VLs1Gs6tOgQS7QqnRJMPVdWKRQrOngPnqhzZy726SrivittIJK4VGmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771243731; c=relaxed/simple;
	bh=RR2IpG9BGcPTRqGN7QHTpfTSiih6hT77uoezOpB8/2U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cYyrdY4CilPoTbJLXEO/pCRvDoeecDYTwv96LQ4LH5LOdcVbdNvpJaRSd7wGLGBFGvgjZGjJ9vqYsMDYTs7fk1hienE1jy3ddvsJWR8TTIXHjfZdsIh7EW9W3fGScnHWhwCyiUG+rpFphsjlUgxHtgYh4wmbnjt0M7/5b3AIGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZZ2oS8D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZZ2oS8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA04C116C6;
	Mon, 16 Feb 2026 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771243730;
	bh=RR2IpG9BGcPTRqGN7QHTpfTSiih6hT77uoezOpB8/2U=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ZZZ2oS8DnoqlPDSEiDmtlbyZCz8Rd9wD5am5tJh9+ytzE3lf8T42gEQDgKB/MRQtq
	 G78U6gwFkMdPlpez89qGzZaAXsCyfB9R8fzyD8F8zk37JurlPhcc6prSA7DPkOGPsv
	 EMsEd69Die2+14eW8eOSif4W8S88UO8EB3p2n3JsHqIPVP8ScBAGkAda/1YkFKfWVE
	 QpwoFvA09DOhl7zj4JtUuFPu0WDGrr1CQt3iDJ0lhZkg+vKJRGOWwgShbkwreTnHWw
	 PLkc2Apf2uOoaRGMjEUUCRFiqdFJ5IhB5/mi1rz54PFpdAgipFZS7mlkzNTPjPC1qR
	 2PR5SB6wZGb2g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 13:08:45 +0100
Message-Id: <DGGDHY4582D1.1GZGZ7P98OKWO@kernel.org>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
Cc: "Gary Guo" <gary@garyguo.net>, <lyude@redhat.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
 <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
 <DGD1LDCXJZR6.32S0Z7EHGYDUN@garyguo.net>
 <DGD2GXAFO99J.1Y3BA26PBVTAC@kernel.org>
 <DGGD4JTGJYXR.3THD2I3AA61PN@nvidia.com>
In-Reply-To: <DGGD4JTGJYXR.3THD2I3AA61PN@nvidia.com>

On Mon Feb 16, 2026 at 12:51 PM CET, Alexandre Courbot wrote:
> On Thu Feb 12, 2026 at 11:52 PM JST, Danilo Krummrich wrote:
>> On Thu Feb 12, 2026 at 3:11 PM CET, Gary Guo wrote:
>>> They can, but the `Io` trait just passes the wrong address to the `IoCa=
pable`
>>> trait, and nothing horrible can happen without doing things unsafely in=
side
>>> `IoCapable` impl, which is controlled by the user who implements `Io`. =
It looks
>>> to me that unsafe code is still needed to do bogus things.
>>
>> I think what you mean is that the invariant of `addr` and `maxsize` bein=
g valid
>> is on the implementing type of `Io`, e.g. `MmioRaw` and `Mmio`. The same=
 applies
>> to IoKnownSize::MIN_SIZE.
>>
>> To me this seems like a valid way of arguing.
>
> But still, using only safe code an implementor of `Io` can lie about
> this safety statement:
>
>     // SAFETY: `address` has been validated by `io_addr`.
>     Ok(unsafe { self.io_read(address) })
>
> Granted, the same person will likely have written the `IoCapable`
> implementations, but its safety requirements cannot be fulfilled unless
> the caller also guarantees that the offsets it passes are valid, which
> the type system alone cannot guarantee - thus the need to make `Io` and
> `IoKnownSize` unsafe IMHO.

Hm...the implementor of Io and IoCapable has to justify in the implementati=
on of
IoCapable, i.e. in io_read() and io_write() that the address is in fact cor=
rect.

The implementor can't justify this if the address or offset can be bogus in
their implementation of Io.

So, considering that, it looks to me that we don't even need io_read() and
io_write() to be unsafe in the first place?

I.e. we are only passing through values in generic implementation.
