Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C513D7A19;
	Wed, 27 May 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885165; cv=none; b=WtzOiV+f2ycadOks19q2ej9ikMk1CMKSmyLRNonxo/Erd2sJ2QFH283EQT5WOxoqS5G3Bvh83IKOYv2ON52CzXK7fSpWfDwWug+vq9PfSy+RvFjUcAVQaIGrWz7GxAsrhfiHRIxMZq8Rj4JBjW6z2Ep2xsfqQXbeYYNAF0PW7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885165; c=relaxed/simple;
	bh=OKoAmXzWtNWOD0pTDY8lNhx5nUHJXMymuDY1gIr3570=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WlCZxbPfHokBddpMPFy1HN1XLxmMTr+LH16WwkfetSZeVWYwab4rjkBWmV0ScqFouulwtiCpPbzW8zrwNw/KzvcJi5t41UE4guDTQ7K2BjwDGuc4sbyc90W/LN7XCAteGgbHFDto8q08MqBjGH1XskNkvL+rHFdnBErd8j/b7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMS/7GE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMS/7GE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7363E1F000E9;
	Wed, 27 May 2026 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779885154;
	bh=TLff9wAVxhvlfLxLLPW9TFL/YoJTIf8ieWrJEGUe7hU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bMS/7GE7wLgb0nFEmbuJ9K/tk8nooRkW2tPTso2AmzUkXNYZAXs52QOL9rUBNIpwh
	 Vr99VtQmbPlUYg3XivJAEVTp/dXo1j+MifuDyEZiZBWlHNlzz241HH109TmRffrHqD
	 08/quz4Eb33s+RBaPSjh5jX3EwbpPvlEiv3w4xyjD3RRGMtfmGmqRs5/5WwQkxctXF
	 QIah6VxT5Vlay2ZTjkyg8qI8A01+tc4WvBscQmXxX3afQ8wzOQwUD5SJi+V/B/SDp+
	 cEgNLQyekXn7NlKUCRG3c3Zt/ri9g0OBVfywIf/IpMVmoLCUURmsVEGQV0jJG0VbX9
	 JHJNARrQvMZTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 6/8] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST_CONFIG
 for PCIe TPH ST configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260527094719.43886-7-fengchengwen@huawei.com>
References: <20260527094719.43886-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:32:34 +0000
Message-Id: <20260527123234.7363E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mixing goto-based error handling with guard() scope-based cleanu=
p.
--

commit 77e99e8523577d196dfd91b6ec41bc5663f81d8e
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST_CONFIG for PCIe TPH ST configurati=
on

This commit adds the VFIO_DEVICE_FEATURE_TPH_ST_CONFIG feature to allow
userspace configuration of PCIe TPH Steering Tag table entries. It introduc=
es
a shadow ST table with per-device mutex protection and an enable_unsafe_tph
module parameter to gate the feature.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> +static int vfio_pci_core_feature_tph_st_config(
> +			struct vfio_pci_core_device *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_st_config __user *arg,
> +			size_t argsz)
> +{
[ ... ]
> +	guard(mutex)(&vdev->tph_lock);
> +
> +	uptr =3D u64_to_user_ptr(config.data_uptr);
> +	sts =3D memdup_array_user(uptr, config.count, sizeof(u16));
> +	sz =3D config.count * sizeof(u16);
> +	if (IS_ERR(sts))
> +		return PTR_ERR(sts);
> +
> +	if (pcie_tph_enabled_req_type(pdev) =3D=3D PCI_TPH_REQ_DISABLE) {
> +		memcpy(&vdev->tph_st_shadow[config.index], sts, sz);
> +		kfree(sts);
> +		return 0;
> +	}
> +
> +	for (i =3D 0; i < config.count; i++) {
> +		idx =3D config.index + i;
> +		ret =3D pcie_tph_set_st_entry(pdev, idx, sts[i]);
> +		if (ret)
> +			goto rollback;
> +	}
> +
> +	memcpy(&vdev->tph_st_shadow[config.index], sts, sz);
> +	kfree(sts);
> +	return 0;
> +
> +rollback:
> +	while (i-- > 0) {
> +		idx =3D config.index + i;
> +		pcie_tph_set_st_entry(pdev, idx, vdev->tph_st_shadow[idx]);
> +	}
> +	kfree(sts);
> +	return ret;
> +}

[Severity: Medium]
Is it appropriate to mix goto-based error handling with guard() here?

The kernel cleanup guidelines note that for a given routine, either all
resources that need cleanup should be converted to scope-based cleanup,
or none of them.

Could sts be converted to use __free(kfree) to eliminate the goto, or could
guard() be replaced with explicit mutex_lock() and mutex_unlock() calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527094719.4388=
6-1-fengchengwen@huawei.com?part=3D6
