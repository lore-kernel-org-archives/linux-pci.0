Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32926 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbbGNJYX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jul 2015 05:24:23 -0400
Date: Tue, 14 Jul 2015 10:23:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Jon Mason <jonmason@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] arm64: dts: Add Broadcom North Star 2 support
Message-ID: <20150714092353.GA12675@leverpostej>
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
 <1436837955-26279-5-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436837955-26279-5-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> +/dts-v1/;
> +
> +#include "ns2.dtsi"
> +
> +/ {
> +       model = "Broadcom NS2 SVK";
> +       compatible = "brcm,ns2-svk", "brcm,ns2";
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200n8 earlycon=uart8250,mmio32,0x66130000";
> +       };

Please use stdout-path instead (you can use /aliases to make it
simpler). It'll save a redundant description of the UART and will remove
the dependency on Linux-specific naming of the UART.

[...]

> +/ {
> +       compatible = "brcm,ns2";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a57", "arm,armv8";
> +                       reg = <0 0>;
> +                       enable-method = "spin-table";
> +                       cpu-release-addr = <0 0x84b00000>;
> +               };
> +       };

Shouldn't the other CPUs be described?

Using spin-table for SMP is somewhat unfortunate, as it comes with a
number of problems (e.g. unwoken secondaries spinning in the kernel). I
would strongly advise using PSCI instead.

> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xff) |
> +                             IRQ_TYPE_EDGE_RISING)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_RAW(0xff) |
> +                             IRQ_TYPE_EDGE_RISING)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_RAW(0xff) |
> +                             IRQ_TYPE_EDGE_RISING)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_RAW(0xff) |
> +                             IRQ_TYPE_EDGE_RISING)>;
> +               clock-frequency = <25000000>;
> +       };

Please fix your firmware to configure CNTFRQ_EL0, it is simply a bug not
to, and using clock-frequency does not fix all the problems that not
configuring it causes.

Thanks,
Mark.
