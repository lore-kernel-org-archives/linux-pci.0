Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1E23D7F0;
	Fri, 31 Jul 2026 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461500; cv=none; b=ZkaFV/1UbffGpVi+cRZDd9E7tmvIERuuQDpcNGgRsAp/lAdVq667uEUaKlEIXcPCtmrqS8RjM6pi3y6gSeSbCmKb7WdwLz+i+IjYeCICgFobJy0wC1Tu214NTTylxid7Q/OIakCg6a6Dbk6p/L0RqBaKx1R4pKerRfPCxQPilwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461500; c=relaxed/simple;
	bh=S6oZnNkBNH2Qbo4QHEZ8z3zCDtmqzbKsSFlklbwJzus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZNCdiY1SBvd0+xrKZ2ba3MBt1abXmODs4meLHyKEMzj9VNTp/0BRQCX3la0m8Cyer4F6OlgvSjkZLnMin3w2DlOYUlNdRiUi1wInGe8xmFEiQNl7ZuVKZJff5t46trC5Z0HiP6/1J/rYtTudTxiWkRumCUaKMmBXJ7fpax+Nf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiNlB26T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiNlB26T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4751F000E9;
	Fri, 31 Jul 2026 01:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461499;
	bh=o+KnExG2TT3k3N4h3cVgBU5hWKvErHBXW+CzmsMzVTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aiNlB26T09ZEARMXa47GCppJ8c+h/vLxr/mGSsxveXIV/hd2wdjCj2XHk1Hrr6uhT
	 78lusAlUFXCENP2T595ZcGS4aaQxeQlMSmeFnmGHimGEVK5dAOBwFkuUcScxE3Gsj6
	 M5Af1s1iqKk2xTzt1wdSjTz0rGgVWEHJpoRLcY1ui/Sb36/4MNjpWedEhxkat2iBXb
	 IAwaHJPU9mbnlC36VeooMcmMWy9Oxm5gw+tBLBV6VqPvPUh29VCADyZ4PFVkYkmXVB
	 SwGPpLEbvlBGsrCQsH5+y/zrEc/6NlYh86JLOLAYAE6RB5Dqxx9kU33B8+M3R35XAV
	 iclcJ5isNiO/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] PCI: ultrarisc: use module_platform_driver()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang" <wangjia@ultrarisc.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260731-ultrarisc-pci-clk-v4-3-d738b491e49a@ultrarisc.com>
References: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
 <20260731-ultrarisc-pci-clk-v4-3-d738b491e49a@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 01:31:38 +0000
Message-Id: <20260731013139.1D4751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing `builtin_platform_driver()` with `module_platform_dr=
iver()` without a `.remove` callback enables unsafe module unloading, leadi=
ng to a critical use-after-free vulnerability.
--

--- Patch [3]: [PATCH v4 3/3] PCI: ultrarisc: use module_platform_driver() =
---
commit d768b3fb3030b38d7fa1abda1368c3ffe340185e
Author: Jia Wang <wangjia@ultrarisc.com>

PCI: ultrarisc: use module_platform_driver()

This commit updates the driver registration to use module_platform_driver()
to support building as a module. It explicitly leaves the .remove callback
unset to prevent disposing of the internal MSI controller during removal.

> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/co=
ntroller/dwc/pcie-ultrarisc.c
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
[ ... ]
> @@ -240,7 +240,7 @@ static struct platform_driver ultrarisc_pcie_driver =
=3D {
>  	},
>  	.probe =3D ultrarisc_pcie_probe,
>  };
> -builtin_platform_driver(ultrarisc_pcie_driver);
> +module_platform_driver(ultrarisc_pcie_driver);

[Severity: Critical]
Does using module_platform_driver() here make the module unloadable,
potentially leading to a use-after-free?

Since the .remove callback is left unset, driver-specific teardown like
dw_pcie_host_deinit() is skipped on unload. However, the driver core will
still unbind the device and automatically free all devm-managed memory,
such as the core structure allocated in ultrarisc_pcie_probe():

ultra =3D devm_kzalloc(dev, sizeof(*ultra), GFP_KERNEL);

Because the PCI host bridge and IRQ domains are not unregistered, they will
remain active in the system with dangling pointers to this freed memory.
Would subsequent accesses to the PCI bus (like sysfs reads or interrupts)
dereference these dangling pointers when the module text is unmapped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-ultrarisc-=
pci-clk-v4-0-d738b491e49a@ultrarisc.com?part=3D3
