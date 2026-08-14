Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285F3AA518
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718820; cv=none; b=s2cU148P6/7+HNwzjPhYiyVJx3pvO15+dd5GhsMMH+O+wIgA8WTwayvuwbxPAVkX2YkWkL/fOHHZScFxD2M/hj3bNSw3QVlbDwN5ksDC3DCliCDoEBkSBRxMRIkYAbr/khQXmMdny7qqUDmZF91x4SGPsAn4R2KWECwOzik5vDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718820; c=relaxed/simple;
	bh=K54Jj5vjPjWJVdql1NfsbgER1tcfUojV4xA5E9M2Mh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZCyIE1LtU4ha9kPwGE2s96FgBG4RDkdlYAT0d3Znuxcbcy+neihsvyCd2E4BBHuWiDU/DTI49LndZ2RvMNAq+8TI89hQtGl+gkPu4fDBXP+Xnn4ElQrOti0VzwN7P0NG5jxg1G8hjzQJpG38s+YarI9ZFW3SI0o2u+c4gka3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFg1nfjM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFg1nfjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129DB1F000E9;
	Fri, 14 Aug 2026 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718818;
	bh=NQckgsgLQlCenq42W6pbLa4+VdfPsZtYcAAll5o1OGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JFg1nfjM7/M5tAvX7M0kEd+WWX0QqEMh6TnVOyNmNmmYwwdgP2NbxkPE78vjjSLFj
	 g0Mn92k2iVe1hora8EF3MVCSuuZ7ZB2uhdYwZMtv4W9C8aqPylX0XgiDr+sha7Ol04
	 64a2KPrwtqB5n+SavEuArQqSUzOI8TnsGL2y5bPCcAUvxB0HemhR5PqJGwDQHLqG9t
	 WQxk5ko8mSMGmzZ3JeY5Nraz8rRf+YWVSBjtixI8xAkVn2OceDSma1QkkDpp2OPJGf
	 2QUdCcSPrbRge2g5U7CCJe/p6clKCGwzxDQL+KchDYee0ffGd7hArDVHMJFEE1E2lj
	 9Jk+bpCgdKafA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] nfs: make nfs_page pin-aware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>, linux-pci@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>
In-Reply-To: <20260814143255.861084-2-praan@google.com>
References: <20260814143255.861084-1-praan@google.com>
 <20260814143255.861084-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:46:57 +0000
Message-Id: <20260814144658.129DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Subrequests incorrectly drop GUP pins multiple times because `re=
q =3D=3D req->wb_head` evaluates to true for all requests during teardown, =
causing pin count underflow and Use-After-Free.
- [Medium] Hardcoded unpin count of 1 in `unpin_user_folio()` leaks GUP pin=
s for large folios spanning multiple pages.
--

--- Patch [1]: [PATCH v6 1/5] nfs: make nfs_page pin-aware ---
commit 21b0f62730c29dca3085e0b77d441b62786919e8
Author: Pranjal Shrivastava <praan@google.com>

nfs: make nfs_page pin-aware

Modernizing the NFS Direct I/O path to use iov_iter_extract_pages()
introduces page pinning (GUP) instead of standard page referencing.
To handle this correctly, nfs_page must track whether it holds a
pin or a standard reference.

> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 7dd478ffc2fab..a562cfe2a126d 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
[ ... ]
> @@ -552,11 +566,21 @@ static void nfs_clear_request(struct nfs_page *req)
>  	struct nfs_open_context *ctx;
> =20
>  	if (folio !=3D NULL) {
> -		folio_put(folio);
> +		if (test_and_clear_bit(PG_PINNED, &req->wb_flags)) {
> +			if (req =3D=3D req->wb_head)
> +				unpin_user_folio(folio, 1);

[Severity: Medium]
Will this leak GUP pins for large folios spanning multiple pages?

If a caller uses nfs_page_create_from_folio() with pinned=3Dtrue for a folio
spanning multiple pages, hardcoding 1 releases only one pin and leaks the r=
est.

Also, does this check for the head request evaluate to true for all
subrequests?

During teardown, nfs_page_group_destroy() breaks the page group linkage by
setting tmp->wb_head =3D tmp before freeing the request:

nfs_page_group_destroy()
    tmp->wb_head =3D tmp;
    nfs_free_request(tmp);

Because of this, when nfs_clear_request() is called, req =3D=3D req->wb_hea=
d will
evaluate to true for all subrequests, causing each subrequest to unconditio=
nally
invoke unpin_user_folio() and potentially resulting in a pin count underflow
and Use-After-Free.

> +		} else {
> +			folio_put(folio);
> +		}
>  		req->wb_folio =3D NULL;
>  		clear_bit(PG_FOLIO, &req->wb_flags);
>  	} else if (page !=3D NULL) {
> -		put_page(page);
> +		if (test_and_clear_bit(PG_PINNED, &req->wb_flags)) {
> +			if (req =3D=3D req->wb_head)
> +				unpin_user_page(page);

[Severity: Medium]
Similar to the issue above, because nfs_page_group_destroy() severs the
linkage and sets tmp->wb_head =3D tmp, will this unconditionally call
unpin_user_page() for all subrequests and cause a pin count underflow?

> +		} else {
> +			put_page(page);
> +		}
>  		req->wb_page =3D NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814143255.8610=
84-1-praan@google.com?part=3D1
