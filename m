Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0331AF25;
	Fri,  6 Feb 2026 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363649; cv=none; b=ND+TNJ5HJ/lcWAtA48HFdIUdxOnjIblJ9FR+hWCBIswiqN2ypGWLRlWGsf1vgbvIkQE80WPlUF5khjoZgByaKaiPBAnnUuX5UpQQNRhQTLTF0hGB9jYvqeYkj/yq+3qOWkPejib3rV0ocufMWZRTiHk/2H+IRTvfqhcN8KKNawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363649; c=relaxed/simple;
	bh=EPrUScskHy6vTlP/uJrxGOtfopdTixn54ogLv4A4OC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+SBF6gbL8aHgLCKY4aqVkTwe569RXtnj4HgVNcj2+TEw3RbJMXaQU/ETXh0wMJ4NMztJK+aijAg89d2JkjbGzaMcAPmFpvlrNiqJHz2WQNiuXaVzyPnvN9F20T1mqO1szCO36jq+OfekhIM39ay0AWXJGjGeJwKtCFmMSaxKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XXphp19B; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XXphp19B"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770363637; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZM3jUVWnJ9uaVrG3aDHcVLfZjBoDdiCFav4GZo0g+kc=;
	b=XXphp19BXx9ldY9g4+VUsa0pdkXCQTFUyx6dXRgCeFd1knrOeHy0+Bubhdl2IlweMRginkYuSDQtEDbcSuXhxWj+IDhd3zyQehEt1NGe1X6SZHsilnqFYMJ1iJz1RDSVnPWw1D4MwzvUDMuHBoE2dR8KBbQVWfFen+Uj/T8cD2M=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wydse.a_1770363635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 15:40:36 +0800
Message-ID: <aceba0b1-b198-492d-b8c2-073a2b933b18@linux.alibaba.com>
Date: Fri, 6 Feb 2026 15:39:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
 <aYGpgSztxNMZO-oC@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYGpgSztxNMZO-oC@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/26 3:53 PM, Lukas Wunner wrote:
> On Sat, Jan 24, 2026 at 03:45:57PM +0800, Shuai Xue wrote:
>> +++ b/drivers/pci/pci.c
>> @@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>   	u16 sta;
>>   
>>   	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & PCI_EXP_DEVSTA_ERR);
>>   }
> 
> I don't think there's any harm to write error bits which are currently 0,
> so I'd just get rid of the pcie_capability_read_word() and directly write
> the error bits.

Good point. I will remove the read step.

> 
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -534,6 +534,7 @@
>>   #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
>>   #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
>>   #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
>> +#define  PCI_EXP_DEVSTA_ERR	0xf	/* Error bits */
> 
> There's only one user of PCI_EXP_DEVSTA_ERR and it feels a little
> awkward to define a macro in a uapi header which does not correspond
> to an "official" bit definition but is just there for convenience.
> 
> So maybe it's better to simply use the macros for the four bits in
> pcie_clear_device_status()?  Might also be slightly clearer.

Agreed, will move PCI_EXP_DEVSTA_ERR to drivers/pci/pci.c.

> 
> This patch could be submitted individually instead of being part
> of this series.


Got it. Will send a individual patch.

> 
> Thanks,
> 
> Lukas

Thanks for valuable comments.
Shuai

