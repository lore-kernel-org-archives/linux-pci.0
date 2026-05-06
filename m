Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2503B0AE5
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101645; cv=none; b=YR1vMHzr/1KpAS87iV1chr3l/wp0sew1Hlmkq4Vf1UvTTkOYXGGNNAWTU8aErhqiO4lDDMX0SK8ZGk2bvrXAUpXjrW6IJfvZxxtrMJ/jIF7WYKnp3f6A2JM/bHa9N/6bSHilh/JnELXYv7U154WVdQTUohkBj+eCMe/JklfLNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101645; c=relaxed/simple;
	bh=ZAzsiuM43l70AnAKdJM4g4s1EB1f1ldhIOrU5M/s9go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JmzshVpfI5yAXHz7gOXjROKyQNn5CS/5kAP0p/THXNe3tTjIn5tCR3Xtsq1pfBAnzmYpxYp5EjOyUD2FwPMfbDA3D1fLfSjb7CS2lyBPbyinph/ECiNrGps4GKaA0HvzbP/FHxcnMnnSUoFjF8tj7TReFmJkM5zby1kw7SsFt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGf0c+wT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGf0c+wT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C3CC2BCB0;
	Wed,  6 May 2026 21:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778101645;
	bh=ZAzsiuM43l70AnAKdJM4g4s1EB1f1ldhIOrU5M/s9go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LGf0c+wTbEclp6ZrIGLb8tzCWxEpxID7rNV6SJnaW2hbXW40dfEMllXBZy6gsbkXG
	 WuflFlGUAApq5FKP+RtiXgfAUBPTq89iCLxumHKawzDki8hWRdTIS7kdXy2Sq30RL8
	 LnQ1AThMLS+t+BbyTwShpkqoDh1uH24ZRHdfB2/sW2jwCVL8KyU4YvrRBv3HWZfF1g
	 avH0h2eO5R9zJWhW2AD0YJl4+eU3wDrCGS3Mv+nQkTgiwR7qkVj9wau6yfxkNjnGG1
	 TjtromkZv9u0OKq9Iw7LwgsP24B6USfkmccWMcG7Z5gj0ujNEgBe+HDh0rBFaZKJNC
	 mpLT91YCylR9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] PCI: Refactor disable_acs_redir and config_acs
 param handling
Reply-To: sashiko@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB43933B1790A24957EB7DB79ADC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43933B1790A24957EB7DB79ADC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:07:24 +0000
Message-Id: <20260506210725.49C3CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bounds checking in pci_param_config_acs() breaks backwards compati=
bility for padded parameters and contains an integer underflow that leads t=
o Undefined Behavior.
- [Medium] Silenced logging for disable_acs_redir reduces configuration obs=
ervability.
--

commit 2b4c7af1c4a60302203ef348c929aa8cf673e3ac
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Refactor disable_acs_redir and config_acs param handling

This commit refactors the ACS parameter handling by splitting the old
__pci_config_acs function into dedicated functions for disable_acs_redir
and config_acs parameters.

> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> +static void pci_param_disable_acs_redir(struct pci_dev *dev,
> +					struct pci_acs *caps)
> +{
> +	u16 acs_redir_mask =3D PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
> +
> +	if (!disable_acs_redir_param ||
> +	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
> +	    !pci_dev_specific_disable_acs_redir(dev))
> +		return;
> +
> +	caps->ctrl =3D caps->fw_ctrl & ~acs_redir_mask;
> +}

The previous implementation printed a pci_info message when ACS control was
modified. Is it intentional that pci_param_disable_acs_redir no longer logs
confirmation that the redirect was disabled?

This might make debugging device isolation issues more difficult without the
dmesg confirmation.

[ ... ]

> +static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *ca=
ps)
> +{
> +	u16 shift =3D 0, max_shift =3D fls(dev->acs_capabilities) - 1;

If dev->acs_capabilities is 0, fls(0) evaluates to 0. Will 0 - 1 underflow
the u16 max_shift variable to 65535, effectively bypassing the bounds check
below?

> +	u16 enabled_bits =3D 0, disabled_bits =3D 0;
> +	const char *p, *seg;

[ ... ]

> +	p =3D strchr(seg, '@');
> +	/* Parse bitstring backwards from '@' */
> +	while (p > seg) {
> +		if (shift > max_shift) {
> +			pci_err(dev, "ACS flag bit %d exceed range %d\n",
> +				shift, max_shift);
> +			return;
> +		}

The previous implementation gracefully allowed parameter padding that excee=
ded
the capability mask, only erroring if unsupported bits were actively enable=
d.

Does aborting here when shift exceeds max_shift break backwards compatibili=
ty
for existing working kernel boot parameters (like config_acs=3D00000000@...)
on devices with fewer capabilities?

> +
> +		switch (*--p) {
> +		case '1':
> +			enabled_bits |=3D BIT(shift);
> +			break;

If the bounds check is bypassed due to the max_shift underflow mentioned
above, could shift increment without bounds for long user strings?

If shift exceeds the width of an unsigned long, BIT(shift) could trigger
undefined behavior. Additionally, since enabled_bits is a u16, shift amounts
of 16 or greater will silently truncate.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB439385689A=
32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D4
