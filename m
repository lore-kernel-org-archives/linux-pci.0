Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020115.outbound.protection.outlook.com [52.101.228.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0501F09AD;
	Thu, 19 Feb 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513007; cv=fail; b=O86r28j4YcDSMwkSoK+OlqbijWL8/WTkD2mdGU8Dp910DEokcYhyFKD2YjPmOfYFM4fCLrWPQwgP7DrVskREfP0TGxjDDP0ZCADCE9IIxwEfNwYYSHMh9+RPjo3wdV9DxbPVvel9t717rnfs2u+lTOBVi7BlEevorYCZiaWG874=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513007; c=relaxed/simple;
	bh=umod8MAdUe0oHj/DYm6TI0VKwRwCkF1d+0e5MmlINkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kKzcvLPiUYVsUGrd1/Fnzxq0Ti3Qx/QY/pAVn+GiYv7vhMVN2gx6bYOVYnPZpXWzgzVSop4D9z8sQyYNTKJS4euYR4oyCw7G6ETCZy4FL8grAOlUk6jxRyiE/NN/8J2MTv2MvtN8vgzcbzMLmIs1nQso6ABVcx0W1WAW3tjg/VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GldZ9rlY; arc=fail smtp.client-ip=52.101.228.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GldZ9rlY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6aiITjAIb+NLPhO//66cXCW42fHL74lf4rR4PxmG+uhCNRwsc/IQ0cZdJ+XpU1JFGbHx4B/pDJUjRoW/hsR91JcmHQWPtRAkEvOe1LNWngWnf7IUPBQ3EwZFHRmsCVFaFhUw9IRr559GOGYAcCtbl+7JKgCaXxtmxqbjUzfsS2by7rDdKE3l4URPwMvcav3zrBCiUu02RKVIEMRjQwsc3ssCXtUAFygVyob26Iw0Rwa7ZNYDzx74WHZIbVRklqo/OLKKksjCy2r5EPERGz2+SVD433fCIZBFTi5h9M2zdvfYz0JsV+8goUP9PbLDwCR42DB3Z6ZFkIgV+7QEr8xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhhAkWaa9JsGwyNzMsOO05KFSwlcz1bOQBgzWMJ4Pvw=;
 b=grFhybAeWd6ezoHAnSTUufh7x7ryTi8vxkb/J9I49JjsPrEqyWKJhUz1ImLixL9UvDlKb69ee5DrlNkpaf6ffgJoIs5YVBTFEwMcskrRo+yVyWJSCL36nNlhGiaBT0il0u489X4ciVRhB8dDx+2k7RTgPrC5Nox32+d5SjHWl91Q40TK+EA5iFFmoIALBUCmoyEnoiXj+h1jPkEnIOg7J+P2i29KGwOnZQqKl0Gy46c6YVlh+Zcci/TB0wpO3/qBESyl74Y56XhYbKblPoHZToU5MsyW0ggQUWSr9fM/MgpE/SHt7dMFSM57s4rhHKNbOnR5C6DyA5ImQedS0tgjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhhAkWaa9JsGwyNzMsOO05KFSwlcz1bOQBgzWMJ4Pvw=;
 b=GldZ9rlYjZipPi8RXU0mlE4839aifKZP/wq6fTx0ANKX4bqKtT7vAt7SGHpHWJpi81ywcDYwokOFKl2RQwiSTVVaalGv+J/1C7gNmP8fxKkcvi5ZoqZy/H47PuY2AYpK3e0jndtnPaGAbNzQ8euqPxSK0uOE1LO1TwSXhZJ9sWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB6157.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 14:56:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:56:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org
Cc: kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: Return -ERANGE for out-of-range MW index
Date: Thu, 19 Feb 2026 23:56:33 +0900
Message-ID: <20260219145633.4191325-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0099.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 0519c4a3-06de-4585-bf3b-08de6fc717a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DFrDdO3Sp6xbZz6AnneM2Y3lAQMjoRoupmPZkf2HpErIpEgpIVLZxO1onyDK?=
 =?us-ascii?Q?HqjiHfKRzVb1Dh+2utKdRSU6/rLgGKBfYpJ6vfDq79MbUjNuiCIPIUDZFmI3?=
 =?us-ascii?Q?kjLFB5t0+LIF77jB5S0wTlALfpWyPmiQX77L/To9OMOjpfH9KVkStQpRpwmz?=
 =?us-ascii?Q?tIQO4dtp8sLLUSpFqw9WN2oGjo19UU49Iq/AMlE2j0Zi7zhJREKT/i8xiPUo?=
 =?us-ascii?Q?3LWxICa1eO/oE2tYoGBqOV42t8T/FHwRQ/oM3UIoxI79CiQ6tIjFGN8ZNFU+?=
 =?us-ascii?Q?p7F5jQVg9OSUthF2xmKpzEV6NFu6ubDwGRO/HIDo9PPEue9hQhbtiUTxc61A?=
 =?us-ascii?Q?CAMNUUQ2THmDq6OD3V1CaZj4FC1U/1uGJdaFHLThvhF5vUUcfvmf09x1m03z?=
 =?us-ascii?Q?oZo0cGfVFgRcZxtUfgaxOY1NIpYev4LDgdxFz4jJEvZRrtaMhYh/fdN/jfc2?=
 =?us-ascii?Q?0MsX2MpTln5ZvBqjMNAyWfTxelNwqtD9CCJwIgj70RwyrrF0IrPonB4OrTGw?=
 =?us-ascii?Q?3TMNjsjCso0w8EDxv23+Ccgbw+DDtz77gm0vRA517I/54pEKaL9nwdTbByDx?=
 =?us-ascii?Q?uG76/RL55PLXbmMNjsVcG/0dAtOpCdYiA2FEX7818ssyfiqjxPdKFOoVUu68?=
 =?us-ascii?Q?BI/2dPUSaPOzPZihFkflOqL5hcESU8KgX4SmKEDGl4ha5SZPV4OXo+JTjxSd?=
 =?us-ascii?Q?pF7EHL5ToFWsihG+RESNyDQVK1djOhM4P1G0A9ubXnN1ZS04G6KJFlfpo/TT?=
 =?us-ascii?Q?/ptzSLZHWlQvvik4fmhJimYYz9rEShbpOieXV9RjevO7EDwwVpCt9mQMzeSN?=
 =?us-ascii?Q?T0sOo+ayUCRw+0mMITb2ZCTfmyCGIGJVMCesDPXCtGB9ZACnfhjGDJ3PkVAb?=
 =?us-ascii?Q?/fqLXsVjukqE5Aip3lQ1co4Yn3vDCDjBb5aKUgzv/kk5BCs7n+hXHg4H7C1G?=
 =?us-ascii?Q?14FTLqYV8upjWNUfuIhZ0yrXaRbvPyL44BvKn9MRAb2+5UV7mgt2WuXAifaG?=
 =?us-ascii?Q?ZEYJVgjjUxc4Ke90eiF2HwkKVlxkCoTdYILMgD8kG0T2uoCDNiV8nqgR7X59?=
 =?us-ascii?Q?aUuQH3YibgkoDrGvevodW6R1/Pou9LNIhs297Lv1iKPDRIzTLpKoNIiqjnlB?=
 =?us-ascii?Q?vSXh+vVzFIyBfUb8/QmppEXmYIGkxJDe9AfmAxNA7Rc41yChFSETDVAfsXii?=
 =?us-ascii?Q?QlH7fnE103EpM0fIiHGJNI1OEMT9KcyF3veeG8qWPnbDYTRroS+xcjkC/+X7?=
 =?us-ascii?Q?qE+fC7JBE3qJzqD+rb8HbJ/YdiJ+N98Qrmg9bbbXuDCL8kySuTA6jHtdaZvu?=
 =?us-ascii?Q?1aEUh7Xo5KO5mIsjpysd+nOI28esUO53EYT6flTtJU2DSmyuy94UKijB7wV7?=
 =?us-ascii?Q?DjJklcOqDZ7BaoVmc+WfYsIgXqBrglBLWj5f/6+9fDyQZHIcB6iNF4iHzAxl?=
 =?us-ascii?Q?XJ87J2/EGPPVMH0pS/Piw2oZj6FMWtUNHkqj8N2JvcodN7XIiQPiICS1p/3I?=
 =?us-ascii?Q?Vxq/p2aMW2uB6yqHyt8DKT4pvFr/hILxPhcnI9D5VYQ9Aj3SMASmKUZvlVdx?=
 =?us-ascii?Q?3ysS3jGXfOxMsbXOwc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i4gPAz3lG8193GdSC8kQxBCOpCjTboY9BFp+DTSw961iq0kuTLyIQWyc4jom?=
 =?us-ascii?Q?bQiRu0PK01db3FdHo/ZDAA3am7JjNtlu1e16SZpGfMtZo37GWhLcXLENnsxA?=
 =?us-ascii?Q?s7hXTuUe37Uv33h/l/pL//Y4jHvsiJjOCOHqE3RuJGnZTQXIj99x2PUmtHI/?=
 =?us-ascii?Q?9Q6MWOd6NuUNJGvCsUEqtEicPGSuIFdAGOpbdfY8EukIEmPI9vYLAx6+7uLY?=
 =?us-ascii?Q?Zd7I1mkPJnF0DZHUeYH5mBjWSOQWBiqqweocPsBGRCYerlQGN5XNXlVcL/+h?=
 =?us-ascii?Q?5EDBxEljCzkVUL/LssPAwnAVwpvBGtjkGwdFaiTMwIl0HJTZEdX3a4U7ekDi?=
 =?us-ascii?Q?roNVR4N0yJ3WoKXweR5NO80FTR6+ktOv+6DrdxtNNfXMANvlO1AiFZc6NAk6?=
 =?us-ascii?Q?QEgtNeNr601HIyegtQgiAPl7A6MmjLI1F0aa7wWPGsSpIOXJOThxFt8zrR7N?=
 =?us-ascii?Q?8qVUMlA0yUWmNCX52AnEvBCa2DS8GNJvhfkmzaaweznHqlIsRrBgvjLVN/02?=
 =?us-ascii?Q?7dy9w3M6s0rvCnxUIEgn8m4M7ueYprZ6meDOgn7kbz+H9vu/Y8/z856mc66m?=
 =?us-ascii?Q?j94IG3tBvIkq4UmI2+TmOep9TQj4mPemwCxhSX3xfxid0X2hQ+MLzN8KLGQi?=
 =?us-ascii?Q?nltIt1hb6OhqCDaTR5+3LacWVEJi1wPho4n/g+H1XfAe/lkYayJG2K1Gc2p/?=
 =?us-ascii?Q?wanmxn4FHSTGVyLpZynCjT1+pLzxA2ecIgeX+/o4tkDAW4vIaBXI8UlK7LfS?=
 =?us-ascii?Q?bCrGCoAVD5HaZFJD1IC1UFvGFXk+GTGOoOOfZYqx+qF3YvAJlwngir4Krxym?=
 =?us-ascii?Q?yWogF+E1YPVoTh2PN4zPMmC1YBociIDTPSI8NYOUaefbLZGsYwXwVOXE07A8?=
 =?us-ascii?Q?9gT4FeJ/KqyvnrMzTvJCPGbbx53IJxhwCx/vKAjjfulVlNisRv/1Z+VQED+F?=
 =?us-ascii?Q?QMnqplNfQu561QdKzdzDM9QkMSVM4BGBDhH5LhxdFrm4UYywgrDXe96/HdBe?=
 =?us-ascii?Q?Awj+D4vDF4EgEsw717KRPkJO5BuAuECL8sPA2ddXSEGuu0Zi7USlUHJLkPlo?=
 =?us-ascii?Q?MpZyfzuEScp2mjF/t9w3+8OJgJrR3OhiLM55Kcq8Iemlm9p6ayxlR6YadNs5?=
 =?us-ascii?Q?3E94dQg0r9m5pOciEv5K4ugyszeHF4gxZYDvOmjLjCTtIFb8YY0hvgHbc3aU?=
 =?us-ascii?Q?Fn33D+OKPnvrQPbEcJ8tYHKFqKRV+EP1mYCFqzmU8BWCLNJUjBQ2AI4mD/RT?=
 =?us-ascii?Q?6eyaX3rZyybr7SB49o64EbnRPIMTQQ1BoA657C/HzHO98j0gCd1JUOOM6YJU?=
 =?us-ascii?Q?4hbdW+cS3f9DP9waGmve27he19nuWjPl5HCoV4xceGVxTdYbMViBm+rBdqX2?=
 =?us-ascii?Q?l1+hpWUwyV0cAstfes1d1g3cnr/pb7iK6WSoUDqMD72rUgYhSqTF59rMv29M?=
 =?us-ascii?Q?obBAhtE1YpOwl4GSUjo4oeVMAD8kku12nTMXmbP1EZ7FzlTtZeT5pTk+gbtY?=
 =?us-ascii?Q?1GbMNk7Mv+eRtuGnKH23wNrtpkC5ou8NXn2hnbaQ4N+ODGt1Pty+8k0+Gqfh?=
 =?us-ascii?Q?49ZTTpnEfGMnqemjYuCRR0zn6WtsHCtUJmb53qnwc1VtqtQ/P7qsRM8KB3ez?=
 =?us-ascii?Q?EctIcQP4mmnR30eyx8qcjeLjZfUfULbbA0jhoUyXYrGD/q57QuzoM9vD8H+c?=
 =?us-ascii?Q?m2flx7aXHaK02pTYRLoj9AAza/3AxpYEX2xv18h+WwsZ4z9tNmWoGoOfP5IM?=
 =?us-ascii?Q?mHHZ0TrQEgODJMR16L5w1lChkCyQl7uHWDUCDBne0yROJMRxGge8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0519c4a3-06de-4585-bf3b-08de6fc717a9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:56:42.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0Z6GsFsmt4hVjbu477KGU99OxNgJXFw/hbQEEPspYnOO0EMn39OGgsrPBbfUqwAlsQZ30X5BXgLf+ezEEUDQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB6157

The mw1..mw4 configfs attributes are only valid when the MW index is
within the configured num_mws range. Return -ERANGE instead of -EINVAL
when a configfs MW size attribute is accessed with an out-of-range MW
index.

Link: https://lore.kernel.org/linux-pci/n7griejk7mlutc5mdi6b3ysedn2dgcius43urhxnfohjeo32fc@d5gymxxhrutw/
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..3d0fa98109b1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1002,7 +1002,7 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 									\
 	if (win_no <= 0 || win_no > ntb->num_mws) {			\
 		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
-		return -EINVAL;						\
+		return -ERANGE;						\
 	}								\
 									\
 	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
@@ -1028,7 +1028,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 									\
 	if (win_no <= 0 || win_no > ntb->num_mws) {			\
 		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
-		return -EINVAL;						\
+		return -ERANGE;						\
 	}								\
 									\
 	ntb->mws_size[win_no - 1] = val;				\
-- 
2.51.0

