Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69AE4418D7
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093321; cv=none; b=LAaPzF35DCwcsMuO//nnQElo7Jaq+9fHadS/JHfjP80n/8/BniBD85zchUgL4OmC9ovlOb3Yc1+w6J25Rk7u5tg0HivHMLWwYLpxQqLdwjXGbHrei3/7cgCYvh428gro7poTB6xBQWn0r9X8FkWdZPjTs2dUkfd44OfYwvTgy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093321; c=relaxed/simple;
	bh=O+GrmHIW4NYRhO47krqBeROSuG2cozQ17GJZVgHGkYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AN9vET3bfGixLshSGp4c/IW4xf+TsMJ3ifQemn6dQY2a0uI/EVFlyGUni/syUlMo7YIgOhVmTbm5V6lOVmJn6xchx56EZ/OfzAqFKL3LEMyX/5Z8CWx7qi+imsyO4EbKppLu0Jftt0wlraErQa01LQ9TQgzVnJdqoVa9VCPxySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRwyyUTb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRwyyUTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EE6C2BCB0;
	Wed,  6 May 2026 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778093321;
	bh=O+GrmHIW4NYRhO47krqBeROSuG2cozQ17GJZVgHGkYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IRwyyUTbRyXpXsxBBWVIVWBYRH4zNOqRhYLOhtzzAVO9X9r43wR1R8HovkJ1Pory5
	 fMM7VbDsx0pilJNuSvlnRtP4AwKaJUQpWRgBHbDwS49ovoxT7VGUMImboHxxRdmCcv
	 3Lf5YceEb85uFuS/HwECTQhYd1i2TkDDOd6Dy7d+WBLSl25z3QvEwCigj0BoWi0tIH
	 9cXnNZBfFheL3M/FRXg6qiK/pFPckRzT5WygVBYF6ihKU75m7AMDl6fXNJ2HXUych9
	 vfxo4dXqHwpfP+pLZWVXgszKlH+qkJ2DNYMJwWOtVIwK5EEFtgpBnGuLBzU2f03UNQ
	 r2rR9hAHugtkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] vfio/pci: Add PCIe TPH interface with capability
 query
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506094623.29327-4-fengchengwen@huawei.com>
References: <20260506094623.29327-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 18:48:40 +0000
Message-Id: <20260506184841.34EE6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The VFIO_DEVICE_PCI_TPH IOCTL reads PCI configuration space withou=
t ensuring the device is runtime resumed, potentially reporting bogus capab=
ilities and causing hardware errors.
--

commit c1b7fcc4c0c41ea45b0bcdd16ef1d416fcc244c3
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH interface with capability query

This commit adds the VFIO_DEVICE_PCI_TPH IOCTL to allow userspace to query
device TPH capabilities. It also introduces a module parameter to restrict
unsafe device-specific TPH mode to trusted userspace.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f8d093aacf8a..d98d04bad4a39 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1461,6 +1463,53 @@ static int vfio_pci_ioctl_ioeventfd(struct vfio_pc=
i_core_device *vdev,
>  				  ioeventfd.fd);
>  }
> =20
> +static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
> +				struct vfio_device_pci_tph_op *op,
> +				void __user *uarg)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	u8 mode =3D pcie_tph_get_st_modes(pdev);

Does this ioctl need to ensure the device is runtime resumed before reading
its configuration space?

If the device is in a low-power state (like D3cold), won't the configuration
reads in pcie_tph_get_st_modes() return 0xFFFFFFFF?

This could cause the kernel to falsely report that all TPH modes are
supported and advertise an incorrect ST table size.

Should this handler (or vfio_pci_ioctl_tph) call
pm_runtime_resume_and_get() before invoking hardware-touching operations,
and pm_runtime_put() afterward?

> +	struct vfio_pci_tph_cap cap =3D {0};
> +
> +	if (op->argsz < offsetof(struct vfio_device_pci_tph_op, cap) +
> +			sizeof(struct vfio_pci_tph_cap))
> +		return -EINVAL;
> +
> +	if (mode =3D=3D 0 || mode =3D=3D PCI_TPH_CAP_ST_NS)
> +		return -EOPNOTSUPP;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506094623.2932=
7-1-fengchengwen@huawei.com?part=3D3
