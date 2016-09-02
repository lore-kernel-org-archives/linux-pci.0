Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 2 Sep 2016 14:40:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 10/15] Group related CSR definitions together.
Message-ID: <20160902214034.GB31011@roeck-us.net>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160902155518.8650.89467.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160902155518.8650.89467.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 02, 2016 at 10:55:19AM -0500, Bjorn Helgaas wrote:
> 
> ---
>  drivers/pci/host/pcie-rockchip.c |  148 +++++++++++++++++++-------------------
>  1 file changed, 74 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 6edfce5..fe1b52f 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -37,21 +37,27 @@
>  #include <linux/reset.h>
>  #include <linux/regmap.h>
>  
> -#define PCIE_CLIENT_BASE			0x0
> -#define PCIE_RC_CONFIG_BASE			0xa00000
> -#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2	(PCIE_RC_CONFIG_BASE + 0x90c)
> -#define PCIE_RC_CONFIG_LCS			(PCIE_RC_CONFIG_BASE + 0x0d0)
> -#define  PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
> -#define  PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
> -#define  PCIE_RC_CONFIG_LCS_LABIE		BIT(11)
> -#define  PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
> -#define  PCIE_RC_CONFIG_LCS_LAMS		BIT(31)
> -#define PCIE_CORE_CTRL_MGMT_BASE		0x900000
> -#define PCIE_CORE_AXI_CONF_BASE			0xc00000
> -#define PCIE_CORE_AXI_INBOUND_BASE		0xc00800
> -#define PCIE_CLIENT_BASIC_STATUS1		(PCIE_CLIENT_BASE + 0x48)
> -#define PCIE_CLIENT_INT_MASK			(PCIE_CLIENT_BASE + 0x4c)
> -#define PCIE_CLIENT_INT_STATUS			(PCIE_CLIENT_BASE + 0x50)
> +/*
> + * The upper 16 bits of PCIE_CLIENT_BASE are a write mask for the lower 16
> + * bits.  This allows atomic updates of the register without locking.
> + */
> +#define HIWORD_UPDATE(mask, val)	((mask << 16) | val)
> +
(mask), (val)

> +#define ENCODE_LANES(x)			(((x >> 1) & 3) << 4)

(x)

Guenter
