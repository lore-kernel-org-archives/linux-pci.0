Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98F471266;
	Tue,  1 Sep 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256582; cv=none; b=hBXHDucWJEqdcLCYEbhWe4hKwCH22bPtYxbEQgq20+obsmGzyk219sPM9ywS9gkjq5Nqy6p4r6netOUff3x//E/r0iTby3gLK0YOcPpBzAxOe6wURHN1UC4aRSUOQO6nQsxdJDyKCXVuYID3XRZVne7eb79I7u0w0CvnqrLCSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256582; c=relaxed/simple;
	bh=p+qqUyIYzPvN6EPytZtDZJSeddOocTKzuzk4q9eQu5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gNClhMTp8kTQY2B1wzlGHrF8kz5Pt1xaPEP7IjtrLVXsZz46MTzSWB3BU+cXAZjamp05qaRjk/vEQLdiRtrUy9+8BZzUKnUCCUzq9/Vr8ZrrIbGFd0XJ3+jr9hiczz0UQO4/kT+37Gc/Zh8x8WOoaEhuj70FY/FRp7ktBz08mJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byia3kaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byia3kaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FC91F00A3D;
	Tue,  1 Sep 2026 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256581;
	bh=NokG16Pfx7QC5eSHV8Hve9+a28TGoDCESTmamb4WYz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Byia3kaKqVKAvxfc8HOhF4LCKhMX/gXQyiCS1LbY1gKx2AgWI/WubedzY0NHzfSEZ
	 6ZKke8ZB32A7VkzVHkAZyPKkOOvlZfPAzbbMDF1S5ZuTEdFOhISbZa3IbkWmhMPPhw
	 ykx50mfthD5H2yDgK4KEh7RFWUaTywx9vnGj/9EdBex3NxyjNEQbp5BIknbIfR7v9f
	 z89L+YVPLv4tFVH+2o3G0+BVGaNL2n8Asob8OneDoIOLAUkRyetwmxv8Pr5tsSnPUf
	 NdHk/Zitac6KxqgsK0nLW34TGMvQ+AdbYZH9rKpvBSoikj/s45gA7vueqgKBOBvb5O
	 DhVAB9I2quVmQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 18/19] vfio/pci: Coordinate generic device access
 with host recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-19-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-19-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:56:20 +0000
Message-Id: <20260901095621.30FC91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Writing a reserved bit (INTX_DISABLE) to the PCI Command registe=
r on pre-PCI 2.3 devices during AER resume.
--

commit 61aa3eda44efb78a0975edb523d9adc67f239efa
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Coordinate generic device access with host recovery

This commit wires up error_detected() for generic vfio-pci devices that
have opted into host recovery. It safely coordinates with the host by
blocking device access, draining running requests, revoking mappings,
and stopping bus mastering.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index eed0430c32ee6..2d757d6a5fe1b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -2746,14 +2746,178 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(=
struct pci_dev *pdev,
>  {
>  	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
>  	struct vfio_pci_eventfd *eventfd;

[ ... ]

> +	ret =3D pci_write_config_word(pdev, PCI_COMMAND,
> +				    vdev->pci_recovery_command &
> +				    ~PCI_COMMAND_MASTER);
> +	if (ret)
> +		goto out_failed;
> +
> +	vdev->pci_recovery_command_valid =3D true;

[Severity: Medium]
Will this correctly handle pre-PCI 2.3 devices during AER resume?

Here vdev->pci_recovery_command_valid is set to true for devices even when
the device lacks PCI 2.3 support. Later, during resume, if this flag is tru=
e,
it appears vfio_pci_intx_recovery_command() in drivers/vfio/pci/vfio_pci_in=
trs.c
is invoked and applies the INTX_DISABLE bit unconditionally if the logical
context is masked:

drivers/vfio/pci/vfio_pci_intrs.c:vfio_pci_intx_recovery_command() {
    ...
    if (ctx && ctx->masked)
        command |=3D PCI_COMMAND_INTX_DISABLE;
    ...
}

Since pre-PCI 2.3 devices do not support INTX_DISABLE, could this write a
reserved bit to the PCI Command register on legacy hardware and cause
undefined behavior?

> +	goto out_memory;
> +
> +out_failed:
> +	WRITE_ONCE(vdev->pci_recovery_flags,
> +		   (vdev->pci_recovery_flags | VFIO_PCI_RECOVERY_FAILED) &
> +		   ~VFIO_PCI_RECOVERY_IN_PROGRESS);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D18
