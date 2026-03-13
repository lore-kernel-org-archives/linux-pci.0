Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com [220.197.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B87364943;
	Fri, 13 Mar 2026 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385828; cv=none; b=SGGUX79B9vUyb89zEDdM+JAoWsgPwP5GnBgsN7/AoncoMWluw84MnBg1GM9hJxLz3RrGF+FUh5qUKxBecz9Cy8nd34ZRR6z2L1psIcW3gaaXr/T2P5efHNUEphDGrqiCJut2/QbRLcSVO57bYYyBKO8WGHZ6mfOuxuJ8pGPCIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385828; c=relaxed/simple;
	bh=FzhcRqA7yckGocPIkjx5upnX4gCmTMBT6vfh5S1xWxs=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EMFwGuMlklhFhC8tVsijGS2I9FqKXys4Je6+0UYyUdlY1qe3ZQtao4DO93tEgYyr8j27a75SBHRSIF2kcELspVBnELuVS7wO7NgULo5SMxdgvTWq4jraB1yTNoEs0kBpc0AvgktqzpXqSwiLV2agzv0f1Qey8t9OOJdPitu98tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JzZpZOrh; arc=none smtp.client-ip=220.197.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JzZpZOrh"
Received: from [192.168.61.151] (unknown [110.83.51.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36d232d0a;
	Fri, 13 Mar 2026 15:05:00 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, robh@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] PCI: of: Remove max-link-speed generation
 validation
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
 jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, helgaas@kernel.org, florian.fainelli@broadcom.com,
 jim2101024@gmail.com
References: <20260312163652.113228-1-18255117159@163.com>
 <20260312163652.113228-6-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <44e74dff-c321-7cfe-e304-a21644ac7787@rock-chips.com>
Date: Fri, 13 Mar 2026 15:04:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260312163652.113228-6-18255117159@163.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ce603472b09cckunm7514b9b4e3126
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0IZVkpPSxpIGhgZSUtLS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=JzZpZOrhxa/p+OxsGMsQFBDF5BmwYT/jD9es/4d2sYQDihM0+OEkYVO2RfHRWGr/vm5MJ0hubEDkQvQa38A1Dfuf1ZAa/0pUGvHKzllpRUYyZ1dmGteisUVSGQW/Qo2e8A0b7YOZgSX9+IObi8GJtscky6tOipCyAPIfkGeTA28=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=f3xm6U44fEGSntAWOFNv+gR52dvtb+FgLKg5beQSpUM=;
	h=date:mime-version:subject:message-id:from;

Hi Hans

在 2026/03/13 星期五 0:36, Hans Zhang 写道:
> The of_pci_get_max_link_speed() function currently validates the
> "max-link-speed" DT property to be in the range 1..4 (Gen1..Gen4).
> This imposes a maintenance burden because each new PCIe generation
> would require updating this validation.
> 
> Remove the range check so the function returns the raw property value
> (or a negative error code if the property is missing or malformed).
> Callers must now validate the returned speed against the range they
> support. A subsequent patch adds such validation to the DWC driver,
> which is the primary user of this function.
> 
> Removing the validation from this common function allows future PCIe
> generations to be supported without modifying drivers/pci/of.c.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/of.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 9f8eb5df279e..fbb779a94202 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -875,8 +875,9 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
>    * of_pci_get_max_link_speed - Find the maximum link speed of the given device node.
>    * @node: Device tree node with the maximum link speed information.
>    *
> - * This function will try to find the limitation of link speed by finding
> - * a property called "max-link-speed" of the given device node.
> + * This function will try to read the "max-link-speed" property of the given
> + * device tree node. It does NOT validate the value of the property (e.g.,
> + * range checks for PCIe generations).
>    *
>    * Return:
>    * * > 0	- On success, a maximum link speed.

Thanks for the patch. However, after applying it, I noticed this part
still seems off. There is a detailed comment in the file saying this
function checks if the max-link-speed is invalid, just a few lines below
your change. Could you please take another look at that comment and
adjust them?

> @@ -889,10 +890,11 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
>   int of_pci_get_max_link_speed(struct device_node *node)
>   {
>   	u32 max_link_speed;
> +	int ret;
>   
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
