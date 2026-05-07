Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791033F5B5
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197774; cv=none; b=axZo31kUuQxU22zhCi9SE5nsmnNI/MISaaGvsmDInQP9UBqgvif3QVwa6HJgJrYxpRDVJRALdNilHmk64MJpovb1V7by+mYacMnxVpCEeryCNOPcKAb7dgD4W2ariviR/6tlANiCSaBkYs6Hg0Yt1KnLZTF1kP4lyGw0lRbnYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197774; c=relaxed/simple;
	bh=PM7LqU+kjXdx0gr6NqRSso9vEXBNMApT8IQPoOzhvDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OM7UV1qJZJtxkWBtzdMFHsRjWPFqqtllFcVLcxK5CBPKU9zYWjD60dtrb98LuN3y/eOHOSS4iqBcNhyMNMW/6pwjsMG1zDtd725B3PmUF7hxi7UrFq+0BpeAVmSAQqFOpVFHeNrbximubCbd5uFiKvAvHAgR6+x0Rcl7zewCEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukdgEqGX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukdgEqGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A210DC2BCB2;
	Thu,  7 May 2026 23:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197773;
	bh=PM7LqU+kjXdx0gr6NqRSso9vEXBNMApT8IQPoOzhvDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ukdgEqGX7Gv91TfSUmTsQqa3V2LEu61VH8UzkIQVAJkFtuWuZkBKhp34ZwdW6LEsw
	 R/CYtkYGJz9WADesBkWV0oS9FfIFl1Rh/vakWv/75Fn3E2wNd6hd3QBxBqWQ0qBdeC
	 333looKHGQtAcVyiq3wd8udVSPYJH1O3xLJLyD4oZ+XTklSIpGNQcW4maugLnE8v8Y
	 ++uFY2ygR8cJnrSnpRs1bvPpZvOCzpKfXRA7eCFNoYlrD/ml5baKsjjQAH/+bGR0Zy
	 b5+P1lTmJ4z1TnVy0+i8AQYWix6IiH8LTErxXn8whnhXnlkLXVej0rgttVsEaKCmFW
	 Y/keV7Mtq4HYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] vfio/pci: Add PCIe TPH enable/disable support
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507130956.34441-5-fengchengwen@huawei.com>
References: <20260507130956.34441-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:49:33 +0000
Message-Id: <20260507234933.A210DC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCIe configuration accesses for TPH in device register/close paths=
 occur while the device may be suspended (D3).
- [High] Missing Runtime PM wake-up in TPH ioctl handlers allows hardware a=
ccess on suspended devices.
--

commit 7ffb59002e7aaac5444cc6452b34924776dcf634
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH enable/disable support

This commit adds support to enable and disable the PCIe TPH function
with mode selection, restricting unsafe modes. It also disables TPH when
ownership is taken or when userspace closes the device file descriptor.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index e7efa8f230bec..7a5dc2bfe2e9d 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -738,6 +738,9 @@ void vfio_pci_core_close_device(struct vfio_device *c=
ore_vdev)
>  #endif
>  	vfio_pci_dma_buf_cleanup(vdev);
> =20
> +	/* Disable TPH when userspace closes the device FD */
> +	pcie_disable_tph(vdev->pdev);
> +

Is it safe to call pcie_disable_tph() here before vfio_pci_core_disable()
wakes the device up?

A device might be in a suspended state when its file descriptor is closed.
vfio_pci_core_disable() explicitly handles waking the device up via
pm_runtime_resume(&pdev->dev).

If the device is in D3, won't accessing the configuration space cause
dropped writes or PCIe bus faults?

>  	vfio_pci_core_disable(vdev);
> =20
>  	mutex_lock(&vdev->igate);

[ ... ]

>  static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
>  			      void __user *uarg)
>  {
>  	struct vfio_device_pci_tph_op op =3D {0};
>  	size_t minsz =3D sizeof(op.argsz) + sizeof(op.op);
> =20
> +	guard(mutex)(&vdev->igate);
> +

Could this ioctl be called while the device is suspended?

Neither vfio_pci_core_ioctl() nor vfio_pci_ioctl_tph() appears to call
pm_runtime_resume_and_get() before dispatching these ioctls.

Since userspace can place the device into a low-power state, accessing
the TPH configuration space registers via pcie_tph_get_st_modes(),
pcie_enable_tph(), or pcie_disable_tph() might read invalid data or
drop writes.

>  	if (copy_from_user(&op, uarg, minsz))
>  		return -EFAULT;
> =20
>  	switch (op.op) {
>  	case VFIO_PCI_TPH_GET_CAP:
>  		return vfio_pci_tph_get_cap(vdev, &op, uarg + minsz);
> +	case VFIO_PCI_TPH_ENABLE:
> +		return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
> +	case VFIO_PCI_TPH_DISABLE:
> +		return vfio_pci_tph_disable(vdev);
>  	default:
>  		/* Other ops are not implemented yet */
>  		return -EINVAL;

[ ... ]

> @@ -2258,6 +2303,9 @@ int vfio_pci_core_register_device(struct vfio_pci_c=
ore_device *vdev)
>  	if (!disable_idle_d3)
>  		pm_runtime_put(dev);
> =20
> +	/* Disable TPH when taking over ownership of the device */
> +	pcie_disable_tph(pdev);
> +

Does this call to pcie_disable_tph() happen after the device may have
already entered a low-power state?

pm_runtime_put() can asynchronously drop the PM usage counter and allow
the device to enter D3.

Shouldn't the TPH disablement occur before dropping the PM reference to
avoid accessing the configuration space of a suspended device?

>  	ret =3D vfio_register_group_dev(&vdev->vdev);
>  	if (ret)
>  		goto out_power;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507130956.3444=
1-1-fengchengwen@huawei.com?part=3D4
