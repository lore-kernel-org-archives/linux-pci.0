Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FE2931CD
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056708; cv=none; b=aza2tP+wQ2Ik0St58Z4tE1Zmdk3htvQba7/Lci7KgZ9fc2PeERpH28JzUIdSbjUgBJDbP9z4bK5wGGSFxuFRJlwQiSylhjNC3ry3IqNqDkt5acTFSQBYKL1pmknq0Kc7S7v8Dk+giZn/ZkPDHlhnq4VRyrff6VLxP6S0/2zF/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056708; c=relaxed/simple;
	bh=UfqRFxTOy8HKf4dbMgaWroK46M0+KvvYeT7KCbDCzNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fVXA6ctyTAXSnhAwa6QezeqWifL9Cvrh/hZTjvXneG3D9Khey234BbwYx6KqJVa4ooEHcQMy83iH6hgI7j7WmHpek4wWA/WmFHj/YIUNQFeXD15ClH209ImpbpBhpMquBtY6JbxkmEHM9yXwlIF0tXPTJYVqF7rq5zjmQlLZ6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeRrUOdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeRrUOdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA81E1F000E9;
	Tue, 14 Jul 2026 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056706;
	bh=U76vvLHbCXirOTpV+kzJoGnFaQjT6map7W9KtrNtgRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JeRrUOdbnEXs34Q9pN5H7oS4R4tOEJpUDXjdtqimWZ0u/e/eDMTHS5PxeGH2ZDFZA
	 KE3ks90PgmjzjntNoGtLprWW9CT6PIR04BRPyitOG0h5MLLfOIPpnag1p/uOUqtlI7
	 jReiOem2e1bM61obCsETbWPbAld6yFwtLOJZlc/SKF2P/y4t4G8/klrnKS3qrCcNBE
	 SFyZx8RergNQbTQbU3SGmOK5zAMNQpsaGOHrWPVocgwHLPtudAoZbC6ItcEkVpVy1Y
	 o704G4TVb8fpSZEBcCBwcuIChuM1ViKzt0YiNfZO06YVopjzwe2Gy9+RSW6zQX37pR
	 UhfMyfApMzzrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] PCI/FLIT: Ratelimit flit error logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714183950.1620016-6-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
 <20260714183950.1620016-6-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:18:26 +0000
Message-Id: <20260714191826.BA81E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Sysfs Group Directory Leak for devices without FLIT capability.
- [Medium] Missing input validation allows negative burst values, permanent=
ly suppressing flit error logs.

Pre-existing issues:
- [High] Surprise hot-unplug or malicious endpoint causes an infinite loop =
in `flit_isr`, leading to a hard CPU lockup.
--

--- Patch [5]: [PATCH 5/5] PCI/FLIT: Ratelimit flit error logging ---
commit 3a5e2834e7b9f5641abd9dbcf3215773fe5a6904
Author: Yazen Ghannam <yazen.ghannam@amd.com>

PCI/FLIT: Ratelimit flit error logging

This commit introduces a per-device ratelimit state for flit error logging
to prevent console log flooding. It exposes tuning parameters via per-device
sysfs attributes and applies the ratelimiter inside the interrupt handler.

> diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
> index 83cf53f392913..7cb5aff7c552c 100644
> --- a/drivers/pci/pcie/flit.c
> +++ b/drivers/pci/pcie/flit.c
[ ... ]
> +static ssize_t flit_ratelimit_burst_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	int burst;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (kstrtoint(buf, 0, &burst) < 0)
> +		return -EINVAL;
> +
> +	pdev->flit_ratelimit.burst =3D burst;

[Severity: Medium]
Does this allow negative values to be assigned to the burst limit?

If a user writes a negative string (like "-5"), kstrtoint() will parse it
successfully into a negative integer. If burst is negative, the core
___ratelimit() check (rs->burst <=3D rs->printed) will permanently evaluate=
 to
true, which would silently suppress all future flit error logs.

> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(flit_ratelimit_burst);
> +
> +static struct attribute *flit_attrs[] =3D {
> +	&dev_attr_flit_ratelimit_interval_ms.attr,
> +	&dev_attr_flit_ratelimit_burst.attr,
> +	NULL
> +};
> +
> +static umode_t flit_attrs_are_visible(struct kobject *kobj,
> +				      struct attribute *a, int n)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +	if (!pdev->flit_cap)
> +		return 0;

[Severity: Medium]
Because this attribute group has a name (".name =3D "flit""), does returnin=
g 0
here leak an empty sysfs directory for devices without the FLIT capability?

Returning 0 suppresses the individual attributes, but the sysfs core will
still create an empty "/sys/bus/pci/devices/.../flit/" directory. Should
this return SYSFS_GROUP_INVISIBLE instead to suppress the entire directory?

> +
> +	return a->mode;
>  }
> =20
> +const struct attribute_group flit_attr_group =3D {
> +	.name =3D "flit",
> +	.attrs =3D flit_attrs,
> +	.is_visible =3D flit_attrs_are_visible,
> +};
[ ... ]
>  	do {
>  		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, &err_log1);
> =20
>  		if (!(err_log1 & PCI_FLIT_ERR_LOG_VALID))
>  			break;
> =20
>  		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG2, &err_log2);
> -		pci_info(pdev, HW_ERR "  Error Log1: 0x%08x Error Log2: 0x%08x\n", err=
_log1, err_log2);
> +		if (print)
> +			pci_info(pdev, HW_ERR "  Error Log1: 0x%08x Error Log2: 0x%08x\n",
> +				 err_log1, err_log2);
>  		trace_flit_event(pci_name(pdev), cntr_ctrl, cntr_sta, err_log1, err_lo=
g2);
> =20
>  		pci_write_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, err_log1);
> -	} while (err_log1 & PCI_FLIT_ERR_LOG_MORE);
> +	} while (err_log1 & PCI_FLIT_ERR_LOG_MORE);

[Severity: High]
This is a pre-existing issue, but is this loop safe against surprise device
hot-unplugs?

If the device is disconnected, pci_read_config_dword() will fail and assign
~0 (0xFFFFFFFF) to err_log1. Because ~0 has all bits set, the initial check
for PCI_FLIT_ERR_LOG_VALID will pass.

The loop condition checking for PCI_FLIT_ERR_LOG_MORE will also pass, creat=
ing
an unconditional infinite loop that could cause a hard CPU lockup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714183950.1620=
016-1-yazen.ghannam@amd.com?part=3D5
