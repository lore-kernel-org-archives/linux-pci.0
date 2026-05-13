Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E336F8EB
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706360; cv=none; b=VnDA+66Vadn1LtenDcOroCQiQm4x83t8jbWckU0OBOssvRevDPmsrkIygrCF2DU5DCIRG0gZUuHqCYCWb+0VJ20HvSXqjkFi0DTHmwBu1UIosXlHVjl0tqiy+/xO4M/jurIUoG50ZHPlgPjrejiR/UqIY1ozp8n1mT+Muew8p2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706360; c=relaxed/simple;
	bh=YJUDZCocSPa/5vYv0pjJtraKotnhCzR0nvUxjKRwXj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IYHZgmB8f+WqTcJo7m6GWQCgLIuaMvg5rdzWcIv8eUABAYUJfcjqO7i9HJX2Skd5NsbzzU2nXW2G2mwCEJnIcZP7GREqRLyqkEmYfkTqzzkmSIr/ckTTd0nBOpk0ubfY9vHjNyqsbtPo0G5n1xn81qJtmmweU36Ij9GpDeaqVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2cUyO50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2cUyO50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CE0C19425;
	Wed, 13 May 2026 21:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778706359;
	bh=YJUDZCocSPa/5vYv0pjJtraKotnhCzR0nvUxjKRwXj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d2cUyO50PmP4lbkbF/U+Sh1Y/cayof9HOQm5JEE4cOyjUHreTCyJF0QQdjdwxBvFI
	 5kyDTFMZiF9dwxl0XaW3aX+vGV9MrxfQx6TvPsd1wdE//FwHRD+0Rn63lvZcjvXWYq
	 1/Jvqlz30LR2ZOpsdfNh8TZjR2gBO2r9YWcSRYBXRxFE1+VncY6H9VPzRr57VJc55/
	 gWg46WGpDaMu0zzfZvCsgbu06DbYG/XeDsjHlSav+CrRbUtxQH63zVYr9ELKEhcAFR
	 WN0HXvabAH7l99REcxTO2EUKj2wJhmZhS7PL3Iq4UxhT7wP4TM6FOdFebGJUMYjUA8
	 i24WI5j0DpFLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] vfio/pci: Add PCIe TPH configuration space
 virtualization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512080329.42593-5-fengchengwen@huawei.com>
References: <20260512080329.42593-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:05:58 +0000
Message-Id: <20260513210559.80CE0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Concurrent userspace config writes cause data races that corru=
pt struct pci_dev bitfields.
- [High] pcie_disable_tph() is called on a suspended device, causing invali=
d PCI configuration space accesses.
- [High] Returning error codes from the config write function fails the `pw=
rite` syscall, breaking VM migration and restoration.
- [High] Idempotent or read-modify-write operations on the TPH Control Regi=
ster by the guest fail with a fatal error.
- [Medium] TPH mediation logic completely ignores the guest's requested Req=
uester Enable state.
--

commit 273d5243ed79b3842db13976044c596f4d95a83f
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH configuration space virtualization

Add support for virtualizing the PCIe TPH (Transaction Processing Hints)
control register. TPH may break platform isolation, so add a module
parameter "enable_unsafe_tph" to allow administrators to globally control
this feature.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..efb413ce78170 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c

[ ... ]

> @@ -313,6 +316,35 @@ static int vfio_virt_config_read(struct vfio_pci_cor=
e_device *vdev, int pos,
>  	return count;
>  }
> =20
> +static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, =
int pos,
> +				     int count, struct perm_bits *perm,
> +				     int offset, __le32 val)
> +{
> +	u32 data =3D le32_to_cpu(val);
> +	int ret;
> +
> +	if (!enable_unsafe_tph)
> +		return -EOPNOTSUPP;
> +
> +	if (count !=3D 4 || offset !=3D PCI_TPH_CTRL)
> +		return -EINVAL;

Will returning negative error codes like -EOPNOTSUPP or -EINVAL here propag=
ate
to the pwrite() syscall and abort VM migration?=20

During state restoration, hypervisors typically restore the entire config
space, including read-only and unsupported capability fields. Should these
writes be silently dropped by returning count instead?

> +
> +	/* Only permit write TPH mode. */
> +	data &=3D PCI_TPH_CTRL_MODE_SEL_MASK;

Does this logic ignore the guest's requested Requester Enable state?

The TPH Requester Enable field is in bits 8-9 of the TPH Control Register,
but this masks the data using the ST Mode mask (bits 0-2). If a guest OS
tries to disable TPH by clearing the Requester Enable bits while leaving ST
Mode unchanged, won't this mistakenly see the non-zero mode and call
pcie_enable_tph()?

> +	if (data > PCI_TPH_ST_DS_MODE)
> +		return -EINVAL;
> +
> +	if (data =3D=3D PCI_TPH_ST_NS_MODE) {
> +		pcie_disable_tph(vdev->pdev);
> +		return 4;
> +	}
> +
> +	ret =3D pcie_enable_tph(vdev->pdev, data);

Can concurrent userspace config writes cause data races here?=20

Since this is invoked during the pwrite system call without holding a
device-level lock, concurrent calls to pcie_enable_tph() or
pcie_disable_tph() will perform unprotected read-modify-write operations on
pdev->tph_enabled.=20

As tph_enabled is a C bitfield adjacent to other critical bitfields like
msi_enabled, could this clobber unrelated PCI features?

> +	if (ret)
> +		return -EIO;

Could this cause a fatal error if the guest OS performs an idempotent write?

If the guest OS performs a read-modify-write on the PCI_TPH_CTRL register
when TPH is already active, pcie_enable_tph() returns -EBUSY. Returning -EIO
here would propagate to userspace and likely crash the VM.

> +	return 4;
> +}

[ ... ]

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f8d093aacf8a..cc13fc8eea9da 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -736,6 +738,9 @@ void vfio_pci_core_close_device(struct vfio_device *c=
ore_vdev)
>  #endif
>  	vfio_pci_dma_buf_cleanup(vdev);
> =20
> +	/* Disable TPH when userspace closes the device FD */
> +	pcie_disable_tph(vdev->pdev);
> +
>  	vfio_pci_core_disable(vdev);

Is it safe to call pcie_disable_tph() here before vfio_pci_core_disable()
wakes the device?=20

If the device is currently in a suspended low-power state (D3), calling
pcie_disable_tph() will write to the config space, which could cause
Unsupported Request (UR) Master Aborts on the PCIe bus and trigger AER
faults.

> =20
>  	mutex_lock(&vdev->igate);

[ ... ]

> @@ -2205,6 +2210,9 @@ int vfio_pci_core_register_device(struct vfio_pci_c=
ore_device *vdev)
>  	if (!disable_idle_d3)
>  		pm_runtime_put(dev);
> =20
> +	/* Disable TPH when taking over ownership of the device */
> +	pcie_disable_tph(pdev);
> +
>  	ret =3D vfio_register_group_dev(&vdev->vdev);

Could this also access the config space of a suspended device?

pm_runtime_put() is called right before this, which allows the device to
suspend. Writing to the TPH Control Register while the device is in D3
would violate physical state machine constraints.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512080329.4259=
3-1-fengchengwen@huawei.com?part=3D4
