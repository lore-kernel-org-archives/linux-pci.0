Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866442AD2C;
	Thu, 19 Feb 2026 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488807; cv=fail; b=t2PrWtOiICFMRvG1t+Ch41tXqNv6L62DKnrteubVkn9VoObXNQqP87lj8qoSz4kSys3pSccIbl5Q2h6Gorh512U6ZfR8I9ESk1Ulj+m1xLuxiwUatQL0EQtxJ+wUqxqG0ShWiMNzkJChAqYA4d8zgfHacqxjUrzN3uUh0rCbM5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488807; c=relaxed/simple;
	bh=hFad4MztiKu+0LXbEpMdvZEsH5qtIJuJjGZXO3zcx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Leylys3LZGdumjD2ohO9exhD2YJHvsyMn6tVMX4k9QQOEqpCiIVOlbDaw2evAYHlNBsYBWWiajpd9fd6VYBDFX2Gwhc+efLoXWjnxqcEisqZdbpBMBrH8+hh96iIbddh9pemLq1FTHhxSnCBzt2KeQEiOOG/SSKWT0KY8S8ggHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SfOh8zi+; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SfOh8zi+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMd+Zmar4HBIWwDOyvXZiywuk6tAZl8FBWAyZ39n/GoazfPjfpQzDpqq5ibTuvk2BH/19RzM5bHtxPBqLpFVhJ/h5pFaaZtaKHdxDNjjhZnzFYW1D9nTbxJ53cuJdt3BPE84Ey7adtaWQKeshBMBE0NzmNF1zn7v9s+zF/iBq6QRnV+4E2PzVkPbXz+h7nKP9/Nmj2O8X1wxyaRcrNrFmX8LQ29Gc6b1ucxCdkMPip7AtopXJoTEycbmVMxI04DGJvA8mB3rgRQAZuMGVeEHQ5iRB4TbBMMNo+I9NErVGLlfRZBcbFdYTJfhrY6RkPi833mdBWeGRB0XxekCrnrh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpmGhyMNcJwLhX2yiUVPmrJAM89gDo/+2KoUeKhv484=;
 b=mtR2Q93P+U53r11nJ1TW7JdAtvriuCHcmlOO5IWaEm3j8k2QO6T3w6Tji8xifBNo/ELR2YfbZ40qvu0GrBen0wRRvHqIsRpjQqgPYKSKBV8gzIqP29oDCADl5sdozeikWtcFF/7R4fV/nHiq8iiANa6f8SgIXQpWwE3bNUyIjp71iJt+itYHN5NE5140xQ2+cuggA9lidO5aXvl9xRaBx90rjTLPxI/1e1Hqy02Luwuq0dvujYFZtE33BXHxJRPzeztk0czuEKUDlhdLzVu6HmGWX5+GOH/iTwAAzcnowY5R471YxLYCgZUTFSBh2ev52PsiyqAcB5UXHvJ44mF7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpmGhyMNcJwLhX2yiUVPmrJAM89gDo/+2KoUeKhv484=;
 b=SfOh8zi+6ZOmg1q4i5rIxTNIy6ti3OUC1+FTrubIGMuxivVo2xc/5r+ZjG6AacQu9Q702bmqtLZyypXZ0WFQfabJRlnJJ/SVIvghV8ahqZCiOxrVaYP0sact0t0ZBglDQo/R39TcX9i65ngzML83AwOOKIync78vzfal/4+ayQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5862.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:13:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:13:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 1/7] PCI: endpoint: Add auxiliary resource query API
Date: Thu, 19 Feb 2026 17:13:12 +0900
Message-ID: <20260219081318.4156901-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219081318.4156901-1-den@valinux.co.jp>
References: <20260219081318.4156901-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0059.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d64a77-e492-4528-6716-08de6f8ebf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yWV+v9kEFIECtHPaCQ2Zoz83trmmBq2yMGfeQZwiBUvn8KWt0tkPDHhYvE3t?=
 =?us-ascii?Q?a4W+wOOHts+qV7u4aitFxIJbSqFCDRVlCnBp/TA2Z7Ou/cGttGKPIKXqT4lL?=
 =?us-ascii?Q?iVW3CDz7osFxk2PrvmpPyfEw6ZLBfUD8WzJPSe8p+pqKMx6EF0ldvusGngON?=
 =?us-ascii?Q?X9f4BfsUfv3t2Yvjh2+FiZyZMB5LLtN9yNP3UJcIsZ+/6wjPZ5ORTclQpO7W?=
 =?us-ascii?Q?Czo1yG6DXiGw7LWZkE3Fo5dpArbNEl8hcWzdgKUGT+8XM4Uwp1DkAnqCK/2u?=
 =?us-ascii?Q?WsFZOPSBVx0YIWBfMPmVElZqssgaCtUrdE8xDYiJ08oQKovmy2uGleO0pYF1?=
 =?us-ascii?Q?LhzvllEYtfT8iBVw/UIzuFzoghawd8SKpe4a1CQvyDDZaFPSXWGN5ZkCoW8T?=
 =?us-ascii?Q?lEwwZCIVDI4lhEs2c3DdrPVT/w0FMcsTJhW1oD/VV7zxFggR52ZqtGazdqvN?=
 =?us-ascii?Q?mrWgMnJmRcLc6cJISqVJwVl3chqWhB9oaEaC9FRqNimj1lZvL7re9zpo+QRv?=
 =?us-ascii?Q?e4qXrmU/c2Ud25UDbz4+JPmm6QobHTeeiP20ohhhut6V3ym8Yg+WRZvOVavQ?=
 =?us-ascii?Q?mJqmVz0QTJcF4EVa86WtxslBUFJkXw0jCkF/8RT+xcxdPqRXN5dEliZDHhbE?=
 =?us-ascii?Q?60lwJ8JOuZd8buu+W6tqwazJYuN3WZeBcHfftdJa6xY2tqd5lui1khiqWY7j?=
 =?us-ascii?Q?+B6q/7E0URLghUfzmZ6kYPDuj5DkQzkk5UshBgkeK/v1QyIYmpcWsYlsgQdm?=
 =?us-ascii?Q?TyqzK98iRuSSS5gYvctYLiP3N0dry2pmKbu6uNy6PYef2RYFALhNk0EZ8Q7I?=
 =?us-ascii?Q?I3JHNaeXIPpdYdntNkZiti6071M7mLZtyiWeZfRMNN73aV6QjjY1KjKtT+lE?=
 =?us-ascii?Q?KVYY74FWC7ilre7BXP58W86YMGoVHxF33e/DDA6JdLYTGUn89ZDgpeUwza2O?=
 =?us-ascii?Q?RZcYd30iJDqsx1J5Bb04uCyQs51sVQLpPxD5NR96492P58cT3AdxUD21rMDL?=
 =?us-ascii?Q?AIMs+w0Fpm08nWqiQxdZVDBas3atRp3NPFI/5ySgnSIDbkx4QQ5JFnmllvYZ?=
 =?us-ascii?Q?JubhdQ23iMpkO3mp08IO92H0UQUwh0vyd8zegqO6rq7fbO+3ub+B5UmZXRLZ?=
 =?us-ascii?Q?nQWGVRluk8MChBUNJsLLHvqzN4460kdGZuHtsuyxf06v3X4R/01cyb8Z+fyo?=
 =?us-ascii?Q?TErgTVGaAnTxje7g7giYDs/b3VTHS/ysoOMxnl+v2ZCUdp8rFFR1hSu+tnaE?=
 =?us-ascii?Q?bTXIeg6VZ3GTDUrSrzDMhmnmcNFT19tA3Fmfn110/okGsmHM8mlMy6VKzfFZ?=
 =?us-ascii?Q?bdDkffUSUkibKdHQtW7/r7etc8b8FJHoWYaWYIVCa4nooAZrEAxAABoBDofw?=
 =?us-ascii?Q?u4Q6mlAVaV+/lPkkOkFHKMeltuIlZb0bDueBuptrYMV9towmWKiLQqB04utU?=
 =?us-ascii?Q?kepBPf449RHxqroE5x/Yc89bvv+AjiRy+OpaxMGDTc8TGVbbM9iqRshkMFQJ?=
 =?us-ascii?Q?EpJtGxeVZsMySHpLRpWIxQJW9jfip2wPJ8CcLp759LqAhsDAuxd2iIA9kpON?=
 =?us-ascii?Q?/BMuhsEXCBHsIjLEgLHpOl9tnxd59cT8orYhz2C1IMC7QF2F0t2uaodrvXTN?=
 =?us-ascii?Q?4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?61zfPxSidd4mpSNw6Is878Y1BT42QHXMMt6E93jPVeiBLEmwZhCMPD9k6ml7?=
 =?us-ascii?Q?hy3TRjeGiQDDWYCmKPa0K60+zXKBgqvFVZTcQmFJySDx4YXjp3cO+QcOq0e3?=
 =?us-ascii?Q?5jZpbO1RFp1u4P9RDb1FXb1XSryfp3nyx/+KxC8Q8xjqiXu0B6svDt/nxwPl?=
 =?us-ascii?Q?7zXpPhfBBKaZsPxb3dtq9jotcZjGCYft4vfRr3inJp16f36XKjzEgD5J7+/z?=
 =?us-ascii?Q?qqJRkPDd6/50xcKO5RL9HwmMrkCWuTUQbCFv1hqfq2fWLCWVHp0maMRHHMdt?=
 =?us-ascii?Q?NhwUpPE45Z8+VEsWn2ReQZOpe52yL8mXbQscwZGaQmOp2c0Iyeyq36YAmtPk?=
 =?us-ascii?Q?DzKpLbDJ3E19YDatlifRTIXoSe+A4GYtLJhAZfUAaakEi+yT0nP5JnT8O8vU?=
 =?us-ascii?Q?tdPVxKFXB1eVnytXj46wpxdElhPNXcM9PO8d7vzlRSVuxD+a9z8YgatKceNK?=
 =?us-ascii?Q?pEETDfX4Mkplrm66u6O7hDViyNVZWzctN24D+ioi0fNvK3w7NK2y/ViCJXZl?=
 =?us-ascii?Q?RHhag5wth77ZOU2j/5/OKej2emOSSW7885iZzCWmfwxERedNNBbrsrbTkG+5?=
 =?us-ascii?Q?k4+2yhAkV2MEIH+2MeaqZmcfOH4FFLcduKdyDZ8i1oRvaXEZlavB8XYbW/aO?=
 =?us-ascii?Q?5PYtinheJXiZpuGBQx+Pjj9nEsvph/77gE9rEf/zbUp1MxMi2OKSI8uL6Gbf?=
 =?us-ascii?Q?yoYvwbXC93xxXaZJzktbfUKHlLJSos65qaXWK4+8SwR1eGgjU9VIuPAY3Yom?=
 =?us-ascii?Q?5NoLZj+ehECNuFb9Dg8PdttNGw4xMkxP4hb6BlbFMc0SWettIudGU4DQRret?=
 =?us-ascii?Q?L8V5pzz1BclC5bByOcQ2szRips7kD2CVQRERjxrYzTxzXb/EvkG6aKwJy6f8?=
 =?us-ascii?Q?7G3MkWNb5xqN6uZoNyJOWrjZSmnltwKFwS0Ylo1aGwq3yRsIO/rdGaypIZlx?=
 =?us-ascii?Q?P1NTZFsZOcAOM1HgNL/FD6Os1w7UyIo+WMFdw3Ck2kh5Y9SSiqvJOIbRYKdE?=
 =?us-ascii?Q?Eoq22Nl9LAjYaZD/VKn6LaObXpIVefdSEElkqo1wcIfyjLVzkuNXKKcfmWDz?=
 =?us-ascii?Q?Yyg2HFFC7M/RVJg4dl616mxHHNCGA15Jp6/KcYAuu/FQ8epKn8OtmTOdNmlF?=
 =?us-ascii?Q?mfKGdpUpIM1Q71hbs+Jyi0iuYmYbXl2Mhc+4raieGqz+YYBr70RfnWwDnOtp?=
 =?us-ascii?Q?fjeqq8bl4slacn7JAtrek6FQ4K4Ebv559xHMqFyhJ+JAt58HR7GXWtWrBRbI?=
 =?us-ascii?Q?ql/petp3Fy+Lp0XDveSFeoa5Cpd/Xb1KU7mfQ7y8FdvPjG4HteIT+4v2X4ft?=
 =?us-ascii?Q?JECugytv47mi0x3nIRcEeGQVe/LLmqkL2j3xIYune78bAv2neQtUaExe6VDt?=
 =?us-ascii?Q?ve/CFzsE4A6wpbEkaaSm/c7tEH4P2ed78PCQdllSrjv2qKhHC0eOKvXcS5o3?=
 =?us-ascii?Q?il0onp2IlZJhlwqDj+sd4gBddE0pHRR500WE5EgZRW6D5N0szlhJQajuI9sx?=
 =?us-ascii?Q?pEby7EgGuSfDraWFN/uMNnXayFJxyyBQn85myvVdR0NllpyWSDqA4C7B/bnG?=
 =?us-ascii?Q?jh8xEKh/fSi24VY9XUBW5U6e25IGp/VbHjD0VSP8coaI4gDdLjwNKSUfSmx9?=
 =?us-ascii?Q?yV9SOpTMGd7+7uY1+N3K5NdCu+ZIw/C4aKcPBPYtaZdt41ofTJD6B7bTjJ+S?=
 =?us-ascii?Q?EwcIHDUvsFlkCdDc83ifG/mwGCsUHFQs7kXh9/TzgJRPrVfd5ELO9vr/fUG2?=
 =?us-ascii?Q?82FP12MYgBBwvHtea+0rxWqjryCAlxVEymEureYl4ApI4RIlyJKA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d64a77-e492-4528-6716-08de6f8ebf81
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:13:22.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLRL2UaDsdFCsX4Rw1WvtXhWbio6z9pSvNix1h6WJzOx6KY6fHIg3sUDCo0PwBsXGQxG8+aFoWz4qDDqStdaCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5862

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
get_aux_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++
 include/linux/pci-epc.h             | 52 +++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5045e22367cf..10bd392c4667 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -157,6 +157,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (!epc->ops->get_aux_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
+					  num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 8687b9c3462b..705026f64ef1 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,51 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
+ * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
+ * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
+ *                             controller register window
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_aux_resource_type {
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_CHAN_DESC,
+	PCI_EPC_AUX_DOORBELL_MMIO,
+};
+
+/**
+ * struct pci_epc_aux_resource - a physical auxiliary resource that may be
+ *                               exposed for peer use
+ * @type:       resource type, see enum pci_epc_aux_resource_type
+ * @phys_addr:  physical base address of the resource
+ * @size:       size of the resource in bytes
+ * @bar:        BAR number where this resource is already exposed to the RC
+ *              (NO_BAR if not)
+ * @bar_offset: offset within @bar where the resource starts (valid iff
+ *              @bar != NO_BAR)
+ * @u:          type-specific metadata
+ */
+struct pci_epc_aux_resource {
+	enum pci_epc_aux_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+	enum pci_barno bar;
+	resource_size_t bar_offset;
+
+	union {
+		/* PCI_EPC_AUX_DOORBELL_MMIO */
+		struct {
+			int irq; /* IRQ number for the doorbell handler */
+			u32 data; /* write value to ring the doorbell */
+		} db_mmio;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +129,7 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +161,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -348,6 +397,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

