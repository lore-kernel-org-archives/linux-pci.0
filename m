Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFB43B3C2;
	Mon,  7 Sep 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796480; cv=none; b=Ecv9+G89SWUKGdkBTuJyWOoMGHKyiROzibFPJsFzGE7u4obg7jL+9fLfC1cmrkJvhkL80ww7A46/gglJslOPEV94JlJiUy/UELtfmCjHSWrVmZAlwz+VizP/jdPgbDSMi0zaW8R2U6yZEiMbjSQ3IVaNPHKS3KCBJPz2kdB7evA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796480; c=relaxed/simple;
	bh=cpjZAs0H8YjG0LwqvmBZ9l6jVNPRlBHZAhBzEimh5rw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wrme9CUzzi9ztzwNedrcr8Vc41OBPbEvLKc3pmHaqSYao5FPAWfVGVX0cJDXlAr6tGmoQGzZLhvY4feBMqMmlKbBWMOgVwSl3CKNLJy/NliXlnNXedYyaRBGiPaL3+gD1PJzI52KeAUWi+GIAtqbFdM8TUV2WJtxlzd0pImSx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwh8vkCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwh8vkCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38991F00A3A;
	Mon,  7 Sep 2026 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788796478;
	bh=xsIS7Ca3fvHWYC1rr2r4J+/xi2oz+bhps4i7JVEh+Zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hwh8vkCKGyg+A84XRCuHAZ+FrzfeC8MLCBA2/4gvsRAyBgYtZ/jLb+Ll6CozSMFAl
	 7jxzgXFt+R9FiS7HAuYvN2Fs1XyVTBm5XQZLadb2TKLbB6JX2pTfrjxz2TDLX8pm3c
	 2m5g3n1igcQI3aZ92/qdEhebvS+/XuOeWJotpFOVxl3j2+NTsqdl52HCrGSXRr1bG4
	 BpuWlWbQttDsfmuTC/RXKpJ5g3HfZWdMYfS4NUdEA6HzxiJMOdYQ2ko+Il0mUCdigH
	 594eY+VcZUVurEWwVhRjlRFL/l+bbhlr/68rHlHQYp/L/P+WjaVUL2yGPCE09jlgzW
	 3D3+m1uSw4jEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Add missing PM ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260907153711.653861-1-marek.vasut+renesas@mailbox.org>
References: <20260907153711.653861-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 15:54:37 +0000
Message-Id: <20260907155437.E38991F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized variable dw->mode causes suspend/resume callbacks to=
 be silently skipped.
- [Low] Missing `static` keyword on `rcar_gen4_pcie_pm_ops` definition.
--

commit 0e99d69c4bfd5a0067af46f15d0ef68cd860b192
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Add missing PM ops

The R-Car Gen4 PCIe controller is part of a power domain that is shut down
on V4M during suspend, losing state. This patch adds generic suspend/resume
noirq ops to tear down and restart the link on suspend/resume.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index fbe465a29068f..47754aee84278 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -849,6 +849,28 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_=
gen4_pcie *rcar, bool enable
>  	return 0;
>  }
> =20
> +static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(dev);
> +	struct dw_pcie *dw =3D &rcar->dw;
> +
> +	if (dw->mode !=3D DW_PCIE_RC_TYPE)
> +		return 0;

[Severity: High]
Is dw->mode guaranteed to be initialized here when CONFIG_PCIE_DW_DEBUGFS is
disabled?

It appears dw->mode relies on dwc_pcie_debugfs_init() for initialization.
If debugfs is disabled, dwc_pcie_debugfs_init() becomes an empty inline
function, leaving dw->mode as 0 (DW_PCIE_UNKNOWN_TYPE).

Because 0 !=3D DW_PCIE_RC_TYPE, wouldn't this cause the callbacks to silent=
ly
bypass the suspend and resume logic entirely on production builds without
debugfs, leaving the PCIe link up during suspend and dead after resume?

> +
> +	return dw_pcie_suspend_noirq(dw);
> +}
> +
> +static int rcar_gen4_pcie_resume_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(dev);
> +	struct dw_pcie *dw =3D &rcar->dw;
> +
> +	if (dw->mode !=3D DW_PCIE_RC_TYPE)
> +		return 0;

[Severity: High]
Similar to the suspend callback above, will this also silently skip resuming
the link when debugfs is disabled?

> +
> +	return dw_pcie_resume_noirq(dw);
> +}

[ ... ]

> +DEFINE_NOIRQ_DEV_PM_OPS(rcar_gen4_pcie_pm_ops,
> +			rcar_gen4_pcie_suspend_noirq, rcar_gen4_pcie_resume_noirq);

[Severity: Low]
Should rcar_gen4_pcie_pm_ops be marked static?

The DEFINE_NOIRQ_DEV_PM_OPS macro does not include the static keyword in its
expansion. By not explicitly declaring it static here, this creates a global
symbol that pollutes the global namespace, even though it is only used
locally within this driver file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907153711.6538=
61-1-marek.vasut+renesas@mailbox.org?part=3D1
