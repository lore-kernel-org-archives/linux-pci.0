Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795577344;
	b=E0GgqjLZTOSjA5fqf+IGd6n8AQ1n0zt5s1gyWHkDico36xJDUQga68a6J9Hrx/NDHSfC
	 BgnfLifFRoHk3x7kDcbFGuBgNVzx8Z8HjAc2pJLhH2HlJ+3bwFsz9DGeY1HkJkhqjYPcs
	 vDfByKM147WHVTWdcikKXAsPrr89cRfzfVbMMz9I6Yanf4clI6haRCImEvC2WH9gz25U+
	 kI2KVdbz0bzbog+MrGx8iN9dfplV2oF15rj1HMmUcOFVzCmSgN2T9FC8hL6Iz7Ncd+YAf
	 v/byQibNtZTH521kLjatCa0NpwZ4FREVG/x8YqCBBz4bX2kI6xiJX8QmloBfSQ5KRog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577344;
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
	bh=G68JYISe2CtSyYzgsdchQz1rHY6prMBPkicJjgta9Xw=;
	b=5OP3ObQJLXiaDrshOoA8xhqxI66q7DIiD6ieAtIWr96aapqCBgrM5GF/HT1U9v+ykrxf
	 iXbVoJNfKy7AXmKVREJOOh16oV2aFwRU2Hk2h0prxn6YWNyno/6ofpzr8uRLWJ3mEOn2G
	 N4F5DqFZt431+qMbcsZQAvUUR3+xldVZbrCKlV4+QcfDKzx06NO0eYLpWNhpg/zL8RLBA
	 UBrpp8k0gCgrIxxXo7ja7BVPlMHv5uzhnWWPwTDYGIEKWn4JO3+ulMHIYJPja7J/Wc57f
	 9t8k8DxFgwGaPdbYDQMCWCMJftYajsPkt+ItYlElUDW16CL8LPt9D3vY4Qj2JQ6b7Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZLJutTM4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.47
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174E606A31E;
	Wed, 25 Nov 2026 03:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1174E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZLJutTM4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnFvALaeUSdNPVoOl1kpzmFvlLt/uf6FemJGO7bkNh5KC1BGWViEWBqs7EN4RZcVJQfpaUuLuOVYCkRLMHgu+XI5AYGUG7clStw2q07va0uZeDKX90b5Vty3sbl1aqy1YvTMnRXzdq8b/VGv1BYNk4qQUwn8NU+//Ms7LqwteOHDA/I2KYhvaQ3PIuuf0NIzzp7NR48LB16QjppXH7lTmlY6CJ9NPlUYzRzCohrI9X7higlfep1OPiO42ghz8kL2iBvaUNR5pmzQWCEanE2B1eqh3yNMwuMPybG7AhukxqxLNMCmSp1OoVrsMvdWN0wZCygZ5lKqRjSLvZzn1JZtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G68JYISe2CtSyYzgsdchQz1rHY6prMBPkicJjgta9Xw=;
 b=xTQwwn1kaIQ1OPok214ILOU0HBZo/CuwH4iYcZvpQgONVJBbxVj6UTH2QJh7INkIWigkQMeCar1cTk7sRCobToX1nEWLW+X9vABD51l5nsPD5XKqPHVpDm3c/+5aTiKOJfCwaQ1aXm52s65Z+pbKUbMzfL6g3NE9U3iFACteZtkvgk3JXP9f5PKvUHYWntmBfNOA8eYocm/whoUGOR6MOUkAXNbc4L7upnRd7abWS1cETRj/aaL2NToHbCNr5046ViQ/i/qOLpVbdhxmZ4RufOOXr6zJHj6su4QjjR5tJBibu6KN7S5tEIBeb+zwWfO8hxWkHRuXJjW8gxJObTD4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G68JYISe2CtSyYzgsdchQz1rHY6prMBPkicJjgta9Xw=;
 b=ZLJutTM4GI7hqZl/XCS2LBXP1JOOugyzIL5H9SUVK8RH/cxQT1ft/NvtqqqrA2EaXAopBPl8BaHikbval+sVCHUG+myG9nS8kc3xfNU4rghYbpiRCFrXgvM/+/YbxM0pewKqYTjsnl0CkRN/0UAd+ocz/zxiTlF+hP2FJZNMXF8=
Received: from DS1PR03CA0007.namprd03.prod.outlook.com (2603:10b6:8:450::19)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 03:28:58 +0000
Received: from DS2PEPF00007109.namprd05.prod.outlook.com
 (2603:10b6:8:450:cafe::79) by DS1PR03CA0007.outlook.office365.com
 (2603:10b6:8:450::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 03:28:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00007109.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 03:28:58 +0000
Received: from quartz-7b1chost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 21:28:57 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	<bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh
	<pandoh@google.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 2/2] PCI/AER: Document ratelimit interval and burst values of 0
Date: Tue, 24 Nov 2026 21:28:46 -0600
Message-ID: <20261125032846.4019744-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123233859.GA1120797@bhelgaas>
References: <20261123233859.GA1120797@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00007109:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: f05ab05e-e5e4-4f4c-0776-08df4aa43dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261026121527099003|10067099003|11063799006|56012099006|261021123027099003|261102123227099003|261022105027099003|261009223027099003|261021121427099003|261026140227099003|261028144727099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	5midy4s1Us2Qzr769PTz6mZ3ftQSeVVG5/m0GVbhZf8NoxRJ8cs0MOCZ+d0YeaEUsYXPBXFgTv74fKu58F50Z0wJMQiUsWpDFbLSeifXS9uVppGBQJR6s5lrUeaJivWBFYhFRhWfM0dJRXnUjpSxnjncZllisVZmk3SAiVfdYAi5cukbeDJAP9DFOMGZIdL28if9psWefEGQlriaTp0XtAvDnwoUpUKVO6cG5ON6sSxQTrCXFzFvqax3Dmmw1UTK9NlH6RMdb3NUsJP0QOfoStq9UNlSA2/00HN8eyseu7awWt+RNNhErNd2V7zsUEm95KRRiISXyO7te1WoRgp+Ep52UpVA9UtK4jOISoi9t8WX4LVu38gOyy7UZZQKPgdTw2PT4BfiMS14jS6Pzg981C1aJIJhae6BAFWx8WBmVzQKaIq7yib1i4UU48tPzPZXPN3Ea0lHstHK+JqnUfAckKQfry2txURwQb6hC0fzOEzFWdLwoaCEwjgMvuGJtfKlfBxNWshdByiuKm9/uNevZyCXsfA1/ujcI8RthMk6eHEI3CojwINwnQfhU1hAz1/tV+oEfuNiaOyYO5z2mz5ngn5kd4uCFjxatdSCKqGDBOx56YCdC07lZ3HubCBSLqd+TlnEdTsC4DDpKUYPLx/cWU/dVrI92Mpu2TZXRnMJCqc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261026121527099003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261022105027099003)(261009223027099003)(261021121427099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ui/5F5PV7ahU/CMWGJqPLZO74RjEunG19YwQD578XUPaoJ8J1yCCqUR4I/cytZ6/Qxs/YEjl/3Zw5i0l8TtDrCyXJ9XU8k3HajyxCWY2MJS3LJGZXYxB5O6PAsqBfwNP/k7DYDsD4FsU4O++YjLT4uQZkpfrAKkjKOLOfBVu8LY5tbFKD2+gP8O49Mp9El4UP3FSCRLXVRKcC5qHAgU+osG1thzHW9hKVVE2liqskCtI1mWah129L+cfsBO6ZIQ+bv4mxWKYhUEL1kZ6M3NTz39GVZwFKYhwXjjUTi8P1bdEjFhe3yttzmQTVhORKIHHsJtp4lylCYxqMCHLhen0FRFZCCRawayMk1/JDDqZ3RzAMLmgLITxedeHx+1JiFqzfjO3qoVbG8Wcvr9QAA2SMJHNCSYVJI3BBjkNY4ITgzQK4qXaxLZE95U6h+0uDSSK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:28:58.0571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05ab05e-e5e4-4f4c-0776-08df4aa43dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00007109.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689

The AER ratelimit ABI doesn't say what a burst of 0 does, or how it
interacts with an interval of 0.

___ratelimit() checks the interval first. An interval of 0 disables
ratelimiting, so every message is printed regardless of burst. With a
nonzero interval, a burst of 0 suppresses every message.

Document both cases for the correctable and non-fatal attributes.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Applies on top of the pci/aer tip, after "PCI/AER: Enable baseline
capability error reporting", so it keeps that commit's capitalization.

New in v3: split out of v2 2/4, with the wording Bjorn suggested.
(Bjorn)

An LLM coding assistant helped adapt the suggested wording to each
attribute.

v2: https://lore.kernel.org/r/20261123165050.GA1741477@yaz-khff2.amd.com

 .../ABI/testing/sysfs-bus-pci-devices-aer     | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
index 9e772e1ed9b3..0f193ccb0e2b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
@@ -140,9 +140,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
 Contact:	linux-pci@vger.kernel.org
-Description:	Writing 0 disables Correctable Error log ratelimiting.
-		Writing a positive value sets the ratelimit interval in ms.
-		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
+Description:	Writing 0 disables Correctable Error log ratelimiting and
+		prints all messages, regardless of burst. Writing a
+		positive value sets the ratelimit interval in ms. Default
+		is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
 What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
 Date:		May 2025
@@ -153,14 +154,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
 		before ratelimiting. Reading gets the current ratelimit
 		burst. Default is DEFAULT_RATELIMIT_BURST (10).
 
+		Writing 0 never prints any messages (unless interval is
+		also 0, which prints all messages regardless of burst).
+
 What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
 Contact:	linux-pci@vger.kernel.org
 Description:	Writing 0 disables Non-Fatal Uncorrectable Error log
-		ratelimiting. Writing a positive value sets the ratelimit
-		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
-		(5000 ms).
+		ratelimiting and prints all messages, regardless of burst.
+		Writing a positive value sets the ratelimit interval in ms.
+		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
 What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
 Date:		May 2025
@@ -171,3 +175,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
 		allowed per interval before ratelimiting. Reading gets the
 		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
 		(10).
+
+		Writing 0 never prints any messages (unless interval is
+		also 0, which prints all messages regardless of burst).
-- 
2.55.0

