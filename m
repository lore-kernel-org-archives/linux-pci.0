Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313853806D6;
	Tue, 28 Jul 2026 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211328; cv=none; b=SlXr9vA/7XML9suupHJrCudomtIpDOIhUIt3TaN5hn3GT5qBoH9Umsq8LY4fJbo7LfszNlWwfcGe2zi7u4oc42EPMOVTAkLoqqQAnxClfkXw6uSiXZOefRtpMUAxQ0DuV2Mtzy/khawktoELQ2J8DoAJfIpJ8N1aU39BAjLJOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211328; c=relaxed/simple;
	bh=mWDXdesxhwUEC/ETaTH/ABiI+bvEP3vtTKtmPT78L8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udQRBtmdrioaKiv2jLWPYMBG1dzpONsX3a5QuZoolcYRoc5FIulMddaBRJ6zvaH/p+qf7sHSdq5IpozTaAGY3MGwYFUmKJBsJCPHO3eudlZKRCrFreu/PPk42dNdNzrERTvU/2T4JWtNBAOy59JISyL+S218LXdwijqlPDXY2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUAo2GkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUAo2GkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977041F00A3A;
	Tue, 28 Jul 2026 04:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211326;
	bh=/V0JnGUlZ5kM68UZ8vuRmuIODbAsSvBBMee9Qlx4Ba8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUAo2GkV6RyYtWvROH4L0DNuUy4N7x1+m6AZcUz/6F8a90wYEbBoxDOk8bASnYuCq
	 1B+kZMpONDYqEefjZ9TUb1VUKrATAITcp805i2GubGqtO6b32bx0PGHqleo2Zx+S0q
	 2srO8xB8C6mvH5hJ2EY1QdHgKd30KDjKidbWGuzRTmartWsCs1AGuCv39Y5C90PbZb
	 wKeFsU/1YFjy/4Ramyf6rTq6Q6h1r/ray5HMa0SiUQ47kxDNKWjS8/Y1EnJVO5dTDd
	 oHIZM/V0W+tn17r2/TeCl2cS6uz4Ur6dyusQE3t75Lpjww1tpJNJB0HPPCccOIZAnw
	 UgDSBVt3FvUuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: imx6: Fix i.MX6Q/DL boot hang caused by
 improper PHY power sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260728035159.2702021-1-hongxing.zhu@oss.nxp.com>
References: <20260728035159.2702021-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:02:06 +0000
Message-Id: <20260728040206.977041F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of `imx_pcie_host_init()` is ignored in `imx_add_=
pcie_ep()`.
- [High] Missing PERST# assertion in error and exit paths leaks power into =
the PCIe slot when regulators are disabled.
--

--- Patch [1]: [PATCH v5] PCI: imx6: Fix i.MX6Q/DL boot hang caused by impr=
oper PHY power sequencing ---
commit 5815e6ed3898888ef7843d167117ab98b00ad077
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing

This commit fixes a boot hang on i.MX6Q/DL boards by adjusting the power
sequencing of the PCIe PHY. It separates TEST_PD and REF_CLK_EN controls,
adds a delay for link training, and explicitly calls core reset assertions
in the error and exit paths.

Link: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@gm=
ail.com/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -1445,6 +1446,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
> =20
>  err_phy_off:
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	phy_power_off(imx_pcie->phy);
>  err_phy_exit:
>  	phy_exit(imx_pcie->phy);

[Severity: High]
This is a pre-existing issue, but is it possible we are missing a PERST#
assertion here?

If initialization fails (e.g., due to a PLL lock timeout), the error path
disables the slot power via pci_pwrctrl_power_off_devices() and
regulator_disable(). However, since PERST# was deasserted earlier, it
remains driven to its inactive state.

Can this back-power the PCIe endpoint device through its reset pin while
the main slot power is off?=20

Should we call imx_pcie_assert_perst(imx_pcie, true) before powering off
the slot?

[ ... ]

> @@ -1466,6 +1468,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *p=
p)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct imx_pcie *imx_pcie =3D to_imx_pcie(pci);
> =20
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	if (imx_pcie->phy) {
>  		if (phy_power_off(imx_pcie->phy))
>  			dev_err(pci->dev, "unable to power off PHY\n");

[Severity: High]
This is a pre-existing issue, but similar to the error path above, when
disabling the slot power during teardown in imx_pcie_host_exit(), do we
also need to assert PERST# first to prevent back-powering the endpoint?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the PCIe
initialization, I noticed a potential issue in imx_add_pcie_ep() in the
same file:

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
    ...
    imx_pcie_host_init(pp);
    ...
}

Does this code safely handle initialization failures?

imx_pcie_host_init() can fail and return an error code (for instance, if
regulators or clocks fail to enable), which correctly cleans up and
powers off the controller. But imx_add_pcie_ep() ignores this return
value and continues execution.

Later on, dw_pcie_ep_init_registers() unconditionally accesses the endpoint
hardware registers. If the controller was powered off due to the previous
failure, could reading these unclocked registers cause a synchronous
external abort (kernel panic)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728035159.2702=
021-1-hongxing.zhu@oss.nxp.com?part=3D1
