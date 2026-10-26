Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029744;
	b=SlrIezfNAsvxbvDUH1KN29DdYAe1zn0Yl89afRiz6abP8a7nF6iE25lUEpUgYUoWS76D
	 DrY6/gPBGpm5UBA3pAxGcBGlDt6ouUEopUNpt/LFFI05AVNzPBPCuei/B++slVrHtgoRy
	 GpIohyDftiFLZOt50vfBsUMPJxa1VgTg0iRvjczfezbrJciasve8ugW1STJZN5TBz3ecD
	 hVEOU2fmcSbxUkXWyJKb5j/vES5WX/cmGbA0mVCLKcP0hGtoaLB/WMsvJk/9NuxCb3WoM
	 k+XiFUHuP29ELhc94uWqUy3Si+PuC9fX1DPQNCT0CwM/tZUcDMKoh5uaeu7fgjtdomw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029744;
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
	bh=5zZecloCTSpg37x6b5RH9F2IkJlaCw2rwn33pgqJ0CU=;
	b=UAb0tJcoqNJLiTfpPiNTLnsuDJPEAu0j9PZo+AkSfnr9x8q3lwd68Ho7BNimo513T//4
	 a+f0MwYf1zIEioue9+7jXznajxgwpn/FFp3EzYiJ8yb1MJxPoH8LDrFmjYgOqFS2v/YZb
	 P7OLrVXl/xE5I1HO/zjpBU9FuYQLBrjvotEio9qwHLe8j9p7IJ7Xd0WQFFitdrGgYBaXh
	 yNVYkMAErcqv1UQ/ZJoG0pY9GXw100m8ZxLs1BBbSePm+iziHgCluDbw/mnwJiU886dr+
	 WtmeqV0GUbZt9vFVRErz+jn0mPcAi4FEe0ky/2UN0FV+bPzQ7knZbYf+5o2/fBxRfXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=shaSTnvu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.58
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D1606A333;
	Mon, 26 Oct 2026 15:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0D1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=shaSTnvu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKd0Iim2574UeKN4oYEhS7K4T6OuwTARjwli9WJzQeNE8TXfraQHIGVwuL362qw3H08ZfuNz4QWjOiZ0edp7mf0/GtW0wcUWnyHWD9QFKQVrVIo6KZoVoHjgviLWdOVVlkiQWDsdWq61Ga2EMELrIS4Yc2VLivbAOFsWOOYFK6GIzTzVF1+dBRMVd9CTs/Qeb9AY63pkTe1oVwqKMC0TjAwjDVVKJQym+Tm2sZ2b5p5iKTMyM/D2WWt0EJUgxuWIkyLaiJKY5FBtMUI6WwEuq+OaCHRsZMMl9fuJOO98P3zfShNDWhYuRshtoB4F5VlqXbTAlyHMTLWO6fXpbewPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zZecloCTSpg37x6b5RH9F2IkJlaCw2rwn33pgqJ0CU=;
 b=KSEDfrUIBznRKgtHzadkA6GNT4ssC92Lj/q5H41+ddczrVhquTRYiJ2FBKZdkdlA1qHO4EaHj9dTC0UqIxzHpXDFYvpBpA1p1UTqfQRxMCdCADavKbxweOa9f8tUq4jW74rTPHA9Eyd5nSSZDExwK+gGPXIpdMGMjsFg8+hFDY6YjpdjaL5wOX/3orXRFFP1aR/Is/ZtpPv3L+edHAG67C9bGsOIo7CwzxHQ5/NAkRIyCQuhaqPUQJxPrKbHRJ0NkQ8L+SN2c6GVTgO9wWRzsMNgV7hWnA9YdrBme0P8Keeaxgxltmq03T6k/8rl/GjF/7KEqYscpwi3hZjRwYWsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zZecloCTSpg37x6b5RH9F2IkJlaCw2rwn33pgqJ0CU=;
 b=shaSTnvug0rqhiYHXRFCDV+nzrEB9UbPY5o2daOPwnUg8s+bZEg98bL2EbduuUQYq+YGcpqKpLoDItrd4HF7ZQ6aflRYQCUJcMK+m2Y0ILxJc52uxJA7B2tDWmKASLIqYFqmlUJvp6/m986BhQ+CJupKDPTdgYsvS9ST2Ah5Cfg=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by CY0PR12MB708545.namprd12.prod.outlook.com (2603:10b6:930:130::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:49:01 +0000
Received: from SJ1PEPF000037A0.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::7) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 15:49:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A0.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 15:49:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 10:49:00 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 26 Oct 2026 10:48:32 -0500
Subject: [PATCH v3 1/3] PCI: Preserve the initial bus number in pci_bus
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
Message-ID: <20261026-vfct-regression-v3-1-fe9586ed6978@amd.com>
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
In-Reply-To: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A0:EE_|CY0PR12MB708545:EE_
X-MS-Office365-Filtering-Correlation-Id: cae83bc4-801a-4f0b-689a-08df3378a80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|261026140227099003|11063799006|56012099006|261026121527099003|10067099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/SU+HaX2tiyDU+Kdj7G5WPUseGnOhTeDVsDn9x8mrjBty+bIGRjfdrgrZ+XBsmJk/PTozMoaUSVMAknXxGOU0MreuM02r7y1qz7Ujg2lniUu/KRGi98lV2U00GIwqZDg7rTyoiIIwts3TcA16jfM/6IVzJAPy84+gJfclo1ElrF2qVFafDR8vR1rGwCpN86gHvOmO0ViETVxzf++rRFKi60P3j4kuTXkub8gYzhCHqftRv88k5wYwGd8WwB+Ic5xi1q3I6QGogTjLeBtl5RnFPb6f4+/F7Mnk8xLq+ppBzFg2V6gL30U6W4FjsBt65pDCTe9Y8N4lJd09ZEDNbmUTAX+zRqdqU4nHUbHLUtwxCWAd9qVRFQtTuRoAMwS2SrbGgURz0so7Xxhl+uFWvJZiMvpGDFHk2IelAlrVvcWmLQT0FzImWBhA63JdEw+K0Vw+hckhmbOX1z/MbIB2ihmQtk5+7bFfcVkzS/OgwD5y+NKr2IS0Ev9TqhAWGbV4PVEuFlUFKDwm/+zCd4pPPFD1OOt19PPVomQ4R1kEkHHgz+4xsqv2OEiSTnWctYTS6YDysRnGflqcqBi5JG5SMvIB07YijZXbyPqmuKMDpISnIE1zr4rM/tZY3frlD7scvK2lV3uo3t1Kh6sDSMLsKzkF8edj7zdKAP8vXC1abd1eGvjAmdAJHBn9Z07AI25mdzKefVLC/bxJpZvzgof2QQYSA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(10067099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u7yqwbqZAxRmRu/k3x3ehlwhVQytv/wit6EIx1kr3kz1IDJ8x/6nQNXZhBHBrehaWmuxqu4K3AlI9QmDLTv208z6kslBg5QTjn15bLQ+lBheoJ4LxSthyPXm2Cpu6y0xTI0i3I6Bu3PBrCrdhWVa81lq1Tq/Ll9K6urFeIpUCPxhxnjT+E5GDmIEa+dykndgHNpLvQPH5GlxQnWxwdTwQ0ezE/ZhdFkD4RmTzrRDtW1qWCnEib6qwKCZ8JdTFSv0+fvb/3LUXPYbFbhxo8p18Fnv2ITUnmDTmA480RSjM7bOEJFmZ+QkhvbMkXBQvYz0TaFqr8c8EDzoLn5IhaMj2r+IdzXgjojXdSisain1DSqcjXt6k8Hv6Ywvan3bb3W1L0zmL6rAt+a+bsIV5Ojp/C6+cMmN59GN99KB+KOPMHYsnCfAylNZAG9VpTnFm5BB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:49:01.7236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae83bc4-801a-4f0b-689a-08df3378a80e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB708545

Bridges that need bus reassignment are scanned in two passes. Save
the firmware secondary bus number during the first pass, before the
bridge is disabled, and carry it to the bus created in the second
pass. Drivers can then match firmware records against the bus number
from before PCI bus renumbering.

The initial number belongs to the bus, so consumers can use the
pci_bus value directly without copying it into every pci_dev.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/probe.c | 9 +++++++++
 include/linux/pci.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..9950a9dd1db1f 100644
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
@@ -1232,6 +1233,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	/* Set up the primary, secondary and subordinate bus numbers */
 	child->number = child->busn_res.start = busnr;
+	child->number_initial = busnr;
 	child->primary = parent->busn_res.start;
 	child->busn_res.end = 0xff;
 
@@ -1470,6 +1472,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			child = pci_add_new_bus(bus, dev, secondary);
 			if (!child)
 				goto out;
+			child->number_initial = secondary;
 			child->primary = primary;
 			pci_bus_insert_busn_res(child, secondary, subordinate);
 			child->bridge_ctl = bctl;
@@ -1491,6 +1494,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
+			if (!dev->secondary_busnr)
+				dev->secondary_busnr = secondary;
 			if (pcibios_assign_all_busses() || broken)
 
 				/*
@@ -1529,6 +1534,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			pci_bus_insert_busn_res(child, next_busnr,
 						bus->busn_res.end);
 		}
+		if (dev->secondary_busnr) {
+			child->number_initial = dev->secondary_busnr;
+			dev->secondary_busnr = 0;
+		}
 		max++;
 		if (available_buses)
 			available_buses--;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5ffcf5ce8c966..75a5fd2374acb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,7 @@ struct pci_dev {
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
 	unsigned int	devfn;		/* Encoded device & function index */
+	u8		secondary_busnr;	/* Original secondary bus number */
 	unsigned short	vendor;
 	unsigned short	device;
 	unsigned short	subsystem_vendor;
@@ -724,6 +725,7 @@ struct pci_bus {
 	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
 
 	unsigned char	number;		/* Bus number */
+	unsigned char	number_initial;	/* Bus number before reassignment */
 	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */

-- 
2.43.0

