Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569123;
	b=n8L5Y4GdMJu46CAjh2kggjuoAZmuClBLtofTIgutsy5fSVY6v7vFmTyh9oaWT7nMnT68
	 VO5mNx5Sk8456UXv7b0Ir/WXcnrmx8R+IoQNW36di4PF+DgpEb4CJ9ASMAO/+a6FErqY/
	 fS+FR6wElvoz+i1Vw7Wx5nyfCbs+ErvrqbLV8IbHIC4QBxdxMKDxgtDJR0/HFrL8SKid/
	 vlVyqxHlkgm15czR6PNs3JBI7tTWJ5owEke/+qe9wr8I6V07b07+g5pVhDSUOHfRZpDCa
	 fULfHMtOkXj7gsvdL74fv7RPoLry5FNwA2E2UtfVyNlv1BIrgO0E9thwiU3EeSF1Z1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=wqrxv5Q2RTtnjt7+05qzteet1T1PNZiaTDIMGMTA4x4=;
	b=X6xIJhjrkcGzkTHBlX6DpW0qwQRFWr1vowwumtzzDNSoY9CheOsGSxKw7KoKUB4lSq8H
	 mJS5uxkcBsYOl9KuEAziHyDa45oRl4Gj2JRPeB5SO8Kn3L4vcTiMFfjckzrAYnygyKcad
	 A0wnnvqvJ6vDgeprNd6HpvyopgDAa6j7HwgsgWaC5iV0fMyfBSmVmkdxvL6v5w3qnWciX
	 VwWjYpv4NZ5u0pYV3Atpx4Hz+ABgNE/ucR2Lhhp8fKBYhep4NRD3E34pygryvs3pmoEUn
	 NPzZVcBwMT6A9O4wAebQDFa94krIxtc9UcVZT2xWBucYaFvy3FzO6NtMvaAUQrpPCwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dl3cWGbt;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF3606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 07:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FF3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dl3cWGbt
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070755c8cso199579b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792569122; x=1793173922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqrxv5Q2RTtnjt7+05qzteet1T1PNZiaTDIMGMTA4x4=;
        b=Dl3cWGbt7PByiH5Gy0or91Cs6az0Q8L4qaP0166Uwyz/aYwOiCPXvcE5eyamjstWGK
         7Bd4EkdEcbDheUu6IS6Q4f5AU9DIU12ejarYY4dRgWhOiR74si8DNPypEtUPIbFsuLS7
         qFE5JwOiKZRhK7wDOBdLrpnRJLccQo7gH1iLpgqFheu0JkbfchtOYNvAYYKSSb+UZm3S
         rf1X1gWbqS21bE0WvpKHlZTi5kOTU8ZCULACoEb0SD+NFklhvI9mGh4KGNKki9+yuSPR
         RbE533gedaAhbYCNvbNVIsAxOMZIaQqNXM7//SELGHqtHk9eyhwMxi2VZ0SVW0lQ+kHu
         Pnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569122; x=1793173922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqrxv5Q2RTtnjt7+05qzteet1T1PNZiaTDIMGMTA4x4=;
        b=NFxXq6QQ0hNEAQSoykHjIbzB2xajmUOa++jvAmdSmkazPVvBC9Qv/xZxsm2KWzMQwW
         mtxWcIfZ+Q2nVXxCVU9l/OqEYdaR0R9JnhwjcdC2BHSIzMYT0pj9/hzyE1YzBs8XOgbg
         ZJWSjJet0VWdPTjMHFV09tLaaq8nSqfL6B1J64WpoCwhRKPGjtMQF3qvZyO0OkIlZ2MB
         +VnaeYHx5V0wL8jBqu5JsvjHrk6PVpT/DLM/6VfGGEhnvz6sI6VErNR+13ffnvyFcYcg
         wTAwszu6JwgiOoYebzSeCZ23ydUMoCSO9RiY7MOJkh9hW/2Dl27kywBdvLpgHVqIHMyx
         x7tg==
X-Forwarded-Encrypted: i=1; AKwUvByO5MNJLqr7ZYHmlAvjoOQTnRGSuM+srtdCvo9HdioUm1jDiXsXkKvSLVnyb6m5a/Nz6jATquPs0Bg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZu7nhyjfDi+4CeBcg0CjUoEtdQ3x6ozu+Dab/+rDbbgemhIWZ
	SQB/Ve+4IjmqVmRxnKDN/lc5XZCWG+MoVweJhLGEZYjEn49V8VZlPFoE
X-Gm-Gg: AYBFou1+UmCURkRsaF6fVPe5JjvGLNdcXF2OlSaF1AzZETcR5nAHfQKAQ9v/CfpMGD4
	LcB2FF4nlLUnCSpj0ubRm+zK+bT9ImhK4raeQVEiz3kTQILzY4/vxaYAA+YK/XM0+BlZxv3/AfH
	2gzAI3CRv9zHvYL5s0dZx3ugZf9XWXmCY3BCyyxxjmPbXwbwL2C3gMPlaIMvi/5p0QYtHbhgRAZ
	q+4ajfu1nHip1BdrCQ58+XUZb6SvigUbGv++sTO/jBFl51lEUyQ4cygdJ6pxS5BDA7VhO9QZurx
	oczyK2MS8C6UWNj0XZWMDX26JWuLiUO9uEzYk62WIIRjNG9ahDsWWMqv7QOIgbsJIo+UUzevHZ6
	pKgUs1kxAmFwKmrCfx/C1De6uwXTiXBKhcVsUgAzbTMhO/vt2b7SNTriKNTGJWPgqyepHtLauWb
	K8IQEQ4ZbCWVlAohs75bGsf3Ko04U2cQ/LNNx4mRgtWdQRuXc73a1ecXm3Wdlu6itYKZrPkGmzu
	U4ZTKT/FLFSb8x5IYLOvjHksGiYKM7DDn7tlMM0uDWGJKDWyCGgnw==
X-Received: by 2002:a05:6a00:a90b:b0:89e:a122:fa28 with SMTP id d2e1a72fcca58-8a089e1f48dmr1074589b3a.12.1792569121569;
        Wed, 21 Oct 2026 00:52:01 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895fb005sm548529b3a.49.2026.10.21.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:52:01 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:51:20 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
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
Subject: Re: [PATCH v7 1/6] PCI: spacemit-k1: Add device data support
Message-ID: <athuYJjPMkrecGm3@inochi.infowork>
References: <20260929083755.458238-2-inochiama@gmail.com>
 <20261019164108.GA2177470@bhelgaas>
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
In-Reply-To: <20261019164108.GA2177470@bhelgaas>

On Mon, Oct 19, 2026 at 11:41:08AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 29, 2026 at 04:37:47PM +0800, Inochi Amaoto wrote:
> > To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> > data to handle the K1 specific logic and make room for the incoming
> > logic for K3.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 30 ++++++++++++++++---
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > index 0564c46e2f48..ab2953ad8f56 100644
> > --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > @@ -45,8 +45,17 @@
> >  #define PCIE_CONTROL_LOGIC			0x0004
> >  #define PCIE_SOFT_RESET			BIT(0)
> >  
> > +struct k1_pcie;
> > +
> > +struct k1_pcie_device_data {
> > +	const struct dw_pcie_host_ops *host_ops;
> > +	const struct dw_pcie_ops *ops;
> > +	int (*parse_port)(struct k1_pcie *k1);
> > +};
> 
> Does the "const" here add anything useful?  This patch suggests maybe
> not:
> 
>   https://lore.kernel.org/all/20260911233541.1650895-2-james.quinlan@broadcom.com/
> 

I am not sure whether the compiler can make use it.
And I have not seen any explaination for why no reason
for that. It is good to have a clarification.

Regards,
Inochi


> > +
> >  struct k1_pcie {
> >  	struct dw_pcie pci;
> > +	const struct k1_pcie_device_data *data;
> >  	struct phy *phy;
> >  	void __iomem *link;
> >  	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
> > @@ -274,14 +283,21 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
> >  
> >  static int k1_pcie_probe(struct platform_device *pdev)
> >  {
> > +	const struct k1_pcie_device_data *data;
> >  	struct device *dev = &pdev->dev;
> >  	struct k1_pcie *k1;
> >  	int ret;
> >  
> > +	data = device_get_match_data(dev);
> > +	if (!data)
> > +		return -ENODATA;
> > +
> >  	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
> >  	if (!k1)
> >  		return -ENOMEM;
> >  
> > +	k1->data = data;
> > +
> >  	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
> >  						       SYSCON_APMU, 1,
> >  						       &k1->pmu_off);
> > @@ -295,11 +311,11 @@ static int k1_pcie_probe(struct platform_device *pdev)
> >  				     "failed to map \"link\" registers\n");
> >  
> >  	k1->pci.dev = dev;
> > -	k1->pci.ops = &k1_pcie_ops;
> > +	k1->pci.ops = data->ops;
> >  	k1->pci.pp.num_vectors = MAX_MSI_IRQS;
> >  	dw_pcie_cap_set(&k1->pci, REQ_RES);
> >  
> > -	k1->pci.pp.ops = &k1_pcie_host_ops;
> > +	k1->pci.pp.ops = data->host_ops;
> >  
> >  	/* Hold the PHY in reset until we start the link */
> >  	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> > @@ -316,7 +332,7 @@ static int k1_pcie_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, k1);
> >  
> > -	ret = k1_pcie_parse_port(k1);
> > +	ret = data->parse_port(k1);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "failed to parse root port\n");
> >  
> > @@ -334,8 +350,14 @@ static void k1_pcie_remove(struct platform_device *pdev)
> >  	dw_pcie_host_deinit(&k1->pci.pp);
> >  }
> >  
> > +static const struct k1_pcie_device_data k1_pcie_device_data = {
> > +	.host_ops	= &k1_pcie_host_ops,
> > +	.ops		= &k1_pcie_ops,
> > +	.parse_port	= k1_pcie_parse_port,
> > +};
> > +
> >  static const struct of_device_id k1_pcie_of_match_table[] = {
> > -	{ .compatible = "spacemit,k1-pcie", },
> > +	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, k1_pcie_of_match_table);
> > -- 
> > 2.55.0
> > 
