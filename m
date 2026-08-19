Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D353D6682;
	Wed, 19 Aug 2026 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123996; cv=none; b=GLWyXTuY1JWWAmXd/f4XPdKSj9F4Vw3cihVci8RrCFlW/0ygWOinJnSaWawIlfgqCLb7I0ku3DvC72v2Em1GqJtzQV8DnvzmuiGsAUWk7KtzlavQiPKmQf/oGeSnuIrllqJbi49qPz+xgQbRrePf+7E53zy1gdRaqfPeZv3qwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123996; c=relaxed/simple;
	bh=p02tQNkII1JE1oqoa8s3PEt4wYvGcanMIxBrDE4zD2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQh+triBtID2m2iJlPY5AW7YhqPNmJvLnkJPJKLMWzHTDRW2xbVf1Si9xaNA/4TinMPtqqdR6OP/j/BhOBIznUxg02ppr/AIIdSfSzj9V3NkUkrCJS4WGBOWGVkIlB/39V1b3E+XzbQyCHcn6SgEWtIteULQFuQ9J/4rE4nrKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW5s8TvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW5s8TvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79D01F000E9;
	Wed, 19 Aug 2026 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123995;
	bh=k1REdBtCR5osjYM7lRGUQkr9bPCgV0CRoVXf3VrU7Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mW5s8TvDK3/BlJdSe9sp0udmNqhtmlREcRU6o8BDFFtoG9jtUDNmBJtnG3KL79ZmM
	 Rdji5Wks/TMywA7nmtZYhnWPfdokyE9Il28vJ6losgVtij8hpWKTqDP9rjaJvGsT4u
	 1Ca4iPShLZlmrNXPJhbok7CmrO9LU4rEnGX1rfuL2U0RirqXLxPYVsFogq62m0JFlQ
	 hUk0nzn0wGiO/UdXNCTRdrwR2I38PquPtCoAO0ZlFM9Btgv0XU4QjvevwgzvHHHoWN
	 eBn2RD8hifKbVRN80c9yG5aNp2clne72xDkWPrBTyoGiWYrBBXLgBC3yjgHDeagsQ6
	 GuOAjeQzvUZnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260819070947.4080389-2-devverma@amd.com>
References: <20260819070947.4080389-1-devverma@amd.com>
 <20260819070947.4080389-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 07:19:54 +0000
Message-Id: <20260819071954.D79D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The parsed channel separation size (`ch_space_sz`) is extracted =
from the PCIe VSEC but never read or passed to the DMA core, resulting in d=
ead code and an incomplete feature.
--

--- Patch [1]: [PATCH v4 1/2] dmaengine: dw-edma: Enable Chan Separation vi=
a VSEC ---
commit b605eb99c5a71a0d4b5d7b6b4068f555cc7fee6e
Author: Devendra K Verma <devverma@amd.com>
Subject: dmaengine: dw-edma: Enable Chan Separation via VSEC

This commit extracts the HDMA IP channel separation size from the PCIe VSEC
capabilities. It then stores this parsed size in the driver data structure.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 791c46e8ae4c4..f287879b2cb9e 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct =
pci_dev *pdev,
>  	pdata->mf =3D map;
>  	pdata->rg.bar =3D FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> =20
> +	if (pdev->device =3D=3D PCI_DEVICE_ID_XILINX_B00F)
> +		pdata->ch_space_sz =3D dw_edma_get_ch_space_sz
> +					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));

[Severity: Medium]
Is the extracted ch_space_sz value actually used anywhere after it is store=
d?

The commit message states this enables configurable channel separation, but=
 it
appears that pdata->ch_space_sz is only saved in the driver-private structu=
re
in dw_edma_pcie_get_xilinx_dma_data() and never passed to the DMA core.

The patch changelog notes that the first patch of the original series was
dropped after review. Does this omission leave the core IP driver using its
hardcoded 256-byte layout, making this extracted value functionally inert d=
ead
code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819070947.4080=
389-1-devverma@amd.com?part=3D1
