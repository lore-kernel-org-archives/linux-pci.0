Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A912C15AB
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170454; cv=none; b=IRz4MRpJW+7sDIzrUu7PH1LSNNJkFkn7IDs1GjEZF1cVFR2A928vgPCSZIfcOGNbEDvkyzwDHpt3b586iulTGFiIQkRv5wob6nD/qDFERsUNNHwXL/piGpyeVqYvFUibo3NSpF48I8nUcsR3Ae7aNYZvPrwBlpbDKEA/5h0asbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170454; c=relaxed/simple;
	bh=ym2an1QYIKEblaMQwyxWe/C8SQ+U4aJ+Nfj3jtSSjpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ef9s2KM64quT0glq84WL1zYST/EuoQDw7uKU2ro/42Aa1FB8t/tiE9FY905spKpC7SSSqyGEsQn4WHd5eCwkV6lDKuq33VNkXVvQRM1LPVvMDH6RPDi+c2WvRPZmxa1Ip3//+3cW8q2PhE6ouIrjhrWYWTPVErgvyi8sJc0dVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGD1V8u0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGD1V8u0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EDB1F000FF;
	Fri, 11 Sep 2026 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170451;
	bh=H0ZENjC9ivaNI8dr1NwBnbklYypNMP1pZxB8pBOWUNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QGD1V8u0uppiUxgTv0Jxh0w7LgHaJ9LDpNx59aNfXzyVECIOoH1Za54PwKY+kV9dq
	 wCqM34IihHO+3gwdWK0KZa72SXDet76oYuQppuxxE96EFun5sdX++21UOou1NnWWdu
	 D4SPm1QhQkUY7YRXp87n+r/gY5QAvAER19ux/NvwgqwKSneczCjlyeMTFFYXZgqThH
	 DvLu0GvfeP7FOX54jDnBQiOAtVCDUD+eTft2vpSqGuq0B/L0jY/5IylCaOaT5vBj1J
	 xgbWjOErrWz8MOAMvtDUklsGOMnHEVXqKoLmh7CgH+KiuDd3bdOHVuHqTihv0DGBWb
	 oI2YaxiETvpDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] PCI: brcmstb: Use order-0 indexing for inbound
 BAR window array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-13-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-13-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:47:30 +0000
Message-Id: <20260911234730.C5EDB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The shift from 1-based to 0-based array indexing for `inbound_wins=
` broke the MSI target address calculation. `brcm_pcie_setup()` was not upd=
ated and continues to evaluate the hardcoded index 2, which now points to a=
 0-sized disabled window (or uninitialized memory), forcing an incorrect MS=
I target address.
--

commit cc21218055610569186c9058228a2b11645c3501
Author: Jim Quinlan <james.quinlan@broadcom.com>

PCI: brcmstb: Use order-0 indexing for inbound BAR window array

The register names for the inbound BAR registers use order-1 indexing,
e.g. the first is BAR1. The code followed this nomenclature by not using
the 0th element of the inbound array. This commit undoes this approach
and uses order-0 indexing.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 8bca98e6f5fa4..53984cfa2c96f 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
[ ... ]
> @@ -1202,11 +1195,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
> =20
> -	num_inbound_wins =3D brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> +	num_inbound_wins =3D brcm_pcie_get_ib_wins(pcie, inbound_wins);

[Severity: High]
By changing the inbound_wins array indexing from 1-based to 0-based, the ma=
in
inbound window for non-7712 chips has shifted from index 2 to index 1.

Does this break the MSI target address configuration further down in
brcm_pcie_setup()?

Later in brcm_pcie_setup(), the code still unconditionally evaluates index =
2:

	if (inbound_wins[2].pci_offset >=3D SZ_4G ||
	    (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
		pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_LT_4GB;
	else
		pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_GT_4GB;

For non-7712 chips, inbound_wins[2] will now point to the disabled zero-size
window, forcing the condition to always evaluate to true. This incorrectly
forces BRCM_MSI_TARGET_ADDR_LT_4GB and breaks >4GB MSI allocation.

Additionally, for BCM7712 chips with fewer than three dma-ranges,
inbound_wins[2] is never initialized and will result in an uninitialized st=
ack
memory read. This issue remains unfixed in subsequent patches of the series.

>  	if (num_inbound_wins < 0)
>  		return num_inbound_wins;
> =20
> -	set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
> +	brcm_pcie_set_ib_win_registers(pcie, inbound_wins, num_inbound_wins);
> =20
>  	if (!brcm_pcie_rc_mode(pcie)) {
>  		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D12
