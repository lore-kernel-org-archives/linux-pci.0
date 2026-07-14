Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79361FFC59;
	Tue, 14 Jul 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054421; cv=fail; b=M+Q24qtAyJDQ1CiPU2wTi3gH3RfUsS35eWanDbFywwuwaudF0UlbxaSAJLBKGNz8dWjw95FrgwYt2GaxxyE+kmxQ2eZ4yNSa6pEn6/MEYo11dj8blH5BXaGA0i/qlIDhqiowV0MVw06QGA1MxQwdlKFPwny46D47NUMmz/nqris=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054421; c=relaxed/simple;
	bh=C0R7PZ1mR9hNXvtPJxLbIKFK5Ube/yk3OEM9BWt3FFw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B6hvgl074HGaoWet7icTfobTKk3E+2fXzmfd5ujSBo3yyciNZDGzH1sMNAQ1OOJzB2kRboL9MeMG9NDf0nKIRh9D+R8AzFmK48NU9er4vwuCPRY/dvFwWtfXAhYiyASLL5/8soLya8bXRvXUNxqRY3ke9X06yCz49gd++Zlboig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vphWWu2V; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vphWWu2V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1y6czLxVznQxWTpWlWvqUPSeSLMKUslUH7qUl65y8ppiwr3FlYjRjPGfGeifRBUGe12sTjXBf38XaOTKHcNg/m5QZ2VxHtCT1nG52RGKn1FAXYCak7+uow1ht0GqAbCIZWvs0b46yXi2aY/SMAb1W10P29MsoPS7KEvjkcHQZ3UKZ7IRwUIYIPJM2vrhhfuAIQ8O9PhvrTYf1tgizYIgP08My/EkoMhUoEOmTrg9VuHTBWuftJH7fgiLoZ/Cc1Wsnv58GLoCD39sjd3PR+VSZ+Hcpuf4z/dyvwXYdfmG3Hv/woFRe0TH3nJtX4PGTsElQXpgd8rzmKN8kIdlmdI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Is+PRyluZ8sny/UfXbytOYWtHPsOGzkMMYctwSPBatY=;
 b=KFXSe/UJd03aiPDKm5LNWhxfvDykIcKQUu4yzIYIYEaDxyHhbVclK6yEqdp7lVr0E786po3jczhZEs09YEWbWcrXdMIx7MEFvdmeRP5AiHRZDxdQKdxqap4kScsnBHudamL4oRXqBybgqP5URf7Dhe4RF/bHCn0othVrV39STttetiYUSc+e5ESoYISjAq9KgcQeG+R9n6D4YruhkbjcBTg8z2vNvx8d/koHFSEyKWVDHYZJPcALuclTLpTB372GXnqilZBeBeCneeAhEC7sPQ893klsbuCOw0X8XnJ0R5pm5UeacAuaPxFXBjdw79e1gO9fVLNkhmY6zhVsC8M8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is+PRyluZ8sny/UfXbytOYWtHPsOGzkMMYctwSPBatY=;
 b=vphWWu2V2Ylbxw3wj3C+9sUd3JP7YcL2arFfMozKmts0jJZ0hdF8DNEL09Xslmh5PG3NEwfHNmakpE6FnsQnp5EA+9iC910JDoKMYUEwCH1Jx5F9t60jD2407w1Rb2+j9nFr9p6l7eee2ESFdHKH0f/OaeQY8TLkRQLHwV93oW0=
Received: from LV3P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::19)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 18:40:04 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::ab) by LV3P220CA0018.outlook.office365.com
 (2603:10b6:408:234::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:40:03 +0000
Received: from yaz-khff4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 13:40:02 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH 0/5] PCIe Flit Logging Ext Capability Support
Date: Tue, 14 Jul 2026 14:39:45 -0400
Message-ID: <20260714183950.1620016-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a4ee0f-4a17-4be4-ab4a-08dee1d751a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ye93tJTV5g0Xj4MqjK+4Qkt4/fsecOAqmi1abE5WkpEVjObzLjjBVITWGrh1DSC36BszeMC8x19ZQwWXKnGbk1w1YeihUdTT6ZAXa72KC2TSCSy9b2LTB1qXcYR4AWyOQSPOIQ05D/0U9Or9Ui4xoh4OZTBCthnJQGBVVrgOh/o09zD+L6nvI3KsmtD+DqM+BDlFZs6azv7Xb80JEzJHwFG5Y6/Z66elWJNs/9n43mGoaB6tdWH3bNBNw2vp8CoWvhm7c2aoGxHnOzA5bF08z4+UWogeOt/+ze9MxxFFk4yIaJVCYo8YPbZ2rb/rCYIRdLxET861GgKOco49vzytUsEMJhtZUAqcP3T5yBkMndQFWrA9e49l2w2HHoXx41Nf1WZdI4TfWm0yxSZ51EPqfVG8IfeX+Sj00xxrFoMo+o4SJJgpnuQ/viDIqjONOXK5UUd4PurjNC0VuzHcJGmeZW6f4zn6ZrGvYMzS0JYOiUpRHdC/CGqNeZ4bkVt8zQDe5dw/5Ikm91bFaCWol8Z9QaXFCBwOSqwQfiiPDur6IRwUOEi/SM3bA7/SgSGvfG5DUau6JQZdENV2UupwEKOvxXKhc4UdLlZOeAMcyMcxiaqoAwyvumPBTWP1HZ2CagPjRMT1OG/yBDwTiSxWk2R2YE6MPCz+6f4bJnNGOl8APG9p5R79RnTyuCWwASA+uRVdoXbH86/phaA0gyZtXZF0Zg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eD1U6HGzXGZhNUnClLboEfQ8sJmwBl6rcdp8hKfiDRADGWBG+j3EfZR6VcGlVK020elimxYOEGDIwT9uXW9AAzf8KG+ngcOp+634ECZniTuTJHtWezDMjXbMhGYHrmRFt5rGt56QratQIwEoKLgpB2VWEotTiLEndJKDRpMozpurSDROEeE9tSkEGn14qMCHHuPoiLJUih4wORmBIKA9tPeK+tolLRTiuLxSnScPYA4cR6PoXRVLm9FQu0bus0QcFBUw8+BQrKqfCo8UT+DkXrIhZtmvQ0udx9kueGzr5anZC8jcymcReSfvDxkunvElTQd8+grJ0Z4vIRrtTQ+o9y6d9SpI33t9xOYURR4xd+V5+Kys/dpajK8Eg4InMMHczSiSPnzjPPC31/wFhFz5cKL9x4F7xTmeEHn02L0lVHeGVRLX+kyLdMbdYMiT78JL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:40:03.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a4ee0f-4a17-4be4-ab4a-08dee1d751a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462

Hi all,

This set adds basic support for using the Flit Logging capability
introduced in PCIe v6.0.

The work was started by Avadhut, and I took over after he left AMD.

Design Notes and Limitations:
* Only enabled for ports using a service driver.
 * Other device types can and do support this capability.
 * The interrupt is managed per-device. So each driver would need to add
   their own support. In other words, there isn't a centralized handling
   flow as currently described in the spec.
 * A future Flit Logging capability revision will use a centralized flow
   similar to AER. But that is not covered in this set.
* Included ratelimiting for messages.
 * Initial thought was to do "interrupt storm handling" similar to MCA.
 * It's not clear to me if that's necessary, so I went with a similar
   solution to AER.
* Flit logging CPER decoding is not covered.
 * There is a proposed change to include DPC and Flit data in the PCIe
   CPER section format. This would be used in FW-First handling.
 * IIRC, the format still isn't settled, so I left it out of this set.

AI Assistance Notes:
* Patch 2 was originally written by Avadhut, and I made a few fixups.
* The code in patch 3 was originally written by me.
* Patches 1, 4, and 5 were written with AI assistance.
* AI assistance was used for squashing, splitting, refactoring, and
  reviewing the patches.

Thanks,
Yazen

Avadhut Naik (1):
  PCI/FLIT: Add support for Flit Logging Extended Capability

Yazen Ghannam (4):
  PCI/portdrv: Group PCI Exp Cap services into a single mask
  PCI/FLIT: Negotiate _OSC control for Flit Error Logging
  PCI/FLIT: Add trace event for flit errors
  PCI/FLIT: Ratelimit flit error logging

 drivers/acpi/pci_root.c       |   6 +
 drivers/pci/pci-sysfs.c       |   3 +
 drivers/pci/pci.h             |   7 +
 drivers/pci/pcie/Kconfig      |  11 ++
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/flit.c       | 283 ++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c    |  23 ++-
 drivers/pci/pcie/portdrv.h    |  10 +-
 drivers/pci/probe.c           |   2 +
 include/linux/acpi.h          |   1 +
 include/linux/pci.h           |   7 +
 include/ras/ras_event.h       |  48 ++++++
 include/uapi/linux/pci_regs.h |  14 +-
 13 files changed, 409 insertions(+), 7 deletions(-)
 create mode 100644 drivers/pci/pcie/flit.c


base-commit: 5d9f1dd3b3e7bd64ac7ddedf28fcb7db81053819
-- 
2.53.0

