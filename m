Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CF54EEBD;
	Tue,  8 Sep 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886871; cv=fail; b=jRp57oUCn9ogo2O5gg5+sMaQcUHrbeeEkpjU+kjMfvlVsR2P0vNJp3z8OFztdOg2XLXAXDDOLO6D7fOPdmTYaTt+T3yt+ZFXCxQfjdOs54Qd45Qg4hPQ51QViKMnber0WbBoggy0XLbdVSklV6GmxK66e42YbxYmNi6SwpGApHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886871; c=relaxed/simple;
	bh=Q98o0adbXPokq1rKjxAV/rg45bWFMO8wfauUhkmWsSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzJdriY3/u+ZvZvMTGPX35Yr5Gj1pp35Y3DvMRkW4z8Gklb9Z/JWrCWyelRVIgergO1Ou8/cTbnSUNHgHdVRnj0SwXbsb0rPdQHfIKIIKLI8XSH2HuHxSs8/28/dJt1KAymWzLOuvDF4p5BJWAhKqGERN83TdIzspCindR1hC4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vu3b2wjX; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vu3b2wjX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwdQkUD6FmuX0eGiJiG820MzUOhK3Egg7uPj2yw8wgHfRYOcoHR9KL0TdBioFZcNE/eUTLo/1HLuj1NeUrQTVeVdm+r28oMiQUSWPcRrJSbVPupG8P0fQZYSQS7gtU9Frc6ZBGMTmoaSXErHuVNLS9R2GLgsl8JGGtRgykrI9mRPNY2Md84O/oaiLUgsrnl8jCSpZB8VkDpiUnI9oOtq/Mj8kFZsJy2/4LQx/zpV/y3IfxDyatLvMcuzPsfoiPpytyGCzmmGggDilM4w74FWKuYs3jhQXL8bR26Q08yIuQU83Ba9H7MpS2mVv14LDtpgwrYTQeKtvmn+UQfYHl5puQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Spuflq0O4jjhln7uxocfQd4Ngrsv1Y5px6bDxZeZpE=;
 b=dKeu9WmYqZXBs2ThIsB+/vHi2rBl+C3IUxGbYnqxKmbwNjWJG+2zHE7xsoBQov6+UCPMXIQArdJS30E7b1JTkgo4nDf4QnABqD2hHa5bAO5oS0mqbAFoo653fu5lVIE+ces4RAJ9SbHPD2Fr08YZM4Dp8H4BTwEzQfm3WYVaPZ0G7tZsX75JhlUhNQ/126Uhp94IeXCeVV5MVJQleQt8MJncLjkOT4fJwzXsSqcH/teMV5u1D8BZiFPSEsEP1HueMtPxjTpS123QYgLbAlwmYkMKu9jZR1Wd+dNycQzKZeIWOvLNopepodxDcfs5olAgyRneaRetQ7fN1MTeDPRCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Spuflq0O4jjhln7uxocfQd4Ngrsv1Y5px6bDxZeZpE=;
 b=vu3b2wjXQQTqIycyEXfzNAf4eavtCjSKuUThjNBSiCwxzbI41H076JoRDv4sA6VKivpJlVe2ehIr0siOq2NRt/PKx2zKivycGlneESIB2+6VOBXN/+xJCj3yD80t0H6l8adw7tuzSkEACG/KZfXpZNFth14SRkUkTdS3yGtrmvk=
Received: from DS1PR05CA0007.namprd05.prod.outlook.com (2603:10b6:8:457::17)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 17:00:59 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:457:cafe::ad) by DS1PR05CA0007.outlook.office365.com
 (2603:10b6:8:457::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 17:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 17:00:59 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 12:00:56 -0500
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
	<mario.limonciello@amd.com>, Arthur Husband <artmoty@gmail.com>
Subject: [PATCH 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
Date: Tue, 8 Sep 2026 12:00:35 -0500
Message-ID: <20260908170035.160166-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908170035.160166-1-mario.limonciello@amd.com>
References: <20260908170035.160166-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bf643c-ef00-4b2d-b902-08df0dcac19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	caUL9Jd4LLqar1w2DWzQ5hnF5jcWxSQiCkSZeMwCGbtaH44PQfl3VkeQTy5GUoV/o5B8UIZ/mTANzsgbzRNLFIAi0+3tRtc3b2Jafj0V91y7FZBZAINdag/gzPub5d360UtCix11MwwZ3uGpli7OVVGwOyRS4RhwWSn4eStESkjwhOsYiDHyeO7okc8Xyjm2mNWgIqjEVGSjoCCv4ZX83+4zIuqHZ+9ZtHRWgyFIRWFWMuC0IEiY9D73g+40zs+YeHqbRuQ722fTScAKHl+u03djfddSCENkHm5sIQoX1D0Vvc5C8TQ/EhAUGdqjAz8dyG1Z8rB1TjNVfNJkQqegpnyw7qE7scDMTejfv6Wk68p+/EmFpD8P1F+2m6+Ys/tCodoi87VheSpmiQd46Y0sawEvGWSifzO9HKy95aDiAhGgJhP8fk+buK4rpJI9XcCXs6QmLbrNWkd6KNLAuS2scPrJx5ubQN2bSTsJ0tqffCs1eoxkwyhTFKzo3+W1XMzWVS3tYtILfMvw5zyw6/UUuBPM7ja1FvJ11X6B7tMPv5eRjyBruX9tyvDWcYLF07iGs/De00McTfXUx9FkV04Madn4jnERi0c+qJsLbySRdY5Jquittww8InI+LQ5msw7oU3wMrEPMZVQ2KezautkR6iacC+k0xglMpMVPRbZwiOuGb6cYUb6+rWeF5bKIBSclpA/xyi2ZY5Jt2hZQw6hinQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	frtgWbJtDwGxWCX02cdEWT0XE1C8CwK+SyYjp7UIK1dyZpDAjlGhYyVuLYE6sLKj+8OKxER3P9Cj14z0b5Af4MwoGOHjnhY7IHY9kKu6GG0N+9gEd0ZFbMCkZDqMuGBvJTi3BeUyzgW9XOTpqIb9Novha30VFs0sLPu+LqbElatFmOMCDI6tab3L1Wr2hfXHao5ZxUdbRZaPyOEqXR8hFfnYGysxunLrZ5XbwWIexfwF0OsVnGywzJi8fnJsPtr7PACOnuJKgFTgJRPvtF81PhnAs0Su2FI2jmZ7WjdbUwktTywSToOvy0jouYHSRY0Upol+M/H1q3gOzts4Q8sYt16fhhQC7t8PRHccxbNf/AhGLa0/mnIjkR3Hgc0fNe81ag8jsNIOX360waaHZtvRgEHQVrmAkhoxs18UomVh/sK7qZzdV9qXUiRJ3h2hlCDE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:00:59.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bf643c-ef00-4b2d-b902-08df0dcac19e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

This reverts commit 105c42566a550e2d05fc14f763216a8765ee5d0e.

The issue is actually a problem with BIOS configuaration of PCIe
root ports, enabling a feature that causes problems with 64-bit
DMA.  It is fixed by adjusting the kernel adjusting the
configuration of those root ports.

Cc: Arthur Husband <artmoty@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ata/ahci.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9b8c0935001cb..bffe50a109b88 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -68,7 +68,6 @@ enum board_ids {
 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_al,
 	board_ahci_avn,
-	board_ahci_jmb585,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
 	board_ahci_mcp89,
@@ -213,15 +212,6 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_avn_ops,
 	},
-	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
-	[board_ahci_jmb585] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
-				 AHCI_HFLAG_32BIT_ONLY),
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	},
 	[board_ahci_mcp65] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
 				 AHCI_HFLAG_YES_NCQ),
@@ -954,14 +944,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		/* Elkhart Lake AHCI */
 		PCI_VDEVICE(INTEL, 0x4b63),
 		.driver_data = board_ahci_pcs_quirk,
-	}, {
-		/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
-		PCI_VDEVICE(JMICRON, 0x0582),
-		.driver_data = board_ahci_jmb585,
-
-	}, {
-		PCI_VDEVICE(JMICRON, 0x0585),
-		.driver_data = board_ahci_jmb585,
 	}, {
 		/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 		PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID),
-- 
2.43.0

