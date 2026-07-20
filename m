Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C13839B8;
	Mon, 20 Jul 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561618; cv=none; b=QB44UgvuUY1hfehn02VMPsQFiNtpJ1ggJBpitU0hanYgDGpVquA6KT4Q1IIgi/Yxsgoz+JYZwCKGqEaYRT4CmAWrxNvR9fMyR4lM1lLNwoH3fWeImOJNG9liGnRkYCQ0TdODoy2ahIgcEKr90u3qa4Y82fPcMfpWkGQFyUmCDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561618; c=relaxed/simple;
	bh=IZRduAq1r6NaPM5YROFadleqTlO2yjFkjToY3ZTZvqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i4LGaen2VoQL2d1buM9QHtBV5KNicFAdD3RMlT6uEFfHgJjniKdgmwry3MgM+f4viK1DzwSLMG2rgrTtvldcJ6pi8B0DX17qTarBBasXWzJgxVAJD+cYY0MGdV+BXdkW8OsjkbEFIqeHl3SOp0jCFQ8NEgkoIWaJ+2Kod+eIwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at563S0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at563S0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F431F000E9;
	Mon, 20 Jul 2026 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561613;
	bh=/8xIWWV58JRVzHpzaPTCwgzSCb+umOikg0RXZPGeIzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=at563S0/ufpfWRdNOrlPsCQBM2H8OdDGCqBfK/qasglcuwCV6oMYiQxRvn6N1/aJa
	 O8qdcUtBFAuf4RLNtGzXOGIRQNDHBTnzsF4iwUfb2phzEIYyyudE+rXYBVM2kStsq8
	 bhklFpS7PxhiO30zzJlsJcDReADYDWGzSWFA8NDTqjl/d2K14WUPg3/f0Cuy3X5KRq
	 5VEeudSqmHA6G+EZT5ZRWlEuiesbkqpT3J0psmLnqMtGizZFO98QF7A62M5Owd9+/4
	 oAHErDWmD6omVNsiXGdwNSvKJo5hfIQcg3e2xHCOmVWB1TBgUXoJUJyqiIKhBh+LGY
	 tUhwlf5lmnLpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/16] PCI: dwc: ultrarisc: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, neil.armstrong@linaro.org
In-Reply-To: <20260720150619.24733-17-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-17-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:33:31 +0000
Message-Id: <20260720153332.A6F431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] In Endpoint (EP) mode, `pci->pcie_cap` remains uninitialized (=
0), causing `dw_pcie_setup()` to silently corrupt standard PCI header regis=
ters.

Pre-existing issues:
- [High] 32-bit read-modify-write (RMW) of 16-bit PCIe Control registers ac=
cidentally clears Write-1-to-Clear (W1C) bits in the adjacent Status regist=
ers.
--

--- Patch [16]: [PATCH v3 16/16] PCI: dwc: ultrarisc: Use cached PCIe capab=
ility offset ---
commit 4d9321bed75fe3c10535cf01ea0a69ce527cb616
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: ultrarisc: Use cached PCIe capability offset

This commit updates ultrarisc_pcie_host_init to use dw_pcie_get_pcie_cap
to obtain the PCIe capability offset, as the core has not cached it yet.
Hardware is already enabled before this point.

> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/co=
ntroller/dwc/pcie-ultrarisc.c
> index 6ee661ceff67a..3f6e3ab0aa697 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -49,7 +49,7 @@ static int ultrarisc_pcie_host_init(struct dw_pcie_rp *=
pp)
>  	FIELD_MODIFY(PORT_FLT_SF_MASK, &val, PORT_FLT_SF_VAL_64);
>  	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
> =20
> -	cap_exp =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	cap_exp =3D dw_pcie_get_pcie_cap(pci);

[Severity: Critical]
Does caching the capability offset here expose an uninitialized value
in Endpoint mode?

If the broader patch series replaced dw_pcie_find_capability with direct
reads of pci->pcie_cap in the EP paths without initializing it,
pci->pcie_cap could remain 0.

For example, in drivers/pci/controller/dwc/pcie-designware-ep.c:

dw_pcie_ep_init_non_sticky_registers() {
    if (funcs > 1) {
        offset =3D pci->pcie_cap;
        func0_lnkcap =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
        [ ... ]
}

If dw_pcie_get_pcie_cap() is not called before this in the EP
initialization sequence, offset evaluates to 0. This causes
dw_pcie_setup() to write into standard PCI header registers like Cache
Line Size or BIST instead of the PCIe capability space, silently
corrupting the header.

>  	val =3D dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
>  	FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
>  	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);

[Severity: High]
This is a pre-existing issue, but does this 32-bit read-modify-write
sequence unintentionally clear Write-1-to-Clear bits in the adjacent
Status register?

When ultrarisc_pcie_host_init() reads and writes 32 bits starting at
PCI_EXP_LNKCTL2:

drivers/pci/controller/dwc/pcie-ultrarisc.c:ultrarisc_pcie_host_init()
    val =3D dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
    FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
    dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);

The read includes the 16-bit Link Control 2 register and the adjacent
16-bit Link Status 2 register. If any W1C bits are set in the status
register, writing the 32-bit value back will clear those events. This
can drop hardware events like Link Equalization Requests or Device Errors,
potentially breaking link training or Advanced Error Reporting.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D16
