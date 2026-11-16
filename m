Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794809001;
	b=1604DdfHcp5ytDWY1auSO1YdqoeqCSpN8+VF4c6wwN4a2Oq/j8ZzzfdKtyae3WRMKEc8
	 T6n+l7ADf0XRZyRCOyrNnaF3hz5BlHCU8Xx5JyEHcEkwAtK1fZ4XFsOdWgKecafBqAdOh
	 9V+RFxaLE3cePf5pNPW4upWba1p1whlXveQa7prbgDgrPFbUWrVFSe3zAxFJx1yL8XVwJ
	 Lh2tbDFOZqJasZRy2IrLJfkkFF0ECScvpEiZ/XmKN+28Tdvm8aLZNyirAcbK9RLxV2s0t
	 lkqfl0J3OnTcJx5Qsz68CbzfMuYtC/3FfMAb+Nk7lRnwI5B8UPWohe519vicNk59knA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809001;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4OnlnTTJfhndsvWamV/N8Uog89JAU1mAq4M+mX43c0I=;
	b=s4V9DJOchWHTKfDVtI4VFCeQ/utOv2wDD/PxXMXqhQBHUSQ83e0X2wtzgw61PBPopZlu
	 oyxN0eLUeaN43q7aW7eJ1H4YzgT+JARqOiu692TNPcUvie5LZ8N3WOFA74v1sTPZBS1fL
	 KO4WoawVmITD3HfsEA/pfq+b/dQaTrGL3X4MvhX0C6oEymd11mb2FfRUcpu5ZR49ZX6G9
	 0mKLdiFHe/HWKRE74mJyCjPiI5bzfBbO4EqYp1Mk5DtvbIh1hla+XddUvYVj9eIuDc/Ss
	 Kw2t4SjNeYouUzN73rLim9eUETndc7gLr2UOqah6jLWCV5BZk3iCH4aa9iaXz67LLgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=G1elAMbq;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ImnAF+Vp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5655606A8AE;
	Mon, 16 Nov 2026 06:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5655606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=G1elAMbq;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ImnAF+Vp
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG4Qt2b711893;
	Mon, 16 Nov 2026 00:03:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=4OnlnTTJfhndsvWamV/N8Uog89JAU1mAq4M+mX43c
	0I=; b=G1elAMbqdiS/xIMoJ9l5xwMszpkyT4ALFLujitSkx4z57i0dupQxdTRNG
	ubN7R0XbWZ3w+bZ1PF9YvHhLORapWSkcpAXnriRSvZcUisVe7I+RGL7BH7FzQ1jA
	qWMpwIvgkuNO1MqWnsKISuPgWs6+/UgP61kQk/iK9jWlCYi8vsdH5yfqO+LV9HqW
	oMEk/dfDRppJq6ftyuUcOEOVFpbjmCTPwtGsHhjuOd9HtmukTE2jgKBD7Qn19jUx
	R9PaglAvoRPS1aewU/01kGYWoc4maTBPm2B6yNVuJ0MGxZ1VGWcztplM93vGuq+c
	1www8Wu3J7rTLvJFiSfSlHLJgsY1A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hys3u8w29-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 00:03:06 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYvPwUuyfkxps6f8PmNsB+ov1eDImE7xmr6J7sY3cvc0RPXI+5w7YJzNZXbAlKmdE12rXRieS3bYQANK4vYK4LaNx8kN5ezfUhZXsCN5P20AzVDkZYk7b6CADWB7Hs2hWl7gP1aS93N/xqG+kg1iwF7OWflUB1rvn0p/SWFBZ+b439UleFh8gicyxTrzvW4tIH9yLoOSZ9Sw2IC/7Hj7MX/5DERfXpor4zE2AFCMkhKreBT6Hr1yd8o69OhFl0dWjpmzw3lBarNKX3t55Q/b1Xed7aR0CqgNVYiDcqIS6jl0H1j/Y0gH7E20bqSAGdGmmnzClAEkk7Qd/azSmlyKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OnlnTTJfhndsvWamV/N8Uog89JAU1mAq4M+mX43c0I=;
 b=NPVfdg12uqFiCorJNTjMaiFYBBWrJKw/u5lJtRxGgmvnP6yLTXyQEgarwxFx8/MWxGn2Sv4zKwv4fgO3YrCjBwNiEt7ruAce4rnjdONUZ6edUiWoy6WulF0426VmcaFTZfhrh7+EFLnSoPsQZUeWZWVX5sQ3dSgEwBKsSEFlKGS70wESlMbXE1amnUYrcj2iRTb6CiBVscbo6mfBQngm2nPYnYa4S5QGZ729ZzlOxjlN9O8R0iCtjc2dDJaocaIOGvUmyHYiY8ebw8TipNNKd7F39zgPTmYUUFJojBRhDgcNg5ZyCUvgVbX9xo20wgGykA9bFkLgV84g9+SkSFR8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OnlnTTJfhndsvWamV/N8Uog89JAU1mAq4M+mX43c0I=;
 b=ImnAF+VpavzjYKSSanqR/agKKVb7djHXNK9wKARe3D+ESQK0d6NIcWev3Gq89bdSrfhQR6FTVNGUbX5+X0oRbBCdwpuDjVrIk/xowAO8F8AKamzbvC/XKwhD2q2E9f0vpincng1QBVyhGkUGPQk76ENGbfW4nUVr48jK9KMPi2A=
Received: from DS1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::12) by
 MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 06:03:03 +0000
Received: from CY6PEPF00000049.namprd03.prod.outlook.com
 (2603:10b6:8:44c:cafe::23) by DS1P220CA0016.outlook.office365.com
 (2603:10b6:8:44c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 06:03:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY6PEPF00000049.mail.protection.outlook.com (10.167.247.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 06:03:02 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 16 Nov
 2026 00:02:48 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 16 Nov
 2026 00:02:48 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 16 Nov 2026 00:02:48 -0600
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG62j7P112834;
	Mon, 16 Nov 2026 00:02:46 -0600
Message-ID: <37fb3894-5d11-49d0-b15a-8259727e1f91@ti.com>
Date: Mon, 16 Nov 2026 11:32:45 +0530
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
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] PCI: j721e: Fix OF node reference leak in
 j721e_pcie_ctrl_init()
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
References: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
 <20261110070944.996-2-zhaofeng2@cmss.chinamobile.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20261110070944.996-2-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000049:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 42950302-9c82-4402-b623-08df43a7466d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|4143699003|5023799004|56012099006|10067099003|22082099003|18002099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aShB/aD3y7wdsYPZ3bmvOVq4/gusRUAy/YBYYkA73lszZiF4zuyrF/CM2tAYiMSc/t4jEyqqzmKWa+KxDW0dph6ym60pAYZ8QGKA+r3qG6ILiOSFtw3o2UV0Rn5ER1ecOIJO6Wxd3OYRSZ0zni2jrUZqN/VsSYYrdv3zY8l5UHa0EMt2DGyWNFS1WMmYqaYQSutBSCeswUDENnxO+HaRK7kEBeJdFGMMrPVg+PRCkGCeerrB6QUMDYlfoHnF5sWlm/u5rE4LJ8jwywr0zGRIWg50LTaRwmvW8eLBm2++oEkg4lVMS286/2G8Ir1Blsx7qwR/0YyX7yaNhhLOdD7bv52uVOCi5Gql5D1/RY8iJYnXDhpPK47C2R6fYPZaTHk000gFxF06HvJf7tACHs9HVp4iPEILDrmE+tLzyEeD0t8kOEChtPmSdbPwYmVKrjdH5urWwg4mIGVlibh+ZJWKpr4xYe4hCZU4uVYW4OFQT+0tI76vOP7P/POHoqgpoeRgkx6yhm9WXH1MkJShtGKftduBZm2tcEz/g0sPdSAVAlYRj5Xv6yVPp36OwYJpIEoLnn0hMiSPB38EQrm/riBJczH3UqT5BBQS0Xp+i6hnwFT00oeH5BNLC2zYW2+HyBCsgRGH6VrvEiEPRi0S2EMMHsKFgZsONXAxNItqdIBp3U16s8uqRynNBSNY4/lkXcdvty7qWXdabyflMyEjkJF38g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(4143699003)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/yjx/iobG8ejWePlKz7ATb/+5N7FvgQTaAtffwBcHf0lvLqXKeU2Oj1AvP7xIJOWjVkNkt+T9FJjj8SrwwcFZn2SX4AZaKm6tQwyyEZEx0g6nwzigIKxBgI7A5nIjDCX/69fwWDa9UNlAtN/2SJreuWjONQ9wBWkrE7ubA+82rFtve8w1rmefgrVx+FEVSGay3W20cwsoYHBbUP/44fD2RnVWRZVY+LxvHvKk5l6WCEqB4JRv2XzBqG98DTADOHSbK3PrKWsF8IkZ/9A1VYoS8EGN0//qtoRR9Ncvj7yG93hsmZHrCZ3qbjfRzOQ14s5b/GTxvMb0nZDPEnXhCDQZYzJh9o9OaXwq44ziyo900sHUYUEFbMbAS6P/YVbsEgs4GtbvV7gFwJkMbL6zIwqZdnRqJfXLcUugxPpSgg25Co1trbBYh7kfOI/WMuCv0Xz
X-Exchange-RoutingPolicyChecked:
	Pb92XgznV1FDBh8Y2vRfwLMLkHuA8yezqSTACwLVRNQmV4Vtx0RFi/FGLdcWatAeWPRBHSSL+gxBP1HrspZptKjdRtddTtbR/oi4V7XyOyQOn/ZRWuRFHzWYDOTOPDy/KDQXMwyoGsno5gEF7JSZL3Eu6Uo4zEead7neUEvEBVpWocGxGX+sC/GzQ958PHQ+SG3db151WL06M7a+Ay/Nb2F7YaMsZ5amAGgqqTa3Fgde1cOVaR6Db6oRuD7G7Nwo7K4h1s6BPam+YMEzU5Uon5auSsktx7PIxUtDNr26PWxEmDvtWJwN67zG/Z3Q/Yu8nd/eRkwdDExIDWB3oscgrA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:03:02.9204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42950302-9c82-4402-b623-08df43a7466d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000049.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Authority-Analysis: v=2.4 cv=etZKXYpX c=1 sm=1 tr=0 ts=6afa9c9a cx=c_pps
 a=1PQ19NIIScYLh/jfzFkFww==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=R5C9hjxsAAAA:8
 a=sozttTNsAAAA:8 a=TVrfaBrL4su9fHt5qOoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX7paaQuoXNT27
 NkENm3LFR4yO/2aZVbzdFkPs0lnwXRa7lypz6WkG4a4sr3+HGgOMJsc352LoZbvo+XWVPlhqM7N
 k1hmBEfPjEXL93bhdbxWqk8K6wnbrv4Dy242lz/8Jh3w7S1CyzMeBjb+SOq7LgL59wowl0lvJ/P
 nkhTcFgS9TFKWiI9BqIECxeAJ2PxK5KuqRfAgDRvDVSYBeqr5qEL4ILUOrSg8LyYUeAuCvLVBMi
 iXNOCTKIDpsCdp8aFeHNkWa9o+IXewtjNW5y65yDwiAsJbzkVaxY6e6mOSgUUDkT50hfhErxNAH
 V/Y6NtPVAF65+QQguEkCV5g+PIzp4HuxfB5MkTsEdRx/iqsJPcgI5c2PtuSPXLVLv0TW/uqfzoa
 f/LKy7xVtWE6fNFopLfvfo1PYzl1QTLHaWnKR/xe4YROC1qNlLqTzx6/qN2/byoITaJzUMwxqb2
 pgtY9NkMF6I+wvjoR9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX4twjRD+PV6zr
 7E/ih+9YNTamePzKrF9sMGhGwiVzGGNRmB/YRiKQ4uwRMWPPrwlPrLmQ/kd6zqAkaG4+wRk07nA
 xB3qIXC5MZARdLxckhJmvk0Qt7c4PAU=
X-Proofpoint-ORIG-GUID: lpE39w1o3TJl6sfmZhIh4VQLTVXyn7Ue
X-Proofpoint-GUID: lpE39w1o3TJl6sfmZhIh4VQLTVXyn7Ue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160023

On 11/10/26 12:39 PM, zhaofeng2 wrote:
> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> 
> j721e_pcie_ctrl_init() resolves the "ti,syscon-pcie-ctrl" phandle
> with of_parse_phandle_with_fixed_args(), which takes a reference on
> the resolved device node, but the reference is never dropped.  Since
> j721e_pcie_resume_noirq() re-invokes j721e_pcie_ctrl_init() on every
> resume, the device node is leaked not only at probe but again on
> every suspend/resume cycle.
> 
> Drop the reference with of_node_put() once the offset argument has
> been consumed.
> 
> Fixes: 7aa256234c4c ("PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl" phandle arg")
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

Thank you for the patch.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

> ---
>   drivers/pci/controller/cadence/pci-j721e.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -274,8 +274,10 @@
>   	/* Do not error out to maintain old DT compatibility */
>   	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-pcie-ctrl", 1,
>   					       0, &args);
> -	if (!ret)
> +	if (!ret) {
>   		offset = args.args[0];
> +		of_node_put(args.np);
> +	}
>   
>   	/*
>   	 * The PCIe Controller's registers have different "reset-values"

