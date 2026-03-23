Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E8371CF3;
	Mon, 23 Mar 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253745; cv=fail; b=kHpT18SWKFHw9N0HaRSj/yrrBPomOohuuwyqGCEee0rrsDChm6YT6epSCInSUQs0tscJA6Xb+1iAfZHZlPjKe/w88KsD2synwxc3cLx8DweezG5CKOh1u2Iy0WZasr7cvoMGy++JBN9v68NVZsHMA4+J2+PXFZ7em7aViAos8K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253745; c=relaxed/simple;
	bh=j5BgMSyIxbXiLp1G3s+GOzHm+vfN36dWiNd4WSZuw7k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=YYVe+IYxSZU8K1y6cUSuJ0tjbp0GYBONIV0IB+21MahK9o3zHWPo4Xu/2YmH/iRbPU26anGmVTmWUoit2y6Csy8AdWxnSBiGFjKEOebbCEcVzDEHt5KPIokGnHlOUkueayr1EEWoGBqgSD6DhdocG5SHp/vsRg0I1+SqRSus9QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eOeuJ4+l; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eOeuJ4+l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpN2tiHLxRwzlYfGgVHFxN83OT8ckIrE17heySexzQeMgQkUJuNEjXcB1FVcx5GE7k4qhYhKIKWNbncCnEpPIjQb0knZ/S6m9logAeDDmDhNH+VocUHGmjzju8sRZWGDok4/+TAAy3ne4ERBjxFUuRGDECEW6szNPQZpVP4ukSJOLhw25gE13+uUrHiuZmYAdXFzEhH/oCrlAsGFy9yQv18N3xPiSE0/H6ZXXxfAorFjVktwryqf4Yhbpsdt/KLrfkyRcwZuRPrSq89hzIdPz4Yj405GkkbYnkshIb/hfCTZC0vlis43Rv/x1bVsHA1rJ9+BKqiQP4DAlv5CkwituA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwtLQ8U1V66qb0Qr8N7q6xJ2Bav+YKCH5FLnCEmRpB0=;
 b=jhtRGT5Tg4+H+wGYJ+enEFYmAPjyfaaNKoOTeFccLV23Y9EqTtcRrAX0U2HzSOD5y3X1FmXYBulW0cQ+zzOG1X1wT9L3uSi5PqOzI5N3iEmWoLQK6qMUIyzA0TNt5Ujub6I1ERg6+mRtf5eFQddhUFpzz3wPSl8yQLGdHQqTzA6zd2UbGKfbkIzpIL/RAtlrJ09cAL3hdVX9KeTarYB6L22c5wXjOEBV8eaIbsPnFlh9GaAVhoBX6pgQgjfPyTg1G3rs/+CA/AHMKvj68LfO9Ud5+moFHxLejwpF/0KyIOeR2hkf0TKdMKHjpcSuX0XHQHttQzUW1oIWkJzA+VqpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwtLQ8U1V66qb0Qr8N7q6xJ2Bav+YKCH5FLnCEmRpB0=;
 b=eOeuJ4+lqYnLSFb24CIhpfiOZqTF3u/FBevU1Pm8ZCp/S3kdUaZLaaTlQiQP5VgiDuN3L0SxBdrFEozIYYmxCVEIb16rkxVIarct9k11UamRU3DT3avavEpCjp+hyrZzvMCbS67jjYJRdbn5XN8fyMiShaUN+7VevIh3WDCO+VbY5EqlVeYp0hOfKvJBKewjVVuvfuKKO+AoZz6NFAuOWOTkUC0x3qHwxDH8VRF+QDzIUQ82zMmdHfiQc76t/25ad8NSfknbuW5qjnqy3/G0qLDow1XBNo9DQs0vybBBJXuKqgc20vdeEr/fURKVxKisskAjWByMPutcwfP2Fq5DLw==
Received: from DU2PR04CA0154.eurprd04.prod.outlook.com (2603:10a6:10:2b0::9)
 by DU4PR10MB9589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:628::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 08:15:37 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::33) by DU2PR04CA0154.outlook.office365.com
 (2603:10a6:10:2b0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 08:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 08:15:37 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 09:18:13 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 09:15:36 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v2 0/3] Skip subrange map tests on DWC iATU allocation
 failure
Date: Mon, 23 Mar 2026 09:15:22 +0100
Message-ID: <20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJr2wGkC/5WNWwrCMBBFt1Ly7ZQ8amn9ch9SJI0TO4hNyMSil
 O7d2B34eS6Xc1bBmAhZnKpVJFyIKcwF9KESbrLzHYFuhYWWupVGdcAPijDadOXXmPZDRs4M5AH
 nwNGB062XRpoOey2KJyb09N4bl6HwRJxD+uzJRf3Wf+yLAgle2aY/mgZHtGcfmGvOtQtPMWzb9
 gWn/I5d1AAAAA==
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|DU4PR10MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: d35a6da4-02c3-4828-1f43-08de88b45d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZCwIadbWnmKBgUKZoTr0lgjg5xVwm38Vh2tCL2tN5vhHF4calXLN6oAjsJFL4ZDBLooRfMm3QXDf4afwzLpxgaAfel8tWV3FNGfkh7KLOydKKb/zHkfsNfwkSLp7+xx7lSX8GAN1tUfsfH6ctGFA6YevtFn0iNXPnH4NJ+LU527bKrvHG8HnIhOowfde/wAgW9vr8/nPLcorUioBtE6mbNtl7fGKSK6JNu7gPjDp1TY9nRVE3BLrE3LAcXOkhBn2yod5PUF4KtNUXDLP+/3cuFylEtn47KVyMNpNnWV+82fhV5KcJR3FLIgnvHaSi6BLajjsCl7xEZ8kjEI+i1LV0lCKwyZrRe3U+qD88xZX4zZ9jAolAfCl757isaprog+xxPoB4M7BQEt10QC8/qC5UNKdKr7NJ/fo+3HbPpnEAiuioN0Cgs50r0FyPxswG0gOzJ4VMus7vwgRMaI8DdW1zAZXBaJOgNp6wYZqH81f+ebBIttiD1o+qHtxuMtPuJi9Y5UV7Hxij+ypx4AgqFN3TVjdz/Pn5xJNf+sq7szmpPC+n6WD3AtAxRyXjkRTdWvOHjJi4cQxIlBSdeLel5jwIqUjflp4FjqGS53BGUEzKO1g9timPuzs8IoZprI7nyS+ShjlxEZJ2WUZVnKaLPn0hhyx1IShaJxMu9UV8VhnvmHYqxaHxglM1Sum2rOlb0XVKk98rV8dE2lBrr0uEKgdg46j7lhsSl0t93f7yjsXh4RAPEQirwNY2s6mN4ZiAs8arpSdJ1OXyxFY7ftIO8ufFQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j570Yde8A3JYCmqTJ/aAsAAOfMoy5PdRs8Vv5J3MHvCP8a1l5eiZ9ukGdKFLJRj+YnxJ6uenTaI2wr34dHnwhY5PcR/tM5C6KOloQ7gkmUiIb/kB4g/0hrJiBs6GMC7flaMoaX07waksN3nGHPLss3uFhvneGruzKOg02glHDBTxaW7aIOS2yR8JNxGfNMKsjiOVfnrnKc4jiuyPrgB2dwUOkoKWmU0M0jrM3te+60yDJ8U1GalJlijbWQazbe0h3nvSpBwAVIAzqOFCe+QP2ZyAt4LTfsfkYPGDnffgMm+/gCGU4JzK7oj3VzP0OJQe1pHWDEyRnd09056BtRh/6kHCPoMD3n1hqGL2Xe8yEuO9Vc5cQc1oyikHAiD8adxNHQYhGgfwmxjhR9qTzextCcfbs1PKqooLpFrwOlTi1+GqvsfhFFKQIg0NbsdfTlcp
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:15:37.3106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35a6da4-02c3-4828-1f43-08de88b45d4f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9589

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

