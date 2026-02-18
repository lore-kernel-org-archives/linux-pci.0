Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963E2F5A36;
	Wed, 18 Feb 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771413699; cv=fail; b=CdqHoQdP3C+XqU+NoDRXNqsFdJSns11FrZV9F/APWpEfF7Lk1f3ZkfXJffxofZUoXjpQVAUNLsqfCkg9sWAUtHQcdkkvr7wHo2QzH8lrIAkXEgW1UMISqraFK8czVq3X2tXUsK9LD0hmaq4hgfj0qt8z5qYMc2ymdztB2Hzo2/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771413699; c=relaxed/simple;
	bh=oFNhwU9GAvihSGe9YdcZyufbJSabTQes8XFr9HxRZqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bjh7FM+mt8d2jumK1sNjnHbI7wKMZyWkwJzScpNsxoN4fNYRncjTPitGps/YAB/h4Ije3zhjR1QZY6VdgBWs6xjeIRZh/5MsuPKcrLZhRxzEap15sEsbNBTZTCL5hO9u8/7dR3a14nprrrmkcHm7zuma80lVyXTYtic7/hLfkeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rc7cBaZO; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rc7cBaZO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE3z7vGxDlCSxS4tjCF81wNN1UeU72Z68Vmr0WIzb2kPRQpgd3hBh3Fk3jOAbaoHj2MwMpH3G66i9yOkZM3h/R6u0PE94HHm8bsKxsojYOD0ANcyi2YERcz/GDomqrGrS9C8Gz9bwVzR+4xCfaTusiOsp+Mo7Y8iCCtPhLVj3hM0Jn+AxVRKidOV/gXp/o+3tOzcfzHaMyuHo8vPILXQ46uU1JjZwsAX1SlLtelOoynOWazQax5yJMV1yN1Sxx3SXCChRkcbrKKSN0m4MHAYrNB/o0txcV5pAs8FDP51gLxmKXjEgaQ68HBloQvkBHB4X4SIO8aqJL67LvkT3YFGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ngTuzqYre1wsq+Z2yjygGXPlyhwCpAkm7HI4hYO5K4=;
 b=CCWybyYngTHoveUaw+BQcUi/zWEFNMapHx3P1rkMg+A67VMxtcqf5iHoippx7OvMaYmdhjnS+T5oy7mLtqSuy67FDsFaCe3zhdybAB8dia24lAz4oLj8U+TrtMNyYJz4L2eTvFJrJzSO1fJtarwjYiGfcVCaT51PKMFeCHB/xyEOsanu2NZASEtzGRQAUmeL4VmD4Z2LF+F8IoJyzHswnpEO28SduoLwG7oc0VOwqr/uAmsISV3pDVNgg//kfSh8kR40GL4KMeaH7Pgtlk7B88CtDSxRpX/+bqKzdZDQg8gmBVWDXkIRVHR5LrtTlG5sCepb9RanQnDx8oRyZMi9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ngTuzqYre1wsq+Z2yjygGXPlyhwCpAkm7HI4hYO5K4=;
 b=Rc7cBaZO02Jl9tiNNQ2Bb9PWf0W2gUpJKtUyA8cVmyoL70qIForASeZzGYKl3ZM3dpE/Nphjg1svFIuyNya0ulYBJvBpb6EVNix1dTO5dU8wuWzOFQqPzgj/lSPruYSK40AXAvpperpAVBRM+D5oaxW6H0+ekNTGHOUtxQeM76g=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by PH3PPFCCF14A5A1.namprd10.prod.outlook.com (2603:10b6:518:1::7c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Wed, 18 Feb
 2026 11:21:35 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::4b) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 11:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 18 Feb 2026 11:21:34 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 05:21:33 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 05:21:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 05:21:33 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61IBLULa303083;
	Wed, 18 Feb 2026 05:21:30 -0600
Message-ID: <498fb6c1-36b4-4e10-a4ff-de734563cae4@ti.com>
Date: Wed, 18 Feb 2026 16:51:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] PCI: Add documentation for DOE endpoint support
To: Niklas Cassel <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, <srk@ti.com>
References: <20260213123603.420941-1-a-garg7@ti.com>
 <20260213123603.420941-2-a-garg7@ti.com> <aY-KkFE9Ya2ZF8ED@fedora>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aY-KkFE9Ya2ZF8ED@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|PH3PPFCCF14A5A1:EE_
X-MS-Office365-Filtering-Correlation-Id: aad0bf6c-a702-4d1c-de92-08de6edfdfce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW1Qd2xUdmgwWkl1R09Oekx1bG40bGNjbFlEamZzNnRmTCt3Sk1HdHU3Vitx?=
 =?utf-8?B?a2xwWDdTdkczVlVRSjMvL0dVRmZPMFMwSmZhVmtmbStxOGV4aU9NczR0b25F?=
 =?utf-8?B?SlJOL0llYUpMcUN4dFd1NHhrYjliWDBhVDU4eHczeU1iajE2MGxyZGcwSkMz?=
 =?utf-8?B?WDlLc0c1a21ESWJBemgyR3kyWXBMQ3VTZmpVU3hkZTFqZTJmUm80NEFoaTRt?=
 =?utf-8?B?VW4rNEdMalE5Z1E2N1VmaVRPcTVmUVVUUXRyb0EyNGY4K3ZIcG1jWUU3Tjhp?=
 =?utf-8?B?Ukk0YkpteWFFZ1RqT2hqbWQzSFZGek15SVEvQWJjUThPVnZJVE1mcDQ0bGpN?=
 =?utf-8?B?YzRCY3d3OHhtMjVoekZkanlXdVJOTmEvSFNwL2JKdDcyelFmVWpTTEQ3dkdQ?=
 =?utf-8?B?U0ZIdFNmWDd5VG9qVmVMZzd0VlkvZnhCMEI3R25zaWtIbGM2RDlrbGtyUDk3?=
 =?utf-8?B?NU9EaEhCbHl4NHd3SDhVTm54WFRNSEhYOXhiM3BnRjFuSTRTYmxvR1c5VVli?=
 =?utf-8?B?RCtmOVZMYnN4OTQ2YmE3ZUg4RHNWc0VQODNwVE9HOFA1enI4VGlhWGJ1Sktp?=
 =?utf-8?B?YkFRakhSTW1FRkdUQ0N3UUJ2UFBiclp0ZktMRHNWVC8wRkdyRlpXWkxnK05U?=
 =?utf-8?B?UDd5U3ZiK2xPSDRvaXlDMTZneld4Q3pzTHd6Z0VLbUY1ekZPSnZQUmFJSXVh?=
 =?utf-8?B?clFuQVFXc2RHZWplTWtYSC9ETHROV21pVGZOclhoaU1RTEw2WUlSdFRJN29W?=
 =?utf-8?B?WndzbmFqWlBUMGExRjBWMHdHR2RBSjArZFZNdFRoc2lIUUUvb01tN0R1NXd1?=
 =?utf-8?B?eGU3TXRGMUJyYnRUaFo3aEh2VUR3Y3MvM2QzaitpRERibGdadkQ1NU9nNFA1?=
 =?utf-8?B?SHdIQjNHUHpJbFZ2a2FOOEJrQ1dUSGVvRlM5RjV2TGFTeHhreThJNW9Eem1s?=
 =?utf-8?B?eGszY3FNQVZQSTE4WmJYSnRuOFFBcm5OMUtuSzZGVWt0T1pVSU5xYlppdXpj?=
 =?utf-8?B?a1N5UnNKMHlCL2F1ZndMMVVRWGdHbjhrczNDS05oNklWMW16NDBsblVHKzRG?=
 =?utf-8?B?M0dqM3JINENBTVB6aDZSMWMvSUc4clg2YXRiMkduMFVJYzJGbUphbm10QWUw?=
 =?utf-8?B?TTIzS2NYTGFhVVRpcmRML3RwbFZXNHppaGpOejVsUzJlOC9QOERYM3p4NFN6?=
 =?utf-8?B?VWdUZUtWMURtYTRYVHBlVENZUWozWlZVZjBubXpaZ1dwUHN0bHBoWGJVeTNS?=
 =?utf-8?B?NE1qYXExcmkyMVIxeFRSZ3VBQmpKcWs1KzJKVmNFM1hVdFFnNHhMTytmaTkr?=
 =?utf-8?B?QnFSem1QS05td0tsRmhjS3BwYUVxaUNKK3oyS1NQbDlyUllZTVJoSTBDazR4?=
 =?utf-8?B?NlIycWlUKzEyUGVrNTZBR1pzUytBblNGcFFSYlk1dHBRUVA5Nk5SbGtmTFpU?=
 =?utf-8?B?Z0gwSjV1SkpjbHdjT2I0cVh4cVlmZlhBMzRPRVhVanVxTFRkdFltdmFncCsw?=
 =?utf-8?B?UnczTmhFMDA5cU1TcmtDQVMzbllNenZBN1l5Y2p3ZVZFV1FRSHVUVWpIcXN5?=
 =?utf-8?B?SzBNQlNuamh2eHdXNlR6UG5WRS9pM0o5SU5RSjlncmJTZ3IrU1VGTDlnNktU?=
 =?utf-8?B?SWZXN2Y3Sm1XQ3ZYait6V2tzZFZXK0RNc2R4OFFUTGlzT3hrYmtPeFRudk1v?=
 =?utf-8?B?U28xWjgrT0ZOTG9vamk1emNJZzZnOFNMY3dDeENmRW5McFI4Ymx2WEtXZ0Y1?=
 =?utf-8?B?eWR3bEs2Q2JHVS9hWmUvTWNYMFdXSGFrZC8vUlBoYk5Wa2dkRlUxdE5peW9h?=
 =?utf-8?B?dURKWXptcEpEMDJ4Zk00VkZyMEh3cXRLWjN3VUpBVzBoR3lUcHpaR2F0bkpY?=
 =?utf-8?B?ZnpOTFpPOUJMVElYOWtndHZNSWJQYWVDZE5QbkdJSWFwdGY0QjdZSmRicVZM?=
 =?utf-8?B?R3ZWUTdZNmlZUnYxTTMzUSs2SWdpUFVMaFFFd1pPa2hXdHozcFlPQndjeVlp?=
 =?utf-8?B?NXIwNEtHemRTWk1tTFAzeWQ2eWtscE1lc3JIQWt1N3hJWjVVcjQya1RTR0dC?=
 =?utf-8?B?Q014V2l3d090SzlLelBYWStqK0Rnckphb2N5Y3lQeTVFZFNna0F4bmd1ZHMr?=
 =?utf-8?B?MEhKYjBUeWVKbTJDMk1YSmlMUFlFdWhKVUU3bHlCQzhyNytienkxSjAybUJS?=
 =?utf-8?B?NGRZb0lpVG0xU3lwMEhqaHNUOUFDdTV0eXdnSFE2Q1k3aUVJMzh5OXpMSVNR?=
 =?utf-8?B?WVZGNGlCUGtReHJhamxPeTNxeUNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ADNgFZJf509IgYaSL9QrLfrLc/RJcr+wK/Dx7W8RV+mbTBjJYEEUt0/5Cf9MvcJsf3eTwm1Qyux83bEjhUVB97E4J0bQkEqZZWTIKCSVCg+hiPHDIJWr1ZvQuglEF/HDWc/9Lr/WaasDEINXhiTycQEF4nNcaLCu3aQiJoR1y3Ky6LAv2wiOzOypRdwKFsWPRUqTGLbjubPs3dlwz/PvlIGbVxzQ6wSCTrHSdceaaLWvF6C/RwbWYibL/+ynLBj4uOICWK0AtCUNpHY6cpzud5T6aB69QnWyprueiMs4KMNDDcz8lys+oV+j7CIcKA2JrAS6sVU0+1Pj9vVIrseS1hPKvfeoOEOQeqAWEz5Zfd+sSTQmMODWNDfKYoWmNLf1hQJABkbZOrmrEaeOTIRRVBfU19U7gAZPztM8O1fN45GbjvxGbg52liPe0rjhUZOE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 11:21:34.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad0bf6c-a702-4d1c-de92-08de6edfdfce
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCCF14A5A1

Hi Niklas,

On 14/02/26 02:03, Niklas Cassel wrote:
> On Fri, Feb 13, 2026 at 06:06:00PM +0530, Aksh Garg wrote:
>> From: Aksh Garg <a-garg7@ti.com>
>>
>> Document the architecture and implementation details for the Data Object
>> Exchange (DOE) framework for PCIe Endpoint devices.
>>
>> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
> 
> Usually documentation is added as the final patch in a series.
> 

I had placed this documentation patch before the code implementation in
this RFC to allow reviewers to have a look at the architectural design
first, enabling them to provide meaningful feedback on the overall
approach before examining the specific code details.

> I think this patch should just be squashed with patch 4/4, and the
> squashed patch then being the final patch in the series - patch 3/3.
> 

I will keep this mind while posting the normal patch series.

Thanks!

> 
> Kind regards,
> Niklas

