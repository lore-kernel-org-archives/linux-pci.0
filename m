Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612779;
	b=3Et3hcHV4na+D0/AFb0VQYgxf/TJTWH5KeGoaF2VOVBA1O86HH9HbS3t6xpZRiBdEFk1
	 dvRrdfADLDf5uuFP/jV4JFww0OfoBzHihIBjvjNvji9m6XyWEdhLjnggFYR+FXoaciCZ1
	 K02v6ld1R6VCgd1DZ0EA9/42cXxyViM2mAqAiHFzPWIxpUVnztmjgxfmpTFW0FskpsO63
	 MWz2PqcrfIn+vVLu4hMguLp/Ox5J2MriitbI2pDie/1LQTDKEWamzcYJdWUM0twLssDtz
	 4SX4/CkCGY1t48df446J+e+Neh6n5vhn0D+//cqOsKtgSZZzJ/nDiPLabHs3SajekDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612779;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VH5N10M3pbGME5hcwz+unBCDD2i1BtNna/1CUHLysFE=;
	b=HrEkcly1au6g2alp6rADhtOgoMMqYI9FlmtHTxfQDoIJu4SRUD9wtTvlI4/UMwnE+4a/
	 8E7fue7//ShIFeLvlTEFZ2PdWgwfXPDpYTpul8Cd6JbfDjywgJ2PPPxvyKk01YkYbS5x/
	 f7ofDFIr/Zo5n4x6DzklTj4iNOFX8TAgfklrkp0+GHx99tNxkAJfdpjK9MJV8L/BITuRt
	 XtRZUfDfqIiLeMmaC1TgtGPPPactW+9a9IEaMJRsgFEeQxbO6VpejwV4PsVKuDhUHFnmw
	 pFf2UZv53LR1+IOc3PkdrrdYUTguZrGACp4Kp9GOVBrM1KFUEZ84ALLnx9oK7m19Xrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r5Nxx71S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.12
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E88606A326;
	Wed, 25 Nov 2026 13:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5E88606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r5Nxx71S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0rWHHrnQTBbE1OZrzJkKsZfoKHFgTojtiaSmbYiDcgBzEtAFic5GU/1dOp8aoxn5Ntx5tyM/Olp9D68tb1/5X0su4loUjip2int4qVGh3NaKz90JnBOUygzOQzXx96sqXv0ihcXsUY1nif5SKYofvCg5fPlx/55qktdPjYJ+qr7I4y3BscVTeJtjxsbySjqHN7bu+Lv7b7hiRPZ/0mOd7F57zJkhU5sXWmG4FGURmpEAdEhz56i+pPG4zdUgRxtTH2qJm7EM6evbAiyAOHkqCV36D4jIL1Ryu80xkpvjAyM6NpmCluM4F3pw12b84fg5W4QqM+XM2we+aVsHcEBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH5N10M3pbGME5hcwz+unBCDD2i1BtNna/1CUHLysFE=;
 b=rhONucqjAtxdf6P5WnxnBQ0qmnvcaFF5J98rJaXZaz5Am3l+73kbqAgZKyEVbX+CYUV2Qvzc7JAguHKoKUO150FrPU3TlpNL1caOm+eFwQqG6hHkye3A5IvBuqcpkkFmleVsVjlZShNQ63it2KpGPrv5xcqKQtp0KcftJ5lnYREPyhCIzDzgazciipknAPcQlSRu/78u7tD3h/JL4XT0W++boBD+ljRHn72fRhenokxn34EmiHZMm6q6np4/Y2Cj7a5QwxQ6fANj21qGnTTNQ6WVXqHnb81XwkLJ1iu1g/llo+bd/AjTLRkNv5Qi1WjZvWxh1jjvA+xJtUuT3xJpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH5N10M3pbGME5hcwz+unBCDD2i1BtNna/1CUHLysFE=;
 b=r5Nxx71SvCtkBbkSsE6DliP7d/AHsGihywyOeAxKzW3euQV6X3ox8KTYyHZshTeZN1I5xH090nhZ0lyFiamJM5u6o/87b9+LV0OKgWiY2krYktRngg09I3Htexa5MTH/LG+F0kBbY/9NhN3p8UHreKuP330eNIVnFeSqqYa9lDldvrA8iaEbHW2IlypPTBt5MTbIiwHKaIWNZNqpyfbOLi4NcTu7uNo/LTfHsyBgyNt3r4PvupYV9NiZgFUU3Xr2wfByRsF/A2/3GYu/QKP1CtXLQgdaqxGxsi+tgxjb7b1Xv+JGmMbgdoul4MTcACRi8xeI7k95F5y3kclUKL3JcA==
Received: from PH5P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::12)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 13:19:30 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::41) by PH5P222CA0001.outlook.office365.com
 (2603:10b6:510:34b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 13:19:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 13:19:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 05:19:08 -0800
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 05:19:07 -0800
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, JC Chen
	<jc_chen@diodes.com>, Simon Cheng <simon_cheng@diodes.com>, Nirmoy Das
	<nirmoyd@nvidia.com>
Subject: [PATCH v3] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR erratum
Date: Wed, 25 Nov 2026 05:18:38 -0800
Message-ID: <20261125131838.1272907-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5d7474-b92f-4399-2e74-08df4af6bbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|11063799006|261026140227099003|56012099006|261022105027099003|261021121427099003|261022075727099003|261026121527099003|261102123227099003|261028144727099003|261009223027099003|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Y/oQvh1iq+5XXBPJnuGnkrggqmTxZFsFAMb2rldP/ihf8+EgFk9CpbkWXy0u3guixiEg08q9jznDQNdFiBxhNH7lzOBnZvGVQR/ryszejMqeO/Rjcx6c1upPcE48dpxpgajDimPDAFpjETOWdFBEddiYwUXINRTv1kTwLQhHwAv+PWGiSdYuHgmx3KnKjkVE7evZrqvtS9RW7/LBu3saCM2jTuuKr0vt6a/wJxhHvkjh6cQ76sUj9Ra3NmoDhs/XVXYyo6neOt32vtp0MflRoVm0OQaAR+32ON+G/X4HpNFL5Xw75HCWD4pra82W/1t4dce7RCoAJJw+/vepgJG+vyuoVp8XdirkjDFn/8h7FL5zRlolo/zqeCMDbLcx8vE40bLmXcOusnJS2/CwzPiulYqq6oe+v8w7q5WluzLje/lGmaOedW8tfBkz0KulT5gkJJt5+Itomquxc6+lWkOLTwRJL0hIlgUeVidOTCPlD6myosOcldP+PYi3trVMZn3a7DuQWTiDOBo+bSDLyNOeqmXM2FGQ8ywKHpjTgLwhvAPI8fl1eIBw/iD4lRz51I+9NFRow949hRVPocnH9D2JxotRoaOlcy6Tyey8vEja3QGF90GbC50wWEG2aVw2m+Z6lmX1Vct+ZqxptEMASszjY939cr4j3+mCaEyS9jikLhTdPUiA+IjG6QByK6QklTXcJaFhyd7pAwFn2jfJfN6MKA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(261026140227099003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261026121527099003)(261102123227099003)(261028144727099003)(261009223027099003)(6133799003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	97eeM+WzgLSpiJzZBgBgQ2CJ4Ocb/bgSZLdTHEZPLCZhKsM7580AP+KSWx4KWeTovgJywdaL+V/dQPS7wQuRa0WVVinBkcDZ5EjW9kyfLcpd8fHusdDPj75BFIbY1D7ifKtR2xazL/sMzQlcfZjToMMWJohhwGsdqUyAL8Npb3daMuFMLGyeqjBMwyPlWEw6OrGo3KMXhNaBE7Swzy9rxkaDjH2IbAnxkf3KvjXGHHyBY5YSSd/5OfwGDLPunsGUjbR+Ccwwt9Ezd/rEcqpNl4ep4giNJCNptlw0uoFYqGnkebmG2DFTbAcLwkvn8e8IFT0MccQqc4ec6SdVewUC10Zzk+Ckiscp/OIrWzq6h1DsUsD9VJIb4tXnRDRVLCLK1zdfyZrIhklt2Ns4Ot+oADTCsCy6154PYRYKvs8tJibY1aqm3N9+p3/2thECkM51
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:19:28.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5d7474-b92f-4399-2e74-08df4af6bbe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257

When the Cross-Domain End-Point (CDEP) function is disabled on the
Pericom PI7C9X3G606GPC, Port 4 exposes neither a BAR resource nor an
MSI-X capability. It still checks memory requests against
BAR 0 + 0x7f000 and BAR 0 + 0x7f080, the MSI-X Table and PBA addresses.
With the internal BAR value at zero, reads reaching Port 4 at these
addresses receive Unsupported Request (UR) Completions.

The affected system has this topology:

  0002:a1:00.0  PI7C9X3G606GPC upstream port [12d8:c008]
    +-0002:a2:04.0  PI7C9X3G606GPC Port 4 [12d8:c008]
        +-0002:a3:00.0  Micron 7450 PRO NVMe SSD [1344:51c3]

Diodes' workaround is to copy the upstream port's BAR 0 into Port 4.
This places the Table and PBA addresses within MMIO space already
allocated to the switch. Port 4 accepts the write but still returns
zero on config-space reads, so readback cannot verify the mirror.

Firmware can apply the workaround during boot, but Linux BAR sizing
reads zero from Port 4 and writes that zero back after probing.
Resource assignment can also move the upstream BAR 0, leaving the
firmware mirror stale.

Reapply the mirror after resource assignment and again after PCI
configuration state is restored during early resume. If the upstream
BAR is 64-bit, also copy BAR 1 and disable memory decoding while
updating both halves, unless mmio_always_on is set.

Acked-by: Simon Cheng <simon_cheng@diodes.com>
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
Changes in v3:
- Drop RFC.
- Rebase on pci/main (v7.4-rc1); no code change.
- Add Acked-by from Simon Cheng (Diodes).

Changes in v2:
- Explain the CDEP-disabled address check and how BAR sizing can undo
  the firmware workaround.
- Clarify that Port 4 accepts BAR writes but still reads back as zero.
- Include the affected PCI topology in the commit message.

The unpatched boot log shows Linux moving the upstream BAR 0:

  [    6.440107] pci 0002:a1:00.0: BAR 0 [mem 0x10300000-0x1037ffff]
  [    6.445353] pci 0002:a1:00.0: BAR 0 [mem 0x10c00000-0x10c7ffff]: assigned

v2: https://lore.kernel.org/r/20260917103814.1985144-1-nirmoyd@nvidia.com
v1: https://lore.kernel.org/r/20260723161010.2638956-1-nirmoyd@nvidia.com

 drivers/pci/quirks.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee415..2d3f677d0d4d20 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6443,6 +6443,95 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2608,
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2608,
 			 pci_fixup_pericom_acs_store_forward);
 
+#define PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC	0xc008
+
+/*
+ * With CDEP disabled, Port 4 exposes no BAR or MSI-X capability, but its
+ * internal MSI-X Table/PBA address check remains active. Mirror the
+ * upstream BAR 0 to keep these addresses in MMIO space assigned to the
+ * switch.
+ *
+ * Port 4 is device 4, function 0 below the upstream port. Its BAR 0
+ * accepts writes but reads as zero, so BAR sizing clears the mirror.
+ * Reapply it after resource assignment and during early resume, after
+ * PCI state restoration.
+ */
+static void pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream;
+	bool bar0_64, disable_mem;
+	u16 cmd = 0;
+	u32 bar = 0, bar1 = 0, upstream_bar = 0, upstream_bar1 = 0;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	if (PCI_SLOT(pdev->devfn) != 4 || PCI_FUNC(pdev->devfn))
+		return;
+
+	upstream = pci_upstream_bridge(pdev);
+	if (!upstream || upstream->vendor != PCI_VENDOR_ID_PERICOM ||
+	    upstream->device != PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC ||
+	    pci_pcie_type(upstream) != PCI_EXP_TYPE_UPSTREAM)
+		return;
+
+	pci_read_config_dword(upstream, PCI_BASE_ADDRESS_0, &upstream_bar);
+	if (upstream_bar & PCI_BASE_ADDRESS_SPACE_IO)
+		return;
+
+	bar0_64 = (upstream_bar & PCI_BASE_ADDRESS_MEM_TYPE_MASK) ==
+		  PCI_BASE_ADDRESS_MEM_TYPE_64;
+	if (bar0_64)
+		pci_read_config_dword(upstream, PCI_BASE_ADDRESS_1,
+				      &upstream_bar1);
+
+	if (!(upstream_bar & PCI_BASE_ADDRESS_MEM_MASK) &&
+	    (!bar0_64 || !upstream_bar1)) {
+		pci_warn(pdev, "skipping PI7C9X3G606GPC BAR 0 mirror workaround because upstream BAR 0 is unassigned\n");
+		return;
+	}
+
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar);
+	if (bar0_64) {
+		pci_read_config_dword(pdev, PCI_BASE_ADDRESS_1, &bar1);
+		if (bar == upstream_bar && bar1 == upstream_bar1)
+			return;
+	} else {
+		if (bar == upstream_bar)
+			return;
+	}
+
+	/*
+	 * Disable memory decoding while updating a 64-bit BAR, unless
+	 * mmio_always_on is set, as pci_std_update_resource() does.
+	 */
+	disable_mem = bar0_64 && !pdev->mmio_always_on;
+	if (disable_mem) {
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		pci_write_config_word(pdev, PCI_COMMAND,
+				      cmd & ~PCI_COMMAND_MEMORY);
+	}
+
+	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, upstream_bar);
+	if (bar0_64)
+		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_1, upstream_bar1);
+	if (disable_mem)
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	if (bar0_64)
+		pci_info(pdev, "wrote upstream BAR 0/1 %#x/%#x to Port 4 BAR 0/1 for PI7C9X3G606GPC BAR 0 mirror workaround\n",
+			 upstream_bar, upstream_bar1);
+	else
+		pci_info(pdev, "wrote upstream BAR 0 %#x to Port 4 BAR 0 for PI7C9X3G606GPC BAR 0 mirror workaround\n",
+			 upstream_bar);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM,
+			PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
+			pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_PERICOM,
+			       PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
+			       pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
+
 static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

