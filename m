Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F039527F;
	Thu, 26 Feb 2026 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095349; cv=fail; b=h/+zR9pfoFO0OOoR7ZZ1ZtdF4Vb6zlrcFU96p8ytz/gK2wbCV+Ly2A3lJI8I/CKHzX6H0npBWc8KfTsT1gNBBJl9eIMiXeySG/cBOqiZiDbL/aQoYWuU0lZ2kHRyp3WtrlvTpLNh+DF33JBi5rhjuckrOnQj2zuda4OBNCTMYJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095349; c=relaxed/simple;
	bh=t+8TK2GSap9W0kLDPj18qfuCcpv2EVAu6LKS3o1Nnlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJa7Zdp+YSuryCQE+xGcT9YZOcWPJTpCat1zMx1pg9LKJBSQgLUcRpkXyGfjD1hsfE8Ppfrd+BYutrE7QsoKv11scMpLKjH/6ARvm/onAHE8ucUDuGbwN15jibgNaRN/QpkDJl0qrPRLB0v/yNkW8Mlt0eJpvXHzqR07sYUMIOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FyX1ZDxA; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FyX1ZDxA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSFC8FMtK7kXZvy+l2m2womlSlVQWOe2DzhBcp0Vz2JJGSwGwIijd/x+rYxAuF0rKXmLg0kSEpOd6aVrSUSg5mgv6sRgIiKQVU81pbCCp8zLRMUtQv664u3lqDeHBVsduipztnvtPB3UCYMZ6P5/A8QQ+Htm7CCHcgHe4zWqFA48gdI2rTBvtf5Wdt5qJ+lbeWCh/jEIOJcoxpjgfgNdLxpqkwG4LgMPDXBVyay5Y7xd2LJA3JTFlRCllXk5Fy0Y1kSqe8+/7NYfnnvWyRaAazYwOgl/HLWTO98mCkCqHdmiV4i9UNVg2jTpczTf4KmlrI7aSgMKleadrLrIy0+ECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQbQuE1IYDjnoDtHZTlEACNGDvf/jq59dYtHagYs6FQ=;
 b=aRUmV0taEYZH0BWNaeT2c1MqksuL7hpQy0a7ow1VksgnC+29l9+ar674Hk5tmXo8HP3QV9pX1mt1frNfLEkXAU2eahzNmIeBEY7EQW4LVUhd/0HkzKSU3oJ2bsBFRFEw7RbTNRbYfthoUVF6qAly7id57sUklS9VQC1LAihu+nuyMXIe1YdgkFgJOcq2xppJfuNhU2/lh5HXdwb1QFOk75c+u7aOMTsT/58EYTkf4Vd50IdzhtmH8YLaHypHnsXq0vA9WZ9q0ltsAB+0+bfhoNaIlcYBX6yKKdVR2vEXUSXJMRSRL+blxRlyoiCXm+ChUC0P3S1P2h4qmfjCuj0F5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQbQuE1IYDjnoDtHZTlEACNGDvf/jq59dYtHagYs6FQ=;
 b=FyX1ZDxAmspFsGfcqBNXnbgAcKThkCv9zZCqPBINx/Cc12fZdpmIBfrSc5dKbhvzwaBbgshGRO3s/SxSkpPDXb/WC+vpNlg+8vdvu91p+Bs+tgAYAHo2h75IePNIoz05QsKd4nyHeKNSKC8ZVLLEnwOe2WfeiPJ2B/UKy3QPSQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5288.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 08:42:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:42:16 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	kwilczynski@kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ye Bin <yebin10@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
Date: Thu, 26 Feb 2026 17:41:40 +0900
Message-ID: <20260226084142.2226875-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226084142.2226875-1-den@valinux.co.jp>
References: <20260226084142.2226875-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0125.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0ac32b-dc72-45bb-ad4e-08de7512f1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	J5mLYUOn7GVKRB47mhl0YGvQYN855PTa+12f+8xjgFn9/R3P07ALfvAflbmgLeHP2GVc61bpo7/Fg02n6eFDRkK5LKhaSH+d9vY6Iac7hwY0CP4bEpugmTQKt7Y/a60ng8we2ELtIzemdgO97Sdnn90cr9bBjEgbRdipH0AcK3tltR8aY+oMrU+pIJqMN7TdyR1RSJBPGHnLEOzxSfX3OwBFfqcBrvyoxaZj2kFTkSq9Dts8DFbpzslvTygNKfYNJ9S3KKaIUejwHx8lFRx/nPtFtsv1VZbz5zsTLbB1bltzTQv2h/OBNsle9vCZOKjL4ulJp3croZ1Q6e/PLgZ/bTfYRC8Sj/UnNjur+BLwFOJp7E1tYvhSLs/AMwxYRWoQt5sBhsO/+AC/PJXj1mpFyFK/1ALK2ibH50cUqCrM1thU22z4PH769Uc9rvbxA87pmBu1BGtiNo50/Crpml1kWGMizMeq3GO5J2IolFqpeqkf3O0AcvyVcRXI5fVcp4g6JCPmwz4MTBQs/1tDSyJxCIsxhzxJulk+/DO4d3r0lHisLkwOKBdeflVlztfXbQlBaTzztkhUbTWQltnu2GVwTk6rJMkYpviHbquqOCMs7HfrJX3aZEQdSmcQ0pmh2KSL4bKX8G4wENzO00gEY+wa6Oy60V3Q/rJvSPZtPoyUbMHdZV8NYPut43zJzYndB53soXSKwdeq3itnlxQNKis4+G+zEuhGES9mYtYgodReFGuMxgz+buNnaPVeB/onJeayo6fX3F7QPhrDoa50myuR8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EUSNVJ53Oh9MXp3kqN0DLBFq/b7kcBUajJUHh0sPifPvcejrhbJ754K7wEOY?=
 =?us-ascii?Q?DI+NS2nPgQZJH7rdm53jq4dTv2VkVGAILNX8OzUz1ab1AnhkvCnWBvVUwzq1?=
 =?us-ascii?Q?m6MdlfQR9MRENnckDM3lQEvaF0YBRwuZ3HWckssJiFI89+UJQ/N4BLY1vOhx?=
 =?us-ascii?Q?NIGQgSuKYEwyqdWEz21VR8g32rht5LN7/RU1E2WGS3kOA+mEwr5PQi3aMEyc?=
 =?us-ascii?Q?eVkMlqHmkxsHz0ZB3yQgc69xNgsBLk6KA0ZGaAD0JGkMVgQU6IhSvlymTVGe?=
 =?us-ascii?Q?rkS5vU1a21SDSfFA15j9hY35Ft6LnLUmy5Lv+GzuKEIE2wuDyCghvx1wYBx0?=
 =?us-ascii?Q?ps/yUag/j2AfLKtYB9bzp4HuUjvbkqVjTuD2yG2MbfmI1+p/nzjxfHG85uo3?=
 =?us-ascii?Q?feiMOwqgVt4etnHh/AA2aAauUoCg62jYJZJWttvAvK8Wo63fd5P600s8/cy1?=
 =?us-ascii?Q?gH5c0GbS8Y7aIMC3hfSJ43n6jC1sZw0aixxfLMauyfYc9/IJ1wKZXsKNOtIt?=
 =?us-ascii?Q?Lzdnd6nK8CirqgDpeJekbEbhzFmrO9DHlySN6nlvyLxmlUJKSdCuOl0C5QzW?=
 =?us-ascii?Q?mqdWLbaxMp2BD6l9qqpHOXOUP+CCuj/34mZnQPB1ZPtHbl7iigepBVjBWdNw?=
 =?us-ascii?Q?8Fca2ph7/S50Q/NDSdRzmz7hm6ttJg2G0dC0TV5WK6ZE8UWhYr1vhW42Z74F?=
 =?us-ascii?Q?5McMJ23LbOMAVV5CGO5Ho5tKmFa5rUF3AU2sNt/NI1T3FbB5hyWTPCzXRYX+?=
 =?us-ascii?Q?wdZuyq3eRgTOEZBR8TN5cCCOwxhhPWrwJtGym6gLmVZG7kc2Mbo7zuyArYoc?=
 =?us-ascii?Q?tIHMHcuSjyXTwgk5+FF+8o90s6okOqSZkKmHs+VfNE4SH1pmOqkXt8XARP73?=
 =?us-ascii?Q?pQvyVTn03tCEjaboCl6KAlDROHOushvoVCCl8sl4TTOYY5t8mohDEXnyz5Lf?=
 =?us-ascii?Q?0wum+q1Mv0fIPBhwH4yNixJ2VDSj1U/cl9/vbIM3f7vGJAE2Mzorzsun+4le?=
 =?us-ascii?Q?W2yIFWX+KhwCyIJ9ZkTMWmHPorR8NOSLsmNQYp698gCrhSL4DCYI3xBo/15u?=
 =?us-ascii?Q?R7ya8dVBgYvNZ7dEQ3s9BIRYeOt/Hoe+KESJA591l8UmP2CU6fZhY5qJkg2s?=
 =?us-ascii?Q?37Xqz8jPhtyQ0WRB/y6kBtitikmg5e2wQVWBCqSO8idQspd0MVSPVsTus7KF?=
 =?us-ascii?Q?wJNP9rLTPYAhsMGDvq7Y7uNVhbvUhIGdy96Ki/pQj/NBXLk4VA6Tl7BHlnZm?=
 =?us-ascii?Q?wriS1RW3e8l5I8Cf8wXbMhdIUeWaUTxaK8O1f2KUbHm0y/5LHEGnXZC9/xFa?=
 =?us-ascii?Q?iXKDBy+za2JieCtPVqCHkvyH342ypYvsccRZkNJJaH5AZ0EZ9aY7wVqawMJ4?=
 =?us-ascii?Q?exSC4a4Pmgmtr65JqwMcfJJw6ZPNaGK+6ZegJfVDd0vrPTyY/LlOBML4wtfY?=
 =?us-ascii?Q?RmHhrPPvc2lnh54YOpuIVQsPsnCOgr+akF6Vzugy2IFLT0UxpTqGf88wmMPe?=
 =?us-ascii?Q?JSjNc3HgFoX8Gx6+oYPYm4wrMF9Uz9DxHejc2gBrNiCj7yIbZvetDkYTNq1C?=
 =?us-ascii?Q?r8RssCPEcdKuj5hzQB/4XqJDUCfQfbFXNCMjezdGoArcHguXArVf74/r+6pB?=
 =?us-ascii?Q?PI5HbW+rAmXnQOOqmxKQXCrxYqOxXcHvvp/qnR/kd4n0DIp0mW2KvL3x5UZM?=
 =?us-ascii?Q?Lj6VWsh94+UZKWZACDVl+Ghiy6qqaGl2Eh6//znG9WpblraLHUGwujZcNNn9?=
 =?us-ascii?Q?hv9f46V72HlAA5iXRULrO/Xq+OjpiREFJekafAt4zqNcOwpUIkn8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0ac32b-dc72-45bb-ad4e-08de7512f1f1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:42:16.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyKcZ93hOEuz6/06bERucWB96YNJbXdX9xI69E7kqa11ag3haKNJ2khRr0nORUuKGEZ0xiST0NEUqL74MJJBcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5288

Disable the delayed work before clearing BAR mappings and doorbells to
avoid running the handler after resources have been torn down.

  Unable to handle kernel paging request at virtual address ffff800083f46004
  [...]
  Internal error: Oops: 0000000096000007 [#1]  SMP
  [...]
  Call trace:
   epf_ntb_cmd_handler+0x54/0x200 [pci_epf_vntb] (P)
   process_one_work+0x154/0x3b0
   worker_thread+0x2c8/0x400
   kthread+0x148/0x210
   ret_from_fork+0x10/0x20

Cc: stable@vger.kernel.org
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 42c870ee3956..805353528967 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -942,6 +942,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
+	disable_delayed_work_sync(&ntb->cmd_handler);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
-- 
2.51.0

