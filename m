Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604534DCE3
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157302; cv=none; b=YMz3JoOEL0iOHAJx11MmftGzwcXE9vvoGWRmI5ZswGHShz/cBCCXShtUMNVQQduoD2TX+DvhX2DjpUz4InhuXOSbsODj76olId88ELB1F+sSoepQR69aSS1KI+BXoxEciGn6nng7XoDUEY/aAE3V2/0vCwlblDT9oaSXzVrjvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157302; c=relaxed/simple;
	bh=6qBjBrP80cbhlB7V8dUd/vDLrxl3DjQEPsB23bkWvj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jxjI17tMAWv0Duq9pli9pZeQfb2KpGCVPhCh3lHiww4CRrn1RTZRwul+X/rIa/aiTEX6EJ6jfoTwCmOiLi83+dn/5042yi1M1l2ASTSjInxUivtRd+0Y86YVGkU/XS/2Blt98rm8U8v00CVT+V67B373xb+uD6a/syN7bI6Rw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmJwmw0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmJwmw0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23841F000E9;
	Mon, 31 Aug 2026 06:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788157300;
	bh=DEeOS0IMt5cNO2a1SWVs2nmCuOH6kgLYflESy9ZCxYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DmJwmw0xcZP2VP0wHjdmDjI4enCYYlcthQj0IeycSLYzOh6HydtzxPEDoeKj46BR+
	 bwAdjGkS7di8/I2m8bpKRDJtf+eCnwQ+Uridc0G4SxNbyjGd/Qh+I6nPnzHpsQfTk3
	 egQ4I2fjDiWWkFJQiJbUFVK+pNir3/wqa+ioUy/4QPPKiWVOtFKuJjj3j14pQiHsQZ
	 qfz1pYdrtvyMTqrVvOn8F6SgGqWn++yJIVdIX6dMM5sawOaf/GgeIdX21uNMSF7K7R
	 L14E2dSMsks8gF9B0DuJxxUbXdcIWknuGCBuMZKZxawhl3Sm0gqdz2V5oKvYjf19JZ
	 kue7TOsdls8Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: pci: Reject IRQ vector indices that do not fit in
 u32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sophon Z" <aiqubits@hotmail.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260831-fix-pci-irq-vector-index-truncation-v1-1-d63217d99b67@hotmail.com>
References: <20260831-fix-pci-irq-vector-index-truncation-v1-1-d63217d99b67@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:21:40 +0000
Message-Id: <20260831062140.B23841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check in `IrqVectorRegistration::index()` allows ou=
t-of-bounds indices to trigger a C-side kernel warning and potential kernel=
 panic.
- [High] `Device::alloc_irq_vectors` fails to enforce `min_vecs >=3D 1`, le=
ading to a resource leak and broken device state when `0` is passed.
--

commit 4de7f8d3881b1c14eada957c4affb1c9815e3096
Author: Sophon Z <aiqubits@hotmail.com>

rust: pci: Reject IRQ vector indices that do not fit in u32

IrqVectorRegistration::index() accepts a usize, but pci_irq_vector()
takes an unsigned int. On 64-bit architectures, casting an index
larger than u32::MAX wraps it before the PCI core can validate it.
In particular, u32::MAX + 1 becomes zero and can resolve to the first
allocated vector.

Use a checked conversion and return EINVAL when the index cannot be
represented by the C API.

> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index 6741046ec1c09..1bf91973cb1f4 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -151,8 +151,10 @@ pub fn irq_type(&self) -> IrqType {
>      /// [`Self::len()`].
>      #[inline]
>      pub fn index(&self, index: usize) -> Result<IrqVector<'_>> {
> +        let index =3D u32::try_from(index).map_err(|_| EINVAL)?;

[Severity: High]
This is a pre-existing issue, but does this function also need to verify th=
at
the index is within self.len()?

If IrqVectorRegistration::index() receives an out-of-bounds index that fits
in u32, the bounds check is missed, and it is passed directly to the C PCI
core:

rust/kernel/pci/irq.rs:IrqVectorRegistration::index() {
    ...
    let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(), index)=
 };
    ...
}

This can allow large indices to reach msi_domain_get_virq() and trigger a
WARN_ON_ONCE in the C PCI core, which on systems with panic_on_warn=3D1 will
result in a kernel panic and a complete denial of service.

> +
>          // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct p=
ci_dev`.
> -        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index as u32) };
> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index) };
>          if irq < 0 {
>              return Err(Error::from_errno(irq));
>          }

While reviewing this code, I also noticed another pre-existing issue in the
same file:

rust/kernel/pci/irq.rs:Device::alloc_irq_vectors() {
    ...
    let ret =3D unsafe {
        bindings::pci_alloc_irq_vectors(self.as_raw(), min_vecs, max_vecs, =
irq_types.as_raw())
    };
    to_result(ret)?;

    let len =3D NonZero::new(ret as usize).ok_or(EINVAL)?;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but should alloc_irq_vectors()
enforce min_vecs >=3D 1 before calling the C API?

If alloc_irq_vectors() is called with min_vecs =3D 0, the C PCI core
initializes MSI/MSI-X capabilities for 0 vectors and returns 0. The Rust
wrapper treats this 0 return value as an error (NonZero::new fails) and bai=
ls
out without invoking pci_free_irq_vectors().

Because no IrqVectorRegistration is constructed, its Drop handler is
bypassed, permanently leaking the mapped MSI-X table and leaving the PCI
device in a broken state where subsequent allocation attempts will fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-fix-pci-ir=
q-vector-index-truncation-v1-1-d63217d99b67@hotmail.com?part=3D1
