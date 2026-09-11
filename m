Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD1476CEA
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133619; cv=none; b=E0wp0lzUQOwdfosoakCh2MVEl3T7cs2Pd4/MWmSCtwynSLAAq2ke8PEHfTJBtSoAa4tgkonUnshiOLcvVSD94QQs7ISkBXb3pCWK6jpvSgMWvrMf8TCfK1QHa62hmm6v5p1614dELz25svcFHjbCqQ1WifkVCzIN2a/9cS3Kfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133619; c=relaxed/simple;
	bh=Me1XkcExeZxwe0Ws9NE2aslaJrLe2+AFfHPL/h1zz4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QkeairoGmiBXZIsga4a7AjFhOxeW60WCvYI+JrBQi6sSj+1VeQwAYTD6RSjaHmb+Rsd0QX3OjZtrydF92QbWIONQrishYkE+sRdMLTJOnjKCytNe5+DV3KvIWaFH12Y4bo+583pzhAvOGYpHCNxuc4zSyL9zRbTwDg4gCRpJnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMAQ5KRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMAQ5KRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647411F000FF;
	Fri, 11 Sep 2026 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133615;
	bh=UQmLf39egxouHqGaoPY1W2b4Ke71vmpsB1o38cIZnUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DMAQ5KRGVCC+1MMFeLnPAyCNuAYz/hxYmepO6VeZS5zCUVkAL6XvtneJZb8gdEJDI
	 RYVZUOz6ajsZT445z02/dzhVfTAagJ9G4IcRHDO0kIODPiWHdpTChOhd0W0BqJkmDy
	 FdVp+bPlKAL2NQ0geE6kZaMw8fsJ4YN3Pj0G7VnZpRFH37okgBqdWk1h4bEB0gfWcw
	 6Quy1lT6pcYsM+9WwWdP0nTyyh/pogvRgEd5YUH+mHn7F9vrtOhP0AYYbBmty4gEmG
	 UFy7duMFi8EQ1jq9RdCJ7amTdJ32o6RWEGtfgMQfF+9iEtCoxgpR1R4oJK32364o8j
	 Lh7tgcyahz4jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] PCI: Configure Root Port MPS during host probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260911132145.211380-2-18255117159@163.com>
References: <20260911132145.211380-1-18255117159@163.com>
 <20260911132145.211380-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:33:34 +0000
Message-Id: <20260911133335.647411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Logic Error / PCIe MPS Mismatch. Unconditionally configuring the R=
oot Port MPS to its maximum supported value breaks devices connected via PC=
Ie switches under the default MPS strategy (PCIE_BUS_DEFAULT).
- [Medium] Missing Error Handling: The return value of `pcie_set_mps()` is =
silently ignored when configuring the Root Port MPS.
--

commit 13816df0ca2fe3070f644d4bbf35fd712be22285
Author: Hans Zhang <18255117159@163.com>

PCI: Configure Root Port MPS during host probing

Current PCIe initialization logic may leave Root Ports operating with
non-optimal Maximum Payload Size (MPS) settings. This change ensures
Root Ports are initialized to their maximum MPS before downstream devices
negotiate MPS, while not interfering with the PCIE_BUS_PEER2PEER strategy.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..dc47478589182 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2229,6 +2229,18 @@ static void pci_configure_mps(struct pci_dev *dev)
>  		return;
>  	}
> =20
> +	/*
> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all) or
> +	 * PCIE_BUS_PEER2PEER (use minimum MPS for peer-to-peer), set Root Port=
s'
> +	 * MPS to their maximum supported value. Depending on the MPS strategy
> +	 * and MPSS of downstream devices, a Root Port's MPS may be reduced
> +	 * later during device enumeration.
> +	 */
> +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT &&
> +	    pcie_bus_config !=3D PCIE_BUS_TUNE_OFF &&
> +	    pcie_bus_config !=3D PCIE_BUS_PEER2PEER)
> +		pcie_set_mps(dev, 128 << dev->pcie_mpss);

[Severity: High]
Does unconditionally setting the Root Port MPS to maximum break devices
connected via PCIe switches under the default MPS strategy (PCIE_BUS_DEFAUL=
T)?

If a system has a PCIe switch and the Root Port supports a larger MPS
(e.g., 256B) than the endpoint behind the switch (e.g., 128B), it appears t=
his
would cause a mismatch.

During top-down enumeration, this new code unconditionally sets the Root Po=
rt
MPS to max (256B), and the switch ports inherit 256B. When the endpoint is
later enumerated in pci_configure_mps(), it hits this pre-existing logic
further down in the function:

    mpss =3D 128 << dev->pcie_mpss;
    if (mpss < p_mps && pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_ROOT_PORT=
) {
        pcie_set_mps(bridge, mpss);

Because the upstream bridge is a Switch Downstream Port and not a Root Port,
the condition pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_ROOT_PORT evaluates=
 to
false.

Since the MPS reduction strictly limits itself to Root Ports, the MPS of the
switch is not reduced, leaving it at 256B. The endpoint then fails to set i=
ts
MPS to 256B, returning -EINVAL and permanently leaving a mismatch which cou=
ld
lead to dropped packets as Malformed TLPs.

[Severity: Medium]
Are we missing an error check here?

If the configuration write fails due to hardware quirks or an invalid value,
the return value of pcie_set_mps() is silently ignored, unlike similar calls
in pci_configure_mps() which log a warning or handle the failure.

> +
>  	if (!bridge || !pci_is_pcie(bridge))
>  		return;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911132145.2113=
80-1-18255117159@163.com?part=3D1
