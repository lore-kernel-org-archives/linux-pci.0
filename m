Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2435C1A6
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662584; cv=none; b=HXJCQj4KKaLFfbxaCc/CZlz/oAW0sevIzDWZi54hAmo6gpAoER6JiaUl6Iqfg2BrMYAB7gwXA+gAP+nE09+m+bAYveCK5lrQlLe8sSYHKpo3SE4zYR2zjyhyYpuISFvljRy/+QyEOhtK8THLGCsK+TOMZMvC9c+G6f8M5VoQyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662584; c=relaxed/simple;
	bh=q5DVSiI5gisJwC0tfhLsPWH5OBu/1chnjO7i2yd5caw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z1iyg0s/Uds5NqIzYayMU2Vkci/9jpjP9qJP0eMbrP0cYd8CH98atez+vtdbp8xHG3CUiFltgVWecn0jSEKNfAygZ0kAuTOu8bnRlOaI5/BblWVvHKPwoZPL3OASI4nm/Zc0W7r6ChcHl1F0rK5QTEKvSUPg9dCOJMq8k/kbgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPCzKa7W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPCzKa7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BCB1F00A3A;
	Tue, 21 Jul 2026 19:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662583;
	bh=PGXu+CcVtJ5MtlozuFNlUeGaHCvHP10zISVwQtXyJRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPCzKa7Wb4H/sB7yQt/qDgCavB6HbcSANqzH1Q4cXCWIoEl66o89YOrJ1JVU9TM4g
	 pALIL/+loabeGOhnNniAjpYSPiQN6zIrlthcPuboPnM+GytYOGMrabZOrh6ZLGMQbd
	 Q4QWxDMwwtJiTs6DSPVSsqhETlxGEiXrX4oVeb2izGapUaScbDdRtGkAx1CXbmJyVQ
	 g4fShQR33xjAC9nhjdQj0Zydx6l0VJf3bx/k2iCS49y1vHmr5502QgjeFfy5SgvQeM
	 6N3IEyGL4WzUAzsqRi5sqAgLb90VmFukEJqG6sX1VHsEFfZcv+HF00WFrOpPo/JnPi
	 8/1hgnkRJIRBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] kernfs: Unmap mmaps of removed files via
 file->f_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721185252.1670958-3-kwilczynski@kernel.org>
References: <20260721185252.1670958-1-kwilczynski@kernel.org>
 <20260721185252.1670958-3-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:36:22 +0000
Message-Id: <20260721193623.16BCB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a call to a non-existent macro `vma_interval_t=
ree_foreach`, causing a compile error.
--

--- Patch [2]: [PATCH 2/2] kernfs: Unmap mmaps of removed files via file->f=
_mapping ---
commit 568af62b59f659777caa44a1d088a26cedb87a9a
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

kernfs: Unmap mmaps of removed files via file->f_mapping
   =20
This commit replaces unmap_mapping_range() with unmap_mapping_file() in
kernfs_drain_open_files() for files whose f_mapping differs from their
inode's mapping. This ensures that mappings on a shared address space are
properly unmapped when the file is removed, leaving unrelated mappings
intact. This restores the correct teardown behavior for files like PCI
resources.

> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 8e0e90c933720..8d1e4acc67162 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -818,7 +818,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  		struct inode *inode =3D file_inode(of->file);
> =20
>  		if (of->mmapped) {
> -			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
> +			if (of->file->f_mapping !=3D inode->i_mapping)
> +				unmap_mapping_file(of->file);

[Severity: Low]
Could this lead to a compile error?

The unmap_mapping_file() function called here relies on a macro that doesn't
appear to be defined anywhere in the kernel:

mm/memory.c:unmap_mapping_file() {
    ...
		vma_interval_tree_foreach(vma, &mapping->i_mmap, 0, ULONG_MAX) {
			if (vma->vm_file !=3D file)
				continue;
			zap_vma(vma);
		}
    ...
}

Would it make sense to use mapping_rmap_tree_foreach() instead?

> +			else
> +				unmap_mapping_range(inode->i_mapping, 0, 0, 1);
>  			of->mmapped =3D false;
>  			on->nr_mmapped--;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721185252.1670=
958-1-kwilczynski@kernel.org?part=3D2
