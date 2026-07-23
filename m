Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C253859CB
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787932; cv=none; b=oVfWhtHuAfMwGeRoHeTlMh8ZZLWp1zOgRMyQa7n2It4nbiFcAIMZ+/2RvOckGjPCpnulhrEE8oNBbPOo2sesDW9Kk6/yH+4BzmUxX5aSGCX0+2L7fRDsEJd5qB8UPUT4ghWwxFBWVIVY4SBXghUtfiJ1CdHAk2Nu6ioFxnaOi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787932; c=relaxed/simple;
	bh=g6v8KunGx6zlQk8BRmGjPcsPho5sZBE0j8K11fGUrgo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OaeiJUb2LlYIsN0ADSBjryR4yWxfH2+tFBUtMx5ojp4KXi0fnzJou6q/5Qi8MAT+qCPZCuGsG8+HOUa5toqpeRt7UIAxNhEPoTWO2zpd6bh2mWTHMNc3qTedzugomqwcPh+rYP4zgGXD5d06rT6kXGgsbBCzhU+nPfHh3KEfGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWSM9Gnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWSM9Gnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D591F000E9;
	Thu, 23 Jul 2026 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787931;
	bh=ggN1p79uvZMnpBFzNTtq+epaV7zudZzqND4oOH94QOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWSM9Gncv7u5irRN+vAhgfMI6rhpNke46Qm42WIyyYOyXnLsHx6dySxr7q1dR2DrB
	 uCv2pJtVPlWjYjOfSTsLdjZ2MSCfJlRWSAvs+6wkxmo9xhCsRSe/nZ/dfGA4dWtRUi
	 hGhuPBENXuDPxtdjkBBVWkJXozRee/hGXnZpF/hC2tX44c5iOX+E5YFdbmLMKgEtUZ
	 eByFTLUijCY+bXBWqC7gwTKCEujcvJFW3P+PNXvQPjEs+YhXe88wyVinQkKNPFybFG
	 UJBKwRD9sfvw0MZW/w+5JtBUHHqDNy+1ybXFcaNVsqpTC5/dQV2oOldcpllhjMl0nN
	 lBz0wYt1tmkEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
 only
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasant Hegde" <vasant.hegde@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723061548.10187-3-vasant.hegde@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:25:30 +0000
Message-Id: <20260723062531.68D591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] quirks_force_identity_mapping() incorrectly identifies AMD discret=
e GPUs (dGPUs) as APUs, inadvertently forcing them into IOMMU IDENTITY mapp=
ing mode instead of the intended DMA mode.
--

--- Patch [2]: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs=
 only ---
commit 43e3d4caff8faca1297d432e0146e34c6ec99227
Author: Vasant Hegde <vasant.hegde@amd.com>
Subject: iommu/amd: Force identity mode for selected GPUs only

This commit attempts to enforce identity mapping mode specifically for APUs=
=20
while keeping discrete GPUs in DMA mode by checking the upstream bridge=20
vendor ID.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 1e76386e5eb11..a9c7209f1b587 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
[ ... ]
> @@ -3122,6 +3122,32 @@ static bool amd_iommu_is_attach_deferred(struct de=
vice *dev)
>  	return dev_data->defer_attach;
>  }
> =20
> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
> +{
> +	struct pci_dev *root_port;
> +	int class =3D pdev->class >> 8;
> +
> +	/* AMD GPU vendor ID */
> +	if (pdev->vendor !=3D PCI_VENDOR_ID_ATI)
> +		return false;
> +
> +	/* GPU class */
> +	if (class !=3D PCI_CLASS_DISPLAY_VGA &&
> +	    class !=3D PCI_CLASS_DISPLAY_OTHER)
> +		return false;
> +
> +	root_port =3D pcie_find_root_port(pdev);
> +	if (!root_port)
> +		return false;

[Severity: High]
If an APU is implemented as a Root Complex Integrated Endpoint (RCiEP),=20
pcie_find_root_port() will return NULL. Does this cause the function=20
to return false early and leave the APU in DMA mode, which seems to be the=
=20
opposite of the intended behavior?

> +
> +	/* If bridge vendor is not ATI then its APU and force IDENTITY mode */
> +	if (root_port->vendor !=3D PCI_VENDOR_ID_ATI)
> +		return true;

[Severity: High]
Will this correctly distinguish between discrete GPUs and APUs?

Since pcie_find_root_port() traces up to the host's root port, the
vendor ID will typically match the system chipset (like AMD 0x1022 or
Intel 0x8086) rather than ATI 0x1002. Doesn't this mean the condition
root_port->vendor !=3D PCI_VENDOR_ID_ATI evaluates to true for discrete
GPUs, forcing them into IDENTITY mode instead of the intended DMA mode?

> +
> +	/* Rest all are dGPUs and works fine with DMA mode */
> +	return false;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723061548.1018=
7-1-vasant.hegde@amd.com?part=3D2
