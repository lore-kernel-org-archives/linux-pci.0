Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC9371877
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783841312; cv=none; b=LU5+dwGsUpOB65wF6b+SGIQmRNvnvpUEMpglF26t9kkHu7PuHte0CvUUSPDH8TBkz3EtB9J/DsCUJUUNztpQfhvJ8baO0TiK+P5PLQs8f1RJashKQHvd1O7h2RgroWRT5KJqPvPbapakro0xnvVeoI5Tzf9uqH59O39dR/mA4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783841312; c=relaxed/simple;
	bh=PENQv930pgF3/GZ3y57oKUkMIVU5lq28nO0YYnhTHQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMTKIwGVVDLWLUF8a5UYYhrdwX44yv8sXy6bEHlyJXyY6x7IST7P2copUembKXW3g/2HtVfoTc0xpTu7LnSvHtRNZUJIUnyN9/wbkz/FOM5ark4wOXhgbLKTImMgWHdNrPfwLCslplWWnwZPOAXIB3OW5MisSFpc5GAriqs8w8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkiQnNTQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkiQnNTQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso21945365ad.0
        for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783841310; x=1784446110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lJkGlW1PNIgDL2QJ4YXVngoWTLt4PyzuUrEHmd42bds=;
        b=lkiQnNTQq6V4RLT+pnjGSCy7ooSaj7y3PCYOh91wlqOlJMnWq9pq9mf7h/u2IcoaqR
         bOFiSTssGHTZ43LDee0CxwANGJFqhJS9FOZx+56M85ntCpNMhfBv+sf7hkhBPLutBpRT
         7p5dNH6ppGXAmx0W4/4VusScFSK99/oj3wsmNj4xJgV0tMVxHDbxXELAvWt+Gv0HU1Ws
         u23v034mC9PzQEtBfzbPk+H3+Ol5DvforzmWCOOiowASYCATZDCsUWMWYKb0LvPjGlAz
         bE/g+VcPUpFm3F1wOsSGXzf49K0+OVI7tACEb5WBBR77qZM380MFbhZEO5F6QFx9Bdg7
         ZzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783841310; x=1784446110;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJkGlW1PNIgDL2QJ4YXVngoWTLt4PyzuUrEHmd42bds=;
        b=dRaqjNhuxCojyHW9IFvh3wD0BW4kvYfQ2d5OfiufEtPvhzQKoAdhN/y/0ve1/NHjiH
         hp2NR5NyG2kJjfmf/b0NmtwBj4NrAiQYsw4LbhARPKS+3gmiFNbalciuqQ28pZ+EBneK
         wIF+3Nm20YA6UbKHUxylofglxem7LrR6IVn10YQ9ripPl4U2e2cOKotblROjIK4rr7xu
         ny/6uoQ/7/gtnKzwXrX3/99dB/hJ5GWfYoe6GKSwt/lZi0N8zdByDLQwrkDN5y6XYIXY
         6T9b4UMJkPcR6sTZIzvvextlLWvQHLEAHfyi+KJA/pFG/rToZlsJ5JTaVVS/2hBrfka5
         XQ4w==
X-Gm-Message-State: AOJu0Yzh2MXqFs/7B/TdgrYzRg2Ynv88zQObDtWMLFwpZqXQMzin5Uip
	feeQzsVgySP7LLL00hWTzUjKUacpbjleBC/Fdo+shYKzFPCyJmZydFQw
X-Gm-Gg: AfdE7cmuIxy/i1eymEH7vLQYa9+BchPGaX+kXT7TymJUakBOkH+j5u/4BZmeqS1/bkN
	QC3V4o7RWzWT3bcWp+7wKH73M4ezKLZVK/ZemoWs2znge9uwJmJdtKgylcBtn97oBMaruSn8DY2
	qJbUu+m6GCzajlZmbyuid5in3Ekw0nAfdaLJf1c6WcyxjK3xQc9JdJoo1RMBYRa4kXX4D3NukQ1
	g5wo/7r5GNHobxaHpfhaFoH6J/XzbrUH1h3qVWAGtcGVinZ2tcWaCMhkc7F+mYP6ou/ahZYaRmM
	Zc2AF5BjCxidjRlPRw3cgGk8SS5Yu7hxnrOpW+Sh0ACr356ZyeF+afFgXjDDx3oP0kbWr6c6RXU
	BPp4YQEVvl1SsSqt9pVDdNvc0RLrIGyUmPwWrHkcdcRIqex0Hptk/gPLZoLe0zVgK
X-Received: by 2002:a17:903:1b08:b0:2ca:17a8:cfce with SMTP id d9443c01a7336-2ce9f2852b2mr53150225ad.29.1783841310195;
        Sun, 12 Jul 2026 00:28:30 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c25fc0sm82771295ad.36.2026.07.12.00.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 00:28:29 -0700 (PDT)
Date: Sun, 12 Jul 2026 15:27:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alex Elder <elder@riscstar.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Christian Bruel <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>, Nam Cao <namcao@linutronix.de>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <alNA03enTCy0RNAt@inochi.infowork>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <7e8cc486-8d0c-4bb0-ada9-fb4dd53e53e8@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e8cc486-8d0c-4bb0-ada9-fb4dd53e53e8@riscstar.com>

On Fri, Jul 10, 2026 at 11:01:23AM -0500, Alex Elder wrote:
> On 7/8/26 11:00 PM, Inochi Amaoto wrote:
> > The PCIe controller on Spacemit K3 may use multiple PHYs at the
> 
> s/use/uses/
> 
> > same time. The feature is not support by the current driver.
> 
> s/support/supported/
> 
> > So extend the PHY definition to support multiple PHY handles.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 70 ++++++++++++++++---
> >   1 file changed, 59 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > index f6ae8ff3589a..e22ecbd09579 100644
> > --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > @@ -55,12 +55,14 @@ struct k1_pcie_device_data {
> >   	const struct dw_pcie_host_ops *host_ops;
> >   	const struct dw_pcie_ops *ops;
> >   	int (*parse_port)(struct k1_pcie *k1);
> > +	unsigned int max_phy_count;
> 
> Is the name "max_phy_count" meant to suggest that there
> could be fewer "actual" PHYs than the number provided in
> this field?  If not--if it is simply "the number of PHYs
> this platform uses"--then just call this phy_count.
> 

Yes.

> >   };
> >   struct k1_pcie {
> >   	struct dw_pcie pci;
> >   	const struct k1_pcie_device_data *data;
> > -	struct phy *phy;
> > +	struct phy **phy;
> > +	unsigned int phy_count;
> 
> If this is always the same as what's in data->max_phy_count,
> you don't need to replicate the value here (since you're
> also keeping the data pointer in this structure).  (But it
> looks like it might be less than max_phy_count.)
> 
> I believe I suggested making this structure use a flexible
> array member for the PHYs.  If that's possible, it should
> go at the end of the structure, and the way you allocate
> it needs to change.
> 
> >   	void __iomem *link;
> >   	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
> >   	u32 pmu_off;
> > @@ -119,6 +121,54 @@ static void k1_pcie_disable_resources(struct k1_pcie *k1)
> >   	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
> >   }
> > +static int k1_pcie_get_phy_handle(struct k1_pcie *k1, struct device_node *node)
> 
> I would call this k1_pci_get_phy_handles() (or perhaps
> just k1_pci_get_phys()).  Or even k1_pci_phy_get_all().
> The name you have seems like you're just getting one handle.
> 

OK, it is good for me.

> > +{
> > +	const struct k1_pcie_device_data *data = k1->data;
> > +	struct device *dev = k1->pci.dev;
> > +	unsigned int i;
> > +
> > +	k1->phy = devm_kmalloc_array(dev, data->max_phy_count,
> > +				     sizeof(*k1->phy), GFP_KERNEL);
> 
> Use kzalloc not kmalloc.  Even if you're initializing all fields
> now, a future change might not (and in that case having it zeroed
> is safest).
> 

Thanks.

> Also, if you find fewer than max_phy_count PHYs, I think it
> would be better to only allocate as many needed.  If you
> used a flexible array size, you would need to count the
> number of entries before allocating it.  It would require
> changing the structure a bit--providing a single function
> that would allocate the k1_pcie structure after doing that,
> and most likely initializing the phy array within the same
> function.
> 

Currently, it does not know the phy number before parsing,
the only thing we can is to parse this twice. I think it is
kind of unnecessary.

> > +	if (!k1->phy)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < data->max_phy_count; i++) {
> > +		k1->phy[i] = devm_of_phy_get_by_index(dev, node, i);
> > +		if (IS_ERR(k1->phy[i])) {
> 
> If this returns -ENODEV, you are done getting PHYs.  So
> max_phy_count could be more than the "actual" number.
> 
> Is that reasonable?  You indicate that at least one PHY
> must be found below, but is it OK for a platform to
> define fewer than some expected number of PHYs?
> 
> (Maybe it is.)
> 

Yes

> > +			if (PTR_ERR(k1->phy[i]) == -ENODEV)
> > +				break;
> > +
> > +			return PTR_ERR(k1->phy[i]);
> > +		}
> > +	}
> > +
> > +	k1->phy_count = i;
> > +	if (k1->phy_count == 0)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int k1_pcie_enable_phy(struct k1_pcie *k1)
> 
> I would call this k1_pcie_enable_phys().  But actually,
> because what you're calling within this is phy_init(),
> I'd probably call it k1_pcie_init_phys(), or possibly
> k1_pcie_phy_init_all().
> 

I will take care of this in the next version.

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
> > +
> >   /* FIXME: Disable ASPM L1 to avoid errors reported on some NVMe drives */
> >   static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
> >   {
> > @@ -174,7 +224,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
> >   	 */
> >   	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
> > -	ret = phy_init(k1->phy);
> > +	ret = k1_pcie_enable_phy(k1);
> >   	if (ret) {
> >   		k1_pcie_disable_resources(k1);
> > @@ -194,12 +244,14 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
> >   {
> >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >   	struct k1_pcie *k1 = to_k1_pcie(pci);
> > +	int i;
> >   	/* Assert fundamental reset (drive PERST# low) */
> >   	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> >   			PCIE_RC_PERST);
> > -	phy_exit(k1->phy);
> > +	for (i = 0; i < k1->phy_count; i++)
> > +		phy_exit(k1->phy[i]);
> 
> Please create an inverse of k1_pcie_enable_phy(), like
> k1_pcie_disable_phy(), to encapsulate this code.
> 

Sound reasonable.

> >   	k1_pcie_disable_resources(k1);
> >   }
> > @@ -266,23 +318,18 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
> >   {
> >   	struct device *dev = k1->pci.dev;
> >   	struct device_node *root_port;
> > -	struct phy *phy;
> > +	int ret;
> >   	/* We assume only one root port */
> 
> Maybe you could get and put the root_port within
> k1_pcie_get_phy_handle(), since that's the only
> place it's needed.
> 

I think it is better to not do that, it is better to keep the function
do the thing as it claims.


> 					-Alex
> 
> >   	root_port = of_get_next_available_child(dev_of_node(dev), NULL);
> >   	if (!root_port)
> >   		return -EINVAL;
> > -	phy = devm_of_phy_get(dev, root_port, NULL);
> > +	ret = k1_pcie_get_phy_handle(k1, root_port);
> >   	of_node_put(root_port);
> > -	if (IS_ERR(phy))
> > -		return PTR_ERR(phy);
> > -
> > -	k1->phy = phy;
> > -
> > -	return 0;
> > +	return ret;
> >   }
> >   static int k1_pcie_probe(struct platform_device *pdev)
> > @@ -358,6 +405,7 @@ static const struct k1_pcie_device_data k1_pcie_device_data = {
> >   	.host_ops	= &k1_pcie_host_ops,
> >   	.ops		= &k1_pcie_ops,
> >   	.parse_port	= k1_pcie_parse_port,
> > +	.max_phy_count	= 1,
> >   };
> >   static const struct of_device_id k1_pcie_of_match_table[] = {
> 

Regards,
Inochi
