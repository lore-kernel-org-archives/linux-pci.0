Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:50786 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752776Ab3GAJ6Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 05:58:25 -0400
Message-ID: <51D15295.2000601@st.com>
Date: Mon, 1 Jul 2013 15:27:41 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: Sean Cross <xobs@kosagi.com>
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Mohit KUMAR <Mohit.KUMAR@st.com>
Subject: Re: [PATCH 2/4] ARM: Enable PCI Express on ARM
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com> <1372662947-27160-3-git-send-email-xobs@kosagi.com>
In-Reply-To: <1372662947-27160-3-git-send-email-xobs@kosagi.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/1/2013 12:45 PM, Sean Cross wrote:
> Some ARM devices have PCI Express hardware, and should be able to take
> advantage of PCI Express code present in the common driver files.  Enable
> PCI Express on ARM, when PCI is available.
>
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---
>   arch/arm/Kconfig |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 136f263..2f51f13 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1418,6 +1418,8 @@ config PCI_HOST_ITE8152
>
>   source "drivers/pci/Kconfig"
>
> +source "drivers/pci/pcie/Kconfig"
> +
>

[PATCH V10 2/4] ARM: EXYNOS: Enable PCIe support for Exynos5440 does the 
same thing.

  source "drivers/pcmcia/Kconfig"
>
>   endmenu
>


