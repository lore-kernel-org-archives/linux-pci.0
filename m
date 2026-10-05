Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010069.outbound.protection.outlook.com [52.101.229.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0347CA81;
	Mon,  5 Oct 2026 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198163; cv=fail; b=ZyE1SImCKZGeuMJPis+74/UiaQLj7OrfbhnjMwcrwIsIUAzXDcliYiGh6lVbft+TQaifc/KM9FkDNEr9ww2xUIiRz+9WnDhxPHiwk8KzA5dP4QDiEueWHvH+gSQwlSeOO5xbIdtBRXuJ35BJvgDpAiXK+TniWPmqO6mzHY8kFQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198163; c=relaxed/simple;
	bh=1Atrb+0V3MLH0RZxRF9qgYpTdygfJr9MXSyVR8C7dps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNtLTNFAao4Ori3Ylos74ZvpvrbA+l954lPDf6jvUkUMDpqK/Nx51FyE5C9qH7GuBxMP2o6Ueur+qdWjIfiFdyOmY+4AHQdQduyKLD3pSsZ+4AqqOe6yVf7wP5yrvo/DCundogu7L8Q7oUbIsgtfCU+dtC3gXrfUWKdswaEtatA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ValvWFw3; arc=fail smtp.client-ip=52.101.229.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ValvWFw3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg3orlaZAGOYff2tsnqdTvQvurqb5sPhFPWpbeGolFM2yeIIVkd2Js2uf6m4Qw7afszqAem43VoHn0r4v5XJDwN4g1yHu+orrUvmead6e3wrceroNwj6QPNTxHUiyRLoCHABHHgRcOFKPz5F7MO4kfSskCdCP8HJEpse7XP0MQ86jmwzi695PCt/w0IAbpl35xzhvDiM67CWystcXRBFb0j2KTuKUEpUOUsAL0LuFFYM1p5Bw+FTfa7Xp/RhUUpxA0Vm2hNs8l/mOpraqykgLMkthIyC/eVZv0ANW64/3Fhs/xnstYm9j4VPbnmC23mrvlg70RUwSLD8NG78N6GZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/fcYpNLjBEpECwB+4aEqXY8kUy21PFM0EvC6Hu4l3E=;
 b=uQRn8cIrAVJu7yaFYTZiCcNjL7Kc+tTIg9gMHwHMx79bfCEe5lZv9vD6yXtEocsI9UmKY9d6icaVtTd6zC/WOTMUENWHJEJbqJG2FUQF9EVkCmyZX05cZaprlWfTXXq0PnZGqUvh/bd6BgJZrw5sbS1/xksDdcQebSlXN0WcVdUuksoKnhmsXJ9hdT7rpO+yWqi6woKDBXIkZ6sasMPPmn8MVtopHKOulIFYBuz1KLdn6spqw1u3uanlaJRb/GuYz+O4jDYR+FLrGGvgFDAbG4bLbUUScWkjwrVakGK5ftWuhv5H4p0yr19PtsF8hgG1113/cGd9q6GY5CqkyzftEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/fcYpNLjBEpECwB+4aEqXY8kUy21PFM0EvC6Hu4l3E=;
 b=ValvWFw3E/tE8bCNkB49FxBVzw+cixHnAiDcMC1LTRFsg9w7bUPJZxJR1rv60SkRmhl4irbhjcrA1k71KXEWEP3WCJFAf/96pbbFDTZhbYYfk002FA+aEweEmaE3kWUam/GyiyhfpdOc1hX55jXGdvtg6rWqndyloJYOqAlruXU=
Received: from OS7P301CA0026.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:26b::8)
 by TYWPR01MB9939.jpnprd01.prod.outlook.com (2603:1096:400:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 11:02:36 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26b:cafe::41) by OS7P301CA0026.outlook.office365.com
 (2603:1096:604:26b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 11:02:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 5 Oct 2026 11:02:36 +0000
Received: from vm01.adwin.renesas.com (unknown [10.226.93.89])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 88F263000204;
	Mon,  5 Oct 2026 20:02:33 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH] PCI: rzg3s-host: Fix NVMe resume errors after s2idle
Date: Mon,  5 Oct 2026 11:02:24 +0000
Message-ID: <20261005110224.17160-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|TYWPR01MB9939:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d5d85191-c9cd-485c-f5ed-08df22d02a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|56012099006|6133799003|11063799006|5023799004|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	41EUybhImkW8ApQ/J2Fm1gKOoe8ocu0xyBcd0z/qRRDH4fST4yViUzWGnBGW3DAv7GypYCTzRHMur7J1LfIyKV+/H++/+fCuyHqNtptgljX9znYqzc7nt8hPhSNU4NhG//lz/+4wC9SBwKC2Nlk39avblTc/657I06ctAPO0CRN0FkAZcQihAncY01KdXP2ATDSwQuFFH+qbfZTbS3juoJFgm8sYxcyOwlTXO3WG6OfnSCgIeth3rL/JkPdvX+/jGA6cnZydt9XguVqSc7DcZl7cAiQje2ETSV6/gpjUurrPaslG9mfLoaWviB2whGZOQg3GTvRTmU7VsqFU8DXN9a18sKy2csQLmmvBq4CiaIJ76NHHBri0PTiOs7QmJp3FBPNTc2644w+moxMBtY9A+SjiUlSDbryfGFqgE2CN7gBdmbuRpXAFMP6apahMgeNBU1LJtuq4xb7IqFZGLD6goQA5E0ib570Mr8PjqZCN33pk6Hwv4nMzINgHw9qGyfA9QZ9EjhjiO2z/uISI68cCBub55a7sMtjifkvfFx4HKkMSVBo+Gm+3zyv9FV2LZ19Ls/l81GvfFVn3fPhY5pTaC35Mwb7Vz1BZkGEn0V2jPGkvlh1l0p03DmOjee41HdNQYKa369TLzMEk8YEKHuXkYhh3iUnkHm9ueXA5yKAqic/NnAuNvGcnyVbC6WhHZL+pubyXjt8g8XLo0nwmAaoBLQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(5023799004)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nsWMpbCTpZCrS6tZ4WIix6IuFCoQsoQttBhtUI9S8al0NsoASFnl8IdpyXlbVYGwrCcyGYLyczbdegF7C4r7uy5e0OCVOU1jmwdl17fJcU5xh9KBydyhS79UY0zbxDsmMk8BGR2uqMsumaIOKfdwj0bxvNup6QeENCypnZ0MjMkSdImKptlqWR6qwRlwKyx1iAOv681KPL/2funvcCDT5IGCEOT4HtYxKJWrRXy+UUQHi+jPgFMc6+TNIpYejLcHSwRLHMif6UeHi7kITVb32c/FUHlkHHGeLPVLqnWeMMPT9+LRw85pQRj5tTxFSReKZl7SnJyyzhagPmlek40KDOmoQgeQ4jPp9/1ylzn9TiTojoliEoPZ8Py/T3jxUdUuXON52OYzaPzFx3XiSSvDmr5cAFbQenKye8duzR/Gdyvl9ylLezk6IHFQASukFXH8
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 11:02:36.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d85191-c9cd-485c-f5ed-08df22d02a56
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9939

On the Renesas RZ/V2H platform, when ASPM is enabled, resuming from s2idle
with an NVMe SSD connected fails with:

  nvme nvme0: I/O tag 27 (001b) opcode 0x9 (Admin Cmd) QID 0 timeout, reset controller
  nvme nvme0: Disabling device after reset failure: -19

This happens because during s2idle, when ASPM is enabled, nvme_suspend()
does not shut the drive down. It leaves it in D0, puts it in its lowest
NVMe power state, so that resume only has to restore the previous power
state instead of a full reinitialization. This assumes the drive keeps
its context over the suspend.

However, rzg3s_pcie_suspend_noirq() doesn't take this into account and
it always powers down the controller and asserts the controller resets,
including PERST#. That resets the drive, and the command the NVMe driver
sends on resume never completes.

To fix this, similar to the dwc driver, use
pci_host_common_d3cold_possible() to check if the controller should be
powered down and keep the controller running otherwise. Do this only for
s2idle, as deep sleep could power off the SoC and neither the power domain
nor the driver will restore the controller clocks and resets on resume.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
Note: this fix depends on the following series:
https://lore.kernel.org/all/20261002110935.2004349-1-claudiu.beznea@kernel.org/

 drivers/pci/controller/pcie-rzg3s-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index eea215818633..9fc1a5a4bed8 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -2272,6 +2272,14 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 static int rzg3s_pcie_suspend_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	bool pme_capable;
+
+	if (!pm_suspend_via_firmware() &&
+	    !pci_host_common_d3cold_possible(bridge, &pme_capable)) {
+		device_set_awake_path(dev);
+		return 0;
+	}
 
 	return rzg3s_pcie_host_stop(host);
 }
-- 
2.34.1

