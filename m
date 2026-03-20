Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020115.outbound.protection.outlook.com [52.101.228.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD543BFE2F;
	Fri, 20 Mar 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015312; cv=fail; b=qeD6z/noXsoklMFJEL71dt3qnMJ1yVllLwOH3nmgfDse1E0FF9MXtRPRt9uVAX9LIeiOUzvkZx0nKg/spMzx+o84AMoyBhn+X3I1wuBjy5Hs6UvTY64+WKWyo5128o6iIPID0ehyQzqYmimECf+f34KbuYaPGZZ9tC4ThQqALF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015312; c=relaxed/simple;
	bh=vmdvKdApnXTKAMaHAUaXmTgZxQDaQfaVsr6w+s6Fhlg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ru3p+aVWP0IekXIdv/b3CFjZmUOZc4+4I6aqm2yW4wtpJpoltF5DEpsC1NzkhniCyrW2DRDLI/61xgMBYPGnfBQqXEf2GpZMeGBFlZqhTJMFy3l+dniHtdX/L1dTo1sEUilVFUFKoJUvIwEI1KkvRYOxGXsc+MwTrkAF/z1izRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gFLExeJa; arc=fail smtp.client-ip=52.101.228.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gFLExeJa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVsN3KLY2xV1USF4STxDHY1q4p3xoOclSQvESahHbwplbn5mfrtw5ZSRhShwwk2J6imlwBPuLkfmHF36MUGhA4q9wb2QmYSXTyX1HTVJhm0MIloeF8zonEpiASzdeyiX//fek0UAohjRuVQdY+BtpQ6XRBSZp5sc6TPvAcRuF3HIuGhjQ1XA4Uy/7OGIWHhOXXlEpbsTl1/8qXYunr2+HBTvaLmgGOaKlFFLo4ma/h9ANSuQ9pVPaPmM33/l9Q88XzCPlEQoUP3wCzs3ceX9mmhZCCDE2P+NUiWv/pHuQg2Piusn3+Uz1St2cczXpfkgrUAcX81bY7JZj42KlJbW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkMVXR4yT7XJnaTi3gy9Xa3C1NWjlC7H/b6nAd7g9Ss=;
 b=ux2RLLBVLmx2BiD+Kxw832L7rmHwxLxEeybpS2beGs28iPmNs4AYpgd0aXIYH+vrlj7B2g8UB01Dwzw1jA/YiSslPgy/MNkwcFMM+R/lLFqsVJZVHNHgA/UizP3rcaJiXW5w+KiJwjPpioQZ2V6f+Dn0gRle7zvmvp+ktsPXQ6OkJ0mN1UEkCO2iiQUVQqDAjmKv8ITNJFT2/Su/Cl3JBcpqI+myK7eJ8QxKgDsxqzutKawyjRLuXvAdcKflmHCQ/qgSBwTTlu/+EiKFeK2zA9lBAheBJ5aUHh6o8nNo/s44CfNHVNPcABzfjzoD+s7h1UFsDs7C6XN5BOIuZzb8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkMVXR4yT7XJnaTi3gy9Xa3C1NWjlC7H/b6nAd7g9Ss=;
 b=gFLExeJalMaJvtlJZ/WeAJCfcn9p6YQobMbPmf4Ixdq/duMXfgn15TztnsjgYc/1KI7Tn2g4R1ufGdN4dlxbFL5VYO8pMh3p1w2s8gBKNixffXAwSPOI0jbEdo1Y6ppJX5V1OTMbrHig+FjugTcqiDDL3VTMIC0JDFXOiJzXOgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5266.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 14:01:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 14:01:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Use -EINVAL for small subrange size
Date: Fri, 20 Mar 2026 23:01:39 +0900
Message-ID: <20260320140139.2415480-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 69480d85-fba2-4522-01ac-08de8689379d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	I/VjbOn8Iy7aWYUPkzyxfly1BmQWRGZjfTKShve1q4qB21aSJJGSN2Czv4yvI2w5ywp05k1urxvyFQblMGGoByDjmiULscCDb7EgFd2/H/Rsfjy5I4wpUrm/P7ZcTJ4Bx4HOo8PnoKl4Vb2F3FL4PA6tiVEoL0h8QN1PoSRgUAVjxYMtzGLzZf80JbL1S1aQfnojsD+fQwb93gUBVO/Ew9W2ZBgjaPjMqDeEacay3ekhA0LVjQnh/pp0yCAasM7td2D8mZ84vslNiqWVkwOKO9cXSFmWtURiePX9AMZGT4A8ovZkV/bwOz0XA2tEUbF+ydqtaBQOfaSMN/7BcbL0oGUyE6kVtZsqKXvExfqfmA/DAdDwt8QTEz9K6oiwfQXNopQt2dqJzTTs/r30MFJ2f8+9zY7mTWm+ltLDgQJ9IUyXiNKjSQUTMPA06moG0a1OBxIN6mnX8L9k0AgDoEGfq/KvCnwj/fjKn7vfQBmVjZVrsqZXWoUxMywm45Ocem1J67VHu+UUYJVOwuGfP5XjLlUkVw7kU+OZa6M1pUgt6FAd9Fkzijsr29jZNgsOVV3rfwdTeAh2RrjC56j9D6Syte4OemLHmqxOwci13t4Cr+PXH2LU7Bo3Kk+mi1Y5qB6kmR9BzjH4bXJWTYmrj2c6jShraxWMBW6eR6qERnyuyO5V4uDoNQoss4OPAOS79AXbuj0JrP/FToCTkYaGu9mSlUF88GCzbnbE0hHox5k24M8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nHs/M4p2M7B7HuS0T6OKzUhzTqfUgso3y9Cq8taIEZ2OeFbLNad2RYgRBjRY?=
 =?us-ascii?Q?OnQpyzo86xBlg+t8pPimeo+tMt5tnCvTY5w8GI44dDwJ7wToDPl1jln0Nrw5?=
 =?us-ascii?Q?gPTJWoxwYSUzjAKq7h1DAT/fEmFaWsdbGpQhRI/ag9aO9SP8/N93IC+sV8Wj?=
 =?us-ascii?Q?ffxEPaQGRnGSPWie5C5f8Ms/RDoOmbDg8BSUopPVE98xAza1QhSCFfAws63L?=
 =?us-ascii?Q?lQn/G/VVzhxWk6xTHaGgUmZZxiyv0J7RKeDz/ecoFFhOad0YwJm4KpT7F/Wh?=
 =?us-ascii?Q?dWZf67fCriDtH786mHpSvXEldYNjY6JlBZ6rr8RaAXnlyVYFuu/2EW2TSCfb?=
 =?us-ascii?Q?/woD4hpecvEHPU3listSPCFz4Rf2qUPZ8DE9WypWVSuHX4rKYqK3KfOs3aRh?=
 =?us-ascii?Q?cgoyz8XZfBQ/HP5IM5dDVh2i0Xjb+i70sWhNtmX2LFqMdgRgyiesqtvIDOGL?=
 =?us-ascii?Q?B7rdHDQ7+tG5negbZ5e2a3mKdtUYTeOUu+8M9IK8/5uCzj2aT/j+uD3skNj6?=
 =?us-ascii?Q?glEDvwlO+KuoF5+00DZmQYWSG1ugTnsvB1VhAEBXmb92hnxwVfG1dvBM88vy?=
 =?us-ascii?Q?uyXMHorYXmyS6djCJ/F5RQdqi2IxojbIucjGfYgCAcm/n4jHgC7GASZrxhzo?=
 =?us-ascii?Q?i2NigF/tJFZPogsiblMPooqMD1LlrjzWh8J2LpocB4fcDK8y9pya7s7VI3xe?=
 =?us-ascii?Q?RPFV3FxL/UnowKc5Kxfnpm68mgofro97mt83CwHxZVrSu5th8SAv3PVkJM96?=
 =?us-ascii?Q?OWBnElGE2RMDkPNYO5n/NKDV6Ry6crbfU+vkm/z8g7QOHFmS0pgNl2/YcUak?=
 =?us-ascii?Q?ZiBTyBx2RQCwuOOtzErJ+V2LD6KINYVOg1Agm4I7HsEEzRXLVhbygxnWY5y/?=
 =?us-ascii?Q?uKmLLw9LMaPQbzcMwzwVABU6mp5/l1VP3sMdEHe0CJiS5N0qKzjlkX+IM84k?=
 =?us-ascii?Q?/0NEc1Vdn/CFigfxpVPHPr5Te7zmJvMA7q7BObo9AQXmgCj6O01bUQLfWmdr?=
 =?us-ascii?Q?69QY7Mm5jcNfuSNfMkQCWVbihoh9pkgdeH31y2glToYLDLe9aGleiFxxBPeT?=
 =?us-ascii?Q?ux3gRBELB+Ea2UsFmrB2qb7zYYPOIOq9fe5J8nifLujUbw51Br0p9j54l2sC?=
 =?us-ascii?Q?UtsLl0ScajeUlVcyPklmHJeAxVfLfNZI8X60nEXeYNsUB8bn1fYk22vdPldW?=
 =?us-ascii?Q?hN6JX7Y6fd6H1ESH1uOlXs9PBZyBcDUvlFvKvmFHXFT30O/JXH+VOBzr6e/d?=
 =?us-ascii?Q?W+7FFsEERWZacFLfTCx3Tejo8cbg4CHg04BKPs4PDTj6RWN8EEzygdadtvf2?=
 =?us-ascii?Q?9/4tyLl8tJkC2BlnI32p0MADCKpn4KGXXCK4vhjDIIcQ24Cw6DAMMdi7n1zN?=
 =?us-ascii?Q?bLrV1nh/3BJf9P6ValXzFE/tXnpSrSsd7ce4qI8R1yKW17xg73mOccyY60Eo?=
 =?us-ascii?Q?0Qd46bQP+rAoVoj+yG/ksV1/S0zwmLDTEPFeyoQvXyef2f4mhE+ziCX/nF4+?=
 =?us-ascii?Q?M/TM+1VWkOOklDS3Y8SsQA8EN8Wl+yEjU701ATFRHqKO51qEeGcbOVJPkI+e?=
 =?us-ascii?Q?dZpsSybX8amKrcyNw2Nk4rimpgysU8nj91vWCZRfXsAszeXgHthrmXfG18V5?=
 =?us-ascii?Q?k+r/MvDpWuRRzsVpbWvlsvk25+e0QMGxJEKpt+VB2epg/q6LfuigD3KmGwJt?=
 =?us-ascii?Q?k4iwrmBTWvNXHrgHsccXtra65B0HVnjND3ObJyOLW91icUybLEJsTYm8Tjau?=
 =?us-ascii?Q?pn0eE0fXDqgzgiv+EwOUuM2XFGrlFPM2OyuLBmuBaV7DJoFhfKvb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 69480d85-fba2-4522-01ac-08de8689379d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:01:43.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPQ9lYh6fHeuJA/R6JyaKGq56L/QjjMJXwLlJ97dwyd7jhQ1gNQUs9M9Eo3vSH2j0FhJXAhTmmWH0pTAcQkMNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5266

The sub_size check ensures that each subrange is large enough for 32-bit
accesses. Subranges smaller than sizeof(u32) do not satisfy this
assumption, so this is a local sanity check rather than a resource
exhaustion case.

Return -EINVAL instead of -ENOSPC for this case.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 55e128ed82f0..496c8f509590 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -543,15 +543,15 @@ static int pci_endpoint_test_bar_subrange(struct pci_endpoint_test *test,
 	if (bar_size % nsub || bar_size / nsub > SIZE_MAX) {
 		ret = -EINVAL;
 		goto out_clear;
 	}
 
 	sub_size = bar_size / nsub;
 	if (sub_size < sizeof(u32)) {
-		ret = -ENOSPC;
+		ret = -EINVAL;
 		goto out_clear;
 	}
 
 	/* Limit the temporary buffer size */
 	buf_size = min_t(size_t, sub_size, SZ_1M);
 
 	read_buf = kmalloc(buf_size, GFP_KERNEL);
-- 
2.51.0

