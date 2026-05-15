Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829AA47B435
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844364; cv=none; b=CQ5DH2zK26B+hl216k/1qcz/jM9/AY5/0S1utN3PB4nKL2Elmr7oMlqDNotJmeuaECmRh83lHcnjq3qMTqkCKV2JfAYC+Qu7ZXSZA982HIjQj7e2SxeGsqnl7bas0JuivxSA7WQTFHLaxDP6oBI+BILGbzCUPdMd5fVNCK4shXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844364; c=relaxed/simple;
	bh=/LZHi44rc23cSc8wdozn8/ZO259B4hlDc6puJPaejnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qK7YB2VH7uTwVv2XkZOHUKd0dxJ+V93mm5IdzbMbkaUPVQWq3TMT3Ywg+oAMccY1bPWimEA4g9WFAxk6wzbXTh0w/vzqL8CwFyNC8SY6qWHvoEgqTwHpnh7HMVqHDKyWAA++IE8P7Pp4IXWeeG0sJbwltebtn2E/xzVHyC0V2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs7NDF65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs7NDF65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43EDC2BCB0;
	Fri, 15 May 2026 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844364;
	bh=/LZHi44rc23cSc8wdozn8/ZO259B4hlDc6puJPaejnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gs7NDF65qFNfTgx1y+OU5jGdL0ICXAfGXFf217sDFBG21TT0rOLDg8ZtJq2me0vce
	 WPGtHiNrKFwpCHxpQEg6g5HkpyqwgCqxZmlvFQNRjbpf/D3f9+kGe3W/xHvUtsgyvE
	 mB5hgg+htqSU4dDrxod7o+D5VzX+R5XG8DVp8IOj5OZvn9gSJcRmKGlk0QbGPHuGQu
	 e/DPFX673DzvcDcX7fM+tR5XE+Z557jChr6uOfa45I2bPlUHtnhHtDPdd50khShTrG
	 oReaYlGWuhzNs46wAcr/LSMBma07d1z8glqsssfg71S1DIPbe/2AUhWGoJ5DeeqO1D
	 0nB+21mgPz2qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/5] vfio/pci: Add PCIe TPH configuration space
 virtualization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515094040.38496-5-fengchengwen@huawei.com>
References: <20260515094040.38496-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 11:26:03 +0000
Message-Id: <20260515112603.C43EDC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Hardware configuration space is accessed while the device may be i=
n a suspended (D3) power state.
- [High] Valid sub-dword (1-byte or 2-byte) writes to the TPH control regis=
ter are silently dropped.
- [High] The guest's requested configuration for the TPH Requester Enable f=
ield is ignored and improperly overridden.
- [High] Unchecked return values from `pcie_enable_tph()` lead to state des=
ynchronization and permanently broken TPH after reset or mode changes.
- [High] Concurrent config space writes to the TPH control register cause d=
ata races on `struct pci_dev` bitfields.
--

commit 11f3d46be6bcfc08d1a080f85c6eb8e89f3bdbb3
Author: Chengwen Feng <fengchengwen@huawei.com>
Subject: vfio/pci: Add PCIe TPH configuration space virtualization

This commit adds support for virtualizing the PCIe TPH (Transaction
Processing Hints) control register in vfio-pci. It introduces a module
parameter to globally control TPH support and mediates TPH control
register writes to only allow valid mode settings.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..907b7a16ac0c6 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
[ ... ]
> @@ -313,6 +316,31 @@ static int vfio_virt_config_read(struct vfio_pci_cor=
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
> +
> +	if (!enable_unsafe_tph)
> +		return count;
> +
> +	if (count !=3D 4 || offset !=3D PCI_TPH_CTRL)
> +		return count;

Does this hardcoded check drop valid sub-dword (1-byte or 2-byte) writes fr=
om
a guest OS attempting to change the ST Mode?

The PCIe specification allows configuration space accesses of 1, 2, or 4
bytes.

> +
> +	/* Only permit write TPH mode. */
> +	data &=3D PCI_TPH_CTRL_MODE_SEL_MASK;

Does masking with PCI_TPH_CTRL_MODE_SEL_MASK ignore the Requester Enable
(REQ_EN) field (bits 8-9)?

If a guest clears REQ_EN to explicitly disable TPH but leaves the ST Mode
non-zero (e.g., IV Mode), data evaluates as non-zero. The handler would
then call pcie_enable_tph(), which forces REQ_EN to the host's supported
value and enables TPH on the physical hardware instead of disabling it.

> +	if (data > PCI_TPH_ST_DS_MODE)
> +		return count;
> +
> +	if (data !=3D PCI_TPH_ST_NS_MODE)
> +		pcie_enable_tph(vdev->pdev, data);

Is it safe to ignore the return value of pcie_enable_tph()?

If a guest attempts to change from one ST mode to another, or attempts to
re-enable TPH after a Function Level Reset (FLR) where hardware registers
are cleared but pdev->tph_enabled remains 1, pcie_enable_tph() returns
-EBUSY or -EINVAL.

Ignoring this might leave the guest assuming success while TPH remains
broken until the device is closed.

Additionally, pcie_enable_tph() and pcie_disable_tph() modify the
tph_enabled:1 bitfield in struct pci_dev. Since VFIO only holds a read
lock during config writes, can concurrent writes to the TPH capability
cause a read-modify-write data race on adjacent bitfields in the same
machine word (such as msi_enabled), potentially corrupting PCI device state?

> +	else
> +		pcie_disable_tph(vdev->pdev);
> +
> +	return count;
> +}
> +
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

Could the device still be in the suspended (D3) power state from previous
runtime PM or guest operations when pcie_disable_tph() is called here,
since it executes before vfio_pci_core_disable()?

Accessing hardware configuration space while the device is in D3 causes
unsupported requests (UR) and master aborts.

>  	vfio_pci_core_disable(vdev);
> =20
[ ... ]
> @@ -2205,6 +2210,9 @@ int vfio_pci_core_register_device(struct vfio_pci_c=
ore_device *vdev)
>  	if (!disable_idle_d3)
>  		pm_runtime_put(dev);
> =20
> +	/* Disable TPH when taking over ownership of the device */
> +	pcie_disable_tph(pdev);
> +

Can pcie_disable_tph() safely access the hardware configuration space here?

Since pm_runtime_put() was called immediately prior, the device may have
already transitioned to the D3 state, which could trigger unsupported
requests if the configuration space is accessed.

>  	ret =3D vfio_register_group_dev(&vdev->vdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515094040.3849=
6-1-fengchengwen@huawei.com?part=3D4
