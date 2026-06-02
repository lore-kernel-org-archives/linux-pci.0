Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF32857EE;
	Tue,  2 Jun 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412160; cv=none; b=cE790TacfowXWnWvsgKPavOP2hn1k6HQHZOnXlnmiMr7V/hoU7dOO3hVl8xLDsQ+sUfM+ZFTL4pE24DnUd7ILmKTzcUJIe0LUO84TjIP69+k4BZoXst8+b5O64ufahYJP9+pkTKw/4HnPqFil4CSjIHti748JEUlK9znKBMdZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412160; c=relaxed/simple;
	bh=PkdI0JiAXPNJF4eyUWeov3jAZRa6U5yJjYhGBmqge80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XKgEfHH/yfoEhsnZyJ998MOMSFK8bpsqjrrVGa4mH4rPS2Cdu6uIIuI/9NJw6m9Lucc3MZZySMkEZPPASvNKHYdffVQ5HN/hUgpo0Y0iUcZKrekJ2GuVIZCcT4N9ijCwqQ0Jk4mKlTAZ9ec0xEgUAIxzRGCFOxK8NBx4QomjjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IId0LfOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IId0LfOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F8C1F00893;
	Tue,  2 Jun 2026 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412159;
	bh=VDA+NRjyg2pOPkTfV5N0gM0u4CbGPJwGhs+OI9Q4mko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IId0LfOEUqCao4GZZDoMDDVe08+8AEgWSxJXXgvWvPR1sRGcDj6VjmbF2xO/10ZZR
	 RMM/Oq0a0V4L7U+GnmtJqSiWlDCZQgd1HHCf4oaEq+Rb6aYflOw3k6Qxw+L3imu3Kf
	 qSaEvOngu9cb8094ju4QlB/189TN0Ey3algC9xZv8rYS7U7tGPJuIM82s0eeuw4ALt
	 hnzgUOIJ19V5I0+VYCPekK8MQfbqmEI+GsCuPU7Hhb1gdmK/kprI6dHmvuNA4Pl4VO
	 I3w6h78Rs8SC8eupIEEUtWLn2MYeisxw0/M7b8O/jqZSziR3ohmJuLuzTzf9brHcDl
	 AdEPrjucq1WsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 04/10] PCI/TPH: Refactor pcie_enable_tph & add
 explicit requester variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260602144023.25254-5-fengchengwen@huawei.com>
References: <20260602144023.25254-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:55:58 +0000
Message-Id: <20260602145558.F3F8C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless modifications and TOCTOU races on TPH state and hardware =
registers.
--

commit 9289dcc78e41909614fcdefa75658ec5d86a7bbb
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant

This commit extracts the core logic of pcie_enable_tph() into a static
helper that accepts an explicit requester type. It retains the original
function as an auto-selecting wrapper and adds pcie_enable_tph_explicit()
for VFIO TPH support.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index b4ecc510033ab..bb60f83885bca 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -401,10 +385,11 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  	if (!((1 << mode) & dev_modes))
>  		return -EINVAL;
> =20
> -	pdev->tph_mode =3D mode;
> +	if (req_type =3D=3D PCI_TPH_REQ_EXT_TPH && !pdev->tph_ext_requester)
> +		return -EINVAL;
> =20
> -	pdev->tph_req_type =3D pdev->tph_ext_requester ? PCI_TPH_REQ_EXT_TPH :
> -						       PCI_TPH_REQ_TPH_ONLY;
> +	pdev->tph_mode =3D mode;
> +	pdev->tph_req_type =3D req_type;
> =20
>  	/* Write them into TPH control register */
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
> @@ -413,7 +398,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  	reg |=3D FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, pdev->tph_mode);
> =20
>  	reg &=3D ~PCI_TPH_CTRL_REQ_EN_MASK;
> -	reg |=3D FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);
> +	reg |=3D FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, req_type);
> =20
>  	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);

[Severity: High]
This isn't a bug introduced by this patch, but does this read-modify-write
sequence on the shared PCI_TPH_CTRL hardware register require mutual exclus=
ion?

The TPH configuration functions, such as enable_tph(), perform read-modify-=
write
sequences on the shared PCI_TPH_CTRL register without locking. I see that
other functions like pcie_tph_set_st_entry() (which invokes
set_ctrl_reg_req_en()) can be called from IRQ affinity notifiers that execu=
te
concurrently on different CPUs via workqueues for different interrupt vecto=
rs.

If these read-modify-write sequences are interleaved, could it cause hardwa=
re
state corruption where one thread's enabling of TPH overwrites another's
disabling? This might violate the PCIe specification that TPH must be disab=
led
while updating the ST table.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602144023.2525=
4-1-fengchengwen@huawei.com?part=3D4
