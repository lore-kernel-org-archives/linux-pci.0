Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397A35F199;
	Tue,  3 Mar 2026 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571062; cv=none; b=eANv2+q75aCkfJa4T1I/EeipQXB0LZCEpO+2pz39YZkKZU/xDvuebBdSjjgvBuxSw5ydbvySOljs2QVG9j5lp3JfDCC0sVYk/eXkEdHvcTrxyzkPQiG+3SJFinvUZBrib0dZcv5HKIPnP+KnIfV3rCBssMbtbaiCycUrzAj5vAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571062; c=relaxed/simple;
	bh=qte+d70iMLpccZH/xGwXfT/WiLx9st5s/uqFeQ9tdA0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=L/vVRMiusn1CfwYv9ednHYoNxJKpmFdj+tfRgdLSqi4RMYnERwPAvP8682aKhHJxhPzqO0U4QnJXYKY8HDW1Hm8k9B3ss9MHFZWE7QvRAwbkKGx+Q03zu8lK0gFaHS6bylAkYORbew7PuC87aCMMPYJlxLv+8obt5l7QQRJXD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf9+SyNb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf9+SyNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D48C116C6;
	Tue,  3 Mar 2026 20:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772571062;
	bh=qte+d70iMLpccZH/xGwXfT/WiLx9st5s/uqFeQ9tdA0=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Gf9+SyNb3yVlntMIaBz/Kgeg28Qg/OoEU80dEFoAP+miekUpBYs5ER46dnXrQfWVJ
	 /AGeDHryjPfPkchVMlqW3vgHGF2UvserVLNP3H6vrC4dnYjZuiqftl2WxG6Pfluce1
	 smL0xGo3/8L7Wkmx2EwK6UwjI3s4skc0kF0ag6IU/B8o7x6mGkHZwl2ZSexUKzshri
	 0lx6hBhGO4zOK2MKfynmpq14PlbsFtTbjZwUCNTkzlS/o25UDI/AE4nXS4eaLoPlo8
	 NsGSvymYtTfdM0I43GACY+/ZZBSdDK6tFo6eFB1L+TnlqPtgbScDvsunxQvJ8f+cJP
	 UAoO7SBq5gZcw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 21:50:55 +0100
Message-Id: <DGTFZX0OF96N.18P63FULRD8GN@kernel.org>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gary@garyguo.net>, <joelagnelf@nvidia.com>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/1] rust: introduce abstractions for fwctl
References: <20260217204909.211793-1-zhiw@nvidia.com>
 <20260217204909.211793-2-zhiw@nvidia.com>
 <20260303201552.GF972761@nvidia.com>
In-Reply-To: <20260303201552.GF972761@nvidia.com>

On Tue Mar 3, 2026 at 9:15 PM CET, Jason Gunthorpe wrote:
> Anyhow is someone waiting for me to do something with it?

I still have this on my list for review, I can probably do a pass tomorrow.=
 :)

>> +impl<T: Operations> Device<T> {
>> +    /// Allocate a new fwctl device with embedded driver data.
>> +    ///
>> +    /// Returns an [`ARef`] that can be passed to [`Registration::new()=
`]
>> +    /// to make the device visible to userspace. The caller may inspect=
 or
>> +    /// configure the device between allocation and registration.
>> +    pub fn new(
>> +        parent: &device::Device<device::Bound>,
>> +        data: impl PinInit<T::DeviceData, Error>,
>> +    ) -> Result<ARef<Self>> {
>> +        let ops =3D core::ptr::from_ref::<bindings::fwctl_ops>(&VTable:=
:<T>::VTABLE).cast_mut();
>> +
>> +        // SAFETY: `_fwctl_alloc_device` allocates `size` bytes via kza=
lloc and
>> +        // initialises the embedded fwctl_device. `ops` points to a sta=
tic vtable
>> +        // that outlives the device. `parent` is bound.
>> +        let raw =3D unsafe {
>> +            bindings::_fwctl_alloc_device(parent.as_raw(), ops, core::m=
em::size_of::<Self>())
>> +        };
>> +
>> +        if raw.is_null() {
>> +            return Err(ENOMEM);
>> +        }
>> +
>> +        // CAST: Device<T> is repr(C) with fwctl_device at offset 0.
>> +        let this =3D raw as *mut Self;
>
> Should this have some helper? It looks a bit fragile, in C we have a
> static_assert on offsetof to prevent errors.

We could add a helper with something like this:

	    const {
	        assert!(
	            core::mem::offset_of!(Self, dev) =3D=3D 0,
	            "struct fwctl_device must be at offset 0"
	        )
	    };

But we could also just include this in this constructor.
