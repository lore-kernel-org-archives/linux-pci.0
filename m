Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402208;
	b=3HMHlOSoStEW6kDX303LdfutEP+fCecBEc63xYK+W0ZxTnmNnPxm9C9bs578MpM+id4i
	 I4IOISmGgUf3gouezl2+z5nkE+gksiL/E6AG/CZS6KFY3Fn9aAYJffWlLvFLHlTngwQod
	 9q7b1gfc6IeV8y2w3JRRBTTRx2CM5Agvj1FF2hXeYOyNI8larw18WV3AR3+sV1IfANGXX
	 0V31LYg1QuI1wcuhykHuqnvAHPmFM+8/Rf1eKKcjHEQzyjTnteADNYSYGendWEAJBHTMy
	 HgkTa0k4nIHeQjCYl/NcghZtWwCywBLi2DTeJEDZVK8VxKTgKMenyB/17+yATWdwTnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402208;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=icE3NOHsUjbw2djv6ZZGYtMKSPfBdWlX128XMt2eUtI=;
	b=o7ohpbyYhZnA/QERCwH5zXICCe+49KP6bcrl8R28Hkec0mtuZZFXoRyQUIfRMmk19yFC
	 i1uqmQIOu/IFSCfSu2GbE2fpJXZIXHEWoGcOXQK8moG4ZK2LV77a1KrQFRJICPy3cMOag
	 yWAOzJXTbiPQ908KZMMCLG9oYW0Y6F0tYqYsvf0/Og9feO01WU/B/AXAiHkjV9Smr3wOu
	 E0L4NyLxMUCPfkTahC2wUdezQASkICG/j4bnPqXZVPhNR/00LfP44V1N+tGBFY+zrbHH0
	 W4CUm6A886FdqDM7T/w+NEZ7zjVSIOVgOyan7PcYRbqBD1gfVQedLlpPF6KyTffkYsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laSBag70;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A3606A31A;
	Mon, 23 Nov 2026 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laSBag70
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7201F000CF;
	Mon, 23 Nov 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402207;
	bh=icE3NOHsUjbw2djv6ZZGYtMKSPfBdWlX128XMt2eUtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=laSBag705q0HG1PMukI7WD8HDf0Db5erKRuKXTcnG/xjerVFX9uiP4CL08Go9XgMX
	 PFPGkjH/a05C73GtMm8yoPPMiH8mLiC2ere3963GviUx8DzihIS2hqqyZPFCJO4GKP
	 lbFLEJ9t9IyoGC8s67at3d9116Cy6R5Cut/hcd/2ruylNWUUJFR1QZ4qHRGFQ3tBom
	 yTMQ9pfx/tF76gO7skaAuAlCxND83MSUkYeeul+NIzL8gDd46S9fOA9/43OgZ9tUxW
	 zSNcwRpFZm6tSTDAJjyxQq+8vkQIzEq5dv/m4nmPT39QsxAz/Pz8kr517G2v5bzWuI
	 xVeDddjfOJpVA==
Message-ID: <sashiko-outbox-228565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 12/13] vfio/pci: Add DS-ST TPH policy and
 TPH_RESOLVE capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261123023628.7728-13-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
 <20261123023628.7728-13-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 02:50:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] vfio/pci: out-of-bounds read in cpu_online() via unchecked CPU
  ID
- [Medium] vfio/pci: vfio_tph_config_write() loses ST mode when TPH is
  disabled
--

commit d6106eda03cc2bd8d1bcbc6a878dc5163e37fa33
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add DS-ST TPH policy and TPH_RESOLVE capability

This commit adds the VFIO_PCI_TPH_POLICY_DS_ST policy level to allow
PCI_TPH_ST_DS_MODE selection and introduces the
VFIO_DEVICE_FEATURE_TPH_RESOLVE ioctl feature to resolve steering tags from
CPU sources.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 2bae386a8469f..3b507a96edfc0 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1228,7 +1228,7 @@ static int vfio_tph_config_write(struct vfio_pci_co=
re_device *vdev, int pos,
>  	cap =3D vdev->tph_vcap;
>  	mode =3D FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
>  	req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
> -	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) ||
> +	if (mode > PCI_TPH_ST_DS_MODE || !(cap & (1u << mode)) ||
>  		req =3D=3D 0x2 /* reserved */ ||
>  		(req =3D=3D PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
>  		goto out; /* Drop invalid or unsupported write value. */

[Severity: Medium]
Can vfio_tph_config_write() lose the ST Mode Select field when TPH
Requester Enable is PCI_TPH_REQ_DISABLE?

When req =3D=3D PCI_TPH_REQ_DISABLE, vfio_tph_config_write() calls
pcie_disable_tph(), which either returns without writing to hardware when
!pdev->tph_enabled or writes 0 to the entire 32-bit hardware PCI_TPH_CTRL
register when pdev->tph_enabled is set.  Because vfio_tph_config_read()
reads PCI_TPH_CTRL directly from hardware and vfio_tph_config_write()
overwrites vdev->vconfig[start + PCI_TPH_CTRL] with the hardware register
on entry:

drivers/vfio/pci/vfio_pci_config.c:vfio_tph_config_write() {
	...
	vfio_user_config_read(pdev, start + PCI_TPH_CTRL, &ctrl_val, 4);
	vfio_default_config_write(vdev, start + PCI_TPH_CTRL, 4, perm,
				  PCI_TPH_CTRL, ctrl_val);
	...
	if (req =3D=3D PCI_TPH_REQ_TPH_ONLY || req =3D=3D PCI_TPH_REQ_EXT_TPH) {
		pcie_disable_tph(pdev);
		pcie_enable_tph_ext(pdev, mode, req);
	} else if (req =3D=3D PCI_TPH_REQ_DISABLE) {
		pcie_disable_tph(pdev);
	}
	...
}

any ST mode written while the requester is disabled (or preserved when
disabling the requester to update ST entries) is lost on the next config
read or write, reverting the device to PCI_TPH_ST_NS_MODE when the
requester is later enabled.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 83b81d1a61227..318b4f4332565 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1915,6 +1921,50 @@ static int vfio_pci_core_feature_tph_program(struc=
t vfio_pci_core_device *vdev,
>  	return ret;
>  }
> =20
> +static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device=
 *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_resolve __user *arg,
> +			size_t argsz)
> +{
> +	struct vfio_device_feature_tph_resolve resolve;
> +	u32 user_flags, src_mask;
> +	bool extended;
> +	u16 tag =3D 0;
> +	int ret;
> +
> +	if (!vdev->tph_opt_in || !(vdev->tph_vcap & PCI_TPH_CAP_ST_DS))
> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(resolve));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	if (copy_from_user(&resolve, arg, sizeof(resolve)))
> +		return -EFAULT;
> +
> +	user_flags =3D resolve.flags;
> +	extended =3D !!(user_flags & VFIO_DEVICE_TPH_EXTENDED);
> +	if (extended && !pcie_ext_tph_supported(vdev->pdev))
> +		return -EOPNOTSUPP;
> +	user_flags &=3D ~VFIO_DEVICE_TPH_EXTENDED;
> +
> +	src_mask =3D vfio_pci_tph_get_src_mask(vdev) & ~VFIO_DEVICE_TPH_SRC_NON=
E;
> +	if (user_flags & ~src_mask || !is_power_of_2(user_flags))
> +		return -EINVAL;
> +
> +	ret =3D vfio_pci_tph_resolve_st_tag(vdev->pdev, user_flags, resolve.src,
> +					  extended, &tag);

[Severity: High]
Can a user-supplied resolve.src >=3D nr_cpu_ids cause an out-of-bounds read
in cpu_online()?

vfio_pci_core_feature_tph_resolve() passes the unvalidated 32-bit
resolve.src value from userspace to vfio_pci_tph_resolve_st_tag(), which
calls cpu_online(src_handle) without first checking src_handle < nr_cpu_ids:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_tph_resolve_st_tag() {
	...
	if ((src_bits & cpu_srcs) && !cpu_online(src_handle)) {
		*st =3D 0;
		return -EINVAL;
	}
	...
}

Because cpumask_test_cpu() does not clamp out-of-range CPU numbers,
passing a large resolve.src indexes past __cpu_online_mask in test_bit()
and can trigger an out-of-bounds read or kernel page fault.  Checking
src_handle >=3D nr_cpu_ids before cpu_online(src_handle) in
vfio_pci_tph_resolve_st_tag() would also protect
vfio_pci_core_feature_tph_program().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123023628.7728=
-1-fengchengwen@huawei.com?part=3D12
