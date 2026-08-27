Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04D312807
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810902; cv=none; b=gsk9kb34bdqvuZrSNVBNQU9M9Q5deuTOUfR9AZ2guF6RSRhYZ5tA2DttOHd2ZOx6Nt54OlldGWLtNYK7/18oc9ouIRE0e4XwHMBbnTo1TGVxWGPW5luz4IfrQ4E/G+yxZSrS/p1nbtak60+oRvj/rjto/aIF5sChOY+8KSNMDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810902; c=relaxed/simple;
	bh=P6KbdjjGexIkdCE+64vdnbI+6fpTQx00fySZgz9y+cM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDWqFPX3blQaD9tT2HVI9opLiFgp3EoAhDzc2/F6ea0DFNV5q5IZxCUA2yg2AknxTzNBuxdHJ4jZ+fmgWoEtGcxlEiZPZ3RVFIRTH8llSNY7SQliSz8UUPRumZ99tmHk7EgdonzzkdDkOK5vWK9sRUPRNqAjzP8EW3avBJ66BCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+lrbHjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+lrbHjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2DD1F000E9;
	Thu, 27 Aug 2026 06:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787810900;
	bh=wWXknS9ZgFpL0q9IvREy4vOVXEkuPRmzNr7kIP0Zkl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+lrbHjr14xota919DwCSjUTQq6hk0xZuVdAbhaUSuBE0QR+3I+hBtOfagKHDU5RM
	 +d7hkYm/mRpAajijKjyYSd+uzj6DEbJPRcngC6ubH48kfvaQchbMm4qXTc1o6c9nhX
	 9VdM7k2vgm8ZoWR0Nu9pOyZIWpVjfhZIWaApBnprwRTlGyjA8L4BsQg9TPMbR4c35+
	 pRTYU33XJUr38mGLgtz+OAqIR3Nzvhg9as8W65pQLd6sg3SWuCRCc43W7587yMBhV+
	 vL/v1nyP/XJAk5CGVMWq1kvVVAtEN0fedo3jxzIlMSuQ3PGL/wlDWSHi+3S+4LDqWB
	 HmiMGgYd7qmZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: ultrarisc: Skip MEM outbound iATU setup on
 DP1000
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xincheng Zhang" <zhangxincheng@ultrarisc.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260827055448.1818858-3-zhangxincheng@ultrarisc.com>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
 <20260827055448.1818858-3-zhangxincheng@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:08:19 +0000
Message-Id: <20260827060819.DC2DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing driver `.remove` callback causes a Use-After-Free of PCI h=
ost bridge structures when the module is unloaded.
--

commit e72827a32cf8b1eb87517edbf6b7e64e76f36134
Author: Xincheng Zhang <zhangxincheng@ultrarisc.com>

PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000

The DP1000 has 16 outbound iATU windows, one of which is used for the
32-bit MEM aperture. To avoid limiting the 64-bit MEM aperture to the
remaining 13 windows, this commit skips generic DWC MEM outbound iATU
setup, allowing transactions to bypass outbound iATU windows.

> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/co=
ntroller/dwc/pcie-ultrarisc.c
> index 51e89180490d4..0d4989a0f3afc 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -154,6 +154,12 @@ static int ultrarisc_pcie_probe(struct platform_devi=
ce *pdev)
> =20
>  	pp =3D &pci->pp;
> =20
> +	/*
> +	 * DP1000 routes MEM transactions without outbound iATU windows, which
> +	 * avoids the 16-window/4GB-per-window aperture limit.
> +	 */
> +	pp->bypass_ob_mem_iatu =3D true;
> +
>  	platform_set_drvdata(pdev, ultra);
> =20
>  	ret =3D ultrarisc_pcie_init_clks(ultra);

[Severity: High]
This is a pre-existing issue, but since you are modifying the probe path,
I noticed that ultrarisc_pcie_probe() calls dw_pcie_host_init() which alloc=
ates
a PCI host bridge via devres, yet the platform driver lacks a remove callba=
ck.

Because the driver registers with module_platform_driver():

static struct platform_driver ultrarisc_pcie_driver =3D {
	.driver =3D {
		.name =3D "ultrarisc-pcie",
		...
	},
	.probe =3D ultrarisc_pcie_probe,
};
module_platform_driver(ultrarisc_pcie_driver);

Is it possible for a privileged user to unload the module and trigger a
use-after-free?

When the module is unloaded, devres will automatically free the memory for =
the
pci_host_bridge. Because there is no remove callback in the driver,
dw_pcie_host_deinit() is never invoked to call pci_stop_root_bus() and
pci_remove_root_bus().

Does this leave the PCI core with active references to the freed host bridge
structures after the module is removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827055448.1818=
858-1-zhangxincheng@ultrarisc.com?part=3D2
