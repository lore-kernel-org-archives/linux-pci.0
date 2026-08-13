Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F11499F17
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641063; cv=none; b=geBxy7hIbODBkNhsW2Mj/Q5uz0+cix+gb52zPDY683ctAKOt+19KcWeiciA3FYt3AJ7yL9pt9CJ5BTpDm4/tYLmxSwwWPzpW+Rae9ocHHBEle1uoqcdGut3JGslO9KxbVTdu0Hji32dhoYEu3Vvi+ezzVsOxlaOzfnfIekhmORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641063; c=relaxed/simple;
	bh=05WNGWTdVvcdm1wxlcOhuHcc7LcSM4TKNjAkAoKDMlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sZVnGMv3+I5o1qKQ5CKA8TgzfxBwyy7SXZXC4X4XQcPxvWud9qgbZ37nUa3GRd8nGLVFMpvbcvx9sH3hcaOAe293Tgpq4SKezDK7INx/+5JNHNl1ZW3xPzD2+gN4pjP4+7oIFrbu7EvIv4iJyYzSLskAiS1W/jWKcIYeK2UOiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm8zrNGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm8zrNGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2406F1F00A3A;
	Thu, 13 Aug 2026 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641062;
	bh=iGWm+pmHiOMD/4TqjY2w5DbLsHEcJX+/xQZlNOSmgU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gm8zrNGLUPaJqQ/SaJheRGt99iwSW3O75Ycy3mZgyoteJRcub7x/KlO2PV84ollTX
	 ++8xOzhAg6YsdZZ7zYJveh+VciDiYHyIO36rHaXwYLUcpaJycdNR8UcFwL01vdqdzw
	 xbKjKebnAalzbxCzgNfzu1xmDI8G0dKCcxhPkunFiRUsS5RJh5SAy1sodCWZTVWfLU
	 wOwmmMu2eMNVjmCuBNIeAcEXu0CF6rHL+u5OwE6I316Vojkwf1feq+NRouXS6010+0
	 Nm69/42rfpnCTgVy20W1ceo6d7lyAXwpdlswhLb8//WtDlMRt6MsWDSzWIEI+Elb+X
	 aoo9BjeUVGo1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] rust: pci: resolve IRQ in index() and embed
 IrqRequest in IrqVector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260813165234.620555-3-dakr@kernel.org>
References: <20260813165234.620555-1-dakr@kernel.org>
 <20260813165234.620555-3-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:11:01 +0000
Message-Id: <20260813171102.2406F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The API design forces a self-referential lifetime bound, making it=
 impossible to safely store both the vector registration and the IRQ handle=
r in a driver struct, naturally leading to Use-After-Free during teardown.

Pre-existing issues:
- [High] Multiple concurrent `IrqVectorRegistration` instances can be creat=
ed, leading to a Use-After-Free of active IRQ vectors on teardown.
--

--- Patch [2]: [PATCH v3 2/5] rust: pci: resolve IRQ in index() and embed I=
rqRequest in IrqVector ---
commit 517346220f40fc029bc56afcf3a1427744cf6f09
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: resolve IRQ in index() and embed IrqRequest in IrqVector

This commit eagerly resolves the IRQ number by moving the pci_irq_vector()
call into IrqVectorRegistration::index(). It embeds the resolved IrqRequest
into IrqVector, making the conversion infallible. This removes the need for
pin_init_scope() in request_irq() and request_threaded_irq().

Link: https://lore.kernel.org/all/20260808031120.363869-3-jhubbard@nvidia.c=
om/

> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index daba86505cd2b..81b74c4c17d98 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -68,32 +68,25 @@ const fn as_raw(self) -> u32 {
[ ... ]
>  pub struct IrqVector<'a> {
> -    dev: &'a Device<Bound>,
> +    request: IrqRequest<'a>,
>      reg: &'a IrqVectorRegistration<'a>,
> -    index: u32,
>  }

[Severity: High]
Does this struct definition force a self-referential lifetime bound that ma=
kes
it impossible to safely store both the vector registration and the IRQ hand=
ler
in a driver struct?

Because IrqVector<'a> borrows IrqVectorRegistration<'a> with the exact same
lifetime 'a as the device, request_irq() requires the resulting
irq::Registration to share this lifetime. A long-lived driver struct would
have to hold both the IrqVectorRegistration and the Registration that
borrows it.

This creates a self-referential struct forbidden by Safe Rust. If a develop=
er
uses unsafe to bypass the restrictions to get it to compile, Rust drops
struct fields in declaration order. If IrqVectorRegistration is declared
before Registration, pci_free_irq_vectors() will execute before free_irq(),
destroying MSI vectors while the IRQ handler is still registered and active
in the system.

[ ... ]
> @@ -200,12 +183,8 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq=
::ThreadedHandler + 'a>(
>          name: &'static CStr,
>          handler: impl PinInit<T, Error> + 'a,
>      ) -> impl PinInit<irq::ThreadedRegistration<'a, T>, Error> + 'a {
> -        pin_init::pin_init_scope(move || {
> -            let request =3D vector.try_into()?;
> -
> -            // SAFETY: Caller guarantees the Registration will not be le=
aked.
> -            Ok(unsafe { irq::ThreadedRegistration::<T>::new(request, fla=
gs, name, handler) })
> -        })
> +        // SAFETY: Caller guarantees the Registration will not be leaked.
> +        unsafe { irq::ThreadedRegistration::<T>::new(vector.into(), flag=
s, name, handler) }
>      }
> =20
>      /// Allocate IRQ vectors for this PCI device.

[Severity: High]
This is a pre-existing issue, but can multiple concurrent
IrqVectorRegistration instances be created, leading to a Use-After-Free of
active IRQ vectors on teardown?

Since Device::alloc_irq_vectors() takes an immutable reference (&self), a
driver can call it multiple times. If a driver allocates MSI vectors and
then falls back to allocating INTx vectors, the C API
(pci_alloc_irq_vectors_affinity) successfully processes the INTx request
without checking if MSI is already enabled. This returns a second
IrqVectorRegistration.

When this second registration goes out of scope and drops, its Drop
implementation calls pci_free_irq_vectors(), which disables and frees the
global MSI state. The first registration's active IRQ handlers are then
left operating on freed hardware state and descriptors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813165234.6205=
55-1-dakr@kernel.org?part=3D2
