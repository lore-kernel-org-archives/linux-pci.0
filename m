Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794351020;
	b=Y6j2AAaWKEyJVWB7SItb3vdVNnQEpRsSHWmrI5zj9LLXMi600OYJb0tPKIaNSLWWTLTu
	 mfb25wATdkaF6H3bKugOn5wqcFgr/gqiq5fdPL2BM2slBJ70cBYdIx1EQv06ceDD7MQAd
	 i0M/cowBHwoXjmjArJHNXdvs56O8EOGxIz5SD0QcQcXhDLOv+9dc6ie3Q6yJgaBeBxNN6
	 Jcsyw5idvWWjO5fI4BamLxv76Z0mySPqYpGag3Y4ODuISzk0fUXF7MN47c49ULTL6K4vK
	 dWI3NlInhV6WlvkGW33Mrvb6g4nQM5vWgGi9pnamX8RQMCGuygxRrlnF2ZFw/Or6GGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351020;
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
	bh=T3VoH+xe57aqoNovlPb+sFFzUTF2Qj3qJ4mpVhCpzVM=;
	b=g+oer7ct1v9sPbsDy6gllnRRP0ttVq1kznRfuNlrz6oTdG8V1XnzCZcgnMbj9KMb6+q3
	 dVHQM27lRbAcPQEOleZHvpCPpF203sQ9nqFpYawydQVfk+DIN5OiI0zNzYX5WN2IVLF0+
	 4gKWLwzvLY79lOOZk4QnBRb9GyfPysb2H/bxdeugG8DbxFz8+vpjc1uWp0R39q/YtcEiI
	 gO+hu1OLNquBrkhhFnnwR3g5IH51eWT7UZQoGnYaN6GQQDRn99R2ZjagUKTlksnTC3cbT
	 f152wEtDZoehTTdfQ3gijhDJKe0Nx5PqfwcpiIzSjlfauwq7BSQGnEekVm0gY20yNSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Zk5bjUVs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.5
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A6606A320;
	Tue, 10 Nov 2026 22:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4A6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Zk5bjUVs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozW8YdRGisvmGPpvKsH75WKlrpV49GsBRX20hkSCYdySdccxVXgw7sykBOeW6P6we/qW21Nik789WQ6tU47hsNKHwOGuTcd4COJGB5ssvlO3pUeHmM/wvJKahs7as08Svgqv0uXvmWGepDlH9eRTvrx11ID1Tf6OzLbW2QAqzJ+G+1BvhijhyXK0RKq8Xu+g9yc+VbdvkJLAllREKfeH6z6oLT7PVNvMmButjGPuL1m79cdyV3TfkaibeHV5DXmAeZhcnuHwk3YX/Ongd8wWnpAOuWF14fBDpkiF0N0a8pb5Re/EgCyKGPxbf7GCmK8gcnRlEGlGWzMwnNT3+Tfulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3VoH+xe57aqoNovlPb+sFFzUTF2Qj3qJ4mpVhCpzVM=;
 b=Px/8jPwQe2EdrYATVymXQ79PSJN0oFK+qtUlJA4y8JMLh2ZGZ90z0PymOo1E6LeIeErbvDeBNE4bdBnjO86iAFpwu/CnNWJx+McByzySnTMNyJJfRca4ifQQnulGmdAwk8pm7rptKiL9oFXivJHa+Sx0IqgrS4MzU0znvQDcsROBvTw/lyl6v/IRR58NIi4/sHBvwE1fbnZziEdT4B28PWfdr8ccy1LuGg6hZXasePp5PXrCXGbbaHpgkR5yAdBggJV8CGhoiVctIFFWhDPokMsaBUWPxL3pLhnxp+HB1nWtJfnqrP6n3PKVwgJbrRFLUXLzCSOR1acIh6aK+d53/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3VoH+xe57aqoNovlPb+sFFzUTF2Qj3qJ4mpVhCpzVM=;
 b=Zk5bjUVsImFbM+xSJE78tQzVvRS4kwZTp7ESiEfUDw0f2hs0jT7Rh0DVnSA9KDXbhagK07pRJK0NVHnRwwRGcLSICVPmDobexlodYtI6bAwpT54BaoepXmmcGXYVVzSoBStO2xaXaaoZGZPzeJRRgfDbV+GsHK1LRfsuKIbA768=
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by IA3PR12MB899783.namprd12.prod.outlook.com (2603:10b6:208:621::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 22:50:16 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::74) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 22:50:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 22:50:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 16:50:08 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 10 Nov 2026 16:48:21 -0600
Subject: [PATCH v5 1/3] PCI: Cache bridge firmware secondary bus number
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
Message-ID: <20261110-vfct-regression-v5-1-f49fae981bf3@amd.com>
References: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
In-Reply-To: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|IA3PR12MB899783:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bdc05a-f72d-4bae-1a6b-08df3f7cfcd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|3023799007|261102123227099003|261026121527099003|261021121427099003|261022075727099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zaU4hvgPvJtRqtRnZEP0J5mkRFn4glgN+6LWZzyZZYVEA8a2Cor4kX2WSTgDczQyqGA92/GTZG8sj44XswlaY/uhJwCy1Lj85csVnKdUmxf56Vk9NP4Wrg8p8Z3qMCsD3LXCcCM4fWsoH28AiEgd3KlciNqwFeJ6bNiZMiHdsilTnqEQEO+3nQZA+Ecnq0G7XZ2hEGlPZ/pGptOTSynDrKqwdcGqCo8IkTVVnzOE9HwMTTLIaxuyp2teXuH/bX29PHXqNG0R4tXT5RP3yY3hyebFS7KFzV48gHmu3eb4W6L/6ijgqRzRTcu5Oe+EK9wi42yw6OMmTb0xzxrEPPJu24hZWIOjc4gFVRgiIiTicgks3n54M9K7TXFbY9xa9CT9TNjeo+fNBu+FZk/dnl/Ab6gue//ms/M9e4mFKzLKujBFCgInv2VTZxhl+OqAZaxKkg1tAQ8j2kt0AsrDhWD2hsnlMU3iKMBj3xHUdH0/fOYZ+oydD7ezWDkQoyUVLLyulSCNrDUqxDA6zKHy2kcLJ+GzhFdBuw1/ubrFSR4WHkMeQ6r5yEywOb1vZvQ1eEiev0puug4wQ4FpEWsI8ORaFGY7jmwvvtLS7/Es8jhDBJklvCHAzG5a1yPiCxEnmVw/9hogNwFwBH/z4iEl8hETv44s1CEmpz2XQ5fmzyU4uJsLp16rIGNV9H2MzJwZ8u3+XpsjfUcv9OMSev9bkpnitw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(3023799007)(261102123227099003)(261026121527099003)(261021121427099003)(261022075727099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HKuUhB/wDiBJv0ajsuZg3c0oiMD/lqOcLQ/gyy/gvnbMrca7ah+Hjz4X5kUJidai4HiReWCbsL3ubw3NgNkRMtCRZ1jamUuFF488dTnQLSqnVa59Ppy5HIulMhH5LfCpeSRqWCOn7r9MsD3YeHA8zrmV3o/d1/jOdeyY7FfrAfBxEqlEoJe8SXhJUFZHVvPPY67H3XHdlVUZOfLC6DyhVJzawfvAY6TptIyXDHi9YgI4X458EsHw37LI6cltwBAlNz1jmnv/WUIQzrmiGwc930TFjbf/DOl6rs8Z178xdx5/GtZcTGLoHLltVa363pNMCrE3oJUSGi7oX6CKka7lKzEU46zjXa3Ebhnv+DTFWmS2OVXgQfDzRnVc3yBFs6Ec7MVsPiK9KyHUeiuukG1djkUn3wBHvHv2WYKqL2PDAOA0XL84XfoGcwXzvSyUl9io
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 22:50:15.9449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bdc05a-f72d-4bae-1a6b-08df3f7cfcd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB899783

Bridge scans are split into two passes when bus numbers need reassigning.
Save the firmware secondary bus number on the bridge pci_dev during pass 0,
before the bridge is disabled, and keep it for pass 1 so devices discovered
there can read the original bus number via their upstream bridge.

Guard the cached value with a validity flag so later rescans do not overwrite
it with the renumbered runtime value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/probe.c | 4 ++++
 include/linux/pci.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..14b3dd7dac271 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1418,6 +1418,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 
 	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
 		secondary, subordinate, pass);
+	if (!pass && !dev->fw_sec_busnr_valid) {
+		dev->fw_sec_busnr = secondary;
+		dev->fw_sec_busnr_valid = true;
+	}
 
 	if (!primary && (primary != bus->number) && secondary && subordinate) {
 		pci_warn(dev, "Primary bus is hard wired to 0\n");
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5ffcf5ce8c966..b942dbb4edf57 100644
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
@@ -414,6 +416,7 @@ struct pci_dev {
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
 	unsigned int	pinned:1;	/* Whether this dev is pinned */
 	unsigned int	config_rrs_sv:1; /* Config RRS software visibility */
+	unsigned int	fw_sec_busnr_valid:1;
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */

-- 
2.43.0

