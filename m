Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DCD344DAD;
	Tue, 23 Jun 2026 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205710; cv=fail; b=gU51Z8mG/SQPe2QHxmag7OtxiXhZnRBPUG6//G0w9Y/S+8z5wKz5c4qUmSmoUv1mNsIINsOukDFzyjsGfKfzHjhJ8bBPpS3GJrFRFFM/qp9XlFZaWUdQigqzJmykGPlY4vZf3GGZ5l3rD6JvMHuOgz3aLhezDpvGuzmVGGFS1rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205710; c=relaxed/simple;
	bh=XZNutsma5IYKuqgekQQu0zA5pjQJtUazYyykQos43Fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWmq/wuXCU4IgeHWwDRsFbq2Mss98PsnXJLKB9J3zQqxTeN56vpwkGjgAbg7/PAt1b5eRe6GmoaAajm8sdxoZeFnIx1CJqj6+TjjrlSxlN062gC2dUHO8tJDGp1LGpRabr7NKZu12KCXVLp+IV5o19tCZHC+Ij6GN/JxBsd1FEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=K/zTudE9; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e2kBqzM+; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="K/zTudE9";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e2kBqzM+"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N8dE0V3725160;
	Tue, 23 Jun 2026 04:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Pw12IdlzntrYqEH6qhT5s2GSjfm8VSB1pxZZE+7J/
	a8=; b=K/zTudE9jmxLNgoMuexkiyyUfq314ZA5jStgGY6+yEWI2ZKQgctEI01Sx
	2WyDsyUog0YU310VVx/V32YWJ80HeJrtZah7ys/VA2pmisfT6h0WM8TzIwjf1rX2
	iSfkZyKSPYNzlMv39VwiYd5Bu6v5qUZQX/ne3E3zERopI2xBGMZVhyWsic8d/iHx
	A98uWoXlVE/iouOHGNtPojSD4zaYdfpZrOoN8YV46xfX8STzR1DEADv2CivtXsBV
	6RAKPrgWnQkUP+bVJhKGryWu0N5h4zbO9meWlXIipJBvtUSI+0goO8TUvTM0P+MR
	CPiFQQ6F0SwL9DHA6D6iGT66F8R8g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eyptt84ta-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 04:08:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZoKAMCCzqWK/AyDicdURLpwRglWmg6tp5WcshVjJjcapw2cNu7mPnLj5z0TT8l+PB4LWN831vaWqZ2oEz3Uoshsv0rXVeIwz7nh4cvc6ESVqWY/1GnfNIogOi+jNUDxhE2ii+T4OWY5wx4mz6dTEggfXj3Y85kR0HqfHj4LTunEt7mejgmjswo94qFsGRUorDyufZWSgWY0emulKr2/nehwtAnT9jKgdXTBmsw8BhgzyWhbvb21+bdsetV3rvkViuN1NqOsmxN6go93oBhjZGBEwN1Z+HLc14pgtEzeCWG/Sel/b65xgDW9cSLTmeC75JYhPFskZSIGfy0asLVLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw12IdlzntrYqEH6qhT5s2GSjfm8VSB1pxZZE+7J/a8=;
 b=Y/LmGHBqCpSK1ZaowIjn9SYxygdRPtoCyF7IMcLggyQx+df4M7Tv8wvMeObAR18JC7ZJBx3gF6BLhqX/TUTSv91CmE7ncCBs7ZiKbfXZAwUkRPiBegYHLHMk/Z9oM4fRVXVzlDlAfgPfXVW9+NIxx7jYTlkHUfFiWXKduzX3i6MVAkRHnQPMMsBsEn1xKiCeJtQJmf9YJCrYN8YfXbZoWZirWHpiiS339c2yYghgq4UwVTq8Z8+on0XtRErWxFRT2leVSr5aO+QD5XwIVBoo1mUXDydKBYjuxVQ7A+k630l25oskjQGo176Cr2yxp3fLCox5pIAsZh7BsiiCC/mJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw12IdlzntrYqEH6qhT5s2GSjfm8VSB1pxZZE+7J/a8=;
 b=e2kBqzM+C+LXgxuWoNhIP9gSaKit7GTKCffVXJCiaqjFafyE1yMnw2Abf/TAVt4COJnHJEe6/Kr9FM9riOjlBFsI6lXln9elJ1W0YYqZIg71mQcpEKBVXrsU3mCmqQQ4C4OCBvN6uytPBiyDS7wbC+CjcYEoGRPwckuzwTEGIwo=
Received: from DS7P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::19) by
 DS0PR10MB6055.namprd10.prod.outlook.com (2603:10b6:8:cc::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.19; Tue, 23 Jun 2026 09:08:02 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:25c:cafe::45) by DS7P221CA0016.outlook.office365.com
 (2603:10b6:8:25c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 09:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:08:01 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:07:54 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:07:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 04:07:54 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N97bL42520663;
	Tue, 23 Jun 2026 04:07:49 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
        <lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rdunlap@infradead.org>, <Frank.Li@nxp.com>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v6 2/4] PCI: endpoint: Add DOE mailbox support for endpoint functions
Date: Tue, 23 Jun 2026 14:37:35 +0530
Message-ID: <20260623090737.711656-3-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS0PR10MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: f56e581e-e5bd-400a-dddf-08ded106ed4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|7416014|36860700016|13003099007|18002099003|22082099003|921020|6133799003|5023799004|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	WMug/KQCvYDbj6fp/yBdyo0hfgoJFyb64k4NR7qYgK2VQhH4oPfWVoDL96Y7PBHHmfLJY4GfP1RiKMQquAjnLCJE5FN6UyxyWVOec2lsCRWmNjnukOuPeNRF5M6X+AR6P1QHbxiRrKZfY1t0XyiRRoZA39GGs00kZHtB15yveCooNPwFHTUj5kMxwMnsXOfvG1IaQ1AGDWBaKJ2C72+yDxOT+9II0xj6ZxgUpQslf6dhtl47zWbHBgiuXpSc4pVz4hFX/s+K2NC5lfZP2tVUA5l2tRbq5J3Oj9Yt3nu/EmGR/oJoM9RnYNsEY0fROq4WbJrQqcIK8Loh/MCLQM3A03Y1pvUQDkkDoQFbMnb5oBPK6J7+/qPew6OJ/kDrJBk8e8JuaevDob8ccOIzaR8uQPtd9lqoeuz7hooCrhvCOCp7ZsNFzugxby/aZoiliMta8zb2ye2yyrjhV0nRW6jWV+NWBtbkU12jQzB2DS9+P4CIltN91kXHmTA4Vz9mF+YiorYnZons+UZ9WCQOQEEFpQU0LoXp8Xo588qRPX2L1HVLRg8TAbuYJO3wIlFFEGLiZTuXsxOqsKw8Vbjh6LWSaM1gayNe95JqGS165aCOXxyXDTFMGmvoZUeKVEhEVUTq43L4rT9lFLsB+AHBzXN9/7HDKRafdyhjk1/NGsnhhtfQFp5mXMHwO6h9AItY5dr/
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(13003099007)(18002099003)(22082099003)(921020)(6133799003)(5023799004)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+FXMyDoqbHuSqe6qAZntnp6wKaDYH8RkpF7BZ4m9Z0Py9gCgG/9gs9TrHO0X9bXQIjbE9MVObEnqeliH5AMr543s6rAglGXNjCAjbsoNO9FJBSEwxKBjFj3VfnppmwJR+oaj4YIrjcEH8h0B4zBp0SGu+pvPbFfR69chTqX5/KxZGCatHnJ6igHNuxYWob5EFz1ra+NtWAoHniphoC7cOfNgWF6h2uHW8X7K0Xe6OTx6hw47z/3cUGGdTz8UMBSmQcWrehRnFlAsi942f0GR2BwgJFPzJvLR6dr583A6IvlSOfrwwD9GP+W6SLjO5LngY619JwQzA5QQ255uSdbCeexOp8xEAxpdS/TMclG0MBk4qkKWWcMPNSg131Kk9rz86j9T2asDkpuJJwYFrraOQcFVflKhP6nzoH8OwTiWXBYpcg37h81ElWOTtVg+RiQf
X-Exchange-RoutingPolicyChecked:
	TBr90J/Wo22MSl3QAhg7DO1fNHnnfWT7dWB/QsZkWPjs2MC0vsfJDptI+Pj5+hc/PTdfCMA/kxArBOKrahkTqstd6YHrUF6V1DU+OR5UyYnMC2ZAJfKh4irCT8sWoqvhFhcpN8e95PDbBunQ6ZC9ytBc0HHkjJhwaOdieH9YNCa8fB+mQJE6OzgwuowKx80K8G2ZqFxt37t+NzUhEGI5Fp2TJOry0viKSjh04vIQKxwJH5ZQDDstgMQbq/gdLBXnIDeq3N80P2UhMAZzMNS6BqrC+cl6gfmLBrFx0VcbEteJ6oDbmnpo1gEpdLBcK/Cm/ajjRUt5bSKPXiAHNHs+2Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:08:01.3640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56e581e-e5bd-400a-dddf-08ded106ed4f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6055
X-Proofpoint-GUID: TyhyJpjc5pJUrVl2dq4FcwKwhD6MH0QM
X-Proofpoint-ORIG-GUID: TyhyJpjc5pJUrVl2dq4FcwKwhD6MH0QM
X-Authority-Analysis: v=2.4 cv=EPo2FVZC c=1 sm=1 tr=0 ts=6a3a4cf7 cx=c_pps
 a=ut66qxPycOxoCiL0Gbz/2w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=n5kR8oRbfA_fDx0BZckA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX9P+MNHGy/K46
 6zHIi2ZD4Kgnn2EH2xK/q1qFJ9CBszz5ob7rQ1WZDKzfsB6AmKk/o8gB4+Ig3H0oItZh4UjjcQi
 ENR2UCF9q+pPDMNUWFTYfh8S553G4ag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX/5AGW+qin5fc
 thrsce0sOQm9ytjl5NATi1Ej2Mnuf+H1qaN+NHgQ9wVAkgjVCRiTY6Kj8ntQjK39SGB3rIyoBPc
 U6Mj7To75orhzAw28/VyPYN9J3m8sBJrY875PRaHdiS9ANDc+nfAkolOFqeNne23w3YdPDz57sw
 Iumgc9rdd4xdnUeZ2pxKOnM4CHyCclNauZT4KY05po9RH4ZXgEb+4rXcC+NKaOP1TsF+5q3ia6F
 Ke6PBPMPykIs9lQp9d2M3pslznHo1nGnSNRwjungB0EXWqlTAFI9a+mMcQ/gojFgmi8Rd0QhW6l
 aJFMmlevf9G6ZGBkP7GSWTsOR2H4J5ID+e/ghn7/760ojsYv9bdqkIkcmwJnhlPKuEpM1AERHf+
 v2oDlnUUWNfx7GtCDiPTUVOq/oC8AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230072

DOE (Data Object Exchange) is a standard PCIe extended capability
feature defined in PCI Express Base Specification Revision 7.0,
Section 6.30. It provides a communication mechanism primarily used for
implementing PCIe security features such as device authentication, and
secure link establishment. Think of DOE as a sophisticated mailbox
system built into PCIe. The root complex can send structured requests
to the endpoint device through DOE mailboxes, and the endpoint device
responds with appropriate data.

Add the DOE support for PCIe endpoint devices, enabling endpoint
functions to process the DOE requests from the host. The implementation
provides framework APIs for EPC core driver and controller drivers to
register mailboxes, and request processing with workqueues ensuring
sequential handling per mailbox, and parallel handling across mailboxes.
The Discovery protocol is handled internally by the DOE core.

This implementation complements the existing DOE implementation for
root complex in drivers/pci/doe.c.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v5 yo v6:
- Addressed the review comments provided by Bjorn Helgaas at v5
- Used xa_lock_irqsave() instead of xa_lock() in pci_ep_doe_get_mailbox()
- Added a spinlock to protect the work_queue of the doe_mb struct from
  being destroyed while being called

Changes from v4 to v5:
- Addressed the review comments by Sashiko
- Added refcount per DOE Mailbox to fix Use-After-Free bug
- Change in the Abort Sequence:
  * Instead of waiting on flush_workqueue() to clear the CANCEL flag,
    return immediately after setting the CANCEL flag. The CANCEL flag
    gets cleared in signal_task_complete(), allowing the mailbox to
    accept new requests
  * Abort sequence handling in various scenarios is updated and explained
    in the documentation at PATCH 4/4

Changes from v3 to v4:
- Used 'Returns' instead of 'RETURNS' in the function docstrings to
  comply with kernel-doc format, as suggested by Manivannan Sadhasivam.
- In pci_ep_doe_process_request(), changed the type of request buffer
  from "const void *" to "void *", as the ownership is transferred to
  DOE-EP framework, which is responsible to free the buffer.
- Added "struct pci_epc *epc" to typedef "pci_ep_doe_complete_t", to be
  used by the EPC driver.

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- Moved the DOE-EP core file to drivers/pci/endpoint/pci-ep-doe.c, and
  corresponding Kconfig and Makefile to match the existing naming scheme,
  as suggested by Niklas Cassel.
- Renamed the config from PCI_DOE_EP to PCI_ENDPOINT_DOE
- Moved the function declarations that need not be visible outside the
  PCI core to drivers/pci/pci.h instead to include/linux/pci-doe.h as
  suggested by Lukas Wunner
- Converted from synchronous to asynchronous request processing:
  * Removed wait_for_completion() from pci_ep_doe_process_request()
  * Function returns immediately after queuing to workqueue, hence
    removed private data for completion in the task structure
  * Added completion callback as an additional argument to
    pci_ep_doe_process_request(), which takes the response and status
    parameters as arguments (along with other required arguments), hence
    removed task_status in the task structure
  * Created a typedef pci_ep_doe_complete_t for completion callback
  * Removed the pci_ep_doe_task_complete() function, as it would not be
    required anymore with these changes
  * Moved from INIT_WORK_ONSTACK() to INIT_WORK(), to initialize the work
    on heap instead of stack
  * signal_task_complete() now invokes the completion callback, once the
    protocol handler completes its task
- Changed from dynamic xarray-based protocol registration to static array:
  * Removed the register/unregister protocol APIs
  * Replaced the dynamic xarray with static array of struct pci_doe_protocol
  * Added discovery protocol to static array, instead of treating it specially,
    hence removed the special handling for Discovery protocol in
    doe_ep_task_work()
  * Updated pci_ep_doe_handle_discovery() and pci_ep_doe_find_protocol()
    accordingly.
- Memory Management:
  * DOE core frees request buffer in signal_task_complete()
    or during error handling
  * pci_ep_doe_process_request() defines response_pl and response_pl_sz
    as NULL and 0 respectively, whose pointer is passed to the protocol
    handler, hence removed the arguments void **response, size_t *response_sz
    to this function.
- Task structure refactoring:
  * Response buffer: void **response_pl to void *response_pl
  * Response size: size_t *response_pl_sz to size_t response_pl_sz
  * Changed the completion callback to type pci_ep_doe_complete_t
  * Removed void *private and int task_status
- Updated documentation comments of the functions according to the changes

v5: https://lore.kernel.org/all/20260610100256.1889111-3-a-garg7@ti.com/
v4: https://lore.kernel.org/all/20260522052434.802034-3-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260427051725.223704-3-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260401073022.215805-3-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260213123603.420941-4-a-garg7@ti.com/

 drivers/pci/endpoint/Kconfig      |  14 +
 drivers/pci/endpoint/Makefile     |   1 +
 drivers/pci/endpoint/pci-ep-doe.c | 591 ++++++++++++++++++++++++++++++
 drivers/pci/pci.h                 |  42 +++
 include/linux/pci-doe.h           |   5 +
 include/linux/pci-epc.h           |   3 +
 6 files changed, 656 insertions(+)
 create mode 100644 drivers/pci/endpoint/pci-ep-doe.c

diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index 8dad291be8b8..15ae16aaa58f 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -36,6 +36,20 @@ config PCI_ENDPOINT_MSI_DOORBELL
 	  doorbell. The RC can trigger doorbell in EP by writing data to a
 	  dedicated BAR, which the EP maps to the controller's message address.
 
+config PCI_ENDPOINT_DOE
+	bool "PCI Endpoint Data Object Exchange (DOE) support"
+	depends on PCI_ENDPOINT
+	help
+	  This enables support for Data Object Exchange (DOE) protocol
+	  on PCI Endpoint controllers. It provides a communication
+	  mechanism through mailboxes, primarily used for PCIe security
+	  features.
+
+	  Say Y here if you want be able to communicate using PCIe DOE
+	  mailboxes.
+
+	  If unsure, say N.
+
 source "drivers/pci/endpoint/functions/Kconfig"
 
 endmenu
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index b4869d52053a..1fa176b6792b 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
 					   pci-epc-mem.o functions/
 obj-$(CONFIG_PCI_ENDPOINT_MSI_DOORBELL)	+= pci-ep-msi.o
+obj-$(CONFIG_PCI_ENDPOINT_DOE)		+= pci-ep-doe.o
diff --git a/drivers/pci/endpoint/pci-ep-doe.c b/drivers/pci/endpoint/pci-ep-doe.c
new file mode 100644
index 000000000000..b2832253eaca
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-doe.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Data Object Exchange for PCIe Endpoint
+ *	PCIe r7.0, sec 6.30 DOE
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com
+ *	Aksh Garg <a-garg7@ti.com>
+ *	Siddharth Vadapalli <s-vadapalli@ti.com>
+ */
+
+#define dev_fmt(fmt) "DOE EP: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-doe.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+
+#include "../pci.h"
+
+/* Forward declaration of discovery protocol handler */
+static int pci_ep_doe_handle_discovery(const void *request, size_t request_sz,
+				       void **response, size_t *response_sz);
+
+/**
+ * struct pci_doe_protocol - DOE protocol handler entry
+ * @vid: Vendor ID
+ * @type: Protocol Type
+ * @handler: Handler function pointer
+ */
+struct pci_doe_protocol {
+	u16 vid;
+	u8 type;
+	pci_doe_protocol_handler_t handler;
+};
+
+/**
+ * struct pci_ep_doe_mb - State for a single DOE mailbox on EP
+ *
+ * This state is used to manage a single DOE mailbox capability on the
+ * endpoint side.
+ *
+ * @epc: PCI endpoint controller this mailbox belongs to
+ * @func_no: Physical function number of the function this mailbox belongs to
+ * @cap_offset: Capability offset
+ * @work_queue: Queue of work items
+ * @flags: Bit array of PCI_DOE_FLAG_* flags
+ * @refs: Refcount to manage mailbox lifetime and ensure safe cleanup
+ * @lock: Spinlock protecting work_queue access and DEAD flag checks
+ */
+struct pci_ep_doe_mb {
+	struct pci_epc *epc;
+	u8 func_no;
+	u16 cap_offset;
+	struct workqueue_struct *work_queue;
+	unsigned long flags;
+	refcount_t refs;
+	spinlock_t lock;	/* Serialize work queue access */
+};
+
+/**
+ * struct pci_ep_doe_task - Represents a single DOE request/response task
+ *
+ * @feat: DOE feature (Vendor ID and Type)
+ * @request_pl: Request payload
+ * @request_pl_sz: Size of request payload in bytes
+ * @response_pl: Response buffer
+ * @response_pl_sz: Size of response buffer in bytes
+ * @complete: Completion callback
+ * @work: Work structure for workqueue
+ * @doe_mb: DOE mailbox handling this task
+ */
+struct pci_ep_doe_task {
+	struct pci_doe_feature feat;
+	const void *request_pl;
+	size_t request_pl_sz;
+	void *response_pl;
+	size_t response_pl_sz;
+	pci_ep_doe_complete_t complete;
+
+	/* Initialized by pci_ep_doe_submit_task() */
+	struct work_struct work;
+	struct pci_ep_doe_mb *doe_mb;
+};
+
+/*
+ * Global registry of protocol handlers.
+ * When a new DOE protocol, library is added, add an entry to this array.
+ */
+static const struct pci_doe_protocol pci_doe_protocols[] = {
+	{
+		.vid = PCI_VENDOR_ID_PCI_SIG,
+		.type = PCI_DOE_FEATURE_DISCOVERY,
+		.handler = pci_ep_doe_handle_discovery,
+	},
+};
+
+/*
+ * Combine function number and capability offset into a unique lookup key
+ * for storing/retrieving DOE mailboxes in an xarray.
+ */
+#define PCI_DOE_MB_KEY(func, offset) \
+	(((unsigned long)(func) << 16) | (offset))
+#define PCI_DOE_PROTOCOL_COUNT        ARRAY_SIZE(pci_doe_protocols)
+
+/**
+ * pci_ep_doe_init() - Initialize the DOE framework for a controller in EP mode
+ * @epc: PCI endpoint controller
+ *
+ * Initialize the xarray that will hold the mailboxes.
+ */
+void pci_ep_doe_init(struct pci_epc *epc)
+{
+	xa_init(&epc->doe_mbs);
+}
+EXPORT_SYMBOL_GPL(pci_ep_doe_init);
+
+/**
+ * pci_ep_doe_add_mailbox() - Add a DOE mailbox for a physical function
+ * @epc: PCI endpoint controller
+ * @func_no: Physical function number
+ * @cap_offset: Offset of the DOE capability
+ *
+ * Create and register a DOE mailbox for the specified physical function
+ * and capability offset.
+ *
+ * EPC core driver calls this for each DOE capability discovered in the config
+ * space of each endpoint function if DOE support is available for the EPC.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offset)
+{
+	struct pci_ep_doe_mb *doe_mb;
+	unsigned long key;
+	int ret;
+
+	doe_mb = kzalloc_obj(*doe_mb, GFP_KERNEL);
+	if (!doe_mb)
+		return -ENOMEM;
+
+	doe_mb->epc = epc;
+	doe_mb->func_no = func_no;
+	doe_mb->cap_offset = cap_offset;
+
+	doe_mb->work_queue = alloc_ordered_workqueue("pci_ep_doe[%s:pf%d:offset%x]",
+						     0, dev_name(&epc->dev),
+						     func_no, cap_offset);
+	if (!doe_mb->work_queue) {
+		dev_err(epc->dev.parent,
+			"[pf%d:offset%x] failed to allocate work queue\n",
+			func_no, cap_offset);
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	/* Add to xarray with composite key */
+	key = PCI_DOE_MB_KEY(func_no, cap_offset);
+	ret = xa_insert(&epc->doe_mbs, key, doe_mb, GFP_KERNEL);
+	if (ret) {
+		dev_err(epc->dev.parent,
+			"[pf%d:offset%x] failed to insert mailbox: %d\n",
+			func_no, cap_offset, ret);
+		goto err_destroy;
+	}
+
+	refcount_set(&doe_mb->refs, 1);
+	spin_lock_init(&doe_mb->lock);
+
+	dev_dbg(epc->dev.parent,
+		"DOE mailbox added: pf%d offset 0x%x\n",
+		func_no, cap_offset);
+
+	return 0;
+
+err_destroy:
+	destroy_workqueue(doe_mb->work_queue);
+err_free:
+	kfree(doe_mb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_ep_doe_add_mailbox);
+
+/**
+ * pci_ep_doe_cancel_tasks() - Cancel all pending tasks
+ * @doe_mb: DOE mailbox
+ *
+ * Cancel all pending tasks in the mailbox. Mark the mailbox as dead
+ * so no new tasks can be submitted.
+ */
+static void pci_ep_doe_cancel_tasks(struct pci_ep_doe_mb *doe_mb)
+{
+	/* Mark the mailbox as dead */
+	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
+
+	/* Stop all pending work items from starting */
+	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
+}
+
+/**
+ * pci_ep_doe_get_mailbox() - Get DOE mailbox by function and offset
+ * @epc: PCI endpoint controller
+ * @func_no: Physical function number
+ * @cap_offset: Offset of the DOE capability
+ *
+ * Internal helper to look up a DOE mailbox by its function number and
+ * capability offset.
+ *
+ * Return: Pointer to the mailbox or NULL if not found
+ */
+static struct pci_ep_doe_mb *pci_ep_doe_get_mailbox(struct pci_epc *epc,
+						    u8 func_no, u16 cap_offset)
+{
+	struct pci_ep_doe_mb *doe_mb;
+	unsigned long key, flags;
+
+	key = PCI_DOE_MB_KEY(func_no, cap_offset);
+
+	xa_lock_irqsave(&epc->doe_mbs, flags);
+
+	doe_mb = xa_load(&epc->doe_mbs, key);
+	if (doe_mb && !refcount_inc_not_zero(&doe_mb->refs))
+		doe_mb = NULL;
+
+	xa_unlock_irqrestore(&epc->doe_mbs, flags);
+
+	return doe_mb;
+}
+
+/**
+ * pci_ep_doe_put_mailbox() - Release a reference to a DOE mailbox
+ * @doe_mb: The mailbox structure to release
+ *
+ * Drop the reference count. Free the memory allocated to the mailbox structure
+ * if this was the last active reference.
+ */
+static void pci_ep_doe_put_mailbox(struct pci_ep_doe_mb *doe_mb)
+{
+	if (refcount_dec_and_test(&doe_mb->refs))
+		kfree(doe_mb);
+}
+
+/**
+ * pci_ep_doe_find_protocol() - Find protocol handler in static array
+ * @vendor: Vendor ID
+ * @type: Protocol Type
+ *
+ * Look up a protocol handler in the static protocol array by matching
+ * Vendor ID and Protocol Type.
+ *
+ * Return: Handler function pointer or NULL if not found
+ */
+static pci_doe_protocol_handler_t pci_ep_doe_find_protocol(u16 vendor, u8 type)
+{
+	int i;
+
+	/* Search static protocol array */
+	for (i = 0; i < PCI_DOE_PROTOCOL_COUNT; i++) {
+		if (pci_doe_protocols[i].vid == vendor &&
+		    pci_doe_protocols[i].type == type)
+			return pci_doe_protocols[i].handler;
+	}
+
+	return NULL;
+}
+
+/**
+ * pci_ep_doe_handle_discovery() - Handle Discovery protocol request
+ * @request: Request payload
+ * @request_sz: Request size
+ * @response: Output pointer for response buffer
+ * @response_sz: Output pointer for response size
+ *
+ * Handle the DOE Discovery protocol. The request contains an index specifying
+ * which protocol to query. This function creates a response containing the
+ * Vendor ID and Protocol Type for the requested index, along with the next
+ * index value for further discovery:
+ *
+ * - next_index = 0: Signals this is the last protocol supported
+ * - next_index = n (non-zero): Signals more protocols available,
+ *   query index n next
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int pci_ep_doe_handle_discovery(const void *request, size_t request_sz,
+				       void **response, size_t *response_sz)
+{
+	struct pci_doe_protocol protocol;
+	u8 requested_index, next_index;
+	u32 *response_pl;
+	u32 request_pl;
+	u16 vendor;
+	u8 type;
+
+	if (request_sz != sizeof(u32))
+		return -EINVAL;
+
+	request_pl = *(u32 *)request;
+	requested_index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
+				    request_pl);
+
+	if (requested_index >= PCI_DOE_PROTOCOL_COUNT) {
+		/* No more protocols to report */
+		vendor = 0;
+		type = 0;
+	} else {
+		/* Get protocol from array at requested_index */
+		protocol = pci_doe_protocols[requested_index];
+		vendor = protocol.vid;
+		type = protocol.type;
+	}
+
+	/* Calculate next index */
+	next_index = (requested_index + 1 < PCI_DOE_PROTOCOL_COUNT) ?
+		      requested_index + 1 : 0;
+
+	response_pl = kzalloc_obj(*response_pl, GFP_KERNEL);
+	if (!response_pl)
+		return -ENOMEM;
+
+	/* Build response */
+	*response_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, vendor) |
+		       FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE, type) |
+		       FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
+				  next_index);
+
+	*response = response_pl;
+	*response_sz = sizeof(*response_pl);
+
+	return 0;
+}
+
+static void signal_task_complete(struct pci_ep_doe_task *task, int status)
+{
+	struct pci_ep_doe_mb *doe_mb = task->doe_mb;
+
+	task->complete(doe_mb->epc, doe_mb->func_no, doe_mb->cap_offset,
+		       status, task->feat.vid, task->feat.type,
+		       task->response_pl, task->response_pl_sz);
+
+	/* Clear the CANCEL flag for next DOE request */
+	clear_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
+
+	kfree(task->request_pl);
+	kfree(task);
+
+	/* Release the mailbox reference acquired during process_request */
+	pci_ep_doe_put_mailbox(doe_mb);
+}
+
+/**
+ * doe_ep_task_work() - Work function for processing DOE EP tasks
+ * @work: Work structure
+ *
+ * Process a DOE request by calling the appropriate protocol handler.
+ */
+static void doe_ep_task_work(struct work_struct *work)
+{
+	struct pci_ep_doe_task *task = container_of(work,
+						    struct pci_ep_doe_task,
+						    work);
+	struct pci_ep_doe_mb *doe_mb = task->doe_mb;
+	pci_doe_protocol_handler_t handler;
+	int rc;
+
+	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
+		signal_task_complete(task, -EIO);
+		return;
+	}
+
+	/* Check if request was aborted */
+	if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags)) {
+		signal_task_complete(task, -ECANCELED);
+		return;
+	}
+
+	handler = pci_ep_doe_find_protocol(task->feat.vid, task->feat.type);
+	if (!handler) {
+		dev_warn_ratelimited(doe_mb->epc->dev.parent,
+				     "[%d:%x] Unsupported protocol VID=%04x TYPE=%02x\n",
+				     doe_mb->func_no, doe_mb->cap_offset,
+				     task->feat.vid, task->feat.type);
+		signal_task_complete(task, -EOPNOTSUPP);
+		return;
+	}
+
+	rc = handler(task->request_pl, task->request_pl_sz,
+		     &task->response_pl, &task->response_pl_sz);
+
+	signal_task_complete(task, rc);
+}
+
+/**
+ * pci_ep_doe_submit_task() - Submit a task to be processed
+ * @doe_mb: DOE mailbox
+ * @task: Task to submit
+ *
+ * Submit a DOE task to the workqueue for asynchronous processing.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int pci_ep_doe_submit_task(struct pci_ep_doe_mb *doe_mb,
+				  struct pci_ep_doe_task *task)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&doe_mb->lock, flags);
+	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	task->doe_mb = doe_mb;
+	INIT_WORK(&task->work, doe_ep_task_work);
+	queue_work(doe_mb->work_queue, &task->work);
+
+out:
+	spin_unlock_irqrestore(&doe_mb->lock, flags);
+	return ret;
+}
+
+/**
+ * pci_ep_doe_process_request() - Process DOE request on endpoint
+ * @epc: PCI endpoint controller
+ * @func_no: Physical function number
+ * @cap_offset: DOE capability offset
+ * @vendor: Vendor ID from request header
+ * @type: Protocol Type from request header
+ * @request: Request payload in CPU-native format
+ * @request_sz: Size of request payload (bytes)
+ * @complete: Callback to invoke upon completion
+ *
+ * Asynchronously process a DOE request received on the endpoint. The request
+ * payload should not include the DOE header (vendor/type/length). Ownership
+ * of the request buffer is transferred to DOE EP core, which frees the buffer
+ * either on error or by signal_task_complete() after the completion callback
+ * fires. The protocol handler will allocate the response buffer, which the
+ * caller (controller driver) must free after use.
+ *
+ * This function returns immediately after queuing the request. The completion
+ * callback will be invoked asynchronously from workqueue context once the
+ * request is processed. The callback receives the function number and
+ * capability offset to identify the mailbox, along with a status code
+ * (0 on success, -errno on failure), and other required arguments.
+ *
+ * As per DOE specification, a mailbox processes one request at a time.
+ * Therefore, this function will never be called concurrently for the same
+ * mailbox by different callers.
+ *
+ * The caller is responsible for the conversion of the received DOE request
+ * with le32_to_cpu() before calling this function. Similarly, it is also
+ * responsible for converting the response payload with cpu_to_le32() before
+ * sending it back over the DOE mailbox.
+ *
+ * The caller is also responsible for ensuring that the request size is within
+ * the limits defined by PCI_DOE_MAX_LENGTH.
+ *
+ * Return: 0 if the request was successfully queued, -errno on failure
+ */
+int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
+			       u16 vendor, u8 type, void *request,
+			       size_t request_sz,
+			       pci_ep_doe_complete_t complete)
+{
+	struct pci_ep_doe_mb *doe_mb;
+	struct pci_ep_doe_task *task;
+	int ret;
+
+	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
+	if (!doe_mb) {
+		kfree(request);
+		return -ENODEV;
+	}
+
+	task = kzalloc_obj(*task, GFP_ATOMIC);
+	if (!task) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	task->feat.vid = vendor;
+	task->feat.type = type;
+	task->request_pl = request;
+	task->request_pl_sz = request_sz;
+	task->response_pl = NULL;
+	task->response_pl_sz = 0;
+	task->complete = complete;
+
+	ret = pci_ep_doe_submit_task(doe_mb, task);
+	if (ret)
+		goto err_task;
+
+	return 0;
+
+err_task:
+	kfree(task);
+err_free:
+	kfree(request);
+	pci_ep_doe_put_mailbox(doe_mb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_ep_doe_process_request);
+
+/**
+ * pci_ep_doe_abort() - Abort DOE operations on a mailbox
+ * @epc: PCI endpoint controller
+ * @func_no: Physical function number
+ * @cap_offset: DOE capability offset
+ *
+ * Abort the queued or in-flight DOE operation for the specified mailbox.
+ * This function is called by the EP controller driver when the RC sets the
+ * DOE Abort bit in the DOE Control Register, and the DOE Busy bit is set in
+ * the DOE Status Register.
+ *
+ * Set the CANCEL flag on the mailbox to prevent queued requests
+ * from starting, and return immediately. The CANCEL flag gets cleared in
+ * signal_task_complete(), allowing the mailbox to accept new requests.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset)
+{
+	struct pci_ep_doe_mb *doe_mb;
+
+	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
+	if (!doe_mb)
+		return -ENODEV;
+
+	/* Set CANCEL flag - worker will abort queued requests */
+	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
+
+	dev_dbg_ratelimited(epc->dev.parent,
+			    "DOE mailbox abort initialized: PF%d offset 0x%x\n",
+			    func_no, cap_offset);
+
+	pci_ep_doe_put_mailbox(doe_mb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ep_doe_abort);
+
+/**
+ * pci_ep_doe_destroy_mb() - Destroy a single DOE mailbox
+ * @doe_mb: DOE mailbox to destroy
+ *
+ * Internal function to destroy a mailbox and free its resources.
+ */
+static void pci_ep_doe_destroy_mb(struct pci_ep_doe_mb *doe_mb)
+{
+	struct workqueue_struct *wq;
+	unsigned long flags;
+
+	pci_ep_doe_cancel_tasks(doe_mb);
+
+	spin_lock_irqsave(&doe_mb->lock, flags);
+	wq = doe_mb->work_queue;
+	doe_mb->work_queue = NULL;
+	spin_unlock_irqrestore(&doe_mb->lock, flags);
+
+	if (wq)
+		destroy_workqueue(wq);
+
+	pci_ep_doe_put_mailbox(doe_mb);
+}
+
+/**
+ * pci_ep_doe_destroy() - Destroy all DOE mailboxes
+ * @epc: PCI endpoint controller
+ *
+ * Destroy all DOE mailboxes and free associated resources.
+ *
+ * The EPC core driver calls this to free all DOE resources,
+ * if DOE support is available for the EPC.
+ */
+void pci_ep_doe_destroy(struct pci_epc *epc)
+{
+	struct pci_ep_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&epc->doe_mbs, index, doe_mb) {
+		xa_erase(&epc->doe_mbs, index);
+		pci_ep_doe_destroy_mb(doe_mb);
+	}
+
+	xa_destroy(&epc->doe_mbs);
+}
+EXPORT_SYMBOL_GPL(pci_ep_doe_destroy);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5844deee2b5f..6d3b4b779d15 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -692,6 +692,13 @@ struct pci_doe_feature {
 	u8 type;
 };
 
+struct pci_epc;
+
+typedef void (*pci_ep_doe_complete_t)(struct pci_epc *epc, u8 func_no,
+				      u16 cap_offset, int status,
+				      u16 vendor, u8 type,
+				      void *response_pl, size_t response_pl_sz);
+
 #ifdef CONFIG_PCI_DOE
 void pci_doe_init(struct pci_dev *pdev);
 void pci_doe_destroy(struct pci_dev *pdev);
@@ -702,6 +709,41 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_ENDPOINT_DOE
+void pci_ep_doe_init(struct pci_epc *epc);
+int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offset);
+int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
+			       u16 vendor, u8 type, void *request,
+			       size_t request_sz,
+			       pci_ep_doe_complete_t complete);
+int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset);
+void pci_ep_doe_destroy(struct pci_epc *epc);
+#else
+static inline void pci_ep_doe_init(struct pci_epc *epc) { }
+static inline int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no,
+					 u16 cap_offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pci_ep_doe_process_request(struct pci_epc *epc,
+					     u8 func_no, u16 cap_offset,
+					     u16 vendor, u8 type,
+					     void *request, size_t request_sz,
+					     pci_ep_doe_complete_t complete)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no,
+				   u16 cap_offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pci_ep_doe_destroy(struct pci_epc *epc) { }
+#endif
+
 #ifdef CONFIG_PCI_NPEM
 void pci_npem_create(struct pci_dev *dev);
 void pci_npem_remove(struct pci_dev *dev);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index abb9b7ae8029..c46e42f3ce78 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -22,6 +22,11 @@ struct pci_doe_mb;
 /* Max data object length is 2^18 dwords */
 #define PCI_DOE_MAX_LENGTH		(1 << 18)
 
+typedef int (*pci_doe_protocol_handler_t)(const void *request,
+					  size_t request_sz,
+					  void **response,
+					  size_t *response_sz);
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 1eca1264815b..dd26294c8175 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -182,6 +182,9 @@ struct pci_epc {
 	unsigned long			function_num_map;
 	int				domain_nr;
 	bool				init_complete;
+#ifdef CONFIG_PCI_ENDPOINT_DOE
+	struct xarray			doe_mbs;
+#endif
 };
 
 /**
-- 
2.34.1

