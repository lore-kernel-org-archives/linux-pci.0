Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69F519DF0
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090069; cv=none; b=CwIP8dZlR+zWvfEBgyFcV6AZRIyt6KTdCvQqXJEhfOUcJpGL1HkHvJupeaPoqm6GE5hY5DDnYk7WsU3/4ZRxqmMf41zo+/4dDe5aUPUxIue5vgAnAmTDfJPsTR/rS3oyAJc7MOTY0vcxZeqP5dFWg9JaZU+4igrmqV3jXSHotSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090069; c=relaxed/simple;
	bh=4uDrq0Nqxci0nKQ1Ki9ctPEztcPfn9r8DGfxgay3KOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YaJXr75hsZVC8s/8SXcyr/Umb4Iic8Ps9AhCLtMpyY79hpzi6wrxfm79mb60veDVlC+jZVisrb5m21Xl/ybIZJtuHsMcTh3UUZOu0hOPBxEkU0YtoZ+da2dqYzJvYlYoJXLIadDyTnmxlU3vPFnlEWtvczAdvRd550wZsMVl5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/haha06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/haha06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F281F000FF;
	Tue, 22 Sep 2026 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090068;
	bh=Hx2vnr4cEeUJedp88X1kFV8MKq4zRiRfd1Aqn53LyOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c/haha06A5+5zCcNb+28ekVwWTzuHl4iO6SIay371Y/+6Cx19ezwnDcss3N0SQX5v
	 vCHGcouVNUwODpCU405lZUdYXa88/7OQBjKTwk0NFQX/HeGo60H4hUSHt3rr6nfk1l
	 gPkOnq0ksAvfigLuYpppWgrvvCTMhFnbFI2eKMQqVJwxvqUC5f3r5akPWko41vOquA
	 bt+DCIAvQTt8LWvLKWo8gUO/Iv9h3UV/UBHY31OiKsoIjRdFy2oOewGUHOnjnEAblV
	 ip4DHMu/jCDJSCxiq4sQANdlRQzppbupQuEMgoZumWjKDy7TBpZhFFBz4AWWkyFn8e
	 gWVDOjVI53wJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/6] PCI: Enable the enhanced ACS controls
 introduced by PCI_ACS_ECAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB43937D197A3C0286A51A8D69DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43937D197A3C0286A51A8D69DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:14:28 +0000
Message-Id: <20260922151428.56F281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] pci: missing port-type validation allows setting reserved UMAC/U=
RRC bits on Root Ports
- [Medium] pci: unconditional check for reserved DMAC/UMAC encodings breaks=
 config_acs on non-ECAP devices
--

commit d128af062fd915f74bfeafe2fdd8a9e6bffb5ab9
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP

The ACS Enhanced Capability introduces several new access controls to
improve device isolation. These new controls are particularly important
for device passthrough in virtualization scenarios.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ffb489e4cbef6..4942bb6f1e111 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -982,6 +985,10 @@ static void pci_param_config_acs(struct pci_dev *dev=
, struct pci_acs *caps)
>  	u16 shift =3D 0, enabled_bits =3D 0, disabled_bits =3D 0, invalid_bits;
>  	u16 valid_ctrl =3D dev->acs_capabilities & PCI_ACS_BASIC_CTRL_MASK;
>  	const char *p, *seg;
> +	u16 new_ctrl;
> +
> +	if (dev->acs_capabilities & PCI_ACS_ECAP)
> +		valid_ctrl |=3D PCI_ACS_ECAP_CTRL_MASK;

[Severity: Medium]
Does this missing port-type validation allow setting reserved UMAC/URRC
bits on Root Ports?

Because PCI_ACS_ECAP_CTRL_MASK unconditionally includes the UMAC and URRC
bits, an administrator could use the config_acs=3D boot parameter to
overwrite these reserved bits on a Root Port device that supports
PCI_ACS_ECAP.=20

The PCIe Base Specification states these bits must be hardwired to 0 for Ro=
ot
Ports, so permitting them to be configured here could lead to undefined
behavior on poorly-behaved hardware.

> =20
>  	if (!config_acs_param || !valid_ctrl)
>  		return;
[ ... ]
> @@ -1023,10 +1030,23 @@ static void pci_param_config_acs(struct pci_dev *=
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

[Severity: Medium]
Does this unconditional check for reserved DMAC/UMAC encodings break
config_acs on non-ECAP devices?

If a non-ECAP device has firmware or hardware quirks that leave bits 8-11
initialized to 1s, this check will falsely trigger. Because it runs
unconditionally, it applies ECAP-specific validation constraints to non-ECAP
devices where the bits are just reserved.=20

This will cause the function to abort, preventing the user from configuring
even basic, supported ACS controls on the device.

> +		pci_err(dev, "ACS DMAC/UMAC would be set to reserved value\n");
> +		return;
> +	}
> +
>  	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
>  		enabled_bits, disabled_bits);
> =20
> -	caps->ctrl =3D (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
> +	caps->ctrl =3D new_ctrl;
>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB43935D2C01=
946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D5
