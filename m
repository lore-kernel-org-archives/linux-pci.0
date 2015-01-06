Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56680 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550AbbAFTex (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 14:34:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, Feng Kan <fkan@apm.com>,
	linux-pci@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>
Subject: Re: [PATCH 3/4] documentation: dts: Add the device tree binding for APM X-Gene v1 PCIe MSI device tree node.
Date: Tue, 06 Jan 2015 20:34:50 +0100
Message-ID: <1715051.BWgXSpP5LC@wuerfel>
In-Reply-To: <33cd03155176a77c673eee4a4598e677a3a9b8b4.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com> <33cd03155176a77c673eee4a4598e677a3a9b8b4.1420499393.git.dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 06 January 2015 08:15:43 Duc Dang wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> @@ -0,0 +1,34 @@
> +* AppliedMicro X-Gene PCIe MSI interface
> +
> +Required properties:
> +
> +- compatible: should contain "apm,xgene-pcie-msi" or "apm,xgene-storm-pcie-msi"
> +       to identify the core.
> +- reg: A list of physical base address and length for each set of controller
> +       registers.
> +- interrupts: A list of interrupt outputs of the controller.
> +
> +Examples:
> +
> +SoC DTSI:
> +
> +       msi@79000000 {
> +            compatible = "apm,xgene-storm-pcie-msi", "apm,xgene-pcie-msi";
> +            reg = <0x00 0x79000000 0x0 0x900000>;
> +            interrupts = <  0x0 0x10 0x4
> +                    0x0 0x11 0x4
> +                    0x0 0x12 0x4
> +                    0x0 0x13 0x4
> +                    0x0 0x14 0x4
> +                    0x0 0x15 0x4
> +                    0x0 0x16 0x4
> +                    0x0 0x17 0x4
> +                    0x0 0x18 0x4
> +                    0x0 0x19 0x4
> +                    0x0 0x1a 0x4
> +                    0x0 0x1b 0x4
> +                    0x0 0x1c 0x4
> +                    0x0 0x1d 0x4
> +                    0x0 0x1e 0x4
> +                    0x0 0x1f 0x4>;
> +       };

I think the example should contain the pci controller with the respective
msi-parent property.

	Arnd
