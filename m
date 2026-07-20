Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163A2E282B;
	Mon, 20 Jul 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560658; cv=none; b=F3VOzL2DRJ+K/W7MnO6kaIvmuQVzbqeln82H0FDdws2WZj1qK4zqaExaYuNdqI8fVq6lMYYnps9eJz9BxPv1PGhkKpqQQ0jMBM+FkVGUQVtzUJ/PKPkQPwIyAntZbP9bHpt9KrCsvILzcJr/n7bYIZkI3VWXWJ9HLEtre3jKmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560658; c=relaxed/simple;
	bh=bL67cwmyMkFUHL9npoQTriyUWF5SLsJYJJnCS2n9+7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=noEUAZycE9opasl/bgX2q226P0X8mRkevUMPF0kTYunJkKC/59UeffWf+650VJ+4zdkh+gRd1lLc5xlhuPxlfjQig+qsUhZFOz2pGFEw1Ub2L77KyaZKPt+xgdRPltojWcYCPyTX5LQ9rxq3bdc3QLq8KLwsLdfobo0voJLHeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYH+uwBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYH+uwBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9A41F00A3A;
	Mon, 20 Jul 2026 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560652;
	bh=mxxLC8eV66ZKFUyzucpluzk0eXBW6xfbc0sa5+LIdg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYH+uwBNlOne1kOTaBYyJlto6+IxlOYJRC32Nl6/XCOylwNcpH8uqoKpjnldUw8qj
	 x739yphb7/92m5DvbHpzrYgrzjce0y3iOSyWSgrHZj0V6n2myS04tpgE5Hr7ArUV7V
	 3UlFwIDxEg8Cypn0oXCmaI2w3IFni2gXxBdsB/CMuEr1XDhNAn/d+jZnv+UfLv9tSb
	 YhaoLU2iu2y4oiI0pzMhMaBPgiKeuQHUlKa/4YgP/0uu61OqROWcrgrQd3+7eJAhD1
	 iKroxeWDOBB8B38yGhRjDxWFXhRJPk3sGBLfAn6xnVDgpMwrqaDNSIkzKAsRh+mvY8
	 m6J0INEgfUnew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/16] PCI: dwc: Add pcie_cap field and helper in
 designware header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260720150619.24733-2-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:17:32 +0000
Message-Id: <20260720151732.7B9A41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Data race and logically flawed caching in dw_pcie_get_pcie_cap()=
 due to unprotected read-modify-write and failure to cache 'not found' stat=
e.
--

--- Patch [1]: [PATCH v3 01/16] PCI: dwc: Add pcie_cap field and helper in =
designware header ---
commit ab22dc6f534d77b34df13c99dd929771547f5ff1
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Add pcie_cap field and helper in designware header

This commit adds a pcie_cap field to struct dw_pcie to cache the offset of
the PCI Express Capability structure. It introduces dw_pcie_get_pcie_cap()
to perform the capability search on the first call and cache the result.

> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
[ ... ]
> @@ -829,6 +831,21 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_p=
cie *pci)
>  	dw_pcie_writel_dbi(pci, reg, val);
>  }
> =20
> +/**
> + * dw_pcie_get_pcie_cap() - Return cached PCIe Capability offset
> + * @pci: DWC instance
> + *
> + * Finds and caches the offset of PCI_CAP_ID_EXP on first call.
> + * Returns 0 if the capability is not present.
> + */
> +static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
> +{
> +	if (!pci->pcie_cap)
> +		pci->pcie_cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);

[Severity: Medium]
Will this repeatedly search the configuration space if the capability is
not found? If dw_pcie_find_capability() returns 0 when the capability is
missing, pci->pcie_cap will remain 0, causing the search to be repeated
on every subsequent call instead of being cached.

Also, since this helper might be called concurrently by different threads,
could the unprotected read and write to pci->pcie_cap cause a data race?

> +
> +	return pci->pcie_cap;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D1
