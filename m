Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153630BF66
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854640; cv=none; b=f2phS67ATdBHVyNRc1vpF9im/HaOJE2/D2W0JEizP4I3kyTYMb4keYBicf+z/yOeLbtSiqXq9u0XYNgCwOZ7h+ZlSc86ECcG4AcHAWMdL8RvXloM4EQm9t2CQ4KMCXDndvuB1zx8A5ow3oesk7aqdG2TAkxl912LC0oodIF4nhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854640; c=relaxed/simple;
	bh=wkXMErwKUGut4lkZUQYLlPySSXb7zjQW250Sqk2EsT0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4d71SBPRt0m/jMepf0kpIKBYGUJzN15fQvPL9GqYIoQFmTOofrR1aqp9A96fMc/wwn7AiffRyVsVrjMg5q8ULPGZAGcZLGsfTnPxpTOagdnhPuIUz3NkltJYfDrZbnOsjMDK/RbZT7r82YNmwlscENRjKwZyVNJVaIRSD72Yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1f9jlX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1f9jlX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230A11F00A3D
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781854639;
	bh=YnQ9MPAYpd0fxk76rGMZS9hOaWFlYma1+sDSqr8GlGA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=g1f9jlX8G5K3xqMhw6dOWrgEVlni/Ezpn3Gza1D7DzGz0+7SPYXkoDwsul1rCZfLI
	 k0YFuXUB8ijYEzn9d5zccJ0oK/9KcY45dhv9S9C+lUZWfIiBDLNAmCUIQmzlWTUXUN
	 VskVK7wvA+0hx7VsjwUVDIdsgSyWBofCtMb3QCZSPxMHlOpjlzgW4njp9RxNNLo0Tc
	 IVf4G7xIioy+BPMzuKeLDioPxtCFnUg8AZz8uMolB6SLW+pNRVhLyS0Wv8uTmqVqlN
	 x5FMNQaWiEdbz0mZ9qW0kCQuUdkw9q8PuCwtxyB0oW7H/iDHnnOQ5ZzQagMa5QaQTf
	 DBLBbu7uIto5A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ad49da7123so1586548e87.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 00:37:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/MQ1uKHUcE9DSa/fLqMSYiR0bGKg9CF3ws3Le/nxsuCXNveSE0iwLXmqFgbFpzkvaCMu/oS5RU0vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70Nw5CfWHGixVfgGDFYUN80ahFu3GYfT+1inWQGLZCQpAIp5b
	sLbjUpyPDZSwI8hb/Nau1dE/prHcYAs/7Sdfy+WxW9KiVMzpqd7/xIdKFI8siBM8t+yOPM7SBZl
	0yrYUZINGXcQqtgvxvFkY/ihPCfMxFfQNaXSbvDUmlA==
X-Received: by 2002:a05:6512:61c5:20b0:5a8:73c2:c90b with SMTP id
 2adb3069b0e04-5ad57229d41mr401564e87.20.1781854637750; Fri, 19 Jun 2026
 00:37:17 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 02:37:15 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 02:37:15 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Date: Fri, 19 Jun 2026 02:37:15 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfsNa4itdpyGtR16wMb+wMkJwg+9=QJF2-oOoVVfFCF3g@mail.gmail.com>
X-Gm-Features: AVVi8CfCeqYM86-ykNLbU8hxtvU1LP7wSiVMnCr70BLSiKSY_mF23r-WT1fp8gY
Message-ID: <CAMRc=MfsNa4itdpyGtR16wMb+wMkJwg+9=QJF2-oOoVVfFCF3g@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add PCIe M.2 Key E connector support for NXP i.MX boards
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, sherry.sun@nxp.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, marcel@holtmann.org, 
	luiz.dentz@gmail.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jun 2026 12:10:39 +0200, "Sherry Sun (OSS)"
<sherry.sun@oss.nxp.com> said:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> This series adds support for NXP Wi-Fi/BT combo chips (88W9098, AW693)
> inserted into PCIe M.2 Key E connectors on several i.MX EVK/MEK boards.
>
> For M.2 cards that rely on PCIe L2 link state and wake-up mechanisms, the
> card must remain powered during suspend. Patch 1 uses the existing
> dw_pcie_rp::skip_pwrctrl_off flag to skip power-off during suspend and skip
> power-on during the init path.
>
> Alsp the btnxpuart driver is extended to obtain a pwrseq descriptor via the
> OF graph on the UART controller device in patch 2.
>
> Sherry Sun (8):
>   PCI: imx6: Add skip_pwrctrl_off flag support
>   power: sequencing: pcie-m2: Add PCI ID for NXP 88W9098 and AW693
>     Bluetooth

Can this be applied independently without build-time issues?

Bart

>   Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
>   arm64: dts: imx8mq-evk: Describe the PCIe M.2 Key E connector
>   arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
>   arm64: dts: imx8dxl-evk: Describe the PCIe M.2 Key E connector
>   arm64: dts: imx8qm-mek: Describe the PCIe M.2 Key E connector
>   arm64: dts: imx8qxp-mek: Describe the PCIe M.2 Key E connector
>
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 56 +++++++++++++-----
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 44 ++++++++++++--
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 58 ++++++++++++++-----
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 54 ++++++++++++-----
>  .../boot/dts/freescale/imx95-19x19-evk.dts    | 55 +++++++++++++-----
>  drivers/bluetooth/btnxpuart.c                 | 33 ++++++++++-
>  drivers/pci/controller/dwc/pci-imx6.c         | 36 +++++++-----
>  drivers/power/sequencing/pwrseq-pcie-m2.c     |  4 ++
>  8 files changed, 264 insertions(+), 76 deletions(-)
>
> --
> 2.50.1
>
>
