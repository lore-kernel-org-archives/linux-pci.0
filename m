Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118170;
	b=P4dCGRXCW7jEGW7IfsBUw/aMY/qxrAf3CuzoQV2MNe+HiVYd4p4bpcpiGlYHc/QXVT0O
	 1QP5V3cIHSKGOZtGJGNgaV92+z39YWgV/JLzx+TWagSIDmyXiPgJbhfBVXIPs2opN87Qc
	 ffCwA3SwLOk82SxQ5hwf9MoIN9BNbVsEuK3mAYn8MASb3OsgkYMT1PF2qBa3IkOWOFHrI
	 rIcGn8X5DYjt/8a0uTJZD70Mfs6VMDnhmCc0W5uyd8uBzrB+36CX8v6ZU/RERsj4IwqfX
	 vDtrEVq4Rj0F2f0G2XUNiIJQp5mJPX5p6nSURcg1hh2laFYx8if36C+8fgkYXDKWksw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118170;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iPxRuAD7btUzrPn1gYg2KolVQ2GjDYy44BASlQrs/Vo=;
	b=eIuZHFYlpfFGZwTz4kBDrWYupV3QkRr38WOqYc2WaRwXNTO/qlNtihZY5c6+4fGYm+Fa
	 mLm5dnv2RD4ekiNLOiEUZFUP6yQdGGY4CwS5UGMm2TgOwqe0n7K9p7XOlo8rOoHNYEI6w
	 B+NdgFQggbzMn9zgWbq2PsyjMn3nqpSLr7tjmB0PuvET64gUeg1Iy3+oHslFF2wJbOJIq
	 tHnrgxAjgkZShWxi8XDuGNeaFgEsY5Nod/NTjjGbi0BXt9z65RCVGrelye0kafyiQHako
	 naBPSal65M/b2WytXI/fcZJCQ7WSySs57d7VfFZ+My6DHZ0AKhByw8H88loEVm9/G5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3ncbhNHF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.54
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1037606A322;
	Tue, 27 Oct 2026 16:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1037606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3ncbhNHF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjw5DF46YDJ1GXfFLKDqhnX9lSMu/lrS1xdqSlewquHk1HLU7a8nhKsI6WIirNy5o9uXFzeo6Y+2g0PqRusPta3KDDaDetiC9EVKUognvsbif1Z+D2ssN7hlUx2uszANcA8PZ0RUzRnvYywDWW82zfnboOv7WOvkGuzSIEYSi7QSQl2xCe9c0qHk5V/fL85D/4EJRcVeYUZltr3LXwg8cfmmneWFkSyzmP/4I+GUfEy1ImQ/z1KXY+YwnKpcxm9pWMUmv1Y7znU5qkNljNBE4sIaYFjF808pwc1Ol1Ldh+418X5F7ho0h4voJAK9wFpMvKVaPet+T1/1QXIARCmbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPxRuAD7btUzrPn1gYg2KolVQ2GjDYy44BASlQrs/Vo=;
 b=qvfarhLm7zdcoz4wyp98t3PEgdd1rAP2RyaBsHKM1k0WqW5qhxer+zcuXzOOoyIGHJ3iBTg+Y6QNsoy8eoVzzlhYpX8yGnP8fing+RUANBNPrCCi0XaACDY7kMXG15OCMIjaECm6swodWkc/nyQ3+Waa0FlLvZECne7BdxvKgkiCE1YQ0V144wGbbZxEZLPjqiXYRkpCOg11UDE28cjp5ROF9QMlqo42v2g6AmytZffa7+YtRc8ae/3vQUQThDVP86wTmo8LwtjqpFTfdD7cQdmABDMOfntzwq7lysX2ktFktvAkg/Zeb3N4XSrjB/0P9hJeaAiR/EIF2lOEyyJCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPxRuAD7btUzrPn1gYg2KolVQ2GjDYy44BASlQrs/Vo=;
 b=3ncbhNHFUVWqwEioSIVPOaaED6wy9SgedUVL7UFWM41ZOzKn0cJYGXaaRzSAf4N1Er25dAqfv9eWxk2ToVJz4kq6YbupKVSDwMU2vBRQnPNX8aCEjA0miU0gwa2Qypcrv9ABUDjeGj0MRtigNcjt1AbntUgdD6d3Jo/ejiakWLc=
Received: from BL1PR13CA0393.namprd13.prod.outlook.com (2603:10b6:208:2c2::8)
 by DS0PR12MB999265.namprd12.prod.outlook.com (2603:10b6:8:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:45 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::22) by BL1PR13CA0393.outlook.office365.com
 (2603:10b6:208:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Tue, 27
 Oct 2026 16:22:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 16:22:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 11:22:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 27 Oct 2026 11:22:25 -0500
Subject: [PATCH v4 1/3] PCI: Preserve the initial bus number in pci_bus
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261027-vfct-regression-v4-1-0e7190e39c2c@amd.com>
References: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
In-Reply-To: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|DS0PR12MB999265:EE_
X-MS-Office365-Filtering-Correlation-Id: 77525da4-92cd-4b03-3ae4-08df344688b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|261021121427099003|261009223027099003|261022105027099003|10067099003|56012099006|3023799007|261026140227099003|18002099003|22082099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	5AMlihQFt7HFGg7dSz8PL4A0eZxBHR9824lbrBcfNX1kGtDomriTneFEqEb896xTS36RDfgCxQaP9aPnTHoohQn2kdvFo3lr052QlppbkyduUtn6rfgnEP0bM1HFPUtpyq6ybha75Cc/eHQzFySkrwh03fH3NbgY31pZA/1reamWZc8nGC3z+AJq3aUQ4ZcDJSHx9MdiPYbLvR2nUeJZI6i0IDW3BAeU4+fgVg6FK25Hgu2BWzavTO7MEprGf+Li2tNi9BqLfFcL/9hZuaKEPJgtBYoupF1JU3ZJcj5fJAz/gOVHBazfRXymIaMgxaC3duFzRPc3B8XZFqG6SbOe7X5vt3H3jYrCfjTYJQ8unTPRV1pKdYFdz35zOdP0Lf53TIzMeuNQsi5O66A/O0CdZWpjXYS/qfomJp/BZG4Mgl+uKRkuoGFIxubdLPAqudGr+3Y4zcuuL0TOhu/wYDbpeYdyTpft6RLm764xOLYX2ud66VAosFJvdeYkXKKIwzP1XczUmM88Fq08cbzaOAO4vkasObgQto+X2XJCvzuTA8vDJ7gSrh4yP/LKTaX77pik3JT8ijZ+QCLcyY3tAj4tWouoagWSeSf6dh5lhE26WrWeGDDl0AZIy+mn1JMkSqxd5LmuP0GceEjeLDa8NAZsEgh8pa6xrEkkxqjsWsfth3q2vgHuXpvcWfZ8me9mhH45WJhW3Otqtbs7hJG+9zsDkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(56012099006)(3023799007)(261026140227099003)(18002099003)(22082099003)(261026121527099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	see6NoEgalNbD1fgHpL8edEEtVZ1Wb3FzjMAN2t+xEojc+IKHg5xd8VlnY+9yv05eV59OuRRaWYFsEzm9sdrcX02foIU7Ixh1KwZn6McI4YmjiEP0ejgPl/EwHwrzQZXqOR1BHBCEOQESm8Sm2YKJNxmOMHQekO95Bui6k2q5c4X7bZtCyE7W6a/b8usfRs5C+MtTC64PvSn3e5q2gYq4Jp07+9SnG2SznfTsuf61L1kKBf+1ifaSsdvo0NfxVzRC3p3lQrEOA7pkzVv73E8hY5XU7m3fui6Y6tSE48sD1pGwrRfo13kyJovAMyJBc1jAbZGqSOtFX6A6Ru4+mlbELHgcJeF0HT5aice5H8aF6pg59wv4GAs2pqm7yFekqnThgKhdbdIlNq4FfMd0h7CK9wBYji1wUAUck9hNIPdMWkySjz2B8REV1NZA02rxfmx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:22:45.5122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77525da4-92cd-4b03-3ae4-08df344688b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999265

Bridge scans are split into two passes when bus numbers need reassigning.
Save the firmware secondary bus number on the bridge in pass 0, before it
is disabled. Use it to initialize number_initial when the child bus is
created in pass 1, before bus registration callbacks run.

Keep the saved secondary number on the bridge so a later rescan does not
replace the child's initial number with its reassigned runtime number.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/probe.c | 6 ++++++
 include/linux/pci.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..3c03ac22223d9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1012,6 +1012,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	bus->sysdata = bridge->sysdata;
 	bus->ops = bridge->ops;
 	bus->number = bus->busn_res.start = bridge->busnr;
+	bus->number_initial = bus->number;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
 		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
@@ -1232,6 +1233,8 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	/* Set up the primary, secondary and subordinate bus numbers */
 	child->number = child->busn_res.start = busnr;
+	child->number_initial = bridge && bridge->bridge_secondary_busnr ?
+		bridge->bridge_secondary_busnr : busnr;
 	child->primary = parent->busn_res.start;
 	child->busn_res.end = 0xff;
 
@@ -1418,6 +1421,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 
 	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
 		secondary, subordinate, pass);
+	if (!pass && !dev->bridge_secondary_busnr)
+		dev->bridge_secondary_busnr = secondary;
 
 	if (!primary && (primary != bus->number) && secondary && subordinate) {
 		pci_warn(dev, "Primary bus is hard wired to 0\n");
@@ -1470,6 +1475,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			child = pci_add_new_bus(bus, dev, secondary);
 			if (!child)
 				goto out;
+			child->number_initial = secondary;
 			child->primary = primary;
 			pci_bus_insert_busn_res(child, secondary, subordinate);
 			child->bridge_ctl = bctl;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5ffcf5ce8c966..c607818a98a87 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,8 @@ struct pci_dev {
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
 	unsigned int	devfn;		/* Encoded device & function index */
+	/* Firmware secondary bus number saved across bridge scan passes */
+	u8		bridge_secondary_busnr;
 	unsigned short	vendor;
 	unsigned short	device;
 	unsigned short	subsystem_vendor;
@@ -724,6 +726,7 @@ struct pci_bus {
 	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
 
 	unsigned char	number;		/* Bus number */
+	unsigned char	number_initial;	/* Bus number before reassignment */
 	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */

-- 
2.43.0

