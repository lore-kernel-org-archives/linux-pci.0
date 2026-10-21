Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569453;
	b=eRChpMfMmanPCrV2lOYol99EDVIlquTXSisoDt3Hh0aOJrurxBaCSUe3GOIqhoO8Aryu
	 b1EFpr07b2VdhsYjLLqagZI/XEjXHPbWneT6RD4U40ZOW5nm5xPDRXomXAXQ5TWnIuvX6
	 WZXBndZSf/pWyFH/Fo4e/jMERBXpKBcMD4ktD41y6rmcOLkreKJUFdxow02FPSfWD55dW
	 mAuJrXOCA4FP1/39cxXhPxWfcZks6Q2U8SpT+ifxFGupphple74Iiw2MomJ38OIXHy6zx
	 uNpFUpVk+JJRSuu8+Fh6T8Tp2myzgzPtaX7D820Y3sJjps1svL/6FTvIO663UEpm25w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=s7OIxnjVnGRZmr1LgfXzEIcyEF1Urq62srWXFTWymcQ=;
	b=FJGkkcif6gMuRZ/2ke/QyBgjxA4c3RuEVzm4cjPbUr4kikOdYZT01PNz0xrwQPtGSc2H
	 3r5mekv8IGS2NaBfGfSUjRas+8CwRq1Of7BY5XJCHsu7j4HgrtvgOBHW7J9YuONvi2v8v
	 89xuSRz0/zMQxnuycEljWZEpdwu+nu7ig0Mpy3TIAMSJRVNAzdhmKPKpfwU2cMontXYHi
	 Rgs6dazJpbrjhEwB0GhTwKJJZ8Bwc/72WpnZvykoOwqXu3QNNtHXCX6OIQ5RCMw6xAfNu
	 sdMQorL55NKi0H8ynjTPKRiSYkmUIcLMYLZeparz9GXcmip5x89McAITlGBG6aG+KwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K6lvj+lv;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADED606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 07:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AADED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K6lvj+lv
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e985106c0cso3400735ad.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792569452; x=1793174252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s7OIxnjVnGRZmr1LgfXzEIcyEF1Urq62srWXFTWymcQ=;
        b=K6lvj+lvZtKXzjvSRbsU+FaCzYBN2NYhJK+HUebHt9pABX0/rmG8wTenVUl0cSXM7a
         LHI8cJcZ2HPzePscY93875cum/9i7b4teuhjXFaV4AU1xRMYyUiJ4uN4vnCBVD1GyMrI
         dRboQPVmpBlkff7uJGjD9RU5uanu/8LlL72hj8Ii1/0sV5O2y2RI31Hbhr0WWbu4vn4O
         Gk3BPHcxszOKAa+CpUNBm/l+kXfk4WqXJaAOXBxnMAZsTNxc+hR+VwMCh3PnQ/WURBok
         /UBO73sWCjcP8GvtizUrEhmtR7S/GNaBFoQ0WLcu8Vy/autt+/7cBHsiZTm2DQaT6nOj
         NkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569452; x=1793174252;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s7OIxnjVnGRZmr1LgfXzEIcyEF1Urq62srWXFTWymcQ=;
        b=NDgUUBaYd+zAK2Prmv3ZM9Yk8rnzKULF5ME+u7C0wmCCUmKiUFyeQi7OIE4nqlqUoI
         W9XMZ1/txFs48ge+1bNMg0FKn+ApE3tiLdH0fKcY0T2pmEVHHknNjK8fN4rXOllbc5Dv
         Ikz04RUrRaXNMWGarSMyUL94Se+u+T/QuhN2xPgoKfQ8g7wc0MBi+9ND6VbJLdSVJ9WU
         zOhdwYd3a2Kdvv4Kq2UKg3z0q3Dcmj21MPPIY4WV0iPMQjwGqg826Ftv7GRoYo2ar4U5
         DvFpRMKcumzAk2qNOyxjOFFZJAIyvuE+90Tc6eQKy0W3TG3pvk80vAwXjx4p8hkzOIUE
         JC+Q==
X-Forwarded-Encrypted: i=1; AKwUvBya6VW3Aa4ii5OeWuE9x48xLvu/pAF2JrIVlw1zNOturZzS95U2IbBj+VQua8Vhkdyz+lHZXo5Awew=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo71Aq9PjFb210/9KfCyP3xfvIEQptpXxYLhNFHDMO8dg+GA7C
	QedZZRt/HOlXLju4L41bIOCmKdi2AKkt92121HJiIxrwGNPlVMLjfyXl
X-Gm-Gg: AYBFou2fRQwaEY0TPzh2j+j6+OvcVIwOH5ABoh4DMHsOr4Ky7JyEOpyvTO3qquBEPtE
	FgRK6CEXmgCFC4wKQrYWPtCZPNkztUy4V+Bqm4En07hAi9/nJZ5R3gUCp9R+DEm1UlSkTi5vGvn
	uxGC4ocim/+2KAPzFD9saYo4vp4M5/OeoqxUvJ37ns7Y63L3makbnCf1AOLZan+VORUHvY3sjTS
	ZCezgXVvme1BlEpLjhhva4kFhGbbKDh7vMxTFBXg6pq7y7rwHEdZaHxqtFLbYSRG/Jq6uXR73aw
	QU/wrhOAetKXt53p0E6NYZqJ5KL8gpNZdWGzsG06I/dVSAvk8wXMK+CRsP9KFJ7BKmTWKjx1XsK
	Yc5J3zn5uMxV6dcT4PbggLoPoPR2rO4ew2kVFwwOHLAT69ZioF76C0atpzAlWMEmxOObHtIR9WC
	ZIiiEYjvyz/gyIw1NJNiHRVZDsCH+5AmYgso5Qudl2g5Fumz6e2F9Ip4ECT9R6GKWbXpjkoV1yM
	BBCZ6h9nXnsfVltifZXaGgGgQYwgATizKZOWRZa5Tpt0GTRHnaDeg==
X-Received: by 2002:a17:902:f70c:b0:2e9:53c2:760 with SMTP id d9443c01a7336-2ea43c79efbmr10549995ad.30.1792569451953;
        Wed, 21 Oct 2026 00:57:31 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b48866bsm8021975ad.65.2026.10.21.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:57:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:56:52 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Niklas Cassel <cassel@kernel.org>, Christian Bruel <christian.bruel@foss.st.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Randolph Lin <randolph@andestech.com>, Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Alex Elder <elder@riscstar.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Vidya Sagar <vidyas@nvidia.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v7 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <athvDzJHs7WQmBnx@inochi.infowork>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-7-inochiama@gmail.com>
 <179232693939.2114.10956498814503201256.b4-reply@b4>
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
In-Reply-To: <179232693939.2114.10956498814503201256.b4-reply@b4>

On Sun, Oct 18, 2026 at 06:05:39PM +0530, Manivannan Sadhasivam wrote:
> On 2026-09-29 16:37 +0800, Inochi Amaoto wrote:
> > The PCIe controller on Spacemit K3 is almost a standard Synopsys
> > DesignWare PCIe IP with extra link and reset control. Unlike
> > the PCIe controller on K1, this controller supports external MSI
> > interrupt controller and can use multiple PHYs at the same time.
> > 
> > Add driver to support PCIe controller on Spacemit K3 PCIe.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   4 +-
> >  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 139 ++++++++++++++++++
> >  2 files changed, 141 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index dcfbe7e229fd..f9c27165260e 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -443,7 +443,7 @@ config PCIE_SOPHGO_DW
> >  	  Sophgo SoCs.
> >  
> >  config PCIE_SPACEMIT_K1
> > -	tristate "SpacemiT K1 PCIe controller (host mode)"
> > +	tristate "SpacemiT PCIe controller (host mode)"
> >  	depends on ARCH_SPACEMIT || COMPILE_TEST
> >  	depends on HAS_IOMEM
> >  	select PCIE_DW_HOST
> > @@ -451,7 +451,7 @@ config PCIE_SPACEMIT_K1
> >  	default ARCH_SPACEMIT
> >  	help
> >  	  Enables support for the DesignWare based PCIe controller in
> > -	  the SpacemiT K1 SoC operating in host mode.  Three controllers
> > +	  the SpacemiT SoC operating in host mode. Three controllers
> >  	  are available on the K1 SoC; the first of these shares a PHY
> >  	  with a USB 3.0 host controller (one or the other can be used).
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > index ec59ccb710ec..61b430f2294a 100644
> > --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > @@ -28,8 +28,18 @@
> >  #define SMLH_LINK_UP			BIT(1)
> >  #define RDLH_LINK_UP			BIT(12)
> >  
> > +#define INTR_STATUS				0x0010
> > +
> >  #define INTR_ENABLE				0x0014
> >  #define MSI_CTRL_INT			BIT(11)
> > +#define RDLH_LINK_UP_INT		BIT(20)
> > +
> > +#define K3_PHY_AHB_IRQSTATUS_INTX		0x0008
> > +
> > +#define K3_ADDR_INTR_STATUS1			0x0018
> > +
> > +#define K3_CACHE_MSTR_AWCACHE_MODE	GENMASK(14, 11)
> > +#define K3_CACHE_MSTR_AWCACHE_BEHAVIOR	0xf
> >  
> >  /* Some controls require APMU regmap access */
> >  #define SYSCON_APMU			"spacemit,apmu"
> > @@ -44,6 +54,9 @@
> >  
> >  #define PCIE_CONTROL_LOGIC			0x0004
> >  #define PCIE_SOFT_RESET			BIT(0)
> > +#define PCIE_PERSTN_OE			BIT(24)
> > +#define PCIE_PERSTN_OUT			BIT(25)
> > +#define PCIE_IGNORE_PERSTN		BIT(31)
> >  
> >  struct k1_pcie;
> >  
> > @@ -315,6 +328,123 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
> >  	return ret;
> >  }
> >  
> > +static int k3_pcie_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct k1_pcie *k1 = to_k1_pcie(pci);
> > +	u32 reset_ctrl = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
> > +	u32 val;
> > +	int ret;
> > +
> > +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
> > +
> > +	k1_pcie_toggle_soft_reset(k1);
> > +
> > +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
> > +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> > +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT,
> > +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);
> > +
> > +	ret = k1_pcie_enable_resources(k1);
> > +	if (ret)
> > +		goto failed_resources;
> > +
> > +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
> > +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
> > +
> > +	ret = phy_bulk_init(k1->phy_count, k1->phys);
> > +	if (ret)
> > +		goto failed_phy_init;
> 
> You got me confused with this PHY bulk API for a moment. I think you are trying
> to control all the PHYs of the multi-port RC setup at once. But I believe
> that's not what we want mostly. Each port is an independent entity with its own
> PHY, PERST# etc... So the RC driver controlling all the PHYs at once, doesn't
> seem logical.
> 

In fact this thing is different. Accoring to statement from spacemit, 
for software, it does not need to care about how the phy topology, 
and which phy/phys is/are attached to the RC. It just needs to enable
all the phy and configure the APMU, which is the one that give some
control on PERST# and others. The phy itself does nothing on this.

Regards,
Inochi


