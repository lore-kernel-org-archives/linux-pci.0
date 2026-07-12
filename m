Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD9371D13
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783841977; cv=none; b=RN6tlgMQksE5rZw99nlshnO2PlDUvmmPASQqMWMb70rrWB7vSPNm2+W5N4MehFkw7oOZ8lHrv1WYr3sUYl2JaI7aaxUt5t6aJbYewE7ytejFbsIJeC2VnSFDRo9IgP+nU6nbeSEk40v5g/mXBaPpcbhWsACwkILx2nbe5ZFvqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783841977; c=relaxed/simple;
	bh=fAvTWsD9sw32WdUtuhGi8/HFepILucEW6Mr5vR3sUUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkLdUl46bCK7UDxDU9HxJPagNImY42He18kVgnX8bDcevV24ceWR5+xvtyQwJd4sWojSBEz/LLZQ+eWm5GlY1KfBuo3RoE0l46135wAcf3XuxpKISBvPSwuMxaqhGLrtb2i+//1Oe56nosXpUXwUI9nfRtqn7qg1cYwC7I++f1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN7tBUf4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN7tBUf4"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38deea72eebso114748a91.1
        for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 00:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783841976; x=1784446776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eu7dHrjo+8poscG/MBw9L5sZo7bmfQR/ckNZrU5PQs=;
        b=AN7tBUf4NqPN83MpMU81a3Ld6ZrAnePqB/Yi3CYpJHa2jqgZAe2prfl+lP6zRqq1r7
         snY2SeiRfQfz1R2cQhfUsopPsazRng8zwKDe1+088pBH2XkoRzewTY4Q9lbWL1v6yFG5
         qBXbyTVEFpjfQxpYH7Uyh+uyHYtcBuyIDw9lCOTX2yp+RiRlIABsy2D+trfH1nEblFM8
         QnX9iTwCo0u9P68SQFrQhdN+EKaJQp1cnBj2xKd2YKa2oHgoTI0NpxZxwIn9j09dtEm1
         Waq6rtWg1XXyXfbh177V0iIY1fCTMjtIzIyAFZHsQ6arXv+Z7v2b8/YDpui51QwLG8V0
         0oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783841976; x=1784446776;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eu7dHrjo+8poscG/MBw9L5sZo7bmfQR/ckNZrU5PQs=;
        b=D2tMRhxyPwWdAAsT7nQXSO8sFLx1UFL0Sb3oOZef3VozhZ22JS7yRz/5ABBeX/M2i9
         djJ+BIMAWUu9KGQ2NsSknJtL1lVKv4thwwVPyEh1dEdlKV/J9e9mmAGcFQiNx7IyKnTu
         ZIwpud8g91tIBlVP+1Z8BSQnnmkMaiv8TJe5Tci04tAb2dDGo8uIS/NKu7CsIjWY37Ub
         UvY2WLSd8Bnl0Vf94eMTSCEDYdyMWb3qbfI1h1AwpqP/0fQ7pjsGSF/d1gdC83UdvvtO
         2OwWhtyVWG2QTUIqPCa7+rsv4r/fshHODsTO3BXiE/4L7Ptiunfd0RgXXIIni9SuUoGK
         kDbA==
X-Gm-Message-State: AOJu0Yy4GKsl48DnZJpU71DecfkK4UeR0v78zL1tGjpQq/DLqPX2f2cp
	gdQv2Cl3AGGMgpigpKQdHoUwMggxf+i6C5ruHf25CM0AqfEo9bWpXoI4
X-Gm-Gg: AfdE7cn9sa4k5dl/ygAEhF/Lo3csI3m3X9Y6S9Ur+npB40mKUO8clLTgkKHTF2MP4zx
	XklxFPa3lePBzfpBHMkRLWwbbI9aJVV429hi2TQ85ixwZbPBVY56q1U/nokHPkt/akW4YMb5ux6
	vlse1KWhkwN9aaQa93rnvag1y1oPQikPcR9Z51CbvkPjKJkwBhOhIiCooMTXlF1SgYryWeVXv8j
	r1OevGmzMIaiVfQVaEct9zvah58XoMynNycniN3W/aX6trxW+It/g9Iw8YwTCEDmqDVypZ0XUcN
	D1RccIpqXZZ1eRAXVRn43lHzjydVSIwQWxuJOp3PLhBaBxK3sXIaoTp5nmdslYnKonpfvE1UGyK
	K4fsLIqI5GO2yuULmtWWXQZS4PURKrm3fuBWqyzrY0E7VAle7DcnIH932AKa6tQqo
X-Received: by 2002:a17:90b:390f:b0:387:df8f:1406 with SMTP id 98e67ed59e1d1-38dc77ce51amr4336096a91.39.1783841975574;
        Sun, 12 Jul 2026 00:39:35 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5516ad85sm4803452a91.2.2026.07.12.00.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 00:39:35 -0700 (PDT)
Date: Sun, 12 Jul 2026 15:38:51 +0800
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
Subject: Re: [PATCH v4 1/6] PCI: spacemit-k1: Add device data support
Message-ID: <alNDI8JVUuhpJblo@inochi.infowork>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-2-inochiama@gmail.com>
 <338687f9-e80e-40e8-b14e-1218e61e4e0c@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338687f9-e80e-40e8-b14e-1218e61e4e0c@riscstar.com>

On Fri, Jul 10, 2026 at 11:01:16AM -0500, Alex Elder wrote:
> On 7/8/26 11:00 PM, Inochi Amaoto wrote:
> > To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> > data to handle the K1 specific logic and make room for the incoming
> > logic for K3.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> 
> I have two suggestions/questions, but I think this looks
> good overall (please add the space that Andy suggested).
> 
> If you drop the data field in the k1_pcie structure you
> can keep this tag:
> 
> Reviewed-by: Alex Elder <elder@riscstar.com>
> 
> > ---
> >   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 30 ++++++++++++++++---
> >   1 file changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > index be20a520255b..f6ae8ff3589a 100644
> > --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > @@ -49,8 +49,17 @@
> >   #define PCIE_CONTROL_LOGIC			0x0004
> >   #define PCIE_SOFT_RESET			BIT(0)
> > +struct k1_pcie;
> > +
> > +struct k1_pcie_device_data {
> > +	const struct dw_pcie_host_ops *host_ops;
> > +	const struct dw_pcie_ops *ops;
> > +	int (*parse_port)(struct k1_pcie *k1);
> > +};
> > +
> >   struct k1_pcie {
> >   	struct dw_pcie pci;
> > +	const struct k1_pcie_device_data *data;
> 
> Is it strictly necessary to keep a copy of the data
> pointer in the k1_pcie structure?
> 
> It can be convenient to do so if you reuse the fields
> in that structure rather than duplicating them, but
> often the constant platform data is meant only for
> initialization, and never needed after that.
> 

In fact it is not, I think it is fine to remove it.
Recording this is more like a habit for me for the
future usage.

> >   	struct phy *phy;
> >   	void __iomem *link;
> >   	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
> > @@ -278,14 +287,21 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
> >   static int k1_pcie_probe(struct platform_device *pdev)
> >   {
> > +	const struct k1_pcie_device_data *data;
> >   	struct device *dev = &pdev->dev;
> >   	struct k1_pcie *k1;
> >   	int ret;
> > +	data = device_get_match_data(dev);
> > +	if (!data)
> > +		return -ENODEV;
> > +
> >   	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
> >   	if (!k1)
> >   		return -ENOMEM;
> > +	k1->data = data;
> > +
> >   	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
> >   						       SYSCON_APMU, 1,
> >   						       &k1->pmu_off);
> > @@ -299,11 +315,11 @@ static int k1_pcie_probe(struct platform_device *pdev)
> >   				     "failed to map \"link\" registers\n");
> >   	k1->pci.dev = dev;
> > -	k1->pci.ops = &k1_pcie_ops;
> > +	k1->pci.ops = data->ops;
> >   	k1->pci.pp.num_vectors = MAX_MSI_IRQS;
> >   	dw_pcie_cap_set(&k1->pci, REQ_RES);
> > -	k1->pci.pp.ops = &k1_pcie_host_ops;
> > +	k1->pci.pp.ops = data->host_ops;
> >   	/* Hold the PHY in reset until we start the link */
> >   	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> > @@ -320,7 +336,7 @@ static int k1_pcie_probe(struct platform_device *pdev)
> >   	platform_set_drvdata(pdev, k1);
> > -	ret = k1_pcie_parse_port(k1);
> > +	ret = data->parse_port(k1);
> >   	if (ret)
> >   		return dev_err_probe(dev, ret, "failed to parse root port\n");
> > @@ -338,8 +354,14 @@ static void k1_pcie_remove(struct platform_device *pdev)
> >   	dw_pcie_host_deinit(&k1->pci.pp);
> >   }
> > +static const struct k1_pcie_device_data k1_pcie_device_data = {
> > +	.host_ops	= &k1_pcie_host_ops,
> > +	.ops		= &k1_pcie_ops,
> > +	.parse_port	= k1_pcie_parse_port,
> > +};
> > +
> >   static const struct of_device_id k1_pcie_of_match_table[] = {
> > -	{ .compatible = "spacemit,k1-pcie", },
> > +	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data},
> 
> In addition to the missing space that Andy mentioned,
> adding a comma means the line won't need to change
> when you add another entry to the array.
> 

I do not think the comma has this meaning in this scene. It is
weird to wrap in the device table when having enough space.
Further more, this line must be changed for the last "}", so
it always require a change for adding data.

> >   	{ }
> >   };
> 

Regards,
Inochi
