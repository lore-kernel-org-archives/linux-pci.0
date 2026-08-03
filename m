Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020095.outbound.protection.outlook.com [52.101.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03086431E6B;
	Mon,  3 Aug 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780296; cv=fail; b=pGibgkk1YnCD1Ks56qMFx5ZCnM1ZdY5YqnjQ+fkYpcwTAj55gyQ+jC9jyPPA4WZfW2B7YSl4ZjOsQlkdJdqKAn5VhJ09aKJiHkoxm9kIXYQ0eg00fKPgQB/6vFtdazyKtOKyboZ0P2wVWUoBcjiYZ/5HgP1woBrp1a4r+lYKVSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780296; c=relaxed/simple;
	bh=8M/qHzWAnFmZ3liuFJsaaDCHfF2TNU1Od5SqvS4GcEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uCwQBDIp50/lVjDKD6xZ5xXMI2rC6Li70ddjcpTWOF/wLDZKJvCBkRbOhJCtsw4e9TZUyZ0YtPiEDfFy6mV7EpAykqnfVCbZCms8i1ByYWDZsf/TMvq/sPjQ61o4ak5Vl2RumrO1eIZFuSmDQ52hU7EcVnLDt7CQb6U8jgIVDdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rz9ETois; arc=fail smtp.client-ip=52.101.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rz9ETois"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD4ZTeBLDFvuYjArNz/bKJrdU2ABd41FP15cKo7C674E8Ghcov3upF1ueWQZ2Qwn1+X2v3G3h/iBTqEpOPUqOcnMeWPbeumBE34rn2kGkZcRVcS7NWOFpSr+dKn9uuF8UqBbbl+2GkJ/4s2EGDVztfnSkoZFmlnG1DznOxXBPpoXQYHf3X/Jb6F/ZrC1iFKMxshDekk70eRPzTsGuLjBOs136YNqSfrlQRT9K0dVF3y5v1jcshswa2CSc7qjZj8Wx2Mm+rFtCqFkozPx7+t8H7O9n4skbVMdyVhApGM9YR3s3zBFGdK4/iCHaUcP3cP/EfiJsLQZZ4OXYpNYYN/X9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LHf2c7wRLd2PWPT/vwSGSJTGvEWKNQOgVZtvoqxlFo=;
 b=rI9TLBSllmPU6B3iPpWjLuF5aE97VApn2IKY8Ds0UC5oH4kJtIfHOwp7fmtLWcZAnhRfkWTLjtDVZ7vBr97k9aC6EUxOPAhcT5UKEDwGkqXa0axVJbLmEQ39rLLOkcXNNstduzLzy9bUgLzdxRCATE1E5HNZYM51ynQngcssoCgiYfpOKhIrPA0eJE3TL/SNhZRA2AozMWMYw5StX3ZjEjn2+OLtHPsQ1Uj9VuUspacqCPdMJEBmcx1kQctY3e4TlTaJiwbw/TzM8YQ8F9mYY4Fn94oJymQzlMdtZ6ssTjaD3jwQKseOPiU+I40NQ8tDt6mOFfVL1JGKXIBw9mXvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LHf2c7wRLd2PWPT/vwSGSJTGvEWKNQOgVZtvoqxlFo=;
 b=rz9ETois7Ug2RM5ZDiUv7X7vYfxrSFVXphnsxDRzZ/N00HZ0QiMIhjCb+s6NVwGZqlEjmFxCQbrYLoV8huFCa07x3Tz8wI6+NAqVbx6o1phjwt8PPgVmte4FBfjbVaGbnbR8Kc+z3KytwF0AZIa2NAh9mE2zr876HxiUcEZjVvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:48 +0000
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
Subject: [PATCH 08/11] NTB: perf: Reject grouped memory windows
Date: Tue,  4 Aug 2026 03:04:35 +0900
Message-ID: <20260803180439.1963864-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dfa722-1a74-42cf-0c0a-08def189b4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iEckVs51U2sfvyk/1Nhfhtbj3Zi5RmONlXf1LNkKg9H6vh1Ltro31c9gKlaIfFSPWlV6l9Cy0s1+kYF62F+hdRmjH1rR3VOThLt5O7321403rFYxGMKMv0v3z91WiZMUGZRbCJxtzfyDBWsotLMqsFfOUXzi5Bw4kDr9eJeCm2Yf0gFH/yBiKETuZpJs7E6duJHsWC0hmFfN/QdFmRb2HWUip+5VauyfCOeL7VIQfKB8b7p/XQ6nDoJEuOY77Ugh28LYHrVwdmHCW/rpbwi65dto5T1m56OBRietsVeNEj9kljpsKoyCP56wucS/LawSWGd05YMLYMdJ/5b3sZyO6cLIMHkRvyxlXShhbtZC78givTAZLBPVhpwXzCwQYSjTk0pT4ofvHtR3+iwgD6M3jmluJaCvNerM3qfeWTFrvV7M9Etc19ct4AKEz67ZrJGNzbqPj3xr25OYelgGEE/+/kMxJo2vsLoUhycSkoqrcEBsc7kDjSH3Y6g7fnpG7E7YlheMKD57oRoQwq56az+0D1sKRUERcCmmR9bJUs1vbi7tdqYOurlVgXmT8b5GApfAlOg4+ctKY4wTizxqLfLNAfxBKFphVuWoprDWDPJUoQ/yRD5sWWq3meyoyUTh8czH49dIkJjAfgEBZTtVUUMScInIGI+m93rGUP8I0NIPwhpMgPQow+canHQ85CI6aXPqI801IQz6afEqjTyjv0gniQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjYUIRguzCx8cT0Ov6VdGD7W75CHYtaW7ofulxUjcK2Ry4kHrrkq0rHmiiQH?=
 =?us-ascii?Q?4eOw/3HasBdMhuCOyjysz/FAjY3S0rGcG2sRe4lcRmxBdimDKPa2JE6rvHmE?=
 =?us-ascii?Q?R/h1IJHU4+micVPtVGdKQa1KgE0HJQwhR0cJ0V4oJwsCtFkuDjJtZIpb62+q?=
 =?us-ascii?Q?VIO5RL7MDx6LAmGE7d+7sdFJG0TENVR5Z1DwgyjX9CoaJQ8QwCPE5qpFSjup?=
 =?us-ascii?Q?LeQ1+DSePJVpURnlg1ahiGF7RLOFTiYruusxa+ViUykwtA+rURC30S2S79qG?=
 =?us-ascii?Q?+oq4KisD1J2ophvCULG37VHB8K35MtEhe4dN33F0Gr4jLETCwGPuuakXGHFE?=
 =?us-ascii?Q?JO8dsrsr6eAFB7ndvUqgx9pTXgaIcIcpKr80VQYUP0EnIZv/OSqj3813vQx8?=
 =?us-ascii?Q?xZYNO4ck/tv7+fwZbR93B0ZbKwO3vSeqMQksuMT6R5m7lwvEo7dnVdbKq8ij?=
 =?us-ascii?Q?6CRso4ftSnyxwsYaEeGsIcR0N3ztz2GzTXUrqFasfkCVSPofiYbzL+SZ4zIc?=
 =?us-ascii?Q?RHxKRMPp0ttjY5YK0rix8rRy4v3DBe1qd13/W4C/rSHAyV0q0J/Lrn9kEkFE?=
 =?us-ascii?Q?ha9wrqcOQU1zG2oK9FIme/LmzBVGjJ4ncIFGFS0RxBIsmYXrKJqQcRa/ZymM?=
 =?us-ascii?Q?4i1RFUIV+etEntr4vaBUw4ILtP1CLQIMerZZIKZ8NVV2/7FVbh+gSpXdd74u?=
 =?us-ascii?Q?WimhkPfGnux77LYNQWTkKNRVYgyXXBYIhLrkb0SMpCkegO0Frap8Lfy5oPmj?=
 =?us-ascii?Q?f0X8/GN4rI1jFimWeSn7QkCt6J2M1HhT3glQZ4CCwiPULtQAvrPaIwSf/RWC?=
 =?us-ascii?Q?RaAVYeUxA7zOAyTA24apaD0RONJcwsDmFflLvfaMpmP4sFVt2ArI8AryTYbt?=
 =?us-ascii?Q?ocpx/THQSOJ0/c0gI+EZz0Msl9V/3FrJKkgT5j8xGdMPGA5h94tBZhnpDkXP?=
 =?us-ascii?Q?mJREDW1ns5GQ7SP0guZeJ/IHDXrUxY0BuHILTFPIm/KxbgJSWkhmIbpm4qIN?=
 =?us-ascii?Q?FIPk+bpteuSqgjJ6YZKW/pEwmVbbQobJzSg4PW3At1bfIlXyGnxc/H3Hsopy?=
 =?us-ascii?Q?zBtyvTGEbcgSFxiGLRKxf63uLnhf+ML6CESlWzRWDJqt1+XmSrsWkA8roDI8?=
 =?us-ascii?Q?WB80LPStXsVorcLcC2qOAAAUS8ZTtpTRpoK8XE5PD11vrnQCeai7KfEeoz2d?=
 =?us-ascii?Q?VQL0DrNgGapSmu9NiIp2GR3qYcKz5IPZx24JUIcTf9DYwvmgUqIoqIci7Q1Q?=
 =?us-ascii?Q?Hq3yZdpsFKS3BxkKY6B9nZ1isG6/NYQuD9iM5VykbRBAC8JX2r1APojqxuTR?=
 =?us-ascii?Q?ngd6PRdoA9kujHckPHCGTAtlga76EmNckYV0R1INr6UyGaJ6p0Lhqa4y/xvX?=
 =?us-ascii?Q?nhPvmKASC9o0tWgjuV9iUgkf0W1bCq5pMKutPOALr1rp9sljldQTHyANI9QV?=
 =?us-ascii?Q?fBLfAx2zRfoV8aGF8xXyxwQgdNky28WgBHedPACGX5T5gUAxJzlkcpX8xKdU?=
 =?us-ascii?Q?+m8kxFYOvWjatrpwDbt159ZQ9IjjUbVw+hFKpC4E8z5ZD312IFG846LhG8gk?=
 =?us-ascii?Q?bTchWjh8HAvsU9nbYvFWw9oQxrRzrvnvVX9DzubEvccrF5GoCTdZ09ke8dhJ?=
 =?us-ascii?Q?MQgZL9ssNFU8/o2zSXxD1SCueiUrcrzl4kRlpvA2+g4Sj52SoVGThzloSaUO?=
 =?us-ascii?Q?wAnuPLUiYlTvl7TFNql/xKZuytiyN8678js4P/b7EZTrlXcRs6QBYuvps2nW?=
 =?us-ascii?Q?iCAgg10gGRel9NSB/Q5Jf5/JstzO9viQ0mdBvUO6veWcSLL7qOLJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dfa722-1a74-42cf-0c0a-08def189b4c8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:47.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5NAOZwZOB7JfwWJbioW2KdomImDREtKh1U9XlOyKAdFtKkditdNK75mrfGZnTv1cCtMk5XbVCuTxdd6y24KTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

NTB perf configures one MW per peer through the per-MW translation API.
It cannot configure one member of a larger translation group.

Reject such layouts at probe. Otherwise, link setup cannot complete and
a performance test waits indefinitely.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/test/ntb_perf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dfd175f79e8f..50bfbec1e251 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1436,7 +1436,7 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 static int perf_init_peers(struct perf_ctx *perf)
 {
 	struct perf_peer *peer;
-	int pidx, lport, ret;
+	int first, count, pidx, lport, ret;
 
 	lport = ntb_port_number(perf->ntb);
 	perf->gidx = -1;
@@ -1469,7 +1469,19 @@ static int perf_init_peers(struct perf_ctx *perf)
 	}
 
 	for (pidx = 0; pidx < perf->pcnt; pidx++) {
-		ret = perf_setup_peer_mw(&perf->peers[pidx]);
+		peer = &perf->peers[pidx];
+		ret = ntb_mw_get_trans_group(perf->ntb, peer->pidx,
+					     peer->gidx, &first, &count);
+		if (ret)
+			return ret;
+		if (first != peer->gidx || count != 1) {
+			dev_err(&perf->ntb->dev,
+				"Peer %d MW %d is not a standalone window\n",
+				peer->pidx, peer->gidx);
+			return -EOPNOTSUPP;
+		}
+
+		ret = perf_setup_peer_mw(peer);
 		if (ret)
 			return ret;
 	}
-- 
2.51.0

