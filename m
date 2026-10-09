Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com [117.135.214.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64812868AB
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505809; cv=none; b=EWctgvvgCylATiyNz8Mx9K5McehK5uxIhlyxT9OzRo97QyAn5jqWKZVsG5nsCZmsSfe3putuzdqEHmRrNippWRsoikFGTa3TGDtXUZ5ikk4jKFGpRGyI2adKoFa4lxT24wepy4v9x1B9To6i92Gum7jmIyO3B8yEklD2FVQN784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505809; c=relaxed/simple;
	bh=uyjzSoPvk6w3FkZj3H2N/SqjfZe4KizfEFG+exuvAf0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pw+Kzjk0AwQLr+4nRTesbDW59PchwrEWDyWlAYUeFv3VTEyWkJqzqRvYYiiQcdh/BHHG8a9bu6b7jqwo+CmKjSQdNRgmtM34977qDmm6b+OXU2aEjsQH90qK44OuxguXw20co80Kh2+iKWqwRn+etlSQWRs9mzpM2WUkPAOT+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AGWvmOcY; arc=none smtp.client-ip=117.135.214.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AGWvmOcY"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 505bcb933;
	Fri, 9 Oct 2026 08:24:48 +0800 (GMT+08:00)
Message-ID: <b90aa993-97dd-4551-a75c-c327f19f5527@rock-chips.com>
Date: Fri, 9 Oct 2026 08:24:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy devices created by pwrctrl core
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20261008233211.GA941209@bhelgaas>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261008233211.GA941209@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa11e0c593003a4kunm437b8f42dc16cd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUpOVkofSB5JSh0eSksdQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=AGWvmOcYTKQpAa5hGhu67pHIZELd49PzzkQJ34Kz9E4Ib+rfN/SeSAgXrtepgq9NBoC7v3CD9dD72i/jA7XJbr94J4kcOvGlrb6BRVAiINGsPP/bBPRs/O1SzHXl4rB4PmjLLOj0on9cAYZwUfZWupyYfMGF6NhnTUqltrRtd6Q=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ocE2w66/6I4qP+A05/n4/ej/QMHwRX+4Qxl9ZIpZSoc=;
	h=date:mime-version:subject:message-id:from;

Hi Bjorn,

在 2026/10/09 星期五 7:32, Bjorn Helgaas 写道:
> On Thu, Oct 08, 2026 at 04:05:00PM +0800, Shawn Lin wrote:
>> pci_pwrctrl_create_device() only creates platform devices for OF nodes
>> that pci_pwrctrl_is_required() accepts, but pci_pwrctrl_destroy_device()
>> unregisters the platform device of every available child node without
>> that check.
>>
>> Nodes under a PCI host controller that are not pwrctrl devices may have
>> been populated by another mechanism.  Destroying them here would tear
>> down devices owned by other code.
>>
>> Mirror the check done at creation time so that only devices created by
>> the pwrctrl core are removed.
>>
>> Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Applied to pci/pwrctrl for v7.4, thanks!
> 
> Tearing down devices owned by other code sounds like an issue; maybe
> this should have a cc: stable tag, since 4c4132489201 appeared in
> v7.0?
> 

It would be better if this could be backported to v7.0, so it's fine for
me to cc stable.

>> ---
>>
>>   drivers/pci/pwrctrl/core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
>> index 10d817a..c14df11 100644
>> --- a/drivers/pci/pwrctrl/core.c
>> +++ b/drivers/pci/pwrctrl/core.c
>> @@ -388,6 +388,9 @@ static void pci_pwrctrl_destroy_device(struct device_node *np)
>>   	for_each_available_child_of_node_scoped(np, child)
>>   		pci_pwrctrl_destroy_device(child);
>>   
>> +	if (!pci_pwrctrl_is_required(np))
>> +		return;
>> +
>>   	pdev = of_find_device_by_node(np);
>>   	if (!pdev)
>>   		return;
>> -- 
>> 2.7.4
>>
> 

