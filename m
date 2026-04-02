Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A836F429;
	Thu,  2 Apr 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152850; cv=fail; b=eE359+lNEc1B25QRw/vySjYFMebLYYWC3dGZ58sNRzohZBdtniR+t5PD1go+ZsaXY+Nd5Pz8nB68MQ34Wb+ZaijONtZuSsPuCC9cM+Z0V+D/XM4rP5Tw1FVm1VnL72A2eKJ6zhX3AgUq+WsZCZQuJNrlk9qC6iOTFSc4s5yGTlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152850; c=relaxed/simple;
	bh=anA81ugk1R5jKlAeYLGXhIj0Cwg+gCYd2dnWvgy/LT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ0fcqEicIvaqKOTnPPl/2koA9rwy2iXBeQUqJ/Afsjt9xA6aThvY0/ZFgFvu4t79UBiUazQ4iIed5ygmNVq/IFoCaID2OPp6laJsd4P8rHW2YB3Pe6aGRp2XDTvR5i5bkOqnDF31YgH7rm+FDsY37qh7UiksC1yIYWqG9T9E20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KUl82cNQ; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KUl82cNQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTN2DheJq8JhS01qLWpIEpEPNGnuviKHo+BLIPj07cAcTSQ1LxowGKGDrbJKCRCdtLPhv/TnbPAGRITem3KgicmBMO1WLIrJBN5yL08YPA5pywk/JN2a/TbEhjXxDp5gwpGHHOK0jjW2dBQIAhyToVW9s+aStZArS47NwBL98jtD8BQ158W/o+vVZNQ0tlyhVsBb/tkDjAgU5AWJCpCO4IXaiK7aq1xUvFHDAAvHF5vp41kBZZWy12dcA6MZAJddRWwrItCxXEZQb8lCt2X+VmCswy2t9YKb6MqDJ4braDMTJltTfik5N05OJiepj8ec8q58P79lgMnvdpf0xjG+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LQ0cVskjGTtclQ+8xVdqBfB8FVzUsWxBm6UFHqme8U=;
 b=I6mCnbl80x2fwQPI1q+Fn6mGpQ1eNrpW01PGz7TFOrtg7CoTK4jxxVBAqz6LKW9N/EG1tgZzAbA3t7W7lcgTZkSeUvuxnDFmw2wavYlMQC7OWHK1UblM+7DjmwbS7LSIe8QQmc1V2LdOpxcctTlfVwk1apGYEiDZKhLILaxxxbIxlRoa3T2a9t0/yYcPlwD90JF8TqqRQglv7x2baX089EVm4KUvQxg1Kqo/C15sMMQfccIwzO5P/Lc5SCeALanfysI8a0pdCXRkZ7ZRydwRypSxig+v8f7Rc2w/woTLOtiypVTX9LDJcACwFALUM8i+fjoQWFRWc1do4wcLaRqsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LQ0cVskjGTtclQ+8xVdqBfB8FVzUsWxBm6UFHqme8U=;
 b=KUl82cNQQeoLt/2hm72TSF35JmLyRFZPXyPwkH+e0aSy3p4HzWwmNQ85DKoCeoNI21hYu1VsYA5dOIO12IoKcEnzG4+31nnsSnLuZUUBJZxzsTphPlucAUCdGJSXT1nwmzpoRMAbG6APMPXc8zlDlz8QsSBYVrsXMSIu8tAiW7g=
Received: from BLAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:32b::8)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:00:45 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::72) by BLAPR03CA0003.outlook.office365.com
 (2603:10b6:208:32b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Thu,
 2 Apr 2026 18:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:00:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:00:43 -0500
Received: from xhdlc250067.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:00:39 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: Add compatible for AMD Versal2 CPM6 host bridge
Date: Thu, 2 Apr 2026 23:30:05 +0530
Message-ID: <20260402180006.486229-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260402180006.486229-1-sai.krishna.musham@amd.com>
References: <20260402180006.486229-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: da1e08b4-59bf-4a7d-3e71-08de90e1c2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	d9pWwxmr4Mx6GYc4exQvDQZrz1VolB7vjfeMigZ6zyf8odRgaBKIWJOCaaxHWXPa1OvpYJqA4kG2KgKu0Ow8sPflGJ0ymkEZEiPeSeRhkGag+S1J25iLWq7a0oiiDgqNSwQQgHwuU04ovCB4Ffo0VJgt+pgY4odTWXURblY1C2ZMfyIoSRB6TUjp0RLd75xrxXU1cnbStMXAA0yT2UQLh07aBP5YGW0Z22DUkbgq1ONLOlHCefPTNzLggkjpJ4vksrS2zhNSnoxUQfDdTVYwH+z6/BmhfIL+BjGnJRFUXoRcMBgJoBst2Rk3FvVMuPAEvY9hloIBaRCoRxTfz7//xiPKGOJDGCaBQ4cSQBT74GfXZFKMBNrS6Haa9W3oZCAs/6Kvo/tjlk8rEONlmxb0wsZlJtWBbGm8E1FlPEzSwu+JYsuUWU6747b0+h0/swQAutTzln6shuvlGX54jfAW3Yjh6HMnbl7wnpGNhsdjTzsmsq/lVljfT7Uc4Nf7j9I5Rxc4yqeA7e85od9ArW044PNQX+5bJkVVcTHmzDKf87ksEYUhN0hpUSh+bxAI5np9RyOBzj9e5jKB5MMak67/WwFtOs9jaClEY5smDNRYwRpuJPfR4YDbiKaWZOkQcO86ygtwVmsxif+YK6tAMpbGPMpkfxerVPogwUP+dmsboy8i2AlhXeomMZz0thqZtF3u9EOnA8LAfetJXfCRvoIsLzodxoWh2CtS3KvpxCaL6LRlTJkbNWpEnJa24jHCgL6JxXayr5w0wis7hBq+XSC4sQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nxR2pluAdDvQduk1+C1CrfGqVIpKvtM5YuhS4foCjtKyWn6gxtaoH0k52oYMYxRscklUQL0JEUpZLU57cvwGzLGs1oORbsWc1qj/Qd2O9AnpFrTQyzgJ0JjvclocH453K1DlyhJd409y1172p68e5nurnNal4V99grkFhOZwTePbig3IRBcxKKloNxJE40ZM3quVWyksfYOGiAu3VvK9ZFDGfGBvVMcGLUFDtqhjozyOQ3Eq84jVCM64RvUspE0EheFBv1hFBGS5uRED/wkWDFYCyp1bEmbEcNPlfGTpN/sQTweSx30KBO8hkgCPEnPiQRPMAOKwCJkVCv1+oRpODnuuP/faMitFo9Mzug0Vf6zdjLDZZFwUWNJEPeqcgO4553bNvCnzZhSxeyYq+KX+ZVvd20ys48oa1ZhNDNWqXTIvLCqM6pZx8IIQakddzGyk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:00:44.0287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1e08b4-59bf-4a7d-3e71-08de90e1c2aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837

Add the "amd,versal2-cpm6-host" compatible string for AMD Versal2 CPM6
host bridge.

CPM6 integrates a Synopsys DesignWare PCIe Root Port controller derived
from the same IP family as the existing MDB host bridge, but uses a
newer IP revision, supports PCIe Gen6 operation up to 64 GT/s per lane
and has differences in register layout.

A separate compatible string is required to accurately describe the
CPM6 hardware and allow software to distinguish it from the MDB-based
host bridge.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
 .../devicetree/bindings/pci/amd,versal2-mdb-host.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 406c15e1dee1..be5a77908d24 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -15,7 +15,9 @@ allOf:
 
 properties:
   compatible:
-    const: amd,versal2-mdb-host
+    enum:
+      - amd,versal2-mdb-host
+      - amd,versal2-cpm6-host
 
   reg:
     items:
-- 
2.44.4

