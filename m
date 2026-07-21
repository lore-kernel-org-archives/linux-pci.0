Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3952282F31
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616575; cv=none; b=oMMGEjLGkj67KJYohBF8yT6fZ8kfxGObL1g/DWEodixJ19DTDG4xQrgAtU8AgNs4FwO8WeZFlqrVmEd7TDwFYzKR1WZyhwNJvVbjNKnc2JkBxCfUgO9eG5PYTl3nUjCkN6B5nzW7VzS8uIkWAtigBjp9TVQDlOl+5Wr4ncmfRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616575; c=relaxed/simple;
	bh=dyPvBoV7NhCaJSIRuRL/YOLxv6oiz6yE7Uv6E6RpFjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cMv4qFOMzsRxOVTKMvxBy5X7euoyblWNxxW0osrMoFhatjzqr1ff3DtcXB395kFEPT1pE6bQG/odnLVXCWRQ+bDLtrmvBBP9jExiiK8afN3abAqcCNCL5QpP+U2xHNVTikYzIMclf3YtWUYxvANgfeHgVfKcCFmpaffjsil8XnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRVn7pHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRVn7pHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632281F000E9;
	Tue, 21 Jul 2026 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784616573;
	bh=K2cqR9oRkUw4SZaDoUQ3YFBxwe2azkeWH7UHdGulN4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRVn7pHkZDibg6UEGrm5CP04D2qx+IAR1koLhR7ikMrPoM1CyDs1AI0OukMJuHD/6
	 I0Usr687NEMDdvvzjiOuvMvL4gjhQjYJrLDu/BIADectHhB6n/a67T2pQReoLHoGko
	 Sf0jVNGREGVwxPsJnR+HXCRHG8ZVrZkVOgAUDiZ6/8OmHgfqTnwysvsIRsdyN0JMBm
	 y8LMHNHV+pgZQTzqZD1gvG8n4INBPWvI5U+JvDEDZROFOYP39deyba8DiQtj43TpOs
	 ycifp9FFjv3WguZE5eQsQ4ODSaTQtS8T9Gf7JJjjncY1n4JYOgpU/fRnzbnepZziJe
	 CQtbESoh/vpng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 v4] PCI: dwc: Add PCI ID for LECARC PCIe pmu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Braden Zhang" <braden_zhang@lecomputing.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721-pcie-pmu-v4-1-850a4e695b19@lecomputing.com>
References: <20260721-pcie-pmu-v4-1-850a4e695b19@lecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 06:49:32 +0000
Message-Id: <20260721064933.632281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The commit message claims that spaces were replaced with a tab, but=
 the patch actually uses spaces.

Pre-existing issues:
- [High] The `dwc_pcie_pmu` driver caches a pointer to the PCI device (`pde=
v`) in `pcie_pmu->pdev` but explicitly drops the reference count. If the PC=
I device is removed, this leads to a Use-After-Free when the PMU driver acc=
esses `pdev`.
--

--- Patch [1]: [PATCH v4 v4] PCI: dwc: Add PCI ID for LECARC PCIe pmu ---
commit c7438edb93a79853b55beed10ead3c56dfcc3ff6
Author: Brett Zhou <brett_zhou@lecomputing.com>

PCI: dwc: Add PCI ID for LECARC PCIe pmu

This patch adds support for the PCIe PMU found on LECARC SoCs by adding
the PCI vendor ID to the vendor-specific capability list. This enables
the standard DWC RAS/DES feature detection.

Link to v3: https://patch.msgid.link/20260713-pcie-pmu-v3-1-5e4a8d82248d@le=
computing.com

> Changes in v2:
> - Format: repalce space with tab to separate the macro name and the value.

[Severity: Low]
This isn't a bug, but there is a typo (repalce) in the changelog text.

[ ... ]

> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> index 8ff778e7aec0e..0df5fa81b5610 100644
> --- a/include/linux/pcie-dwc.h
> +++ b/include/linux/pcie-dwc.h
> @@ -11,6 +11,8 @@
> =20
>  #include <linux/pci_ids.h>
> =20
> +#define PCI_VENDOR_ID_LECARC           0x0720

[Severity: Low]
This isn't a bug, but the v2 changelog claims spaces were replaced with a
tab, while this macro definition still uses 11 spaces.

[Severity: High]
This is a pre-existing issue, but enabling the LECARC vendor ID exposes the=
se
platforms to a flaw in drivers/perf/dwc_pcie_pmu.c.

Does dwc_pcie_pmu_probe() trigger a use-after-free if the device is removed?

drivers/perf/dwc_pcie_pmu.c:dwc_pcie_pmu_probe() {
    ...
    pci_dev_put(pdev);
    ...
    pcie_pmu->pdev =3D pdev;
    ...
}

The driver retrieves the PCI device and increments its reference count, but
explicitly drops the reference with pci_dev_put() while retaining the point=
er
in pcie_pmu->pdev.

If the device is hot-removed, the PCI core drops its reference and frees the
device structure. If a userspace process holds an open perf event and reads
from it, wouldn't callbacks like dwc_pcie_pmu_read_lane_event_counter()
dereference the freed pcie_pmu->pdev pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-pcie-pmu-v=
4-1-850a4e695b19@lecomputing.com?part=3D1
