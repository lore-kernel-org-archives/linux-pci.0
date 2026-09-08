Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30656C634;
	Tue,  8 Sep 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894383; cv=fail; b=JuofD9rRfLaDPILZ/JOTpnY7AkUy3Co70Zebi+Y3R5bHtQ58HCa9PGC76Qnljv6FrPUBoQjPNbuMz6J3EXR0+NmGVkk/vMhQXNwMQ8FJDUfLawtE4vsprPXKRYNMaVuuY7XfqM3FkD3nS2czRDEQ3qEqMCexwyPDD/cmwTjYVrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894383; c=relaxed/simple;
	bh=EZPQtm+bPefTUj5lMp6MUzxAtHVgAahOZ5Xk3wIIUAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmyHwZvYhy3f8PbTN0H6QLQoPUCiGE8D7B12z3s0coIa85tY5JDtmRWOu9AOyLy8ETUU2SFAroydB+/71Kgl5Joaqp4KE02j/08AiZ0XDyuDr1NrUC6/+s3X3rcjXCKhOJ1OIU/8lBpCGIZ9L5eMA793GWo1rzomQMSwmzwIVDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sSXjIVSJ; arc=fail smtp.client-ip=52.101.52.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sSXjIVSJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+CeKItBpE3qUh9tXOp1WQ8aeliYcRM47oDP4rGTlg/wtOTKg7RqMxbIVcEC47Bv+NnAmfSIlIfigQVawts7dguzkOxqCwjv/whlaLsTy2UZUUV6BpxlXPkItUMbgVPI9T69joks74ve1ZhoTq1pnWY8mlIEOlOaGIl5vJbRkEIQwumGN1m4MQlIBCc77RMwazbC6D5bYA47wLmCaGbm92USJfSieeU7BV0jYtdK7C1G/1E04q/Z0dTPHmsg9qh37xbV0iyA3dw6vQqe1gmq+07Zp/0lmqPYvXWOy5U1if5/rVmDEOhm4NjiwmRtFh25pHRfUwMwhQtZ5M9BIPcw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtbcFJYtEf/HtRnVfcDYZKKsZHb9247CR5SHn7RNmXU=;
 b=NBDDqpPiMohbN7LDQh2hXP5loXt98i3WBS3cX+hhk4kbv9k7a0kvtQ3qUiV5dFCJQXWNxg0pb4uI82zDIUW+qvTiiuHIcxDPsWvjGxn3mFU6fpYFrb84IohbVoMMTdfySMILDt4wsNfGtt2rbQkKfq8c5RTp2FNaBRqZMu9GE2N2WLm75LKMb50My5hue8aYz9YYOLnycRQyy7GUn1qLgT93tWFFFk3spWYz2QmV2sTcon1ryaOpdiaW7OstRZBuwYp/pxE+fKjyzzdxKCXSMmXDxXLHdz4GDsQ9FB/a1TF3c8UHhsu6CtabAo3tYF29jZApqnmPvpIq3NxxJumBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtbcFJYtEf/HtRnVfcDYZKKsZHb9247CR5SHn7RNmXU=;
 b=sSXjIVSJaLlAhdvz7Jr4taqINeDL9kpc4pOQWE8ndFdhkRKiHatLpDavKjYlLSdCK/KA6IF5AVvScntjh3nrtOeW7802l13dUoduk5L8OANAStUty45ZsAclXd/dAetCt1LQDTiXKuOceiYD7/gDtOgae7tdKgMhju+DdjeFVt8=
Received: from BN9PR03CA0108.namprd03.prod.outlook.com (2603:10b6:408:fd::23)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:06:17 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::6e) by BN9PR03CA0108.outlook.office365.com
 (2603:10b6:408:fd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 19:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:06:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:06:16 -0500
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:06:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "open list:PCI SUBSYSTEM"
	<linux-pci@vger.kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>, "open list:LIBATA SUBSYSTEM (Serial and
 Parallel ATA drivers)" <linux-ide@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 0/2] Fix for storage corruption w/ AMD IOMMU on 64-bit addressing
Date: Tue, 8 Sep 2026 14:05:58 -0500
Message-ID: <20260908190600.226485-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 4666a240-656d-44f5-74e0-08df0ddc4296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|376014|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	8YUI3p8RYrr3GqLn+83RFAgX1eXgvOKOC857aEccRgWYqSBw8BHBeWpiRzUGe2yqYsqfH3aazLlE9oV7PXF1QX78lKpJiMQHiTtb2CIdn5AXaI7fZuybHc8IYtpDm3JTseOJB2yW/rgfZwLJtAW1cXuRf3xkX9Bh9ViQonn3QTaY+BGQXrUAgIGYgMeH1SgDlXIgZTSe3jQNUBpPzvy9jVB4sBEKLTwFtA1r9NtLkcQL75VSSkLGNt/R8vhuZMpP11XLx59mgtTqM9sa3pyToR95HTz6FItiNbcC/ApUgTiydClaFhmKXj7RHhQFGATbGyc0Mzdel1Vj7LeKErJC9a03F2CVJCX6ylkbHrKqm27CgRQ6Ja8SZ9WCq+0REWOXja+tIapvrEJxQ26LOPeMyFI0VmrASTced93Os9r4vzNBdjB7DSQPMj11F5lw4UuZls7tiv+SoPvkIqe376+IN41NfiOCXPjcgXn7aQas3EEypD4+OyP1dIqsECt74jzqMCwWResHAW6rUpG1yJv5rr8d/6DdjWAjnRxQC+SLHg7YwFBMP7nyJTLnd9ZP3SL7EEMMEyRh2sGBvF9GdLQWtGWay27ALzjgGGWQ3r9cWM/8GRsqzizgOFCS0fjPNzN+TgTi9IhOIw0ZizNa2wQDeDytHAB4bLP2xsSuwYlljAVuU2R4rvwxOFLPx52tBg/10lb7YU8nNf8vF9aAect65g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mOT0VTj/getcgCCDGf/oUhCfoLTR+2UVd4Nu2dauu/kJoZRobetyNbzrjnqNfsGAyctg9MRghpw/ly/sUzL0gq11uXJZ3gVFptTLgmTHHomC/MuFGJep2N44K5S6DFH/56YV9l80DRhVwWp2IHvsr0W25h31nPRUZglGkNyqvMHg7Kj/a8/sLR+dhAcUH0dORfPFyAKpM+fd4GpKOAMAc4rB4zU2gkJHK66cmqRfSEO4iHuLejtcTYaDsWTiSNOAgrhMMM1F10H7iRkJ6bnu7g2vuVpNZ2rNNYdw0eIvhfU1aNJcaW67K869n8fyQre2pV0DTix5aRtPlkjG5vVlUqJrC/HqXulxAXTlYJp0pnes7VnrqSqwTtUp3JV+9Z/917e8UTCLspEngVEYgGjkx5bbAHTHz31TVtj1J2u5CHMbZu7YSMHdYq5tn6tCMsH7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:06:17.0613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4666a240-656d-44f5-74e0-08df0ddc4296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607

An issue has been reported by a number of people that corruption
was occurring on storage for desktop systems.  It's notably reported
on SATA, but the same issue also appears on NVME.

At a glance it looks like an IOMMU issue as turning off the IOMMU helps
the issue, but it's actually a problem that occurs specifically with any
IOVA addressed >58 bits.

This is because the BIOS on these systems is enabling a feature of the
root port called 'enhanced atomics' which repurposes those upper 5 bits
of address space.  That feature should only be enabled by the BIOS when
the partner device supports it, but it's instead needlessly enabled on a
number of root ports.

As some of these systems probably won't receive BIOS updates and there is
active reports of data corruption root caused to this add a quirk to
disable it on affected models, and also remove the quirk that was
introduced to work around this issue in drivers/ata.

v2:
 *  Added resume fixups for the affected AMD PCIe ports

Mario Limonciello (2):
  x86/PCI: Disable enhanced atomics on some AMD PCIe ports
  Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"

 arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci.c   | 18 --------
 2 files changed, 99 insertions(+), 18 deletions(-)

-- 
2.43.0

