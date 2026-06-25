Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B63D0C07
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383151; cv=none; b=DVIdf8nbfJS2Yb2oi87hoUsULXxZ9Z1HCKHDOYohglVeK21bkO1EYAqFQYW9eV1y5VLxqaeRMGz40UFNVOzeBqFmWBr6xmyJTkJr8+gmmaudl/6E5U9xTXzQTH3QYUa8IEA4WVV/YbS4X8qOkSwf7u7YtVXyr8sGfzOrAMCh/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383151; c=relaxed/simple;
	bh=JDiVCC1ZF+vqQdm+w+i1b79TsNtCHKhSDsy2HMme44s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y6mL98TgevnaSYml93NzcR3hKKony2+z8MBkfcVs3tnFp1gg1ZvKosCmZWFYd4BBpZzIFsmjc8m07kPWKnKeFZ0cLkDx+/YwzrcbkKH6q7r1NYRLt7buUp628Idr36Dyo04Z7BNLggmgLtz7kRcEzZF8ujM7PdL29AfOIrbLpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZg/I8ka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZg/I8ka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56171F00A3E;
	Thu, 25 Jun 2026 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782383150;
	bh=9h2j/XNhmhlcvuBt4WXuwaPw+4bYk+FEspXvfL6F6EI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZg/I8kaLdP6zxv/K8/a+hLHsBA8EVj9+zUTcCXtnSu5PYGGpjVXMpFds8LWvPgBL
	 XJh3j3W3pr+LAwsCjL8dIpyDbCuLWOHjizeU0pIIImpcD+EPKyhJGYcud9KgMtmhjp
	 ubUkntiYsxWW/6ydMWEPNZdWZeg8HobT+IXg1j3oNwkFT0EARNsAJXKiZzqdXntaCR
	 dy5RixaSwELAsDr8LDdi4TijyO+X+B04ht+L/CS6knHY2f/880XPpaN7t5LnVjEZzD
	 Yow8hsmiugk0/fwKpEk5sC43Wl6gNbTbBUG4mqBZwUXyqqk+nGplVEOW0l/5/oLW3Z
	 O3U+hyUwlxFnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 8/8] rust: page: add `from_raw()`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-unique-ref-v18-8-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-8-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:25:49 +0000
Message-Id: <20260625102549.B56171F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `# Safety` documentation for `Page::from_raw` is missing the=
 precondition that `ptr` must point to a valid `struct page`.
--

commit f6aeebdd661d4004190de07e9d991442f793517a
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add `from_raw()`

This commit adds a from_raw() method to the Page abstraction. It allows
the construction of a shared reference to a Page instance directly from a=20
raw struct page pointer.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 6dc1c2395acaf..c88fda09ead5a 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs

[ ... ]

> @@ -143,6 +143,20 @@ pub fn nid(&self) -> i32 {
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

[Severity: Medium]
Is the safety documentation missing a requirement here?=20

The # Safety section only requires that ptr is convertible to a shared=20
reference. Under Rust's rules, an uninitialized or dummy pointer could=20
technically be converted to a shared reference if properly aligned.

> +        // INVARIANT: By the function safety requirements, `ptr` refers =
to a valid `struct page`, so
> +        // the returned reference upholds the type invariant of `Page`.

The invariant justification inside the function explicitly relies on the=20
caller guaranteeing that ptr refers to a valid struct page. Could the=20
# Safety documentation be updated to explicitly require that ptr points=20
to a valid, initialized struct page so that callers do not inadvertently=20
violate the Page type invariant?

> +        // SAFETY: By function safety requirements, `ptr` is not null an=
d is convertible to a shared
> +        // reference.
> +        unsafe { &*ptr.cast() }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D8
