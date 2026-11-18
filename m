Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999115;
	b=sWQlK9MSjwa2OZ7hnBL9rhDGcMMl9zz+mNhiE6qSF86sfmwRFUCeu3yC3u/InmrkwHhh
	 MRHAinpxOB4SkNVW3FNIAkAENrPeHzYJOOMlpWQspYtoyTXx4QtxgCQJvjRJKk/ypCSIa
	 0yt0gDaVufR5tgjtR+5WQo+gcpWzn/d2j9jjViM51nJJeiydITAoZQpixh06C28LhFRHn
	 jrchGuv+9JVvBquDwvkIs9jSrQKJTU73znwyRiBgSaZnIIaJtyuKuYNgIht0eO5c9966n
	 ww92NlkjSWC9CwWO2vik6trfT0kz/HBACOzuVItD3Rybv1CSBLreOqk1P6NI0HCF3oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p/6E69zGAk8ulfQ3mr072kI9llyzRVNTq3HHzwdAMZA=;
	b=OndpcHFLsMdKPgZN9ZsbA2g3lSXDl0YuWC7J8ilduv1UzTbdD/2ICPH2Q2foCQY8Zpv+
	 PONd955ZqnlXC+BZ23mVTZPjhPoIR8eEm5DiXZ00ciQzsHx956yWVwRVS0XLT1fJ+V8pJ
	 VSQgt1YkW3EVCw7O1Yn3wp1W5ZaZeexaD967HUBinxMjfr9LuWG5ETBqqZGRLoSmhfqp0
	 kEUTLKAcqGIQO9V30PWJzEaae6WGOhDoQ76Gz9SNEWFTtC3iG7RnRJqGt5G6ft5I7swo0
	 dZm3f+gRH7P+HV5Bj1Q0PCHnCatR57JbYtrh7BLTZLZy63835+qKb6xTHZpdICc16pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIwpmjK2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAE606A320;
	Wed, 18 Nov 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIwpmjK2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9701F000C6;
	Wed, 18 Nov 2026 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999115;
	bh=p/6E69zGAk8ulfQ3mr072kI9llyzRVNTq3HHzwdAMZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZIwpmjK2mFH6h4e4mQIv+MvunypRTsJjASAyslCTdKnVWsNPbE5pYp0myKzjAkvT3
	 cyJ0uNEk7rSlahaRDV2IW5SZW2cLpFH4AjfJrmvIXFIKGMuXlRWorRPMgikxtGnrlS
	 pA2e6NX5B56G6EAicoMGnskGaYB+2iI9tLVaECppwnHG4USzEEsP0iyzEPMm4JJKo2
	 n+Ei8WuBI8q8/qGBv1295i9NoBdw4+Wf9KvdTOU/ehlWqpnuyfQyXbNBBWMLWJVE86
	 0QgvYVuWbKom4+SxRF0Lfiv7P2FLHMOgKG/pxA0r8s+J2flWUFLG8YTNUhEWNweJ6T
	 DuemjMB0mR6bA==
Message-ID: <sashiko-outbox-220757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 09/13] vfio/pci: Add basic NO-ST TPH VFIO device
 feature support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-10-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-10-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:51:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vfio/pci: vfio_tph_config_write() fails when
  pdev->tph_enabled is already set
--

commit e4125940aba8b4e82c51ed4d75d938a51d421022
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add basic NO-ST TPH VFIO device feature support

This commit adds VFIO PCI support for PCIe TPH in NO-ST mode, virtualizing
the TPH extended capability and exposing the VFIO_DEVICE_FEATURE_TPH ioctl
for userspace opt-in.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 9914f3ac69aef..3946ed2ec0cfe 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
[ ... ]
> +static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int =
pos,
> +				 int count, struct perm_bits *perm,
> +				 int offset, __le32 val)
> +{
> +	u16 start =3D vfio_find_cap_start(vdev, pos);
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	u32 org_ctrl, new_ctrl, cap;
> +	u8 mode, req, org_req;
> +	__le32 ctrl_val =3D 0;
> +	u16 cmd;
> +	int ret;
> +
> +	if (!vdev->tph_opt_in || offset >=3D PCI_TPH_BASE_SIZEOF ||
> +		offset < PCI_TPH_CTRL)
> +		return count;
> +
> +	cmd =3D vfio_pci_memory_lock_and_enable(vdev);
> +
> +	/*
> +	 * Synchronize the CTRL value of the hardware to the virt. Otherwise,
> +	 * the value will be inconsistent when the device is reset.
> +	 */
> +	vfio_user_config_read(pdev, start + PCI_TPH_CTRL, &ctrl_val, 4);
> +	vfio_default_config_write(vdev, start + PCI_TPH_CTRL, 4, perm,
> +				  PCI_TPH_CTRL, ctrl_val);
> +	org_ctrl =3D le32_to_cpu(ctrl_val);
> +
> +	/* Do write operation to virt. */
> +	ret =3D vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	if (ret !=3D count)
> +		goto out;
> +
> +	/* Reads the TPH_CTRL value after the write operation. */
> +	new_ctrl =3D le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL=
]);
> +	if (new_ctrl =3D=3D org_ctrl)
> +		goto out; /* Exit because there is no change. */
> +
> +	cap =3D vdev->tph_vcap;
> +	mode =3D FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
> +	req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
> +	if (mode !=3D PCI_TPH_ST_NS_MODE || !(cap & (1u << mode)) ||
> +		req =3D=3D 0x2 /* reserved */ ||
> +		(req =3D=3D PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
> +		goto out; /* Drop invalid or unsupported write value. */
> +
> +	org_req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
> +	if (req =3D=3D org_req)
> +		goto out; /* Only care about requester enable. */
> +
> +	if (req =3D=3D PCI_TPH_REQ_TPH_ONLY || req =3D=3D PCI_TPH_REQ_EXT_TPH)
> +		pcie_enable_tph_ext(pdev, mode, req);
> +	else if (req =3D=3D PCI_TPH_REQ_DISABLE)
> +		pcie_disable_tph(vdev->pdev);

[Severity: Medium]
Does pcie_enable_tph_ext() fail here if pdev->tph_enabled is already set?

pcie_enable_tph_ext() returns -EBUSY whenever pdev->tph_enabled is 1, and
its return value is ignored.  If userspace switches directly between
PCI_TPH_REQ_TPH_ONLY and PCI_TPH_REQ_EXT_TPH without an intermediate
PCI_TPH_REQ_DISABLE write, the hardware PCI_TPH_CTRL register is never
updated.

Similarly, if a device reset clears the hardware PCI_TPH_CTRL register to 0
while pdev->tph_enabled remains 1, subsequent writes of PCI_TPH_REQ_TPH_ONLY
or PCI_TPH_REQ_EXT_TPH fail with -EBUSY, and writing PCI_TPH_REQ_DISABLE
exits early at new_ctrl =3D=3D org_ctrl without calling pcie_disable_tph(),
leaving TPH unable to be re-enabled.

Calling pcie_disable_tph(pdev) before pcie_enable_tph_ext() when
pdev->tph_enabled is set would avoid both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D9
