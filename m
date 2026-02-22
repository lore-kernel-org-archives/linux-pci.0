Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020134.outbound.protection.outlook.com [52.101.152.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC01BC46
	for <linux-pci@vger.kernel.org>; Sun, 22 Feb 2026 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771721214; cv=fail; b=nA/eFAaUNCSgyfTKUFd1PoGY1bp+MgFrxlMXcJUZ5oTX/2fnoUCapzq+Z8pQ2nw36yWME8c68hkKGWeMmDX6MDbq2es+yN+xwsjW1oBYCyMNse2MLmSy2XI9XXQHb94HjR2OwO5DT459e9OSOH010XF9Vnp1XWiD7V0EK1fEzZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771721214; c=relaxed/simple;
	bh=K8h65caOSM8yJfb2gRX7spp0D5I/QtZOE20CsB3U//c=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jFiD02Rq2uo3XsHHnwMiIZlpChFat1aV1GIh6P22xidjeZICplMKCqpan9tILY71Tl0bKQmvUbgDh0rhYsknMhk6jUgx5p+z2C1CTib8jdWtOC7yrjXytBNRtODXcRb2hlpU9yPrSEehZRlagdNMJ5QaEB55h9Z2MDH0zhCAHDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.152.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axKOREPCjGj4E+uBlylr4o6KEwOpS7r1Zl7BYHKDAaOaLXakBMPFbjGA1d/Ikr/TzJgqBqkyAEdXKTpEpjAt6OzWGzDwF3ZM//atnNsAJfpR1J7/8O8QPptkxGzgw6kT3dASjwF+u+4l7c0OuN5KZWngAix3gCjlhN3OXzK/66aH//7UOkKXRkdErF3UBX6h6u70espxDt3J868yJAVR57RKJWo6If1LV1s5n/wFSEIx4JODV7WFQ5zCRbdV6UaonoXrGZfFgS5YZFhRF64q0DhRJTMP2mQRGP9Vb25yN35pB3z7VxbpmEKFnkJtYTfaruh5eM+EclneuFW81AoApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkeUeH/OivZJyZoAcEtbbcuUdRvMXNCsxXEW/zymQYE=;
 b=Sxo/861ccDwXCwVdbVE+NtA7L+0H5Z3owyEEg9z2Fp7YSqjiicCoorMGaMdUpgMQSqdX06YSE847c6M5tlu6FehWcM09NxKo+KBToap/9kYJhMlbJfRt9rBNsTlgm68+0uZ0fGmR2s2j86Wlf5EE9jQoMBAFz+XPY+cdtmiWdXmG91S61IgTqyyRaKAAvoyK/5aF+W5IyKCIkPpt1jRy9VxJA6L2J6kfOSxguEPHXuIsisYtsA4NyT0Eyre0Gm2aCJKR8Auy8lHvQCjxqKsDR2/3a1xz0xciqd1KX6LiGwqqaldL63Q4RYETtHRT2yx0DhG0BWkgpXqO9SzBrMQ23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 SY7P282MB5865.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2d4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.20; Sun, 22 Feb 2026 00:46:47 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 00:46:45 +0000
Date: Sun, 22 Feb 2026 00:46:31 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-pci@vger.kernel.org
Cc: rudi@heitbaum.com, mj@ucw.cz
Subject: [PATCH 1/2 pciutils] libpci: ecam: Fix discards const from pointer
 target
Message-ID: <aZpR5wfDQ7fg-4cl@4c9b59f0293a>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME0P300CA0067.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:20e::8) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|SY7P282MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 00694426-184d-4161-0b04-08de71abda2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PE10SHZZLU7eGhvDr1EqCbhFoqdj1d4I2sw6LJ4CSpK6ymOMDwZeFhh0HNlB?=
 =?us-ascii?Q?x+OGBvtMsf1aJTpQUBAKs7dEJohnOtmuM0DydXdtz6FSxwe224QMLvH4HwHT?=
 =?us-ascii?Q?Nusqnvl7jTscjkOT0ourZH3JXLpW/ImbBenlRMMwU6c4ruq1/Cd2oD+t3dgo?=
 =?us-ascii?Q?UBUMk426BBv0uFmDbPa9c9qxucCxlFH3bplaw65LbVqMV4nXLjV6m7V6cQ85?=
 =?us-ascii?Q?sBDRil1JVDdtKLxdOyS+f5B4Nhg3+gtF4iuetl2PlQeCutzjQGpPWw/RGUSW?=
 =?us-ascii?Q?3V055mnBIjlbdv4LLgJhTLai8TzO+ECJmGfZHSyC1W172yjMj49qG7DJnjSF?=
 =?us-ascii?Q?DKtcU6OJafAgMMdqMVn1jiB4lc3O+G2ZM2xOEpI+Z6s00ootNKbN5cf9vyfa?=
 =?us-ascii?Q?mNMRLaSDzVa4fMknf1vMcyFh2V6YNsdOZaW2qX7vxJwW4n2QwAmCyn/NgRRn?=
 =?us-ascii?Q?JAIOGaYZa0oiZkc7Pf/xknxlE86dHQUW9tDmS5614ZLidyRvbwrrDH2GVKoL?=
 =?us-ascii?Q?wvI8iNSCzVz5MXnZDactysW+zm3ioDryZ98GNMz1acc5O7iE4zq+4uNoKSs5?=
 =?us-ascii?Q?cMAJWhFOIjFeHLmFDdOuKYplRYA1VNG3x6uxpO6maXaw01IWIeBb5p9SSE39?=
 =?us-ascii?Q?IxDb54mU1ptmCYxXJuNMerahxDxVSCagY/OQvshXviFDxRzwH/gulTyh5xfj?=
 =?us-ascii?Q?ckhqoa1s3cvx2Qy6l/A7N9WA/6hmLX7/I+X2L7tmR84IE5Rhy3G3yk0YgG7g?=
 =?us-ascii?Q?7t0THcyKLlrjcY+HShUkDl6jVlCTwBGyzYLxfnvrOIfoBhRHIZ97D2ud9DVB?=
 =?us-ascii?Q?RQt6Ky9TpgrskQE41USWK+ECGXKFaF5NDhxqJNjbWW3V3ZB6GS9GbQq7b5Ai?=
 =?us-ascii?Q?1A+TG42BDG9VSre+OHofeSnM5hpBQKoBS2a60rqOzyq+DeJU/IHp/Q1Utz0f?=
 =?us-ascii?Q?ZelZHdDNMvau/lbC9vA7vb6JIFnkmxTd8du6uL2g6BPo8Tv9EisiMvz7T3Cp?=
 =?us-ascii?Q?W0cVL5PbBpwL+8fQNyOTZTCwTac743TdzkhXIdyAhFfPTA+xRXa1fXlpBw8f?=
 =?us-ascii?Q?SSsCTaC+2FLt0Q6rhoNmnF6z7oXwMh9ySV72iM3pHGqoe1P3WFp0jUx+Kkah?=
 =?us-ascii?Q?U+pnQhc7QAQK366Oa5WM2/TU+SLP28oEteFE0QgmqoG8fGODxm4HD0PpFjRR?=
 =?us-ascii?Q?53ZLlKkwulKocxFoN/XNCOoSYL787jVzdeu0UD0Yb0Cirw4x4QqBhM+VrzS3?=
 =?us-ascii?Q?xpBXblTSop9RJfrV+2CNaycBHw61s2b2RRMX/zKrhDc1Hbi2sEBdLMjfJI+9?=
 =?us-ascii?Q?zGg0+s+AltsG4Qp1nxxVgb1D76Rqz5ZIAgKDJtAzpm6oTQa10AOSbLfPCZRJ?=
 =?us-ascii?Q?GTCtvaIGlgDHWv7FsevnlRVSpK6dJd9mOeVFEUYaXZnC256GR555O8ein9ae?=
 =?us-ascii?Q?Vt9DprSDJMs4q+6Zy0I/gkxCw9rt1uy+7ANSu5cicjLlOQ3UqYOfZUMWwUun?=
 =?us-ascii?Q?OeLgFSJCw2qozaaRSq8yECFb+TJKTe+ZIiPDfergjv9ANcf3fIvvJd24OxQL?=
 =?us-ascii?Q?Ht70yoxdA3w60N/FIUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JOSmZjlbPi5ldwP3ALX8kP0yfPb8HukjoWxnifLfLENff7xJJTna/PKp6cPC?=
 =?us-ascii?Q?23EFg4URJfQZQxUG5jxs8JAGPr+8PpAAUaIoI588fetmbThtBL2YN1C3Phc1?=
 =?us-ascii?Q?6ma5/hvxkA5R1fqMkbNFCjqvyXQpRmgVw0a4nzqkz2/N2ZqLN71/bsaEu2uE?=
 =?us-ascii?Q?6DDRzt/C2tm9BhVciYwxy+GPYNEi0BMCbwaOIl/n3LR/fgC64sUuSnyohofr?=
 =?us-ascii?Q?99153W2kKGP/Y4oNfd3U5jlqXaO9GXfoFyZsPV9rm3CAQOz33vZHHGVtNu0M?=
 =?us-ascii?Q?gJsdvAbIQtgh7SFLseUjN2CpJQ+ooStcV+d3UK/loNqWJtdWV/V1Uuag8D4u?=
 =?us-ascii?Q?oRA1wf4bo/+CJLK9oPRUdN9c/bc7WjGUNmQeIEX38s4VLxcJcJVEVu8/vySR?=
 =?us-ascii?Q?U29W/MGc5AI6WQatt8HLH+t3oiqk2ulgUH+7TUwMwwF40inoHFZAcQn7caGz?=
 =?us-ascii?Q?M5hR7gHwnjDqpqwsuu4P5WO2JSlBFshElfJvCbtJfwv6xX+ZEXH3acOF6v1x?=
 =?us-ascii?Q?oZ89zklkJHPinJofEVrQzwTQ2NSS7qkGxSjW1YUYdCdZt798jm7a7oWMsQ7+?=
 =?us-ascii?Q?6IieASAaGqlbJQ49sZgqRNRxKpX7+chrHHz214n8p1wPEVi1Utqkn5fcr+F1?=
 =?us-ascii?Q?9dcQilhBJCoP/04WvQWSiXEXJGTxgWIDqS6EUl651TZ75USOwsRnTMTE/E5l?=
 =?us-ascii?Q?HLPCcDhJcwB59/Z+lZJrUVl+UDy0+rygD3jsqcF4DC7ReOSljBRnc7iAIiEl?=
 =?us-ascii?Q?k+bu3K+1gW8eRABkReIDe/dWAhNIQZWZcfnDncUZIHSdwrDk6Z8XpzitzXMF?=
 =?us-ascii?Q?7FDtC+a51xxa5pPMf+3SZzorN/m7OWrkSR/jDzjzZ168Up9qBkTAEaA3fvPP?=
 =?us-ascii?Q?Hh7dHKqTUnrU48GSzqPQCkht/0QjuYysNFTcDeRb7/20uggMd36lt6iOBHTY?=
 =?us-ascii?Q?eb2Z8AWHn/TwgVEjR+3lPX2ewNlB43h3GlK5zc/LQ42o4SRDgZv+lLSPIuEI?=
 =?us-ascii?Q?ZRFD00gtsGpqN4Yes//DOU/rYtJi7BZbncMbsL7orDBembaqz+VRcYu+qnrP?=
 =?us-ascii?Q?7GglCuoLPEkw+dh7giFF91ltZKVefS16Evufs0pUkJhqK7S0knMWcEMVYZdf?=
 =?us-ascii?Q?vGt9+wtnlxMIo8hh502FCKRdNTfosZ+8MMnywPVHObolKa+AcW5phhnsORqX?=
 =?us-ascii?Q?FSvu2I7HWR6YeP44UKyWelOZjuX9TLyEbjEh1IJuD5PTlLsRhC0dhlit/8P6?=
 =?us-ascii?Q?V5+WuR7MaQLc3Bko/wlx9gGJd9HqYb1Oj9iK9nIICxKhmB5KLhib5Xhb8Mib?=
 =?us-ascii?Q?qQriryAG++eRbqqZTRGXjHb633V36417aKCyijpnRr5rRFJTuxms+5f77ORp?=
 =?us-ascii?Q?osjF2f0s4zNejxKc2u1+y0jsF+f9WTM0lBmpg4446Vj+Tkq0tJT6j+ITxkH3?=
 =?us-ascii?Q?pTBTkPydvsFaNtArEHj25iKckevJ7uWPKCJPP2obQ7SzLxTH5SutmAdwCLWi?=
 =?us-ascii?Q?2H0Yk/ixmXzfP3MVcXNYfbmGMauNDqF1azfoyxIH84CBH3vZZyzCyVzB1SkD?=
 =?us-ascii?Q?fau5HlKbcKK8He3QZ+rnfU7q3qzHT/7cNWkowZeiJrJJolhI6eV7NZdL4uZ8?=
 =?us-ascii?Q?khpuw8CFIcjeLmWTH/X3e/IO5zO3f9bgXVGysVKa9WIin4YEW0NZsn5CNeNm?=
 =?us-ascii?Q?FYDdPXlH4W2my2LHuEkssFI/aJbFxToarmX5hHly+pnka7yZ?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00694426-184d-4161-0b04-08de71abda2c
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 00:46:45.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwv1ezKInZ+U9XUAvwZkhsHAGcLKX7nx5pqq3yAqf9w2fOxD8PW8kf9S21lahowxaOI0jFpMPhtquGoY7xdztQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB5865

endptr is used as the return from strchr(addrs, ',') which is a const
char. endptr is subsequently used as a pointer to the token which is
char. Fix by not reusing endptr, but declare addrsptr as a const char *
pointer for use in the first case addressing the warning.

fixes:
    ecam.c: In function 'parse_next_addrs':
    ecam.c:620:10: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      620 |   endptr = strchr(addrs, ',');
          |          ^

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 lib/ecam.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/ecam.c b/lib/ecam.c
index de8ecb5..65edd82 100644
--- a/lib/ecam.c
+++ b/lib/ecam.c
@@ -603,7 +603,7 @@ static int
 parse_next_addrs(const char *addrs, const char **next, int *domain, u8 *start_bus, u8 *end_bus, u64 *addr, u32 *length)
 {
   u64 ullnum;
-  const char *sep1, *sep2;
+  const char *addrsptr, *sep1, *sep2;
   int addr_len;
   char *endptr;
   long num;
@@ -617,14 +617,14 @@ parse_next_addrs(const char *addrs, const char **next, int *domain, u8 *start_bu
       return 0;
     }
 
-  endptr = strchr(addrs, ',');
-  if (endptr)
-    addr_len = endptr - addrs;
+  addrsptr = strchr(addrs, ',');
+  if (addrsptr)
+    addr_len = addrsptr - addrs;
   else
     addr_len = strlen(addrs);
 
   if (next)
-    *next = endptr ? (endptr+1) : NULL;
+    *next = addrsptr ? (addrsptr+1) : NULL;
 
   sep1 = memchr(addrs, ':', addr_len);
   if (!sep1)
-- 
2.51.0

