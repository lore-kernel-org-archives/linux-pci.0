Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC472AD37
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877537; cv=none; b=PHNVQZPckppqnzLVlLNkgdVvyqx7Sa9+CnZH2J8IloO7UDmt5mmp7nIt2aEYBCyNz0V/OBggXC9pcJ78Mlrvfm6OWsXJitObDI+xCRbJkvrjcF1cvJlJtgJNQ3pAkshGN1Ye1dymArmodWE+b6HYXtkvR5EGTdqLnJIgTTnIMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877537; c=relaxed/simple;
	bh=85e5IiQ1WhNWL4shjtcGwqQB7Fig03QKjFbvQl2DKG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rAHo6UZOSmS++NvnPkYNLIC+EQGao/WY+UFb8YV6fVR4/GIXQPshb4DRaDd51pVE1cflqDODng8q6yk1ugUuc4PnmILVrcfj2B+oPMm0HzAJXkLmQ8E3dWuxnx/KkdL24QB8SVnmhWpDeks2TuV/hvLd9jadAZIKfQ60m2TB8Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3kp3siP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3kp3siP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162111F000E9;
	Tue,  4 Aug 2026 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785877536;
	bh=amHXDus6JCeKtZQuKFbbh3TTuDW3NyMPLv70Zwssp7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3kp3siP3hzCZH4bqF4SikDYO9OBiCwsSL15ffT50zp+Wb4eCUBElgBuIKTzImhgE
	 MiP8l1TDz4sl3A4UwKzH3Pcla+Gju/JMY0VDpVFVNrfIi588En8/2fIyns6TnLD2rZ
	 KGyJOrFy0FX5F+75vC2xqWEwxOMsZdcpR+VnmSRmg5IFeau6U60uaSmzN9c7XhI0n4
	 mM9h7LoSKl5H6wkHUJvS3H6whFsiKlw8kdH8lj76hAuENOeqKqH4g7bGBMWnSBPPwi
	 WXkM3KnsBd9Oy0Kl0Ztq1AQqutywsC0SuMb1QIZgCD2cDykEpunryMDb16tEpmZgvI
	 M55XsR4lyo6rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Fix Intel Xeon 6 x2 quirk collateral damage on
 adjacent x4 endpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Warner" <rick@microway.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260804204845.171483-1-rick@microway.com>
References: <20260804204845.171483-1-rick@microway.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 21:05:35 +0000
Message-Id: <20260804210536.162111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The refactored quirk attempts to isolate the x2 mitigation but fai=
ls because it applies `no_inc_mrrs =3D 1` globally to the entire host bridg=
e, still penalizing parallel x4 branches.
- [High] The local fixup to disable Extended Tags on x2 endpoints is immedi=
ately overwritten and undone by the PCI core during device enumeration.
- [Medium] The local endpoint fixup unlawfully modifies RsvdP (Reserved and=
 Preserved) PCIe capabilities on SR-IOV Virtual Functions (VFs).
- [Low] Unmatched closing parenthesis in the `pci_info` log message.

Pre-existing issues:
- [Critical] A guest VM can bypass the quirk and re-enable Extended Tags vi=
a VFIO, leading to hardware instability and host Denial of Service.
--

--- Patch [1]: [PATCH v2] PCI: Fix Intel Xeon 6 x2 quirk collateral damage =
on adjacent x4 endpoints ---
commit d621c370d145fdc2f0765dea4356628c461c0bda
Author: Rick Warner <rick@microway.com>

PCI: Fix Intel Xeon 6 x2 quirk collateral damage on adjacent x4 endpoints

This commit attempts to fix collateral damage caused by the Xeon 6 x2 quirk=
 by
changing the mitigation to be per-device instead of global to the host brid=
ge.
It removes the global bridge->no_ext_tags flag and uses a local endpoint fi=
xup
to disable extended tags and lock MRRS to 128B for devices downstream of an
affected x2 root port.

> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df753..6370b08d99aef 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -320,9 +311,8 @@ static void pci_xeon_x2_bifurc_quirk(struct pci_dev *=
pdev)
>  	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) !=3D 0x2)
>  		return;
> =20
> -	bridge->no_ext_tags =3D 1;
> -	bridge->enable_device =3D limit_mrrs_to_128;
> -	pci_info(pdev, "Disabling Extended Tags and limiting MRRS to 128B (perf=
ormance reasons due to x2 PCIe link)\n");
> +	bridge->no_inc_mrrs =3D 1;

[Severity: High]
Does setting bridge->no_inc_mrrs =3D 1 here still apply the restriction glo=
bally
to the entire host bridge?

When pcie_set_readrq() is called by unrelated x4 devices sharing this bridg=
e, it
will check this flag:

drivers/pci/pci.c:pcie_set_readrq() {
    ...
	if (bridge->no_inc_mrrs) {
    ...
}

Would this cause the MRRS limitation to still inadvertently impact the para=
llel
x4 branches that this patch intends to protect?

> +	pci_info(pdev, "Blocking devices on this bridge from increasing MRRS fo=
r performance reasons due to x2 PCIe link)\n");

[Severity: Low]
There appears to be an unmatched closing parenthesis at the end of this log
message string.

[ ... ]

> @@ -334,6 +324,50 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db7,=
 pci_xeon_x2_bifurc_quirk);
> +static void pci_xeon6_x2_local_endpoint_fixup(struct pci_dev *pdev)
> +{
> +	/* Skip bridges/switches; only target actual endpoints */
> +	if (pci_is_bridge(pdev))
> +		return;
> +
> +	/* Only apply to devices under the x2 branch; leaves x4 branches comple=
tely untouched */
> +	if (!is_descendant_of_xeon6_x2_rp(pdev))
> +		return;
> +
> +	pci_info(pdev, "Applying local Xeon 6 x2 quirk: Disabling Extended Tags=
 and locking MRRS to 128B\n");
> +
> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG=
);

[Severity: High]
Will the clearing of the EXT_TAG bit here be undone by the PCI core later in
the boot process?

Because the global bridge->no_ext_tags flag was removed earlier in the patc=
h,
when the PCI core later evaluates extended tags during pci_device_add(), it
will encounter this in pci_configure_extended_tags():

drivers/pci/probe.c:pci_configure_extended_tags() {
    ...
	if (!(ctl & PCI_EXP_DEVCTL_EXT_TAG)) {
		pci_info(dev, "enabling Extended Tags\n");
		pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
					 PCI_EXP_DEVCTL_EXT_TAG);
	}
    ...
}

Could this unconditionally re-enable Extended Tags on the endpoint and defe=
at
the mitigation?

[Severity: Critical]
This is a pre-existing issue, but since the commit message mentions concerns
about vfio/VM usage re-enabling extended tags, is it possible for a guest VM
to bypass the quirk?

Looking at init_pci_cap_exp_perm() in drivers/vfio/pci/vfio_pci_config.c,
PCI_EXP_DEVCTL_EXT_TAG is not included in the NO_WRITE mask:

drivers/vfio/pci/vfio_pci_config.c:init_pci_cap_exp_perm() {
    ...
	p_setw(perm, PCI_EXP_DEVCTL,
	       PCI_EXP_DEVCTL_BCR_FLR | PCI_EXP_DEVCTL_PAYLOAD |
	       PCI_EXP_DEVCTL_READRQ | PCI_EXP_DEVCTL_PHANTOM, NO_WRITE);
    ...
}

Would this allow an unprivileged guest VM to write to its virtualized
PCI_EXP_DEVCTL register and have the write pass through to the physical
hardware, thereby re-enabling Extended Tags?

> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_READRQ);

[Severity: Medium]
Does this code modify the PCI_EXP_DEVCTL register on SR-IOV Virtual Functio=
ns?

According to the PCIe SR-IOV Specification, Extended Tag Enable and
Max_Read_Request_Size are RsvdP (Reserved and Preserved) fields on VFs and =
must
not be modified, as they track the PF.

Should there be a check for !pdev->is_virtfn before clearing these bits?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804204845.1714=
83-1-rick@microway.com?part=3D1
