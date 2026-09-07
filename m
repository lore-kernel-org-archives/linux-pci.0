Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F893E63AC
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796014; cv=none; b=SgdXAsaXK1NNHJ4El1i+l77Lwc87NZRJnJ9oxexEH/QwgMeUUbZVzNCvio4akfMJ5BGuqutb9w72XYmE8AC8gnThA22fp4N9vZ/2avkgxk8vCTnKPQK4dLtRo1m5X97DUFI85X+3jyy/7dW1C0X8L8VedJVaPK8OkH5OxnSKLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796014; c=relaxed/simple;
	bh=+p2wxhGX5nM0ZplC1iTxNQsIkNWZxeDpFxjC2VLhC2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JchaCFw96gLLpxJ/T+gVmfVUB6hDqhWmBzolV7JpuDptw2JrB+znj3oG3U7DYPkllrL3jefTWcv4K8m3eyUpVbgC9YceoBGufL0uMQABTmmaoEBsmxg8HVZOm6fnzeEHlKJbNYAFvrKNUMH4tQ/H1xRzxGNApxgeEU6tQvQkUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNnDW100; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNnDW100"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4957eefd361so29161515e9.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788796010; x=1789400810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:from:references:cc:to:subject:reply-to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9NIT1FwG6Cf62/avBGQMVMZG3cECtHFx23mol9pUcno=;
        b=pNnDW100kEg1If1sHAERsxI4dZsAnTFQVtYxnT7QAQLLXwsPTlubgyPyI3lmvj2Dey
         zysKoC/of3N1f/rrWiRGpGrNqcJlVMl0wAfisAtY6o9PASiUpfz+FahOYiNUpvlGhkEG
         bbWVrJJLKaRuF85KBqCx1qV0yqGoQcCd0vBiauHy5R4wk9W66h1IhWOC+metXBeEu+zC
         QOfhXS5v3g2kgU2KzO79Hb4x1KeHrd9k372qp28GuVMuhKxEYbHU8M1/YglkrrkMFXbl
         T7y9bNG480lzcTM251C4UVkZABmIh673xrJq9dodI4jYUTi17eJU+zfpUiQM1z50Xx0R
         IEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796010; x=1789400810;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:from:references:cc:to:subject:reply-to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9NIT1FwG6Cf62/avBGQMVMZG3cECtHFx23mol9pUcno=;
        b=mJ6EalzTVuRWBxgUxASNA4djpudNNj2mwK1HAn6L9dtvYXa3iY3WV6MqOVHKVL98TL
         89HQqvxkc37hxSKbstxr+lrF61lMgrlvowOduqo8P7t4KfElV+RiDcNXTMmye69k7sM8
         9w1lYDvPHiqENjGSalUGlCsXEItPrutxIG/9zMZVjq5/Bmac7/RJAk3JDqotrqggbhvd
         YVbMS2BZz6lKM4o2nSYwpVLhnTTVAbLYxGXX/QBeYSvts+bMSTMOTOkHVQqRRcUmUOeO
         UGcuQnOqrlZjwS07lqYcf3BWdDT9KiR5OIvb5NWohZvhLfkTUp0HYL4aHHjWT/P6aoPb
         c79g==
X-Gm-Message-State: AFuF++l4aMFJoXhQ0nFCInORxziIx+GBrroXeoQk26o5dplxVRgk0ODG
	AcLbNby97yp1YMh0WxZ9lE4gXOTz2/eTA5fw32Jt5KLeFdMSQEuL3egBNUz26EySyxU=
X-Gm-Gg: AYBFou3A+GWJ9Dhv43d9KfflASXMyBwublDlSpTY8AIzq5IDQ+oJf7ul0RyPRmbOo3m
	mDtUOa/73fhfipRbbKFR85U2sCqxcfl8tfDZj3JcVZ3XD5VgCOTLcYCO8BykP3OULdpqRLJiBji
	B1isnMsUHxWFV4UoNcWI+QnwYC8wP7XdZT/gwI5YNpJEfExFHDMyMS887hcIsU/b0EO2oG9lBy6
	GKdv8u6TSyXSTJ/r0/9O9014wOGuDxpfMJG5FW6bnisMNNxBeim+IlWAIqnRZoETNzU8W4RCT4Q
	7+RYAgZF27+oGUikcARMjyNF/evoaCLuqC9uvcg9YV2soxL/VOgQd2JtKxDe7oX3ND9jmQvkOPw
	BRwDEbRKhiNFzdd+hdTA+qvGzkVPa74KuQsULyhCo/hAWvPc4SyL3QsM9CGft0+HUQclzomQKtL
	XudtnPAe3cbrREsNlFX5mYNgLRSgLKX12URtm8S0stN/fbeoaMT5LrnQQiVLOJd9Ob8ml8Fhql7
	fSaItnzNLWB9cM9dRBNBCcyPLiag4zKQ8NzUeTWgSQ=
X-Received: by 2002:a05:600c:46d1:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-49cf820c992mr246008895e9.6.1788796010330;
        Mon, 07 Sep 2026 08:46:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:74d7:9035:e283:b480? ([2a01:e0a:106d:1080:74d7:9035:e283:b480])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf772692dsm379629685e9.10.2026.09.07.08.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 08:46:49 -0700 (PDT)
Message-ID: <e04b2fc0-710c-4cd3-8f38-e528d57b4487@linaro.org>
Date: Mon, 7 Sep 2026 17:46:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] PCI: qcom: Honor IOMMU provider's #iommu-cells in
 qcom_pcie_config_sid_1_9_0()
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <20260907143349.317495-1-mani@kernel.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260907143349.317495-1-mani@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:33, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> qcom_pcie_config_sid_1_9_0() reads the "iommu-map" property as an array
> of fixed four-word {rid-base, phandle, sid, rid-len} entries to program
> the BDF to SID translation table. But that layout only holds for an
> IOMMU with '#iommu-cells = <1>'. The PCIe SMMUs on these SoCs use
> '#iommu-cells = <2>' (SID and mask), so per the pci-iommu binding each
> entry is really five cells long.
> 
> This used to work only because the DTs were themselves broken. They
> described iommu-map with four-cell entries that omitted the SID mask,
> which of_map_id() tolerated via its of_check_bad_map() fallback, and the
> four-word parsing coincidentally matched that malformed shape.
> 
> Since commit ccb2fd725d41 ("of: Respect #{iommu,msi}-cells in maps") the
> OF core parses such maps correctly, so the device trees were converted
> to proper five-cell entries, e.g. commit c41749e9554d ("arm64: dts:
> qcom: sm8250: Fix the PCIe iommu-map entries"). With five-cell entries
> the fixed four-word stride slips by one cell for each entry after the
> first, so qcom_pcie_config_sid_1_9_0() reads the endpoint mapping's RID
> from the preceding entry's length cell and its SID from the phandle cell.
> As the RID is the hash key, the endpoint's real RID is never programmed
> into the BDF to SID table. Its DMA then hashes to an unprogrammed slot,
> gets tagged with SID 0 and the SMMU faults like below on QCS8300:
> 
>    arm-smmu 15200000.iommu: Unhandled context fault: fsr=0x402, iova=0xffa00000, cbfrsynra=0x0, cb=1
> 
> To fix this, walk the map with a stride of 3 + '#iommu-cells' of the
> referenced IOMMU and take the SID from the first specifier cell, which is
> all the BDF to SID table needs. Validate the layout instead of trusting
> the array size. Also, preserve the legacy behavior of the old DTs by
> detecting the same pattern that of_check_bad_map() recognizes and
> falling back to a stride of four.
> 
> Fixes: 4c9398822106 ("PCI: qcom: Add support for configuring BDF to SID mapping for SM8250")
> Reported-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 90 ++++++++++++++++++--------
>   1 file changed, 64 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b58a607b713f..42cbeef083ca 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1143,50 +1143,90 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>   
>   static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
>   {
> -	/* iommu map structure */
> -	struct {
> -		u32 bdf;
> -		u32 phandle;
> -		u32 smmu_sid;
> -		u32 smmu_sid_len;
> -	} *map;
>   	void __iomem *bdf_to_sid_base = pcie->parf + PARF_BDF_TO_SID_TABLE_N;
>   	struct device *dev = pcie->pci->dev;
> +	struct device_node *iommu_np;
>   	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
> -	int i, nr_map, size = 0;
> -	u32 smmu_sid_base;
> +	const __be32 *map;
> +	u32 iommu_cells, entry_cells, phandle, smmu_sid_base;
> +	int i, nr_cells, nr_map, size = 0;
>   	u32 val;
>   
> -	of_get_property(dev->of_node, "iommu-map", &size);
> -	if (!size)
> +	map = of_get_property(dev->of_node, "iommu-map", &size);
> +	if (!map || !size)
>   		return 0;
>   
> +	if (size % sizeof(*map)) {
> +		dev_err(dev, "Malformed iommu-map property\n");
> +		return -EINVAL;
> +	}
> +	nr_cells = size / sizeof(*map);
> +
> +	/*
> +	 * Each iommu-map entry is: rid-base (1 cell), phandle (1 cell),
> +	 * IOMMU specifier (#iommu-cells cells), length (1 cell). Read
> +	 * #iommu-cells from the IOMMU provider referenced by the first
> +	 * entry to compute the per-entry stride.
> +	 */
> +	phandle = be32_to_cpu(map[1]);
> +	iommu_np = of_find_node_by_phandle(phandle);
> +	if (!iommu_np) {
> +		dev_err(dev, "Failed to find IOMMU node in iommu-map\n");
> +		return -ENODEV;
> +	}
> +
> +	if (of_property_read_u32(iommu_np, "#iommu-cells", &iommu_cells))
> +		iommu_cells = 1;
> +	of_node_put(iommu_np);
> +
> +	entry_cells = 3 + iommu_cells;
> +
> +	/*
> +	 * Retain backward compatibility with DTs that describe iommu-map
> +	 * with 4-cell entries against an IOMMU declaring #iommu-cells = 2,
> +	 * matching the fallback in drivers/of/base.c::of_check_bad_map().
> +	 */
> +	if (iommu_cells == 2 && !(nr_cells % 4)) {
> +		bool legacy = true;
> +
> +		for (i = 0; i < nr_cells; i += 4) {
> +			if (be32_to_cpu(map[i + 1]) != phandle ||
> +			    be32_to_cpu(map[i + 3]) != 1) {
> +				legacy = false;
> +				break;
> +			}
> +		}
> +
> +		if (legacy) {
> +			dev_warn_once(dev, "iommu-map has 1-cell entries targeting 2-cell #iommu-cells, treating as 1-cell output\n");
> +			entry_cells = 4;
> +		}
> +	}
> +
> +	if (nr_cells % entry_cells) {
> +		dev_err(dev, "Malformed iommu-map property\n");
> +		return -EINVAL;
> +	}
> +	nr_map = nr_cells / entry_cells;
> +
>   	/* Enable BDF to SID translation by disabling bypass mode (default) */
>   	val = readl(pcie->parf + PARF_BDF_TO_SID_CFG);
>   	val &= ~BDF_TO_SID_BYPASS;
>   	writel(val, pcie->parf + PARF_BDF_TO_SID_CFG);
>   
> -	map = kzalloc(size, GFP_KERNEL);
> -	if (!map)
> -		return -ENOMEM;
> -
> -	of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)map,
> -				   size / sizeof(u32));
> -
> -	nr_map = size / (sizeof(*map));
> -
>   	crc8_populate_msb(qcom_pcie_crc8_table, QCOM_PCIE_CRC8_POLYNOMIAL);
>   
>   	/* Registers need to be zero out first */
>   	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
>   
>   	/* Extract the SMMU SID base from the first entry of iommu-map */
> -	smmu_sid_base = map[0].smmu_sid;
> +	smmu_sid_base = be32_to_cpu(map[2]);
>   
>   	/* Look for an available entry to hold the mapping */
>   	for (i = 0; i < nr_map; i++) {
> -		__be16 bdf_be = cpu_to_be16(map[i].bdf);
> -		u32 val;
> +		u32 bdf = be32_to_cpu(map[i * entry_cells]);
> +		u32 sid = be32_to_cpu(map[i * entry_cells + 2]);
> +		__be16 bdf_be = cpu_to_be16(bdf);
>   		u8 hash;
>   
>   		hash = crc8(qcom_pcie_crc8_table, (u8 *)&bdf_be, sizeof(bdf_be), 0);
> @@ -1208,12 +1248,10 @@ static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
>   		}
>   
>   		/* BDF [31:16] | SID [15:8] | NEXT [7:0] */
> -		val = map[i].bdf << 16 | (map[i].smmu_sid - smmu_sid_base) << 8 | 0;
> +		val = bdf << 16 | (sid - smmu_sid_base) << 8 | 0;
>   		writel(val, bdf_to_sid_base + hash * sizeof(u32));
>   	}
>   
> -	kfree(map);
> -
>   	return 0;
>   }
>   

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Thanks,
Neil
