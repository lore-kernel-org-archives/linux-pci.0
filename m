Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275D29D26E
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156906; cv=none; b=Q9zYQxlnnZhlJuchBXmDM3y7tqM9S/xOBlYab9ngJtJDvss3Zr0n/gH3gh23479QVAN2ifiXK6J7vZDZS5WuUC2LN1ILtktZ/l0n1+bqaz32Wd10sseUQXMWMAvn72i513lOG5rFPfGpODFAlFqCidrRnDh6DBNUTXTbL7RyhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156906; c=relaxed/simple;
	bh=7Lg8lN6mAAui59ZYJ3GKBZNtYj/XhG8UGTlwGEjcML8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pr+KGIidLTMmuHptgEjRCqy6w80cNr93gxvEc3JxOP9uXG0+fIEUfUfmoIYcmTDHB93524JLlRAiA2jxn0/IwrIQ23GZ4jhZTYBElkQK4V92rwbjA2d0eRC34bBiNr6m7PQXJM5pJMcQ7LDIcf/mByoqmhMIuodUMeZJC6VvhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyjnZkIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyjnZkIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9271F00893;
	Sat, 30 May 2026 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780156904;
	bh=I9Qicoa2cO8BHdSP4pLw2C0jT9oTaAXlgLJjN6d4fqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OyjnZkIG9pMw4HmaxJYxvq+nAJ0DXvjMaUzo7ahZXjSwBux3Q3Zg7cOQ8kzD9N99b
	 +/MbY64tzd44b/BafC0ulIAR0X3+79ywHeSkChj3HywSv8y0LP4xWlq9W3/2UjmXCC
	 kHx2C3Uo++xm/cF+M8fApD6cqGaM2PcA9Dq4iWQmZq+00S8kYrHpezcE3xkhNPjA28
	 sA4RL2shGRRFTdH6uRYOEYShw2FU7/l3tJ+0CxyLUPeq7Ywl2jRG5EIhkEETwhfGHK
	 cuUh6HabuTOLVT7fe20wqRkO8N6l+3NfZOUMdu0wFwHx3Edr0Y41o2sKvVUJSm9K4J
	 i/XSv7k+l0LHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/16] PCI: dwc: rockchip: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-7-18255117159@163.com>
References: <20260530153101.695580-7-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:01:44 +0000
Message-Id: <20260530160144.7E9271F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The IRQ domain and chained IRQ handler created in RC mode initiali=
zation are never cleaned up if host initialization fails.
- [High] In EP mode, the devres-managed 'sys' interrupt can fire while cloc=
ks are disabled during the probe error path.
--

commit 2570eaad60265910abfe106597d119f992b11a1b
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: rockchip: Use cached PCIe capability offset

This commit modifies the initialization sequence to trigger caching of the
PCIe capability offset. It replaces a direct capability search with the
cached helper function dw_pcie_get_pcie_cap().

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 731d93663ccae..be8b6187913df 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c

[ ... ]

> @@ -369,7 +369,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *=
pci)
>  	u32 cap, lnkcap;
> =20
>  	/* Enable L0S capability for all SoCs */
> -	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	cap =3D dw_pcie_get_pcie_cap(pci);
>  	if (cap) {
>  		lnkcap =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
>  		lnkcap |=3D PCI_EXP_LNKCAP_ASPM_L0S;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the RC mode
initialization in rockchip_pcie_host_init():

    irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler, rockc=
hip);

The IRQ domain and chained IRQ handler are created here, but there does not
appear to be a corresponding teardown path if host initialization fails lat=
er.
If a subsequent step in dw_pcie_host_init() fails, it relies on a .deinit
callback to clean up.

Since rockchip_pcie_host_ops lacks a .deinit callback, does this leak the I=
RQ
domain and chained handler? When the probe function returns the error and
disables the APB clocks, could a subsequent interrupt on the legacy line
invoke rockchip_pcie_intx_handler() while clocks are disabled, causing a
synchronous external abort?

[Severity: High]
This is a pre-existing issue, but I noticed a potential race on the error p=
ath
in EP mode in rockchip_pcie_configure_ep():

    ret =3D devm_request_threaded_irq(dev, irq, NULL, rockchip_pcie_ep_sys_=
irq_thread, IRQF_ONESHOT, "pcie-sys-ep", rockchip);

We request the 'sys' interrupt using a devres-managed function. If a later
initialization step like dw_pcie_ep_init_registers() fails, the probe
function jumps to the deinit_clk label and manually disables APB clocks usi=
ng
clk_bulk_disable_unprepare().

Because devres resources are only freed after the probe function completely
returns, the IRQ remains active while the clocks are turned off. If the
interrupt fires or is pending during this window, will the IRQ thread attem=
pt
to read the PCIE_CLIENT_INTR_STATUS_MISC register without clock access and
trigger a kernel crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D6
