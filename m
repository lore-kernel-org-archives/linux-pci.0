Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4319C553;
	Tue, 28 Jul 2026 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202664; cv=none; b=BNVHXJJO4LuGbHQ7s8vB2ba5/jbscNx34GJXIzUcY1eGigLiuWkVPwNknwY5kHL7RMd1Qjn/sq1kQ7LiBFNGATt96WBiAprZJrIbbXZgqFJjej48HaX8fw6x4Ij3VowVNgtLRmM5uxX/GgCSeirRE0aYHtXrCIGdnK69nkXojeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202664; c=relaxed/simple;
	bh=3dh02CtdbCTIYfEJY52EoA1Vwc7DhtF4Nj5u9LaC7v8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dAGXoT7yUHxviPqcfkzcuteF9PUU7asvEbAASmU/sL8PkqxmKbsNK2MTByABf972LJ4gpzjfJmJhxOVHA5PBTz5+oRRRalbnbxsGGxwR4BuxjcFJfrvIr4TNQ8FIGooNgFgg1wzoVBlTTQf7xmXFWfo298e4c+2rxFdf2p3jYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi0WRylC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi0WRylC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C292A1F000E9;
	Tue, 28 Jul 2026 01:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785202663;
	bh=B3vtpMFzFhKabsV0uirG/fEDlvriRjCdOri8B+AvNwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hi0WRylC7qUZCcOSyTFVPx4hCGOoFYPmV5HeuNWWKO7ckdl+YPRL6LNl6H5HXOkjf
	 1BkEIwVBjFEMdrBX4UKyRKY1feZlQe36cxr1lcOdrBpYvJosrOZqE037jRCCBEKqAd
	 P1VfP3IndsU6kCOrwTOLC2E1NRv+Iiy3B4VSVIGoCML03AFfLVe0D2XktNHqZK1mKq
	 fO3gvvjNnFhaHrG1uwUwqo1PoTLF6VQtCfYsqmIaMuoo1YIF1+eARD2Vj+RQKyYitE
	 U+1u0+lYCiiyd3o8JvaWObbHO/NHkWO12B088hdFcnMM8RIR0LsFMrzxw34m1opMLt
	 iJMK6UNWbPGLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: Handle return value from endpoint
 .pre_init callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260728012548.465139-3-marek.vasut+renesas@mailbox.org>
References: <20260728012548.465139-1-marek.vasut+renesas@mailbox.org>
 <20260728012548.465139-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:37:42 +0000
Message-Id: <20260728013742.C292A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional cleanup in the rcar_gen4 endpoint driver leads to a =
double-disable of clocks and an unsafe unclocked register write when `pre_i=
nit` fails.
--

--- Patch [2]: [PATCH 2/2] PCI: dwc: Handle return value from endpoint .pre=
_init callback ---
commit 275f56803dca69c843553d94d9e95ba4e8dc68ae
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: Handle return value from endpoint .pre_init callback

This commit updates the DWC PCIe endpoint code to check and propagate the
return value of the .pre_init() callback. Drivers implementing this callback
are updated to return integer status codes rather than void.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index d78fb845582b2..b00239097d893 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
[ ... ]
> @@ -1524,8 +1524,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ret)
>  		return ret;
> =20
> -	if (ep->ops->pre_init)
> -		ep->ops->pre_init(ep);
> +	if (ep->ops->pre_init) {
> +		ret =3D ep->ops->pre_init(ep);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	ret =3D pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
>  			       ep->page_size);
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 8b03c42f8c84c..55ef0da9146c2 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -373,7 +373,7 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rcar_g=
en4_pcie *rcar)
>  }
> =20
>  /* Endpoint mode */
> -static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> +static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
>  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> @@ -381,9 +381,11 @@ static void rcar_gen4_pcie_ep_pre_init(struct dw_pci=
e_ep *ep)
> =20
>  	ret =3D rcar_gen4_pcie_common_init(rcar);
>  	if (ret)
> -		return;
> +		return ret;

[Severity: High]
If rcar_gen4_pcie_common_init() fails, it will disable the PCIe clocks befo=
re
returning the error. With this patch, the error is now propagated back up
through dw_pcie_ep_init().

The caller of dw_pcie_ep_init() will then unconditionally perform cleanup:

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_add_dw_pcie_ep() {
	...
	ret =3D dw_pcie_ep_init(ep);
	if (ret) {
		rcar_gen4_pcie_ep_deinit(rcar);
		return ret;
	}
	...
}

Because rcar_gen4_pcie_ep_deinit() accesses the unclocked PCIEDMAINTSTSEN
register and then calls rcar_gen4_pcie_common_deinit(), could this result in
writing to an unclocked register and triggering a synchronous external abor=
t?

Could it also cause a clock framework reference count underflow when the cl=
ocks
are disabled a second time during the cleanup?

> =20
>  	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
> +
> +	return 0;
>  }
> =20
>  static void rcar_gen4_pcie_ep_deinit(struct rcar_gen4_pcie *rcar)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728012548.4651=
39-1-marek.vasut+renesas@mailbox.org?part=3D2
