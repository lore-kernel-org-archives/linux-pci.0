Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713E33E35F
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778097469; cv=none; b=Jv+6XLcjIunwuBi2pr7iuCnNSlbkkd1ton+JwJIpoaL76B1A9ZWnMH6XY0MBbn9SdNPwryJC1SvMZnr3Wos7OCA4+Ck9MLM9g0Vpi5ddnPhblbyKOjK6+BTAdhJjnDTpLUiyBFbRzvFOoHXWYXv3k4KlGvnpHmZP3btQRr8/oe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778097469; c=relaxed/simple;
	bh=d0e9gqoyXvUGYMxgStyL5E55xLpSj2jNvNc1sTlxOjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TcvSniKxWB6Dx9K1SHMFF6jnFXux2RL5fXH655gu06ggC8P7IbJW/juio7UWLCy7J9SVSV0ntnbFrzZ1Cmrs8hDEdiSl7MRXC7fZK7v4c+wzHTEQXDaBaI9YWsZZmgrAy34NT/DIMoJuKj8siduztxH4N7VH7Yco6qVid4z1lXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o78CvqPF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o78CvqPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25379C2BCB0;
	Wed,  6 May 2026 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778097469;
	bh=d0e9gqoyXvUGYMxgStyL5E55xLpSj2jNvNc1sTlxOjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=o78CvqPFweAcQtwZVLFxuXZ9k1A+HouDonL99onUwoNwYKmyxo38lnArRBuXg3YRh
	 SeC08zXYJmaGSy5XV67X7w8szbiHeyXvaFhk7WEWpAWN2LqJDDr+ivk/IV00p+4Vh0
	 oWF33BL/0e5CM6Bx178XQ/p3pGSLX+abW/44ahTd/ATmS8+PfBrTeOEvzb94zWwlW8
	 dTSY2+UOQ7H6FKy7ujvN/XwzH7KXt6qLy9Ov+9yuIVWuJeiwozPeOipjbIHzK7COto
	 logqT8zLj8H2+etXA/FFMOnPw7ZbrAf93+AyosUCGJuzz/NjX39iGuEZw2saiM5dHG
	 vK4MYVMBbva1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] vfio/pci: Add PCIe TPH GET_ST interface
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506094623.29327-6-fengchengwen@huawei.com>
References: <20260506094623.29327-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 19:57:48 +0000
Message-Id: <20260506195749.25379C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `argsz` validation incorrectly double-counts the size of the u=
nion member, causing valid requests to be rejected.
- [High] Concurrent TPH ioctls lead to data races on unprotected PCIe TPH s=
tate variables and device configuration space.
- [Medium] The unused `index` field in `struct vfio_pci_tph_entry` is not v=
alidated to be zero during `VFIO_PCI_TPH_GET_ST`.
--

commit 69a04a0a6e943f789b3703368fa523b4efd43755
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH GET_ST interface

This commit adds support to batch get CPU steering tags for device-specific
TPH mode that does not implement an ST table. This interface requires
enabling the enable_unsafe_tph_ds_mode module parameter.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 69f666d20c4af..45e641ab2a887 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1529,6 +1529,77 @@ static int vfio_pci_tph_disable(struct vfio_pci_co=
re_device *vdev)
>  	return 0;
>  }
> =20
> +static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
> +			       struct vfio_device_pci_tph_op *op,
> +			       void __user *uarg)
> +{
[ ... ]
> +	if (!st.count || st.count > VFIO_PCI_TPH_MAX_ENTRIES)
> +		return -EINVAL;
> +
> +	size =3D st.count * sizeof(*ents);
> +	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, st) +
> +			sizeof(struct vfio_pci_tph_st) + size)
> +		return -EINVAL;

Is it possible the size calculation double-counts
sizeof(struct vfio_pci_tph_st)?

The macro offsetofend(TYPE, MEMBER) evaluates to offsetof(TYPE, MEMBER) +
sizeof_field(TYPE, MEMBER). For the st member, offsetofend() correctly
calculates the end boundary. Adding sizeof(struct vfio_pci_tph_st) a
second time makes the expected minimum argsz larger than it should be.

If userspace passes the properly calculated size, will the kernel
incorrectly evaluate this as false and reject valid ioctl calls with -EINVA=
L?

(Note: The identical calculation error appears to be present in
vfio_pci_tph_enable() introduced in a prior patch.)

> +
> +	ents =3D kvmalloc(size, GFP_KERNEL);
> +	if (!ents)
> +		return -ENOMEM;
> +
> +	ents_off =3D offsetof(struct vfio_pci_tph_st, ents);
> +	if (copy_from_user(ents, uarg + ents_off, size)) {
> +		err =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	for (i =3D 0; i < st.count; i++) {
> +		/* Check reserved fields are zero */
> +		if (memchr_inv(&ents[i].reserved0, 0, sizeof(ents[i].reserved0)) ||
> +		    memchr_inv(&ents[i].reserved1, 0, sizeof(ents[i].reserved1))) {
> +			err =3D -EINVAL;
> +			goto out;
> +		}

Does this code need to validate that the unused index field in
struct vfio_pci_tph_entry is zero?

While reserved0 and reserved1 are checked, the index field appears to
be ignored during GET_ST operations. Because userspace is not required to
zero-fill unused arguments, this field may contain uninitialized garbage.

If a future kernel extension assigns meaning to index for GET_ST, will
this lack of validation break backwards compatibility by making it
impossible to distinguish intentional new values from uninitialized data in
older applications?

[ ... ]
>  static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
>  			      void __user *uarg)
>  {
> @@ -1545,6 +1616,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_=
device *vdev,
>  		return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
>  	case VFIO_PCI_TPH_DISABLE:
>  		return vfio_pci_tph_disable(vdev);
> +	case VFIO_PCI_TPH_GET_ST:
> +		return vfio_pci_tph_get_st(vdev, &op, uarg + minsz);
>  	default:
>  		/* Other ops are not implemented yet */
>  		return -EINVAL;

Are concurrent TPH ioctls adequately serialized here?

The vfio_pci_ioctl_tph() handler processes requests without acquiring any
serialization locks (such as vdev->igate). If userspace issues multiple
TPH ioctls concurrently, vfio_pci_tph_enable(), vfio_pci_tph_disable(),
and vfio_pci_tph_get_st() can execute in parallel.

The underlying PCI core functions pcie_enable_tph() and pcie_disable_tph()
perform lockless read-modify-write operations on the PCI_TPH_CTRL config
register and mutate pdev->tph_mode, pdev->tph_req_type, and
pdev->tph_enabled. Simultaneously, vfio_pci_tph_get_st() invokes
pcie_tph_get_cpu_st(), which relies on these state variables.

Can this lead to data races on unprotected PCIe TPH state variables,
resulting in corrupted device configuration space or inconsistent state
reads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506094623.2932=
7-1-fengchengwen@huawei.com?part=3D5
