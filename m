Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA435675C;
	Sun, 11 Oct 2026 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791705887; cv=none; b=pXWatM+Gz1w36ogLu2Zge5DYc+lMWZaiB0QZMoSvj+FoFPV6PQTuUKUCJ/uygdr/R4JR4W+litV71cqbEidfhBnzTXIGwTSmF2g225//YoPXRpRc4KMdZBIggDZee/TO7Pomug9ueRfaYZOL8eX9B/pf3Fi+T94MU+ETADlVpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791705887; c=relaxed/simple;
	bh=zSa4FlcSC/EZjyunO45RrRPER4GkM6vtVfB9kCiX+HE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=N6LquFFZLIWlHUoc3j4JyVuX1u6YbRA7wpnF8Zx8+mbsBTew7H5RoH7WeqjWFhnmdhiEP2O6hggKEBQlxf7K4vs54z0HQte62dsaQVqdQRl9RUhGljNbyr213uag5K703oZTZpd0J6puskw8DJQtRdEFtIPB5XouhDBl6GZ8ryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuG0DCVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuG0DCVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F01F0089B;
	Sun, 11 Oct 2026 08:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791705885;
	bh=+y4nxKFlc45EtwdcFQ34pRHZUP16RU/2m/49bCb76E4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UuG0DCVUQvbH7hw9ADlE8QzcKHpAwjTqLN0CI/sY1+Y5pIDJ2GgNorGBqYPqCOF0B
	 YoOtPdqZKztvHNiQWNy+xuuiclRmvqzVnBzExK5qZ5wRJh2rXnGRHbca1OAP5rWITD
	 Hhzzmg5Ah39C11ZJA38mAWywfUpJts47yH5CG+tYtCpsUFvo3bkMmlp+WTtis6mwX/
	 /3+yOukl24m7gnaC60RYHmQBe3UJp1rGyJOaIeSoVfKvmN/Rkg+rkjNpnP4HENGU4M
	 kORQSjs2cy2gfOnOrX05YQqSXnyu96p0+jr4UM8b8wJ1AGsWGKXxM6bLRcit5RXpNr
	 RV1fMugBe+tUg==
Message-ID: <sashiko-outbox-167116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] ath11k: Use VFIO MSI cache when available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261011074514.515894-6-jtornosm@redhat.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <20261011074514.515894-6-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 08:04:45 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ath11k: early return in ath11k_pci_alloc_msi() skips MSI disable
- [Medium] pci: unsafe linear scan of extended config space in qcom_vfio_fi=
nd_msi_cache()
--

commit f45d065c25ccffe5ad5bba4c9805876b528061e6
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: ath11k: Use VFIO MSI cache when available

This commit introduces a mechanism to detect and read physical host MSI
addresses from a cached location in the PCI extended config space. This
allows the device to function correctly when passed through to a VM via
VFIO, avoiding interrupt delivery failures caused by guest IOVA addresses.

> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless=
/ath/ath11k/pci.c
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
[ ... ]
> @@ -487,6 +491,36 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *a=
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

[Severity: Medium]
Is it safe to unconditionally execute this config space scan during every
bare metal probe?

The qcom_vfio_find_msi_cache() function performs a blind sequential read of
the 4KB extended config space:

        for (offset =3D PCI_CFG_SPACE_SIZE;
             offset <=3D PCI_CFG_SPACE_EXP_SIZE - QCOM_VFIO_MSI_SPACE_SIZE;
             offset +=3D 4) {
                if (pci_read_config_dword(pdev, offset, &magic))
                        continue;
                if (magic =3D=3D QCOM_VFIO_MSI_MAGIC)
                        return offset;
        }

Reading arbitrary or reserved extended config registers without checking
capability headers violates PCIe specifications. Might this trigger
unintended side-effects on physical hardware, such as clearing
clear-on-read registers or triggering Unsupported Requests?

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
> +			ab_pci->vfio_msi_cached =3D true;
> +			ath11k_info(ab, "VFIO MSI cache at offset 0x%x: addr_lo=3D0x%x addr_h=
i=3D0x%x data=3D%d\n",
> +				    msi_offset, msi_addr_lo, msi_addr_hi, msi_data);
> +			return 0;

[Severity: High]
Could this early return leave MSI enabled during the remainder of the probe
phase?

Normally, the function calls ath11k_pci_msi_disable(ab_pci) shortly after
this block. By returning early, we skip disabling MSI. As documented in
ath11k_pci_clear_all_intrs():

        /* This is a WAR for PCIE Hotreset.
         * When target receive Hotreset, but will set the interrupt.
         * So when download SBL again, SBL will open Interrupt and
         * receive it, and crash immediately.
         */

If MSI remains enabled here, could the device send a spurious MSI over the
PCIe bus before the IRQ handlers are properly installed, potentially causing
host interrupts or device crashes in a virtualized environment?

> +		}
> +	}
> +
>  	ath11k_pci_msi_disable(ab_pci);
> =20
>  	msi_desc =3D irq_get_msi_desc(ab_pci->pdev->irq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011074514.5158=
94-1-jtornosm@redhat.com?part=3D5
