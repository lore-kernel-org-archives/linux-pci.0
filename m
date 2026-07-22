Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3EB3E1713;
	Wed, 22 Jul 2026 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719989; cv=none; b=Ifct3zYKdCY/+7Ey0wiPxB0Zd8fWJnB1m9vte3hfref70IcUqKk1Ta0/7aKVAZL95gYYSXfSww/0UWopgW7XWOyE4eM6CebB/adFbKryo7ZjveixfdEjfo3zWAUnWvg+5bbc62RAWbcNzuzjGwHnok/CBehlSF5Is0gI11n58Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719989; c=relaxed/simple;
	bh=vMc1+1V8K9TmCwlC8DDoCRfNt95/eXlB29jBwd21abM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k2yNBDePgQFuAVDKlbfraxTnI4UuUwMZQYOP+vGDZvw3/r6EKT95S12K6NtN4YomxMYnHl3UZFaAfeFmYLfpX5sg5cfedOw/+kAt0hPgbTz1p6aK0ttkHCiirV7AxBfv7z5XnzsXZVabhuH2LAxKYvg88Hql880lX8xCfuz7T7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7Cs03wU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7Cs03wU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1EA1F000E9;
	Wed, 22 Jul 2026 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784719988;
	bh=TxxsBLufSm++Cvz5kOkT33qzoU4aWSoS8KEmFIitGVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X7Cs03wUc26msWWm3Ejqk08TxEj5JCC7l88rjGwg0w+M10ri2OhoCgMO45a1zFvPV
	 sE/e4WZjtkdXVMoy5ZNsKpFJsBppag5dN+56CF2NZKSl6JQdTXiHA23TdNzRhp6fwc
	 EwuDYTuMJIHWAmy/SPmYaUHneoc3PjOoPQ+iddXmV1jDZBqRBykyYVudpcIaw8pFN1
	 jig0/AqxW+gYzMIv5vTN+mplV/gkGzL3tG5VpGfkCMRkAqOVqECYLnn7pNsS1Urvzu
	 T3Sr5HO9/H6+wRdVdUkfeMImL3WENqkrDRrWgFWZLOkBVMl1IwSXxIhDr2Ry9b6yTZ
	 +WJ3UjAXjWrZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260722111640.1146212-3-devverma@amd.com>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:33:07 +0000
Message-Id: <20260722113308.1F1EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The parsed channel separation size (`ch_sep_sz`) is a dead store; =
it is never passed to the core DMA driver.
- [Medium] dw_edma_get_ch_sep_sz() silently falls back to 256 bytes for uns=
upported hardware channel separation values.
- [Medium] The newly added `ch_sep_sz` field is left uninitialized (implici=
tly 0) for statically defined devices.
--

--- Patch [2]: [PATCH v1 2/3] dmaengine: dw-edma: Enable Chan Separation vi=
a VSEC ---
commit 5d0ec977534da50b8d8937caafb8d91a21d54565
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Enable Chan Separation via VSEC

This commit aims to enable channel separation via the VSEC capability for
DEVICE INFORMATION. It parses the channel separation size from the hardware
registers up to 4K.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index ec5e057a0f11b..6295d01ba2f71 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -73,6 +74,7 @@ struct dw_edma_pcie_data {
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
>  	u64				devmem_phys_off;
> +	u32				ch_sep_sz;
>  };
> =20
>  static const struct dw_edma_pcie_data snps_edda_data =3D {

[Severity: Medium]
Does this leave the newly added ch_sep_sz field uninitialized (implicitly 0)
for statically defined devices like snps_edda_data?=20

If the core driver begins relying on this field to space out channel regist=
ers,=20
will preexisting devices calculate an offset of 0 for all channels and brea=
k=20
DMA functionality?

[ ... ]
> @@ -189,6 +191,23 @@ static int dw_edma_pcie_irq_vector(struct device *de=
v, unsigned int nr)
>  	return pci_irq_vector(to_pci_dev(dev), nr);
>  }
> =20
> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
> +{
> +	switch (ch_sep_val) {
> +	default:
> +	case 0:
> +		return 256;

[Severity: Medium]
If a hardware device advertises a channel separation size greater than 4K
(e.g., 8K/0x5, 16K/0x6, 32K/0x7 as mentioned in the commit message), will
this switch statement silently hit the default case and return 256 bytes
instead of the actual hardware size, leading to incorrect memory offsets?

> +	case 1:
> +		return 512;
> +	case 2:
> +		return 1024;
> +	case 3:
> +		return 2048;
> +	case 4:
> +		return 4096;
> +	}
> +}
[ ... ]
> @@ -324,9 +345,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data *pdata =3D (void *)pid->driver_data;
>  	struct device *dev =3D &pdev->dev;
>  	struct dw_edma_chip *chip;
> +	bool non_ll =3D false;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll =3D false;
> =20
>  	if (!pdata)
>  		return -ENODEV;

[Severity: High]
Is the parsed channel separation size actually used by the core driver?

The VSEC capability is parsed into pdata->ch_sep_sz in this patch, but it
doesn't appear to be copied to the struct dw_edma_chip or used anywhere
to calculate register offsets, leaving the feature non-functional.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722111640.1146=
212-1-devverma@amd.com?part=3D2
