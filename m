Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251953F5BFD;
	Thu, 24 Sep 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272957; cv=none; b=fhwAu1a5LYzkm1z12s8RpqTwzX4igbNdNRGgED9yK7qk9K752KDAPyD+9B0oAKw0QY7Ttr2AWOSfOV/h+HBxW2A8nZH/uqIPBpmr50IqJQPc4K8Q3LHSQlOzaz95bz6ElhreqKD+Agp0fCeGeTYxT5EkPRhj18XgVpbOXz+Yz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272957; c=relaxed/simple;
	bh=vhlYxrq3zkhDOveFX1ZVtXnhoHqfgwNrFALGgBEHfvg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GH2hUtvUHMuAU0wQ0o5Fxdqb1iQ2IHFg14fnR2ltj4EymNB53xvjgtFaNnhElz4Nv1vR3lvjrHE/Ps9P3SLGo+HqS+6aeUNLsxopYKYPbsiO2Hw3VtYhvF7YaxvMjxs8cJxIL/rRSut+6bqZnkYdFpYEahRO1/Cl8/Ya1gdS/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtNBYdX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtNBYdX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929D61F000FF;
	Thu, 24 Sep 2026 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272956;
	bh=7XuW8fR6obHIaECVkQ/oQW8UbYwTRR48c0HPzP0MOGo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=CtNBYdX4hAYjYZhVp62dDw10ZSvEsXwhf8WbMaG7QqvwG2ejItwNA/vMxflQEaBgG
	 lQljaNpKl/DB60I7eovidWmR6OXM1yTz6EgQ7YBGa981N0cJMfU4zMgiS3mCkonos1
	 2iUE027Nkvbrw59/iw6XouLu73Y1uQOLbsv09hnnrCouG/QKgwdv8Gvhwi3m4cauQt
	 v8KziPMkFJqT/hRZAwvEQCTULagBmBKcurrRdt3siwl9izz1FN/v7IPL4KmAJB0U3N
	 G8UhiFTBqJfB79qhMk88JS76iG6HgDZzByRjfKw6YbMF+caWp5rckLucp2V2ye/LAV
	 P0z1L2vriLA4Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 20:02:29 +0200
Message-Id: <DLNQSN92C9RT.WNMLAMGA5UBW@kernel.org>
Subject: Re: [PATCH v3 5/5] rust: samples: add EDU PCI driver sample
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Maurice Hieronymus" <mhi@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-5-5d0b5594e52b@mailbox.org>
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-5-5d0b5594e52b@mailbox.org>

On Wed Aug 12, 2026 at 9:52 PM CEST, Maurice Hieronymus wrote:
> +const QEMU_VENDOR_ID: u16 =3D 0x1234;
> +const QEMU_EDU_DEVICE_ID: u32 =3D 0x11e8;
> +const QEMU_EDU_DEVICE_MAGIC: u8 =3D 0xed;

This should be local to magic().

> +const QEMU_DMA_BASE: u64 =3D 0x40000;

This could be of type regs::DMA_DST and local to test_dma().

> +
> +const IRQ_MAGIC_VALUE: u32 =3D 42;
> +
> +/// Bit set in `IRQ_STATUS` when a DMA transfer has completed.
> +const DMA_IRQ: u32 =3D 0x100;

Why is this not part of the IRQ_STATUS declaration in register!()?

> +
> +mod regs {
> +    use super::*;
> +
> +    register! {
> +        pub(super) IDENTIFICATION(u32) @ 0x0 {
> +            31:24 major;
> +            23:16 minor;
> +            7:0 magic;
> +        }
> +
> +        pub(super) LIVENESS_CHECK(u32) @ 0x04 {}
> +
> +        pub(super) FACTORIAL(u32) @ 0x08 {}
> +
> +        pub(super) STATUS(u32) @ 0x20 {
> +            0:0 computing;
> +            7:7 raise_interrupt;
> +        }
> +
> +        pub(super) IRQ_STATUS(u32) @ 0x24 {}
> +        pub(super) IRQ_RAISE(u32) @ 0x60 {}
> +        pub(super) IRQ_ACK(u32) @ 0x64 {}
> +
> +        pub(super) DMA_SRC(u64) @ 0x80 {}
> +        pub(super) DMA_DST(u64) @ 0x88 {}
> +        pub(super) DMA_COUNT(u64) @ 0x90 {}
> +        pub(super) DMA_COMMAND(u64) @ 0x98 {
> +            0:0 start_transfer;
> +            1:1 direction;
> +            2:2 raise_irq;
> +        }
> +    }
> +
> +    pub(super) const END: usize =3D 0xA0;
> +}
> +
> +type Bar0<'a> =3D pci::Bar<'a, { regs::END }>;
> +
> +struct EduDriver;
> +
> +#[pin_data(PinnedDrop)]
> +struct EduDriverData<'bound> {
> +    pdev: &'bound pci::Device,
> +    #[pin]
> +    irq_handler: irq::Registration<'bound, IrqHandler<'bound>>,
> +    // Declared last so the device stays enabled until the IRQ handler i=
s freed.
> +    _enable: pci::DeviceEnableGuard<'bound>,
> +}
> +
> +#[pin_data]
> +struct IrqHandler<'a> {
> +    pdev: &'a pci::Device,
> +    bar: Bar0<'a>,
> +    #[pin]
> +    irq_test_completion: Completion,
> +    #[pin]
> +    irq_dma_completion: Completion,
> +    dma: Coherent<u64>,
> +}
> +
> +impl EduDriver {
> +    fn init(pdev: &pci::Device<Bound>, bar: &Bar0<'_>, handler: &IrqHand=
ler<'_>) -> Result {

I think this should rather be named selftest() and it should be a method on
EduDriverData instead rather than a function on EduDriver. The same goes fo=
r all
the other functions below.

> +        Self::config_space(pdev);
> +        Self::magic(pdev, bar)?;
> +        Self::liveness_check(pdev, bar)?;
> +        Self::factorial(pdev, bar)?;
> +        Self::test_irq(pdev, handler)?;
> +        Self::test_dma(pdev, handler)?;
> +        Ok(())
> +    }

<snip>

> +    fn magic(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result {
> +        let identification =3D bar.read(regs::IDENTIFICATION);
> +
> +        let magic: u8 =3D identification.magic().into();
> +
> +        if magic !=3D QEMU_EDU_DEVICE_MAGIC {

Can't we construct a regs::IDENTIFICATION value and compare this instead of=
 the
raw value?

> +            dev_err!(
> +                pdev,
> +                "magic mismatch: expected {:#x} got {:#x}\n",
> +                QEMU_EDU_DEVICE_MAGIC,
> +                magic
> +            );
> +            return Err(ENODEV);
> +        }
> +
> +        dev_info!(
> +            pdev,
> +            "major: {:#x} minor: {:#x}\n",
> +            identification.major(),
> +            identification.minor()
> +        );
> +        Ok(())
> +    }
> +
> +    fn liveness_check(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Resu=
lt {
> +        let test_value =3D 0xabcd;
> +
> +        bar.write(regs::LIVENESS_CHECK, test_value.into());
> +
> +        let inverse_value =3D bar.read(regs::LIVENESS_CHECK).into_raw();
> +
> +        if inverse_value !=3D !test_value {

I think this would read better as

	let pattern =3D regs::LIVENESS_CHECK::from_raw(0xdead_beef);
	bar.write_reg(pattern);
	if bar.read(regs::LIVENESS_CHECK) !=3D !pattern {
	    return Err(ENODEV);
	}

And in the regs module we could implement

	impl core::ops::Not for LIVENESS_CHECK {
	    type Output =3D Self;
=09
	    fn not(self) -> Self {
	        Self::from_raw(!self.into_raw())
	    }
	}

> +    fn test_dma(pdev: &pci::Device<Bound>, handler: &IrqHandler<'_>) -> =
Result {
> +        dev_dbg!(pdev, "testing dma\n");
> +
> +        let dma =3D &handler.dma;
> +
> +        const DMA_VALUE: u64 =3D 42;
> +
> +        kernel::dma_write!(dma, , DMA_VALUE);
> +
> +        handler.bar.write(regs::DMA_SRC, dma.dma_handle().into());
> +        handler.bar.write(regs::DMA_DST, QEMU_DMA_BASE.into());
> +        handler
> +            .bar
> +            .write(regs::DMA_COUNT, (dma.size() as u64).into());
> +        handler.bar.write(
> +            regs::DMA_COMMAND,
> +            regs::DMA_COMMAND::zeroed()
> +                .with_start_transfer(true)
> +                .with_direction(false)
> +                .with_raise_irq(true),
> +        );
> +
> +        handler.irq_dma_completion.wait_for_completion();
> +
> +        // Destroy previous value to test roundtrip
> +        kernel::dma_write!(dma, , 0);
> +
> +        handler.bar.write(regs::DMA_SRC, QEMU_DMA_BASE.into());
> +        handler.bar.write(regs::DMA_DST, dma.dma_handle().into());
> +        handler
> +            .bar
> +            .write(regs::DMA_COUNT, (dma.size() as u64).into());

Please avoid as casts and use FromSafeCast instead.

> +impl pci::Driver for EduDriver {
> +    type IdInfo =3D ();
> +    type Data<'bound> =3D EduDriverData<'bound>;
> +
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> +
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<kernel::device::Core<'_>>,
> +        _id_info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        pin_init::pin_init_scope(move || {

Let's make this a single try_pin_init!() block. You can subsequently chain =
it
with pin_chain() to call selftest().

This is what I came up with for a talk; it doesn't align perfectly as it ha=
s a
couple of things refactored and uses self-referencial pin-init, but you get=
 the
idea.

	fn probe<'bound>(
	    pdev: &'bound pci::Device<kernel::device::Core<'_>>,
	    _id_info: Option<&'bound Self::IdInfo>,
	) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
	    try_pin_init!(EduDriverData {
	        _: {
	            dev_dbg!(
	                pdev,
	                "Probe Rust EDU driver sample (PCI ID: {}, 0x{:x}).\n",
	                pdev.vendor_id(),
	                pdev.device_id(),
	            );
	        },
=09
	        _enable: pdev.enable_device().inspect(|_| pdev.set_master())?,
=09
	        bar: pdev.iomap_region_sized(0, c"rust_driver_edu")?,
=09
	        irq_vec: pdev.alloc_irq_vectors(1, 1, IrqTypes::default().with(pci=
::IrqType::Msi))?,
=09
	        irq_handler <- irq::Registration::new(
	            irq_vec.index(0)?.into(),
	            Flags::TRIGGER_NONE,
	            c"rust_edu_irq",
	            try_pin_init!(IrqHandler {
	                bar,
	                irq_test_completion <- Completion::new(),
	                irq_dma_completion <- Completion::new(),
	                pdev,
	            }),
	        ),
=09
	        dma: {
	            let mask =3D DmaMask::new::<28>();
=09
	            // SAFETY: There are no concurrent calls to DMA allocation and=
 mapping primitives.
	            unsafe { pdev.dma_set_mask_and_coherent(mask)? };
=09
	            Coherent::zeroed(pdev.as_ref(), GFP_KERNEL)
	        }?,
=09
	        pdev,
	    })
	    .pin_chain(|this| this.selftest())
	}

> +            let bar =3D pdev.iomap_region_sized::<{ regs::END }>(0, c"ru=
st_driver_edu")?;

With the above, we also get rid of the turbofish.
