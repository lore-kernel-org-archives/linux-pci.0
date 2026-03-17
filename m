Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0933EC2D3;
	Tue, 17 Mar 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761999; cv=none; b=OWq0wTW65xVhScGmg0rsBmuPqqiW6DXvGxGvFL9Lr8Yvdgr7KLI+5uNDC+Fy/zBVKetTz7PO4xjboTsK7+tJxYV4niXWU/jh/TrPHsWrAzJy2JXc8G6NmprEU6ymqnP9k/TtkhtioWkY54AWlt1U82e6pNF991UEfylBmx0Eong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761999; c=relaxed/simple;
	bh=186JhnNAcaQqSuuvZB6aFzpPz35a2Zd9/RC3mvLUCPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ky3J5ImG9XJwqwuPvYC9F18qQVZI1qESt1Ow7rTAfq8NoC7JCgHk687iBbSZkm9aQz2w9Wn3jZZrNTnDJkBp+PEmHLc+2kBnjh4BzEkPhW6GlI/ECnQLmx7keK0GXPU8XyfzivdQFfatnWsOB6yD+m10CzluhcBjEBf/zDEfnu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g0uJsdBM; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g0uJsdBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=4I9GllvVTkUqBYyXh9DqJQijn6I+keaARWJmUZ/Wdpc=;
	b=g0uJsdBMd6fy+T+2E/pTQiVDE60G8SaZvcvHja/8w4Lgh1lJny9eenWNoJNgux
	KIG55uv+jrSFWBlDZ22GxyOCqBb0Iaw7BsjfALZRs8f9SurYHhXiwmi+XEbZ03dj
	RWKaNi/TIwjbvOMA/F+BFTrkG6PeqgLicm/vlRGb9LUi0=
Received: from [IPV6:240e:b8f:927e:1000:2e7e:cb18:c0e8:5588] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnyYizdblp_n8bAA--.114S2;
	Tue, 17 Mar 2026 23:39:36 +0800 (CST)
Message-ID: <780e86ff-70b4-42fb-865f-c49fba018b76@163.com>
Date: Tue, 17 Mar 2026 23:39:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: bt1: Use common dw_pcie_ltssm enum for LTSSM states
To: Shawn Lin <shawn.lin@rock-chips.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260315154015.126074-1-18255117159@163.com>
 <8bc47270-6d08-ae71-ac8b-c9d17044ff9c@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <8bc47270-6d08-ae71-ac8b-c9d17044ff9c@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnyYizdblp_n8bAA--.114S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyftFW5JFW3KF45AryfCrg_yoW5tw13p3
	yrJa9IkFW2qanrA3W5tws5Xa1UKa1xAFWq9r4jg397X3WkK3s3KF1rtr15KFWvqr1fJw1x
	t34DC34Syr17WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRqXd5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xhU92m5dbjY2AAA3N



On 2026/3/17 14:22, Shawn Lin wrote:
> Hi Hans,
> 
> 在 2026/03/15 星期日 23:40, Hans Zhang 写道:
>> Use the generic dw_pcie_ltssm enum from pcie-designware.h instead of
>> defining private LTSSM state macros. This eliminates duplication and
>> aligns the driver with common DesignWare core d
> 
> No, this driver's removed due to the sanction policy in this community..
> 
> efinitions.

Hi Shawn,

Thank you very much for your reply and reminder.

Best regards,
Hans


>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-bt1.c | 38 +--------------------------
>>   1 file changed, 1 insertion(+), 37 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/ 
>> controller/dwc/pcie-bt1.c
>> index 1340edc18d12..429fab073bba 100644
>> --- a/drivers/pci/controller/dwc/pcie-bt1.c
>> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
>> @@ -41,42 +41,6 @@
>>   #define BT1_CCU_PCIE_PMSC            0x148
>>   #define BT1_CCU_PCIE_LTSSM_STATE_MASK        GENMASK(5, 0)
>> -#define BT1_CCU_PCIE_LTSSM_DET_QUIET        0x00
>> -#define BT1_CCU_PCIE_LTSSM_DET_ACT        0x01
>> -#define BT1_CCU_PCIE_LTSSM_POLL_ACT        0x02
>> -#define BT1_CCU_PCIE_LTSSM_POLL_COMP        0x03
>> -#define BT1_CCU_PCIE_LTSSM_POLL_CONF        0x04
>> -#define BT1_CCU_PCIE_LTSSM_PRE_DET_QUIET    0x05
>> -#define BT1_CCU_PCIE_LTSSM_DET_WAIT        0x06
>> -#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_START    0x07
>> -#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_ACEPT    0x08
>> -#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_WAIT    0x09
>> -#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_ACEPT    0x0a
>> -#define BT1_CCU_PCIE_LTSSM_CFG_COMPLETE        0x0b
>> -#define BT1_CCU_PCIE_LTSSM_CFG_IDLE        0x0c
>> -#define BT1_CCU_PCIE_LTSSM_RCVR_LOCK        0x0d
>> -#define BT1_CCU_PCIE_LTSSM_RCVR_SPEED        0x0e
>> -#define BT1_CCU_PCIE_LTSSM_RCVR_RCVRCFG        0x0f
>> -#define BT1_CCU_PCIE_LTSSM_RCVR_IDLE        0x10
>> -#define BT1_CCU_PCIE_LTSSM_L0            0x11
>> -#define BT1_CCU_PCIE_LTSSM_L0S            0x12
>> -#define BT1_CCU_PCIE_LTSSM_L123_SEND_IDLE    0x13
>> -#define BT1_CCU_PCIE_LTSSM_L1_IDLE        0x14
>> -#define BT1_CCU_PCIE_LTSSM_L2_IDLE        0x15
>> -#define BT1_CCU_PCIE_LTSSM_L2_WAKE        0x16
>> -#define BT1_CCU_PCIE_LTSSM_DIS_ENTRY        0x17
>> -#define BT1_CCU_PCIE_LTSSM_DIS_IDLE        0x18
>> -#define BT1_CCU_PCIE_LTSSM_DISABLE        0x19
>> -#define BT1_CCU_PCIE_LTSSM_LPBK_ENTRY        0x1a
>> -#define BT1_CCU_PCIE_LTSSM_LPBK_ACTIVE        0x1b
>> -#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT        0x1c
>> -#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT_TOUT    0x1d
>> -#define BT1_CCU_PCIE_LTSSM_HOT_RST_ENTRY    0x1e
>> -#define BT1_CCU_PCIE_LTSSM_HOT_RST        0x1f
>> -#define BT1_CCU_PCIE_LTSSM_RCVR_EQ0        0x20
>> -#define BT1_CCU_PCIE_LTSSM_RCVR_EQ1        0x21
>> -#define BT1_CCU_PCIE_LTSSM_RCVR_EQ2        0x22
>> -#define BT1_CCU_PCIE_LTSSM_RCVR_EQ3        0x23
>>   #define BT1_CCU_PCIE_SMLH_LINKUP        BIT(6)
>>   #define BT1_CCU_PCIE_RDLH_LINKUP        BIT(7)
>>   #define BT1_CCU_PCIE_PM_LINKSTATE_L0S        BIT(8)
>> @@ -108,7 +72,7 @@
>>   #define BT1_CCU_PCIE_LTSSM_LINKUP(_pmsc) \
>>   ({ \
>>       int __state = FIELD_GET(BT1_CCU_PCIE_LTSSM_STATE_MASK, _pmsc); \
>> -    __state >= BT1_CCU_PCIE_LTSSM_L0 && __state <= 
>> BT1_CCU_PCIE_LTSSM_L2_WAKE; \
>> +    __state >= DW_PCIE_LTSSM_L0 && __state <= DW_PCIE_LTSSM_L2_WAKE; \
>>   })
>>   /* Baikal-T1 PCIe specific control registers */
>>
>> base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
>>

