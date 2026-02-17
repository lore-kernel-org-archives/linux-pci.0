Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569021ABD7;
	Tue, 17 Feb 2026 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307747; cv=fail; b=KFeB7dw5FfviWU8EahLK9J5XjdNTU30Qx2Fv414E7qV5ucBSR8v//nPDoQuB4A2B0ZimKwNGxJRS2erQSWgNX+v7WJU1Mm841jkWX5jFzQ5SAjOEXHgPNcP9v6tKsr/DEKGh22iWm9xWj8YMQ/oQXDNBZKlRinfBWaOuAeBxqJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307747; c=relaxed/simple;
	bh=3IAmS6MY5NAraE/E9lBVxa1Szob7VwZxidT/hV5tnSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5L4zm8C6wQbYO0XWp1piuN3NCZbGnp89m3/GhE3KsBACvnxIeWRCqtSzfdNExahVh+IlkTf8oDtcL3KFudrlBfce9PrcxeU5SvnFLJZ6w0dMP79mbCq+ErBg4bGffTAgIPid+u86BsAGwqzk4hTR4FnaSyIZ9DLp1MUo8zVtGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FggYL/h4; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FggYL/h4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3zqWje/97Cjm1HtQNnFYN/NxE3dJtBOEjSx7n+TEVWu0vOCzKY+oJduubcH1j0c73MA5txp3rS8sFLqscI5S7EDdL9RBArqSHe53WjPjm0vwiqAUyA4WRaz6HdD2gGmQjlIXoyIzcPebn13TdSROT7HAh0CpDr4/FFUaE10bcYQbgmE41WYG1pXzQD4BAVUK3T14ToKykb0ImMv18FLepwuCsJmsjjRaJWcZ8fRBm7usVigDW9fSw/WBXsEsN1nPhUvXIitw9UsKij7o7ClvF5dC3L5J9FQQ09/AcSiwCoPmtaMIBqgVtbOiDHktGd+RsNSKZsEMp5lXsRZ+VsKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cxUq2jUTyx7qjEAq+WirBbXD2bUTbuecZCgc+latC0=;
 b=abU14U+sVGPQRyq3KWF5rK0qFZ++c8NL5qvWzPZGQO2D8NkaCAAIvKo0PEmVTyk8HiKrlkjylJZG62BMrjMkoe1fW99r+uDE2W/SPYEA2r3XsdNpXJTYlLQ/4SmQEaYptBUz2OcmjKR74FGeMwxPfDfG5acrsqhdZNClcCzfqcSpEtWQ5aCvQj+z+5HfpJxDrOx2lP1Fj19TpbqjYYZ6HuGf6ADY3E6mGjUw7sPvf6M89Z4vKwpZchqA5wKlhDyyezheedH7Jf2B91OjQoZOlZHDfpy33Hp+jnNmGQYygLK1X6PBCkPHdZvoBeyCKfMBKSrF7fY5jI9S0ss46fYkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cxUq2jUTyx7qjEAq+WirBbXD2bUTbuecZCgc+latC0=;
 b=FggYL/h409OZ85wqNKSlnTf5yCeP6vJYYogzmqNMu982AjHrFqHWz5cCakDrfivMHgNu0li+5FMWa3+V91Dq2u7HhCR3wkFIlVtmO1yE1Pttl94EJ7EIe479O9ZeqdnQhZf4ojmUX84KwbBKKgydI0pcuZq4Wr8n1qNmHlkc/YPFjG3igMYSVWOI8YQLbK3PBKXNWoTIrprOrT0u7F1t78P7L2DL6SPR0f3AIoU0DlvPgB3msfCy1HIC69eSS2eP3KOvY6XRXyM32p+N+F/56GKyWjirjImSaQTU0b+kx7BSMrg8i9M8+jFaVUIObFClcGOwAm+iI3FBweZe7grL+A==
Received: from CH2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:610:38::31)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 05:55:41 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::f9) by CH2PR05CA0054.outlook.office365.com
 (2603:10b6:610:38::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 05:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 05:55:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 21:55:18 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Feb 2026 21:55:13 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>
CC: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] PCI: endpoint: Add BAR_DISABLED and document BAR_RESERVED semantics
Date: Tue, 17 Feb 2026 11:24:41 +0530
Message-ID: <20260217-master-v1-1-727e26cdfaf5@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
References: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b38a5f-61ea-40d9-1779-08de6de92e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXc3b081dzJWZkR3QllJYTlOcUZ5WnZGTTV6S0puV2QrZFF3MnFDNk01bGRs?=
 =?utf-8?B?WlFpbmZZVFY1dFdRaVlVSFRLMXNwNEdKRU1VdG9WU3QzNGxBTlU1c0pjSFlW?=
 =?utf-8?B?TXdiTWVraElYQTV1aVA1M1crN1FlaVBrOERGcENwT0l4Nmw2L1R0TU5qSTBk?=
 =?utf-8?B?UWw1ckdWWlc3ZXN5RnRYRFRHcEsweE1uN3lveGNYbTBBcjREY2N1Qm9QUlN5?=
 =?utf-8?B?S1pRM3JsOENPRWI5d0QraCtMQ0VCdlNWT2FPN0p4dGJtQ2h3c0NrRWhoM1Y1?=
 =?utf-8?B?TitCWW9tckpqcEJTRW1uYTlaR1BpRHYzblgraFNpZEpDZHgwUk9Xckp4ejJP?=
 =?utf-8?B?bkFrNE1tZWtYN1N5eEtaclhzM1hiVTRNSjdZb0E2RUJYd0xERE15VzRXTUVr?=
 =?utf-8?B?N2pPRHVlKzVKVCtnRnJMQnlUTzVqdFVRQ1B6Mmt3RHgvWFRMcEhrRXlvY0pm?=
 =?utf-8?B?b01IWngxeEtPZDJuQnVhdDVQWXF0em4raFRkYVdHMHk3SXErN0YrRzVOdTJV?=
 =?utf-8?B?Qjc2ck02eUxndGVzNnpSbjlTeG9SSm1YUVVlZm5veEFvaHZUUkR3Njd0RXNW?=
 =?utf-8?B?NnV3aDVXQWpVM2lTa0NteTdaamdWNng0Sm5LTTludnVaWkc3VUw3UUpQdXpP?=
 =?utf-8?B?TUdHOWxnamRuenpkSDJsOVFheEhXWXZBWVNvcUJzbU42RlNnRUtnZDZVYUp1?=
 =?utf-8?B?KzMrYmJwMnFtay9ZTDJNYk1qQjQxdk53VjJJcC9DM0szblFVek41TmluT2Vk?=
 =?utf-8?B?VHZSVHlFOUlqTGRKbnozc2hZYTJmTGlHaWkrcTcyWkxNK2ZuM3JJVzJOY1N1?=
 =?utf-8?B?YStoNk9lVGl4aWtLVWp0YnZ2QVphVjlYYzN2ZGgwMkp1OEZZRzZGZ0ZWV0hP?=
 =?utf-8?B?a2RodVdZVml4WGpIMjk1YUhSYVlzZE9WZ1RpN2RYRmN0aXdlaHYwZXlueHVO?=
 =?utf-8?B?K1ZVNXlHaG4vWFQyKzhZZXFMK2d4RmczenhoQllremVEWTUzd1Z0VktFT1BL?=
 =?utf-8?B?RGhnbTZFL1A4NEl5LzVvNmJoRkhyNVJYQXF2a2JQby9NTGo2cnM3UWc1ZWFH?=
 =?utf-8?B?M0puQUNtVnZ2SDN3ZWp2b05GbDdWTWFWd2N5N3hML0I5RDM0VW41K3lORU8z?=
 =?utf-8?B?bmJnSDhPQkJlZ3FmTFNMejVRMyt4UFFYOElsT0JyOVhLM0NSV3o0bnlsSHZQ?=
 =?utf-8?B?TlNQbDZzWHE5djZFM2xQYUJhcktSbVQvVmRyb3crS1NxT0hCd29XQzFPUm5Y?=
 =?utf-8?B?QnBRa1FONVVOY2txaHIvMzVWdnAxNnFaQTd1eEdxQmg1VGQ2MEFtK29YNUhr?=
 =?utf-8?B?Rk1oOVlVb1VVdDdkMkZmYytWcW9VencvdEJMWUxNWU1hNkFKdGE2bWpVUjZH?=
 =?utf-8?B?QTA5SkZwWXljV1FRdkNRaXlnVFBydjdsc0VSSWt5QS9nOW9qL0Z6NzhBclFI?=
 =?utf-8?B?T0hSaG0vaTBia053ZlloSVJ0MktodjlyN3VLWFBIaXduR1IxRmVzVjBXSjJ5?=
 =?utf-8?B?dkN4QmFpWkxmRGlkQUN3cGpaVE5MMlJXbS8rL0Q3bkM1Zi9UUEthUTZqT2l5?=
 =?utf-8?B?ME9wSkdVMVJkNG1uMnRSVGJ0Tkowcm5rU0FDaE1FWWZZS3RLdzU5blpscVE2?=
 =?utf-8?B?NjNUWlpvdUd1M0IwUkhIM2d3T3VIOEMydnJkWThJUzJId1lVNGZBWDJmQUdq?=
 =?utf-8?B?NlRHMmV6cUozdlR5bnZRTVd5TjFxYjlzaWtka2o0WlV1K1dyZmJuRDJ2YXVJ?=
 =?utf-8?B?TUVTY0tySG04emVqd1ZwYVdjM2syN3BVdm1nd1c3dzJuYkM1Y2x0Z3E0Mm1R?=
 =?utf-8?B?b0l2ZFQvWDl0YnVNaS9BMFpUaTdsYURsaEFWUHdMOTQrbTh3NE4vVnUzTzBM?=
 =?utf-8?B?L0o1Z3dSRUJnMlRqa282MWJzbkdPWTlwUkZLdURvTi9la0xzakJUclNSajhx?=
 =?utf-8?B?RmdWZXhKQXdZRjlnNkQzSTYwZS9pV01iYzVqUW9ocThXNXBydlhPMGw1blBB?=
 =?utf-8?B?SzFrT3FpNURMRmYrbUVuSWkrL2tGc1VLWHh2Ti80VWFIMUNRRzdlTXI4L3lp?=
 =?utf-8?B?VExlOSttWkdrYmMyZU80R2xnd1pVbzNDMXZTZDRZZ2F5ZmhhK0w4aGRocmFX?=
 =?utf-8?B?YzU2MUpuTzFKK2pMSC84NW9BVkZncS90SW5NZ2c2TkF2SlYySk4yY3VxYnQ2?=
 =?utf-8?B?V2ZQR09aakNnZ2p2Zk5IYS9NR2w2QmU2KzVSM013RjlRTFBJNVEza3RUQXg2?=
 =?utf-8?Q?8K1nYuGwK8EhsjZj+AUfrRcNr917+6FjxD38gQX/RA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J2QGteh8Gx8lkmM4P0BLWy/sqWpC1T2Z/xs4EsvG2iy6b2aQl8/Gq7ktTL6QCOizPJTkqQNGTcGghdzfINBkE55+xz6Hf8QLG7RNeD+kHN5awZlpdIPbwOmbdF2jx8hKn88tc1ovzqlOE2L4k1X3ncB7bXJ3PAUlMCThCWn4IeHKDsLQKnWJEY2gF+GEa1zN9vf2L8dLiqsjEpUV2tT9tcdW9xLrqBkLDcj54bwByzkJvud5ktg1J4fQEqSooI1Dh6w4znwM2gqCGIUzRTfCcUUd1QDvUHZQRPIZF5utvvVBkZHkrYLQiJjQVnVka0bh92Y+r9owdM/nWb8EXQ+eI4CTrcGkkjPv0CaTvl5j3SKdMtKmgnkznu3Ufdw8b+OCQY8FPeooEkAkpqxfMP2CHYhLxQG+DEZExTGoli98ujuiveZqxS1Mc0mJoaNgAo2n
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 05:55:40.7944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b38a5f-61ea-40d9-1779-08de6de92e92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

Add BAR_DISABLED to enum pci_epc_bar_type for BARs that are unused: the
EPC must disable them in .init(), the EPF must not use them, and they
are not returned by pci_epc_get_next_free_bar().

Document BAR_RESERVED for two uses: (1) HW-backed BARs (e.g. MSI-X
table, DMA regs) that the EPC may leave enabled for the host, and
(2) the second register of a 64-bit BAR (high 32 bits) when the
preceding BAR has only_64bit set.

Update pci_epc_get_next_free_bar() to treat both BAR_RESERVED and
BAR_DISABLED as not free so EPF drivers do not allocate or use
these BARs.

This allows EPC drivers such as Tegra194 to keep HW-backed 64-bit
BARs (MSI-X, DMA) enabled while still preventing EPF from using
reserved or disabled BARs.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/endpoint/pci-epc-core.c |  5 +++--
 include/linux/pci-epc.h             | 13 +++++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ca7f19cc973a..1d6b04ac4fc5 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -103,8 +103,9 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 		bar++;
 
 	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
-		/* If the BAR is not reserved, return it. */
-		if (epc_features->bar[i].type != BAR_RESERVED)
+		/* If the BAR is not reserved or disabled, return it. */
+		if (epc_features->bar[i].type != BAR_RESERVED &&
+		    epc_features->bar[i].type != BAR_DISABLED)
 			return i;
 	}
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4286bfdbfdfa..9b3714a0dafc 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -191,13 +191,21 @@ struct pci_epc {
  * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
  *		   NOTE: An EPC driver can currently only set a single supported
  *		   size.
- * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
+ * @BAR_RESERVED: The BAR should not be touched by an EPF driver. Used for:
+ *		  (1) HW-backed BARs (e.g. MSI-X table, DMA regs) that the EPC
+ *		      may leave enabled for the host; (2) the second register
+ *		      of a 64-bit BAR (the high 32 bits), when the preceding
+ *		      BAR has only_64bit set.
+ * @BAR_DISABLED: The BAR is unused; the EPC must disable it in .init(); the
+ *		  EPF must not use it; it is not returned by
+ *		  pci_epc_get_next_free_bar().
  */
 enum pci_epc_bar_type {
 	BAR_PROGRAMMABLE = 0,
 	BAR_FIXED,
 	BAR_RESIZABLE,
 	BAR_RESERVED,
+	BAR_DISABLED,
 };
 
 /**
@@ -212,7 +220,8 @@ enum pci_epc_bar_type {
  *		only_64bit should not be set on a BAR of type BAR_RESERVED.
  *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
  *		touch, then both BARx and BARx+1 must be set to type
- *		BAR_RESERVED.)
+ *		BAR_RESERVED. BAR_RESERVED is used both for HW-backed BARs and
+ *		for the high half of a 64-bit BAR.)
  */
 struct pci_epc_bar_desc {
 	enum pci_epc_bar_type type;

-- 
2.34.1

