Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020095.outbound.protection.outlook.com [52.101.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039912F7445;
	Mon,  3 Aug 2026 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780294; cv=fail; b=bi7TW0iQZJB1vSsna+eApjZ22vHdxEraheGc2L+ntfp5E1ySLiqQq7HignnTOKKTN3br2mZlCJX6eZgBnkzpu0VfBWpYW+rqdZL2SwqmuiH8GNYcw/GQ8z1BctoFB4IaLWq13G8fnWmLbfabDaxSx1R7W2y+T43KOT9QX0R2hKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780294; c=relaxed/simple;
	bh=gAj6IRrCyqkZ4I+SiswP99rJhVdW93CVlY7LM0GPnoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMUlKig7trk83PPXTD7GySHGZRHo9BmC3oY17OJK+29xyGJzijgLg/SobWe1LrpWK2H1M0vgbL9T1xa32S1TXXY84duCd7vtJjBl+90NGy5TvvjA2A4I8E3sLiPQi0eUO8K1cZwWHQWALZOhomBl30dUzCG2a6dHUBajtjfNWW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FvwFTrGo; arc=fail smtp.client-ip=52.101.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FvwFTrGo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xpl8kz3Z6Bu3kj7f1pSjwhmgl74237gI/HsFs4F32N1mbF2zo7VwWdY0uHbAuxdu6svYSIKftOofZH9eyEtD2a+lvcvVpBKE6zmkHFIrj+CViUwRe/M7Dip6MmC8KKIlw34IsMymIFxnjWF+eoyreDpT0qoLicjZpovj+TidcIIUB5lK3W0yMPMFL5NW80gvSj4PjPxznERsv5z/wTMgq3BdAD4d6zT3/GqmHUKsk2JVgbtp7YaB8CmEJ8epUhEWpcIShWyRi3hHbuZk+CL5TSpFcVelQPGj+4h4tAWEdz+65/bUHciay9LIKHd7K/2aCxPmgU0nUk4JktOpPtM+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnzZ/EMXmwmyVYmmg75k0d8wLAgRIBkvjHzMi/iYfFE=;
 b=okgoStHy/3DXQqvY0AF6s7MY2uHJnHSDqsRMFHxq7HgSnfUnQgC/5nT6dej8M/Wu/QE1HXeQuW2202JVRu7cyYn4tXJQnuDGHOeLgb15K9B5VgNHMgeqVHaqnkjQjdbId+ZosVli9fafVBeVhBAZgg9zj1LgCROPzq6ck/1LRUriM2oUWaJLG9L/gbXMc5cme4wdGx48Nuk/ROPCyVEdLyI/bIzri4uFZKxPFdqwnxKnlYMRxj4LoC5lzqW091hTSHES4NBdENFOzh3sAIH9kwjmNzW5630eYNCFTEguggkq2ACBcPX3RVPyYJiN2yFzl4HxD350X144to28dXfQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnzZ/EMXmwmyVYmmg75k0d8wLAgRIBkvjHzMi/iYfFE=;
 b=FvwFTrGoyGGLiwzG9IShtYXMOT6WhtZ4JzsU6Yy44Lw6FSL9EbH2GHn/A4YBOkoJZ1Bv35ZiNT4+AjYPWET9Jz9i5jVJbtp1UGJQO7/CluFSVRmrOlTGbDo39Qy3IadM3d3mZE5m1w87HnxsMUbCIoXjJRLKDC/A7srmcMYh620=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:46 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 06/11] PCI: endpoint: pci-epf-vntb: Add outbound MW group commands
Date: Tue,  4 Aug 2026 03:04:33 +0900
Message-ID: <20260803180439.1963864-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 3577d31c-468a-47f3-3520-08def189b3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	z3mhPCczfLnakJsyLGsHnOV/VqMfJZDxDuQFozL1Z6RF9PvmjVuBX/768k1ZbVHYHTFDODVxWmVfQSbrKlG5xnk8aafbsd26BUePC66mi0m3vG6P7VySb12tNJOAu3TeNx/8pXO4psZ8QFeBmc27e/mW/BfIuaWd1Bn7TAMwwf9NmDpIbqGcdRvjo6+mk1XNsLRwz0c6YLYNyi4X/QziQ0VMdMGiKhbkJWoQRWtzPD4MA3BaiJ4BJ62l+QYk7WkVulqYm4/fUZLcNFFhG9OZgTSWttj4ZltBbnjjeLnWKuX/98WfTjnmTGXpfD6Yi5EwdYsgZ/k+wKPR0PtvzNYHgARXX0OtKsg/nxICCFNMKe/p2SmPgFUEnIdlq3ygxDLowjQquZlMQvUK/JxIxddYMCvGkDMWtiOcBw53UW3pR2HnKkcSKbVRp7O7essMDIxcY3ts5EJ8LH6rj0q2al6jPhyLXu4APLMbsRqWijaYWwd+cOsFKIoXgI07q64wdsjlsCzDGoWaWKzmOfSn04pSstqB4tjaTfi/GsrEMHXFwF1Aj9PMLFzTC6Od6DUlqwFRpYrVn8M4J0FUaRGcBayRc5VA0vj7101VrVhXLciuxpOYKGPRklo5VK/RANIFS0XkaOKMLk25cvQ+AFsrQTXffm0+iMq7LM0UN6ZOSmYXrwlt5h5d22QtSurGboMW7fUr0uPgAR44l55BzyIdMJFvlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5DG+W6A5RGdncaUoukRO+aJkV40RMPu8f9t/KpPjnajm3m1LlmjTcRu1T2Y?=
 =?us-ascii?Q?K6tRNyb/FRL9wm/KfvwBhrMf+zcC/buzFh1l0nn9KbocjwpB5qMPHs0o5u6k?=
 =?us-ascii?Q?iwQU/FzH1h36AUAqziBhchcwin6Qz3o3koyej5JgdkrRUvmqUt/anIHjmhgx?=
 =?us-ascii?Q?ruXcGF9P0c/fomxujv5U5b+sLxjJjeiL3JxT83Yzj5ZnjQ2TzUmNN/cMHHbp?=
 =?us-ascii?Q?opuVFD5L9BAgTJY2GLhMlaPedn7FWivG6mTpjS+T4Vhl1KC94l3U6UCfV3Dx?=
 =?us-ascii?Q?iWss2Mz+1MrrnB4aGifUp1tuxhFklx3umkWSckS8Ezd69v07bw3VgClfYqh3?=
 =?us-ascii?Q?i8wi19OBiTaGbPvD5xlL1RWNdwksDFxp+qbOrDUCWGj5pqAtIq8X8Tm0FisU?=
 =?us-ascii?Q?JBS7dhkHKpEULQacd0j0BDdcl418qdmntSRDRXYx2F3MW4hTQ7MfPQoVyHME?=
 =?us-ascii?Q?cbL2rFBQGvI6xaGsCGI74MQJOm2Ln3u5q4ncKaj3MSdCkunLS7sHHMvg2wi9?=
 =?us-ascii?Q?20JgU3h+2ZC9xMCxnUnQ62IOAFQj/ZE5lIEG4I8BkVH14oAxg7uj63mYybxq?=
 =?us-ascii?Q?nu6gXkJvHb/4yUxfUxAOAzFWvwf9t2/k78JA8/x71Hq2VT8eGwJ3PchJjOCj?=
 =?us-ascii?Q?OZOevlfr8cf16ihd8AqWT8gE32ur69WvgSNwUf6iBOna+1llyuNCzyqiUEyf?=
 =?us-ascii?Q?xkghT8kum3srq5fe7w5m1y8UhYZ3StjQtNNkQWN0cNfGIAL6wOJhhHzSG3j+?=
 =?us-ascii?Q?pBHt9/iFdiTScEZNuGesgoWJY3ozt6wN16SXAhV2kXQ2cdDqvLUjxMtBQpqy?=
 =?us-ascii?Q?fVYm0tYrbTx9GgSuBo1OpfuUw04PyONjtWWvd818mJ+YP0/YXxCaqWL9KDek?=
 =?us-ascii?Q?IKLOjKudN2Iqg2EP2eeE6+q1LmrXxIMCmdJg1uyjHPP4qyNmqzLGkLt+s3Ov?=
 =?us-ascii?Q?tfMNdfqNacMxMy9DzblRuZXrk4RRi2jjGjv3CAYlJlQnPCvYDl0QLrvQfVJ2?=
 =?us-ascii?Q?5aybS0dabBZtkZZopwB2K/5z0rVgXe3N20sdhj86WTk3eN4t8z1hk1Zhk3Iz?=
 =?us-ascii?Q?P5zVCMBDQUF9zA41MMy9qtYTD482QUqHBVKs2JNpI7qEW9/qJcuvFgW0MzGe?=
 =?us-ascii?Q?krg9wirurbYxhDvbXpxxkiIF82h0soVn/rqHHb8B3vom+B/1hIbl4Bt1JPzT?=
 =?us-ascii?Q?1LAnhzW0urOZyxaopp3YHmPtnX88KwX/N5mc+SVaWIBknDaxLIT2luR/HnSV?=
 =?us-ascii?Q?2ZLyHL35WhT+uRkD/7mdGKBewpA+V46GVdDpYf3xG1z8ujEIqH2mQplKH2XG?=
 =?us-ascii?Q?AZAYCQyCxH6bslXxo/j+jOeCDkjTkQvSQOQQhNEd9u7Wqrz9bYlvbGKLOCX3?=
 =?us-ascii?Q?d/gQaANfD5GQX+fEqsw3NWHbCEnppNau6DvFZB4K2BxOKyBRKSUJyhOC1aUl?=
 =?us-ascii?Q?FjsD8BeptR8A4M/Q5ipQnTMR+A163UfEIwoqL+Yqe40Fn/IzVakwUV6UpEnl?=
 =?us-ascii?Q?/nFLcNmuJotN99Jd3gTT5Yb90BCuYvsdonqHSfTMNZHUqtK9SmuFKjM0wyWc?=
 =?us-ascii?Q?Mvinosv2ZFB2xX3e2XtN4wo7wBWbkDg3ncL2rLIzv7uzDObZlZrYnrs2Ta/S?=
 =?us-ascii?Q?/JIvPYVYlhplCP1XM1WuhxRqNxzafYttTYx7wLHag6LM7ZJt639y/lBbMkOF?=
 =?us-ascii?Q?72Ei6XRPkSrKh7ey/yCd9TAB7bUebNvYi2eykOMWb+iP4gKI/yI496300Cty?=
 =?us-ascii?Q?k9z5U/FZPyyjb/LbsfCIBtVYmmGX6HGjU8VZ4fvSeKUIOtnj2GxU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3577d31c-468a-47f3-3520-08def189b3d4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:46.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pX3+amvW9vPZdlD83U0HofUJYerEImzcqbY21wtS5FoD6BsgdUEGMF4Zos2ipJD/8NiPRsvSItZtItXLihjm3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

Packed logical MWs share one contiguous EPC address range. Their
outbound translations can therefore use one mapping as well.

Add commands to map or unmap a complete group in one operation. Keep the
existing commands for singleton MWs.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index aa8d304fe861..526cc31d9435 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -56,6 +56,8 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define COMMAND_TEARDOWN_MW		4
 #define COMMAND_LINK_UP			5
 #define COMMAND_LINK_DOWN		6
+#define COMMAND_CONFIGURE_MW_GROUP	7
+#define COMMAND_TEARDOWN_MW_GROUP	8
 
 #define COMMAND_STATUS_OK		1
 #define COMMAND_STATUS_ERROR		2
@@ -319,6 +321,50 @@ static int epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
 	return 0;
 }
 
+static int epf_ntb_configure_mw_group(struct epf_ntb *ntb, u32 mw)
+{
+	unsigned int first, count;
+	u64 addr, size;
+	int ret;
+
+	ret = epf_ntb_get_mw_group(ntb, mw, &first, &count);
+	if (ret)
+		return ret;
+	if (count <= 1)
+		return -EOPNOTSUPP;
+	if (mw != first)
+		return -EINVAL;
+
+	addr = ntb->reg->addr;
+	size = ntb->reg->size;
+	if (!IS_ALIGNED(addr, SZ_4K) ||
+	    size != epf_ntb_mw_group_size(ntb, first, count))
+		return -EINVAL;
+
+	return pci_epc_map_addr(ntb->epf->epc, ntb->epf->func_no,
+				ntb->epf->vfunc_no, ntb->vpci_mw_phy[first],
+				addr, size);
+}
+
+static int epf_ntb_teardown_mw_group(struct epf_ntb *ntb, u32 mw)
+{
+	unsigned int first, count;
+	int ret;
+
+	ret = epf_ntb_get_mw_group(ntb, mw, &first, &count);
+	if (ret)
+		return ret;
+	if (count <= 1)
+		return -EOPNOTSUPP;
+	if (mw != first)
+		return -EINVAL;
+
+	pci_epc_unmap_addr(ntb->epf->epc, ntb->epf->func_no,
+			   ntb->epf->vfunc_no, ntb->vpci_mw_phy[first]);
+
+	return 0;
+}
+
 /**
  * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
  * @work: work_struct for the epf_ntb_epc
@@ -378,6 +424,14 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		ret = epf_ntb_teardown_mw(ntb, argument);
 		ctrl->command_status = ret ? COMMAND_STATUS_ERROR : COMMAND_STATUS_OK;
 		break;
+	case COMMAND_CONFIGURE_MW_GROUP:
+		ret = epf_ntb_configure_mw_group(ntb, argument);
+		ctrl->command_status = ret ? COMMAND_STATUS_ERROR : COMMAND_STATUS_OK;
+		break;
+	case COMMAND_TEARDOWN_MW_GROUP:
+		ret = epf_ntb_teardown_mw_group(ntb, argument);
+		ctrl->command_status = ret ? COMMAND_STATUS_ERROR : COMMAND_STATUS_OK;
+		break;
 	case COMMAND_LINK_UP:
 		ntb->linkup = true;
 		ret = epf_ntb_link_up(ntb, true);
@@ -388,6 +442,8 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		goto reset_handler;
 	case COMMAND_LINK_DOWN:
 		ntb->linkup = false;
+		if (ntb->packed_mws)
+			epf_ntb_teardown_mw_group(ntb, 0);
 		ret = epf_ntb_link_up(ntb, false);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
@@ -976,6 +1032,9 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	unsigned int count;
 	int i;
 
+	if (ntb->packed_mws)
+		epf_ntb_teardown_mw_group(ntb, 0);
+
 	for (i = 0; i < num_mws; i++) {
 		barno = ntb->mw_layout[i].barno;
 		if (!bar_cleared[barno]) {
-- 
2.51.0

