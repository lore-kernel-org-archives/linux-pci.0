Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794809153;
	b=r5pyRPh9mP9eTdC4Le3v2hGduO/hP4lRwpPZSt13zz4EDBpK5Q0vePcSS4Brdx6omCbt
	 vWmTmz1mEf9BSF+IAUwAWzLHeLLtM27isuHiuueSMD/3dyJe2w9SicHpy5DZbnyKkrV0k
	 TDl6NIvgLlYdmNezJVW72Ei5NvuN3jMBwqRWmQ7y6uqspKRY1WMwKGDKHWNzvp9gG6dn3
	 2QCm2u2Ja97rQytIKYfnI8U30pdRo3ILy6oTvRB4JQRx60DXpD3bT1TjFp9kuDm9Ozf94
	 wsyc6Nh6ymjkSJ6WE6FYKFTgSK2Zqzd7wwQhmT6K62iH1cK9aOHW4evz2TJ5Fk7/5Rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809153;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Yfa8mjdOXFVkr7lEyf8sHdsSE2CNtmZkW3up/HFbVaU=;
	b=A1Daqo2hgM4l7qqshDzrV0+5icFLBf4YA+U8SE8+IG7LUWXQOV8Rrs5FBrytdmfnMH22
	 r5/IWJjEYW054MuWwzlapjOGv7qfltXdXv7cCeh2iSPoVJXFVt4xREmIJFADXm73LZa/2
	 i5h623m4MuEL8bASdwg6wlyXtO3LwtIG2Yvd1EvKagTDeC124kXH5hpKL5W8LYNODVrAK
	 FqN2q6XuYu4PhU6UzxtI7UjwMA43fIawoJJzEWMJvpulgkxPq32tZW0jotSVt5b/zFEoA
	 4hidhQduLRVvB6U61gWoS6fEB6JlMEqqxohXl5qbpTOIPklJ/BeQ/oNdXCAxbAJh9oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qGKxkNbA;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=O3uTHj8H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3C606A880;
	Mon, 16 Nov 2026 06:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FD3C606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qGKxkNbA;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=O3uTHj8H
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG4QsLP4111887;
	Mon, 16 Nov 2026 00:05:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Yfa8mjdOXFVkr7lEyf8sHdsSE2CNtmZkW3up/HFbV
	aU=; b=qGKxkNbAFKQFDo8B3wLNVnxxtIKfRDAzyBQOIzuUFz4sG4739IbtVROwo
	XQvfOSv9ptQijmxZpVtnSp3ngxwQuvENfn8WHreyd3LWaZvN8SNrIywA5Lzpe1Vf
	Zcw0jMKqWtYX1La2kd34+ohDd5bWudSddKKgEZpQmHdNBITMj+awg2IEtQdC7b9c
	0Arq2jYO8/jv2Q08VNMF7DIB/l7kmHhvacTpFF5yPTzGtstejt1UKM2elVjlCuGp
	+7gSFiYOiBlQZEKvc1RljVYo9P2M+3+T7t8i3K/LQbledziJwNacwvcLTOu4R4H1
	lNutoEfpXy+3Huxsj4S7Esa86JnuQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hytpn0dq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 00:05:34 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAA+79yhn2NOhSUpjdArJPhg9jSGi1rYVr4K6eDyFCsegW1JrUGiHJNhKRIEzhSVMxyQmxXROtC3+AChSXSE+hhhKZj0cps6ugjCsmp9XwsR2q1PKic5vBQV2adpnQHcFg5Hp6eKBO8TieTUmKYBsbmeGLRA4xTdMI4V4UoqdFLIQ4A/DUsR/VA915aMaiyIx7n19hBbada5Wa1PisDrrM2LMcC4+ozCFNA2CaY/2ev8vP1Vdq5gETsiSd9XX3I0nwXC9Ofy5/pdlzUH6H+EDNuSDZOH6795r4iLTe9GvEH+2Cq+WsjxpnWflp/jfktapAGiSttFJoIZAKL1sgKR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfa8mjdOXFVkr7lEyf8sHdsSE2CNtmZkW3up/HFbVaU=;
 b=UsuDjhmjxDViuj15HGywEx56w1ysinl/LWycVQwNAOvWhZrvs5nvE3cRnQLT0KWbkxY4K550KJ0H/pETqkbZV9/6Y+sEChVO+OZak8zIETWHzjJ82H634//ho8YmEUZzIL1Wl8DjvjFYpCgTJ8+h3xe5fHSg4fFLWOVe1L/VE4OtsTnfycKOXyBeK6xR2FUeyhINCxH+uHbmDCNnTmeNq1VBPKlIyr8yo68H8Iqw9xJXMwYCewIDX5gHIpJkrH2hVE/2wQ7IPO2tYzjmO5HP5v3CD8RS2V1dIG/KRndXjXqn0kvsQ+nBis88z0wRJKExPE3VNHhducKwcFxJMjR9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfa8mjdOXFVkr7lEyf8sHdsSE2CNtmZkW3up/HFbVaU=;
 b=O3uTHj8HoSLoAuBIqfvnHOjPD+0jChgfnRaCKAM5ceSdjONOispAFMWWhHBUp64HM6iHJmjmDpk4oY4t2ep0ngqLMh71mbbX1VUW2DPwKxtNKWNOY58Rv6rFexL5yzIorvbRzXwnq+K0g5cZNH3gVe0sm8nNnIl8VSowaVa4EpE=
Received: from BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23)
 by LV0PR10MB998115.namprd10.prod.outlook.com (2603:10b6:408:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 06:05:32 +0000
Received: from BL4PEPF000003F4.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::23) by BLAPR03CA0138.outlook.office365.com
 (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 06:05:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL4PEPF000003F4.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 06:05:32 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 16 Nov
 2026 00:05:10 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 16 Nov
 2026 00:05:10 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 16 Nov 2026 00:05:10 -0600
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG6577J1126874;
	Mon, 16 Nov 2026 00:05:08 -0600
Message-ID: <9a603465-6765-47e1-adb8-5032581b98d2@ti.com>
Date: Mon, 16 Nov 2026 11:35:06 +0530
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
Subject: Re: [PATCH 2/2] PCI: j721e: Fix OF node reference leak in
 j721e_enable_acspcie_refclk()
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
References: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
 <20261110070944.996-3-zhaofeng2@cmss.chinamobile.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20261110070944.996-3-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F4:EE_|LV0PR10MB998115:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c77ae1-341e-43a2-36ed-08df43a79f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|4143699003|5023799004|56012099006|261021121427099003|261028144727099003|261022105027099003|10067099003|261026140227099003|261102123227099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003|261009220027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zG9u4k/Vc3iApngNlgLUcTMXV6H1Ajo9JFCNVdD3VDXNNVV27QDk65SjudoIW5mQfKFudlGaOuo7k23JbNCTJLzT7GAOBPXvHwybvqnlfkA06bqf2xlrQ0GmHuuqK+wTlidPBXGz58U2XAwSnWtkBz6+SLrDoIUH9pv/XxNYvdbRvSzLn877syT7fRmir5QQ+t2m3GEKQkpMCg9eFIdTD7bBBLRyz27NUMyfHAwjX+zKKkQH3fwe6hRRxIsOe87hIbu8Azg4auk8GDU0SZAnPHHjUfkoCSv/LCPmNu/GfnGJI/pu1gY9n8xyTuPNP1E05X5tqFqMmDw/oK6X5yg6n0rzTqVyltsKQYDAP6YOafynIuSMs3e44FI7bA5AHejIuSOI4kd5dtFFMax+g4el5QovheBLSPOhJeUfqqMBC2aETNIBCxXLByySdBLx9Ow+bkbi4lTEdjT2y8rO6kM3Fd5tsnfM34lIHBcLISp7h6ZC1yPSRzuCH4VI90B+Mzypj9JOGPAg4+teNA4u0oUYDTwzN4fIYENLdKn6hAbPufal0rLqrJH5TGmWCeIMczaB4CUakue9nTsKKL0S2KHXTgt/ghPF6eNoa+Jf9cBNEJRFRrYWcDjqXSAsOOJABY9rf2IqVGxF9iy3qWgTElp6qzSjQKHIeM5SFWy7BwimZWVMom1mfcQ8OF8gK/D+a+Zd2nFYBlsSY03KLKdVC5qiOg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(4143699003)(5023799004)(56012099006)(261021121427099003)(261028144727099003)(261022105027099003)(10067099003)(261026140227099003)(261102123227099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jkhQ40Ic/ThWowXwqLUV8H4BUAZ4xou0Xf7BmFDOWXZlGpj9W2Ft2SYN4vIVjcE89KVbZQ5KuMtY4notzKWGZCXrQR5X9phkphtEvaFzcw/i24FHWDa9W8gMERJMYzM0iuUpwxs86rXCd9S6bD1W575LUDlOon5WDbctqDBw9pskB0Reil6Fjcq+N6EIIe3Ky+itax0WdscT1TyLP40cGzPfh82tLnl/81FtSVuir68WU8Ui6HuAXAXYNGoVy6TBLTlxE3atYdCksPQTy1EavqMqoPc53ITSPz4aMxpAtFIXybAxLQ3V4EenozZ9NnUAIu11fD1rUidUqJ+biewhd1kpqsM2es1bgyiZIvx0OWgV3Vb5lCkQpaaYk62XHOYLXeOYES601ef6RSINkdGvfqnWvt7KEBeLC2c215/JGnA3i6FYZoebFexDbdcikKaS
X-Exchange-RoutingPolicyChecked:
	VE158VF6p3rKEH659+x6x/5Jq0YxKH/KaQTBgdV58H9nQeECyOI2+Dpv+tQOE6BYyhvl2uhPnrRlXgyV6cnx+A1KovBks3fJpsdw0bJISyw1NPWrHUbwscD1N39xkQSPJeRfrB9yTdz3FqEkz/iI4S1z8W/NxahpRWoJn3S3xN4EJZUsB9aUvPi3CPCy5atBd7dszWS247X7jRBJP3yuZudYU+kM/ue4UvmSfdoXn24RPnahB9AwoEd+opavUFc2A8jRtGUs7BOZcl21t5daG2zqpeVXmGqBurHFpX6/y1PXWMIvdQtgfA0c3usg9qhuNaYP00dv12iUGSikPx0clg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:05:32.1061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c77ae1-341e-43a2-36ed-08df43a79f5d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB998115
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyNCBTYWx0ZWRfX/+ZrGtdKQvXB
 3RWkaNeH39mAGI57tOHWocrvF9J0ycxxHiUW4ks8+CjpcIMtg4hlR9PSiz/ovBVcieOwvnLZEPu
 21kXFRst1KKgpVpjLK8FryeoP5+90/8=
X-Proofpoint-ORIG-GUID: 0A1qBQLTmIa_5518e_sWKI5GaDkjorEf
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6afa9d2e cx=c_pps
 a=kVQeibrV0jayZGAE3rze0w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=R5C9hjxsAAAA:8
 a=sozttTNsAAAA:8 a=noyuFu-MPKm2Tnd2QyUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyNCBTYWx0ZWRfXypXn9rn55g5k
 oe345hahf40RJlkZa0uLMey1DvB6FAHLfqGC1zKSS/tLathoyQZyVpq4lq5yiWXOaAriKUt7Qk0
 NSjU+EDUYttRN2sHIEhQ7hqbv1FNIEWJkkqF6IG7OXxsh/EvuLj771UGZcE/8B/xNVTq2YYa3Fx
 lFZslP/aMVSen9zWOPR3AfGgGenl+piKU3hUf6nnFxDzIwjHRITh/U+5tTxnjV1ht6linltLBsB
 nbRi2iwUrjQEy+YWtbLrMrQtRw+kCNlA53DvPYR9VzjKdiWMmxK5MQGpXK0/MbQ/hMnflFoUksS
 rAUQY9OwW0XFAk05EA9STFn8NLqe6m52sBlT0Hb1/h4n+ETv9bPJz/iswzTJnDrgPkJNGw5goG4
 p9h4300/GziPlRrUtH9u8VNq5oMs+vNLt0Zy/fOpBPa7yNh9OBYU2IUv1y4UUqkf9THN1FJ/erO
 jTKZ7FVHFJmOZg311UA==
X-Proofpoint-GUID: 0A1qBQLTmIa_5518e_sWKI5GaDkjorEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160024

On 11/10/26 12:39 PM, zhaofeng2 wrote:
> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> 
> j721e_enable_acspcie_refclk() resolves the "ti,syscon-acspcie-proxy-ctrl"
> phandle with of_parse_phandle_with_fixed_args(), which takes a
> reference on the resolved device node, but the reference is never
> dropped, so the device node is leaked.  This is called from
> j721e_pcie_ctrl_init(), which j721e_pcie_resume_noirq() re-invokes
> on every resume, so the leak repeats on every suspend/resume cycle
> as well.
> 
> Drop the reference with of_node_put() once the mask argument has been
> consumed.
> 
> Fixes: 82c4be4168e2 ("PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists")
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

> ---
>   drivers/pci/controller/cadence/pci-j721e.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -247,6 +247,7 @@
>   
>   	/* Clear PAD IO disable bits to enable refclk output */
>   	val = ~(args.args[0]);
> +	of_node_put(args.np);
>   	ret = regmap_update_bits(syscon, 0, mask, val);
>   	if (ret) {
>   		dev_err(dev, "failed to enable ACSPCIE refclk: %d\n", ret);

