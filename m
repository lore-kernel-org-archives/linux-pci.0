Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1713A3F7
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014400; cv=none; b=R3oHDiexaBCMJTNvu+UF/FL5HqCykRNyJOuCPmLvUYlNW2VZH3XulXBF5BGK7f/xvwHBC4flPhkEqUjK0bg/nOM6RdzgC9Vu6vgDvTauxXV3Jm01yPYF4blN/mb9WdIulelnX1GlKkK9LMlpOEAyo6WT2bRyGoE1hJC5i/WAmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014400; c=relaxed/simple;
	bh=928hR+SwFWAxH2eCwf14vfc37giYHTWMIlJul3wTImQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CsJaw4VrKyoXzwzW8VLmUp+1LTgTRkYnGXivZ+Qrw5tyZ4iB/oWa8gkkTwafpmT3r3qd863jm0V4E04Z8FDZJcTNBo2xw3IxWjaj0Y3D4l/uJG5wkGKdpVFMpIPTUoRDXqrOHUi8iDSis9zSazvH6GWnQO9MpB28bEibze89i6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8Rn9dbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8Rn9dbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B801E1F000E9;
	Sat, 25 Jul 2026 21:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785014398;
	bh=kWsyH6ol78DyYQyK3v9eHMMdUFAVX+em3q+fQbXkpoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8Rn9dbcHq4WCoDJnWr6WlWjHJ9WOxZNapapVfYBBZ7J8y2wE3haBDpFIKkJAFQj1
	 3diWysjAWfatqVPy8JXerMnzW7QnQWXYNEh4qtjDfmd9FU9YhyawLtZzbxsCODx/7h
	 iupprf6ZvoI2+IErPyptc4FBS8dEO8SQ2WVGuhlcHbdjR6Zj/C6zldNt8dIwxqEmSr
	 4cY5fmgYYUJl95jUWokxjNzqfzXVtAE7gUKjUdOibfOSO1Bm3E+3g37Pd/L8zp8MtB
	 IK2xsK4V8ow9s8xLehyHqLfP55NFzu+qZixRX9pzuKpohoxfe61rjiGjCHZaP80OV1
	 mK30n9ByBEhsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] proc: Unmap mmaps of removed files via
 file->f_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260725210549.3716546-4-kwilczynski@kernel.org>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
 <20260725210549.3716546-4-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:19:58 +0000
Message-Id: <20260725211958.B801E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] A TOCTOU race allows a newly mmap'd VMA to bypass the zapping =
process during device rundown, leaving active PTEs mapped to removed hardwa=
re.
--

--- Patch [3]: [PATCH v2 3/3] proc: Unmap mmaps of removed files via file->=
f_mapping ---
commit d70ab9967b02c9e0d34615bf288a6ac4be654e1f
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

proc: Unmap mmaps of removed files via file->f_mapping

This commit unmaps user space mappings associated with removable proc
entries when the entry is being removed. It does this by calling
unmap_mapping_file() in close_pdeo() for each open file.

> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -239,6 +239,8 @@ static void close_pdeo(struct proc_dir_entry *pde, st=
ruct pde_opener *pdeo)
>  		spin_unlock(&pde->pde_unload_lock);
> =20
>  		file =3D pdeo->file;
> +		if (pde_is_removed(pde))
> +			unmap_mapping_file(file);

[Severity: Critical]
Can this race with a concurrent mmap() operation?

Looking at proc_reg_mmap() in fs/proc/inode.c, the PDE usage count is
dropped before the VMA is linked into the address space:

fs/proc/inode.c:proc_reg_mmap() {
    ...
    rv =3D pde_mmap(pde, file, vma);
    unuse_pde(pde);
    return rv;
}

If Thread A drops the usage count via unuse_pde(), Thread B's rundown
could proceed and execute unmap_mapping_file() here.

Because Thread A has not yet returned to the VFS layer to link the VMA
to the interval tree:

mm/vma.c:__mmap_new_vma() {
    ...
    vma_link_file(vma, action->hide_from_rmap_until_complete);
    ...
}

Would unmap_mapping_file() miss this new VMA, allowing Thread A to return
to userspace with an active mapping to the removed device?

>  		pde->proc_ops->proc_release(file_inode(file), file);
> =20
>  		spin_lock(&pde->pde_unload_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210549.3716=
546-1-kwilczynski@kernel.org?part=3D3
