Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABC368293;
	Thu,  2 Jul 2026 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017212; cv=none; b=gTcXvzIk4RH+e6XT4GSaJAt4573opHjUK7euleLeD/OXVQW9ndWecuERaRdKqpHAE/vN3UI55evrXcOi5TNBMwcafjLNGcbbj4w5InLN2vFz1p9odORXjNw8ekAsEGLp6eUYQxAIxgVVyMvY6G3LwGYPe+cY8cJunpWURzwfIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017212; c=relaxed/simple;
	bh=LFOTAkqPV8Wj2HyBZz+KlX8tGWWNQGCP7+/J75FEgkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/lOeHQAh04t0Jh73K9+DDMDkfWtydUrS+e8BUo0SF64oU5GrC2uC20yRapal2Q3aJ22ulKTlX3l+QGzN0XrpwN+R/e/hiljdEi3w2bDTrWbVokQt774MzcR/LjIYDJ3n4rJn1rUjEvK3YiX5Ez83rmwdlcu6xo3wDJQgfPcBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrfErFCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrfErFCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C6F1F000E9;
	Thu,  2 Jul 2026 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783017210;
	bh=FHAky5wZpURiKAuKpOMSDAxCLNyYScJoczXMQgVugvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JrfErFCW7E0sIDfoIEn9m1UFz+f5fbKXMNai1AcRfa0Hz8QNwoGfE2SWC4F/Em1Y3
	 ANORQx4/kPPAwUnbaVsaf1uezZwk0CpH+bvWn2kf+KPALWDCXS9eQXIMKXnvA3I8Bp
	 KxaMkAWLOz1jS9ClEPTQqJ1o9jUvseH1spJVbS0irIkAT62/+Qs07KjIr5IqPoTxtf
	 nttE8fvoikoDOZIR5vCXkfsgNQy/9fbKGLegECDZo6BaFyz5zSYfHy/yyYGvJdDNoa
	 va+MCzsO0VyiBmJ/sNj2BvmTSfWxmJRNq3wc9mZbh83EpSLOdzG5iGcqTfTWf/kXNr
	 ndTiIM5CdUN8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/4] PCI/TPH: Add requester/completer type helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260702181025.2694961-2-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:33:30 +0000
Message-Id: <20260702183330.A5C6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly added `pcie_tph_enabled_req_type()` can return an invali=
d reserved value (2 / 0b10) because a pre-existing internal function, `get_=
rp_completer_type()`, lacks the safety checks introduced in this patch and =
was not refactored.
--

commit e4c05b2d02aee077c988b64f210719a661f03806
Author: Zhiping Zhang <zhipingz@meta.com>

PCI/TPH: Add requester/completer type helpers

This commit adds pcie_tph_enabled_req_type() to query the enabled TPH
requester mode and pcie_tph_completer_type() to check TPH completer support.
The new completer helper safely folds the reserved 0b10 encoding into "not
supported".

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 655ffd60e62f6..e7693fd9d6763 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -173,6 +173,51 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> =20
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester=
 type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_=
TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;

[Severity: High]
This is a pre-existing issue, but could pdev->tph_req_type hold the reserved
value 2 (0b10) here?

While this patch safely decodes the completer field via
pcie_tph_completer_type(), the pre-existing get_rp_completer_type() function
accesses the same capability on the Root Port but lacks this bounds checkin=
g.

If a Root Port presents the reserved value 0b10, get_rp_completer_type()
propagates it:

drivers/pci/tph.c:get_rp_completer_type() {
    ...
    return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
}

This unvalidated value can then be assigned to pdev->tph_req_type during
setup:

drivers/pci/tph.c:pcie_enable_tph() {
    ...
    pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
    ...
}

Since the newly added pcie_tph_enabled_req_type() API is documented to retu=
rn
only 0, 1, or 3, returning the reserved value 2 violates this contract and
could risk logic errors in callers.=20

Writing this undocumented value to the TPH Control register could also cause
undefined hardware behavior or AER panics.

Should get_rp_completer_type() be refactored to fold the reserved value
identically to how pcie_tph_completer_type() handles it?

> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181025.2694=
961-1-zhipingz@meta.com?part=3D1
