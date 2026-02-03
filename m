Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F831D371;
	Tue,  3 Feb 2026 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087231; cv=fail; b=me2StVfiOxrhR16/MSMR4bfnkKBl3ii84YE+TnlPWgk4l67lfxFH3b0+vASjOCi9kkYQjBLI1OUO8hEfR8gJzs318KTOsJ/JvywYmXzqvZq7tvVXkdLQiw1qn406kx6Id04DPVijTf26Zjxr8lAwCi2ot1pD7L1fOgnIu6O8Mm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087231; c=relaxed/simple;
	bh=/Xevsrecgelb0NvtBnuM8gG4AM1Yrpph/kYEDIZeUF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vA77h+kaBQ/Pls9XPxL/dcnRXnXLGi0F/QNRYEVlp0+y/KZaQnxuqATygBig30RnvJut+DAZn1vkyabpAxh8C5Squ9O2GEWeGsYsYFHl6W4/mqbhwqDu/DgK1G8tkxooLBGR28ILC6FWDtVNzatootHIhbAlhtmO1pQoVe+PbJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b5hq4vLx; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b5hq4vLx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIfZFAb75PrKqDPGlOLEseYuc1e7PkNhfl2psbQznKBIb4sQ4vcT2rpRkZ4f9VEJHv1TKvEyVovbnD21KrMiWhsBTUfMo/KFNdWRTZZiG4RpbVTgf0UgL24TxTxM7GI0k5FyL+dEjIcONSGEyzIdICyBOBOsGI3CmQJbBOcdyXGCessBVVqcgAi0Q0io6iYPijGowmI6QAX/NCHlaP0CKTPQsplkVD/ZFc+tnFIrkXd8ZwKE347BkesTn54PekU9RZxMc40zz7UxfUzplqm0U5ED+HWGstw1KLJSx5r6WFkCgm0fN68U8Ro/wSt/gRl1VRxi6mzXKB3jUbTI57HtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDAGjWc3VdkwglwO0vXP/Ml2lNLc2ab4sYasy9ovPEU=;
 b=S1oldB1N9bS7g6tb1WRnsdMKkhHcYNkWk3cAPDCP0PzCc9KQX/+jyv4V8VG1/RtwNibGGWv3oflqKB1lU2nVQdoOcJoGlpEnGn8nypx8M+RmgD55h9/GFrxkQOcRPYm5Bz7hBKHp8pmOEMrWvyot5sxNXqUZUJEpg6aLkmGBvymG7fiAWo549gr/yyG7CHnEOVSfLusK03Rk496xqEhUW/p0yO7RSMmoDSZr27AAzKTFwrttP9xdfWHnu/p942mWxgPYjQmG93mQ/duyq+tacdM9a3zFHvX5NeScCRUu+D/j/+vc69xd05pw69hvcO9Yuh0SLKWemOBJj+qwJuo8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDAGjWc3VdkwglwO0vXP/Ml2lNLc2ab4sYasy9ovPEU=;
 b=b5hq4vLxDFrbuTC8vvnIEFKeP9EpAVnFlXD2TwptGnPLSqgT1i+ZnMQUJw6ownoA7iDSb2BrEAkHJaBqjKv2SdMH5/7A9G2O4pf3LTvjdiTpUDxdCsO2kDfkxy3P1qvOw7EKQjmswUkDwqbwEEX4jfan2baj5SDt4ZG/7uuF4FU=
Received: from MN2PR13CA0028.namprd13.prod.outlook.com (2603:10b6:208:160::41)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 3 Feb
 2026 02:53:45 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::ee) by MN2PR13CA0028.outlook.office365.com
 (2603:10b6:208:160::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 02:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:53:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:53:44 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v15 4/9] PCI/AER: Dequeue forwarded CXL error
Date: Mon, 2 Feb 2026 20:52:39 -0600
Message-ID: <20260203025244.3093805-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203025244.3093805-1-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 63925162-3b79-4712-0617-08de62cf7285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1BtYbWG3+BwCL3x2d9WtZcPUyC4GQHp7bgj7hdGnWrKVgWS0x0xOEUaioR0d?=
 =?us-ascii?Q?rM839gyZexMqmL8aZqnaW+/gBf6hnEAy4bR5BIj9WxVICXaghn2lHIRD0VMk?=
 =?us-ascii?Q?oqEWeBdOa3MOKx2e3yajQhB2QF6iVTG1farTsOU43mWo2ojy0405V7/L1NEA?=
 =?us-ascii?Q?d7pVsB3+i7LbhuJXUg9jp+Pgic7LVFCjZ7aUeynKWFUXTm7Njw6YPrE6jnvF?=
 =?us-ascii?Q?vJ4XypxVRKmcUeAzF27kCYaOZygUikZMg6xCrGkQqCyCz/Nt/lU1s7LwzBkF?=
 =?us-ascii?Q?j17pmOhDL9CzlyFVfa+4JC8Q8MBKL89wrxgsk+IwFaVBvjJrfug+jWoc8wm9?=
 =?us-ascii?Q?b9cpLiWEYTxF2jXRBRVDOTgnbbD2JTgTOY0E4IxR/7ZgeQE7pallh7qMMlq+?=
 =?us-ascii?Q?qJaACo6yx/vd2Bs0KJsyQDPEZ+hHZDMayv28vvx5m/SppQnuX+aC9d5i4yYj?=
 =?us-ascii?Q?Sgt3cPnxFo1midXWPzg7x5L7ChXsb/JQP5OSpS4GsZLvzxO7YcYpSxR4Qp3l?=
 =?us-ascii?Q?At5dRGG3tKiuKSZ1QebsYyPwRD5qv6o7FnjI/xJAtb03wIdGQkFfyvAhwJ3N?=
 =?us-ascii?Q?32a9v/ckw2hPJL+JVcwhwsYjHCUkZ4qxVfZndg2Sc45Ik4R6IjUtQ0FGi7hr?=
 =?us-ascii?Q?PmfcNUSSiWfSH5Wi6JJU9I/Eux6AP5VvAY86CKD8gnCNe8Q6G5DiIKBEAIhc?=
 =?us-ascii?Q?y1kMGd3itOn2S8B5PXl/ahQ5bG3+hmBQsrr//J4MlgaKSsLsT5TMVdf8JErj?=
 =?us-ascii?Q?MG33rnDGsBbjfsgPd01UMXr9dnjRCsQId03+mZKbA6bK46Ezo8tzdhmx0aX9?=
 =?us-ascii?Q?0X+quY9Or17IfyhvTj7xRnKVRt/cZW1GCwa+hGGEik+sbcaUbSdzQUlF8ab3?=
 =?us-ascii?Q?VzDIE0IvqyhdNjOFItZFnxaZMEebjGa2agJHdjjrvj6B6ncxH9EzYxeo3z7T?=
 =?us-ascii?Q?g30C71SZ5uUcdF0m2nFzc5whh0PndcIIsR+v/Sdq9uSI0YxuN3NsRTEx+EhI?=
 =?us-ascii?Q?lhb9kEA6whiuOf8zGylvL3KtEJl7d1zj+6OdD2hq3P06LoMrj3lif+yENTlk?=
 =?us-ascii?Q?zp+8MoNtPaCSU5O3OTDzzvLgpEI/oCLM66epnQEgh+FRrfDZv5SZsZobIG4F?=
 =?us-ascii?Q?yXgUGq62fImwJcSYea1z6k6zUsieJMO2UYmLX2BUT/t+6HWl6ACOvkNxKugp?=
 =?us-ascii?Q?s0k7kRc74uCbwWVxp6styFGK+irT15X5d04aVL23ZQDVNPyXKOQunS+Sm3Xs?=
 =?us-ascii?Q?NMRq8aPllH0vsSU9zFmKQ4zRsD8eCYO2b0JXJTKyKeKtFCxeYu5uGZEaT7aD?=
 =?us-ascii?Q?6QtWnMpf0SV1VHqJIf9gOkVS5yvZ5oJrNalHTENEmsTgg+XCpCIwGaDsbC6e?=
 =?us-ascii?Q?GDMPzDKiqKssBbriInQrWKQaM2dtf5g4/tyuf/gQhbeaM6XczZzv6CUrjvFw?=
 =?us-ascii?Q?/JsNbXirBkdYpowRw6rCDYKLQI01TP7klOvyKO9hjtaLE4QuTYtuJFjYH0RN?=
 =?us-ascii?Q?0c1pIv/C/jdAmKx7UmLty94P2PuoILMWKGr7H4HAno3vHuzcXFhQdnVae/Ko?=
 =?us-ascii?Q?uF5IoTiQ4fOxJ9X0k0iHc3K3dc+ujt/TXxQZHot3+uHBlbfyxQ9NeItKaYlf?=
 =?us-ascii?Q?PlWlU13Gwgo+aMBYb9o1Xbigw2jk+lnHvOiIbXTeMxMW52wpJH7FdMHi8fV3?=
 =?us-ascii?Q?izfQCMxKN7B0cQAme3EWOnIX6IU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bLlnWdNqYKK7l0hrFVL5NP/8N55Qk/wIREm87RetJT1qREqWeRvr0gxWTWzMIiZ7zGN8jtkr4tGBfUNU2hTXv0z2Ui4VV3ZSxYuDJtXUboGcgtMEptmZr0aPMkULqM3CRBGflxflJAdhp8x/96TdG80Hq++LwCB/QTdp3R+AdD6Dh4rvqw/7coE8cV1SjNiijuJy0NX0rvj5mWKthmLMUg5PNYFh4aRAtWkzcD2oBoz8zvGVWSH1Bdkrh1Uv6Le10MUhE/j3xvDgx2ZtzoGLhViyyzkHI1IWSUgC4wPA9PLhPsvL3JOhxbBab440UPG9//O2l9f0z+OLtCHbqUoalRCimbPY8+0j4q0Np21CeUj3lsusOh9dIVeyTrh1+IZOuAJb+SGWyc4MXSokHV9lg5MELA4uUh++yt4O1d4Qdwc74eggPCOcJ/27435KFSTW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:53:45.1825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63925162-3b79-4712-0617-08de62cf7285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512

The AER driver now forwards CXL protocol errors to the CXL driver via a
kfifo. The CXL driver must consume these work items and initiate protocol
error handling while ensuring the device's RAS mappings remain valid
throughout processing.

Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
AER service driver. Lock the parent CXL Port device to ensure the CXL
device's RAS registers are accessible during handling. Add pdev reference-put
to match reference-get in AER driver. This will ensure pdev access after
kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.

Update is_cxl_error() to recognize CXL Port devices with errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

---

Changes in v14->v15:
- Move pci_dev_get() to first patch (Dave)
- Move in is_cxl_error() change from later patch (Terry)
- Use pr_err_ratelimited() with PCI device name (Terry)

Changes in v13->v14:
- Update commit title's prefix (Bjorn)
- Add pdev ref get in AER driver before enqueue and add pdev ref put in
  CXL driver after dequeue and handling (Dan)
- Removed handling to simplify patch context (Terry)

Changes in v12->v13:
- Add cxlmd lock using guard() (Terry)
- Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
- Change pr_err() calls to ratelimited. (Terry)
- Update commit message. (Terry)
- Remove namespace qualifier from pcie_clear_device_status()
  export (Dave Jiang)
- Move locks into cxl_proto_err_work_fn() (Dave)
- Update log messages in cxl_forward_error() (Ben)

Changes in v11->v12:
- Add guard for CE case in cxl_handle_proto_error() (Dave)

Changes in v10->v11:
- Reword patch commit message to remove RCiEP details (Jonathan)
- Add #include <linux/bitfield.h> (Terry)
- is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
- is_cxl_rcd() - Combine return calls into 1  (Jonathan)
- cxl_handle_proto_error() - Move comment earlier  (Jonathan)
- Use FIELD_GET() in discovering class code (Jonathan)
- Remove BDF from cxl_proto_err_work_data. Use 'struct
pci_dev *' (Dan)
---
 drivers/cxl/core/core.h       |   3 +
 drivers/cxl/core/port.c       |   6 +-
 drivers/cxl/core/ras.c        | 106 ++++++++++++++++++++++++++++++----
 drivers/pci/pcie/aer_cxl_vh.c |   5 +-
 4 files changed, 105 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c6cfaf2720e1..92aea110817d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -182,6 +182,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ee7d14528867..8e30a3e7f610 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1402,8 +1402,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1607,7 +1607,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 {
 	struct device *dev;
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 74df561ed32e..a6c0bc6d7203 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -118,17 +118,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
-{
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
-}
-
-void cxl_ras_exit(void)
-{
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
-}
-
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -185,6 +174,50 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
+/*
+ * get_cxl_port - Return the parent CXL Port of a PCI device
+ * @pdev: PCI device whose parent CXL Port is being queried
+ *
+ * Looks up and returns the parent CXL Port associated with @pdev. On
+ * success, the returned port has its reference count incremented and must
+ * be released by the caller. Returns NULL if no associated CXL port is
+ * found.
+ *
+ * Return: Pointer to the parent &struct cxl_port or NULL on failure
+ */
+static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
+{
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport;
+		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_ENDPOINT:
+	{
+		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port;
+	}
+	}
+
+	pr_err_ratelimited("%s: Error - Unsupported device type (%#x)",
+			   pci_name(pdev), pci_pcie_type(pdev));
+	return NULL;
+}
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -327,3 +360,54 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+
+static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
+{
+}
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+	struct cxl_proto_err_work_data wd;
+
+	while (cxl_proto_err_kfifo_get(&wd)) {
+		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
+
+		if (!pdev) {
+			pr_err_ratelimited("%s: NULL PCI device passed in AER-CXL KFifo\n",
+					   pci_name(pdev));
+			continue;
+		}
+
+		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+		if (!port) {
+			pr_err_ratelimited("%s: Failed to find parent port device in CXL topology\n",
+					   pci_name(pdev));
+			continue;
+		}
+		guard(device)(&port->dev);
+
+		cxl_handle_proto_error(&wd);
+	}
+}
+
+static struct work_struct cxl_proto_err_work;
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+int cxl_ras_init(void)
+{
+	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
+		pr_err("Failed to initialize CXL RAS CPER\n");
+
+	cxl_register_proto_err_work(&cxl_proto_err_work);
+
+	return 0;
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cancel_work_sync(&cxl_cper_prot_err_work);
+
+	cxl_unregister_proto_err_work();
+	cancel_work_sync(&cxl_proto_err_work);
+}
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index de8bca383159..6bcd6271afbf 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -34,7 +34,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
 		return false;
 
 	return is_aer_internal_error(info);
-- 
2.34.1

