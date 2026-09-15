Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDF374170;
	Tue, 15 Sep 2026 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451593; cv=fail; b=VIPiX1Q3D7HqTMmBWPhNMm90UI0xNiSFpBjaBAgEeDO/POUBoHQGVjiNGhUDmPbKm67oGw6e4gXuIRtugAaUN9qMv1g4KWJHB45+D98RAnJdA+18+3N5iHYh2zdbMSrwLciI4mRusO9IMtCsHpHcaLYPW7+/HXOOi9RRV1PLAXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451593; c=relaxed/simple;
	bh=YE+EeT61/CNqXzVCHSpCb+LT3xazsAJR58ugU653CuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PscbzcZHkOguA8e/BzdafTR7qjwltRKp+M8Mhl0pHeKiJu5zObsDXWtmrOQEVEEAVarqlBaEZtc3nmF06ENMIKOcHchhZaYzV4Eb8ouevjuHBljjL0sNk1VkyNGY70RWbuXjQq9SQICBY1Nt2CAgwNKVUUFugWVIfbT+2C8zORo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=OdIDh/np; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ug67+uWs; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="OdIDh/np";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ug67+uWs"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68F2ldL5683759;
	Tue, 15 Sep 2026 00:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/8DciEgSQ6dDPr6Mjh648Xrj5YiOUDY8mnK1VcMs6
	ck=; b=OdIDh/npsjmdCmtlwerOGdoCDHLnL4imkfODMQd3bBDzCGT4h31dZbW7q
	XH1ALQuBqvLn5Fqk1Ekg6o+iJZQ0Xgep3rqZdoJBCpO3IqVtr1wgHR3PXauV58oC
	7dkk6AXLfuz4BKigmTX50WzFDi34qdRN/mudIlsmBhvAOYATIlhaRcmajdYbZhgD
	1OKkystEqAGFtXeCHMzbgyrfyn5q2leFeOexIq0Q4Cnr/wp2CRQjdjV/xhaMPzd2
	5eLI+MSBjpRh59TU4wIm6Mion9Ujqe8AnVkP6xSGozz6+L0riSjGjVDxsksJObo/
	dk0zRMf9EDpRzOQcU43kJ6miJJ2bg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gpvpa183r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 00:52:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2RnEUJqr8DrZcQs+fu7hHUpKDoZfnx/mhRrdTapeuBCcmVCjPGVRlSFD/y0FT/jG9K7Z5odaHygBQTRr/k435z0oUHrdUFkCnMrbttFFiF9QhB1zSbRm3NT2mUy0qupMMdBcriB0doe9rjBnGxVe8tbg77PLTlLUs4ZWPjYkItZj3ldy8Pxp+znUcL/VpznVj7quKauuo3NLQR6+mEYzSvS3s1Rjgcvbz9SM5yuyPAHHqBJ5WZU5zUnAjf1qszomlCQFOJyANdGEFcWlhdHsesEnZU47tDWqZ7cW9cfRtsC9RGhnEoJRvz/IAZsfHgGaLuUurGuFKJtZUVAKegxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8DciEgSQ6dDPr6Mjh648Xrj5YiOUDY8mnK1VcMs6ck=;
 b=jhrHqYtJzIzAEuIcaMuA0fsJsSG0TI9+2gfwU1n17bBuDVR/Fly395lGCXEYiBt5Agg1rtLaSeUcwqEmbxFgvVPW7hStlyOVSuWtL9uUBWdPPgGSevv0gLw3M/rzIF74toZwrw516vE33xWvVAh45lA8qQCPbo8qAwlEYP6uw+uc1YGdIX/cBwLEMgVKnkIdSTl6DM9EwDo/2gIWaP1+fGBmIaEj4ddoShKOrIe0f03vyBhhudxezFogFjOvvLaE6EDn8o5Ris2rw0fIgoW0zy9jknOXASPdv+Qy8d8ljkf+0Q0n8H65k3G8HmkZCPbIv4hBXtK3mZu7E/t6XFeYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8DciEgSQ6dDPr6Mjh648Xrj5YiOUDY8mnK1VcMs6ck=;
 b=Ug67+uWsCZ8PfY8NkAChfjzAhLT4fb9czZ3CgH3DxjTtOpjty5YvcTT9Ymn+/ny7kno7obNUyNHqdfUJibPjNEnUcD9aVdrONjpKryRVbst2Oq1juZ4CIGuSboliqFHJnMm0x/dEoSIEbrCA32r+UVdU530lVp3SRwtvx37YiJ4=
Received: from MW4PR03CA0037.namprd03.prod.outlook.com (2603:10b6:303:8e::12)
 by CC6PR10MB079336.namprd10.prod.outlook.com (2603:10b6:170:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 05:52:49 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::ab) by MW4PR03CA0037.outlook.office365.com
 (2603:10b6:303:8e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 05:52:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Tue, 15 Sep 2026 05:52:46 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 00:52:05 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 00:52:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 00:52:05 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F5q2hI2635670;
	Tue, 15 Sep 2026 00:52:03 -0500
Message-ID: <14112866-62d3-43f5-985f-942baa5b5637@ti.com>
Date: Tue, 15 Sep 2026 11:22:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Store the core controller in platform
 drvdata
To: Linmao Li <lilinmao@kylinos.cn>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>
CC: Rob Herring <robh@kernel.org>, Tom Joseph <tjoseph@cadence.com>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260915030044.4019259-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260915030044.4019259-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CC6PR10MB079336:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ef5dc5-260c-495c-7938-08df12ed917d
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SS/m8GEANTfBm9u2MfpqljHYzBcVHwcCWVZk48uvp2dh/vCbgLPPX1thUdlYHRhPffijXAfmjtTaBfLSAGsf8o6//A5dBOo5CJnyiC4WlV++NnOydOyap3ETZIk/OtyWFhNyXddNX346jqcPJqB5zNXTIXe2nx1Joo/1eOIA5GR7lmGDp3cken6cjINLbxkVEoE7gswo5aEidcFHh8/EOv7D361bx09bCoTuNJ5rlq5MjWvLkQm9wMog5taBfwQgKGF2gppy75HdWiTr+uqY/fALZFGfDqHIkheosYWFH/pc6vTr/EJODDv+5OZYEuJkm98HwJ9Xd/ezxdAlfRYuoUo7A0WeBtOqts9qVeje87fcb5zn0e1owQe49w5P1fNeTnjtZHfVolkXo8f4kx05wof1Aw9wJ47H+VZs8pXq5iWuojF8ZWApIGqR0FrNsxAQ/YTzWbD2lDQFbxBxgUok6FKOOXci/HGqH0GkwpPk+C42oc3FVdDPpJFX3O9ZSgoXS5MaRPHlJwdq+t9XQRSvrTgfSIDgoUBq36cbYQqqUDgQ+EAROWLZR3zgQZwr6dQxcGcDwAylAvmw3de2W8evZgT09covskx4D7S0uyhDpihVNJ3b5bKMTwetRJdPMdHlQ3VvCoTqrxewEZBrVrO7A/liFuStdukZ6EC+Lt3Z0xlrGcvpr3U+qjd1AKpSsAsMtSdGTQhDyBPOEbe36fnCDQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uic1w2Am6LqMGMRqe9rwOe9+1wOCb1Jg6E8n/BUuS6ZaPdZgbWB6aoPw+Xe7cT6ehHo65klsYjQ0A59xT3H9UspmRYGwOvQWImTsRq4rAjy63XIvG7g9hWIZB2aJG9arp1zlZfEo9MzsPar9QmuGJHkqlEeIbxsIC5HyGlxiJ+TdN5x56NOvXrpru9CiDcQ3RXN1rJ5+/G+OpYQuAW7BXg/iGLvKgVX/IydsggTLsdlETVlF7I0y1xIs2oeNMi2PR43Quno6zogebeGummj99ZtRxo7vRSiadfs5STInJUQ3ZgYiBPI9w1ya4fTVL+rRJb1frmf0XpCYc+DPFx96eTLhh0fWr0ZRgllyOwFXUIonflgfWkrwCkIHVtQvsVeWmHAwq5wXgVQlvq3oNuI2S9wZjL8pMMhr/r5+NSr+UoQeV+bHN8N+CjN56fKyJwuu
X-Exchange-RoutingPolicyChecked:
	GPVRr1/D4agdDQdkR6kcTJ3EaSKFJf4zlKEySV4ZYakgGA655QeV18LXVat2hhotT4qfyX8Y6rmyFF81S2aDGQLRpxA4c72HRWo9E8V9tEIAD+lQl/7awa1rk+DnN8Rm8595TLIZlJ6cSwVGEx2WfwqpxLGoPHAC9UZIgzItuJZoP/ISmuzvazuNFewhlfwILhUD6Cq+9A2iSAUGeV+cdOL1uuJu75bIJpGSyRlRWrWEeiy9QA7IzrHeUB8EDOS1FgZ7XkbpgixqBVrywMFikTzYa0H9+iionuIFsKAXox/CWuV51h1DEHETp+jy5YWxeYZp/gYuLKwky1WEGDZ+YA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 05:52:46.6108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ef5dc5-260c-495c-7938-08df12ed917d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR10MB079336
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA4MSBTYWx0ZWRfX2Ggmrv7XvvtW
 vXtVdqEpefV7gmg69fIOaRTRAw5uOlJQrDFGIaxDBB/v7/hBfuBH8HvJzDoK2I8NWf+NByRtccA
 DfpfYeBHRGxkpHxoCy8WIX1aWbWS8fgCUyCRS2WYSeWI2WENGu/sfQFWXMQcjcPgDWEqPcrrfmO
 66thqL2nSICoJdZBlAs5hugD0IahaS5IZ7TmZv/DPTZdzMacXoqqxOgiQCxaffJzwl+ryztAZut
 0M8jQibDJnL4dsoxs14DEFHUQJ/OBeF0gGLee+o9FVV3kNDIZqvmf1bZIfJrGdgZ5G3fUp5Q7h5
 ddm8OCKnjjHUmF7VdG1lK1u9XMClz1IpHEJQwY63Ya5IhzXT0kZkKVkzvj7hBYD8S94eVQOYbot
 GfrH2QOpOTTdmg5JWH/xUVsY+SXQ7yMIXtKr3NI5lPt5NgxU1SaUOMtOEqsLZgjHAW5RIwZbF8/
 5UVaBWYyqumcZAVg+3w==
X-Proofpoint-ORIG-GUID: iyTsU5S6EkDztE_gSgGyoKLkpf1mdigY
X-Authority-Analysis: v=2.4 cv=U7cHnuru c=1 sm=1 tr=0 ts=6aa8dd33 cx=c_pps
 a=AqWYtYKdvuqIQX7AE/aD9Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=EAFpj99wLUtKhCG8CcAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iyTsU5S6EkDztE_gSgGyoKLkpf1mdigY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA4MSBTYWx0ZWRfX4TvN6totDW/9
 CyCiZhBT200v0UikSn5c2AbpnjGJOeLX8sQZbKN7AwAhRIfQBkI0gHbIb8oCXZMIL1pAZeH0o8M
 0gQHnEqKl6rwIh1bL8u+5rDqL61mFWA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150081



On 15/09/26 08:30, Linmao Li wrote:
> cdns_plat_pcie_probe() stores a struct cdns_plat_pcie pointer with
> platform_set_drvdata(). cdns_plat_pcie_shutdown() and the callbacks in
> cdns_pcie_pm_ops retrieve the same pointer with dev_get_drvdata() and
> use it as a struct cdns_pcie pointer. This makes them read phy_count
> and phy beyond the wrapper.
> 
> Store the wrapped struct cdns_pcie pointer instead.
> 
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---

Hi Linmao,

Since commit e111ac7025cb ("PCI: cadence: Drop unused member from struct
cdns_plat_pcie"), struct cdns_plat_pcie only contains a pointer to
struct cdns_pcie.

As sashiko pointed pointed, struct cdns_plat_pcie now becomes redundant
and should be removed.

Regards,
Aksh Garg

>   drivers/pci/controller/cadence/pcie-cadence-plat.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index 13edc6be21f5..7fef237cdbb7 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -55,7 +55,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>   	if (!cdns_plat_pcie)
>   		return -ENOMEM;
>   
> -	platform_set_drvdata(pdev, cdns_plat_pcie);
>   	if (is_rc) {
>   		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
>   			return -ENODEV;
> @@ -114,6 +113,8 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>   			goto err_init;
>   	}
>   
> +	platform_set_drvdata(pdev, cdns_plat_pcie->pcie);
> +
>   	return 0;
>   
>    err_init:
> 
> base-commit: 9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d

