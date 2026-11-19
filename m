Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120228;
	b=ouwxehJPmVT9nQhbHCMw7olu+wLYOliyClVKCRSIQ/JFwnhjN7lu8dhd2dfZbVHitVgF
	 EmvDyhbkb9Y0FP8QQT7vOaFt63IdXqmO/9YQAccbb6Q7W1cJYX33k6ut9rN+UEb3B0Tbn
	 O2z6rsDgY5eXFWE/7KzkaeHQUZkA8cewTXf1yGjJl+W+29FZET9MmZ1FIa2Ai/Gv+AUfd
	 AI5yNbQJZQkpqE6EOLfShxH9fcneise7baARGS4MCqIoLBlNh0Hj+Ko4dpvSCPoIWqphu
	 Aw0Q88/9j01ymeJOu8aK8ouWIBU8ecshjLstyJEUX3DY6j4hCUgd9Kd31XXR/qLTCIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120228;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zD6Qoso89AlPqvO14EaCb+JPFPT79KS7IjukfS96IsU=;
	b=bGMwLry5HIq9rSryQPfP2hM6n4M5Oq/tmHV0aMShxVtZxQz4YPLoky4m2gUK/Y929i5z
	 9tm5BwbTeeIvnmXjq+EFg1H9FdkiFTtc1K3iorPkoDQK4voJHjyetPnlC6PmC4R7JANvL
	 qFvO8zfX5Zr7QEeeLVM5/QgNcN9e+lmRnGw+G/7Kqdrs+6CSXF7WxFSxTcvY1mMREAgn6
	 GOxqdn5gzKy+iAuKVVxeX6N+naClcCQAbKJYDNoNLv97xvauBYxpYN3fwQVtx2W40Re7j
	 OZPudN3ftdKxTkPl/jmwENL5zDwte86V3TW9BssAZ4UsdqVC4HFBrirp9yOilhVjxSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xuPhWKq8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.7
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B078606A320;
	Thu, 19 Nov 2026 20:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B078606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xuPhWKq8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhW1LNq9sVVRtMVCnaOveQNA8YfUyy7V4AoJszMc56NT915aVMewNiN+dcVeedYJ+5WKI+B7dzL5RwwvqOyS6nViMBR8Quesatu85j+MS6YioQIcnasMSvhydaOqRiY7jxaeV/N5xtXRQjjDXYGP1vnrjS9qWdwF7vs03W1/ghls++dahKtksuLq1Pn+KPBavcWwd8SxiFyixtCyKM86XnlCoKRY3f7j5XwW0NrW7fYa7eWP2ImcroFi6WvelKT269uFr6jCfLqur9XUeyQVjZ76VIouxE/VlV5piARBfcMozjYNJjngfgm4m14iPl9VhseM1WbtbvP1WVZyLK0jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zD6Qoso89AlPqvO14EaCb+JPFPT79KS7IjukfS96IsU=;
 b=LXEFS+WhIFLSB3zHxNUgxjl7tFLwTRRxCct0yimi6yfjrxpDDn9phQTPFbec/oyalKh1fGUaM3YAr+P8LvPzoQjjG9jiU04oS+uEVtImx/Ii3K2wXg+WHrpRlxRkCVC6eIMc3XO3fUdRDi0x9huYzY1dhOaqslIPXP+LOpZ5auH/0rIh5aI3PCI44Ft06vCMqNfZ5B01oPg0HBD1j+h2QdWpkVDLxDM5XushQ4YyTavWiUAN6ztE2/TdOBsU6OLypR7Atmo6LukhM2PVr9SnLPdrWPVyxboDG+9fbZoeXbGwgC1+ckWFaPceZxWdvvTGUOqwdjsAGSTE963oofKO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zD6Qoso89AlPqvO14EaCb+JPFPT79KS7IjukfS96IsU=;
 b=xuPhWKq87Sk50OGy5/xr6VzOuRvJK0agLVNFatH407YH02QaDVyU2q7SxrYa4bdxSxBhfp/BVQJAwVqJUZvbdah87IZivjZnLLtKikR2hN8Vm6nldTGgowGbPAxjsEG1WtcZO10eUNF/C5FdjZof+011QuXCDqmMiFngv0dQcDQ=
Received: from CY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:930:17::6)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:30:24 +0000
Received: from CY5PEPF00000E88.namprd05.prod.outlook.com
 (2603:10b6:930:17:cafe::82) by CY5PR17CA0001.outlook.office365.com
 (2603:10b6:930:17::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:30:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E88.mail.protection.outlook.com (10.167.247.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:30:24 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:30:23 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 33/44] dmaengine: sdxi: amd: register QoS vendor handler
Date: Thu, 19 Nov 2026 14:23:09 -0600
Message-ID: <20261119202321.1734355-34-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E88:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: d291c21a-d3bc-4dfc-9d7a-08df467bf0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|7416014|18002099003|22082099003|3023799007|261009223027099003|11063799006|5023799004|56012099006|261021123027099003|261102123227099003|261021121427099003|261022075727099003|261102130727099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	m+KAKSIDC5OvcqA6f9qwGHY2FmLRZJLQNqqqT/i24xploAHp+A4g4ZNaBQ2k6o5jmWWubJk6CZN6jb8kcytZRtV4hnVQB7BYaMXSJZgsHAFM9SsiVXbvtPHXUeABdulXiLgoRt9GWv3QM8y1OQCu090JDSzLccChSX74bOc3Tkxl8sfRyDfWD/cRmxu90o2b/Hu8UYUFsTaXkzm9TyJwpTq1bEFdCPL8hEPokpmbRF52u5vteVgCLhqkHIkrzorXpTu5zzTTc+Z9zfBL6b4Ai9bZS8oEGNkvnbzqna/kmxkmMYK4Yyep3iyqmb6IhjZnWjdePC85m5v/+ci1dS/iYkoHChkLzA++G8w1kTpePlT9CiJoNfUIfAhT/NRkH5cClnEhCxOPJOwwmMkahqtGPZFVLtyv1ctT+VUHHYFlLG1PCAAscZQDbRv2THQ5B5OgtpgKoEXRHA6sY4Q4TYWMH11TJlMh0xjFxYTU4baNwrsBztLkmOqFNV9VZ6Tqh0pdG4k50mzzx6JauGQ90z9fB8LBMl3eY9nNWdhb0zNZ8kU6Wl+QRt+kM1f4OkZugrQqNXxmNH5qZqEUJkLVIZln4fCSV6OEuDUmCZkMOl7veGFfTNk1CQE1QkqQnYkDYmucbtjYJt8ldPxekPHKMXbSAMI66xOqXdSxjcbn2DfatDPDQVbYur2n7Pgb5mq6SNd8ACyXJ6hV2aq6j1AEpAYHNw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(3023799007)(261009223027099003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261102123227099003)(261021121427099003)(261022075727099003)(261102130727099003)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dsPuFIab2oFxjCojwioRJkVCrJxTgZpinQZCOcCACBNswHv0+xtZpjgHcnA7SvIDbRxLb2IWFanY1Kn9rDgrBtk8Q5rhudtCzgcHI1ILiG+TVTidl1EgJyozHk1A+NlwCRLKqR23k5c5Zz3wZKtKB4XjTz9U8h3AKDCqkc6H3v8Z34p1lK9BkQn44w/nWOdw798WykiOO4Z5xXmFVV3Kt8boDDpdxyjwIH7YGRTaeTEYi0MckYXjt7hWiZEZ3ZNve9v+IQF3aRoymKLQ4wZOQ0LwHbZnemdV3Lvi+7rhwj6DHGWs6wFg0Jc7SVUvdnNyGaFA25n+D+gPgWF2y8XENwKq0krHNDESLQCK6SsF7igJ0dbw48JPPs5QuTxhRu1KWenHdP9rgV4zjVPoa4RtK/Ndyz/DjUbT7wjuW0Y42ZUTrr0Vu6YNLuajAmFQMTaE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:30:24.2549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d291c21a-d3bc-4dfc-9d7a-08df467bf0b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E88.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366

Register the AMD QoS GUID with the SDXI vendor framework and add the
Kconfig and module build glue for the handler.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Kconfig      | 11 +++++++
 drivers/dma/sdxi/Makefile     |  2 ++
 drivers/dma/sdxi/amd/Makefile |  4 +++
 drivers/dma/sdxi/amd/qos.c    | 58 ++++++++++++++++++++++++++++++++---
 4 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 drivers/dma/sdxi/amd/Makefile

diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index 9b8416304ee2..ec89d976c3d3 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -41,3 +41,14 @@ config SDXI_KUNIT_TEST
 	  SDXI hardware.
 
 	  If unsure, say N.
+
+config SDXI_AMD_QOS
+	tristate "AMD SDXI QoS vendor control"
+	depends on SDXI_CORE
+	help
+	  Enable AMD SDXI Quality-of-Service vendor-command handling
+	  through SDXI_ADMIN_VENDOR. This registers the AMD QoS GUID
+	  with the SDXI core and lets the kernel compose the QoS
+	  descriptors on the admin context on behalf of userspace.
+
+	  If built as a module, this will be called sdxi-amd-qos.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 34f62b7366eb..d808492c60f1 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -20,6 +20,8 @@ sdxi-core-y := \
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
 sdxi-pci-y := pci.o
 
+obj-y += amd/
+
 obj-$(CONFIG_SDXI_KUNIT_TEST) += \
 	completion_kunit.o    \
 	descriptor_kunit.o    \
diff --git a/drivers/dma/sdxi/amd/Makefile b/drivers/dma/sdxi/amd/Makefile
new file mode 100644
index 000000000000..5aee7e8a2414
--- /dev/null
+++ b/drivers/dma/sdxi/amd/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SDXI_AMD_QOS) += sdxi-amd-qos.o
+sdxi-amd-qos-objs := qos.o
diff --git a/drivers/dma/sdxi/amd/qos.c b/drivers/dma/sdxi/amd/qos.c
index 7d5dc9b6b32c..be5a03c00327 100644
--- a/drivers/dma/sdxi/amd/qos.c
+++ b/drivers/dma/sdxi/amd/qos.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/capability.h>
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <kunit/visibility.h>
@@ -133,9 +134,10 @@ sdxi_amd_qos_prepare_output(struct sdxi_admin_vendor_args *args,
 
 static int sdxi_amd_qos_admin_ready(const struct sdxi_cxt *adm)
 {
-	if (!adm || !adm->sq || !adm->ring_state || !adm->sq->cxt_sts)
+	if (!adm || !adm->sq || !adm->ring_state)
 		return -ENODEV;
-	if (sdxi_cxt_sts_state(adm->sq->cxt_sts) != CXTV_RUN)
+	if (FIELD_GET(SDXI_CXT_STS_STATE,
+		      READ_ONCE(adm->sq->cxt_sts.state)) != CXTV_RUN)
 		return -EIO;
 
 	return 0;
@@ -310,6 +312,8 @@ static u16 sdxi_amd_qos_max_vfs(struct sdxi_dev *sdxi)
 
 	if (!sdxi || sdxi_fn_reports_vf(sdxi))
 		return 0;
+	if (!dev_is_pci(sdxi_to_dev(sdxi)))
+		return 0;
 
 	pdev = to_pci_dev(sdxi_to_dev(sdxi));
 	totalvfs = pci_sriov_get_totalvfs(pdev);
@@ -705,7 +709,7 @@ static int sdxi_amd_qos_prevalidate_fnupd(struct sdxi_dev *sdxi,
 
 	err = sdxi_amd_qos_validate_fnupd_req(req, cap->max_pools,
 					      sdxi_amd_qos_max_vfs(sdxi),
-					      sdxi->max_cxts,
+					      (u32)sdxi->max_cxtid + 1,
 					      cap->feature_flags);
 	if (err)
 		return err;
@@ -742,7 +746,7 @@ static int sdxi_amd_qos_prevalidate_tel(struct sdxi_dev *sdxi,
 
 	err = sdxi_amd_qos_validate_tel_req(req, cap->max_pools,
 					    sdxi_amd_qos_max_vfs(sdxi),
-					    sdxi->max_cxts,
+					    (u32)sdxi->max_cxtid + 1,
 					    cap->feature_flags);
 	if (err)
 		return err;
@@ -1083,3 +1087,49 @@ static int sdxi_amd_qos_exec(struct sdxi_dev *sdxi, u16 opcode_type,
 	dma_free_coherent(sdxi_to_dev(sdxi), dma_size, buf, buf_dma);
 	return err;
 }
+
+static int sdxi_amd_qos_authorize(struct sdxi_dev *sdxi,
+				  const struct sdxi_admin_vendor_args *args)
+{
+	(void)args;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* ASQOSE is PF admin-context only, including vendor PROBE. */
+	if (sdxi_fn_reports_vf(sdxi))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static const struct sdxi_vendor_handler_ops sdxi_amd_qos_ops = {
+	.authorize = sdxi_amd_qos_authorize,
+	.exec = sdxi_amd_qos_exec,
+};
+
+static struct sdxi_vendor_handler sdxi_amd_qos_handler = {
+	.name = "sdxi-amd-qos",
+	.guid = sdxi_amd_guid_qos,
+	.owner = THIS_MODULE,
+	.ops = &sdxi_amd_qos_ops,
+};
+
+static int __init sdxi_amd_qos_init(void)
+{
+	return sdxi_vendor_register(&sdxi_amd_qos_handler);
+}
+
+static void __exit sdxi_amd_qos_exit(void)
+{
+	sdxi_vendor_unregister(&sdxi_amd_qos_handler);
+}
+
+module_init(sdxi_amd_qos_init);
+module_exit(sdxi_amd_qos_exit);
+
+MODULE_AUTHOR("Wei Huang <wei.huang2@amd.com>");
+MODULE_DESCRIPTION("AMD SDXI QoS extension support");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("SDXI");
+MODULE_SOFTDEP("pre: sdxi-core");
-- 
2.56.1

