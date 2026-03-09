Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com [220.197.32.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC622D4DC;
	Mon,  9 Mar 2026 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017626; cv=none; b=JGBmGy42GBD2xhT1QigiAwqNct+z08jKbxr/sdu1zQyOPWNbKNVsF34ZFoAeyah2edvUOOEX7VQR9u1679wnT4MyJqwp1RpfwNhg2LYkWZmugCsYJWdX+h3oK7VC5H/fa0QLJnnFNoDODB55D5Bc2Ui1YXatqmD6bV7pneWPhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017626; c=relaxed/simple;
	bh=oqadouO5boXOluf4D4wATX3jaZxsUbZr1IBC2YTyJuw=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hsr1lDiohf1VJNZzJK6Pw8UVg1o9YCGDQvRvwM6AWe+ogtUX46Ex7mB3jP2tTA12z9MQ6HzoK15JbECdV0JAtgtgw1as2ecJxE38jSH6Rd6rMT9PnyN5K1e+kfbnPZ9PioBCupA9BC01EWZJlvkDA12+8hpI4uxskMf2BI38Wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Im2J6y5g; arc=none smtp.client-ip=220.197.32.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Im2J6y5g"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 362a57f85;
	Mon, 9 Mar 2026 08:38:15 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, robh@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] PCI: of: Remove max-link-speed generation
 validation
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
 jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, helgaas@kernel.org
References: <20260308142629.75392-1-18255117159@163.com>
 <20260308142629.75392-2-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <0c558d65-edca-f3a9-9e31-01d30a206e7f@rock-chips.com>
Date: Mon, 9 Mar 2026 08:38:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260308142629.75392-2-18255117159@163.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cd007c0a809cckunma97e204415ca26f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9CQlZKGU8eSRpCTR0fHhhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Im2J6y5gzvtqCenZ61pUK7EnCPI3y/YG1W5NT6MaGSEqd4du2lGSpcN2EOZvZNw4hCZWsKFpFjaA6cdj80LKuCdoPqIN9lo4wCd4BGkcRI8ql2OuJeZm0wrna91FIvaOnJIlxyQYOCop/wQfO/3tdnDwgCkjo8vJ2KQKeFkk2pE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=UG0fG4FpvswsWNFhQ45rHCRTKgbDLXR8HEAwDGADYj8=;
	h=date:mime-version:subject:message-id:from;

在 2026/03/08 星期日 22:26, Hans Zhang 写道:
> The of_pci_get_max_link_speed() function currently validates the
> "max-link-speed" DT property to be in the range 1..4 (Gen1..Gen4).
> This imposes a maintenance burden because each new PCIe generation
> would require updating this validation.
> 
> Remove the range check so the function returns the raw property value
> (or a negative error code if the property is missing or malformed).
> Callers must now validate the returned speed against the range they
> support.  A subsequent patch adds such validation to the DWC driver,
> which is the primary user of this function.
> 
> This change allows future PCIe generations to be supported without
> modifying drivers/pci/of.c.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>   drivers/pci/of.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 9f8eb5df279e..cff5fd337c2b 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -889,10 +889,11 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
>   int of_pci_get_max_link_speed(struct device_node *node)
>   {
>   	u32 max_link_speed;
> +	int ret;
>   

Should update the comment of this function, as it states:
"-EINVAL    - Invalid "max-link-speed" property value...
a negative value if the * required property is not found or is invalid."

So it won't validate the speed after this patch. Perhaps it's even
better to note the caller to take the responsiblity to validate it.

> -	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> -		return -EINVAL;
> +	ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
> +	if (ret)
> +		return ret;
>   
>   	return max_link_speed;
>   }
> 
