Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947E2472A6;
	Sun, 11 Oct 2026 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685507; cv=none; b=JyTXWoucsUYAGMsOeA3BRgWxYzmJ2oqshWZ8Ra4TMu1SUAYt0Jk/bN0TD9ybKHPvCrczgjqXsoghNxqkFAS5HhaQRLXHx7c4rxf16Dz0ZhQboXfO2vY6gYy75Q4wMTZw4XRu1MHrj5M5xB5D53LW/GOIY27yBwhLRLkBPozHT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685507; c=relaxed/simple;
	bh=T+nzqt4RAeV5Q6aD0jJ1Ws95D3VWy3TuViqssHobR38=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZsgKbC0erpMCtnrKyLu09N/fGvlaCzXkHFWbTCl2GIJFGG02ZZkSug+9FfAZj5SGamGRnfaxsJJz2GYElU5XNi5k3KPQpJCStqBVfkh6HHwDhGpJTWxlo/HagJ6zSuBAzdXi3iuZgiZLpelWwtLTqGmV5BvsS1kZhvwR/cpifHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA88fJBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA88fJBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879301F00893;
	Sun, 11 Oct 2026 02:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685506;
	bh=P5XqPh02HAtiayoldsThJXdyI2i66sA3n5w2W7JJjNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MA88fJBwizcXwPCWJjOTXgd/cnLWKBOob/jGPz97p3kCctQSUCZfsj2jfjNJFFP06
	 MN9aml/+8Mk64u6M2kU9oyAheM2XWGxl1IfD2Tdf6B4ZFrx78DymfF/hDHBvFFbFw+
	 y2y9LDkwqBBoPQheuVHKu0iwT+UDN4oWni09d1aSLYKHoAQVSGbPm54Ay9YIIe23S+
	 o7FBtYLvN8FuRdCyAm0t1hFtPihsgkSIewsZQFaFV+8I2GGJ2D5j4mshHkn+qC2pdh
	 Vsx1kn3cPkW74c71aON2LLfjaa6xAlc893tEfuwEwR30e1fCVGdS9n2Gr8FAMu+YdZ
	 e0xoxwBsRjuEQ==
Message-ID: <sashiko-outbox-166976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 09/16] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011021422.3428136-10-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:25:06 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing MODULE_IMPORT_NS("CXL") in drivers/pci/cxl.c causes modpost=
 namespace warnings.
--

commit 316d4b1d9e38508bd7197a5097af59c2f4cb6fd4
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Cache endpoint HDM state during PCI enumeration
   =20
This commit caches the HDM state in pci_dev->hdm after BAR resource
setup and before driver binding, allowing resets to restore it without
a bound CXL driver. It saves the HDM register location, decoder settings,
and Device DVSEC state, keeping PCI discovery separate from shared HDM help=
ers.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/comm=
it/?id=3Db12baa1105f33cc1a10f9c9c0c6376194397d9f3

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> new file mode 100644
> index 0000000000000..471b57391593e
> --- /dev/null
> +++ b/drivers/pci/cxl.c

[ ... ]

> +static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
> +					  struct cxl_register_map *map,
> +					  resource_size_t *hdm_offset,
> +					  int *decoder_count)
> +{
> +	struct cxl_reg_map *hdm_map =3D &map->component_map.hdm_decoder;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
> +	rc =3D cxl_setup_regs(map);

[Severity: Low]
Does this file need a MODULE_IMPORT_NS("CXL") declaration?

cxl_setup_regs() is exported via EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, "CXL"=
),
and drivers/pci/cxl.c invokes this exported function during device enumerat=
ion.
Because the file lacks MODULE_IMPORT_NS("CXL");, it causes modpost to emit a
namespace violation warning when verifying vmlinux.o imports.

While this does not cause functional runtime failure, it pollutes the build
logs and can cause build failures under strict configurations.

> +	if (rc)
> +		return ERR_PTR(rc);
> +	if (!hdm_map->valid)
> +		return ERR_PTR(-ENODEV);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D9
