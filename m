Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231B3911DF;
	Fri, 28 Aug 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936992; cv=fail; b=BHrUb6i6Ludv+vxQxZVEpC+SDVLyFLrV1NoQFsPD/WZ6rOtno1Poi/WQVmVx0WZHWflemrF4TKA7tw5E3Eev1JdmL2G1VniReY7X8EXsp+d/ufRWgKCZVFb6f31prfcgZDM1tjVeqx+0ovKuVRJ0r1Mx4BwI4AdF+IZExiltRhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936992; c=relaxed/simple;
	bh=h1t0BP53j6bFJCvqDkj1mRsCr5FgWex0Oj+XnUcifQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAxbTzGYXI+tGtjxy+sk7RD2J/Km2/eKylx9RLSZSysDh86hXol2kTVerIwQkVR8Ylu0k5RldsdrWwqjYJ40HCWHi0M+TyQvquxvZQlJf1hd6AHnHWDwQU9rI+cOn9vUPkponNcLyYE3qRYohF/KZjc7E7WC4Zh12ynoUeI5j3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NgXoW2Ur; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NgXoW2Ur"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mesOwGK4R9qK+8CgFvYCxjB2Nflb6fGXrVG7YNkjAeV/F9eoAMgFzYuE3M/PeP5VRqbyXbN8foHgEseSXrfgZKKvh1OAhtTG0cd8krL1+BrzLVHXeHrKe8EG5KE29TPVA5M4aTA6FdcSr8x1OIta9xnHHt0H1CZ1P5AKuPEzGxPHyTfW+Yeu6okHTdVJwJf9ZOvTRFIv8+BlmYkhMXhtyf5zviE1Pm24UcxqIGUrVQ+KBVCXwYZJBI4MljIPp23jNjUs6YdHT4G8AR6/eczE8TLaU/wbcTmFJUAOu23ZyyE94xBIpLeU4Hc1U7EYjoaolLT+9O/1TYzT+B3KHiX+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z+T7MQVevWvvdP28H8enXw1E6m20FjFnzHN0aFByiA=;
 b=RhgYCI/EUcwoEdJU3MsWTH+3cS14Z/JXB2vgnvT6rRAVQ3M24nDfG98kAWqXcLsJ0w0n6QFPLJLjDM6OL2OHMJA9dd5hsKdkZn5OK+gJEA7XMNuH+KyHBxzey/pT5WbG4evzkBSEZz3OUEQ17qusdqf80iU7GmjUG8mVEkuh45VroQKYlxNpd9X206gGnu/iT383QcK7K3hZpqzIpVRs+NeJb9IyTW7xUM6R2uoOgekFoRZUBD1A1aOG7q2nszPlBAGhPkB74PPy7f2PPwc77/L6P4+5REJ8W76dJvUJr2qa1DXSElnmIjeQtDBKGAZxnatgQcfCyRhHgCJXFsDUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z+T7MQVevWvvdP28H8enXw1E6m20FjFnzHN0aFByiA=;
 b=NgXoW2UrtLnU0m9S5cpUPZqG5ituuRyHwsu9f1LRw4t6xRihLCmmcc6wfJW1cZ35TOZiloFdueTT2aeqy+gRUZbIxLEVzSTavwHixEO60hJ9A2MDmOQE3sRpA1PNdNk0N8vfXOWxy2nLe4xcxkkLk1kMAtx0KLDAaHU/TPBykL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7951.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:09:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:09:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 3/5] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Sat, 29 Aug 2026 02:09:30 +0900
Message-ID: <20260828170932.2735807-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260828170932.2735807-1-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: f25a7efe-ce8a-4fae-9224-08df0527264a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|7416014|1800799024|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vNzSKjrjdASEF/xnbPGWjBNrYqxByIWk9FhzFZsRJI+NeQN29SQIpUw5tFF9jkBMu58EjZqxpcLNQTDjfsGxl1MexGDm2xNNqYxU0HIiFnlST6dMTJJIOzv1iY70PAQfbu7aB/15K34UcE7AWkNqW9C8YBw6RRrn1xDiRejdee8c6D/YggMzU3vUmerqRU87f4ksnLKFHj23fcQjdNZUOFQK5tILPUUaXFchpvjoCVwJy75h7AydRcSja0xW330OcxrIn3pkt7lBW//EnFTfFrlgGCL2JrcRphCI2SQjhiOHhZHc3Cn+nOkZUjHKjSxBgsVEkanrKPn7ZedUhzX3bl9FGnPIB9i50S1uynv3HJ5MA/H13o/8LfQxWMqJEvmJofw2qnefTP6GRbL4aDSPqOA5x9s9ESQbv76QCzuI8Z2D2xl+I+xzpEYlDlJViwAhWEdos+Co0MIhs4REgKUoy4jkkKUaPA6gTVDmCX5VZhFzj4X0Rj5HnIj3eF12r85t91Ya0gCbhmnONambz4U36vvp6e2G8qnE81yNnCy+yVHDnegWsBc6IJjCLAB50rqWUK3O3v28NDfrBVFOaf59F+WbeSb6bGq2uWoKZ7k51t4NBQggzqr223JQ0V/CB90xaiIaMgCEPxiPNP91Y2CW7xDnjPxG1166AWcgSlERdN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nlQrYnGBHLnKjODXuePGthtDK2iP6kYbnfMYOjmTLoSYBn8pDG4knD2eRfjX?=
 =?us-ascii?Q?Jc1okcmuPlcPaJMfev7FjvNNquvqOw3+jrrkleSKEtW1QvPdL50wJX8KulBj?=
 =?us-ascii?Q?KDlX3CZkUQLwqGVAzXeOHiH8tUY0B4kvLqnfRBpLbGkySs8osdvI9/yMIB9O?=
 =?us-ascii?Q?D8J4Plxt/ak8unyTTdmYhCK4M3DdOrBXOKYb30DkKN/qbpU3DYWobqCwIQSk?=
 =?us-ascii?Q?GFtm3V2VRhn6moeTi+I0XNIdkTpeOn5HQ0Etl9cXM/RAdHS6DIiTiI0fMz7B?=
 =?us-ascii?Q?9X1xLphH6OQ7uXM76knvI/lYayvvVohZ6FQF4351qZ+dtz6aos8dOk3+sHCt?=
 =?us-ascii?Q?BK0UmXXBTLx6jeHaWQ/6M9AwWc08ifwHXekFVrl43GQ/YhuaZgAWp8YbYZXk?=
 =?us-ascii?Q?Y59Cqk5CXixgtFw1dFoN1W9s1236eVYPCBAEHVkrW16EK4dDsdiIJtAwtSLx?=
 =?us-ascii?Q?MQ4M7TzC+elpPKtLiLs7XxQAll8O4DPRr+U7g1iWpvnA8W7eVojPCz2YrLig?=
 =?us-ascii?Q?Ch+LuUZN78/ty7oe7IGiujk7r2PW8oBJ40/BG6pzKd6ObFo0U1ntGfEd/WKW?=
 =?us-ascii?Q?mJ1q2dOAM0vTB72QNWTuTzKzf7NJVGSKzLlGaA6fTGk8hodCGF1lwrPto2Ch?=
 =?us-ascii?Q?3oL8UbCeRRrOq6FobA238UKNb/eOGZ7vy2mXG+450N3wpNRBwcSBl90MqvhC?=
 =?us-ascii?Q?YdBFfY0JmD/aJ/pV/F7BAgnXCw59H3Yk9pzb/AhNJqXcpZ3ntvQ+sBODS6Hu?=
 =?us-ascii?Q?jp9lTtb21H0NcutSXltbq60Q+pjGR+adUEuzwoihaJ/uVYjOWlRwviB+dPwd?=
 =?us-ascii?Q?eyQLAflIfcyb6Ejob4nSfSIGpBqQwbVn70ZqBwjUw1irnZn8RlWnbKiCajWt?=
 =?us-ascii?Q?5RGjs4TtE8wCCoTI0nR693iaOet8PIwgshSYLz5XXB2Z6Wb4etwixzx7NWvk?=
 =?us-ascii?Q?2Xd4ujuiEBQA5V9FVPy9D9TCnFEYigEZBeR9EuobOSsNEU7Ky5OO8WYnZ6a4?=
 =?us-ascii?Q?5aZzOAEY5xM1h4OMUEUCRuxE8aff7a92feHiD4ymXRoff2qtW/XRqwanCSA+?=
 =?us-ascii?Q?i5KYd4hDO2MykmNKvz5cQczz8eT/J+hSZgVi33t5AWrxPMf1HWei2YMJUSSS?=
 =?us-ascii?Q?E3b3j1qwuXH5TyubdxGnIo5QPth/0ElJRBWsDMkNt0bfX/DXV0s2SAVLWRLb?=
 =?us-ascii?Q?tL3lwRlDOVYKA61XDI2do3xrHm1vsXs16cztX4oV7Kisjkvyyr0rNpuOYf2E?=
 =?us-ascii?Q?5HW2xwo1sjYNY66A/KfHKKn3gnmzH58mgOBr2VIj4lnSImtoGDaKldWoGFDY?=
 =?us-ascii?Q?EsfiDcH4qwSbC3f4ZPzxRk95mBCJ3ecc4tUV9V0aIhxu5FSerI2Wszbuc29T?=
 =?us-ascii?Q?XhC5eIJHRVFTtcFvp3j59KJkMgNWKvA5Ycm8FmvUNcURanrKCvnjcqogerE7?=
 =?us-ascii?Q?AqlarsuotZi/mYPcMzJFdCXE6ITR+nQbs3ZCrIvnZ6qDAIC/BdDVJJ5ejcxa?=
 =?us-ascii?Q?kZh+7EYNp/5fidSurENdafay6sEdVybOw8cdwlsXu+Bekh27S5rKd6AlzrWa?=
 =?us-ascii?Q?bD6pqwuw275VO1LSLZxagig9iyhQ66a8I8OpK8F/bihRL4uV2hDMqTPZjrVH?=
 =?us-ascii?Q?/5NVxVXPnfTC4G3Clq+GwA31v7ukzO0AvjiyR4uRHWVAvH9pCzbRswSTusti?=
 =?us-ascii?Q?vrlXbaWbKtFobv8WICA9YqhYjvS1afxQ6U0qan+qo+oh67Uhng0fPQ/xugJL?=
 =?us-ascii?Q?fJLnelAipPl9ns7VQKEH1Z7LooCB5vubnRp/CI7oqymoItPpzmqu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f25a7efe-ce8a-4fae-9224-08df0527264a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:09:41.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIWMHnIazgae90sjDbzW6QkJfmUWK0w6xyKrC5IsfV1fkvZBhXrN0Y5SZru1T2QnLmlhlrpyT3gwQdExQqqH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7951

Move epf_ntb_is_bar_used() up so later BAR selection code can call it
without a forward declaration. No functional change.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c3caec927d74..d12d134ce553 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -199,6 +199,26 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	return 0;
 }
 
+/**
+ * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @barno: Checked bar number
+ *
+ * Returns: true if used, false if free.
+ */
+static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
+				enum pci_barno barno)
+{
+	int i;
+
+	for (i = 0; i < VNTB_BAR_NUM; i++) {
+		if (ntb->epf_ntb_bar[i] == barno)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -830,26 +850,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @barno: Checked bar number
- *
- * Returns: true if used, false if free.
- */
-static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
-				enum pci_barno barno)
-{
-	int i;
-
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
-		if (ntb->epf_ntb_bar[i] == barno)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
  * @ntb: NTB device that facilitates communication between HOST and VHOST
-- 
2.51.0

