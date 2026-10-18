Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7534145B27;
	Sun, 18 Oct 2026 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326975; cv=none; b=BNl4hfMcdPuS1KmP8J1CkZjCrrnxxcSWnzqrdSGP1XV8HK6OiPgscF8awvXqN3CrU4WrQbauz7v+HvrUP0zXhnThIfWWeoquAfPNsQDxO9JMyoe+LL4wrXmZ3zbzccUfg03MCk8OiyKGD1hNMa1C9ZzxleCoGVhf150QwEnkaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326975; c=relaxed/simple;
	bh=ljDHyDaZBANeeICNvzSN7DVpxrl3r0R0WMwfV/PkUXM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OKg8r50AHQ+1iDQ63SvFa9Tlw6GFRmSp+omm9Sa9iDxtoZCAZmRsBD1HJYBWRDlIz4CsRvhJEt5Ph7WH13yuuZSJPGZtiJFq0rMDgTt7YW/TJ+XbMxTQzJbnKxg6wlpQZlembqoWLRu3ydJ2oh2ze1Wc80JtL9HJXSPcEygywzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4178D1F000C4;
	Sun, 18 Oct 2026 12:35:57 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Christian Bruel <christian.bruel@foss.st.com>, 
 Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Randolph Lin <randolph@andestech.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Alex Elder <elder@riscstar.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vidya Sagar <vidyas@nvidia.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
In-Reply-To: <20260929083755.458238-7-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-7-inochiama@gmail.com>
Date: Sun, 18 Oct 2026 18:05:39 +0530
Message-Id: <179232693939.2114.10956498814503201256.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ljDHyDaZBANeeICNvzSN7DVpxrl3r0R0WMwfV/PkUXM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq1L0pE5kbgUbKenMgAMe+ZzJeUUKq5H6vAkioO
 RiDLJWutYKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatS9KQAKCRBVnxHm/pHO
 9RvzB/9/ZK7KgWgk4XijvjJCRJao8cXcma0BG7oXAw0FSZAUcT47dcuRodLf4Qn6okWf9kCDbmn
 aHD17eIigO8b6uPuGn8P+zndjKVE3yXIxPQU/Am9k+/T/6TFhZD5VxhtCChzFi8jxIpa6S9S14L
 pHksTseuSy8+l7eMZcw1Orq9GNHitN5lMRkRYhb/qSumrZIgL4IKCdqho64yZ2dEJRaYquGhvEz
 ltoCD/PkJA4QvgRc5yrIYMw4nuQXDrGviRUL9iZdRaIFi2HsjNCzrcdXgL7pLjsjDPiQSM5FLLG
 sFcUeCrrqDAHwMlPFVuNK4Zcxhy913CMi8nNUH7jQFaYHJNy
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-29 16:37 +0800, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> DesignWare PCIe IP with extra link and reset control. Unlike
> the PCIe controller on K1, this controller supports external MSI
> interrupt controller and can use multiple PHYs at the same time.
> 
> Add driver to support PCIe controller on Spacemit K3 PCIe.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   4 +-
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 139 ++++++++++++++++++
>  2 files changed, 141 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index dcfbe7e229fd..f9c27165260e 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -443,7 +443,7 @@ config PCIE_SOPHGO_DW
>  	  Sophgo SoCs.
>  
>  config PCIE_SPACEMIT_K1
> -	tristate "SpacemiT K1 PCIe controller (host mode)"
> +	tristate "SpacemiT PCIe controller (host mode)"
>  	depends on ARCH_SPACEMIT || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	select PCIE_DW_HOST
> @@ -451,7 +451,7 @@ config PCIE_SPACEMIT_K1
>  	default ARCH_SPACEMIT
>  	help
>  	  Enables support for the DesignWare based PCIe controller in
> -	  the SpacemiT K1 SoC operating in host mode.  Three controllers
> +	  the SpacemiT SoC operating in host mode. Three controllers
>  	  are available on the K1 SoC; the first of these shares a PHY
>  	  with a USB 3.0 host controller (one or the other can be used).
>  
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> index ec59ccb710ec..61b430f2294a 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -28,8 +28,18 @@
>  #define SMLH_LINK_UP			BIT(1)
>  #define RDLH_LINK_UP			BIT(12)
>  
> +#define INTR_STATUS				0x0010
> +
>  #define INTR_ENABLE				0x0014
>  #define MSI_CTRL_INT			BIT(11)
> +#define RDLH_LINK_UP_INT		BIT(20)
> +
> +#define K3_PHY_AHB_IRQSTATUS_INTX		0x0008
> +
> +#define K3_ADDR_INTR_STATUS1			0x0018
> +
> +#define K3_CACHE_MSTR_AWCACHE_MODE	GENMASK(14, 11)
> +#define K3_CACHE_MSTR_AWCACHE_BEHAVIOR	0xf
>  
>  /* Some controls require APMU regmap access */
>  #define SYSCON_APMU			"spacemit,apmu"
> @@ -44,6 +54,9 @@
>  
>  #define PCIE_CONTROL_LOGIC			0x0004
>  #define PCIE_SOFT_RESET			BIT(0)
> +#define PCIE_PERSTN_OE			BIT(24)
> +#define PCIE_PERSTN_OUT			BIT(25)
> +#define PCIE_IGNORE_PERSTN		BIT(31)
>  
>  struct k1_pcie;
>  
> @@ -315,6 +328,123 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
>  	return ret;
>  }
>  
> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct k1_pcie *k1 = to_k1_pcie(pci);
> +	u32 reset_ctrl = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
> +	u32 val;
> +	int ret;
> +
> +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
> +
> +	k1_pcie_toggle_soft_reset(k1);
> +
> +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT,
> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);
> +
> +	ret = k1_pcie_enable_resources(k1);
> +	if (ret)
> +		goto failed_resources;
> +
> +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
> +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
> +
> +	ret = phy_bulk_init(k1->phy_count, k1->phys);
> +	if (ret)
> +		goto failed_phy_init;

You got me confused with this PHY bulk API for a moment. I think you are trying
to control all the PHYs of the multi-port RC setup at once. But I believe
that's not what we want mostly. Each port is an independent entity with its own
PHY, PERST# etc... So the RC driver controlling all the PHYs at once, doesn't
seem logical.

- Mani

