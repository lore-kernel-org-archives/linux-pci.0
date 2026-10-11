Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E783603DD;
	Sun, 11 Oct 2026 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791705599; cv=none; b=tXZx36/XZN/Vpk/rCA/YsxS/HNdnS1fbK3VtGXbGqP/V1YRy+bBDomAJ6E2h3v2SdnCN0SoEdQNQyt7hCYDNP13T4iRn2lFqWXkh7BFfJ6O7mN5X/eZa1Sh42bqgrXjDq0jGEvP6gLBsRm9S2BQsqRBkggvWVkmUnIReIQUSCpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791705599; c=relaxed/simple;
	bh=K21+Au9QTwxBwKsG1IjISlLNTgTSVOo22myO8GATl0w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cDQcUBRhFrBr+SSMFuNAxMuBnqu40K5Y25Vk7F5U00KXojjBX3AQ12YAULEKjS4R3tTHKYhjqevOOjzdDSNCnW2QzPDEFEegztYHRbcha/HXzN9gVEBcp86eiXVPnB3TJCD8dK2k9aUgqRIpNsWf5Gl+dsJC9OSmwsOLbqAVFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ2UCwEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ2UCwEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DA11F0089B;
	Sun, 11 Oct 2026 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791705598;
	bh=Szqw7w746rHZmma5GwdDqmJ51Yf+3iRrZnRWAuogKqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJ2UCwEsDibhivAIeAz81r/CLB5K+4opaxOsOkXDuNwfkxQtvYwperhCPEobjq26+
	 lOz8V2R41t4GfL++GaBBbCBjJ37KazT2fRZF9XY6iWfUJPndH1WjoHOaf4n/pE2cxw
	 PMqbUMzzLaONtWEeu8BNoCAgjc0oRrSmWwuX4LP8K9wUsEHHjrHCnKrr3ugFHv8Dc6
	 5AQl1MMbmiUYLW+QyO0EvPtWBNlv5wpadeszL39Vy1yxysZdnIZ2U6dJxKRa0PYRh8
	 kyi5b7mHNb31onVinE+DI0fTUDzsJEB0WNn57cEGu7uq0DvF+QFA1g98NWsQ1EvJKi
	 qVlSossczGPlA==
Message-ID: <sashiko-outbox-167114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] vfio: Add qcom_vfio.h header for MSI cache
 protocol
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011074514.515894-3-jtornosm@redhat.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <20261011074514.515894-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 07:59:57 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] pci: hardware state overwrite via pci_find_free_ext_cap_offset()
- [High] pci: out-of-bounds config space read in qcom_vfio_find_msi_cache
- [High] pci/vfio: false positive in linear MSI cache scan risks MSI miscon=
figuration
--

commit a4701d60f47321f6e79355d9a8e74d4e1c2789b7
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

vfio: Add qcom_vfio.h header for MSI cache protocol

Add a shared header for the qcom-vfio-pci driver and Qualcomm device driver=
s.
It defines a communication protocol for caching host MSI values in extended
PCI config space with a "QMSI" magic signature for VM discovery. This avoids
offset mismatches when QEMU filters certain capabilities.

> diff --git a/include/linux/qcom_vfio.h b/include/linux/qcom_vfio.h
> new file mode 100644
> index 0000000000000..7553bc382c8e4
> --- /dev/null
> +++ b/include/linux/qcom_vfio.h
> @@ -0,0 +1,90 @@

[ ... ]

> +static inline int qcom_vfio_find_msi_offset(struct pci_dev *pdev)
> +{
> +	return pci_find_free_ext_cap_offset(pdev, QCOM_VFIO_MSI_SPACE_SIZE);
> +}

[Severity: High]
Does relying on pci_find_free_ext_cap_offset() risk hardware state overwrit=
e?

The implementation of pci_find_free_ext_cap_offset() does not skip the size
of the last extended capability. It begins scanning for zeroed registers
immediately at the start of the last active capability. Consequently, it can
misidentify zeroed registers (such as reserved or masked fields) inside
active capabilities as free space.

Using this offset to cache MSI values could overwrite live hardware
registers, causing a regression due to hardware state corruption.
Furthermore, if the extended config space is completely empty, it
incorrectly returns 0 instead of 0x100.

[ ... ]

> +static inline int qcom_vfio_find_msi_cache(struct pci_dev *pdev)
> +{
> +	u32 magic;
> +	int offset;
> +
> +	for (offset =3D PCI_CFG_SPACE_SIZE;
> +	     offset <=3D PCI_CFG_SPACE_EXP_SIZE - QCOM_VFIO_MSI_SPACE_SIZE;
> +	     offset +=3D 4) {

[Severity: High]
Could this loop lead to out-of-bounds config space reads on bare-metal
systems?

The qcom_vfio_find_msi_cache() helper is called directly by the ath11k and
ath12k drivers during normal probe, meaning it executes on bare-metal
systems, not just inside VMs. The loop unconditionally reads up to
PCI_CFG_SPACE_EXP_SIZE (4096 bytes), completely bypassing the dynamic
pdev->cfg_size limit.

The PCI core generic pci_read_config_dword() does not perform bounds
checking against pdev->cfg_size and relies entirely on callers to respect
the boundaries. If the host platform restricts the config space size (for
example, due to a broken ECAM falling back to legacy accesses or a
PCIe-to-PCI bridge), this loop will force reads beyond safe boundaries.

Accessing undefined extended configuration space on bare-metal can cause
regressions like system lockups or fatal PCIe Unsupported Request panics.

> +		if (pci_read_config_dword(pdev, offset, &magic))
> +			continue;
> +		if (magic =3D=3D QCOM_VFIO_MSI_MAGIC)
> +			return offset;
> +	}

[Severity: High]
Is it possible for this linear scan to falsely identify unrelated data as
the MSI cache, leading to misconfiguration?

This linear scan bypasses the PCIe standard capability chain traversal and
blindly reads all extended config registers, including dynamic logs like AE=
R.

If a hardware error occurs and the AER Header Log captures a TLP containing
the value 0x49534D51, the scan will falsely identify it as the VFIO MSI
cache. It would then read the adjacent AER log values as msi_addr_lo,
msi_addr_hi, and msi_data, and program the physical device to use a garbage
MSI address.

This could lead to regressions including data corruption, IOMMU faults, and
loss of network interrupts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011074514.5158=
94-1-jtornosm@redhat.com?part=3D2
