Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AC1C860C
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778977743; cv=none; b=M+hwsV2gQOByXAKqSV+nC3RfIaawFTuTdLZKM15E3zgNuE+3BcxtQAWgpmbvH6+Tkc10sDKrwSkPXCZ531B9nFS0dH/aMB/NPqCRBbS7uDj4yblQiXnjCYCRRncBk6Rxwu6IZVT0++dozgbkOgIp5U0+tmT8wzy8a5YitIDDJ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778977743; c=relaxed/simple;
	bh=k0ftk8Tc+E6+PE/gKUBAEMDt7fGdHyBsiLYxmo3uaFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m7IDz9Z++K5UNxHGeFfgsdJQQQD1u1dCl9Ex1KqREVlkn05TWajxFGc/Uh1GGcPicluM3vR4+kkVjQEBL8MW/2//WEHzB83U+boeUfdhRZWy90gx4wNJtrA/kl6An1bFS1mFFW7m8IiCai4kzlvlLUKpN9TutXo0gfqdG/Qxynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tny1m5ob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tny1m5ob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26386C19425;
	Sun, 17 May 2026 00:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778977743;
	bh=k0ftk8Tc+E6+PE/gKUBAEMDt7fGdHyBsiLYxmo3uaFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Tny1m5obBdFV1c7L+MODbIH93kEvNz9zrxfk2VF5tWx0XW+cBE+j9fwUk7Ss/ayxT
	 jNkKINRY8+2gc2G1+/tVMMWjVxtVTpdvx38nPciFU8ujWgTybXkk6mg+B8rcLszRNU
	 ojof4Z/f1pQaHqb3YoWDKeR8VMQ2JicR04/3jqmb8U88MFzaQ2Gjhq+3+OIkjey1IO
	 iDF9zDxfEi0V1CDdXryiSOMUgb5XVkKiw8ODXCmbohtcH2ulUYiSh6z0zqw/spQBiH
	 XSdN5CXiaosvlorYZaPMcvctXlc4bM35t2L3KFe8g5AwNUPYbACXaKM1SDk7G8X/fB
	 LHcGCR6U1P4Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-11-dakr@kernel.org>
References: <20260517000149.3226762-11-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:29:02 +0000
Message-Id: <20260517002903.26386C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The introduction of the `'bound` lifetime parameter allows drivers=
 to capture short-lived references into driver private data, leading to a f=
ormal use-after-free (provenance violation) and Undefined Behavior when acc=
essed later.
- [Low] The signature of `unbind` in `samples/rust/rust_driver_pci.rs` does=
 not match the newly parameterized `pci::Driver` trait, causing a compilati=
on error.
--

commit e20151fd03221a2c3958612a0dabaa50cdd67768
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: make Driver trait lifetime-parameterized

This changes the pci::Driver trait to add a 'bound lifetime to the
associated Data type, allowing bus device private data to capture the
device and driver bound lifetime.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index c06ac3fb2a64f..8060861199d41 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs

[ ... ]

> @@ -130,7 +130,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pc=
i_dev) {
>          // SAFETY: `remove_callback` is only ever called after a success=
ful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
>          // and stored a `Pin<KBox<T::Data>>`.
> -        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() =
};
> +        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };

Does this lead to a formal use-after-free and provenance violation under
Rust's aliasing rules?

In probe_callback, a reference to pdev is created with a lifetime restricted
to the callback's scope, which is stored in Data<'probe>.

Since set_drvdata stores this data by converting it to a raw pointer, the
'probe lifetime formally ends when probe_callback returns.

Between probe and remove, the C subsystem can mutate the pci_dev struct usi=
ng
its parent raw pointer, which invalidates the child reference created during
probe.

When remove_callback calls drvdata_borrow, does this execute an unchecked
transmute from the expired 'probe lifetime to a fresh 'remove lifetime?

When the driver accesses these references, will it use a reference with an
invalidated provenance tag and trigger undefined behavior?

Would it be safer to use ARef<Device>, which stores a raw pointer and creat=
es
fresh references on demand, rather than circumventing the borrow checker wi=
th
synthetic lifetimes?

[ ... ]

> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index f43c6a660b395..30b9311812f3e 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -140,11 +140,14 @@ fn config_space(pdev: &pci::Device<Bound>) {
> =20
>  impl pci::Driver for SampleDriver {
>      type IdInfo =3D TestIndex;
> -    type Data =3D Self;
> +    type Data<'bound> =3D Self;
> =20
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
> -    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinI=
nit<Self, Error> {
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core>,
> +        info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self, Error> + 'bound {
>          pin_init::pin_init_scope(move || {
>              let vendor =3D pdev.vendor_id();
>              dev_dbg!(

Does the unbind method in this file also need to be updated to match the new
pci::Driver trait signature?

Since the trait adds a 'bound lifetime parameter to unbind, failing to upda=
te
the implementation here leaves elided lifetimes that resolve to two separate
anonymous lifetimes.

Will the compiler reject this with a lifetime parameter mismatch error,
breaking the build?

I note this regression is fixed later in the patch series by the commit
"samples: rust: rust_driver_pci: use HRT lifetime for Bar", but does it bre=
ak
git bisectability here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D10
