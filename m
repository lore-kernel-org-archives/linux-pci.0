Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F43A7F75;
	Tue, 28 Jul 2026 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785215390; cv=fail; b=R5dJXvLQ0xLBBlbdAVdZICJr5KNVoe2uC60lKL74OFdHdbo0RHMPh1S/cWAshBnCISWAjWrpHs0YRWvC6VwUQUiLAkUq5lc7WavWlxBIJm85RfMcItLGsxam4SIGfK9dgLYValaRRtKpOqtyAcIgGmWCm5EjBkq3lhqV3CGW8/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785215390; c=relaxed/simple;
	bh=pUaARAl9RE+5Hwjo7Se1nT7OihQ2pB+LAsSnHISooPY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IhrLLYxylk+g0IqX711YBQrhilRZAddTV2snrNqkN5F5wPtiSqf3WgLIhKKPYTnJboSgGBS6ANqV4dkCmJp9BOZvtEbAB0RA3xgiWJoM4lb19yXDaslbzlKBNGi7ageb+V75qtnBfSZNGnBFOb98Z/OSDaeJKtbmeXjbgsGfZRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NSA2h2Kx; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gj3C2i1v; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NSA2h2Kx";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gj3C2i1v"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66S4D8pC2740408;
	Tue, 28 Jul 2026 00:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CygZisX1jDSG4avMpdCuej8OInvJk0m+dEkU8Au8e
	H0=; b=NSA2h2KxJHZqCbOvJYwpKxNJ/AcPrUzv9GieIdRVAQ/JmHGVjwex5J5cc
	wWxmvBGvpHbSAd3qEbVwWbqMXRO91u/dDS20cE6HwhZeWJ4Yoz0WzqPypf0kb611
	IAHYutAKRBUhlmCAVJ4tAKhK3sDuK+lLh4sBbkP9XzFpxYbWoanJ28xnxYjvyg4p
	sdl43xRX+1JDvh8HR+vogouOGVSwCQieNgGZ5g2afiQ+Rr82x8shStFd9MMQ6MaF
	WBTcDJZ9B7bHxt8/jWjoOmZFN9TlLzYv9KalCQEnIQt4ML4kEfgKju/FzLwBfvTE
	ix5exc8mZLPD/cR+9jrE+VsGbF3Cw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fpn6sr7qw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 00:09:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwkUDsw2qlKBOcKxD+DIFTAZyIDBq1ln2J4DZK4C2cEecQQZm3iXWPMcliPxQMDIF9pE4FMmNeMqUfohj9nulwTHksvjIb+FDX8nkhtO/u0NLN6Js8AWALSJJeHxqF4daIzhHYpIWrGsj70bZBglcuT4bzK8D6bu3EhRn2iOD8ciLJK9ZfImWn9EaurjqbHfTcDq7xlyRP0Wfg/DSuUkffmU/xir07h2g4J52dnsBIylBV+lQ+Hfiyp/lD00FYB3+pJ40DOdDQnOVOrznqH30Gbxut3HYAeVvoS8FrFyDkkJ1qqvDygthq93rll5dL5DwEPSl7FClTUkWnhh9ZRLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CygZisX1jDSG4avMpdCuej8OInvJk0m+dEkU8Au8eH0=;
 b=DI/4R6HWxVi1isN2zmhyI52wCt/6iNC1L8usuV0sOmxlTW33e4gxij815Itvzgf5mtkMcSmxlNOETUrEYTHvJh36F6FYZDPIH7lMDjh9YBHuJViU4scajRbg+sBMPBUzD3bLhO/juOX8p4cgEfZ6s/doZJ/wdPQ52p7rnQYQ9gJe4fMpxJWW479RmWNn0OQ8Uz1ZTFsqlRBo/JBbYGrrH1vHhCuRJJHcZ6TYW3ziQQr28X+1f5fIeIgcDiNPrnoBMpLk7LEnbIeFXhLZo3JPfzABwmMnwL1DLyZjcIkosPZukUiQgJTsMGeJuitoxN+cjSmTDuVWWAASRThQepLkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CygZisX1jDSG4avMpdCuej8OInvJk0m+dEkU8Au8eH0=;
 b=gj3C2i1vQQMeX4dmAHlSxIWalrEA5SJTFuBFXSEeUK92JDvw52Xzypown58Zf2yl7H7QuDcXfM348UvRVWYLesx38I/QDbk6GN7xebgix2Oqp/wPFnYeBqXFYKKGQig7kkuLlopt2TUCeMMR2BFRc8KQxa0i9+pzc1GB5zLMd+w=
Received: from SJ0PR05CA0113.namprd05.prod.outlook.com (2603:10b6:a03:334::28)
 by CH3PR10MB7284.namprd10.prod.outlook.com (2603:10b6:610:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:09:08 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::5e) by SJ0PR05CA0113.outlook.office365.com
 (2603:10b6:a03:334::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 05:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:09:06 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 00:09:04 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 00:09:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 00:09:04 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66S58slX1955238;
	Tue, 28 Jul 2026 00:08:55 -0500
Message-ID: <f38d195c-cff1-40f5-9db4-d9bb4e4ef156@ti.com>
Date: Tue, 28 Jul 2026 10:42:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <linux-pci@vger.kernel.org>, <imx@lists.linux.dev>,
        Heiko Stuebner
	<heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Niklas Cassel <cassel@kernel.org>, Koichiro Den
	<den@valinux.co.jp>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Jesper Nilsson
	<jesper.nilsson@axis.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Srikanth Thokala
	<srikanth.thokala@intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Qiang
 Yu" <qiang.yu@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        Qianfeng Rong <rongqianfeng@vivo.com>,
        "Mingkai
 Hu" <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Minghuan Lian
	<minghuan.Lian@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Nicolas Frattaroli
	<nicolas.frattaroli@collabora.com>,
        Yuho Choi <dbgh9129@gmail.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 2/2] PCI: dwc: Handle return value from endpoint .pre_init
 callback
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260728012548.465139-1-marek.vasut+renesas@mailbox.org>
 <20260728012548.465139-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260728012548.465139-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|CH3PR10MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bb7e50-2eca-47f0-49f4-08deec665978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XXE1korwt/FKOhc3WdfyX1tCUaSK3TZ/aWkWtEEN0/dW/V8N05Ydh4AjNzB1kQ2djC7IpR5w49ajoDbIStL0cT/WQCxDxC9xXZymEMzgmYuIccmzYqiekJ5lOasqAtuBwClDCjSg16Zbz5UtyevcJBNS7puC3IUtr2kxZk4dizAUadlK16onZucBGZXv8ihKM66BnVi0Pn+z3pkOKbrikQdXe3ZBuepx/sP3dKx+8PgWOLRh/4bnSj9yDx4Z6ZA3vMbdxQGs7Nku15u1SgQPOzXn4NEaHsj1NVJtyACIVFneVUmciupcSQ3JT1iFUADUUBmGL+rqNatsGBnIPNQEjt7kVUMPVITezHqdMhhDN0AnFq5RaRGx3KZ6GKDE3xaNe+2EaFxYkn7W8N3okQFQLLsnkzAxNU38tNs8p/TEhlwQESjDMHuWHmJsIn7092sAmByjhKu+lq5CI0w76xcuCUTX8PsaON9rY3iqkyT4MzBuxwEjWteys/LB6KvNZqFPp+5ard/9U7uUjAxqZ1GB01cehbSCHHQv4jHVwDDt3MtsVMDPXIalYAL2MqiUs4tFQT0dIL4eRn7OMSoniEYz1gFSjDO1NjZUbOgeNdEZzOgX06gysgeYaujwMKwuxHJ9KAaee+/MPYV7Ck2QpWX8hUi+mcjAJGwxC15TzrEo+OZgPUbQuObxXWpazVcp24bYWJnUiCkhOtaqnHQr5nPrrw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gzd9ez6Znucj6z6nKy9YHrB7iW5nxgTkYYdf16Nuz9yt1c7j1TWSudTJSdft+WUKyB+4vA17I8MgGEUBTy3rpRa2f7pjICAttvDwKfsE/Vj2QVz2MnPl+caX7xXJB1/KPSNH1MHtkhrdEI+TjnB/K/SOyAnuBm35bMEFhCgm3paKHX/+0vNHbmey/KtLgKgZ8Pbz66YSlw8XwySUKF70c8H+P2o6XMB2+WshS1WINUpn/SvOiyGrE19g5Szzd5E3R60uFQV7T4hgNaNhAaZxXqak62uuRO8clctZpw/s53n0w/6i3Cq2qSjfyMe863KYynfqkNvf83XbdpQJQMKWm0LaZuVnD1fUHKVhI4FfW6J6o3SKr9ue0n0J6WH1kKcgzW2DK6l1Q2KhtBkT+fDwaoBabF8KrMK06JENtxoYsqH7BqMM4McJ4KlRyR/30C3x
X-Exchange-RoutingPolicyChecked:
	cr+JFHgjpkQ6UEcdvLBjZcEoOc70IQhbNt57ByRUbZEDovbA4AbAvgPdVRXzxuJH1PE8KuTXteDQS9MnDDkKQ2dk8rLT2ikxSuTb0vFz91UygjsqTd+ufVBVJ0nR7CRS0prRVSS8sfohZTOxOiPKFFOAIKB3xIbfRgbv5vW59iHBC7H0WcIg3vGDKNKPN3Tj/f78yjQFA5TuVU6NDFVNgKa82iXvNEijBEDrhgF9fGVvFzXqrfvYcr0BPUrgu3TVAI9zMD2Lr+L+5w8+f3ffGrCuXYQ1+cs2kDUiHr/fbFyguUKq5+rcqwcRwaa0pSLBLM/apw4rZaOK67MQL3t34A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:09:06.4093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bb7e50-2eca-47f0-49f4-08deec665978
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7284
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0NSBTYWx0ZWRfX6jZJgxPrMZD/
 UGEEY2NxWYlJKng5IapIZDKofi4Mzuw745LRBpsViE68E/wXlgdveF+EEM4fSgXP0jqERi2hWDJ
 ilbJNjnre1oHSepCoXdtPZa7DCz8BxoEdJyMJHfd06S4Hlvm38bvlI0EsoaCfdoRRfgkQI7m9dG
 KfdsLK0WC3DdSFPpFE067jQLHra8Ii2npZxxNPv+5IYLt7gYFdzqRPMyH9wcKjl7ybQGIVesLAd
 MbEKmFYat2pt1JPXo/ZB2PdU+0p2k+uXNW0cWfOrBQkrktSg4rGeqKaWrkW5MoksRljFPk49o0o
 W2hgqL0fN8dMb4rY1q2lz9B4+ZNDMExJAecBkws2EGK8W2+lsJMfYLbcBeNJzWgQS26Htqwys/R
 FhVMertccpTnUlXfBlcs8KaXlo1ljGLrnvgvXjooqmJidivvbbVzIOmpPwRNZ2Q8jw3Ko+YYr0v
 hPZtnnxXFlRpFn7doTg==
X-Proofpoint-ORIG-GUID: KVdMH0_ZB_Rtd6aFPyhQZuXNPEAbcpfk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0NSBTYWx0ZWRfX+tmztf0EdklD
 dQK8hc8V7E9aDdIrCOESnWtJSidiSbySAhqBH1VZ2DbXV0ziwyo5QqGmIsYYf9ga7PVLFBME2AS
 gqoff67WLAQXlHRX12crrf16eD0K0k0=
X-Proofpoint-GUID: KVdMH0_ZB_Rtd6aFPyhQZuXNPEAbcpfk
X-Authority-Analysis: v=2.4 cv=dvnrzVg4 c=1 sm=1 tr=0 ts=6a683979 cx=c_pps
 a=aFbGVCYh9COm6MyaDWiF6Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=b3CbU_ItAAAA:8 a=sozttTNsAAAA:8
 a=bF27UdnnnCdax2b7sEsA:9 a=QEXdDO2ut3YA:10 a=Rh4KQ1K2KoEA:10
 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280045

On 28/07/26 06:54, Marek Vasut wrote:
> Add return value handling for struct dw_pcie_ep_ops .pre_init callback.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
