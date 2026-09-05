Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212338330E
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577846; cv=none; b=YTOIbgi8m+RCz5+UMNhcb9aE2olJua5QxLU9x+tTg7rgSHbu704NIbJKnn6nZyWXn66zrNXo0hgexoSrMgsvhSAiWF9Ob5rERFIxpvPnfxq0T9SnV7O+3lXORsHvOjbgI6Pu17Pud4hI7k9UuLyv5noxXfrMeosK2kKU51d6v1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577846; c=relaxed/simple;
	bh=Fndp5GiNVto1a4Hve+f3lF8Hwn7FDilsd/eCGnrbEbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MQeuKhZCHnFqda7aPkKOWz0DT6yfcR6g4yFgpqan60PCRdrRFgmrw2WPNu8n1IOI4GoO2OB7lKMXtZhSef43x01hHrDw6z7ci9ZAxb57S66vtCWCo7mhUxfJD/62xCvzrUEDrZjJLaxmG5cUwzoZhIU9e1L3I/po34I9RtgclIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg77GmcX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg77GmcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875211F00A3D;
	Sat,  5 Sep 2026 03:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788577843;
	bh=CZVkdvEayEeBEis93LnR80FDmvkrewuCLpKoJd61hZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eg77GmcXzJpt0CBXI8DIFTsBUTkdCQE48XBcmbRKcXfiJUhOYZ6hPlySOFRe7AGwM
	 XP6tl/+4dRhtMN0i1Ep6L9dK3kdJMfR7xUDje+3l9qjoVe4srcfN8Kp680P+wxtx0K
	 ZBbPnXWW09B2oxLGxsqi/E+Xko6zaZS7sHJ0J+BO2d1QLZXfu+vFAOx3dsgFbPND/x
	 rHCfh1rOjNGQ3ZOv+mcKpNKUXyA3mtjr8od6VvM5AsK2x/WY6wrQipyHmGFJdhhEg2
	 uTHpn1Pd5N7BYak5kEWpe9wTEnYpLWq4Wy49+jjOzpr3AgI+Qh+m5NKEgb/X7y69UX
	 9ly4LUTbQnwVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: ultrarisc: Skip MEM outbound iATU setup on
 DP1000
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xincheng Zhang" <zhangxincheng@ultrarisc.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905025635.211390-3-zhangxincheng@ultrarisc.com>
References: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
 <20260905025635.211390-3-zhangxincheng@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 03:10:43 +0000
Message-Id: <20260905031043.875211F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `.remove` callback in platform driver causes memory leaks,=
 use-after-free, and unbalanced clocks on module unload.
- [High] Ignored return value of `dw_pcie_setup_rc()` during resume leads t=
o unconditionally accessing uninitialized hardware.
- [High] Missing `dw_pcie_dbi_ro_wr_dis()` on the error path leaves DBI rea=
d-only registers writable.
--

commit c554fce09754058c518d7827f376e2e64ea19f5a
Author: Xincheng Zhang <zhangxincheng@ultrarisc.com>

PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000

This patch sets the bypass_ob_mem_iatu flag for the DP1000 controller to
skip generic DWC MEM outbound iATU setup. This avoids the 16-window limit
and allows for a larger 64-bit MEM aperture.

> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/co=
ntroller/dwc/pcie-ultrarisc.c
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
[ ... ]
>  static struct platform_driver ultrarisc_pcie_driver =3D {
>  	.driver =3D {
>  		.name	=3D "ultrarisc-pcie",
>  		.of_match_table =3D ultrarisc_pcie_of_match,
>  		.suppress_bind_attrs =3D true,
>  		.pm =3D &ultrarisc_pcie_pm_ops,
>  	},
>  	.probe =3D ultrarisc_pcie_probe,
>  };
>  module_platform_driver(ultrarisc_pcie_driver);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to leave out
the .remove callback in the platform driver?

Since dw_pcie_host_init() is not devres-managed, unloading the module=20
triggers devres release which frees driver memory and disables clocks, but
leaves the PCI host bridge and devices registered. Could this cause a
use-after-free and hardware hang if those devices are accessed later?

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
[ ... ]
>  	if (pp->bridge->child_ops =3D=3D &dw_child_pcie_ops || pp->ecam_enabled=
) {
>  		ret =3D dw_pcie_iatu_setup(pp);
>  		if (ret)
>  			return ret;
>  	}
> =20
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
[ ... ]
>  	dw_pcie_dbi_ro_wr_dis(pci);

[Severity: High]
This is a pre-existing issue, but does this error path bypass restoring the=
=20
read-only write protection?=20

The function dw_pcie_setup_rc() disables read-only protection at the=20
beginning via dw_pcie_dbi_ro_wr_en(). If dw_pcie_iatu_setup() fails, it=20
returns immediately. Does this permanently leave critical PCI hardware=20
configuration registers writable?

[ ... ]
>  	if (pci->pp.ops->init) {
>  		ret =3D pci->pp.ops->init(&pci->pp);
>  		if (ret) {
>  			dev_err(pci->dev, "Host init failed: %d\n", ret);
>  			return ret;
>  		}
>  	}
> =20
>  	dw_pcie_setup_rc(&pci->pp);
> =20
>  	ret =3D dw_pcie_start_link(pci);
>  	if (ret)
>  		goto err_deinit;

[Severity: High]
This is a pre-existing issue, but what happens if dw_pcie_setup_rc() fails
during resume?

It appears the return value of dw_pcie_setup_rc() is completely ignored.=20
If it encounters an error like an ATU enable timeout returning -EBUSY, the=
=20
driver proceeds to call dw_pcie_start_link() and re-enable endpoints while=
=20
the Root Complex hardware is incorrectly initialized. Could this lead to=20
accessing uninitialized hardware and causing a synchronous external abort?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905025635.2113=
90-1-zhangxincheng@ultrarisc.com?part=3D2
