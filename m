Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D827587D;
	Mon,  9 Mar 2026 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773031753; cv=fail; b=AfjpfoJ4dd1i1dQbXzPdPDDeuP1jE8Tj2OpzMC8U5mfFtvXKSFGMTeMh02gt4Mpw13kkyZHA4XRYWDlJZtuI+kzbBMzcrP+/iUZwwf5iEiGj6oqCMuA5DqJNk52ZAZVG7wAJ7Zknz0EMZuq9++AoN/7E6xVfgwunsne5ySR0Gtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773031753; c=relaxed/simple;
	bh=qGKMgZbzKQJ651fFuIQ/mqEj2AqRc6x37E7upbnVo8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CFN1fer1LhDqNApuvnneVFdF/+j+PMdcNQefp+Qg5O08sG9/xzfzOTuekM6H74x6ok+zvoTopEk/z6tSNQbVJWAttppl2W+tjdLTaI0O4/2ccnxE86m3/UngM5N8OplAKlW+7hTwQEDo+cpWnehVrJvvotPh6ZU9GSisX60XqkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QyKgPb/a; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QyKgPb/a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWXEeZTpWdExRcUPcgXe1BwEyN1Xms6EU8/sQ812Tabt21Z5HP+f8eUeZSAGRb+HR4Be/kEACNBQz4c2RCl7uSeeSxrlm2Gxbz7u7I6QKczMyqOZAgLnYStA+CrKnZNtwAstNYQUolWSvVV509dAAPhudntxEKhvU7KLRxM1dV7bON9UIOpnet+ZB5Hh9NS8+dFZB86l2qFUYT7eocFMRiv4qK7NmP4+e4mJagFUNJ+PiX4vanK+CXxu0p5UjFz6zBRmOsrsrv+jzkRo+JOOaEEL/zuWcEF0C2p+B/ok5VPzQB2wbOwkO7EfbmfLoU+Ou7HwdX7XGHYWePuvXQ64KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRdqkM6FuS7esBwWdCNd/Ny/tORp/vmyU47bXxs/5gY=;
 b=cwojNz1E2i/QC0M5Vg3mB3tXY/6NivtWoe70bHsOYo2nAsckDkhz0mbmjlachoXWmZ94lY4XdmK3BxSDw2K5iLdxc2Y+TAwfZZA79rLbdq6xNxRrmj8PVzpRpZRUE47X27oDmPFR4nAGhjYbjDQRuAhv8o3CLphb7vuIB8pVbMoQizybBG/lvQBgALLVA7TBwdD7bEc9OzasXOYqahYdmTJQl+yckRkeGV4FxeOm1+uMD0MX1P/XzC/GOKIKAC7DtihJ+78dOZxBYkr9bitrT66BlX6CPJAzDVTZ0XNzdQMTqB7R2UNayBzbjM1HI26vIAJWVRfHqCgLvriSElAJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRdqkM6FuS7esBwWdCNd/Ny/tORp/vmyU47bXxs/5gY=;
 b=QyKgPb/aBifxAJNJQs12ukN12cHNGFQeju2/VZgVspojmc2bKInWxV9dvcg0K0HbCBQhTVsunFyeEf+xWFl34nuLvamfQN9Q3s0/7FthFC+/a9vRdhK5/fPQWusmKtL0Ptr+HBk2UGpv9SUqV1K1m2L7WHjQyJ1V6WXlEcD1nwA=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 CH2PR10MB4373.namprd10.prod.outlook.com (2603:10b6:610:a9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Mon, 9 Mar 2026 04:49:08 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::ac) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 04:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 04:49:07 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:49:06 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:49:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Mar 2026 23:49:06 -0500
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6294n13X405184;
	Sun, 8 Mar 2026 23:49:02 -0500
Message-ID: <95b73073-5a94-4e69-820c-7154be72056a@ti.com>
Date: Mon, 9 Mar 2026 10:19:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to
 correct physical function
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
	"fancer.lancer@gmail.com" <fancer.lancer@gmail.com>, "Zhiqiang.Hou@nxp.com"
	<Zhiqiang.Hou@nxp.com>, "gustavo.pimentel@synopsys.com"
	<gustavo.pimentel@synopsys.com>, "cassel@kernel.org" <cassel@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vadapalli,
 Siddharth" <s-vadapalli@ti.com>, "Anwar, Md Danish" <danishanwar@ti.com>
References: <20260306184519.GA131984@bhelgaas>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260306184519.GA131984@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH2PR10MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ea8ccf-24b5-4392-3a27-08de7d9732a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	hLAs12yBXgB9cUzkzQNTVhr96Re7hEzPo8Vf74csE9C50LM0Y/YPSNRzxywHjwCJWpTFVDHavSciIQuzZH1BOb+hY9HlwKnQSuZGU0LzecPa3tDTSS9aH+w3zxpMbvRicPzCZiIlukZ4Rt75ysmfMTic6sKXH/nZQjlVEopxYLHkSTZMBSQW2AHc/uRt9vjX39c50/TRiwmgK6ycumh339mw5PDUxF5a3FrAiRIs5c1BQtRXgAp4MwxjG0olXZuMbIh0ZWq520U5VAnVcPe7mzO9a9JARU/CgtdsnsG1fbHDswiJYp6VQ1IVszRLZ03t4AcFBMzMl/ARBRKcXV0MxLzlBiAxJFCWg9ae/CvykXr/Rlu0zTIdcW8aIp4oLDfOYG1BANONAZLWvOh/B1CsWGirnTS1rbJGZL9om8UqQue/MbtxdlMyA3tT8ZLxvA5bgh4h0lmtO5sHG00BDtjuEO+6aRAgMmRUw4TJXCcDAulbcWC4IF8vkDC9Cmd4GoJbKGKcCMXM4zdxvCb9Ob80KanYpImep9RMe+khReJrJA6RTFqCzsVEnaTb0NRQxgW9yfhyKIS/8IDxtoRAlBZjVvNGJ50LmjEkuJhhRcY7yEqvxIE1rSGkPUHr8LhryUMPapsg2xRGsa4THSEv2M7ndLg/tLcvLktCc9Qx7/+7RXSdLqLxJ8tr+DoSfxB+sD6OPWQgdVsUxW4kPg7fQMzOLabmivs+vme2AdcpoBhUYj4=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K1FR8b0XSapgPvM1lEw55Fc95t7GavsiuSFp/Kx9ozxYkMFkwVXIKB10SIcIT+wqXG0K53V3nSaftinFmpwGIKt99H7No+9DGlXZRH4ClhgiK+VO8bgTAvB5H9kE3M5x0TV3dBIZic4ilZG4rj4mZmj4jvDZfkAxFi/A5+jQ26d/NmqGCAr76N8PVEog2nAINwSl8htZ7lWd0Q1wCPDEeK1xCQwkdf1mKsTJREwBIdvNQRymCGRg/6TE7jdZVa0Uk86hNkJPoINy+V62I0NqCaRiaPgRTz8J4o5iDgGILB5r6Uu4BbH0f12Sb3ORqCcByppeL6fnBgqqn6MXB4cisK4CkasKVTp7giddJw/kDiL5asiTD/xJbJOtJ9gE7nzk6BCzlOJGJ/84MWHyR99aiYSeI+AiTxdCoUhhp1PhYfjUrn5X9S417RgQuzdVu6E4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 04:49:07.5474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ea8ccf-24b5-4392-3a27-08de7d9732a6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4373



On 07/03/26 00:15, Bjorn Helgaas wrote:
> On Tue, Feb 24, 2026 at 02:08:16PM +0530, Aksh Garg wrote:
>> The MSI-X configuration code reads from the correct physical function's
>> register space using dw_pcie_ep_readw_dbi(), but writes back only to
>> PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
>> MSI-X configuration for other PFs.
>>
>> Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
>> register space, matching the read operation.
> 
> Is this another case of using "PF" in a non-SR-IOV context, as I asked
> about here?
> 
>    https://lore.kernel.org/all/20260223185558.GA3701139@bhelgaas
> 
> I do not want to use "PF" unless we're talking about a device with an
> SR-IOV Capability and we're doing something specific to SR-IOV.

I apologize to commit the same mistake here after your feedback. While
posting this series again, I made changes to patch 2/2, but forgot to
look at the commit message for this patch.

> 
>> Fixes: 70fa02ca1446 ("PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers")
>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
>>
>> Changes since v1:
>> - None
>>
>> v1: https://lore.kernel.org/all/20260202072758.101845-2-a-garg7@ti.com/
>>
>>   drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 7e7844ff0f7e..771241e1a2c9 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>>   	val &= ~PCI_MSIX_FLAGS_QSIZE;
>>   	val |= nr_irqs - 1; /* encoded as N-1 */
>> -	dw_pcie_writew_dbi(pci, reg, val);
>> +	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
>>   
>>   	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
>>   	val = offset | bir;
>> -- 
>> 2.34.1
>>

