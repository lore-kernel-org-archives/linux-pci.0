Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1C3B47CD;
	Mon,  7 Sep 2026 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799755; cv=none; b=KMrJJCaWIwOzrzx3QL3z4LD2zaiYH9qLL/Dyh7nyYZd8QvmAjpJ1YjyHaccPB/BylBjsSdMCnys2b1fYu1tYKUrFT0RHQyw4rBNlSDAj2dRi6OYtcX25ivQg90zFQcxMxxTS44TS0IYV+ChN21L1gD3kwM6o+TLyTr9yTI+LswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799755; c=relaxed/simple;
	bh=8b0U8riFiqjIrUW8eHOKd5uJ86QSqUkGLZ3ZC49qL+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MPEeR8uu2DvfjO/tV/ryxVVLGuovCYbQctfgBjMUF6oacHF8POE2gkRL9PWJdb3W8NmjS+khI3pnQPk8/W+JwHIvPuIDoxMOGZblMeNLbISgE09ezGD9PCB654hp697wn021grO5fNOMI5cmb/Dw7OHZwAhd7M5WNA/8vQBexXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6/PKp0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6/PKp0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87261F00A3A;
	Mon,  7 Sep 2026 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788799754;
	bh=uXbCdN9NfPjDHE4wgSr++t3jsmjnpHZ5zf/l89RQZUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6/PKp0VZnYLtwAl4DlWeHENBK3drUC2hR2EXSkhyyCpFHFpaa2YNsale3k4jIhU0
	 wqsIJlzPtjKLRbIqdT8y302XfiPrAKaiPebC48JT+u6NVx1UkYhxwmFF6bjX57d7jn
	 3hzePhvXSmQaMpSEqZi05Uo7eJLih7LXUnoCsGbAwXMTe8F7nJ4tNijm+7yCtXGZaN
	 tgY7kaGL8knCZ0CO4ejiPtEprJxqAi4x3Jfi5HPBx/5Z6GGCOZRX/IRC11ubkKR6E2
	 OsGUGP29GcNRol3oaBAB4g3MBNKgmAotMgC6JR9B0hJdRjQQmlvitAo9VfebZFjqkT
	 FrCSm+gvZGuKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing PM ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
References: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 16:49:13 +0000
Message-Id: <20260907164913.A87261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] PCIe host controller fails to re-initialize on R-Car V4M after res=
ume if any endpoint does not support D3cold.
- [High] Endpoint mode (EP) does not recover from suspend on R-Car V4M due =
to explicitly skipping PM state restoration.

Pre-existing issues:
- [High] The `msi_node` device node obtained from `of_msi_xlate()` is leake=
d because its refcount is never decremented.
--

commit 924c8a29b2859d29f5190b0088001c235ae190fa
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Add missing PM ops

Adds generic suspend/resume noirq ops to tear down and restart the PCIe link
during suspend/resume for R-Car Gen4. This supports power domains that shut
down in suspend, such as on R-Car V4M.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index fbe465a29068f..2926660f1b537 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -849,6 +849,26 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_=
gen4_pcie *rcar, bool enable
>  	return 0;
>  }
> =20
> +static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(dev);
> +
> +	if (rcar->drvdata->mode !=3D DW_PCIE_RC_TYPE)
> +		return 0;

[Severity: High]
Does returning 0 here cause the endpoint (EP) mode to not recover from
suspend on R-Car V4M?

If the V4M A2PCIPHY power domain shuts down, removing power from the EP
controller, explicitly skipping PM state restoration will leave the EP
hardware dead after system resume.

> +
> +	return dw_pcie_suspend_noirq(&rcar->dw);

[Severity: High]
Can the host controller fail to re-initialize on system resume if an attach=
ed
endpoint does not support D3cold?

If an attached endpoint does not support D3cold, the generic helper
dw_pcie_suspend_noirq() returns 0 early:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_suspend_noirq() {
    ...
    if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
        return 0;
    ...
}

Because it returns 0 without setting pci->suspended =3D true, the subsequent
resume will skip initialization:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_resume_noirq() {
    ...
    if (!pci->suspended)
        return 0;
    ...
}

Since the A2PCIPHY power domain is unconditionally shut down by the generic
PM core, the hardware loses state. Does skipping re-initialization here lea=
ve
the PCIe bus permanently unusable?

> +}
> +
> +static int rcar_gen4_pcie_resume_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(dev);
> +
> +	if (rcar->drvdata->mode !=3D DW_PCIE_RC_TYPE)
> +		return 0;

[Severity: High]
Does this explicit bypass also prevent the EP controller from being
reconfigured after power loss, as mentioned above?

> +
> +	return dw_pcie_resume_noirq(&rcar->dw);

[Severity: High]
This isn't a bug introduced by this patch, but does calling the generic res=
ume
helper introduce a recurring device_node leak?

On every resume, dw_pcie_resume_noirq() will call pci->pp.ops->init(), which
invokes rcar_gen4_pcie_host_msi_addr(). Inside that function, of_msi_xlate()
acquires a reference to the msi_node:

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_pcie_host_msi_addr() {
    ...
    of_msi_xlate(dev, &msi_node, 0);
    if (!msi_node)
        return -ENODEV;
    ...
}

The function returns without ever calling of_node_put(msi_node). Because th=
is
patch now causes init to run on every suspend/resume cycle instead of just =
at
probe time, does this leak the msi_node reference on every system resume?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907163554.7251=
27-1-marek.vasut+renesas@mailbox.org?part=3D1
