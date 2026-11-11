Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794415430;
	b=ZIJGwvqex7/rf2zPSUkD01jTYN6QT5b6Uo29WLfMNCndDIkIqQXLS3aIqmXYVADkaMRM
	 bxFzbndCsbrRMz92CcOcWqNO+sNa5iLyky/9wvFcVw3qGs232ZFnebRjchwh+rqvjrYOU
	 4q4cViyAU040GP4szF5jvO3i+Q5c/nuSpNXLHpkPMuu/3mjK2UgdQ1jN7c4Y3O521ng1Z
	 3NShXaYcAlmPgeBgnfzwyo5wK/fZ7K7mQtlwoXte2Otj3ilOBdz1DhXbUBRHUZobakBxd
	 cxAujpte6MKRfjqxA0YmCYEHG36DOijJ0CgvUU2WDa8lRSHp+b4LAJadGgebTwQA6UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415430;
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
	bh=k5wy3FkSEjxSvPOk06r2FZAEDkpjh8xts2NVrDb1/Ew=;
	b=oW1EFKaaB1RnobihofSO7LvQDqRdoBkqUsTHOTHjxGfB2bzydZXYEjMR7NbwK1iwgDJS
	 J4la1JTevpqYgEAmUIEkvHuRII627QK5Owjk8U87K9eMG5BGhW16zpOivwa/eMIaR5Xpg
	 lx29bSUkM8K7z1b2xjgwqnIL50MHIRfQ0/GCqAUl9CJbO8PWc29kgfTnSywq8Db6fUd9M
	 hwptJxaZ5gFYKXQwc+I5meMls9CzeqF+fbOhNzndBrRvuG6TaCVGEz/Uf6ZgQJaCNXZky
	 oyYotyIZCvks3l9odNmtDqTF9T5zbRZWcuhzkLyJmGwCqw3b/aUKeSYDfLjdEMEnepg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uN7dyTP2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.63
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA23606A884;
	Wed, 11 Nov 2026 16:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA23606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uN7dyTP2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYvu7nemI5IHCG1zVEQhjqyh1/0PchBru5f1PpMhgJMrcBgzmuw9TWbTd+AdSZJGw9/mxRIg43vd9p1zDMqt69xcPtAS9TTV6PbFKwt4r1ZcV8+idzebsNuY/FP2iIJd/pI8Rb5S4nAdxGF2epLbfsoxAOBYSxI1/S2V5eXUEv2OI8NBG5qdGNnAt9ACa6wvDl5+d6BBapHncyLVQDDlPFi+ulonSsuwTmYEsW1asuTX0DblGZ/jscD5YFn2U9Q/IwdpBprtUyX+41N19dY4LoMOqComSWws8OcmfNHBp+GOnQ/zHqgtKHd+6A1KUkatkWyKYZA4j6jMnme+JLul3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5wy3FkSEjxSvPOk06r2FZAEDkpjh8xts2NVrDb1/Ew=;
 b=s46ZKFHw4nJozV7JtDfpmBM0MzsafopeMFcGuCrhBkxPo7c9K1TXoMPp/pelzptX0AjGZgWwofTvw6Mwyecm6izrhFMLrZlpqD3113WaStWC3JVeARo8pgn9n/5TpgBsXdw+Z5wMNp265LNLu95mQsnAU+cOgp5dPn4kSIwtTP6Bs0z+yipFb+ZI4YNmkhcRoqNpNk9lx3BVt6pQ2e5uqBqHfnHXzP97zIJTdRM/AxImCWiJqIUEG7czcD5eqgEEORAuJRz5EVr1EVSVyqiMLd+gJMajFME8tK8G7zWjXnSLHQ7e5/O8INEN3LTPOu7+yyOCAtfTnzRhP/JifEmC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5wy3FkSEjxSvPOk06r2FZAEDkpjh8xts2NVrDb1/Ew=;
 b=uN7dyTP2IHcB0mJzZY5fJwnWBZAaSh1T1xC7YH8+jP09/JGoVoKsk5gqUDYSR+NcYRtckLQr5qp9v4ytgXdwWEFyq4oXzQq+BAkFoKiDdRKKYb/caQDdeZXv/T6e79W5Ku3U4Ob57jI+OAS4eCNWVlHWtqsFTK0yWWS+svtUULs=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:43:44 +0000
Received: from CO1PEPF00018868.namprd03.prod.outlook.com (2603:10b6:303:8f::4)
 by MW4PR03CA0002.outlook.office365.com (2603:10b6:303:8f::7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9
 via Frontend Transport; Wed, 11 Nov 2026 16:43:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018868.mail.protection.outlook.com (10.167.249.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 16:43:43 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 10:43:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 11 Nov 2026 10:43:20 -0600
Subject: [PATCH v6 1/3] PCI: Cache bridge firmware secondary bus number
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
Message-ID: <20261111-vfct-regression-v6-1-393797bbb6e3@amd.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
In-Reply-To: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00018868:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 14de68ab-c7c5-45f6-6f9e-08df4012f30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261009223027099003|10067099003|261026121527099003|3023799007|261022075727099003|261021121427099003|261021123027099003|261102123227099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EamC+/K0CP2ahX1WxC4Vu6Uiz26DkIdZcdGQ7ndJ0jWDqdgQgZ9zd2SZiQuVj6PdXcJMLBCgOxxfuwE6CpaNz3tDztfkOOOYyKaTOy6q5x7ktvY5GX1oY/QA4oBP0J6kZGIuz64ufkcozdWiKtflUqI8UwdHl25nE1eUnrC7cNTn3Hvu+g+vyxRI+fv+yj9mHx6yhw1aoNmUs/b0qK3QvMNzQDoC+1D/LhH87PrlFSpojnjTYc69whaxpI35bCg62ihUJLUQxvB0n/NTMWQK6IWYPpH1wiFyIHv1XFvxR/ISkgqLFs3B7qqzkI4tQAlLF2HoJSmwcPGI/np3uNY+9MRD0Xq9VrRAjXg/3fHNty+8CXggSlmKtbzEuVnaIqqFLs5oTGpuWBoVlbOkwQRK4ix1KtQznHiMvdQ6UKrMenepw5GLNM6vB/7G2MmpU1+8qaJSiwxPDN/DG0W4eAgtsay1auLfqZzmKzlvJRT1JUV+pwo2vEuZa0UpICLKpPnWMU1cHnqc5CYPeCPa6iU7E/I4t0akqsxSsYiSef0IBCV0g2Ze3GPi6tbYTuTns1RRWDR/Fk5CH/bM0UWARBWkVtjJUoRBR3g5atkJW6IKN1pL8sx6bHXcykKJFWdc9fExqeNI9OOuXe4E9EshiECMgZIDjc7eBV0/wLesFb95h5pVURUv3pVCrAKQbHevl6N1C768C5hwc/Rqtjl9TZCnAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261009223027099003)(10067099003)(261026121527099003)(3023799007)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RLwx6QpL/+N7Iy4AGJXMd+vtukC3SL+/Xwi2iT03fuZxCzNRt93fCVon1dtsua8nX5BCm4qQLvgX61RtO184BXYeRoMo3C+nQdPmMKWxeXQ/KA0YChou/CoS6Y33R2YtKP8TlhXWc4VWAHjRiXsNuvQzsnL/7te52YUzc9o2uSgjIAjCciXaqJipyIJthVys63V2PZ8RfOIxTpkYdHVddiNq9eonIml5y9/IKrtC8BZLcqayxmipzmT8mKqxWPteBSpnSCk2oyrbsxOQ0+WeqvPDPSeMmw3HtagHzQO2fYtzo8C9IpqeYWGDyXof/RoehzdQQlJalCpxV8WUGWYuXXYofSliRXWY8QinKJJygwkWbejMQoncyAcRHCE/R/PuNyAcxBi69weMHTIgFo4iNjfHQkNbCmNgvDTYPGo2oOk9//S8zFFVxk53ZqB6VB70
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:43:43.9797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14de68ab-c7c5-45f6-6f9e-08df4012f30c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018868.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

Bridge scans are split into two passes when bus numbers need reassigning.
Save the firmware secondary bus number on the bridge pci_dev during pass
0, before the bridge is disabled, and keep it for pass 1 so devices
discovered there can read the original bus number via their upstream
bridge.

Guard the cached value with a validity flag so later rescans do not
overwrite it with the renumbered runtime value. Ignore unconfigured
secondaries and remember that pass 0 has already run so we do not
record runtime-assigned numbers on subsequent rescans.

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

