Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8423612E7;
	Tue, 24 Mar 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339791; cv=fail; b=aRcijlQCm4KCPLL0uLgQ29H/usTBZipZL/Mw61quYFazN41XA6OAc7pm1IT7BwXW9QzhNg0zaaeaXfhhS/O841h0D+kXxMRwUoOyIVPV5zCiYOaVUrz6kdTYnIOfExYaLy1Lr/Oz6hkHptMbTPcjUFOVySl82EGg2HUMgMUlk3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339791; c=relaxed/simple;
	bh=OIGZAbKguExB615rcm38f47xspcM8AfBwckK6G8NEmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lsEZ7U0MMqgZmjzW0jVL7WZGBGUcY9DJ4zFff1tKbyE1pbHlqLT/hWBFv/4RaRGDLMUmc7P6t1eP01kFYsE3SUmegerDRsoSvDRlesi8fg4eTF0qldqSg1h3biBV90T1Ep/pCvQV2IpINlFZM5I80oqKQP9myQ8nZ70J638NmP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kr5r+DXs; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kr5r+DXs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6/+JuydLXKB4UHs/i3kQI2xlOZ7yUVjii8sn3kROHN2jy8eIMboW4Gz5TMEyac0+MNijNKwzl7WKk6AhFGVqKRyrGWMqP1BArGXSHqGYWuUpqVtpVtPk5Rx5DIRcvIaLUkZzov1ZhfW89g6cY/Aorib3lN399rK5qQL3mo/CTX7vX6x6Q7EEP18ScP2XU9Np2dS9IyHXXO+iJUQf4BBCoONsK+b+J0jLOfIzZ7MdgljxSG73bV+dxpoRmCCEcUWcE0vvpQkHlTA20ReayMWUrrkaKNS4pfIGDKK0CJQ1mG+K+xOzFlfaWoZOxJWx01cAlcfOdGcJ5402F/g6aoT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n3lWhmFP8HCFP5B420NemsfAU3i6DMfcXf97qeHk3k=;
 b=ZV3bnwa40sC3ocuopu+Hy/q0NYtQfxJJ8y89/qTQWQsyLgg2gtbTax7fmJREPdwXyY4h0NQgYwMw9wjUZmw52c2Pq5Q2FRCl0pAknugTuXmrkOKhW1KqW54gR2X+vtjSlGGgfvHWKj4HgagCb6SB+rOJ8fkxxxKz6ItLwvv3DbzhtlwlylsP3jGtMc8+Tw+D3eR37yxF2T12j0o7+hlONRTt91nS9/JwjjOBqzPcoJD33CQlLAgXIE1rqa1eDiwJHS27pyyY1VXcSRE1oImYMJGk8NvgmYF2DgetDgT/u1+Xi0IuKdsGui+USsHjFFuDZJyLfnvHqPxO8LfWti8PvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n3lWhmFP8HCFP5B420NemsfAU3i6DMfcXf97qeHk3k=;
 b=kr5r+DXsCyQSJgGxJDJ+mZb/qOecPIzQOL5ihixFgFxoeQ1kbU7A72pUJHPzI5P8HMrAi2VwDIjARdmOolAvCKAYk4f3/NDklK8MrlDPGtVnyhtx9jYpxfqZXqDpjlI0kfV3S/oevlCZSxdG1jD8zz9VU3pp79isHD8ENQhcM93ZsnUGagjJUQXA9Z1CBRH67ylMQk7Z7DC19lZZTceX+zaK76OqEOJmOo7PIkd4RXrNFSgatZpq1j8cxIXkzuz6yghszwHNHjNX3nUnJWTU9LGQmr6imI6S+7cAYyPSfDVbxrOnHj9BEsoc96oiDnEwQfKydqqZ1iXnKDhP09JlTQ==
Received: from PH8PR20CA0009.namprd20.prod.outlook.com (2603:10b6:510:23c::23)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:09:37 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::a9) by PH8PR20CA0009.outlook.office365.com
 (2603:10b6:510:23c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 08:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 08:09:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 01:09:19 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 01:09:12 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v3 0/4] PCI: endpoint: Add Tegra194/234 BAR layout and pci_endpoint_test support
Date: Tue, 24 Mar 2026 13:38:53 +0530
Message-ID: <20260324080857.916263-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc2c292-1210-4fa4-2b81-08de897cb0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|921020|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AU9F4VrhYRxsORwRwG1VvGJoWhVl+ryOLszBip9G1A+hh6FBjTkh1S9kHT7wj0awpygWtw+e3C6KI2tcqIFvjkvwMbj+Bjg/IMZ/W4r6HBUdBYBUuCMxLBaKiEjWSNooXQ2qyuEYbss/kNQpR1DS2R4HocrU0tTIIEbX2ZVK5n331mcb7ovrD996u0jLZWL53CzYYqUr7w4zmvcAd7gpyfwzEAIBc7VwlyUtwCj0B9wovHi5Ic2yGmabyA27JuylKLMLI6U6BctTmfl3tJ1rUlgiuDoWgrZr11//rkG0T1tkb5mu82dzlI2bnZYvF3hzi19brDrtsaJIVf/3BFGdTX25oLF0N1r7F0sMspvf/DTJSzlgziwci59LNM9t03321/5KdIbpzDnaWDrkIEc3/xKdAyDN7TwX7P9S3OiRnjAUVPx529Z96aBPpqylwgGqp1slG6TTAajuCxRfiXy2xvW0OFtPE22Ctr5t+cy2WNz7xnY9WlZvqYONZUaXBiO0sCAvAFb9gqPpCexXG/CUB3FryGmb9p22R5p9YlSs1BwNcyaf/b00CAx6yhPxwjDcdIE3tyXdA1zvnDvbBjMbH6kuGi4ilCbdfxEaIZ0Bhw442qiMi2YwrfNcprRToVz0bMvI7UDHtQljLE8A5kzxfDlUUOlVIcdG99mhZFS2A4mUabWYClQAZtOn6+thhytEDX4v25GJhi/s0xkmZ+CAZMJSmgrfmBZ/DVqA80Bya+o6CvHCbs/mLsUXH+09DGZEaxt8E6bC4q/Dss9602x+U27Lh4XZgzOndn0NQuDcWFueiq8PlpU8KgNiIhJNtKh55JA53ie/bCmHEsU1pywJJA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(921020)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KVow5/x1UpRki/P1nGWYnNKT4qKwj5JZJj3AkXeNYfTsVNf/fxfMSlo75t/iNDlGPO+cPrN4tgFXXjk1hMBT5P43flgnlI2o6xom7YyNAPQeB/dX37i3vmBakPL8xzCERYBRGvNBhQg5rg5myUDIeJgipqxR27yV9zBCHtL+osP9zwGNYbn0hy9ifltyQ6jW/5y4anAxeXQZyRww7B+MyS3WSAlZqJ29lsqgxivOPO9EqfCRCW7s/qpGrstAYlU2QDbtkGlpQncs7PpY1l/V7rMK4LcfbivxtmzLffyMNqQD+5Mz5Q4LYyYRs8RNVQWm5RHwRX2VMD1HgTWsbV6O+47DG8Df+doODGrLNWtaCr//RwyxEno0fOo3Feh9kOAGRIdIAiZtd6UzaR8PTuBaRNOyJ2oqvoiBYiSHdDR17Aibupwx5Q3QFfFZsyu581eD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:09:37.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc2c292-1210-4fa4-2b81-08de897cb0fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

This series is on top of https://lore.kernel.org/linux-pci/20260312130229.2282001-12-cassel@kernel.org/T/#u

This series wires up Tegra194 and Tegra234 PCI endpoint controllers to the
shared PCI endpoint and test infrastructure:

1. Add a new reserved-region type for MSI-X (Table and PBA) so EPC drivers
   can describe hardware-owned MSI-X regions behind a BAR_RESERVED BAR.

2. Make Tegra194 BAR0 programmable and drop the 1MB fixed size so EPF
   drivers can use it with arbitrary sizes via the existing DBI2 BAR
   programmable path.

3. Expose Tegra194 BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED with
   the appropriate reserved subregions (MSI-X 128KB, DMA 4KB), keeping
   CONSECUTIVE_BAR_TEST working while allowing the host to use these BARs.

4. Add Tegra194 and Tegra234 to the pci_endpoint_test device table so the
   endpoint test driver can bind and run on these controllers.

Tested with pci_endpoint_test on Tegra194/Tegra234 endpoint.

./pci_endpoint_test -f pci_ep_bar -f pci_ep_basic -v memcpy -T COPY_TEST -V dma
TAP version 13
1..13
# Starting 13 tests from 8 test cases.
#  RUN           pci_ep_bar.BAR0.BAR_TEST ...
#            OK  pci_ep_bar.BAR0.BAR_TEST
ok 1 pci_ep_bar.BAR0.BAR_TEST
#  RUN           pci_ep_bar.BAR1.BAR_TEST ...
#      SKIP      BAR is disabled
#            OK  pci_ep_bar.BAR1.BAR_TEST
ok 2 pci_ep_bar.BAR1.BAR_TEST # SKIP BAR is disabled
#  RUN           pci_ep_bar.BAR2.BAR_TEST ...
#      SKIP      BAR is reserved
#            OK  pci_ep_bar.BAR2.BAR_TEST
ok 3 pci_ep_bar.BAR2.BAR_TEST # SKIP BAR is reserved
#  RUN           pci_ep_bar.BAR3.BAR_TEST ...
#      SKIP      BAR is disabled
#            OK  pci_ep_bar.BAR3.BAR_TEST
ok 4 pci_ep_bar.BAR3.BAR_TEST # SKIP BAR is disabled
#  RUN           pci_ep_bar.BAR4.BAR_TEST ...
#      SKIP      BAR is reserved
#            OK  pci_ep_bar.BAR4.BAR_TEST
ok 5 pci_ep_bar.BAR4.BAR_TEST # SKIP BAR is reserved
#  RUN           pci_ep_bar.BAR5.BAR_TEST ...
#      SKIP      BAR is disabled
#            OK  pci_ep_bar.BAR5.BAR_TEST
ok 6 pci_ep_bar.BAR5.BAR_TEST # SKIP BAR is disabled
#  RUN           pci_ep_basic.CONSECUTIVE_BAR_TEST ...
#            OK  pci_ep_basic.CONSECUTIVE_BAR_TEST
ok 7 pci_ep_basic.CONSECUTIVE_BAR_TEST
#  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
#            OK  pci_ep_basic.LEGACY_IRQ_TEST
ok 8 pci_ep_basic.LEGACY_IRQ_TEST
#  RUN           pci_ep_basic.MSI_TEST ...
#      SKIP      MSI17 is disabled
#            OK  pci_ep_basic.MSI_TEST
ok 9 pci_ep_basic.MSI_TEST # SKIP MSI17 is disabled
#  RUN           pci_ep_basic.MSIX_TEST ...
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X1
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X2
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X3
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X4
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X5
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X6
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X7
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X8
#      SKIP      MSI-X9 is disabled
#            OK  pci_ep_basic.MSIX_TEST
ok 10 pci_ep_basic.MSIX_TEST # SKIP MSI-X9 is disabled
#  RUN           pci_ep_data_transfer.memcpy.READ_TEST ...
#            OK  pci_ep_data_transfer.memcpy.READ_TEST
ok 11 pci_ep_data_transfer.memcpy.READ_TEST
#  RUN           pci_ep_data_transfer.memcpy.WRITE_TEST ...
#            OK  pci_ep_data_transfer.memcpy.WRITE_TEST
ok 12 pci_ep_data_transfer.memcpy.WRITE_TEST
#  RUN           pci_ep_data_transfer.memcpy.COPY_TEST ...
#            OK  pci_ep_data_transfer.memcpy.COPY_TEST
ok 13 pci_ep_data_transfer.memcpy.COPY_TEST
# PASSED: 13 / 13 tests passed.
# 7 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:7 error:0

lspci output displays all three BARs with this series,

0005:01:00.0 Unassigned class [ff00]: NVIDIA Corporation Device 229b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 165
        IOMMU group: 13
        Region 0: Memory at 2b28001000 (64-bit, non-prefetchable) [size=256]
        Region 2: Memory at 2800000000 (64-bit, prefetchable) [size=128K]
        Region 4: Memory at 2b28000000 (64-bit, non-prefetchable) [size=4K]

Manikanta Maddireddy (4):
  PCI: endpoint: Add reserved region type for MSI-X Table and PBA
  PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
  PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit
    BAR_RESERVED
  misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table
    entries

 drivers/misc/pci_endpoint_test.c           |  5 +++
 drivers/pci/controller/dwc/pcie-tegra194.c | 44 +++++++++++++++++++---
 include/linux/pci-epc.h                    |  4 ++
 3 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.34.1

