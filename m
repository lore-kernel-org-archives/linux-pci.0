Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF129BDBF;
	Mon, 20 Jul 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560794; cv=none; b=Ba0miQCHITsSGhSJRW3dSs3JJbu19Vbo7+j0LBey4doyMTf3UNb9FzMgjRg6uSZ2Q2tiUdLKottfb4e33fWUr7rhsMzMqFjaP8STn8zXyIjwSLrknZ7O/3r3kAKb02KooRmCqhnth1ezw6TGMPrYHJWQHvl9QFFCw7bkKe4XA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560794; c=relaxed/simple;
	bh=kyB7NVODiWaRCg2lYTNpUSRXz7RC9zgrYyYCmcI/xo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U9VQxLvxsRqCtPlEoXJda69niVws3hgl09mKdjv3R9fWHqKFkhhflwCnsVDP5szN1saYyCd1Qaep+ys4iNgbMQ/fusiaNdbtGxpfk8fXm/8F6RA7krMIy/wMaXyH605hqUFRQ+5RLRzdmhBY97X1FkPwO8saQAqD10P5sAWMdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFd++oL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFd++oL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2BF1F00A3A;
	Mon, 20 Jul 2026 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560793;
	bh=sQmSXD0739fsNdmNYjSP3MawCSiQllwIQnGyyfhhTv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GFd++oL3rilWcDeFxUH0TGprXPkkTKlFjixJDEiHmC7+nYH2l+LV1xAH3RG+sQS9U
	 Ctu5qR/qIjLaRq9/I8fX7DGwKVKJIgpfO09vpUsKCtdglkxOtU1xXjJ934m49VbwSo
	 x6oeltyZUuTGBkAl1ha4/bY1sVviHrHV6Ta8p/g1Dawu0VsBRCdZBxoyF5PDYXPPcN
	 BE0+YRnLZEElSsbX2YUpD4WAYfzP8jI3w28hPWs/oGbvu2bBOkBhMdEbX+KZPtMgYU
	 W6ni6hsV66nrcag2ABO3wal+yYT2jniZZ3ULh+U9W2guwRA/feM8nKN6zK1O/Z5zkh
	 mNP+adlqOzZkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/16] PCI: dwc: qcom: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260720150619.24733-12-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-12-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:19:52 +0000
Message-Id: <20260720151953.0B2BF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `pci->pcie_cap` field remains uninitialized (0) when used in `=
.post_init` callbacks, leading to corruption of the standard PCI configurat=
ion header.
--

--- Patch [11]: [PATCH v3 11/16] PCI: dwc: qcom: Use cached PCIe capability=
 offset ---
commit ddf8caa0039918520481c1cff7b9e80cbf8ee212
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: qcom: Use cached PCIe capability offset
   =20
This commit updates the Qualcomm PCIe driver to use the cached PCIe capabil=
ity
offset (pci->pcie_cap) instead of repeatedly calling dw_pcie_find_capabilit=
y().
It aims to optimize capability lookups during initialization and link updat=
es.

> dw_pcie_host_init() caches the offset after .init, so .post_init callbacks
> and later functions (.link_up, icc_opp_update) can use pci->pcie_cap
> directly. For .init itself, we must call dw_pcie_get_pcie_cap() inside
> qcom_pcie_host_init() to obtain the offset (hardware is already enabled).

Is there a confusion here between dw_pcie_host_ops->post_init and
qcom_pcie_ops->post_init?

The commit message correctly notes that dw_pcie_host_init() caches the offs=
et
after dw_pcie_host_ops->init returns. However, the .post_init callbacks
modified in this patch belong to struct qcom_pcie_ops.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index d8eb52857f69c..bd383d7cb02b1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -360,7 +360,6 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *=
pci)
> =20
>  static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
>  {
> -	u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
> =20
>  	dw_pcie_dbi_ro_wr_en(pci);
> @@ -370,9 +369,9 @@ static void qcom_pcie_set_slot_nccs(struct dw_pcie *p=
ci)
>  	 * notifications for the Hot-Plug commands. So set the NCCS field to
>  	 * avoid waiting for the completions.
>  	 */
> -	val =3D readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +	val =3D readl(pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);

[Severity: High]
Is pci->pcie_cap initialized when this is called?

Looking at qcom_pcie_host_init(), it calls pcie->cfg->ops->post_init(pcie)
before it calls qcom_pcie_clear_aspm_l0s() where dw_pcie_get_pcie_cap() is
finally executed:

qcom_pcie_host_init()
  pcie->cfg->ops->post_init(pcie)=20
    qcom_pcie_set_slot_nccs(pcie->pci)
      val =3D readl(pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);
  ...
  qcom_pcie_clear_aspm_l0s(pcie->pci)
    offset =3D dw_pcie_get_pcie_cap(pci);

Since pci->pcie_cap is 0 during qcom_pcie_ops->post_init, won't this access
standard PCI configuration space (like offset 0x14 for PCI_EXP_SLTCAP, which
is BAR1) instead of the PCIe capability registers?

>  	val |=3D PCI_EXP_SLTCAP_NCCS;
> -	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +	writel(val, pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);
> =20
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }

[ ... ]

> @@ -935,7 +934,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pci=
e)
>  static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci =3D pcie->pci;
> -	u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pci->pcie_cap;
>  	u32 val;

[Severity: High]
Does this also suffer from the same initialization ordering issue?

Since qcom_pcie_post_init_2_3_3() is called by qcom_pcie_host_init() before
pci->pcie_cap is populated, offset will be 0 here, causing the subsequent
writes to PCIE_CAP_SLOT_VAL and PCI_EXP_LNKCAP to overwrite standard PCI
header fields.

> =20
>  	/* Force PHY out of lowest power state */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D11
