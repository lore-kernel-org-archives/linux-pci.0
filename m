Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AFB3B2FFE;
	Tue,  7 Apr 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564443; cv=none; b=o3vDu7hq1I3fMne8pl1mFoMycH6HCuOGo3dvqzM36RoBMVE3nKzymTjv6S0f3bg1jrmOzG88WkJ4M+EtiN3oVw4Nc20Ou9cBMuVQQr8KiAM/v4E+1mWOEijczP7QQoVsKGaKpnLPgOge+G3PmqIF28DnMwLyyI5MjOL2f91uNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564443; c=relaxed/simple;
	bh=sJ1CTkKLhj3L+D33YKXHmLr8TA6o0L7i+LTHndBHGpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9hu11uCYmHGyXXAA23Mb1mBZWP9YXOlZv0YML4KNLQX8BH1K9iVo5CCaayQkMqM6g76i+2yvRAL7NLct/JZqcaU6n4cf0xagIfc6ATuvZXeTZ8li6e3JZevdAZfXD8ImnvIdWMK2JWI1rwpyVly9zsTYJqPNgm9MbjihEnC3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=es7zoXUD; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="es7zoXUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AJ1ahH9SZN4eFME6rHz8JB+EKEGZ/RYfk3cSrKWdd+c=;
	b=es7zoXUDnh/kDjAHKV7EqOomfYNGyQfTDNYDNXgYA6ctlExLCacMCGb//36/T/
	qj333YmwexFryA4uLw5IfRkqBTg/wJApoaQSO06y/5LRBC0C5O43LBc0IkL1Oojj
	VmAOc6J7/S2+T8MDUalLdYWk4eA0a73d/Fs3EH9e2zWrY=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnwn9s9tRpbNOQAA--.143S2;
	Tue, 07 Apr 2026 20:20:00 +0800 (CST)
Message-ID: <70f81184-4900-499b-a6ee-fbe18367bd0a@163.com>
Date: Tue, 7 Apr 2026 20:19:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: dwc: Use common speed conversion function
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
 robh@kernel.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260406105613.1228673-1-18255117159@163.com>
 <20260406105613.1228673-4-18255117159@163.com>
 <d2bb9eae-8731-b438-87dd-fcbcf2a17551@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <d2bb9eae-8731-b438-87dd-fcbcf2a17551@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCnwn9s9tRpbNOQAA--.143S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW3Kw48Ar48JF17Gw4rXwb_yoWrtr13pa
	y3ZF40yF18Jr15ua1q9a4kXa4jqFnxCrWDGFZ8WF95WFy2yas3GF40yr1ft34akrs2yr12
	9w17JrWUC3W7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UerWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBBpDWnU9nDKFAAA3V



On 4/7/26 16:25, Ilpo Järvinen wrote:
> On Mon, 6 Apr 2026, Hans Zhang wrote:
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
>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 06792ba92aa7..ab8dee5d6c7a 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -861,24 +861,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>>   	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>>   	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
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
>> +	link_speed = pci_bus_speed2lnkctl2(link_speed);
> 
> Its signature is:
> 
> u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> 
> Using link_speed variable both for in and out does contradict with the
> expected typing.
> 
> Maybe it would be beneficial to rename the current 'link_speed' to
> 'ctrl2_speed' (or something along those lines) to differentiate Link
> Control 2 speed representation from PCI core's internal link speed
> representation. And then reintroduce link_speed variable as the
> pci_bus_speed. ...But this is just my suggestion, there may be better ways
> to untangle this type abuse.

Hi Ilpo,


Thank you for your review comments. This way it will be clearer. Here 
are my revisions. If there are no issues, I will send the next version.


diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
b/drivers/pci/controller/dwc/pcie-designware.c
index 06792ba92aa7..21a709a47e82 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -843,8 +843,9 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);

  static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
  {
-       u32 cap, ctrl2, link_speed;
+       u32 cap, ctrl2, pci_bus_speed;
         u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+       u16 ctrl2_speed;

         cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);

@@ -861,30 +862,18 @@ static void dw_pcie_link_set_max_speed(struct 
dw_pcie *pci)
         ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
         ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;

-       switch (pcie_get_link_speed(pci->max_link_speed)) {
-       case PCIE_SPEED_2_5GT:
-               link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
-               break;
-       case PCIE_SPEED_5_0GT:
-               link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
-               break;
-       case PCIE_SPEED_8_0GT:
-               link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
-               break;
-       case PCIE_SPEED_16_0GT:
-               link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
-               break;
-       default:
+       pci_bus_speed = pcie_get_link_speed(pci->max_link_speed);
+       ctrl2_speed = pci_bus_speed2lnkctl2(pci_bus_speed);
+       if (ctrl2_speed == 0) {
                 /* Use hardware capability */
-               link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
+               ctrl2_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
                 ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
-               break;
         }

-       dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | 
link_speed);
+       dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | 
ctrl2_speed);

         cap &= ~((u32)PCI_EXP_LNKCAP_SLS);
-       dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
+       dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | ctrl2_speed);


Best regards,
Hans

> 
>> +	if (link_speed == 0) {
>>   		/* Use hardware capability */
>>   		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>>   		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
>> -		break;
>>   	}
>>   
>>   	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
>>
> 

