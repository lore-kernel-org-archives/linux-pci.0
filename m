Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77871443AAB;
	Thu, 16 Jul 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223241; cv=none; b=Fsqi9pDx+MjfdgLEDXgSjOoh1xxkWrYv1ThPY5/0vuqV638a0quOKhoRId/nF8suiK3Pfm1uCc8loTFNQaXM74tpUyDKANLoycqU5SYs2GIm/6MoldYWYFew4BkwXtaKjd2WJaLcQM4RIbscskvIfEDmN69uaZ2W4exIJI4t+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223241; c=relaxed/simple;
	bh=X3GV4AiZV+W+pFo2WiI0Op1tOYU9RX+hA0pNH+I/Ud4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MLMwaAFvA8i2opIhy/R1lQG3y7HquX70DTwh2irHtdsA0Ta1vaFF7PaMubHsEt11TaXnLFuzINSO8E8fAWqrNrxIolB9I7ffxRL8B9zHhclnFqgP7JM9iVpLweCVdZoL+TnVm3vgQaGaBDfPXV//+JdXvt5ZovCz/ZS3pRnJ/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCMJ+gJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCMJ+gJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43221F00A3A;
	Thu, 16 Jul 2026 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784223240;
	bh=HcrrA1szM2krCv1NQmmOx1FQnJPguN48pUQs778ezNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCMJ+gJ0a9Q2eNSS5J3mo3DdYZkLBwbP7EvmGh32/zJDlKU8yE0ZW3aSybpFbWe0E
	 QIRIni+AN7PjdJ9+WzN1AfapZNDocScTX6GIVpa1YS7u0J8QjQJoh6rpGU0LIv1KXS
	 Wr7J6HLq5BOc+oK1d+W4A7jP4Q/sJcTOisc56VMplblkOxnn0aCpV6JL9VlOpzMZkT
	 pm3aortUH2GWgOd9ED/wF3qHyybCjAF7oc6rDsjWejDZD6NRBVWoxI7XbhUzzyOk/O
	 gBa5ETpRbdrI1wSO0vFJowUERsGwh7YIt00hVlEyU8zVogkyCIasHGZIowzPS4AII/
	 24s28w5dPjSkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] PCI: Use standard wait times for PCIe link
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260716-tegra264-pcie-v8-3-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-3-23e51589229b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 17:33:59 +0000
Message-Id: <20260716173359.D43221F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] readl_relaxed_poll_timeout() has an extremely short 100ms timeout =
due to incorrectly mapped arguments, breaking standard PCIe link up expecta=
tions.
- [High] PCIe Configuration Request 100ms timing constraint is violated if =
the link trains quickly after a fundamental reset.
--

--- Patch [3]: [PATCH v8 3/6] PCI: Use standard wait times for PCIe link mo=
nitoring ---
commit dd424bc144818153a04d4fe26f753cd9432c9695
Author: Thierry Reding <treding@nvidia.com>

PCI: Use standard wait times for PCIe link monitoring

Instead of defining the wait values for each driver, use common values
defined in the core pci.h header file. Note that while most drivers use
the usleep_range(), it looks like these were mostly cargo culted and
msleep() is a better choice given the fixed delay that the specification
calls for. Convert all drivers to msleep() and use the existing
definition.

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index fd9c7d53e8a78..272c5c8fc1e5c 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
[ ... ]
> @@ -350,13 +347,13 @@ static int advk_pcie_wait_for_link(struct advk_pcie=
 *pcie)
>  	int retries;
> =20
>  	/* check if the link is up or not */
> -	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +	for (retries =3D 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
>  		if (advk_pcie_link_up(pcie)) {
>  			pci_host_common_link_train_delay(pcie->link_gen);
>  			return 0;
>  		}
> =20
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +		msleep(PCIE_LINK_WAIT_SLEEP_MS);
>  	}
> =20
>  	return -ETIMEDOUT;

[Severity: High]
This is a pre-existing issue, but does this violate the 100ms PCIe
configuration request delay specification?

In advk_pcie_setup_hw(), advk_pcie_issue_perst() is called to deassert
PERST#, followed immediately by advk_pcie_wait_for_link():

advk_pcie_setup_hw() {
    advk_pcie_issue_perst(pcie);
    ...
    ret =3D advk_pcie_wait_for_link(pcie);
}

If the link trains instantly, advk_pcie_link_up() will return true before
any sleep occurs.

For PCIe Gen 1 or 2, pci_host_common_link_train_delay() adds no delay,
causing the function to return immediately. Doesn't this cause Configuration
Requests to be sent before the mandatory 100ms window has elapsed after
a fundamental reset?

[Severity: High]
This isn't a bug introduced by this patch, but since this series cleans up
cargo-culted delay values across drivers, should visconti_pcie_start_link()
in drivers/pci/controller/dwc/pcie-visconti.c also be addressed?

It currently uses readl_relaxed_poll_timeout() with the same 90000 and 1000=
00
values:

visconti_pcie_start_link() {
    ...
    ret =3D readl_relaxed_poll_timeout(addr + PCIE_UL_REG_V_PHY_ST_02,
                                     val, (val & PCIE_UL_S_L0),
                                     90000, 100000);
}

Because the delay interval is 90ms and the total timeout is 100ms, doesn't
this allow at most two polling attempts before timing out? Could this break
enumeration for devices that take longer than 100ms to train their link?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-tegra264-p=
cie-v8-0-23e51589229b@nvidia.com?part=3D3
