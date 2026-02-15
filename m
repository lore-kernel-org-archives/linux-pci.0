Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247C2248B9;
	Sun, 15 Feb 2026 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771168166; cv=fail; b=rrhnE7Ws2A8Od8vWqkDwmxMidT/rN2jg55RnXBWtU1SqyckbJgWJt8BH6oQP0MxjgTJ8r21l5l125b8H5nBvH6TO3a/XM1hG39rAAWhDyZMcbE47BcrXyT1rKzvyAPvtELU6wvbn7IB8Wqqcjb0PCZq9J4yVozoBY4eeRs6Hlm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771168166; c=relaxed/simple;
	bh=vWgpMozEEVuyihdxFX3kXiJReAgUT8TZLIHPvQKexno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+pER3xrlGYm+da9bE540UVp07t+dfmVmElubviUx4V/WkDICl/n1Biyh2Jmga8MrgIGboswUArTPZAQ3YGwj820vZPylJrmOCEkjZLPQAOF5gkxCpOnj79AXmKx+P5qgJIUT/knULwWq175vKL9Jfaat2XzalLHIsJZ+aQEEj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hGTPGU46; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hGTPGU46"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSVzJkslXj4kKw+OExOIJISZ2FDELx+FyIeO4waWcFIGq4NzVQJWjf3j0hDT15/gJ9j/X/m0FInNoYgFUN6dKHw6NIsx01kFlepK2J3ocxwb+cXVr5xQaLbDVMRKefe1R6TOVgEjP9d4lNj6tPBEu77ODmqIdDpe29Ctb5tce1guTcQPAtgaa9QPETymiZ3I3G3cuyH5kBcwxtWy10m7amGN0Jp1/SYR5xZew8zY63WXIMv5oLs5yZmXi6Q/x9LaK5Vn/h78T0LQUKHjQhxtnF0xtDXQW9qZao+aNYuC0JqiPIyonudl42N0VMN+Fro9Y0gCMRORPQlvt5yIe/jUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMGAMfnYWSEiNEZdjlnOA56dlSnnOIuiXrZgESk1T8o=;
 b=pWI3HGtNsROBBUSKrqEtTSl9JdBIyt0dUrSnVEAn2FFnUQt+eLtqd/bA9Wej3Hsudt6Lei5OZhaqoHqvKQ9HPYs6UQu1bbWgK13HN+/NklvrKABWlbMsG9NxL1ZRK9HboE1dqQjzf3CjHuWWVlNsldccCCn/mwSIoxTg8V+gEnoz6FwFJHF+O3s/Q8UORTqjphtwilHN8dwOj9ktNFfNri84moysABfE4wj7VjV0p0f6ZdomcCAY6hYsrs8OphLPQ+6TNthmwWd5GI14KKo3Ba6X9s6FTKubLBpczz2fZdjSi3Gm0p/cBnaVn/Zq0vIo6F+g1RNbgTUQKBgx0NJcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMGAMfnYWSEiNEZdjlnOA56dlSnnOIuiXrZgESk1T8o=;
 b=hGTPGU46KixCn67PoKEYlNcxZA5YGy+5YSf1uctaVWhltUO7o8cqmkXgSoWJekd2I03jYhmNZqsnjwEGJwx+sGalDOMMkUkp/44+c/ScTbo2dTYP3L7OLyf5vIL0s70xZtmK7wdKzEqyULWQEWgAOlJ0GCuVF5+sc/fMSGMr6rY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7240.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:09:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:09:22 +0000
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
Subject: [PATCH 2/4] PCI: endpoint: pci-epf-test: Sanity-check doorbell offset within BAR
Date: Mon, 16 Feb 2026 00:09:12 +0900
Message-ID: <20260215150914.3392479-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215150914.3392479-1-den@valinux.co.jp>
References: <20260215150914.3392479-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: d0734216-9ac8-4689-ed32-08de6ca432fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxAFFfvC/zQi9M6NPeevVPkTvuVmwgzux7N52IuK0m3d3HuuCMryl4y+NEwH?=
 =?us-ascii?Q?HNTo5raytgt/qxnCU32qQ2idgOpvkydHIFMoDHX7V32xVc5yg3tPXpJcBA+l?=
 =?us-ascii?Q?UIwrDMEYan6pnJsIK+3o7Sbd59Rl46DbgeGKagaW3I4irOezN9Ea4uFVxSB7?=
 =?us-ascii?Q?W1LsclCOoOQlkGTWDgSejpagh4KA2cG7+sEs2GCyu3vSqXrufTO2L7k7FV5n?=
 =?us-ascii?Q?Od5E1DicHZt7YQFTdPTaSps7yUDcBUZWmzA0wDGO2dthdwb47nyJl3nD2D77?=
 =?us-ascii?Q?AQt8BF3YmW0KP6H0jM5AzJbI7YP8zqL4CSiXtjipXrm0HjqLLEQjR2EK0Xcq?=
 =?us-ascii?Q?Au0gNARraSXiGqzGPBoVg7VoDy6+WkV3C+fnX7QZfvyfQqdsJHhnZBVcqdXn?=
 =?us-ascii?Q?FD6TYoN/zdrioWHrYzdX1Vno88kuA1B97EmHMCcGNnn2FjNwJbyoPVUAaNQE?=
 =?us-ascii?Q?KikAAKnZnfykqt6B6aN3zSIFrA9+W6IjxEyKPqJ9FGLPo8krqge92mrwCgLR?=
 =?us-ascii?Q?RMm6QdCePwY5f2ei5Wf1xp8EfqLVqZ03DJ/zmthav9jtPR6svRAuCF8o+L/w?=
 =?us-ascii?Q?LA58uQI8Uwgohjs4aSMy3L5Q2Oq3Hx4nwPWxt5KMA7dMeClRokt+SX5wj6x4?=
 =?us-ascii?Q?44kAyZHA6hfzomCOei9X6oDzJ/xHMnfiBDFDBqhG5gs8E2Ls9uFThDhlhoRy?=
 =?us-ascii?Q?Dw3JQ4gnaZclSdZR71zgoPwF/3HETrzfmn5+6MmWBfNbmiehO/EtEJmz7+30?=
 =?us-ascii?Q?C9/bKybLUSPZjG9sU72h2F8QUCb11B2npM+78jVHRhaSaET60JUVybLMLvAm?=
 =?us-ascii?Q?NySi6RtM10lbtL5d+wdMt4otjRJnvV0lklQ4MwmaqXsFIum/RvEdktr3XZzF?=
 =?us-ascii?Q?wxfN6kzuAGpmP7iPyOIUGlOMrTCU0yw9VlvoV1HgFDDKm8cjais1DJhnKfMN?=
 =?us-ascii?Q?5vVf+qWyNz95r85ggwP8N6trvRxQ8XQUbVf9Bv8Sdv/C4YV73VZFn0dfQhp8?=
 =?us-ascii?Q?bCJKZGGAQVi6mw7XTczs8mvcamXHF0d54M1b7jRpXSEr1RDwM3oSiqiNJXjE?=
 =?us-ascii?Q?yAznz45kP4wwpj/Y6hxY/XiTHE0Xfnjsi2N6EzuvQWaU0H7FCSBmtJA1tmWh?=
 =?us-ascii?Q?c0nT5Q+hR63mGcTtNDXo1FKHoa0oJvo8O1WwWCAwK3WaJsqGbSGMAIPj1Avr?=
 =?us-ascii?Q?zximMwFTWlZURaxTn1CBYHIL3p7dHtzU1NDCNCzo6SmQ676ebf+X8r/TDh1W?=
 =?us-ascii?Q?UIt1R8LH/+de3XYn0hQZsTMhhy+Uc4ZetD58LiwWxKndzGeGtoAoaCH4sVwU?=
 =?us-ascii?Q?tvxsVjhaF3ONRMxNmRZ9HiDGuTd8ipDx49YrgGTmqvG7xg6qoKo7zNpBagJD?=
 =?us-ascii?Q?vkj5r3mKn4A4XaH+aWZw7V+qjMKYImfg2WcFZI+K/oPNe7oa5N4KVGgmiYvj?=
 =?us-ascii?Q?kSDohETybPmL1lluUH3lHVICdQ0Gzkfs/v73LS1sJ5agEdDKmWuzKOXdUEBP?=
 =?us-ascii?Q?wWa4z2Qyt07VPRJ9EYhplaZZBxtrApEQLnvxOkPmmFxpVbAsfewCkisNx8SQ?=
 =?us-ascii?Q?MQ6ZtCsWUzzoWsLeTbY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GhvCTJiOrseXcL2KC32E+1c8CkMXCZjSSYEMulLbgovfxzKg2BUMgX94moQo?=
 =?us-ascii?Q?B5mB7rcj3AES0WuXVuo2TjENYAqBFqQ47PN+/b2ZrCzB5qPXnD1oZ/07oG1c?=
 =?us-ascii?Q?8V89bxT7GSuuizzZlerFvseASpYrmrZm+IZTf5F/p+U63xGqF3tg41ABcXYT?=
 =?us-ascii?Q?fdl/EHjMCC7fTipJvUKICVN3sgbaMm3NnS4mejaYXyAmLSBUv7h8Jyt430jL?=
 =?us-ascii?Q?lGrHJ9ZlJysfD6T7MGfWr+FYWWrDHqq/rta2jXt9/aSsIv9LB41pP5F/NoJy?=
 =?us-ascii?Q?Go0gIe0L7Vj7mfX3FDIvjVG9qtSPGTAVLJu7ms6QiTkmANuIu0H7UGnxRJsA?=
 =?us-ascii?Q?2dOADrZjuLgvNu5wp0la08HQH2qGTo6WI0YNcDqx+vHq6ncXIQYI4xrVUPR/?=
 =?us-ascii?Q?vNj9r2fj+A+bBkBzI969vH3r5k42dnuT6KAJcGUIHxtPDdT723dFlkVD0Rhf?=
 =?us-ascii?Q?gKo2smM8ZFxLc1dgxaQDqOmrvcnuB/7l2MkdLXwpVutbnX3lMasHOzp8044h?=
 =?us-ascii?Q?Jb8nTf7CFOMzU9Hr3W3biJa+0//l8jKsif9p0AQ9+upRvexvyjmRqarT6o3H?=
 =?us-ascii?Q?qjmQZJ5fAX9hbn8nHfuNp9cSCZo/044THSpqihhZCMim+K8UvKb1j50KSGQc?=
 =?us-ascii?Q?RMRdmk2aecIlU8UdQ1DM8Q2M6Ns/vNWEDrHZKeXN5eviTLHtGUSVTAfiG2xj?=
 =?us-ascii?Q?55pVxJ/P8Uz3x4BAFGHALK84oxRDuy6HDD90LcpF8sv3OMHIx4no675ifG8s?=
 =?us-ascii?Q?EOlWEY35djJVowNoy2fyd1TI514ru+s3Bnlw1ZuMRLuhwxmJlHGgpLgMhBmU?=
 =?us-ascii?Q?aaPeH/JDORwYiPcwlQPJ3ZcMCvSGLbC5z8AOHXuRgKT6H6ZqcFiFd2ci15ni?=
 =?us-ascii?Q?lE3HYcKMHtWDuRAW+1bytCEQREm4YL2Q2eQg9b5PMan8Vm9yXScJiV9Uvk5t?=
 =?us-ascii?Q?Krs+hdBT/+CHVF8WWkRF945AQdbJDWH0P4K4aWm8KiOfbGAbsZ0Q+QWO8Zba?=
 =?us-ascii?Q?3AQOzpEwyLwdTI7ulMfMq+3cPp9A0GsPsmHMKXwn3/Ex9AxoGAWIJPXv0ABY?=
 =?us-ascii?Q?TeJ0pNey04HamF/WAhcaemNDJwJd8XjLBm0hX7aGaICOVHTjRfHgXLlqpaq1?=
 =?us-ascii?Q?TRr03jbo1RZGpg/q8fx2nO3CZlRRGJ5A4Uj2OJsBTZrrsdaUUa5hZDNCclM/?=
 =?us-ascii?Q?yVkNWXDurbouGlS8SAXmGlh5N4N9TAob2MfXid/hkJAC1MBPgWoOi1tv1IGN?=
 =?us-ascii?Q?VrX7rJ7lvBD9+JMqGMpUDcX8q2sdfqRD+i34SiqzVTxypO4hoGwP+vRVL72w?=
 =?us-ascii?Q?hHRX/AiTHwtZkMigTpa9sw9bkZsRGZj1uz93v9phG7mnNSjD6mDEI0DfDS3L?=
 =?us-ascii?Q?0qFbpNoQhsAsu9eHeDj0l8NjYGg80+T3O9W+/9StePv0vIRjis9sA3PvXFxZ?=
 =?us-ascii?Q?hJylUPlcf1VvRc4Fk+ctJBURJsQdR/QXxrRVdxwdkXlFVGP7H7bevw1qkpBd?=
 =?us-ascii?Q?L5yRSHh4/AUDt3xgwyCdSRv0fwfJuQrZsFCnAnHC1Al05M884zYcQkscURLQ?=
 =?us-ascii?Q?uKzFf1AE7q1UAhWp9WOBb86rJRfD9ZQBbvngRSroYjCe/rMqM7t/C008zrqn?=
 =?us-ascii?Q?Wb5fg/a2wETR8yu4uAmd3Kk2p2mOILuy4qVJHKbydT6xh4hnmG5Rz6GwUna+?=
 =?us-ascii?Q?2GmuXMmg0gTjYZ61QGuxPsX3bQu9ftp3mUu76pKMHUlhC3A2uBoJaWM8ECuW?=
 =?us-ascii?Q?3qGxmtQ7ruJZGhP3cjI1aWLv4gxHHow2hSEagQBvQLMkGG6O0GzP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d0734216-9ac8-4689-ed32-08de6ca432fe
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:09:21.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzKAK+8W16kTGfWQshXx623UgIDOTVUiNveTXw9Kc5hkldORkfpkMIQGJ+2jVSql+CKGB9OuY1oDTHMQyET1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

pci-epf-test advertises the doorbell target to the RC as a BAR number
and an offset. The RC rings the doorbell with a single DWORD MMIO write
to BAR + offset.

For MSI/MSI-X-based doorbells, the message address is required to be
DWORD-aligned, so the computed offset should not straddle a BAR boundary
in normal operation.

However, with support for doorbells based on mechanisms other than
MSI/MSI-X (via pci_epf_alloc_doorbell()), the returned message address
may not necessarily be DWORD-aligned. In such a case, offset plus the
32-bit write width could cross the end of the BAR aperture. The offset
returned by pci_epf_align_inbound_addr() is guaranteed to be within the
BAR size, but this alone does not ensure that a 32-bit write starting at
that offset stays within the BAR.

Add a bounds check to ensure that the 32-bit doorbell write always stays
within the BAR aperture. While this should not trigger for
spec-compliant MSI/MSI-X addresses, it provides a defensive guard
against unexpected offsets from future doorbell implementations.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0cb7af0919dc..148a34e51f6b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -761,6 +761,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (ret)
 		goto err_doorbell_cleanup;
 
+	if (size_add(offset, sizeof(u32)) > epf->bar[bar].size)
+		goto err_doorbell_cleanup;
+
 	reg->doorbell_offset = cpu_to_le32(offset);
 
 	epf_test->db_bar.barno = bar;
-- 
2.51.0

