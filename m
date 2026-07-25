Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAE2E7365
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785015322; cv=none; b=q0/VfdN8/Q2mnxzfdl/EitzVsC7TzvrtiTltEMNs7XFHZdTduvbH3YTaDtjaRPGcrIf91A8HtwX40hqdlF9p6E2+v/c6urEJCaxUOsCaIeD27D6zahsRFGs4o34Wj+l5fkeL/pk+QQjpHJsB0ZO4KqvAIIKEy1Vk6vzmDUZ0z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785015322; c=relaxed/simple;
	bh=3TmID8lxkttDQhmj1WeTZMEFff5Ccujyeb3WiqY6dpI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cUJdjQb4HJiK8OAg2tPIWqPBdaWbcUFJzJejz/oxfhSnUrUC3JGEEzURtzFRwqVmDDN6RsFjL3Baiu96KTGSWfYvNuVTKX0wLGSZ/ABsODyJ44Pl38JsjunR2fQukr/gIamHv43QomyzoxUSGe8tyTo55qJO2j+GGUnDsx/sVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4X6Mkkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4X6Mkkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95581F000E9;
	Sat, 25 Jul 2026 21:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785015321;
	bh=DEEU5o80NIWDc7+p1rD76qVitBoj7c7tR0B1z2TyyPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W4X6MkkmJYCWvOvXRIymTB3djRAt3gR7I1/u6oQF0DA/R99pDNtjizJ0ZNDb+aQ58
	 wEw5qIbU0n076BvQJcXeWpVYNHnJlGghjjFYyPLlihO6c3MWAqE4QPUzn0MaQ7/r13
	 B1FqYi1OkfE1j7btLNI5QOr/eEpHV5u5UwCCsynZE9CJeNpWCOWJ0nBsaGx1WhVIrv
	 1ZtuRpCchUyTXFjuTydFo0O+0Uje5F4Cc73b/Nq5r6Sd9LX7hBXuKtKp7g9ieYnXy3
	 hTbFE6hkPZI6K0a/fw7lDJD6MYZN6hWffUm6Nqd9d/nc4jW6wf70UJGoW4zrbyiX4Q
	 DCbpj3vF8hzBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] mm: Add unmap_mapping_file() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260725210549.3716546-2-kwilczynski@kernel.org>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
 <20260725210549.3716546-2-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:35:20 +0000
Message-Id: <20260725213520.C95581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] unmap_mapping_file() will inadvertently zap VMAs of all anonymous =
files system-wide if called on a file utilizing the singleton anonymous ino=
de.
- [Low] The macro `vma_interval_tree_foreach` is not defined anywhere in th=
e kernel, causing a fatal compilation error.
--

--- Patch [1]: [PATCH v2 1/3] mm: Add unmap_mapping_file() helper ---
commit 4d2549a11df2bbda156f67d12490793734715126
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
Subject: mm: Add unmap_mapping_file() helper

This commit introduces the unmap_mapping_file() helper to unmap the folios
of a specific file from all processes that have mapped them. It is designed
to handle both standard inode mappings and swapped mappings by checking the
vm_file pointer when iterating the VMA interval tree.

[ ... ]

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4555,6 +4555,54 @@ void unmap_mapping_pages(struct address_space *map=
ping, pgoff_t start,
>  }
>  EXPORT_SYMBOL_GPL(unmap_mapping_pages);
> =20
> +static inline bool should_zap_file_vma(struct file *file,
> +				       struct vm_area_struct *vma)
> +{
> +	/* On the file's own inode mapping, zap every VMA */
> +	if (file->f_mapping =3D=3D file_inode(file)->i_mapping)
> +		return true;

[Severity: High]
Could this inadvertently zap VMAs of all anonymous files system-wide if cal=
led
on a file utilizing the singleton anonymous inode? For any anonymous file
(such as perf_event or bpf-map), file->f_mapping and
file_inode(file)->i_mapping both point to the singleton
anon_inode_inode->i_mapping. Consequently, should_zap_file_vma() would
unconditionally return true, causing unmap_mapping_file() to zap every VMA
in the global anon_inode_inode->i_mapping interval tree.

> +
> +	/* A swapped mapping also holds VMAs of unrelated files, zap only ours =
*/
> +	return vma->vm_file =3D=3D file;
> +}
> +
> +/**
> + * unmap_mapping_file() - Unmap folios from all mmaps of a file.
> + * @file: The file to unmap.
> + *
> + * Unmap the folios of @file from every process that has them mapped.
> + *
> + * If f_mapping is the file's own inode mapping, they are unmapped
> + * from every VMA on that mapping, as unmap_mapping_range() would do.
> + *
> + * However, if f_mapping was swapped to a different address space at
> + * open time, only the VMAs with vm_file set to @file are considered,
> + * since that address space also holds mappings of unrelated files.
> + *
> + * Must not be used on HugeTLB files.  HugeTLB VMAs are skipped with
> + * a warning.
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
Is this macro invocation correct? The vma_interval_tree_foreach macro
does not appear to be defined anywhere in the kernel, which would cause a
fatal compilation error in mm/memory.c. The file-backed VMA interval tree
iterators are typically exposed via the mapping_rmap_tree_foreach macro
instead.

> +			cond_resched();
> +
> +			if (!should_zap_file_vma(file, vma))
> +				continue;
> +			/* Zapping HugeTLB VMAs needs i_mmap_rwsem held for write */
> +			if (WARN_ON_ONCE(is_vm_hugetlb_page(vma)))
> +				continue;
> +			zap_vma(vma);
> +		}
> +	}
> +	i_mmap_unlock_read(mapping);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210549.3716=
546-1-kwilczynski@kernel.org?part=3D1
