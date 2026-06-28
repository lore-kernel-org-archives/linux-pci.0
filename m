Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B5382298
	for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782641652; cv=none; b=rC/bTMSzyy9HoEt0kd3qOj7ovSFsJd3lVxQdeNKWagZV5OtiFgE8TtlFnHTy47Dyz+aPf7cLvVmSXwdXJUcP7A6cxRU1CLRJArIbjSilQ+KoaYrEb/M2Snyb93gMTWGGgD9OpIiOiBH/608vTMST4XlQAI5xO9WMC/85Tw72M0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782641652; c=relaxed/simple;
	bh=v88tOvvOTMxAL1SulwTQAQq+K0vbTzVzP8Rx4yCVkwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XkayYiKTGgG8gaGM/J5BcYSsMbmHrceWpwWsfMSf5W5HW5BZkkXw5J3w1mSPjrxY8lLiLSkjnkgNSTL+i9FrH68GVbDthiMLfkGAjq+2J2gCwNTeNt9Bsddo8Xqw7z0qRxg2M2u5imDxOy9aLtBs8VIwVeqEITDZaAQofjIfAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0WIkhQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0WIkhQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29EC1F000E9;
	Sun, 28 Jun 2026 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782641648;
	bh=Uq2uDvPhJDtgq3rP59hSeLR14Qtx2QYFNGSyZ8FixPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0WIkhQibFgJolyOH++upFHMDLtx0UCSTHyePZR3d/GCItPHWTE40DbIiOdbee959
	 yfRjxHGHz15J9c21LZkI2irNveY8C3hDWCE/SfBysubb3XEpgczqCM92gS7gWVwK9l
	 yleQ9osPY+H7L0nO59ANha43BpGX2hucv7cC/NQkXjM2lVbotzrMBjkDhNpmOglVjm
	 n3ox1gNrT74E3c3/ve14rBJkePSBsdrnF/CDGzWOzMTxlvBI6rGfZpCyIUZRyMsNMR
	 pcY6yNLDmGsH9CNhVRTEFcXBwSzqVd0gdTraW+FyQMPhyCY6gliotjEp5NxnZcM0lB
	 LqqFYoUg7t8Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Trevor Chan" <trev@trevrosa.dev>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260628100731.64885-1-trev@trevrosa.dev>
References: <20260628100731.64885-1-trev@trevrosa.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 10:14:07 +0000
Message-Id: <20260628101407.D29EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `I2cAdapter::inc_ref` calls `i2c_get_adapter()` which sleeps and c=
an fail, leading to sleep-in-atomic panics and Use-After-Free.
--

commit dcdb7e5879ef4f6a18646d7f509abd59ae6f10db
Author: Trevor Chan <trev@trevrosa.dev>

rust: aref: make AlwaysRefCounted::inc_ref an associated function

This commit changes the AlwaysRefCounted::inc_ref trait method to be an
associated function rather than taking a self reference. This prevents
accidental calls to inc_ref on types that implement it, and updates all
implementors across various kernel subsystems to match the new signature.

Link: https://github.com/Rust-for-Linux/linux/issues/1177

[ ... ]

> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 624b971ca8b0b..1a9882a64c4b8 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -425,9 +425,9 @@ pub fn get(index: i32) -> Result<ARef<Self>> {
> =20
>  // SAFETY: Instances of `I2cAdapter` are always reference-counted.
>  unsafe impl AlwaysRefCounted for I2cAdapter {
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
> -        unsafe { bindings::i2c_get_adapter(self.index()) };
> +        unsafe { bindings::i2c_get_adapter(obj.index()) };

[Severity: High]
This isn't a bug introduced by this patch, but is it safe for
I2cAdapter::inc_ref to call i2c_get_adapter here?

Since i2c_get_adapter acquires a mutex (core_lock), won't cloning an
ARef<I2cAdapter> in an atomic context (such as under a spinlock) trigger
a sleep-in-atomic panic?

Additionally, does this code handle the case where i2c_get_adapter fails?
If the adapter has been unregistered (e.g., the device is hot-unplugged or
the driver unbound) while the ARef is still held, the IDR lookup fails and
i2c_get_adapter returns NULL.

Because this return value is ignored in inc_ref, the underlying device
and module refcounts wouldn't actually be incremented. When the cloned ARef
is subsequently dropped, dec_ref will unconditionally decrement the
refcounts, which could underflow and cause a use-after-free while other
ARef instances still point to it.

>      }
> =20
>      unsafe fn dec_ref(obj: NonNull<Self>) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628100731.6488=
5-1-trev@trevrosa.dev?part=3D1
