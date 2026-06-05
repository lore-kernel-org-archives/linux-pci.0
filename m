Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E673ED13E;
	Fri,  5 Jun 2026 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643973; cv=fail; b=oRrodh0fQeWj1w/l6PpUNVTu1aO5iE9muUjwaZ9tk1UblcfkbC5nmbUfcpnmLXFgPTl/PIkiv5fXj2L2BQfv1t6CDiVJ2kyzkrB+Mq83G/PIayo9/THMfylfFuaAk7hgwBpWvULs1Dc7L37NOX6eIdgJyT69oYoQtnh0DxsG4UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643973; c=relaxed/simple;
	bh=d7X8D2ShDzPD2uzdIKwEdIReTae+5Drf1dJx4aRNWbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T8nzLWaM2k/2dgLqjd29FOxyMPwoqTqHMNJIqm+qrMCgm/jC/nRq/jmZpyMHKniiNFEavxnqzkLrH8LbR25oY1mHpOwVVI0j7XMmFMeo999SrJJWE161JzFn2fU9wE+hlRJ/0cVdBEPBEDMfrtnipJychhe0vNBgoND9XKhnvN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BnCnYEt8; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BnCnYEt8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj6DT+RI2iG90HR32P6mMbzxDNphmA/CYS5ethbMO3XRkrbM41CN0y5FtRXj9gdxazsHxyuD2ZNMoOUO7Lnx34663yj2boFe6cEklojtK41AK9YID20hzygjTdQJnBn6bonTowqRfTS/4ttDgjulW+iVKLE9kuWYUsh2qcL8Ss2vLZ64QGduiiDV0Av+evc9F6c/EzrXEpRnytMufVmAGJBLPQGhoDP3t4+jjEv2vZyM/5y+xs3ZeEkf3W0inub9VXFN42UgnFt52eKPkFnrycmTzuHb9Tp4p+375RIfBx7yMcZd8UzCIVRXgooouCe7UyeCrSkiS3ZLFj/Zg2gVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RlfFIgPGy7pGZjFawt4wYmr+kEbPPFQGpGp0fZuEYY=;
 b=OAM+fpyqjOOdNsvbiLdr1JicFzussF1RCKDSMoN1rv8ODF9gz5t0G8iadaKZmEodQLN27hy7IXcejk680EUoEeaxfpgbvdfYLykYHLktXFb3GA1u8HipE1OAMEUNg1wc1mkFyePxPMwwnU9VM5ASaLyUESie9CUYY6vl9282C9KLSrgUbAHKB9XD/mn5zSXOwJGHkIDzOGU1QS1g4FQl/v0kjf0tEQGO+wS9RFdgNgjsYkngIUbNLHltKGIkT059zH40oKgSkMqS/fFZGIfx52IvXZyiad0jmoa4kHqyjDuHjnvRCwCD5R2gHgOPj0m0TZatEzyu7/DEJO6ezRHORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RlfFIgPGy7pGZjFawt4wYmr+kEbPPFQGpGp0fZuEYY=;
 b=BnCnYEt8lm1ptWb1KkryR9gLVXALBJ1Al59pPKGzQ86YKXLLK1rz+OAee2yohNA19u2Yn/wbVfVzmPFrfmrU3Z0/PQn39uNkwmQCxMzRwlGFZ5+4sXimbfHqYIpawMDUrGkcOzbFkzDTAaCrsAcf18MLNNfj/GWEY65gc3ZrG7o=
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by LVUPR10MB997835.namprd10.prod.outlook.com (2603:10b6:408:3a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 07:19:29 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::3c) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Fri, 5 Jun 2026 07:19:28 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 02:19:28 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 02:19:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 5 Jun 2026 02:19:28 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6557JNSs1404246;
	Fri, 5 Jun 2026 02:19:24 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <vigneshr@ti.com>, <s-vadapalli@ti.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <mpillai@cadence.com>,
	<unicorn_wang@outlook.com>, <me@ziyao.cc>, <18255117159@163.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<danishanwar@ti.com>, <a-garg7@ti.com>
Subject: [PATCH] PCI: cadence: skip the link polling when endpoint not connected
Date: Fri, 5 Jun 2026 12:49:22 +0530
Message-ID: <20260605071922.1724499-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|LVUPR10MB997835:EE_
X-MS-Office365-Filtering-Correlation-Id: 600d2589-7d87-4006-3fc1-08dec2d2c834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|32650700020|921020|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	nkmhoYZNo5DGO9MFPheLQYMTA5fea9PQpNkPawdhWVQkzD1An12dykOXp1GfxwXi8BrQhOPg+Zg8RSzQby0y7KfwYVDxUjU75ZcBLqLIyrabmbsZF86T6M64y21bXMXvhRl3o0kchuT64eWmIKmdrfiPhcIgvrnKOChu9zL+eHltvHBUOfkIVn9O9ERNlptyzNpcWh8cK2AWhpBQaxIQEd6IR3BcFT7gIIs6/UnU3W02xNsyqD0PCcDo62af7Cd5oha2rH8VWU8ckAdwt9ie7dnNxl5m811DaXKuLAKdx/9VLfCwuA43NCXxGtyObJ5LrlCloc9ZrP0BfRFogzPOETvnq0qoWGSmmIzoJgRCzGvaGtmEIMFP82z4TVmBIhG4Op15K2PcFnxxUP5fiOJpuUE2Fm90j+we0S1ty6BTZ6EmfzcH1krpCmTVSO7TAnTDlX+qEh1uFxUH4hh62d0uCPdINqDUSBTBUheIjw4QfTeXWHV6nERT4rnYR9eNOFwuyUE0jaDykraIwvGf4Mk7pjeTaIhrqZaZgUJ7N9BNoDCIeP8vNq4rdMygETqvuJ5OuYAp9TWp+1Z/RhjF7QOj3SZ7h41dNH34H3MaszlkVpQxxNhypgaorIjjG2ToHuF0ILPhRXrFr2Lkk8gFo1+4AlNXx+/sNv1MJ7LydyVoIAkbBsMV7k9Rtriv0MGCFuGhj9o03tdbe3Ctff5lawfonm9V5iqFg1hDxvHvnXooxN0IJqlm4h4d3SLNOf5Gi+zQrIp41bXGGFO74TqNkfvMNg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(32650700020)(921020)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Alat0+RJgDntlyluyqzwq3w5TpD80GFhtaBG1BGh8eTfv8LejPVjMC6y/Aq4hKgS0pMmpLWuLRRR9qlgu9fUrlIXi+CiXIEyx5WjImmxoygMt4gDefq8OHMTtRbgiTJmCHLrMZzzNj1NktBhHKjAHjYCJCoNE8CW/ciJjcDHDswUnx/d6JrAMZlTxiZWuSVGbeetdfWmJVWPxKBhBUoSsvLcKuPlUFvBYaQVtBferZDyYFxLX4rTilvlv6rhK/xKaNVRykleM0QI9TqTHrVBKXOZSLmg3m25zliGXC+QpfdyaxlFmfesdrJl6Oc8GaG5EPuF3gmYQsvnFB4h1BsiPykN+OgQ6jNOIdksRYSrqcOIgkIcWU7URplWBcJ/xO8LcY9yzKCo0k6u8dSdDFoe7/1p8imEUl3A5m+WRaOHMurNPg70QWoGqN/i3pFfKOlh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:19:28.9735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600d2589-7d87-4006-3fc1-08dec2d2c834
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR10MB997835

cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
during the resume operation blocks the resume operation unnecessarily for
~1s even when no endpoint device is connected.

Add skip_link_polling flag to track link state across suspend/resume
cycles. If link was down before suspend, skip the expensive polling
in resume since no endpoint was present.

Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c             | 5 +++++
 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
 drivers/pci/controller/cadence/pcie-cadence-host.c     | 3 +++
 drivers/pci/controller/cadence/pcie-cadence.h          | 3 +++
 4 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index bfdfe98d5aba..849eb8bb9e45 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
 	struct j721e_pcie *pcie = dev_get_drvdata(dev);
 
 	if (pcie->mode == PCI_MODE_RC) {
+		struct cdns_pcie_rc *rc = cdns_pcie_to_rc(pcie->cdns_pcie);
+
+		/* If link is down before suspend, skip polling in resume */
+		rc->skip_link_polling = !j721e_pcie_link_up(pcie->cdns_pcie);
+
 		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 		clk_disable_unprepare(pcie->refclk);
 	}
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
index 0f540bed58e8..d78c1282a5ee 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -301,6 +301,9 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
 		return ret;
 	}
 
+	if (rc->skip_link_polling)
+		return 0;
+
 	ret = cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 0bc9e6e90e0e..026414c21ee1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -352,6 +352,9 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 		return ret;
 	}
 
+	if (rc->skip_link_polling)
+		return 0;
+
 	ret = cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 574e9cf4d003..01e49ecccc7b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -117,6 +117,8 @@ struct cdns_pcie {
  * @no_inbound_map: Whether inbound mapping is supported
  * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk
  * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk
+ * @skip_link_polling: Skip link polling in resume if link was down before
+ *		       suspend, to avoid long delay in resume
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -131,6 +133,7 @@ struct cdns_pcie_rc {
 	unsigned int            no_inbound_map:1;
 	unsigned int            quirk_broken_aspm_l0s:1;
 	unsigned int            quirk_broken_aspm_l1:1;
+	unsigned int		skip_link_polling:1;
 };
 
 /**
-- 
2.34.1

