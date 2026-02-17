Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021097.outbound.protection.outlook.com [52.101.125.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3757283159;
	Tue, 17 Feb 2026 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310346; cv=fail; b=d9lSoItVMpHx0GLZc/Cof/X8s+UX7l0rWc9eNLem/68Jz30agEQoxE6srpJlkZud85tjB25fTtsss1TNXLwiyOqiaXJT+fFvVUmx2Ter315NpWsVcAMexl5j/pqC9dOWopObn20cAmmoNv1nOHiAHY9OkkLVsR6KFQhweDo6ZS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310346; c=relaxed/simple;
	bh=10ezyIgSJC38R3IqNRl/2HUFRmcYJwMcWrWc6GjraPM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O/kG0RclFRtXh39PizZugdDx3zwHAbgMVXmd6pN3bVpsL8Nj37M0bucCH85xJRTm/9dLqdCkxC4/bshfw98zdCN8DIlwzAg4gLEtIIKMRBxOY58ctvNFxecnTeJNKgUdAeKnS+EaoAJsgD75T13rfondiHgOIHRvdHns+F2Lv7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=nZ7Jshet; arc=fail smtp.client-ip=52.101.125.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="nZ7Jshet"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckAt4+64e7X2tZ2ZYREfP6b+lANQtyNrikIhxeBEYWB6K7BMMPn3+mSOORnNLnkcTKNt9IgIxXWZZhye7iNe1XLB/KE/bKmk4K+qwWXFLZ/nFAwulrTgnLgt7UvGxXydGEJZOkoN/59G4wa66CPIr5O0dzFvYn2SdxtBxyM4OnfkZno5aeV/AcGcqqD3dNWkUqdeG+9A1K6e3ygT/UayCMPV5I4jO1hhkZrCWBqctunlrdphOZWKjT1uBKwZcHQt0q73Ry40hXnJ6bm/xD8QWtXewGA+7Wji7eELnnWK5uQMdHxYsunqmIIFB3SS14xVKWKUfJZTFDQyaFZRuQGKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnnlR5F51LLsb8F/GLamr62RkVStts/gTO0vmlN2asQ=;
 b=T8JP6IqLffAquU5RiYZ3n6OY4JDqEg7Moa6PH5tUsrVg7iJqZ+UBJzreWaEmk2kRYFQFXRE+VoWHSplAO89ZK7oPXQdq/UufPMRsTK0IrBma4be6DUlcyeMvcppw+B1VJ+NkcdSBCfNGBcFpIGqVjLsTLptIGu9D6bjKtPzMpddGwqiUnW0nfoWty1rM3+RGrCdjGvv2chV5rUWHYUs8F5W4xb4kuQa5O+2pbL5Ndjpc5hXx69+Ev4M8taJbws8gTHQQrKZO4a5ExAScWAW1wCM0z3EQmcJlJSt2x/YlbP+Xzjgv/eStmcxAPbAqdUmySM3BXj02iHisprI7/sSdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnnlR5F51LLsb8F/GLamr62RkVStts/gTO0vmlN2asQ=;
 b=nZ7JshetryIFuu0X1e4Gj2gBF75jBYcEVrbLMMT8bEpDBfkkYcn2Rn6woTWkb8abMxhujOFTc0UN7lOXrxutICbO4/y0rIaKojuuFpFBElwRJMveyhU9vRsEhF7ThtaR1BkBRav4U0jT9t3M8hQLZwe0S/Un42CDO+p5gsoKeIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7477.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:356::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 06:39:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 06:39:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 0/3] PCI: endpoint: Doorbell-related fixes
Date: Tue, 17 Feb 2026 15:38:53 +0900
Message-ID: <20260217063856.3759713-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 74faf807-8989-4602-9c9c-08de6def3d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqdyIIK35O+X8lsGparneJ2nP6+EyoDxUZxF8m9sDszvQhZhOKbnxuMbBz+v?=
 =?us-ascii?Q?5lb9Fx01daj8HXgCixLOfrpXPYeFYnbl6vBxBJCmIpCzuoNbMTe/88IX567H?=
 =?us-ascii?Q?H+j8e3TnJlehWlgm4Y7DgpmmP46QYbgzP8CQI7nNn+IEMAy0rWYi/Tec5oek?=
 =?us-ascii?Q?4olZ+lxV2HMyc//tR0a8pwQbIpkmrrp1QYFJ9g/iiGAvl8plD8YrUbDJRxp2?=
 =?us-ascii?Q?rG8ZRJbQyLy7dgspD1qTQMNauRoLnAXs7zttdiEUjJKp9Y//Hc9GCvLFMAeQ?=
 =?us-ascii?Q?WHeuXehJGhGH4sX04wB+8eLCi76LgJZ7rLKQkI1F82w2k93krTD4z5Pi+vLT?=
 =?us-ascii?Q?7yNKOYup0Fmf9KuJ2BF5CobllwLwGwUMwk9IhTJxGTFNn96wx1VurXUqLskZ?=
 =?us-ascii?Q?I7yOgcHOs4IfO/85QjzE1Xjk01XSOtAIL7hIZDWFi+CQzc/1GtCCFmqTzUSA?=
 =?us-ascii?Q?laeRjFMRpH7jPvxAIpJdOWvxoo57vATNaYF5UKQohggWPIuTpANTPNgXSoO8?=
 =?us-ascii?Q?hFBAFlcE6ZfnKpaLCaghxxaJlFoMtkRn3PoIpR2RwSZIvUVo0yJFum0VnTib?=
 =?us-ascii?Q?6syDKKgZ9xexaqof2h7gtTloDVbPV/R79uVB3CqAUV/6kr+TfN/gvYd8gKNA?=
 =?us-ascii?Q?PAWnNGSKyMeIjyJWyl+vmvN4eAGEGO6m+svD94rB6FyUG9IZgQJbWqgXnj6I?=
 =?us-ascii?Q?yy1fJ09iPHmAlZnOgt6QILtVgLmt6+cEq94DHSlhfqdTOLBFsPGNUoNm+8zY?=
 =?us-ascii?Q?Ql7fJNO/pCacZBs+19UDsT+QHbd6LyZo2eiRi8Q4gsOJEIx5U/jiBelRmpPN?=
 =?us-ascii?Q?KxjS2eRU82H1w957qnl6wQXol+xtk+1B4uF4ufNAH/2SC6MNpKcSvS6jFjp6?=
 =?us-ascii?Q?BaC4YBjNCG6PSo2l/UKhAKgFSUCQQ4gT/ACmdSvKEiZtDEY4DKt2176VGZH1?=
 =?us-ascii?Q?4ToMGSOeA/K/Pnk+FZ/DGYTNGCxjVFK0PW5z5gkQL7FrgrWGZEoQXqRYbhDs?=
 =?us-ascii?Q?ZJZzLC5gxKkHeDr7rhwZdEai7uMhbqiFOi1az74r+Ior5sLBLB00k2XptdFA?=
 =?us-ascii?Q?ifIOhBSxAiumdYzK+JTQz4Aphtsd9RgPEcF23lxZwq882BGJWykhc+qyXSeg?=
 =?us-ascii?Q?XypkUWA3BwctEWokA3WpdtprORY9tBGuLPjBPqsYewgQCzqDSjmPZR0lMqOh?=
 =?us-ascii?Q?PLu8UJDsqKhTAs77FhED/zN2FCvir3tKP6DLyl9tZEpZnC19ssDL2o66t7iK?=
 =?us-ascii?Q?TT4ipcHRqjKUilWzDyd3owlcYkbMik28Eq1KS/uKsx6bMZt2KKKJDvphKWKe?=
 =?us-ascii?Q?HlvxxB9gRRaywmNyr5SYcW6u+gCCaY8nL9IbE8oTWzP/QLY42jianMk86aTA?=
 =?us-ascii?Q?Edm13VADQKmMCLLQEeCPWnKVnFOOEMWPQldUieOgcj/bm0teYkX1+tg/mRMO?=
 =?us-ascii?Q?AHU/UkGXMhZxmP8lHbjGeFyJjOvUCm66OZUxDpJIOAUnUvoKtM86N1klgmjc?=
 =?us-ascii?Q?KHE4uy2pHR9I9E93R57W+6Li9JyMtdC8bb67rErM3jXRo/Eo9tuvD7EtZk3c?=
 =?us-ascii?Q?mm6FpFpBYU4uUCLplig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVoz7u5Kgsd7DGRxjucv/Bje+aEFH8UJnbphK3z6dC9CR+XrzRE0qKz5h9eN?=
 =?us-ascii?Q?hqX8J982GS6ajqnuSpxinYG4yzUq7Gzg9J7ydOkDv+PSvMqumYYBDeAf6B9p?=
 =?us-ascii?Q?Fzk9kkY7Wbpy0gBMldXfUkDc9NIL8xJYNU1lbHj5WDd4pzQ4/KYJ82tJwK9Z?=
 =?us-ascii?Q?eEjhe/81qXw+fRhD1ZrfCJE8S/suCjCjFPEUIJSPcH5QBy8xy2um/7xwdPcx?=
 =?us-ascii?Q?2Oi7haE9WHgwhTeRdDGQ8dwObfZ+XIeIID+zX01c7UDaFAdcl/HOkmWE9Cb+?=
 =?us-ascii?Q?6+vrAZpq8ZVaKyWzY0GT2WOIkvkwndLT53p2ERFte56Ns1XvVneVm9UrFzWt?=
 =?us-ascii?Q?94v9EFDz1XyXfUxn5Wi6EcYKGaCVtEV7vwP3jt7hnesHkkJ5cPyBp/8lAsoa?=
 =?us-ascii?Q?oWG5PT8EpEiGEE2XlHE1TZI/a21z8H9N3cjLNKTWB4vOjcVGYYQi4dOXeiXR?=
 =?us-ascii?Q?2QOjtJTgRCXyNdHuYJvBWGN5iV7Ai/oqhgAc57zocByMGLLHTl47O9sZoGlv?=
 =?us-ascii?Q?xPAD4hfBl9/NpDnUJTK3iF612Kpq8M+Chek0VP4s9ICHOhwuzyJSSdHswrKr?=
 =?us-ascii?Q?yItbSi8gu2voQewbn0Zui1GP3YljmElq8sy/tiGXAhyzY6bdF5T/7JFPkQgm?=
 =?us-ascii?Q?kYCFpKgGA/mtDJ4LzWctc67hHsQS8DCpkTVGxoKCpUhhLN44a4BiSz5f3gUf?=
 =?us-ascii?Q?+k6M+5RvTlgODzohN9PNIpVCR3yCkTX4grqqnKyXgh2uAeu7+rdFUjIaxlne?=
 =?us-ascii?Q?lnt5RYoQZ4s/R40bPTfWqsLC0RbZ6Py608c+3nkuWHZoATX+6UmhWQN7LEXP?=
 =?us-ascii?Q?FTq7huywPNp0n2OrPOTxP5qA1RIqqsww9h77C+OQPif6qL9x3BVnZgVG2njw?=
 =?us-ascii?Q?OEL4TSwdhvw8XVacIBaGzVMQX4LHK0PkJhuXzauwlIhRMEZZd59zIvy+QTfc?=
 =?us-ascii?Q?fpYaukC6jEJvWkufPW5i7G0N2K/kfFPuMK36uPfa3DrdX+CI9HkI4SDLM6Fp?=
 =?us-ascii?Q?WiX06Gm7TnADmrqM55XhJK2q/BjuxlPIc/RznBlmmcGRqVi5+PO8p02e/dtq?=
 =?us-ascii?Q?iM2gsEqXObtnORFB3Qu+kSF2trdREsJvXDVgxReT2kutSG5xWHLbzcmCsWSZ?=
 =?us-ascii?Q?WtB57pOx/iGta4tvt9MA4O2dq1IKMAAfsRNIeSl9oMrTKK5HN7kIg9tXaW04?=
 =?us-ascii?Q?XFUCUQ+xKlAgwCVjc2jO2Ah0lSRl+p78yIv1xdfJ6xMJLyFRG2nhoVIIn1ml?=
 =?us-ascii?Q?DOt1bni5daNGgh2OIa+q3G9P6Eh+5v8oMK9LdIzzIB9LjByQMwS1DgD2nAvt?=
 =?us-ascii?Q?LiRU6X0dXFl1PvGCTJtX4egMEjdSgCX950iSJNnYdAc8RIkiwcPaZA40JCj+?=
 =?us-ascii?Q?VKLNQhdR4E8lQGD9txr6+h7U9wynsRX1VqgkEvBLA5Nm0i0ZIIrC2vIAccxO?=
 =?us-ascii?Q?cXmDtqLdrReC6yhCJZHGzx0um4oXNQoe2IzMDgWFVryyWq8quLRcIFMjl+Cj?=
 =?us-ascii?Q?k6zMvUo15u6BDs7Si1a2MqrIZrxhMqIs/dmFlXYTPqoyAHYR0/jOQir5sLBt?=
 =?us-ascii?Q?zEYrhhrNxPp1Cwnwd0ZwBBIcj2/DLqC6YVdNAfKvU3/kEpco3jfInh0kg8/q?=
 =?us-ascii?Q?nZY0aoAEoiPbsKaM/cShBiza1gMMwFuJjvxOkVt6RKwZ7W4R+jT1zAT9DsKQ?=
 =?us-ascii?Q?bJuwX0s2xSS/cMLm19yQ1dYyLPpKhFlxAm3p6y7+rsjfSaHISqSHGroMrEiK?=
 =?us-ascii?Q?QzouZ7oN4E0V+ebqINU26W6XeJBYtIIdFbEzUpyvuKxRs3GRpWTg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 74faf807-8989-4602-9c9c-08de6def3d18
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 06:39:02.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZdoy4BV0wCXnjCs+AB6ifJiuTdOc+laFuX18gxU2Wz+LPYyT+F7G42q36lHl+gGr2egVtT9u5jerunHUm2IQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7477

Hi,

This is a small fix-only series related to the previous (v6)
doorbell-related series:
https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/

These patches address a few independent fixes in pci-epf-vntb,
pci-epf-test and pci-ep-msi:

  1/3 fixes IRQ unwind in MSI doorbell setup (pci-epf-vntb)
  2/3 avoids free_irq() if doorbell IRQ was not successfully requested
      (pci-epf-test)
  3/3 fixes error unwind and prevent double allocation in
      pci_epf_alloc_doorbell() (pci-ep-msi)

These fixes were originally intended to be included in the next revision
of the main series. However, doing so would have grown the v7 series to
around 15 patches, so I am posting them separately to keep the feature
series manageable.

Kind regards,
Koichiro

---
Changes in v2:
  - Removed a minor refactoring part from [PATCH 1/4], keeping the iterator type
    int, rather than changing it to unsigned int.
  - Dropped [PATCH 2/4] (bounds check). It's a theoretical future-proofing guard
    rather than a fix for today.
  - Dropped the db_irq_requested flag and instead moved free_irq() to the
    appropriate call sites.

v1: https://lore.kernel.org/linux-pci/20260215150914.3392479-1-den@valinux.co.jp/
---

Koichiro Den (3):
  PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
  PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
  PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc

 drivers/pci/endpoint/functions/pci-epf-test.c |  8 +++++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 ++++++------
 drivers/pci/endpoint/pci-ep-msi.c             |  5 +++++
 3 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.51.0

