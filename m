Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C762AF1B;
	Wed, 28 Jan 2026 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769563306; cv=none; b=HkKEKKxmNMKJN5bG+KaNcJAzAmBgaveg0sugx8j1mBr5JFx/6RdTagqV5IQoRQ4YBspwPMQ5aQ0/lisz5k41xvdmdRX3E7q0dx5vGIYt/UwjFG0HTK4BbKpqPDbHI5OrFeI22jg3LyATrWJRirpsE3YdomoULuHKxuzY+z2G+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769563306; c=relaxed/simple;
	bh=nI7NlYDFjZ4HtSOAdOB4GQL+OVvn1g0ZEzDYbz0cwhI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kWSq5N16+i7bmfbIUuw0dAm5J4OWt5R1pHwwR1mx7/bEfiNS6CxTQEEUb6DDKZX6nedbtqZdmz2g5m6wsOUEDVk8BXmk5cMaT6WzL/s7tt+pVjm9gUmQBLPvVwy/Rx68CI67e5kP0jW3mnZAQ6xuPqYF8pO92JabDf0aDY6+j7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg3KV8NF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg3KV8NF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CA3C116C6;
	Wed, 28 Jan 2026 01:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769563306;
	bh=nI7NlYDFjZ4HtSOAdOB4GQL+OVvn1g0ZEzDYbz0cwhI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Wg3KV8NF1w3DUlu+JrYtM76tt93fuJWGf2K1wjhUJZ4Y+QwFVzDIWKCrdwdrtdBNL
	 6ZeK9gSA3aE8NRHLEZETVK3CM58c4AFwTSrop/2Qv7fiBybFpkMj9HwOd1mINY4m4Y
	 9LGZfvlQomljp+X1q7b5ekvph4KpQbFUWTERhkMSNnB60liM/DhlxsYeQ+iOd58sxf
	 /iaXsCLV+XF7w4CRom8zEt0Etud8HoBA4QRr422WTjDdWJwqpjSys8i0FaqleuoYPe
	 t2m7N789jpHZ38DqqqM1V0wByLrnNaVV6He7pT6EZ3jGLcw7qAoEjrHv0z9RuCRwgE
	 Nh1EmyXJsjG6g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 02:21:38 +0100
Message-Id: <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
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
In-Reply-To: <20260128000410.GT1134360@nvidia.com>

On Wed Jan 28, 2026 at 1:04 AM CET, Jason Gunthorpe wrote:
> On Tue, Jan 27, 2026 at 09:07:37PM +0100, Danilo Krummrich wrote:
>> On Tue Jan 27, 2026 at 8:57 PM CET, Zhi Wang wrote:
>> > The fwctl_alloc_device() helper allocates a raw struct fwctl_device
>> > without private driver data here. The Rust driver object should be
>> > already allocated and initialized separately before reaching this
>> > point.
>> >
>> > We rely on the standard dev->parent chain to access the rust driver
>> > object from the fwctl callbacks.
>>=20
>> (I will go for a thorough review soon, but for now a quick drive-by comm=
ent.)
>>=20
>> IIUC, you are saying that the user is supposed to use the private data o=
f the
>> parent device in fwctl callbacks. Let's not make this a design choice pl=
ease.
>> Instead, allow the user pass in separate private data for the fwctl devi=
ce as
>> well.
>>=20
>> This serves the purpose of clear ownership and lifetime of the data. E.g=
. the
>> fwctl device does not necessarily exist as long as the parent device is =
bound.
>>=20
>> It is a good thing if driver authors are forced to take a decision about=
 which
>> object owns the data and what's the scope of the data.

I think we were talking about different things. :)

Zhi mentioned the private data of the parent device being used in fwctl
callbacks, but we should use private data stored in fwctl_device::dev inste=
ad.

> I'm not sure what the model is in rust, but the expection here is for
> the driver to have a window between alloc and register where the
> driver can fill in any information into the core structures that is
> needed before calling registration.

Yes, in Rust you can't have an instance of a structure without initializing=
 it
(unless you put it in a MaybeUninit container, etc.).

For dynamic allocations Rust solves this with initializers. For instance, w=
here
C does:

	struct foo *foo =3D kzalloc(sizeof(*foo), GFP_KERNEL);

	/* Maybe broken if foo is used here already. */

	foo_initialize(foo, ...);

you'd have something like this in Rust:

	struct Foo {
	    data: Mutex<Data>,
	    index: u32,
	}

	impl Foo {
	    fn new(index: u32, args: Args) -> impl PinInit<Self, Error> {
	        try_pin_init!(Self {
	            data <- new_mutex!(args.to_data()?),
	            index.
	        })
	    }
	}

The returned object is not an instance of struct Foo yet, it is an initiali=
zer,
i.e. impl PinInit<Foo, Error>; no memory has been allocated yet. Note that =
this
initializer can also fail if executed, since args.to_data() can fail.

Let's allocate the memory now:

	let foo =3D KBox::pin_init(Foo::new(...), GFP_KERNEL)?;

This allocates the memory (i.e. KBox::pin_init() calls kmalloc() eventually=
) and
executes the initializer. (The call fails if either the memory allocation f=
ails,
or the initializer fails.) This way there is no way for the caller to use f=
oo
before it has been initialized.

(What about the "pin" thing? Let's assume Data contains something
self-referential, in this case pin-init does prevent the user from moving d=
ata
out of Foo, which would be a bug since it is a self-referential structure.
Actually, the mutex must not be moved either.)

Back to this abstraction. :)

In this case Registration::new() returns an initializer, but also allocates=
 the
C struct fwctl_device within the initializer.

AFAICS, _fwctl_alloc_device() already initializes the structure properly, s=
o it
seems there is nothing to be done. But let's assume there is. In this case =
it
wouldn't help much if we would create a separate fwctl::Device structure be=
fore,
as this one also has to be properly initialized once created. So the constr=
uctor
of fwctl::Device has to take the corresponding arguments.

Though, sometimes there are cases where we have to defer some initializatio=
n.
This is where we usually use separate types or type states. Let's assume
something in the device only ever gets initialized after registration for s=
ome
reason. In this case you could have a fwctl::Device<Unregistred> and a
fwctl::Device<Registered> and correspondingly treat the inner data as parti=
ally
uninitialized (which requires unsafe code).

Either way, I think it would be cleaner if fwctl::Device has a constructor

	impl Device<T> {
	    fn new(
	        parent: &Device<Bound>,
	        data: impl PinInit<T, Error>
	    ) -> Result<ARef<Self>>;
	}

where T is the driver's private data for the struct fwctl_device.

And Registration::new() can take a &fwctl::Device<T> and the parent
&Device<Bound> of course. This would also be in line with what we do in oth=
er
class device abstractions.
