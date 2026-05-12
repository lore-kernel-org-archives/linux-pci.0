Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09921448D5
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546701; cv=none; b=PIQyEB0lGiSB6IzLtDApCPtWnuiD8x5JqYQeWTGpi4XUgVKtUO2jtGZo3SRRCecr6mtw3OvOOw3U1LhD993kxq6YKxboYPyhHLsMQfIGe7Fbav81grJ5F2TpKU44ruGYgUc0N2h86xtqPjRbX0gIcO7d1IjPgcbq2UiMRclG9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546701; c=relaxed/simple;
	bh=Qb6skaRFvARfQituJbTnVTEdzNhiETeENg6NcMq2z3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rth+UdkI02cYa+Is4l9A4p223iR1WZ4cSbmYUVpyxq8SCJ2DEpVygpsbHt/Ra9oxOGnrpz/7bO3FAl2QDE2rgIitQ2pE56PwhzOSM3u0PLi/hXPMRgfheTHz56sdmQkvcxgT+PKlM0s433kzxz/ONUUQ4Kkv0od1IoFvhTDoyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nnNhBqO+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nnNhBqO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=IVtRKKYH3GrG84xaJANJeNCyAfAgs7lgPSkb+N9RnpQ=;
	b=nnNhBqO+Iyc5SeW2Sewqpuzwcr/jesOwtA13DiAOXzfxus0/YO+6lilE435+vL
	eatKs8hbQLgH5+TfllMLAh277tO3q/ikO80MHIMYK/EP7iAyxFA35qUFsdk7w8Wi
	SNtlo/aOGTxmGkMnPYPvyaLgpIx/GFZx+3JW49wfdvJtA=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3qgv0dwJqg4yVEA--.4946S2;
	Tue, 12 May 2026 08:44:36 +0800 (CST)
Message-ID: <7bbe1c68-6829-4d1b-ba81-acc5af89d5a1@163.com>
Date: Tue, 12 May 2026 08:44:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] PCI: cadence: Add post-link delay for LGA and
 j721e glue driver
To: sashiko@lists.linux.dev
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
References: <20260511055923.37117-3-18255117159@163.com>
 <20260512002408.101ADC2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260512002408.101ADC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgC3qgv0dwJqg4yVEA--.4946S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW8KFWUJw4xWryrKrykZrb_yoW8ArWfpF
	W7u3yfWF48XrW5WanrA3W5X3Waq3Z5C3yUGrsagw18XF1akr9xGFy2qFyfCa9akFZrAw1x
	Xwnxtw12gw1avFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKYLyiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xQ22WoCd-TncQAA3t



On 5/12/26 08:24, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Compilation error in `j721e_pcie_set_link_speed` due to incorrect structure member access on a pointer.
> --
> 
> commit b3897a7e50194e1f9cc94b232c615c7f8f651006
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: cadence: Add post-link delay for LGA and j721e glue driver
> 
> The Cadence LGA PCIe host controller lacks the mandatory 100 ms delay after
> link training completes for speeds > 5.0 GT/s. This commit adds a
> max_link_speed field to struct cdns_pcie and inserts the required delay
> after the link has been successfully established.
> 
>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>> index bfdfe98d5aba7..ee85b8e04f5b8 100644
>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>> @@ -206,6 +206,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
>>   	    (pcie_get_link_speed(link_speed) == PCI_SPEED_UNKNOWN))
>>   		link_speed = 2;
>>   
>> +	pcie->cdns_pcie.max_link_speed = link_speed;
> 
> Will this cause a compilation error?

Sorry. Will change.

Best regards,
Hans

> 
> Looking at struct j721e_pcie, cdns_pcie is defined as a pointer:
> 
> struct j721e_pcie {
> 	struct cdns_pcie	*cdns_pcie;
> 	struct clk		*refclk;
> 	...
> };
> 
> Does this need to use the arrow operator instead of a dot
> (pcie->cdns_pcie->max_link_speed) so it correctly accesses the
> max_link_speed member?
> 
>>   	val = link_speed - 1;
>>   	ret = regmap_update_bits(syscon, offset, GENERATION_SEL_MASK, val);
>>   	if (ret)
> 

