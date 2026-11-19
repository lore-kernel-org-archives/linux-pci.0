Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120273;
	b=q5Z/h4ES7EihyExaHgx6AicF94Y3zyymmPIUaLhAHUl1G5iW7kHF7lSQyFbjc/nLDoqf
	 QGiTjD1ub284yZyJWgv2RPMOtYUVVs66bIHaQGysrCn/CN1jx8bjn786pFAJGwwFlsZF1
	 M3KGgkNIH5+bnxT+f4cjgJQJCfueLw/VQ65gdo9H8rkNbFPoOFj6VxYtK5IuX15DyX6Mh
	 /UGUw9GOQueyEuiFfcD02j19tgFzqLPbsaw+v/bMsT1wsH6tyyDOyGiLVradCWgZ+TKW7
	 M63xZzkFIfDHQElt3ZsshkJr1Ap6OOKm3v5X7joFfL7nM+T4kuzwjG6R/XVNoz+4IwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120273;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=FSG2RR9CR+CX8A37nUT8ewlesURVaIx88lE3eWQuMBE=;
	b=dTaCceN0AuhhLair4J040suv9kD/LVOVUOnAND3b5XwB1pIHLtoFyf4UtB0UIYIQw9AX
	 OClFkY/wR3nVKvhxHyWmRH131qWnBcf9XgBp8H+GrKgEGvfHh4hIF1al5tlL64HLMAYFD
	 0eZYz597nP9ShOBGnoDMieMmI8WBtf9l6WHELEBxYFdQ9Qog73N+SeWe2gNnFIrXdMRFc
	 lkSA6xgPsMjcvxyVoTC7Zthk4sxbDY/19lxD/GJdikU0kxk0fAUJfGwTxWT9kMqskD1HY
	 2e9Q+4HLfPMIpngTXr2LUQBZPk6oMYb31vpajHRXjI4Y0RCFxg9xEulxgREZaNNcQcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YcsbuByi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.29
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC1606A332;
	Thu, 19 Nov 2026 20:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43CC1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YcsbuByi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JANplRUzbu+oETbBDEAHRqpfx2tQhvyKAfiotmAFblWZGS90D0oZ4mVILtNm42jFgaS/uFDGlUXn0AeMXWotrB7xdnZ9IQ0ImtnM+EBijIz2GYabkleiOZ5WHe1GwSfLj4roNmChhO79a/eiUKXLpS78hA+Gl6Lqlb2C2Ne8etTvX5v90qqhWeZr2pwoWNpNOcXmyJXw0EMFF6BvQeUBz+4lnkFHJAEpshNHaOppjQzG09cozgApvdvI3RBh0Fax822A0vN7ZLsLCCkppJpoJE900GkuAZTL2mB4G6qBz0HIqavVGEPfrFBMBuCqNpucH/qDNtKWH2r60zc4vovbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSG2RR9CR+CX8A37nUT8ewlesURVaIx88lE3eWQuMBE=;
 b=eFPi1DiwdDC+8loHwrnfSIADtFyLNwP2Ih2t1yaolGbdSjV8udQdg3kWWDAIiiTfdOOvY25ZLKPLGQCYlk2I31wBDI0DO5mKHxkJE3LUJc/0awi8crFkjCyFsdf082ZFcvPpUBonhgCcjF3GaiF8ieBtZ6DOkDxiekHEBOf+ZTbyy2Bk6yBUjfyePUNl8TbG4AqQEeDD8/qregF0va/nPDkTqah3dTPgrqSkmKo8RcqcjW9Qx4mEKZEjpU3X/TyMvwn6BjAm8/pjDMcsdgZttXp2fpkH5Y1dPH5BDM5DJSOwCa129sb0Eb8A6xtf+60Nsh0zmb5/vN/LB1H3tRhmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSG2RR9CR+CX8A37nUT8ewlesURVaIx88lE3eWQuMBE=;
 b=YcsbuByiBsoBHl88u3joFh7PKJ1+Bo5ifXFjL8d+vGlEuPNgCy3+m2E+39sc9woTWDHrZC0pBS2081sojwLbZXIazyPPvwz4Quk2vc2Ea5kMGZlyMuF7zDxHot23KdZbfB5DXT+WCXkM8XPe4lpdqVMXi6sYVu+vQkZu6gfJmnQ=
Received: from CYXPR02CA0015.namprd02.prod.outlook.com (2603:10b6:930:cf::16)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:30:52 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::37) by CYXPR02CA0015.outlook.office365.com
 (2603:10b6:930:cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:30:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:30:52 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:30:51 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 35/44] selftests: sdxi: add build scaffold
Date: Thu, 19 Nov 2026 14:23:11 -0600
Message-ID: <20261119202321.1734355-36-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcba39e-0d14-4ea1-f65d-08df467c01a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|261022075727099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QrW4q83xOTIiRLoXcb8uN8HxxNf5hf+NDqa3v/bVMKkQM8MFLFot9lR4mGTTyqnnh1yKBrBBmuQrjiRnQBkpVZ0h6uqlR2tJE1rxPe2ExuGWNyRaZncCHFTl6BLyQdK3eg73WORpUwP57iqbN46AIJbQFYDSnSRWa1rd2PtSi4J+J4VHUPiA9RMat3jFf/VKLyIHFmgvunjUg3bEYfF14jezV6jTqm1Kt7lURyjYJ2X3JfsxraXbMiXp8cheny2AH2fDR4Pe0KsP/xdN8kclqpoS6sphu2zn0UfcE5OeUf9q5AeUC8TVhtaURKN95JZtdx6BFLhksLCLjPgPRnSVzEZsuIXrmHXtlFereMOTb/rBB+zVLK2iHXXxHpKYQTAYYztHZqJUQvhEEWxKsoKNoiW1vcOGHPUrXwWgP8Cgf9uHx5QAAqgOHcF1V/e7Ay3qY/Xuai2epcNdd1iA+ioIKX6axH37c9pocTVjnVH4yAbdTXl+86LzPzbALqiUnXmpEBZAKBohootFrxD28xz2Kud/EhX3Ty5/lxlmnVSfu9NJXqDHpgxXKsI+SGCuI8juybYbZuCTA6U0UUAky/Upy/hkrbNishfT8bR3ZecgJWyOgjq7fC4/hW8F5L9toOJS7jS5xAglKQHfdkQPiI0Mn5cWRubrIbIKsADYujqdg3X+DEay9N0TMtIjvnNMpzEmLxzS0dNMMxhXLf75QUD86w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EW5IFsR7F/aKexKMycB29dDzKHJkdt9ZUzJF/qdOm1Gp3/iOTbC6wg/B6XsE8Y1Ef7rHmhLpqLCgXI9wzY0eypf9kl2/RDCS8vTiiOGsRqc/ZZiE325u4qRyroAPQATVT0n4yBoq2unad6zScfbxdnc2p6kXciLelWNsvW2lfZqzOs+Oo7hUASkYyuY0BX10dTwW6YfU0CwMHz2YfzD9X0KHfxmFYI/THBH+p0tR+Rm7D7tti30vByry0YofoH8luajMkSaBpU2E3cUc/vMPV6fNIfQfxQp4ZFs/7YvLwLr78og1Ea1zj23g8v1jbMkeICocycQyvEumqrYJ4/bmdF+cop7JsU6wUfpGqRkMkTUtugy94Ey957NfFu9xfMybHZMkYUJP5c0+ceLD7PSqSM5JRFay38Xp4478EIJ6XRB9CPPHNRWaiEyoG3ncrKrC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:30:52.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcba39e-0d14-4ea1-f65d-08df467c01a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122

Add the SDXI selftest directory and the initial build scaffold. Test
programs are added later by the patches that introduce individual test
sources.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 tools/testing/selftests/Makefile      | 1 +
 tools/testing/selftests/sdxi/Makefile | 5 +++++
 tools/testing/selftests/sdxi/config   | 2 ++
 3 files changed, 8 insertions(+)
 create mode 100644 tools/testing/selftests/sdxi/Makefile
 create mode 100644 tools/testing/selftests/sdxi/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 07c3719f8b04..fcc361c97224 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -122,6 +122,7 @@ TARGETS += rtc
 TARGETS += rust
 TARGETS += sched_ext
 TARGETS += seccomp
+TARGETS += sdxi
 TARGETS += sgx
 TARGETS += signal
 TARGETS += size
diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
new file mode 100644
index 000000000000..107a9bd08f04
--- /dev/null
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -0,0 +1,5 @@
+werror := -Werror
+CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUDES)
+CPPFLAGS += -I../../../include/ -Ilib/
+
+include ../lib.mk
diff --git a/tools/testing/selftests/sdxi/config b/tools/testing/selftests/sdxi/config
new file mode 100644
index 000000000000..ac044d4da732
--- /dev/null
+++ b/tools/testing/selftests/sdxi/config
@@ -0,0 +1,2 @@
+CONFIG_SDXI_PCI=m
+CONFIG_SDXI_AMD_QOS=m
-- 
2.56.1

