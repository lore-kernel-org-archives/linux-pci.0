Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794347792;
	b=P8e3k7nb0+QFp6rZa0/WyTonbZbMegvuPRXUSzzDMErlmNX1WykO18CQRfButWtJXG05
	 YBeELb5akk3te7epgM8PDAPOHNtYg880BCDKoRktBSLdG4YT0Qy/fHBQ3jpWNFQYeBxQY
	 35AHDu/9nHyFhanhJEL0fFupnOMzCvz6jnIvzPR0jGIDRjhmeqXbugaBz/0TalM26d2XE
	 9p2F3WLzvoTy3cVEga5eZc/htfl8p+Pt91a3jG3hEXGkIfYogU7XlYAOgiExf6mMUKpF3
	 xIoeNbDkg5TdFWqqTQLNNfyX5YeRxYDBOjhwqIuABUpGQjfpB5AdmNcJFvqyHVaesYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347792;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=zB5Imvgb+6kg9dkoE+3cmzTl4yt6wTx66W09NBbOidc=;
	b=i289lRGh4gNiXNRTCJpLKm2mn2YnhbFV82TDGsfGQ5BoJZmbbWmfOedeAGWHJLqUKvEz
	 XfUD7jgbSUpcawcP9JVvC7y481S4FdNerYY0fd7XOFWOKYpnvK3UNSXx1+9fj4wodhsNI
	 zpTSRsIEOyJZHAC05y8GV4PChnSPe1jh36bm+hH7BP/Ki6U/KvTJdNFqttaULIZ/RS6pk
	 xkv6ep7uH2/cNCUFCU3iSfANgUXJoPoBt3DnJGvwy3fsqfPcxuGdb8r6xUl6bmipv+eFc
	 p3NZihqxnCFNUp0DwD0o1aOVuysFx7MMNJJAuDVXb5O3Ze8owRebmNr8mZZbNPoC+Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eTOZFK7+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.39
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB61606A981;
	Tue, 10 Nov 2026 21:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB61606A981
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eTOZFK7+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYihnOvbcMEmXXa6S3f6khm4dxE9JrQbUCmicuYGgKFyN+en5jh+f6L2YBoKcVCJ7nxQyLrhBY8N0tkzPVhB0ZEsVRA/dbx05yTMeEM7Az6XxRz9bO5ERuaCaWG8wrkZeGXI6YidRVe9k4qAi5UYSrkD/flMTqGxlyhq3DjL8vUQFjWkteLCHde2ZOznRmO0brJpSQCmHqpUJ93gPpvH+/vGtIASsI1J4dgtQe/QxXDSjwAmg5BZ8DQaoIgJ83UxTVTRNun2OYfvE7OEuOVJchi43rcBOEjCrObY1KThd5k3DJcTHlR2GF4fqCG/FvFQNcO/u+3sG7DlCSFIi7ffIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB5Imvgb+6kg9dkoE+3cmzTl4yt6wTx66W09NBbOidc=;
 b=N/tUI9vK+m8pgiGMlcISkEaKeuDxLyYz5wniAlQs8aDWr0eCyxvcOllugnPLt1Kpl1u1PramdWfY8q+/eILBGLbahs5xVpVg4EuMY7C+/sCbaPVkL/SirUwXoOo77QwVxT1v73eT4afCEr3Ku5+/fSQng8CjXZOwiN8LUVvfkRVm4TWJdU40RxW9IFuq860L+BcaovdE3GN6SZqu+cFoHoL6xiRV5VPmC5zWNqHKk5yK+Qu7Tn7QDv4sCujTsrWEZ6agIqw6wknhX3rza7bFsHSXS8Jpg/Ufv4VhIt2SVGnfeOTMl1fKeYHAsgpbkIJIswr1OdC+OUVT7+D4m6Nt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB5Imvgb+6kg9dkoE+3cmzTl4yt6wTx66W09NBbOidc=;
 b=eTOZFK7+5ArwF8jdmg/rxKGZSxRS45apWc27E9g3YnbAHq7X2pizWFAKlxbWLp5XtSr7sGo4tw309Q6Lk/v8uFkui8rL+QA12QKu14NYMSpf/Ya8859o1+RtfeBgUrqrk+Ry3q/pQcrO4WWH43UvzLKxIPf0mxRhTIiJBiCOmqY=
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 21:56:25 +0000
Received: from BL4PEPF000003F0.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::1) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue,
 10 Nov 2026 21:56:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL4PEPF000003F0.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 21:56:25 +0000
Received: from quartz-7b1chost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 15:56:24 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH 0/4] AER sysfs fixes
Date: Tue, 10 Nov 2026 15:56:10 -0600
Message-ID: <20261110215614.3931232-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.55.0
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F0:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 2679b1dd-099c-400e-2266-08df3f757714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261021123027099003|11063799006|261009223027099003|56012099006|261021121427099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U5mWOC0j93Jxibs8n3dGWJC36n0M000tktDvTUV72gVjJ62+XXLxrdI/9BY+vsdXqwpG2kZDewT1uqYYDr5nqI/BCHRhANgExwwA8dtmCB+WVde9vJhwrCgVFORNty3biQlj1cy0rwnOlgKLNjmD6iA+GGa4KwdiV6zF06sff5K5sLqJnwtFm04xv9QsotHfCj247wCZELHdUQWMSnLxHmEUGdqWD9Wn0ktLvSBOllP5G5OFldJfeeEBJNe8SwOUdFPYEkc8vWAxBj44MdQR/1cs82yVGV1ZO/kqQbRGR1ISGGyv2WC9m0qy5RrGrkPiBXTp9nUQNAGDI+vps7HYgYC1xVKEw/qiZTV0a45cIyipUpi3gG9M0pnhzp85HJc54h5uvlIP3Q0/kY3UB93jC5KkVbyHfyf88a8A6X/uefZ2Cvt1S1pOyxlzUNd+yiXyXF21DiFw2LMBYwb6riqKEt1MrDK+zqXKkcJBjmAjUyBlh8b/7UOQxN9EB3xory6hGqaKLSaMjLT/cnT5YL8no5y8J+glS8MFukFea70xkKgMpmCF/1tuZpIFYLZlHsnkg20hb3LEUyV9vhHlEfX/Oj3AibKnZYgIXCCSbGlCEiYQ6aeKJ0ak5Wh1VQS7zBoOUH1lAdWWzHSfhAT76DXiapS9LN/7EXYfAp7NwrbqjS8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261021123027099003)(11063799006)(261009223027099003)(56012099006)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oWdvu3O9VSnNbSH9+qy764f3wgkfhWhZ/oIRcKiyCkD/x+ICqdWghcgpZtcyZo6lxcsKHPVhRG5sr4BgcTAsPKvA4IzDNIuvrKiZwmZxl5fqCbScFzrI+r9vrt2y7YJK80bCQtAg79sfWz45JILRUacf47O9QZR2h3fkWzwz1SX+4Y3DYmzZtfCdNbhAZbPBmpcoELXHUfsKyOmQSuDffEBYDqLLATIIp+xyv57oTsWFn/OJf1WNDk5psSKn3nAS1fmbzSpWR9tPGO2eRn41piba1q4TT6InbrWJQ96BjvbSNvdAdj17Wy08G8wMaedpjpIod172MYJGnRRYACQH39PgzQZCPd5Omb5Kq/SgZk7AjT/lxNNTM2I+dXYyOirVI9u35bbttwuJKq904NCN4jaCGt7K1/z+WsYYp9RCqfX6UM0fFiJS/ahuMrvPXrN+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 21:56:25.0966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2679b1dd-099c-400e-2266-08df3f757714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122

Hi all,

This series includes fixes for issues reported by Sashiko on the Flit
logging v1 set and were included in v2 of that set. But I figured it
might be better to send these separately since these are independent of
the Flit logging capability feature.

Thanks,
Yazen

Link:
https://lore.kernel.org/20260918145619.3016889-1-yazen.ghannam@amd.com

Yazen Ghannam (4):
  MAINTAINERS: Add the AER sysfs ABI file to PCI SUBSYSTEM
  PCI/AER: Clamp negative ratelimit burst to zero
  PCI/AER: Report the ratelimit interval in milliseconds
  PCI/AER: Hide the "aer" sysfs directory on devices without AER

 .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++------
 MAINTAINERS                                   |  1 +
 drivers/pci/pcie/aer.c                        | 22 +++++++++----------
 3 files changed, 26 insertions(+), 18 deletions(-)


base-commit: 6d69eeae8966bc3bea0facbd550f45ef9de41cc4
-- 
2.55.0

