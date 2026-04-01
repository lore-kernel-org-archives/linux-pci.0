Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE72D9ECD;
	Wed,  1 Apr 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052093; cv=none; b=f5xxe81kvQRuz0O+98SPtfk44ZeOAUFO8lb7OM0vIhiR6d34TzFF7VnFlLkd9LqoLMjSOxqye/eYG6wtuL1RCfs8cE/t9nhzkrZKrV+uvS5CpxfP/tEb+8/LB2M90UxmAeU92QSZ3AuJ460FJOevE0oz8DfNAYVXPnz4EdiXJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052093; c=relaxed/simple;
	bh=LiHQrm62MOcowCWUqBGuzNV7hJWJF1jGzjpSJ+lknfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJmHKfOzcfbdiutiM9LS4Pis7c14ApysYenjhb1yvRroiowU68S5IDHlvjm0sGpcoq9uzebSA4VjJjMhe77lSTH+odrfSwHQNJHZq2uMleN2hP9Ataq/Mi+WCMAxbdpMfCCFQcVnCIFsUAQsuRSRq0+yWedEQAIKzfB52jAq7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S0YWDD+a; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S0YWDD+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=NPrBP2UemVPSDsrLJa0dJ3X/Djv89Bjz5oOkesTOGa8=;
	b=S0YWDD+aYrLoM1aSlewWnrl66YSFQfs3vjU7gpO2naLOdPXZFYdjXeCtqsjGWR
	DmP3BZw32SMYf6Lpqa9uk4S1fZ6qTUWg4/gXqlYW23MtU7fpHTcBdpE1/uD/sFMM
	Z1TxWJOXm18NUV8NiMnn8gBeMyPhdTGv3H7HeCJ2UNVCE=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDHwv8iJc1peHi7Cg--.14440S2;
	Wed, 01 Apr 2026 22:01:07 +0800 (CST)
Message-ID: <976e1e32-d671-42f4-8a11-3308013feb02@163.com>
Date: Wed, 1 Apr 2026 22:01:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Fix type mismatch for kstrtou32_from_user
 return value
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org,
 bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401023048.4182452-1-18255117159@163.com>
 <e55eajqhjh4hgpgzlm4cr6lh5sw6eulkgn2iy53blwmttr7hq3@ndoeigvy2v3q>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <e55eajqhjh4hgpgzlm4cr6lh5sw6eulkgn2iy53blwmttr7hq3@ndoeigvy2v3q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHwv8iJc1peHi7Cg--.14440S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1ftF1rXr48GrWUZw1DJrb_yoW5Xw1fpa
	yrGFyYkF4rJF17uFnxZan8ZFyfA397urn8G39Fka4093429F92g34rGayYvFyfGr40yr1v
	ka10g3s09FsrJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Usdb8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wMfwmnNJSN2QwAA3i



On 4/1/26 20:27, Manivannan Sadhasivam wrote:
> On Wed, Apr 01, 2026 at 10:30:48AM +0800, Hans Zhang wrote:
>> kstrtou32_from_user() returns int, but the return value was stored in
>> a u32 variable 'val', risking sign loss. Use a dedicated int variable
>> to correctly handle the return code.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Can you add Fixes tag also?
> 

Hi Mani,

Sorry, below is the "Fixes" tag that I found. Could it be that you added 
it when receiving the patch? Or do I need to send the v2 version?

Fixes: 4fbfa17f9a07 ("PCI: dwc: Add debugfs based Silicon Debug support 
for DWC")


Best regards,
Hans

> - Mani
> 
>> ---
>>   .../controller/dwc/pcie-designware-debugfs.c  | 21 +++++++++++--------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> index 0d1340c9b364..9461be074490 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> @@ -208,10 +208,11 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
>>   	struct dw_pcie *pci = file->private_data;
>>   	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>>   	u32 lane, val;
>> +	int ret;
>>   
>> -	val = kstrtou32_from_user(buf, count, 0, &lane);
>> -	if (val)
>> -		return val;
>> +	ret = kstrtou32_from_user(buf, count, 0, &lane);
>> +	if (ret)
>> +		return ret;
>>   
>>   	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
>>   	val &= ~(LANE_SELECT);
>> @@ -347,10 +348,11 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
>>   	struct dw_pcie *pci = pdata->pci;
>>   	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>>   	u32 val, enable;
>> +	int ret;
>>   
>> -	val = kstrtou32_from_user(buf, count, 0, &enable);
>> -	if (val)
>> -		return val;
>> +	ret = kstrtou32_from_user(buf, count, 0, &enable);
>> +	if (ret)
>> +		return ret;
>>   
>>   	mutex_lock(&rinfo->reg_event_lock);
>>   	set_event_number(pdata, pci, rinfo);
>> @@ -408,10 +410,11 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
>>   	struct dw_pcie *pci = pdata->pci;
>>   	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>>   	u32 val, lane;
>> +	int ret;
>>   
>> -	val = kstrtou32_from_user(buf, count, 0, &lane);
>> -	if (val)
>> -		return val;
>> +	ret = kstrtou32_from_user(buf, count, 0, &lane);
>> +	if (ret)
>> +		return ret;
>>   
>>   	mutex_lock(&rinfo->reg_event_lock);
>>   	set_event_number(pdata, pci, rinfo);
>>
>> base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
>> -- 
>> 2.34.1
>>
> 

