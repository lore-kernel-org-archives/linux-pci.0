Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949962BE057;
	Tue,  3 Mar 2026 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522449; cv=fail; b=Q8ENYSMf6Bn6arRSa8g9cngCbZeDbkNtoBnSooY1jCdoSNNYp3F8BhDGSCCR5LlLlS7vzR6e7r6VKSNf6DGWxrD9ClLZvv4Jpc6iYF2RLLiVc/kAa1duD+5iQgPUGgkcKWs7tPvdAhskYzLjYU+YDHbspyius2aoXkx6Ik66U7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522449; c=relaxed/simple;
	bh=ICEYmoSjgfxdhGczBw0tgaPlM8zWOF6SRjCU/p+IUcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AnTiyxnJChKPkpDlCKwkrSz/PpHFYm/uk61dhdjwmvubBU1JFh6a83iWnTtMzkNnNL2to0IH010dto+/IiMeTo5/dm1cEMAMsg3Impexx0iZ2AXozGNcJj4UveZCwIG2VTqopIfFyQgb/Vw69yw56yEkm3zhDLlptMBCmxPJw38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lf+uXxZU; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lf+uXxZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDvEzg7IlILY6UIM4VUaJ8SaYNgd36bhWWXwd0RfEBQPqKP2WQPXG1Pnl7dcaGQRQwNttX4YoWIhi9xKY0YnGwZbRuoT54kVbMEUOWODTEMwYRMDt4pKZfWOH0r1CARUuYqUfaQmzRQfkkps2HwVHoZeCPXpU5Nz32blv5vrrEFC1c/gzxrettkFerrl1TZj5vp6Xy56ONDEZNWcELz/cnvWfUdwxVynC6bFirgVyfOT5QWAdY3TUzhBx1ixXG7GIHLE67LorplAVpyt673UMo9SPuBS/zhJvRM8YaZ6nzEWt2Of+IQWi92/bqL14Y7KJ+ICFkHs/zthgsOXzBwxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjrX7pWNMwZWOlZHiI2/teCPoy4np7gOPsAMOb9/5uE=;
 b=pVraFNFd1qDsbDuSpCHhukM+E5Unou/bUmHwIrmJ1ioGVBRscUSkDDQe6jto7tOaD4G3CcirsHbS2KWm5/tjaPSy6EDa15FwS8oD3Y43gpvt+e3DDKSfSQF3mUkivuZDwQHnSPa0BxFmAcwb2zo5OMG67vfm45t4wWjM/dIe7oJUiaKp1cm42xjOO1t+CCZLUKmJfu+JSAYum61UfDaeUG3PW1YiljmhqgAqh/t9dEBNXE2LXjp80F5JU94iS4uVTsFzoIF0bxTODEMN3MlCau5YRc1mIy9GPdtT0n5/y4rcix4MuKitmu85Bo09vSyI/DOyQIgarOZDH1lyICbxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjrX7pWNMwZWOlZHiI2/teCPoy4np7gOPsAMOb9/5uE=;
 b=lf+uXxZUE2M9ufcIJsA3+XEeN/xVvvrc3+qMPfPS+5lB1hOmz9pHxKxp5lyLPjj8qWewy/DZRywQXrH1+gfXc9XUfzeIW/LKHsy0tU+olFrXMgE/D3gzPADBG5kSlI71qSP9bPmquY4A6g4tfL9EW6KJZUwa3pgdjc4LdaXVUNeTwsEs9EJgtSvH3IV/DrpfHK793PGOs7xi+RFp2Mt6dMnsSwB0GHAusOnbaSjTa5NN2mej0w9kXNvE49P4k+AY3eVYd22Ixk6TMl/EX2uZNcGQmWdn3SdGK1hxyk2oXn5nmvtOOpCUlkGmCgCXvzvxo3H+Ox6cmqjae+esCjW3Zg==
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 07:20:44 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::99) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 07:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 07:20:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 23:20:29 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 23:20:23 -0800
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
Subject: [PATCH v2 0/5] PCI: endpoint: Add Tegra194/234 BAR layout and pci_endpoint_test support
Date: Tue, 3 Mar 2026 12:49:59 +0530
Message-ID: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: c538d6e7-7796-4d12-1e09-08de78f56202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	9YIOWb+4WcKG3ae6DPN7aAVgW4fjcBq9CF5KcYj1FsqmWo4DEezQ0GW8b7DH+bs4AGxq4SrJoollnhRmdd1HSj+1IdT2i6EihmRneQhKPY3EBWZ+IVh4jTX4Fz43n+kDCQATaZnWqoXTg0NLt1YzihPw7LyplKZiY4shKt2hzZIbAYknankzDVblEJ1amZjOA5A3PH0QpRfpvcUK1Y0E1+IxFez9lNaQbUjtG9m6RaiCYm2Er7vARF/3NZYdHQa5d0aX+qenytikdr+YeERC9lwu2ElFvhxi67vIzGG3OfFZX2S98zQNQFLX9E2hbpv+U1pQE9qu6X+bRbBWrqqNZ/FN+alFx2hg8teK4LwB6CXhav2UCV0QmzLN1O3tjyX8wfqOh9IGTjbB4mOLQYO96HwB1UdjwHfDqsFn0khHTTjp7y1g472Hte8YHvfuf5HK0I0r1+wMqw9e/UP93dmM3zeHbauCIa1OKxo5f4x7Te2cJV00UDObMPp7mwNoK+9dBBCRHrot1YeYSypYnXVv3Licgq4AwSR5dkZYBauDMWIXVvcLFqt1LD3pVHE//glQ/WjbE8tzjaw2A8isN4RHzy8o+6K+DPUBGV6EUB8UvQfNTJQoR1jOWNUC8MynlDCGibNqjCfuAF9qLS9OBGI0iKK03ffXopKJEocJRwY/AWAn4JfYHB4azwuweoZ9o23ON9BDrYcYARN0OrN5DS9/MBAeeUvPiaRJFYGgVds/w2SX3AzNqIhScf9fQxIsdO7rEgEBt38ktqxAC9qJl7OsOclhxjw+FvQW30N5aCDh6zuood0kNUHao+k60oDtvGUm9osTKn6p5GFOol+8aZW9Ul8NcBuRACCYibtlDBS/8Y0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HIG8GNe4OUbmxQVtSNPMTBwUm6DQuBP3dgw+zRgkv9hD5R/ld3QBaZSGX6e8LUugkhTzJ23rzl1zoFCobSC42mo4zEeZirJHqrUwUtSd8+ugAAKRMFGEHhQpxszqhKbBUuvZKhYy5AfhQuCFNYPe50iMNYE+zamVl2GqL0yY8Kh0FHcxDBMORJ5csIAnD45qZdkpPkXlxwz5hhAUpLFOYD1ePrH8ncqOOiHkw+VOeifN4eXXeAsx3F18iCJjiS9eOMuhRvX5ssCIJNVOCavNMoN0jK0T2Q4Mob/Xj6OHgkxnuHWsW9gIj3sgmWAjDj07pFRUPAL6g5XLSPqyU3zwMBW1O2NGyDfpUuj7lBRBQnzqvgSWStByj4c5G0fYWfmW6vb3PaMFMdKdLlGDPS+TbLwTd28vDjlFPuKfKCveIo4aRfKkMUJiwfpkNgUBZLgL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:20:43.8294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c538d6e7-7796-4d12-1e09-08de78f56202
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624

This series is on top of https://lore.kernel.org/linux-pci/20260217212707.2450423-11-cassel@kernel.org/T/#u

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

Manikanta Maddireddy (5):
  PCI: endpoint: Add reserved region type for MSI-X Table and PBA
  PCI: endpoint: Allow only_64bit on BAR_RESERVED
  PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
  PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit
    BAR_RESERVED
  misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table
    entries

 drivers/misc/pci_endpoint_test.c           |  7 ++++
 drivers/pci/controller/dwc/pcie-tegra194.c | 46 +++++++++++++++++++---
 include/linux/pci-epc.h                    |  9 ++---
 3 files changed, 51 insertions(+), 11 deletions(-)

-- 
2.34.1

