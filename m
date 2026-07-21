Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA43BADA5
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622575; cv=none; b=YEXoVeAOT+ElC2ZBCceHQa+oC3BNXOusbrBAXh3DCj+5MET3Dfi1cFSGtoYkxNfLw5ngAg77M3IuRZL5Ad0ctji4kGiuoNdL7smTir+CX6pX+mOWVEwb5So4Pic6gs6hmEVdT6FPNisDpSevMu6gFt1CgK8II2gKvAd1/D44Ois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622575; c=relaxed/simple;
	bh=2XLys/rOLNpOBnHv4PypnvUzFcho05gN9AEvFfOIdj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9SI3E+9XPs5BnWZbODVHYKxY2mwYd0foSBors8DZbLvE+oEs+UqxJEDUi8bU/lmcoCtRnULeJlT8Zk1VILox7VVIrttz1Vh99DKRQ/mAj1Sg5d501KDrRJuB2OKe3eoQ2YtmotGdhlpsip5XCXrsHVLblmQc1m6u4aQWe6RWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLdRLb58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLdRLb58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5A41F000E9;
	Tue, 21 Jul 2026 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784622573;
	bh=eBt5hOD59AelP7Fo4RCem42CLXOd7ydLRvNDzqS/6tQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLdRLb584Lxeux8cziXfO/6kGqkGiKKYT1yc5aQidmXD3bav9AFRCyI18mIvpmq77
	 r0SmppZx9tp8sUNk/eXsUDCkCsRB/BJmNFUmIyuukB97+C4XLmksNuOeaTJApYA2hK
	 nQQTGm01mxNtvGX8R3eqEMRiWpvI+MU9qV6JQ5oz5CkwLF85l+HJ4xuzlYYyDcyYVL
	 U7Gt6tf8lVIJOecB+BmZe+gh+CdwtKX275NneO53OfcjNQml3wuD0Rut9/iWQLJEXH
	 j2IgLX39veDFH4csxYxzGOyWxvPU1/2BjytWqQdS9T/kw+znqF/3zBSzu7Szp0Nh38
	 WrT2+rvuGm/kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13] PCI: Add device-specific reset for Qualcomm devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721081301.205374-1-jtornosm@redhat.com>
References: <20260721081301.205374-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:29:32 +0000
Message-Id: <20260721082933.7B5A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Polling MMIO registers and issuing flush reads on a disconnected P=
CIe link will trigger Master Aborts, escalating to AER errors and kernel pa=
nics on strict architectures.
--

--- Patch [1]: [PATCH v13] PCI: Add device-specific reset for Qualcomm devi=
ces ---
commit 8de0dab811e2555e876d5163ff0092117c834bb3
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm devices

This commit adds device-specific reset methods for certain Qualcomm PCIe
devices (WCN6855/WCN7850 WLAN cards and SDX62/SDX65 modems) that lack
working reset methods for VFIO passthrough. It implements hardware reset
sequences using BAR-space registers via SoC global reset and MHI SoC reset
mechanisms.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..c3799e6c58584 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> @@ -4227,6 +4228,118 @@ static int reset_hinic_vf_dev(struct pci_dev *pde=
v, bool probe)
[ ... ]
> +static int reset_qualcomm_wlan(struct pci_dev *pdev, bool probe)
> +{
[ ... ]
> +	val |=3D QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	val &=3D ~QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	ret =3D read_poll_timeout(ioread32, val,
> +				!PCI_POSSIBLE_ERROR(val),
> +				20 * USEC_PER_MSEC,
> +				5 * USEC_PER_SEC, false,
> +				bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);

[Severity: High]
Will this sequence of ioread32 flush reads and read_poll_timeout trigger
Master Aborts on architectures with strict error handling?

The SoC global reset explicitly drops the device PCIe link. Performing
ioread32 flush reads immediately after asserting the reset, and then active=
ly
polling the disconnected MMIO space with read_poll_timeout while the link
recovers, can result in Unsupported Request errors.

On strict platforms like ARM64 or x86 servers with APEI/GHES Firmware First
error handling, these can escalate to fatal Uncorrectable Errors and cause a
host kernel panic when a guest VM exits.

Should this avoid MMIO flush reads during these reset sequences and instead
use fixed delays to safely bridge the link-down period?

[ ... ]
> +static int reset_qualcomm_modem(struct pci_dev *pdev, bool probe)
> +{
[ ... ]
> +	iowrite32(MHI_SOC_RESET_REQ, bar + MHI_SOC_RESET_REQ_OFFSET);
> +	ioread32(bar + MHI_SOC_RESET_REQ_OFFSET);

[Severity: High]
Could this immediate ioread32 flush read also trigger a fatal Master Abort =
if
the link drops instantly after writing the MHI SoC reset request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721081301.2053=
74-1-jtornosm@redhat.com?part=3D1
