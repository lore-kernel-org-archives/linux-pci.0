Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11037189A
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021481; cv=none; b=Q2DXUc9nMgETnk5gf3C1jp37H3WDwjgyPb6gNEzRgh65StXCAEZBTmWhy6+O/sPZbui2j5Hw5efPftXeZ//PnJEgTbie6OwTSQzYdWCrQi4EmAToftGWZhH2G0wgczdwFatZJOlx/O8rVF2Iqr6K7IUlv2C2EBV/VJu5lUtxDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021481; c=relaxed/simple;
	bh=vajmwAHkYJpp+V9wdAFK39zdbCm8lW1fNKUSmD2mbDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrAin6dOXsDdkB8QQf6mvk6vipBxwnwkl706vjf1XWyHz5dIHPdFUhwmm2Pw2NPLAzgW1acC2UOv2Awz4lRnTmDiM6/LWOyeBaQKmmrxuNrr3lJXr0Pm0Hl9k2Y9dBU6U1CJ/FpUpKK5kHqxIyCA/J8fiRYGwFlDaeB2Ji57AOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=FCr+UYj3; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="FCr+UYj3"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-48657fc84a3so5116506b6e.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781021477; x=1781626277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pq2jric+p38fa4KyXkbxPznlex9Z4eaGY3w5MG1zr2w=;
        b=FCr+UYj3JlcORiXtEikV49e/xXRBEqwg5F0IZiUko8ILfBWH70NAnNrGrSrVOgEx7V
         NQaHN8z+H/zXEVXFupDx6DSzE7mpPxrZI6DqRXmt/tS8bZTFsAZMsEOEPlTA2KZTjNE9
         CETVogm9YeOyQLytcnIjN1x1BwBX8CNaQuNM5tPmfUcjT69TGanmXcpt+Uqc441pKMGR
         g2N7h9dyCvrg5fTBfn6uVJZdcwp2qcCSAs6PXlnvodYcAUvF4BuEJQgYiN7M4zoIRFYQ
         9wtLsjUsr4CzBi1uXnMWdXQLEpS4BuHkWLaXGQ9M4dxjstKPoiwtMsVJZ6h6vbIz2xum
         3f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021477; x=1781626277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pq2jric+p38fa4KyXkbxPznlex9Z4eaGY3w5MG1zr2w=;
        b=CQpGTw/zv7TjhPeGD/WyLGEOndeNzmJqQPfGtsihw1p1DjtqrlUHpSY/B80kphDmxD
         KBGi1Kzczg27N620cjymLFPRl5zUhBILW3TPRrdb2LnXR+chLtB6995qYaM507SFpoFk
         QP8sbJ7aRcNcBL3229v2r79mAvhE5FoGpkcuvzd0hSHrVDqMZIkWaElIrwDAJe196r3s
         fgI/b0DxmvDweC7yu3qyaqqGqP56tj+7PZ47fMUN51sXNQDYNZPF0CWj/8bMuhtklpHV
         kWWOi7+LJLXIWbAVcb3s74q894FlBZPBkDiyxi9X/dyLJWLuAgWfHV2fmdepKpq6lecY
         vHjg==
X-Gm-Message-State: AOJu0YxtBM20+Pj00Ddsto9ep6O+F5oZG8rCnZuCou21AHxaIwYoqNZa
	VLV49DKUw1cPK+SiCWlEd4TdnVVvJaK9YLPws9fIySkgLvGFyFBNcXxStbiXSf8DeDQ=
X-Gm-Gg: Acq92OFB784Lzcu/W42tJzSx1qmdO4Tq4HI6oyikgTWE9NmPXW4ZpoWhHADX7J+U2yS
	4EutlgL2c7K8kduBNasgvR9BwvvQE6p1iYCNmB4K6m7bKOdTHkGaDNIYlLRIE9fhBK+zbJVHElh
	alJp75WwjoW9DfsJSTj3IxUQF3mPH0IZKq4cNeuvy7UqM2CKbm0ereb2OICQ/6VBfdNDpJ1Rkui
	QXrYENP2nDUl04eYUIo1XnY1b0gX1foqAPd37ZV9eNwXW2rwmVg2y0LUn7ceX5m9GnTT/vj+FrS
	LpzhQDvhJf6D9ajqbFP8SKlTV8SuHX8E0uRYr6ZibGPeksmQbBtgK4tZ+yuCrDe16eSfGvnZfwH
	5sR9f7Kh0qXcqDS04RMW/xC9xjwJqoCIuhaB3AwoNXaRY2U0D48ulR3MQ1JfImFEOyVTlcqwUVq
	UDgfKflVo1XoLKE6nILXqs1VzYmQE8Nd2ptQ==
X-Received: by 2002:a05:6808:180c:b0:479:db65:8dbc with SMTP id 5614622812f47-486f01d5030mr2399484b6e.30.1781021477577;
        Tue, 09 Jun 2026 09:11:17 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b91f944sm16430240b6e.9.2026.06.09.09.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:11:17 -0700 (PDT)
Message-ID: <433e917b-16e3-4744-a614-6372ef22825c@riscstar.com>
Date: Tue, 9 Jun 2026 11:11:14 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] PCI: spacemit-k1: Add multiple PHY handles support
To: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Christian Bruel <christian.bruel@foss.st.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
 Nam Cao <namcao@linutronix.de>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Randolph Lin <randolph@andestech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vidya Sagar <vidyas@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20260517014841.254085-1-inochiama@gmail.com>
 <20260517014841.254085-3-inochiama@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260517014841.254085-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/26 8:48 PM, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 may use multiple PHYs at the
> same time. The feature is not support by the current driver.
> So extend the PHY definition to support multiple PHY handles.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> index 1b519d49dcc0..7f6f1df31cd8 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -51,7 +51,8 @@
>   
>   struct k1_pcie {
>   	struct dw_pcie pci;
> -	struct phy *phy;
> +	struct phy **phy;

I haven't looked further at this series yet, but do you have
any interest in making this a flexible array of pointers
(counted_by(phy_count))?

> +	int phy_count;
>   	void __iomem *link;
>   	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
>   	u32 pmu_off;
> @@ -171,7 +172,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>   	 */
>   	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
>   
> -	ret = phy_init(k1->phy);
> +	ret = phy_init(k1->phy[0]);

If you're going to have an array you should probably put in place
a loop to initialize all phy_count elements of the array here
(as is done for phy_exit(), below).

>   	if (ret) {
>   		k1_pcie_disable_resources(k1);
>   
> @@ -191,12 +192,14 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>   	struct k1_pcie *k1 = to_k1_pcie(pci);
> +	int i;
>   
>   	/* Assert fundamental reset (drive PERST# low) */
>   	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>   			PCIE_RC_PERST);
>   
> -	phy_exit(k1->phy);
> +	for (i = 0; i < k1->phy_count; i++)
> +		phy_exit(k1->phy[i]);
>   
>   	k1_pcie_disable_resources(k1);
>   }
> @@ -277,7 +280,12 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
>   	if (IS_ERR(phy))
>   		return PTR_ERR(phy);

Andy said something different about this.

But it seems to me you are intentionally allocating an
*array* of PHY pointers, which happens to have only one entry.
But your objective is that you want to allocate an array of
them so you can support more than just one PHY, right?

> -	k1->phy = phy;
> +	k1->phy = devm_kmalloc_array(dev, 1, sizeof(*k1->phy), GFP_KERNEL);

Probably should use the kzalloc variant.

> +	if (!k1->phy)
> +		return -ENOMEM;
> +
> +	k1->phy[0] = phy;

I think what's wrong is the above assignment.

If you are truly allocating an array of PHY *pointers*,
then you need to also allocate the phy structure that
each entry in the array points to.

The above assignment is erroneously assigning the first entry in the
array to point to the array, and not a new entry.

					-Alex


> +	k1->phy_count = 1;
>   
>   	return 0;
>   }

