Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795868798;
	b=d7uAb5fEH68aew4mSjidxfkU44jHoiVA5e4SRaQFK7F6jS7xAfdX9EhYaIR/YYMhE1e4
	 qu4EHRtU+ilcUCLLFEPMS+Eor1F4Ww4oTsCMnFDrpRoAS+T4mX2fpNxUfWlKyLHmnSO89
	 m0MZeG+CpDai+ttZpsxDByNsjlxf7XplK4y5NFj+5Kh920mLqahAVZY9AsNV/PDEKFZs+
	 cu1HumtA6gHcSek+HgUHt6PADMklroDYhAFduWTRruBHif9QbgRN1JdhZSBLH4UQuRjrN
	 woDeHzP5YoEym/RRnA680/jxjAQNASlPQF+PHFbWhXYbUU8EYH/XtgXDMmTIiUMO51Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795868798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P07NYggygzE3fwpHc2SRwsiITr8AGaV5Klw6Eg5mBoo=;
	b=AYDSgHCnJkiPg6C5Xj+Lu5AYtXkgMgNUqIgVyoccKkt82MCgFFeKYdy2ZKuUcqUiq0HO
	 vE2oBXylsEIEw4PDyFHJ3ppUJvj8Rc575a2loPbfncR1nVHvLqoLSfaLE+USKMhuwpuLc
	 ZKppZdJCY7/huP4aySrOPwSMxbV6uIMMc8NntrkrtLD6AuN/Bb2B4uQ87gPTFqPw+spSu
	 evBxA4PA6VyliMG04vFNaU0kvGRrzn8lx2XJbZ1EfFPM3ulNxuTa+viQGZ0qSOJEoqjmE
	 hGeFyEbyInCP7kQBDs99G8gprdqJLuMING91gDsg4TQjj4OixHVEUHbxzSDW67nj0Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2jtjq41;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7D606A31C
	for <linux-pci@vger.kernel.org>; Sat, 28 Nov 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2jtjq41
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ACA1F00923;
	Sat, 28 Nov 2026 12:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795868797;
	bh=P07NYggygzE3fwpHc2SRwsiITr8AGaV5Klw6Eg5mBoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2jtjq41oBH/GEDc66gvlfEwE9LwsffXvoOfW966WeVWxRWdgOds9Pq7TkjilGPNG
	 2dsXcUqE5fDgrApZ9cr9mv6045Y30o5g3HKoJbgcF1x1xQwIQGrXpg8RAr2pwQvUhk
	 B9dvOg4L7gp8s+ETmLsPF4E5gpD7i2b7nD1i92qycUxrSJUEbNQKhxi6zag8TcLOSi
	 oD15b1REK3PudqwJjmh6CzFSKlMHCSQmsrgawEel7R1sTOaNcaSRF57Y/RwjIgysNG
	 OwPb7ZxyEY7dsx+XGPnq1gu5vEfGPzOWdOeXep+0DaJ7XtItrGrfhHcEV55EW5LxnI
	 FLks1/5v8vc9g==
Message-ID: <sashiko-outbox-238690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] kho: don't reference subtree blobs as FDTs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratyush Yadav" <pratyush@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "David Matlack" <dmatlack@google.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
In-Reply-To: <20261127122536.3708770-7-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
 <20261127122536.3708770-7-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 12:26:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kho: stale sub_fdts debugfs path in kho_add_subtree() kernel-doc
  and kho.rst
--

commit 4fb09c13a16f68cfb66608af6d8973645ca988e6
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: don't reference subtree blobs as FDTs

This commit renames KHO debugfs subtree tracking structures, fields, and
the debugfs directory from "sub_fdts" / "fdt" to "sub_blobs" / "blob".

> diff --git a/kernel/liveupdate/kho_debugfs.c b/kernel/liveupdate/kho_debu=
gfs.c
> index 8d04368c19789..1580e1a27566e 100644
> --- a/kernel/liveupdate/kho_debugfs.c
> +++ b/kernel/liveupdate/kho_debugfs.c

[ ... ]

> @@ -131,16 +131,16 @@ __init void kho_in_debugfs_init(struct kho_debugfs =
*dbg, const void *fdt)
> =20
>  __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
>  {
> -	struct dentry *dir, *f, *sub_fdt_dir;
> +	struct dentry *dir, *f, *sub_blob_dir;
> =20
> -	INIT_LIST_HEAD(&dbg->fdt_list);
> +	INIT_LIST_HEAD(&dbg->blob_list);
> =20
>  	dir =3D debugfs_create_dir("out", debugfs_root);
>  	if (IS_ERR(dir))
>  		return -ENOMEM;
> =20
> -	sub_fdt_dir =3D debugfs_create_dir("sub_fdts", dir);
> -	if (IS_ERR(sub_fdt_dir))
> +	sub_blob_dir =3D debugfs_create_dir("sub_blobs", dir);
> +	if (IS_ERR(sub_blob_dir))
>  		goto err_rmdir;

[Severity: Low]
Should the kernel-doc comment for kho_add_subtree() in
kernel/liveupdate/kho_core.c and the debugfs path in
Documentation/admin-guide/mm/kho.rst also be updated from
/sys/kernel/debug/kho/out/sub_fdts/ to
/sys/kernel/debug/kho/out/sub_blobs/?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127122536.3708=
770-1-pratyush@kernel.org?part=3D6
