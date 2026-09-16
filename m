Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBE4E06D5;
	Wed, 16 Sep 2026 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592062; cv=fail; b=kWnX3pjkWmiagI591JkAqNI1ODgYGW24I7YFeDLRl5REBj5JIOGwNM80aE2NyU40mdLpARTI/UoxFA81nx1DHDNCjVvi7g1PcPDS/3M/R0hE+r9XgVRIBQg70KOT1ellaX+i7CFIkbdZ6v92nHHyiWNpI98A0KWt8niwwKmzJFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592062; c=relaxed/simple;
	bh=AuHmV757Je47cqLiz85OfcYG1QeAkhb0C7/ao0D4EjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q93BXXEZQ3j1yMFWAOq5pQmQXockfWlatcKQ1yyAt2IJnvyjGLU3NEwCScE6aalgAVeRlABGshS6DQtWmnxvN9J90fn//Sh4WkpO/CVEKfc/wC3lYzD4GAyjz5/5zwfwaDIJqry+MMqfPoKLPccXA4IVFXcCJagKEBEJgv3uxpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1yFhrJEm; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1yFhrJEm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bucKndvvhMIhYHoPszfy31H3UCzmvthvEKHOjR7w8PoxqjwzOpYkGo/xLWek7sjLEw4dxjJLK/yzWtUmLXP6rVzeMCmx2HIXzfYjte1aT6YBPoCKctSAIS9mM7XHRfsZ8h596clZODtprGy7XPg4Y3k29Sfo3jNqHbToMhlY/xAfVCI9ElI4gOc51mEmgFDpj7wtmjowRRqvr/nMpVQrkuLzdQkjPekAbofaYC0xi2pOWF1LNZzIfekU1sBdTgL84CfQEZWiVBdLbh9C6NU/Ht43j/sh5H0aor3ObZVg8iO+h6kW7weLdfhN/KXDSnMxtfkPPiz4s9/3W3Tp3MdY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w654wXXwH8SnxF6Es8+skQl/rH2diZT+QanVPzahX4=;
 b=h+BK7o7trkdHoMOpdYD64HLBuNwjdsmtLtilJsPYlYLz8XulGPX4IjXW3CivV6B/ty7VXZ5lxTL3chmLaGG6bzwd+fq8XIGaCWUUDr6/GnE7168SesAZOef24UQpy7G9jvqrcjD6jRTYadxx5t7YWP1PLfo5w5DpHQpSUwZ/dHz6aannwIIu1ClSLUSksRpUBd1yc0nhnbRD8c5vClvubWBWmUZk5jET49ida1+pbLLeyV2OYWBMf09ocZPRyPkeN0SMpqPJpHSSGMlQ7znyocrtS438c8pS43BIhDtSNz6VESekpT3f/dZDGwqyGhLd5KUipxlQEovCok+WLzG7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w654wXXwH8SnxF6Es8+skQl/rH2diZT+QanVPzahX4=;
 b=1yFhrJEmmjORflyZWU0ppaLkof8oxorEUWlbxNcmYgQCpsY3Tu7LNx8rKUwCshqU/tlx7dXt7IpVsdWRADG2FvXtq9SzhWgGwLBAxHksciTZy9P2DaO1TfLi5pZZFLj0AvuH9NXRzsB+dq5ITxLI920zzJ7DGoyqIgDlza7ZBTs=
Received: from CH0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:610:e6::12)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 20:53:54 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::40) by CH0PR03CA0277.outlook.office365.com
 (2603:10b6:610:e6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 20:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 20:53:54 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 15:53:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<superm1@kernel.org>
Subject: [PATCH v5 0/2] Unify PCI suspend and hibernate paths
Date: Wed, 16 Sep 2026 15:53:38 -0500
Message-ID: <20260916205340.2466679-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 4647e984-afdb-4805-cae6-08df14349ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	q7blccL7Bg4DHhqvxxMa29TMeg1ToRRpiioJVvtv/6nMY0JeiN9HNHHprli9ti3bbjtGvPIJF51cgXfxnUPWlhX3L6syGX51jLKYttWWsiEgCESTD0Srr+XdaBPlNXKDi3Bq/ELBlqb1W1jn7rNDAWIZqyNLcA4nOe7XdzjQSnpevmrlP/ReKIOOWr/pGGw6DT/NqdvvqZAE5vzZzUG0uKW6VFlG31qKWBDGTncym02rMrFVjHkCgEjb7hL76qOOeeKhwqic2actrbN6CenKWL+SFRaQU9b/kfHIgZken2BSDU4W1keVJUeEbHUr02A+LMlxInKbF7dpUnsQHJ4jgCPvv+CYifYJBYWiOUIb1KYsLvJdKgZKzS44TlQnBPJKX44kyjNqydPSsdHvWGKos3CiWW8zy1HjnbiFp5jPbDSmjOo52niE8djTt0SMKaMru6ASKkU0THbiNj4jLz50OOTZ7YFWeZ9vFVRNDtd4sjDpmU8t+uhfuPgpI549T1gtHCV8TWb4DvQ8c4Esgh0YGAV8M2vH9b267jRmypm/hr4GyD61CwRjCOyK6lVZDTb4oJWKk7CG+LDxJmxqaiX1GIIEiWL4UEMI+euOjBMqRzFzhhzFvnFvL/P0e+IaryDrkPrW8EOVs+YbKNOqaq//qBuuzy09Roz1i4/ysxaxRvdOKIkay7gMAIEYSC7ryhrMbJxroNiT+RmxjKjp+jUKUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ra19DNKt0rlGROg/SPtY0oGzpO1n/2dX/Tp0rwqs0/QZ+rlfehdr7LvwDhKDj8pnDZpZOpdGZFsY9Bm7I0ypP/EVfXexxYUwQMyewufXOk+qfuk2tPFlRmI/TAEdTbXNJiVyWVEml+hSsbvpEY4EsMwImJMaS8iQqj6i/c/QXGxF9VDIxSyXMScLmsM79I+GkQkWAAAjysJCVUkGKa4Rj7cwjYtsUQ6rlEUHr6zQzf55IJNF7kbRD/mW1nRgVHbIeqpjFxyON2MlJjzn7hJeWbAosn4/Hql73CmSroeOG9EZG5Wu2G5jdmNzotM5ZG8IkpMl05GbQpBw9ozN6RZdX/LJguDtxcwE/NvIkO5VnrnGq6pFt5wmWGnXuby3Xdeg/+5ycTsr7KNUcku0QzpVISfklXSw+QiObVFPz3+ZHMtH8LeHqWtx11sFAq7SbvVL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 20:53:54.4155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4647e984-afdb-4805-cae6-08df14349ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9

From: Mario Limonciello (AMD)" <superm1@kernel.org>

Many cycles ago I sent out a kernel series for using the S4 paths when
the system goes to S5.  Some parts of it got merged, and Rafael suggested
to split the other parts into smaller pieces across multiple kernel cycles
to make bisecting easier.

This series attempts to unify the PCI suspend and hibernate paths so that
PCIe bridges with downstream devices are put into D3 at hibernate the same
way they already are at S3 suspend.  I have been carrying it, rebasing it
and personally using it for a while now.

Mario Limonciello (AMD) (2):
  PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
  PCI: Align hibernate poweroff flow with suspend flow for bridges

 drivers/pci/pci-driver.c | 95 +++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 30 deletions(-)

-- 
2.43.0

