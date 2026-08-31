Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8524D90CD
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186306; cv=none; b=FoB+dZnghnfVI1dtYj7ONFOwWAREhq+A7+mDuGz8vm+mk3Erj6bF3hSgzilKpMlvhe8Vg+p42Es8PC4ObdupBxRtgokrx7pnyNRcyGXlNQXAP+doucNcX0/n19lBhHVpyr3+wyl3wDCIN4/YOsXumNkSHrpux6rGnBgUtydXKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186306; c=relaxed/simple;
	bh=7MpR5ekUBzI1UzJsOKHWRyhnL1oCJHvHXwT/erCJOVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ws4Wnr5gBHMr0MsX/0EjZrzXmCzNpbe9gKAGUFZENaSQPdiys21rFSVnmHYLoSW93eH4kmtT+pPIlFd/H+P9OPE/TrXpjt0xI4d2RRGrVFKBCN9bxpZ5HXSEnEConFeqoRw4elTxlzhYPnCUaEkyFxTw1B/G+SgGRTZWFMbepLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO68rDZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO68rDZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC871F00A3D;
	Mon, 31 Aug 2026 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186304;
	bh=xmSC/nYYITSZwCP72nkXMgj3B5GvaMx+2yn4onGlVwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QO68rDZRlLcILn7PxTBZgc8CAKy0H2LC0VpXDPLTWuKeOkxQ/Pf+5plxR2WJTO7Xs
	 WoMG6GbqdzCCLz5KaeKeTXdSsUHqeSXWujeV0KBa5qKd2cC98ntxjUQpGsQWUT0ro7
	 DKIltTVLGuTIfQy7BqFCnT1cYF+1ofMxf8+J64ZQAnylHhLb8d2jM1RImGE6TspnAO
	 +eEVS3JByzpsl0wIn1HQ/kgeszeVGlxN+7JmuXcoQm2axjAoV+lhdQjQHwZw1zvycs
	 seTOaCjWNlkFz+wX8DvbehxAq536ewVRcLIPrk8oQOoQU6Cwyou0VCJpA7jcw8FN+O
	 sKomp4Bq0+b2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Skip system suspend/resume for
 firmware-managed PCIe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mrinmay Sarkar" <mrinmay.sarkar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831-skip_suspend-v1-1-ba2d877e22b1@oss.qualcomm.com>
References: <20260831-skip_suspend-v1-1-ba2d877e22b1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:25:03 +0000
Message-Id: <20260831142504.5EC871F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Redundant OF match lookup in latency-sensitive noirq suspend/resume=
 fastpaths
--

commit c4c9a4ee7ca3ece5a2758b2afa96d34b1ed85c1a
Author: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

PCI: qcom: Skip system suspend/resume for firmware-managed PCIe

This commit skips host-managed suspend and resume operations for PCIe
controllers that are managed by firmware. It relies on the generic power
domain framework to handle the necessary transitions instead.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2341,6 +2341,10 @@ static int qcom_pcie_suspend_noirq(struct device *=
dev)
>  {
>  	struct qcom_pcie *pcie;
>  	int ret =3D 0;
> +	const struct qcom_pcie_cfg *pcie_cfg =3D of_device_get_match_data(dev);
> +
> +	if (pcie_cfg && pcie_cfg->firmware_managed)
> +		return 0;

[Severity: Low]
Is this new OF match lookup redundant?

Since qcom_pcie_probe() bypasses setting drvdata for firmware-managed
controllers, dev_get_drvdata() already natively returns NULL for these
devices. The pre-existing check just below this addition handles that:

    pcie =3D dev_get_drvdata(dev);
    if (!pcie)
        return 0;

Because this executes in the noirq phase where local CPU interrupts are
disabled and latency is critical, does it make sense to avoid the overhead
of of_device_get_match_data() string comparisons and just rely on the
existing NULL check?

> =20
>  	pcie =3D dev_get_drvdata(dev);
>  	if (!pcie)

[ ... ]

> @@ -2399,6 +2403,10 @@ static int qcom_pcie_resume_noirq(struct device *d=
ev)
>  {
>  	struct qcom_pcie *pcie;
>  	int ret;
> +	const struct qcom_pcie_cfg *pcie_cfg =3D of_device_get_match_data(dev);
> +
> +	if (pcie_cfg && pcie_cfg->firmware_managed)
> +		return 0;

[Severity: Low]
Similarly for the resume path, does this introduce unnecessary overhead in
the noirq phase?

The identical dev_get_drvdata() check is present just below this addition,
which already safely catches firmware-managed controllers and returns 0.

> =20
>  	pcie =3D dev_get_drvdata(dev);
>  	if (!pcie)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-skip_suspe=
nd-v1-1-ba2d877e22b1@oss.qualcomm.com?part=3D1
