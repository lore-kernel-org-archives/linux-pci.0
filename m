Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9AC363C77;
	Tue,  9 Jun 2026 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981777; cv=fail; b=cBbVQQP4IjUKeQ4cXdBdtvO2jgKh2FuLlvpTyi3ElqFnWBO2Df8iv+Z3lsVAHq7Q0KHVl2FnnVGj4d93gLWuxgPhYOGzOI/yIE7HJLVIPrUqjjAlZbIJ9B6FVWaJ6uPpmMxt1xozPb4V2DIKvm+sBnbj1NWk52pMK45fS3QlVHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981777; c=relaxed/simple;
	bh=AT1TflwkijmWoHlU/zvUBzbwNqSH2ogqPOWkUl/r5zw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u95viUngt5ZmsPgSpGo7DdfKinrCY+mw8Ga+WiLLUEc4gwoFx+3CmYlMFMzv3ynNT/Xc4JN4vEaCnALGUKQA3b9Vt7B3gtdMxocF7637XkBoX7DkXS++tdnr8clFW2o8RKQT/sRq69n5T5JL7PGjJ9U1uprQPRAA6HSiAZ0MAog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AZzuGKJ5; arc=fail smtp.client-ip=52.101.57.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AZzuGKJ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4Xl022FmRUfXrGrLID7io5e7G1RrTV+a6yXsC5wgDWXKuDNRumMpabrrSES2h+sArENLOS6f8ty3dcWIdmI3ai5Jw3FRFTzmCbCkiHGGDOGvl+hYHgnj/prjMUR8zVBkMhiDkWtfySUinyE6nYldOmXCxDPjnd03OLq5g9mUwYbegW9l1NSEwZKF9UO9naFdz/cMHs+mpu+xsoXSnTVkE3TKiMmtt9MN8msw9011Aa/dTqzu7cI4e2P+VYO+mLcYSpvGzbUTl+N4qEYIM5dYUMOQFN+SAXuQ99rVgRBU9540S4zpSKsTDrHCOqMeM2qP7lB3iZWyoUG/xrzArIrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ccvXdyoC8m3wGlo3k+5DqL3ncMPCwhdi4eN6BDZswM=;
 b=gluj+a/qayZPw2AOxOI0BO+RgnOhoKZb/x1vHy6OiuDjpPLe8kU3GQrssPO57r6W1hOLviqnra9aHHUW2tLnbWv2XgSemoRXPavBdiFmeYsGSyM0SdmQJtQnWz5bqyQk0Dj3q1gURs7u6ePCbtnBMCgnvXb1pBxCenUibhYmV8pvrmNHLdRu9DlvYqtA3PKLTuRoH1B7mzaDXW5PHDSFThZHp4u9LCHgS3Tp6EUlx/VtkVthe5IYl+sRcCsu8N7wfj6nVIxLv9e4OvmCCUtJMR2sKQHPINeTtGauQHF+Oy3JwH86rt7SdxvkqyWerdt0WlUeRIb2fzy3OaQiLXiPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ccvXdyoC8m3wGlo3k+5DqL3ncMPCwhdi4eN6BDZswM=;
 b=AZzuGKJ5JLVcqUuONyFZp/6IOzdomFJ4Zw+c8wiDkT7xYxaGRdpja586Fr7+Q+l0Qwx8eKCCfPuyb6mnoUWgaSu7cCdKtFuSqLC8PVs0dFQAsu26r2arWGygGJXGUls7Gm/trrrVdtJ1QtFVCDtfCdDymc7r9jy5idqA9Qclqrk=
Received: from MN2PR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:236::13)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 05:09:34 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::34) by MN2PR05CA0044.outlook.office365.com
 (2603:10b6:208:236::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Tue, 9
 Jun 2026 05:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:09:33 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 00:09:31 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 00:09:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 9 Jun 2026 00:09:31 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65959QXc936124;
	Tue, 9 Jun 2026 00:09:27 -0500
Message-ID: <bb190834-121f-4b71-ad12-bd2d5fcacd44@ti.com>
Date: Tue, 9 Jun 2026 10:41:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <s-vadapalli@ti.com>, <vigneshr@ti.com>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <mpillai@cadence.com>, <unicorn_wang@outlook.com>,
	<me@ziyao.cc>, <18255117159@163.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<danishanwar@ti.com>
Subject: Re: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
To: Aksh Garg <a-garg7@ti.com>
References: <20260605071922.1724499-1-a-garg7@ti.com>
 <19ded2fa-4560-4b38-975c-6b490328e992@ti.com>
 <1362dccd-24b0-4b44-8e45-75cba81180ae@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <1362dccd-24b0-4b44-8e45-75cba81180ae@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f932f0-0812-45a2-4eeb-08dec5e54b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|32650700020|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G/z3ZQGLEgw4/RTL3qpE8WjIEqzyJhSy/zBYi4zJVmP4df8hxPOh7skD6zXqFHZCYqSWf7dFAz72061jk9x1nxM+T39IapaoXtyo5ZRNTl+enu6Cuu+EevKgJjf5/iZE/X0LX5OVzvfFKkc+FOer2/tErqmW8wR3+obf+O9F+Lfpm2AOLVUobw26lsybB6ChxUr7ZcfPJGCQGpcrhPiIdzDSywdr9LgKVuckgAE6hYJ7bFAlK3DC6qZsGHfDYGo9zkx632sy5QS8kYa5U1aC5jHNIYd+ql/DOrIZeNE/shJj986kB5J9py1eOrLpMyx81jhN310DOuk8DmB3+TZs43cgdBcH2u3q2AThaddurYcRCvR/1Gtovnvwc/1l18CQ3npHi4JIAWpUcEFskidXi88halIOW0nhx2BLiUy4hiaiWG6xHY+C9s6ASwspBthdOlX6mJr6buRUeOyyfMBTSw5pICmw4gi+EB4nOJwBf9ShHthc1wrXOBS8vYq53+wg0DpaZmRlUkk/pvzsI+FOtj88J62eeef1f+TYBhx5aTK27Ok/KS0ikgCxLxX2lmGXeTFSvGhlavUw5wxj5e/xCk6/pAedI/sXas8kwo126u4tuReEMT+eStdPamumGBUUjjPG3kXTK/zS5dTxGnx12nQrP8N/obrq+vVZ35M3Zf2jer4ahUu96/BfwPi7EHtZVRAEKTzPnqxNULDYfHqkWY3PRV+MDey5tKUcRBJEXiY=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(32650700020)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lBmf0CYqjcWmIyKfW/vWXXKeO0E/tqcbo8VjqGHm0iIkCz9pGRAEyH4mB+RW+FFfOHSpEOyZR3e/cuXdwkptbMmTaZgeQPABztv2kWHC010R0YGqsgQRdNYoa5B+es4xXuuKOFNUMezgGhGR1u/y4vnnVS5l1GZfjjtqzzwoXOt4BTwtX5KAMJHZmdZtax4iMAQ1cQ3J+DijHyzQdiwLyP4/yT1FQ3FIbmKlDLOrBuHpyK8TA72npZccgnFIrBCpjpy0OuAFn+oFrL9XW+Go/lutaVbJjG9A9U3Q/mfKcG51Uoo8knwOP40xmgwqcAL/SC8NfE64s9rJV78EH3/pBuJPb8YyEf0kw3Zsg8Xh6KKpMlapjJJHd5eW+AfFqYnp160zPUXjpYZOlRDZ767ugR2afqXSxCRAMurKv58elSoo4yiPIa8lyHqzQkucbnKE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:09:33.1045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f932f0-0812-45a2-4eeb-08dec5e54b27
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108

On 09/06/26 09:58, Aksh Garg wrote:
> 
> 
> On 09/06/26 09:12, Siddharth Vadapalli wrote:
>> On 05/06/26 12:49, Aksh Garg wrote:
>>> cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
>>> delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
>>> during the resume operation blocks the resume operation unnecessarily for
>>> ~1s even when no endpoint device is connected.
>>>
>>> Add skip_link_polling flag to track link state across suspend/resume
>>> cycles. If link was down before suspend, skip the expensive polling
>>> in resume since no endpoint was present.
>>>
>>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>>> ---
>>>   drivers/pci/controller/cadence/pci-j721e.c             | 5 +++++
>>>   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
>>>   drivers/pci/controller/cadence/pcie-cadence-host.c     | 3 +++
>>>   drivers/pci/controller/cadence/pcie-cadence.h          | 3 +++
>>>   4 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/ 
>>> controller/cadence/pci-j721e.c
>>> index bfdfe98d5aba..849eb8bb9e45 100644
>>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>>> @@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device 
>>> *dev)
>>>       struct j721e_pcie *pcie = dev_get_drvdata(dev);
>>>       if (pcie->mode == PCI_MODE_RC) {
>>> +        struct cdns_pcie_rc *rc = cdns_pcie_to_rc(pcie->cdns_pcie);
>>> +
>>> +        /* If link is down before suspend, skip polling in resume */
>>> +        rc->skip_link_polling = !j721e_pcie_link_up(pcie->cdns_pcie);
>>> +
>>
>> Please consider the following scenario:
>> 1. Endpoint device is not connected initially and we suspend with 
>> 'skip_link_polling' set to true.
>> 2. We resume and skip link polling.
>> 3. An Endpoint device is connected to the PCIe Connector a while later.
>> 4. We perform a bus rescan, but with skip_link_polling still set (in 
>> resume), wouldn't we skip polling for the link to be up?
>>
>> Shouldn't 'skip_link_polling' be set to false on resume, after we skip 
>> the polling initially, in order to allow waiting for a link up for a 
>> newly connected device? Although this may not be done in practice and the 
>> Endpoint device may always be left connected from the start, I am 
>> wondering if we should clear 'skip_link_polling' on resume to account for 
>> the aforementioned scenario. Let me know if I am overlooking something here.
> 
> This path is not used during bus rescan. This implies that during the 
> rescan, we do not call cdns_pcie_host_link_setup() or 
> cdns_pcie_hpa_host_link_setup().
Thank you for clarifying.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
