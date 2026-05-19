Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8472E7F2C
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222039; cv=none; b=dHQnIxV7qEBHIx1hJFnhucC+5TO27+LlRpkyMnK7r/k7YX7YNYdUR1m5RvzkQX2Dl4kEVAAXOv0bNCSV5gbPdaWwVe/TTBpbL6Xs2qdC3HuOZiWoS06BVLtjiQM0VStgiH+kOyUbNTvMy9EbsHcnEK9q4Dbj9NqqaDVr4XR6mH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222039; c=relaxed/simple;
	bh=kdcdDapsnJrrQTjmcpp09M3kacJWrMllUuW0i7zmzTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u5i+nvVQL1JAt0RLXaPKH+IBfR7GSFoYQtY/BdG3ZQXpoWc9TH1fmPZ53cvdEtnOI0nTP+d9R12Vy5qCh7GtDlqwYDmmOGRFo0eqYRKN/Og+zYLH+SSgJsHLk1Mhu1qD9xpmPxdV2ph9HZalM7ux6WtzzTsjYJ/xkEDIBxXgtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on2Hb9lu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on2Hb9lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD001F000E9;
	Tue, 19 May 2026 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222037;
	bh=56BG0fytKuf5O6ZguHl+i4rl3SKw258mcxkLyAQQ8Rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=on2Hb9luBmWa+j+nZoOyb1rFGyVPuT5vsQzdMQRlc5RpLP0B5K7PXFXvtgHLe/60a
	 ADFq+avcm3s5EjH9egHWt5kGa4MbJ4dn5iBXf1BqJo8rgUNHYXNzsuNxzL5pOxHEjz
	 yfpa6a+2SkWOBjgvku+YAdXb6zFhRxyDoI1GWpJ/xd2zCo7IFS7pzTnlzlnKkPKtJg
	 ZZ+7km3o4uQRSbZymiYAHEXOwWDp9iFQoDvrAUs2sESGAxZWimeHMfROuh3huRG97s
	 rab202cNswcpRNAnxzcAnfpJe78wBnFIOqm1yOj8uV2+Edy6SPUd+HmLsid9QEbu0m
	 gKqMz11VTaTbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260519195219.189323-1-marek.vasut+renesas@mailbox.org>
References: <20260519195219.189323-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 20:20:36 +0000
Message-Id: <20260519202037.8BD001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Dynamically modifying a device's Max_Payload_Size (MPS) in the ena=
ble_device hook breaks PCIe fabric consistency and causes Malformed TLP err=
ors.
- [High] Endpoint drivers can bypass the Max_Read_Request_Size (MRRS) limit=
ation because the bridge's no_inc_mrrs flag is not set.
- [Medium] Ignoring the return values of pcie_set_mps() and pcie_set_readrq=
() allows devices to operate in an unsafe state if the limits cannot be app=
lied.
--

commit a6b8290401b7fa98e699e975574f47bfb1d20609
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Limit Max_Read_Request_Size and Max_Payload_Size to 256 Byt=
es

This patch introduces a workaround for an R-Car Gen4 PCIe controller=20
hardware limitation where the Max_Payload_Size (MPS) and=20
Max_Read_Request_Size (MRRS) must not exceed 256 bytes. It implements=20
an enable_device hook to force limit these values to prevent data=20
corruption with certain NVMe SSDs.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 8b03c42f8c84c..9fe34ca7ce532 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
> +					struct pci_dev *dev)
> +{
[ ... ]
> +	if (pcie_get_mps(dev) > 256) {
> +		pci_info(dev, "Limiting MPS to 256 bytes\n");
> +		pcie_set_mps(dev, 256);

[Severity: High]
Will modifying the Max_Payload_Size locally in the enable_device hook=20
desynchronize it from the rest of the PCIe fabric?=20

The PCIe specification and Linux PCI core generally manage MPS uniformly=20
across the hierarchy during boot via pcie_bus_configure_settings().=20
Because this hook runs later during driver probe via pci_enable_device(),=20
if the upstream Root Port or Switch retains a larger MPS and transmits a=20
TLP exceeding 256 bytes, could the downstream device drop it as a Malformed=
=20
TLP and cause a fatal link error?=20

Would it be safer to restrict the Root Port's MPS capabilities before=20
enumeration so the core logic correctly scales the entire fabric?

> +	}
> +
[ ... ]
> +	if (pcie_get_readrq(dev) > 256) {
> +		pci_info(dev, "Limiting MRRS to 256 bytes\n");
> +		pcie_set_readrq(dev, 256);
> +	}
> +
> +	return 0;

[Severity: Medium]
Should the return values of pcie_set_mps() and pcie_set_readrq() be=20
checked and propagated here?=20

Both functions can return negative error codes on failure. By ignoring=20
these return values and unconditionally returning 0, the device could=20
be fully enabled even if the configuration writes fail, leaving the system=
=20
silently vulnerable to the data corruption described in the commit message.

> +}
> +
>  /* Host mode */
>  static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>  {
> @@ -313,6 +361,9 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp=
 *pp)
>  	int ret;
>  	u32 val;
> =20
> +	if (pp->bridge)
> +		pp->bridge->enable_device =3D rcar_gen4_pcie_enable_device;

[Severity: High]
Could endpoint drivers (like high-performance network or storage drivers) o=
r=20
userspace via sysfs subsequently increase the MRRS above 256 bytes?=20

Because the host bridge's no_inc_mrrs flag is not set, a downstream=20
driver can call pcie_set_readrq() and silently bypass this workaround,=20
re-enabling the data corruption vulnerability.=20

Should pp->bridge->no_inc_mrrs =3D 1 be set during this initialization=20
to enforce the limit permanently?

> +
>  	gpiod_set_value_cansleep(dw->pe_rst, 1);
> =20
>  	ret =3D rcar_gen4_pcie_common_init(rcar);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519195219.1893=
23-1-marek.vasut+renesas@mailbox.org?part=3D1
