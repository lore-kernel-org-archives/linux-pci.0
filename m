Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2630EF74;
	Wed, 20 May 2026 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246012; cv=none; b=cc+x3DGmCbj4dbHSO4yVySfz9EuxZy2ohYA733qcZFkvcc26ThSyTmTCQvav5cWtKg6rakV7ymIx2oKfwAOJFpt/rTz+Vd5a3hbjxMXqsIiwDASHrz/sEluDCszz64sCXJjW4loBHX2B6fg/3tYDhtacDiJ2vnpfYR1ouAia+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246012; c=relaxed/simple;
	bh=+tDVkN3nUdGETQrjJBqqTxMPwAYkWbJ+ePrOJiy05Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnUlvv+9leXaMVEMj/LqN/JHLUxOs+CB2nqKPh8NtbA9D4lo51dYXBSz7FhlEcznntocsrnqy+6NWBa5AJZZvk9LuHPExPQpWLE9Gj/KbQm+WAKYz2p0Ot9MjOoSitdYee0yDGEVQfSVcAZwn02AC2fEj/YwPQ6QcSxZNOTfRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UzNLNVmT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UzNLNVmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=YSZy+25VXisq/sZX/dpeKAlrRh14YY0Um8pN153m72A=;
	b=UzNLNVmTnR+m83Cj3Xeeenyt0k1NxN851TQ0TqqSnJWbeK1aMyFE40ktG1Tny4
	XvZqJanCdYmlU/n5VDvdmoCI4lio0UsasXDnuhUrKo/iEOcNt218VMdEtDmdIGfc
	AxZb0e6unVPHkR/RHUe2Xk0+2CEpqk85FYPaJQ9GzUL8c=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXJNuOIw1qotNbCQ--.35640S2;
	Wed, 20 May 2026 10:59:27 +0800 (CST)
Message-ID: <e3fa093e-28a5-46a1-a10e-e8065d127d08@163.com>
Date: Wed, 20 May 2026 10:59:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>, "a-garg7@ti.com" <a-garg7@ti.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260519123609.1595280-1-18255117159@163.com>
 <20260519123609.1595280-4-18255117159@163.com>
 <DM6PR07MB6716A1B312BB85439C399D56A2012@DM6PR07MB6716.namprd07.prod.outlook.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <DM6PR07MB6716A1B312BB85439C399D56A2012@DM6PR07MB6716.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCXJNuOIw1qotNbCQ--.35640S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4DGF47AFW7ZF4xKrW3Jrb_yoW8GFWDpa
	y8GayfG3WxZFWfZ3Zav3WUJryagwn7J34xJwsF9r1xuF17ur1UXr42gFW8tFWDWrZFgr1x
	t3W5tasrKr17AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR573PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxA-JbWoNI49lRQAA3E



On 5/20/26 10:34, Manikandan Karunakaran Pillai wrote:
>> EXTERNAL MAIL
>>
>>
>> Extend debugfs support to LGA-based Cadence PCIe controllers. The
>> 'ltssm_status' file now works for both HPA and LGA IP by selecting the
>> appropriate register access based on the 'is_hpa' flag.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
>> .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
>> .../controller/cadence/pcie-cadence-host.c    |  9 ++-
>> drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
>> 4 files changed, 112 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> index 97c5deef2b1a..0a308f95e9f6 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> @@ -13,6 +13,58 @@
>>
>> #define CDNS_DEBUGFS_BUF_MAX		128
> 
> Where is CDNS_DEBUGFS_BUF_MAX used for ?

Hi Manikandan,

Thank you very much for your reply and reminder.

This macro definition was used in patch 0002. Since I compiled the code 
after applying all three patches together, I didn't notice this issue. 
The next version will be fixed and will be included in patch 0002.

Best regards,
Hans

