Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECF3A7186;
	Tue, 26 May 2026 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779769899; cv=none; b=hgBf5ZmrbM4HmG5ZfcGHfm8jipSHQHGzFmQB3X2eg165hxHPuh3PZdPA2Dg0a1Fz3/3t4Dbr3bzfXz/leJ+PkCWn+224+XAk//NWN/S8ycZRMiLGOBZ7n/8ww0q50d7xqqykiqrNAyrEv1CMU82Vqe8D0snUcH7LpHFdD0d8hb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779769899; c=relaxed/simple;
	bh=6RnQIGHpeQIVlxqzzYzE6uYM1KIm4SZlzj9Kuk4thd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ER8Rym1olnJCDyuYbNa+7LMKxwKQY2BkY0DbxTNZLcNf70M1ChIaougbqW6YfdBFByR73U2FmutL0cEQyI2m52HV1SvKvPyIQnwECt5mnE7blCm0DAOTt5eLNBtbnkrXWWABaeF9FGPhdlCSzXol+nGBqVBukH6c1XQ5EaTGPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7sy2BB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7sy2BB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3494D1F000E9;
	Tue, 26 May 2026 04:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779769895;
	bh=tljaTvv0fA8n5ojHqWJ2qf4OK0bi1oyUg1k+/OqmkdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7sy2BB3PWyqCFlr0QUluYO3vABJnEXYSHsFS5Ag1cs99C5sP4Ms+3daPw7AB0PsQ
	 lZ9tkipRI5+yiVam/ushytMstZERPCcC9JvYdvsukZzFQaDDI20FiZUinvuGNRfo1g
	 xhrjo+7WqndpVmItahWUdCA0zvODHzI0RhJX0cIL2mq9EArmomG2wC7PIE+6+mKF7h
	 n2U7Vh1mUyR54zOQxTNuiIwLIaNegPS4QtOUkRuWL6vZzaao6HL4Ka+B/aVBBgivQU
	 MYl8gpkrAQxhcPfvEAoRnWpXfe6oExd0V2zdoKDqvOVur5TcmTeEFcn0B3UVeSjI4R
	 e+ydrgMtOSW1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/6] PCI/TPH: Fix pcie_tph_get_st_table_loc() field
 extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260526040830.52854-2-fengchengwen@huawei.com>
References: <20260526040830.52854-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 04:31:34 +0000
Message-Id: <20260526043135.3494D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Exported functions pcie_tph_get_st_table_loc() and pcie_tph_get_st=
_table_size() do not verify that the device actually supports TPH (pdev->tp=
h_cap !=3D 0) before accessing the capability offset.
--

commit 778a377b4fe5a5811f9d4225d057f7de399a56a3
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction

This commit fixes the ST table location detection in
pcie_tph_get_st_table_loc() by using bitwise AND with PCI_TPH_CAP_LOC_MASK
instead of FIELD_GET(). The function was designed to return raw
PCI_TPH_LOC_* values without shifting.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d951..877cf556242b4 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -170,7 +170,7 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> =20
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);

[Severity: High]
This is a pre-existing issue, but should this function verify that the devi=
ce
actually supports TPH (pdev->tph_cap !=3D 0) before reading the capability?

If a device lacks the TPH capability, pdev->tph_cap is 0, which results in a
read of the generic PCI Command & Status registers at offset 0x04. The ST
Table Location mask (bits 9-10) maps exactly to the Fast Back-to-Back Enable
and Interrupt Disable bits in the Command register.

If Interrupt Disable is set (which is standard for MSI/MSI-X devices), would
this incorrectly return PCI_TPH_LOC_MSIX (0x400)? If Fast Back-to-Back Enab=
le
is set, it might return PCI_TPH_LOC_CAP (0x200) and then incorrectly extract
the table size from the PCI Status register in pcie_tph_get_st_table_size().

Since these are EXPORT_SYMBOL APIs, they can be called by external modules
that might not independently validate pdev->tph_cap. This could lead to
falsely detecting TPH support and allocating unnecessary shadow memory.

> -	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
> +	return reg & PCI_TPH_CAP_LOC_MASK;
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526040830.5285=
4-1-fengchengwen@huawei.com?part=3D1
