Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF530FF08
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604880; cv=none; b=sJHyndRshXqXQOF0XYk6NRA+euea/EO4Ib4EcFNfLfMPHRD8AtZi91Rsz6OcMMOq46XQjaYPghynCr7ew6MXgoqeR9riQ8cf3S6lm/oINfrqs7R27duRkyisv+dg8pDbbKjsHVSkhCj4e85nKkHiYdV+PDn6tQAQmiZCn/gfMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604880; c=relaxed/simple;
	bh=xoDobrqWJPWqbV7HwqB/Ke3w45ZfrvMEVLZYCwf9Nzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PLDnyR8561BhuEYM2jEEjic0o0jEVkht7dGr7HRqmmh/QiV4ysZtBsw+R1oRXl+3rbNlFQAXJVktfuhuOJSPc2niMs9pUiQmSR+8nSajBPy4p14XAp2+XqIBfS8e7RyqM+UOLi7zRbvyfP53Ct9QISs2DTms2y0pGobYdFZDf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqSeetLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqSeetLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F81F00893;
	Thu,  4 Jun 2026 20:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604879;
	bh=YBvC4Fda+tKS9v7W4UIElArPjNz9mmn4BPqn1AWLPdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqSeetLXqhpSDfGyVu4AENk1xy9TWLjtgEM/XscT4En1cRlANf6yYQmkpgoS6yzSO
	 /MuEbMyjIwX3fka9SKL03H0uL4SIuwDWw63TvYtbSPchZCX5mmn0Ujm50I3iSSCEO3
	 XOrC16OuB0kwgF8woLO7Mk2g5ENxc2RpR7lPNGMFusNyTJtFl+KUPlENgH5h614wnF
	 1PAw6l+xxjoxRoNskaswaGFf2jBj7ZxPVstlDs4bOeyIDrZTGgFyL+crbn3dGx3krI
	 TfgGJ7ntc2+3Bf9/Az812bxWenUCiFa3PMGAkLZ8+u6LyqAeN5D1FY9cCBtl3dJQl6
	 7qWMxonTDYxYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/10] rust: page: add `from_raw()`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:27:59 +0000
Message-Id: <20260604202759.630F81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `Page::from_raw` method silently bypasses the documented type i=
nvariants of the `Page` struct and lacks an `// INVARIANT:` comment.
--

commit 224010a6541ae8f534f1577d76a1acd3e9bb5d34
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add `from_raw()`

This commit adds a new from_raw() method to the Page struct. It enables the
creation of a shared &Page reference directly from a raw struct page C
pointer.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 844c75e541345..d56ae597f6926 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs

[ ... ]

> @@ -214,6 +214,18 @@ pub fn nid(&self) -> i32 {
>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>      }
> =20
> +    /// Create a `&Page` from a raw `struct page` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be convertible to a shared reference with a lifetime =
of `'a`.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
> +        // SAFETY: By function safety requirements, `ptr` is not null an=
d is convertible to a shared
> +        // reference.
> +        unsafe { &*ptr.cast() }

[Severity: Low]
This isn't a bug, but should this unsafe block include an `// INVARIANT:`
comment to justify the type invariants of the Page struct?

The Page struct has an `# Invariants` documentation section stating that it
has ownership over the page. While that ownership invariant might be an
obsolete leftover, creating a &Page reference here conceptually asserts that
the referenced memory satisfies this type invariant.

Could we add the required `// INVARIANT:` comment or update the outdated
type invariant documentation to clarify this?

> +    }
> +
>      /// Runs a piece of code with this page mapped to an address.
>      ///
>      /// The page is unmapped when this call returns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D10
