Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF08460
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778097677; cv=none; b=SRDAyLmI9461qHBLpJnc2EblNzrJjTLveFiMe1o2hfuUM139/CsWscbs1ZgAmvnph1vvPY5o26vkGWoTQndil3alRlRCgBnCyswBCDu1Rfrh+Chdk4sCJw2h3T6uO4ipzDV3QBYCvWgaLDCxH5x8Y+feV9dgxQu87nkFz4fswhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778097677; c=relaxed/simple;
	bh=shpMpjhVxu2TC5v4DX324MH03krGG4C87UPDqcJ6EZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q7AjL2s64Zc7LpoKxmlXGcFUZcM5dgM5bTqnY0wLcQ89nEUUb7l4/cpMp8/U0+iuz4WzNeDjmeFbFXkkG2pwfl042Qoz3yq/ATOKJMb9h3uf5ko+j3BRKuvu7qfC/xSM17sYdEmaJwDqX64ThQhzY+mukOaQFz66doAbbyQpLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeMAHsRM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeMAHsRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E280AC2BCB0;
	Wed,  6 May 2026 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778097677;
	bh=shpMpjhVxu2TC5v4DX324MH03krGG4C87UPDqcJ6EZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VeMAHsRMnA6wrTzsndKAP8Jq9Crkzd65S+FNhbSeOMZQzCUp8tZIokGawe6f/3oXI
	 oayHwc6CGYY8KzCAaKb5GoAyDxasWOkRCMtlDjFENsXmiM/RMyeCarQldcgw29JQhs
	 oEJBhFg8vJpHSco0Me38OzCoxOXrgFjrIJR17telojGq21/noubizAb5NeNnBZoa9O
	 MxHZghldHkybfbU0RgKi1N2fEudW8QThmxczTEuFZEoEKc4BdD1Cc5jtzgjTGG6aCk
	 nVbuLVYVQxl7TXoXErnVAr9CMAU8ovCbrnzC3HU7zm57wseqkHGrgm2hJswRYrL8/t
	 wV8qvlaldO8mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] PCI: Validate ACS enable flags against
 device-specific ACS capabilities
Reply-To: sashiko@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB43931FC883781B95114B94E1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43931FC883781B95114B94E1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:01:16 +0000
Message-Id: <20260506200116.E280AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The new validation logic unconditionally fails when parsing the `d=
isable_acs_redir` parameter, completely breaking the ability to disable ACS=
 redirection.
- [High] The validation logic incorrectly treats the 'Egress Control Vector=
 Size' field as capability flags, breaking the configuration of Enhanced AC=
S features and allowing reserved bit corruption.
- [Medium] The complete removal of the `mask` bounds validation allows malf=
ormed user strings to clear reserved bits in the ACS Control Register.
--

commit 624557195263e213573cb1ed8cebc0a3dd09d6c8
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Validate ACS enable flags against device-specific ACS capabilities

The ACS flag validation is updated to use dev->acs_capabilities instead
of the full set of ACS control bits, ensuring only supported ACS features
are enabled. Note that a regression regarding the disable_acs_redir
parameter was fixed later in the patch series by commit 2b4c7af1c4a60
(PCI: Refactor disable_acs_redir and config_acs param handling).

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 783e71962cc61..e017200694d8a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -931,12 +931,6 @@ static void __pci_config_acs(struct pci_dev *dev, st=
ruct pci_acs *caps,
>  			}
>  		}
> =20
> -		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> -			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
> -			pci_err(dev, "Invalid ACS flags specified\n");
> -			return;
> -		}
> -

Does the removal of the mask validation allow malformed user strings to
clear reserved bits in the ACS Control Register?

If a user specifies 0 in the command line for an upper bit position, that
bit is set in mask but remains clear in flags. Because flags is 0 at that
position, the new validation checks will trivially pass.

The function later evaluates:

caps->ctrl =3D (caps->fw_ctrl & ~mask) | (flags & mask);

which would unconditionally clear the corresponding bits in the device's ACS
Control register, potentially violating the PCIe specification that dictates
reserved bits must be preserved or read-only.

>  		ret =3D pci_dev_str_match(dev, p, &p);
>  		if (ret < 0) {
[ ... ]
> @@ -959,6 +953,12 @@ static void __pci_config_acs(struct pci_dev *dev, st=
ruct pci_acs *caps,
>  	if (!pci_dev_specific_disable_acs_redir(dev))
>  		return;
> =20
> +	if (flags & ~dev->acs_capabilities) {
> +		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
> +			(u16)(flags & ~dev->acs_capabilities));
> +		return;
> +	}
> +

Will this validation unconditionally fail when parsing the disable_acs_redir
parameter, breaking the ability to disable ACS redirection?

When the pci=3Ddisable_acs_redir parameter is used, __pci_config_acs() is
called with an inverted mask for flags, making acs_flags evaluate to 0xFFD3
as a 16-bit unsigned integer.

Since flags has its upper bits set, and ~dev->acs_capabilities also has its
upper bits set, the bitwise AND will result in a non-zero value. This seems
like it will instantly log an invalid flags error and return early, silently
failing to disable ACS redirection.

Could treating the Egress Control Vector Size field as capability flags bre=
ak
the configuration of Enhanced ACS features?

dev->acs_capabilities is populated by reading the 16-bit PCI_ACS_CAP regist=
er,
where bits 8-15 contain the Egress Control Vector Size integer. Validating
against the full 16-bit value incorrectly uses the vector size as a bitmask
of valid capabilities.

If a user provides a parameter to enable Enhanced ACS controls, the validat=
ion
might erroneously reject them unless the device's vector size happens to
have those exact bits set. Conversely, if a device has a non-zero egress
vector size, a user could pass flags corresponding to the set bits in the
vector size, allowing unintended modification of reserved bits in
PCI_ACS_CTRL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB439385689A=
32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D1
