Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532A4FD275
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664735; cv=none; b=dl+kEWkqiXY4THOaskhwlmCnuJFoajWZHhwP0/DiaonEhHV7Q6HA7oi96HL33WXinjlFJqVo/P5b/Rb7UWWeRqXeI6E1rEixrFPkqD8Lxx1yHYX4hqOcR6zB9iYZXEr3v2q47Q/9LX8DzdxjhVWf8ZwxnqBcXcC9tYLmGCn6ElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664735; c=relaxed/simple;
	bh=voESh8KNnZyYDqcPM7EScY57S21NUgKsPzeAuamylDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgkLWGUP7VOLW294rQH8EJlX6lDQ9gyYKIRL6isyWIoDBKADmObvEoGigKeblvZL3qRH9bD/he5th3NC+7ogZWfP9PgB/5BR9Xbdw+TPYkb/SNFN2JtjhIW/3+iRxZS4AHc9mD48W1ViYG8vCRbaWyXZs4b757k0RNKGc5/Mr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RrB6NCex; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RrB6NCex"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso380483a91.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664733; x=1790269533;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xZkIZE07OmYSk4DK1TncPSDCSBW3v5Bo/6rKnMUHhA4=;
        b=WD5m860aMKJWe3aYT02ruXfJDZqS3B1D3NGecUfoOPqYCBh6NLWvcuLGJvMJY5xnPU
         FPMAnVv01Mkuh+4auMUfR6CAVMiOwFfQLEmhOwlC6vmMvXfso4ZoKPlpP36Zd2DBRjvI
         bR23VPgtGrZjWyIewRKTlZSXx40d03WuNidM10B7Etj9B+jRMoXmA769Dct2kj1z7zH5
         pehSM3FVSqr6V3Y/2ZLSqMvED/ZekGnf3svhOzV2Rg4gqH02DyETBv50AMS9+PPR4RM7
         fIsBTV97KhxlRKq/9uiz2OflJ5DYLSvkIhn5KIkPXa1TePyhKSrlInYGGhQWD4+MgfOb
         bSsg==
X-Forwarded-Encrypted: i=1; AKwUvBxqDEFcOHjRapzWhTgBWS7/2Snr6c4b/Jq1iMbT5vuuPicp5i+ZlBof4JHz7qhwdrduY4dBKlTRMgQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mb76XepdT2c/ZteGM63xJrPUvz88TUSOl0fQTfWTX95+Zd3il7
	FB9n2aLUiCeLYW1TrIjpM23sj0PWj46oLTparRoCDRFLYegIjbMhL8eMzYkdz/ZeZoWjO3rcWgY
	kVCl1OYPBFl1a7WuIyURLeZO5OBj9o70Re65aot2X1TKFqUunncFRh4TdrAgt51NevbwrwPMqhu
	o0x8QeF08iFXNn7ZpG6JU79TxBh0xV6JgZkgl2pY3cIgjw90yRnFn7VzdIumoq/rIbuiMGaBmiU
	ijI+PcW1lXVHuzTLBIy
X-Gm-Gg: AYBFou1vNUkTsNo/sZ4hBopn357Q6IQ9B84o7XZN64/1anYYdcG9tmJRngIW2yYQTcW
	S0geVAxo3X7p6gBmk46BNjgKmLH8txTe1XoWSJ94j/793ghH24YRXlJbSLkJNXCR7jEAs5a7YoI
	UJvDb+zGnLSjyM5xaQUjT4ZDvmigcCfFnnM8LCgoEB2SfEPIH3uyhHOzeUdpyw1VLkXueN0Mv5z
	EA6TdWOAzWEMW+JhGBEfbQN2wSLFPSwFeOyk+nrseWOrpCJLDW6miqawW1VbaAGy9ZvdfmxC+Y5
	talmN0qJe/YCMKpmqwLGrSGnGIpzl74v/bGK9ANytK3J7smaRrpXtNu5rlh/DU27/9aRKxZm35o
	BOOmDeCW5LimqXl5/I0VRWcYv4gsbbRcQLH2yr6WsKUiUkNyVyFBrgrTnjeMKNOS9Boa0fUOKSh
	meZ7PrG637Wz93rEjgH8UAotQCdSG0diLLqUjdCW1taxM=
X-Received: by 2002:a17:90b:4ad0:b0:39e:3559:12df with SMTP id 98e67ed59e1d1-39e35592079mr9206022a91.1.1789664733202;
        Thu, 17 Sep 2026 10:05:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e362c64b6sm1811258a91.8.2026.09.17.10.05.32
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:05:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3734d06dso20932195ad.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789664731; x=1790269531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZkIZE07OmYSk4DK1TncPSDCSBW3v5Bo/6rKnMUHhA4=;
        b=RrB6NCexIQY3Vyp+jL5nef4kQvC0d72hwloBl4Z9TmZx9ZqgBmWrQQF68fd3mV/wPq
         r/AwOWETDzi+fESOYx8c14p26Rg37ejcG/dKDuR1AuJPcNBHg1yom1Lvf5ber+9jLuI0
         NTAziF1gNsEKX43vwEOa3YogAnLsXzi0inysA=
X-Forwarded-Encrypted: i=1; AKwUvBy5Ki+ZjYEJGoSIqz7GVhgh2Us/sCjmcCLhb6u4gIOI5i7qkDwN4FM0m3AVftDr30G9Ye27NnCDnqU=@vger.kernel.org
X-Received: by 2002:a17:903:1b43:b0:2db:1f50:6515 with SMTP id d9443c01a7336-2dd8dc0f8abmr153789365ad.2.1789664731371;
        Thu, 17 Sep 2026 10:05:31 -0700 (PDT)
X-Received: by 2002:a17:903:1b43:b0:2db:1f50:6515 with SMTP id d9443c01a7336-2dd8dc0f8abmr153788385ad.2.1789664730579;
        Thu, 17 Sep 2026 10:05:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eb7c87sm29904485ad.34.2026.09.17.10.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:05:29 -0700 (PDT)
Message-ID: <6ce4208a-3869-4eea-9ae1-06985c9774e7@broadcom.com>
Date: Thu, 17 Sep 2026 10:05:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] PCI: brcmstb: Put max_burst_size setting in
 cfg_data
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-12-james.quinlan@broadcom.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260911233541.1650895-12-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/11/26 16:35, Jim Quinlan wrote:
> Rather than ascertaining the max_burst_size setting by comparing different
> SoC IDs, specify the setting in the config_data structure for each SoC.
> Also add a comment on each SoC's encoding of this field.
> 
> Note: Previously, the max burst setting used for the 4908 Soc was 2.
> However, it appears that the setting of 2 is illegal for this chip.  Set it
> to 0 as (a) this is the safest (smallest) choice and (b) the 2 was probably
> interpreted by the HW as a 0 anyway.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>   drivers/pci/controller/pcie-brcmstb.c | 29 ++++++++++++---------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 047783e33ae4..8bca98e6f5fa 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -317,6 +317,7 @@ struct pcie_cfg_data {
>   	u32 flags;
>   	u32 quirks;
>   	u8 num_inbound_wins;
> +	u8 burst_setting;
>   	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>   	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>   	int (*post_setup)(struct brcm_pcie *pcie);
> @@ -1153,7 +1154,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>   	void __iomem *base = pcie->base;
>   	struct pci_host_bridge *bridge;
>   	struct resource_entry *entry;
> -	u32 tmp, burst, num_lanes, num_lanes_cap;
> +	u32 tmp, num_lanes, num_lanes_cap;
>   	u8 num_out_wins = 0;
>   	int num_inbound_wins = 0;
>   	int memc, ret;
> @@ -1188,20 +1189,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>   	/* Wait for SerDes to be stable */
>   	usleep_range(100, 200);
>   
> -	/*
> -	 * SCB_MAX_BURST_SIZE is a two bit field.  For GENERIC chips it
> -	 * is encoded as 0=128, 1=256, 2=512, 3=Rsvd, for BCM7278 it
> -	 * is encoded as 0=Rsvd, 1=128, 2=256, 3=512.
> -	 */
> -	if (BFLAG(pcie, IS_BMIPS))
> -		burst = 0x1; /* 256 bytes */
> -	else if (pcie->cfg->soc_base == BCM2711)
> -		burst = 0x0; /* 128 bytes */
> -	else if (pcie->cfg->soc_base == BCM7278)
> -		burst = 0x3; /* 512 bytes */
> -	else
> -		burst = 0x2; /* 512 bytes */
> -
>   	/*
>   	 * Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN,
>   	 * RCB_MPS_MODE, RCB_64B_MODE
> @@ -1209,7 +1196,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>   	tmp = readl(base + PCIE_MISC_MISC_CTRL);
>   	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
>   	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
> -	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
> +	u32p_replace_bits(&tmp, pcie->cfg->burst_setting,
> +			  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
>   	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK);
>   	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
>   	writel(tmp, base + PCIE_MISC_MISC_CTRL);
> @@ -1961,6 +1949,7 @@ static const struct pcie_cfg_data generic_cfg = {
>   	.perst_set	= brcm_pcie_perst_set_generic,
>   	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>   	.num_inbound_wins = 3,
> +	.burst_setting	= 0x2, /* 0=128B, 1=256B, 2=512B, 3=Rsvd */

Not sure this one is much of an improvement, especially if we end up 
repeating the comment, also there is inconsistent decimal versus 
hexadecimal.
-- 
Florian
