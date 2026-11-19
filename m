Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795116093;
	b=XGz+atY0mpLSH/VkM2XIsIChVWaEYPx2onADnCOdyziXp6obCVC11UYPCNnEzERlwj3Z
	 lP0V53v3ei2kQ0AOrxMWk26n3TjA2flbUMnRZl04AnP7dcx1xzWYJa6ihEwYZSo7YD67N
	 551c+gyTjQi2ituq1h3gtiPyvqPi6RR/FV+IcqDFoFyEZ/+84qDuYSc2GgdczYEQxbPcO
	 rZrhmnR91dI4ZAMHGM1TpYt+gGxrC559pIBJHTq0K7qwKjJV7hgEuqR5d4C7yFw/poK0g
	 YJ6HP2rlA+lKFLeaDJVpT0oGxa8yg29tR1MBHuykViJAjlBO6vK470P+ljtLlUZokgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116093;
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
	bh=AdeFiplGcKxVUtUPZ3kFt6nKgkxxna/xcrE+GNTnSYc=;
	b=G0/gPCuehr2H9lUoidvb28ukv7DF9j+scQbSGXfqPYsdeS1o7XCrp6xBou3tKQ5UWnkR
	 42yEgOmAgWdeIFJXIuUR8fPWDnrVSmA7Gkfaw/BMpDhNdkLu+3vbSDkH+LNBplcvk99vL
	 NWHFnaaDw4cMdojX/BT0SCHcMy6jsJb4Lx8+bb0n5ej43XWl0E0E6nbvx5SXEd14RdJzK
	 eHOjHvKKULCL43IHUJce3x2vvUvs373GlXKVtzr1QBqLvAdMWXikqp6od2BrfjhtBxK3c
	 ucZP9cPOETjRoy6Tt3TZDAVqRJxSeFEoKByXqmG/JZ2Dez0UOpn8QuDPGVVUU40yaLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FGyUBzjf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.60
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761D606A32A
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 19:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3761D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FGyUBzjf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoPdafU1aOJ0g8DvQrjR2RoB4nJdS8tTEFTGB25VR/oNYJ8g3Pek8FYmOFbBZEF1w+eDEtRoojoqoyF1p+VtjBUnB8qvJNPePrQawoKmWaz/v7rnqdhcLfIUJvhLqnhs/rJzbR3k9I3M3xnlN//hnpg9D3YUEaig4GD9YC3XjQJz0JbD5/v7qCAACABprAvzc7C9hsgQhniFIDJm8nwtV4Pb0A8IJR4ktTMR2PIX1BcVWGRHpx8gepMseNtP5+N8qzIuwFcKa/JDrBmkMlz2wAtW/gNgkyTgZDJ/+8L1c2JXf5ld6kZTdKOhzii+LvZa9RZGBmMY1kFk3R4qMwaV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdeFiplGcKxVUtUPZ3kFt6nKgkxxna/xcrE+GNTnSYc=;
 b=PCR2+ckKbLMNIPmrs1lnVzDChNKfl2bhvlZ3PDqJ8ASOqv4/9vg8l0xECs11bjBn4+OfaokgkhUqLwQGuJcqMNDnPg42Wx7sRu34eSVylKkjz7HZw/ttEjgMfuxKY+akRHHZHBRhxhj94XmGcYEbb8DuqFp8NXsn78t9t9kLUCWS/4+JgrHtbozMYBSUcC5PVoUwisIbYX3Q0ZC5m3lH7uKMzWKJuapWf+QOaPye4356XTzH+6iWDbKHmHVMU6MPfNsDvo114xTx02khF7p4iAHWSUKmToiZuiDw4goTvu1AZOtKjM8pBdol4S8YiwOdWwf9L+EIhYl2OtPrm7VoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdeFiplGcKxVUtUPZ3kFt6nKgkxxna/xcrE+GNTnSYc=;
 b=FGyUBzjf+RRjQ5o4JWSGQf6Ckrnrv2fQm/5DEzkqlNs6a8rtcq5AghB5WQ4OEiy+TzWhUKGrgQ+8uFYYg/QnEI8HNWQLqC3Xb5U2kzWb9+GxZpnrJOTONH2+m5z7VpBeKTkVyBRFUkY1SRzWo0pNbVNdOaqE4N8dVmBCUmjazB8=
Received: from CY8P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::11)
 by CH1PPF351A22FF6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 19:21:26 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:930:6b:cafe::24) by CY8P222CA0020.outlook.office365.com
 (2603:10b6:930:6b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 19:21:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:21:25 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:21:23 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 13:21:19 -0600
Subject: [PATCH v8 1/3] PCI: Cache bridge firmware secondary bus number
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
Message-ID: <20261119-vfct-regression-v8-v8-1-12463194e457@amd.com>
References: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
In-Reply-To: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher
	<alexander.deucher@amd.com>
CC: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Lijo Lazar
	<lijo.lazar@amd.com>, <linux-pci@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|CH1PPF351A22FF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a543d26-2d89-4d51-8028-08df46724de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|261009223027099003|22082099003|18002099003|3023799007|261022105027099003|261026140227099003|261021121427099003|261026121527099003|261028144727099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	HgfKJGZtzEUBpqOB9jGmsI6rk664OYpM+61k8ZkyjzJCWxWJVMWgznLq4juRUE+DtBg6UmRJWCTzBQww84IGcXBCDpVG/qGVJffk3H+huMlesS3V8hgeR1VkTYN3XfHjFDM7+lZqieB3LxgVaOR/orOkpJp54QBpwqSDuTF1kAXu3I9T41Tk5red1hBJcMko8DqDQ5dof2cGy/ldbIeTGS4Uem+nCuepUJQ4pwnGFBiFgqEBT0stqjVy7CEhzWOcvSe4lg/tH2dxGpn+8++EknTJlCJ6hMqg9G56GFUnQg7+SG62j6Keo/nCv1zY2R/KmGTEdSKZFDK+clpNq2kLEaQS5ZzfLstxx/IDPs/RhOD7aKrEPoxFFwrR2VzHYzpCCgD5BiOFBcjTXAwr6/h0uInsoqKCP8K2Q8NP6ZZ38Odw+X/JeH8exC/XrNsi1gIwDa+jYbn4RwuHlZQrIqP/oo6vjrFTWJmnMigAln/1EZPAlf2NGJ4BjKKJy58zyAyZZFMWvkYbgthIoi408kolOETXIHJAIbL4o/avsnyCiQwmAjlYZr63yI3LKayeeUDRn3OD3JogtpvILim+1HvarBTcLyljaDxNh/WcROuEPnNYcBRBMf9lYZSvyg6T5gAUDTGkwL+5tM1FKN/mVmL0gAok2YWUiNs+ZqPx0Nt61JcweNLaFTz0kuKmnHycy2v7UuvpWE4zCZixwQGJjEVotA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(261009223027099003)(22082099003)(18002099003)(3023799007)(261022105027099003)(261026140227099003)(261021121427099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pE2G+zBaWzNaMVAtiwILYpNfWOWAiGDgzoeR2u60OQz8aP0Fg/Qg+VBr6yKuD7lRD0WEPtXKSKFdgoHsU3DwzwOiT1Jk0+BQTVCbJLwUQfEI5OJnF8fs5vWTO5lhS1et3HtjRDreq3n+IunJYq9KIivKNxMeZvSBbH9PIFYARVGwlEtJWdISUYgmP18occaUeEkQ9TANNnxNcSXyExFF1GjHxdGArvH2zC6K+UXMmB4uLmaYZGCpQviKUwZEC4BaO+8m0NFz3yUa6jA3Ysb3SY4wyG2TXZw9ikCMoF5DGAo+p7zJwOz5JZxcug3MofhbDS0Qgp65o+A2Pj/YNqqAz5PZGNq3xd6B4WTwtrCkDnpA6RiqyK89xReTplFW3vJFHQ+zmILKtN2kzuD4umfcJtWnIhqG3kxGdX5qcuDDksXK8DO6iPlrR8lwCVIKkAz3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:21:25.5612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a543d26-2d89-4d51-8028-08df46724de5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF351A22FF6

Drivers such as amdgpu and radeon need the bus number firmware assigned
to a device to match it against firmware tables like VFCT. The PCI core
may renumber buses (e.g. with pci=realloc), after which the runtime
number no longer reflects what firmware programmed.

Record the bridge's secondary bus number in its struct pci_dev when
pci_read_bridge_windows() reads the bus number register. This happens
once, when the bridge is first enumerated and before any renumbering,
so the value is what firmware left at FW/OS handoff. Devices behind the
bridge can then retrieve their firmware bus number via their upstream
bridge.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/probe.c | 1 +
 include/linux/pci.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f4..89a7c52ac3e5b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -513,6 +513,7 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 	res.flags = IORESOURCE_BUS;
 	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
 	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
+	bridge->fw_sec_busnr = res.start;
 	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
 		 bridge->transparent ? " (subtractive decode)" : "");
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96c..4c1b1e557a607 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,8 @@ struct pci_dev {
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
 	unsigned int	devfn;		/* Encoded device & function index */
+	/* Bridge secondary bus number at FW/OS handoff */
+	unsigned char	fw_sec_busnr;
 	unsigned short	vendor;
 	unsigned short	device;
 	unsigned short	subsystem_vendor;

-- 
2.43.0

