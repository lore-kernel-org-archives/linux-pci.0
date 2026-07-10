Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAA43B3E6
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699286; cv=none; b=lwEvVyB7F8dQaFct8fNJj95c2qtqP+dysn9zm6sddndlp/t5ekGCesMlmAhMCTbRcrG1GcrcVt7IP02hpjgrh7kPqDwGZYifHceix9XItHTtgcpIQweASI2vRhWG02kjI2tu3j9J4Wx9P5bvYMPqmPR3Y/plUVUfPNr+stMjt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699286; c=relaxed/simple;
	bh=uLPdwznAA16rRBewYyJb6MPaGc4jA+si+tOg5Gq5fas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cttkAImFa4hjJnuLTpnn8KeE2vzEvL68nv7ZPMQvYBUKXhLFGORiHVn+H9N1oeMyUjSJU8fyw7JzJ9H+B4h+frQn7E5ZsTbhSOeOc2h0WPumwgpA2CX7jQtWPyRcxXQsVX77a3/+Ws0UYZdpcOXyvEHwGFOPPR8CNFhbSsuM7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=eeAGLQYu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="eeAGLQYu"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-809b19a7f25so17079107b3.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783699281; x=1784304081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hTfHUanZhIXs0ZjukXO0cd1RP2eKmvIle5TeFGqJ2E=;
        b=eeAGLQYuJ4vka6TfcQh4UHsghaBRYcGSOxj/YmbMhPNh+TQnfR3LJ9RvbB1LUpiFBx
         et/01zbqBRmupbSEHve5DtRs/fUC+L2mwRl9lYTfB6YaD4fAjKBPqYVZrw2rtRqFFfVG
         HzzW7P0aIa4wCW0U12b2zB65FKrIVhYrmlrgLoWIKj41CIVPmh8rvhJfMia3aXynIgky
         chgBIMX1vtnYjkeH6MuViBzT0DCCdARk9DzpQqUVex19HyZsO46j+24mixTy2VB8769M
         vnuNkrPlrIKnx0J/8qhMNQEsj8YZlmcKZaPwnh7UJlFFyCofxN3NvqklY/wiYKySpoo6
         JfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783699281; x=1784304081;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1hTfHUanZhIXs0ZjukXO0cd1RP2eKmvIle5TeFGqJ2E=;
        b=gK0jTR/OJdgXvcLJqJwtQxq6lvs8j0x+BL7v+R8pUabMpeKDWp0iBaU2ItY+2Qv53t
         D9yJBBmFLkZJH+7cRuRWx6QCOCpAzQjvDfpWHaVYzCjz50Jq7cOdMu13luHU4zYb/n/M
         Wv0h+dqYXQvnhM9725IahVLo1hFeRRo5OTQ/QkmIRB/IaEBGA0At3URpJZ9EG0V3iB9H
         g7xL4cfJYcdwb/VfLtza/jlUbDFtIoGIF+S2X0SPkJzoZovfk5FwAdenAiMdAVhaFd3k
         +lTgRK1aQkn6cO0mZOQLf4UQ9/O9+Zm+ldxD8QUD4btJZrfH/ztwhIU1EPuwIRY0StvV
         HXyg==
X-Gm-Message-State: AOJu0Yyt8yxxmtbPLF5AdTJ6+4cBEkBVg2IiS/hrFzOgXRhhQvFPUneR
	h4vcU9lnVUoEpEP38gmkkidQ6IhkLTR+7DJ3IJn2KOPABzqF9NLw+dQCfUJIjmCaL44=
X-Gm-Gg: AfdE7clcR7f14GjSAxp5D8PS6eyNckxGZHrJ7L7pflRUcwJl6UpED7m8mVCKIgyC6qF
	AciDbPXhas5lX42kjPmb5Dl2WNwar4WmwZHSWjKThsRDWNrKFTQs5mvt/2Mk8Jy22Z78GGlyChq
	958GhIj9QGjqjqRMkTsNAbjMutirLqmjv+Ofbb68xQI/P13v0ozi9gYwphG+2ypfFyPsMLJw4do
	6oUOa6eFLLsiNXh9bGiq/QDszgLkbff+D2s5uyT7jsYzP/EMs91Vp6ExWHQAur2EMx0bpW3H7eq
	SDrfr5pB62r8Uqv3Ot6jxPcsu8uFkCp6bI1/z4K7gU1qoV+VrBltxcIaWRNWu0vcWazPbfw7yEq
	qqZDDNM/ZszKADH20oK1/Xasg5uWJqsjGfCrYK/rxPLlhXSJH4VpBEN1upX+NMkHbH6Q97xUZaE
	YRbGmD+WzV4+J5r2hxE4Gta14=
X-Received: by 2002:a05:690c:6384:b0:81e:8112:c5c9 with SMTP id 00721157ae682-81e8112ef15mr20197907b3.3.1783699280936;
        Fri, 10 Jul 2026 09:01:20 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9036e27f765sm8965376d6.11.2026.07.10.09.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 09:01:20 -0700 (PDT)
Message-ID: <338687f9-e80e-40e8-b14e-1218e61e4e0c@riscstar.com>
Date: Fri, 10 Jul 2026 11:01:16 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] PCI: spacemit-k1: Add device data support
To: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Christian Bruel <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>,
 Nam Cao <namcao@linutronix.de>, Qiang Yu <qiang.yu@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Xincheng Zhang <zhangxincheng@ultrarisc.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vidya Sagar <vidyas@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-2-inochiama@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260709040027.958400-2-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 11:00 PM, Inochi Amaoto wrote:
> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

I have two suggestions/questions, but I think this looks
good overall (please add the space that Andy suggested).

If you drop the data field in the k1_pcie structure you
can keep this tag:

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 30 ++++++++++++++++---
>   1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> index be20a520255b..f6ae8ff3589a 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -49,8 +49,17 @@
>   #define PCIE_CONTROL_LOGIC			0x0004
>   #define PCIE_SOFT_RESET			BIT(0)
>   
> +struct k1_pcie;
> +
> +struct k1_pcie_device_data {
> +	const struct dw_pcie_host_ops *host_ops;
> +	const struct dw_pcie_ops *ops;
> +	int (*parse_port)(struct k1_pcie *k1);
> +};
> +
>   struct k1_pcie {
>   	struct dw_pcie pci;
> +	const struct k1_pcie_device_data *data;

Is it strictly necessary to keep a copy of the data
pointer in the k1_pcie structure?

It can be convenient to do so if you reuse the fields
in that structure rather than duplicating them, but
often the constant platform data is meant only for
initialization, and never needed after that.

>   	struct phy *phy;
>   	void __iomem *link;
>   	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
> @@ -278,14 +287,21 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
>   
>   static int k1_pcie_probe(struct platform_device *pdev)
>   {
> +	const struct k1_pcie_device_data *data;
>   	struct device *dev = &pdev->dev;
>   	struct k1_pcie *k1;
>   	int ret;
>   
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
>   	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
>   	if (!k1)
>   		return -ENOMEM;
>   
> +	k1->data = data;
> +
>   	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
>   						       SYSCON_APMU, 1,
>   						       &k1->pmu_off);
> @@ -299,11 +315,11 @@ static int k1_pcie_probe(struct platform_device *pdev)
>   				     "failed to map \"link\" registers\n");
>   
>   	k1->pci.dev = dev;
> -	k1->pci.ops = &k1_pcie_ops;
> +	k1->pci.ops = data->ops;
>   	k1->pci.pp.num_vectors = MAX_MSI_IRQS;
>   	dw_pcie_cap_set(&k1->pci, REQ_RES);
>   
> -	k1->pci.pp.ops = &k1_pcie_host_ops;
> +	k1->pci.pp.ops = data->host_ops;
>   
>   	/* Hold the PHY in reset until we start the link */
>   	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> @@ -320,7 +336,7 @@ static int k1_pcie_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, k1);
>   
> -	ret = k1_pcie_parse_port(k1);
> +	ret = data->parse_port(k1);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "failed to parse root port\n");
>   
> @@ -338,8 +354,14 @@ static void k1_pcie_remove(struct platform_device *pdev)
>   	dw_pcie_host_deinit(&k1->pci.pp);
>   }
>   
> +static const struct k1_pcie_device_data k1_pcie_device_data = {
> +	.host_ops	= &k1_pcie_host_ops,
> +	.ops		= &k1_pcie_ops,
> +	.parse_port	= k1_pcie_parse_port,
> +};
> +
>   static const struct of_device_id k1_pcie_of_match_table[] = {
> -	{ .compatible = "spacemit,k1-pcie", },
> +	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data},

In addition to the missing space that Andy mentioned,
adding a comma means the line won't need to change
when you add another entry to the array.

>   	{ }
>   };
>   

