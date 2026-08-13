Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E3442B17;
	Thu, 13 Aug 2026 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610203; cv=none; b=BoKvnkzreXe/6sOBF8CX95EjBxNLZhYUsqLDOhD6irxJGvhUrgySjKh6/vEkXLVp8rU/yTeWZ9UekQTz5weYJkxixqckttBdKR+A5oFUI6vIWvHrF74cf9wo49qhhR/liwpOFrgrmAe1XsYha+cxc5+fVVMngCru3krLoNyFxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610203; c=relaxed/simple;
	bh=N34Piu6UotMucXpQ3lW6urue3Zuja34JbmjkdF9373g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aK1/TawJn5Pt4CstHK44MCm/vJmYyKlO3rqRS3gM2eg5C/RhpRXEKJlArr7C8eD1Cx5k5HMbFMKvwCz9lRAcIbfwOg+bv4MGC2iXGFWRHwxl/zlNYv2t6yGxdj3yE/+QkTKWnMIac/7kAC+M4l5Uiyzo+UYaDviHR3Py1rMkVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4DSzlIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4DSzlIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EBE1F00A3D;
	Thu, 13 Aug 2026 08:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786610202;
	bh=vJypfqGdu2ABBZg7hvLHB5fDy3oLIw7YZWH0MBvjzoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D4DSzlImFdeuSXuonjubumGPizCxmT7DG4Vyn7RGtxceSadq2THn8MNO96SjgaRgj
	 hS0Ymut7X1Xd+qOKQEc9JgVLNnnkZokoyjc9mCEYeC3vjstT8uCOwBzxUYd7bIJs20
	 S2EVNKvXJ6owpnCCxfVW/syIUPCCllthsYDWyCXXPVkvXLlNLJQ752An18C64Fw8uk
	 mgmYnXWCTbcpsnme7mpLMFDpB+ugrKQI1bAaYvKEhB0uzDok1oD/Rh68V78rDzV13s
	 IM7V+K8RAO2gWehKZZSivq8tOGQoWuLNofplwHVwXviFw4KBngZ3fn9mjBDgATIFVk
	 2/a3p+NIXtF+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Move clock enable after core reset
 assertion
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260813082900.270003-1-hongxing.zhu@oss.nxp.com>
References: <20260813082900.270003-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 08:36:41 +0000
Message-Id: <20260813083641.C1EBE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of imx_pcie_host_init() is ignored in imx_add_pci=
e_ep(), leading to a kernel crash if hardware initialization fails.
--

--- Patch [1]: [PATCH v1] PCI: imx6: Move clock enable after core reset ass=
ertion ---
commit 6d9f9eb5750531f447a5eaee6a038ee84ba72010
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Move clock enable after core reset assertion

This patch reverts a sequence change by moving clock enablement after
asserting core reset and configuring the controller type. This restores
correct initialization on i.MX6Q Apalis platforms where PCI device
initialization was failing.

Link: https://lore.kernel.org/all/bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgnerop=
f3hpgwve6@n2m5uhlduw57/T/#u
Link: https://lore.kernel.org/all/t65y5d54axtksbfs7r4olcefqhwm6m4dz3njgnrnf=
7fcotj74i@o7avoznlafbj/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..f7a2eb257c169 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -1415,6 +1409,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
p)
> =20
>  	imx_pcie_configure_type(imx_pcie);
> =20
> +	ret =3D imx_pcie_clk_enable(imx_pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> +		goto err_pwrctrl_power_off;
> +	}
> +
[Severity: High]
This is a pre-existing issue, but is it safe for imx_add_pcie_ep() to ignore
the return value of imx_pcie_host_init()?

Looking at imx_add_pcie_ep(), it calls imx_pcie_host_init() and immediately
proceeds without checking if it succeeded:

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
    ...
	imx_pcie_host_init(pp);
	ep =3D &pci->ep;
	ep->ops =3D &pcie_ep_ops;
    ...
	ret =3D dw_pcie_ep_init(ep);
    ...
}

If imx_pcie_host_init() fails here (for example, if imx_pcie_clk_enable()
returns an error), it cleans up its resources and returns an error code with
clocks disabled.

Execution would then continue into dw_pcie_ep_init(), which attempts
hardware register accesses. On i.MX hardware, accessing PCIe registers with
disabled clocks triggers a synchronous bus error (SError), resulting in a
kernel panic.

Could imx_add_pcie_ep() be updated to check the return value of
imx_pcie_host_init() and handle the failure gracefully?

>  	if (imx_pcie->phy) {
>  		ret =3D phy_init(imx_pcie->phy);
>  		if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813082900.2700=
03-1-hongxing.zhu@oss.nxp.com?part=3D1
