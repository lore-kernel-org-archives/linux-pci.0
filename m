Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DC371D1F;
	Tue, 14 Jul 2026 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026647; cv=none; b=Fog7/LljqopsUTtM3fyYxVrgGlIcyrv6koDFbMMGShJQN3Jz9LKErR/vTWiDD+W3mM3V5ntRFNWIy8CV7E65CYOqpfP/RkrkTUuIk0gBNF9TdNVlTmWqHKdNAOFy2I+kgh9p7Il3m4dRzkFISJ3z/oljFz4MVogJJJu3KNmLxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026647; c=relaxed/simple;
	bh=JiIO0eH0v6cLkBxZoNZO2UF1zP7cBTssB5Kxom7QOtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DxizILHE23AxYOXEAYOuw8fBN0iSzvi9drjURYX3MEUXNZEjldmS2KwnpB21l+O70TXEl6JdUsnMuoJPBPzCQSAwRRkBtJONK/AxpBjEmqpPL64+SNIUcZiAl/FdXrOJgVRCZFst50dYuhy0tbjj9PmotXpiu6R74Es9PjDhlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw3QGaWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw3QGaWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F501F000E9;
	Tue, 14 Jul 2026 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026646;
	bh=jhGp7x6ZYz30r5rFDh7E6Awcwob2Mp9bWPM/VWJW7uA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kw3QGaWdxmozHgUjpyRRZr5DJRQi4naMvXSRXCR4D0s+qBYXnMSTbPo1Qnz+jvq07
	 rakQAPksCP6l9SmunCHNcfhxyyW5ul3AB2X3ahWyYeCB2zzy0TkeGyv7B/XBk0UE0Z
	 hkgX5x7qT8oTXila8M4hyAiI2kwgBezx2luBzl8HcGZ33MJpl4vLLqc4hSy2ktsCGo
	 cUWaPTmVctqXXHO0ZVN1G+pSEsv7yLLHVdb3hC6RFDOQ8/w03QgOL60dErP9QIX/hB
	 UpyG2FtCjuKvql+c/McUnFA5SafVZ4oBDxbdKz/T4zNvkCTYHguH5vi63wzMvFbj2O
	 YHCRINx2AkmgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 06/16] PCI/TPH: Cache negotiated max requester type
 at probe time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-7-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:57:25 +0000
Message-Id: <20260714105726.44F501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] get_rp_completer_type() does not validate the Root Port's TPH Co=
mpleter Supported field, allowing a reserved value (2) to be propagated to =
the endpoint's TPH Requester Enable control register.
--

--- Patch [6]: [PATCH v20 06/16] PCI/TPH: Cache negotiated max requester ty=
pe at probe time ---
commit 29ae72049d4aa847803163ffb3618441007a362d
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Cache negotiated max requester type at probe time

pcie_enable_tph() recalculates the TPH requester capability and queries
root port completer type on every invocation, causing redundant config
space reads. Calculate the negotiated maximum requester type once during
pci_tph_init() and cache it in a new pdev->tph_max_type bitfield. Simplify
the enable path by reusing the cached value to eliminate repeated hardware
access.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 41084a45b0bbc..d123f91775c65 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -551,13 +536,31 @@ void pci_no_tph(void)
> =20
>  void pci_tph_init(struct pci_dev *pdev)
>  {
> +	u8 tph_req_type, rp_req_type;
>  	int num_entries;
>  	u32 save_size;
> +	u32 reg =3D 0;
> =20
>  	pdev->tph_cap =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
>  	if (!pdev->tph_cap)
>  		return;
> =20
> +	/* Get req_type supported by device and its Root Port */
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
> +	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
> +		tph_req_type =3D PCI_TPH_REQ_EXT_TPH;
> +	else
> +		tph_req_type =3D PCI_TPH_REQ_TPH_ONLY;
> +
> +	/* Check if the device is behind a Root Port */
> +	if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_RC_END) {
> +		rp_req_type =3D get_rp_completer_type(pdev);
> +		/* Final req_type is the smallest value of two */
> +		tph_req_type =3D min(tph_req_type, rp_req_type);
> +	}
> +
> +	pdev->tph_max_type =3D tph_req_type;

[Severity: Medium]
This isn't a bug introduced by this patch, but this caching logic embeds a
pre-existing issue where get_rp_completer_type() does not validate the Root
Port's TPH Completer Supported field.

If a non-compliant Root Port returns the reserved value 10b (2), could this
unvalidated value be propagated into pdev->tph_max_type and later written
to the Endpoint's TPH Requester Enable control register by
pcie_enable_tph()?

Would writing this reserved value to the endpoint's TPH control register
cause unpredictable hardware behavior or PCIe bus errors?

> =20
>  	num_entries =3D pcie_tph_get_st_table_size(pdev);
>  	save_size =3D sizeof(u32) + num_entries * sizeof(u16);
>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D6
