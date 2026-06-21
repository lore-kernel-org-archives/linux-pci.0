Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324701FA859
	for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782025964; cv=none; b=mL6/Xlkhq2jJSm/zDvTk+414sMNEljUD4VtBXBPdKf0I7OvdcNwXRQdVUtPprzuEA3VPl5ojYnM2jyDEDiirH+/GPCN8t1nV4TgBwVNXs7q211/WiG9HrR9+vFt5BnKB44SVj44YzMZLA7sxDVA9BrqwHgc7d+z/2bDcBhxonKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782025964; c=relaxed/simple;
	bh=dLmZ+yJD2JOWdxUSCVeWOoemfMGt0nE77tcp9suOYK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VZc1mMoPbpm4RQTLENSrb6WGVDt3BDAoZSFxTyBEV5OaswYtQECBVqhD+v3HoOWSS2TZvkOdP52MHmXYGi7GJX5cM2JBPLLaeNQgUbHf72z+I8JatwKHYlLlLQy98rpWXiXoMW5tC3uSd6ZA4iLII3ignMi7NXbVwCk+vgLuD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onY0BL3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onY0BL3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20F31F000E9;
	Sun, 21 Jun 2026 07:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782025962;
	bh=P2smeCEOe7IcPc8e4xWXAXlf8PAlnbTC/yvLkHRll1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onY0BL3NWNo0RFfE17Cae1xulvybxTXyItP+Xa4pOeL//59sMJYdL/aibtK9cO2FQ
	 BGuUaO+8Rpos9sQeMxvzIDBiEAD7rosrgnOEV88SkWN704wL3rWMgtXClR1mKOqhzS
	 6QoYBtWvLP3vix4Re02pW5Zc8NIeMr5/xPA+JgXdws1C5GBU/6v85gvlrciLdiGqCS
	 D9qk3Wmt14uRqDH/S2vW5Y7K08DoLPL0Zj7X36kwtXTuihybuybagdZEvZ3gl1/lb0
	 SKrDYxlWdgna+JNZ7HBGS7+eajF5gFq9WurzG08delodJCWshmOVHeKpTnGBgnxiEP
	 UyC1YFF5Nv/TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emmanuel Grumbach" <emmanuel.grumbach@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
References: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 07:12:42 +0000
Message-Id: <20260621071242.B20F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing suspend/resume fixup hook for Intel BE200 PCIe erratum wor=
karound
--

commit ebcdab6d68a92d23aa6cf1713e8e72d87f0e6279
Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

PCI: Disable NoSnoop and Relaxed ordering for Intel wireless BE200

This commit disables NoSnoop and Relaxed ordering on the root port for the
Intel wireless BE200 device because it fails to copy TLP Attributes from a
Request to the Completion.=20

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4674,6 +4674,13 @@ static void quirk_chelsio_T5_disable_root_port_att=
ributes(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  			 quirk_chelsio_T5_disable_root_port_attributes);
> =20
> +/*
> + * The Intel wireless BE200 fails to copy TLP Attributes from a Request =
to the
> + * Completion it generates.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x272b,
> +			 quirk_disable_root_port_attributes);

[Severity: High]
Will this workaround survive a system suspend and resume cycle?

When the Intel BE200 device is hotplugged, the upstream Root Port's
configuration state is saved at boot time by pcie_portdrv_probe(), which ca=
lls
pci_save_state(). The workaround modifies the Root Port's current
configuration to disable Relaxed Ordering and No Snoop, but it does not upd=
ate
the Root Port's saved state array.

Upon system suspend, the PCI core skips saving the Root Port's state because
its state_saved flag is already true. During resume, pci_restore_state()
restores the Root Port to its original boot-time state, which would re-enab=
le
the problematic attributes.

Should there also be a DECLARE_PCI_FIXUP_RESUME_EARLY hook registered here =
to
ensure the workaround is re-applied when the device resumes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621065451.2165=
0-1-emmanuel.grumbach@intel.com?part=3D1
