Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B522435ED6
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699292; cv=none; b=uL5hTNbqqYeMFswYhUIr4hhQf9KaX/BJssqfoyrgFUDZWHy6bevyrblgBurp3jQAkGl54vuqUv08y15Cb7HuH+FM7VcrJbGRKlu2Y9RZKQbgZd1ASVbQpHcm9XsEBDsddPoqU0HNRN/3mIbA94HF9BPyZfg9GrK4SyuVKp3hZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699292; c=relaxed/simple;
	bh=epu93lAu/KUXCKBFjiN4J4HkiyQAjzjExF2DJWiAOww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFeeVuKawpnZuvS1kSY9zYkHdhHcQCdnmSFEV9AATvS2a3Mvu3HoLPA8eUgU7YAKDyDnEctThSzWAOWUJ7OQLk9R0nUNXdi3BpXTC+2ZS31G/lEamseIHN/xTVB++7F4ggYbv4mJ/GRd5GksdyQ5na+bKHMUtgH+2p1W0eHZe38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=UboF9Ajd; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="UboF9Ajd"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8eefd4a8057so13505546d6.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783699286; x=1784304086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibYEVRhooxeSrQ5xojyVHvKfco3aR1AHaIOv/pn/k8M=;
        b=UboF9AjdkzPcLgRKLj9lNa6Z/S1ZLy2N7eALPX2i2AtNOoUVIo64jn4uG9CTcExyjL
         A4Nqu7DfiqMnVNwbqwlXhx63jyduF9zeT9t5xDkdNkwDhLbPsjnHNRShr7AnleUDHCkO
         uZh0WxFqEJyihRCnZB3mkSKfvxA6mAhxEuAdhQjB7nOjyDVCZrdJZhzWJ6Ti5KGKpqP0
         EUmXAn4A5/EM18GYAS2nTrj/c9+6wFP6rdswbjSIp+W20/J6v03hqs4SNCS9tlMU4XyG
         Tn8ntc6Y4u9kVHiAS/QbaP8DJ/uk0ryOHq0hWaW4cJFa8azX76E/PhbjEs/YdagMobAY
         E9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783699286; x=1784304086;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibYEVRhooxeSrQ5xojyVHvKfco3aR1AHaIOv/pn/k8M=;
        b=WsfRqaA8NzcmLJC7tc01EFwFopw3z1Vtpccg5q2CVwg2KCVVzLLMwHN1PH9C+hNu7N
         4HOylqgFLfJ0WtZCzhiPwlhGh7en4iPnwqEB5ClPhGT0icZb2Eqa72MgTflJpTnQijop
         zuNjAieEZEQdaKgdb507rkVnqYQ04OJ350QrdcyGK3JQunVr+LzIpQnp2PVImv1DNTKB
         nkDdQV2Tx4dszlOTehLL/4UbVbaMz23z3GTHeT1GRCTkpdDmiFuyyabehm5xPkdUCt+c
         SMwfpSlHOPpxSEpWHLj8WbvlzVfhKDzIWqYCsGBaOx6vxTaXZvkFImM+E99uIvcN6Vz+
         YPXQ==
X-Gm-Message-State: AOJu0YwYeuUJAnIzc68UVmYU9h/05WsPWFvD8VGA2u/yugLESfu+mTwK
	R2HUcT3vRwPs7TlufbkohNcrnqz/DfIEcL35A2rMe75ojPh3KBOJZvVrbK00r3aZsMs=
X-Gm-Gg: AfdE7clSDwPZa6ENuhH/O9GoDWE28Lbpn/KG4Z3v/CsZGWC/mJFIUoDjlcSxiSSj5II
	k58JKGIboM1rwAREqUcp7xjQ5/0SUefREnnaiTS+WSYgzbndiqPOkUgQD+A/N4m0ebiJpoQYgAa
	kSFpyrHt2/tdIoTMvL7PMHYCKq8lto+z40wBB4GIXTw/MMqbewYGi1RPxB3FBG0g8C6ZtlPfYcz
	vfPdLPCg50YJn0XAK9yVJTFHN9BUTfeE7AihhMgtW3siPoe5pZ9iWI4//0pYntMSsx2/Q4Y2zF5
	ZAoOXHHcvVsKiFT2aIWUSinv+iRaThjaRXKSqDzvS1JVLKF7OkSTflpisKyNhUeDjmXOFYwMUmT
	EclJWLWzfKw5Lqm3UHvexWSbPsJ4B9x3vizaq6x1zMO2AaqqVig/uk07xX7MofB9022/LN4Fa2f
	cTM0Txts+eOWVi
X-Received: by 2002:a05:6214:2f0c:b0:8e9:f5de:d628 with SMTP id 6a1803df08f44-8fec333688bmr139493076d6.55.1783699285931;
        Fri, 10 Jul 2026 09:01:25 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9036e27f765sm8965376d6.11.2026.07.10.09.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 09:01:25 -0700 (PDT)
Message-ID: <7e8cc486-8d0c-4bb0-ada9-fb4dd53e53e8@riscstar.com>
Date: Fri, 10 Jul 2026 11:01:23 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] PCI: spacemit-k1: Add multiple PHY handles support
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
 <20260709040027.958400-3-inochiama@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260709040027.958400-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 11:00 PM, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 may use multiple PHYs at the

s/use/uses/

> same time. The feature is not support by the current driver.

s/support/supported/

> So extend the PHY definition to support multiple PHY handles.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 70 ++++++++++++++++---
>   1 file changed, 59 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> index f6ae8ff3589a..e22ecbd09579 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -55,12 +55,14 @@ struct k1_pcie_device_data {
>   	const struct dw_pcie_host_ops *host_ops;
>   	const struct dw_pcie_ops *ops;
>   	int (*parse_port)(struct k1_pcie *k1);
> +	unsigned int max_phy_count;

Is the name "max_phy_count" meant to suggest that there
could be fewer "actual" PHYs than the number provided in
this field?  If not--if it is simply "the number of PHYs
this platform uses"--then just call this phy_count.

>   };
>   
>   struct k1_pcie {
>   	struct dw_pcie pci;
>   	const struct k1_pcie_device_data *data;
> -	struct phy *phy;
> +	struct phy **phy;
> +	unsigned int phy_count;

If this is always the same as what's in data->max_phy_count,
you don't need to replicate the value here (since you're
also keeping the data pointer in this structure).  (But it
looks like it might be less than max_phy_count.)

I believe I suggested making this structure use a flexible
array member for the PHYs.  If that's possible, it should
go at the end of the structure, and the way you allocate
it needs to change.

>   	void __iomem *link;
>   	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
>   	u32 pmu_off;
> @@ -119,6 +121,54 @@ static void k1_pcie_disable_resources(struct k1_pcie *k1)
>   	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
>   }
>   
> +static int k1_pcie_get_phy_handle(struct k1_pcie *k1, struct device_node *node)

I would call this k1_pci_get_phy_handles() (or perhaps
just k1_pci_get_phys()).  Or even k1_pci_phy_get_all().
The name you have seems like you're just getting one handle.

> +{
> +	const struct k1_pcie_device_data *data = k1->data;
> +	struct device *dev = k1->pci.dev;
> +	unsigned int i;
> +
> +	k1->phy = devm_kmalloc_array(dev, data->max_phy_count,
> +				     sizeof(*k1->phy), GFP_KERNEL);

Use kzalloc not kmalloc.  Even if you're initializing all fields
now, a future change might not (and in that case having it zeroed
is safest).

Also, if you find fewer than max_phy_count PHYs, I think it
would be better to only allocate as many needed.  If you
used a flexible array size, you would need to count the
number of entries before allocating it.  It would require
changing the structure a bit--providing a single function
that would allocate the k1_pcie structure after doing that,
and most likely initializing the phy array within the same
function.

> +	if (!k1->phy)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < data->max_phy_count; i++) {
> +		k1->phy[i] = devm_of_phy_get_by_index(dev, node, i);
> +		if (IS_ERR(k1->phy[i])) {

If this returns -ENODEV, you are done getting PHYs.  So
max_phy_count could be more than the "actual" number.

Is that reasonable?  You indicate that at least one PHY
must be found below, but is it OK for a platform to
define fewer than some expected number of PHYs?

(Maybe it is.)

> +			if (PTR_ERR(k1->phy[i]) == -ENODEV)
> +				break;
> +
> +			return PTR_ERR(k1->phy[i]);
> +		}
> +	}
> +
> +	k1->phy_count = i;
> +	if (k1->phy_count == 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int k1_pcie_enable_phy(struct k1_pcie *k1)

I would call this k1_pcie_enable_phys().  But actually,
because what you're calling within this is phy_init(),
I'd probably call it k1_pcie_init_phys(), or possibly
k1_pcie_phy_init_all().

> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < k1->phy_count; i++) {
> +		ret = phy_init(k1->phy[i]);
> +		if (ret)
> +			goto err_phy;
> +	}
> +
> +	return 0;
> +
> +err_phy:
> +	while (i--)
> +		phy_exit(k1->phy[i]);
> +
> +	return ret;
> +}
> +
>   /* FIXME: Disable ASPM L1 to avoid errors reported on some NVMe drives */
>   static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
>   {
> @@ -174,7 +224,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>   	 */
>   	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
>   
> -	ret = phy_init(k1->phy);
> +	ret = k1_pcie_enable_phy(k1);
>   	if (ret) {
>   		k1_pcie_disable_resources(k1);
>   
> @@ -194,12 +244,14 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
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

Please create an inverse of k1_pcie_enable_phy(), like
k1_pcie_disable_phy(), to encapsulate this code.

>   
>   	k1_pcie_disable_resources(k1);
>   }
> @@ -266,23 +318,18 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
>   {
>   	struct device *dev = k1->pci.dev;
>   	struct device_node *root_port;
> -	struct phy *phy;
> +	int ret;
>   
>   	/* We assume only one root port */

Maybe you could get and put the root_port within
k1_pcie_get_phy_handle(), since that's the only
place it's needed.

					-Alex

>   	root_port = of_get_next_available_child(dev_of_node(dev), NULL);
>   	if (!root_port)
>   		return -EINVAL;
>   
> -	phy = devm_of_phy_get(dev, root_port, NULL);
> +	ret = k1_pcie_get_phy_handle(k1, root_port);
>   
>   	of_node_put(root_port);
>   
> -	if (IS_ERR(phy))
> -		return PTR_ERR(phy);
> -
> -	k1->phy = phy;
> -
> -	return 0;
> +	return ret;
>   }
>   
>   static int k1_pcie_probe(struct platform_device *pdev)
> @@ -358,6 +405,7 @@ static const struct k1_pcie_device_data k1_pcie_device_data = {
>   	.host_ops	= &k1_pcie_host_ops,
>   	.ops		= &k1_pcie_ops,
>   	.parse_port	= k1_pcie_parse_port,
> +	.max_phy_count	= 1,
>   };
>   
>   static const struct of_device_id k1_pcie_of_match_table[] = {

