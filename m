Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794523820;
	b=pcTESqXp0OlkfuaCrPlw6wLNilXRlFzidlm3cihIX00wtUFnVR1waPbI7HU5bHQq5aNw
	 IdRJPeKdR5gXCym0Ez3xXA6YP3qrxPIWK2fV6jmtLw1AB4ZldDgRuFDbzHzdGU3O3UZec
	 4H2EpcIoBpZ+Of2Wi/rbyi1z4wICKXATDYTRhHeYIkpZ1msTtDCOp6qGc8QsZ1MkcYfdC
	 lb6LRLHq6843kl0H/AX4HEt2b7cmfEteAm/WLzdwNq7eDsHcx7jE/uEvS9f6xxxIy3548
	 nx0MkkuXY7cjmHc1bnBQhBX4+qNCKjmBOsT6gROEy9/WBhKo8ut0rEloGmJicbCFwvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523820;
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
	bh=JrdbG21TrC2ruikwQnjN/ntxDrsdas74fpkNWbA9mvE=;
	b=Bv9yt9lhPnx9oFRA+zOVc5vfGx6B0T9n079DkeHYdSzkoJduEALfFVGJFaDoKua61Bm4
	 NfFofQ4nk43vaBc6T+jrmNXYuDUn5kxl6vXh+b9gBGHyiuttjN8+PsHAp1HJ8zlkIl7d7
	 aJysc1JTPb+T74RFxF+hnXejOpksiwXCtIEL1xBwVgCOO5mzOFGtmtDaE2OglqP8ZBSEQ
	 Kv9X5vUL629349J8O9DpJrQkHzQjCVvB32tDIdF/t6cKslvwqm/5SHVcTzARyX9SjzIIW
	 o/cHmlCORIjaHjFQtAoJ1cDI0w0dOZsBHLt0OLoaRfQhiXO8JDSqAzLYUN4Bbn+AKDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KuJX87An;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.66
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A8606A321;
	Thu, 12 Nov 2026 22:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KuJX87An
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKl/DfzsFjmI7BevQFjg+19BR7ly95upNdGVyQ0/kmx7BheGRf1d24Y9BXl1BJw+ARe5ysBy70YwePYJdQbG/DncPCaxBkJ1YruYTjEa2LvwylXCG+r0fcuIe8ya7XUmrDGp39PXaUJMAo471UJTQRMnnI9yfrxEtkR3kSK7WsKyuj22TD/jI979LWHv/r3n6gWUHuE7CPD2qWAfbgidftXMVnFqjR0xLcaCi3HCOYDkpKDiWwClyYUPo8NhobXZwp8LxOpqXeGI4F3JvcbHKUdZi29E5Ck3wa+zxQfaUzMaAETFj+BB9bg1AtZNUcn+/RkBwCI1ZAOa4+eD2Fog2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrdbG21TrC2ruikwQnjN/ntxDrsdas74fpkNWbA9mvE=;
 b=apwz5MN6POxVV7Nx/a/CTKfgsALSwsQxKPsweQvwDL39zN0e3XzyU0WIZfHPDqosHihlS8a2hpDQthV/1m1FY8Kb+so703X8G1s+BdY2C5SNo8X+eceJ4Ktq61dHU8b/1mUdPrI7TR8Rj2EiLc+h4gWInp0Asbvpac9oXHZjNdPC1OucCzWRB6ZbIAc+DVpXsmzRLQ9OTb6Zbm/itz+gQ8LYhElrsUeBqcaEMphBOrgbFdDzaBPJCLJsgX7FNhS6BT1y00mx/k7RETyaS1/A2VAS2/iGfYUk+HP3zMS1Fc9DSlyX4/KaTo542JtQHlhHxnn0SKc8Y3LZcXaVlSf6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrdbG21TrC2ruikwQnjN/ntxDrsdas74fpkNWbA9mvE=;
 b=KuJX87AnUXHVXRSCubXyPudvt2X5i/LyoyQ3V8S5vc1cHiMOAp9JuTfVRLJ3oDX5wdon4Fv3S0nsAVbLFRIuwGB4O3jTJvLIt6cDMYBHDfEP8NVsCesaiXTOHhisWHQ3sib2rHezfVpWpC8L3cydLqsCtWMDVxgZ2vsOZvIxQyA=
Received: from DS1PR05CA0018.namprd05.prod.outlook.com (2603:10b6:8:23f::14)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 22:50:14 +0000
Received: from BN2PEPF0000A990.namprd04.prod.outlook.com
 (2603:10b6:8:23f:cafe::57) by DS1PR05CA0018.outlook.office365.com
 (2603:10b6:8:23f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 12
 Nov 2026 22:50:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A990.mail.protection.outlook.com (10.167.248.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 22:49:27 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 15:55:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 12 Nov 2026 15:54:53 -0600
Subject: [PATCH v7 1/3] PCI: Cache bridge firmware secondary bus number
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
Message-ID: <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>
References: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
In-Reply-To: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A990:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: f011a005-de83-447b-d8da-08df410f34af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|3023799007|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	XKUyPri5aaTvT94ZHpcIDHlbzoVkBGrPwRh6ohSdH9eTVRDRraSFzJKPQx/68Vilf6hS3BvgIk07XEkgGPBxCffDb7zIUhwdpr4idn6jgLZ4O4aFduMIiBCcvxVUmO2moZpitL0e12uLh9nknpeq1zClNEtDfTXjTHqWcJhFMMLRjUusmqOQBel00qi5GQTz3kMHg6J4MbzP8pTF2uqQcc9Zj9TdDVhjM10Lskb8e+li5l9Yq8eOWqhroXJ2TuIll06dhY3RE6gxsbRSTvI3Ne024XeQbJLVOVdr1N4TNaM3ULzpZd45cD5ysvlxfgxhaODua5rW62ppo6HxiR1tbNq4JzlvKWcwmP1laUUeIkBKVFyruA4WbabEzH89Tn7ZMub2g+wO9qdBKbdxQwMvx4cljfi5VuN61EuhkfoEmGU0I5EdVDhlE0LlnzAKCBr+r3tJokaLrwXCJFXJyBCW6zWv6XJps/waGzLmulSBXas2p9fe7Ii+eIfZsuFuI0rFDk6SUdfrKbAhwQkm+dFulFfWHgyaG1DcU4BoRN9wqQl6TRmcrfTTfzkeEGqe8YJvvDCmq7TotcOSLv7Fg65foKRge8O2n5cBQkT83IFObVlATgxjeusv3AsrPTlyqAY/kofLhy0zgtc9uXH7mz2NWPIZvbafafLaBtsIY9WCOV7H73/WVX4JTZoJiIqKEhkAeFtZEZPpcTMn23K/vAlqhQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jQo5w2S8UBDvnAkfUKA70XNQX1F99p6AEgsa6kEb3ByPuLji0oBDD1+GPAWgoBWXssGbOBMY3fjlRjybaKWjjg4lGeqyjXwlCjzNJwlmn6nFyNaNCiJvhuAN3cuJd5H7aQZenrFJmoi2KMVRvx/JQo1csMNfH8Q8VWZaSfjRobsZVJvhZug+CoGKrrPLHnujHKQg+G8npXaTTxeGLzz7OIvywyjo2zdgVM1Vmfc1iczLfrJsMdUrEm8SN9nbx5AfZ36upjJNrq4xLN5V3NvTgGEOZlrGOnHbUMC9xEHNjkvzsFZxZfO4kFKj2QjkRbhH1A34P+lj7GrbuCZTdYqTTyexcwmuMX5TBnqW0c6zRP/u4nINK4OBzIcNh2loYNkqNrM5QceInRyHZmCnc5KTfD6XdCgu6M0rcqFs6uf/2l6RNBHKcrq7iKxEV2tnT2BN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 22:49:27.3809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f011a005-de83-447b-d8da-08df410f34af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A990.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332

Drivers such as amdgpu and radeon need the bus number firmware assigned
to a device to match it against firmware tables like VFCT. The PCI core
may renumber buses (e.g. with pci=realloc), after which the runtime
number no longer reflects what firmware programmed.

Record the firmware secondary bus number on the bridge's struct pci_dev
the first time pci_read_bridge_windows() reads the bridge's bus numbers,
which happens before any renumbering. Devices behind the bridge can then
retrieve the original bus number via their upstream bridge.

Only store the value if it is usable: ignore unconfigured (0) and 0xff
secondaries. Use a separate "sampled" flag so that later rescans, which
would read the renumbered runtime value, never overwrite the cached
number, and a "valid" flag so users can tell whether anything was
recorded.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/probe.c | 16 ++++++++++++++--
 include/linux/pci.h |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..f20a4b8f7a23b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -505,14 +505,26 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
 static void pci_read_bridge_windows(struct pci_dev *bridge)
 {
 	u32 buses;
+	u8 secondary;
+	u8 subordinate;
 	u16 io;
 	u32 pmem, tmp;
 	struct resource res;
 
 	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
 	res.flags = IORESOURCE_BUS;
-	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
-	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
+	secondary = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
+	subordinate = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
+	res.start = secondary;
+	res.end = subordinate;
+
+	if (!bridge->fw_sec_bus_sampled) {
+		bridge->fw_sec_bus_sampled = true;
+		if (secondary > 0 && secondary < 0xff) {
+			bridge->fw_sec_busnr = secondary;
+			bridge->fw_sec_bus_valid = true;
+		}
+	}
 	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
 		 bridge->transparent ? " (subtractive decode)" : "");
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5ffcf5ce8c966..045157488b8e7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,8 @@ struct pci_dev {
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
 	unsigned int	devfn;		/* Encoded device & function index */
+	/* Firmware secondary bus number saved across bridge scan passes */
+	unsigned char	fw_sec_busnr;
 	unsigned short	vendor;
 	unsigned short	device;
 	unsigned short	subsystem_vendor;
@@ -414,6 +416,8 @@ struct pci_dev {
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
 	unsigned int	pinned:1;	/* Whether this dev is pinned */
 	unsigned int	config_rrs_sv:1; /* Config RRS software visibility */
+	unsigned int	fw_sec_bus_valid:1; /* Firmware secondary bus number usable */
+	unsigned int	fw_sec_bus_sampled:1; /* Firmware secondary bus number captured */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */

-- 
2.43.0

