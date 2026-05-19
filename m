Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B6332638;
	Tue, 19 May 2026 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193435; cv=none; b=J2Oq2DRcSvXVUrCfyjBACJP1/T+K+v2tMV7stRj6KfQR594xJfUbz5cOC0ur5xlNHiAa4o8ZTFiWYVrdR+bZu29aCpP7b/ZBLnPXwzv1xZXtIpPtobJYqlnXVCQSOAczMr7KK7TADe401WPZl91LNTwRPMAm0LcfdbVuAQ65Qck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193435; c=relaxed/simple;
	bh=RNvzrRQjnPjQa/DwSWqniUQWTmy9+Y2mbDLOSJp9XIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WH/HB5Get7tWV9+naBvNYksWjyh/CfbUwTSxqb/U62FrMiG/6FnGNZEkf4pQB2k8Nox2n38PE7LwnZlrGRo1EntSrjx2uNVX2SYIioZcnLMcc+T/4SJzjeGza+Agd+rRzvUUYFJu7y1TzIXOuCNWDS/amb2pE4r/Ngfnxdn2vY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M9X597pW; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M9X597pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=151iYdaAzBb7bApYaQ8oMWsPgcYXz6XT/Z3QtRtXEXg=;
	b=M9X597pWFegNIov2/jOvxm3ADHpgYyy/OrcOoG+zmJIBgmWZ3U9HJnjJbKqM0H
	8TTgX5g5XhyCdVZ/Vw3p4JvKPy3vBXTzg90f9wZ9oyWaD6H29XmDyNmjjAtHvkUy
	2apI3yKdpxIapVrwfx4EcQCk/VaLYfl5uGvOkhCEUoUd0=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgA3Ef8qVgxqgKI0FQ--.38665S2;
	Tue, 19 May 2026 20:23:07 +0800 (CST)
Message-ID: <89f37f95-a252-411d-8c79-23a450282b74@163.com>
Date: Tue, 19 May 2026 20:23:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
To: Aksh Garg <a-garg7@ti.com>, bhelgaas@google.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, hans.zhang@cixtech.com
Cc: robh@kernel.org, mpillai@cadence.com, s-vadapalli@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515145747.129635-1-18255117159@163.com>
 <20260515145747.129635-4-18255117159@163.com>
 <1bd033f4-a695-4266-aca3-1e034a161c3e@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <1bd033f4-a695-4266-aca3-1e034a161c3e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgA3Ef8qVgxqgKI0FQ--.38665S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr18Jr48uFyDur1DJw1xuFg_yoW7Gr45pF
	92ka9YvF4IywnFva1Yy3WqvF4DJFs2yFnrGrsrJrW0k3Z0v3WDWr4Utr4DGrZ5tF17Xr17
	Zw1YyrnrGay3G3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0_MfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7As94GoMVitsDQAA3A



On 5/19/26 13:41, Aksh Garg wrote:
> 
> 
> On 15/05/26 20:27, Hans Zhang wrote:
>> Extend debugfs support to LGA-based Cadence PCIe controllers. The
>> 'ltssm_status' file now works for both HPA and LGA IP by selecting the
>> appropriate register access based on the 'is_hpa' flag.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Hi Aksh
>>
>> Could you please assist in checking whether the ltssm_status of LGA is
>> correct? If there are any inaccuracies, please point them out.
>> ---
>>   .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
>>   .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
>>   .../controller/cadence/pcie-cadence-host.c    |  9 ++-
>>   drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
>>   4 files changed, 112 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/ 
>> drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> index 97c5deef2b1a..ac985699b974 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> @@ -13,6 +13,58 @@
>>   #define CDNS_DEBUGFS_BUF_MAX        128
>> +static const char *cdns_pcie_lga_ltssm_status_string(enum 
>> cdns_pcie_lga_ltssm ltssm)
>> +{
>> +    const char *str;
>> +
>> +    switch (ltssm) {
>> +#define CDNS_PCIE_LGA_LTSSM_NAME(n) case n: str = #n; break
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DETECT_QUIET);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DETECT_ACTIVE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_ACTIVE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_COMPLIANCE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_CONFIGURATION);
>> +    
>> CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LINKWIDTH_START);
>> +    
>> CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LINKWIDTH_ACCEPT);
>> +    
>> CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LANENUM_ACCEPT);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LANENUM_WAIT);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_COMPLETE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_IDLE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_RCVRLOCK);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_SPEED);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_RCVRCFG);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_IDLE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L0);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_ENTRY);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_IDLE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_FTS);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_ENTRY);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_IDLE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_FTS);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L1_ENTRY);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L1_IDLE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L2_IDLE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L2_TRANSMITWAKE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DISABLED);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ENTRY_MASTER);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ACTIVE_MASTER);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_EXIT_MASTER);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ENTRY_SLAVE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ACTIVE_SLAVE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_EXIT_SLAVE);
>> +    CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_HOT_RESET);
>> +    
>> CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_0);
>> +    
>> CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_1);
>> +    
>> CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_2);
>> +    
>> CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_3);
> 
> Hi Hans,
> 
> You might need to rename the states as CDNS_PCIE_LGA_LTSSM_* as
> suggested by Sashiko to print the state names correctly, and also to
> complement the naming used for HPA LTSSM states.
> 
>> +    default:
>> +        str = "CDNS_PCIE_LGA_LTSSM_UNKNOWN";
>> +        break;
>> +    }
>> +
>> +    return str + strlen("CDNS_PCIE_LGA_LTSSM_");
> 
> I have tested for LGA IP by updating this to strlen("CDNS_PCIE_LGA_").
> The state encodings looks good to me.
> 

Hi Aksh,

Due to the issue of copying the LTSSM code from HPA, the "LTSSM_" part 
was omitted. The next version will fix this. Thank you for your test.

eg.
s/CDNS_PCIE_LGA_L0/CDNS_PCIE_LGA_LTSSM_L0/


Best regards,
Hans


> Regards,
> Aksh Garg

