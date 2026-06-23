Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B3352010;
	Tue, 23 Jun 2026 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205709; cv=fail; b=KjmtnPMcTtznMhC9pQxy6YCmktnEwjkCFLGX2tnrKi2RSjPfhw1bqNMwGOK1jgFUUz8F9b1gDwop99HrlzEZAyRAKr3col65wSnHJXu9Pilyu/35ddDz9Xz76TLpSkYhMuQwMX99by6LkIrWsTe7b/vOUtYSiRUKSodBhy8p9/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205709; c=relaxed/simple;
	bh=W4kEOKLEjuQButy/7sp/C4G1MbSKFCrWCAIAYyRlNFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgS2Jg+MaGewXpHWxiAPZFYp7HMwWLe3C3bkessoqibbfDWtNcda3XxuQbXjv6CPf925HNAIsG/v+8K4l3ELdPHUvhNLguhLsCswfdpZizQe3OHQu0jgiIpv58zqaEhocfs7FRYjXqi0cAjoAymbk8QCS0RYN/1ReMfdjO19kuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VlR5OdRg; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pBluN5yY; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VlR5OdRg";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pBluN5yY"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6dcUY1007023;
	Tue, 23 Jun 2026 04:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=86LlkovgaGqE9eZD/7IYC3jBnPzi7OtBezofBO0iS
	HU=; b=VlR5OdRgICubM4zptyydzSgMdzcFJ++R2I/lMNARHkSk3OPFtEIonZ5Jx
	07TR9hJYrYw8V040YSaToKMNc0F3AEHwkkji5Xai2iwB/jhsvRguQYtwUmJvCpum
	woH0JPS3voUK61y6LcvVZEKfxlilukLxm2I4bevx60hKPpJzztRs7sencPgv29SL
	o+aGhx5e6pLCWHnQss/yvRZBH6EzBnXhvrWWcVUZNA/Y4NIOW8N8F0nLtNt70Xwp
	LSA0U0zxTnVnAL2Z+OnAkFTE744N34d86hzktmNfG3L/dFsRBn/hA2/J1gvwV/bK
	YGrjuvwW1PP5GvR6H82/IGgqtQp9g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ey43bpehg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 04:07:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asrx5L78JIdIBpjAH8G2KIoq2V+r4H34TLoopFUvlSFYjtKSMh/8Nta2uMmjO9Y4ZqrZeMISSy9Td/xUB9s8Jwv6iEWtxLuchQ9t7C/qBwd/02o8YSuVnnAmpn3PPXxCgnV2hdLjoUmEV5Z3M3f7zr85n4rxsKC+M/lrEtgORwRUrZxyTPIb23lkjqwkbL1tFQWI9iG9Ud6U7WUDmhSG91Dy42osiFkIc6L1tpEif+pvfsrmrjK78UoHORMtTt0o5DMiyEfTdPHWCc74HJZnVvSO/z2IxT63aDDRUNQWM9BG9Cff5ZVJtz63XaGFzhZXqyK0nL2ogV6uS7maEckyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86LlkovgaGqE9eZD/7IYC3jBnPzi7OtBezofBO0iSHU=;
 b=hRLhLmtGGKrq0QkjUcbelV2KnBQMtFA+WkFXabH9AWgSCdQKbyAChodCSG2qkW3XkNzpxnxDqVeUrwXiJ32qnfaz3JUKXhtltbw70bmOx4S9iMIcJ8XrzzRQT17UruTXfb7JGan6Dd81nPq22azeQnS+sEPDTBL0fPURXJn32IUhoA3yLwdHhK5Vm9bzGweIfz46fx9iHcsYWHeuubw2Kd3ZvPXBWh2Uq+cspDoZ4HaCyHx/KUY+nEmV34G+in4wLxapJfX9dBG/tHD8l3geZjzQvyuVDsZ2hkmfc0Kf61hmm5FMZEcNGaqiZBhkupTp0/Ck+7lH9aa7jJZ2RWCH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86LlkovgaGqE9eZD/7IYC3jBnPzi7OtBezofBO0iSHU=;
 b=pBluN5yYxn175JmXG46h7XRM2iRdjstFCM/lDJmqFv3iI3S/6Mt5jqLX/vplzojrUkYx+g5UK++8xwHSk16DX1ZGT8v3duBKbQPxFrjfqFrZ9MSAScTehEuYQbWwrJNZ6q09kJeeE9OhFSb5ZLToYyIRbJpdJQN0fIh5TQn9REU=
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by PH0PR10MB997783.namprd10.prod.outlook.com (2603:10b6:510:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:07:51 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::aa) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Tue,
 23 Jun 2026 09:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:07:49 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:07:49 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:07:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 04:07:48 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N97bL32520663;
	Tue, 23 Jun 2026 04:07:43 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
        <lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rdunlap@infradead.org>, <Frank.Li@nxp.com>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v6 1/4] PCI/DOE: Move common definitions to the header file
Date: Tue, 23 Jun 2026 14:37:34 +0530
Message-ID: <20260623090737.711656-2-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|PH0PR10MB997783:EE_
X-MS-Office365-Filtering-Correlation-Id: 055020c0-e80e-4395-b1f7-08ded106e657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|921020|13003099007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aDeUJRXZ7rrLIqBVIQAZ9R2IRqaO4JTNZUbMO5ntBVJyOmyUioLFRTPoTgtVBnmqu9XXmW6/Aj70kEaGCMO0DMMG2vIIw2ALa1Rj4Hwtu8YKkLupytrlPDLFYCL9RdXIKzziS8YiAcXAzWMy3Pn6BuCfOwvq6Jc6CsKTxWdCu7EL/sa+Eyd7dqHhr00ZtuAmKMV0bee9BW/u2121ahHAWQPjBZwrTZ/eZcgZmaRlgUN+cs/lbWxX6NLvZUJYQ3wimyY+8+czCjWxIevL1omOO6iAL9gcqBDwAam7UHpcBQXhmS6IblHX5fGbVjXa2zryyCGM6xt3DpNwfC0BX1noiqHWZVuLQEpBrztR8URhgWLSYqc09mKdsTtZzngKTUQeaTE6VJAPxjbERokSEWsSwE9OeFIc0ejPyqXE+k5qL8lXOLFHxrFCpYFoxQ3xkIWoVldv7KR2WsqAlbgg64ZZ0a4JyHU/UZQkZTge7B0apbXvc20RSrXakY7AmYbiALhHq6kz5QN07RvBEYXGkt40mXgEN9mEFsmUUyP7b5HQmvV/Fz0rhOA1QLVARtUHLQVP1LGN11QTkkEQ4Pm1kCaHJIe3Emz1sfJkKU08o1o93EzuTEjrGOdg37XINwYLmEVYmWQxH3s5dBShX+GdUe8/9HSnuQNRlQgrmjTF0iJE/PMrww/CU4zOwchlZ3j5i6cAHIZHApAE9W1f7eE43+K4C2dthETPigD/eidIEUUPKf+/dzb/Pbk5tRJBIFPl+ZV5
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(921020)(13003099007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JTblrO1QeQsJ/dUaO/CZEjZ+BKgRHNZpSvUE1CjVOLpACmkJmJxjGlJMP8s04OOiDU4umS+WEJqFvEkHG040pjHATzedbglOyDcubU8Vf+XekxLevGyBNq0DwhS9O0JX3pbDUjXqcaoiELX/aNMRlNqdxEacvzMxRXhDofwS9HlEy6jOnKsmcGXxX+GKEtUczFzjv9BrxN5lqXKIvMWpCwtLZg7QqCTmY49BF9PLFCv/X+lvl07oYmGnhtCTMitQyKZOKTrcocKJK1jinmo3YAgpbVlr3194cc44rcHxati5Q561Tt5kqFIxVR7IVFGnliG/zJKJPjRezuQxN0E9sE4sBRmlzGkmU9jUMo1z8Bq+U4tl7aH7c9yFMTcL9oPyDZiUuabPntPkl49+B7bNhhb3vmIWpzw2GOLixJp/nG0esNLNioXe3e8XdbInM7tI
X-Exchange-RoutingPolicyChecked:
	Lx2eSusdDC0vHNbG/Mk9L9+blgZVdXXlz0bLSSBH7Ww9nTmtwe2KmOSoNoBETOJFLHq61jDca7qqI7MC/aHNXychsNsX+8pxsixoCbrv5V2VOeYOIkLLRnE5EGNUfPPyea3xgURsL3sRYh8uwdFtoT8C2PTMTJMoUnFMpfOYNDLKQrHAXTErnxE50sa8cgyTdR6+1fCqGF14mokCTD9nGbwp7hGEZPA5EbW8NUga/ZMgrZIntAOok1EdGTBJdwmvEQxzA4GAOy8Bs0jz4cDav6dw9YwBN59ex+OBUdmVXqjVsTLMT3D4yK1KWX5vT0KHk5zGRHd+NEfnrqiLDwe9/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:07:49.6348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055020c0-e80e-4395-b1f7-08ded106e657
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997783
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX1lRYtTkPojyv
 Jjre+OPFRafQHwLfZXn+Pbbag4iJ0c8cqt0Xq93EgwSu1odBuyfezSRexsiIy7/uZHy0ejDci8W
 tJg2zhmJAvBHhKgGxDgkxzjr1O4ZkN4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX7Ik2zGFvd6Ed
 MLQGHT59rCWlTw7lvu7Xk4O0b4k1CVKxv6iM6LvTAFyz1c4v3PsOwmiW7Xv/rmLtU4J+VOtkopo
 jfUCA/HcaOge5E/fctB9fu2ESg6P5CI9AF5jrX2y5+dWvVxvwVUBKrxMZVllgSMgqHOl0zzIZlw
 YfNt4EDU90o3/DuijChmBpZDkhFiRnOzVeL75ei/VQN2gZobl3BEoULfVj7Cik1/0SLapoA3qqF
 9sdY1HmOQoozYteat9uKYk/Dqci2jaF4TNU6QMor6BCpkIt4NWEbHLJXddJKNTLEgS/L8HTFRa7
 v1GFXIFwyyE4B9zLUQj96jVX+3ThHVx9d7iAZ3qcu7Q94WHVwdZXKKoEK1ulsVi+GtLsd4hEzaK
 EDiD3FkM1YNnqcrx4J8n9vzNxfCSiiHhWF1YO8Z9aGaORuDPte2Fv5e4xwcrzCHUoYGX7hgkvxJ
 9vzRv/YCZneQLmIp63g==
X-Authority-Analysis: v=2.4 cv=TPl1jVla c=1 sm=1 tr=0 ts=6a3a4ce9 cx=c_pps
 a=6O9SViV89A8ZJb2Gg0v8VA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=8AirrxEcAAAA:8 a=A4G5x-j8PL-PQYzVoaUA:9
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: 9vIEjSfKZUUpNMhskpu7WwrqHv-2Gk-U
X-Proofpoint-GUID: 9vIEjSfKZUUpNMhskpu7WwrqHv-2Gk-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230072

Move common macros and structures from drivers/pci/doe.c to
drivers/pci/pci.h to allow reuse across root complex and
endpoint DOE implementations.

PCI_DOE_MAX_LENGTH macro can be used outside the PCI core as well,
hence move the macro to include/linux/pci-doe.h.

These changes prepare the groundwork for the DOE endpoint implementation
that will reuse these common definitions.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v5 to v6:
- None.

Changes from v4 to v5:
- None.

Changes from v3 to v4:
- None.

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- Moved the common macros that need not be visible outside the PCI core
  to drivers/pci/pci.h instead to include/linux/pci-doe.h as suggested
  by Lukas Wunner
- Removed the redundant empty inlines guarded with CONFIG_PCI_DOE in
  include/linux/pci-doe.h.

v5: https://lore.kernel.org/all/20260610100256.1889111-2-a-garg7@ti.com/
v4: https://lore.kernel.org/all/20260522052434.802034-2-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260427051725.223704-2-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260401073022.215805-2-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260213123603.420941-3-a-garg7@ti.com/

 drivers/pci/doe.c       | 11 -----------
 drivers/pci/pci.h       |  9 +++++++++
 include/linux/pci-doe.h |  3 +++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 7b41da4ec11a..e8d9e95644b3 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -28,12 +28,6 @@
 #define PCI_DOE_TIMEOUT HZ
 #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
 
-#define PCI_DOE_FLAG_CANCEL	0
-#define PCI_DOE_FLAG_DEAD	1
-
-/* Max data object length is 2^18 dwords */
-#define PCI_DOE_MAX_LENGTH	(1 << 18)
-
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
@@ -63,11 +57,6 @@ struct pci_doe_mb {
 #endif
 };
 
-struct pci_doe_feature {
-	u16 vid;
-	u8 type;
-};
-
 /**
  * struct pci_doe_task - represents a single query/response
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..5844deee2b5f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -683,6 +683,15 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
+/* DOE Mailbox state flags */
+#define PCI_DOE_FLAG_CANCEL	0
+#define PCI_DOE_FLAG_DEAD	1
+
+struct pci_doe_feature {
+	u16 vid;
+	u8 type;
+};
+
 #ifdef CONFIG_PCI_DOE
 void pci_doe_init(struct pci_dev *pdev);
 void pci_doe_destroy(struct pci_dev *pdev);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index bd4346a7c4e7..abb9b7ae8029 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -19,6 +19,9 @@ struct pci_doe_mb;
 #define PCI_DOE_FEATURE_CMA 1
 #define PCI_DOE_FEATURE_SSESSION 2
 
+/* Max data object length is 2^18 dwords */
+#define PCI_DOE_MAX_LENGTH		(1 << 18)
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
-- 
2.34.1

