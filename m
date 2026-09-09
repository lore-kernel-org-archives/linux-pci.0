Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574074519A3
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940297; cv=none; b=ZRFn5zDhUcTr11hHDQzsqrb8lOoptDIHrjpzTrJVQgdI64OwPM1O6FTt7WHkaMk5aq1+Vq505E9wey4ZCsxOUj3h3EGtEdzz6JzQmhDKIHBhXyRwtkQCfVpr1cwuGYo7l7mDtETRdaawr77hWpyjlHQBUCvumLsbRHt6JgRwQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940297; c=relaxed/simple;
	bh=L93RZFfSNxCUGv3IQaOPX+eNMIHvMrFA8PqhAa8TdM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByDZyvEN4/Tc6FiyIIZa2vhpunoM2Vvp/Izm3bd6VEsshvw8YBpvyyUIfuAkJCrjsVXQ2h5tUiXJv0INwjDgtso3GZR0wfi+Yofw2vqtLZHhZQzzULVFo08vtW75YVIzXrFyGSuB17Us2nMK7l2VCP/AFMEUTiS3YBVrw6XcHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqU7obUy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqU7obUy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d944747d41so60560195ad.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940295; x=1789545095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jKrEyC/4kP8ddKpasgLPQzfssOl6topa0dwYgM8fxlQ=;
        b=BqU7obUyrAVj4F1/sz5IrQyo2Nak+BLQsiXCUzX1QCLg6mTaWKlOkyUQqYvTrGtzH4
         LGEfTk2vgVUNYqT9SpuE5VfklDThxqbzbxH7ZsuBpkD131EZm6IjmLgMEIqhhi6Z5Qc7
         Kg5nH56JPG71m4BA7Hr8HLgMHm5JQ3FBeX8LkXsYI7udWcVL0L3M2uFK6B8PzeaQPWId
         xX/A/oiKBEIoZfgXhytkIyGNNa2nJkoFJIi3QqxuLhrgsmsBUi0M9Oc4gdmWpOe4XKcb
         hZ1QO2PVfN1wqhhvjvKVoIbI4zyheTvcwN9cmarfdZDWQbhq5s6mMx/KjePq1Q75dSJ6
         FQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940295; x=1789545095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKrEyC/4kP8ddKpasgLPQzfssOl6topa0dwYgM8fxlQ=;
        b=VdEtcONpvUr1LFgrPluUkOupYn/hNh9aXGbPln4ojuED6XjD//YpBjyKKlH/apBvd1
         ufo7OE9iLoJSQr62ySVrnuxVZBMuf33AgB7dT3Ogf/eXj9x6yDKyh5dO5Wa1dn2C/4l1
         Jzhro7GZN27TxMn1QGgqNOEEmvH+g0vviTzTTX9CLBVJxT3+drOApolYoFQ2yHfCGFYu
         UlpQX8xkVNb3xYhdERCPKsbQ26ZTQpdI1RmXb2Skr46MCgbVqIt3WJz+BqVG0ZjHycGe
         HD461VavzqSlCWF1cHW3eD/44/KWeFFWL1yUMJ/+u39KMALltoa7Sjlb5xdvyBDYrKxU
         yPvw==
X-Gm-Message-State: AFuF++kqdoxBbRpBQGOsT5z3libmTocRrP9G0YpIIFLEBcm88fnM1Tfp
	M0org7NaUw6VNLrLno3H1RbMxhhG1c8036XJmhnCiqrmt25tIf33EBAi
X-Gm-Gg: AYBFou1QhHm8OlrAcVYcVZG159EpgEAmaXKYaugqVRO9oEpj1uK4mo+io6+bQeHckgV
	kpwzRuEWx3BP640vi0pwVwJPe2rTIhCON8Fok5GuZU0KTDs8c/LXthKyLK6319/+Gaj9x6s358g
	DJh4BAERnvC4qrIzBLBKIK+SsAJnXpZaK3wUh9JF9I+R2FybtgBVqITQXL3LeEM/Y70pd5/OeU+
	1VFpFFLkHLEWu3vtF90FGwdv4/I/lEZ81J+NU/abSiQ+XxIGz5CweoKJyYMxJ6UBzmX3I59Ec+e
	RITBTgf0RxcbsFZhRgNZy3yC1UVotYNIXa5x4f1PYKR1zpAEV7nwMB9E/CVqc526iohwCrPnZpU
	nSJSSMmjW1ZwR0KjZHA9CZPBSnpLZH0QL2ILRVR3xaCzouSwlpfO+/BYlo5dz2z4Nu7NDn7GnhB
	O5mis37S9Sf7sRx31v7RiPR9FPoYCY6GAKhElBqMUcIwcZS3d0c9WSwiGMx5dt/AFw43oBGQ==
X-Received: by 2002:a17:903:3c47:b0:2db:eb5:47ea with SMTP id d9443c01a7336-2db12106896mr504658855ad.0.1788940294598;
        Wed, 09 Sep 2026 00:51:34 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497d9f9sm67640495ad.32.2026.09.09.00.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:51:33 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:51:02 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Sherry Sun <sherry.sun@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Bruel <christian.bruel@foss.st.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Alex Elder <elder@riscstar.com>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Randolph Lin <randolph@andestech.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <aqEOHmlKdKqQWYE8@inochi.infowork>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-7-inochiama@gmail.com>
 <DL940SRP94AG.408BKFWHDVY3@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL940SRP94AG.408BKFWHDVY3@linux.spacemit.com>

On Mon, Sep 07, 2026 at 09:14:23PM +0800, Troy Mitchell wrote:
> On Mon, Sep 7, 2026 at 07:26:05PM +0800, Inochi Amaoto wrote:
> > [...]
> >
> > @@ -303,6 +316,116 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
> > [...]
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
> > +		goto failed_phy;
> > +
> > +	msleep(PCIE_T_PVPERL_MS);
> > +
> > +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> > +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);
> > +
> 
> Should we use pci->pe_rst when reset-gpios is provided, and keep the PMU path as
> a fallback? The SDK handles both cases. The DWC core requests that GPIO with
> GPIOD_OUT_HIGH, but this path only releases PERST# through the PMU, so an
> endpoint using the GPIO would remain in reset.
> 

I do not think this should be included in this version. I found PICO-ITX
has no reset gpio support. This means I can not test this feature.

I suggest adding this function when there is a board using this function.

> > [...]
> >
> > +	/* Finally, as a workaround, disable ASPM L1 */
> > +	k1_pcie_disable_aspm_l1(k1);
> > +
> > +	return 0;
> > +
> 
> Would we also need to configure IOMMU bypass during initialization? The SDK sets
> the PCIe A/B/C bypass bits in PMUA_PCIE_SUBSYS_MGMT when there is no usable
> iommu-map. The proposed K3 PCIe DTS has no iommu-map, and I could not find the
> corresponding bypass setup in this series.
> 
> Is bypass already guaranteed by firmware or the reset state, or should the
> driver set it here? My concern is that enumeration could succeed while endpoint
> DMA still goes through an unconfigured IOMMU.
> 

I think the firmware should mark it bypassed as the default, at least
I have notice this behavior, but I am not sure whether it is the builtin
firmware or the uboot do this trick.

> > [...]
> >
> > +static int k3_pcie_parse_port(struct k1_pcie *k1)
> > +{
> > +	u32 status0, status1, status2;
> > +
> > +	/* This register require a RAW for cleanup */
> > +	status0 = readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> > +	status1 = readl_relaxed(k1->link + INTR_STATUS);
> > +	status2 = readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);
> > +
> > +	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> > +	writel_relaxed(status1, k1->link + INTR_STATUS);
> > +	writel_relaxed(status2, k1->link + K3_ADDR_INTR_STATUS1);
> > +
> > +	return k1_pcie_parse_port(k1);
> > +}
> > +
> 
> Are these status registers accessible before the controller clocks are enabled
> and resets released? k3_pcie_parse_port() runs before dw_pcie_host_init(), which
> calls k3_pcie_init() to enable those resources.
> 

Yes they can. It is something interesting.

> The SDK uses the same ordering, but I am not sure whether it relies on firmware
> leaving the registers accessible. If so, would it be safer to move this clearing
> into k3_pcie_init(), after enabling the resources?
> 

In fact, I have no idea about which clock control this MMIO area, if it is dbi
clock (but I guest it is not), it is kind of weird for this clear and should
move to the init. Do you have some knowledge on this?

Regards,
Inochi
