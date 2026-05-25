Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE248462
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724788; cv=none; b=K/9xKQ8qc80tqLDXg+T8KdUkQfLHyMJiLkGYxhQKQAESaya2OrQOTRbhWAuXjMVuMaO831kgD6RW8/t0paiOwx6Ce3N4ehq7rYz9sNVNv1MsKRxjU3QHZnjiCvmgh6jpdX55kN+M/N/u4fy5Osx36jg5+/ii3d3W9X56ZTwKRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724788; c=relaxed/simple;
	bh=3JuKILLfG7IF/gAMPjA+V8c8lI2pIoNN2fPRPvWZIQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jEkv905vK2WAKvZwAyxYXnw9HNQGU2uWOSFPUhWb+RnBAwjPmFz4PA6BpZj4C1+0LihaDolCbYH/0f8wVmq1vB/Dw82fLDw6tcWC3lVSe+PsAOYAsq+SD4AKZPQGXKbr2Gns6W0rVTHFpadMocitIj8aoZsatBoDjNQNBj+RibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhCeeIaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhCeeIaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925081F000E9;
	Mon, 25 May 2026 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724787;
	bh=aV6SxRY9AwOvyeseWBIq4SlXxbpmMFUdXWEdbC1l2Mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OhCeeIaAKnBpTCT9fVghMSY5s4zvVx09N025sB8hYTHcmG0tUD3OQQ3qb3XfzHgFe
	 KKQexvPLJFLP//WSAG8XB9ed1z/U1Z0NdDMeSI0CT3tZjcJOSNucCElbKoBs8IQYlH
	 a583wzaU5JGmPTPIifaQUVsB5NK06BlD56rtYm+p8eziinDdd6R1nOLodTcdpt9BNd
	 jMDlnQ5JTpyx/dR2Gh+VOi/SEvPDGZObBkPksgjaNOE5+t8E96Mw+wGzg82tiWmste
	 tiqnsp9Jr0qRD4zv3AL3bWoeqli3YGmqjJo6kAsKU/aYtUbKVCFDxcx/pHH9ErXLNf
	 w/oyUVajLQ+wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] PCI: Enable the enhanced ACS controls introduced
 by PCI_ACS_ECAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB4393FFFD729022A7AE45D19DDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393FFFD729022A7AE45D19DDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 15:59:47 +0000
Message-Id: <20260525155947.925081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditionally modifying port-specific enhanced ACS fields writes=
 to reserved bits on unsupported port types.
- [High] The implementation erroneously assumes a single capability bit dic=
tates support for all distinct enhanced ACS features.
- [Medium] Unconditional validation of reserved DMAC/UMAC bits in pci_param=
_config_acs() incorrectly rejects valid ACS configurations.
--

commit abb6544c6b6950bebc64c85febd33746df14b3cb
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP

The ACS Enhanced Capability introduces several new access controls to impro=
ve
device isolation. This commit enables Unclaimed Request Redirect Control, D=
SP
and USP Memory Target Access Control, and I/O Request Blocking by default if
PCI_ACS_ECAP is supported.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 655ebe1a5400d..9da37f6669718 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -1009,10 +1012,23 @@ static void pci_param_config_acs(struct pci_dev *=
dev, struct pci_acs *caps)
[ ... ]
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

[Severity: Medium]
Will this unconditionally reject valid ACS configurations on legacy devices?

If a legacy device has 1s in these reserved bits of its ACS Control register
due to hardware implementation choices or flawed firmware, new_ctrl will
inherit them from caps->fw_ctrl.

This causes the validation to fail, completely aborting the application of
valid user configurations for bits 0-6 via the config_acs=3D boot parameter.

Should this check be conditional on the device actually supporting the
Enhanced ACS features?

[ ... ]
> @@ -1034,6 +1050,16 @@ static void pci_std_enable_acs(struct pci_dev *dev=
, struct pci_acs *caps)
[ ... ]
> +	/*
> +	 * Enable Unclaimed Request Redirect Control, I/O Request Blocking,
> +	 * and Downstream and Upstream Port Memory Target Access Redirect.
> +	 */
> +	if (dev->acs_capabilities & PCI_ACS_ECAP) {
> +		caps->ctrl |=3D PCI_ACS_URRC | PCI_ACS_IB;
> +		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
> +		FIELD_MODIFY(PCI_ACS_UMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
> +	}

[Severity: High]
Does PCI_ACS_ECAP correctly indicate support for all of these discrete
features, and are these features applicable to all port types?

The patch defines PCI_ACS_ECAP as 0x0080 (bit 7), which the PCIe
specification maps specifically to I/O Request Blocking Support (IBS).
By using bit 7 as a catch-all, could the code blindly enable URRC, DMAC, and
UMAC on hardware that only supports IBS?

Additionally, these features appear to be port-specific. For example, URRC
is only applicable to Downstream Ports, and UMAC is not applicable to
Endpoints.

By blindly applying these settings to all port types, could the kernel write
non-zero values to reserved bits in the PCI_ACS_CTRL register on unsupported
port types?

Would it be better to check the specific discrete capability bits for each
feature, and verify the port type before modifying these fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779442182.gi=
t.wei.w.wang@hotmail.com?part=3D5
