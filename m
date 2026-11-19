Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120118;
	b=ymR1vHu4p+NvtHL8iZali8+JfXZaw08GvTqDDVQGa0PuFnpDM/lyaXwgZEzcywG2fR4M
	 dQL4zdcJO3zsPy97hs8bCKsq6kNQOmgQJk3+i6g4/zveJje+diC7bPfY6mbM8su07V6GW
	 tnyO1I5hizSmE34XaD/+EA/MhQVzpb3QpP+AJ+42+Cxluy4T/7x7cixWwN2y0nEL9ojvp
	 FtuFsziCv8oyIU5GRhVE6mYgc5VmtziQa5ftoHMrazhrhwgL/5Ft5UsD35GSc+R4eeROZ
	 finMDIG5N18J8T7Ev2ahaJq7aGQ1kFs/iEYkBzMdaKrbHvEJ05t8es0bBlMdqpC+TXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120118;
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
	bh=S5JCaW1vaJulFhB5w1GdWAL+REOMEsjLhN25zguucL0=;
	b=kiHjx5aV1WRxxd8iyDLIZgjjryBEFZKCwBe3yw1XwjN1TjHeP4Xv8WoaCyk0m2qChGfm
	 geEF1O+8dIjP+PfR6UgNwBU/ZE/5mVHrifHNSUlzO+551fqgFrzTQg1tNiEXkNqORSuOZ
	 JiHkyCqPGIdJzQL6cb4EWl17QB7iZ+/aKBpP68Zssg/OnMm3PlNCTgCMl7ypri38Yh2f4
	 3hmek9PjeCaFvYYd6BEQb8PbuGrgDNJwmJGymoUhoXO4XDFF1NQypZEksq8mZbDtgtf+E
	 VPSo3PANlDwc03in7zHzRQ35fqtYO8VUQFcpRHOdYq5cHl7k3md5siJUgmBSdXQ8RZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mwbWvgWQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.42
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A8606A337;
	Thu, 19 Nov 2026 20:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 910A8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mwbWvgWQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXq9G+S/wFXA4HRHqQlp/XCtM6bl+U4gN5dF8d1uoDDUsiQGzFL7JL1BlJZSH7Ne4rSC/m01EM/h3VvzKVluU0zdGyhNhNAPI5JKvs4lMz3gKyNdRfmwaVtvV55x28edgK32Yb2kx7bULesDPyEZOfR/bEoLQb/xEno0JVU93iMRZhRFjiPcR/h0wVUoLJ47qPEBFBCN5Qj3ZavTjFyzVZHsnWyzMT3SkCVpF1RdlKwgA4q8ZeZGFTLKoUho5Nnr6OzeXBCh2PBxdRoM3NE9mJmjWkhvXlaOjgWaNlTzRHDVLSMjWEWi4xcHIjBwGfiqgspjYXpsXFglD/Tr4O06+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5JCaW1vaJulFhB5w1GdWAL+REOMEsjLhN25zguucL0=;
 b=YwGZx/un90EqHtZuOVxfbotvgzdwoLqH4cEWtvIuINTkDcfWxPBTrMUhGJFZsFY0+kWdTi/3+7zyAgW2vtaJ+cG0XPyQSy9NHECULWE7Bk0f83BAQqwqbP+4yi8LWnMzPEqFxEgDEPLWSSpHvBeXH2RavqpxLKjuAPQ43jd0mxz+3u+PA4ywVGSotO8yIDwRcC+PekeWQ1Ev/McrI5T88IefaLtY8a31UxurD/iw0xLEsCvY9bLO7LDrXh88dzk68PEJbxhDw2o7/N8dJ5nbM/7e8nXhNdCPpGaH8QjjqRyMxGHxorFIlakMV6jnSA1mTWMtDeKCsp1kLBbp/5rh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5JCaW1vaJulFhB5w1GdWAL+REOMEsjLhN25zguucL0=;
 b=mwbWvgWQwK7A8vcPRE2D7EQpcH5wD1vNj3sCEMJ3ESsxUi2/9TkSsR5FGnFbeENZ67yvEpobEvX1k+dg0e35dJkW14NZrDhtd6DCBvPgp84M33R31Zzdi2MRLnRPGotC/Rd2yR4Yjj05/rx/2Wps20oF21cLdnpvRpWUhPRnyRU=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:28:25 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a3) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:28:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:28:25 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:28:24 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 23/44] dmaengine: sdxi: implement typed vendor admin transport
Date: Thu, 19 Nov 2026 14:22:59 -0600
Message-ID: <20261119202321.1734355-24-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: d82c4c03-da16-41a3-28df-08df467ba9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|22082099003|18002099003|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261026140227099003|261102123227099003|261026121527099003|261028144727099003|11063799006|5023799004|10067099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	OKnIMCUOR7scu+ljhvW8Ye/riUpCAX+YLmw5cg3FzDqkkPplWGDJC8m6ThtNAwLt18L2YBuKmu3ASdgl4hlSHVcdEUVTAp+3DXhaCFnGrSo+w4RgimfDrZC7bcpKLfg+1zM3LSfUWjtHYD52gdkbc9x5q45nO0hNR3CMbJ/pEuMCqwxwOSjnc/z7/0DtO4SvDKSENLKi5ii2yvwhM5TyY4d0u3a7Q/zS1odCp1Q/r5zMxCu6PGF03S5HDfxNhrG5mI8hTr9BVYxmxQIxyw1wT0uiXNkQUjO1bqny/5G+W52tLU4nZ3hfEumOqOQ8AlZwf6D8/eDpsSG1nahLYQkUWFfVZCFmFuOp4RYFimCNEyFku1vReUpUrVXmOo53UdvTVDSUx/uCsVo0apLgz5v6exXztpP/AHCGXY+7dDkShBh7o5kltJPJQGnAS5BSXdq/QYwTFZUWS3trnvvXe874XIzN64Eqh7l3QtqrtKLJDYmmnhsMqeaBtfQ1knJRJrWAjz1fmGmVyr5EtrRju5U7j/Doe/jhwsZ3yZe2TEKrEYA5HACnvmmGiHxK/3QVNIGQb8acTqPzWlL03SwpSLES5uC8QAxNHjB41XjON7YeQYderGO5i6GyWFiXCAjRIRMP8GoGOfsj4vxkrW5LhkYEOn5zLwMYZb/bnK4t8GR/BCF02GtH+tbF4lwZG746QGBbMwtTNq201OIPIeflFpW4BA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(11063799006)(5023799004)(10067099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0tDgSfyYKSbsMc9kDx9h0RJjuXK5BFetYDiQEhonmE8vCA8W1bJX1pmMEYmbIQ2JP2VV+MfLfT4uj5HnERCbKp6JxrJ1z1QmC6bN77Q34ykbCApsTrGhhUyjRR0rH5aaRql+64aShKDRcDd4EgTMhLmmkIqOjwpiQ7naIU+bO0fy2uzcy4fa3CdbPyUd2KZ5b++i1/1JYzhIS1uwnh4ImyRQIZ73WDWKLOYgw5QUhsnLgbzMxZdYzt9RucPO4kXGBAsapmmZF5kFQ51DmX6hGwB/RinMcyVZOUU911kZcgTEUJQ3Nda10/o0XNVhFPB6sPNNQ4JP2egcc+nEUsLp5kBxeJOafUkFtnBulN1uQt3HIydTMkGwqcTIDHY8yjg8KBauszxmgpNXO0N8J/gPpdRuMFdrh8jyaSkOCY4uKDy7obrppd0PQfaSRn7J8Yq7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:28:25.3447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82c4c03-da16-41a3-28df-08df467ba9d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

SDXI allows vendors to define vendor-specific descriptors. Add a
module-pinned GUID handler registry and a typed vendor ioctl that never
accepts raw descriptors from userspace. It probes the vendor's opcode
through SDXI discovery, delegates authorization to the registered
handler, and keeps execution on the kernel-owned admin context.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Makefile |   3 +-
 drivers/dma/sdxi/ioctl.c  | 107 +++++++++++++++++++++++------
 drivers/dma/sdxi/vendor.c | 138 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/vendor.h |  42 ++++++++++++
 4 files changed, 270 insertions(+), 20 deletions(-)
 create mode 100644 drivers/dma/sdxi/vendor.c
 create mode 100644 drivers/dma/sdxi/vendor.h

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index a9eaf01df4aa..253398a45c74 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -12,7 +12,8 @@ sdxi-core-y := \
 	ioctl.o       \
 	keys.o        \
 	process.o     \
-	ring.o
+	ring.o        \
+	vendor.o
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
 sdxi-pci-y := pci.o
diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index 80648bed0e87..feef322a005e 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -36,6 +36,7 @@
 #include "mmio.h"
 #include "process.h"
 #include "sdxi.h"
+#include "vendor.h"
 
 #define SDXI_MAX_MINORS	256
 
@@ -75,12 +76,6 @@ static int sdxi_file_check_owner(const struct sdxi_process *process)
 	return 0;
 }
 
-static int sdxi_ioctl_unsupported(struct file *file, struct sdxi_file *sf,
-				  void *data)
-{
-	return -EOPNOTSUPP;
-}
-
 static int sdxi_ioctl_get_uapi_info(struct file *file, struct sdxi_file *sf,
 				    void *data)
 {
@@ -101,7 +96,8 @@ static int sdxi_ioctl_get_uapi_info(struct file *file, struct sdxi_file *sf,
 			SDXI_UAPI_CAP_CXT_CREATE |
 			SDXI_UAPI_CAP_CXT_EVENTFD |
 			SDXI_UAPI_CAP_AKEY_MGMT |
-			SDXI_UAPI_CAP_ADMIN_DISC,
+			SDXI_UAPI_CAP_ADMIN_DISC |
+			SDXI_UAPI_CAP_ADMIN_VENDOR,
 		},
 	};
 
@@ -721,6 +717,59 @@ static int sdxi_ioctl_admin_disc(struct file *file, struct sdxi_file *sf,
 	return ret;
 }
 
+static bool
+sdxi_admin_vendor_reserved_zero(const struct sdxi_admin_vendor_args *args)
+{
+	return !args->flags && !args->rsvd0 && !args->rsvd1 &&
+	       sdxi_u32_array_zero(args->rsvd2, ARRAY_SIZE(args->rsvd2));
+}
+
+static unsigned int sdxi_admin_timeout(u32 timeout_ms)
+{
+	return clamp_val(timeout_ms ?: 5000U, 1U, 60000U);
+}
+
+static int sdxi_ioctl_admin_vendor(struct file *file, struct sdxi_file *sf,
+				   void *data)
+{
+	struct sdxi_admin_vendor_args *args = data;
+	const struct sdxi_vendor_handler *handler;
+	struct sdxi_dev *sdxi = sf->process->sdxi;
+	unsigned int timeout_ms;
+	u16 opcode_type;
+	int ret;
+
+	if (args->argsz < sizeof(*args) ||
+	    !sdxi_admin_vendor_reserved_zero(args))
+		return -EINVAL;
+
+	args->argsz = sizeof(*args);
+	args->cst_flags = 0;
+	timeout_ms = sdxi_admin_timeout(args->timeout_ms);
+
+	ret = sdxi_vendor_get(args->guid, &handler);
+	if (ret)
+		return ret;
+
+	ret = sdxi_vendor_find_opcode_type(sdxi, args->guid, timeout_ms,
+					   &opcode_type);
+	if (ret)
+		goto put_handler;
+
+	if (args->op == SDXI_ADMIN_VENDOR_PROBE) {
+		if (args->in_size || args->in_uptr ||
+		    args->out_size || args->out_uptr)
+			ret = -EINVAL;
+		goto put_handler;
+	}
+
+	ret = handler->ops->exec(sdxi, opcode_type, args, timeout_ms);
+
+put_handler:
+	sdxi_vendor_put(handler);
+	return ret;
+}
+
 #define SDXI_IOCTL_DEF(_nr, _cmd, _func, _files, _access)	\
 	[_nr] = {						\
 		.cmd = (_cmd),					\
@@ -759,25 +808,41 @@ static const struct sdxi_ioctl_desc sdxi_ioctls[] = {
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
 	SDXI_IOCTL_DEF(0x0d, SDXI_ADMIN_DISC, sdxi_ioctl_admin_disc,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
-	SDXI_IOCTL_DEF(0x0e, SDXI_ADMIN_VENDOR, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x0e, SDXI_ADMIN_VENDOR, sdxi_ioctl_admin_vendor,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_VENDOR_HANDLER),
 	SDXI_IOCTL_DEF(0x0f, SDXI_QUIESCE_CXT, sdxi_ioctl_quiesce_cxt,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
 };
 
-static int sdxi_ioctl_permit(const struct sdxi_ioctl_desc *desc)
+static int sdxi_ioctl_pre_permit(const struct sdxi_ioctl_desc *desc)
 {
-	switch (desc->access) {
-	case SDXI_IOCTL_A_PUBLIC_DEVICE:
-	case SDXI_IOCTL_A_CONTEXT_OWNER:
-		return 0;
-	case SDXI_IOCTL_A_ADMIN_DEVICE:
+	if (desc->access == SDXI_IOCTL_A_ADMIN_DEVICE)
 		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
-	case SDXI_IOCTL_A_VENDOR_HANDLER:
-		return -EOPNOTSUPP;
-	}
 
-	return -EINVAL;
+	return 0;
+}
+
+static int sdxi_ioctl_permit(const struct sdxi_ioctl_desc *desc,
+			     struct sdxi_file *sf, void *data)
+{
+	const struct sdxi_vendor_handler *handler;
+	struct sdxi_admin_vendor_args *args;
+	int ret;
+
+	if (desc->access != SDXI_IOCTL_A_VENDOR_HANDLER)
+		return 0;
+
+	args = data;
+	if (!args || args->argsz < sizeof(*args) ||
+	    !sdxi_admin_vendor_reserved_zero(args))
+		return -EINVAL;
+
+	ret = sdxi_vendor_get(args->guid, &handler);
+	if (ret)
+		return ret;
+	ret = handler->ops->authorize(sf->process->sdxi, args);
+	sdxi_vendor_put(handler);
+	return ret;
 }
 
 static bool sdxi_ioctl_has_trailing_payload(unsigned int cmd)
@@ -900,7 +965,7 @@ static long sdxi_ioctl_live(struct file *file, unsigned int cmd,
 	if (!allowed)
 		return -ENOTTY;
 
-	ret = sdxi_ioctl_permit(desc);
+	ret = sdxi_ioctl_pre_permit(desc);
 	if (ret)
 		return ret;
 
@@ -959,6 +1024,10 @@ static long sdxi_ioctl_live(struct file *file, unsigned int cmd,
 		}
 	}
 
+	ret = sdxi_ioctl_permit(desc, sf, data);
+	if (ret)
+		goto out;
+
 	ret = desc->func(file, sf, data);
 
 	if (ret == -ENOSPC && sdxi_key_list_cmd(desc->cmd))
diff --git a/drivers/dma/sdxi/vendor.c b/drivers/dma/sdxi/vendor.c
new file mode 100644
index 000000000000..6fb5967b0052
--- /dev/null
+++ b/drivers/dma/sdxi/vendor.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI vendor operation handler registry.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+
+#include "admin.h"
+#include "sdxi.h"
+#include "vendor.h"
+
+static LIST_HEAD(sdxi_vendor_handlers);
+static DEFINE_MUTEX(sdxi_vendor_lock);
+
+int sdxi_vendor_register(struct sdxi_vendor_handler *handler)
+{
+	struct sdxi_vendor_handler *iter;
+	int ret = 0;
+
+	if (!handler || !handler->name || !handler->guid || !handler->ops ||
+	    !handler->ops->authorize || !handler->ops->exec)
+		return -EINVAL;
+
+	if (!handler->entry.next)
+		INIT_LIST_HEAD(&handler->entry);
+
+	mutex_lock(&sdxi_vendor_lock);
+	if (!list_empty(&handler->entry)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	list_for_each_entry(iter, &sdxi_vendor_handlers, entry) {
+		if (!memcmp(iter->guid, handler->guid, 16)) {
+			ret = -EEXIST;
+			goto out_unlock;
+		}
+	}
+
+	list_add_tail(&handler->entry, &sdxi_vendor_handlers);
+
+out_unlock:
+	mutex_unlock(&sdxi_vendor_lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_vendor_register, "SDXI");
+
+void sdxi_vendor_unregister(struct sdxi_vendor_handler *handler)
+{
+	if (!handler)
+		return;
+	if (!handler->entry.next)
+		INIT_LIST_HEAD(&handler->entry);
+
+	mutex_lock(&sdxi_vendor_lock);
+	if (!list_empty(&handler->entry))
+		list_del_init(&handler->entry);
+	mutex_unlock(&sdxi_vendor_lock);
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_vendor_unregister, "SDXI");
+
+int sdxi_vendor_get(const u8 guid[16],
+		    const struct sdxi_vendor_handler **handler_out)
+{
+	const struct sdxi_vendor_handler *handler;
+	int ret = -EOPNOTSUPP;
+
+	if (!guid || !handler_out)
+		return -EINVAL;
+
+	mutex_lock(&sdxi_vendor_lock);
+	list_for_each_entry(handler, &sdxi_vendor_handlers, entry) {
+		if (memcmp(handler->guid, guid, 16))
+			continue;
+		if (!try_module_get(handler->owner))
+			break;
+
+		*handler_out = handler;
+		ret = 0;
+		break;
+	}
+	mutex_unlock(&sdxi_vendor_lock);
+
+	return ret;
+}
+
+void sdxi_vendor_put(const struct sdxi_vendor_handler *handler)
+{
+	if (handler)
+		module_put(handler->owner);
+}
+
+int sdxi_vendor_find_opcode_type(struct sdxi_dev *sdxi, const u8 guid[16],
+				 unsigned int timeout_ms, u16 *opcode_type)
+{
+	const u16 first = 1;
+	const u16 last = 2047;
+	const size_t record_size = 16;
+	const size_t size = (last - first + 1) * record_size;
+	dma_addr_t dma;
+	u8 *records;
+	u16 index;
+	int ret;
+
+	if (!sdxi || !guid || !opcode_type)
+		return -EINVAL;
+	if (!sdxi_dev_compatible(sdxi, SDXI_VERSION_1_1))
+		return -EOPNOTSUPP;
+
+	records = dma_alloc_coherent(sdxi->dev, size, &dma, GFP_KERNEL);
+	if (!records)
+		return -ENOMEM;
+
+	ret = sdxi_adm_disc(sdxi, first, last, dma, timeout_ms, NULL);
+	if (ret)
+		goto free_records;
+
+	dma_rmb();
+	for (index = first; index <= last; index++) {
+		const u8 *record = records + (index - first) * record_size;
+
+		if (!memcmp(record, guid, record_size)) {
+			*opcode_type = index;
+			ret = 0;
+			goto free_records;
+		}
+	}
+	ret = -EOPNOTSUPP;
+
+free_records:
+	dma_free_coherent(sdxi->dev, size, records, dma);
+	return ret;
+}
diff --git a/drivers/dma/sdxi/vendor.h b/drivers/dma/sdxi/vendor.h
new file mode 100644
index 000000000000..2a4e4582b21b
--- /dev/null
+++ b/drivers/dma/sdxi/vendor.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI vendor operation handler registry.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_VENDOR_H
+#define DMA_SDXI_VENDOR_H
+
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+struct sdxi_admin_vendor_args;
+struct sdxi_dev;
+
+struct sdxi_vendor_handler_ops {
+	int (*authorize)(struct sdxi_dev *sdxi,
+			 const struct sdxi_admin_vendor_args *args);
+	int (*exec)(struct sdxi_dev *sdxi, u16 opcode_type,
+		    struct sdxi_admin_vendor_args *args,
+		    unsigned int timeout_ms);
+};
+
+struct sdxi_vendor_handler {
+	struct list_head entry;
+	const char *name;
+	const u8 *guid;
+	struct module *owner;
+	const struct sdxi_vendor_handler_ops *ops;
+};
+
+int sdxi_vendor_register(struct sdxi_vendor_handler *handler);
+void sdxi_vendor_unregister(struct sdxi_vendor_handler *handler);
+int sdxi_vendor_get(const u8 guid[16],
+		    const struct sdxi_vendor_handler **handler);
+void sdxi_vendor_put(const struct sdxi_vendor_handler *handler);
+int sdxi_vendor_find_opcode_type(struct sdxi_dev *sdxi, const u8 guid[16],
+				 unsigned int timeout_ms, u16 *opcode_type);
+
+#endif /* DMA_SDXI_VENDOR_H */
-- 
2.56.1

