Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D348423C;
	Fri, 11 Sep 2026 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133126; cv=none; b=Ypt8IypBXrus4jKLsnyzGR0SuEIQ2flSSdsvLc6RFxLfPRnN3d9bb7VGcGB3FEAm4k2vWAtY8J0Rg6V6kpaMaEPoC+0XFOF1Hwm2Tpk3MKRkMXu5S2hAo3dssefz4WZxvTCq5sCC2W3gLzERsY3n9GLasrYb1qLf6NAsx0gfZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133126; c=relaxed/simple;
	bh=Foyo/WbRI9GTL0ov1byfGqJSsLs3Cyh9aGVQtghA2U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlkr1BdyjW9Ty4919XGQ8L3K8XcC0MUxFfK1XcCSJG751RZovm6vqLu3ky+sd/GL++UMI+cQVeHBVUCfqOLJN/yHDOB908mk2NwndSdnjavH0XhCrDcgBIy0TVdrI1sTF+HF1Om7g/e/7PoUoeFmdXVnkrtxHT0HR7e5QethHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nlVqxUcD; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nlVqxUcD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Qkw3B5gs6z18dUvZ2oYot6I2aIm8IxFFKnSjUST1Lxk=;
	b=nlVqxUcDubEzUK6+rn4a6b7LGNfc3QZhSzXYSeDk0t9jVv/tA3wTQGjclt169B
	oGUudJNEN5PG6twf3tN9FrWtmNnOyCg6itQGVfBrZqRBpCo0xNmObIfpTeR3OGBL
	tjivroSFiY+kGJtI8/C3swp/EGCbXKKkUuf9Mx2ZgfMzY=
Received: from [IPV6:240e:b8f:91b3:d000:8f8f:b76e:3756:1454] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3f7QgAaRqAxtLAA--.22907S2;
	Fri, 11 Sep 2026 21:24:48 +0800 (CST)
Message-ID: <a170c630-6dc7-4f22-a655-e5fd3d6a6e67@163.com>
Date: Fri, 11 Sep 2026 21:24:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VPD: Add Realtek 8126 to VPD blacklist
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522114135.2104890-1-18255117159@163.com>
 <lfml4kmr4r3l44hcx7vfrcks2z355ri5emr5umynnzoncyopjl@5to6f3e67owz>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <lfml4kmr4r3l44hcx7vfrcks2z355ri5emr5umynnzoncyopjl@5to6f3e67owz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3f7QgAaRqAxtLAA--.22907S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF43JFy5tr13uFWUWF4fuFg_yoW8Wr4Upr
	s8Ga18CF4rXr18WF4qgws0kas8Za4ktFy0krySgwnF9an5Gr1UAr9FkF9Y9F1Dt398Xr17
	Xwn0v348Wan0qF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziLZ2DUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wAMr2qkASBz3wAA3L



On 7/15/26 21:44, Manivannan Sadhasivam wrote:
> On Fri, May 22, 2026 at 07:41:34PM +0800, Hans Zhang wrote:
>> The Realtek 8126 Ethernet controller advertises VPD capability but
>> returns invalid data when VPD is read, leading to kernel messages
>> like:
>>
>>    r8169 ... invalid VPD tag 0x00 (size 0) at offset 0; assume
>>    missing optional EEPROM
>>
>> and pcilib reporting "sysfs_read_vpd: read failed: No such device".
>>
>> Add the device to the VPD blacklist to suppress these errors.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 

Hello,

Gentle ping.

Best regards,
Hans


> - Mani
> 
>> ---
>>   drivers/pci/vpd.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index 153394a652d3..fbc34cd842ac 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -590,6 +590,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8126, quirk_blacklist_vpd);
>>   /*
>>    * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
>>    * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
>> -- 
>> 2.43.0
>>
>>
> 

