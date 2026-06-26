Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9443F4128
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475592; cv=none; b=aNSvxx+xxd/9z1N1UFR+Ge74kNKqb71cRdsezcw6cAjFwlaPx71FT30IAAhQ70wFOzW6CPw8SB+B++r0ED/bX2aEfIe9TFAwUTRtWFSVEGwz4vI/BJU4GOvo143A6MiLVfy+/DaLc0qwn5ajLQBHdRYmFutZTBx/kch/YgqBA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475592; c=relaxed/simple;
	bh=MsedowHqXT6VDETNK7YrcXe5U8CgRS7mukA1NyAxsFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VN36d/OG7ynbieyRd9GtmUClV2coqXzcM+lCviuGO8xovVVh3z4mkiJPg1ljaK1pfvMaF7I0gA+7KYWz3wijqB+xaBuH+bHogshtUT3RywqVc2ElL6B2YvlywiRl1SDM2cpVpw7U9ZrglecVCZJhf+bdieSsmaWUKotzcF9x2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHEyf3vT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHEyf3vT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45EE1F00A3A;
	Fri, 26 Jun 2026 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475591;
	bh=kA3E2g3ttE8yH6xTuGwPiUWm4eg6v9MsNrIT9t2Sh9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHEyf3vTqV7IHp+OjWluIJUsYMrl9sK1u94HHyETLIc/au6uPK02ipseKe7J2GFTi
	 4h1pUn0/RLTRODaTWwSZLcKZ+7v2G4I1rYO6kHVPRc1dYvWrT8CVTo9+Od8ri1+C2U
	 Hf+eG+sqPCH9RDFE1Abv0eVfLOC99KXH2cDboDM3xkinzcc+w3tkWbNgJxj4We8B6B
	 lLisp07yginLrGLHySaaefG1p6ZopNGmtJ1eJUobFSB9TbTVTXVBPgZdD2u/pTdabn
	 rd1HuzSNukVhbtUzpv3NC505Li2+MbBi4ZTcIPUkPR1FYW6qfzZD2hLXRFsE4f8tkX
	 KV77aWFgqZ92A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 8/8] rust: page: add `from_raw()`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260626-unique-ref-v19-8-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-8-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:06:29 +0000
Message-Id: <20260626120630.C45EE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `# Safety` documentation for `Page::from_raw` fails to requi=
re that `ptr` points to a valid kernel `struct page`.
--

commit 06f58b70c6165ba4fd1569c291c6f0d211dba674
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add from_raw()

This commit adds a method to Page that allows construction of an instance
from a struct page pointer.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
[ ... ]
> +    /// Create a &Page from a raw struct page pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// ptr must be convertible to a shared reference with a lifetime of=
 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {

[Severity: Medium]
Does the safety documentation for from_raw() need to explicitly require
that ptr points to a valid kernel struct page?

The current safety requirements only demand that ptr is convertible to a
shared reference (non-null, aligned, valid memory). However, the internal
INVARIANT comment explicitly relies on ptr being a valid struct page.

Could a caller technically satisfy the safety requirements with a
stack-allocated or dummy struct page, but break the type invariant
and cause issues when methods like page_to_nid() are called later?

> +        // INVARIANT: By the function safety requirements, ptr refers to=
 a valid struct page, so
> +        // the returned reference upholds the type invariant of Page.
> +        // SAFETY: By function safety requirements, ptr is not null and =
is convertible to a shared
> +        // reference.
> +        unsafe { &*ptr.cast() }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D8
