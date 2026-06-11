Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF683B6C13;
	Thu, 11 Jun 2026 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209561; cv=none; b=fJvv3e++AmTo3nVyHLDcb1DX8/Zr40YAVcDpCKExPZrBuCsvhQ9Qj6aYFU3pA9o8ZdmF5aE107HCgh55mgUFp8zTeT7jmTX4kSDL0IqFPVIMZga8WiiKs1pSzN/ALfiGAUpDHexM2y/D/iMdjZGvu+vgQGPu5iaiRD4Dr1ywri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209561; c=relaxed/simple;
	bh=CJw2j1MYSkMWzO5gt7/Ae0oqiW/l3qcmKeK0Kp8W6C0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=myc6NJ+34XJ6VAJk1OqlfwuFAWWLWvZsfm9uklv7BHY93NogUh3tbj/VJPaAmL9DkaKHKNxsZzdtyeKgbKsC7k5IWYxEKaIrw19ZtVuVK23lGmEqsxna/vRrqVsJn2Wyn7AFLaRqVur+z4EtF/vJbLC8wmUeT0LhIpBAfAhHimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkzYHHtO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkzYHHtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C691F00A3A;
	Thu, 11 Jun 2026 20:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781209558;
	bh=RdzeKz5JEmi38OWy+iPUBUpytfeA/njUV2W7HTZgRKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TkzYHHtO2zbdBeEdfH6529i1q7X3wcw8FHIkTrcuPWqxEZoP0jFwIrF0L+9F3Rg9S
	 4vqa0Bp5n7gJ+xHEtSm2SNDcKXaY8wZ+Li0VSAmDL14ffrD0CA4y0ZKG0483A+YN+R
	 2vky282EODak06Qa/Va5JHXZJv5aU+MRupmc1b2aLNyce+Hj0/ukRFQ7QGbD8kvJHA
	 zeK+p0vmiHZTr3sTitPSrQYWcRnRZko35TaSgE00eZJj5kx9CYX4hJqcpOsT2MSFnf
	 eXB63kegSZ05aRdi9H2WI6K3NHF04fYchP7cyn1ZUjgn3/GsyPAM2yP+EzLmdFIGDn
	 jgoGZURuqU/vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260610193158.2614209-3-zhipingz@meta.com>
References: <20260610193158.2614209-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:25:57 +0000
Message-Id: <20260611202558.09C691F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] pcie_tph_completer_type() incorrectly returns PCI_EXP_DEVCAP2_TP=
H_COMP_EXT_TPH when reading from a disconnected or hot-removed device.

Pre-existing issues:
- [High] The internal get_rp_completer_type() function was not updated to u=
se the new pcie_tph_completer_type() helper, meaning it can still return th=
e reserved 0b10 value, which can corrupt the device's TPH Requester Enable =
state.
--

commit e3087f1c41da11f8e5258fd8b874372276270977
Author: Zhiping Zhang <zhipingz@meta.com>

PCI/TPH: Add requester/completer type helpers

Add pcie_tph_enabled_req_type() and pcie_tph_completer_type() so drivers can
query the enabled TPH requester mode and completer support safely. Fold the
reserved 0b10 encoding into NONE so callers only see defined values.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d951..4fe076bba953a 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> +u8 pcie_tph_completer_type(struct pci_dev *pdev)
> +{
> +	u32 reg;
> +
> +	if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
> +		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> +
> +	switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {

[Severity: Medium]
If the device is hot-removed, pcie_capability_read_dword() returns success =
(0)
but can leave reg as 0xFFFFFFFF (PCI_ERROR_RESPONSE due to master abort).

Will FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg) then extract 0b11 (3),
matching PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH, causing the helper to falsely
advertise that a disconnected device supports Extended TPH? Should this log=
ic
check if reg is ~0?

> +	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY;
> +	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH;
> +	default:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> +	}
> +}
> +EXPORT_SYMBOL(pcie_tph_completer_type);

[Severity: High]
This is a pre-existing issue, but the internal get_rp_completer_type() func=
tion
was not updated to use this new pcie_tph_completer_type() helper.

Because it still returns the raw extracted Completer Supported field, it can
return the reserved 0b10 value without applying the safety folding introduc=
ed
here:

drivers/pci/tph.c:get_rp_completer_type() {
    ...
	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
}

If the device supports EXT_TPH (3) and the Root Port returns the reserved v=
alue
(2), could this incorrectly propagate the reserved value?

drivers/pci/tph.c:pcie_enable_tph() {
    ...
		pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
    ...
}

This would then write the reserved value (2) into the hardware's TPH Control
register, misconfiguring the device:

drivers/pci/tph.c:pcie_enable_tph() {
    ...
	reg &=3D ~PCI_TPH_CTRL_REQ_EN_MASK;
	reg |=3D FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);

	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
    ...
}

Should get_rp_completer_type() be updated to use the new helper?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610193158.2614=
209-1-zhipingz@meta.com?part=3D2
