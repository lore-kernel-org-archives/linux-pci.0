Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1B389106
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959533; cv=none; b=sRjGOrWfBh3reVMFJ+obMzHskVntW2a/5lYimlqnaWaWbJvfEI7/pHPyDvknTyWpZ7WGdXREH7iJT/jUv2RdvAvhrO5LOCnvuDYzOcAsu0+dmTA/X9xjQqEVvFp+rQMEVxKTx/eHGkahzhOZZVmC2Vidoi1/JRb12QMYc+8PqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959533; c=relaxed/simple;
	bh=FtE4otJa0Ru24yq/kC05tfoVqpyJ/HrNt2rV3me53mc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j9Cmh2qpjd34jx4AP210zzm0nsYyGQYm2CDFd/md7qNiRhB0trW1RA1XzaKfrDBStkocbegxbZJU1rupbFZiACgm/ZtxohZA84tl6yCZRSqqTGapPnjR/OVOc/NFe9IyIMkIRANUMxk9mLZTpObK59pQzDqszjNTkKwEEd/MxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDAUG1De; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDAUG1De"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641531F000E9;
	Thu, 28 May 2026 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779959531;
	bh=gcflqZfEBAIcp6dd2itzk/Pd/XMkuWFdvgXBnuSWhiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDAUG1DesN9ej+ebF3lFwqhCX2Io/seVqsra9apT6EcwuGx7eYBp2YEptDd3i0ipr
	 fa5L2akuD3J7jfJhxEYYU6MiQN0TYoobTeA2mM9BB5KWu9ZOSzc8qR/F7oXRsxko7r
	 klDzRPx5H9Khz4ig/raxtCF8eimvEyW3aOITK0iK2d+SVwf4/uEpx00t//vXHQuMcU
	 SRJkklgE/dCGPvEAYgJen1CWr2fXg5Zi4SIaIlz+bEafLVCi2ozq3Qm64A8WbWJ/47
	 KGGOItwsEJjw0qTd4pQh2Be5PWD0EDf7hnxC2on+7O82okrVvFbofzjjOzPKNLSAdG
	 I1MlnMrWKzX+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] cxl/hdm: Add helpers to restore and commit
 memdev decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528083154.137979-2-smadhavan@nvidia.com>
References: <20260528083154.137979-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 09:12:10 +0000
Message-Id: <20260528091211.641531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying CXL HDM decoder base/size registers before ensuring the =
decoder is uncommitted violates the CXL specification and introduces a race=
 condition.
- [High] `cxl_restore_dvsec_range()` propagates positive PCIBIOS_* error co=
des instead of returning standard negative errnos, violating the expected A=
PI contract.
--

commit 9296092c66325a5bcb4efe105b5c2a5e625c1363
Author: Srirangan Madhavan <smadhavan@nvidia.com>
Subject: cxl/hdm: Add helpers to restore and commit memdev decoders

Add helpers to restore endpoint decoder programming for a CXL memdev from
CXL core's cached decoder objects, then commit it as a distinct step.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..f7af1041a9fc2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> +static int cxl_restore_dvsec_range(struct cxl_memdev *cxlmd,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +	struct cxl_decoder *cxld =3D &cxled->cxld;
> +	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);
> +	u64 base =3D cxld->hpa_range.start;
> +	u64 size =3D range_len(&cxld->hpa_range);
> +	u32 lo;
> +	int dvsec =3D cxlds->cxl_dvsec;
> +	int id =3D cxld->id;
> +	int rc;
> +
> +	if (!dvsec)
> +		return 0;
> +
> +	if (id >=3D CXL_DVSEC_RANGE_MAX)
> +		return 0;
> +
> +	rc =3D pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_HI=
GH(id),
> +				    upper_32_bits(base));
> +	if (rc)
> +		return rc;

[Severity: High]
Since pci_write_config_dword() returns positive PCIBIOS_* error codes on
failure, will this function return a positive value instead of a standard
negative errno?

This propagates up to cxl_restore_memdev_decoders(), whose documentation
states it returns negative errno on failure. Callers checking if (rc < 0)
might treat these failures as success. Should this use pcibios_err_to_errno=
()
to translate the error values?

[ ... ]

> +static int cxl_restore_hdm_decoder(struct cxl_hdm *cxlhdm,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld =3D &cxled->cxld;
> +	void __iomem *hdm;
> +	u64 base, size, skip;
> +	u32 ctrl;
> +	int id;
> +
> +	id =3D cxld->id;
> +	hdm =3D cxlhdm->regs.hdm_decoder;
> +	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		return 0;
> +
> +	base =3D cxld->hpa_range.start;
> +	size =3D range_len(&cxld->hpa_range);
> +	skip =3D cxled->skip;
> +
> +	ctrl &=3D ~(CXL_HDM_DECODER0_CTRL_LOCK |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMITTED |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
> +	if (cxld_set_interleave_fields(cxld, &ctrl))
> +		return -EINVAL;
> +	cxld_set_type(cxld, &ctrl);
> +
> +	/* Preserve setup_hw_decoder() programming order, without COMMIT. */
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)=
);
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)=
);
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	writel(upper_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	wmb();
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));

[Severity: High]
Does this violate the CXL specification by writing to the range registers
before ensuring the hardware un-commit is complete?

The code clears the COMMIT bit in the local variable but writes to the BASE,
SIZE, and SKIP registers before writing the updated control register to
hardware. If the hardware decoder was previously committed, changing these
registers is not allowed until the COMMITTED bit actually reads as 0.

Also, since the un-commit is only initiated at the end of this function,
could cxl_commit_restored_hdm_decoder() read the control register before the
hardware finishes un-committing? It might see COMMITTED =3D=3D 1 and return=
 0
without setting COMMIT, leaving the decoder uncommitted and traffic disable=
d.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528083154.1379=
79-1-smadhavan@nvidia.com?part=3D1
