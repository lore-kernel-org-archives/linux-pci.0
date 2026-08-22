Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA7349CD8
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787377771; cv=none; b=JwMzzx3dLQOcS+LxI8eo93tcBn3Iz0xJ+w5fvFTUlwMW0NqolJf2+r2eIM8/CpRq1xBj0dHQ44ju0eDX0ZYNKZbVy8UqlbPd6aeSxfXzcKJ+Z1FU2jcFnAU8stVyVKMVXvJicsPW3uX1qODHQomqgTjD75zZYzNw7OYdyEc2sDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787377771; c=relaxed/simple;
	bh=yptXp9HvHREZR0KM1IeMAv6vJZL2ojK/GdkqAcsrJRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=muEFFBNMXq242o1KrfT+9FnDzK7we206Eqg0VK75jzrBFKhIFrg+XmFmVVtS3eSuMjJJ2t3z9Xukh/ctAFayEpVPZHQFtOggTSGxPzSaWjsDexm3Dr+gMzYs0OBWeyaVl25ot1bsAZDy1QNuGEWGmrquUt9DnGs8UG3MpavYpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INHTjW1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INHTjW1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D00F1F000E9;
	Sat, 22 Aug 2026 05:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787377770;
	bh=IGTcKmker5amZzpPffbpptg1kQQW+hqmfIZryuAA6sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INHTjW1x7bUN9oaVF0S2j0/BJeKfTTka2E76MFarwu5alPmAdRAoX8aNp1RTAOKTX
	 9GVHCw4lK6NmwC1RV/sga5Z5Q159Wcz4ayEkWINLRFkKZ5geuNVxZGDtVVRyRC5RQx
	 5rRkY9XaTFLaoQSSCKuP4esgyLaU23Itm+MP1djPUMYyOSK3XCghg2A8RjJ9XPrnt5
	 zSOy4FfR5eu4GF96fN8xwhhzo88ViyeG0ole6junIc8YB5+kJYlTNJf5463haSUmMT
	 BcU2X5gUEATxV39BG2080NT6HNjffzAOT5zjObt2SI1qiK8Pt0k4Ae75GyG+qktbAZ
	 EdJzlbohZiNZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260822-shutdown-v2-1-520a68f1b4a5@oss.qualcomm.com>
References: <20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com>
 <20260822-shutdown-v2-1-520a68f1b4a5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 05:49:29 +0000
Message-Id: <20260822054930.0D00F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch breaks Wake-on-LAN and PME from S4/S5 (hibernation/power=
off) by unconditionally powering off PCIe endpoints and disabling auxiliary=
 power.
--

--- Patch [1]: [PATCH v2 1/2] PCI: dwc: Force L2 link entry on shutdown/reb=
oot without D3cold check ---
commit abaf02ec8187ffca064828adacb9cade46a5b293
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

This commit modifies dw_pcie_suspend_noirq() to force the PCIe link into L2
during system shutdown or reboot. It bypasses the pci_host_common_d3cold_po=
ssible()
check to prevent the link from staying up when endpoints fail to suspend.

> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
[ ... ]
> @@ -1222,16 +1223,29 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *p=
ci)
> =20
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> -	bool pme_capable =3D false;
> +	bool shutdown =3D system_state =3D=3D SYSTEM_HALT ||
> +			system_state =3D=3D SYSTEM_POWER_OFF ||
> +			system_state =3D=3D SYSTEM_RESTART;
> +	bool d3cold, pme_capable =3D false;
>  	int ret =3D 0;
>  	u32 val;
> =20
>  	if (!dw_pcie_link_up(pci))
>  		goto stop_link;
> =20
> -	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
> +	/*
> +	 * During reboot/halt/poweroff the link is going away regardless, so
> +	 * force L2 entry without checking whether endpoints have transitioned
> +	 * to D3hot -- there's no point walking the bus to find out.
> +	 */
> +	if (shutdown)
> +		goto d3cold;

[Severity: High]
When shutdown is true, the code jumps straight to the d3cold label, entirely
bypassing the pci_host_common_d3cold_possible() check. Because pme_capable
is initialized to false, doesn't this mean it will unconditionally remain
false during shutdown or poweroff?

If pme_capable remains false, later in dw_pcie_suspend_noirq() under the
stop_link label, we set:

	pci->pp.skip_pwrctrl_off =3D pme_capable;
	dw_pcie_stop_link(pci);

Will this cause the host driver to explicitly cut auxiliary power to the
endpoints, breaking Wake-on-LAN and PME generation from S4 (hibernation)
or S5 (poweroff) for devices that were correctly configured for wakeup?

> +
> +	d3cold =3D pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable=
);
> +	if (!d3cold)
>  		return 0;
> =20
> +d3cold:
>  	if (pci->pp.ops->pme_turn_off) {
>  		pci->pp.ops->pme_turn_off(&pci->pp);
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-shutdown-v=
2-0-520a68f1b4a5@oss.qualcomm.com?part=3D1
