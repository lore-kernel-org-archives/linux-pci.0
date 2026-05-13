Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA613C0A07;
	Wed, 13 May 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661015; cv=none; b=hDB3WZ3cLi2zipmuaSq98a95UshMMwu4Fq7WQ2ZGAStD1wNKJTt+/xqEkyQ2dHKNVtWQ5dSRGU6rIfHBVitjKzjSjgxp122ARCz+OQJKoRkChaLkfQFNGpI+nLQ9E1d3aXvKCg2pj0DSc6/Z+8Ruap4yxI3NOmjfz5gOpdQ3iKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661015; c=relaxed/simple;
	bh=fmnq/lqCoLl7NWkXhAV6W/dKWMrlHHnsBhbYKAB5J7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbuCDtal/aVCNdIMJibDtkKBgK5FXhovsslglDz7znbFGuZ8EiH9fwa61IN4uW1SwQEHOyijTt8UgHC9eUcdqpCze72iAlThAeunbbFDXiuwWXLgGYBfCyUODB0bbaUqw6MIIBEasr1WsvfzCTu2Us4nFydpDl9P72jVkBPaU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VIIK6icD; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VIIK6icD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wvHwVCYpGj4rNi0s0J0pc5qX/R9oNsE1tp6/DrolsBI=;
	b=VIIK6icDSiCDqwtprz0RsGe6WJDP/c19PINI9L9w/3aBv1CkCYto2VtsyUTURl
	5qxeDrmBd4NqRj1C3hETltNN7jKq6Aw9RR3WelOHtzj85hYKie+7+xT5X5b74ExA
	sQ1SZoooDHnYMsL42v6zOctT3+KwZhMIRFUeFZHJSL75U=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDX98ZWNgRqlpBpDg--.199S2;
	Wed, 13 May 2026 16:29:13 +0800 (CST)
Message-ID: <e0beb3f0-9a70-476c-8571-73f3b567e7bb@163.com>
Date: Wed, 13 May 2026 16:29:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Aksh Garg <a-garg7@ti.com>, bhelgaas@google.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, hans.zhang@cixtech.com
Cc: robh@kernel.org, mpillai@cadence.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <75d71086-4d44-4dfa-b685-e18888c0c471@163.com>
 <1e5b0f09-c04d-47e2-9657-70eab3d0e415@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <1e5b0f09-c04d-47e2-9657-70eab3d0e415@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgDX98ZWNgRqlpBpDg--.199S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4rZr4DZF1xKw45JF43Wrg_yoWkJwcEy3
	s8A3s7J3WYyFW7ua9rtr45Arn3JanrAr43WF1rJr10k3s8Aw4DGayUuw1fGa1rt3yxWF1q
	gFyUWr4xu3y3XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUq-e7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxk-4moENlmPjwAA3G



On 5/13/26 16:25, Aksh Garg wrote:
>>> Hi Hans,
>>>
>>> The LTSSM state encoding in your patches do not align with the state 
>>> encodings for LGA IP. TI SoCs have LGA IP of Cadence PCIe, and when I
>>> applied your patches, the LTSSM value in the debugfs for the PCIe
>>> subsystem (which have an EP connected to it) came out to be 0x10, which
>>> points to the state "PCIE_L0". However, the debugfs prints the state as
>>> "POLLING_CONFIG_2 (0x10)", which seems to be incorrect.
>>>
>>> The LTSSM state encodings for TI SoCs using Cadence PCIe IP is 
>>> provided in the J7200 TRM section 12.2.3.4.14 at:
>>> https://www.ti.com/lit/pdf/spruiu1
>>
>> Hi Aksh,
>>
>> Thank you for the information you provided. Could you please tell me 
>> how to read this register? Then I will incorporate it into the next 
>> version.
> 
> The code to read the LTSSM state for LGA IPs in your patch:
> ```
> reg = cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
> ltssm = FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, reg);
> ```
> correctly reads the LTSSM state for TI SoCs which uses LGA IP.

Hi Aksh,


Thank you.


Best regards,
Hans

