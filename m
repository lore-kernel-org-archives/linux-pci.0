Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128307;
	b=K4evQ7XwHCJcr/k2UnnPL3o4WgpvC6tbrasxooimqMZ8/hCJNlrUTYKn3QR49jwtnupy
	 zCdPLp0kluNB/EcJy1wHaN0BfdwGgNJs03isHAAU0MrTxFiwzHyoJfC2MnATCiwyTdWR8
	 McEIxjIakkQBld8GlpB0tvuMeEQ2OHWdxwm/MW61gV1iAywqHfF9+HFNOlRH8UotCuakm
	 SEFGE+cyKD8kzpBohbTlRPcCxKeD8BhyB1mzs/eAFLpMrD8aV7ceMKO7ZLmi4jjYFClRQ
	 n83QrRuo/n0jcDLfhh5Mh1kZ0mW7yP98aI/nrsJbAXHItgKui6sogr29mo7cswAMhuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128307;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=1Z7DDRTiLz4S+Y9ky1zlt3K66s/Vk46YLWiQrEagZjQ=;
	b=oTnsWNmVunzOGC1zjj760peLHUUk0obTP/4XFAtL3MqQou9l/Y4DIQlecgY8lBUJXhNj
	 jCo3AlbP2iXbaoDB1mCN3gum9LIGVtUC14o1go4pzc6DU0X9KqvWivwBJLFDnCSCGSC0o
	 rXas+FsWTXg/S8vO/jETFx51SUL5TolMmA+N+pCzEpT802pLZelx+K8fMXvEwP118J57/
	 /m/2yc3z/bLfWXOYb1+dss+5Ex5bSEPsayoJjOcnRSSBTIORKi/gnE6/kAXIwY55ZSMwo
	 1wUBtpzMGKOz2tCHyknGwz8QA4XzYLp6FXyjZA4D/awPjX/573R7NU3fAPanInYPGxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TlvcMMb4;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE90606A31C;
	Sun,  8 Nov 2026 08:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FE90606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TlvcMMb4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=1Z7DDRTiLz4S+Y9ky1zlt3K66s/Vk46YLWiQrEagZjQ=;
	b=TlvcMMb4LRq8373tAZ00PG8i0w8qNJ4WUt6oeXNdHkA8iUriWcmBPLLqPYUzCM
	RVbNoMrbjXlDOr5T9DeVNqlA4AdZax+2KVQlWNQERMLcJxrBqhOkF69zOHdUVyDx
	ZhhTJZBVnF39ISVxdkJ75DDnXVFK8Z0R3/WRLpd/rwe9M=
Message-ID: <58f35b77-4fb4-4813-a9a3-836345656581@163.com>
Date: Sun, 8 Nov 2026 16:57:54 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
X-CM-TRANSID:_____wD3X+iSOfBqsHL6GQ--.4558S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF43JFy5tr13uFWUAF1kKrg_yoW8Wr4xpr
	s8Ga18CF4rWr18WF4qgws0kas8Za4ktFy0krySgwnF9an5Gr15Ar9IkF9Y9Fn8t398Xr17
	Xwn0v348Wan0gF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziApndUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BNJ7GrwOZPqhAAA3E



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

Hello Bjorn,

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

