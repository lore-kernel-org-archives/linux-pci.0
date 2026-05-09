Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5D416132A
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342147; cv=none; b=fi/ZJ41FlB3h9TV6Fx1gxvHw8bFHgCy4xEtmZ7nHsJ3xa8KFq8ljE7YQYpJdr90z1YT4AxJ2W8b24YcX8paodZsakCsv/j0h9lI4+noHTGLdTs6y+ulCXj9CFSmt1DD1kEm0WScDHfQApRYZjxaF2kP+TkhSWqVTvjUBmsgcdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342147; c=relaxed/simple;
	bh=Ngix7EStA5eEA+lJmsg5N8JXqCIKJmvcvct3bQGf0jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IGarbZpq7Hjxiv+FgdUZqhKEJ3Dlr4o8RDpx/q39xZYAJ4rKrHlRNliy9ubt0DH46Ex9k0UspFZv25Jvkj6HGOfqmo0oB7w4sabL8H7qOxJ1GETZNEjXf1S425IoFIg3huGeW5ZBZRRNT7qhEFjDuth4nVCrCsqhs00PH6aaraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP5ACXVi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP5ACXVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBDCC2BCB2;
	Sat,  9 May 2026 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342146;
	bh=Ngix7EStA5eEA+lJmsg5N8JXqCIKJmvcvct3bQGf0jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JP5ACXViz6trHouefdTzWKvhsfSRCCfxpw9RjHhsNhINkEDM5OHaZLK9gNKFNiILZ
	 QcR+KgboCc7Tkn+nc7pyxdZFPQYkj6XW4Zn5XY8lgB5oJlbyJr02QXj3fIUba1mjog
	 5SlBG7QJ56g8pmZU3ID+3lGQVN3O/h6SbiBdGhdBUB9aiT6+QECaWezWxu8mnseqTy
	 2MGgdRQCs7oi2vhdn1xpOr5CexM/tthW+qNA/S6jHFNLeLZ2MTvuBlZJfvpAKMntFC
	 Ma1jXVlxczcftY1VW8JGCKJG4EETueRaCR77dnvjaNmWBJ2vZRnOCGMNodjiTtjEli
	 9eGwr9m4dIn0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: Simplify platform drivers using cached
 capability offset
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260509135152.2241235-4-18255117159@163.com>
References: <20260509135152.2241235-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 15:55:45 +0000
Message-Id: <20260509155546.7CBDCC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware access violation and state corruption due to prematurely =
cached `pci->pcie_cap` evaluating to 0 during early platform initialization.
--

commit fc0c674ee4b79463c25ac169e08eff8e9302d0c5
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Simplify platform drivers using cached capability offset

This commit replaces explicit dw_pcie_find_capability calls with the
cached pci->pcie_cap across several DWC-based platform drivers to
simplify the code.

> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
> index c21906eced618..939b9dcac7fe2 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -121,7 +121,7 @@ static void intel_pcie_ltssm_disable(struct intel_pci=
e *pcie)
>  static void intel_pcie_link_setup(struct intel_pcie *pcie)
>  {
>  	u32 val;
> -	u8 offset =3D dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pcie->pci.pcie_cap;

Will pcie->pci.pcie_cap be correctly populated here during early
initialization?

Since some platform drivers (like Intel Gateway and SpacemiT K1) enable
clocks and deassert resets in their .init callbacks, the hardware might
be inaccessible when the DWC core initially attempts to cache the
capability offset.

If the core evaluates pcie_cap to 0 before the hardware is powered on,
would using the cached value here cause us to read and modify standard
PCI configuration header registers instead of the PCIe Capability
structure?

[ ... ]

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index be20a520255b6..6f0556336f440 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -114,12 +114,9 @@ static void k1_pcie_disable_resources(struct k1_pcie=
 *k1)
>  static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
>  {
>  	struct dw_pcie *pci =3D &k1->pci;
> -	u8 offset;
> +	u8 offset =3D pci->pcie_cap + PCI_EXP_LNKCAP;
>  	u32 val;
> =20
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	offset +=3D PCI_EXP_LNKCAP;

Could this also experience the same issue if pci->pcie_cap evaluated to 0
during early core initialization, causing offset to incorrectly point to
0 + PCI_EXP_LNKCAP (0x0c)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509135152.2241=
235-1-18255117159@163.com?part=3D3
