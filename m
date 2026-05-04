Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F83603E1;
	Mon,  4 May 2026 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935180; cv=fail; b=GiRnImm+Jifq9OiQgspVOrdOpNPscEABK6n9yGyHo3bBy+c+HGn88sfTageLgyNjYssWueYGI0LUcvOr32/FogNQFbyqAyKz/eCmYPUB83vKIJxXCReZy8Wu7g2bey0Zr0Op7ITEPOPsSPgxoAiBrx8VyAZLVKDINwQxIls0dww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935180; c=relaxed/simple;
	bh=gndjTeiZveJU/Rkv2H/OmVIVoIyBjcXOcBuI41jfPqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bCINneq6GV4AjsVqrCcoeRR6oV0UBZrz4kVCiml2fByTUKU3sjHauRegJ7Nz1hmLUNdYxqEudn8cNedQApDGruO8PudrbXGiK8OKaByQjpxsasGKs1ZZyPoByK3zKwVX4WOn+SySVjyj+7Udw79kBLQjSVEwQYfzLY7mFwR3YiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ozXYfZDW; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ozXYfZDW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHcO0jWHAPu9EywDg8FJHg4IWWhkSatrR5j9STiYO1p8NjctdOaYp02dBbGGmXp7a2t5in9xtDVph3ejHnmVegMR8PON/QDOdWC7kIsH5v43cvimTQU6vlkTPXWPUipdcWvJ6nKN2CcylLdcjVqj0dR6FzkFLpv9bzJQOKwy9y+vGId10Z/i4uOwYL16l+LoRYfk7ewjznhcJEOD/a7oiZVSQz+QBDUgOSULQ2hTsAx6l3d+gS95UhLzLf0g6nAoMYR9c5bvltgwXICK6uiv6bTflpgCUv8YiBX0pcP1AjThf5QASGVuL+yU8wjRNm9FmpR4f43OGO4TWdXJgptS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhPZHSl4z+i10oh1iZbFRnLp24hrmQW+B9xFbcK0JiA=;
 b=vTTtLBzszyrn39vkX3veaZPkMVDVqILBJaRThv7LOiBSZiy/2a7Y5Ugknfy7XGZqACOhufT9dOct3SqM/dvwD/iZlUbVnspMXIkcIuOTXmSi7ppIzePNPXppLE0NNuv7NuLI75BriT5gjovQzqffvAIltgriol4Ws7sW2iXj4h9gYQgk5JnYj72MPT+XBVpoZrCrt6rPAZFcltd/va0HS2waoEZMn+rhZGVgHLReL4Ef4ppM/EGrPFsad9CCk93sO7D4IDPR9qB3P/AJlo/GbTXxBEVPf9ibi2ORR6yf3/WcrD2pyii7uKgoeiYiUDEYSHNae56MlsY2/3SS/+TQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhPZHSl4z+i10oh1iZbFRnLp24hrmQW+B9xFbcK0JiA=;
 b=ozXYfZDWqv1PjRZMr3h2yvWM8+4sYfVaWCSRjRudP2AOPtX3aMurQTCrOoB00QdEmvqnL59OxdStbtYk4Gj6L6M/qx/TN3UebpRpGoQ4ezIXTV6FDNhg9BtotFo1KkvJ1O0CSiMzcR1K72OQHvpX86KvuerUWqqhumfEtm1VIqI=
Received: from SA1PR05CA0012.namprd05.prod.outlook.com (2603:10b6:806:2d2::16)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 22:52:54 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::f1) by SA1PR05CA0012.outlook.office365.com
 (2603:10b6:806:2d2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 22:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 22:52:54 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 17:52:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS didn't configure ASPM
Date: Mon, 4 May 2026 17:52:46 -0500
Message-ID: <20260504225246.480921-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 865ef8c2-cf11-4707-9d4d-08deaa2fe0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZSt2CXp6Ft3UBvPVVZGAk7itRVLr3yOe0QlHpnKd13DapC9WzK4GufdHepM4OsWx/vLTZEfPsWDrDqU0A9HDRnt/9kD0+Qyj6uDDXq7usf1R3/Vz2129z2rEt4dylMrThlGOmYyBpmt7zj1qtVIz7SIpmr5MjoM9USaThuYgMwCcE1Agsc7nFDgwrTMt5KWA1b+KPEkAEwA7eztinnDuBIp5pj0TnsttSaTObQxAFof5OHJaYyf9Z5GIw+JbjN17DmMuGtXqDzgQfaRvqh81cgbiJIgR+SyPS0WULBtkD+L5Be6oo9MkeOsVTr9NbXJD+Dfxl69VpLUltjGEsZWOcsLiBv5/bLA3FohHRi+pRXAMAkzQFYtALWJAcM3iaQn77fs4lRTUBQGpZJjj8Kw7DvC30nG9FImFcHKrtP/eGgVl7LFz94+LI4wJj8O8KlfpBg8WLcFLKR2de9A3GKVpPT/0UJqHNn4p//p7OfOiIxC0MvP2R/dHTkGvR8Iwe0SF+4xKQfgDXDOQxnUxSRcm+A+s7GigrbSEAXHH3W9rw/txkZHXY3hm+6QS/0Fke6ODl2HeVFZusd3ArQpNmk7HKPM4E9aa/N3WdOJGLfvIg2VpHstkI4kfaaEMkD3i4uUfCPw9Zc9Q7nUawLeJUx7tLgQKe9WME7fsKsSaQkpksjYNK+0haQuSQ0axVeG4qaNfnLsUZDk6h+S6y5AjSiCgIDiFfHN/XJebQmHOI14mork=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZsUqN8pmJxAHPBD3QJfrb+jTvxfjxYzI8u62TS6oB1OAC4fhPU4AxR7zw7/4m0KHeOBWTu8pcVk5iHTNaom3UE4tG4w0ftjdul6BlbZgCg0Dwgp0UGj6FYzMPXbemf4mElMseTKyWb7Okidh7XYgLwjH7+xjw0LCuKkP1fD8hSiXPupbJY2peRYZ2xSBVZsnecJ/8TurRONxuYWU5a22nldx0N2nSkS/Ppl65Z4b5OwFXTfZzDJr3ISC80B96C4CWV3GRDQtzpVTEYb9rGkTBPTo7DYpv65p73aBA7HNZ3A2CwpVaXOH2pbfr8eZcS4172ik5IQnFNSs6cI4Bph9iZfZr6/hlnf/Mwk+g5Y4sTZDA2NkWieC/svp2L2LFySSjdIGQUlhWJihl4jqVZsbJxm4NRLSyyNki/vi629FbJ439pViCkxCUABrWaKUpCSy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 22:52:54.1326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865ef8c2-cf11-4707-9d4d-08deaa2fe0a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201

When comparing lspci output between Windows and Linux for hotplugged
Thunderbolt 5 eGPU devices, Windows enables ASPM L1 but Linux doesn't:

  Windows: LnkCtl: ASPM L1 Enabled
  Linux:   LnkCtl: ASPM Disabled

This difference in ASPM configuration can cause behavioral differences
between the two operating systems for the same hardware.

The root cause is that Linux's default ASPM policy (POLICY_DEFAULT) relies
on firmware/BIOS configuration. For hotplugged devices like Thunderbolt/USB4
eGPUs, the BIOS may not have configured ASPM since the device wasn't present
at boot time. As a result, link->aspm_enabled is 0, link->aspm_default is
set to 0, and Linux never enables ASPM for these devices.

Devicetree platforms already have special handling to enable L0s/L1 by
default regardless of firmware configuration. Extend this same logic to
removable devices when firmware hasn't configured any ASPM states.

This makes Linux behavior more consistent with Windows for hotplugged
Thunderbolt/USB4 devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221319
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pcie/aspm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 925373b98dff0..77497d90be0b7 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -804,8 +804,15 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 	struct pci_dev *pdev = link->downstream;
 	u32 override;
 
-	/* For devicetree platforms, enable L0s and L1 by default */
-	if (of_have_populated_dt()) {
+	/*
+	 * For devicetree platforms, enable L0s and L1 by default.
+	 *
+	 * For removable devices (e.g., Thunderbolt/USB4), enable L0s and L1
+	 * by default if BIOS didn't configure any ASPM states. This handles
+	 * hotplugged devices where firmware may not have configured ASPM.
+	 */
+	if (of_have_populated_dt() ||
+	    (dev_is_removable(&pdev->dev) && !link->aspm_enabled)) {
 		if (link->aspm_support & PCIE_LINK_STATE_L0S)
 			link->aspm_default |= PCIE_LINK_STATE_L0S;
 		if (link->aspm_support & PCIE_LINK_STATE_L1)
-- 
2.43.0

