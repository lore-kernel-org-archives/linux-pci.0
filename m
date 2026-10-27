Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090632;
	b=vvLAzsxJemW3YhMee8YxwTmyxz0EC1/U1knd8YxQfXfulgo8Te+BkTxIdQGiVdpu9Poz
	 Q+ThvFnlEzcxnST0EwZuY5Zm/1hBMGfBOo17nDHlD5wpRUsceNjCOLMkvPHAZorc6cW/3
	 3Smzq4NDRHbH75+aESxi09ucGRVbWcCyYTkLmuxST9UA4WHcPsW9IfQE2hr7ogVJ4bv/8
	 dGv4IYF2UoggctqcYcML7QsAPWzwWmx3a8M4+jqwlASiMx0iC7Xbml8IEZC0ZQIGM3iri
	 ux9x8ntuQR2VqGEl+eIPdiH/SlohJ6BxhvIP1O3p3DJcVidQvOdshTaM+ZB6LO3HpVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WdGWi2lCPsVOQrfWu4TCiPig1JxwAx4MQlsKT53PN3c=;
	b=VS6qlcrG/XfpAzZiPWSlTRTUR0vEpgPwexkyeW/pnbzNFjmF9MSrQFlfQGRMO4sLEZRj
	 xyJPV0rbwOzKk3OEIkj32+AIbjykgmxc7hEz+NjITIFglpyN6AgAyUmSFSUnIS6dDtfjF
	 n20AhJByjDyCEK8oRcPdV0lvh6LeAX3ohcOim3cZu3P5x1fAbAom1RiRogCV0NNKQdgfD
	 RG9Ls5g5mv4X++IZXvy5tx0nVy2Yi7vj7g4w7MEeRPfGAUzMlN37PQ9BfdnT3Pe7zMSwD
	 WX33w0J7Km6e511WwbHsWLcXaUDtZ//SVvhIAxW5jCVCbzmFVYJZux+eLtC+5yxcfRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X6h3MaKU;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887C606A31D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 08:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8887C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X6h3MaKU
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea0efd636dso31000775ad.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793090631; x=1793695431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WdGWi2lCPsVOQrfWu4TCiPig1JxwAx4MQlsKT53PN3c=;
        b=X6h3MaKU/WaA/MnP0JtjHmvUoxo8La1Gi2rFdudPKo5jMX4Pg4Q1MAgw8PLeqeF0Qb
         KPt/u3uRBlseZ+5gw3ZikC6qiss0fDsz/WtBZwv3nHEGmGtpxEmcM2sE9EFH6fG4c5BA
         kx5j+7PLiQl8WBXroU8rS5DxbDa4TLqr7mJWdfcBu8yYXu8Dot79vSTVU1aiUtvVwMSx
         55BSa9oYtiKKuOzVzqL5/RPRWAVP9C+Il8GFhbstTvLRxa7DvUDUCsXlqatLpZqqQYuI
         CnBk51RdhO41gakhMBWpHtm5Vp8DoY/F4fq19tZ3melf0NZZoXoMEKBazIhCeKuRThws
         Ed9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090631; x=1793695431;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdGWi2lCPsVOQrfWu4TCiPig1JxwAx4MQlsKT53PN3c=;
        b=nM2lhDNHVEHrdnjoGV9P6ktG1LsOdB7uElifC3F/hGtN68amZj8IUFksIONP2H+GDh
         pDnuTBaD7A0Ox6SZ8YoYeGt4IyUWEW37PryutL8d9NyR+sm+qgJHp/zJ7Ou+f65sS3Pf
         oWeSc+SeRGtvg70f4Ll+nGxVAare5UzC+3lGMJOPMuF6ASD+CdCEvmGAYSpyEH2heflF
         FU768oPZNYuoCCX0Le44t+Ie49oIYJe5C4UsagIWjjll5u1LIRidoBV6P9GA69EvuKDf
         OWoDtPy5Y3ISAaIMzwgnrJ5OIuI3vJKBpv22yz01nin+RqqxxfYno7y9dOvaB0x8SQLR
         mXDA==
X-Forwarded-Encrypted: i=1; AKwUvBynSfjwuxM1/qZdlt309Z7GdK/v9TmfUVLobjpxVOc2BS5/EeRp5TxEok+HUhMvkKTVReTWeHjF86E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKm7TjS7nKVKjXIUODpg0m7DobjSrqXOCZdZzajTgtrYNbHOaXh
	8X3MXRpqY1r65hjKaVQbZo5Huh5Rme2keMBCTXJ5rHilZtv0vcqe+F/Y
X-Gm-Gg: AYBFou0BFW8EhIQS7TJkVBr2Yc80Crw6IyOy0eAMPEYQwGnyOrnuCuOVCHSvQneV04B
	8VCZKjlG1zGirPFKobJG1zMiZwxBYxMN9C72NNrNmYjQs8COpIB0mwjGvbuW47P8KT6GOdtDU/b
	hYEY22/xNHAwMdmhCAWxY9Be81LrbW6tWttK8PyCgGIAH6bx8cejvSXrlJIGm1dOnt1Sw0aTedq
	S/XtVm+L/mtjFwYls1R3apG8D3oG3f9ja80JQ4VwMqxiYFsj77zplfyLhbusknL9Xm3/z2gdyoI
	ub6ZERB7w1lwV/UOUCdSliC/fQ++sXaiaRnB7vou3uJmRz8aRzAtWGLrkQSKuikxynDrHQSGdXT
	QV5M9ZXnfvzPBiUWEo8dpdHhb/TwDdLM5G+6o3FaU8kvZ59l79krzQjEHLF1cltoyA1AqOJsXGC
	eTtlColSqe6WKmy4RSfekmFyfyTd6Wec8tQrqgeMmphBBzPKm02lvZ+eVBKfd6lb/9PHnwBgUbe
	G+on84DxJnOv2ZkzjjUKknjj+RlCQbDNG/FPYmpOyM2I25+pCC8Lw==
X-Received: by 2002:a17:903:2389:b0:2e9:6788:9379 with SMTP id d9443c01a7336-2ea9c821072mr73512925ad.32.1793090630759;
        Tue, 27 Oct 2026 01:43:50 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm5640215ad.35.2026.10.27.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:43:50 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:43:04 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Niklas Cassel <cassel@kernel.org>, Christian Bruel <christian.bruel@foss.st.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Randolph Lin <randolph@andestech.com>, Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Alex Elder <elder@riscstar.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Vidya Sagar <vidyas@nvidia.com>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v7 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <auBkBSr5N_FlCPxD@inochi.infowork>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-7-inochiama@gmail.com>
 <179232693939.2114.10956498814503201256.b4-reply@b4>
 <athvDzJHs7WQmBnx@inochi.infowork>
 <bddc44d0-5446-40a9-b211-28d0b03f89ad@ti.com>
 <179308804504.2479.5374380919602671853.b4-reply@b4>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179308804504.2479.5374380919602671853.b4-reply@b4>

On Tue, Oct 27, 2026 at 01:30:45PM +0530, Manivannan Sadhasivam wrote:
> On 2026-10-21 13:56 +0530, Siddharth Vadapalli wrote:
> > On 10/21/26 1:26 PM, Inochi Amaoto wrote:
> > > On Sun, Oct 18, 2026 at 06:05:39PM +0530, Manivannan Sadhasivam wrote:
> > >> On 2026-09-29 16:37 +0800, Inochi Amaoto wrote:
> > >>> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> > >>> DesignWare PCIe IP with extra link and reset control. Unlike
> > >>> the PCIe controller on K1, this controller supports external MSI
> > >>> interrupt controller and can use multiple PHYs at the same time.
> > >>>
> > >>> Add driver to support PCIe controller on Spacemit K3 PCIe.
> > >>>
> > >>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > >>> ---
> > >>>   drivers/pci/controller/dwc/Kconfig            |   4 +-
> > >>>   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 139 ++++++++++++++++++
> > >>>   2 files changed, 141 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > >>> index dcfbe7e229fd..f9c27165260e 100644
> > >>> --- a/drivers/pci/controller/dwc/Kconfig
> > >>> +++ b/drivers/pci/controller/dwc/Kconfig
> > >>> @@ -443,7 +443,7 @@ config PCIE_SOPHGO_DW
> > >>>   	  Sophgo SoCs.
> > >>>   
> > >>>   config PCIE_SPACEMIT_K1
> > >>> -	tristate "SpacemiT K1 PCIe controller (host mode)"
> > >>> +	tristate "SpacemiT PCIe controller (host mode)"
> > >>>   	depends on ARCH_SPACEMIT || COMPILE_TEST
> > >>>   	depends on HAS_IOMEM
> > >>>   	select PCIE_DW_HOST
> > >>> @@ -451,7 +451,7 @@ config PCIE_SPACEMIT_K1
> > >>>   	default ARCH_SPACEMIT
> > >>>   	help
> > >>>   	  Enables support for the DesignWare based PCIe controller in
> > >>> -	  the SpacemiT K1 SoC operating in host mode.  Three controllers
> > >>> +	  the SpacemiT SoC operating in host mode. Three controllers
> > >>>   	  are available on the K1 SoC; the first of these shares a PHY
> > >>>   	  with a USB 3.0 host controller (one or the other can be used).
> > >>>   
> > >>> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > >>> index ec59ccb710ec..61b430f2294a 100644
> > >>> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > >>> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > >>> @@ -28,8 +28,18 @@
> > >>>   #define SMLH_LINK_UP			BIT(1)
> > >>>   #define RDLH_LINK_UP			BIT(12)
> > >>>   
> > >>> +#define INTR_STATUS				0x0010
> > >>> +
> > >>>   #define INTR_ENABLE				0x0014
> > >>>   #define MSI_CTRL_INT			BIT(11)
> > >>> +#define RDLH_LINK_UP_INT		BIT(20)
> > >>> +
> > >>> +#define K3_PHY_AHB_IRQSTATUS_INTX		0x0008
> > >>> +
> > >>> +#define K3_ADDR_INTR_STATUS1			0x0018
> > >>> +
> > >>> +#define K3_CACHE_MSTR_AWCACHE_MODE	GENMASK(14, 11)
> > >>> +#define K3_CACHE_MSTR_AWCACHE_BEHAVIOR	0xf
> > >>>   
> > >>>   /* Some controls require APMU regmap access */
> > >>>   #define SYSCON_APMU			"spacemit,apmu"
> > >>> @@ -44,6 +54,9 @@
> > >>>   
> > >>>   #define PCIE_CONTROL_LOGIC			0x0004
> > >>>   #define PCIE_SOFT_RESET			BIT(0)
> > >>> +#define PCIE_PERSTN_OE			BIT(24)
> > >>> +#define PCIE_PERSTN_OUT			BIT(25)
> > >>> +#define PCIE_IGNORE_PERSTN		BIT(31)
> > >>>   
> > >>>   struct k1_pcie;
> > >>>   
> > >>> @@ -315,6 +328,123 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
> > >>>   	return ret;
> > >>>   }
> > >>>   
> > >>> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> > >>> +{
> > >>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > >>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
> > >>> +	u32 reset_ctrl = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
> > >>> +	u32 val;
> > >>> +	int ret;
> > >>> +
> > >>> +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
> > >>> +
> > >>> +	k1_pcie_toggle_soft_reset(k1);
> > >>> +
> > >>> +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
> > >>> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> > >>> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT,
> > >>> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);
> > >>> +
> > >>> +	ret = k1_pcie_enable_resources(k1);
> > >>> +	if (ret)
> > >>> +		goto failed_resources;
> > >>> +
> > >>> +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
> > >>> +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
> > >>> +
> > >>> +	ret = phy_bulk_init(k1->phy_count, k1->phys);
> > >>> +	if (ret)
> > >>> +		goto failed_phy_init;
> > >>
> > >> You got me confused with this PHY bulk API for a moment. I think you are trying
> > >> to control all the PHYs of the multi-port RC setup at once. But I believe
> > >> that's not what we want mostly. Each port is an independent entity with its own
> > >> PHY, PERST# etc... So the RC driver controlling all the PHYs at once, doesn't
> > >> seem logical.
> > >>
> > > 
> > > In fact this thing is different. Accoring to statement from spacemit,
> > > for software, it does not need to care about how the phy topology,
> > > and which phy/phys is/are attached to the RC. It just needs to enable
> > > all the phy and configure the APMU, which is the one that give some
> > > control on PERST# and others. The phy itself does nothing on this.
> > According to section "14.1.4 PHY Configuration Block Diagram" in the User 
> > Manual for the Spacemit K3 SoC [0],the x8 Lane PCIe Controller namely 'PCIe 
> > A' requires multiple PHYs (ranging from PHY0 to PHY5) to be 
> > initialized/enabled simultaneously for a single Root-Port configuration. So 
> > the phy_bulk_init() API here seems to be used in that sense. Mani's concern 
> > is that the PHYs for all PCIe Controller instances are being configured in 
> > a single invocation to phy_bulk_init() rather than the potentially multiple 
> > PHY instances of a single PCIe Controller instance. Since k3_pcie_init is 
> > invoked per Root-Port instance (i.e. per PCIe Controller instance), the 
> > phy_bulk_init() API should configure 'all' PHY instances _strictly_ 
> > associated with the corresponding PCIe instance. This might already be the 
> > case.
> > 
> > [0]: 
> > https://spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k3/k3_docs/k3_usermanual/14_connectivity/pcie.md
> > 
> 
> Thanks for sharing the link to the doc. I didn't know this SoC allows muxing
> multiple PHYs for a single RP. Now the bulk API makes sense!
> 
> For the next iteration, please include a link to this page.
> 
> - Mani
> 

OK, I will include that, thanks.

Regards,
Inochi
