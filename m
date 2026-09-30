Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33104CCDF1;
	Wed, 30 Sep 2026 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778721; cv=none; b=GV9lhr1KszzabNK4WFl7XQPTFJB+S0tUG+Z1Z/puaEor7aPq2nY8dOv8FTVzfAv0qWphejrq7cqU2WADz47uDw0CuFVr2TsWBtaqltoeo9ZcNMyk+Nk69XVhkdFu3AFPbXp+gsiF/CgQWABMuAdnkCOuRJFIJqI7F1gH/maR3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778721; c=relaxed/simple;
	bh=LyM7wxvHhLhsDrGBDwEEDYR28tsNWgkJuFFcVo0o55E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBeMcrXyZgNlZUTPqwKEajdcNGMKKelZ9S+mX6js+FnVFghpITilA+IAkG3y3tGCkdENqqp2wYItIjynYRga/m9K0BI2ruydXXjM2hGFkOW4AR2wg+wWhfo8A6W8gnomdrp9K+dL6+kjs85ZDfy/eqWjOGTfTDO3jqKFeZIfnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzjVQRd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzjVQRd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F62D1F00893;
	Wed, 30 Sep 2026 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778709;
	bh=QtS2X3YldurI0Y0MBsPQHgAN5TykVt3KWFKZ8o9aQ6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzjVQRd/BMSozA7pNtQhycfmrrYzU1c98zbVeuesavaJ2UZQB70qZJownbidb1RFF
	 W99XRgtnCMZAt6ZZalk7WMLplfMSI6omBSakQZ/c8UDfs0bd1rkxH5M26p5Ux7gmkn
	 J0uObqoXcVYCiJKdZ4WV3HCGJ9ChueH/mqUhTlIbUPS8Hbvy4vH8i9jdNO5zcDupFr
	 qil7Vz+XJDXRlqEhhA1Npjtrg9EdHFW64u+S/QnycBNf0cyFMCnvlUYEP/q+JuXN88
	 tuWNIO/JTcI58/BOICz6MomrU/XES310YcQT9mhXf/dbBnwcXtGhZS4dinaeaNeBDH
	 geH0BLcvMLCaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] vfio: Add qcom_vfio.h header for MSI cache protocol
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260930140833.576941-3-jtornosm@redhat.com>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20260930140833.576941-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:31:48 +0000
Message-Id: <20260930143149.0F62D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] vfio: protocol abuses hardware config space risking data corru=
ption
- [High] vfio: blind config space scan causes URs and read side-effects
- [High] vfio: false positive MSI discovery from arbitrary config data
- [Medium] vfio: incomplete MSI cache search bounds silently fails
--

commit e548d5bbb36a1137ddec4454b7d63b995f23989e
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

vfio: Add qcom_vfio.h header for MSI cache protocol

Add shared header defining the communication protocol between
qcom-vfio-pci variant driver and Qualcomm device drivers (ath11k,
ath12k) for passing physical host MSI addresses to VMs.

Qualcomm device firmware requires physical host MSI addresses rather
than guest IOVA addresses. The qcom-vfio-pci driver caches host MSI
values in extended PCI config space with a magic signature "QMSI" for
VM discovery.

> diff --git a/include/linux/qcom_vfio.h b/include/linux/qcom_vfio.h
> new file mode 100644
> index 0000000000000..2ed1ea0c1a604
> --- /dev/null
> +++ b/include/linux/qcom_vfio.h
[ ... ]
> +static inline int qcom_vfio_find_msi_offset(struct pci_dev *pdev)
> +{
> +	return pci_find_free_ext_cap_offset(pdev, QCOM_VFIO_MSI_SPACE_SIZE);
> +}

[Severity: Critical]
Does using pci_find_free_ext_cap_offset() here risk corrupting active
hardware capabilities?

pci_find_free_ext_cap_offset() relies on a heuristic that assumes the last
extended capability is exactly 64 bytes:

drivers/pci/pci.c:pci_find_free_ext_cap_offset() {
    ...
    free_offset =3D last_cap_start + 64;
    free_offset =3D ALIGN(free_offset, 4);
    ...
}

If the final capability is larger (such as AER, DPC, or VSEC), this
allocation would return an offset inside the active capability. Will the
host driver physically writing MSI data to this offset silently corrupt the
device's hardware capability state?

> +
> +/**
> + * qcom_vfio_find_msi_cache - Locate cached MSI data by magic signature
> + * @pdev: PCI device
> + *
> + * VM-side function: Searches extended config space for "QMSI" magic sig=
nature
> + * to locate host-cached MSI values. This avoids offset mismatch when QE=
MU
> + * filters certain capabilities.
> + *
> + * Returns: Offset of MSI data (after magic), or 0 if not found
> + */
> +static inline int qcom_vfio_find_msi_cache(struct pci_dev *pdev)
> +{
> +	u32 magic;
> +	int offset;
> +
> +	for (offset =3D 0x100; offset <=3D 0xf00; offset +=3D 4) {

[Severity: Medium]
Will this loop prematurely terminate and fail to find the MSI cache if the
offset is allocated above 0xf00?

The host driver uses pci_find_free_ext_cap_offset(), which can legitimately
return an offset up to 0xff0 in the 4096-byte PCIe extended config space.
If the cache block is placed between 0xf04 and 0xff0, the guest driver
would silently fail to discover the magic signature.

> +		if (pci_read_config_dword(pdev, offset, &magic))
> +			continue;

[Severity: High]
Does blindly reading every DWORD in the extended config space risk bus
errors and unintended hardware side effects?

Iterating through the configuration space without walking the PCIe
capability linked list means reading active capability registers
arbitrarily. This can trigger unintended read side-effects, such as
clearing Read-to-Clear (RC) status bits.

Furthermore, reading unmapped PCIe configuration space can generate
Unsupported Request (UR) bus errors. On some systems, URs escalate to
Advanced Error Reporting (AER) faults or system hangs.

> +		if (magic =3D=3D QCOM_VFIO_MSI_MAGIC)
> +			return offset;

[Severity: High]
Could this lead to false positive MSI discoveries if active registers or
payloads contain this value?

Since the loop scans the entire config space instead of parsing
vendor-specific capabilities, a legitimate device register, statistics
counter, or VSEC payload might naturally contain the 32-bit value
0x49534D51 (QMSI).

If falsely identified, the guest driver would interpret the subsequent 12
bytes as physical MSI addresses and mistakenly program invalid addresses
into the device firmware.

> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930140833.5769=
41-1-jtornosm@redhat.com?part=3D2
