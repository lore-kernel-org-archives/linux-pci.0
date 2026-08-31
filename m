Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88AC5474F;
	Mon, 31 Aug 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209766; cv=fail; b=DPt1ZD11rP2tF8OGt6ifHJA+qubOEusGTKO7o9XwvB9blQT9GiaJaGgFCBViL8TelzocNf8ACujljzRhIyL1SgypA26U5NjftNpnImdY3FL358cIXd1LqXII7w3VPQkvA/BZtY+dUdqBrR3RLhJll9Qt2fnCMrsmptnnEW9fLN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209766; c=relaxed/simple;
	bh=bp5ZQo3T3/jP8S2DfofHDOdYf/ojRiNj8ZPihNL9QsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYY3HxbEJgYOLwkK1fIEWrYbcpfTQFY+dpzzic1x3q7SiX1wvtgBfRdBDPyv1F9qlzH3iEb/jppMaMeBjdrs2GN7FNKL5C7JUry0eu+h7BJXvSzoqBGjMeJADBG6rwNR5HW65SxHMnLpf60YQMMMuJq7NWQjlmXQOhTQ5cUu4Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dVLtJQTq; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dVLtJQTq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRDyczRmd9qKxWe4Wo+GZv5C5eb7Mwqa1UZD/vYBaVKF3xaFqILHA15+jRcrTQ0LDYIuzTkS469u57Ilx6vlCSCjSziqk/8W553BzPwUr52PE1+EEOQUuBIWZzR9hq2kpK/ww9LHBeTf4d/3EhAQ1G7MVNXVAEx2pn3WqLx0QGQCTJkJ8LsvyjsHs/kx8MVZluRB6/xNUCZzBJ+UG/JMyjc5xVgSd3fC0axLzw0ZiNmE1VwElMK7+6aW2QYgRe+aSzK722casagpePJvSPadNCwcGs2jEzs+Kp7JWn0ojzIsPIyssSmDqkPG5p6BvxTbQs3wjS9HretiRljYOOqmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojXmQNN9Z+jB8Ydrdwle5P8xI+XvaRSqb6nTe6tbAVY=;
 b=EBl2Y5+PB5rt7ojeE17XPS/wT/GjREBj9S4wgrWw0OAE9EEjVsXPpkWzd1qtWdtyP1XMNewU6Udif1nPiSaHSe75arwUVzUPuiuojApW2upjRTLYWkMuO3rno8ZuL13qRtVUqPnUxQINtVUCGozgDR8YsmUdMBuoaKi3WYsOwU1uuBx+8T2KRXvhGAhT/MCgrVzVqcre3m6iDycDUMKbYavKmTnlYmI22MRqZW9EPl6tQfqjwQ6ueYKEvowvdVd0CHBawOIvapQQtMfdXnJssosaV36S7pTzgLa+NexKg2VL1638+xf2tqmZLb9ky6Mj+k/Kt2hckuBvz0OAzjYbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojXmQNN9Z+jB8Ydrdwle5P8xI+XvaRSqb6nTe6tbAVY=;
 b=dVLtJQTqb5l2mY8JcU2B1AhATrm+LONg83KABCsHHXxImmZZLY/A72ylPCgRfw6HMoZzDzlLW7SusDm6ptfur/2eaFqnQZxSg2SuWS3QrArBMg/MHXdef2xtjbWXG64LgLnTblXUAfsjmtHmm4yyK0PAM3cyZYtGwsvyzSPVswU=
Received: from MN0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::32)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:56:00 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::4d) by MN0P221CA0020.outlook.office365.com
 (2603:10b6:208:52a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 20:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 20:55:58 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 15:55:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Eric Naim <dnaim@cachyos.org>
Subject: [PATCH v3 2/3] PCI/PM: Run bridge power up actions as part of restore phase
Date: Mon, 31 Aug 2026 15:55:32 -0500
Message-ID: <20260831205533.2325747-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831205533.2325747-1-mario.limonciello@amd.com>
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 047c07a9-76b4-4fbf-cb2b-08df07a241d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IngcUEaWK95/croyfUie759BLzqCdVLznuSGo1JKyMKaCnM4z3JjDHJ0TElLNoFnAe7trgdSMAuLDbX/zv96jHmakbClEePVSYndSqy0Ef4lFmuufywBElGKibtSFOjtKriLO+i2SVubJYqGkHIzJ8bBqF296eJzWByXdbDulNmKGqKEVKOFmd7XLmWSGdUnvyxsXdTMMwPT+zbF6PjFRnQmtNGn0NzA1s7btP+O5NjvyixiUOljwwoU9k28nfJ9YBcb+eOsjQEKtgOGMD7oWWP1n9yQVzIPiKITWbyyFOTw3lHDQpzjAiFI4za72ihNLYUr/ZytZSoMa0tNImLGCx4zshj+x+Tf1Iwkx2r9k0OR4v9RgTJKuHEpZs0V1EUYJe6WJpXdelniU3NoF6j1GLvyIiNpjO5/vx5PjDdEmkOyodOzJI8lZH00yiHsK7UTzeWQRvyY3+r9vQpV+LjS4N3TQRAe4OS8hWrRrIqAYiG/2cO2HsHIT86iIqnARx7PKY3AKAdTKhSsskw4+4cGBdfnaUG/FpgeCLr7vglmsiQSamT4eeRQGEp84sq6SvcTJJZm5M1QURS0P+FvCXGK98U3F7YIsRt4zMuqVBG8LUpi5TEt0J9yzkDflHMr6YoZbwPpH9ZFzWDcye8qoyB9VS+xjbQH10dAmSsm29BeU083Cgs57QFZTkXip7oSjZtY5Fj/XBOP4rlp+z7fExD1WA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7MUosVpGPHfxvzHH7rQuafYzuAWUGBSMRsCG4r4oOi2NIikQ9P17b3ZCADD1WOweS9eC8xQyV+MAv/jvaPs4GxskmI4PNfx6ZBJOEaFQLtChS/RLsd0NcbD4dVukiPUUgkuYOYpPqZCyM1j8kcGANW24r3a9CCrHil+Yz90MhvpsVt2ljO3WgnWbX7cpwiR+rHJmbqr3PosI/C7dWCSDvZzFL0ZNilRCtkJGrgpB7UtRR4GQ21PGg9+GM+uf2ZYPLbcP6XDf/wR2ATTwt4eG68pnjOhkbfJbW2b2nYdJosLsyyTF4dajNKL93gAkqefWPgbvM6j6Es0eOkI8eCDJ3pnM+ykwYkmaJ/O06bZCqakIttYdbM6nxndkjWmYpUWcDby+YNC/lKMwQKQr2CKtNVvo1uOFstY2DeFCAA3KeqdBPh8ztIDLTofiq7fA9AVo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:55:58.0301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047c07a9-76b4-4fbf-cb2b-08df07a241d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

pci_pm_resume_noirq() calls pci_pm_bridge_power_up_actions() when a
bridge is coming back from D3cold and bus PM was not skipped, so that
the mandatory post-power-on link training delays are observed before
any downstream device is accessed.

The last patch in this series makes the hibernate poweroff_noirq path
put bridges with downstream devices into D3 (including D3cold),
mirroring what the S3 suspend path already does.  For that to be safe,
the hibernate image restore path has to bring those bridges back up the
same way suspend resume does; otherwise a downstream device may be
accessed before its parent bridge's link is retrained.

Add the same bridge power up actions to pci_pm_restore_noirq(), gated on
the same conditions as the resume path (bus PM not skipped and the
previous state being D3cold), so that hibernate restore and suspend
resume behave identically for bridges.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3d352c7b31d4..d15b3eb55ec53 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1297,10 +1297,15 @@ static int pci_pm_restore_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev_state = pci_dev->current_state;
+	bool skip_bus_pm = pci_dev->skip_bus_pm;
 
 	pci_pm_default_resume_early(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
+	if (!skip_bus_pm && prev_state == PCI_D3cold)
+		pci_pm_bridge_power_up_actions(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
 
-- 
2.43.0

