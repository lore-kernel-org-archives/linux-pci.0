Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5E352007
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550771; cv=none; b=MpixWH6yvPLFT9vNycI1iMz3cPGPbgsf/0wuUysqJ9qz3DkNmN0xYAJduKruUK7GPleJ3L4bchTGKTkMQ+E3jdpNRLQdBLFYOClYLIewsNUj5jVEmZq0MPyn6mqWghLIzJ90DRpJYa3dd/f4GCn29+MqqsoYreeMhH0ByeY88VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550771; c=relaxed/simple;
	bh=0oCy/G+S5FSCi8i34LEk8E8UnPAoECdfhL8ZngudmYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WFoq6LYcaVYI4ppw5IYjdVa/iJoJ7rBcIOmcnPlHaIK1YKOrCMaULRqRKbP/NHAueP8zYhqGM7MsjNKESt1ix3O3fT9T8rUJMAurUcaQSqJoagWwDerSjI9gkt2t/FO3WNQRJDJhuR8W8PG5k5Rjpft3+Iyh/TXWFo2LIRYMXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIU6fna8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIU6fna8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6E01F000E9;
	Mon, 24 Aug 2026 05:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787550769;
	bh=vIsK++JfVkVCBJpmvYe1nviZgsfLgrExptqFwAqTk5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PIU6fna8fVapWyXqnXRVeBIO/7fF6CSvWKhGTAvEIj81gK47+CVT/2FhLatDaLYOm
	 5foPPG1VJCOagdA6MQDs7tli5jfi56UZUS4Ypjz5fmyK4SpNqGiAhoebtdVIF9dtII
	 NxKRfygsNY8SOEa7XZrLsEdopjFUzyVBEgGQo7T/7Tt4Lj02fhSfwezmlZWEA3Aht7
	 RANqmEdujeCRGwtzVrey03C4nNS1qFj5dBqVki5L5Ng7pId2QcMbOKNSKdq5/NdY5B
	 OocnrtSlYwLvND0Fqo5SEVuZxtO6358c17pSAuWt52E+E8lKFsh3zrZNFwGc0pgu2c
	 56cUosC0pCD1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260824-shutdown-v3-1-81c14bb7a1af@oss.qualcomm.com>
References: <20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com>
 <20260824-shutdown-v3-1-81c14bb7a1af@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 05:52:49 +0000
Message-Id: <20260824055249.AE6E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Forcing PME_Turn_Off and cutting VAUX during shutdown unconditiona=
lly violates the PCIe Base Specification and breaks S5 Wake-on-LAN.
--

--- Patch [1]: [PATCH v3 1/2] PCI: dwc: Force L2 link entry on shutdown/reb=
oot without D3cold check ---
commit a2c00716f7d3b58c02f9dc631c72c6f185e30be1
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

This commit modifies dw_pcie_suspend_noirq() to bypass the D3cold
capability check during shutdown or reboot. It unconditionally forces
the link into L2 state to avoid delays or failures when endpoints are
still in D0.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 06722259d2e37..98cd9dd2c7d79 100644
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
Does skipping the D3hot verification and jumping straight to d3cold cause
the controller to broadcast a PME_Turn_Off message to endpoints that might
still be in D0?

Section 5.3.3.2.1 of the PCIe Base Specification mandates that all downstre=
am
devices must be in D3hot or D3cold before software sends this message.

Also, since jumping to d3cold skips the call to
pci_host_common_d3cold_possible(), pme_capable remains false. Will this
cause the driver to incorrectly set skip_pwrctrl_off to false later in the
function:

stop_link:
        ...
        pci->pp.skip_pwrctrl_off =3D pme_capable;

and unconditionally cut Vaux power to the bus, breaking S5 wake-on-LAN for
devices that were prepared for S5 wakeup?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-shutdown-v=
3-0-81c14bb7a1af@oss.qualcomm.com?part=3D1
