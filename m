Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021114.outbound.protection.outlook.com [40.107.74.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DA2DF707;
	Tue, 17 Feb 2026 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315583; cv=fail; b=KrF1cRCt7bWghAldnJV8p7uoV4zKeUoVNZCgQMD4FzTEAF+2Ww698C4O5nHsgMowBfBwxcgGev90Z/GE18JxjWyBnDJfBW44oqdegq5z0lKv/OU8/0h6Ak9TQGaJueVsK0HPsA9tWeXzDQymOGwxg4kAb0Znzz//SkjAjEUW298=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315583; c=relaxed/simple;
	bh=NGUBqpXStEhYVYNtvBHkE3nhOawXzDFxMEJeZIQZrN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GLrLq+rBTytwOda7GlLiX6AGrojIx/NDubDqnEAUoWISKCjyoHOA08W9Q8Zb/5UVUHuA3mREIcn9rpI2Y1dd92wtCRCZxlcMPYaEt80rRbe9pqtQF6Usg+RXhZnHtnsN41gFUnGLRBqndk43OKm6zcNKM0jb0Ztoemhmc10soA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=K7C1vUr/; arc=fail smtp.client-ip=40.107.74.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="K7C1vUr/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5pGICgPmnqX4rKcRu+CGqTCCj6Yllx9Mqni0OevKDId4Uu7NsJe5Si26y+6U2xWDLQ57JRLZZ1Sapvj6pV35uQpmjD5A3UTyQ36nnXu4eCzYC1LhEiq3qr9PjdawDlVMWBBTprvOI1+r3o2KTQHdYPgzAhug1biVxF4EyaYznRYq+X4JRTcJV433+U7fZN6UspNfKgvR2B844Q93mM8ZzlY6KBInGCcoaxDkSOQqpQy8jOe/Ha8QyNCFw10yHqGiQk8B4ZuDneKAtcB3NAfNjWiZC/+rmBSYXuFjdzq1CddxWDkppBhVoS3qXal8phnUkI3OPprFI0IXMcutSDQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHwHdnhRuoRN5muLu8YkVyQT5oWn/9wyB21jJTKRj0I=;
 b=nqCrJYAL+Q+Id8coMMNiC53PsaQJ7YquHMRnGu0Y+mJ88Agcv85uPtoRzJkjx2+BzVXGxL0Kycj7+a0v2hMY2UkGjlRKuzwG1dgGcd3zOPB7rFeABwyJ3ZLJHim65XI4DhpkiW4EMlFspkLEUEOGH3bMoOJ0C13xKVwEKZnz7t3rq5nQorYeBlEVsZGmsXrQ5pk0i2FGz8RGj6HQeJ34fWcTHXwjqpXGgGFEOYOyJUYqD+V5q8D9JoMwmmuC7d520qmhGRuOEDrr7MAGOIVhAfueMN00CeYbvJGggah5y+nhdk+hI8TrMXWJorMJBB3TaOdffw3DZ5OuYG+dLS/oHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHwHdnhRuoRN5muLu8YkVyQT5oWn/9wyB21jJTKRj0I=;
 b=K7C1vUr/oJw8ZDT8m1POtq4NdZ5swj76PgUYgmSGvXMSKHlf4KEtu+oEY8QR2FXwLsWK/1IPF4D5gcA3yQ+PanD5HbYQ1IgdfsKqmjPOC9kDHj+PbZTvUQ8kx/XjT+s2jp1eubotHkD0AqgleDk1BKLdyDIG0cml1A8NSy00l0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:14 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 8/9] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
Date: Tue, 17 Feb 2026 17:06:00 +0900
Message-ID: <20260217080601.3808847-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217080601.3808847-1-den@valinux.co.jp>
References: <20260217080601.3808847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0a01fd-de9e-449d-6eee-08de6dfb6b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eO3U69qKQqjrst7rPjSBxoiHJD2GY/O2GTsjnMsQruFmEsL4OJVOxXvh5JQS?=
 =?us-ascii?Q?1IbnXNNS5XY2Dxtrlap6+STMGbS0re9zMEgA4NNOOj1t+v2SWeKPqzTwv6gb?=
 =?us-ascii?Q?/8bNTLgTeg+Vv+djdEcIBxLd9CW+fpVI0JhtYIdR9n0Gib40ULp03OZzj3ci?=
 =?us-ascii?Q?2HoiI/rp0olEjYcJLvd7X9tFytD51WpCNyHj2tGC6Pt7jZiCaVm5fsD3t1jT?=
 =?us-ascii?Q?qfkwhatSXOR1D2XVZcHpumFqIbIx2wrr4Tb8EFGVsx6WjLiqzega4bB0U5QJ?=
 =?us-ascii?Q?f6/JHz2mjmHSpu6UbpaNpeEkqB9ewCDGC5mydmBQfm+p8CjPGMGKH6RMbBaK?=
 =?us-ascii?Q?wsK2gtwPzvnoB1nM6iFDfcOsmaVTBx2XG5xpwgxpyBa+Epz/k5a9Z0dUW91W?=
 =?us-ascii?Q?zl5MCcTRICGbHIA+f2xUT1ejSSgBbzXTcRNfpXSFPyxf/D4CX6fN4VhSPZ6i?=
 =?us-ascii?Q?x9gDGFIIWRV+KraqQW7NBOyjPjtEE1XqNYtQgHJNRF6w01mgZDDWMp/PYCOv?=
 =?us-ascii?Q?uI08RVTiJse60ZmZewrGAxNCSHaFS29qEXC0bAH3mtqOa8SY8ITYtOE+UFvA?=
 =?us-ascii?Q?+U7Hmkk9KCTmKORoqrx7iJTmbVkDUNpPItlfyGhGbDGrLRMUcwfyZgb8SFF4?=
 =?us-ascii?Q?IWbcR3unmN68KRaE3s3CTKOMsnGeEf+K8mIcKSxLhxNIpTq2NYj2X+4lAJBt?=
 =?us-ascii?Q?3eiCFCsVNhypMAxq0Qd+qiVABeGavm5Q2k/oD3vpkOJSGc1bxNnIsaAbwi9m?=
 =?us-ascii?Q?75nwdkboZZ077GdY0IH90BnuQeCX9sXKKjWO6BK5zv+QHi0cpZe0oEHeAlNG?=
 =?us-ascii?Q?nlkRNVDf1B+zt85RJZwrbDcNTC+9+UJpjmE6WdNwaYl8nBKflBOTNDQZ2rq+?=
 =?us-ascii?Q?Q06TpAO7Scz2sXyNrWd5MGKSZAIhlguRUstLk/u9XCtrEY8nxNveuXa13xK6?=
 =?us-ascii?Q?mnzHtOTK5/lK+uc7UZ7NzI3Vqs0g7KXDvxCkfLy5We2TLhb3YoQe8+CfxiC/?=
 =?us-ascii?Q?Mu+6VkAFwB5lCiExJZuaQkPeuqmvBGSh3WjPNGvRMaP3m40HEp8UBCE4Gqgv?=
 =?us-ascii?Q?TDMW4e3dT/JzkJUHsD0aXh0KdfSINKboFoKzg80TtEpuKE/tbJnhNLUpVszO?=
 =?us-ascii?Q?lEjQ4O+5Xph1qi0F0SOQ2sP+y1aOl4MZc97HqbRPryz3szRRHii74eRmnz60?=
 =?us-ascii?Q?PMsKsQxlPX9Pn2pVzFmwv+djr87t584MFq3pXruJQnRzAQrSS4LA68Y+Vrdl?=
 =?us-ascii?Q?1a3M4unrRKENq7tY1KBkztCL/khDjux6xhQJDxoZHVEP57I9yrcJWe+75AFX?=
 =?us-ascii?Q?pgon5jWglrZwJw5dWEKmYAaGwucsrS0BhYJErU4bAN1ooWXM3SgYKjG1bAIT?=
 =?us-ascii?Q?VN+49Z+WnfAQk+309l83NcgAgsyzE0VDSLXcCAeWz1pS5TccnB/PH7zwa9ae?=
 =?us-ascii?Q?0/llCY5OJ+UIwwxCEkIEr58Oyj9gDa+9/qKgosFY0IAIbpZlT6/gnaJhndg3?=
 =?us-ascii?Q?5qertQCQz1o9LKxN76MrXlqBGPRaL1dpzprkF8EaWHPBfV/MJwBnrVt4SZ/P?=
 =?us-ascii?Q?BFjhUN5U8cLBQhG9epVgcEGQbVCK4nYpOliVJ8QCZV9WJbRNEtVPTXrOis0k?=
 =?us-ascii?Q?bA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lh0IbMj6uh87/zkhFKZaniRne102Dx3jYojJmKdOe0eepog7eUZu3haU7MhJ?=
 =?us-ascii?Q?yXz/bAE5ip2DHdik3/z91ErAnbh1FLSqdpMOXHkExLPOLxf5SyaPyZAixy0o?=
 =?us-ascii?Q?nPuFovHzDwCDr0M+49fGvwRV1eYOrnbObjAUq1odj4USQh0Z6fe2l3zvW9ao?=
 =?us-ascii?Q?3prCQhnJr2VnDqhYqXOTK4slNLbCnJIIgXkXEEoqompR3hKpjz/fapltzsZR?=
 =?us-ascii?Q?SU9kRBaYi4tPlVLgP+w6aHekMbnRc2X7PQZBnHRrTx4wtRC45wzjr1kJZiA0?=
 =?us-ascii?Q?L90hhLth/MDIgqe90DaRK7owdUyjB9STcUb5RZEe9LrHEVA6WBKhRbHevalq?=
 =?us-ascii?Q?jAKkl8znebPB2XOIK3TDYC1Gakk/NCrD5wxCZXXHjbTzKkHk8iCPvO0XOIep?=
 =?us-ascii?Q?0ueXg0RCbklxzqDCTm/upsiWEUuTjX1SW/cLfjHn5wEztJ/qi/cSqvQpjCr4?=
 =?us-ascii?Q?olfw65JrnqALUCiaer6qZA/nsOdXel0ZcdgUg3BaMIff4FhPzOYE/Fkdy9Nx?=
 =?us-ascii?Q?GY3mWk6GGcZBBIkaGAz0hr7ocJP2vj/p8hpP+5W13i1hvno5qe4twLYmP7Ey?=
 =?us-ascii?Q?SwV7BYGYEXpYH12+kZhhZq2GM+vo45O7ZMkO4GsoZQsSbDGgJRr+OcC8auV6?=
 =?us-ascii?Q?wz7D8z9q/1hG7K0gmDicFEhPo72JKvzMsgOjwMSYf4JXijBw82zbrYZKscsF?=
 =?us-ascii?Q?3uY2qWgxM3gyHZDXp17S3FCu6DlzLs9QRO7UsGTHEQFjFyC0VzPLWoWQu57c?=
 =?us-ascii?Q?9/GiepNKuIEAcTk+ebvbPTqm6l1ekiRuLK6PZWkXqCz70lLgh7zpt6aC7g3w?=
 =?us-ascii?Q?++hxM8+/Mi/QgES2p+tIAGT03uyJZVyDiW1AOTFzujJk2dC2rVlKGx3NiApe?=
 =?us-ascii?Q?Fzk3enmeYDovnNJFBXgEjwZvn8LoEXDg2j7HoTLj9oz1UMbzgWLewBB3LdzS?=
 =?us-ascii?Q?8w2H9Du1G1NkHUc7E9am3KWHGZIRW1EOWqyWTgpNQxjbUK/Y0bbII8kgLKWP?=
 =?us-ascii?Q?xzqntPhUI1pEgOYaLbwOnBsuVnUytqHx6pbVXSSd0RE0Y7e8adk79W8mboMS?=
 =?us-ascii?Q?NvYgwU50BFj2BS3UDcrZ8Lr4EgfdQWNQJlLbb8aGPw/rgcUpuFIrCXbDRtac?=
 =?us-ascii?Q?ZM9WGC/AhcNfqRZafLGxG6kcTjuUlYM4fGE4ZrZIuRwSUPAUbDjbShusdYQN?=
 =?us-ascii?Q?dOwn+W2WiF9DXy/NqWzPhRMPOMf0Km9zIYMct0Ss/NZnWGx66jWKeYet6iHp?=
 =?us-ascii?Q?6/fIhuSX129NfYXfHKiL2thESLE5JmFltTC/ORvixQ6cz9Qd/HVAkBNGKncv?=
 =?us-ascii?Q?J4yktpPFCmaWuSHeDHglx7DFs3o8jn+ryNSIiTjp+SlZo9lbJoHk+cwLpkJc?=
 =?us-ascii?Q?7HWL0aWwgzJjxTbojRogVV9cl+mBgFt7vX1aSZTOX9VILKtS+gV+ieF2PVar?=
 =?us-ascii?Q?v0GggPsTiz8X+vG2Z82+LyBNU7h4dl2gnEdmqiIg/tdGwVaR/offvaVKqViI?=
 =?us-ascii?Q?PgI+rQnJ+mFWk4W+Q6tdafbu/T8leo6W9gg+qYeGn+yEEy8xCmt/vnxdyWxw?=
 =?us-ascii?Q?dKahhhqfAP9R7ntIm4iJvBkVmZ9wYBoHxAZtZqy4SvCpyOllSEV8sCzTvgz8?=
 =?us-ascii?Q?lK39wTjZXOITk5EbWLRRLs/qYy0HD1vKov5VcnGnElweZNPvEhbvgSxrBIAw?=
 =?us-ascii?Q?vp4LelaqsGxp39/a0ZJ4ayOno+K/l2kfi/w1BDfu5QvYNdLBF71UuRd5fqLR?=
 =?us-ascii?Q?0JSw28nvaQygSqTeqg2/z8Y9/9zamVwBZ1msVCgI/5vgn8gtiNuz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0a01fd-de9e-449d-6eee-08de6dfb6b8f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:14.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqvM8NxSnhJVB+yV7LOK4mvR3bDvxn5d4v4L8PxW0Yc5veH9Sb/5uuEcdhRK/4ytX5I1adzqCzAUwh3H9k94uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

pci-epf-test advertises the doorbell target to the RC as a BAR number
and an offset, and the RC rings the doorbell with a single DWORD MMIO
write.

Some doorbell backends may report that the doorbell target is already
exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
case, reuse the pre-exposed window and do not reprogram the BAR with
pci_epc_set_bar().

Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
only restore the original BAR mapping on disable if pci-epf-test
programmed it.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 87 +++++++++++++------
 1 file changed, 60 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 12705858e502..f5a74108e180 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -86,6 +86,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_bar_programmed;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -725,7 +726,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 {
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_doorbell_msg *db;
 	struct pci_epc *epc = epf->epc;
+	unsigned long irq_flags;
 	struct msi_msg *msg;
 	enum pci_barno bar;
 	size_t offset;
@@ -735,13 +738,28 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (ret)
 		goto set_status_err;
 
-	msg = &epf->db_msg[0].msg;
-	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
-	if (bar < BAR_0)
-		goto err_doorbell_cleanup;
+	db = &epf->db_msg[0];
+	msg = &db->msg;
+	epf_test->db_bar_programmed = false;
+
+	if (db->bar != NO_BAR) {
+		/*
+		 * The doorbell target is already exposed via a platform-owned
+		 * fixed BAR
+		 */
+		bar = db->bar;
+		offset = db->offset;
+	} else {
+		bar = pci_epc_get_next_free_bar(epf_test->epc_features,
+						epf_test->test_reg_bar + 1);
+		if (bar < BAR_0)
+			goto err_doorbell_cleanup;
+	}
+
+	irq_flags = epf->db_msg[0].irq_flags | IRQF_ONESHOT;
 
 	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
-				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+				   pci_epf_test_doorbell_handler, irq_flags,
 				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
@@ -753,22 +771,33 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
-	msg = &epf->db_msg[0].msg;
-	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
-					 &epf_test->db_bar.phys_addr, &offset);
+	if (db->bar == NO_BAR) {
+		ret = pci_epf_align_inbound_addr(epf, bar,
+						 ((u64)msg->address_hi << 32) |
+						 msg->address_lo,
+						 &epf_test->db_bar.phys_addr,
+						 &offset);
 
-	if (ret)
-		goto err_free_irq;
+		if (ret)
+			goto err_free_irq;
+	}
+
+	if (size_add(offset, sizeof(u32)) > epf->bar[bar].size)
+		goto err_doorbell_cleanup;
 
 	reg->doorbell_offset = cpu_to_le32(offset);
 
-	epf_test->db_bar.barno = bar;
-	epf_test->db_bar.size = epf->bar[bar].size;
-	epf_test->db_bar.flags = epf->bar[bar].flags;
+	if (db->bar == NO_BAR) {
+		epf_test->db_bar.barno = bar;
+		epf_test->db_bar.size = epf->bar[bar].size;
+		epf_test->db_bar.flags = epf->bar[bar].flags;
 
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
-	if (ret)
-		goto err_free_irq;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+		if (ret)
+			goto err_free_irq;
+
+		epf_test->db_bar_programmed = true;
+	}
 
 	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
@@ -798,17 +827,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 	free_irq(epf->db_msg[0].virq, epf_test);
 	pci_epf_test_doorbell_cleanup(epf_test);
 
-	/*
-	 * The doorbell feature temporarily overrides the inbound translation
-	 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
-	 * it calls set_bar() twice without ever calling clear_bar(), as
-	 * calling clear_bar() would clear the BAR's PCI address assigned by
-	 * the host. Thus, when disabling the doorbell, restore the inbound
-	 * translation to point to the memory allocated for the BAR.
-	 */
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
-	if (ret)
-		goto set_status_err;
+	if (epf_test->db_bar_programmed) {
+		/*
+		 * The doorbell feature temporarily overrides the inbound translation
+		 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
+		 * it calls set_bar() twice without ever calling clear_bar(), as
+		 * calling clear_bar() would clear the BAR's PCI address assigned by
+		 * the host. Thus, when disabling the doorbell, restore the inbound
+		 * translation to point to the memory allocated for the BAR.
+		 */
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+		if (ret)
+			goto set_status_err;
+
+		epf_test->db_bar_programmed = false;
+	}
 
 	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
-- 
2.51.0

