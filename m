Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF24D488F;
	Mon, 21 Sep 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008297; cv=none; b=AdMDV69n6tnKTgnaJMmBphqliVLFJD0C0TLnPJ2u5qHn7WXnEJ1RKV91jNaqwj9GloIYFEn7K+rFjCRbEmVmI0BsmO7su9dFpty3dkiiHpVZYzcmX3grWjK0jnxmp+0oaFsFkkkuaxbZn0a1itg9TgN0ZFKIV0coCGkcUQ2tR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008297; c=relaxed/simple;
	bh=topJIHAcFcucgIIom/s6JhB/DOjnjHOXAk1hYRfIgNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPuQ6Px0LKuVwM4b3uu120bV5Oj3pZ9eMTRHhBEfX0c2lcvAewP3WwXx6PQCE4I7i5RNTqNhfUL8LgAYvhvB8i8/UfLNMDh1Yh0u5RIqLOxceueZEbDhQ7938Mla9TI93XzD75HS+hhZnx7ai9nMuosX5eIYP5+VWrM5zvqX0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nn7Sd1Q1; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nn7Sd1Q1"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hpTJG1wCYz8v1k;
	Mon, 21 Sep 2026 18:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790008286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I066lHB93h8dqTHWVqvnXC/UNI96ZDGINkKhm6L02A8=;
	b=nn7Sd1Q1L+wQTqtmh2O/hC1IRD5Q5cZtGyMTVdGow80KJyxYJwY447TM41iio2tvWtKUF1
	a4KyDm52fNktjx5kbuBhOshN/s0yjdr+vJYpEGqrmGPlqP/RAiEe+N6TFgZDiQUyyM+Mqc
	Y9OCKdIIB2uP5HztDOYZkru/Zms61KitY5yzga6Gu2MrzxYv49AtrRlNmRxW/eC4mjuixF
	WbrrOJhohUoarzBG3E9T9VYv9DUqG8AjJk/3EzvXSq/n04ZtTyI03o3AzsUN03ebvyRRiV
	TPZWSKpL7MqjHwFBVkuVHLxAreqHeUXgjl5lJaS6LxE/TW2OvoHqcOW1PunADQ==
Message-ID: <67ab9f01-069e-4010-8f5e-7f65bf30ebd6@mailbox.org>
Date: Mon, 21 Sep 2026 18:31:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/6] PCI: dwc: rcar-gen4: Handle PERST via reset
 subsystem
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-6-marek.vasut+renesas@mailbox.org>
 <zwdqspl2uno35uffgzsel57ed2umpejgfeqrkwvxiqd2pgfpm6@h6w3qsgc6rny>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <zwdqspl2uno35uffgzsel57ed2umpejgfeqrkwvxiqd2pgfpm6@h6w3qsgc6rny>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7de80fa4f7fd47ba824
X-MBO-RS-META: 688b6z6z3h4z4uht9ckk6a8mg3k6fi8d

On 9/21/26 5:46 PM, Manivannan Sadhasivam wrote:

Hello Manivannan,

>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> @@ -99,6 +99,7 @@ struct rcar_gen4_pcie {
>>   	void __iomem *base;
>>   	void __iomem *phy_base;
>>   	struct platform_device *pdev;
>> +	struct reset_control *perst;
>>   	const struct rcar_gen4_pcie_drvdata *drvdata;
>>   };
>>   #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>> @@ -317,12 +318,27 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>>   
>>   static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>>   {
>> +	struct device *dev = rcar->dw.dev;
>> +	struct device_node *root_port;
>> +
>>   	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
>>   	if (IS_ERR(rcar->phy_base))
>>   		return PTR_ERR(rcar->phy_base);
>>   
>> +	root_port = of_get_next_available_child(dev->of_node, NULL);
>> +	if (root_port) {
>> +		rcar->perst = of_reset_control_get_optional_exclusive(root_port, "perst");
>> +		of_node_put(root_port);
>> +		if (IS_ERR(rcar->perst))
>> +			return dev_err_probe(dev, PTR_ERR(rcar->perst), "Failed to get PERST#\n");
>> +	} else {
>> +		rcar->perst = NULL;
> 
> 'rcar->perst' is NULL by default.

Indeed.

>> +	}
>> +
>>   	/* Renesas-specific registers */
>>   	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
>> +	if (IS_ERR(rcar->base))
>> +		reset_control_put(rcar->perst);
>>   
>>   	return PTR_ERR_OR_ZERO(rcar->base);
>>   }
>> @@ -494,6 +510,22 @@ static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
>>   	return 0;
>>   }
>>   
>> +static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
>> +{
>> +	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
>> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>> +
>> +	gpiod_set_value_cansleep(dw->pe_rst, assert);
>> +
>> +	if (!rcar->perst)
>> +		return;
>> +
>> +	if (assert)
>> +		reset_control_assert(rcar->perst);
>> +	else
>> +		reset_control_deassert(rcar->perst);
> 
> So the controller will only have one form of PERST# implemented at a time. Even
> though this code is technically correct, it also gives an impression that both
> form could co-exist.
> 
> So I'd recommend using:
> 
>          if (dw->pe_rst) {
>                  gpiod_set_value_cansleep(dw->pe_rst, assert);
>          } else {
>                  if (assert)
>                          reset_control_assert(rcar->perst);
>                  else
>                          reset_control_deassert(rcar->perst);
>          }
> 
> to makes it clear that only one form of PERST# is supported.
> 
> I'll implement both of these changes while applying.

Please do. Thank you !

-- 
Best regards,
Marek Vasut
