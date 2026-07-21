Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1573471257
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662135; cv=none; b=XoCbgT5ghHbsxKre2SyK4Swje6llrTLVB5V0fWOPsjX1zVm7LVNQCpCCCLpG12nhPzbii64fr9bhuBgXYbToC8HGxpbuem9IRRk9mOMWwlwmi71wpE2HQpYI+r/a09/RTfjOJ/GHWaFS01Umw3l944EWhUPCas10k+0+K6QYWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662135; c=relaxed/simple;
	bh=4jJ3jTrtW1xO+i0JbjUSsc5IfsO2P6Uz8IY2VWPs0bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mNPWVb/lgn4/ft0b3T2aPW3qM/jd9bfeghii5x/vk6fr/nxxpaGgDxUGxT4pmeT5yiXJmib3cv0nwck475fp8cvVaBkyWInjwpYA6ZRIemisyY7Vnx0POkW/M6qC0sbK4JIZAHvbGhnjajbaH9S+mfev3lGuFpxqidKGxLHRo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoVETkDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoVETkDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A401F000E9;
	Tue, 21 Jul 2026 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662134;
	bh=bcmXKE9WkfyDfoDSkMz409dA38nzMoRhrKM9S01PicU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RoVETkDtNMKVfq86O205jE+RhHu+4OorI9Ft4skvjD2c0nYqZoYLgVkx5RhL73xGO
	 ZjuwjvnKMVcfnedT8oxEe+oCZl0tGAeXMxxlCA1z/BKoM9RgEj1QXDGr1Abjvy6lpR
	 FJkjKOQ+vwmd21CgRAf/Fqulvr7yrIdiE0rrqE+/+cczuQKJzK8U39Xtao0wIxpxK2
	 HjdhKAIFb7pHz82HIUi3raTTrj2P9LnTLf+al4xB4mMiEliaPK4akUqdsE9o2+Rw4C
	 08v5Vh1tzyID6a10ZCd42eEqS5kTvz5vrDc+PYXF2oK+4MxUut55Brn4IvhymAEGlH
	 yM5u9MARSdOIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm: Add unmap_mapping_file() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721185252.1670958-2-kwilczynski@kernel.org>
References: <20260721185252.1670958-1-kwilczynski@kernel.org>
 <20260721185252.1670958-2-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:28:53 +0000
Message-Id: <20260721192854.22A401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling `unmap_mapping_file()` on a hugetlb file will cause a read=
-to-write deadlock on `i_mmap_rwsem`.
- [Low] The macro `vma_interval_tree_foreach` does not exist in the kernel,=
 causing a build failure.
--

--- Patch [1]: [PATCH 1/2] mm: Add unmap_mapping_file() helper ---
commit e0347448b942ec3ee37afc554cc84ed398530cd2
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

mm: Add unmap_mapping_file() helper

This commit adds a new helper function unmap_mapping_file() to unmap
all VMAs associated with a specific file, regardless of the address
space they are attached to. It iterates over the VMA interval tree under
i_mmap_lock_read() and zaps matching VMAs.

> diff --git a/mm/memory.c b/mm/memory.c
> index a620d425ec95e..ba3e3e35150ea 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c

[ ... ]

> @@ -4555,6 +4555,32 @@ void unmap_mapping_pages(struct address_space *map=
ping, pgoff_t start,
>  }
>  EXPORT_SYMBOL_GPL(unmap_mapping_pages);
> =20
> +/**
> + * unmap_mapping_file() - Unmap all mmaps of an open file.
> + * @file: The file to unmap.
> + *
> + * Unmap every VMA with vm_file set to @file, regardless of the address
> + * space it is attached to.  This also covers files with f_mapping
> + * swapped to a different address space at open time, since such VMAs
> + * cannot be found through the file's own inode mapping.
> + */
> +void unmap_mapping_file(struct file *file)
> +{
> +	struct address_space *mapping =3D file->f_mapping;
> +	struct vm_area_struct *vma;
> +
> +	i_mmap_lock_read(mapping);
> +	if (unlikely(mapping_mapped(mapping))) {
> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, 0, ULONG_MAX) {

[Severity: Low]
Does this compile? I couldn't find the macro vma_interval_tree_foreach()
in the tree. Should this be mapping_rmap_tree_foreach() instead?

> +			if (vma->vm_file !=3D file)
> +				continue;
> +			zap_vma(vma);

[Severity: High]
Can this cause a deadlock on hugetlb VMAs?

If this is called on a hugetlb file, we hold mapping->i_mmap_rwsem for read
via i_mmap_lock_read() from earlier in this function.

When zap_vma() processes a hugetlb VMA, it eventually calls
__hugetlb_zap_begin(), which attempts to acquire the exact same rw_semaphore
for write via i_mmap_lock_write(vma->vm_file->f_mapping).

Since we are already holding it for read, won't this result in an immediate
read-to-write deadlock?

> +		}
> +	}
> +	i_mmap_unlock_read(mapping);
> +}
> +EXPORT_SYMBOL_GPL(unmap_mapping_file);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721185252.1670=
958-1-kwilczynski@kernel.org?part=3D1
