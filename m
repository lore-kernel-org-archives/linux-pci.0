Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B713307AF2;
	Wed, 18 Mar 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871281; cv=fail; b=Td/BA91SJT0QF2ufkr8jC45Szq+ibgaiWS8cS9wpZAkCL5ZxPcDd4qTwJ0zgGvgamfTqkwq8BpKLGIJ5RIQrd8N/E5bPBoFHlCb4LnDT4BHceeHBWxb7hepkNiIQHgxtrbJfVf60TsEnWpNsIKnMzA3rQFvPL7zXyWC1Hd6tz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871281; c=relaxed/simple;
	bh=jfd9fazQDuMCD6xyjATZtEIBoY9/M7y4UJukq670Jmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EgXcgle6qllJHAAq5VPxaOpo20+dySA2l2A8+1r5JpKYu0gz8cJ0/lWoDaLQD0yulWMXsSYqyye05Y+fxZNWRXSQg45RKjcaSV7+1DQW2Pln5WfDMKrS8/ss398RKTQa2ZehxLZf3QGvhBz5plOUIo5l83KcQCCp7Vx4124xCxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usK5OZ7i; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usK5OZ7i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2Xv6bQ8ZYA4+zApB+yhdfOvCjV5hgKl1HBsWGcjKI5CU7OW9UkyPSaR9iLypiVAE5BCpz04PAFbBf8hv4LKYVaiL4ws5hXH1/kW5mHlz6onzcLHDh+LW0oYMLa0aysuLciGk4M6SG4JWzz5ocYgKHW1C363U5CVK2D3J63Y2/w9XkM1FthoMjb8EcnT4XDLeccWzUZQ3vlQIFSy9eyBq1c9GGB6EA9wjl82C5z7vEtbvuNL+JkM3TgvvyNEDs5XNpbTwcBNG75A6+/ZtsrUkZT5coD48j6U9CPykA8u0NfdVqYeuQqQRR39xTo/Q6PAXfp410309LziNESVFFTtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRHkHks2laEcW8Fs71/oIWHZR3bYGMnxAkkXYwfH6Fc=;
 b=CMqFWTJfdd3Sg7itVIaIw6y02bGgaxe1kTcR/y2bMFUqivoxWs8ukR/G8oCQ5Hbnd7RKXvflsa+QX3VEpEF+kCIQ3Q4/ft8KAzBaBvzg1JFQ5aiOjCvRskDVSaIcZhbqFTpv4TSxAmvZQbYiLAuv2Ob20Ans9dtVnRFy9GOXAqhtkVFpFRmZOiB+x/zJDOGkaU3FFANGa/ZjmbmB2qCmDkJtXy5NIBIFvdYqhW3TuA6wIFQ1paELUyuW/0Pc49NRiI4oega3/q11wS2TJuWDz34qlj9HLsuCJlcisgraRnI7fbruifQ9Iit+aMxXOBJ+DTANnaLSyTNhN64GuPA38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRHkHks2laEcW8Fs71/oIWHZR3bYGMnxAkkXYwfH6Fc=;
 b=usK5OZ7iFpslMxi4e/9IngsGJ/kQ8Pq8MYxgORMmsjHPs8XJ/ovwyHJ2YRF9OKuBS8zY/R8V/Vn57buyLkuGHd1iaH8F/Bndt7PRJyxz4OneF9p6mRZo38X3+lLoDMnnrHG1NRpCk7njgMQSZLQ5hkE3pYQomCWftx+6UFy9EpFpxcvDHBjr96So4YoLMHm42UorU+Zdpz3OCFIL3nfjrxON8iDoZQq5fJQnHddUL24vVZiiVCEdjWSpe27jVeu2DepVNTQERi/A4VB0qAWDw2O4GTPmAfuYOHOdqzYgRINSJN3dhn6yd+ME6kee8aoD8Pv0Ka1CVCBr9epy4pWd3w==
Received: from BL1PR13CA0181.namprd13.prod.outlook.com (2603:10b6:208:2be::6)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 22:01:16 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::85) by BL1PR13CA0181.outlook.office365.com
 (2603:10b6:208:2be::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 22:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 22:01:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 15:00:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 15:00:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 15:00:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <bhelgaas@google.com>
CC: <joerg.roedel@amd.com>, <kevin.tian@intel.com>, <jgg@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Date: Wed, 18 Mar 2026 15:00:28 -0700
Message-ID: <20260318220028.1146905-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3b12f2-c03b-443d-5c45-08de8539e0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C7nnzWsNB15xSWYwBfsBOx1DQkqEXdsHAR63JL7/vRKcCna7dITOwjZSa0BpIzzmJJ8uuxl+Z6ope0V01TtdyKkUGB3N3eB5X1hDzXHlr8TpRP1m7b0KWYTeC5y1QeE14U0UCPO4mTaAvmCoeUudDyUHyfeyspYafblqf4KY+qjKL6UamatT5ro1XZM/Tk/rqOl8xAecr3wDbfn3EwdZN7MZfK8GfEJiYKLklKE5lhfZyX9QzTLfpgtMdsoPtnpVHryG2MWlzC6/ZkJ78mWjOYMNZk7mEEiGSz2JOfuj1XAnEvr+xpt0fdNF6PVKfYQ/INlYDJCtPAVEv6RREIUiYOdNH4fH0VsqGe2nipr0z40CwH/AkEv4aA2X73psJ9PWZ8q7qFoOzsfjzvFU+sqFhnhpuntgXwLgq8tWMqBxRooD8nwqjNQbZKhxlqJkKeMWpOqFivf8PUYF+voK3boCqCEIXYefRqwr+VlP+ug8fQMSzhxSFMPP8po/z02TvmWleZRWntdXnkNadQHGkxtgZVuQdIHGGW3TvJY2Qes/YiCfOX6HrPyqlxgkJN7HzMe+7KxIdVwMLuw0PViCvDt5wysHhrigyT7zJfZlH5C05m68kFNs5oxsan8YvVL06xF1ybKzM05QHZTEXKj0MDlkKFjTYxt1wCYACzw4ZOUlxtoDuoJbz5yJByNKvkflgzYDgOCWQeRjsfLWue/QT4dhZnfTJx4U13OzDAOu+VfIseQp2HCtajlgbIDy5ADTqHefHs0SAgjgipm3V/OPanK0mQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	noQpeNGFzLk8qyTXFgpm844GQbox3LZG4v5AAQxJIpQipupe3DmISb+JbI63oWHzUirYEnzSLi83gjsZ8WcGU0pqR+QcuWueNqYX7nrblIvalQ1SB8XQ4FOCuNauA1nbzc1SDY9DElsfuXxzPeVfYRljJXG2k+BxT1PIqyPecM9qMGfXyOYlWlUHqkSdRhiyjz7OlrZknA+SJS5vf5W69+y+5aQ1Hn0f1FcbV3II3ywu2A1DM8zorAHU4wmZEPLp7gK95IMGzcWEqyxOH8pTAtxO/onN368ygKEbLnlQ1l7WmQyM/A9+86DDSU/hGjBoUdITLgSeOSbtRjnWuWjVYZdJS8UtETO+FtaljrwNDYAkxx096IYigiGlSkcSWK/d6zKVv2DIcrR+/b04MABd55cR14hHoC4/AhR2dKsqwj76/zhbiOqd8IvIuHVhVxbp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 22:01:16.3231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3b12f2-c03b-443d-5c45-08de8539e0d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
internally while both are calling pci_dev_reset_iommu_prepare/done().

This results in a nested pci_dev_reset_iommu_prepare/done() call:
    cxl_reset_bus_function():
        pci_dev_reset_iommu_prepare(); // outer
        pci_reset_bus_function():
            pci_dev_reset_iommu_prepare(); // inner (re-entry)
            ...
            pci_dev_reset_iommu_done(); // inner
        pci_dev_reset_iommu_done(); // outer

However, pci_dev_reset_iommu_prepare() doesn't allow a re-entry for now.

Digging further, I found that most functions in pci_dev_specific_reset()
except reset_ivb_igd() are calling pcie_flr() that has nested those two
functions as well.

Drop the outer callbacks in:
 - cxl_reset_bus_function()
 - pci_dev_specific_reset()

Replace with adding the callbacks in:
 + reset_ivb_igd()

Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.c    |  7 -------
 drivers/pci/quirks.c | 29 +++++++++++------------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..8f1fd083a84c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4958,12 +4958,6 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
-	rc = pci_dev_reset_iommu_prepare(dev);
-	if (rc) {
-		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
-		return rc;
-	}
-
 	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
 		val = reg;
 	} else {
@@ -4978,7 +4972,6 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..d1d210bc2a15 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3973,6 +3973,7 @@ static int reset_ivb_igd(struct pci_dev *dev, bool probe)
 	void __iomem *mmio_base;
 	unsigned long timeout;
 	u32 val;
+	int ret;
 
 	if (probe)
 		return 0;
@@ -3981,6 +3982,12 @@ static int reset_ivb_igd(struct pci_dev *dev, bool probe)
 	if (!mmio_base)
 		return -ENOMEM;
 
+	ret = pci_dev_reset_iommu_prepare(dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
+		goto out_iounmap;
+	}
+
 	iowrite32(0x00000002, mmio_base + MSG_CTL);
 
 	/*
@@ -4006,8 +4013,10 @@ static int reset_ivb_igd(struct pci_dev *dev, bool probe)
 reset_complete:
 	iowrite32(0x00000002, mmio_base + NSDE_PWR_STATE);
 
+	pci_dev_reset_iommu_done(dev);
+out_iounmap:
 	pci_iounmap(dev, mmio_base);
-	return 0;
+	return ret;
 }
 
 /* Device-specific reset method for Chelsio T4-based adapters */
@@ -4257,22 +4266,6 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ 0 }
 };
 
-static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
-				    const struct pci_dev_reset_methods *i)
-{
-	int ret;
-
-	ret = pci_dev_reset_iommu_prepare(dev);
-	if (ret) {
-		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
-		return ret;
-	}
-
-	ret = i->reset(dev, probe);
-	pci_dev_reset_iommu_done(dev);
-	return ret;
-}
-
 /*
  * These device-specific reset methods are here rather than in a driver
  * because when a host assigns a device to a guest VM, the host may need
@@ -4287,7 +4280,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 		     i->vendor == (u16)PCI_ANY_ID) &&
 		    (i->device == dev->device ||
 		     i->device == (u16)PCI_ANY_ID))
-			return __pci_dev_specific_reset(dev, probe, i);
+			return i->reset(dev, probe);
 	}
 
 	return -ENOTTY;
-- 
2.34.1

