Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DA3BB4A
	for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782639427; cv=none; b=oKXuFQsdAIlnhD3L1lA8yCH7pG3V5LMGe1NdvpHXpRwzfjIUM+gJVInqB0nqIpiZ7jW+BHsxXQ8988POHwbRUe7nMnxTgr5CdW9oY72Vo5yu7VSScDyDZ7XYTUIvNWRWSM3KmFzqAkb1UN+t3JEafvF/JLdipJd3LMN3Mb4+rn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782639427; c=relaxed/simple;
	bh=qaVj558o/TKb1KEDtvq4R5TIepAsacKfnq0CUgJUh5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kPgUibBvo/aV3UzKg8a84qDn23yIJM5cSda77JGwer15Sg/xQyBDIAinROXH3JozNH7sIL31+S+AtoUbQ2zCjrVMPNFn2LvX8/E8hTIdPYmqAS6j24m00GmvNYU2GgwjhOz/mfy+5ZR06l6pfzDx7MqlnHoqf/P9piAoo1osOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9MMAlOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9MMAlOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2BB1F000E9;
	Sun, 28 Jun 2026 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782639426;
	bh=4jMbyawPfP607rzTm8dvsPRWuTuL2WG3lfWHHb0MQBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J9MMAlOuYwCjVAByQEGBv1WS5zsa4joqU/haPA5pB/uhFX439DUBgJ2TtBUYwCEvv
	 a0AN6Cy8mUosL15+/gp7I2GQ8ucFKSWhGojWhFo0HGi4RSEOkXpNQnf6cjrO9nVsFe
	 un2WSXGujTLLRrAt2PPO3XWkb+gkrFLOZIdsjbqUXhLQR1b82ooZNKabGGKQdyvBvD
	 6lW5JQDVKN+HeXBgfwl06dIR+yfUaouU2qpPYilh44BDcmAORMzdjDF2vH3MixkRtM
	 Hbd5qNf/w2voBjPGlB3wM2JGVwqAkgGPBWIX5x1IUF1PXG5poovKWrZRY7rej1l4Mw
	 6AM+/W+TtFBAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Trevor Chan" <trev@trevrosa.dev>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260628092853.16550-1-trev@trevrosa.dev>
References: <20260628092853.16550-1-trev@trevrosa.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 09:37:05 +0000
Message-Id: <20260628093705.CB2BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Un-updated AlwaysRefCounted trait implementations cause conditional=
 compilation and rustdoc test errors.
--

commit 5db284043a909f35f9aed5c1467a5f9cf863972d
Author: Trevor Chan <trev@trevrosa.dev>
rust: aref: make `AlwaysRefCounted::inc_ref` an associated function

This commit changes the AlwaysRefCounted::inc_ref function from a method
to an associated function to prevent accidental calls. It updates the
implementors of this trait to reflect this change.

Link: https://github.com/Rust-for-Linux/linux/issues/1177

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index b721b2e00b986..2ae2130d5bb1d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -44,7 +44,10 @@
>  /// alive.)
>  pub unsafe trait AlwaysRefCounted {
>      /// Increments the reference count on the object.
> -    fn inc_ref(&self);
> +    ///
> +    /// This function should not be called accidentally; a type might de=
clare their own `inc_ref`
> +    /// function and it shouldn't be confused with this one.
> +    fn inc_ref(obj: &Self);

[Severity: Low]
Will this change break the build for conditionally compiled modules and
rustdoc tests that still use the old method signature?

When compiling with CONFIG_RUST_DRM_GPUVM, CONFIG_PM_OPP, or
CONFIG_RUST_PWM_ABSTRACTIONS enabled, it appears this will result in
compiler error E0185 because the following implementations were not updated:

rust/kernel/drm/gpuvm/mod.rs:
unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVm<T> {
    fn inc_ref(&self) {

rust/kernel/drm/gpuvm/vm_bo.rs:
unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {
    fn inc_ref(&self) {

rust/kernel/opp.rs:
unsafe impl AlwaysRefCounted for OPP {
    #[inline]
    fn inc_ref(&self) {

rust/kernel/pwm.rs:
unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
    #[inline]
    fn inc_ref(&self) {

Additionally, a rustdoc test in rust/kernel/sync/aref.rs for ARef::into_raw
still implements it using the old signature:

    /// unsafe impl AlwaysRefCounted for Empty {
    ///     fn inc_ref(&self) {}

Should these implementations be updated to use fn inc_ref(obj: &Self) to
match the new trait definition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628092853.1655=
0-1-trev@trevrosa.dev?part=3D1
