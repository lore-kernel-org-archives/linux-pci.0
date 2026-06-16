Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C63876BE
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594353; cv=none; b=VO978i2KA3tcZBjqimZaeGu0t4Ar4Ua3+3ZOMxKqLVr+qrVE0MU9rIfMoPjxoNL1vIKmH4ft3fq1iHrlOfaza4OIbiA/i8lYwVw5JJ0w5+gFffS7AcPIiZkZ115A3C84JG8VNlbcSfQ92dYG8fvrL8CUlfs92tRtVHarbIcIZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594353; c=relaxed/simple;
	bh=4C6Or4LN5gvytrB8AXjg49vdAGT+FPD9VAXJAX/mDCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FzayP+PTpsgg2HZxSGbCu9xxBqfC09qG3A7pejhzRCvWHkQBXWoIJGEM6c4p5BUvHR5KK1MZGMQ8NnblSRkL+BUSFvVcap58ZZl3qr9KpUMh4sk/4GOqcz4h0R1npb1s+5Ikeukwj7PNthDOyk0hWPS/NDgKcLsd2+HrllVrGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou6CA3A0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou6CA3A0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311411F00A3D;
	Tue, 16 Jun 2026 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781594345;
	bh=HrXKZBSa4XfWGRUZ7aaZverlmkzMxQjwm29CfJP2Rx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ou6CA3A0Qf8h60/PqJJQwVGpXQ0aLOPi8sIL4x5/Cj9t5frsw5+7CbLnb5lTuj4YC
	 wWe77Rp/zY/RoOybp+M/Lf5BzJtN9NoqRmG8WvBuXTrRnKHY+WghAc01XYyYblKcbf
	 jcCQk7/UBxJ/CGaM/GFRYmvKlTlvHev60yGcMF798h5yBGicQFw50V7iZE3Ow7Rn3M
	 M68jwl9Regkd6wcGGHlisg7cKhF6XDo11oX+7L0Lcruw+aGlDmeJOlkjqFTk8SsEAJ
	 FzdOYvOY/iSycHEGBDY11CKtW200UphSTWcDFbjgs/JI1iRKfewfjLCT/u/9XuuZLE
	 ZQgMEotAfC9bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: meson: Fix reset GPIO initial state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ronald Claveau via B4 Relay" <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Cc: neil.armstrong@linaro.org, linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260616-fix-meson-pcie-reset-gpio-v1-1-fca404b4c8be@aliel.fr>
References: <20260616-fix-meson-pcie-reset-gpio-v1-1-fca404b4c8be@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 07:19:04 +0000
Message-Id: <20260616071905.311411F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing .remove callback leads to Use-After-Free and resource leak=
 on unbind/module unload.
--

commit 6f34b371980942ee76ca5383825dd8ecaff2cbfb
Author: Ronald Claveau <linux-kernel-dev@aliel.fr>

PCI: dwc: meson: Fix reset GPIO initial state

This commit changes the initial state of the reset GPIO from GPIOD_OUT_LOW
to GPIOD_OUT_HIGH. This fixes the reset assertion logic that was inverted
by a previous commit.

> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
> index 0694084f612b7..15ed59b8764fb 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -400,7 +400,7 @@ static int meson_pcie_probe(struct platform_device *p=
dev)
>  		return PTR_ERR(mp->phy);
>  	}
> =20
> -	mp->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	mp->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);

[Severity: High]
This is a pre-existing issue, but does this driver lack a .remove callback
to clean up the PCIe host?

Looking at meson_pcie_probe(), it initializes the DWC PCIe host and
registers the PCI root bus:

drivers/pci/controller/dwc/pci-meson.c:meson_pcie_probe() {
    ...
    ret =3D dw_pcie_host_init(&pci->pp);
    if (ret < 0) {
    ...
}

However, meson_pcie_driver does not implement a .remove callback to call
dw_pcie_host_deinit(), nor does it set .suppress_bind_attrs =3D true.

When the driver is unbound via sysfs or unloaded, devres automatically frees
the memory for struct meson_pcie (and its embedded struct dw_pcie) and
disables clocks and resets.

Because dw_pcie_host_deinit() is never called, the PCIe root bus and its ch=
ild
devices appear to remain registered in the PCI core.

Could this lead to a use-after-free and panic if subsequent interactions
with these leaked PCI devices occur (for example, via sysfs or lspci) after
the memory has been freed?

>  	if (IS_ERR(mp->reset_gpio)) {
>  		dev_err(dev, "get reset gpio failed\n");
>  		return PTR_ERR(mp->reset_gpio);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-fix-meson-=
pcie-reset-gpio-v1-1-fca404b4c8be@aliel.fr?part=3D1
