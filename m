Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:57572 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753493Ab3GAKI7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 06:08:59 -0400
Message-ID: <51D15513.7020101@st.com>
Date: Mon, 1 Jul 2013 15:38:19 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: Sean Cross <xobs@kosagi.com>
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Mohit KUMAR <Mohit.KUMAR@st.com>
Subject: Re: [PATCH 3/4] PCI: Add driver for i.MX6 PCI Express
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com> <1372662947-27160-4-git-send-email-xobs@kosagi.com>
In-Reply-To: <1372662947-27160-4-git-send-email-xobs@kosagi.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/1/2013 12:45 PM, Sean Cross wrote:
> This adds a PCI Express port driver for the on-chip PCI Express port
> present on the i.MX6 SoC.  It is based on the PCI Express driver available
> in the Freescale BSP.
>
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---

...

> diff --git a/drivers/pci/pcie/pcie-imx.c b/drivers/pci/pcie/pcie-imx.c
> new file mode 100644
> index 0000000..664679e
> --- /dev/null
> +++ b/drivers/pci/pcie/pcie-imx.c

Should go to drivers/pci/host/

> @@ -0,0 +1,1049 @@
> +/*
> + * drivers/pci/pcie/pcie-imx.c
> + *

...


> +#define ATU_R_BaseAddress 0x900
> +#define PCIE_PL_iATUVR (ATU_R_BaseAddress + 0x0)
> +#define PCIE_PL_iATURC1 (ATU_R_BaseAddress + 0x4)
> +#define PCIE_PL_iATURC2 (ATU_R_BaseAddress + 0x8)
> +#define PCIE_PL_iATURLBA (ATU_R_BaseAddress + 0xC)
> +#define PCIE_PL_iATURUBA (ATU_R_BaseAddress + 0x10)
> +#define PCIE_PL_iATURLA (ATU_R_BaseAddress + 0x14)
> +#define PCIE_PL_iATURLTA (ATU_R_BaseAddress + 0x18)
> +#define PCIE_PL_iATURUTA (ATU_R_BaseAddress + 0x1C)

I may be wrong, but from these offset it seems to me that it is SNPS 
controller. If yes, then please go through comments of
"[PATCH V1-10 0/4] PCIe support for Samsung Exynos5440 SoC"

Regards
Pratyush
