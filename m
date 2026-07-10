Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4421CC5C
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648668; cv=none; b=VB16bNG1BSXqm3YHBjkDOvziA/zxd3e9bYrWqS3ymWCmlph8553AY+ACrpahsJWPI4UDJLanqi8ouSk2ATIRMTpCLVOXlFs1oAhzbBMwQPtZBF0rxFTEjyHLngHX0DEIeSJJExVfbrJ3HjMUANN8Uhtrcf5+VwRkBEGU7uLrfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648668; c=relaxed/simple;
	bh=dHlhaxBZM7dXqt8/qgDa0jI803YV2CvBpu+tjHS7fCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6HHn9jPCy2NKCQp4OAbNmO+Vg2wFYpwYDEYwDXOQjEdIIZHl260OBLWwB5fD1BMv2pooU/R3yNbC5ODVf71V9L7zHoxo8SG2RNbA6RsENoK2C3FqffHEjNoxdQ56NUhxepfyqQ1FX8m1BeMX4QUA+wVyJBvp8O9RZAhQ/eJtA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSPbH2HF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSPbH2HF"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cae1a3a744so2552325ad.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783648666; x=1784253466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yNnnvPqeszB5BO6wBdcbAXNtS5SR1xypVlNj/wphgrw=;
        b=eSPbH2HF86IK1D8xyAWd3Ovr2ycC0AcFUKNWOZcBC7qp+vLwsA97BUZ3KfVyXbVC9p
         vDx3XsshlSGuxXN3WScaHxPkhH4Ud9O3lhukKuWXUJ05bq83I+goEWEA9GE1rxlgFAkk
         dGS893+LHGQpdEgeGjcz3LY/IOvgE0yLCj8g/1zim8teEytw2FatCO/Q13MOihQMVPBm
         IUAz69eiXGdSvhfyiF3l9rjKjWDNKVm/p17230CpaFrcZru/O2IaeupIN5n/UnJ69xU7
         3fS2671NL2ztAaki1duaoRJ8PWiPlZq4Q2H4PwkbtFQhiFveIRPghWQZZATtpoBTNEFi
         5wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783648666; x=1784253466;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNnnvPqeszB5BO6wBdcbAXNtS5SR1xypVlNj/wphgrw=;
        b=Z2wIvZ8mV/VzgQszP+HOVLJM6aPNJV2cNen9g34K2d8N5UkqJKFnp6Arh2dkrDt7Lg
         rzowIEkQdd3y2IjYVkpjIkx0paOfSZsnI1cFZ5n3VXiP2sUraXiEr9BL1xOj/oxrYKnG
         eEyAJY8QxHKag50qJMFIPlRQz7jchs6Ft7YfcNx0elmqNS3vhUy7iR6bl+LntNpHLejX
         Kf3MlOHvp8adyrMFYkJVoQIzu/WxWppF7CGdbUk34DHyR6RlimI3CZGe40m4PrbaFHSn
         NyPSKvSQUQ/mDSml/Il06sREXbfvHw87zIs4SotZWaBQYTqXhCgW5GTkx4bO1WEQj276
         W5Fw==
X-Forwarded-Encrypted: i=1; AHgh+RqQLijDft+pJhHMrDS/qs7wlq+B783t5b8uDwoCdPRzs+kSLqGjcaOCEpFDwRYyBssij70XXGRvI3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87Y1Q0tXPKJ4itzHfeigmEb/y+/DdosS89oRDl5B3yBEjL1P1
	78kep2rBu+aNgB4sxqueA5xDFZUFwSrigBqhUhsp9/2TvPE8Dp4+Saf1
X-Gm-Gg: AfdE7cmFLYunJwcUsmY7mBC0Z2pPYE1Y9wg+MpHMzw596D1UlpGlnKnkbIYQ/3ZfakQ
	D3hlxy7DJiR97186S7zVw2v+E5Zy/+zlgBfCm3fP7Wzk2sER9mjjn/jlLMp6Au5zKrF15nA/aRI
	vIQPMQjIKSpxtyb7CGOC08XbaqcdLsqwwB1QzdiIWF0fCqdKqLkjJcq74C+3dOUHhrIYnvVykke
	o96JA+9wL3swtovFOxt/+5fgSlA0h+ZClsOECz426Knw59RHCqnzMr7wwX+yKp0XWwFZVYD7Ygh
	zAQtpCIQJPolHDoH+++nB2Xx+kwjsgkkV3JctutrfYCBJUGADjqwhZVqFiUwM6IphvdKIwEjVQM
	1j8m+PInyNEwGBVOq1GAYJ9CFlOMHuHPOegU2cF6GKRW8KhEFy9XRebyR0L40UxN1
X-Received: by 2002:a05:6a20:1587:b0:3c0:b3f7:e5e9 with SMTP id adf61e73a8af0-3c0bc8c42f4mr11229276637.15.1783648666263;
        Thu, 09 Jul 2026 18:57:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm5608901eec.5.2026.07.09.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 18:57:45 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:57:05 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Bruel <christian.bruel@foss.st.com>, 
	Frank Li <Frank.Li@nxp.com>, Nam Cao <namcao@linutronix.de>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Alex Elder <elder@riscstar.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <alBNXgMAwXPKwiJ2@inochi.infowork>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <ak9KzNFF26B0Kttz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak9KzNFF26B0Kttz@ashevche-desk.local>

On Thu, Jul 09, 2026 at 10:16:28AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 09, 2026 at 12:00:22PM +0800, Inochi Amaoto wrote:
> > The PCIe controller on Spacemit K3 may use multiple PHYs at the
> > same time. The feature is not support by the current driver.
> > So extend the PHY definition to support multiple PHY handles.
> 
> ...
> 
> >  struct k1_pcie {
> >  	struct dw_pcie pci;
> >  	const struct k1_pcie_device_data *data;
> > -	struct phy *phy;
> > +	struct phy **phy;
> 
> Should it be annotated by __counted_by_ptr() ?
> 

Yes, I think it can, this is something I have missed.

> > +	unsigned int phy_count;
> 
> Ah, you allocate much more memory than possible PHYs... Can you redesign and
> use the above annotation?
> 

IIRC use the annotation does not reduce this memory usage...


> >  	void __iomem *link;
> >  	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
> >  	u32 pmu_off;
> 
> >  }
> 
> ...
> 
> > +static int k1_pcie_get_phy_handle(struct k1_pcie *k1, struct device_node *node)
> > +{
> > +	const struct k1_pcie_device_data *data = k1->data;
> > +	struct device *dev = k1->pci.dev;
> > +	unsigned int i;
> > +
> > +	k1->phy = devm_kmalloc_array(dev, data->max_phy_count,
> > +				     sizeof(*k1->phy), GFP_KERNEL);
> > +	if (!k1->phy)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < data->max_phy_count; i++) {
> > +		k1->phy[i] = devm_of_phy_get_by_index(dev, node, i);
> 
> > +		if (IS_ERR(k1->phy[i])) {
> > +			if (PTR_ERR(k1->phy[i]) == -ENODEV)
> > +				break;
> > +
> > +			return PTR_ERR(k1->phy[i]);
> > +		}
> 
> 		if (PTR_ERR(k1->phy[i]) == -ENODEV)
> 			break;
> 		if (IS_ERR(k1->phy[i]))
> 			return PTR_ERR(k1->phy[i]);
> 

Yeah, this is more clear. Thanks.

> 
> > +	}
> 
> > +	k1->phy_count = i;
> > +	if (k1->phy_count == 0)
> > +		return -EINVAL;
> > +
> > +	return 0;
> 
> This doesn't seem correct to me, I would expect phy_count to be assigned only
> when it's valid. (Yes, perhaps 0 is the same as it was, but semantically it's
> different 0 in this case.)
> 

I guess you think 0 is a valid number? I can not understand what you thing
Assign this to 0 if there is no phy is fine to me, which shows there is 0
vaild phy found.

> See also above. Do we have some PHY API that just counts provided PHYs?
> If not, that what you should probably add first, before this patch.
> 

I have not found any api for this. But the actual problem is, how the api
is designed. I have checked both the array bulk api for reset and clock,
it seems like it is much more than this patch...

> > +}
> > +
> > +static int k1_pcie_enable_phy(struct k1_pcie *k1)
> > +{
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	for (i = 0; i < k1->phy_count; i++) {
> > +		ret = phy_init(k1->phy[i]);
> > +		if (ret)
> > +			goto err_phy;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_phy:
> > +	while (i--)
> > +		phy_exit(k1->phy[i]);
> > +
> > +	return ret;
> > +}
> 
> ...
> 
> > static void k1_pcie_deinit(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >  	struct k1_pcie *k1 = to_k1_pcie(pci);
> 
> > +	int i;
> >  
> >  	/* Assert fundamental reset (drive PERST# low) */
> >  	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> >  			PCIE_RC_PERST);
> >  
> > -	phy_exit(k1->phy);
> 
> > +	for (i = 0; i < k1->phy_count; i++)
> 
> 	for (unsigned int i = 0; i < k1->phy_count; i++)
> 

I agree with the unsigned int, but I guess this definition is not
allowed in linux.

> > +		phy_exit(k1->phy[i]);
> >  
> >  	k1_pcie_disable_resources(k1);
> >  }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Regards,
Inochi
