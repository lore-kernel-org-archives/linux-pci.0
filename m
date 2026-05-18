Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7143E6382
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096159; cv=none; b=ueb1xqpnkwyb51+YRflUv2AuPOLavdTpv3bY/DqvNMj0cwA2cieBxTKl9tjTnvL0v5cuqYeOoFUxvoy9LjN58NRSVzS25lwRRLYY9lmH59QT/pOODg3MwrBDMMlbVq2hw8H4co5IUuBURt2887Rsoy/8WorohC42cenvi5r3v4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096159; c=relaxed/simple;
	bh=oHaDAmhuNloSH5DgBfDFbk59x50FCO4w9cbnTz3aoeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=edG1n0f3PWbIKTFjhsoVUdX6v8dH5z6TDRg+ZqDfYp7j/Xlhd1zgercx+tmQfeQIrnHX6NyIat7E380gJIOL+RMhm66uKGO/zntx4pTvXmW1oi7InKMA0jQkBozDGoSfKVc/22DdAJNeQTZkkIpMJmHXTUJ6Lb5Q+8N8ZHExAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn7edN2V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn7edN2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47841C2BCB7;
	Mon, 18 May 2026 09:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779096158;
	bh=oHaDAmhuNloSH5DgBfDFbk59x50FCO4w9cbnTz3aoeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Jn7edN2VPfy11sAT9yUllZK3BaXXZlwZ3b3Hd9i2fasYoMKZ5l2ml0jVWD7Caoaq1
	 yLU+QC1uOoJy0NXy/fLm+PBCOu3OcQeUPTBHbqkfPT1Fg7u9yPTkmQJs5Y9yCwsq/b
	 IQjVoXIj+WJZ6ewBsYmHwMO0q5E0fwNzQw48wlFrjBN2OFO92tXU4jz8/sBbTC3tjK
	 H7yqzM4Yf5I/xhpSrn0wdtE5+gBWc0a4EvBKHQMUjIZ3FG9GtvW8vLG0pfZBhQYgOY
	 TV9KyQbDh9BscUiC6BIJBjIiAfAxEwGOb5pRMsvEjbRC+vy6rHzjzHmx8+oUTgCpz9
	 AYA5I1BDpl1CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/5] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for
 TPH ST entry management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518071701.25177-6-fengchengwen@huawei.com>
References: <20260518071701.25177-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 09:22:37 +0000
Message-Id: <20260518092238.47841C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The function mixes `guard()`-based cleanup with a `goto`-based c=
leanup label.
- [Medium] The flag-gated parameter `index` is validated outside the scope =
of its flag gate.
--

commit 06e9eeaeacf7925e08b8f7df545f7710af906cae
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH ST entry management

This commit introduces VFIO_DEVICE_FEATURE_TPH_ST to allow userspace to man=
age
PCIe TPH Steering Tag entries. It supports SET operations to program contig=
uous
ST entries and GET operations to retrieve ST values per CPU ID.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
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
> +	guard(mutex)(&vdev->tph_lock);
[ ... ]
> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
> +		return -EFAULT;
> +
> +	if (tph_st.count =3D=3D 0 || tph_st.count > VFIO_TPH_ST_MAX_COUNT ||
> +		tph_st.flags > VFIO_TPH_ST_MEM_TYPE_PM)
> +		return -EINVAL;
> +	if (!is_set && tph_st.index !=3D 0)
> +		return -EINVAL;

Since the index field is documented as only valid for FEATURE_SET operation=
s,
could userspace legitimately pass uninitialized memory in this field during
a GET request?

If userspace is not required to zero-fill unused fields, validating that
index is exactly 0 during a GET operation might cause spurious failures
for valid requests.

[ ... ]
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

Is it recommended to mix guard() based cleanup with goto-based error handli=
ng
in the same function?

The cleanup guidelines suggest that functions should either use scope-based
cleanups for all resources or convert none of them. Could the cpus array be
managed with __free(kfree) and the rollback handled directly in the error
paths to avoid using goto labels alongside guard()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518071701.2517=
7-1-fengchengwen@huawei.com?part=3D5
