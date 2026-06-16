Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC07438FEA;
	Tue, 16 Jun 2026 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607417; cv=none; b=Ppmz6ccmZSAwtd1E8+zV6OiYD7yZrIM3Gs3dkSL0cJhyt1KfEAOpjqPVLI4mZ5ngc85VOhdTJjkzGYErdsAIZaV90ivTRQ4F32636ZdVv/swlM+OR4HLvGtPe1Cwc6hwPbcKu9x+h1xasxIgSuV18qB9VdYEJsFlZ9FsvaOzEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607417; c=relaxed/simple;
	bh=4Kw/Fi/UjQOR23uwtxsOimVV34xEYl9LW64yU3WXsOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ncplmuz03ZPn/WoP1rNFvvvpQn+KywFRXIMPT+W8VT/39tc7miSpsoJZVYWx1MLy+BaQq/f2QXzScRg7IlCqjqnVuIjRWMptOW0vrqHYoYiTWt5Cyl9fWwbdGySfY77xvyWMu3lrYikn1jv79AV+WhqfyTzI0WD+Oe9XEaM9a7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m65JPuKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m65JPuKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54F01F000E9;
	Tue, 16 Jun 2026 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607415;
	bh=FmUbbQudSJA0GC2dP7FEolxLxKV6bGxKbFldR4SYmxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m65JPuKCgXcsmgvSMM/2k7cLfRQuP3O7s+SeJIld5Lh1wb0qRQX3Bcnz8QDm+sEcF
	 91a8NNWlzY0vYDIS9w5za4CCcb55y7GrohwP6EJ8oyHsUw2q2+VKwuNbs/HkcHzpNE
	 BaY5ugeBDU6WQSsWHSlhiibYOOHfpEle3tGt6znU1Ri2IXUpCIZq2FX6q5Q+4/UmCn
	 ITFXqAs0ntL2jpK3MTkCTH1fPIQvCxn7OpOzZCSVzYZdY73onAIF9Mjt/sqBaKIWk7
	 2IaiMR8Nwsh6f+s99RXF5w06s8CpG3VM4Zlkpj0NfU+rAmVb+Ym6/VlYWl8OE5DOLE
	 el5HAAjGrkT8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 09/12] vfio/pci: Hide TPH capability when TPH is
 unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260616104621.41915-10-fengchengwen@huawei.com>
References: <20260616104621.41915-10-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:56:54 +0000
Message-Id: <20260616105654.E54F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on dynamically-sized PCIe capabilities al=
lows a malicious device to cause a kernel heap buffer overflow.
--

commit 2b14d080b02da7dcb99b160bf40eeb6f9e38b928
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Hide TPH capability when TPH is unsupported

This commit checks the device negotiated TPH support status before parsing
the TPH extended capability. It returns zero length to hide the capability
from userspace if TPH is disabled during topology negotiation.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..5c6ab172df6c0 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
[ ... ]
> @@ -1450,6 +1451,8 @@ static int vfio_ext_cap_len(struct vfio_pci_core_de=
vice *vdev, u16 ecap, u16 epo
>  		byte &=3D PCI_DPA_CAP_SUBSTATE_MASK;
>  		return PCI_DPA_BASE_SIZEOF + byte + 1;
>  	case PCI_EXT_CAP_ID_TPH:
> +		if (!pcie_tph_supported(pdev, false))
> +			return 0;
>  		ret =3D pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);

[Severity: Critical]
This is a pre-existing issue, but does this function safely bound the retur=
ned
capability length?

Looking at the rest of the PCI_EXT_CAP_ID_TPH case in vfio_ext_cap_len()
in drivers/vfio/pci/vfio_pci_config.c:

    if ((dword & PCI_TPH_CAP_LOC_MASK) =3D=3D PCI_TPH_LOC_CAP) {
        int sts;

        sts =3D dword & PCI_TPH_CAP_ST_MASK;
        sts >>=3D PCI_TPH_CAP_ST_SHIFT;
        return PCI_TPH_BASE_SIZEOF + (sts * 2) + 2;
    }

Since the ST table size is read directly from the attacker-controlled device
config space, the returned length could be up to 4108 bytes.

Later, in vfio_ecap_init() in the same file, this unbounded length is used
to write into heap buffers:

    memset(map + epos, ecap, len);
    ret =3D vfio_fill_vconfig_bytes(vdev, epos, len);

Since the pci_config_map and vconfig arrays are allocated to pdev->cfg_size
(typically 4096 bytes), could a malicious PCIe endpoint or virtual device
provide an oversized TPH capability size to cause a kernel heap buffer
overflow, as there is no check ensuring epos + len fits within pdev->cfg_si=
ze?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D9
