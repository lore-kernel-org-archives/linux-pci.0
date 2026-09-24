Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11F4B337D;
	Thu, 24 Sep 2026 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277079; cv=fail; b=l9xywhDknXo4QL0ijpkVsm5FDd44ZEKxkVMzBE4Gg80872wZW4JPwg/kFKYTW2XaA0Ixsiefs1lVhPXkr/rFB2b1QbJwcyTAZJ7lDuyamb4pmH1AA04viTxvaVJeiKBwpXerF1NTNUhLpfyn9pCsMP8psm8WmYOM5qZNUx+BHF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277079; c=relaxed/simple;
	bh=KUl/SNyHfUbv1ZpzqChynJ0BHVfCks3BudvpuABnv0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rayfwEEqwsQr59Ntt2S+nV7+cgULlwTCdJ0YeY6xO5j61YZyGPIlTCEbhIbofKUe0x0grXFmUStiYh2N7zII5D53yHsZNavKRdosgqDN8TshbDMeOMGl50iMAoQjwzQrBwJ701N7CqWhfuYR1yvQ4stAlxtcuzfCO8PMnS9h388=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y2fV1YN9; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y2fV1YN9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avxns/CJ6vhmE15izKlXKLm4XrgnjkPacMfOS5QZLEzqe5P+3MrrJ2f17w9Wyq4cxk81jDFOYFJJ+7gcKLeVmNJWr/BVNxpjLE2RXGKr6Zl2HatFDnSVxi3clnzEVZlJOejQN0yht1OZE/xY6PXFQiO1n4dH0OCN6iu5exTajJLIOSnbIyGUxXnTXbuxZCKvy08/jpcjHo+oObBBUP9eFWU8W6nfLBGApjpXjuN6pqddsaO6rROdsmfdAcYfH4WBvCLbigQD3GZfhgZwIImpNtne9IwLaCmyvJ2ctoCTnhKl3vsb//Yvfp8Bh+j4bQLyIm5VkQ3yLDlQmtnC0smNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGI/Clke5Xu80K6cs3IeCNBCjj/KZBHstMSKsWlysmo=;
 b=qqRyDPaUqKLFfoQgJcdwM8wYo9Es+iPrE8NISEwN3hcKL8ABWDdHmVX81l9j3AVv9cnsqIsjJ511SxVrjBsL4c1e9TxBbsdFRS8720RLeVSQSA54TTHcCXJcP1zMbHXPf2FDkqG6RKPhJIqagwvv2oFKodnqPC+GKxwejF/v0065dvojNH10osCmzP1Sgfv7hUyQkrb6f7hhOGkQWKke3VPjheevcBRohZPRFLT5WfSAfqTxbWoZESZaY4fQa/dE2IcYdAuAmwZJGlAcOEGxkTmK32ljSKhK/EHIzYSy9NWsvW0OT9WF4Le+AzmsCfqA9+Kk+VPU9Ic5/UpELmOcug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGI/Clke5Xu80K6cs3IeCNBCjj/KZBHstMSKsWlysmo=;
 b=y2fV1YN9JZqTLKPcIZ7qkPGzAvmzbMt0KefJ8p/PwVHmLGc/+f579Lm3Z6/0C5sb9TQKP+bXG/OO23NTkGe/p3YbwlMfrlDqpokLzGzJ2NXPLrMLc+7V+kfjYIchgQMXwvz7eoYTdGg0ORwk45HPOIpK2GRdmO8G9yUjAB91wc4=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by LV2PR12MB806340.namprd12.prod.outlook.com (2603:10b6:408:422::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:11:15 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::17) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Thu,
 24 Sep 2026 19:11:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:11:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 14:11:00 -0500
Received: from weiserver.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 14:05:49 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrew.gospodarek@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<fengchengwen@huawei.com>
Subject: [PATCH 1/1] PCI/TPH: Validate the firmware Steering Tag response
Date: Thu, 24 Sep 2026 14:05:43 -0500
Message-ID: <20260924190543.3424792-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|LV2PR12MB806340:EE_
X-MS-Office365-Filtering-Correlation-Id: 5519915b-c242-48ef-da8a-08df1a6f9a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|5023799004|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	50MsqeO/3LTHC7uPpjd3SJyR8vQHF6SFpOP5D8EBzOcet9qv96JuToDSYr7HLIFw4uQ8nQDEViuj+T1bQpvR9kD0HzictjCIs/0JBbOqqNln0iD7r+Mynqihj4fjH+ZN13B3vc7zj4/W7eYU3Bb/GUhx5a1xe3FtmurFFjuYOWg9Oju7jDU2699CWM2TCq2reDpCrnHXcKEOLbNrQfSwBjGmZBgWK18cecRI/QC0ZL/MmLUtYaFIGxHokZ9hAfT4TbFwMi5lBK1u6bg16uj4KaBVAqUOns77Z/sXuR6eaDBj6L/vo1VZ1+IQMJOP15hCN9wpDcyF4aZd5G88IAnfIX/7OI/MZ12Ii0lvIxbXU1y6agQPvWfglWat3chRGQaFTyrtGJB260aApuv12Fin+u5BcdN3B1QNMauuGVoHDXpbOZnZyWWOuzzlONedNwVAeJCv0r86p8j5EFLKVJD2bhXSb8JpGoYELVZrKWn3+GnkoROEG/6adHjbtSrXS+KjDYbePeVCoiUguZum1FMrp1obfpSIIxb9wegdn4b/WgyRQcaxwBygklD3KJf3mdlySL5/YLyGKH74YUydS5uwW9P0Ywu5hI6zydZtiK1oM82RsPU3MZufHLVL/cFDT1sKwMch4N4jOBmnGo2fAvhOB0NURk9TUMR/TxpzRFbv7ZAh66dXKroym/OMryebvoGjDlr9p5ABjWzbbYcnCL6vsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(5023799004)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I72HU8pp8sSpV13bQCQQ9WgZmTzjvi5Jn8C1JlU+jkNqZxufj/Rp7CRa1U+x5HTXzhCXbAgGu9SH3afq5p/GkstL4LdR77h8aOsoh5Fx3yg8Z4rOqpzPzMxuFYZFjhC22aI2CkbZI4ltKMdlWAY1EEAw/j01OBvzp95vnys+BQezj8A5S5VpMWEbEcciNZE1kCzbtsoWmgI0PFUMj67BfodAy57OyELEktKEQUGqmpt4BZuURVEn5Nj6VhJPFYHIxLzkk0yAYKMPmI9/Od3hd0BgPIpDd+qEuZYbdaKiyWgAUrYYQ1g2sBZTL1BRRZa9wnY3Ab9IxpHFkva6CWBXOjJsNVcU3a2FT3aGQ6DR9EV4GE0Zxi0qFoSADCSjnqmCxgMIJ91HOJpEYaEG3ICJZjxCGBPeBYjZZFU+CiQA59uPzWgyUBMhp88FuX9TnE4v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:11:14.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5519915b-c242-48ef-da8a-08df1a6f9a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB806340

TPH _DSM returns an eight-byte Steering Tag information buffer.
Checking only the ACPI object type allows a short firmware response
to be read beyond the end of its buffer.

For safety, require a non-NULL buffer containing the complete value
before copying it. Use memcpy() so that reading the response does not
depend on the alignment of the firmware buffer.

Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/pci/tph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..4d064b86befc 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -119,12 +119,14 @@ static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
 	if (!out_obj)
 		return AE_ERROR;
 
-	if (out_obj->type != ACPI_TYPE_BUFFER) {
+	if (out_obj->type != ACPI_TYPE_BUFFER ||
+	    out_obj->buffer.length < sizeof(st_out->value) ||
+	    !out_obj->buffer.pointer) {
 		ACPI_FREE(out_obj);
 		return AE_ERROR;
 	}
 
-	st_out->value = *((u64 *)(out_obj->buffer.pointer));
+	memcpy(&st_out->value, out_obj->buffer.pointer, sizeof(st_out->value));
 
 	ACPI_FREE(out_obj);
 
-- 
2.55.0

