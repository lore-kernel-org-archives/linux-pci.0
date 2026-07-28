Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11939021E;
	Tue, 28 Jul 2026 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260339; cv=none; b=WwZRtWbRnHXQ8GQVMRG96yhslHg6b5LKLZ4hdXz3bKcSj8ZYrnqE9C8zKGtFQ43M63xJQUeBRxhCqqMWKLb9bjKHGWbFA/rGV37ud863sVd1FPsOj2xptniwUujflvqkEBDabzF2OGaJ3D2CCjOXWe8+eOhk/tcOgU2bYcHuN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260339; c=relaxed/simple;
	bh=OvQ3BCAFIlg6143fQhbfWR51aHUrNYsdcAIRz9QdBZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nku+ONo/dG/g/Pncfx0Ge4aijrpg860qCpjgPOFLOa9jdgimuajGj7Zs+JKBboMUQcvvqaD46PvK1/6NSm8+cMIrsnVYeQNv0/YqNSx99lmsO0ZofTVwkB9O7sxQAucxqGK8PD3UbQfP2iuKf90s9Xu6+zPKDtwxD9qz0h6w0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIAPRym1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIAPRym1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9A81F000E9;
	Tue, 28 Jul 2026 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260337;
	bh=Tct2b+ETmkfy0Z+icoK3T50iLQBq5gNAhQF5vsApCNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIAPRym1CVM7dXH/h7kXFp6tKKpVnGGRucFk4yUbefnx2K1E5AhQ9XB7zq4VZ8oJs
	 E2ZtniPEUjbix5OKX2O/+ERw8OUOXfNasShtdtBKzW3+CARdcGMWj3MOTHE2pSjwGG
	 DGtaVJjWzcrjS0cpG4bCG3TPxjNMQwv4fM0ZPgcWe+cpPYsd/BNaRuOnIan89Wj7e3
	 Mw03CTbBE9d/z2ZMRpGCaJvcXPNPpIiin0YjZdX/T76IFFoQ60G090Rfxgp0Yyc6MX
	 jqVHf0Rg5PNrx9GxXkPKOShun39PRcbVO0zuU/oxtOBXoOCkvOPruJcEbdaWlvzWYf
	 Y9WL6LxymyISw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260728172306.2751813-2-den@valinux.co.jp>
References: <20260728172306.2751813-1-den@valinux.co.jp>
 <20260728172306.2751813-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:38:56 +0000
Message-Id: <20260728173857.1A9A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An off-by-one loop initialization error in `epf_ntb_init_epc_bar()=
` leaves memory window BARs beyond the first one unassigned (`NO_BAR` or `-=
1`). This results in negative array indexing and out-of-bounds memory acces=
ses when `epf_ntb_mw_bar_init()` and `vntb_epf_mw_set_trans()` index into `=
ntb->epf->bar[barno]`.
- [High] Missing NULL checks for `epc_features` returned by `pci_epc_get_fe=
atures()`, leading to a kernel panic if the underlying EPC driver does not =
implement the `.get_features` callback.
- [High] The virtual PCI driver `vntb_pci_driver` lacks a `.remove` callbac=
k, resulting in resource leaks of the virtual PCI bus and Use-After-Free of=
 the NTB device structures upon module unload or EPF unbind.
--

--- Patch [1]: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number w=
hen BAR programming ---
commit fc9ce298c179bf87e88da3f2964f2fbbd870806a
Author: Koichiro Den <den@valinux.co.jp>
PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming

This commit updates vntb_epf_mw_set_trans() to pass the endpoint function's
own func_no and vfunc_no instead of hardcoded zeros when programming the
memory-window BAR. This ensures the BAR is correctly configured when the
virtual NTB endpoint function is bound to a function other than PF0.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index c3caec927d748..fba65abfb6b21 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *nd=
ev, int pidx, int idx,
>  	epf_bar->barno =3D barno;
>  	epf_bar->size =3D size;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for barno to
be -1 here, leading to an out-of-bounds write?

Looking at epf_ntb_init_epc_bar(), the loop iterating over optional memory
window BARs incorrectly starts from BAR_MW1 instead of BAR_MW2:

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_init_epc_bar() {
	...
	for (bar =3D BAR_MW1, i =3D 1; i < num_mws; bar++, i++) {
	...
}

If a user configures num_mws > 1, this leaves BAR_MW2 unassigned (-1). Late=
r,
when vntb_epf_mw_set_trans() is called for idx =3D 1, barno is evaluated as=
 -1.
Will epf_bar =3D &ntb->epf->bar[barno] then access out of bounds and corrupt
memory?

> -	ret =3D pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> +	ret =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, epf_bar);
>  	if (ret) {
>  		dev_err(dev, "failure set mw trans\n");
>  		return ret;

Also, while reviewing this file, I noticed a few other pre-existing issues:

[Severity: High]
This is a pre-existing issue, but how is the case where epc_features returns
NULL handled?

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_configure_interrupt()=
 {
	...
	epc_features =3D pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, nt=
b->epf->vfunc_no);

	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
	...
}

If the underlying EPC driver lacks the .get_features callback,
pci_epc_get_features() returns NULL, which would cause a NULL pointer
dereference here. A similar dereference happens in
epf_ntb_config_spad_bar_alloc().


[Severity: High]
This is a pre-existing issue, but does vntb_pci_driver intentionally omit a
.remove callback?

drivers/pci/endpoint/functions/pci-epf-vntb.c:
	static struct pci_driver vntb_pci_driver =3D {
		.name           =3D "pci-vntb",
		.id_table       =3D pci_vntb_table,
		.probe          =3D pci_vntb_probe,
	};

When epf_ntb_unbind() unregisters this driver:

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_unbind() {
	...
	pci_unregister_driver(&vntb_pci_driver);
}

Since there is no .remove callback, ntb_unregister_device() is never called=
 to
clean up the virtual PCI bus and its associated devices. Could this lead to=
 a
resource leak and dangling sysdata pointers upon module unload or EPF unbin=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728172306.2751=
813-1-den@valinux.co.jp?part=3D1
