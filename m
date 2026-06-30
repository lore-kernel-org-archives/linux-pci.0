Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D53B9920
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852118; cv=none; b=LyYtIGCK5LKV8sAPc04jp22mkSdr4NutpLZxITygW3xDQ05JwOU/fZ9+Fo2lKnPmSG7yUzM8wE4PRARj3+RgBFdByYnVxY8YJrXjBaPqMz7upoxCbGjK8i5i9p2BZyTLR3k/GyhKT/u0MgwhnoBwwoTYheJIT3n9XB8yyC3ONmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852118; c=relaxed/simple;
	bh=jRO1vN+U/KC0P686VcBZiUiZgQrXzjQFh7rj8gTYOS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JyUeDjHec2UKulFkaJCg6xSEwtjF6/BJNtoatM/+vQ2/7NeUE17yjpSfw38oQtCsKoq65A46foie/Hzz2pSUrT8OVlReLXxpkHv5xAgrw/6N0jjiyCqu92S8OiUSJnxyvcM8K7DPfRiuGbHsRrjH5kMp3TnNaydKFhJLWlfkRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ04qalZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ04qalZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84D61F000E9;
	Tue, 30 Jun 2026 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782852117;
	bh=Iz2s9Im3NYpGO2ErJ0Q42ZzRp5dQLXpnO5JEUwMFXzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hZ04qalZWIQr94QevUSqD0LgW2wiMjaKFpUyAwjhzhM+2UTHsWh/eYngJqiHKmGKA
	 iIWci9MbvTldgfv5cWvfxQBuDnWSZiDYyAJ0hsyPGWs8iGe8b9qctr/wxE74XmiWsy
	 1imSZYh7fDTB0/UAHXYaDmR7ZqdOPEggzn+Mg1VQR97lqc0xBEb34oTtKuDJBU2y0u
	 fxeNKXwKT+mF85ga/V/N0f3Cpb46U2+UmNwz4KVTMVakm4Oi6hx8aaxZZQCVASxtOg
	 kO/BGjBSB0dwoTFyOuRWO6qsG1MuXwf2IOLvNUKzv/qmN3yKCrSbMb1aoTbCUfBki2
	 r9NTwTRDNlOXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: keystone: Fix OF node reference leak in init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260630202938.1877632-1-dbgh9129@gmail.com>
References: <20260630202938.1877632-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 20:41:56 +0000
Message-Id: <20260630204156.E84D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbinding the `keystone-pcie` driver leaks the PCI root bus or End=
point Controller (EPC) subsystem registration, leading to a Use-After-Free.
- [High] Unbinding the driver causes a kernel panic due to a NULL pointer d=
ereference when tearing down device links for missing optional PHYs.
- [Medium] Missing `of_node_put(args.np)` after successful calls to `of_par=
se_phandle_with_fixed_args()` causes OF node reference leaks.
- [Medium] The `err_link` error path in `ks_pcie_probe()` leaks successfull=
y allocated device links due to incorrect loop termination logic.
--

commit 7622e803c35b7f152e532145ef64528354f691a1
Author: Yuho Choi <dbgh9129@gmail.com>

PCI: keystone: Fix OF node reference leak in init

of_find_matching_node() returns a device node with its reference count
incremented. ks_pcie_init() only uses the returned node to decide whether
to register the ARM external abort fault handler, but never drops the
reference.

Store the lookup result in a temporary variable and release it with
of_node_put() once the existence check has been made.

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/cont=
roller/dwc/pci-keystone.c
> index 278d2dba1db08..f1b27aed488de 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1389,13 +1389,17 @@ static int ks_pcie_fault(unsigned long addr, unsi=
gned int fsr,
> =20
>  static int __init ks_pcie_init(void)
>  {
> +	struct device_node *np;
>  	/*
>  	 * PCIe access errors that result into OCP errors are caught by ARM as
>  	 * "External aborts"
>  	 */
> -	if (of_find_matching_node(NULL, ks_pcie_of_match))
> +	np =3D of_find_matching_node(NULL, ks_pcie_of_match);
> +	if (np) {
> +		of_node_put(np);
>  		hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
>  				"Asynchronous external abort");
> +	}
> =20
>  	return platform_driver_register(&ks_pcie_driver);
>  }

While reviewing this patch, I noticed a few pre-existing issues in the same
file.

> static int ks_pcie_init_id(struct keystone_pcie *ks_pcie)
> {
[ ... ]
> 	/* Do not error out to maintain old DT compatibility */
> 	ret =3D of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-id", 1, 0, =
&args);
> 	if (!ret)
> 		offset =3D args.args[0];

[Severity: Medium]
This is a pre-existing issue, but does this code leak the OF node reference
by failing to call of_node_put(args.np) after the property is parsed?

The same pattern appears to exist in ks_pcie_set_mode():

> static int ks_pcie_set_mode(struct device *dev)
> {
[ ... ]
> 	/* Do not error out to maintain old DT compatibility */
> 	ret =3D of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-mode", 1, 0=
, &args);
> 	if (!ret)
> 		offset =3D args.args[0];

And also in ks_pcie_am654_set_mode():

> static int ks_pcie_am654_set_mode(struct device *dev,
> 				  enum dw_pcie_device_mode mode)
> {
[ ... ]
> 	/* Do not error out to maintain old DT compatibility */
> 	ret =3D of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-mode", 1, 0=
, &args);
> 	if (!ret)
> 		offset =3D args.args[0];


> static int ks_pcie_probe(struct platform_device *pdev)
> {
[ ... ]
> err_link:
> 	while (--i >=3D 0 && link[i])
> 		device_link_del(link[i]);
>=20
> 	return ret;
> }

[Severity: Medium]
This is a pre-existing issue, but does the && link[i] condition prematurely
terminate the cleanup loop? If probe fails after skipping an optional PHY,
leaving a NULL element at index 1 while index 0 has a valid link, would this
leak the device link at index 0?


> static void ks_pcie_remove(struct platform_device *pdev)
> {
> 	struct keystone_pcie *ks_pcie =3D platform_get_drvdata(pdev);
> 	struct device_link **link =3D ks_pcie->link;
> 	int num_lanes =3D ks_pcie->num_lanes;
> 	struct device *dev =3D &pdev->dev;
>=20
> 	pm_runtime_put(dev);
> 	pm_runtime_disable(dev);
> 	ks_pcie_disable_phy(ks_pcie);

[Severity: High]
This is a pre-existing issue, but does this code leave the PCI root bus or
endpoint subsystem registered? Failing to call dw_pcie_host_deinit() or
dw_pcie_ep_deinit() before the driver structures are freed could result in a
use-after-free when unbinding the driver.

> 	while (num_lanes--)
> 		device_link_del(link[num_lanes]);
> }

[Severity: High]
This is a pre-existing issue, but can this while loop cause a NULL pointer
dereference? If an optional PHY was missing during ks_pcie_probe(),
link[num_lanes] could be NULL. Because device_link_del() does not check for
NULL before dereferencing, will unbinding the driver panic the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630202938.1877=
632-1-dbgh9129@gmail.com?part=3D1
