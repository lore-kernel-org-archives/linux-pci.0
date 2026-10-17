Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8C3C7E19;
	Sat, 17 Oct 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258435; cv=none; b=DumClviVyA2+wiZhpkkNJJvPWuxR8FvSIbxQW2cznj5felM4o8EyHA7sXV0rE+USJvEMhTo5dyR/FgqYgf6aFhO3gocUKxE5bSHA2CxqB0rmoBKvFKr7A1qbFNjNXnBKzj8aQCZfZb16DCiZTyfITvE/cAkbxyye24CfP57gONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258435; c=relaxed/simple;
	bh=sUMtSjJfH1Hc2Rb0srMs7Cu3KDrbOZILBwySp6UMGhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7kIcHCbIF1CQI8V8TR6YB41miqx3UwmX2F6baGonkACMIMdk5If4GEz8xjULsFV+K8EiWEM4B1jbUDLQp8QYH8Ycd5lTCZXziPrD0ktohGxNNpA6FFTtqTNl4ApZ3pAebmrUul1vTNuv/5IvqGgs8aD7WJb9x0+H73lAGvZ7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ht5vrwyE; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ht5vrwyE"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j6TSH0PqlzMlJf;
	Sat, 17 Oct 2026 19:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQcUAi6MSkLaCexc0ZzSlMbqTFUROvz0PGaISaVK38A=;
	b=ht5vrwyEXe1MmJR/VXBRbkVY2fVUtrLL5E3WwdpDVo8iaESYeFsS4hbKbpRXb0nQwJbxV+
	J/Jirm2+UI1PqkQT0oO3niVcbWH08YWDVIcKJZUiY6/EXOfmt07dPFcEbxkZ9RBLJwSq8C
	QWqiZy3NKOs6YTxPkJ2cHb/2GNCaroQyaG0RNorS3OE2wgQjW4HSUFzuSse3LQuRbyLQRT
	l/tMxrJPOUxxdq70ecioFZyYK0yrLpwBuDbHzrPYgTpjtqcyiivJv2HGh6lSgXdLRulTj/
	XvSdpULrp8OtyNh6Oyc1t0aj1sChCsYBagY+H9t+lJprQwPk7eFQCA4pCTlWPA==
Message-ID: <cba6b5db-d610-45d7-85e9-30ccf0a659f6@mailbox.org>
Date: Sat, 17 Oct 2026 19:01:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: rcar-host: Validate IO/MEM resource count in DT
 ranges property
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20261005233758.GA646371@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261005233758.GA646371@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d0ad517624d8bf8c23f
X-MBO-RS-META: jzgfbkmkmm44umbxituzuuidegm4rezp

On 10/6/26 1:37 AM, Bjorn Helgaas wrote:
> On Sat, Oct 03, 2026 at 09:35:59AM +0200, Marek Vasut wrote:
>> The R-Car Gen3 PCIEC controller supports up to 4 memory area mappings.
>> Count the IO and MEM ranges described in DT 'ranges' property of the
>> controller DT node, and in case there are more than 4, refuse to probe
>> the controller driver, because such DT does not describe valid hardware
>> configuration. Do the IO and MEM counting early to avoid controller
>> configuration rollback in case of failure.
>>
>> Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>>   drivers/pci/controller/pcie-rcar-host.c | 31 +++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
>> index cd9171eebc289..4bcc8c3051ac4 100644
>> --- a/drivers/pci/controller/pcie-rcar-host.c
>> +++ b/drivers/pci/controller/pcie-rcar-host.c
>> @@ -341,6 +341,32 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
>>   		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
>>   }
>>   
>> +static int rcar_pcie_validate_resource_count(struct rcar_pcie_host *host)
>> +{
>> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>> +	struct rcar_pcie *pcie = &host->pcie;
>> +	struct resource_entry *win;
>> +	int i = 0;
>> +
>> +	resource_list_for_each_entry(win, &bridge->windows) {
>> +		struct resource *res = win->res;
>> +		unsigned long type = resource_type(res);
>> +
>> +		if (!res->flags)
>> +			continue;
>> +
>> +		if (type == IORESOURCE_IO || type == IORESOURCE_MEM)
>> +			i++;
>> +
>> +		if (i > RCAR_PCI_MAX_RESOURCES)
>> +			return dev_err_probe(pcie->dev, -ENOSPC,
>> +					     "Too many IO/MEM entries in DT 'ranges' property, limit is %d\n",
>> +					     RCAR_PCI_MAX_RESOURCES);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
>>   {
>>   	struct rcar_pcie *pcie = &host->pcie;
>> @@ -947,6 +973,11 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>   	host = pci_host_bridge_priv(bridge);
>>   	pcie = &host->pcie;
>>   	pcie->dev = dev;
>> +
>> +	err = rcar_pcie_validate_resource_count(host);
>> +	if (err)
>> +		return err;
> 
> I guess you did this here to avoid rolling back controller config, but
> the code would be a lot more readable if it checked the index at the
> point where it might exceed the array bound, e.g., (I think) in
> rcar_pcie_set_outbound().

All right, I'll send a v2 like that in a bit.

I also found another issue triggered during irq_dispose_mapping() in 
probe fail path, I want to fix that too.

(sorry, I'm still catching up on emails, hence my slow response)

> This is for an invalid DT, which is unlikely.  What if
> rcar_pcie_set_outbound() just printed a warning and ignored any excess
> windows?
I'd say it is better to simply reject the invalid DT and fail to probe 
the controller driver, esp. since it is unlikely there are such invalid 
DTs and users should really fix that problem instead of being surprised 
by the missing windows. What do you think ?
