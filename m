Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3D4CCDF8
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245833; cv=none; b=rOkeWIxZZw6eco+EtHXG0XtOCBStbSL5860IgSwFN6uS1jpZ7P/9i5r4UsB0hanfKSmalTA+vQFqoSjx6K2DZodio3cFY8WNGgpBrb4MWR6+dcJPW+wZQ1tP0citJhRVGDuF8nYsZ7FvooSFnyEiSOvJY1pVshTy33acsoVEFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245833; c=relaxed/simple;
	bh=zcii4c/7zyLpfS31aOAflSGR5r2ksAl66YZ2DzqIBqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CNtMCD85kPZZepCh+tM9x+VN6fLfItogE36W4khyZpyE5yblLLHfhsWvC5yL65jEQccllBJh29Pvna1uNSNqRqWuse0I22IHroVJfNFKJAEi2Li429aKhqr2NEZCH2LHuKwim5gw/0AWXuUQaupdM12x0nSW59SvFoZ+xOjBLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbHmTBvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbHmTBvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEC91F000E9;
	Tue,  1 Sep 2026 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245831;
	bh=stJwvZoXaAqxnk3AmSxKZ2f1o7e6HgaUJ1H1+RXNhN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mbHmTBvqL0cU9OA+FV/xSrWTkCFVbEZ6/Cyw9edJgu/0mjjpn0012fQ+63cOMfCea
	 U6lniNbbuhI0ptXOGaTUsYiX787eH1pp2Escup5zqG/joE/tqxLRpQbILZDw4x9UON
	 fMfySBh5YqP06FRBcU36ejH3yaOX6cejhbZdKDvUGv90oKKT1nsoC4mH+1st6e8rnx
	 M4Hr5ROiv7mLJxVO54zhjHv+pnxFhn60kOqS7RdmsDtd9Un6n94SccvLcoJCEdww/7
	 7QfLopoz1AmhZo+kyZjRNHLi0nEbUr+HqDp6XboffzmUu/bKDMFy6cfkgGOtaygFNz
	 nF0OrLxa0QGTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/DPC: Honor "pcie_ports=native" when enabling DPC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260901064554.2178688-1-kanie@linux.alibaba.com>
References: <20260901064554.2178688-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:57:11 +0000
Message-Id: <20260901065711.7AEC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but pre-existed in t=
he codebase. Various PCI and CXL subsystems incorrectly check `host->native=
_*` flags directly without honoring the `pcie_ports=3Dnative` or `pcie_port=
s_dpc_native` command-line overrides.
--

commit bed1438fd8fcfc05e1122790665a4045a06281cf
Author: Guixin Liu <kanie@linux.alibaba.com>

PCI/DPC: Honor "pcie_ports=3Dnative" when enabling DPC
   =20
This commit fixes an issue where the "pcie_ports=3Dnative" command-line
override was ignored when deciding whether to create a DPC service
device. This ensures both command-line overrides continue to work when
firmware retains AER control.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a9cbfc1d2bc75..a05ee7980fb27 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev =
*dev)
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>  	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || host->native_aer))
> +	    (pcie_ports_native || pcie_ports_dpc_native || host->native_aer))
>  		services |=3D PCIE_PORT_SERVICE_DPC;

[Severity: High]
This isn't a bug introduced by this patch, but pre-existed in the codebase.
Since this patch correctly restores the pcie_ports_native override here,
should we also fix other subsystems that incorrectly check host->native_*
flags directly without honoring the command-line overrides?

For example, in drivers/cxl/core/ras.c:devm_cxl_dport_rch_ras_setup(),
the code drops the override, which can lead to broken error reporting for
uncorrectable errors:

	host_bridge =3D to_pci_host_bridge(dport->dport_dev);
	if (!host_bridge->native_aer)
		return;

	cxl_dport_map_rch_aer(dport);

Similarly, in drivers/pci/pci-acpi.c:pci_acpi_program_hpx_type2(), it
fails to account for the command line override which should prevent
programming when the OS forces AER:

	/*
	 * Only do the _HPX Type 2 programming if OS owns PCIe native
	 * hotplug but not AER.
	 */
	if (!host->native_pcie_hotplug || host->native_aer)
		return;

Also, in drivers/pci/pcie/dpc.c:pci_dpc_recovered(), this check bypasses
the synchronization wait if it fails to recognize OS-forced DPC
ownership:

	host =3D pci_find_host_bridge(pdev->bus);
	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
		return false;

Because pci_dpc_recovered() prematurely returns false, the pciehp driver
will not ignore spurious Link Down/Up events during DPC. Does this cause
hotplug to incorrectly race with DPC recovery?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901064554.2178=
688-1-kanie@linux.alibaba.com?part=3D1
