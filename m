Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C937C929
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845514; cv=none; b=BPr1sTAlIDd+I+NGBkkd8HxWvEbx+OQP95hFFZhkcwAxieU8AbhnoH2fGUaMexpLiV/O6s1iMyzSWfdjcfcGWjvsgIyfa16PmQJlAljj1XRGnlqUdOWHzHMUb0YVQH7T9XDba/0Bdzu7jrvukscpK6d6MV5JhiG0AmjgglQPMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845514; c=relaxed/simple;
	bh=00T/Phz0pa3L31e+ebMy61oOP/BDDw1gOFrl/ZfSf4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RuOMKEWFtUAYn5nv8w18d87B5p0K9xH1d43LhiWX4WVUxwxN/GfebG7XMSNae+S/vLlsoFOgOF6+xahmSe1OX/nHIsIDj8JyFtSZuPKH9n9p1lkbsiuZRHmRuy2ch12XfZzxn8GDBVFv1xfv4ss4BkS9QjWbtfAKq7FWDfumzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um5t1cYQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um5t1cYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F61C2BCC7;
	Fri, 15 May 2026 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845513;
	bh=00T/Phz0pa3L31e+ebMy61oOP/BDDw1gOFrl/ZfSf4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Um5t1cYQZxW2rsVomjDLm3MjumvdnyCRZv9uldKoxPtCPnu2NSxYVfK1NUGJo+nHG
	 vbtqvo2qVDRNl/NsAW+9EYBMQcFen4OmhK3W1F64xmHFZp2ZqDsYVCKvaiMCJqX0pZ
	 s2SC5zzHxPTM06jrcBfI5m7kyJexXBrTYihJqY8cU5BzJLNxxh1R16J28maReaK1Bh
	 7aMjUGfnsiYVqeQjlzO+khrXjIKmtAFRkR0kXLHCmzO9UMUta+zXBI3ax2C3Dkh047
	 /tSnTiibOZ99/yIawDnc6mwfRdfHQIiQoeVz62v7GInVXc/UGLlyQkkmgQTtxmIg7B
	 oaJNqZsYysmCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/5] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for
 TPH ST entry management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515094040.38496-6-fengchengwen@huawei.com>
References: <20260515094040.38496-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 11:45:13 +0000
Message-Id: <20260515114513.71F61C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Memory leak on copy_to_user failure in the GET operation path.
- [High] Concurrent VFIO_DEVICE_FEATURE_TPH_ST ioctls lack serialization, l=
eading to data races and PCI specification violations.
- [Medium] Flag-gated syscall parameter 'index' is validated outside of its=
 flag scope.
- [Medium] Incorrect evaluation of VFIO_DEVICE_FEATURE_PROBE requests cause=
s false feature reporting.
--

commit 76816c744e3e2eb2b037ba7d9a51bdc93bc6ef28
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH ST entry management

This commit adds the VFIO_DEVICE_FEATURE_TPH_ST feature to allow userspace
to manage PCIe TPH Steering Tag entries. It provides both SET and GET
operations depending on the capabilities of the hardware.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index cc13fc8eea9da..13304a37ba266 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1521,6 +1521,93 @@ static int vfio_pci_core_feature_token(struct vfio=
_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vde=
v,
> +					u32 flags,
> +					struct vfio_device_feature_tph_st __user *arg,
> +					size_t argsz)
> +{
> +	bool is_set =3D !!(flags & VFIO_DEVICE_FEATURE_SET);
> +	struct vfio_device_feature_tph_st tph_st;
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	enum tph_mem_type mtype;
> +	int i, j, ret;
> +	u32 *cpus;
> +	u16 st;
> +
> +	if (!enable_unsafe_tph ||
> +		pcie_tph_enabled_mode(pdev) =3D=3D PCI_TPH_ST_NS_MODE)
> +		return -EOPNOTSUPP;
> +	if (!is_set && pcie_tph_enabled_mode(pdev) !=3D PCI_TPH_ST_DS_MODE)
> +		return -EOPNOTSUPP;
> +	if (is_set && pcie_tph_get_st_table_loc(pdev) =3D=3D PCI_TPH_LOC_NONE)
> +		return -EOPNOTSUPP;

Will these capability checks improperly handle VFIO_DEVICE_FEATURE_PROBE re=
quests?

If userspace probes with a bare VFIO_DEVICE_FEATURE_PROBE, is_set is false.
This would reject the probe with -EOPNOTSUPP if the device is not in DS mod=
e,
falsely reporting that the entire feature is unsupported even if SET is
supported.

Conversely, if userspace probes with PROBE | GET | SET, is_set is true, whi=
ch
bypasses the GET-specific DS mode check, falsely reporting that GET operati=
ons
are supported.

> +
> +	ret =3D vfio_check_feature(flags, argsz,
> +				 VFIO_DEVICE_FEATURE_GET |
> +				 VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(tph_st));
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
> +		return -EFAULT;
> +
> +	if (tph_st.count =3D=3D 0 || tph_st.count > VFIO_TPH_ST_MAX_COUNT ||
> +		tph_st.flags > VFIO_TPH_ST_MEM_TYPE_PM)
> +		return -EINVAL;
> +	if (!is_set && tph_st.index !=3D 0)
> +		return -EINVAL;

Does this validation evaluate a parameter outside of its flag scope?

The UAPI documentation states that the index field is only valid for
FEATURE_SET. Since userspace is not required to zero-fill unused arguments,
this might cause valid GET requests to spuriously fail with -EINVAL if the
unused index field happens to contain a non-zero value.

> +	if (is_set && (tph_st.index >=3D VFIO_TPH_ST_MAX_COUNT ||
> +		       tph_st.index + tph_st.count > VFIO_TPH_ST_MAX_COUNT))
> +		return -EINVAL;
> +
> +	cpus =3D memdup_array_user(&arg->data, tph_st.count, sizeof(*cpus));
> +	if (IS_ERR(cpus))
> +		return PTR_ERR(cpus);
> +
> +	mtype =3D tph_st.flags & VFIO_TPH_ST_MEM_TYPE_PM ? TPH_MEM_TYPE_PM :
> +							 TPH_MEM_TYPE_VM;
> +	if (!is_set) {
> +		for (i =3D 0; i < tph_st.count; i++) {
> +			ret =3D pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
> +			if (ret)
> +				goto out;
> +			cpus[i] =3D st;
> +		}
> +		goto out;
> +	}
> +
> +	for (i =3D 0; i < tph_st.count; i++) {
> +		if (cpus[i] =3D=3D U32_MAX) {
> +			ret =3D pcie_tph_set_st_entry(pdev, tph_st.index + i, 0);

Are concurrent ioctls serialized here?

There appears to be no locking (such as vdev->igate) when iterating and
calling pcie_tph_set_st_entry().

Concurrent SET operations could race and cause lost updates to the PCI
config space control registers, or cause the error path rollback to blindly
overwrite successful entries programmed by a racing thread.

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
> +	if (!is_set && !ret) {
> +		if (copy_to_user(&arg->data, cpus,
> +			tph_st.count * sizeof(*cpus)))
> +			return -EFAULT;

Does this early return leak the cpus array?

If copy_to_user() fails, the code returns -EFAULT directly and bypasses
the kfree(cpus) cleanup.

A buggy or malicious userspace application could repeatedly issue GET
requests with an unmapped data pointer, leading to memory exhaustion.

> +	}
> +	if (is_set && ret) {
> +		/* Roll back previously programmed entries to 0 */
> +		for (j =3D 0; j < i; j++)
> +			pcie_tph_set_st_entry(pdev, tph_st.index + j, 0);
> +	}
> +	kfree(cpus);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515094040.3849=
6-1-fengchengwen@huawei.com?part=3D5
