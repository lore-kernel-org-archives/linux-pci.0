Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013020.outbound.protection.outlook.com [52.101.83.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB835F19F;
	Tue, 17 Mar 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741340; cv=fail; b=FrD912tNOWE4ZCPoc70i887JsG3+MoSvKQfr6DW5MUkiptmnsZo+qlJB9SGl01zoZl8Ct+nKnVez1VWKAQRRhNMIv2AknZHQEVPnYwsy5/bRvopyVlr9JOj4ABlZ7hVeqMTe9VUbYvHfZNvbF6Vcgeu7QwEr2AYYjc3J6psUIBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741340; c=relaxed/simple;
	bh=na2SN4sOd4b5aLdWzlz3CTBM/0J1Y6lolZsW3LqWJMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uxvMlVfzvAmWdH4/V2EMwNncFnFoqGsEZRauqpjx8FG8mpcCl06fSCKWCdlStgCr6Fz2SjewxiSW9zuuoUqQJoS54zZ2yzbUtHDgZT2RbRuBFiljPXv22DcAvyOz1gAyhreW+q+acr2d7vnU/H0TcffkTv8usDg/Ejb72AjpNjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=b7Awh7X8; arc=fail smtp.client-ip=52.101.83.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="b7Awh7X8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKrqtU1pNAgi6gebwzr3iUFZIKfMQ9xvoF8hT7M9Wmf76VWlM6zgpDAF4+AX0mFFPKNmJNKXuEnX2OOixOGy17D+r2EEssSl2/0HFwZWd7gLFpJsFGl+kCHSqyaD1SxHMuFsDCKTKNRaGFd/VTYztUV/Vcgr2svRxdSceQLlbHpRzWphkdZkzoieW2OAZ6T7QlwK90wk0FwVudSGhhdWNvE7ZV6HPzdN9Z/0JRDPBnsI3D4ijUOMdjNRXjAxkW+vjFK1U4Yissrva/usurQcJMPINH3Fm1tgeQMrpbKZ5cS5tQAZNpYTQmz/aWdHNM79CwvnQdj3Jxv6TZxmuVsZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO2TsVa7gbolcmFRsca5MyHW8e5vF6hd+SoiehBddAU=;
 b=wZLSGyQ9L9VebbL0W3EEcUJnSZvUOzszd5ilErt/LFdSfY1HX5JAxv3vHQj7Ver7S65xl7bsknOaNhSZvkJhpiL/3jLvez36pbT3Vkm+ickwD/1t6L++JZOobNgTjWld4kqUq5EpTorqEkP/N4nB1R4FcCw16z1euA+KeYwZQ0Uos/FzPbI//NRDQowVKPZqUYVzar9svJ0AHfMXEbMdrAolqJVHz1RyPO6icNxcHo21CQTjPkWC5bwl7IQgd/SczkQ/UQsab9pamuVN80QZuvQkd6Vb5tU9UzTrRxQNhKWEfoFjgagVMM0Gizw9sOr9o8niKuLrQHZRuVwWaau39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO2TsVa7gbolcmFRsca5MyHW8e5vF6hd+SoiehBddAU=;
 b=b7Awh7X8ufqatrWWlTU70mqKx8bFWa4hSRLCs36+5m6ozC7v+WMeDQC5YFpM0xcghtMZSEhHulGZNRY+r6HmpTzyT3ss5bovsK4xfuThPhkAW+A63fGL8A5E/wqpLlqEZsWEkq1zZSm2BMF00bEDMBlJ7Ko6eldcE9TRPdeTJByrMWFtn4b4ZiAzsD632RZ7EyzP4FkfrGvx/Z6iTJ5sljxbZgll6SGd58J4egP9GK/dAcpSwYBO5sx47jg5T6JuWlsi7gb2oPWG/+3tUV14XtNw63BVMJyF+uTTLDflmeR8yTu1bS8ifzmjnxGc8IKj+sGse9JkyH/XEGcr4qHBJg==
Received: from DU2PR04CA0338.eurprd04.prod.outlook.com (2603:10a6:10:2b4::8)
 by DB9PR10MB6401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 09:55:33 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::27) by DU2PR04CA0338.outlook.office365.com
 (2603:10a6:10:2b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 09:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 09:55:32 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 10:58:06 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 10:55:31 +0100
Message-ID: <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
Date: Tue, 17 Mar 2026 10:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
To: Niklas Cassel <cassel@kernel.org>
CC: Koichiro Den <den@valinux.co.jp>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kees Cook
	<kees@kernel.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Bhanu Seshu Kumar Valluri
	<bhanuseshukumar@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com> <abkdu_7n_lePaTIY@ryzen>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <abkdu_7n_lePaTIY@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|DB9PR10MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: d0018668-bb08-4719-1d39-08de840b5476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mEDLAHeDhqorHKmug3wqQfqyMGTQT2Pzrsu+9DbkfcQ3ghFh/qXaOsGM6G7+D+Hs9sxbQG5BD2wu6nBiWoSbjU4N48P3EoNvtP81Cv/RoUz1hgncvt7OAa/dXMoMBJV7fssFSbesFtyX7LsbQDIqMBLpTy5p/+LuPXsh4ijOSEk8JLMBlMT+VJwlWwkdgl0J2dDKlW8/AO6pbH+pdERI4PtReuHpPQioUIuu2nWDSiNmPriIn0H62HlXqtM5dGoIlJP/LghTUiDnUtq6SD1QTXuZObjzfA+DHvy87tj9Y4Ky6sGtBkT9qdc74cRWPs4x58q8vAAD+pcGyG3bjr/+o4zllEhIa24qICctAddVCNdS1uQ4V6TM/sUf4y7D72NOeBa4BToVHbftuYfTrih0USwUB69bZSwuKpA+TqDB3kJhXQKZs02rVPJvxAx1d3N+ruEUzI81rOyWOwpfflipv/JfCyYi4AHVdsdU30qzppTyXWZavSPrQ2Pb6Rz0Nk6smRXvMWARSjoSuUK/XSb6xYf2nnsHI5TtofEV0dEaF3iervUr8vWiBJ2onXyKUHSyzYtXCeqysEnIYV0TPDjYppnT5S8u8vWnKKAOb9d818jpXaO5QSo0Gz3vC2KIUICVotQAqD7gSSAIJ43paMVl5H2z8pgpdqGfmbi2a0kRhFAYuYsMKuGNGXxj+24Gxv0s3HfGPR0ybukbcNfhEnP/OdzSsIG9BDIgIXyT7Tjic8K3QQqkJxQtuhkOuBUaGdJ+a8yo+VXFVb+KepuUuJVHGw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nKgbbufNg7YLamrYvPT9m6c36GTC8TUQVz6wMmfshNLXPjzw2AeNkn1FuF2RffV0YryHVrvNNFE8NK1OeFS6id33Vr/FLaVwi8sbxRO2iX41y+jUK7PIxvnAwfpkrq+UHZdFiIRmATpInz8rnOjeBARv11gRkEP0/gGl7mKWaSui94AP464o2id0NDgR5M6rgKm1uUtJiehk4CjZc38ZC4YQRHyu/ISde92fKdxQKaQlBn2xo1ST5ILO2lHWtlnfyPGnfsRv40PJsDbe4dwKhMUDKu0yfV3RgTZM1Czr49kolc1gfxYYJeSl3VNFq+CwRDv6Nk7R5OSuhvk/H53QJWNRD6Ecg+lmw1FohaZFaeH1A3f+sN2Kv+vSxVhFE7A9+HFHztlm4nuFDpjuUaME84GONxX+MYeCJ4ze5AwcdyCU2yGkB0eVdRPnItZOlKhK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:55:32.8571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0018668-bb08-4719-1d39-08de840b5476
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6401



On 3/17/26 10:24, Niklas Cassel wrote:
> On Tue, Mar 17, 2026 at 10:13:52AM +0100, Christian Bruel wrote:
>>
>> Tested-by: Christian Bruel <christian.bruel@foss.st.com>
>>
>> with the DISABLE BAR dependency
>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=33642e9e36dc084e4fc9245a266c9843bc8303b9
>>
>> I will need to update the pci_epc_features after the merge.
> 
> I don't think you should update pci_epc_features just to be able to test
> the inbound submapping feature.
> 
> As I said before, I think a better option would to ensure that the test is
> skipped instead of returning failure, for SoCs with too few inbound iATUs.

So we will need to add a SKIP ENOSPC case in TEST_F(pci_ep_bar, 
BAR_SUBRANGE_TEST)

Note this will be equivalent to set .subrange_mapping to false in the 
pci_epc_features. But I agree, it only pertains to the epf test driver, 
not all epf drivers. Touching pci_epc_features is not a good idea

> 
> A real EPF driver (not the test driver), that wants to run on STM32, and
> wants to use inbound submapping feature, can simply ensure that it does not
> enable all BARs (the test driver obviously enables all BARs, since it wants
> to test all BARs). That way, that EPF driver will be able to use multiple
> iATUs for a single BAR (as required by this new feature).
> 
> This works because all BARs are disabled by default. An EPF driver has to
> enable the BARs it wants to use. (E.g. nvmet-pci-epf only enables BAR0.)
> 
> 
>>
>> A more general question: I don't understand why only the STM32 is impacted.
>> It seems that all targets, even those with 6 IB iATU entries, should ensure
>> that one BAR is disabled to handle subranges.
> 
> I can't speak for every SoC, but looking at dmesg:
> rockchip-dw-pcie a40000000.pcie-ep: iATU: unroll T, 16 ob, 16 ib, align 64K, limit 8G
> 
> rk3588 has 16 inbound windows.
> 
> Probably most SoCs have more than 6 ib windows?

Yes, probably, thank you

Cheers

Christian

> 
> 
> Kind regards,
> Niklas

