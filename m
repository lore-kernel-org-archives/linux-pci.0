Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D31ACEDF;
	Wed, 28 Jan 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608893; cv=none; b=eeqyh9pSRw1R30u9Mmde7TvRnm6ElI79u/pdGzXonMEASYCYcqTtGjWOZB1yHJp4l7nzl9a5uVQg4v+OaByMf1dIeepoDgwt+UBcYLg4qQFit1bHgGOkQflPdkJ5Kaek1/6Y+uyM2aK9lnDWpKhJtgJeaqtfY7vna1oC8yEBc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608893; c=relaxed/simple;
	bh=KFeBI8zLVZ8WMwwmbISKeHRDeUHY7P767iycOE8mnNs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kPKXa/QTxONCjNVEgX/F09raVv0uVu9DX5pkHAWI/ZASKwWn24utYzUBSN6neREpDQObcQ7TMMACwy+DCtqbt6D5h4MO0lo61ESb3gQabEnPeGwwwD69dUiH9wHRjs5ecOUUYVW00abgRyYeyhN+Gof6WqG3xBnYlyl5XeHmSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX0uCU2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX0uCU2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1037AC4CEF1;
	Wed, 28 Jan 2026 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769608893;
	bh=KFeBI8zLVZ8WMwwmbISKeHRDeUHY7P767iycOE8mnNs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fX0uCU2de3ofbVOQte0/PprfXZiybpd9bmhfuQxb/Ymhk3Z5KIg/3gEiW1BzATJDW
	 rvkP0OS8qtz27vpJQINdeFdELpH5fzt8uHrVEtJ6GZ/aBeV6aNZdqpKIpijp53GiGc
	 ajzGcVyDzVbuTw4DdMom9s0v+xub+5hBgV/6fJ9Jtohh//x5j4SuN9lyBDWFYXcQNE
	 B9EqghbcMjuIIR00jsyVKEf6BSXGmugRTwKR85q5HGxHRPRlFzSyVsq57WrkEDs0pj
	 uSQpQLgMaUnhcNQaay5aRSW5YyS1Z0QfkyqPeAXPTJStVcuhFvRxV+HYfG244r3gqY
	 snp3DUNGps80A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 15:01:25 +0100
Message-Id: <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctlg
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128000410.GT1134360@nvidia.com>
 <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
 <20260128132029.GX1134360@nvidia.com>
In-Reply-To: <20260128132029.GX1134360@nvidia.com>

On Wed Jan 28, 2026 at 2:20 PM CET, Jason Gunthorpe wrote:
> On Wed, Jan 28, 2026 at 02:21:38AM +0100, Danilo Krummrich wrote:
>> On Wed Jan 28, 2026 at 1:04 AM CET, Jason Gunthorpe wrote:
>> > On Tue, Jan 27, 2026 at 09:07:37PM +0100, Danilo Krummrich wrote:
>> >> On Tue Jan 27, 2026 at 8:57 PM CET, Zhi Wang wrote:
>> >> > The fwctl_alloc_device() helper allocates a raw struct fwctl_device
>> >> > without private driver data here. The Rust driver object should be
>> >> > already allocated and initialized separately before reaching this
>> >> > point.
>> >> >
>> >> > We rely on the standard dev->parent chain to access the rust driver
>> >> > object from the fwctl callbacks.
>> >>=20
>> >> (I will go for a thorough review soon, but for now a quick drive-by c=
omment.)
>> >>=20
>> >> IIUC, you are saying that the user is supposed to use the private dat=
a of the
>> >> parent device in fwctl callbacks. Let's not make this a design choice=
 please.
>> >> Instead, allow the user pass in separate private data for the fwctl d=
evice as
>> >> well.
>> >>=20
>> >> This serves the purpose of clear ownership and lifetime of the data. =
E.g. the
>> >> fwctl device does not necessarily exist as long as the parent device =
is bound.
>> >>=20
>> >> It is a good thing if driver authors are forced to take a decision ab=
out which
>> >> object owns the data and what's the scope of the data.
>>=20
>> I think we were talking about different things. :)
>
> Well, I've always been talking about this :)

Fair enough. :)

>> In this case Registration::new() returns an initializer, but also alloca=
tes the
>> C struct fwctl_device within the initializer.
>
> In a normal C implementation this would allocate both the core and
> driver struct using one memory and a container_of() relationship.

That's what happens here as well, see below.

>> AFAICS, _fwctl_alloc_device() already initializes the structure properly=
, so it
>> seems there is nothing to be done.=20
>
> It does the first part of a three step sequence
>
> 1) Allocate memory and initialize core code
> 2) Steup driver related data
> 3) "register" to make the device live and begin concurrent access
>
> I don't think 1 and 3 can be in the same function. The driver must have
> the opportunity to do its #2 step in this sequence.

Yes, the driver has this opportunity, again see below.

>> Either way, I think it would be cleaner if fwctl::Device has a construct=
or
>>=20
>> 	impl Device<T> {
>> 	    fn new(
>> 	        parent: &Device<Bound>,
>> 	        data: impl PinInit<T, Error>
>> 	    ) -> Result<ARef<Self>>;
>> 	}
>>=20
>> where T is the driver's private data for the struct fwctl_device.
>>=20
>> And Registration::new() can take a &fwctl::Device<T> and the parent
>> &Device<Bound> of course. This would also be in line with what we do in =
other
>> class device abstractions.
>
> If it goes like this is there some way rust can retain the
> container_of layout and avoid a second memory allocation?

There is no second memory allocation. In the implementation of
fwctl::Device::new() above we call _fwctl_alloc_device() with a size (and
layout) such that this allocation is suitable to initialize the second argu=
ment
(i.e. data: impl PinInit<T, Error>) within this allocation.

This is the equivalent to the subclassing pattern as you would implement it=
 in C
with container_of(). See also the drm::Device implementation [1], which doe=
s the
exact same thing.

When it comes to the Registration object (which returns an initializer as w=
ell),
this would go into the initializer (initializer can be nested) of the drive=
r's
device private data of the parent device, i.e. no separate allocation, it j=
ust
lives in the driver's device private data of the parent device.

Alternatively, we can also just not return a Registration object at all and
leave it up to devres to entirely, i.e. equivalent to a
devm_fwctl_register_device() function. The Registration object is only need=
ed if
we intend to unregister the fwctl device before the parent device unbind.

[1] https://rust.docs.kernel.org/src/kernel/drm/device.rs.html#98
