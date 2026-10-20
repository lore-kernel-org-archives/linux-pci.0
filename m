Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792505099;
	b=HM622mG+nMW/ogsR5fud1XCi3ckDLRG+YV14pOpg49swXU+22AKJo4Oj8q38y1F8pk5J
	 +dQEGADpbBoGmyx6lnDqL0TmsFYOozou+zoPJxEgineG+rUnMWSdWsYymPGxwrqkTfdiB
	 xIdWuZpfMXO5JbEQxXt1/4JKtefwKJ4KMzCGPEnti1vtklu/E0C8bSNrT3z6iXnpxiSPo
	 CyNwNI3NMReFW0qYU3Ry/b9i4+82xBT0qYr2dDXMNCRZ43SZJAz/iOCxW8StfrKp1sJYw
	 tWIzYAUIaq5Kq0+6NALHQDRSpPsBDEGebrz4p/2A4LMVLMDKnp3LrwIbLDd1BfzuCQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505099;
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
	bh=qfjEj+0QtpfcAKgWV6lqny3G7ajFWudkbdd/yJx8mKA=;
	b=lVziMFCqh95aXj2Mu9+BA7SaJiiYK54jCJRQjoe0fJ98to4+vLOZwF626+tTKGlHtl5j
	 Mo7lbX0fmj9uWbQXKcI1S0BPeWhmj616NWJfbL6ytjKfBZfTvebx8Ywfq2h49QTSlVAVA
	 aWIcUXmZrwtEV4ZqW00j4tTd138YdjUxFXpZZqNy63n6owXzAO4b7e/ztexwFvGo5RgNV
	 ogo6LFNAia7miOGG7lqz21v5Q7Yr5sgl5T7NyFv8et27NQoXZWe0VaPMEsC+dW9WWpwXK
	 +X+o1iBUUST6lsWITTvB7RbNm4mhg34zPzaQf9+/5Ic/4F1Ar4Z2cexBtzQoR9Wn6Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4oEl1MdB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.25
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C4606A31C;
	Tue, 20 Oct 2026 14:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 420C4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4oEl1MdB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIkbvxTUfe2qM/6F1LaUWOq9r8UHgCHCqiEaScVgkAusBEnrJ63pc1IEWW4StNvNDA+M3PPUpVIigP3HCrR32Ib3gxe4HDPGDErnj1VWxhRX2SA/uIEab+p6twcCbGddPi8vKuSD0Iy9L+DxiZjHvsOIDSiQBER31mhhPhs3AggakoR7l0pO95usBo4riM/BDf2tWWL6D42CFcYVaoidiiqYZ/BYo/h2FArYWHL5DkrSOrMaRh9U8ubeDJKVvL84dwiRv20TX/qizs3IHHKmQ+OScBYS29VQ4GSJ0lw+27Fr1MwjNbTH5vr6W26AI78f+4y+a0H5Hx7aLzXCWQHfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfjEj+0QtpfcAKgWV6lqny3G7ajFWudkbdd/yJx8mKA=;
 b=kXveRjNluj95DoVbrDwWqhUKln/1bUYIG6gDlw1WDOgHbACUXI9zU/KF/1uNieID+NW8Xod++W6h/9w3/N9JxDyrQ935Coc5MrqMFcVrpQVOgarH+jrIpHcPhOti3abnhhgXEEEsOGpXwjxDagmNoI2Qzh1WJ4F3WVC30BUrWIVmvDwCdEQZbve7bZ4Ge/syzQawN23kaS/fAXNT/jcLnIuMIUGsGD3gPCR0AVM3UD0eibpLGDUKiqPG09B+blIf9yxPxzKFk/LQU+w6eKqbmZty9/jCQ9T7DmPMv6Ck1qLoH+COSh1bdpfU/Y4nvxFY8Egb/MGaPPCeqjEU/KwJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfjEj+0QtpfcAKgWV6lqny3G7ajFWudkbdd/yJx8mKA=;
 b=4oEl1MdBnWzPAPcE7EfD2OTk9NWZEl1otcUJWaHeecldCQwOe/RAZyu2c7f+NrC9h3kFf7zWd8vr9vO0lTG0Mw1Qg5xacrqYx6pCQBYkGuSc44SWEGaPv18ozIEdi++xCXdVGjuk8sGN4HByHdegy+xKSKI2fsvOpu2GfjFIOuo=
Received: from CH0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:610:e4::25)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:04:56 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:610:e4:cafe::84) by CH0PR03CA0200.outlook.office365.com
 (2603:10b6:610:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 14:04:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:04:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:04:55 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 20 Oct 2026 09:04:40 -0500
Subject: [PATCH v2 1/3] PCI: Preserve the initial bus number in pci_dev
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
Message-ID: <20261020-vfct-regression-v2-1-d2394d11450a@amd.com>
References: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
In-Reply-To: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0544d246-b434-48c1-5923-08df2eb31ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|18002099003|22082099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VrHLJHl8cM227BT1XrPegvXJZxfoIs7ITubZjdrTQ57+43oU5kE32Wzma0DXP2pvW+SelzyF9LoyDl5sAY+P654eKpUHVuWsTAQlf25Hp+bYhMuiK3DlhjdeiZgzIwytNG0wPW/+YV8YjAVqIwG9bP6EM1WInzm9KT2NEOQ9HKPdH7RbbBQ1n9OUMwEj8NomncMmeoJ/CzVY4yGZwCqQVXg8UJBrYmvPdMnJuVsjuWoOuUPVP2EBofA964/VzY5NmY4iGJ/eob3sb1go2F/AcvrcVzDAKxm2UWljLOgp3rrV/H0mHgvJHx7T6ghrLRHNbsLECZGwNaBINOyTPhZq5meYsGWyCzz58AQbfzo8HVijBzRn2NXM6NnAWW01m08R3XH6fYG2y/vHxjfemgqsKmSGBNpouG4NlFTnGPpG62TRLeTLkSXw+4m/PiC4GPif4eXFawxdS4/siri7egvUF86GdV6WQMJVvDRQrW+q8jICpI5M1nmijMNpSqD5IxnSJ6DQQptBt+7LCGEAt/0MPLP1bLvauYpQSGZl86br5XjSrHw69EYPiTwLs+DzSMTX2ovKuIJLf97OdYHdrlTzc7QgFG6C3Ti09aqrtejze7nKMO4qwKoPwPub/j7RBQ3dN8XUItZPlxtobKz/Ls9pGR2w85QhtxdibMs3B6072WkCqXp/2EoQHluCYNmNvpt2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2K99GaOl9jm6o7XJ/hnBTMn2MuXUUg0Z81LXiKZVFupz/DVyXOvvzH8wbxyz7TLWt1Np4+bPG/EvWdc3JiqgEZ5btIEE6sWcPjFQtzCXim1pmQaHJC8jIDB4h26hF/OEYxs8LZ9q4asRQOk1jGDA9B5FP3kYJb2BgH2w1KITQZrnyDVoxqEUaEuCP/kVSGjrB/YsPFnzMLs8WQiRpRRheyFrYlUHYZIN/s3NKBQmH5tefwLDSK5BZ+QNCGpjSxNXPBEEUIGHeJEIc2uR6kw3ooaL+3alsJi8cnDPKq4c3bl/cjDBCok9+/8sdVHzunIiaOTaHQQGGnjO5EjxTDt31HWHFypGx1zd+VBOBL8kWFppfEguEWp/SbkhBPnzIQTAMLWVHB7SrWCb1xGh3D6BKCSd4beAsPSHe+IvsTWg4NCfHeJ/NS0B7gWiVmdQP/tR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:04:56.1597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0544d246-b434-48c1-5923-08df2eb31ee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

Bridges that need bus reassignment are scanned in two passes. Save
the firmware secondary bus number during the first pass, before the
bridge is disabled, and carry it to the bus created in the second
pass. Initialize pci_dev from this preserved bus number so drivers
can match firmware records after PCI bus renumbering.

Handle pci_alloc_dev(NULL) as well; some in-tree callers use it to
allocate a standalone pci_dev.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/probe.c | 9 +++++++++
 include/linux/pci.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..4ece4b70cdc15 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1012,6 +1012,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	bus->sysdata = bridge->sysdata;
 	bus->ops = bridge->ops;
 	bus->number = bus->busn_res.start = bridge->busnr;
+	bus->initial_bus_number = bus->number;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
 		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
@@ -1232,6 +1233,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	/* Set up the primary, secondary and subordinate bus numbers */
 	child->number = child->busn_res.start = busnr;
+	child->initial_bus_number = busnr;
 	child->primary = parent->busn_res.start;
 	child->busn_res.end = 0xff;
 
@@ -1470,6 +1472,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			child = pci_add_new_bus(bus, dev, secondary);
 			if (!child)
 				goto out;
+			child->initial_bus_number = secondary;
 			child->primary = primary;
 			pci_bus_insert_busn_res(child, secondary, subordinate);
 			child->bridge_ctl = bctl;
@@ -1491,6 +1494,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
+			if (!dev->initial_secondary_bus_number)
+				dev->initial_secondary_bus_number = secondary;
 			if (pcibios_assign_all_busses() || broken)
 
 				/*
@@ -1526,6 +1531,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			child = pci_add_new_bus(bus, dev, next_busnr);
 			if (!child)
 				goto out;
+			if (dev->initial_secondary_bus_number)
+				child->initial_bus_number =
+					dev->initial_secondary_bus_number;
 			pci_bus_insert_busn_res(child, next_busnr,
 						bus->busn_res.end);
 		}
@@ -2508,6 +2516,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	dev->initial_bus_number = bus ? bus->initial_bus_number : 0;
 	dev->driver_exclusive_resource = (struct resource) {
 		.name = "PCI Exclusive",
 		.start = 0,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5ffcf5ce8c966..f6b377dcf7a14 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,8 @@ struct pci_dev {
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
 	unsigned int	devfn;		/* Encoded device & function index */
+	u8		initial_bus_number;	/* Bus number when device was discovered */
+	u8		initial_secondary_bus_number;	/* Bus number behind this bridge */
 	unsigned short	vendor;
 	unsigned short	device;
 	unsigned short	subsystem_vendor;
@@ -724,6 +726,7 @@ struct pci_bus {
 	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
 
 	unsigned char	number;		/* Bus number */
+	unsigned char	initial_bus_number;	/* Bus number before reassignment */
 	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */

-- 
2.43.0

