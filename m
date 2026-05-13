Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC63AEF49
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707578; cv=none; b=TKDMoWYEqH7EhaYvTzIMRLPBDQqfJoBI/1ythWCuAiGDVQFbOKEcF7Xd9r4Lya2e7+e7owZEImTgZpwTycWBnBu/1QlGv/J3pa62Z5OlpbAlhtviP4cxIxUYVFSJYy3d+hwVQNXzu+CjVMLv+sldTPVABHnKHHWQgSP2ATbvyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707578; c=relaxed/simple;
	bh=gy7mjVhKN8RNQDmkeq3iuXc0CzsEzQNU3A31lupFEkI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dpsNF2K8944WcU2p86eEhAqcVYOeKm9q2rJC/ZN4eXRonlzjlhalpOO24eDefcls1A4hEXL/fzO3Hk1fpis6Z/KqFXOviR9wwTyLzDL5+34ppHHlFWsUy6Q01t0D84mrTdu/p+ZEHx7gC0XustgAoUrVjQYTWnl9sl1vdhyy++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAuCWZcJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAuCWZcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0898C2BCB8;
	Wed, 13 May 2026 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778707578;
	bh=gy7mjVhKN8RNQDmkeq3iuXc0CzsEzQNU3A31lupFEkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZAuCWZcJoYjHkYjIw+d8X/4UQ4Dz2aAHJvF2XIT5hQdO2BNdGhcYmy/aDn7UXHED8
	 AboRyy4r7578OBL6Kxlng7mNXskGnH26o1uiTZX/0mN5BjuarYWgkZ97v40RJkoWYQ
	 OCVsQt7Usw03z5IVyucoIDPldn6fJC6n3H3oVoBpNMQ5xq+q46F8vNwGlcNdwUMHBY
	 exY1trfM54IHF7BazgjsZ9/Ib6n0ftwf45ZIc9SBemThBZxsSTBs80ZH2xW0He2LS6
	 uJluBFJ1/WpGTa7zZFerIMHiDUwC7lhSdZeQ1hNmyTyMdgowQVrWofPqZq2bA1Zmzt
	 HFR2mZpFqF+ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/5] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH
 ST entry management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512080329.42593-6-fengchengwen@huawei.com>
References: <20260512080329.42593-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:26:17 +0000
Message-Id: <20260513212617.D0898C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The function validates the flag-gated `index` parameter during GET=
 operations.
- [High] The return value of `copy_to_user` is returned directly to userspa=
ce instead of being translated to `-EFAULT`.
- [High] Feature probing is broken because `vfio_pci_core_feature_tph_st` i=
ncorrectly returns `-EINVAL` for a valid PROBE request.
- [High] Unprotected multi-entry loop and rollback allows concurrent ioctls=
 to corrupt the device's Steering Tag table.
- [Low] Missing `__user` annotation on the `arg` pointer parameter.
--

commit cb7b3cb66be5004899767cf60e4cb277d30b557d
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH ST entry management

This commit introduces a new VFIO device feature allowing userspace
to manage PCIe TPH Steering Tag entries. It supports set operations
to program contiguous entries and get operations to retrieve ST values.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index cc13fc8eea9da..298e7dd136fd2 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1521,6 +1521,91 @@ static int vfio_pci_core_feature_token(struct vfio=
_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vde=
v,
> +					u32 flags,
> +					struct vfio_device_feature_tph_st *arg,

This isn't a bug, but should arg be annotated with __user to satisfy
sparse static analysis? The caller passes a void __user pointer, and
dropping the annotation circumvents kernel address-space checks.

> +					size_t argsz)
> +{
> +	bool is_set =3D !!(flags & VFIO_DEVICE_FEATURE_SET);

[ ... ]

> +	ret =3D vfio_check_feature(flags, argsz,
> +				 VFIO_DEVICE_FEATURE_GET |
> +				 VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(tph_st));
> +	if (ret !=3D 1)
> +		return -EINVAL;

Will this break feature probing? When VFIO_DEVICE_FEATURE_PROBE
is requested, vfio_check_feature() validates the request and returns 0.
By converting any return value other than 1 into -EINVAL, userspace
might be unable to successfully probe for VFIO_DEVICE_FEATURE_TPH_ST
support. Should this return ret instead of -EINVAL?

> +
> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
> +		return -EFAULT;
> +
> +	if (tph_st.count =3D=3D 0 || tph_st.count > VFIO_TPH_ST_MAX_COUNT ||
> +		tph_st.flags > VFIO_TPH_ST_MEM_TYPE_PM)
> +		return -EINVAL;
> +	if (is_set && (tph_st.index >=3D VFIO_TPH_ST_MAX_COUNT ||
> +		       tph_st.index + tph_st.count > VFIO_TPH_ST_MAX_COUNT))
> +		return -EINVAL;
> +	if (!is_set && tph_st.index !=3D 0)
> +		return -EINVAL;

Since the UAPI documentation states index is only valid for
VFIO_DEVICE_FEATURE_SET, could validating it during a get request
incorrectly reject valid calls? Unused parameters might contain stack
garbage, so if userspace leaves index uninitialized during a get, this
forces them to zero-fill it unnecessarily.

[ ... ]

> +	for (i =3D 0; i < tph_st.count; i++) {
> +		if (cpus[i] =3D=3D U32_MAX) {
> +			ret =3D pcie_tph_set_st_entry(pdev, tph_st.index + i, 0);
> +			if (ret)
> +				goto out;
> +			continue;
> +		}
> +
> +		ret =3D pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
> +		if (ret)
> +			goto out;
> +		ret =3D pcie_tph_set_st_entry(pdev, tph_st.index + i, st);
> +		if (ret)
> +			goto out;
> +	}
> +
> +out:
> +	if (!is_set && !ret)
> +		ret =3D copy_to_user(&arg->data, cpus,
> +				   tph_st.count * sizeof(*cpus));

Does this correctly propagate -EFAULT if the copy fails? copy_to_user()
returns the number of uncopied bytes, which is a positive integer.
Because userspace often interprets a non-negative ioctl return as
success, it might falsely assume the get operation succeeded while
operating on uninitialized or partially written data.

> +	if (is_set && ret) {
> +		/* Roll back previously programmed entries to 0 */
> +		for (j =3D 0; j < i; j++)
> +			pcie_tph_set_st_entry(pdev, tph_st.index + j, 0);
> +	}

Could concurrent ioctl calls corrupt the Steering Tag table? Since this
loop and rollback process does not appear to hold an overarching lock
(like vdev->igate), two overlapping set operations could race. If one
thread fails halfway through, its rollback loop might blindly overwrite
entries that the concurrent thread successfully programmed, leaving the
hardware in an inconsistent state.

> +	kfree(cpus);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512080329.4259=
3-1-fengchengwen@huawei.com?part=3D5
