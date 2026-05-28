Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050537E307;
	Thu, 28 May 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957137; cv=fail; b=kkvQXPoAy4OEXGtnNp9lXBR/BAA2eztK5dRMpg/4ktJnynF66e2NCDrSQXR+wiBhdJ0oAaX8DKVk31uMxvntcaCTywO628Vpj433GweY89TTiHWx80+lHzTwxPJ8nTEptD/cYT2LKNytc6fqF6PcPTyWTFbbqvxV5xHG+BfWmpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957137; c=relaxed/simple;
	bh=sG5JenU3eBtjxIo7xcLFwqz77ntjv6FQ0bh8RoQcIws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxITJQYF67N4v8zCYp3A0EJVumTon59TeLQAHdkH7gC+Ru5MLESI4dKJiG3+mmYkVCZKdKsF0Gt8IPHTphkNJhJE+kkEtsi2WOywI4xgfUy5IhEp6HqQ8ZqNYCAkAl+dMzgmErv53WMRqoG0SC556XRLLOuLMNxN+Re5v0IvjjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J8b18ecP; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J8b18ecP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E91BJcGvhIrENathA1qFckY8FuOIdmOQJcd3bkQv0GrzRam3XKIqo3cH1z/pgx6FBL+Nb9SnPRihPKHT/lMWw7Z1SchpgcLWF1paDnPY5jnB2Fti58sapUdxUz2mTYjMHMDpnk3qu3+QwhIwmJ1nUXmjYdIAwD9y5+oWQTYbri3a6Fm8jUZP3pcfCc62kIXlvKnIEEJYAkDH/GAqxPzYI8A9vB+Ol4NvrNJDHr7eWWEjmvZeuf6FUump9DvjzhQUwBDyogOutsMRKmhDNWGFRcWCstkMrIjjitohPZLVJJIa/Z7hpX2ja4pnnY5eych3ksMwBjyYSl2ZjV8F7HpYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmYCLcC4yheEDmWm1ZTdlO/W/LFEOhUd+NVj5LxevqE=;
 b=a1eEhlCKyN775dMgCaCycUKuD0u2upEhMNSowWWoEoa51wXwfSWoxIrcxwcJHUzuWETvO6M6OpLpP9IS80v6YM6m1AtiH6Cxn1TcdFSJTiDKlCYzyNsvyRS4VicWMmDTHtVMzaRaRXkXFbWTLzaeMcFokLEKCWysFby71v/xjl2WTazrxUMBExmaJ9TanyOeUcx7suaxYJHz3/vLgRe2JWz5XUd5TmGQ4ChlUtdw53gdAzQACaJbp710ofWiq/zKYEG/spq4wtrj7ht5vYn/fcYwGoSP+x2jodGOUUvIjGXw4M2kqn0PqUodH8HvQJwBiuMgxRIeF8UmhIjFDq7AUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmYCLcC4yheEDmWm1ZTdlO/W/LFEOhUd+NVj5LxevqE=;
 b=J8b18ecPlWrLKg5n9wmsxJPUL/AA9L5oJOnB4Pyvx4PRnK5AUlWkBWJHXpA4/w7b8fRBweY7kyxrW+WJwV7WC1c8qTYdUWU7/S3jcdJ20c73ZR5GizviULxZazAxk/y5qCPFBKSbtzdpjHAlzs7IeDX4Eu3kILNWapXzBEJIr5uesJfHzCd4sM80n5TZdbrv9o6tyz9mA4J/vL4m117H7qjgRCcKRLZZqRaN7Sio0NmtZwSVYnL95Ti/7k6c+Ly++hCmYphGpqO9tZg/Q2tjvsh8HWJa1krtTnNuShEBV8UWdZejImDa143LHoH3aoIdh06NbqRkGv6q4aTzRx8sWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:32:10 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:10 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v6 5/9] cxl/pci: Add CXL DVSEC reset helper
Date: Thu, 28 May 2026 08:31:50 +0000
Message-ID: <20260528083154.137979-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8615ed-f605-436f-f07f-08debc939c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|5023799004|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VC1HfAY0xTcS/GOIsXhT99nKXVCBCZsTx73P3J807KnwrDzlE3Wg30XXLczDXx6NDdx89/yQuCuS/8u75CTHrKv4fKaD+kubletrTkSnLm4VqEbqk4uJq37cmJVJ+BYkCH9fmu8CIsn1wF6G0+SjIREz0h88jwMo0vok4loNSIy3Tc6Tc9p2y4kSCO4lXz2voaAlUbvisnZiUXg2HvvU7rMk8NFREEE5vxCb4LGG+BJjH2cuhNiDo9qmv/N47jusDfHLZjF/f3GetPGkELoYxfOT1s6D3sWMZ7BuFzkNCrkQarN4/2PmktZZAi6gmZPuboxNvNrG3ulBRiXvESHsNFbA5D0PhiE770T2akyuL773b1AYS/1eII5VzW+7iYSenmaO6c28Mpnx0I19Tqh0v7XKN2cid2uO1ceC3PRSeCOblx81jKe1wMqxQP52ypCJFWpCW2seHzYad0VdFCleUz+O1UC/SnwJG6pPsDPMJP/rLI4WO1lr8lW7o/W5pVrX6+ioHZfIHpgyAxzQGJoJE4pf72syu6CFuWHmxzl//LHom4Hw8VSUF5GO/WwsoFFD7eNK41cn/SESnGFNkiGrjxUYpXT9F9/MFlrxwwo6vE7Br20wOwOG6cgE0gJ5yy1rtL0o60Jyg6caLkKCNpBJQ6JPJEEf+tltqROCXaIMpdm5EDt0hiKP5iMNnsTO+3nu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nwMXp3WdhPa/XVbyxy0zq22+Xofhd1qhJVdGnT4p9pR02chL33jvKxfOUXEH?=
 =?us-ascii?Q?iP1GeeVOZqWT5uRr1nNeCmd/rruIe8mbXVEztEk+tMxARSP8KAeX10//bWAO?=
 =?us-ascii?Q?GBuq9NbcmiPGpfDHgrWctBE+LKzN/6kojJAqtSFuHwzgybIL480Po1ocTjvQ?=
 =?us-ascii?Q?uptVrP2wOf/Hl9uNgHeEcnGnyhW21Gv/aObS4Q0fDApgCEnZiiqw5Ptb3JtR?=
 =?us-ascii?Q?L05zd+7SwuWPznZGMoR6xWtQ1gszuA1HmIoCe3zqcneSKDcqcx8viB2AFBkQ?=
 =?us-ascii?Q?7ZKsSMDNJBGp4OUb8TXMorFRiF9oyi0fispfMzQLE8oo/vtkVWTmAtK+z4Qo?=
 =?us-ascii?Q?WIEyRYRsbDcNHgSPWA96Ah5CYFogJbER/L8x7bejzgFnmfzz4hAQGm12Zrej?=
 =?us-ascii?Q?bs2vrEmAocvfxg+bWKwG19gnmAmYP+C7zDgoH5k2WIrB2FjM//f8Gm72Nsq6?=
 =?us-ascii?Q?2jlKNNQEUOhAsdMKIQ7jpejhkEBS0w/AZ/d87N2P+F/OEnvNaOQkMugvXthK?=
 =?us-ascii?Q?RgetqJADGzXxmYGeKNHhVWH9JAk31oZY1H0kcpH0XDlxxcuZYYUhmTgp3s79?=
 =?us-ascii?Q?QHZYOTSqylhvStcYt/c48pz6O1Sui7IdoYu86dgFKUg4r8LsqjxLa7fEzU8y?=
 =?us-ascii?Q?e3OHrwd1VoQdGoRf7cn+PnW8HwF/o1f4YxMxR1RwCIxg5x4Xslw0G2TD7EaP?=
 =?us-ascii?Q?81+++1bzU9C5S4BILr6uwQZrqH6dQ3cjufOFcSISH2nZuTcvp/lvzuOaKGcB?=
 =?us-ascii?Q?ZJaAio5RXqxHOg3e0v2UuutxtWWZs7qiNQ5gnw4aj3nQPFsD2NHvPW4kAZ6c?=
 =?us-ascii?Q?k8L2Ry6eNT5EEPtkQUwWtg2LU4Ude8uNJD3dJJuM5oZD4/yX0qBJaRh3ap2g?=
 =?us-ascii?Q?Tck37Z2XzkdIsDQ/apAz+a+f2C5Z0ydinmEPCnXzpDOSHsuL1oZ+m688ITx+?=
 =?us-ascii?Q?U9WW8JNxVsGE+aMMcU2CX6kwQ4d5uj5AwUQaEjS7eUCXW5sGATWKwVB3ecXZ?=
 =?us-ascii?Q?qGLykpYEfBIyM8/6GM/gf8OKQ//XjKRs0Fu8ciAeAw35c+szgH4fBvwj5taQ?=
 =?us-ascii?Q?wp0T+5DSxQZ3+CQeCn2zRq0NoUEQUEYDTVsNMdcKQbE2MaG3GGJkMHhjNkkg?=
 =?us-ascii?Q?Pi5wm1HPEzihYIFIAhso5gGvxZOM79lCT6CKt7xncM2Bc+ZpYYoUiwjJT7N8?=
 =?us-ascii?Q?VgiQPBNwZq6BeGEL0+B4t9JxtqCfHNILTuKv0vHLK4Z0rIKOS1hEySYJuFnO?=
 =?us-ascii?Q?lJe8zgunA6mpseaVTFRqefHnBSoVYyrWwZanjOSXYZ4aUJkPBjnPlyH1LyDu?=
 =?us-ascii?Q?lK/fYMxTPYLm/dZqfuxfxoKi+9UtzT88fIPcAeIWBGcWRcjuQk6Et3Mtqrgu?=
 =?us-ascii?Q?1DvECBope+5POe6ZOkGh5Ma5NBgnAhnXCOtsWJElgEThJePM1nPc+VhzkJA5?=
 =?us-ascii?Q?fEwGiRUWoL5N5ZTQOShaHQA+3BMgPVLV+Ec1NDqRZADWMxqEZEb1aeSMYlq2?=
 =?us-ascii?Q?D4WVyDVgEOp0UWysAd3nO69PyPo8UWAzMN2GbyLdJRMULC7vg2URvXtGrapg?=
 =?us-ascii?Q?hdaewWF/B5+IYZLIM7EgK9HGSiWfYtJ9qrESrqFij4WqDbaOA0YUtkneuy6V?=
 =?us-ascii?Q?WOwBxDmtYQbSiAwwCHBsxzRBbeb3sJZPBh4EtTxyVQQkRZTdwsI1aGRQSOpf?=
 =?us-ascii?Q?QWZMAzSAdQRXT+X20b+fE/nbQD/TdtvdauXvIUv7FKRJK+i9ntzY80bjpGTo?=
 =?us-ascii?Q?g0wxFdyhWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8615ed-f605-436f-f07f-08debc939c75
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:10.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QUz2hKHRX+cHsBDD1yLBS6/uXW53rIVxxabi4AOw6P1sVMjq0hUpJ1Z4skARVI/XLCB1gC8I008wKhz9nn++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Add a helper to execute CXL Reset through the CXL Device DVSEC. The
helper verifies reset capability, waits for pending PCIe transactions,
disables CXL.cache, optionally initiates cache writeback and invalidation,
and then starts CXL Reset through the DVSEC Control2 register.

Block IOMMU traffic while reset is active, then restore IOMMU
translations after reset completes.

Wait for the DVSEC reset timeout before checking reset completion, and
report reset error or timeout status from the DVSEC Status2 register. Add
the CXL Device DVSEC reset and cache control definitions needed by the
helper.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c        | 185 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  13 +++
 2 files changed, 198 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 01effbb4e7cd..1dd880f5a333 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -20,6 +20,9 @@
 #define CXL_RESET_MAX_FUNCTIONS		256
 #define CXL_RESET_FUNCTION_MAP_REGS	(CXL_RESET_MAX_FUNCTIONS / 32)
 #define CXL_RESET_SIBLINGS_INIT		8
+#define CXL_RESET_CACHE_WBI_POLL_US	100
+#define CXL_RESET_CACHE_WBI_TIMEOUT_US	(100 * USEC_PER_MSEC)
+#define CXL_RESET_MIN_QUIET_MS		100
 
 /**
  * DOC: cxl core pci
@@ -1303,3 +1306,185 @@ cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
 	cxl_pci_functions_reset_done(ctx);
 	return rc;
 }
+
+static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
+				  u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 &= ~clear;
+	ctrl2 |= set;
+
+	return pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+}
+
+static int cxl_reset_wait_cache_inv(struct pci_dev *pdev, int dvsec)
+{
+	int remaining_us = CXL_RESET_CACHE_WBI_TIMEOUT_US;
+	u16 status2;
+	int rc;
+
+	do {
+		usleep_range(CXL_RESET_CACHE_WBI_POLL_US,
+			     CXL_RESET_CACHE_WBI_POLL_US + 1);
+		remaining_us -= CXL_RESET_CACHE_WBI_POLL_US;
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return rc;
+
+		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+			return 0;
+	} while (remaining_us > 0);
+
+	pci_err(pdev, "CXL cache WB+I timed out\n");
+	return -ETIMEDOUT;
+}
+
+static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE))
+		return 0;
+
+	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
+				      PCI_DVSEC_CXL_DISABLE_CACHING);
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE))
+		return 0;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc)
+		return rc;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return 0;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		goto err_enable_cache;
+
+	rc = cxl_reset_wait_cache_inv(pdev, dvsec);
+	if (rc)
+		goto err_enable_cache;
+
+	return 0;
+
+err_enable_cache:
+	/*
+	 * Best effort rollback: preserve the original WB+I failure even if
+	 * re-enabling CXL.cache also fails.
+	 */
+	cxl_reset_enable_cache(pdev, dvsec, cap);
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	static const u32 reset_timeout_ms[] = { 10, 100, 1000, 10000, 100000 };
+	u32 timeout_ms;
+	u16 status2;
+	int rc, idx;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(reset_timeout_ms))
+		idx = ARRAY_SIZE(reset_timeout_ms) - 1;
+	timeout_ms = reset_timeout_ms[idx];
+
+	msleep(max_t(u32, timeout_ms, CXL_RESET_MIN_QUIET_MS));
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+				  &status2);
+	if (rc)
+		return rc;
+
+	if (status2 & PCI_DVSEC_CXL_RST_ERR) {
+		pci_err(pdev, "CXL reset error\n");
+		return -EIO;
+	}
+
+	if (!(status2 & PCI_DVSEC_CXL_RST_DONE)) {
+		pci_err(pdev, "CXL reset timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
+{
+	int dvsec, rc;
+	u16 ctrl2_clear = 0;
+	u16 cap;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENODEV;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return rc;
+
+	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
+		return -EOPNOTSUPP;
+
+	if (mem_clear && !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
+		return -EOPNOTSUPP;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to block IOMMU for CXL reset: %d\n",
+			rc);
+		return rc;
+	}
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (rc)
+		goto out_iommu;
+	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE)
+		ctrl2_clear |= PCI_DVSEC_CXL_DISABLE_CACHING;
+
+	if (mem_clear) {
+		rc = cxl_reset_update_ctrl2(pdev, dvsec,
+					    PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
+		if (rc)
+			goto out_ctrl2;
+		ctrl2_clear |= PCI_DVSEC_CXL_RST_MEM_CLR_EN;
+	}
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_INIT_CXL_RST, 0);
+	if (rc)
+		goto out_ctrl2;
+
+	rc = cxl_reset_wait_done(pdev, dvsec, cap);
+	if (rc)
+		goto out_iommu;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec, 0,
+				    PCI_DVSEC_CXL_DISABLE_CACHING);
+
+out_ctrl2:
+	if (rc && ctrl2_clear)
+		cxl_reset_update_ctrl2(pdev, dvsec, 0, ctrl2_clear);
+
+out_iommu:
+	pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index fa1fcd26af01..7fc1d34fcce7 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,8 +1352,21 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0

