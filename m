Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F54D98EB;
	Wed, 30 Sep 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780945; cv=none; b=U82Ooxw5T23FJGv/Ra2qurYcBALYSqmI4CknBq3TAUamrFBFOGnpne63vSCD2mOdb7l/d2yvVIHyfgtCOwHP/dojRyD1NspSr/79ouw0eXP7Dwav1jQJvlOwyB5wvop5oAqyGInQVOT/a8ch4e2AiaMHn05j9UA9ecIEFoJnNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780945; c=relaxed/simple;
	bh=e8Phd42DTJdLAnGLVfXXimqbeDjLtZbbv+CnDmezlco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tjZke8h2Vex4oHJqia2qxBBPvVSslJDeox8de2FzXrmKtr39dZDK2fJZPnGQ5pqeBVtol1RO9wno416Pv69ZTb8VcNOjuk2YnqYVxAoRy+p949hxd9JH8De0s/LEz89lR76Z2fjcEoxXvSDucRIBpqQdsjvaAP+UgtpQV8DE0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnI098zD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnI098zD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED211F00898;
	Wed, 30 Sep 2026 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780936;
	bh=wvd2NOR9cMCtk5nzpD8yt3d4Z4we1096f0lVjvDem4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnI098zDEckYskRLMdmy1V8DH6dCuRp4LejDojkyG4KW/Edwaak9/orOaNl9ewKjm
	 t22INuSWaP3I5GOD7MCuZ+caT/lP1azYLtl90+DPfMy7nBTT0JL1Q6SGDxj4vyouQv
	 pjXAWr2+ReyAYg2IP2LEqspEI3vdjxvmh34RWpGp+yunBEQqB723wGY5CYeWWovujv
	 zxsYSkgov8E58/cw6HsR83GURTL/CqjSLm7AmTDOFEhRgJjzM+od9CHJclQ6f3phU+
	 afziWPpg1Mpfe8A6PO8VIAHM6veBTy/tiycCnCvdM6BuBcQ3KZoQs7+30t84DFKeqO
	 wXfUXNOU26Wvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] ath11k: Use VFIO MSI cache when available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260930140833.576941-6-jtornosm@redhat.com>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20260930140833.576941-6-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:08:56 +0000
Message-Id: <20260930150856.8ED211F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] ath11k/pci: guest MSI data unconditionally overwrites host VFIO ca=
che
- [Medium] ath11k/pci: early return bypasses ath11k_pci_msi_disable()
- [Low] PCIe: linear scan of extended config space risks side effects
--

commit fb991301d679c8e835b3eb00875de8e25f6d571d
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ath11k: Use VFIO MSI cache when available

This patch adds support for reading cached host MSI values from the PCI
extended configuration space when running in a VM via VFIO. This allows the
firmware to receive physical host MSI addresses rather than guest IOVA
addresses.

> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless=
/ath/ath11k/pci.c
> index c372676b097f5..99a3a709831c1 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
[ ... ]
> @@ -488,6 +492,35 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *a=
b_pci)
>  	}
>  	ath11k_info(ab, "MSI vectors: %d\n", num_vectors);
> =20
> +	/*
> +	 * Try to get host MSI address from VFIO cache.
> +	 * When running on a VM, the ath11k firmware requires physical host
> +	 * MSI addresses and cannot handle guest IOVA addresses.
> +	 * qcom-vfio-pci writes host MSI values to extended config space with
> +	 * a magic signature "QMSI" for discovery. Search for it.
> +	 */
> +	msi_offset =3D qcom_vfio_find_msi_cache(pci_dev);

[Severity: Low]
Does this unconditional linear scan of the extended configuration space risk
unintended hardware side effects?

Calling qcom_vfio_find_msi_cache() loops over the entire extended
configuration space reading 4 bytes at a time instead of using the standard
PCIe capability linked-list traversal.

This could trigger side effects if there are clear-on-read registers present
in the configuration space.

> +	if (msi_offset) {
> +		pci_read_config_dword(pci_dev,
> +				      msi_offset + QCOM_VFIO_MSI_ADDR_LO_OFFSET,
> +				      &msi_addr_lo);
> +		pci_read_config_dword(pci_dev,
> +				      msi_offset + QCOM_VFIO_MSI_ADDR_HI_OFFSET,
> +				      &msi_addr_hi);
> +		pci_read_config_word(pci_dev,
> +				     msi_offset + QCOM_VFIO_MSI_DATA_OFFSET,
> +				     &msi_data);
> +
> +		if (msi_addr_lo && msi_addr_lo !=3D 0xFFFFFFFF) {
> +			ab->pci.msi.addr_lo =3D msi_addr_lo;
> +			ab->pci.msi.addr_hi =3D msi_addr_hi;
> +			ab->pci.msi.ep_base_data =3D msi_data;

[Severity: High]
Will this host physical MSI data be unconditionally overwritten later during
the probe sequence?

After ath11k_pci_alloc_msi() correctly sets ab->pci.msi.ep_base_data from t=
he
VFIO cache, the probe sequence in ath11k_pci_probe() continues.

Later, ath11k_pci_probe() calls ath11k_pci_config_msi_data() which does thi=
s:

ath11k_pci_config_msi_data() {
        ...
        ab_pci->ab->pci.msi.ep_base_data =3D msi_desc->msg.data;
}

This appears to overwrite the host MSI data retrieved from the VFIO cache
with the guest virtual MSI data, which could break interrupt delivery in VM=
s.

> +			ath11k_info(ab, "VFIO MSI cache at offset 0x%x: addr_lo=3D0x%x addr_h=
i=3D0x%x data=3D%d\n",
> +				    msi_offset, msi_addr_lo, msi_addr_hi, msi_data);
> +			return 0;

[Severity: Medium]
Does returning early here skip ath11k_pci_msi_disable() and leave the device
in an inconsistent initialization state compared to the bare-metal path?

By bypassing the ath11k_pci_msi_disable(ab_pci) call just below, the device
is left with MSI enabled prematurely in the PCI configuration space.

> +		}
> +	}
> +
>  	ath11k_pci_msi_disable(ab_pci);
> =20
>  	msi_desc =3D irq_get_msi_desc(ab_pci->pdev->irq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930140833.5769=
41-1-jtornosm@redhat.com?part=3D5
