Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FB5013D3;
	Wed, 16 Sep 2026 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555181; cv=fail; b=JCUlOnqQEHN38Ht22eSF2GGJPx+/nV4Xk3U1Of67aaH3aKfvFPQT9fFjo4Jqm+YYZidB0zE23pqaGtl5RJWKBRceUeZohGVK8xsfnubnu8jsKQAZ/GC+KTyfLyvfzxsUmyC31h/PEkNlxXSe94Qjoax8Md50/NzIuZqmeJmU4BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555181; c=relaxed/simple;
	bh=738wcXJdoHPeCgFwl7l7DLzJASxDGyX/wIZWka0kHCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WmKQ/jpPv4iWp/Z4oc42QDoFXbqYBXoNWewdm6vTXG55gFiXw8wrK1YYapCJMkihlAHHPyK/LwfM4r74czq0qK9mr7Kc/eHrGtdmfRH0rU24jRBZawz6vasmSdIthAItVOxK95mCbqwjtPGOZEYaqxkBhbacupXiAlbikYTHle8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=q2U93P9w; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IxA1+Fm8; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="q2U93P9w";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IxA1+Fm8"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68GAAKC43048334;
	Wed, 16 Sep 2026 05:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=HmLI/b5NAnjbav1Z6xsbCiUe7SpJ6cCXVv3aifIDP
	Uc=; b=q2U93P9wMwF6JYKUQw9WonF/w3ZXXNqsoRHLZ0+RaK9MSZaltW7WyawSK
	a847iz17Ytn6gVa89tpJZJPjP3zDb94iUqRWuf0AMtxzAdhN/Na82RLbcxDS7+vz
	DfqFbOEDfWJ/Bnd3V9Qzlm3NHHz0iwkgyZYXl1iAXkrGCqno7XuuHXEITXvl34mB
	QlVsuqWcDGAM6SVY86v1wyrZRpbZn+HV0TyJZDcuaHRFPWAENgkGTBthGykoJoaw
	R9iE5ABCVgYzY+4KFa6F+X7GvFXGBpObjJwcPN2VwD3etVpv1G6r4dmn4Bfic75J
	NOZVvtET1eIZdfgCe05ONeYOv2F6A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gqfuf36cs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 05:39:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8NKp3mCFu87YGgzvyLZUhe+J9WJBBpD0VEMkpJZXR27Wcznt7KkrRf31kZD4ltR3ISCPqVE8rUnAt5cyTiTspxSgTQ8lzVocq9pCdl+jliEB6eaHofFrmSij2KDAEEGcZV/5LwXV7gCqv4/GnDSqwbNcjgCRcOydcTXo0RzxIaaL99ttb4MiZ1g9sgX7zITxk4gTQPpBxCfunt4tVc/6tQ23sPLX9OSQzMzAlWINHLuT3Z3cqyObFc02iC8ZIOVxI2bzsaoxDITcwRFoGl1rojDAOWu27Ge5PKskEhNvtgupM45z/HCgp/rFNUi7xBlM3xDb+4QvoUcpX4jY7MUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmLI/b5NAnjbav1Z6xsbCiUe7SpJ6cCXVv3aifIDPUc=;
 b=tCPGIagAf3qmtYCi2u9atlgipuNyiDUaVoDBDrsnKfG8cLxfFzk+T5AVLT4e7bC8DWKZUEkvqqTFPWCapXPCojgIS+QfN9Pku2b++gSNPhjzIvzemByQouhV7Try8pXm4t26scwhlCNnhJInNI7TQyrcTvMrOChln20N/wqDPVyB1mxxp5sfpd+Ki6RGA5Z75/ts0K37QsAGrxPoBYXKsgxSFfAd5ZE8cBOPjODWTxrxr27lt3vWv5n8ohJp2IZO21EgQkR2CcqzA15dCU4FeSetu+dxDGRCHK61U+X+Cs0F8XWmskse0qZrXcyVfk7a8kDRadjHVizvH0Bndxirmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmLI/b5NAnjbav1Z6xsbCiUe7SpJ6cCXVv3aifIDPUc=;
 b=IxA1+Fm8/KvPnmA2k2E0skrx5sGjfjJ9HHYDmPkjHbS1nzHU5r84qLTFoE5r5876Rzr+NQilEN0FS1INmC5dxahfYJNVCT2ImTxSMZ7jHjMK15p47w1Rf6n5QfZLhnGuSGjeowLVCMl8JFYRAPEY7oPWL2+v7xKImG1YaHst6ug=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by DS4PR10MB362516.namprd10.prod.outlook.com (2603:10b6:8:4f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Wed, 16 Sep
 2026 10:39:17 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::7e) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 10:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:39:16 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 05:39:01 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 05:39:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 16 Sep 2026 05:39:00 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68GAcvW4857757;
	Wed, 16 Sep 2026 05:38:58 -0500
Message-ID: <5d11ff80-02b9-41f6-9022-b784b9459ea9@ti.com>
Date: Wed, 16 Sep 2026 16:08:57 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: cadence: Store the core controller in platform
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
References: <20260915082826.4135665-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260915082826.4135665-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|DS4PR10MB362516:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f64a33-ead3-4144-1440-08df13dec216
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|10067099003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	XwiQun1oE2eJqV2xcjijEF0muYJ8JRb6nVi6I9Y+HxGAsibyvKkYLGxFKJeIsJGwIItyGspP9F1t9s1c6sR9AEYdlpUbV9S2GCay1RG7FM7yNg+VaVp/tvtG4l01jVvYhq37EKJocUUh8IoNEUwxH9kA6B0R3+D92DtfVrGjhGkpNsru083jFE/iZFl1txyuvVJXGcXRoA9ca3Lj16U4KGmw2a4lFJ2LLq3YqCAaoQAj1SIQnQQzm2aQmXIdaFhmqEoOY1OzQ8XTXuyhzxs+JVx2g2Vq/kW7/BbwKyi/Y7D+bxGFt8a2V/cIevPZjS2N9iCZmtA++dSHzgV6aqdrR3CCtoDgbRMmQshVmz2UVRNaWoZcW5xuD3rtVyJga+B11BA1ZIobn1r9kZcuIh+vrgRxlID2v5D1UNA2C5QoIQoPbjupCHZwX32ibkNasMmIq/XZ2o29JUHvcme0FjSgnoopSW1BmLId6BqLUAl4mse31rDwgwI/kY3TbfOuWHRhUbpHxD/jH36gJPlr3ovtt1ntKLMrs5gGy+ff4Gx5Pm65q5ieDizhImuZ3IVMfDAwXRePRsLnN/Je8Kxe/fpMW0udyVRS6ZgNTP4wC+TPMt98NuJtcVz+UxaUT8k4vDjhXyrkjV6wavvf+NRZENv5z+J3lRm/LmMvhN5dkWqq7u7GuGyGb8ANYf9+kIayYKvjkVN4hsrhU3ALNUDyWCd/YQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(10067099003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6C2sNL2jmHj3UXtozLsJoYhza8EI1pVQayCHLXHrwGBQsQxA6aEeU5JreXC4B6L1/Yk8O/irYdeKTYvoOew97Y4gulAa5NGru287FTneVsYYbAILJv1MGKsZqMCcty1bd6EkZQ90X7FixQv8QCBTLYr8fmc/xV6PIYho9vtLmOjNLtiMCEnnjNwA32Jk04j4zz3mhkf7g9MnIqeMgTr2LGwul/eWSAFGPHAQscPamx3Cp5+NMWGO2fQSfiY9aw8QqnmSXO7FAmNKaeoktMH2IDOmC+1Udy54N8hEjl7LM6W/IqQcYSNdKtTvXeXQsxPMnPgh/Ue5DbdrTqCNmmK/+ywun7Wsvo6I7J3crLqDdCYhGUK19t1aL5FWl33d0yVxL1LWM587vxKBbCkQh0ZTvENuAYEYrh+3Z7HRFiAkrY+JVvQIchgbkQkNz92StWIx
X-Exchange-RoutingPolicyChecked:
	nUwvE+aU91Fu8AuyGhqzfp2t+trYYIUClSLxFjNPHD7FK7KKEqZhqBVmXaZx9NWBJmQaULwtxL9bF4xNUfdFj0dfJ2UOrnY9iqFBrD6PYNpgmViE9Tl0LzAMyMbvpiqbgxvijtVXFjlAIwsQuKtiGW5OTh3BfA+hDg3G/r1twpTnD0UEWOfHG5sinpStA5S4CBl37PziED1eGbu7O/HzFl0KmsCA1zfmYr3ffr7HUiydZUkXwaBSwB6k7RpDO3TnGLk/Ff4rWH4Vpzjj7tgCZ5Ch3OR52mdU7bADsAg/0Mu5uqP1Uravv2MM3hQXtzj8l5Ed/kCE2Co3DYtlwupWhQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:39:16.8662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f64a33-ead3-4144-1440-08df13dec216
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB362516
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzOSBTYWx0ZWRfXwIEmz2Exg14x
 MOfssUggcfyLL7MLRNbu8Znf033b15vXgDivDF4MR6JsMFpPDtbeG6VrRcQ381eXL+I2IW5qZlE
 6qcEqX0wBRhHfenUq2FI48ZoMXLzDCaRt807KeKMFSBe4jIblcQ8Z5SI82OtStXDyP+r5DCXd0U
 aV0uvZNYB4A0JcniaJ4PRuySWHOfwtAJ9SUB02r29kuJ7Ht02NqxkX5AJQ3jHbMLGaJrcL6pZdb
 4EaQQE0Wl8MnOu+Dtjg53Dumn4h1Ry03/7iEtvc2vFd1poyB4XXnxw53W20lbmFGSWn/9Uv3azv
 23C9GPsErD0BIx5b4U3dQEGF0PROtQboFJeslztjmCinEX6vxIM0L6v/WWUuahgwfOo6pPr620v
 zgFpiLCaQifLX8bgfL5dTDnl5Kur6g0QoMYEUW/ipcaCdRmYnh1diQT2LEISu9fyS8iO3KcCMyJ
 Iy+VgnnVtYxawYBbSKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEzOSBTYWx0ZWRfX7y9XND5c82WN
 gJnR5NsD2LEJn2leYAyD9heWYWpwgrt4b5gJd9H/wL2eiW7VWcVVT1jqkXn5c4asdVm4WXCE2G+
 mIFJZJy64XwJSnYFisjE7fKQ12XgBpM=
X-Authority-Analysis: v=2.4 cv=E7JYNqdl c=1 sm=1 tr=0 ts=6aaa71d7 cx=c_pps
 a=F1HhE1toGRAZ88wdd1wKFg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=S-R87FCbgeg6FCKjwTYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZwPxEMsUD0ZsHqmXulIWMIt46xXN9soW
X-Proofpoint-ORIG-GUID: ZwPxEMsUD0ZsHqmXulIWMIt46xXN9soW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160139



On 15/09/26 13:58, Linmao Li wrote:
> cdns_plat_pcie_probe() stores a struct cdns_plat_pcie pointer with
> platform_set_drvdata(). cdns_plat_pcie_shutdown() and the callbacks in
> cdns_pcie_pm_ops retrieve the same pointer with dev_get_drvdata() and
> use it as a struct cdns_pcie pointer. This makes them read phy_count
> and phy beyond the wrapper.
> 
> struct cdns_plat_pcie only contains a pointer to struct cdns_pcie. Drop
> the redundant wrapper and store the struct cdns_pcie pointer directly.
> 
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
> Suggested-by: Aksh Garg <a-garg7@ti.com>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---

Suggested-by tag can be dropped IMO as the suggestion was not the core 
insight of the patch (to store the struct cdns_pcie pointer directly).

Reviewed-by: Aksh Garg <a-garg7@ti.com>

Regards,
Aksh Garg

> Changes in v2:
> - Drop the redundant struct cdns_plat_pcie wrapper (Aksh Garg).
> ---
>   .../controller/cadence/pcie-cadence-plat.c    | 27 ++++++-------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index 13edc6be21f5..4a24302cc5b2 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -14,14 +14,6 @@
>   
>   #define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
>   
> -/**
> - * struct cdns_plat_pcie - private data for this PCIe platform driver
> - * @pcie: Cadence PCIe controller
> - */
> -struct cdns_plat_pcie {
> -	struct cdns_pcie        *pcie;
> -};
> -
>   static const struct of_device_id cdns_plat_pcie_of_match[];
>   
>   static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
> @@ -36,9 +28,9 @@ static const struct cdns_pcie_ops cdns_plat_ops = {
>   static int cdns_plat_pcie_probe(struct platform_device *pdev)
>   {
>   	const struct cdns_plat_pcie_of_data *data;
> -	struct cdns_plat_pcie *cdns_plat_pcie;
>   	struct device *dev = &pdev->dev;
>   	struct pci_host_bridge *bridge;
> +	struct cdns_pcie *pcie;
>   	struct cdns_pcie_ep *ep;
>   	struct cdns_pcie_rc *rc;
>   	bool is_rc;
> @@ -51,11 +43,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>   	is_rc = data->is_rc;
>   
>   	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
> -	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
> -	if (!cdns_plat_pcie)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, cdns_plat_pcie);
>   	if (is_rc) {
>   		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
>   			return -ENODEV;
> @@ -67,9 +54,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>   		rc = pci_host_bridge_priv(bridge);
>   		rc->pcie.dev = dev;
>   		rc->pcie.ops = &cdns_plat_ops;
> -		cdns_plat_pcie->pcie = &rc->pcie;
> +		pcie = &rc->pcie;
>   
> -		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> +		ret = cdns_pcie_init_phy(dev, pcie);
>   		if (ret) {
>   			dev_err(dev, "failed to init phy\n");
>   			return ret;
> @@ -94,9 +81,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>   
>   		ep->pcie.dev = dev;
>   		ep->pcie.ops = &cdns_plat_ops;
> -		cdns_plat_pcie->pcie = &ep->pcie;
> +		pcie = &ep->pcie;
>   
> -		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> +		ret = cdns_pcie_init_phy(dev, pcie);
>   		if (ret) {
>   			dev_err(dev, "failed to init phy\n");
>   			return ret;
> @@ -114,13 +101,15 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>   			goto err_init;
>   	}
>   
> +	platform_set_drvdata(pdev, pcie);
> +
>   	return 0;
>   
>    err_init:
>    err_get_sync:
>   	pm_runtime_put_sync(dev);
>   	pm_runtime_disable(dev);
> -	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
> +	cdns_pcie_disable_phy(pcie);
>   
>   	return ret;
>   }
> 
> base-commit: 9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d

