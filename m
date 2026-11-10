Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282513;
	b=ApkBMjhNgguzJNoldxq7et4o2UWOZWUQZTSv17F7ywdUXBYcN2HTdwV1xjCBOGqcD3p3
	 eOk/tuHF7fFOSRTEJTX1vOc13ETiCWwjpRvgPzzvFfWqXsTsIaYXxqtLgbTPSlSoSaZu2
	 TxTugr2O2/T9gM1tP+0PeltsanqCADshG5VPxRagPiOFOUCwM9LLqyVpmk+5fK+H7b1BY
	 HiDSdMUZGXO/OhPReCMtbCAwt16O7c1LlplxNeUaXxawliLzNjHR8QCjkwJJnnGRoayX7
	 psTNO5xZhzbs6l2epyY5mt6+Z7oJoGZ41At7V6FZ+eFIE4yZLWymzHp9ss31ybcqJQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282513;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PxEd3OjSksbK7+nLb9kkcFQkg3P4HBKGiE8PTgwn2v8=;
	b=ZO8jWxWD/x1F3qErY4yheKr1Ok41rv+tW0h5pYwL/1Go+WLbl6wAYCMhRkFbQqkMeGhV
	 sQQ2LBNEQBLpQbGK2Yh0PWC71ryDLkVxSjh7ZmohpbIT03zDb+k47taTLAaomsD51FKs/
	 ROPIAFNQ3JxrPY25Z4Q2+RNKPwwHOO8qnvn4wWo0i0y2Djj/GF/QLBByCSZ+EHnyDNmJN
	 N7/X/+ASzEq6EszrL72LdUIQCA1a09PN/l5p9yk3U+5T/9pVr706aJWhJFD8kc68ZYOYI
	 gs+Joj5xTsHNotyPQqfNfESi6rj8OVHI2MmOVioV5g5lQSqNYDLc2CDJUBR0sviHgNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btWkBDH4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27A606A326;
	Tue, 10 Nov 2026 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btWkBDH4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74E01F008A6;
	Tue, 10 Nov 2026 03:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282512;
	bh=PxEd3OjSksbK7+nLb9kkcFQkg3P4HBKGiE8PTgwn2v8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=btWkBDH4lyFeV+0ZZl/xjOdA3NcZ0EepKn7YSJAIt7cNvt9C59fP836Ns/ssZrymf
	 +3povOsXK+SGg6hkqJY0tq4LMJwibmuMLhGCtuxR9oIS/2rru+txm/8CO4ZBZOLhec
	 AISl44KtYjEcXec+Bsnc7TKp5qWT/ANFKeO8c/nX7QdImwagNi6eLyk0pm+EU9wrEU
	 Nd0A1JhIvdnXv5QQlaTqoTp10YZSXdZmH+mr7J26E1HmdpcgOhRp6VFhZsTbwL6lvu
	 Np7BjZym669R/KVCWTLfja9vlSKUzSREGYKegrcdC/uiL7OrFssiwDCok7e591LnxD
	 XvQLlsI6trbkw==
Message-ID: <sashiko-outbox-206149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rust: pci: add domain_nr() accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, =?utf-8?b?Qmo=?=
 =?utf-8?b?w7ZybiBSb3kgQmFyb24=?= <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20261110033655.148487-2-jhubbard@nvidia.com>
References: <20261110033655.148487-1-jhubbard@nvidia.com>
 <20261110033655.148487-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:48:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rust: pci: signature mismatch in rust_helper_pci_domain_nr()
  on ppc and s390
--

commit 40ebd2410b826b9813de5dae1bbe6075723a08bc
Author: John Hubbard <jhubbard@nvidia.com>

rust: pci: add domain_nr() accessor

This commit adds a domain_nr() accessor to pci::Device and a corresponding
rust_helper_pci_domain_nr() C helper to retrieve the PCI domain number.

> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index a8540f90b13ce..49f2c089d2369 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -7,6 +7,11 @@ __rust_helper u16 rust_helper_pci_dev_id(struct pci_dev =
*dev)
>  	return PCI_DEVID(dev->bus->number, dev->devfn);
>  }
> =20
> +__rust_helper int rust_helper_pci_domain_nr(struct pci_dev *dev)
> +{
> +	return pci_domain_nr(dev->bus);
> +}
> +
>  __rust_helper resource_size_t
>  rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
>  {
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 769d01d234296..57718e48208d5 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -408,6 +408,20 @@ pub fn dev_id(&self) -> u16 {
>          unsafe { bindings::pci_dev_id(self.as_raw()) }
>      }
> =20
> +    /// Returns the PCI domain number of the bus that this device is on.
> +    #[inline]
> +    pub fn domain_nr(&self) -> u32 {
> +        // SAFETY: By its type invariant `self.as_raw` is always a valid=
 pointer to a
> +        // `struct pci_dev`.
> +        let domain_nr =3D unsafe { bindings::pci_domain_nr(self.as_raw()=
) };

[Severity: Medium]
Does bindings::pci_domain_nr(self.as_raw()) fail to compile on PowerPC and
s390 due to a pointer type mismatch?

In rust/bindings/lib.rs, bindings_generated.rs is included after
pub use super::bindings_helper::*, so any non-inline C function emitted by
bindgen shadows a rust_helper_* wrapper of the same stripped name.  On Powe=
rPC
(arch/powerpc/include/asm/pci.h) and s390 (arch/s390/include/asm/pci.h),
pci_domain_nr() is declared as a non-inline extern function taking
struct pci_bus * rather than a static inline function:

arch/powerpc/include/asm/pci.h:
extern int pci_domain_nr(struct pci_bus *bus);

On those architectures, bindings::pci_domain_nr resolves to the C declarati=
on
expecting *mut bindings::pci_bus instead of the helper's
*mut bindings::pci_dev, breaking the build when CONFIG_RUST and CONFIG_PCI =
are
enabled.  Either rust_helper_pci_domain_nr() should take struct pci_bus *bu=
s to
match the C signature (with domain_nr() passing (*self.as_raw()).bus), or t=
he
helper should use a distinct name that does not collide with C pci_domain_n=
r().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110033655.1484=
87-1-jhubbard@nvidia.com?part=3D1
