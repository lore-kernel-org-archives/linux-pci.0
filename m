Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299111;
	b=fD9a8QljLUuWyFvVs3dGpOs+r1esUkQeFQv6ymmHKZJK/RtgIwFc1zF3DB7851dMSQ63
	 mAve3SCOcDMLIgj1RLPM3t5afx1VYayBjRF+9m3S8VALdhiBUlS4WstqSFTrVUVJCfVrm
	 iyt6OIrKIK+Ycuv5CFDtYTvTM+yCFu77SbE74uzou2hZIjMjNzqFFYlnhM8xdZ4wbVvPr
	 7r8HBENuRnCYc8k9BkF90dXbw1hKJl2Lg6Nyq+76pxn6cQsTM1Qtq/H9adIcEJ/sS/NYM
	 iV0JtX3AghSSQGmrYBImwh4yVdOJ4GMH5Rje5VtbVfxTm6o5bW0CjIP0R/LyIsVn+Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299111;
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
	bh=ldmlqC8XvzEAuXpvfeAXM9CZtM0xZvrpz+fX8S1U2es=;
	b=LT6EfBrRMyOJ2pSJen4suKH2Hv1WzXLXIvO0jUNd6az1RNLSWhOXnLsCSXVh6j8axild
	 lvTgnomzTu6aIrlL9ub4NtI0L8VehndKxyV3ETgy7+YEIPJMREBZPkoUIoSTGAnPnPo4Q
	 p/ieTXVX0PnT61ewhbONtaAdAOyFXNt4g9Ev4E4mg4P+Rq0nRUoFjGoYXXoTnMe8zLvcL
	 +vcSqi5j59DEhYEwIT0y5LJ/Vrs/FWgpPO8pGRcMVYUQkVwWQuJO/LdU6paAnFI0AtuQG
	 zo5TgZsw1DQpRVVTTxDZdVE3jl17agOfjDRv/zGK4DCtgZbz2ZOj3eYdN8ZgGUIfXhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=jETrjfRs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA660A2616;
	Tue, 10 Nov 2026 08:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6DA660A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=jETrjfRs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm8NOVNhkjUCZbSAJupVDTUt1O7jMopZ7G2IyBHpOWVyYVzarFsvvzy9gkIURzURAmHJPccCNgSSQpZEGH+VhFOIwfNnFZwrT9WzFdTRA4YTjU23A4R9kP0ijkGKxXeFEQkhxN06cjFfM/AEC1vhl/Ci2hMf6MhOkIN/kaOCrPktVxLqPOkLiToQihkqMwSl8Z1Cac4W4C9ovG/HQ0+6YQ+9Tf8eFpbUtI8yRhLw/TuCeN7I9g9sXfRFrxbqnZsmlBUp0POJGsy+47OBo3YQm+HlLvTVPAmIZgzFExaglt6steTznq5kXWLj6CIM2WLj5GS81CTYtCTWef2blCm82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldmlqC8XvzEAuXpvfeAXM9CZtM0xZvrpz+fX8S1U2es=;
 b=Ta838eBRH4xt+wYnmXKEWlFMGZ6xYfrRrYl2aRs81Cvti1+Pg6eiXC2XTcj5a+1EPLysDYF1nc6iMpfRULxnirag91+SgsIGSZ9JU+dbDv9Lu2q9gztMvuAJmmjXy9JjNAS5ABj7mKn9vRhXRx4F8c6wdzqu0thFyhTwu4TCcSMPrcqiGzCY2RUwYMwbV1xvISP7qKFzRurDz0SjNIlyiDDtg0XkFvRDfKh2JD8dM/p+XRthAXagBHr/y0XWU1BIUQadlQJjgFv8EVZQ3l1Ex9ryIgnQlzlvEEU4uXysM40ZHiXEotTa78SVUuf5gA75kbJW8ePqG9WxcbVqULQfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldmlqC8XvzEAuXpvfeAXM9CZtM0xZvrpz+fX8S1U2es=;
 b=jETrjfRsvl+wBrXTWLwSUp1A94cUfq2zdmShSS/Ag2VfNjiMiPCYbgXEw2QNCvmZGozx4v40hhl1YNUVS1oAx5WeAN6ipZURkr806PcKmrBavxF2jBm49xn8pBTPG+JQHom3SbyT2YrCLBbZWW/VKnzHi3knM2NX3yXDYSzLhno=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:09 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:09 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: [PATCH v9 04/10] PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
Date: Tue, 10 Nov 2026 17:24:53 +0900
Message-ID: <20261110082459.1798763-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB3015:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d1915f-09a9-4081-bbaf-08df3f04221d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|5023799004|56012099006|261022075727099003|261021121427099003|261021123027099003|261021135927099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FThD676WSzu/YxRQKL6S9pAOwWKoRSZsVbFMJFm9pll4AF6NWn7VZcS0e/ApsSpVpLSiHp1ZsgU0CRrjONWIlvlzVGQME9jMo3PPsh8iB8DFkpuwyxOIiFfZHN3KxWeA/p0xyOhu5Z0wj8S4cBoa1mplyM/r/D654doE2AmYcSdQqy/1j1CebDblWul1AOCyisCfg9bwBG846+jsXT/Aeb0Bvp4+ONK5eZC8yEGg6lpqvTheL8d4hEDWriq5jnfP+XXY5uOfXZ5AwyILYSA4ol4fm4U6sKIlvRA1hTfowLpvf1iuaEOgRV5Goq+1m2uQdcrM7uds+w/rYp6E7RVcPgIHGohRQ2EnHlf6nX/meioQzT7UgDQEIGmxlNW5qmdnooofS+gL7yEbf0LE64u6SbPztPHOUt5ciQ1whjPUMn5bWCwZznK5LxSHWGNv7FqBzJ87o6o3dbEMYy+PMWNIB425bsuo4lo18ImI+Ftce2ueutnBJRbpHoaNpubWY1cEkXb9GrUVp0guQ98xjDf1rojhX0mmIzRQkE/6DsAK1FNEdxIK1TcF78IV14C9ec3SKK5CK7s4qh+LzSKbIj2jd27NUOSBnbgtA+24+2Pi+aS4zVKjt9jnnI+k92t7yW6AmqUr2UgT7s73/Ev2RJHaTv3wdTEebowyavjiKoOcYf4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(5023799004)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?67tjI7XbSdUg3VaaZbUFhaaeqJjEE2e4yq4Ee0uNZw1hfdLwC7ayUnD8gMO+?=
 =?us-ascii?Q?nXdh+6E47JNNOdk8QZJKj1VhggYhwJXPD/aEbRnnll3BPqkB72fww4JsXyFW?=
 =?us-ascii?Q?chxJIxOB6h3rkiIc56Sr4wzRpR+Y0dAzgw0/OwbGmvPfiznyVg0CVmrJ6mIB?=
 =?us-ascii?Q?6p7I26UX6h+QJdsElQRdrrwDv7cGKSjgtJaV84qOlM8nJ4Ulj30wJ1VbLZA6?=
 =?us-ascii?Q?kedu5QUaxsoc0Y40bOPt2CPX6y/JflPYnsZC/WUDYEVrQDw0FkAb7quoc563?=
 =?us-ascii?Q?GO6GFHd10kFvppFl7UrafCG5NTWSXIWy7p++fpawRunl4gWqPs64hYV5PQ3Z?=
 =?us-ascii?Q?QNdqvOFJaigcFQYdNkP/VVF9F7WuIy3wknER98O7fNGrTXwdgmg7JwfH9qeg?=
 =?us-ascii?Q?5SIzV/Ei3TmWhfzpuvdCf2BBK8aPZNaM9cxkrkjaHOzph+MhET24cXy6huYE?=
 =?us-ascii?Q?BwMWG4BR/l2OGh75xEv5c7mPaFbyRFkOStvYCHeJuieian/7peIvb58P4hGU?=
 =?us-ascii?Q?J/y0XjIEwVMjaII7h4xvYtiGvDD/ODjeZanPk8ZelVyYllPsLanoHPZvaKzY?=
 =?us-ascii?Q?2oaG+aRgOWiRBkmC+B9Lp2AF050wPrvKOzmIB1soA+MABpMUEoO/IP80HUgN?=
 =?us-ascii?Q?qQsHa96MKKi+J6ubfAd+gDeYp0riAUsh5jNKOrkqbzSXllTJ4hU2ymuMDhTj?=
 =?us-ascii?Q?LXPcStP9AEXHh1jGZSdhnztM0mFOwXE/jUw/cS4Bk9zNpPolH9oJUlzrSezf?=
 =?us-ascii?Q?zuGr6IE90Xx/aJQ/ygDy5rsyV5XM0sttH0W+2MhH54D61lHHhzZLq92693Ge?=
 =?us-ascii?Q?TaexqUPzhyp1nBuxJBkXo0NRO31S29HUFSqKylnwYcNvXNLuYDOm/45DfwAz?=
 =?us-ascii?Q?V8KRmkGcMnBPnfoZ8Ul/1qzsU2XscLeAdpZHnGIUj0hN075RLqQS/9oI/Bqd?=
 =?us-ascii?Q?6To7viQJx1K6sI0TSGiL7HGyNug+n9uYBomnEWE+hqpaw5eU8hDKngKz8Fke?=
 =?us-ascii?Q?9y4IJKP/0P1hG1W/uLGO+EG33DPaYcU5wJu/+uRnjCH43TG9zqg4G9EF3Mrh?=
 =?us-ascii?Q?Bv5soqpUKYpSDxf2pCznaeAWEhPr+wXdeXwIYzhiJDkbz7B7ZBbSppG9/Jl2?=
 =?us-ascii?Q?DsK1Zn2+QXgLeRvJ25rdOU+IPKO0YLV7XLR+3XyC2Tfy0C55cNfKTiedgsYf?=
 =?us-ascii?Q?ntGhsblRUPeclVhhqI455rn9j2V+EJMJD9x416tFs3Imhdp6Ab7osJbUkm2y?=
 =?us-ascii?Q?TCfZ2NazzHk/DsACFprpaiD6iyH8N3Fe8G8D5pxW3ZSVJEPcPU6ytuRxUM8C?=
 =?us-ascii?Q?J9THIJYi1CiDOOT25RHFeHCCPBto3JwaK6gHqe8E4ZKQUe2u5EWLxHV6DGgS?=
 =?us-ascii?Q?21SX5jJMcMSIo/rLott/577nbApg+aA8litaevN+fvngmNEY0l37vCtFAYCz?=
 =?us-ascii?Q?5ZNfu+rLdoiMln3Ywk0VfifiZmVxcfUCaRSW1dq4oE0lYshLvBf/OTzqT90X?=
 =?us-ascii?Q?yjbYSR1eWebc/2mxw/uk9RRhe2AYuQiTZMhw9FpYRQ0SY6kKk8S5a61ihyr3?=
 =?us-ascii?Q?FRrajqikFtPtJSZi87BgKYcb4hy2lnHpV6680E2jBadQslrFJHLSEBZe7BNC?=
 =?us-ascii?Q?uZgqkteUzzsRMR42Xb5YAjJBP578SosseyOIzdGd124elwZbnDSxCNFqn0s/?=
 =?us-ascii?Q?PDgd5OKcW2Xi8BGJyUYrgiELrjRzRavHMkEV6adbONkkh6/1/sboeBptW/tR?=
 =?us-ascii?Q?KVzjVU/h4nf2BDWJgQVw9IfAo3fAdl76RFPS9YGRXGacNRem5b0x?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d1915f-09a9-4081-bbaf-08df3f04221d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:09.6197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP9QVCoOWUKwraQL8Hn5qUtp9uMg6f21QkcxKbpgt/pVAsPEnzzN3uwpkVTuZ0wA+3mbUOmhlzVkoa0IgxMTQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

Currently, pci-epf-ntb.c and pci-epf-vntb.c each define struct
epf_ntb_ctrl, and ntb_hw_epf.c mirrors the same layout with hard-coded
register offsets.

Move the shared struct and macros to include/linux/pci-epf-ntb.h. The
vNTB "reserved" field takes the pci-epf-ntb.c name mw1_offset, which is
what ntb_hw_epf.c reads at that offset.

No functional changes.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - No changes.

 MAINTAINERS                                   |   1 +
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 ++++--------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 131 +++++++-----------
 include/linux/pci-epf-ntb.h                   |  48 +++++++
 4 files changed, 128 insertions(+), 137 deletions(-)
 create mode 100644 include/linux/pci-epf-ntb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..ebdbc54c72d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19934,6 +19934,7 @@ F:	drivers/ntb/
 F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
 F:	include/linux/ntb.h
 F:	include/linux/ntb_transport.h
+F:	include/linux/pci-epf-ntb.h
 F:	tools/testing/selftests/ntb/
 
 NTB INTEL DRIVER
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5314aca2188a..925cf46219d7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -41,27 +41,13 @@
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-epf-ntb.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
-#define COMMAND_CONFIGURE_DOORBELL	1
-#define COMMAND_TEARDOWN_DOORBELL	2
-#define COMMAND_CONFIGURE_MW		3
-#define COMMAND_TEARDOWN_MW		4
-#define COMMAND_LINK_UP			5
-#define COMMAND_LINK_DOWN		6
-
-#define COMMAND_STATUS_OK		1
-#define COMMAND_STATUS_ERROR		2
-
-#define LINK_STATUS_UP			BIT(0)
-
 #define SPAD_COUNT			64
 #define DB_COUNT			4
 #define NTB_MW_OFFSET			2
-#define DB_COUNT_MASK			GENMASK(15, 0)
-#define MSIX_ENABLE			BIT(16)
-#define MAX_DB_COUNT			32
 #define MAX_MW				4
 
 enum epf_ntb_bar {
@@ -104,23 +90,6 @@ struct epf_ntb_epc {
 	const struct pci_epc_features *epc_features;
 };
 
-struct epf_ntb_ctrl {
-	u32	command;
-	u32	argument;
-	u16	command_status;
-	u16	link_status;
-	u32	topology;
-	u64	addr;
-	u64	size;
-	u32	num_mws;
-	u32	mw1_offset;
-	u32	spad_offset;
-	u32	spad_count;
-	u32	db_entry_size;
-	u32	db_data[MAX_DB_COUNT];
-	u32	db_offset[MAX_DB_COUNT];
-} __packed;
-
 static struct pci_epf_header epf_ntb_header = {
 	.vendorid	= PCI_ANY_ID,
 	.deviceid	= PCI_ANY_ID,
@@ -156,9 +125,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 		is_msix = ntb_epc->is_msix;
 		ctrl = ntb_epc->reg;
 		if (link_up)
-			ctrl->link_status |= LINK_STATUS_UP;
+			ctrl->link_status |= EPF_NTB_LINK_STATUS_UP;
 		else
-			ctrl->link_status &= ~LINK_STATUS_UP;
+			ctrl->link_status &= ~EPF_NTB_LINK_STATUS_UP;
 		irq_type = is_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 		ret = pci_epc_raise_irq(epc, func_no, vfunc_no, irq_type, 1);
 		if (ret) {
@@ -562,9 +531,9 @@ static int epf_ntb_configure_db(struct epf_ntb *ntb,
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
 
-	if (!db_count || db_count > MAX_DB_COUNT) {
+	if (!db_count || db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(&epc->dev, "DB count %d out of range (1 - %d)\n",
-			db_count, MAX_DB_COUNT);
+			db_count, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
@@ -648,50 +617,52 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	dev = &ntb->epf->dev;
 
 	switch (command) {
-	case COMMAND_CONFIGURE_DOORBELL:
-		db_count = argument & DB_COUNT_MASK;
-		is_msix = argument & MSIX_ENABLE;
+	case EPF_NTB_COMMAND_CONFIGURE_DOORBELL:
+		db_count = argument & EPF_NTB_DB_COUNT_MASK;
+		is_msix = argument & EPF_NTB_MSIX_ENABLE;
 		ret = epf_ntb_configure_db(ntb, type, db_count, is_msix);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_DOORBELL:
+	case EPF_NTB_COMMAND_TEARDOWN_DOORBELL:
 		epf_ntb_teardown_db(ntb, type);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_CONFIGURE_MW:
+	case EPF_NTB_COMMAND_CONFIGURE_MW:
 		ret = epf_ntb_configure_mw(ntb, type, argument);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_MW:
+	case EPF_NTB_COMMAND_TEARDOWN_MW:
 		epf_ntb_teardown_mw(ntb, type, argument);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_UP:
+	case EPF_NTB_COMMAND_LINK_UP:
 		ntb_epc->linkup = true;
 		if (ntb->epc[PRIMARY_INTERFACE]->linkup &&
 		    ntb->epc[SECONDARY_INTERFACE]->linkup) {
 			ret = epf_ntb_link_up(ntb, true);
 			if (ret < 0)
-				ctrl->command_status = COMMAND_STATUS_ERROR;
+				ctrl->command_status =
+					EPF_NTB_COMMAND_STATUS_ERROR;
 			else
-				ctrl->command_status = COMMAND_STATUS_OK;
+				ctrl->command_status =
+					EPF_NTB_COMMAND_STATUS_OK;
 			goto reset_handler;
 		}
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_DOWN:
+	case EPF_NTB_COMMAND_LINK_DOWN:
 		ntb_epc->linkup = false;
 		ret = epf_ntb_link_up(ntb, false);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	default:
 		dev_err(dev, "%s intf UNKNOWN command: %d\n",
@@ -1298,9 +1269,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	func_no = ntb_epc->func_no;
 	vfunc_no = ntb_epc->vfunc_no;
 
-	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
+	if (!ntb->db_count || ntb->db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(dev, "DB count %d out of range (1 - %d)\n",
-			ntb->db_count, MAX_DB_COUNT);
+			ntb->db_count, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1a0ce31e680c..3adbaa9d85db 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -47,27 +47,14 @@
 #include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-epf-ntb.h>
 #include <linux/ntb.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
-#define COMMAND_CONFIGURE_DOORBELL	1
-#define COMMAND_TEARDOWN_DOORBELL	2
-#define COMMAND_CONFIGURE_MW		3
-#define COMMAND_TEARDOWN_MW		4
-#define COMMAND_LINK_UP			5
-#define COMMAND_LINK_DOWN		6
-
-#define COMMAND_STATUS_OK		1
-#define COMMAND_STATUS_ERROR		2
-
-#define LINK_STATUS_UP			BIT(0)
-
 #define SPAD_COUNT			64
 #define DB_COUNT			4
 #define NTB_MW_OFFSET			2
-#define DB_COUNT_MASK			GENMASK(15, 0)
-#define MSIX_ENABLE			BIT(16)
 #define MAX_MW				4
 
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
@@ -90,47 +77,6 @@ enum epf_irq_slot {
 };
 
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
-#define MAX_DB_COUNT			32
-
-/*
- * +--------------------------------------------------+ Base
- * |                                                  |
- * |                                                  |
- * |                                                  |
- * |          Common Control Register                 |
- * |                                                  |
- * |                                                  |
- * |                                                  |
- * +-----------------------+--------------------------+ Base+spad_offset
- * |                       |                          |
- * |    Peer Spad Space    |    Spad Space            |
- * |                       |                          |
- * |                       |                          |
- * +-----------------------+--------------------------+ Base+spad_offset
- * |                       |                          |     +spad_count * 4
- * |                       |                          |
- * |     Spad Space        |   Peer Spad Space        |
- * |                       |                          |
- * +-----------------------+--------------------------+
- *       Virtual PCI             PCIe Endpoint
- *       NTB Driver               NTB Driver
- */
-struct epf_ntb_ctrl {
-	u32 command;
-	u32 argument;
-	u16 command_status;
-	u16 link_status;
-	u32 topology;
-	u64 addr;
-	u64 size;
-	u32 num_mws;
-	u32 reserved;
-	u32 spad_offset;
-	u32 spad_count;
-	u32 db_entry_size;
-	u32 db_data[MAX_DB_COUNT];
-	u32 db_offset[MAX_DB_COUNT];
-} __packed;
 
 struct epf_ntb {
 	struct ntb_dev *ntb;
@@ -195,9 +141,9 @@ static void epf_ntb_update_link(struct epf_ntb *ntb)
 
 	/* The link is usable only after both sides have enabled it. */
 	if (ntb->host_link_enabled && ntb->vhost_link_enabled)
-		link_status |= LINK_STATUS_UP;
+		link_status |= EPF_NTB_LINK_STATUS_UP;
 	else
-		link_status &= ~LINK_STATUS_UP;
+		link_status &= ~EPF_NTB_LINK_STATUS_UP;
 
 	WRITE_ONCE(ntb->reg->link_status, link_status);
 }
@@ -368,45 +314,47 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	dev = &ntb->epf->dev;
 
 	switch (command) {
-	case COMMAND_CONFIGURE_DOORBELL:
+	case EPF_NTB_COMMAND_CONFIGURE_DOORBELL:
 		epc_features = pci_epc_get_features(ntb->epf->epc,
 						    ntb->epf->func_no,
 						    ntb->epf->vfunc_no);
-		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
-		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+		if (((argument & EPF_NTB_MSIX_ENABLE) &&
+		     !epc_features->msix_capable) ||
+		    (!(argument & EPF_NTB_MSIX_ENABLE) &&
+		     !epc_features->msi_capable)) {
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 			break;
 		}
-		ntb->peer_msix = argument & MSIX_ENABLE;
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ntb->peer_msix = argument & EPF_NTB_MSIX_ENABLE;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_DOORBELL:
-		ctrl->command_status = COMMAND_STATUS_OK;
+	case EPF_NTB_COMMAND_TEARDOWN_DOORBELL:
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_CONFIGURE_MW:
+	case EPF_NTB_COMMAND_CONFIGURE_MW:
 		ret = epf_ntb_configure_mw(ntb, argument);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_MW:
+	case EPF_NTB_COMMAND_TEARDOWN_MW:
 		epf_ntb_teardown_mw(ntb, argument);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_UP:
+	case EPF_NTB_COMMAND_LINK_UP:
 		ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		goto reset_handler;
-	case COMMAND_LINK_DOWN:
+	case EPF_NTB_COMMAND_LINK_DOWN:
 		ret = epf_ntb_set_link_enabled(ntb, false);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	default:
 		dev_err(dev, "UNKNOWN command: %d\n", command);
@@ -518,6 +466,28 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
+ * +--------------------------------------------------+ Base
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * |          Common Control Register                 |
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * +-----------------------+--------------------------+ Base+spad_offset
+ * |                       |                          |
+ * |    Peer Spad Space    |    Spad Space            |
+ * |                       |                          |
+ * |                       |                          |
+ * +-----------------------+--------------------------+ Base+spad_offset
+ * |                       |                          |     +spad_count * 4
+ * |                       |                          |
+ * |     Spad Space        |   Peer Spad Space        |
+ * |                       |                          |
+ * +-----------------------+--------------------------+
+ *       Virtual PCI             PCIe Endpoint
+ *       NTB Driver               NTB Driver
+ *
  * Allocate the Local Memory mentioned in the above diagram. The size of
  * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
  * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
@@ -602,9 +572,10 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 		return -EINVAL;
 	}
 
-	if (ntb->db_count < MIN_DB_COUNT || ntb->db_count > MAX_DB_COUNT) {
+	if (ntb->db_count < MIN_DB_COUNT ||
+	    ntb->db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(dev, "DB count %d out of range (%d - %d)\n",
-			ntb->db_count, MIN_DB_COUNT, MAX_DB_COUNT);
+			ntb->db_count, MIN_DB_COUNT, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
@@ -1258,7 +1229,7 @@ static ssize_t epf_ntb_db_count_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	if (val < MIN_DB_COUNT || val > MAX_DB_COUNT)
+	if (val < MIN_DB_COUNT || val > EPF_NTB_MAX_DB_COUNT)
 		return -EINVAL;
 
 	WRITE_ONCE(ntb->db_count, val);
@@ -1456,7 +1427,7 @@ static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
 	 *
 	 * Report only usable per-vector doorbell interrupts.
 	 */
-	if (db_count < MIN_DB_COUNT || db_count > MAX_DB_COUNT)
+	if (db_count < MIN_DB_COUNT || db_count > EPF_NTB_MAX_DB_COUNT)
 		return 0;
 
 	return db_count - EPF_IRQ_DB_START;
diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
new file mode 100644
index 000000000000..0c02d709aa08
--- /dev/null
+++ b/include/linux/pci-epf-ntb.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Control region layout shared by the PCI endpoint NTB function drivers
+ * (pci-epf-ntb, pci-epf-vntb) and the host side ntb_hw_epf driver.
+ */
+
+#ifndef __LINUX_PCI_EPF_NTB_H
+#define __LINUX_PCI_EPF_NTB_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#define EPF_NTB_COMMAND_CONFIGURE_DOORBELL	1
+#define EPF_NTB_COMMAND_TEARDOWN_DOORBELL	2
+#define EPF_NTB_COMMAND_CONFIGURE_MW		3
+#define EPF_NTB_COMMAND_TEARDOWN_MW		4
+#define EPF_NTB_COMMAND_LINK_UP			5
+#define EPF_NTB_COMMAND_LINK_DOWN		6
+
+/* EPF_NTB_COMMAND_CONFIGURE_DOORBELL argument */
+#define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
+#define EPF_NTB_MSIX_ENABLE			BIT(16)
+
+#define EPF_NTB_COMMAND_STATUS_OK		1
+#define EPF_NTB_COMMAND_STATUS_ERROR		2
+
+#define EPF_NTB_LINK_STATUS_UP			BIT(0)
+
+#define EPF_NTB_MAX_DB_COUNT			32
+
+struct epf_ntb_ctrl {
+	u32 command;
+	u32 argument;
+	u16 command_status;
+	u16 link_status;
+	u32 topology;
+	u64 addr;
+	u64 size;
+	u32 num_mws;
+	u32 mw1_offset;
+	u32 spad_offset;
+	u32 spad_count;
+	u32 db_entry_size;
+	u32 db_data[EPF_NTB_MAX_DB_COUNT];
+	u32 db_offset[EPF_NTB_MAX_DB_COUNT];
+} __packed;
+
+#endif /* __LINUX_PCI_EPF_NTB_H */
-- 
2.54.0

