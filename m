Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1194D9900
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812659; cv=none; b=p78wwRD+hIMXHz8k9eaxzBbBEprrHzj+96glaOZ25j2HX4w4o6+JWNOCct+Ekx5ViA6PO0hEczluP3ZXhMXG29oFAG3Zs+JyLjyouJbj8RlVmayKKf2vvs6XmjO3Gfa+mscbHca0JKjvQNMHrScNEpsGrdmpI6tac4aJzByiJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812659; c=relaxed/simple;
	bh=2KF2NK4jU3OMBU6vC5PtVQ+haGLRi51fkIQwnys01R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9iA7YtQsI+NrNrvUbF8FbrTAPwDv34cO6o0IdrOC5kI7AlOBUGVEh+P0L8ho9jJUsQYDmFvhAfzB5wxzrYE0HA8WemCmZ9d6iuGkHz4F8Nsooq7wO98fAT4/0CzvGv6/9WYj/rHXGSlIdH8IcoMLZYcpTFlBAxXar5CA+NESVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAb5Ea2I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAb5Ea2I"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49557167508so6172895e9.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784812647; x=1785417447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:from:references:cc:to:subject:reply-to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9iBEUWCa780NKREnuZlfqOv1A8GdvpYRK+dYt5P3FuE=;
        b=qAb5Ea2IOMXDgQOQEsSzcTy58VD2AI8hHKJdwmJ+EeutravP/7FEmlt8m0jkbAJJZO
         hhQGydNBtYjVBoOYEpDDHkJ5T5zAHUH4eJiDSqtF3XIWRjaWAi0BktXhxCZ+W4clWata
         Nr9al5X4kna4k+M9kqMmOMFUUFndj70iDD2BNh7CeP0fQF8ASxMyQtkNa2NIVlM81dHo
         Y/5zVn4RIUbGKcfv3rWmepmppoP5gHLGxKt2ciTG2AQ2Gu4yd49n0E1dO2VhAqtrpQ8W
         2L7lG9mzrKujeOis194FJZuHaBYSrkPL97bwQ+vrDI/XjUGchEHc821T7JXRK+RVvAJL
         P7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784812647; x=1785417447;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:from:references:cc:to:subject:reply-to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9iBEUWCa780NKREnuZlfqOv1A8GdvpYRK+dYt5P3FuE=;
        b=LtJ4VGB5xseWImpWrjJjDFZp0KVjbCgARJ6np57eFoK4ce0f+XCiS/hbqcqXImlpxm
         T9yBlBrRklHLwDUc846G8cwIo09XEs5gCD4N3HjbyJCui3G0JXPVzAf6XzSa6aO6bDjt
         GD8JjUJqPr2LCg+bvVqfhDXBwvreou0M8/y+3ZrdW72FgW7ED3FwlxoiJhe5NEAUASBZ
         tvI4GDh1IRUffECEE7eOHWWREjbIwnWaHrMjDXrUyVoN0e1jSqwkKUQ3wKq0edwoAO8X
         N/rpsxfalUcYR7FdUSTjk9DQ29eflRXtNWMzyXtDfl7ShCpivfPFNVlk4MdlL0U2ajOy
         AaiA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9Bmxq18HwFfgTBdg9/di05tGvBcAPIWufjDA+iZBpsdpdeDWLCcf3w7sAtyYSFNcSQw3/ZfGDdIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYQABdo9YEtu78f3DS3C+FPJCmKw8xvGDgZWjzYEA1RPDIhPQ
	A627hW5Ld82jHC/kVeH7gr3yHe1Poe1YhPhawqbfdeF/cCLOk7mJj9eTkCORGTPnpbU=
X-Gm-Gg: AR+sD12UCUGYMawTEYP6unI+uHRq0vaJDWBxIJxaciXeXGPGbx4TBztp1euR0kixP8P
	qkxgKiSSNIeAewR2tleHnUUo6LxmoiPbb4eskFji5nVNeYYrz4/aq02unbH4wjTIBDN554yZh+J
	2lxPexZH1fpZ+sTxzKiwZmtHGh/pokMraQvE0wbcr4q/khmYu2zd+xxSbpQ1DKiDYE+SPuXukoD
	GJll24egxo8DKunxg8/BSIcIocN/z9Enb4LAIO2tXhvRj3WMdvyU0fJl2mQ6U/CTAGsV4FtGAnO
	EBWV8NeObspdFqF9+MLhJ4qXnQIhGCGPkRMIrJ2z9Wi+PEWMAW7V4KWHOa6XL0qttMEvOo1ZRgi
	cAOSr9l4TzIMsjQa+R+Z5EmcrvEsifXKLiAInLyibX8yTahtSyjfJqz8bsTVKvJRlOSAJJdVflM
	PTGKBZiuyJbXgh/a6uN90ly16weYBY7fauPwlhYaI7m/B7KcH9HlKygdyUdA==
X-Received: by 2002:a05:600c:4583:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-49573ccd1ddmr33553745e9.11.1784812646529;
        Thu, 23 Jul 2026 06:17:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:f234:5e35:82ba:6d6c? ([2a01:e0a:106d:1080:f234:5e35:82ba:6d6c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63bd3sm14637989f8f.27.2026.07.23.06.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 06:17:26 -0700 (PDT)
Message-ID: <3f5c974f-425d-47a5-9fda-e05de1f39d79@linaro.org>
Date: Thu, 23 Jul 2026 15:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v16 3/3] of: Respect #{iommu,msi}-cells in maps
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev,
 xen-devel@lists.xenproject.org,
 Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
 <20260603-parse_iommu_cells-v16-3-dc509dacb19a@oss.qualcomm.com>
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
In-Reply-To: <20260603-parse_iommu_cells-v16-3-dc509dacb19a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/3/26 09:13, Vijayanand Jitta wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> So far our parsing of {iommu,msi}-map properties has always blindly
> assumed that the output specifiers will always have exactly 1 cell.
> This typically does happen to be the case, but is not actually enforced
> (and the PCI msi-map binding even explicitly states support for 0 or 1
> cells) - as a result we've now ended up with dodgy DTs out in the field
> which depend on this behaviour to map a 1-cell specifier for a 2-cell
> provider, despite that being bogus per the bindings themselves.
> 
> Since there is some potential use in being able to map at least single
> input IDs to multi-cell output specifiers (and properly support 0-cell
> outputs as well), add support for properly parsing and using the target
> nodes' #cells values, albeit with the unfortunate complication of still
> having to work around expectations of the old behaviour too.
> 
> Since there are multi-cell output specifiers, the callers of of_map_id()
> may need to get the exact cell output value for further processing.
> Update of_map_id() to set args_count in the output to reflect the actual
> number of output specifier cells.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>   drivers/of/base.c  | 168 +++++++++++++++++++++++++++++++++++++++++------------
>   include/linux/of.h |   6 +-
>   2 files changed, 135 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d658c2620135..ac7961cbab94 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2116,19 +2116,49 @@ int of_find_last_cache_level(unsigned int cpu)
>   	return cache_level;
>   }
>   
> +/*
> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
> + * specifying only 1 cell. Fortunately they all consist of value '1'
> + * as the 2nd cell entry with the same target, so check for that pattern.
> + *
> + * Example:
> + *	IOMMU node:
> + *		#iommu-cells = <2>;
> + *
> + *	Device node:
> + *		iommu-map = <0x0000 &smmu 0x0000 0x1>,
> + *			    <0x0100 &smmu 0x0100 0x1>;

So the sm8650 PCIe controllers has:

pcie@1c08000:
			iommu-map = <0     &apps_smmu 0x1480 0x1>,
				    <0x100 &apps_smmu 0x1481 0x1>;

and

pcie@1c00000:

			iommu-map = <0     &apps_smmu 0x1400 0x1>,
				    <0x100 &apps_smmu 0x1401 0x1>;

and apps_smmu has #iommu-cells = <2>, but gets flagged at wrong:

[    7.538800] OF: /soc@0/pcie@1c08000: iommu-map has 1-cell entries targeting 2-cell #iommu-cells, treating as 1-cell output

Returning false in of_check_bad_map() triggers:

[    7.642680] OF: /soc@0/pcie@1c08000: Unsupported iommu-map - cannot handle 256-ID range with 2-cell output specifier

I don't understand the issue here, we use 2 cells as expected by
the iommu-cells, so why is it wrong ? can somebody explain in
comprehensive words ? I'm super confused, it worked like a charm until now.

Neil

> + */
> +static bool of_check_bad_map(const __be32 *map, int len)
> +{
> +	__be32 phandle = map[1];
> +
> +	if (len % 4)
> +		return false;
> +	for (int i = 0; i < len; i += 4) {
> +		if (map[i + 1] != phandle || map[i + 3] != cpu_to_be32(1))
> +			return false;
> +	}
> +	return true;
> +}
> +
>   /**
>    * of_map_id - Translate an ID through a downstream mapping.
>    * @np: root complex device node.
>    * @id: device ID to map.
>    * @map_name: property name of the map to use.
> + * @cells_name: property name of target specifier cells.
>    * @map_mask_name: optional property name of the mask to use.
>    * @filter_np: pointer to an optional filter node, or NULL to allow bypass.
>    *	If non-NULL, the map property must exist (-ENODEV if absent). If
>    *	*filter_np is also non-NULL, only entries targeting that node match.
>    * @arg: pointer to a &struct of_phandle_args for the result. On success,
> - *	@arg->args[0] will contain the translated ID. If a map entry was
> - *	matched, @arg->np will be set to the target node with a reference
> - *	held that the caller must release with of_node_put().
> + *	@arg->args_count will be set to the number of output specifier cells
> + *	as defined by @cells_name in the target node, and
> + *	@arg->args[0..args_count-1] will contain the translated output
> + *	specifier values. If a map entry was matched, @arg->np will be set
> + *	to the target node with a reference held that the caller must release
> + *	with of_node_put().
>    *
>    * Given a device ID, look up the appropriate implementation-defined
>    * platform ID and/or the target device which receives transactions on that
> @@ -2137,19 +2167,21 @@ int of_find_last_cache_level(unsigned int cpu)
>    * Return: 0 on success or a standard error code on failure.
>    */
>   int of_map_id(const struct device_node *np, u32 id,
> -	       const char *map_name, const char *map_mask_name,
> +	       const char *map_name, const char *cells_name,
> +	       const char *map_mask_name,
>   	       struct device_node * const *filter_np, struct of_phandle_args *arg)
>   {
>   	u32 map_mask, masked_id;
> -	int map_len;
> +	int map_bytes, map_len, offset = 0;
> +	bool bad_map = false;
>   	const __be32 *map = NULL;
>   
> -	if (!np || !map_name || !arg)
> +	if (!np || !map_name || !cells_name || !arg)
>   		return -EINVAL;
>   	/* Ensure bypass/no-match success never returns a stale target node. */
>   	arg->np = NULL;
>   
> -	map = of_get_property(np, map_name, &map_len);
> +	map = of_get_property(np, map_name, &map_bytes);
>   	if (!map) {
>   		if (filter_np)
>   			return -ENODEV;
> @@ -2159,11 +2191,9 @@ int of_map_id(const struct device_node *np, u32 id,
>   		return 0;
>   	}
>   
> -	if (!map_len || map_len % (4 * sizeof(*map))) {
> -		pr_err("%pOF: Error: Bad %s length: %d\n", np,
> -			map_name, map_len);
> -		return -EINVAL;
> -	}
> +	if (map_bytes % sizeof(*map))
> +		goto err_map_len;
> +	map_len = map_bytes / sizeof(*map);
>   
>   	/* The default is to select all bits. */
>   	map_mask = 0xffffffff;
> @@ -2176,39 +2206,93 @@ int of_map_id(const struct device_node *np, u32 id,
>   		of_property_read_u32(np, map_mask_name, &map_mask);
>   
>   	masked_id = map_mask & id;
> -	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
> +
> +	while (offset < map_len) {
>   		struct device_node *phandle_node;
> -		u32 id_base = be32_to_cpup(map + 0);
> -		u32 phandle = be32_to_cpup(map + 1);
> -		u32 out_base = be32_to_cpup(map + 2);
> -		u32 id_len = be32_to_cpup(map + 3);
> +		u32 id_base, phandle, id_len, id_off, cells = 0;
> +		const __be32 *out_base;
> +
> +		if (map_len - offset < 2)
> +			goto err_map_len;
> +
> +		id_base = be32_to_cpup(map + offset);
>   
>   		if (id_base & ~map_mask) {
> -			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
> -				np, map_name, map_name,
> -				map_mask, id_base);
> +			pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
> +			       np, map_name, map_mask_name, map_mask, id_base);
>   			return -EFAULT;
>   		}
>   
> -		if (masked_id < id_base || masked_id >= id_base + id_len)
> -			continue;
> -
> +		phandle = be32_to_cpup(map + offset + 1);
>   		phandle_node = of_find_node_by_phandle(phandle);
>   		if (!phandle_node)
>   			return -ENODEV;
>   
> +		/*
> +		 * Assume 1-cell output specifier if the target node lacks the
> +		 * #cells property, for backward compatibility with controllers
> +		 * that predate the property (e.g. arm,gic-v2m-frame).
> +		 */
> +		if (bad_map || of_property_read_u32(phandle_node, cells_name, &cells))
> +			cells = 1;
> +
> +		if (cells > MAX_PHANDLE_ARGS) {
> +			pr_err("%pOF: %s cell count %d exceeds maximum\n",
> +			       phandle_node, cells_name, cells);
> +			of_node_put(phandle_node);
> +			return -EINVAL;
> +		}
> +
> +		if (offset == 0 && cells == 2) {
> +			bad_map = of_check_bad_map(map, map_len);
> +			if (bad_map) {
> +				pr_warn_once("%pOF: %s has 1-cell entries targeting 2-cell %s, treating as 1-cell output\n",
> +					     np, map_name, cells_name);
> +				cells = 1;
> +			}
> +		}
> +
> +		if (map_len - offset < 3 + cells) {
> +			of_node_put(phandle_node);
> +			goto err_map_len;
> +		}
> +
> +		out_base = map + offset + 2;
> +		offset += 3 + cells;
> +
> +		id_len = be32_to_cpup(map + offset - 1);
> +		id_off = masked_id - id_base;
> +		if (masked_id < id_base || id_off >= id_len) {
> +			of_node_put(phandle_node);
> +			continue;
> +		}
> +		if (id_len > 1 && cells > 1) {
> +			/*
> +			 * With 1 output cell we reasonably assume its value
> +			 * has a linear relationship to the input; with more,
> +			 * we'd need help from the provider to know what to do.
> +			 */
> +			pr_err("%pOF: Unsupported %s - cannot handle %d-ID range with %d-cell output specifier\n",
> +			       np, map_name, id_len, cells);
> +			of_node_put(phandle_node);
> +			return -EINVAL;
> +		}
> +
>   		if (filter_np && *filter_np && *filter_np != phandle_node) {
>   			of_node_put(phandle_node);
>   			continue;
>   		}
>   
>   		arg->np = phandle_node;
> -		arg->args[0] = masked_id - id_base + out_base;
> -		arg->args_count = 1;
> +		for (int i = 0; i < cells; i++)
> +			arg->args[i] = id_off + be32_to_cpu(out_base[i]);
> +		arg->args_count = cells;
>   
>   		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
> -			np, map_name, map_mask, id_base, out_base,
> -			id_len, id, masked_id - id_base + out_base);
> +			np, map_name, map_mask, id_base,
> +			cells ? be32_to_cpup(out_base) : 0,
> +			id_len, id,
> +			cells ? id_off + be32_to_cpup(out_base) : id_off);
>   		return 0;
>   	}
>   
> @@ -2219,6 +2303,10 @@ int of_map_id(const struct device_node *np, u32 id,
>   	arg->args[0] = id;
>   	arg->args_count = 1;
>   	return 0;
> +
> +err_map_len:
> +	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
> +	return -EINVAL;
>   }
>   EXPORT_SYMBOL_GPL(of_map_id);
>   
> @@ -2228,18 +2316,21 @@ EXPORT_SYMBOL_GPL(of_map_id);
>    * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
>    *      stream/device ID) used as the lookup key in the iommu-map table.
>    * @arg: pointer to a &struct of_phandle_args for the result. On success,
> - *	@arg->args[0] contains the translated ID. If a map entry was matched,
> - *	@arg->np holds a reference to the target node that the caller must
> - *	release with of_node_put().
> + *	@arg->args_count will be set to the number of output specifier cells
> + *	and @arg->args[0..args_count-1] will contain the translated output
> + *	specifier values. If a map entry was matched, @arg->np holds a
> + *	reference to the target node that the caller must release with
> + *	of_node_put().
>    *
> - * Convenience wrapper around of_map_id() using "iommu-map" and "iommu-map-mask".
> + * Convenience wrapper around of_map_id() using "iommu-map", "#iommu-cells",
> + * and "iommu-map-mask".
>    *
>    * Return: 0 on success or a standard error code on failure.
>    */
>   int of_map_iommu_id(const struct device_node *np, u32 id,
>   		    struct of_phandle_args *arg)
>   {
> -	return of_map_id(np, id, "iommu-map", "iommu-map-mask", NULL, arg);
> +	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", NULL, arg);
>   }
>   EXPORT_SYMBOL_GPL(of_map_iommu_id);
>   
> @@ -2252,17 +2343,20 @@ EXPORT_SYMBOL_GPL(of_map_iommu_id);
>    *	If non-NULL, the map property must exist (-ENODEV if absent). If
>    *	*filter_np is also non-NULL, only entries targeting that node match.
>    * @arg: pointer to a &struct of_phandle_args for the result. On success,
> - *	@arg->args[0] contains the translated ID. If a map entry was matched,
> - *	@arg->np holds a reference to the target node that the caller must
> - *	release with of_node_put().
> + *	@arg->args_count will be set to the number of output specifier cells
> + *	and @arg->args[0..args_count-1] will contain the translated output
> + *	specifier values. If a map entry was matched, @arg->np holds a
> + *	reference to the target node that the caller must release with
> + *	of_node_put().
>    *
> - * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
> + * Convenience wrapper around of_map_id() using "msi-map", "#msi-cells",
> + * and "msi-map-mask".
>    *
>    * Return: 0 on success or a standard error code on failure.
>    */
>   int of_map_msi_id(const struct device_node *np, u32 id,
>   		  struct device_node * const *filter_np, struct of_phandle_args *arg)
>   {
> -	return of_map_id(np, id, "msi-map", "msi-map-mask", filter_np, arg);
> +	return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", filter_np, arg);
>   }
>   EXPORT_SYMBOL_GPL(of_map_msi_id);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index ea50b45d9ff7..374b249766a2 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -465,7 +465,8 @@ const char *of_prop_next_string(const struct property *prop, const char *cur);
>   bool of_console_check(const struct device_node *dn, char *name, int index);
>   
>   int of_map_id(const struct device_node *np, u32 id,
> -	       const char *map_name, const char *map_mask_name,
> +	       const char *map_name, const char *cells_name,
> +	       const char *map_mask_name,
>   	       struct device_node * const *filter_np,
>   	       struct of_phandle_args *arg);
>   
> @@ -950,7 +951,8 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
>   }
>   
>   static inline int of_map_id(const struct device_node *np, u32 id,
> -			     const char *map_name, const char *map_mask_name,
> +			     const char *map_name, const char *cells_name,
> +			     const char *map_mask_name,
>   			     struct device_node * const *filter_np,
>   			     struct of_phandle_args *arg)
>   {
> 

