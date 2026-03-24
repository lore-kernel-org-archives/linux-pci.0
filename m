Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459B3B6BF9;
	Tue, 24 Mar 2026 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379472; cv=fail; b=ugmFsnUxHnBf7D/FkriSn7PJNnnOGhjEk5+HhVzM9MFe7d7J9bE4vikqlUiY6jD/+iKpZrKYLd1PE0EcJbrLlPtViIP5fpUga1MD53xXGVFNEw6Qi1NkLL/OzB0TTRGdtfVgm3u+AM77ExvSaNk5ea7wp+alIjUHs7Ic/Rhop8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379472; c=relaxed/simple;
	bh=kEhDOlmGEhixShGDK866qYFUjcGwh7HZAD4KPYBnp/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMlu/EFOxbYU2Ihll2UsF/bPudklB0PnpQpCsAteNqKVZCENEDSnxQPLzQJFcB1OhsQVeE7ZD616YZ9fBGuq/soD/xhcRFqClF9zTSjFfuhx3Z8IkTRxzXFCFiydMakQw7J0EqeFzp9EZyoxaFiJqsMwKNuEZ9I1c5EUxdpDy+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OSwjApih; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OSwjApih"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF4h2bt7+ArPfmgKgGHkXfYjHvmYBwsKukuWZPYFmeqV1c7sXlAMaSVdE0l9AfNo5sdHlS+I1Bb0AQi2sA269ghtm5glwgUqi3kXEvtrkyFAgf50EGeRcmn0uHLe31UnQ+VYjgRKOF/fFIPlc5QL+YzKewfkjTBiFuymnXtdq9kbO9JhvYk448Ll7FSp+r2UlK7qv9+I0NCx7luGf/saNCES9YawarT03oV/OYO8B8LhBX29tThE0REcryOV+nSB/Ah6Ce79vdy7MSpGNl2JsUrmO/n6f2cFiH1yuhAUPFHxOcMWfX9FHL4LpzwuEt6jd6VSiBa8X+UNR4JOgejGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgdFrPsO4srfnkMT7p7L2TKB4+aWbSkIBlPkk3cwhmg=;
 b=xUc+SAlP9ycZMG+T2H67O9EiN8hijVut0iryhZAIZv+6gUdaKmIqzr5SUq7cvklkQW8Z/T8LV1hfxk+zpFS5B8tITFohUfUY1UgtoFIr03yMygf32/XbTTMtrL/wcxLU2KYfpCgppPf2YbseNuB5MZnZ8kXSzDuPbMMUF15hB0eYuZrzgPUFi/2jyI/Rr8a8PziyfwAdgOQrWABhExheNJ925BJTmQDk1QRfallb3trF5EstfvKNREAMxd3Fc8lFVlEFTIdg5BOOoGeQAy4Ou/9TaTh6iPhkQHEM5NsdO2sOvaeuD5dc9Adc/pOUIZpVuXSGd5hsXC+LLgTvRvY2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgdFrPsO4srfnkMT7p7L2TKB4+aWbSkIBlPkk3cwhmg=;
 b=OSwjApih3vJRxYnlPAApTzRtPsLiWgc3707aJiug8l42zKp00WL1NMAlOMOVa0kDi0mz0xazGRtbCaJirGwVyVQy+9VJSPLpeofLkYDpXMYQxsTaGALtxeFrCAU/ZAJAUPqJMe/uIx/bkDx6ZRklulHwEg48zU2xFChVBX7/IvDG83akpNFf/MqqfjOdo2WEnIlSO2yYcIkssv7ZK0Yz+y7WIDTye4t+NPM40Qzc3v+/b5wVSGjO2d/tqGg2EYY+no1/cZcXXZDkGHPNOzQXIIs5nddHA0Sdknp2cSvYmwK2V4nMRpWYn5Z+bvcOWSvj/JL/48gV32okYH7tKcyLxw==
Received: from CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::27)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:11:00 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::8e) by CH0P221CA0044.outlook.office365.com
 (2603:10b6:610:11d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:10:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:10:41 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:10:35 -0700
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
Subject: [PATCH v8 3/9] PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
Date: Wed, 25 Mar 2026 00:39:54 +0530
Message-ID: <20260324191000.1095768-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d4659b-f99b-4c4e-cd69-08de89d915cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zaZuCtwAHCuakDd4rca8wnOXUMgMVNogzwytFnGvpUMY9B9cq/s9UDXr+SFQvsiSyfN/wvq3pLvvTQOVsL3QBwYZVfsB1FrOAnKFPORAVVG6V+tw56TPN8W7RIOUkfVRhBnHL2r+66E0Lt5DQ9EqEeMppKPsI5wi1PDIXYVKCxFQvbJGgBigZcabol6i7Yl+V6lTCNJmyngAMJ0FEVW/C5SJwdvx+k348LQx2sx/usH26hN1TBB4drwmX91wd5Mzdu8cnRDsEbMlDBbDclTad3fgr3+Rj+467GLER/7J6ld65TDOpbCkWpWKg/O/ZlxR6NuSqtB9YwyyKX86+QTaU3Sith0ImnzeHnsvxjEzvc7J2NqYzA7JwzqtqeRejy7RlPsaKHW9ZoU7sF/OurZUOJjiWxBLy+fm5SVksP7FbhukuX+14jW06kDDrk2W3SCIgJ1d8LRl7XMK8bkBSEAk8ehA8p+mYniPKuo4rIRFZ+N7xgXRhiVnEfjD/c1V7k97aVE/ZLmXbRFT8UO6Bmo0S6Vp2nI3H8KhChJe3QwXExBHw4Vkmhl+RLG/jPqDt9l8QE/ksuCTikN0fzZmZxxK+Tc25vi0haGpq0JbvP1GJrk6OeZMk1BaxagP4jcipdz6IrC8dTPXf0suLw/+ZIqDYMYioM7rMUxit/KOtOqKhD52Pv3MjrMq2yTdhgttbOsfoYFnrY4lfBW4xYctup9/o0VMN3QkcOBvjyPO4d/QIyZaOB3zyMgIVCS7isrxJcnaTRjInb4OW5FZ/DurDG0A+f5JL7qwgkKumu/dZIIzMkFOiml5JmJvxTTt8XkeuTiD
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0Vr7k+vOyWtJTeEWHHmvo9LKGa/k3eKUb8tyJmVKKVAawHjCnY3Q13xOl1+XCsyo4LC/7idMyjJwDQBuYWtIntWxaI3OIgqfvGyqnRDw3Y8qrukbg5kPZdbEoIIat0P8tkjgxVpi9ahLEe+I9UYPTtb3AOMCgTSRJyJOyAWWKk7WBdzpNRkCub3qpwFSP/ljzE8Nq8p1vg4c2vNxMF/cRSazYOtbYfVbxFhnL616HeFZlc93NEpBKB1CIMjI5DBYUwMJwRSzkvttAMH8rOzO5XuQW2eC/rty72E5mRU4kIWMRJKK3jcLb8NyUOoEw1sQEXIYJ/LSKR1T8o4iWp9BOofuEc5/dpy8WQYuUja3exNKra6GE6spewx421DHHj0cjNfI598VpltmIRSiJRXeYiZLQXAsy2IBHiwz7iLXI4KIRjX8vRak1h/hsBFCOoiS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:10:59.8619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d4659b-f99b-4c4e-cd69-08de89d915cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765

From: Vidya Sagar <vidyas@nvidia.com>

The Tegra PCIe Endpoint controller has a single interrupt line that is
shared between multiple interrupt sources:
1. PCIe link state events (link up, hot reset done)
2. Configuration space events (Bus Master Enable changes)
3. DMA completion events

The interrupt is currently registered with IRQF_ONESHOT, which keeps the
interrupt line masked until the threaded handler completes. That blocks
processing of DMA completion events (and other sources) while the
threaded handler runs.

Removing IRQF_ONESHOT is safe for the following reasons:

1. The hard IRQ handler (tegra_pcie_ep_hard_irq) properly acknowledges and
   clears all interrupt status bits in hardware before returning. This
   prevents interrupt storms and ensures the interrupt controller can
   re-enable the interrupt line immediately.

2. A follow-up patch adds handling in the hard IRQ for DMA completion
   events. Dropping IRQF_ONESHOT is required so the line is unmasked
   after the hard IRQ returns and those events can be serviced without
   being blocked by the threaded handler.

3. The threaded handler (tegra_pcie_ep_irq_thread) only processes link-up
   notifications and LTR message sending. These operations don't conflict
   with DMA interrupt processing and don't require the interrupt line to
   remain masked.

This change enables both DMA driver and Endpoint controller driver to share
the interrupt line without blocking each other.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Fix commit message
Changes V6 -> V7: None
Changes V1 -> V6: Updated commit message

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 37fcac55838f..63173f7af62b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2243,7 +2243,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
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

