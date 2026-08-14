Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939947CA8A
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718836; cv=none; b=u5NacsD5eE7LH70WBY1MqhNr6B+HS9boSLMtzGo9zaztvlWV1LPZ8TNzEM9HSvZlOFl0+EKFqrxzpL0dA5fKNd/WzgMLaMqMC6ObB8m7OUid+x2KkJ1DXRSPhJ64u50hydbsDPu3ngXOoHmw00+OcET9k3EP7nq6g/1/dVCF9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718836; c=relaxed/simple;
	bh=LI9fobfgNQZJvwmy5m2sQy8KgyVrzusO3UBtmW0JscE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=frgfhXsfpYbeizL61CcEBLcyOAKhQGPMG5IjLO5eAQzp332mmi266Rci4PbV6HqHpxZRdWNtSpWYjAnECuEnZOZX2wOuHgp8hLwqvUZoQP8RzkSvvCmnt6i/DULM8uqKqbj2ih7Qhc3+81sBROCpgl4Qk7VFxfZ/VlKBAZhM8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWUuGJo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWUuGJo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1A21F000E9;
	Fri, 14 Aug 2026 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718834;
	bh=cDmTqMwYUIGOlzhKiWFdyv4Om63EQKpM332P1/mk3+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HWUuGJo4xVM9mFl/aq3mjDqdO2iOeD5/rCOR7aMIIhSgB4J5yf4v7nq1l/TAIjB8v
	 9l+MkpUZnGD4hUs4lXZA9kl70MU0j3RLL53+9W3yEwYYblx6NJjWkSli3y6COOMxl+
	 ajW3d9VF2PnKInRBAG7plmqYjWR1+ol2Tf62fO08jJu69VEcjcuPvwVfCxnP8GRX3u
	 1rxdgoRv3AspiIk7jRXX1+shO6PIukZrN10VOOOTSDUQfN2y5N6Il4Wn4Wrx2W6OZA
	 ovp8jN1blQrjbyPt7jmrslvL2euoYwoXxLAqsYg3FDpjLAVTZCbM2X4LXMWBMNeZ9H
	 Hc91ET0suJmfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] nfs: track number of pinned pages in nfs_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260814143255.861084-3-praan@google.com>
References: <20260814143255.861084-1-praan@google.com>
 <20260814143255.861084-3-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:47:13 +0000
Message-Id: <20260814144713.DF1A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Latent stack out-of-bounds read by passing a single local stack =
variable to unpin_user_pages() with a dynamically loaded length.
--

--- Patch [2]: [PATCH v6 2/5] nfs: track number of pinned pages in nfs_page=
 ---
commit 1fad80f498aa716421accabc5c2572235b589709
Author: Pranjal Shrivastava <praan@google.com>

nfs: track number of pinned pages in nfs_page

This commit adds wb_nr_pinned to struct nfs_page to track the number
of pinned pages. It updates request creation and cleanup helpers to
ensure that only primary requests perform the final unpinning operation.

> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index a562cfe2a126d..b9ccf2a87e3c9 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c

[ ... ]

> @@ -567,8 +572,8 @@ static void nfs_clear_request(struct nfs_page *req)
> =20
>  	if (folio !=3D NULL) {
>  		if (test_and_clear_bit(PG_PINNED, &req->wb_flags)) {
> -			if (req =3D=3D req->wb_head)
> -				unpin_user_folio(folio, 1);
> +			if (req->wb_nr_pinned > 0)
> +				unpin_user_folio(folio, req->wb_nr_pinned);
>  		} else {
>  			folio_put(folio);
>  		}
> @@ -576,8 +581,8 @@ static void nfs_clear_request(struct nfs_page *req)
>  		clear_bit(PG_FOLIO, &req->wb_flags);
>  	} else if (page !=3D NULL) {
>  		if (test_and_clear_bit(PG_PINNED, &req->wb_flags)) {
> -			if (req =3D=3D req->wb_head)
> -				unpin_user_page(page);
> +			if (req->wb_nr_pinned > 0)
> +				unpin_user_pages(&page, req->wb_nr_pinned);

[Severity: Medium]
Could this lead to an out-of-bounds stack read if wb_nr_pinned is ever
greater than 1?

Looking at nfs_clear_request(), page is declared as a single local pointer
on the stack:

static void nfs_clear_request(struct nfs_page *req)
{
	...
	struct page *page =3D req->wb_page;

If req->wb_nr_pinned exceeds 1, unpin_user_pages() will read adjacent stack
memory to interpret as struct page pointers. While wb_nr_pinned is currently
hardcoded to 1 when a request is created from a page, passing a dynamically
loaded length alongside a pointer to a single local stack variable seems
prone to future regressions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814143255.8610=
84-1-praan@google.com?part=3D2
