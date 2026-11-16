Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794811967;
	b=XOrl8eJx6q1+4nJB2qpmJkBXVkjma8PVdIB+f8CbeEA25dTD8zq/iZD6+eGfYSmXJe1+
	 WliA5zV5OBsN/1ZSKP0zlsi8M9Bm4Aqo57wS8LqP3uoH8fFTQiqKtmN1EZvDZxHkbATLo
	 7KUWXlsW2v6TWfWwgBsZ9S1w5lwHKISwQbwmKj0GYUrThrd++aBav8yruaNwFQr6Tz75G
	 A1Mo3LzzHOHAOIKg15i8PDJZGRUMx3J30NS53kD6tfIUmRds0Q/rqeh98d2fF2BITUVQJ
	 PWB5/ShdL+U1gfqsZ69xvTBnJCtXbaerK/12y6nId8uf6GtwqLy34ZoEDt+eY9MJ/2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811967;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HIINr7esEx+BM38+RsvV2vebktU+m5lvjalzgsViMYM=;
	b=OeX+WVHUgHrX7LX20fp3DPGeDkrsY7zbamD85RG6bRsPOiBZgMUNXO3CmdNzJP7ktQTV
	 oBUbbq02PJt/XTwBbPvqgLWJFxgyTLGsHmZRP/4jlOnFWyOUKlM7DT1DxIRsxBpwledb0
	 7zgMO9dbQ31UC1OTr7Cr/jHS6muuIIUksi41mj7StUNwbAc0PmHhSNI9NCWR561WVaUxp
	 FViX0KhBXU/q+ppGLGkuekpsqDJaINtC8/kzkkgcbXT1ky1NeRXi/UWAqyPwi/943d2Lk
	 1Q/rfwFpEXTxCH1+yuXTE0ZnovWoTzxFC/5PI+pzPTOa8WCBwzS8LC0cC1BwCIdWsFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=THfvwuI9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.69
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47768606A339;
	Mon, 16 Nov 2026 06:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47768606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=THfvwuI9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdNhDZvHjUp/DSQ+GLQRfZ912HeCNwQXWr3voXxbWjxYLZPvITDRZi3hShosAkFiByOOcxZbaNfqViUEA99xHlMsPz5IeNzHdQq8xEVs+hoPhy5C0+O8kI98z/OY3MtmaqTUF7R38uC/qys0IhrgVqsRXb/S2QXfafRiWFXNIe8Cm2vFtK9Cgam77JI1wxFjrVCDuFJONyR2MjnFkXPQRFT2m6H7m3wI1jaosb4LXecdMV9CxcJu6Jy6oCuX0UpOKzvhYeN/a/HEJiR1tA7MxXR16tI8JSbUXpqEM2cnfSKX+tqtx9ZDWojl6s8dMS7WCrFYbZwwVRWvVM2G2dYmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIINr7esEx+BM38+RsvV2vebktU+m5lvjalzgsViMYM=;
 b=GJICDQxL3yUeSzWFIeRNjUwC6zdOpBx5JehIyg62fRJNkmEpb70+9RoYoMd1W0XAJGJyGTYcs9F1MiZJZxL66iwe8YUWy54xra+anvNVepO3up0nvxCHLQQuujPdR8ESPe+Ha3Xcf014E1wIbfCuZgzVVlUyj69Z8kSLPKSPkn+crJ7l4u1np8IL6B6aAPmrXW8AT3qRpj5XW+7ucdbVtK1Az6av3HXOc4sfQ4aA/v+OVgrG92GcSJ+TjoflLR2+rhZoTpwqMWa/mSiBdAscOG4yIGhHOLGC7MRxgE4ZTJbvbIw5EO3xGE8fEZEP4kwQ+/2dTdBSuzVeGKdXtXiWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIINr7esEx+BM38+RsvV2vebktU+m5lvjalzgsViMYM=;
 b=THfvwuI9accD7AvdQ37bBY4XByxtUqc0Sw5Sqy+QQv2A5TJeKu439VOgAjIdMtZ9Q0yTUwHO2lRnmcgPcVFin0FvmnJeaTFbAlXYUfpLTSqxG6qV35opU15Hxp0sa/lveD7e5zgwBRON0ULDMkjavqGbMosxKne5Uo/9pjrYkZGPzxA6ftVJzMKaNyofI07sBDOD12pMpr2aCt1LT42/AyxRNOBEKD8F0Km+lU9r5s/gBdXRfzXMoE/GWyohXIbJRteZsMG++ZDjc5s/vYtvvDVkCGQ6UmpW+/y5y/ehyzEItG9+Zm4tTVrLCG09Vze4qzMvWyIiaokRTQds2tnt/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV0PR12MB078426.namprd12.prod.outlook.com (2603:10b6:408:3b6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 06:52:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 06:52:44 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	helgaas@google.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tglx@kernel.org,
	wangruikang@iscas.ac.cn,
	alifm@linux.ibm.com,
	shawn.lin@rock-chips.com,
	lihaoxiang@isrc.iscas.ac.cn,
	18255117159@163.com,
	xiangzao@linux.alibaba.com,
	vidyas@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com
Subject: [PATCH v3 1/2] PCI/MSI: Skip MSI/MSI-X restoration when config space is inaccessible
Date: Mon, 16 Nov 2026 14:52:28 +0800
Message-ID: <20261116065229.38194-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116065229.38194-1-icheng@nvidia.com>
References: <20261116065229.38194-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV0PR12MB078426:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed39902-dbb7-4471-fceb-08df43ae3756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hxGVv1d6TyBbQchFuTRmgucX+2aNXC9coO8agcKzrEfaxRHbfeLqwH3DNrwiTvEMKANX+EkyUrgZj33oEoHd5cEih0lOaZWU5Somit6nXeKP6oOzLusHEcTT8Ch0NgG+laGKSye5Zder7cQvGCBqy7jzZIu2GO80hVinUdIgxqP3g3H7YWM/m6yyaQThmjGQhGVz5skEGo8qpIh8CpL3wgoWHM3QpyT2mSW47w1uYFtNoK+HRYgtym8Omc+EOmEeweH3kU8Y2KI/0kJmniQ+zRthKVQ8JgM9k44/ct8cqoDCF1/t1wAUiwTYk8/E98ujIZry9IbvWWl6MEMC5LVTtzMIKDQX7CnOM9PLEfecbdqhoodbdiG3zSk6+DGfV3X/lO50t3/OPtwV7t8myjBf/AcCYQ2kia0Sqr6FzcxFfWCvPivf7UTZmisjlmPNyXt8QmZbxbnP3JwZ3wMzVAHo33jYOEfz7zC3D4cMnfXNcwC785Ev5AHkhBEVrTmsTDhhpGpplpb4ieui8WD/qeZqPPFrAxVMt0qOX7EyHd1LwNPPejqDdMHnfBSBUkHNK9v2v+Nok+VpkZoZejrXxfLaadhlmqn2Ku4fbphBAc4uun+u7obeaH+EI4VWQQgmvsXY72D9cd9hDGRJze0xiyN26vcwDlACN0cUFBbL7SrvtRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EmSuvMc5RaRskXJz4qFLe+6Myp7nyqdSPwDHv3fgR8+gxr8y18XLar8rtwpb?=
 =?us-ascii?Q?FVZFySAsi85LzCjGHw16Q+Oz4zJzty3ChiKS7v6wJCIQFcN6g6LwEbgakkR2?=
 =?us-ascii?Q?9pTbZgZV/4qF/D8h6waSHudQrXW0syOZ7a7zxRhpYhIf1CEUx2DycdmNV+5i?=
 =?us-ascii?Q?g3pworpp0JutWqS0rfqz/ql22gId7PGfF5cBHeFFa+OWgxLLda3D5PcDwGTR?=
 =?us-ascii?Q?xZClKi5m/0F6VUmRi1DRmWDiyjvlEVB/AWD62qldZ4y6UgWTNTcYpwShajv1?=
 =?us-ascii?Q?b9UZ1kc/8ZuTzMHTR6NZnEWiz3awWjCSx55bgYiv9vijVzwccUwLiNRZdwQr?=
 =?us-ascii?Q?z6YUEFYVENqRmHc0jsu0fxtBNlGmFOPY3m9ya1hSQ+fXdo5LTUFz29jO9RVy?=
 =?us-ascii?Q?aLLcIg9Og18gFY6uaeoAJW4FPpJ0uTdW0GyxVWdfDEVhCd2IAa1lkvjkmjF8?=
 =?us-ascii?Q?IG7YiujC9TWD1PIChsSmVkIT1IK3ncbCDuGneMvy/GQNU2qAFDgFddJs7DrY?=
 =?us-ascii?Q?9vMU5APcZoafdxSelk4x3yWdkcXWd4u/axSh+m0bXZXB0Ojyne6fSK+lgcf1?=
 =?us-ascii?Q?jHEukSmlK6PE126M+Yr5L0jVTw9HqtJU6fdi7fiEyMmhtMRCAOxoTjfaUTcY?=
 =?us-ascii?Q?LYwyqBkHm6EM2RFOAD0DgvwAneuiLGnunNMJkMa4fKpG8UWCyaLfWHtvaxcS?=
 =?us-ascii?Q?Hhs2iUvH2bo7w7gTfGYEYh4eFMKaoTHNZ94bc9vzrfcRjMNAVgXtUduXbA8u?=
 =?us-ascii?Q?t77m9uxrYdhvZSsV75TrA8vs7VBjt6Bj3q/xsv+2Eci7SkVJCz7PJl1gnkrA?=
 =?us-ascii?Q?7SCcaUSdc89SlF2vUFxD9bF+EL4dEhJ3L+u/0XFiqcv+yfQnZaGCZz9LTMtR?=
 =?us-ascii?Q?BKG03iq6gu0dGoOAQOONC/3sfTbeDeqbWl+qyL9cFcw7n8YyGhyawySzHbHr?=
 =?us-ascii?Q?fCF2yjqi39Zt8q3IlImHmAfpwpLEij0WVXi6L9VoLHo6tljdt1XwnW16MbqM?=
 =?us-ascii?Q?DAZxVXtyJtnTlA0cV4mYFROZ/9UM9rrwIDaiVb8nVjHcGn8yeN33/pgaYMz5?=
 =?us-ascii?Q?cRaYum1mAbEyjV10oJpaCv5t0RM1lc3UaKzGxUqZZGYFECMkC4jag1WxmRIg?=
 =?us-ascii?Q?ZvsVvxbG52gME0K3ymxja1pJQrVg8sD9ED/xNvDyMOVCLbY+5E2EEGdxykCR?=
 =?us-ascii?Q?023r2qb60ubPZtW5jTPKqo7ZmQ5xAdElMqVOSRq1gQORSrZbhr5fH9nj5pUG?=
 =?us-ascii?Q?SBfRD1Yl4rpqA36EV/aGnJuQBF0YgC6cEiPtH4JcNsky7ZUDnwkwN+A7onnM?=
 =?us-ascii?Q?rYtyE/LB8pqGDjfLTAX6e6mBNuiY2aHFS5e+g9obr5Fz7Wx25uqTo5/CCH7W?=
 =?us-ascii?Q?40auQjGWLASuXNnKQ404hOv7+9dTPzndHklyizdNbMucDj93RsnESG69fC3w?=
 =?us-ascii?Q?7ELmqWY3o3uOgK7Zbij6pZaPu+7x/De4Lr4zEjZzNh1D9QWXJOajbdxT+jV/?=
 =?us-ascii?Q?YBNDKMw+3ssCw36CH2ckx3j1M2cR9cVARbRoLjPTF70zwxNrqUceJqi+sr9H?=
 =?us-ascii?Q?qkTRiewIpeYkr8K4xL+C6Fvm8QJHH+I/KBTpyPG5snNx4TdOBshRzPz8cA78?=
 =?us-ascii?Q?vSveEtV7IdtUknBfiX2Jcl5V586/+z9XeGcWghlmgV9JsHnMYCxmXlVIAE3e?=
 =?us-ascii?Q?awuFVSkyumAu/bFAc1HTA3OPMBNjhc0RvxB99WBLkbBkk16h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed39902-dbb7-4471-fceb-08df43ae3756
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:52:44.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDZj2+odXGEoOmTfjufvvyiIlKWNO28UaIFrd9jmf3KgXPqlNggfvZRfGV9FIbA37IDzK4+i5kHv0bed99VoUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB078426

PCI state restoration runs even when a reset fails. If the device's
config space remains inaccessible, MSI-X restoration still writes the
MSI-X table. The table lives in device memory space, and these MMIO
accesses can trigger additional errors, including DPC.

MSI is programmed entirely through config space, so it doesn't issue
such MMIO accesses. Restoring it is still pointless when config space is
inaccessible: reads return all ones and the restore path writes back
values derived from them.

Check whether config space of pci device is accessible or not at the
start of both MSI and MSI-X path, after msi_enabled/msix_enabled test
and before any config access, and skip the restoration if the device is
inaccessible.
Make the helper non-static and declare it in pci.h so the MSI code can
use it, too.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2 -> v3:
- Cover MSI restoration path as well (Farhan)
- Use pci_dev_config_accessible() instead of open-coding the check, and
  make it non-static (Farhan)
- Move the check before any config space access in the restore
  functions (Farhan)
- The return value of the PCI Command read is no longer checked, since
  the helper only tests for an all-ones value.
- Update the subject and commit message accordingly
---
 drivers/pci/msi/msi.c | 6 ++++++
 drivers/pci/pci.c     | 2 +-
 drivers/pci/pci.h     | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 8a0133a6a286..2865f73f5ead 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -524,6 +524,9 @@ void __pci_restore_msi_state(struct pci_dev *dev)
 	if (!dev->msi_enabled)
 		return;
 
+	if (!pci_dev_config_accessible(dev, "restore MSI state"))
+		return;
+
 	entry = irq_get_msi_desc(dev->irq);
 
 	pci_intx_for_msi(dev, 0);
@@ -877,6 +880,9 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 	if (!dev->msix_enabled)
 		return;
 
+	if (!pci_dev_config_accessible(dev, "restore MSI-X state"))
+		return;
+
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
 	pci_msix_clear_and_set_ctrl(dev, 0,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..671ffe4da1c8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -714,7 +714,7 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
 }
 EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
 
-static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
+bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
 {
 	u32 val;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..98dd3dbd5edb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -240,6 +240,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
+bool pci_dev_config_accessible(struct pci_dev *dev, char *msg);
 bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
-- 
2.43.0

