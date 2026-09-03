Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520B2264AB
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410358; cv=none; b=Y7w3Zro6YXsNMf2wlDjwDUVpjP6lBntP5TeqMfhdfuwoMD/X/eXD7P4PrI9OIHUuyjIkjwzDFAo0EWCfTB3Ueo/H9KzZK3CNFmAixwVz39DjvR23fuDQho0BOk9Px4nZ1KRBogcyxYjVe9/yZYya0XVLFU9t9Co4HLzOZ+BeBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410358; c=relaxed/simple;
	bh=/xW31zQjPy6TBL1Z/XTYIkH6i6cQO8sD6m+361GnsJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sg4OeoiONIJhUJsBfbE9csLuhyNhUSWSWSeoDkOYEyK+pQp4rXZbSNvPKUf+V1VPINvq5/J8PGsmJMTnFX4GfonbvYqtORM6QvteKuaf2+NTEfcHNxe/hYiyj9uPvugDigUMF1+AMb9swZIJw31OHF78SN91152TPPG6d/FjYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz2DzRuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz2DzRuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7FA1F000E9;
	Thu,  3 Sep 2026 04:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788410356;
	bh=xGJVPoKUemuSdYynjfo7KimF5v8ZspDQwExRofbwXks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wz2DzRuYxQCYyxy0ibVipfZrFsJE+u5M0dwB9cV5X5leh5DUKgRZKHnpd2vBStyFA
	 /1sGaOdXFNRXhs3D/qF54VMmYSQDsUArJMWyQo8b/T5ZB6J9/o+qBe2ZroBKqLNZ1k
	 U78vLpcAf1o7Rf31tb9N5+1evPGygX0xOxiVeosLFAyjaDHFcZ2CkfXj2m+NDF0RSu
	 PHKNs9hem4pr7P4/XHjj16K8MMjmUN2AC+8rde/xVsDHp84kueaxml8yU58rK4ipMT
	 UhxsHSFiSwRgFpwF/V5yMKVCOsaEYoFqG1Y9dU2Q9EeYYkIygEu+G+pVk7fMxMHYQv
	 XMMydxCzYtKQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/6] PCI: Enable the enhanced ACS controls introduced
 by PCI_ACS_ECAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB43939FB8FF7F1239925023C4DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43939FB8FF7F1239925023C4DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:39:15 +0000
Message-Id: <20260903043916.5B7FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional validation of DMAC and UMAC fields rejects valid use=
r ACS configurations on non-ECAP devices and fails to account for kernel-co=
rrected states.
- [Medium] ACS Enhanced Capability access controls are unconditionally appl=
ied to unsupported PCIe port types, writing to reserved bits.
--

commit e1302a2bae5cac8f4c54de9a2a416f24d9b8a517
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP

The ACS Enhanced Capability introduces several new access controls to
improve device isolation. These new controls are particularly important
for device passthrough in virtualization scenarios.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6cffdbba99d34..50a3b61f9898e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1026,10 +1029,23 @@ static void pci_param_config_acs(struct pci_dev *=
dev, struct pci_acs *caps)
>  		disabled_bits &=3D valid_ctrl;
>  	}
> =20
> +	/*
> +	 * DMAC/UMAC are 2-bit fields where encoding 0b11 is reserved. The
> +	 * final value can land on 0b11 not only when the user enables both
> +	 * bits, but also when they enable one bit, e.g. "1x", while fw_ctrl
> +	 * already has the other set (e.g. "01").
> +	 */
> +	new_ctrl =3D (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
> +	if (FIELD_GET(PCI_ACS_DMAC_MASK, new_ctrl) =3D=3D PCI_ACS_MAC_RSVD ||
> +	    FIELD_GET(PCI_ACS_UMAC_MASK, new_ctrl) =3D=3D PCI_ACS_MAC_RSVD) {
> +		pci_err(dev, "ACS DMAC/UMAC would be set to reserved value\n");
> +		return;
> +	}

[Severity: High]
Does this unconditional check against reserved DMAC/UMAC values reject valid
user configurations on non-ECAP devices?

If a user boots with the config_acs parameter to configure a non-ECAP devic=
e,
but its firmware leaves bits 8:9 or 10:11 as 0b11, this FIELD_GET check det=
ects
PCI_ACS_MAC_RSVD and aborts the configuration, preventing the user from
applying basic ACS settings.

Additionally, for ECAP devices with buggy firmware defaults (0b11), building
the new control register using caps->fw_ctrl instead of the kernel-corrected
caps->ctrl revives the invalid firmware state, instantly triggering this
validation failure and rejecting unrelated user flags.

[ ... ]

> @@ -1051,6 +1067,20 @@ static void pci_std_enable_acs(struct pci_dev *dev=
, struct pci_acs *caps)
>  	/* Upstream Forwarding */
>  	caps->ctrl |=3D (dev->acs_capabilities & PCI_ACS_UF);
> =20
> +	/*
> +	 * Enable Unclaimed Request Redirect Control, I/O Request Blocking,
> +	 * and Downstream and Upstream Port Memory Target Access Redirect.
> +	 */
> +	if (dev->acs_capabilities & PCI_ACS_ECAP) {
> +		caps->ctrl |=3D PCI_ACS_IB;
> +		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);

[Severity: Medium]
Can this logic unconditionally apply these access controls to unsupported
port types?

If the kernel enumerates a PCIe Endpoint or Upstream Port that has the
PCI_ACS_ECAP bit set in its ACS capabilities, this unconditionally modifies
PCI_ACS_DMAC_MASK and sets PCI_ACS_IB.

Because ECAP controls like DMAC only apply to Root Ports and Downstream Por=
ts,
applying them to Endpoints or Upstream Ports writes to reserved bits, which
could risk hardware misbehavior.

> +		if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
> +			caps->ctrl |=3D PCI_ACS_URRC;
> +			FIELD_MODIFY(PCI_ACS_UMAC_MASK,
> +				     &caps->ctrl, PCI_ACS_MAC_RR);
> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB4393F337A7=
92CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D5
