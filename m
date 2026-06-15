Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9223C4E9;
	Mon, 15 Jun 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536689; cv=none; b=QkDu7wpP0oxR8zQXYL9TGKN5Gy/grrfd4Oq2JB5X6i2WkWLY9E1oEfQz69jUjvltWXrBP7/KsfyVdd+VUTJdThwL/5yZCquP49pZqiFURkV3eJAH4es5qna6lI49l5sbyQ/UFo3Ldcy99TGfqEJlWXH4SEkFLyzGW+lcz5U9VZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536689; c=relaxed/simple;
	bh=noiJi8Wd9wt+o2xna8dhOPXtOPWLQNlTkIiDX92fN6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLFZwxghfAOChSs0QWlwFN8xqMABcy5hLrqIiMFi9HC00yNd9o9tNdb7wD2caVoIcx+9SIXvq5yqMZvkHmBBl/VvLpNJcQFNDqONipDSCZ6iv+vqKtkk0CmCYscr6CFSp06ZNvtQtpYzFW+dgwMMgZ1oRju9lbL/XOqs16GDoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HAyg4K0/; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HAyg4K0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=9eV7TnAbI8CXkbKmeKz2CXP0paY4MnrJtdk37jVX5GE=;
	b=HAyg4K0//30rJ1L23A9Fd6sw6jOBtxdj4X8ydOsFd3Cbivpvi++eB2nLerYH/Y
	R+N22LbtKsnxjpg6GTtbU/yXxp7eLnZ0rr11WTVyWp/AksuhU2tXZ542DZExMblH
	kRIoxxbbuhZj3A8X47aAbip5OIKjJXEVzqY4OyCI2aq1Q=
Received: from [IPV6:240e:b8f:91b3:d000:367d:ab80:34a0:4b1f] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXMyCAFzBqUaLTDg--.32959S2;
	Mon, 15 Jun 2026 23:17:21 +0800 (CST)
Message-ID: <5b30e9d8-21a9-460a-854e-02ca1968f4bc@163.com>
Date: Mon, 15 Jun 2026 23:17:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] PCI: dwc: Use common speed conversion function
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
 robh@kernel.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20260407130450.1489318-1-18255117159@163.com>
 <20260407130450.1489318-4-18255117159@163.com>
 <9fed4498-0218-872c-0fb2-92c33c8726b7@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <9fed4498-0218-872c-0fb2-92c33c8726b7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXMyCAFzBqUaLTDg--.32959S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4UWr1xtry3Cr1UtrWDArb_yoWrGF1Upa
	9xAF4YyF18Jr43Za1qgasYva4UXFnxCr4UJF98WF95ZFyakas3KF40kr1ft342krZ2yr1I
	vr1UJrZxC3W7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5nYwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwGMMGowF4EQxwAA3l



On 6/12/26 01:55, Ilpo Järvinen wrote:
> On Tue, 7 Apr 2026, Hans Zhang wrote:
> 
>> Replace the private switch-based speed conversion in
>> dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
>> function.
>>
>> This eliminates duplicate conversion logic and ensures consistency with
>> other PCIe drivers, while handling invalid speeds by falling back to
>> hardware capabilities.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++-------------
>>   1 file changed, 9 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 06792ba92aa7..10895f6a8e6e 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -843,8 +843,10 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>>   
>>   static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>>   {
>> -	u32 cap, ctrl2, link_speed;
>> +	u32 cap, ctrl2;
>> +	enum pci_bus_speed link_speed;
>>   	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +	u16 ctrl2_speed;
>>   
>>   	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>>   
>> @@ -861,30 +863,18 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>>   	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>>   	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
> 
> Not directly related to this patch but I wonder why this function gets the
> speed from LNKCTL2 instead of taking it from LNKCAP2_SLS.

Hi Ilpo,

Thank you for your review and the helpful observations.

Regarding the use of LNKCTL2 vs LNKCAP2_SLS – I will investigate the 
current design choice in dw_pcie_link_set_max_speed() and see if there 
is room for improvement in a future patch.

Since you have no objection to this change, I will keep this patch
as is for now. I'll put the points you raised on my TODO list for
potential follow-up cleanups.

Thanks again for your time.

Best regards,
Hans

> 
>>   
>> -	switch (pcie_get_link_speed(pci->max_link_speed)) {
>> -	case PCIE_SPEED_2_5GT:
>> -		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
>> -		break;
>> -	case PCIE_SPEED_5_0GT:
>> -		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
>> -		break;
>> -	case PCIE_SPEED_8_0GT:
>> -		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
>> -		break;
>> -	case PCIE_SPEED_16_0GT:
>> -		link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
>> -		break;
>> -	default:
>> +	link_speed = pcie_get_link_speed(pci->max_link_speed);
>> +	ctrl2_speed = pci_bus_speed2lnkctl2(link_speed);
>> +	if (ctrl2_speed == 0) {
>>   		/* Use hardware capability */
>> -		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>> +		ctrl2_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>>   		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
>> -		break;
>>   	}
> 
> I again lament a bit that pcie_capability_read_*() cannot be used early in
> the controller drivers, which might allow using e.g.
> pcie_get_supported_speeds() here (depending on whether the small
> differences this function has compared it are really meaningful or not).
> 
> But this is not really a problem this series is trying to address so as
> stated in my comment to the other patch, no objection to this change.
> 
>> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
>> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | ctrl2_speed);
>>   
>>   	cap &= ~((u32)PCI_EXP_LNKCAP_SLS);
>> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
>> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | ctrl2_speed);
>>   
>>   }
>>   
>>
> 

