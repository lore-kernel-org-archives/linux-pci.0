Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFA35DD1C;
	Tue, 23 Jun 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205706; cv=fail; b=c9ZAemGup1kj1IVyWHX4VjMJtHCsqyNsBMPWaZ9GE2NpiFSXWwM4POKETk6mv9uYRWzXRiY5n5FTcCM/PH5z8R6L7hSoemaFJXMLRcfRji4MBE986DwWxGB5RCTDvUN6bfDwwDcpJPQbCHSYTmVjCjNVW9Z4OBZZUgdQLwdzWG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205706; c=relaxed/simple;
	bh=uGDiy0+XvmNPX88B1DeHhN8ShMk0Vn0k9trAdzrVbBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMbNjV5/ZMBMaiVf5kO6klwQKJslb1u7bYaiV9rLV9Xw2T5At0qmzFWB1qsa7hyY8k3r1XsyDUFAah9M/1vTC4t+t8O4ojRvEuRVVCuWVM6w2ecGSIALyVAr2hLwN5NJOdHh31bkhxg4hHGab6Mk04H7ljv7ykPKIvdUTFQnuxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=kBmOUI4f; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kDT0087W; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="kBmOUI4f";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kDT0087W"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N6cWmW786410;
	Tue, 23 Jun 2026 04:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=dV3saCpigv76kX9b4YhbYGiGOYki5XIcfoebWm8pw
	NE=; b=kBmOUI4fq5JqW/4FDFgAO8NGI3qs5i5BKic7nwfuBPvitRENk/Yy3eEML
	Sm4WMtzlbunFLcvml8jfCnVMXar1c1EsG5I6X7pJgiv5TAyGXNknNO/O58FZjTxx
	pQ6q/6l4LuOIKt3h8w+yt8+p/N2h6yWbjHRBonOXdRkiMuitKfpuWoOhpp8okBs2
	sa/d37hMwec9Sc1nlvEMXp9pjzUl6Tl28+ChkNzM2UYIgybOZsSd1Wmloolzawvs
	jXS8xhCIWNdsA0f2fWHkmdURLqG9Jwwn0ShG8uf1Wbps28pSMXGJwZ+zofCQYPfL
	wXh4zDEzwAImi6fvvYYQqf0mrd1kw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	by m0380145.ppops.net (PPS) with ESMTPS id 4eyma1ryge-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 04:08:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r54QHYEwYrnvDVhkBQaSIgV1AK50l7bs50AXFVTuuR+9Dn+EfKqQwS4ULgyDR45AKpBnUqg140El66P5giPxswVf1eLaPtO7rtvJ7f+FVYfx3e3rbLu81rEwVVvj60kygh8sVNXm8Fq0wZzy1YBfcmFYaMn4NsQ1MLxV9XqUUOlJ3o8SgPp77V27DZsdSCwH8DzZfBOBGTgx58xkknHQ++SEmBIXnTEDkRS+A+03ui8jzJhOAhwtevMHrt3Qpo4exWZ/Xfr8ppPDvqbarHp7De1yUbwL8gqt2V3VpMNq4KAFT1i9hR8UfsO2nk5C3grkqHfePeH1aYpAbgjyTD5hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV3saCpigv76kX9b4YhbYGiGOYki5XIcfoebWm8pwNE=;
 b=LjJm/guBMvN8C/vtHUd6drO5rZGGArEUSaurPnWMHp26TpdorI/JdhYs9yCl7cN0dNvq7RhgmEAFC1fIRUckdbwtprWU0HxEtniZs0fsgZ/aDVxBC4U4LYo1FOhpZWrniveDEyp4bkM7eafpl6mcBmBOoGbFG6TzQaiPCCguurEdLllmoPAJvebPTkRsqQCO/Rmaf9hLkUkCI3akLcEkLjX1WW2MvIsLpyZkryd+fWmrq00/Yo9/kH8JRxxhmS0fi0urlyfdaN6zdVhtQG14bdMk7fRTIF2+/2PVNQ10VX2piIukw+2f8V0s68/8h8ITpLX1qWqlWbnW3VUJF1NfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV3saCpigv76kX9b4YhbYGiGOYki5XIcfoebWm8pwNE=;
 b=kDT0087WHtRMm9Hn1EVLhtws/I6odQ1N0fRYyyWgVz/KMs1u6cCoz34P+ZMAyPIKZUxmbHdmCyj5Br4/yo7ogVqjmpooMjCXOx/RkYOGxRTlZsTKcX/TkyE2dHdx7TzmFhJGRqxlFTpYvgZrhRQLRa35GPJGK+WbCf4rqBpAB4s=
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:08:02 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::70) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 23 Jun 2026 09:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:08:00 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:08:00 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:08:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 04:08:00 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N97bL52520663;
	Tue, 23 Jun 2026 04:07:55 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
        <lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rdunlap@infradead.org>, <Frank.Li@nxp.com>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v6 3/4] PCI: endpoint: Add support for DOE initialization and setup in EPC core
Date: Tue, 23 Jun 2026 14:37:36 +0530
Message-ID: <20260623090737.711656-4-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623090737.711656-1-a-garg7@ti.com>
References: <20260623090737.711656-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SJ2PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f30e98-d294-4401-c403-08ded106ecd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|921020|18002099003|56012099006|5023799004|6133799003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	7NICqeLoJxLUTjDY1f+kCiveLpGlGNpkGrdelXNfDPbTwb6jb2tHetfOWJ30SBSy6qYwBUww4CLjlhZJJcspNSb8Bgh8RGUF+M+ta0EroOKACpu/x72of64Qf0TkQaORgIRSwKfzX/4lxoBaGX4Wo3f/Zi1JHA7Nr1nIu5kMbVs/lSHLwCWIXaP9loZAuyhoNA2EWWr1lmamhIOxd6HhGJEcFFpOnijwO9KsalPU/bx0s2Mln0TqLQCVJozXg8R4x9JO0XYbrN5kyHF1TawkQPcUXzdtlq7c7op1LVam+hQUGhR9rJgrIDWlHfBnRaCqVwQkVvP6PMde2M2QGVYir5ilHXsYNZmVDo5EnpKBpQNf6L/Rc+vZnbnWa6RLqfFAAvnwaTtEWnL1KRhq7TsmJRZXUEoWY/GzjynRAAx7hNE5p+z1jnuGgtg/lFadX6GSwpSk/b4sTZPnoNLWDpFSCMYz1cn8NaGFyEwJi6eMShx16RszzW4PKe3bBgDHhTEjgM9eT7xPHb9c5dyIqCDgOthaGhmA36O0n2UZnaUuI9urEolgpIY7smjAWQ3AVvcZYUPYfHblNbvrfF98vAjwy32DcSC/DZ96xiT6usm+IMhzMCsqVDCVn6rC58hmkoK5gyB6q8TW5DstbBhLd82igRauX/u8Tc+ppvGP0lrBtgUJshScVyMyPeDDExJKe4iIaLGV7afxUFyDPMZQ6gNyWDZXd5QiM8DQ2Ykxi9KZiKwpqaSglo0Q0ymo/J3OvoxY
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(921020)(18002099003)(56012099006)(5023799004)(6133799003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t/M3Tae5VBdFcrIvnFjQCyH35UHCVqqFSm205qNKDJsOQa1kd8L/7EiqKaP/nNxSKYI5s6vpj9jrhe1ugElGgs0FXJO8L2qyQFPHX4qoNj6DjFBr8dJqdK1tBcQbccemXM8mjX1EtsNBsFOP3fWdUQp3NfYm2GXC18hB4WuLEBDUsDJ+/B6T0G+TamwAS53QaFj3WAUKDn6GqYYO8+GEZFCyMZAzu+WkMgnn3LHg6AGXlRagFQYOmr3JC7oGe1rGRi7IQmdXECOYeY2Q4CJcu/x23G99duNjItiSua/YibGO1o+rul2rtBu3KxXuDkM5lf63VEEEAflybmMHaK09GszV14RySn0j9vJ8fBYrUWlQPcPtuEdJx1tUOQMKPyaSTIwwaXvijDsz5mYtKT1z9QNasW0D1fQstkML3w7m3k3hwuH3wEuczu28fB+iBZsI
X-Exchange-RoutingPolicyChecked:
	oZ+MKEWdkTTzAbLFuFW/AnqePExpm6ltZxYOw+E596u4ho65Ldrh5iSr80ndpPjgZOiATLmlOWcjCh0OufLidh5dS6jWyQhK/lWV+TclrRzWRHfeFjDA3qqYkpNnNtVzPfZHucW7ldxqGxrJr3+H6M6s7uZu/5fCq3dkp2SYeuJH7Ik8OVfPPD4rAGxsXVlG2PEl/oEO8WvDLoIPhM6Y767OvtRYdopacJuGpyK7FmruR4s1GqY7oqU3vKH6TrQN0/xRXyr/Er4tATQqUBFH51VLGRsC4DQvsbaKrUbjUMOpPUj5rSgjEZSeK2q/MXykmLu/Qe/vSiAXLKZW2+C0yA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:08:00.5272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f30e98-d294-4401-c403-08ded106ecd3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX2tQpCcUsotXQ
 bUKsFh/ivz4EqIBE9CPGbaSrkSLvYjmRWqf6/sPa4umdI4KZF751OlqdYiwSt8Ryfn6onok8E8v
 N2etmmlsjwaw+8pr+iwx2aFKAFqvtTY=
X-Proofpoint-ORIG-GUID: UV_6z1LvkgaOVQwJvQgacTjBtpg2bDG9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfXzetCWlc6YxNo
 fo/ixvPB3VUUodnA1fDa8FjMskDSKzNdscwB2aYvIHWvK4wrLH7GbcuD//5QqDpJ0Pyu998P4c4
 mg1mUlDfqxro2x4CU3V54Y/LTQT6WMPw4bHB/0sdR9GIy5/qwTg6RTXyG0mID63F54AsT3VqdNE
 7jsfD9GGR4crnGE3Rcolmp+e8aD7+ZbQH4tv7+8SL0LGG8buhexIMhlhD4AY5DoqI8uW3guUQ8i
 H08PNoxRAMZUcjEZSeMIRO7Z4c7iTq9ngvqi+PQvJtFac++uaE996kbpv2yfR1SjjuL1yan/3qg
 cevFL2pefa/ycez+Vo2S04YscCvPOlm5cNr+NYQZRc0HDnr8/nreAkPPlFeWy3vrbnOV6QKSN2z
 oJ0Ry8/KIPEb2Vr0Jk5HTeRAj97Ii1RnYaKdk782AmJ/9/iX1mJ8msquri/g921qiGetQJAOCkJ
 wWY/dvVkaxG/J6MzOCw==
X-Proofpoint-GUID: UV_6z1LvkgaOVQwJvQgacTjBtpg2bDG9
X-Authority-Analysis: v=2.4 cv=WoYb99fv c=1 sm=1 tr=0 ts=6a3a4cf7 cx=c_pps
 a=gE6CMw9pMCRGQsgsFAL45Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=yVYE9wUCbgZwH2lgCLYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230072

Add pci_epc_init_capabilities() in EPC core driver to initialize and
setup the capabilities supported by the EPC driver. This calls
pci_epc_doe_setup() to setup the DOE framework for an endpoint controller,
which discovers the DOE capabilities (extended capability ID 0x2E), and
registers each discovered DOE mailbox for all the functions in the
endpoint controller.

Add pci_epc_deinit_capabilities() in EPC core driver for cleanup of the
resources used by the capabilities of the EPC driver. This calls
pci_ep_doe_destroy() to destroy all DOE mailboxes and free associated
resources.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v5 to v6:
- Addressed the review comments provided by Bjorn Helgaas at v5

Changes from v4 to v5:
- Addressed the review comments by Sashiko

Changes from v3 to v4:
- Call DOE setup and destroy APIs directly within the EPC core, instead of
  relying on the EPC drivers to call them individually. EPC drivers do not
  need to explicitly handle DOE setup, rather the EPC core manages this
  transparently. (Suggested by Manivannan Sadhasivam).
- Removed pci_epc_doe_destroy() API, which was just calling pci_ep_doe_destroy().
  Instead, called pci_ep_doe_destroy() directly during cleanup.
- Called pci_ep_doe_init() before the "!epc->ops->find_ext_capability" check,
  because if doe-capable=1 and find_ext_capability() op is undefined, this
  would not initialize the epc->doe_mbs xarray. However during cleanup, the
  check "!epc->ops->find_ext_capability" would be unnecessary, and it will
  try to destroy the epc->doe_mbs xarray even when it was not initialized.

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- New patch added to v2 (not present in v1)

v5: https://lore.kernel.org/all/20260610100256.1889111-4-a-garg7@ti.com/
v4: https://lore.kernel.org/all/20260522052434.802034-4-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260427051725.223704-4-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260401073022.215805-4-a-garg7@ti.com/

This patch is introduced based on the feedback provided by Manivannan
Sadhasivam at [1].

[1]: https://lore.kernel.org/all/p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d/


 drivers/pci/endpoint/pci-epc-core.c | 101 ++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |   6 ++
 2 files changed, 107 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c3c58185fc5..96bd624559f2 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -14,6 +14,8 @@
 #include <linux/pci-epf.h>
 #include <linux/pci-ep-cfs.h>
 
+#include "../pci.h"
+
 static const struct class pci_epc_class = {
 	.name = "pci_epc",
 };
@@ -842,6 +844,78 @@ void pci_epc_linkdown(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkdown);
 
+/**
+ * pci_epc_doe_setup() - Discover and setup DOE mailboxes for all functions
+ * @epc: the EPC device on which DOE mailboxes has to be setup
+ *
+ * Discover DOE (Data Object Exchange) capabilities for all physical
+ * functions in the endpoint controller and register DOE mailboxes.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int pci_epc_doe_setup(struct pci_epc *epc)
+{
+	u8 func_no, vfunc_no = 0;
+	u16 cap_offset;
+	int ret;
+
+	if (!epc->ops || !epc->ops->find_ext_capability)
+		return -EINVAL;
+
+	/* Discover DOE capabilities for all functions */
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+		mutex_lock(&epc->lock);
+		cap_offset = epc->ops->find_ext_capability(epc, func_no,
+							   vfunc_no, 0,
+							   PCI_EXT_CAP_ID_DOE);
+		mutex_unlock(&epc->lock);
+
+		while (cap_offset) {
+			/* Register this DOE mailbox */
+			ret = pci_ep_doe_add_mailbox(epc, func_no, cap_offset);
+			if (ret) {
+				dev_warn(&epc->dev,
+					 "[pf%d:offset %x] failed to add DOE mailbox\n",
+					 func_no, cap_offset);
+			}
+
+			mutex_lock(&epc->lock);
+			cap_offset = epc->ops->find_ext_capability(epc, func_no,
+								   vfunc_no,
+								   cap_offset,
+								   PCI_EXT_CAP_ID_DOE);
+			mutex_unlock(&epc->lock);
+		}
+	}
+
+	dev_dbg(&epc->dev, "DOE mailboxes setup complete\n");
+	return 0;
+}
+
+/**
+ * pci_epc_init_capabilities() - Initialize EPC capabilities
+ * @epc: the EPC device whose capabilities need to be initialized
+ *
+ * Initialize capabilities supported by the EPC device.
+ */
+static void pci_epc_init_capabilities(struct pci_epc *epc)
+{
+	const struct pci_epc_features *epc_features;
+	int ret;
+
+	epc_features = pci_epc_get_features(epc, 0, 0);
+	if (!epc_features)
+		return;
+
+	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
+		pci_ep_doe_init(epc);
+
+		ret = pci_epc_doe_setup(epc);
+		if (ret)
+			dev_warn(&epc->dev, "DOE setup failed: %d\n", ret);
+	}
+}
+
 /**
  * pci_epc_init_notify() - Notify the EPF device that EPC device initialization
  *                         is completed.
@@ -857,6 +931,9 @@ void pci_epc_init_notify(struct pci_epc *epc)
 	if (IS_ERR_OR_NULL(epc))
 		return;
 
+	if (!epc->init_complete)
+		pci_epc_init_capabilities(epc);
+
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
@@ -890,6 +967,27 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
 }
 EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
 
+/**
+ * pci_epc_deinit_capabilities() - Clean up EPC capabilities
+ * @epc: the EPC device whose capabilities need to be cleaned up
+ *
+ * Clean up capabilities supported by the EPC device,
+ * and free the associated resources.
+ */
+static void pci_epc_deinit_capabilities(struct pci_epc *epc)
+{
+	const struct pci_epc_features *epc_features;
+
+	epc_features = pci_epc_get_features(epc, 0, 0);
+	if (!epc_features)
+		return;
+
+	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
+		pci_ep_doe_destroy(epc);
+		dev_dbg(&epc->dev, "DOE mailboxes destroyed\n");
+	}
+}
+
 /**
  * pci_epc_deinit_notify() - Notify the EPF device about EPC deinitialization
  * @epc: the EPC device whose deinitialization is completed
@@ -903,6 +1001,9 @@ void pci_epc_deinit_notify(struct pci_epc *epc)
 	if (IS_ERR_OR_NULL(epc))
 		return;
 
+	if (epc->init_complete)
+		pci_epc_deinit_capabilities(epc);
+
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index dd26294c8175..11474e337db3 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -84,6 +84,8 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @find_ext_capability: ops to find extended capability offset for a function
+ *			 in endpoint controller
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +117,8 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	u16	(*find_ext_capability)(struct pci_epc *epc, u8 func_no,
+				       u8 vfunc_no, u16 start, u8 cap);
 	struct module *owner;
 };
 
@@ -270,6 +274,7 @@ struct pci_epc_bar_desc {
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @intx_capable: indicate if the endpoint can raise INTx interrupts
+ * @doe_capable: indicate if the endpoint function has DOE capability
  * @bar: array specifying the hardware description for each BAR
  * @align: alignment size required for BAR buffer allocation
  */
@@ -280,6 +285,7 @@ struct pci_epc_features {
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	unsigned int	intx_capable : 1;
+	unsigned int	doe_capable : 1;
 	struct	pci_epc_bar_desc bar[PCI_STD_NUM_BARS];
 	size_t	align;
 };
-- 
2.34.1

