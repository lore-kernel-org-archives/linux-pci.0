Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B904E50B5;
	Wed, 30 Sep 2026 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782151; cv=none; b=t8457B/BTPSx2KCvVp/pk3vGWQI+D/sqU+xqVyvn43qpPzGT76B/qIOz57o1W2o+gPTakH/Mna2osOn4FrCRa25DQGZ0abzVuCgBIJYkTcWDNvMFAXk6+CugLaOtRKm4lktglO0Hy5W2qQkZfjUf2qSnS9gwgo6PRq9R2sCrGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782151; c=relaxed/simple;
	bh=1PAjXxgNFSKEiVlKNvm7/ZzcpiA6ddBRTLLTxNa1uxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X9kliD2DpfRtjKiRhA/uARDHpyo74Ad+dKt8YQIniclQKEh72XDIYSI5X6vuoTYKaxVJLu8TC7T5S4XNAMW22MDq2f4vVJ8sqH8tBE+sRpya66DxFTadV3wYhrD5hfUCEwMDPSdyHHY2wca0e2TnYGv36xSSG4isMMTSb7gJSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhGB2WG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhGB2WG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571EE1F000FF;
	Wed, 30 Sep 2026 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782142;
	bh=FBj8YD+zBJYlD1qZQv2Nlq97notj5/p8p6iJ2wnueTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhGB2WG08jAc/DoJCQlEL+qqI8onUMEYqXrMnARC4s54FTN4Zsq/1iD36QVEzjwv7
	 GkDTHBjB2xNA6WQBZynG1ErFyj++toTVN41N52EhH5qpMKKYsGiXEkDyq91ubnqgc0
	 8AdGx8bbxBEEPfmxWr/jaqKYcn/SgmajYgQ4H9V6ULIaIUttwgfSwvz/Q5k8KVa2uR
	 jvlayEZsEC506Kb5es5urlRPdQO9ZxSNOedjzrhheZIFIu8nKUAkVQzl2+YyADZpJS
	 Hv7HeKBgbI4E5+DYyVoq7hfJVChy9n2SwkEFdBM0WufAZqqZkhKMsSRvwOi0A4ipEW
	 q4du4H2SiiK7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] ath12k: Use VFIO MSI cache when available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260930140833.576941-8-jtornosm@redhat.com>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20260930140833.576941-8-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:29:01 +0000
Message-Id: <20260930152902.571EE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ath12k: ath12k_pci_config_msi_data() overwrites cached host MSI da=
ta
- [Medium] ath12k: qcom_vfio_find_msi_cache() linearly scans PCIe config sp=
ace
--

commit e6e6b7a0866fae15d51a21b4502b67de316ac9af
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ath12k: Use VFIO MSI cache when available

This patch reads physical host MSI addresses from a VFIO cache exposed in
the PCI extended configuration space, allowing the ath12k firmware to
handle interrupt configuration in virtualized environments.

> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless=
/ath/ath12k/pci.c
> index 65712486d3127..832d3cf652d9d 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
[ ... ]
> @@ -812,6 +816,39 @@ static int ath12k_pci_msi_alloc(struct ath12k_pci *a=
b_pci)
> =20
>  	ath12k_info(ab, "MSI vectors: %d\n", num_vectors);
> =20
> +	/*
> +	 * Try to get host MSI address from VFIO cache.
> +	 * When running on a VM, the ath12k firmware requires physical host
> +	 * MSI addresses and cannot handle guest IOVA addresses.
> +	 * qcom-vfio-pci writes host MSI values to extended config space with
> +	 * a magic signature "QMSI" for discovery. Search for it.
> +	 */
> +	msi_offset =3D qcom_vfio_find_msi_cache(ab_pci->pdev);

[Severity: Medium]
Does this call perform an unsafe and unstandardized linear scan of the PCIe
extended configuration space?

Looking at qcom_vfio_find_msi_cache() in include/linux/qcom_vfio.h:

static inline int qcom_vfio_find_msi_cache(struct pci_dev *pdev)
{
	...
	for (offset =3D 0x100; offset <=3D 0xf00; offset +=3D 4) {
		if (pci_read_config_dword(pdev, offset, &magic))
			continue;
		...

Performing a linear dword-by-dword read of the entire PCIe extended
configuration space violates PCIe specifications. Reading unimplemented spa=
ce
can generate Unsupported Request (UR) errors, potentially triggering Advanc=
ed
Error Reporting (AER) events or system machine checks on certain platforms.

Could this traversal use the standard PCIe linked list of Extended
Capabilities (e.g., standard DVSEC or VSEC headers)?

> +	if (msi_offset) {
> +		pci_read_config_dword(ab_pci->pdev,
> +				      msi_offset + QCOM_VFIO_MSI_ADDR_LO_OFFSET,
> +				      &msi_addr_lo);
> +		pci_read_config_dword(ab_pci->pdev,
> +				      msi_offset + QCOM_VFIO_MSI_ADDR_HI_OFFSET,
> +				      &msi_addr_hi);
> +		pci_read_config_word(ab_pci->pdev,
> +				     msi_offset + QCOM_VFIO_MSI_DATA_OFFSET,
> +				     &msi_data);
> +
> +		if (msi_addr_lo && msi_addr_lo !=3D 0xFFFFFFFF) {
> +			ab_pci->msi_addr_hi =3D msi_addr_hi;
> +			ab_pci->msi_addr_lo =3D msi_addr_lo;
> +			ab_pci->msi_ep_base_data =3D msi_data;

[Severity: High]
Does this cached host MSI data get overwritten shortly after it is saved he=
re?

When the driver probes in a VM, ath12k_pci_probe() unconditionally calls
ath12k_pci_config_msi_data(). In ath12k_pci_config_msi_data(), it directly
overwrites msi_ep_base_data with the guest's virtual MSI data:

static int ath12k_pci_config_msi_data(struct ath12k_pci *ab_pci)
{
	...
	ab_pci->msi_ep_base_data =3D msi_desc->msg.data;
	...
}

Will this defeat the VFIO cache mechanism by replacing the host MSI data wi=
th
the guest's virtual MSI data, preventing the device from receiving hardware
interrupts in a VM?

> +			ab_pci->msi_addr_cached =3D true;
> +
> +			ath12k_info(ab,
> +				    "using host MSI from VFIO at offset 0x%x: addr_lo=3D0x%x addr_hi=
=3D0x%x data=3D%d\n",
> +				    msi_offset, msi_addr_lo, msi_addr_hi, msi_data);
> +			return 0;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930140833.5769=
41-1-jtornosm@redhat.com?part=3D7
