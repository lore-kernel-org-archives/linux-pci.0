Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2203E3C40
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094090; cv=none; b=H5ffw/IoVR/XNyeRkPnrDCb2ms0kDAzw09eLbEQ+XuyqSbHlpj068IgONEp/PcqPYmza/2agow74WQ9DIAIaiMULu2UO+46UmxaQ7RcFYviVgmQoKcX8ZTk0if5YAHZr2mfP5V/xO3pHCL/Jk++hO+PpavZqn1+Blg0nNwBM/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094090; c=relaxed/simple;
	bh=v01/YEy1fmC9/a+bdzrfy97YTZ2AFDYIq9X55flZPAM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UDreLI15VEAEuoiGoWzUHSxBXTR93Sz4hbg+Ws+6DC6SRIwD0lQiNncorIlFoLTJptFbCFLAXaRVh+WwdET/3xMSQXhQCY2xNijkGY7DPx06dMBXnxQL5CpehgHtqcQwa6yz4ro1pvkXjpw9uAcmN2z1qbdnt5CreGLw3zKMgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuO0yTIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuO0yTIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78BDC2BCC6;
	Mon, 18 May 2026 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779094090;
	bh=v01/YEy1fmC9/a+bdzrfy97YTZ2AFDYIq9X55flZPAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PuO0yTIn0p29ZkRK7eSGDckc+zNE2S/1Qf8yKXvbiUYbuHFjcGhJjPtRhzX8ijqqf
	 G0za6ZJAQZX0mWCUoRfOR8J7WC0lyZVSdydk8KSDNElNjCvX2O9e5pEp5z5fW9dD+o
	 Khuegr5yEgjmj8uorb4Sc3Jo/f0PlDdyb3Vz8FWwNFRagV2ArmqRIU2VBtYNksxmR/
	 MSUr+1NXnnoElerxI6jOyfffCblinbyINHxgyO521ay5jbYIWq9Hb99E+nIvMO5NxW
	 ecEg5XqZjIPUHedOFYHS3MoFnLIzhN5z8kCihYTYet3b7pEaJ1OAuyuTADJ29IpScU
	 Gti61LY+LhE7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/5] vfio/pci: Add PCIe TPH configuration space
 virtualization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518071701.25177-5-fengchengwen@huawei.com>
References: <20260518071701.25177-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 08:48:09 +0000
Message-Id: <20260518084809.E78BDC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Unsafe PCI configuration space access during PM state transiti=
on (Race condition leading to Unsupported Request).
- [High] Dropped configuration writes to the TPH capability break ST Table =
and Control Register virtualization.
- [High] Host kernel API overrides the guest's explicit TPH Request Enable =
state, preventing the guest from disabling TPH requests.
--

commit 5ada31d58b6a34d641ac5392c15e54c3404870a2
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH configuration space virtualization

This commit adds support for virtualizing the PCIe TPH control register.
It introduces a module parameter to globally control the TPH feature and
mediates TPH control register writes to only allow valid mode settings.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
[ ... ]
> @@ -313,6 +316,30 @@ static int vfio_virt_config_read(struct vfio_pci_cor=
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
> +	guard(mutex)(&vdev->tph_lock);
> +
> +	if (!enable_unsafe_tph)
> +		return count;
> +
> +	if (offset !=3D PCI_TPH_CTRL)
> +		return count;

Does this function silently discard ST Table and other TPH capability write=
s?

By unconditionally returning count without actually modifying the virtual
configuration space (vconfig) or the physical hardware, guest writes to the=
 ST
Table, the ST Table Select field, or unaligned byte-writes to the control
register are dropped.

Since there is no .readfn, reads will fetch directly from the physical hard=
ware
returning unconfigured values, which could break guest OS configurations.

> +
> +	/* Only permit write TPH mode. */
> +	data &=3D PCI_TPH_CTRL_MODE_SEL_MASK;
> +	if (data =3D=3D PCI_TPH_ST_IV_MODE || data =3D=3D PCI_TPH_ST_DS_MODE)
> +		pcie_enable_tph(vdev->pdev, data);

If the guest clears the 'TPH Requester Enable' field but leaves a valid mode
in PCI_TPH_CTRL_MODE_SEL_MASK, does this call to pcie_enable_tph() override
the guest's request?

pcie_enable_tph() force-enables the feature in physical hardware, which pre=
vents
the guest from disabling it.

Additionally, if the guest changes active modes, pcie_enable_tph() will ret=
urn
-EBUSY and fail silently without informing the user.

> +	else if (data =3D=3D PCI_TPH_ST_NS_MODE)
> +		pcie_disable_tph(vdev->pdev);
> +
> +	return count;
> +}
> +
>  static struct perm_bits direct_ro_perms =3D {
[ ... ]
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -736,6 +738,11 @@ void vfio_pci_core_close_device(struct vfio_device *=
core_vdev)
>  #endif
>  	vfio_pci_dma_buf_cleanup(vdev);
> =20
> +	/* Disable TPH when userspace closes the device FD */
> +	mutex_lock(&vdev->tph_lock);
> +	pcie_disable_tph(vdev->pdev);
> +	mutex_unlock(&vdev->tph_lock);
> +
>  	vfio_pci_core_disable(vdev);

Is it safe to access the PCI config space here?

A malicious or buggy guest could have left the device in the suspended D3 s=
tate.

vfio_pci_core_disable() wakes up the device via pm_runtime_resume(), but
calling pcie_disable_tph() before that could access a suspended device. This
would lead to an Unsupported Request (UR) and potentially a host kernel pan=
ic.

[ ... ]
> @@ -2205,6 +2214,9 @@ int vfio_pci_core_register_device(struct vfio_pci_c=
ore_device *vdev)
>  	if (!disable_idle_d3)
>  		pm_runtime_put(dev);
> =20
> +	/* Disable TPH when taking over ownership of the device */
> +	pcie_disable_tph(pdev);
> +

Could calling pcie_disable_tph() after pm_runtime_put() risk accessing a
suspended device?

pm_runtime_put() drops the runtime PM reference, allowing the PM core to
asynchronously suspend the device to D3. Accessing the config space of a
suspended device violates PCIe semantics.

>  	ret =3D vfio_register_group_dev(&vdev->vdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518071701.2517=
7-1-fengchengwen@huawei.com?part=3D4
