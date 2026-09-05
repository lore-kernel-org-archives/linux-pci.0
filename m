Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40299367B8E;
	Sat,  5 Sep 2026 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644291; cv=none; b=lqorWjDnYPIQbHLiW+w+bxzQyC4+G6a4ys6UKFtA9zdrmXJ32NsxcqIyn8fTVQVEgH8KFCl10jUkW3fsXdSKwU1qUGC1t4+u3Fu5pTF5EpPKxIGo7zMMX8fn0whHW4k6fE9KiXO92E8C8xcpH7uWEHLXuIoYT3e2fb4YqeiRVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644291; c=relaxed/simple;
	bh=dg9l3qHAbAv+89GO7oBqFGSzhDGY3bWEM9faWkRoTc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RCYjc5XHBS44B0m4RILrh/GmhGnX+MJyDpKgOrb0EU0OhYSGJp1RjWtmWB7uLFaqOAJr0OvdMbftCGwu84rK6Tv4aYZrBD47V2/I6MGqxkct16ybtwKiA8aBaIucte+vTp7eD5LA5E533Q+ThA163wy4Lc3XC6RnPbu3CwDpvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb1BYc+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb1BYc+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9232B1F00A3D;
	Sat,  5 Sep 2026 21:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644289;
	bh=bCs2NXqgPNzxXzc+0XKB+5VAFCb4kpeMjjYVRS1mpzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hb1BYc+VEjKHN+L5/+hAKKDifx3vvT+FfUMWYJ29gWo4VpVHictN8ctBdHydxjjAQ
	 nzOweG2fERBwRh7sBipW5yY/cM6zLNRq6r7jRhNu9NOoN/EKjYhhPGzqjc4/duFqGW
	 l2joC7u0ShxvVPUib0fKYCtmM/QJA0xIU3bT6w/1CQx0/TCgPd2zBmw8v64MHRFjpg
	 pTqMKDP9ueeGMsePbT/JQGuLo2qLbw9wUKpOmw/rTbzxfTYne/OQT/XUktvnHvQAjl
	 huWir9WXLEqEs3eEIN5jWYINMKYKc2pdhrAfcmJi5zUul3kH7PFQKguRu7vIJJ+EDD
	 MxYWkJQdm9s1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] PCI: dwc: rcar-gen4: Add .deinit callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260905212649.360498-4-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 21:38:09 +0000
Message-Id: <20260905213809.9232B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing early return or goto in error path of rcar_gen4_add_dw_pci=
e_ep().
--

commit 2da5cda33af2a170742ef5426b300f42371937c6
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

    PCI: dwc: rcar-gen4: Add .deinit callback
   =20
    Add .deinit callback in preparation for R-Car Gen5 support. The
    .deinit callback will be used to tear down the PHY on R-Car Gen5.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index a19ebbab2f8c3..04871ac11c348 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -580,7 +581,7 @@ static void rcar_gen4_pcie_ep_post_deinit(struct dw_p=
cie_ep *ep)
>  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> =20
>  	writel(0, rcar->base + PCIEDMAINTSTSEN);
> -	rcar_gen4_pcie_common_deinit(rcar);
> +	rcar->drvdata->deinit(rcar);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at
rcar_gen4_add_dw_pcie_ep() in this same file:

	ret =3D dw_pcie_ep_init_registers(ep);
	if (ret) {
		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
		dw_pcie_ep_deinit(ep);
	}

	pci_epc_init_notify(ep->epc);

	return ret;

Should the error path for dw_pcie_ep_init_registers() return early or jump =
to
an error handler?

If dw_pcie_ep_init_registers() fails, the code falls through to
pci_epc_init_notify() despite having called dw_pcie_ep_deinit(). This causes
the Endpoint Controller (EPC) framework to spuriously notify registered
listeners (like EPF drivers) that the controller is successfully initialized
when it has actually failed and been de-initialized.

Could this lead to use-after-free or NULL-pointer dereferences in the EPF
drivers attempting to interact with the torn-down EPC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905212649.3604=
98-1-marek.vasut+renesas@mailbox.org?part=3D3
