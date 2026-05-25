Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168729BD8C
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723032; cv=none; b=S+moo5Vl+eyWcnRKRCGk9/uDIW+aRwiC+pL866ppIOKOKlv+xnVtOAd9O36q5vXCdH7Z9/H55S7DvU7O5dYYNY882Q+OAwjLniLA/k11DMQ66k0fIx3ewYlw0DOYWvZUiW+LHFf7h2LqFVq6BPzPqgf119Qd9q6sCpquO7O67R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723032; c=relaxed/simple;
	bh=qUV9cWBgu2p8d2EiuASzRotnwf3pLxAjtgWiR/bDEYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYyjFhSp+5Ghl8ekhzEy5L9v+oXd/TUAz3MOlS7M21dJyA5xy8pl57H/11dzEb63mg94zbWNTkkkmcqhsIlZb0Z2NMc1F9ZUOa5dZ1n25lsIEN10L4t1D8MiHw7RHktgUjD/KS8C+CUY0pCPRqShH8hm5hs7PwZyZL4UmO4lLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqGBS6Ha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqGBS6Ha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1C61F000E9;
	Mon, 25 May 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723030;
	bh=bu7XrqgioEK2BMNR4QLGWTeY5K2MhyeYupx4nprU6pg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqGBS6Ha4epALrF/egaJRvdcHFi+OQKL/Un129rqel9iu3YYXyHkIUSua4Jm0YbPY
	 7ZW65mHrymLUjwQWNKqwOMlJ+k0X9+RBYD6LwRIvopSLMyJH9fnSEJToMug4mHD6Lh
	 oLDCzzwYeu4EuVo4nnEcIYmjOz8hFYo/L6Msp2y1VqmM4ffUt53YowkcixcdiRXJme
	 68q0JQIqX+h/vLTz9GCWYJwBA9sIVhqJRFxsphf3u1ogn3zdcxXuAs5jYhqVzj8XJU
	 9W1s7bdSuwQ1vCiOqJjCdEy5AFceZ4JVGjUpWLkVajFHSv2PpVNPH+nbF4GLKjh/7x
	 iQlr9Ref78v7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] PCI: Refactor disable_acs_redir and config_acs
 param handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB4393AF5B45E56E8D3B50C1EFDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393AF5B45E56E8D3B50C1EFDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 15:30:30 +0000
Message-Id: <20260525153030.5E1C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The refactored `config_acs` parsing logic silently rejects emp=
ty flag strings and missing delimiters, breaking backward compatibility and=
 dropping diagnostics.

Pre-existing issues:
- [High] Applying command-line ACS parameters clobbers kernel-enforced IOMM=
U security features and causes sequential parameters to overwrite each othe=
r.
- [High] Successful execution of a specific quirk inadvertently skips clear=
ing standard ACS redirection bits, which are then improperly re-enabled.
--

commit a4f9c35859d379acf636ff701d27c2c0461fd84d
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Refactor disable_acs_redir and config_acs param handling

This patch splits the disable_acs_redir and config_acs parameter processing
into dedicated functions. It separates concerns, improves robustness, and
makes the control flow explicit.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index de6f483dab294..655ebe1a5400d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> +static void pci_param_disable_acs_redir(struct pci_dev *dev,
> +					struct pci_acs *caps)
> +{
> +	const u16 acs_redir_mask =3D PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
> +
> +	if (!disable_acs_redir_param ||
> +	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
> +	    !pci_dev_specific_disable_acs_redir(dev))
> +		return;

[Severity: High]
This isn't a bug introduced by this patch, but if
pci_dev_specific_disable_acs_redir(dev) executes successfully and returns 0,
this function returns early.

Could this early return skip clearing the standard redirection bits
(PCI_ACS_RR and PCI_ACS_CR) in caps->ctrl?

Because pci_std_enable_acs() previously enabled these bits, the subsequent
pci_write_config_word() at the end of pci_enable_acs() will write those
enabled bits directly to the standard ACS capability register, actively
re-enabling redirection in hardware.

> +
> +	caps->ctrl =3D caps->fw_ctrl & ~acs_redir_mask;

[Severity: High]
This is a pre-existing issue, but pci_param_disable_acs_redir() overwrites
caps->ctrl using caps->fw_ctrl as a base.

Would this overwrite completely ignore the security mitigations (like Source
Validation and Upstream Forwarding) that were enabled earlier by
pci_std_enable_acs()?

As a result, applying disable_acs_redir could unintentionally disable IOMMU
isolation features.

If both disable_acs_redir and config_acs are used, won't config_acs silently
overwrite the changes made here since both independently assign to caps->ct=
rl
based on caps->fw_ctrl?

> +}
> +
> +static const char *pci_dev_match_config_acs(struct pci_dev *dev, const c=
har *p)
> +{
> +	const char *seg;
> +	int ret;
> +
> +	/*
> +	 * Example: 11101010x@0000:01:00.0;101x@0000:02:00.0;1@0000:03:00.0
> +	 * Three segments delimited via ';'. @seg always points to the start
> +	 * of a segment and p advances to the start of the device id (BDF)
> +	 * after '@'. Upon match, return the start of the matching segment.
> +	 */
>  	while (*p) {
[ ... ]
> +		seg =3D p;
> +		p =3D strchr(seg, '@');
> +		/* If malformed string, stop parsing. */
> +		if (!p || p =3D=3D seg)
> +			break;

[Severity: Critical]
If p is NULL or p =3D=3D seg (such as an empty bitstring like @0000:01:00.0=
),
this break aborts parsing completely, ignoring any subsequent valid segments
in the parameter string.

In the original code, an empty flag string was a valid supported format to
reset a device to its firmware defaults, and a missing @ delimiter triggered
an explicit pci_err() for missing ACS flags.

Does this change introduce a regression by silently rejecting previously
valid command lines and depriving administrators of necessary diagnostic
feedback for malformed parameters?

> +
> +		p++;
> +		/* pci_dev_str_match() updates p to the next segment. */
>  		ret =3D pci_dev_str_match(dev, p, &p);
[ ... ]
> +static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *ca=
ps)
> +{
[ ... ]
> +	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
> +		enabled_bits, disabled_bits);
> =20
> -	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
> +	caps->ctrl =3D (caps->fw_ctrl | enabled_bits) & ~disabled_bits;

[Severity: High]
This is a pre-existing issue, but similar to pci_param_disable_acs_redir(),
this overwrites caps->ctrl using caps->fw_ctrl as a base.

Doesn't this overwrite the security mitigations enabled by
pci_std_enable_acs() and silently discard the changes just made by
pci_param_disable_acs_redir()?

Could the modifications be applied via bitwise operations on top of
caps->ctrl instead?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779442182.gi=
t.wei.w.wang@hotmail.com?part=3D4
