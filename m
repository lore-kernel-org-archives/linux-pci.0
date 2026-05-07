Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AA175A99
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778196018; cv=none; b=cfpxRn1+mqKavdPMLd3xaC4XFGQBMrN2NlTPSoMq4SYkorkboZYS/Fd23Kf3nMsr7mOKXcz4S+TQXCTnOJS7f+u+RkSUJJrf4UfoarPuZ7JKqmy/RuLQQcMLStlv2Zh4Y6xNB5wpsPu2k83As/aeFT4KR8e9K36pTYKf8NC1X/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778196018; c=relaxed/simple;
	bh=XDIL4lZLx7HTlxm0pMj9E20DYlZnj9ZoOLm53fZLC3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cnG/MhRF2lfi+0Pg5w63pprTxI4U2QaIr+k12iaghEu3/MvDMZj2i401f9NkHKjc5NF7qHWQYhsIG0EMLSXQQ5mEpyRS0OR2r3AzPfOd2jLKhcWtYAqHACrCcINyNPtF/gibC4mVVjJtTs2xns/cF80A1kDuh8jLSARBIMf3mtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvAqhW6k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvAqhW6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC6C2BCB2;
	Thu,  7 May 2026 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778196018;
	bh=XDIL4lZLx7HTlxm0pMj9E20DYlZnj9ZoOLm53fZLC3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RvAqhW6klnAUwWfXAeCfa9KX5EghWE7GuF4x0NsRGg3fV/pkXT1KeZZg2lHN9cgfU
	 cSXo65AYlRJOaZJgo6pO5WQuIqP0E9PvRuthb/l/9bBeVXOXfGMfX5rmo7cvayyinl
	 MhiGCLBvePZy0qb+4AkrTLamZmrkeblamt7BDscP3BKcGCLJ8Tztcc4DhbpPn/SXnS
	 hFZdbZH+UToT8QROw1NzN7ofxwazuzfw/Rqs5UHJW5Co8Aa+2PJESuTL/izbbmeYbz
	 cGphOI1UvAbPrHMQZ+WtOOgmgV45cFosHLGqbtu86RdshlCqg16Jw/PN+ZM4/hugpE
	 onBVplxYOww2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] vfio/pci: Add PCIe TPH interface with capability
 query
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507130956.34441-4-fengchengwen@huawei.com>
References: <20260507130956.34441-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:20:17 +0000
Message-Id: <20260507232017.A0AC6C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The ST table size (`st_table_sz`) is incorrectly reported as 0 w=
hen the Steering Tag (ST) table is located in the MSI-X table.
--

commit 84cffb4ace52d740319be3c3a2f634b68268963c
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH interface with capability query

This commit adds the VFIO_DEVICE_PCI_TPH IOCTL to allow userspace to query
device TPH capabilities, supported modes, and steering tag table informatio=
n.
It also introduces a module parameter to restrict unsafe device-specific TPH
mode to trusted userspace only.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f8d093aacf8a..e7efa8f230bec 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1461,6 +1463,55 @@ static int vfio_pci_ioctl_ioeventfd(struct vfio_pc=
i_core_device *vdev,
>  				  ioeventfd.fd);
>  }
> =20
> +static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
> +				struct vfio_device_pci_tph_op *op,
> +				void __user *uarg)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	struct vfio_pci_tph_cap cap =3D {0};
> +	u8 mode;
> +
> +	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, cap))
> +		return -EINVAL;
> +
> +	mode =3D pcie_tph_get_st_modes(pdev);
> +	if (!enable_unsafe_tph_ds_mode)
> +		mode &=3D ~PCI_TPH_CAP_ST_DS;
> +	if (mode =3D=3D 0 || mode =3D=3D PCI_TPH_CAP_ST_NS)
> +		return -EOPNOTSUPP;
> +
> +	if (mode & PCI_TPH_CAP_ST_IV)
> +		cap.supported_modes |=3D VFIO_PCI_TPH_MODE_IV;
> +	if (mode & PCI_TPH_CAP_ST_DS)
> +		cap.supported_modes |=3D VFIO_PCI_TPH_MODE_DS;
> +
> +	if (pcie_tph_get_st_table_loc(pdev) !=3D PCI_TPH_LOC_NONE)
> +		cap.st_table_sz =3D pcie_tph_get_st_table_size(pdev);

Is it possible that st_table_sz is incorrectly reported as 0 here when the
Steering Tag (ST) table is located in the MSI-X table?

The kernel function pcie_tph_get_st_table_size() returns 0 if the ST table
location is anything other than PCI_TPH_LOC_CAP, meaning it returns 0 for
PCI_TPH_LOC_MSIX.

As a result, userspace would receive st_table_sz =3D=3D 0, which the UAPI
documentation explicitly defines as 'no ST table'.

Furthermore, because the location is not PCI_TPH_LOC_NONE, any subsequent
userspace attempt to use VFIO_PCI_TPH_GET_ST would be rejected by the kernel
with -EOPNOTSUPP.

This would leave userspace completely unable to properly program the ST tab=
le
using SET_ST because it falsely believes the table size is 0 and cannot que=
ry
the CPU tags.

Should the MSI-X table size (e.g., via pci_msix_vec_count(pdev)) be used to
populate st_table_sz when the location is PCI_TPH_LOC_MSIX?

> +
> +	if (copy_to_user(uarg, &cap, sizeof(cap)))
> +		return -EFAULT;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507130956.3444=
1-1-fengchengwen@huawei.com?part=3D3
