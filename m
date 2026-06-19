Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6D3B440F;
	Fri, 19 Jun 2026 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888708; cv=none; b=mm4TqKw6y8jpGX43nBNkqSlgw40Ppz8plUITyRcFqA7lUP69EIgnKFiysAUUUFAz0AsRPAdSobyl1FZhrUvM1h3qwBvekOl7Kr6czmwzu9V4ne6ot9qIVWybk/W4eLIPRRSNnPRAlOqLw8BxhWP95Ht3+AU9wzPOlnrya/eowV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888708; c=relaxed/simple;
	bh=dd4vjr4q5V/3ir7bIYqMos4eZJczbpuitTuC73J+Wrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t7KcHjJCN0qZNFmy+jf++X75UlApw9NgeyEe7uej6AklK5bNF62EEFDwHkKqEdbl0WV7v7bmv3wP98LQbMPv6HAmcaNILkAFssPAH0Mjw4qtJ8xidlQs6cLGtQ9wjWx771PCE15lTQjO7UZ4kWYsOmWDQRv/GOY1WgBi3N2JdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpSxXNpO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpSxXNpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6DC1F00A3A;
	Fri, 19 Jun 2026 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888706;
	bh=KXhJYEISXaFUaxU0Sq84gxdcK5Fzkm2MNc0inpSqqgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZpSxXNpOGUDsK+WsYS7XwspS+LGvZUBfP60QmSRCrRTG9PxPQxHnyhVZyL6SsbIp1
	 8s+Dnb8V/efNmb/37I5B3UeGw/93pgef+s2FYVd2CKR4CsGmKcKt9xS1oInF4zxfkY
	 ZGSuBtrMhHFCO0mRpeSjJTCnDuYyonCu8iK2DudCedVJ12S9Fu7VydQ9SORZOnWwWc
	 0GWaCLZjREU61asWzgb9JSZxRmTp4KJ/0TqlAn6jZmmwO/2s67yW/65rR67umVUnJv
	 rSHXCrP0kBkWFDMlph20Qvh8GayQ72rOeSmioGjgVaitR5fP16wkDaD4rJCTdgalvG
	 rEteS7C+ESCvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] rust: driver: remove open-coded matching logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260618-id_info-v1-8-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-8-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:05 +0000
Message-Id: <20260619170505.AF6DC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing `#[inline]` annotation on `id_info`.
- [Low] Leftover FFI wrapper `acpi_of_match_device` and its backing C helpe=
rs are unused.
--

commit 8ad64c5f4617fb456cb113763d7136737e7f51e2
Author: Gary Guo <gary@garyguo.net>

rust: driver: remove open-coded matching logic
   =20
This commit replaces the open-coded ACPI and OF matching logic with a single
call to device_get_match_data(), as device ID info now includes pointers=20
instead of indices.

> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 824899d76fed2..a881f5ef99ecf 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
[ ... ]
> @@ -325,117 +324,22 @@ pub trait Adapter {
[ ... ]
> -        #[cfg(CONFIG_ACPI)]
> -        {
> -            use core::ptr;
> -            use device::property::FwNode;
> -
> -            let mut raw_id =3D ptr::null();
> -
> -            let fwnode =3D dev.fwnode().map_or(ptr::null_mut(), FwNode::=
as_raw);
> -
> -            // SAFETY: `fwnode` is a pointer to a valid `fwnode_handle`.=
 A null pointer will be
> -            // passed through the function.
> -            let adev =3D unsafe { bindings::to_acpi_device_node(fwnode) =
};
> -
> -            // SAFETY:
> -            // - `adev` is a valid pointer to `acpi_device` or is null. =
It is guaranteed to be
> -            //   valid as long as `dev` is alive.
> -            // - `table` has static lifetime, hence it's valid for read.
> -            if unsafe { acpi_of_match_device(adev, table.as_ptr(), &raw =
mut raw_id) } {

[Severity: Low]
Since the manual ACPI matching is being removed here, are the FFI wrapper
acpi_of_match_device() and its backing C helpers (such as
rust_helper_acpi_of_match_device() and rust_helper_to_acpi_device_node()
in rust/helpers/acpi.c) now completely unused? Should they be removed
in this patch to avoid leaving dead code behind?

[ ... ]
> -    fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
> -        let id =3D Self::acpi_id_info(dev);
> -        if id.is_some() {
> -            return id;
> -        }
> -
> -        let id =3D Self::of_id_info(dev);
> -        if id.is_some() {
> -            return id;
> -        }
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that the `dev` matched data is of type `S=
elf::IdInfo`.
> +    unsafe fn id_info(dev: &device::Device) -> Option<&'static Self::IdI=
nfo> {
> +        // SAFETY: `dev` is guaranteed to be valid while it's alive, and=
 so is `dev.as_raw()`.
> +        let data =3D unsafe { bindings::device_get_match_data(dev.as_raw=
()) };

[Severity: Low]
This isn't a bug, but according to the Rust subsystem coding guidelines,
functions in abstractions that are small or simply forward to a binding
call should be annotated with #[inline]. Since this function consists of a
single FFI call and a cast, should an #[inline] annotation be added here?

> =20
> -        None
> +        // SAFETY: Per safety requirement, `data` is of type `Self::IdIn=
fo`.
> +        unsafe { data.cast::<Self::IdInfo>().as_ref() }
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D8
