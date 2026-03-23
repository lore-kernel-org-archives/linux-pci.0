Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C839B956;
	Mon, 23 Mar 2026 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267187; cv=fail; b=ZGtdFsWMe0T0p6Zp5om24nGdebNoLMx37ZxY1oYh5y9lqLdIziQ22+HWRyJjMZblrsQW5u5CBmROlU6cJi7yoCfDdAPIXjCCeEbjoeI5DkFn+JjB/ROBX6L04LOcu+p4CyGmuEN7M7MgQun8JCJqiNc9/8kL2k6E36oCxq9fbf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267187; c=relaxed/simple;
	bh=ey4qd6SnGrlBd8D0Brc7SWXG4J5qNeXd+3sNYtpl01o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=FQzMWT964bld55hMZX791kcCEmtF5Jdf0agyMrpfJy10yOFuSktSDgxtLCDpC4F9EdWA8zMMklifeMEtS6oEA0TIbNqWgAriEY3wvuPAFSkNPfa1Nhg2CIG2xXHX+MFtkl5zXEphKpq2ZKdftFLP+5cPVRgVucvTAWyIVYo2H0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XiEcICRY; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XiEcICRY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3vQZm4zwN8NMY8GWo7NvAC18RTeviSu/7ZSrpJ5fd3SKlYMysTbX4jPQgI1osI+Ne4g5tcRfndn9Xb/wLcbbXIE89HmEVV+gqYAsNW8fdzeOj5fmQomShVVW9dy7duAcTo2N5QuJoQgU2WBzZlQuREi74S14VvqoNhf0I9cDp9lHlIrXg8QSNgZzrzYvrLVyHxrs2rgP3oe/wxeN6cFG5XQLthZ5VRT6NHj+MqQM7A+YhVbso+cG2AeeF0JSj7x18xFc+fxuK1WCHSdKpuXD5uW8Rleh8PSNqNi7TQhIki6jWF6s/NfQUCP+3nBQESj6vupG0pxmM3lpKVBAKhHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcaGMjHBYLKgxAH7mLCtnFeas2MannMPM1aPbMI12sg=;
 b=PS+2HmRrkNZC4uL/b5+5TrJSozB8YYN5HumE/xYp1jOlWctL1CHlvUSdhn1T/eHxV1QaiM9NV2Ctl9HClaJRZu8rYaRr+kf07OzAY2X0N4ZLaFZlEawa99uLDm7rKSjDIdLjEbaq7YRVmN9TqndlIL983CBrFJrDAzgToFxSBduR76Niax1MG9S9DU4nVXnjs0ZaWqx1Oj+Z9bz799Fol+k5frjssBsT7HyvF4a6mRrb/8d7eYpdoToBdFvySj/v0P9wHXb+b4WnKoilniaM0865HZCDFJrZ+mM6X4pVD8PbMddfS+qL10cer0yK6fTkb0fBW6CZoOUcVMS6V1q2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcaGMjHBYLKgxAH7mLCtnFeas2MannMPM1aPbMI12sg=;
 b=XiEcICRYI6eCoggu7x9LFbNKHF6gmboD+KB5F3yLiDsUJcaGO3FdhVXvxwBHuZ5fNuko44IugNQiCUBte3cpBzmNG8k/xAxlg7uTVq7QOqpbiByh9QY8EgeR5Qe2uEttmko1ILUQbUgBO9Ulrt8Xij3sWTWfmt4RqFiNU2/xa+d6Y92/ZBhM6WUjd9mVw5uC/aEmomd8V4bQPTVYVB5r8xmWfmtagIxFT2eSDQxfDr6Oyc3u9zP+KwD7fxj84CNUOCiW1kFjL9/CYY270ViO8GpbkSsPsZDzhkQ38CgcBKCSrpax8Mreuwzzip4czV7j6Do/QiO2ok5NvCDrDyPvyw==
Received: from DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) by AS1PR10MB5215.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:59:37 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::c6) by DUZPR01CA0048.outlook.office365.com
 (2603:10a6:10:469::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.29 via Frontend Transport; Mon,
 23 Mar 2026 11:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:59:37 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 13:02:13 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 12:59:36 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v3 0/3] Skip subrange map tests on DWC iATU allocation
 failure
Date: Mon, 23 Mar 2026 12:59:26 +0100
Message-ID: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4rwWkC/5XNTQ6CMBCG4auYri3pD2Jx5T2MMVCmMjFS0qmNh
 nB3Cyvd6fKdTJ5vYgQBgdhhM7EACQn9kENvN8z2zXAFjl1upoSqhJaG0w1H3jbhQo82rA8RKBJ
 Hx2HwNFpuVeWEFtpArVh2xgAOn+vG6Zy7R4o+vNbJJJfrP3qSXHAnm7Le6RJaaI7OExUUC+vvb
 PGT+jCV/sVU2VTCCGf2Ruqy+zbneX4DXjwRqigBAAA=
X-Change-ID: 20260318-skip-bar_subrange-tests-if-enospc-c26f03038e92
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christian
 Bruel" <christian.bruel@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|AS1PR10MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 821406d3-c6da-417f-56b7-08de88d3a857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aqYPv/MBGDoAzDaU8RdOBxuZZ2CMIZF5PI+lzQJ1jDWEL4LqQLODavObX29/fuFKgW+TiZ97xIIcKLRYWaGx1Hwtb4PN7dVE4obexLsgtcPXQec3XY0qI4wEb4NL4URS9FwjEVGkzZXXLgnxU+VWG2nG1M1ZV9JeRyy+CzQlvBucQwtvzG3IQo42Qemh9F+8pZ2bwHHq9bPw2GVmU+ZovWn9Y6H0jjHO5tLPzK9mq7E4kvIzT5ibrwxR+j2DFajRWZNYsLB7cX+Jbxe1MHVG9fGXvoeR0GAGUZGWZE8DmFqmMtpIb3ECBZK6vntab23sOKfS+2/zoHM1xMFpFMhaKRlAWDs3B9hgpLWSMU6plJIZ+FtSO5vxsBaV5TTlVlx/ngSxJrJ1ahR1jAlNpTxQjleWnfmGmbHYxdkbM/7dM659YHd099qu7VZnCkeQml1WxOe529hale6PskkPZU/ytP1epy3BvK0D6E9TFX2IHbxg1AWmRIqLKrziJI/iUXAa5e+J2jKfkMfyTJ8KGJlUYJxN3nnrNa8VR4ize0VBNWQWnyXFzhzk/s6qdu3QEyK/tcMrAVfeeqz0kJwSa6o6cY/sqKRKA23kTyvjTidUdEIaSHvW/U6iyipfQ8xqGMA+TTGuIoj5llp6CEOJcfeltyENgU+KtkeiPq6GSlHCQkt+SSlp6rP0t8HLZd2ba6n6A86UtRSM2cZQ23Nghw5KV4dOZ6YsQ4bx/U81LGjs7P8oqEkjr5uzMjBR2pnOKi3bV9JYIZeH4JMIugBNkIBLhg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zg7Q0sokw9gaW/gQtRV1mM6X77kXXH8fojRkkXA4j7/e2li9gqI6Oi+S7UAMz+1mFgaWXsvBtS9leJFLaEwBtZ/4lpup+4yoZRw84y9aPfu1XY4Us8sfzk/62UCPw3qihaHK2F+Js2S36ko/+3bvR9LlaoNMJOZ+0TB8YeKQ37xnfpPIiGkZ81z3dOBc1igh/YXq4/36fkcFNnkMS8y99CnaoAqOVAkO2yvhhqBDOs4/A2C4v/cjaCmlDR7GgHHGFAUMPjAfxStuX+Kez58Kvur29LeyjryKvyoeQSpw/U2j/Yu6EvAufJOBvVoAKGB11OTWv8sY4pOEqm9H3USqNURC7d6KLJUfIBA53//Kc6SD5ZAhGV1C2fLAdx5TrTUmxS2W6O3ro55Te3cWFEcD+5HTtsnP7Tu5gbB/ua4obiEoVSuOicFZdDZF9CL9nZu9
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:59:37.5909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821406d3-c6da-417f-56b7-08de88d3a857
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5215

For platforms with a limited iATU inbound window entries, pci_epc_set_bar()
might fail to allocate the ATU entries for subrange maps requiring more
than 1 slot.
For the dwc controller, this failure is reported with -ENOSPC in
dw_pcie_ep_set_bar(). In this case, the epf test cannot be run and needs
to be skipped.

For other controllers (Rockchip, RCar, Cadence) the .set_bar functions do
not use this error.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
Changes in v3:
- Remove 'BAR' from SKIP print message (Niklas)
- Added 'Reviewed-by: Niklas Cassel <cassel@kernel.org>' tag
- Link to v2: https://lore.kernel.org/r/20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com

Changes in v2:
- Rebased, reordered patches
- Clarified reporting message in selftest
- Renamed STATUS_BAR_SUBRANGE_SETUP_NOPSC STATUS_NO_RESOURCE
- Link to v1: https://lore.kernel.org/r/20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com

---
Christian Bruel (3):
      PCI: endpoint: pci-epf-test: Handle -ENOSPC in subrange_setup
      misc: pci_endpoint_test: Handle -ENOSPC in subrange mapping test case
      selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC

 drivers/misc/pci_endpoint_test.c                         | 3 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c            | 3 +++
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260318-skip-bar_subrange-tests-if-enospc-c26f03038e92

Best regards,
-- 
Christian Bruel <christian.bruel@foss.st.com>

