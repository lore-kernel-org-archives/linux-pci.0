Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19731F5821;
	Mon, 23 Mar 2026 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235765; cv=fail; b=n4jkJhzZzfUZGq0tOTPcacwc+SDZcEz5AoWanS9O48h13YXMMnMzauUQMBj73MfzbBricKY2+YSbj1FMEfNnlIJUL5MEMkKsCYtp8DzYgfvNPbFFrY0tU6KN5788912BYPa861yBq7RmWL30nQJxfqLcvVdpGge4YOM1tz2RWfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235765; c=relaxed/simple;
	bh=Vp0jjjAjVx3kJgw5BJe5IzR2vQQ/BQvJP3R2jxxlbgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmVzUkxXvdxYOGlXAMmESDDTYds2k25o1VEG/14qBpBy68fmfMvhEHzmjTdptjE9IuIv+gT/ajcz52e8BZbyTtoV/QCowt+uiSDZMhkSnTLh7oLK+YEBbx79iEVfJgsWTfLAncxfyTzVyC1Ev9sZYKj9UTeyXUv5rGvGi0e9NJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pGLdgjsw; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pGLdgjsw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bg0fCtSqrBGRBykf1Ko0pUSKqDWfhnYg8LTnx9ZQnXzvyjPC5ZL4Zah60SEfsB0AewCGTrAoMvNLRwk6Un5JUkXKebtauiJLwSb3Ed/L/tyDmh6umWZIxmN8DIwuDzLuKdLZvfrK4O1dhej6swxIVfMdeFBsIBCpZT5tvVKjMJxE7R/wKVV4y3iu3l+nMxNMGfgTTEesNBQ8YLWZPJQe+2neP0dbRRf9O+cB5sdQjHTQOMHQ39wU3VhiXrEAf70wC+TVp13Gh/lPaFXJdqgLYVTdEWA3AyZhvhqHT/x8TizZNSbu/1uGeCMe4609Oo9t78r2kt+IqVLLc9AkrPQc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxl4+aqitJJLM9pcANb24e760tjkAxwqC55ts5Kqcno=;
 b=Ge62Iyh1MUb9WTmdqCelRllAmm8k5JWlU0siWO7s7nlvr4EpBC8wvd6kjoWmTiXSlWDeKVprI6Ybu94yIpsoP8KvycazmUx1ef9Ij1rP/1zNdObF5nm7tJfsg+6CN9d5mjMCUTN+FLXsLRVqK61+50D8lFuQjO/hnr/HwSrovW0zPfoFR7feN0qQ8IelI5Z1b5eZv/tUafxIRc6z+c9QuHhiPkuQ0A5QIUrDlt37aXm98WUP2WlzpxBlwfHHHz1AzH1ra79qvOSz17wF6Enr3RXKpw3IpTzp+uuCyTc6Wkb/uKCgAzuxutribo4oYYUxZd/0LQl3/URwGXTzFbzNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxl4+aqitJJLM9pcANb24e760tjkAxwqC55ts5Kqcno=;
 b=pGLdgjswQbnczFOTTOZ3ngElzd43HYZpDk7R8yPMBeWwCL47UpNjSVxp+ue2PyHMvp0S9c7Hf15f8cOH2xZf6K30QywI4GhZKjZPvLwfYV8wNGV7ktPjXxkbGrZtwxEUtupUROpDuAwo/bJA6KT00UWDWcQyjcIfydfTcwTZhbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2385.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:16:00 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:16:00 +0000
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
Subject: [PATCH v3 03/10] PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
Date: Mon, 23 Mar 2026 12:15:37 +0900
Message-ID: <20260323031544.2598111-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::14) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0d40f5-47f0-460e-6cd7-08de888a8247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	PRrSKJK5zLrDJQXa5HDljzITJNNzrdQKFayyR5EvpCzZVR6/Tc3f/msWMsTDLE4Re+aUnECyjPkwPWGUc3mZt1NGqWgSeiEMvHQ74Syf7dUdLve4g4k7LDcOj74AIkpEbBhN2fjX12AsU2GoV7rtUMTXoC2F91kdZjd8H/eXN2ganpeCmzsWjB5boOKz9Kc0EhmzwCerTzQIpvxdliS3ISyaa1zOGujqW+HDYZRCAoOERGwB6lMDAuTaHd9cEB+rZchzUpktJSMrdit4k/n0uULAgy7QAHo8xOx4syLFjfPBYqQ7FZQnjPXDNQ7di7vL4LFWa+b8PG5LPQVlcEKXLSrk0HT8ve+CL51ApOYikNjsRwTAdoNtZB6eGmTbRtt00pS+hAguFUV2iAhabUkjR8TK0AZEhGIOrzMKdQRakL6u4WzOI+TH5zHfkhaPF2AVUhbfLpvYbHiFhNbqdgZMa+h4ysVzTEaSkDzXDm/Gro0fAiYyHsYFxHs5vT9Ja2Y18y9TlT8D2NQiLMgqRdTHIOFc2ZtILioOPCY9lDEidk1A9/q3VHcuSkHOrAY4MMVlRB+y19wZNxmNehcuct381v+X1Kc8mTynmFIAJQIW9Tjxx+RzYLiHDkVrNPvoMv1vi9yjbsyQgsaxSTno/QR2ungeQZFpAJui4nn8cDr//2eJQPADTlH2uMrx5FKZmV5GDW56iE2V2CMf5CdVDZ+BVovMSPtRTlcBGJlZ7EK1BgJ0n6Zw35OfCtvHcNuNQe8MiNwBtQMgJZSP1i1pqtQu3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFoyv6i4Xgu0XC/BtcrHwGp60AAnvl0p4dB0xu8Xlq8Sh3PoE4rl8vtYgoWl?=
 =?us-ascii?Q?206guA04YYAYyN7TcNCtjxniBTYKNZpypUpscZ8mbFWToqR5hyuoKLvxUadx?=
 =?us-ascii?Q?IeougF/PlH8IGhIft1pow3QxOgAd0aHcHE6pLDd4JCLFwf9GAAZFVFzbWyOK?=
 =?us-ascii?Q?6oFzqko91rgDGYtmktJ2tPZViObUon68eeBGjWBPFwb0RxiC04Q9giJ3BwAG?=
 =?us-ascii?Q?3CYs2jQKadldgfHx2TzAMhmFxYTWuX2MsujtvlY+kO6kw2ycM5pzBjDH/fhj?=
 =?us-ascii?Q?RjSKWWtw/7FIn95WzodzSDloie5hgMCUcL/PHehQqivmmvvJPavBGcl5Xjhe?=
 =?us-ascii?Q?Uj6OuMwOR5YyKq/HzUnaAr1Pe+G6HOkBmr02NyR7Ow4b6FAEYb5jzhhpn3VY?=
 =?us-ascii?Q?7mzgdbJGV9Lnt17PdiW6xr1AQ+0xgfzU6fWIRwjM0FIycY5SL90Rp19D9gEW?=
 =?us-ascii?Q?meRKk+rPp44Nu2w1sjo+W5PiCSZUVFLErKC0g07vrPmoF8UyeL6/NStG6/8R?=
 =?us-ascii?Q?dgk9gvUb1NiZoKyHUGebWTBNQQ+qRwI5X396v3U83qEQPb7t2ahoggtS4D79?=
 =?us-ascii?Q?LnwGNamfa4rSj4F1S/qbVTr3NrUQNfiOsWb/NJNcRF0xICv9CTA0hAs/AaJh?=
 =?us-ascii?Q?M/nm+Rft98qhjEF7PKNj3z/iafWvegQFbpQzbj6CG4PKr1bnKWbkRwLzEdi0?=
 =?us-ascii?Q?v9U5z3+kvRtbbcaPvg20H+SHfPfyHUHPZZQyJIYkzaebgCl1K7dz61mMjtdo?=
 =?us-ascii?Q?4VPmE7uiBSe8iCSoKnMPTzcEScGHZ7WM3byXCcMpdAIpcsP9g4ulSNWaD+DS?=
 =?us-ascii?Q?+bAQxMGdn7bp/5H0smlttozlDUvxLhY1Pq+jswr6G60OHJxXI/0E4Gn1QEqH?=
 =?us-ascii?Q?guRgKjp64dXrik88JIJ+T0Mnt7JFxjBTV3e5Ad2e+2WGjIaZe+YY1MENMk2c?=
 =?us-ascii?Q?LeVfnw0n2XnHjyE38wlkLdqfIKtlLoNEkmfkXMiUiEXeZOp38cm5PwjHj1HT?=
 =?us-ascii?Q?/RIIykKccjkci14GPUxyT2xsJ4gnOXwOgr4fpkaOMfKdBKlq2aiXoIjgDMXR?=
 =?us-ascii?Q?f2yXaiKgR3jsetK8D81qSq9KBcJ026PFSZZVKiFnI7KZImEfIPTXWbDX9idp?=
 =?us-ascii?Q?zpH1IxPGiFqQa6c4Iq4rigGNcQRD8nG24XuGnCuB000POeNuHwebG68SlPlH?=
 =?us-ascii?Q?TBcB5iapDsb9YkYAXZTHmVRMEZw4IhdNY6SpLtf8yGGAQZjuO2CGPmXuRxcI?=
 =?us-ascii?Q?xQPVutxCPBQeDoiWAko1UU35VoiBMsOzzRIYrqDGFnsJPKADJ1hyT2bjbAYb?=
 =?us-ascii?Q?mZ5g0RuyXT04mW93vD8DcGDx7zMNCooCQNtUp91oc+L+rsVWBM/eutelS/1O?=
 =?us-ascii?Q?2mHNxEwKUEEh1egFmMd7CBvKaL+XdlpYub7e4PnlSlAr7H9dCKhXGHTnj3Gv?=
 =?us-ascii?Q?ZioSruytb59M/3toEaaKYp0+gwgqYNMXKP2ZHSBsor57H+wErAg25L5vUj4M?=
 =?us-ascii?Q?2eQOR9aXZuvrhklQQpzqfXNqmUcNg8MrmgeHeDsjg7N3DmboCVNXJFJ8giRv?=
 =?us-ascii?Q?e1Tk+EHPHAzbgNmP4x5QJkktQ+dJaBwoqVDxHl3Rl+xrUz1b0+lMI6jWQsCq?=
 =?us-ascii?Q?P3GUCcgEtfeCL81QAJQgYQeueWCSbwyPg3J59DH7UBY5ceZVkYP5JVQlSEbo?=
 =?us-ascii?Q?BGnMK6o3FcrgB8r0AeHBZk4VJF8Fvx2GjDebwrYxg3RNcCoPo7hzTQDH4Yvv?=
 =?us-ascii?Q?TksT2T6AfIEb948ykgGhxmSou/u52kdf459YgiI6MFQ9/cROP9d/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0d40f5-47f0-460e-6cd7-08de888a8247
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:16:00.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETfNL/KwZQigNuc5gZXOmknKX12CUM8NEW6qJOvE1d33VWPHRy/Y1j3w1tiNUellvmwLCpm/cXYJ0p9WBZAakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

ntb_db_event() expects the vector number to be relative to the first
doorbell vector starting at 0.

pci-epf-vntb reserves vector 0 for link events and uses higher vector
indices for doorbells. By passing the raw slot index to ntb_db_event(),
it effectively assumes that doorbell 0 maps to vector 1.

However, because the host uses a legacy slot layout and writes doorbell
0 into the third slot, doorbell 0 ultimately appears as vector 2 from
the NTB core perspective.

Adjust pci-epf-vntb to:
  - skip the unused second slot, and
  - report doorbells as 0-based vectors (DB#0 -> vector 0).

This change does not introduce a behavioral difference until
.db_vector_count()/.db_vector_mask() are implemented, because without
those callbacks NTB clients effectively ignore the vector number.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index bc3b3df53ddb..e86dc530c08e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -82,6 +82,12 @@ enum epf_ntb_bar {
 	VNTB_BAR_NUM,
 };
 
+enum epf_irq_slot {
+	EPF_IRQ_LINK = 0,
+	EPF_IRQ_RESERVED_DB, /* Historically skipped slot */
+	EPF_IRQ_DB_START,
+};
+
 /*
  * +--------------------------------------------------+ Base
  * |                                                  |
@@ -266,10 +272,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
+	for (i = EPF_IRQ_DB_START; i < ntb->db_count && !ntb->msi_doorbell;
+	     i++) {
 		if (ntb->epf_db[i]) {
-			atomic64_or(1 << (i - 1), &ntb->db);
-			ntb_db_event(&ntb->ntb, i);
+			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
+			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -335,10 +342,10 @@ static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
 	struct epf_ntb *ntb = data;
 	int i;
 
-	for (i = 1; i < ntb->db_count; i++)
+	for (i = EPF_IRQ_DB_START; i < ntb->db_count; i++)
 		if (irq == ntb->epf->db_msg[i].virq) {
-			atomic64_or(1 << (i - 1), &ntb->db);
-			ntb_db_event(&ntb->ntb, i);
+			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
+			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
 		}
 
 	return IRQ_HANDLED;
-- 
2.51.0

