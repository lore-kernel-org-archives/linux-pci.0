Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1761F30BB;
	Thu, 18 Jun 2026 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760000; cv=fail; b=sF8/TCbycF3fF76YbC5j7WLWXyhezYNmkY8pSu1t2f/HbKZ2d2LYZpcDwpCZcLlUOr6WwV/XLiK6eewolDbcqWaaxayGSLbHgfnwVgqWHZT/sULVTLy3QqCk+f5/wgcw6rDEZF1n9O96rjULOWq2uo8Y25CLCBMycfyAR86OR8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760000; c=relaxed/simple;
	bh=81OP7boHvC7m5Io7vzk0ff07O95N4qBpYuAwPiKBYyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cEsYHbMahnuga+N8TeyVE2dEwhVXBOEVH4tEniqkvOI2OCzyWOLLYRbBRaGe/KpHjOGR4KCNQrVrsBy42JFeB1zNBrOmLvGsPuv6WXdVA9CLUny6oqr90MvUpIRnJgXry2iojdpuGb9of+3JZ1rEFB6j1YPr+eXcpqq9wcs0DvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GTeQjrg1; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QOci5uQQ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GTeQjrg1";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QOci5uQQ"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I0ORpm3435889;
	Thu, 18 Jun 2026 00:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=7q8Ynj1ghsKsLxANonRIrTbLPNK3rttoQD1RNsPat
	S4=; b=GTeQjrg1xBisOB5uPhi6wqdpenNFYa+koVjOYuPuZ8OGWpSle4FkF2TGe
	zkSKWH9FH38JRM8CHQ4P+C33GFbenFFejIynchpdkr0i2uNu9dJjAEdkmboYO78v
	fHmz0wtbcewYVhMnNf6ffTuCiGyJOoggL9EQVZAGFlwHGPePPZW2Wvp48wKZaWuS
	ramafHm3DEGxmeqYEowRFrwAGCaHVHAoOT5w7t4NQBlDUxRZk1Ix23SLLVvf7SX5
	o4NGZOnH58v4KSZWafQFlbERlYjkLtZJJb12A2bKTh+4USdx8P6PXFzeEOsn8g45
	yAyu3GaeSIca62e8nlO/9/dSX+eng==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev63rhcq0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 00:19:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3CvpTXeELUZLZBXadL1KH20EOQO/yGQvT1rUmL5fsRtgcU7xkG9zN36DYG8nR0k2+TlbLePCajf8UMsSB+rxcNvWv1/4fTt52NotGKx3BrUKSU3I+KN7FxeXehbmfoAskl2K8/toWf5yVjkuVOeOpkEgOjOhOZhris6Wcua+f6tYjuZBHKcI2K1kXxYwK6BzBRZDZi7umFLRIzx2mv4F0PbpNQoXzbFLX5nZLDj1vnkpSEv+09CD42+oOyrWkdWaBUhKlZN5Rof8HJwQK4aVLim08RsV40Jkmf5/JNwVlFlTzi5sUSBnhuW28M5Ulh2C/ShWW/HRsnSFqci2hlJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q8Ynj1ghsKsLxANonRIrTbLPNK3rttoQD1RNsPatS4=;
 b=wlsp4dF8ujq0XWDyZQ+2bKElVUgjtjwtorQZfoBDfcl5nERkYMHZJ6XoFSJAe5rGtKi/azOZdCKCNl8DYfH68jfI0s8jIjQIzvDEsY1Dqjmk2rWFKLmsrDUNIy0iRxtUHImiNRlIUJ4TO5mMUpf6rO1J5ZfJN0cfKHQ5+89MarxQy8z/ZLQxbtRTA0g4pjzaqzOPTfW3IbV5gn/kddWmDNqtBslaAX48C3sC3XMi60qvIPAD1OBB4Hmz1M9fsDGsimmrKTLeSc/xW6+UwSl9jy8thxyBEN97pA4Rs8Gp7wj6/xUXsqtU6dAj0gF9ke2WOb3MWcnO9wXMMKl+viZWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nvidia.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q8Ynj1ghsKsLxANonRIrTbLPNK3rttoQD1RNsPatS4=;
 b=QOci5uQQQ9VyGbpZxxHz6sd5HykhwKV/APPG5P+oYSyKBcxRGZsw/AWsUvxCKpwGDdAW2QstpR/Izn+Ks410txFCUaaUm2CJet67kxnUT0PCoo4PIsvYVz3wUF8/YAQhSxLkV+gG5V4vFpvwUXVWAK67Qs76mXXbn16OAOQFiWM=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 DSVPR10MB244415.namprd10.prod.outlook.com (2603:10b6:8:37a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 05:19:26 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:2e:cafe::1b) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 05:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Thu, 18 Jun 2026 05:19:26 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 00:19:23 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 00:19:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 00:19:23 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I5JHlV3292259;
	Thu, 18 Jun 2026 00:19:17 -0500
Message-ID: <667c890d-0bd1-49fc-a4d0-59e33980a0d1@ti.com>
Date: Thu, 18 Jun 2026 10:49:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] PCI: Use standard wait times for PCIe link
 monitoring
To: Thierry Reding <thierry.reding@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Thierry
 Reding" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang
	<Zhiqiang.Hou@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Michal Simek
	<michal.simek@amd.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Thierry Reding <treding@nvidia.com>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-2-eae7ae964629@nvidia.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260617-tegra264-pcie-v7-2-eae7ae964629@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DSVPR10MB244415:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6667e0-3bfe-4408-62b0-08deccf92a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|921020|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dqCRycxV/JHXT8IEfOgYMAqHtjp4Tu92RNZzc1pQ8SJu6s3wPAK9Ve7f1TN0LC2gUpHjsWxB0S5BKx08SIn8r5brRY84m99bz/zEfIFkbVvls+ttSsUTwCUfNNHgs1hFqsQoZqRLM8bKgB7zm4Ngtlks0k9ttmMZvhN8U5hKyl+nTb2NfpbKsKss2WkCqlE5cdKnWYdh3jmHL+SZ1xQWBWniTAwhjsJmriJ9TzhKoJ75JBhxA+mYlblXsf+OBAokIu5Bb50SZcTpS6Cu3lShQBYQBeRltwxQaabT9578vZH736ei0rsQKJlyhPOeSq3xGimCKJUj3EXNwHA+Qa6U0KksSII0BbRa8SQqL5iD76kablSak1XMQevSusmS8KoirjX0Ka/2120PDzb1fzTEJs3q9Axd+OoG3PI9PHZe3v8BFnLm0Cr/zt+CStNSGmjcxT597eRXK2yo68Og+hshkIpnd7yof3JYlZP5x4lUdlqVh/0XaI+/qYEJBgBnh7jKUAp8trPT9LKX9pgFqwYkWI/ltOIfoe3nJ3UvNKOwLzlfqy01v7FACgUnldNb8g7DE4/Z76coWowDEHATlWesjvRIuha9zg9+a638zAOA369DbroxlU0cMm8aXrwfFwGQXPYKxT+cBLWXPOLaJ1Nt/g+mifLN6UObJGigAcuZ60fwvvvBrSUZg+/Q9mGxXaHrmMmhLaJUDm3zH2sx9XPd/ENHQYjqyKLQFyT7b/oaSO5zRFofsi+i+0mE46DrVpWqRPwQ/x6cTuQ104DmEZTUUQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(921020)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hl0ojE8vQ2fnOS3ilgcfoqeokuRtXbwk9yR7zf8+cVlSPM5qGLKwqrhGJO5VVS1OFva3pdIuvPQ4xT2q0UHnyVDTmCdh/mcKwgFkOxeZFcVCqeBTytLeTCQGXXS9KGFxixPhLIyeV2qkQP+0Q1Gw76QTxHjWG/RPAmaKQcUnIBlnub8BR+fWoBRpc3nETj0oe8mGW1RU1XRfkn3QDQNHAB5QYaQXfwBAgdlp2kWdxH+hnNlEnxQqGi2dbPuEVSpErdaHV+PpVlkrLG0J0tC2avzbXy2Txxl6dZpMBGQMUBfUH7B8W64S+wKQ4jFGm1qDBKFRimd1E+K8rnNjb5rLi0hvvS5wuY7kfH04bresmcvoUgLNMgN2gD9d5PZPzZFbpw4i5P7k6VV7mhmSlIdStLESfKDzR4Ol6XAwlBO1Nob5RwprdswRqqTyGJSgXDsV
X-Exchange-RoutingPolicyChecked:
	Gi9qVnQkeFvt7pKMAMcNWbMQBWZ94LP0PmWNMX7WxKac8WCgRaW8+xGp8fHL0XH4Td8mvpWsH4d3D+FgdVRqo60Ky3erY66qYuaHruzg3Fhut8lLyvyVrvU4VybDsIybUZnBjcUpiZuIvUcb/aOn18eluNlheSPbTwWEliCa+X0BHo+5ZOFQaJdcnEn+2LV+lF2nsCX4oDhssbI1aAuJCdyjxFQlmH7k92e44N8GCU8zYDceFLIuLf86/nx6F0Y3iSBx9YlAikRcSUxAsAgkZ76bU6B9Lgwu1uMrVkXaMO40dx2c98du5IShhqGefAmDckTC4e8lv8XtIJz1XUatzg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:19:26.6014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6667e0-3bfe-4408-62b0-08deccf92a9c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB244415
X-Authority-Analysis: v=2.4 cv=LpqiDHdc c=1 sm=1 tr=0 ts=6a337fe0 cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=Ikd4Dj_1AAAA:8
 a=sozttTNsAAAA:8 a=9pYv5q21Ckep_k857DUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX7teoC0LZtLGW
 gaDNsjjPXEv5qp9CvXlcalZz307caFIX2dJ6EyGrBffRfzOYfNLNQnu8e+/zAZ1PQ6IF57hKdJE
 /UT+QJhI3sfwOSZJ+hJPb4wvw/SBNgkGFYKVRQQGb+Dke950BcM1US217t7hrBwOPFIGPuc3wrn
 TvxAOxWp9hH5EySrGf1XYBfqi8Ew6AzFGEFJDS3nTukgo3gtjIbNZ6BnGaJ8ZQPtaSLUhyd59nc
 /p0GPsYGPsvNQ+gU1CeUracFJsDxHbHQZzQ1ur9B/4YlUHGXcosNqL9SsEQoF1PBi+5ZnfFJHCC
 Clx4PWISL0P/WDZwtSDHoTZ+P1REZlA2PEy9oqmTQx+hrMlySiY7baZPMImQ+LpUYd8eHUjrWQy
 SZ+s7lPoaha9mDsafT1RwL+H/X3Ulsksmk0S6BOY7aP61EY4gNg6VsYoFZ6TGJGWB66gYLaQM0r
 sdeWdN5UdUIRVogP2Kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfXxP8yNXbG8AMe
 e/LyUJW0HEBPSVTVl2UBHAz5AXLj18TKofRUtoreN3LHBuesies96sCfuJT+KqGq41cNjIJpXjg
 wiELW4SQF3vB8uVpIySR5SxIE9HnKd8=
X-Proofpoint-GUID: Zj21siqmYkbrvvlcj3stp47wVA85BPtk
X-Proofpoint-ORIG-GUID: Zj21siqmYkbrvvlcj3stp47wVA85BPtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045



On 17/06/26 21:31, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of defining the wait values for each driver, use common values
> defined in the core pci.h header file. Note that while most drivers use
> the usleep_range(), it looks like these were mostly cargo culted and
> msleep() is a better choice given the fixed delay that the specification
> calls for. Convert all drivers to msleep() and use the existing
> definition.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Reviewed-by: Aksh Garg <a-garg7@ti.com>

> Changes in v7:
> - rebase on top of next-20260615 (resolve pci-aardvark.c conflict)
> 
> Changes in v6:
> - convert all drivers to use msleep() (Lukas Wunner)
> 
> Changes in v2:
> - fix build for Cadence
> ---
