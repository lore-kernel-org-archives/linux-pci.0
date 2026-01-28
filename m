Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E52F745C;
	Wed, 28 Jan 2026 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615355; cv=none; b=liZ8hJrVMfEcX4Iqk3JWwmGfattkWauTb+XigfAGMTPZ+AaNFC1QyFhGa8DJ2V4KDlPuswLlj2qghLlu3njjayzhaXMKQT4UO6Hk8Bcy++cYz8Sdptc079GxUh88QrjjmGobLaJE/gxCh0AkS1kruTyJHdeUNLZ0QG6BQgUmXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615355; c=relaxed/simple;
	bh=0UZj4fFLAfQgbPtutzO7xYeNIF6dEE2FRAMEjj39u1Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Tufy/aQKGjYx7kntK22ag0acfMv4kojNrqvWph19WJm4xgy+YRYirtP6iojK8uXEIPUEb/0E3106pTFE6eQhYg5I9sUn0qsEUiYw2RZZKCH396TTp7Cr2whgH5qO8kCx/HDUBUjXaq/MA7ntmvAo4XE7Cs3ChTW4MyOrGyptN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppg2j73X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppg2j73X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30AAC116C6;
	Wed, 28 Jan 2026 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769615354;
	bh=0UZj4fFLAfQgbPtutzO7xYeNIF6dEE2FRAMEjj39u1Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ppg2j73XHCUd1CMc3I1RKZl+oFlTXY/hpmGTlTHEZwQNHpX5LWk6aQIFNsI2ipaXH
	 UVbN4djypTShB2b9KB04tp3AZbBCOzmODAgpEj86V1ftLnlnoKZWzBmjkeFZlDhTNW
	 qm/VxaLZQsOtqRiq5qDdHZWhlr9VAZdCO8dxJg5FvGXpzWXJzV+JaEXj/RxhivZn/6
	 GCt5Og7ZTvadKh+1vaJpMkAYoQUyIXYTGzIEpHtgbdmZ0FpNfkpRfD5Ju0iSI45flC
	 ExI+d1NUQvUTl+OdZ7/zM+gzNLmxvMUbYCV9vIHjYztgFgKU9P3phwkiV/yd/EeDoX
	 bIkSjY6m297oQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 16:49:07 +0100
Message-Id: <DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
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
 <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
 <20260128145906.GZ1134360@nvidia.com>
In-Reply-To: <20260128145906.GZ1134360@nvidia.com>

On Wed Jan 28, 2026 at 3:59 PM CET, Jason Gunthorpe wrote:
> On Wed, Jan 28, 2026 at 03:01:25PM +0100, Danilo Krummrich wrote:
>> There is no second memory allocation. In the implementation of
>> fwctl::Device::new() above we call _fwctl_alloc_device() with a size (an=
d
>> layout) such that this allocation is suitable to initialize the second a=
rgument
>> (i.e. data: impl PinInit<T, Error>) within this allocation.
>
> You are talking about your suggestions now right?

Correct, I'm talking about my proposal.

> Because what I see in Zi's patch doesn't match any of this?
>
> +                bindings::_fwctl_alloc_device(
> +                    parent.as_raw(),
> +                    ops,
> +                    core::mem::size_of::<bindings::fwctl_device>(),
> +                )
>
> That is not allocating any memory for driver use ...

Yes, the patch doesn't do any of that.

> What you are explaining sounds good to me, though I don't quite get
> the PinInit<> flow but I trust you on that. :)

So, it would basically look like this:

	pub struct Device<T> {
	    dev: Opaque<bindings::fwctl_device>,
	    data: T,
	}

Where T is the type of the driver specific fwctl device data.

	impl<T> Device<T> {
	    pub fn new(
	        parent: &device::Device,
	        data: impl PinInit<T::Data, Error>
	    ) -> Result<ARef<Self>> {
	        let layout =3D Kmalloc::aligned_layout(Layout::new::<Self>());

	        // SAFETY: ...
	        let raw_fwctl: *mut Self =3D unsafe {
	            bindings::_fwctl_alloc_device(
	                parent.as_raw(),
	                &Self::VTABLE,
	                layout.size(),
	            )
	        }
	        .cast();
	        let raw_fwctl =3D NonNull::new(from_err_ptr(raw_fwctl)?).ok_or(ENO=
MEM)?;

	        // Get the pointer to `Self::data`.
	        let raw_data =3D unsafe { &raw mut (*raw_fwctl.as_ptr().data) };

	        // Initialize the `data` initializer within the memory pointed
	        // to by `raw_data`.
	        unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
	            // Find the `struct fwctl_device` pointer from the `Self`
	            // pointer.
	            let fwctl_dev =3D unsafe { Self::into_fwcl_device(raw_fwctl) }=
;

	            // Since we failed to execute the initializer of `data`,
	            // unwind, i.e. drop our reference to `fwctl_dev`.
	            unsafe { bindings::fwctl_put(fwctl_dev) };
	        })?;


	        // The initializer was successful, hence return `Self` as
	        // `ARef<Self>`.
	        Ok(unsafe { ARef::from_raw(raw_fwctl) })
	    }
	}

So, essentially the driver passes an initializer of its private data and we
"write" this initializer into the extra memory allocated with
_fwctl_alloc_device().
