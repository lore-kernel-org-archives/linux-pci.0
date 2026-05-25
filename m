Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C6384CC2
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718383; cv=none; b=OZiDMIAV8Yvi04e1p9ymft7+/J7lR0Bo96eix/2eIr7PTMtQD02F7bsFwAfl2mPcY/6yGEtvP9lSkeNLVM3yhNytilDjWyMpmSDv1pOsbrW7qO9j5vdfRkxp2yoAYT5YdNtmIwSMNxkvp5nNVEK5bgpqKIho6IC239jDHvOR2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718383; c=relaxed/simple;
	bh=RUpPK3iyB/84eK2qRzj+1vI/Y85Slw1LARmFQ0noqJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V7wArfhekvzGMyDwTve+sXGvgXIcQjGRCRWT+clwdjZeoRsIuDDqFrNybI3bpnZxviXnK2jDpOm5SeJJ1o6x5twNqR022JcLp9TPngrBxIbBxl1hP9oAvpfTtmK1/o/q1LiD720oIYQSz7JjYxAvSgkzrZwp1IO2Wd77HduGrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaHGsaHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaHGsaHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684701F000E9;
	Mon, 25 May 2026 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779718382;
	bh=bXtlzhuEOn5GMSkryJx8oz7v5Vjry+gTCZBvsIZ8+6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iaHGsaHWRga3tIb1PsO2FR79XlvsGRZCKSMWpxNmT7Exnhhl3D8gnxPvlTxGs0gHa
	 D+U0SNRE3YL9ScO70llMQkP+cpGx0620feNqyJJtIM0i7KxLVce+QdHk14BVsTqo+R
	 jxOzzD1jfz3tdCJmoQleZkXa3X0gKMUgvd+rktKSiDxDJaz7rWXitq9LYoDtAUoZA8
	 K9cF3HbaOm3RSqMfeuN71cA9zn+LPN4/KrdmQqE17tSDn/pnvG1wlcJ94M8rcYNRsu
	 6YOL8D8h9XlYBK7ym0+khnOAnG2eaqpymUsR2tspa7nuvz9JYNFTMM8bjBfRaEFZ74
	 8nFO/pI04ooVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] PCI: Validate ACS enable flags against
 device-specific ACS capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB43932642FC4DD3D075983B1FDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43932642FC4DD3D075983B1FDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 14:13:01 +0000
Message-Id: <20260525141302.684701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new ACS bit validation strictly rejects configurations that in=
clude unsupported bits (both enables and disables), breaking existing comma=
nd-line parameter usage.
--

commit b54fadf9f09be9bfcfae1cf9a51034c115a768c7
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Validate ACS enable flags against device-specific ACS capabilities

This commit validates the requested ACS enable bits against the device's
acs_capabilities. It ensures that only device-supported ACS controls are
accepted, returning an error for unsupported bits instead of letting the
hardware ignore them.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..604a9febb3327 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -896,6 +896,7 @@ struct pci_acs {
>  static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  			     const char *p, const u16 acs_mask, const u16 acs_flags)
>  {
> +	u16 valid_ctrl =3D dev->acs_capabilities & GENMASK_U16(6, 0);
>  	u16 flags =3D acs_flags;
>  	u16 mask =3D acs_mask;

[ ... ]

> @@ -969,6 +964,12 @@ static void __pci_config_acs(struct pci_dev *dev, st=
ruct pci_acs *caps,
>  	if (!pci_dev_specific_disable_acs_redir(dev))
>  		return;
> =20
> +	if (!acs_mask && (mask & ~valid_ctrl)) {
> +		pci_err(dev, "Invalid ACS bits specified: %#06x\n",
> +			mask & ~valid_ctrl);
> +		return;
> +	}

[Severity: High]
Does this new validation break existing command-line configurations?

Generic command-line configurations, such as pci=3Dconfig_acs=3D10x@pci:0:0,
can apply blanket masks to devices. Previously, the hardware would
silently ignore the unsupported bits, but this validation now aborts the
entire configuration, leaving even the supported bits unconfigured.

Additionally, passing a 0 to explicitly disable an unsupported bit will
also cause the configuration to fail, as the mask includes disabled bits.

Should the code silently mask out unsupported bits instead of returning
an error?

> +
>  	pci_dbg(dev, "ACS mask  =3D %#06x\n", mask);
>  	pci_dbg(dev, "ACS flags =3D %#06x\n", flags);
>  	pci_dbg(dev, "ACS control =3D %#06x\n", caps->ctrl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779442182.gi=
t.wei.w.wang@hotmail.com?part=3D1
