Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752592AbeEKOJ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 May 2018 10:09:57 -0400
Subject: Re: [PATCH v3 2/2] arm64: dts: hi3660: Add pcie msi interrupt
 attribute
To: Yao Chen <chenyao11@huawei.com>, <songxiaowei@hisilicon.com>,
        <wangbinghui@hisilicon.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
 <1526030149-23985-3-git-send-email-chenyao11@huawei.com>
CC: <dimitrysh@google.com>, <guodong.xu@linaro.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <xuwei5@hisilicon.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5AF5A411.4010507@hisilicon.com>
Date: Fri, 11 May 2018 15:09:21 +0100
MIME-Version: 1.0
In-Reply-To: <1526030149-23985-3-git-send-email-chenyao11@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yao,

On 2018/5/11 10:15, Yao Chen wrote:
> Add pcie msi interrupt attribute for hi3660 SOC.
> 
> Signed-off-by: Yao Chen <chenyao11@huawei.com>

Applied patch 2 into the hisilicon dt tree.
Thanks!

BR,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index ec3eb8e..2cef8f4 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -872,6 +872,8 @@
>  				  0x0 0x02000000>;
>  			num-lanes = <1>;
>  			#interrupt-cells = <1>;
> +			interrupts = <0 283 4>;
> +			interrupt-names = "msi";
>  			interrupt-map-mask = <0xf800 0 0 7>;
>  			interrupt-map = <0x0 0 0 1
>  					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> 
