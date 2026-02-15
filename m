Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021129.outbound.protection.outlook.com [52.101.125.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D525288530;
	Sun, 15 Feb 2026 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771167833; cv=fail; b=CHc9TC4jKaNh4zWO7LzjP8FtkVksVnatzjlNB0nSdbxuIrbwjMNrtfeamdBcPGpxtMT3nXMZUppY1wbpqk2Xd4HFhyPybeCGXgRSQDw3EPFSGFT5Mg9hPZyHpMm29OcBKMgxQG/Fu4VvPjMxe8Z30G5jtdY7/rNRklx+BBWX0YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771167833; c=relaxed/simple;
	bh=nABQNg5glY1zKE/apdWyWMg5Xn0aRmPdg4FfyKL44Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gavCKPaIsz9T5xh/aSEG3J98WBUT93i2FImwy+VMd5wfLiPMLCKkucQEdYX2+A5d0+4ARvyHDfzK/G+x7qLeitG+hgeB++7oV/IzgSEhPJxpl+OihLLiMCmKXyHKHze9Hnk0XQsXOXnc4KlijnFKbkOnLRGyJx/tHboWpKumvGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OYA6kKIs; arc=fail smtp.client-ip=52.101.125.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OYA6kKIs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEBS5VEu3SKlTTbKQ8EpSN1IRng95qP8Toytbecv7/XSOxgm8uzJI6NgPvUtW50tYJQlu/DFiaTcM76iBDR/qMOLxhZXoeMLjtHJ4nsZq4qwEzBtm/yjjuR8IDYDxZAN+Ts/LVBYIuX+sNvu2U4PaIA1R2G2+GdOuuB4r2rX/XsiUvKHix/zJ9HkNmwzDKoVrTgwKXGuSC5KYCgpXfkk7Ms/Ab9g8aCTHwNIByC0S9BJhq2BPpizRjZEsKSi6+tQFLbUgwwDSWMAAaM5uV6U2LK/+FQNCKoBQ5yrkdRHgs6NnEz7QOiEYBhDHTMNpnH60fij65Sac/yXAJI5w3CYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/FcPAMxg87iPEUNCp8fDKOvzYniC0LbxyboNsag390=;
 b=OG/QjHzeOEuojZJu9rd8x40HDja2tgt6lqyjMplrtiK5ZYbGUXj/Lk87s0tna03hItYKdWRK9BAryr/bFA6vRH8H+cKT1MGpOdHONfko6KkHf7FqODkr6pqxOudC3WqLFOobUyKIyKMpG076izM8awtCSjV7WFw0QjX7XNa1y3QjxoAHkbUkaB20/8ULEQFOZCRjlGbfyNaAaofYjLsDu3MoYkqkGbm+207mw6qSCdYkNyCXg1mzOwtIYI4/Ku/RP2B6TzplgDk3e2cCuGWlE+RAOcFKqDB/d/i1aiZSaYppcZoearzTrff9ModOgKTDk/g1ROTjYM97lSl/dl0T2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/FcPAMxg87iPEUNCp8fDKOvzYniC0LbxyboNsag390=;
 b=OYA6kKIsZoorQYBIKOEMqQqc7/VjkiXVmTDsEjWUmjRCvSMTP+2RqiZgV+z4HDt1haloJfruk4xa80P2lqrBLOYFI/3/+qcoNMcC5oQeOvDcjxlZUf227DAzYM/VaYtY1unHq3PbMoYOFsnbe55YMbnpCBUW+cwjfwQH5+0CCHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7240.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:03:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:03:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	shuah@kernel.org,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] misc: pci_endpoint_test: Gate doorbell test on dynamic inbound mapping
Date: Mon, 16 Feb 2026 00:03:33 +0900
Message-ID: <20260215150334.3391943-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215150334.3391943-1-den@valinux.co.jp>
References: <20260215150334.3391943-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0f43fd-11a6-4e49-724a-08de6ca36808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVaAdZlmZ7SGatlImStehyaV9gn/NyuuxK6t/RGuM1hXPSQSzhHUm1yiUI3n?=
 =?us-ascii?Q?sWt8MfdkuZRHXWzfkzZPfAFOvaMsGfo5KWUX3A2u8WjQNy4C2wq5QXP7qvIw?=
 =?us-ascii?Q?mEq5El6f/BR1TPasV4VgAels7wgOlcG4rmCzV6/4gklHpXowSCQKaAHPXJ64?=
 =?us-ascii?Q?3KpFgRCqmPUwHb/YTosCKLIj8jTI5aE7Xd1nkH7gTeoEBtiUvWCR67fwVjuF?=
 =?us-ascii?Q?83MsD/zv7fcQgUaImtrBUAngRDQ7DVDKPYlOw7tq+Lz1k7nKosuwvcFuywrI?=
 =?us-ascii?Q?T/GfN1tdJmcuAbAMEPWfNhNwhTxV8qIakxAxFPbiqvZAZMaCGNPLuT9yIPUG?=
 =?us-ascii?Q?W2Lw6zCAZIPLDIox/rocHXrFkIfhul0LStEX8wMf4eoBGDmJa8YwH1sQm2wp?=
 =?us-ascii?Q?Gu9+dh/ZQ+WgrJiozIMACPrINInJplLjXXqNb90oWKyXOS8+Y3SG0H29f1x5?=
 =?us-ascii?Q?bnLWHeh/8AZ9trakax9OiEa0pfuTW4kXFa1froeWiaM8qm6neadGAkF3KvED?=
 =?us-ascii?Q?rDneEOaWnr/CbITRjnsHheDDH/afptTbEI9Qzo5r0joVw8jitmtd4l+1ym8Q?=
 =?us-ascii?Q?N9w1e8RLRt13xdJ+Ut5dubofNmdgDWQWK23NjoHedqYgHMa50ki28nnkC6MX?=
 =?us-ascii?Q?vwTZaBDU03YsdG8E4w4gm9JfRLMmIJP/OiXldswz9d9lLHAYNx/RJ0lCO/mR?=
 =?us-ascii?Q?7ArYNOdUgMPpFkb8n7HuhdtbstOY4yNilaB3E2vxwjylKTE8+57C2Eqkv55X?=
 =?us-ascii?Q?VCa/6XfxDZezPGdiARk5HECyg2ToJw3e0EYeTuWmV1xAYFAiKd95FonRfNnH?=
 =?us-ascii?Q?da7aMy0JbZxOozWJPcAUZuxLVVnp1KVYsTKDpp58/2L1BVMSJ8nhe8+yC6gP?=
 =?us-ascii?Q?GLvnrx6EGtXbMbYaUZRMOLKChBzCgNhP7K+snuxdFoPpttntDFDscEb+jCwC?=
 =?us-ascii?Q?qGWhcrXrD1UTm+2nN98E7u07YMH1tDw1NN3c4HnSuXmCM70wDtaihrt7N0as?=
 =?us-ascii?Q?iYTwmrQQ3PQdVvKGSA9K7jECVzFuy+w+6qtEcNNTCmNoYgcaUOMU1hvXQFfm?=
 =?us-ascii?Q?PAIXliboRIW2WsJXhA1ToMpvO2ulP4lpxcHXX4WQ1ccWzQ71SejsOx1/QzkC?=
 =?us-ascii?Q?QGfAtui8mwz/B1pCo44BE0ZgCCj6QwO2vyxFKPlxgk/vSuwksUCPHXzSRy2C?=
 =?us-ascii?Q?QscWrbRQPMCtpWDS9VhWa9PLYkW9Tut5fqGhR9H7F0NX2C4wPNubjGdvGKjZ?=
 =?us-ascii?Q?ioOFwSF8u84iAqN3z9fGpQQXZMxmxgbGgNk6YYMNVgnC9C81VtyZL/LhEtSA?=
 =?us-ascii?Q?Lb8ru3VvlVjPxcBhsL6PctYedileGcQ2z89CJpgh1dOnzqgHI/xHcr+HmnPa?=
 =?us-ascii?Q?teHFO6ljK004fZ1CBunJEKgwYVr5MKWBqE3GSaDEmlD9xo2CtSvJ+DnfESQe?=
 =?us-ascii?Q?zyn+V4vw2DFKYUQoUm2XrxsPPxR2sbY7hLQETwRuYjxejn8TyRu3aak/MBzr?=
 =?us-ascii?Q?G/lWqjJKUoceawW7b7GqGbym2vjyCkudkScKaOSS2fLomY+k/yP8tc9EK+zu?=
 =?us-ascii?Q?AdZQ/TmkSTAUtTCzIUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U0QBuOxx3xB562pOdKsdlMhtfV7bnJFR4xiNESSiPmKWTmyh29kvHdP2Iesq?=
 =?us-ascii?Q?yi999/S3409tYM4vkv8bS0NW+vE2RNmXCL8RP81avUj8hhRl68XQ/yGjQWXl?=
 =?us-ascii?Q?9n8OEBcly822vM3QYqJju5273g3cjo83cJ/WdxWB2S/CPY9XaunT0W2p81yc?=
 =?us-ascii?Q?X015fbPKb4pZFQzvD2FsIFoyfMskoI0zyxZvGfllqZinLPnusuqPzL5LA2+J?=
 =?us-ascii?Q?UQTvtFusa1iAe6ylqXiyJIOjGQBJaY6ESlnUQAAEbTnOYWPZ9HSTyeBCWFTs?=
 =?us-ascii?Q?xVgyH263pAmkXaSVooEhoqVeRl5DGrAc8kCnZoslNnOhEEqPbK+t/ifUwIhE?=
 =?us-ascii?Q?jTH7qm9gOLBAKMsWZZXlE3epx2K1c7sVZGN0RcTNr5mxDcvLvdsYbd2k8+Ct?=
 =?us-ascii?Q?UCAC629axcQHDiiTCg1ExjPDJkgFYHJYONwnXGB2Gi6cwFNk6HPv+ebbqZYR?=
 =?us-ascii?Q?g23zu/7TsiWlRMoBpFT4ljcPB4R7IS9jJPLg7uy9Aji457jPgECrCln94SpX?=
 =?us-ascii?Q?qLgv3t7B5q4nFWp1dLmWhG9ipZHGSu1L7qTQ18NuIEtCeK4Vl1aToesxS7AH?=
 =?us-ascii?Q?P3GLJP929rfZldnTojY/v6waL1yj1Q+uAyv6yEE6F/lccLiHAGESIY5xz/v4?=
 =?us-ascii?Q?rC179pkFxjnNdBV0HuSiPClF1prf5O1H36HTJuiJIIcp4NdmmGQXV9NHhS4l?=
 =?us-ascii?Q?iSbZ6KdjwR7mCdKzpe4OtkMfIkQ9DHHU//PvvJu6eoKZJiLdXKkCJWbUeuN8?=
 =?us-ascii?Q?zq1/wLhIP0zUF3wyIR6ua/YiMhH//G+pZPCm4gu7HEfiJawEHCH90aIo3SjG?=
 =?us-ascii?Q?JQCfhtXCVGvU7q530u+XpErbzbRet/9bYy7ssv57BkHiLeD9uSvFdBJl3gAh?=
 =?us-ascii?Q?V2nq1k/wSfPc/WkObC/nk6jZw8NaoC904asmqF4D4NLTr2vMcETY27qoKdfM?=
 =?us-ascii?Q?xSDv8my5Cjd9UQMjuXQEGgl7rbDcYXRmCK2XOD6AmkF7XTp9A5yd0KzHslnP?=
 =?us-ascii?Q?9XoMtIKIM4gePyyLmwIdTX70Ng8nQRuLluiVlbaamhKNudqxDvXjWF83OiOq?=
 =?us-ascii?Q?dfomlE0rWEtUwBBns6eARVQJTZ++cCAPMcx3bmRK5XmODZKLqgqRZ/I4GMmh?=
 =?us-ascii?Q?V5w/0Vo2jADyAwA89vBbBCjCnD5NWxa+o5rAXb+ken/QFa6XrOckKWfxnDFT?=
 =?us-ascii?Q?STK9psLZr4v3FqMlgtKZbfeMhpU3ZQZBbaokm0Xi6u0zQhbk7XdnFFJDEcyI?=
 =?us-ascii?Q?CXdPk7gO67NWSArwEvLKJXvaGayd1IOlEBG96+QJkxdMspp/1kHV9xnScF34?=
 =?us-ascii?Q?scZdljAIU7SYINc9tlWgg4+GDNusY0h1rInjPowDjOrQM6DAPcvUjJl65DwK?=
 =?us-ascii?Q?roVjhMawnwkNE8wViCLkATEid9ZC0qWTxM7bUxH38c5wU/UIuxqM3tXnxyZH?=
 =?us-ascii?Q?B0kEvmwyUg5w2bU+pK6gCO+oidPSh7M+0K/hIRi5jkw7fg+WF2brpHf1ylEh?=
 =?us-ascii?Q?78Aq5YinnU5yORSVe2ZqrJg7PaUf0+1ez1q1krDILfqjeQ4xWjSkO3ME6eQL?=
 =?us-ascii?Q?KPBf9mOKrdy7saV/ZjvpvFRW0uxBSMJFAJu9jxIX5i8wphhuXvFaQDWwAMI2?=
 =?us-ascii?Q?waj6UO9KKWUwctchfuhBZfj1F+wQCi2fseNoWSPvRK1/F61edLrI2oXZbY0w?=
 =?us-ascii?Q?c4tDyCTqYN26YBlotOioUZg+rzt2JyVCeOEhN7X41B2o1rSAeSoX+u+arT/D?=
 =?us-ascii?Q?QHWfg6hUFfCMw7SM54ClwP+Kpv3gMfrBd2IwaS1GhAM+y3FbQ5Ya?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0f43fd-11a6-4e49-724a-08de6ca36808
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:03:41.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEPjcXZO/HBHpVYYnunCJO0gRdxf+tdo2N8zO9txg4G0i0/9M5xpE/Gas0gPw0GanXg7MmAp3HTpXmxSudqjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

The doorbell test relies on the endpoint being able to update inbound
translations at runtime so the host can reach the doorbell target
through a BAR mapping.

If the endpoint does not advertise CAP_DYNAMIC_INBOUND_MAPPING, return
-EOPNOTSUPP from PCITEST_DOORBELL.

This avoids confusing failures in user space and kselftests when the
required capability is not available.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 74ab5b5b9011..93cd57d20881 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -84,6 +84,7 @@
 #define CAP_MSIX				BIT(2)
 #define CAP_INTX				BIT(3)
 #define CAP_SUBRANGE_MAPPING			BIT(4)
+#define CAP_DYNAMIC_INBOUND_MAPPING		BIT(5)
 
 #define PCI_ENDPOINT_TEST_DB_BAR		0x34
 #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
@@ -1060,6 +1061,9 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 	u32 addr;
 	int left;
 
+	if (!(test->ep_caps & CAP_DYNAMIC_INBOUND_MAPPING))
+		return -EOPNOTSUPP;
+
 	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
 	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type\n");
-- 
2.51.0

