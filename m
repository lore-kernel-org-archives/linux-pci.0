Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889672BD59C;
	Tue, 26 May 2026 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773718; cv=none; b=NkGW8B/JJRG60hgalFEpUwfSn8IWcfJ7bB/L6zdl46TxcaeO4+mXIpQW0tk1ppgzONilDFA6XvPuiSFGj404bI638IWYrUcXJY84hPxvVAgQzHHjSzjBWuaCovpqYJvxbuPUPmXu/vS57Puirn5OXsFNBmOuQi55W8+yN1CCV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773718; c=relaxed/simple;
	bh=dS+yRPjxuCH9eURYCBmn2179wOJNLxiFbf+4lAeJ9wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVTFtUSOGoiRhq5O2s7YfJuQX7A7mG156k1LMkQJBj4E4IQMg/1ei4BB26f+1bCwqiClnJ85JdzN3lbyifwV2rNPNZ0TReI5DMPQiJYBIEoMcHR3twlvUmeQocrVi1q+w6R5YrVQPqJKpKRQURu82Y5aJBL0ebiwlLlyWJ/a/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIkoCs7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIkoCs7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC291F000E9;
	Tue, 26 May 2026 05:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779773717;
	bh=jgA2u5j0ckNgiSh3irJR5q9iwXwLn8IRsgK0y0/U6YM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YIkoCs7AZ5v2xQT7IjOI2vTebjrswTHv6dRiA3OTwvUgsDvSoZ1PYWLClplrzuWrY
	 53GOVJyxAXDEeOC32wLa996hsPI1iWx4er44YcqEnDfnJogKDipv+xphowl5XFcY5H
	 L/dHZcBK7VnRZpMO0TQxauoX8CiHjFW/Ag32//pi49UIBIPYz8pr9lXGqIC4EPYNeS
	 tF/Ql0v6pdKCEuPZ97TF9krPciCF63SCD0GDfe94Ib+TTiTxz24G7Cj5xJy65IDkS/
	 a0a1ED0HFrYFfmRNNn+ZCAKMUkXAJMomoEzJ66pLFE04PQInkALXeYwRrNN4cDM+iq
	 9cVXuUpt63iSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 4/6] PCI/TPH: Move tph_req_type initialization into
 pci_tph_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260526040830.52854-5-fengchengwen@huawei.com>
References: <20260526040830.52854-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 05:35:16 +0000
Message-Id: <20260526053516.DAC291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function pcie_tph_set_st_entry() lacks internal serialization,=
 allowing concurrent modifications to the TPH Control Register and violatin=
g the PCIe specification.
- [High] Unprotected modifications to the pdev->tph_enabled bitfield can ca=
use silent data corruption of adjacent pci_dev state flags.
--

commit c7677c01bf11b8624e4ab3ed133719b3aefd9b43
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Move tph_req_type initialization into pci_tph_init
   =20
Relocate tph_req_type resolution logic from pcie_enable_tph() to
pci_tph_init(). The request type is fixed per device and root port topology
at probe time, no need recalculation on each TPH enable.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 95e2a95055eeb..3660ad5d36239 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -371,7 +371,6 @@ void pcie_disable_tph(struct pci_dev *pdev)
>  	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, 0);

[Severity: High]
This isn't a bug introduced by this patch, but does pcie_tph_set_st_entry()
also need internal serialization when writing to the TPH Control Register?

pcie_tph_set_st_entry() temporarily disables TPH via set_ctrl_reg_req_en(),
updates the ST table, and then re-enables TPH.

Network drivers like bnxt call this function from irq_affinity_notify
callbacks, which execute in multi-threaded workqueues.

If multiple IRQ affinities are changed simultaneously, these callbacks can =
run
concurrently on different CPUs for the same pdev.

Without a lock protecting this sequence, could one thread re-enable TPH whi=
le
another thread is still actively updating its ST table entry?

This would violate PCIe r6.2, sec 6.17.3 (which requires TPH to be disabled
during ST updates) and cause overlapping read-modify-write operations on the
TPH Control Register, potentially leading to device instability.

> =20
>  	pdev->tph_mode =3D 0;
> -	pdev->tph_req_type =3D 0;
>  	pdev->tph_enabled =3D 0;

[Severity: High]
This is a pre-existing issue, but can unprotected modifications to the
pdev->tph_enabled bitfield cause silent data corruption of adjacent pci_dev
state flags?

tph_enabled is defined as an unsigned int bitfield in struct pci_dev, shari=
ng
a memory word with critical flags like block_cfg_access, is_busmaster, and
msi_enabled.

Bitfield assignments compile to non-atomic read-modify-write (RMW) operatio=
ns
on the surrounding word.

pcie_enable_tph() and pcie_disable_tph() modify tph_enabled locklessly from
the PCI subsystem's perspective (e.g., bnxt calls it during device open und=
er
rtnl_lock).

If another subsystem concurrently modifies an adjacent bitfield (e.g.,
pci_cfg_access_lock() updating block_cfg_access while holding pci_lock), wi=
ll
the overlapping RMW cycles cause one of the updates to be silently lost,
corrupting the overall PCI device state?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526040830.5285=
4-1-fengchengwen@huawei.com?part=3D4
