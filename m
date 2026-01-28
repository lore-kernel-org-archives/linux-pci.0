Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C425A2B4;
	Wed, 28 Jan 2026 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618112; cv=none; b=UDffB1ef95S9xfQEqClXQoAtgrtCwX2tUe/iKxrkVXiFD2JuFYCzRByR84rHRvmWhdlLjq/z/mLUxZjYByCyT17eBL274NJr+aq2lox/JqN83gFqMm3tfaUwHKXjkVNHN+e2qvI4GCGx6XcddE/wf+m35blKLNqOUUVz4L+iyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618112; c=relaxed/simple;
	bh=kNjkhCzfjFGG/s467JvFGHmipMNmR9rg0Sw+Qybtr6I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UzmnnI6PRSAoeFoP6ZEfWAyhhJZtpNVsjBIykqpizGV4rRVUnN/H9R+HzFMrb558fZ0a/p0xCA1f1SeMoIvNb4OCSG0NuT1V7dsxCMw/ZxJh/D8fqD6skzUIt0f8f15PeiamCVdMSc/phbgVdHMzEsbk/odyE7A2NfKPva9p/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu0VUeIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu0VUeIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4028FC116C6;
	Wed, 28 Jan 2026 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769618111;
	bh=kNjkhCzfjFGG/s467JvFGHmipMNmR9rg0Sw+Qybtr6I=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Zu0VUeIM8CG/905d9qub9cbSDWDSecWTJpgIse8DXDIiRkwZo/KVtmUNBAdsMw0u/
	 hJDekR4SKijhTXPHWup152sLSrcCplPIeTT2fvWfulzjflr6yXMNSFR4ZiUD2Bg8rM
	 dzJL6fp+UUFmy3lal1tt4qKmywt46i9TxzxhkI8LBXPGo/xK4uwS1BBBALM6n5QaHa
	 aAQMtvPL+k3CttZgdzYiKBZb0Pg8bC+nUc7iKnqjAxutrjwTYMOgDSQ87YkuQY9n8O
	 eHLzaClofOYD90bmOtLKfY8qK8fubil2rB7CDfPiE4tlLr4cQyRYnWVVV4yLMz183q
	 x7EhejoK1IEUQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 17:35:04 +0100
Message-Id: <DG0D9I9P5BO9.6Q9H2BQN5AWU@kernel.org>
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
References: <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128000410.GT1134360@nvidia.com>
 <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
 <20260128132029.GX1134360@nvidia.com>
 <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
 <20260128145906.GZ1134360@nvidia.com>
 <DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
 <20260128155646.GB1134360@nvidia.com>
In-Reply-To: <20260128155646.GB1134360@nvidia.com>

On Wed Jan 28, 2026 at 4:56 PM CET, Jason Gunthorpe wrote:
> On Wed, Jan 28, 2026 at 04:49:07PM +0100, Danilo Krummrich wrote:
>
>> 	        // Initialize the `data` initializer within the memory pointed
>> 	        // to by `raw_data`.
>> 	        unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
>
>> So, essentially the driver passes an initializer of its private data and=
 we
>> "write" this initializer into the extra memory allocated with
>> _fwctl_alloc_device().
>
> This all seems like the right way to do it!
>
> My only remark it that it still doesn't give an opportunity to call a
> function between init and register.

You would, from a driver side it would look like this:

	#[pin_data]
	struct MyDriver {
	    #[pin]
	    _reg: Devres<fwctl::Registration>,
	    fwctl: ARef<fwctl::Device>,
	}

	#[pin_data]
	struct FwctlData {
	    #[pin]
	    foo: Mutex<Foo>,
	    ...,
	}

	impl pci::Driver for MyDriver {
	    fn probe(
	        pdev: &pci::Device<Core>,
	        _info: &Self::IdInfo,
	    ) -> impl PinInit<Self, Error> {
	        let fwctl =3D fwctl::Device::new(
	            pdev.as_ref(),
	            try_pin_init!(FwctlData {
	                foo <- mutex_new!(Foo::new()),
	                ...,
	            }),
	        )?;

	        // Let's do something with the `fwctl::Device` before we
	        // register it.
	        fwctl.do_stuff();

	        try_pin_init!(Self {
	            // We could omit this and instead provide
	            // `fwctl::Registration::register()`, which does only return
	            // a `Result` and keeps the `fwct::Device` registered until
	            // driver unbind.
	            _reg <- fwctl::Registration::new(pdev.as_ref(), fwctl);
	            fwctl,
	        })
	    }
	}

> __pinned_init() is taking the T type without access to the initialized
> fwctl_device

If a driver, in order to come up with its private data (FwctlData in the ex=
ample
above), needs a struct fwctl_device, we could make this happen as well. For
instance, fwctl::Device::new() could take a closure that has a valid
representation of a struct fwctl_device as argument. But I think that's not
necessary.

> So if I add some function drivers need to call between init and register:
>
>  fwctl_XYZ(fwctl, ..)
>
> It is not possible?=20

As you can see from the example above, that's possible.

> Or is it needed to add the typestate?

This is something we should consider when a fwctl::Device would have differ=
ent
states it can be in, where calling certain methods of a fwctl::Device is on=
ly
valid for a certain state and would cause undefined behavior if called from=
 the
wrong state.
