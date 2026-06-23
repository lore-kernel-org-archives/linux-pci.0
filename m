Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675A2288D5
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209112; cv=none; b=bLUAF9TZMr3fWw4/HT+jkAXRDxYXhb5W0bNb+NDitGzW07aMo3HVRD+4VNQL2oNHEzb05H5GzwBUOmjtrJXsqSdtUWvIv60NQ65F1oHn3/ZgqZ8liyFHoS4tEToXXquvP90OItAS4G5eEQDgh/QTNoOQkXxZfcP7NNmtHBtQwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209112; c=relaxed/simple;
	bh=T7H014iFapyaDLrEXh7DmyqA9Az3DFmYdiTc5mDgXYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtqJbGEqbvxnJRzn1wGdTrL+y8o3W+9imf/VfhpDxubBKnNlRbBTLdnr0Pcb4El6rXPTV+zAd4aFKAmB3s2hr5HME/J7mZ2GbNhe5a34UYgkB0L9TogQOAh8ploFxOKziPR+3CMtRj06u0Zh4BJo2KcrmP2bOyInSz9QCF93lkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQdjgnNf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQdjgnNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADA1F000E9;
	Tue, 23 Jun 2026 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782209111;
	bh=YMSLW1ikNNMB2hevvGWVDe/Kix41+Y+aLfpuTBxLlNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQdjgnNfdJpwowNW3zQGF93R9mhJ+BXAoUD30famOugJHnyNfU8m5Pmj/6TYAZAA6
	 Ffb44doAA9FvyTg5no0YqRms8nDHv8fW0kPsTRLsyZHWCLcapobfKunhLm+jLqTMCS
	 9xb5eLoFYGlffchhcCHQyGz8gYAg9nW4fuS4tNX2NCsloXLbPU6juJlwBoFFwtEsWq
	 iuII2a43orkYUIrKCEKa8H9XGEgZs2ExypIjq2ee5l4YWFGV8/WdQj5hRl+Ul6M4ax
	 qbSRJmQLgrKlbObUKGQ9ax22Kjtf/GOSl4/H73hK/3kdp8n8/Z0uIbWMUh2uFAUNwO
	 lQoKgpJgrOKTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: cadence: skip the link polling when endpoint
 not connected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623095148.721206-1-a-garg7@ti.com>
References: <20260623095148.721206-1-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 10:05:10 +0000
Message-Id: <20260623100511.50ADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Checking PCIe link state during the host controller's `suspend_noi=
rq` incorrectly infers a disconnected link because downstream devices have =
already been suspended, breaking system resume for all connected endpoints.
--

commit 3a9bc5bfaa54c1ff36dc42ca33244027b719cd03
Author: Aksh Garg <a-garg7@ti.com>

PCI: cadence: skip the link polling when endpoint not connected

This commit introduces a flag to skip PCIe link polling during system resume
on platforms without hotplug support if the link was down before suspend.
By avoiding the polling delay when no endpoint is connected, it speeds up
the resume operation.

> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/con=
troller/cadence/pci-j721e.c
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *d=
ev)
>  	struct j721e_pcie *pcie =3D dev_get_drvdata(dev);
> =20
>  	if (pcie->mode =3D=3D PCI_MODE_RC) {
> +		struct cdns_pcie_rc *rc =3D cdns_pcie_to_rc(pcie->cdns_pcie);
> +
> +		/* If link is down before suspend, skip polling in resume */
> +		rc->link_down_no_hotplug =3D !j721e_pcie_link_up(pcie->cdns_pcie);

[Severity: High]
Will this correctly identify connected devices during suspend?=20

Because the PM core suspends devices in reverse-probe order, child endpoints
will have already been suspended and placed in a low-power state (like D3co=
ld)
before j721e_pcie_suspend_noirq() runs.=20

Does this mean the link will likely drop, causing this code to capture a
"down" state even for properly connected, valid endpoints?

> +
>  		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>  		clk_disable_unprepare(pcie->refclk);
>  	}

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers=
/pci/controller/cadence/pcie-cadence-host.c
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -352,6 +352,9 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>  		return ret;
>  	}
> =20
> +	if (rc->link_down_no_hotplug)
> +		return 0;
> +

[Severity: High]
Could skipping cdns_pcie_host_start_link() here cause subsequent endpoint
resume operations to fail?

If the flag was incorrectly set to true during suspend, the Root Complex wi=
ll
skip waiting for the link to train. When the PM core later attempts to resu=
me
the endpoints, couldn't accesses to configuration space over the untrained
link time out or trigger an asynchronous external abort?

>  	ret =3D cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623095148.7212=
06-1-a-garg7@ti.com?part=3D1
