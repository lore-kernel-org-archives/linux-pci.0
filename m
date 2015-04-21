Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47298 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbbDUPTJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Apr 2015 11:19:09 -0400
Message-ID: <55366A64.6000907@arm.com>
Date: Tue, 21 Apr 2015 16:19:00 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>
Subject: Re: [PATCH v5 2/4] arm64: dts: Add the device tree entry for the
 APM X-Gene PCIe MSI node
References: <55310050.7000003@arm.com> <cover.1429586144.git.dhdang@apm.com> <227f8c75e04110e279b78512924742ba7c7fe5fc.1429586144.git.dhdang@apm.com>
In-Reply-To: <227f8c75e04110e279b78512924742ba7c7fe5fc.1429586144.git.dhdang@apm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21/04/15 05:04, Duc Dang wrote:
> There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  arch/arm64/boot/dts/apm/apm-storm.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index f1ad9c2..4b719c9 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -354,6 +354,28 @@
>  			};
>  		};
>  
> +		msi: msi@79000000 {
> +			compatible = "apm,xgene1-msi";
> +			msi-controller;
> +			reg = <0x00 0x79000000 0x0 0x900000>;

I've been repeatedly puzzled by the size of this region. In patch 1, you
say:

+ * X-Gene v1 has 16 groups of MSI termination registers MSInIRx, where
+ * n is group number (0..F), x is index of registers in each group (0..7)
+ * The registers layout is like following:
+ * MSI0IR0                     base_addr
+ * MSI0IR1                     base_addr +  0x10000
+ * ...                         ...
+ * MSI0IR6                     base_addr +  0x60000
+ * MSI0IR7                     base_addr +  0x70000
+ * MSI1IR0                     base_addr +  0x80000
+ * MSI1IR1                     base_addr +  0x90000
+ * ...                         ...
+ * MSI1IR7                     base_addr +  0xF0000
+ * MSI2IR0                     base_addr + 0x100000
+ * ...                         ...
+ * MSIFIR0                     base_addr + 0x780000
+ * MSIFIR1                     base_addr + 0x790000
+ * ...                         ...
+ * MSIFIR7                     base_addr + 0x7F0000

which implies that the size of the region is 0x800000. Or is there
something hidden in the last 16 64k pages?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
