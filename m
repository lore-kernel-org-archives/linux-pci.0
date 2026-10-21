Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792571339;
	b=sRm+T+tWn8XNDi5sg+brlOKmB5EbCK4bHMfqC+ZYjh2WSzAvFW6VE/VSWQAblwMzdudZ
	 wsefqeAYsa/Nt7u15FRBb88vn98azMJcZbDlTUUBmaJRq2yxweW3HKASOIO/ciSQaKKvP
	 l6/CJL/Uje65zzqVSX5HBfjXl5JEyeWxgLaBpKGQkBnIHZnWDkQjjDZgf195Nb0+Dklix
	 fuS+uPDXIne9znhjyZOqMxCCPNd9Jbrcv0I9fF7s4xmpDdy61oRnOXR+yAh0ut8SU/T84
	 XcJzLeZ7WlQqf01m0BMvoI8t4zVpWc6OYLQ1/1eMZsSPma/sRkLUrss2P7+BwoBNjVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:CC:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zLBMx0TJp9cjlNOs7bq0bsc/4MOLn38AYR2Ted3PwOk=;
	b=Ec/6U+bu7ogNVNDpgUcoaHNK3cFPf2a7miohkdcs4MQ6vp695KQ2DytTnE0sIWk66I18
	 wzV3mAcEEWNgz5oDpFyB6lZ2RpIkcmgDcaM2ff+vZgeOOvUsQfGm3MEloAty7NApWIHOZ
	 7fl+7LWfBuNTAHXNnQ0prcbo2QJMacXxfbrN3ZM4U9LB0o0SRKs27eWZAaIUt0VMGmP4H
	 jIURyp/ytv7uUEEZ4dPEfAbtx5z1tV/2BaLFWVvSBIEU+xRbzPMg57nrdzL2HMyjGcJK3
	 /NeY+GfOwVwMB75aHt6fu/odKq2XO9N03FhHv1TA8wqJN2KjrpJ6SVq1KeElGtMmF6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=OrXb1P9v;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Kc1dvAH7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56A606A31A;
	Wed, 21 Oct 2026 08:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D56A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=OrXb1P9v;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Kc1dvAH7
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5hRiO889463;
	Wed, 21 Oct 2026 03:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=zLBMx0TJp9cjlNOs7bq0bsc/4MOLn38AYR2Ted3Pw
	Ok=; b=OrXb1P9vD+r8AbHxmpezvR4SlYeU7aJ5Vo90yFTxVQb26FoWJt9Uc45rK
	v7++vFVl9eoaP9Wj6yRJAjzqTS7s4iIcyVvyYh7tiQGX81DhLcIP/bD874m0BeBw
	nWpbsjSACJPkyiOPr7J4rVXYvcZTAjrtK6I1ujAli+LJgkB30khVm2ss+dvpDM4J
	/zjeqgUOydY5S3KKq89HBkjwSfokTTKG0ENq0LFBOxVHOhDl3BQNXioPLil/Vz8+
	ccOmZm9htbS3WjyAiZE7zrQOtwuMF7Nt67d1Z3kStmtc6Owmpbc899jHkBklOxj9
	GFH+2i8IQD45WLrj3cHZ9wFyUtgfA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4henaahc9q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 03:27:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMBzGmt0NOd2ewIvwYDwCalJsOZvutt9DDLQLZ6cRJdNTgSP8Ief8v1E27WctXTylMs0ETW8l+ul6ypN3LBEqZaBJa/pQ3QME9E37BwColx8rqfWwsfM/QnLKbIPFuXVudXaxyBzfHhshPf/rATlzOK8RAQRjoSKL6mKYjqgM1UpbZYFusCFsXx3BYqR7hAVEDEQLSSlp6TGrOIyqnJ4DQ8WuVpmPmJ2ggDjzPvmeEPSfeyQdnQvpUsL+SyfXMJ659/6EGQf+wSdd1CUyL+VMMMDUX/FPykz1A7CwtCP9xktmVtUZ/5NEr48+IRd240yyUZ5E82xSQkL5JhvhPCmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLBMx0TJp9cjlNOs7bq0bsc/4MOLn38AYR2Ted3PwOk=;
 b=vnTCgQghMSeHlzv0G82Ha2YzQdvwBkf4XlN0jProP2zZGiKxDq5YOsl7tAPOEEgUGjIl843TqZ7XHKTk5mhbQEocbhgTRGa9nSCTZQZVoYdhEF4QqaH4lCpZ0zsnF959R3G41qxrp1DtwXCEqfh+Bf8H3+/+wDvh+ffN8pkpZ9YdCZUqXnjcehlZvibiAuBU/YXVJsRGGwQFlMHMihO8RvuOEWp8AA8xMVEqcrgof1b9flP1Bxp9ukZOBu+ebuRQB5xkdQCwp4+9q40xxW+xD/oLyceQdQFV7pcRCpRl3dovklFMlZX1kQb+i5rCH07s1siDvKb6UDYZvqMQ5CKweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLBMx0TJp9cjlNOs7bq0bsc/4MOLn38AYR2Ted3PwOk=;
 b=Kc1dvAH7iO5d5PZ1Xs2kTG8F9hYfz/i5zA4bEUsFVconn+xsmsoZIsSKCPzrLcaQvrhrBJnUTQl9eEbcdO5AS76fXvjWVyZunWJCwbALupUv3JJDTEMvEH56eqYlwkPuacRZHyfbHV552uERjSqYZykNoO4tjsHoOtH4PVFhHUI=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by IA4PR10MB128213.namprd10.prod.outlook.com (2603:10b6:207:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:27:32 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::2a) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 08:27:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 08:27:30 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 21 Oct
 2026 03:26:59 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 21 Oct
 2026 03:26:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 21 Oct 2026 03:26:59 -0500
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69L8QnNV2227940;
	Wed, 21 Oct 2026 03:26:50 -0500
Message-ID: <bddc44d0-5446-40a9-b211-28d0b03f89ad@ti.com>
Date: Wed, 21 Oct 2026 13:56:48 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yixun Lan
	<dlan@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>,
        Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Niklas Cassel <cassel@kernel.org>,
        Christian Bruel
	<christian.bruel@foss.st.com>,
        Senchuan Zhang
	<zhangsenchuan@eswincomputing.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Randolph Lin <randolph@andestech.com>,
        "Xincheng Zhang" <zhangxincheng@ultrarisc.com>,
        Alex Elder
	<elder@riscstar.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Vidya Sagar
	<vidyas@nvidia.com>,
        "Pengpeng Hou" <pengpeng@iscas.ac.cn>,
        Anirudh
 Srinivasan <asrinivasan@oss.tenstorrent.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <spacemit@lists.linux.dev>, Yixun Lan
	<dlan@gentoo.org>,
        Longbin Li <looong.bin@gmail.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
To: Inochi Amaoto <inochiama@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-7-inochiama@gmail.com>
 <179232693939.2114.10956498814503201256.b4-reply@b4>
 <athvDzJHs7WQmBnx@inochi.infowork>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <athvDzJHs7WQmBnx@inochi.infowork>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|IA4PR10MB128213:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc71d1f-6722-49eb-1fcf-08df2f4d25f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|13003099007|56012099006|261009223327099003|261009220027099003|4143699003|5023799004|261009221227099003|261009221727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8HvmyNB2jPBqEtBYCltstgiXepm7YAQWKX1eMtPNgT0Y0KQms0mL+LXQkN60rpiPsVDKIdtNFHpoQOB6CHc8mDto6ZrY1AXnAUJmzzwU7OfPdmDrW8kYdVREY7XxLTWaWWQ8frntfbf6MY8dce6QCYZTCOFnBSFF1KKnC4qxrMgA13ESYyF246a4wxJ2xY+JoG9roq0XKhjTjxe9Q9cQyorcM1hlVFn2a88Z5VVnehFUEz0UvcBZAx6xQS80j0z4dfmlHXlOPDi5gnUxUo6HOX/veCCBAiSR2B+I5O6K+A4Pmo0NgL68mgoFQpZ6ybn0ZhnQa4T7L6RNtZyPqFDEmiWCv/K1gPfef14vTwe3Hkp+vJm1hzWAPkRun+/kZkJo2o1GoaY9NyEbeCPbabnByszIszAK9hbvm+wKqlYqvQzUKFDzHAFIB2kwftadE+IvdmK9G66tMC9XcCCCdcTXyUgY5ieXhIixf2Pg+jVLAwXaBPuaDgZ1nVPtt9zi5uezA+/tXK7mH0FZwdfxgMb4fDZF+ukuEUaoInWRm7WHfrjP0qjrLT1KVk6Sviip09xkbbEJSdjs/ZDgSIum8sItq9j2V2sPhx5xJjtzMY0WhBrS6jEv1xzIUvoMWwtDdj13P85sTKJxMBojWUIPhn/ihw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(13003099007)(56012099006)(261009223327099003)(261009220027099003)(4143699003)(5023799004)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wEBOfTbcwwdECb1kYdPnpC8jYMbyMfs6yVr2jsxbcEXhuyWr1zvDtqI9JhezdqefBMbXJgPy6TzP+NBo/xoIPa8jWNEFlP7rcQSq5+4bsDUznsWglE6uXEuzuVXI5d5JSUSEBj3i64YdMY3bsrFQsE2GpGfmHrvDmZwSnOVQPu+JrCCMK4PCzq6CvpoUqK/lHmhagI1/wNStdJFVj6tM/pRqwAF9kiyQwT5mHdSTjFdK5fswwSBZqy+PCNTq8yqdi9MmmiWGJk+E8k1Tj7BR5U2eKrcJR5q5DrV8tz74t6UNaU3+z733UDoY4+SywEgIOLeaHi3UMEJt82740KCj1+j+SGQwKZqojD3+ho0oBTc+T5t02p25+/91BLub/jn9iM9191QwPHrAv/uWT1feJEBmeHoITEvN2BF8+AeYwgk6TTbiX+Sac6kryTQSmUwE
X-Exchange-RoutingPolicyChecked:
	H8b4cTnxBXWUukApfcTcc7HwqbgGPQB3+idjwysUQQr2kWxAlHEJmGoobdK2jx+i8eJvZy/+gDeWQxIvTKfvegVegV4VXsNieMhyzhpDnFPp7DTrrVau9rZMARVS4M8xGakvTifJCEMpTKKmdCPusOv3T9fVw13iqeBULXhOgpVRyk6jKcgEsyk5mHeIi0pBg9KRf9/M7pnvLYxd8TAlBRML3xQ/2md77LrBnAZFmUFvEOS8XMTy2YNekh9CPX8geyEi3ueP9k4eiKT3mbUzk3L1b5YaNmKAM3fI18nq17T9+c01boOmVQsBtqblZzztubsQCBSmLB2TU1Q1ePfLgw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:27:30.4743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc71d1f-6722-49eb-1fcf-08df2f4d25f5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB128213
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzMyBTYWx0ZWRfX6D6qSiPLorDx
 W6UU1IavRVrGNbJ58MeFjCKGJCX+bQOy9D+tVkLjxM6ejRiRb0EIh3Sb2WD2Z4Fy9+ks4YWBcJ1
 d97Km0paI4YI2T1GkkNUUZfZ6FUEmnA=
X-Proofpoint-ORIG-GUID: eTStzLIAfoKKnan4hosZxZZVxYfjHi44
X-Proofpoint-GUID: eTStzLIAfoKKnan4hosZxZZVxYfjHi44
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzMyBTYWx0ZWRfX2gg4BXFCcPPe
 5fVzN6LpIPL4Sjy4T+Ct4YufJXKnLnR6wKRPWqsmpwwF1Zi/EQ8Xl64ltFA+EyBX3a0r6Dx5tz2
 6GVbIdw5C7r6uLGgfRoWJCVlb+PtsOtUrVA2SF5dskNeta3IYafsVzJ40jI3WmqPDbdl3Ckvm2Z
 LXaZcl+TT4YdNVhZ+dYkuwemCmA7EOMuwvIfVv5tsnVu9IuxlZvZ2UrDPnbfnPVvHb46xFIygDg
 m+2P52kPVVXe9jDS0wOpTXZkokbQbfVtxG9ryH4VKjbQWTZqH4MyxRBT3/ZDLRfv4XgJ7evzcTd
 aBjD+6NXHDYODIPOaVC3eIj2lE9KiJlyBiZ6dpohbCWXTBpXQVLco608RGEb6NzJpQOZFAatDgd
 7vjg+PRtCBlHNmOgDVj2DZAsDCeNl6yDagZiOXA2Zl18/8AjRuNsC3YBnt3dHLh0dREMhle/Ksa
 fFflxsvlBpkix/U/Qhg==
X-Authority-Analysis: v=2.4 cv=cJB1IVeN c=1 sm=1 tr=0 ts=6ad87777 cx=c_pps
 a=Lj9o+5Kg1g76LDS8oSCIAA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=lv0vYI88AAAA:8 a=pGLkceISAAAA:8
 a=o5qoACeZ21ob3yI0s_sA:9 a=QEXdDO2ut3YA:10 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210033

On 10/21/26 1:26 PM, Inochi Amaoto wrote:
> On Sun, Oct 18, 2026 at 06:05:39PM +0530, Manivannan Sadhasivam wrote:
>> On 2026-09-29 16:37 +0800, Inochi Amaoto wrote:
>>> The PCIe controller on Spacemit K3 is almost a standard Synopsys
>>> DesignWare PCIe IP with extra link and reset control. Unlike
>>> the PCIe controller on K1, this controller supports external MSI
>>> interrupt controller and can use multiple PHYs at the same time.
>>>
>>> Add driver to support PCIe controller on Spacemit K3 PCIe.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>>> ---
>>>   drivers/pci/controller/dwc/Kconfig            |   4 +-
>>>   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 139 ++++++++++++++++++
>>>   2 files changed, 141 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>>> index dcfbe7e229fd..f9c27165260e 100644
>>> --- a/drivers/pci/controller/dwc/Kconfig
>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>> @@ -443,7 +443,7 @@ config PCIE_SOPHGO_DW
>>>   	  Sophgo SoCs.
>>>   
>>>   config PCIE_SPACEMIT_K1
>>> -	tristate "SpacemiT K1 PCIe controller (host mode)"
>>> +	tristate "SpacemiT PCIe controller (host mode)"
>>>   	depends on ARCH_SPACEMIT || COMPILE_TEST
>>>   	depends on HAS_IOMEM
>>>   	select PCIE_DW_HOST
>>> @@ -451,7 +451,7 @@ config PCIE_SPACEMIT_K1
>>>   	default ARCH_SPACEMIT
>>>   	help
>>>   	  Enables support for the DesignWare based PCIe controller in
>>> -	  the SpacemiT K1 SoC operating in host mode.  Three controllers
>>> +	  the SpacemiT SoC operating in host mode. Three controllers
>>>   	  are available on the K1 SoC; the first of these shares a PHY
>>>   	  with a USB 3.0 host controller (one or the other can be used).
>>>   
>>> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
>>> index ec59ccb710ec..61b430f2294a 100644
>>> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
>>> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
>>> @@ -28,8 +28,18 @@
>>>   #define SMLH_LINK_UP			BIT(1)
>>>   #define RDLH_LINK_UP			BIT(12)
>>>   
>>> +#define INTR_STATUS				0x0010
>>> +
>>>   #define INTR_ENABLE				0x0014
>>>   #define MSI_CTRL_INT			BIT(11)
>>> +#define RDLH_LINK_UP_INT		BIT(20)
>>> +
>>> +#define K3_PHY_AHB_IRQSTATUS_INTX		0x0008
>>> +
>>> +#define K3_ADDR_INTR_STATUS1			0x0018
>>> +
>>> +#define K3_CACHE_MSTR_AWCACHE_MODE	GENMASK(14, 11)
>>> +#define K3_CACHE_MSTR_AWCACHE_BEHAVIOR	0xf
>>>   
>>>   /* Some controls require APMU regmap access */
>>>   #define SYSCON_APMU			"spacemit,apmu"
>>> @@ -44,6 +54,9 @@
>>>   
>>>   #define PCIE_CONTROL_LOGIC			0x0004
>>>   #define PCIE_SOFT_RESET			BIT(0)
>>> +#define PCIE_PERSTN_OE			BIT(24)
>>> +#define PCIE_PERSTN_OUT			BIT(25)
>>> +#define PCIE_IGNORE_PERSTN		BIT(31)
>>>   
>>>   struct k1_pcie;
>>>   
>>> @@ -315,6 +328,123 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
>>>   	return ret;
>>>   }
>>>   
>>> +static int k3_pcie_init(struct dw_pcie_rp *pp)
>>> +{
>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>>> +	u32 reset_ctrl = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
>>> +
>>> +	k1_pcie_toggle_soft_reset(k1);
>>> +
>>> +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
>>> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
>>> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT,
>>> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);
>>> +
>>> +	ret = k1_pcie_enable_resources(k1);
>>> +	if (ret)
>>> +		goto failed_resources;
>>> +
>>> +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
>>> +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
>>> +
>>> +	ret = phy_bulk_init(k1->phy_count, k1->phys);
>>> +	if (ret)
>>> +		goto failed_phy_init;
>>
>> You got me confused with this PHY bulk API for a moment. I think you are trying
>> to control all the PHYs of the multi-port RC setup at once. But I believe
>> that's not what we want mostly. Each port is an independent entity with its own
>> PHY, PERST# etc... So the RC driver controlling all the PHYs at once, doesn't
>> seem logical.
>>
> 
> In fact this thing is different. Accoring to statement from spacemit,
> for software, it does not need to care about how the phy topology,
> and which phy/phys is/are attached to the RC. It just needs to enable
> all the phy and configure the APMU, which is the one that give some
> control on PERST# and others. The phy itself does nothing on this.
According to section "14.1.4 PHY Configuration Block Diagram" in the User 
Manual for the Spacemit K3 SoC [0],the x8 Lane PCIe Controller namely 'PCIe 
A' requires multiple PHYs (ranging from PHY0 to PHY5) to be 
initialized/enabled simultaneously for a single Root-Port configuration. So 
the phy_bulk_init() API here seems to be used in that sense. Mani's concern 
is that the PHYs for all PCIe Controller instances are being configured in 
a single invocation to phy_bulk_init() rather than the potentially multiple 
PHY instances of a single PCIe Controller instance. Since k3_pcie_init is 
invoked per Root-Port instance (i.e. per PCIe Controller instance), the 
phy_bulk_init() API should configure 'all' PHY instances _strictly_ 
associated with the corresponding PCIe instance. This might already be the 
case.

[0]: 
https://spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k3/k3_docs/k3_usermanual/14_connectivity/pcie.md
