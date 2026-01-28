Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B732FA3D
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580683; cv=none; b=e7aZLcr3sgPSz9omsIGAhpnS9d/aFp8u6Q7n8NkyZzLyyYTDdLcHT3IxffHemjxZD7TvMCcomu5YiyEGA43DhNi0ffG/3H/65pMgSHNlfTBfZz0/siUkSH7skteQtEGKytQbpp+9EJ4KFceFQNMKe6HQGVy9+7+9xOBQgq1LGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580683; c=relaxed/simple;
	bh=2k9cOjlgSiwfRJrPV/9G3xqvU6n1iJHH/PLdCV2ldHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnH70Dl+QrwxzKNwaOWdNGRNlmiqWml8SGQP/japw8f8VITSg4T10QjgK3gEndnrewum9HpZcHc4+OClw+KQzH3bNbPWbymg3/yMc1so0DiU1q+w1iY9aAXH6x8ar+IMKqOWpCo1A9bwTf21aRoV8pEpjPNvnis6jiD904GpSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ecosda.com; spf=pass smtp.mailfrom=ecosda.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ecosda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecosda.com
X-QQ-mid: zesmtpgz5t1769580629t499fb279
X-QQ-Originating-IP: /frwJUCmhWx8H9pQrtVabHfKfSt5REl8XfI9nr78Bpg=
Received: from [192.168.51.35] ( [140.206.53.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 28 Jan 2026 14:10:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8772503142100557548
Message-ID: <67B225764BC63278+75eacdb8-8879-4d62-904c-f03995d78dc4@ecosda.com>
Date: Wed, 28 Jan 2026 14:10:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI: dwc: Clean up iATU index usage in
 dw_pcie_iatu_setup()
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Randolph Lin <randolph@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>, Frank Li <Frank.Li@nxp.com>,
 Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 dlemoal@kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 linux-pci@vger.kernel.org
References: <20260127151038.1484881-5-cassel@kernel.org>
 <20260127151038.1484881-7-cassel@kernel.org>
Content-Language: en-US
From: Hans Zhang <zhanghuabing@ecosda.com>
In-Reply-To: <20260127151038.1484881-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ecosda.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MhHYuF7Otq+o1UyR6L05RlNRuTq2/q/Rk1pMydlJA29UxCZI78P7QVrF
	rERyHtt9PGGpbGHhqdkkIbY38xFdm1Z/ko1gglN3T7bm9vsi0dGFenIqipiR2M1+HdZnod0
	lYQLcgJ+WouWa70KubLV9P/1XfObK0K7Mw4j4tdWCUWnXVa9PhWY2sY6/sDZVfj0rPzZiSy
	+8FrfETCyo0gIaxFCDaXzUwFto6pyTdy+zTiJMo5dtMF8Jmdt+ojalgJo7rtqxBKG5814TK
	Bv7/TSfZI5+Z96KlJPaihla5kt3XsmWjBLNp8f4Ggb1dDM9+QfxAvSqMKuhtSZbrc8AwGJr
	K+OuIG0HRcBRGCxE0uCW3j0bmK8bBs/pOLTwvk8I4sCp1A1//9QDYro0tGEDSH6K/9DMXXw
	1z60sblBc3A3WPoAV/LcKz0Sj61NIwEWuK08NE6QAPsNnmvFMfMGjGOXhvtkK1vDCmsVqbG
	zgYkhP63OmWvf/h1GykBo6zPT8xvMNdb+jJaANnOxerYjk605SnG7v4ninOS5rIku2DGxHU
	cmNkGL4XDnzR47F3lpUHSsN87I93MrCjoPtef25HX71POXibSDAuAJh17bDCFqgJzuk2qvD
	AL8+a78PNaGpHio8zhpz9h1VoTnRdnfBNvGd9c3VjdjOjfYf87qniqq8/t/bSEvsf0DN70t
	W3Bzd1+aePbY3s3AYbBBzXVkXXCvJ3Hmz19HsG0y8ADe0s+gK3a7GwDHCXtUY2UNdxZqut5
	5hwS+DaDq7AxwFo0CsZ70q3mgsAz7m30bKUd+d+zOQ1l3Bc3LurhDnP692wY+YevFQU2uZW
	k2oWc1oXthSOq6ottdCG9INhOICMImrPW9a2VuUTizP+HnCh9dKZG+5NmJnmZi821mwx3qq
	VQb9JhhI4Gs8pe1piawx9Waam64+KAurMbT0540ZFI8lv+JHFmf0CARebD2Ts0B0zqx12o2
	9zeqeZCU39lRuEGbBRaCVmKL5ZDKSAYAszBJko6Bot196FJxFCLERvPbxKTqhETD0B2MsAT
	di2yAClOPA/aQ+gwbs
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0



On 1/27/2026 11:10 PM, Niklas Cassel wrote:
> The current iATU index usage in dw_pcie_iatu_setup() is a mess.
> 
> For outbound address translation the index is incremented before usage.
> For inbound address translation the index is incremented after usage.
> 
> Incrementing the index after usage make much more sense, and make the
> index usage consistent for both outbound and inbound address translation.
> 
> Most likely, the overly complicated logic for the outbound address
> translation is because the iATU at index 0 is reserved for CFG IOs
> (dw_pcie_other_conf_map_bus()), however, we should be able to use the
> exact same logic for the indexing of the outbound and inbound iATUs.
> (Only the starting index should be different.)
> 
> Create two new variables ob_iatu_index and ib_iatu_index, which makes
> it more clear from the name itself that it is a zeroes based index,
> and only increment the index if the iATU configuration call succeeded.
> 
> Since we always check if there is an index available immediately before
> programming the iATU, we can remove the useless "ranges exceed outbound
> iATU size" warnings, as the code is already unreachable. For the same
> reason, we can also remove the useless breaks outside of the while loops.
> 
> No functional changes intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Hans Zhang <zhanghuabing@ecosda.com>

> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 59 ++++++++++---------
>   1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d7f57d77bdf5..87e6a32dbb9a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -892,9 +892,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>   	struct dw_pcie_ob_atu_cfg atu = { 0 };
>   	struct resource_entry *entry;
> +	int ob_iatu_index;
> +	int ib_iatu_index;
>   	int i, ret;
>   
> -	/* Note the very first outbound ATU is used for CFG IOs */
>   	if (!pci->num_ob_windows) {
>   		dev_err(pci->dev, "No outbound iATU found\n");
>   		return -EINVAL;
> @@ -910,16 +911,18 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   	for (i = 0; i < pci->num_ib_windows; i++)
>   		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
>   
> -	i = 0;
> +	/*
> +	 * NOTE: For outbound address translation, outbound iATU at index 0 is
> +	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
> +	 * index 1.
> +	 */
> +	ob_iatu_index = 1;
>   	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>   		resource_size_t res_size;
>   
>   		if (resource_type(entry->res) != IORESOURCE_MEM)
>   			continue;
>   
> -		if (pci->num_ob_windows <= i + 1)
> -			break;
> -
>   		atu.type = PCIE_ATU_TYPE_MEM;
>   		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>   		atu.pci_addr = entry->res->start - entry->offset;
> @@ -937,13 +940,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   			 * middle. Otherwise, we would end up only partially
>   			 * mapping a single resource.
>   			 */
> -			if (pci->num_ob_windows <= ++i) {
> -				dev_err(pci->dev, "Exhausted outbound windows for region: %pr\n",
> +			if (ob_iatu_index >= pci->num_ob_windows) {
> +				dev_err(pci->dev, "Cannot add outbound window for region: %pr\n",
>   					entry->res);
>   				return -ENOMEM;
>   			}
>   
> -			atu.index = i;
> +			atu.index = ob_iatu_index;
>   			atu.size = MIN(pci->region_limit + 1, res_size);
>   
>   			ret = dw_pcie_prog_outbound_atu(pci, &atu);
> @@ -953,6 +956,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   				return ret;
>   			}
>   
> +			ob_iatu_index++;
>   			atu.parent_bus_addr += atu.size;
>   			atu.pci_addr += atu.size;
>   			res_size -= atu.size;
> @@ -960,8 +964,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   	}
>   
>   	if (pp->io_size) {
> -		if (pci->num_ob_windows > ++i) {
> -			atu.index = i;
> +		if (ob_iatu_index < pci->num_ob_windows) {
> +			atu.index = ob_iatu_index;
>   			atu.type = PCIE_ATU_TYPE_IO;
>   			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
>   			atu.pci_addr = pp->io_bus_addr;
> @@ -973,34 +977,35 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   					entry->res);
>   				return ret;
>   			}
> +			ob_iatu_index++;
>   		} else {
> +			/*
> +			 * If there are not enough outbound windows to give I/O
> +			 * space its own iATU, the outbound iATU at index 0 will
> +			 * be shared between I/O space and CFG IOs, by
> +			 * temporarily reconfiguring the iATU to CFG space, in
> +			 * order to do a CFG IO, and then immediately restoring
> +			 * it to I/O space.
> +			 */
>   			pp->cfg0_io_shared = true;
>   		}
>   	}
>   
> -	if (pci->num_ob_windows <= i)
> -		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> -			 pci->num_ob_windows);
> -
>   	if (pp->use_atu_msg) {
> -		if (pci->num_ob_windows > ++i) {
> -			pp->msg_atu_index = i;
> -		} else {
> +		if (ob_iatu_index >= pci->num_ob_windows) {
>   			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
>   			return -ENOMEM;
>   		}
> +		pp->msg_atu_index = ob_iatu_index++;
>   	}
>   
> -	i = 0;
> +	ib_iatu_index = 0;
>   	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
>   		resource_size_t res_start, res_size, window_size;
>   
>   		if (resource_type(entry->res) != IORESOURCE_MEM)
>   			continue;
>   
> -		if (pci->num_ib_windows <= i)
> -			break;
> -
>   		res_size = resource_size(entry->res);
>   		res_start = entry->res->start;
>   		while (res_size > 0) {
> @@ -1009,14 +1014,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   			 * middle. Otherwise, we would end up only partially
>   			 * mapping a single resource.
>   			 */
> -			if (pci->num_ib_windows <= i) {
> -				dev_err(pci->dev, "Exhausted inbound windows for region: %pr\n",
> +			if (ib_iatu_index >= pci->num_ib_windows) {
> +				dev_err(pci->dev, "Cannot add inbound window for region: %pr\n",
>   					entry->res);
>   				return -ENOMEM;
>   			}
>   
>   			window_size = MIN(pci->region_limit + 1, res_size);
> -			ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM, res_start,
> +			ret = dw_pcie_prog_inbound_atu(pci, ib_iatu_index,
> +						       PCIE_ATU_TYPE_MEM, res_start,
>   						       res_start - entry->offset, window_size);
>   			if (ret) {
>   				dev_err(pci->dev, "Failed to set DMA range %pr\n",
> @@ -1024,15 +1030,12 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   				return ret;
>   			}
>   
> +			ib_iatu_index++;
>   			res_start += window_size;
>   			res_size -= window_size;
>   		}
>   	}
>   
> -	if (pci->num_ib_windows <= i)
> -		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
> -			 pci->num_ib_windows);
> -
>   	return 0;
>   }
>   


