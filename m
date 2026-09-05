Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30E2F6586
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570116; cv=none; b=mjCutSfF+vtB+xM7UKnrNvOlIf0vrZIiQG2/tjCpL1wk0y7nrXBw/+AWcS3mdTq1Xz6Higl9luKn6gOsY+Ph8yHlnEEPreSTShIkbW6aAmGHho3CDvRxgwBOPgEX6TX5zYSoea+aOek/bNsXgvaSktXbaiVD36DrSPdNTyeBD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570116; c=relaxed/simple;
	bh=5Uf1Hfi7jXACpdavT/SMPcKTxUtImKryrKDlze5Gzag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qdrL5oYySWINUyEAZw70J6fP4ypiENzS57qOAXW2JMRjhG6M2dHKxzgYZJr8H3+vLH+2swC4JUxs2FoDdyO6wqABSGS50bY71RqQwjr6G9O7CHou5cRSJweDIGYrQAAsubnYDZGLDo+40Xah8JaGwI+HRvY9Yjdl6OFCwDxeau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK65b/lk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK65b/lk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA95D1F00A3D;
	Sat,  5 Sep 2026 01:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570113;
	bh=f+eFBPIhHuN6nA3JI8iy7ZpHZTm2WrUYwmALG4sHgVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XK65b/lksx25J3ZjybBgvqPbh8CxsXAWI434smu2GzZP9V7fgdNppUlRLzcKk3N23
	 Cmw1p8Xm2+yKy3gRVtQenJKzfFHq5htoqRk3bFjqr1R+63jsCtF5g19UJtke3wSSYv
	 WPi+KUevMmhtTmv3k3d9v/JY9QQc1MAwAkEeG2H4hHW4B/E7vdnovlJkGb/k4o3fTN
	 /x2X52qj8tTRjZi7Wtrc+gu69GlMysNx22BshexMYvOYbcrvJXGOc0hPo4T8Yv51q5
	 QX8uS6fXZvGSZMeDb5tXIeVz4wWsBXluhW04+2HPZd3jhAJuh+c1V+Vw9p+oPtKaQk
	 1Y2prBDZr+/Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905-shutdown-v5-2-f0c6bafa1d4f@oss.qualcomm.com>
References: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
 <20260905-shutdown-v5-2-f0c6bafa1d4f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:01:53 +0000
Message-Id: <20260905010153.BA95D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Functions in the dw_pcie_suspend_noirq() call path use sleeping fu=
nctions like read_poll_timeout() and ioremap() in a noirq atomic context, l=
eading to kernel panics.
--

commit dcb22ca0634090a97fec1c0ad3528317b8e40f06
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
to check whether every downstream endpoint can be put into D3cold before
bothering to move the link to L2. If no endpoint supports it, the
function returns early and leaves the link up. This patch adds a
force_d3cold flag to force this behavior.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index f5a38e6fd8d79..a8a3861c29560 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1224,14 +1224,15 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *p=
ci)
> =20
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> -	bool pme_capable =3D false;
> +	bool d3cold, pme_capable =3D false;
>  	int ret =3D 0;
>  	u32 val;
> =20
>  	if (!dw_pcie_link_up(pci))
>  		goto stop_link;
> =20
> -	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
> +	d3cold =3D pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable=
);
> +	if (!d3cold && !pci->pp.force_d3cold)
>  		return 0;
> =20
>  	if (pci->pp.ops->pme_turn_off) {

[Severity: High]
This isn't a bug introduced by this patch, but does the path continuing past
this check lead to a kernel panic in an atomic noirq context?

If we do not return early here, dw_pcie_suspend_noirq() can call
dw_pcie_pme_turn_off(), which dynamically maps memory from a context where
interrupts are disabled:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_pme_turn_off() {
    ...
    mem =3D ioremap(pci->pp.msg_res->start, pci->region_align);
    ...
}

Functions like ioremap() take locks and use GFP_KERNEL allocations which can
sleep.

Furthermore, dw_pcie_suspend_noirq() then calls read_poll_timeout():

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_suspend_noirq() {
    ...
    ret =3D read_poll_timeout(dw_pcie_get_ltssm, val,
                            val =3D=3D DW_PCIE_LTSSM_L2_IDLE ||
                            val <=3D DW_PCIE_LTSSM_DETECT_WAIT,
                            PCIE_PME_TO_L2_TIMEOUT_US/10,
                            PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
    ...
}

The read_poll_timeout() macro invokes usleep_range() when the sleep paramet=
er
is non-zero, requiring timer interrupts to be enabled.

In an atomic noirq context, this causes a scheduling while atomic panic or
system deadlock because local interrupts are disabled and scheduling is
forbidden.

Should read_poll_timeout_atomic() be used here instead, and can the ioremap=
()
call be avoided during noirq suspend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-shutdown-v=
5-0-f0c6bafa1d4f@oss.qualcomm.com?part=3D2
