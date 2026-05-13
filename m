Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021141.outbound.protection.outlook.com [40.107.74.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD303911B6;
	Wed, 13 May 2026 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640586; cv=fail; b=lDgfIiKTbQKrw/3oQg2PgAvYUHsIhoL3HMlHGvn3NVESoEq2RNKjjgT+Pohu51B/VTHwRE7amwck66MCEifSH+ke4bVSCEpmw/iaBJRGyrCbRb/JbjeR/Y7nR60f1SkiJxttPHzenSbIYkfOJokXtyGwnRnSLd1bRtxNE2RTJUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640586; c=relaxed/simple;
	bh=sng3Ero/SiolvOhyfKWs4Fo1oNoc8Jvy6oAYm7rbF0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFPQ3qsy+1iEiNzzqb3nODUykg9DfDg6/rXnJdQg9ct9r74oTju4NBdLq1teKAfvaLKnP101kn9roh85TGhFKY2v05KQJPF5nngxqEsU8KyQCe3kUlpPi2Cbzf69R0edve2hP5qAzCaBrpcjnOWiNCGfvVi0kOZYSAfXcSCnbWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AykTf6ox; arc=fail smtp.client-ip=40.107.74.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AykTf6ox"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/HasCe43NPdwe6KnKehxK/uPJrvr381pMBZnG6s0jz0ZVc0+t4ItDe2ILGolEmVXcPd9CakS/9Msr1G0jMldpjO26QEGB7twFGA5Pxmr8vVXGtxjg5GCsiWOyBqueVdZBfaODR3N28/uBKLZZMqWsAgsaNwK/r1Dwsa8PvLeLrdxPt4cCQQhKKYsDdrHdhv2wXVSJI/ry/bTKj8+cTV3Ht+EwIu8WmIja9CHqLXoxdNxBNV/B6hXgHasAXTr1WNDn+uzgA3fdlPfeyXeX819C4VAzjXWIczzf5Ljzurv8cbX0XH9xY68/G/yUQKzvZt9xWu8d44k6SiJEAYCmf11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1F8nEYX8axxQwcoftLJiLVp6UNXkY5pTZKX9D7U+p0=;
 b=CXdEMoOsRfKexb6gRR77FyalDlkGQPeRvpgsqH6r2W568goxGfMgylBtYTWCYKb/45aY4KeQnTniJBB7xLTSI2mwMraE6rN/1vj28aIuyFKjtiIxoHAFkrw/+xccAOm/88ztgW9jrAIePIwJ6268hTJLUvDEP3xgk4dfTr7IINxtkDT4TTtqp/67GQLMyHTSLtecZOcMDydEtDyK1NDGyXAaj6ZIRwh7YqdLrTlZAIiNCiXDEDRyFCxNNdTlb//XGUS784Gf4Z4HTPp2fJPJkn1dHMsecJ7XYFYCzLijXSpt/J5M+p1gg8psMKac3VJnBcL+rnCPsTJbG/d4NIxY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1F8nEYX8axxQwcoftLJiLVp6UNXkY5pTZKX9D7U+p0=;
 b=AykTf6oxFuNu/nY7hrmusEPKingsi/w+4HpA/PRzFVl0LOY7He9EJxmT6RKqJhaj8nEs0017YRUheNCC8/J9JjelYCXN2Octnws6n708eYb2UOzGsZGG+CujOC4HTnERn+EAU1oi9Vx6Fad56TE2GnTR+TSAN5H9407v5frdrHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5341.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:191::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 08/12] NTB: epf: Document legacy doorbell slot offset in ntb_epf_peer_db_set()
Date: Wed, 13 May 2026 11:49:19 +0900
Message-ID: <20260513024923.451765-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0130.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e014ea-4d16-4a12-a47f-08deb09a4356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KoC8OuK6twPW3tWPGC65TY5PkavmBdruVLlfCp6TC1KujTP32N8uepCYmW3b13XFs45w8s0LR6blgWOAEMEFMq9wNIyUluNOIUxCeE+pd7wuKxbo358N4TcN4HgmuRXq2juwBg0OGoUM1vgrYswya8sWf67jR7ldZe15h5YzHQNB16zckI9fVj5kqALjPKKpMFfO1c5oadsLttifSzvnEEjLKvEtCgMpNLZrQnp27zU1bHx3a/lxIiY3Fyixw10a0YAYdXVTdUtlwx7olFHpXKhycDP6pYNjwUhaqaztF8yr7vYpHS+m3hvzouFKWvD4ZcmqXL47kswCXIyCWARo+cMTvFJcG6BRbeCdxQkknr9/BCYYNyD4vWAaGMqOsBFvs9Qgo+49SWM9SYl98yie2v8/IuvOzn8cOdbyU5bpdjWxVWCXRvTuWz538D/p5EVLg6o/ZEK8xYnsGeMHELCAubqkAembrJyXwwo4OxAXddJTyTi8PzF1UTXLYOwky7NqccN032D2M2hj4SgvoCzNwSZ2w7QJBwSRC6btGYH66adwMTYmScs/fPX8TCidEsda7ZvVBgJppe86e0VNickY+GBv/765LRf6bDYf7eBPVkc/KJBot+9r0qkVH4htQmkfDhlf7ehxd6P6P19Vzh6uc9sEqda4pZp/4hhXQWltYqKcMaS65uGlQKN6kHfaj38JRHKJChxwVSD0DjHaV1vDWsLZjcvz3RQkEHa8X+wy5yI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMIByMZIdLF+C6TJhTyIpNoRqbTHJpcVM46a3S14XZ/nC+nZZo6kLHGCa1v+?=
 =?us-ascii?Q?DsIsUP+FNIM0A1XgClun/AomjE1DslSocMFLkE5quBPP6U4TV2jutYcBYkhP?=
 =?us-ascii?Q?Y9gGjrJs3hxLGIUrqbsFn+QggscpKx6MKicdH3QkKWv63IhiedKp1DAbZVyT?=
 =?us-ascii?Q?hCJRcODvP4Ka7r3/PWO03mnb3jxZsOxJm2ufiDzni0DtH9jYRi44GBWox8u+?=
 =?us-ascii?Q?668oDqTjfkX+4bn5jtJlwFFDv/Hza9wCjmNYKWsaYwa8/5lBUMI7B0PO4PBg?=
 =?us-ascii?Q?jr3V5Hj7X4xCf7UEWT9svT+uitxi3HWTOhNIz6YVPvkqqvKaZsF8WYe9VUu0?=
 =?us-ascii?Q?GYIZmCw9x0oyVdGMer6ID1etj4uJnYsLVWdHhjjzgG1JGbLPVf452Q363WKL?=
 =?us-ascii?Q?Vk/BhYKfPpKANR+x88wSmu6LKQxVej3fmomzNiHPOSrCLim9tP88rl9DOfsq?=
 =?us-ascii?Q?OB7KwiW2WgadlJkWgQ1+xsljuzY7UDJfEkY/q2Kphz7jVdx51aEDN5p4AX/9?=
 =?us-ascii?Q?SWIgdGS7XIFeL8uFAxOVpIXZLmXnmH6uB1ItoOKJnjkhXWM7cBhSjDvGS8lu?=
 =?us-ascii?Q?YECSHnVElW2nKm6eAeI2PxDpRz1BWRpZEKAeW/dIp3JaySt4gjVDfOml/ZEq?=
 =?us-ascii?Q?JY3po7wt99dZy25rdpNbGi8I/aXpYqUFIwnwCYM0hwG9AO/nvBAwTd7Nd6Qv?=
 =?us-ascii?Q?hnS0W1TaJxKbUQPSIshETOGMw6Het5zdbUZdXHT11+xFJkeGzTtWK4gvU6aY?=
 =?us-ascii?Q?U7aq4+yNSFZrfYsRVMNmGwXwg8nMKgNN50qlhg6znkOBHnfgEyCAKZ8bPvcs?=
 =?us-ascii?Q?TtwrsZ/mHFXmjzpLbaI0tu3RPoMjdMbAmoTGdtFwM670OGrP/E8TvdZ0FBZy?=
 =?us-ascii?Q?l2wQ0p5ah7IEQfhAKLI6WbfZHhfMNXTDxnAcdP4rCKtyluOsmwASg6gTSao3?=
 =?us-ascii?Q?hiTRNkrmuNuahJHtlR7R20i9kZSyvEl2RC2vjjWWbt9TONEh2iRjOWY1Pjjz?=
 =?us-ascii?Q?9exoUxphUdTcBWoXczgThGt0ySXDybHAKihr8dMBmugzbV5iQ3m/wQPfV0b6?=
 =?us-ascii?Q?tn65lidP8NT9hhHTmtOVybsqtBhhzMSh3zf5Y14SxuDZ1N7zTZX8s0HTyu7d?=
 =?us-ascii?Q?+RaDtyszQdIthpWKQnZUIPUlSp7L286xOYlv8d7NSD4R9YcrbA3yP1ewBlN/?=
 =?us-ascii?Q?aq1mRhR1zLDH/3QV004WTH1Br5xFqbeZVasigsKi5yLmMRMO0aRxfN7ZEKA/?=
 =?us-ascii?Q?ohoc2sxBVLvFho8PTQTuSRs1qz/fyi5w05CPRJ6IpAN/HEG6SsCvuJUTjJoP?=
 =?us-ascii?Q?kYdLJggM6jRM4B2EKQ5g14NAKFeyz7dnu1V2KkWwrZRqScfU3OnAYSbpPP6L?=
 =?us-ascii?Q?htU/DTTWwbsFnZvEk6cI5WdRcfsGXt+bQtlqV+swoq822cK33IpdV1AlsByq?=
 =?us-ascii?Q?xoS2lhEgmgtKi8ZjMujyejF1LNITFHZTAeWF9c7/QfdILpzq/APsW27CYtb5?=
 =?us-ascii?Q?Zjq+13TrFb3vBEK9m0oL2Nr4JAH1MxLcrQiRFY+yvfEeIsyZ3zDEPE8sNHlP?=
 =?us-ascii?Q?OTgVyS00HkqLGk8u4Uvk06MTmKy0EeWzwQO/G3BPZO0tv9YUeBpXJLE1uOEe?=
 =?us-ascii?Q?INTmNZYCNtEH48ydASzHso4ayvYN4InqQ6sEwK9SgoVVLKsSSYHD0b29Aane?=
 =?us-ascii?Q?hVnkK8MO2eQiXwkGKb8Si72dy7MjxJxLChdVs50osWug330WM0QSlMnPaW8k?=
 =?us-ascii?Q?h1B5iMWEh24v6wJGYJ5PI4twxQl2rP7yXV0UNyvfYhg4nTavZAEO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e014ea-4d16-4a12-a47f-08deb09a4356
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:33.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68VmXDrZ/Q4w+S9l/z/Tu6CAtEW8hYx4TyPYNiXCDwL/LDqf3euq3E26uByrD908gl6/X1uoxumB+wNRLnJjxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5341

ntb_epf_peer_db_set() uses ffs(db_bits) to select a doorbell to ring.
ffs() returns a 1-based bit index (bit 0 -> 1).

Entry 0 is reserved for link events, so doorbell bit 0 must map to entry
1. However, since the initial commit 812ce2f8d14e ("NTB: Add support for
EPF PCI Non-Transparent Bridge"), the implementation has been adding an
extra +1, ending up using entry 2 for bit 0. Fixing the extra increment
would break interoperability with peers running older kernels.

Keep the legacy behavior and document the offset and the resulting slot
layout to avoid confusion when enabling per-db-vector handling.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - None.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 8925c688930c..21d942824983 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -43,6 +43,18 @@
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
 
+/*
+ * Legacy doorbell slot layout when paired with pci-epf-*ntb:
+ *
+ *   slot 0 : reserved for link events
+ *   slot 1 : unused (historical extra offset)
+ *   slot 2 : DB#0
+ *   slot 3 : DB#1
+ *   ...
+ *
+ * Thus, NTB_EPF_MIN_DB_COUNT=3 means that we at least create vectors for
+ * doorbells DB#0 and DB#1.
+ */
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
 
@@ -473,6 +485,14 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+	/*
+	 * ffs() returns a 1-based bit index (bit 0 -> 1).
+	 *
+	 * With slot 0 reserved for link events, DB#0 would naturally map to
+	 * slot 1. Historically an extra +1 offset was added, so DB#0 maps to
+	 * slot 2 and slot 1 remains unused. Keep this mapping for
+	 * backward-compatibility.
+	 */
 	u32 interrupt_num = ffs(db_bits) + 1;
 	struct device *dev = ndev->dev;
 	u32 db_entry_size;
-- 
2.51.0

