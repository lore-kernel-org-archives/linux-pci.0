Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC7376BF2
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031500; cv=none; b=EOTT+cG/lkh6v08QbZd0B9JX4aZn1wE1CMiJNxYKNbrmnAhgSRNwsZH674F8A9vQ+wXKwuywCnBDxO+XhLajAZUBIiUbjQRjCE+9ChwusUw17DT5CiUqGpQWngFo/78jw7zONJobOofz/q/eHwkp4HMsyLgaSi9bsSe69b6TABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031500; c=relaxed/simple;
	bh=ALYqsU6tFWlP2Yycjq8WBeE856z7Nhw5UpPO/QYgc50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJheD3pNDCM2LNmMz8tVhVL+LRLUlERFRJAIaZ6uktwAYYbjGqY+6q85AOrE0hwU/jKRkG90pd+UQAswrA5lMvDzOfNhuI6lLI1i7DcMsX08BKnM+VY+Rm94idcmsvtY2VXNTTxPBmzG6V4LtmG0ozCRSLInpPVwgc1PjiLw1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn18P9RN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn18P9RN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BDC1F000FF;
	Thu, 10 Sep 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031499;
	bh=ojxyxkwDmQtIJDXEqgQXqbCoPgT0ftxJMe7E+KDyKmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kn18P9RNNkw+fJyLAZSfuSCbvwEBtXpPzdBd/RboVNv6S+tdaxrifuuAlSCf9/XrG
	 JjVWW1tUZe3yLJ8CdO0sw+yzMKOTMkd+2j3UcKiGsTfX1hQss/MAOQfgoRre0CaP7w
	 KKk0lEwvi8ZVaL4Yt2zYauxDeIQPbxTgu0spKY7gxkoRyp0x0xoXHqHf7e0iT1KcPd
	 3BXCOfsDt59xwoXaBmF2HnCOduhAN47zjIuDu9/4v7MHMc9N0xan0voBxnT5+Ny7IP
	 yBnK8pXo4CKgXru0UrLon/IawiOUbWM6UeSrdVgpgXJLkP7sWncrR08vVMLma85TqU
	 wviKb9zJTtZVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 8/9] rust: page: add `from_raw()`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org
In-Reply-To: <20260910-unique-ref-v21-8-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-8-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:11:38 +0000
Message-Id: <20260910091138.C6BDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Insufficient `# Safety` requirements for `Page::from_raw` leading =
to unsoundness.
--

commit e6799a35c42d6949e4edb57a0982fc37d7af34f7
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add `from_raw()`

Add a method to `Page` that allows construction of an instance from `struct
page` pointer.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index a2610774c7499..cd394b0656c0c 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -146,6 +146,20 @@ pub fn nid(&self) -> i32 {
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
> +        // INVARIANT: By the function safety requirements, `ptr` refers =
to a valid `struct page`, so
> +        // the returned reference upholds the type invariant of `Page`.

[Severity: High]
Are the safety requirements for Page::from_raw() sufficient?

The documented requirement allows passing a pointer to a valid struct page
that has a zero reference count or is unmanaged (e.g. stack allocated or
reserved).

If safe Rust code later casts this &Page to an ARef<Page> (via .into()
or .clone()), this invokes inc_ref() (get_page()) on an unmanaged or
0-refcount page.

Couldn't this cause memory corruption or trigger a VM_BUG_ON_PAGE? Should
the safety documentation and type invariant require that the page is managed
by the page reference count (i.e. has a non-zero refcount)?

> +        // SAFETY: By function safety requirements, `ptr` is not null an=
d is convertible to a shared
> +        // reference.
> +        unsafe { &*ptr.cast() }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D8
