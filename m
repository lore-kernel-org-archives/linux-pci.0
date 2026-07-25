Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195C37A839
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014574; cv=none; b=bwVJCQIfa2Fq+HATS4W6MOcAGQ2fnv0uXg1fwSp20OzP0GTwy4VwlfNeCXYb0DFZIcUlSdAOh+YzUMWbVGa2n/9iQ6eHzCjnIvEdlGWzBF8edEpKPk2Qx053QwK2zXSGG5yV6AgBnbvHeK/Uxuj+1tLHNsW+nAvBA9mqgemQL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014574; c=relaxed/simple;
	bh=8DRUuu54TY2LGwCqizPVcK+3dtV86qrpI7Dl/w+5yNM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rxJVpYiGKT6vj8gIPK3l05JWJxvgJ6a3zApkO7mMfo+xhXpxJUbiBT1qBUSfPB6cRtyXauFOT4Z9D0AWVPp65vJMnDSTNbIItqLFwkEY9MGAgqSgD1vbxZS7ghk5MbUGnxEttbFtyhEA7V3RwdRPs171TByGc+P78pBaZ7HibXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br84+rtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br84+rtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A291F000E9;
	Sat, 25 Jul 2026 21:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785014571;
	bh=Ew43s6CCag9dgFrTdw+haPSRnoI+siUJxW9KU9ydcaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=br84+rtPmB9tt625bS4dQ7YPmKHTwq8pwv/8RiPqMjAwVm1lC3wy2igc2hZP/PVTr
	 wsL46IHBx+4f+jlQieoI+qoM2rWzOdTIs8F2ssu/nOeMBaONqn17IlfTlNuRpDrqKO
	 aWwsPukc1+WrOSajTf0mlRxKs1n/XpBdYM0cWNVylgIlg1SY7rm/3rFhtWCiIPc4F8
	 PXSNrSzMy0jDHkG/XN7BV6rraw+kHdgCDCHwhqxdv9wPQ6d6omCTBmHoUaG28k68IR
	 gcf7/JID1t//G24GCORBL0dYDJAzF8E9z6MOeGaBLy4DI4xVnVWKhDasER9lmlebnQ
	 ha2uzpvS08H6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] kernfs: Unmap mmaps of removed files via
 file->f_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260725210549.3716546-3-kwilczynski@kernel.org>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
 <20260725210549.3716546-3-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:22:51 +0000
Message-Id: <20260725212251.A4A291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A TOCTOU race condition between mmap() and kernfs_drain_open_files=
() allows a newly created VMA to escape being zapped, leaving stale physica=
l mappings accessible to user space after device removal.
--

--- Patch [2]: [PATCH v2 2/3] kernfs: Unmap mmaps of removed files via file=
->f_mapping ---
commit cbf76235c8b2fab1c84f41b35091ff343e6741ef
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

kernfs: Unmap mmaps of removed files via file->f_mapping

This commit replaces unmap_mapping_range() with unmap_mapping_file()
in kernfs_drain_open_files(). This ensures that only VMAs of the
removed node are zapped, preserving unrelated mappings for PCI resource
and legacy sysfs files that swap their f_mapping.

> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 8e0e90c933720..eb04439e9c3ec 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -815,10 +815,8 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  	}
> =20
>  	list_for_each_entry(of, &on->files, list) {
> -		struct inode *inode =3D file_inode(of->file);
> -
>  		if (of->mmapped) {
> -			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
> +			unmap_mapping_file(of->file);

[Severity: High]
This isn't a bug introduced by this patch, but can this race with the VMA
being linked into the interval tree?

If kernfs_fop_mmap() sets of->mmapped =3D true and drops the active referen=
ce,
it can wake up a concurrent kernfs_remove() thread waiting for active
references to drain.=20

If that thread calls kernfs_drain_open_files() and sees of->mmapped =3D=3D =
true,
it will call unmap_mapping_file() here.

However, since kernfs_fop_mmap() hasn't yet returned to the core mm code
where vma_link_file() is called (like in __mmap_new_vma()), the VMA
might not be in the interval tree yet. Consequently, unmap_mapping_file()
could find nothing to zap, and the mmap syscall subsequently inserts the VM=
A,
leaving userspace with an active physical mapping to a removed device.

Could the synchronization between the mmap path and kernfs_drain_open_files=
()
be missing a mechanism to wait for the VMA to be fully linked?

>  			of->mmapped =3D false;
>  			on->nr_mmapped--;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210549.3716=
546-1-kwilczynski@kernel.org?part=3D2
