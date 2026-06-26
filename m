Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A32C11E6
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782504132; cv=none; b=qZO+8/pW3+QbI1Uui6SmX7X5U6ZSb9YAeTb8gQraDUuDka4iYfmD0LELcNlq1y5Gbk29CQO3eFBmAbfcdM+TkIwtYBom6Axyjl8sAOTozuA852ZSW3pfhSef2TpWXdwzXxG72+24FXtlg3N7gZDlm+bgesL1gyfL5MCzV2YMVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782504132; c=relaxed/simple;
	bh=WDggPDKD/rTyRqc/uvxafQJ5xL5HuQqcXur1eUS5iag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kv5XBLFrQ5wfPOnAcxQ77wsL7Sm+rQkWYc+M6leKO3VIIMu7JkC9tWKrIPjLUNBE7hTVgufcDQ8n+wc+V7KElB00xv7LxsA7t7Wd2dMBrgp247JcBAaTpxgJpZi//l8QSETBrcw1Z8SJMP9XSqHdxkeSjSHxsoAfowcOlLVckm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDV2dqO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDV2dqO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B531F000E9;
	Fri, 26 Jun 2026 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782504131;
	bh=ZUAA0NvnHUZIhWr2uYJNv5jSOLi08ju3c1bWUmIOl+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDV2dqO4DO7AhumdJ2+6ehmsj7MZjoc3N0Zua1VpoqdZ6/UCxijFbvapOXfrakaz4
	 Vx6TNNUESD3Hr/IhesOIKb7Pjgq+u/QO+Qou2ZQGWgJX94nwfZSCnsA1Lpu+T2QrVM
	 GSN2aMsxLY2gh8mPuE8esxPp9EaKpOeXsTAvtazrCQn9+XztKprXYhAcSFhz6POVNH
	 W849ou924c5lgn7Xr+HZcvZtBZXJRdhIPo7amXTzGktg+eWGJ+fyeb5s0fFWT3VXY+
	 dnYCZXAk8PMC+y+/CoG3OzICDCukXuBB54djvEGpsAjQQZegL4nj1os+Bk8SQBueC9
	 4JcH5HyRgeRiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] pci: fix dyn_id add TOCTOU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260626-pci_id_fix-v1-2-a35c803f1b95@garyguo.net>
References: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
 <20260626-pci_id_fix-v1-2-a35c803f1b95@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 20:02:10 +0000
Message-Id: <20260626200211.47B531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] new_id_store unconditionally rejects dynamic IDs that overlap with=
 override_only static IDs (e.g., in vfio-pci), breaking device assignment.
--

commit 65f57bc2128a4f1b44e3036aee55956006935cca
Author: Gary Guo <gary@garyguo.net>
pci: fix dyn_id add TOCTOU

This patch fixes a TOCTOU issue in new_id_store() by moving the duplicate
dynamic ID check inside do_pci_add_dynid() under the lock. It also replaces
the dummy pci_dev allocation and pci_match_device() call in new_id_store()
with a direct call to do_pci_match_id() against the static table.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
[ ... ]
> @@ -215,38 +244,22 @@ static ssize_t new_id_store(struct device_driver *d=
river, const char *buf,
[ ... ]
>  	if (fields !=3D 7) {
> -		struct pci_dev *pdev =3D kzalloc_obj(*pdev);
[ ... ]
> -		if (pci_match_device(pdrv, pdev))
> -			retval =3D -EEXIST;
> -
> -		put_device(&pdev->dev);
> -
> -		if (retval)
> -			return retval;
> +		if (do_pci_match_id(pdrv->id_table, &id))
> +			return -EEXIST;
>  	}

[Severity: High]
Does this change break dynamic ID insertion for drivers that rely on
override_only static IDs (like vfio-pci)?

Previously, pci_match_device() was used, which explicitly checks the
override_only flag:

	for (ids =3D drv->id_table; (found_id =3D do_pci_match_id(ids, &dev_id));
	     ids =3D found_id + 1) {
		if (!found_id->override_only || ret > 0) {
			*id =3D *found_id;
			return true;
		}
	}

By directly calling do_pci_match_id(), which performs purely structural
matching and ignores the override_only flag, it seems like new_id_store()
will now unconditionally reject dynamic IDs for drivers whose static table
contains a catch-all override_only entry, returning -EEXIST instead of
allowing the assignment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-pci_id_fix=
-v1-0-a35c803f1b95@garyguo.net?part=3D2
