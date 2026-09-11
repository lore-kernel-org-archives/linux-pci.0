Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F537B407;
	Fri, 11 Sep 2026 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154335; cv=fail; b=Ah50B5oP+gA9asjkDf/czDuZ3SD9Xh/NNLN4EKgORIN2CBDB8Hcf4eS3d2xBiMU0SnDjJPar+JUhTEVl1dhAXyeHWsisBgzJLKFGmy3SXh4kdgB66Fi9zWnRuXNde+djYcKb47zjJN9To0PR6yQG7lHCUdq5jeSCOvwc4a5HEz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154335; c=relaxed/simple;
	bh=z9OEfNqC+pA+lDmzCCTirSiBB/t7u0td9ZWhmh/iO+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyuz8q9uMRBywL7vUIwMk1Z/JcjGhjS7bChmI616IdpeVOmT+OWHEk+N/BK+kqbAeReFyin3iGMpXlLhglcHir3Hhqqw0IkYuB6pAUshQ9k/MvcbZDN4iPvv2dLHJgw+QtQ1ZyKsdpyoRkj6+I42+0Z6vxH8QaY84chpkPaWqVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kvVx/2N/; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kvVx/2N/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/J05624SE7YwfFyncOA29lmcurzs5osGQYtcoC280RD3w2zSPGdMbI+WMNM4BKCxO5baXswB8V6FKwkc40slxRGZpX4B6m/fD9bmN211ZhBLVJJYrSDeEpAHAKrEvLDemr+DsM+2FLH80tj4gSKfwlLj0Nx5n70N1kt6kmnLNsIpTSv4EZR3cutzPTdNHgsitSvEUqELhDfQpPt+V80oWsSdRhjfHE97nKRyoczc1RA4z7W6fxI5a83R4eljxMQRr80Mb+znXcS5jRdTKuDn++AQfSbK7aLDvo+JjIC5rqjI/rzWDHHA1CjYhIz7cn0HcoTZq42qAjuSASWVU9p+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Tw9Q5h1wqmAvB8QvhcNH+neYxCWHf+5cdEUJZRG3JQ=;
 b=cDgex2MnQcqNW/grsmxZucxA7CvY/lE1LkNi8e0ss+36QX6wbdk0oNSPgp6URq7vKJDZmhcdcqSQ3OtCRz0QnoOjq7RWVZaSRksktltZA+6yZFgIlUYMup3E/yI/KRjxhCoTTrABXlYr3lWAcevYgRDxowu1LjM6faGogb69phB+34CDYimFGPLEisCLFefzrKbBlKpZkCz/1gaGKjMpP8ssQEy7XX0JqQk6CLf62fN34E0atb6NRrilGM7/zB4ChWvT+yxjEZqDuMTmwZdyr8s2XYFw1s7hCYJXtxM4fjThSjwbqrbg9KPZUEdnKHP2a8fuaQuWcfkrnF9FsC8K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Tw9Q5h1wqmAvB8QvhcNH+neYxCWHf+5cdEUJZRG3JQ=;
 b=kvVx/2N/JSyDkqfznPQkH1SYfdtEO8bMqJerAlLzIOqD61G+ffP7n/lwwJw7yLFW42AYox3701n1HrWMSTGK9iGTjMRZ8V7ryt54whlQ7C0iDRK68kpgk9fU0IEXG8X72HGMFVaW6LQI9DA14vcqfIOsjPjcKgDufD3LTxVASuw=
Received: from CH2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:610:51::34)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 19:18:29 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::76) by CH2PR15CA0024.outlook.office365.com
 (2603:10b6:610:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 19:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:18:28 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 11 Sep 2026 14:18:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <bhelgaas@google.com>, <clemens@ladisch.de>, <linux@roeck-us.net>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-hwmon@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/2] hwmon: (k10temp): Add support for 1ah/80h
Date: Fri, 11 Sep 2026 14:17:13 -0500
Message-ID: <20260911191803.1522358-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911191803.1522358-1-mario.limonciello@amd.com>
References: <20260911191803.1522358-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ec7dee-8823-4971-9a60-08df103975fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wuTiR7+Vl4HyIxarIa5yNJhWiAeNi47AKxEZTkwp1Lc6p6ia7THD2BOdYAPfW1BgO294npl0ap8Nl9qqzzcKNBnE6BrdrWyDKoUyeL/34CUEZX58Mx/6pjrUKcVN7bZCZrGwzk8oAEMKy1KIQqMHhY6OUmVDR4zy5Ihi1iA1O83npUwo8KdcURo8aAFyIxQQakJQGv8WX82NxXlDe5e5qplN17mlH2Lw3In3U2RK1ErDI61AfWUIFLUqzqt3x5gtAARZTuJaYdAkrQWO+Gd8qV4mhVmbhtJff+US4H3QCg7xDRIPsb9kP9F3IMKFPYXSJUxz6M8XXc0+Q0lw8xnzXZragDMRkEj6j8ylKKxShvalpTADIQQAdh2Eboed8LKe2ZJK3tJFJejPzIA74voFyIMA87BRo5r4kLEvgMnKHoKJlBBGobDrouattnKkKGXrbnoRRCJzjqvs/VmBUlnvBTx+ZdLMJ/cLjvDukAU4fLgEqcEHJoSUKRNI9DNQTwfNILtjMfJG0yPOTIrm2BvxbG9Hcl9QaqA0Xtfyv8XtOyS0z4FAl5yeWspYBhc4hRarWzfQYioYZm+Da0pW57I5T7HBiZppcxvClPGtYJ/fo9acoQqECEgepGH1ppErezOpLupl7m9fg5UX1bA/oCTgl0mew/1hlMyCoJ7Sfkzu8jHOZqTaEa6/4QV+eBsF3vYrdK5X0ZCLDwY5K8nYrGLynA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9ICcb80niSx7OVvgumrUgxBMvubEO7Zjoc8kf1HIyxEzpuRlqRujiDpKsdBpbKGy5xkcuFy4XSsV15DQeOOvGQXBcWWslcjUb58WgAkuWi2TCP6jO+JPPoxY/PPyrWq+1OzuICQCvcE6Aftzj4g1+cwXreqVZHplXP6w/BTOC2ik96xmpL4wQ8M4qTGJ8J7178q6NofLVWcKhIAJvUpIAvwUgTSAajBQPn1eVSKzKGlPKiNOwU3WXx0J6bJLlP5CKZtMeRtmOX63PVuYp8YhzztSAUfz8akdp8Wj1e+Fz8plGu+Sxn0quKGszhR+IdCMhEoyr9gMzbuzKcEUNQ4YHAe02j/J9cJNJdA3ARWyj/ESdz5WbfwpubKSkBjtG8OW8HnEHQStue2DamCC2k54BVZ7wJCrNHz0fNK9hJhIpnYFqMRTrPj/1e8IZ1n+g5hr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:18:28.8177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ec7dee-8823-4971-9a60-08df103975fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640

1ah/80h uses same base as other programs.  It only supports Tctl.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Move header to k10temp.c
---
 drivers/hwmon/k10temp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3e7e63edc6a30..5414b7841864b 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -94,6 +94,7 @@ MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
  * Defining locally as IDs are not shared.
  */
 #define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3	0x12cb
+#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3	0x1243
 #define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3	0x127b
 
 struct k10temp_data {
@@ -582,6 +583,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
-- 
2.43.0

