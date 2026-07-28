Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020115.outbound.protection.outlook.com [52.101.228.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63983A5E9F;
	Tue, 28 Jul 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259399; cv=fail; b=XenARSPz6H1XrkJqrfgPkYHACmIwiPM0nDULVA+oRjRHpdLRgG6lfnlzA7duTme/Wef93+L/1wXsIR9kWCFL2/E/poCI+YNZQ8TvdpwUqtGSoQ2ZeKGLpUEOTuP8nf3XvVlZ+gzDJxCv8bGooFV+xt9U/SEavktOMGuxxtsMhJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259399; c=relaxed/simple;
	bh=xNfuKZm6PFp641ttHkhuCfEeYfWmGWylXNGASlQIq8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBdHPBzMrqP1y+crwGvrI2uRKzzlmzsnn8biHTYzkf1uV4biNYT0MKuy2X8hgIs0JyfKXKdnPnHkkLwLiTFZ4j4AeuIsExI7W/5SChkF9H2h97na97CGBCbU7GDWayO5qxRpJAXzxa5UnMETsYbYed8toRFqQ0867jKkaLXRKHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IBitoqL+; arc=fail smtp.client-ip=52.101.228.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IBitoqL+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3LLRv/zOPu+bLJLfIfasEjgU5vO3XXUT//x7SsOkzoA6xe1xYWV+93NluPdSSYuEQzMbxaHHrzDOQx5lH5cStjrmOg/WPZFeP7IzXj9/TZfywcIOXNdA7D3RXGwKI2ZkyRzRESI/hwBo87bG8Srdd5bzs65Xoo+DvB3I3lzEE1X9ZsvobO1VDAKLmvwe6raE2C3LTFwaFZr9Jk4TsijJ4uDstpJ49D6+xv/zk1WR5TV173jtaMdSw5QPiKR1IGDmyH8l0xlZ3a/+oaRO76aCW3aditS3jfkSrB0vms+GACRrHaJeFddsYUKD3eJO/JwBn55ZMzbRhG5gx1xgOe35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxnm5BwhroHKo8Ynm8et4Tvss+3XvbahIW21WRPYBbo=;
 b=x9Xl99qNRPD+DkaXHT6JTtxSjKzND14/bfCwHMVILi1eTqYuoMlQg/EfXDKAjfra0MWvduO1KRPk6a7HqOwt6IG3ELBmrri7NxFEtCri8mUrqz9cWbgiI7G5MHfB1JUTA37/RX4DpcLkZcoP6XqddJ05R3GyPEkS4JpvKL9sIDf8wGPLHTNXxj7157LwXOcL2XCGZ+EEHhTGsvwrjEXRmNnVPJkjGCA3z9iGxIq/ocI/oL7B5pqxRh2mmt62r1NAJO1M/Qzm3/QHRBQDvc1+5laQlgRgQb2oR/xXmLHZuf8VixwaKUIgmnhasKg0D7aTcpC1WEiZc9KFtaSy7tDz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxnm5BwhroHKo8Ynm8et4Tvss+3XvbahIW21WRPYBbo=;
 b=IBitoqL+tJHZECoCBSnDvRwb55TSk6HC/nIWr6uQF7aXo39Rqo3KIAA5L0A4SXUtXkH8auXUA8mffxy3LOLGP0Mojm2mHkzifSNC5xePADWqMhL8A1hUwxqxQwzi+BW2U948GHuKA2NcPNc1bwAyYtyd8rbSp9BgqlAF/FKuBP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB6129.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 17:23:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 17:23:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: endpoint: pci-ep-msi: Make embedded doorbell IRQ exclusive
Date: Wed, 29 Jul 2026 02:23:05 +0900
Message-ID: <20260728172306.2751813-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260728172306.2751813-1-den@valinux.co.jp>
References: <20260728172306.2751813-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 530901c8-eaeb-46b7-c814-08deeccce693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/gegjzeLmzlRj7qbJ8n4SmAXT96GqgZdzOF/r2SXO5Lb/Ck8xgCxuMarBIqU2amBu4xozB0KEXx7pQcBgi6LS2k6nePICqh1igLx2XMRp9RSdzpQDLK+eHti9dqcV67tNpZvpmjFmEpZ13lCYSOgyykXNwxNi6ey43wyoP2iJVXv7zW8CzvvaPBog/8zMrK5ErUMZoqFIgOjDa6JrxN9bcxNYbm8jC/Qg2USXaPQ198ug+KjyNniGfvYOzqATQeN8bc2d3lT84jLZuIqU1I7R6mDoelJwccfB52DbvhD8a8PKLLTX6BpWhpafESx+a55ksKmcug4vcLhK+WN8abv1yDs+72z8a7mG5RG7M+Jbv34ae2LcZBjl7Xmi+whPaj7SrF9ILsAmzxwyBCVo78BxopLqAvpl3IpEQ7x06x1r5tXva/rtb4JFJJGBvV6IdXRTXvlZdqFiE6Pe02himBF2xqJk8aKO2xNdEavjyZsDjX51AgiVBuX0XpTcOjHOy+RQkbrIy7LDODtQBOkKrMW+qU92aaGbWBVBz9OSHkQDTDIwV8q2Oo0gcT4N2UcdEzwrsyDCzcGIVOpwLJdyWAYMI0ZsBIWkxas26uNYQYfE3i54XTbbEKhD62eZz5NjYrSx3QlJoTlELcpLk5BOH+GKCVBkLYwSa37ZSV+vtey3Yo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KEMT+mgglhCMRNK34H65s6ZR/uvTuCPGLLgiKR0xh0Jn7/zMXzOqlKrhYeTY?=
 =?us-ascii?Q?ANC8hDA2AeI9JrvdBZ2+zmMXH1AM3vz8X0M3wDBATB7y/wB2beEKyfCYtfse?=
 =?us-ascii?Q?jua5MgKIqhi9jZH2Ey/P3JsD/qapajowEDsp7+H7yz9XRURAKb3cPcpktSg4?=
 =?us-ascii?Q?3QDiqva3gwPmjJ55HaGzUpTH24etcRG7LGiWU9bTNwS/4yujQuZI5qpQn5G1?=
 =?us-ascii?Q?An/WQKlHqszQDiZhpPeYtbSnhnq7++qfC4Nv5ZuwItHEkITbWRPf+0j0rIlU?=
 =?us-ascii?Q?l2VlyNKIB39PQhSPsy+ifVnG2nJ6fTEEaF8zAB2VkKcFoS3tt0JnSzQ1/+mV?=
 =?us-ascii?Q?HGPc8vINW2xUalJDMMCrV5tFlIlDwCE/okK9dhLf6axAps1AbWDNisTfjRzr?=
 =?us-ascii?Q?dKroeF7M9XQJd0tMMYuugzuXT53uv24nm8RnE4NH82kWt/W3OoaTMHJjS5mo?=
 =?us-ascii?Q?izCjKPHWiyB5I58beokQ8beMT5Q+8ckVDkxU6oGqrnQtAU2dDM75zLfnITAv?=
 =?us-ascii?Q?b0xiJ+N+ErCCrynJLw2e3RYMguESc1taPpwlElIARORLHNd5MZ7BJPUxQfPc?=
 =?us-ascii?Q?G4xAxLtX/2o1AW5FIEhKlNlZ6YKD0TdYDsUBOlct/RlC8CroYzSodXF3P31Y?=
 =?us-ascii?Q?ctGCOzrWWTrbAqXXu4uq+bsnyPcWdTyfX4TW4H70/hZ1AqaUPcgqnZayHcYR?=
 =?us-ascii?Q?ZYUutzV2TzNe44lIvH+kPZXV9N/Gb+j+i5A7MDcKq7N+ytRQethpgNtpXlAH?=
 =?us-ascii?Q?nGvQzJje09LzMz/kovAxuLD0FzFdmOmYkJklJhDF4xab50bVb61E+UuTavf0?=
 =?us-ascii?Q?uopXXrIS/xRId8l1gWEHefChb6LHQ9QBtOYFyGTENxGyTLUqSpGSaJmsJP6+?=
 =?us-ascii?Q?gsxg41lfnL4hibkcL1BxEMgG4dwx44yPM7OlW0MD7QGpBfWfkEQ+8j/6qRpI?=
 =?us-ascii?Q?D69I28d/o23mkJcdgavzZ1MRkPFNtShSedjKAQPdhi/9Gbi/tFxwKcD+oSet?=
 =?us-ascii?Q?t/5l3ynSQNrQLL/cjmP1noSh5jNlAICO2doWnvEgZHi+UAcZrzrhet5Jr6Hr?=
 =?us-ascii?Q?MyUTjeU2hr3y8w/KwtjS78NlRDde9FustnPWtKx/FqKbjlIGVldbhsPrw0ZJ?=
 =?us-ascii?Q?kj5b9Y8VmbjCcG+piaPKxJdUu+rMcQWjPPWHJxvbfE5d/hno0H+yAEIQ8yGX?=
 =?us-ascii?Q?6v4JKDpazzzb+BClIgj+FgBCY2O7W0IXlmlELMgzDco+CC+AMHofYyUQCL4J?=
 =?us-ascii?Q?lTOSOjrPewN6/A9zpSVNUtNrdXZXb+Xpl12SHEqZhG+8psBKbYIVyvW+C8U6?=
 =?us-ascii?Q?9V9ea7iFMWq7KO03YafljkL4p3/qyFMO9vF/jmEpPSHOvOROSlQzqxXipqYF?=
 =?us-ascii?Q?JjjhtJmzVymOSHW3lJJlsR8rXv66mcUtWdmCknYuEwVOs8XGODyJpXwgYk3Q?=
 =?us-ascii?Q?uy+RMpuxN+QfBtu1LM+b+5WBRblM9oJ4V3V0zYC/4sEnQoYZrEfAWCupF+gg?=
 =?us-ascii?Q?i036BJb/k/Dq/5oI7t/sILxBpqPsMhAwhZ0h2RVAfeq4LxsYaL1maiLrr3AW?=
 =?us-ascii?Q?/CyFwuSJByMiA2DQi4Q0ExZpgo0mcGxQlBZ1WaJr6pBAB19ZJDs5BgA4AiQL?=
 =?us-ascii?Q?WWY72Mc8ND/s3sP/QR6MiISIYTXN4WVYQ2sYMEFvUC7NmeIMilFrt9IxpLTW?=
 =?us-ascii?Q?y6DrVnsMvyJ2/eGGZeG+DL5bWFSUvYmFuQFc/RUj5vdPxJJw4XFRuhZKgeQf?=
 =?us-ascii?Q?LUPUTXAWkiJ8qb+IqBjuKldQd2JYFaUcX5KmrBDumyMGy47qM5GI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 530901c8-eaeb-46b7-c814-08deeccce693
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:23:11.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcuQxk5pNrbHffHfLyidnEINR1TB6rwylAWONPbJdHYbgWDJCMlppJgZ4HDF8j9o2SsRYqjjaALnjsJ4cqrb0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB6129

Embedded doorbells may use the same virq for several messages. This does
not mean the IRQ itself should be shared. Consumers only need to request
each distinct virq once, as vNTB and pci-epf-test already do.

IRQF_SHARED would let different EPFs register handlers for the same IRQ.
The embedded doorbell interface cannot tell which EPF a write targets,
so every handler would handle it.

Only the first EPF can allocate doorbells today, so this cannot happen
yet. Drop IRQF_SHARED before extending the embedded backend to non-first
EPFs. A second request for the same IRQ will then fail with -EBUSY
instead of attaching another handler.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 9 +++++----
 include/linux/pci-epf.h           | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 0855c7930abb..a123a189b4e6 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -10,7 +10,6 @@
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
-#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -112,8 +111,11 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
 	 *
 	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
 	 * For such backends we replicate the same address/data for each entry
-	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
-	 * as equivalent "kick" doorbells.
+	 * as equivalent "kick" doorbells. Consumers must request each distinct
+	 * IRQ only once.
+	 *
+	 * Keep the IRQ exclusive because the source cannot identify which EPF
+	 * rang the doorbell.
 	 */
 	for (i = 0; i < num_db; i++)
 		msg[i] = (struct pci_epf_doorbell_msg) {
@@ -121,7 +123,6 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
 			.msg.address_hi = (u32)(addr >> 32),
 			.msg.data = doorbell->u.db_mmio.data,
 			.virq = doorbell->u.db_mmio.irq,
-			.irq_flags = IRQF_SHARED,
 			.type = PCI_EPF_DOORBELL_EMBEDDED,
 			.bar = doorbell->bar,
 			.offset = (doorbell->bar == NO_BAR) ? 0 :
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 8a6c64a35890..e5b9a79beb93 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -163,7 +163,8 @@ enum pci_epf_doorbell_type {
  *       For MSI-backed doorbells this is the MSI message, while for
  *       "embedded" doorbells this represents an MMIO write that asserts
  *       an interrupt on the EP side.
- * @virq: IRQ number of this doorbell message
+ * @virq: IRQ number of this doorbell message. Multiple messages may use the
+ *        same IRQ; consumers must request each distinct IRQ only once.
  * @irq_flags: Required flags for request_irq()/request_threaded_irq().
  *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
  * @type: Doorbell type.
-- 
2.51.0

