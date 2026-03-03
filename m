Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F4385527;
	Tue,  3 Mar 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521146; cv=fail; b=dyabfcWOHQEWyZyd0CEikTZYQNoGptJnW3iO5wHD6lhdHqOZUDxMGgF9ZUEJWBQqJsGLkObnJFGRKBhj6PCmK1oeO1LFWVLzzrME0EZi6bGFgaKw02G/l/5vr+0U6yWUqjDC/r7tHOiOIaWspOo/UpupvirfSQebG3jNLMcQfYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521146; c=relaxed/simple;
	bh=BkLxC7nwkXsDLRoNPNs0cFzZXEi0nXGEcSojVM2+mFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Efr1EaUUHfjxn9TKCEqnYGJfRrLgK77Yy7Y8yh0iSAQn2kcNnBaHUdNCbuPbYfqjt1vVelwCmude/s8x30F0rZ0DGixqIDdlhXmaBm5kmYzODR8dvwcBcTKLRimbUJHAJ3crVM1R2Mdf+iu7vBC0dDtfXHpage1+PBTviMmkp5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s153CVem; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s153CVem"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2ZzySmvL4L5AxTXucuAmFukUwDRaQIAu2FZh8C91BQvh7/rjNARg+pabV1VOW0E40kUDuwH0Z1vPAZ9nZ1+M85TcRqUSNAjVCHs68fH0AEvLaFYT6j1NC3QoNGo0jBV6TJM6VphMcI9tND1hjJ45QHVIx+blkB0ollklNJpWQ+IvXTFlYPKEGhePEmqioBuX456lewrgkBvMlJUVsEwfqRH4XUyZ+db4Dje6m0nJ366we9TcnSzBBD11kLtXO1vt4UJoMuv2jQDm9wxQwpLlRZ/iTm4q9w1mXGv0o/YDBy3/K/ByJkzs8hy5oESbfKyocZovPI1kkebgZS++EP2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPgeWDnq1vAmPSghqLRmtlAs29WZUcj5WXZH1QKhi84=;
 b=ALe+Kl4sikuNtcPEyZxBw8wRE5Jdh2+G/MBsDSoLuLezucOaj7nqV/bZvPtBzOBCS7Rf6mr2RoGnINQV/UTcyK7/eZOZp7tP2RrdaspJ/BF5cwTUwUVC7cbMfW4sWDJ+nTY9SEvB/aP24kUkcPkmRhWHBV8/6GuJc8mbRK5CVAIK6V9hLpzZhDbfO9ceb0IzmH+RIfX13955bt0At1bJr7GH2vZaHt04ioSCjppiSflab2SiY102d2jp4Zy4vqTrI5f07ww8vtqoWpYf3yAtau1q7GBnZewKBlyu6GBVfN3QJB72Zi+PEf5l9pcskEf5+G2AsOZadITyUx5H+nyDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPgeWDnq1vAmPSghqLRmtlAs29WZUcj5WXZH1QKhi84=;
 b=s153CVem0a4bAFRos3cuWMnLw9cafJl5HVxYfP7NE1Jo3AamS+IwNnWqTfvXxRly+jUnUck6olgv/9dIGbPSYnV4Y2qfDBIYn5nPYzfP7W2fGB0xTtbSmjx0Zb39T2+1QFCS0Etl7447V+SaEBt9As72k/SmXN+YUQdT53ROoiUR/J5yQNhlJe8qPBv78s3vimjFcz5w0axP9n402s58OsPds6/PwIENXUN4tO1pNUaFxOAqE+XUx8aiShia/meoUhjYC8WM4as4wNn0tStVLYJz0dalr8jXIPTQ4tLqVrKOBuoL7MyXHDh2HArE+A5FrqpKlsasX/g8ytiQWs/D6Q==
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:58:59 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::6) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 06:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:58:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:58:39 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:58:32 -0800
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
Subject: [PATCH v7 3/9] PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
Date: Tue, 3 Mar 2026 12:27:52 +0530
Message-ID: <20260303065758.2364340-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: b211d869-5d18-443c-f840-08de78f2588d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	eQsGKL21+53ncz2QE7IdBxUMwsAH/Yy3Z3Gg2I6EJUjWxndeHw/VBleCJeJHgVRpdLj63oAEJ0jIs/PniYm8UTGfmnAlGZTQ0cLhdB0d8QYJp3SWU9olzE46fss1gWCxf/Q3GWasrnfwPcdbO6zBqIJzlcDpI8OzM0Ik+pSJ7RNgqbN38KYSUlBLRwF0yO4kxp0ztcuhqW3SJZp0sCOk0bURq+S7KAsOjWShLvtl82jvRJPTBusTE/g3u06NYv1bdHvaZf/YFODgeLatMEElTgUHVDF+u2yyO7HfnCHW6JO7XYbFbnR4Fn7lFQ0tJRWFo8Ob/SmSvyVnGQW8YU/2/V6H1l77TfZojW6O27Q1laMwI2OlnZ0v76ZcZ8U5LJ6vCEKCqovhRU6vE2pBQi0XrawotmbG7ZzdkHwJrP50qhDu8pfv8WtCImRKNrmr0dMAm/cZU37800LuVPZEksKoRW8CCnRaDPA2KNdhZOdQfFf616kJUD7O+lYmilA5vzb+IMGeuz8VmykcQk8qWrje2dwSAvTM1IIsJjRsfPt13EmM9Fw5eOd2mPnyU62/gW3TNKpcM/Yv9bo9Y0EOU4jsNZkQ+k3GUFhtyfhtoPhU72hKAqRgb1J6gfvjqXZ5haiYegrYUKqBRDt6pwgEdOoEBTQBReVs2M9hDoMwqFSueweKfstR38bkLnBOnrrtYZq/YMDQAcl0vUSsd5oNikgdnCWoV4QIC4zfgKZTBtHGw10KRzjoT3jcgp1h+9ikaKpGiDmBaoVL9atajzeCYIdN90fMKlMa1JIA0KZsIttuYSf1oz/JPx/R2d2ivENZO0CumX/a2hIm5BJNQNxrrdm7kIp1f6CQYy7uCfBMAPP9GS0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ch6pTlSuzg/fvUFToRmSD/JO+ZbROe7HHmC6eH4/E0jF4jr07KxYH/TdTnQH6+e0mkl3N4EC47cr1oTWC7e27NIDH7pGbmMCRJVzRhwG29DUE99gNI58uezDZ3m3Ik07JfIWSmqNsnh2eEVUmCaNEA47qy5/LRHn6zrqc7nFkTd7er+9dfEbtmJq0+gN0PmEtxy29TK73Zek1x6oJ72XYYql2xEvGSAi0490kfa6WI7Tu6+8gWRBHmxHGGedhMOmb8YgCyEi8iT5VYYOGUl1iJC4qGL+shpoBgHhaQ8xgu8zgHKz4UfWVkMn7v56aUjW7r5SNA7u3dDTTQW3X2Oi1kb5fRQ7tubY4N79/17vcxewhWH20j/kIuKtOQwpO9SqAAYmXRz5/D4zL+JvvNXs1VWjRLPHTrxMPi1Fco5dRZyDUsGdChwyQ5MGxpjsjZYF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:58:59.4033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b211d869-5d18-443c-f840-08de78f2588d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126

From: Vidya Sagar <vidyas@nvidia.com>

The Tegra PCIe Endpoint controller has a single interrupt line that is
shared between multiple interrupt sources:
1. PCIe link state events (link up, hot reset done)
2. Configuration space events (Bus Master Enable changes)
3. DMA completion events

Currently, the interrupt is registered with IRQF_ONESHOT, which keeps the
interrupt line masked until the threaded handler completes. This prevents
the DMA driver from sharing the same interrupt line, as the DMA completion
interrupts would be blocked while the threaded handler processes link state
events.

Removing IRQF_ONESHOT is safe for the following reasons:

1. The hard IRQ handler (tegra_pcie_ep_hard_irq) properly acknowledges and
   clears all interrupt status bits in hardware before returning. This
   prevents interrupt storms and ensures the interrupt controller can
   re-enable the interrupt line immediately.

2. The hard IRQ handler explicitly checks for DMA interrupts
   (APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK) and marks them as handled,
   allowing the DMA driver's handler to process them separately.

3. The threaded handler (tegra_pcie_ep_irq_thread) only processes link-up
   notifications and LTR message sending. These operations don't conflict
   with DMA interrupt processing and don't require the interrupt line to
   remain masked.

This change enables the DMA driver to share the interrupt line with the
PCIe Endpoint driver, allowing both drivers to process their respective
events without blocking each other.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V6 -> V7: None
Changes V1 -> V6: Updated commit message

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 980988b7499c..352412680b4d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2227,7 +2227,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = devm_request_threaded_irq(dev, pp->irq,
 						tegra_pcie_ep_hard_irq,
 						tegra_pcie_ep_irq_thread,
-						IRQF_SHARED | IRQF_ONESHOT,
+						IRQF_SHARED,
 						"tegra-pcie-ep-intr", pcie);
 		if (ret) {
 			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
-- 
2.34.1

