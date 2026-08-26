Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB53A63F2
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729954; cv=none; b=bHucI9tWexT8IlGh5XMI1nV1zFJyu9d4t/AoSqANvRRuxdqG8HWbKXpT4cdXl0km+mdPvWo3MktfZ/CekWhW0H3ulXfrWlN6/JtLjK1SJxYpxqbv/mpQiWj8dn6lmZkUu+/DTIq54R9+q+MM+9dYIpzmbNrnxOz2Tj40uVURyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729954; c=relaxed/simple;
	bh=tbCekKeCyX/BUT50GT1+8T6/6IrU4Sg00W2kt+elkOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NEi+pCtfq1Qsv2eGKCDFKKmeCmHpliT9hQ1lX+H8j5QeErMVGJhTFJqsVA7jxUbf5F7yqmdEDQ1C+MnMvZHCNNtRC4Fe6P3hFDBZ3O2h8z7wXSX6CGHRcblZoIR44uFaN1/DoGsks2du+gxylB2pXMmrLbHYsTLmF5gWNYEsfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPBT1fGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPBT1fGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE2A1F000E9;
	Wed, 26 Aug 2026 07:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787729952;
	bh=mp/VaVH8iv2dgwJ8DHdwo/67JHB+d805KL2fDr5JNEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPBT1fGhr0gKjeSViUWL/H7c+a3lZ7W5wkNwSlwtO8hPPL2++xD0M9HxaJ9VRcRwv
	 4a8Hvxy42VRtg4MyVKw6hSOt85/MXheTeWri3XcWD76ruGAFSLLr/Jf1+MFrQRBDZz
	 uPeJ7UKx88Drc5pogFhPMJOPvLsO50Mowp7nSe6J88K0qlMrfWg6TPnAixIJAOVQJp
	 RhyDtxQ+DvafPObUA/mycfjWiOeqLLh99HUmSYOWHHD0z/2ru49HHUE5/EqR9lmsNY
	 4jy/SdicGafP6AJd4Lv+Lu126cvY+H/VSyJdvTGzLggkBS3eGk4mrUb1F3FtZjD70h
	 Yoa0zS+KSATOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260826-shutdown-v4-1-eb5fe9d454ae@oss.qualcomm.com>
References: <20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com>
 <20260826-shutdown-v4-1-eb5fe9d454ae@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:39:11 +0000
Message-Id: <20260826073912.ADE2A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete evaluation of `pme_capable` during shutdown breaks Wake=
-on-LAN from S5 by improperly cutting auxiliary power.
--

commit d9876255ad827b6e1f2d6b4bca95ab65c2ea8123
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

This commit modifies dw_pcie_suspend_noirq() to detect the shutdown/reboot
case and forces L2 entry without checking if endpoints have transitioned
to D3hot. It unconditionally calls pci_host_common_d3cold_possible() to set
pme_capable but ignores its return value.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index f5a38e6fd8d79..5d07a742faa16 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
[ ... ]
> @@ -1224,14 +1225,25 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *p=
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
> +	 * to D3hot -- there's no point walking the bus to find out. Call
> +	 * pci_host_common_d3cold_possible() anyway (ignoring its return value
> +	 * in the shutdown case) since it's also how "pme_capable" gets set.
> +	 */
> +	d3cold =3D pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable=
);
> +	if (!d3cold && !shutdown)
>  		return 0;
> =20
>  	if (pci->pp.ops->pme_turn_off) {

[Severity: High]
The commit message notes that endpoints are frequently left in D0 during
shutdown. If an endpoint is left in D0, won't pci_walk_bus() abort early
during the pci_host_common_d3cold_possible() call?

Looking at __pci_host_common_d3cold_possible() in
drivers/pci/controller/pci-host-common.c, it returns -EOPNOTSUPP if it
encounters a device not in PCI_D3hot:

drivers/pci/controller/pci-host-common.c:__pci_host_common_d3cold_possible(=
) {
    ...
	if (pdev->current_state !=3D PCI_D3hot)
		goto exit;
    ...
exit:
	*flags &=3D ~PCI_HOST_D3COLD_ALLOWED;

	return -EOPNOTSUPP;
}

Because pci_walk_bus() aborts immediately on a non-zero return, downstream
PME-capable devices won't be evaluated, leaving pme_capable as false.

This would cause the driver to unconditionally cut auxiliary power. Does th=
is
incomplete evaluation of pme_capable break Wake-on-LAN and other PME wakeup
features from the S5 (poweroff) state when devices are left in D0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-shutdown-v=
4-0-eb5fe9d454ae@oss.qualcomm.com?part=3D1
