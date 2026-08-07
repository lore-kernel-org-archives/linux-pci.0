Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F14756C2;
	Fri,  7 Aug 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106137; cv=fail; b=X3NwZEZClptw0GJMw3czIRmJC0s3xQaXkltTvxbY82I5FtQqO5VLj0P475nktsj+SqtyZhnfjSZIhygIW4pEAnzFjCdcKOiSZ9ck1+i4/OruHgxV1XMqCOe2qtB3ilcaMnCMCZ6h4495gh1azr2vIsZ3E9EcOgRFA5Zpeyjhu7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106137; c=relaxed/simple;
	bh=r82qo+d4vkXGikYkwEe/5VVmGRKzRiLCwmD/vnnLYe8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7mey+7gZJ7rPhWBQnrAXR/HAK+fhN0DzuK79ei1KtdLXmvksE9qZgkcR6ZqvSu3rFxo752CRBuryxsvWt/nOVGz0Yb3oaba5vNYQmHRgaLaL1s3mKL5LOjplHxQms67+45Etu7Bau/sAzv1cQcTKa64/UaU3j4H1FB7Gg4gjtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yf7Rwhn8; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yf7Rwhn8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgT4dj2NU3bHKsCZSX2CQg7lMNF86cFeMhVNcDHC/0P9EsDDyGqV2wnPa5odZV6tOPRh6NLxc04VfPpryk/VIHosFEcJuIhnuQ2VKMmfh+k+fYEXRWkq7yakkiXHejnNPefCCZPksmHFUZqgIzcm3Z5apQgpHh5eR99/MN9zYdX4g1qkuc/JgL7QtouyF9e02y3Tmtlr4Il8PLS0Q2L1ZMGLOG+GMfY0FWAF9d59/9bwcScc4vasstKlKLhSXd8hRVL6IRW/r6eGfYVK1l9K539bSGdzm9II4Z+7FGTXEPq6aiArFXX5p0CT73L5xVGwU6qFutqRW3HyYQjYSkjZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YcD55WYvLtcyc31nPpJHqxWdE7MXd1gRFMzHWdGM0Y=;
 b=YmbLAfNUl+CiupZAf9or5GQi8Ak2kNMBCPhK2YcBOCyLH6BSzinKHPIfpMdGHGEc8ipiTAsXrGd87FfKIjiO7h58+Gs2+YjJB0ib1Fs7i7Ro67E/tUfph//47/qHHGFWI2QjZFuPVZ5Y38wzFvMJQqiM6PlJyi+hVqvMEaJlslHcHuUy7IOt8270YTs442aVSYYBSkNpYsd11vv83iGBp0+0W7mlfSzaq9seZiiRZSN9GZ3jFh9pSpC7h78Rkh6r8AB9rhjgfsLzYHw8BM8aVoHRz88ZxphoqYisL8AIT14ceWlI5U0AcPmN90VHE93OZk9gWW+6HBrStjstON5gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YcD55WYvLtcyc31nPpJHqxWdE7MXd1gRFMzHWdGM0Y=;
 b=Yf7Rwhn853hrz3ALGHZuZoAB2w1jN0ZYJpbn6xeY/slQgFolyC9OORCnIvTxy9OXdF4oWvA2lrU3X/SAWCPGZQnDBNrzOtuMnc6dL2izjPQ42XgFhoa+y0WsSfg9sM+XpwbFDQNi8KwrrcMdsxMghO4IIIowWsdXJi699d539SM=
Received: from SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::9) by
 SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 12:35:16 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::a0) by SA9P223CA0004.outlook.office365.com
 (2603:10b6:806:26::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Fri, 7
 Aug 2026 12:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 12:35:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 07:35:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 07:35:16 -0500
Received: from xhdlc250064.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 07:35:12 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v8 0/2] Add support for PCIe RP PERST#
Date: Fri, 7 Aug 2026 18:05:05 +0530
Message-ID: <20260807123507.3418671-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 5204defc-c7ed-45f9-5a43-08def48055f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6hrDZWekTyOn/RBxS6kEwgmpB+W5dOzKaKrXzwnZAXNptcsduBKUcjxRW71QMPrVOprD5DiM+M4wyX4ZrlYiMJkqhrVJyg3k4OASeAMMLYnKCYrBwI+I9Rgthkqbre8shMXoyQxrzULf93btvApXrQFVYm3hQ7r4Ob1MboDWuW74eGsLW5vIugbob5kkpVNuO3xbS/G/0oExkwlAdIfWdKSMio0DY0XmeN2Ai41e+dd5c4Z9DhbKQRqIM0PTGirajl6PSWuWI/Rk4r7+7/Tm1roSULr0xEqEcOkhUmxPsrKg7bwdyv7AGtmm+Rt4nHDbTbR8MoT9UBF6YYDB1A7IoIA6ma/XLNcG9TzVzD7IPgbBwOkHAVob6Z2f4iCp61tW0fOmt43kKlW1yOTrwz3ZoyD/a7xL66Z0c/SEn/yr8/8D//ZAKtmy72qZNcDDqVc8YqCD5ijO9LOePoiIb8arUCjF3TZaKxsTrH9IGIxyXS4LREUJub//reGsIq9i159m9E6jNqjxzVziCaILeC/mMHx4S9YRsNMZAuGZCohNw5POCKD6X2l+69yEDphWOdiWWAZsw+JYuNXH51s1/i6JLsoUUmUJ7KDL4cnGAdR5nW/TXpx3dqbLm3wpqacld8xZkr4FDQWwbPjaJfgAhKsuCubuHoLRCnecb1gWOG4Ku9vvsYpCCd+ZP2B1kzBg+GO7JqUvX3Dwh2h7YKqW++8VCg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1OOz+/g4uwQTN06DR5DnPdYxuA49Y0c351xSY1ffu9e/aGyZPGqJzBskWe55qnJXg52u81UIVNUi+OvZZPLi+5zy5zNGJ90ZcW0Lutys7JT9LKpv9YpB2um0DH4FGKz9NHg6BqlyI/wD014I5XW3tzfZrqH6AHIpbgANW5PwP/CNd3c65pP62+p2ob3irjCwKJoC6EDjPKT6CJjoto1CtD4EcCF4sFH0gg8Rd5Qa6j4gkWMQAOg/jy32mSbMaB/5jU427eLEzCa6iQZT29Jo8oEC0sWnzKMBXwa4DI2jbdYV/0UnQqIonzSZB5GCRx8r/LlHMBDRvR/tgoqLkaPMca2+s4911R/MHQVzp2zyY+6LSo8qpoLWkz2gpuqToiTnoIC7n8CERMhCMYVXsDAfqCYyWKJ914olzpnn/3Eg0LpanZbxY1w2jJn4GKC4hwnx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:35:16.7778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5204defc-c7ed-45f9-5a43-08def48055f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

Add support for PCIe Root Port PERST# signal handling
in the Xilinx CPM PCIe driver and update the corresponding
Versal CPM device tree bindings to describe the reset and
PERST# resources.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       | 38 +++++++++
 drivers/pci/controller/pcie-xilinx-cpm.c      | 78 ++++++++++++++++++-
 drivers/pci/pci.h                             |  9 +++
 3 files changed, 124 insertions(+), 1 deletion(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

