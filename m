Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794347791;
	b=Moi8wqinijf0vyReSwEAVYqi+wusooyl9o9qY3OaRJNlH38EnByUclBvKBTEG/LJl0Uz
	 MIWxavwibRhugWnQgLRrOO1uM/x+9wEWfS+8UEFfIMHPQRUme6fldyUMSRXM7hTvf5l+k
	 7FiMtKyCdYWL1wGwHQf3gL0jMYJ5CS23IY2yhlE90yeRQb7e+1PsnMrCNa7o+/gByphg8
	 +YiAKKuJ6zdhFvTlBAA6O5ujVaBI+35yOkNGmtPoIcNas6vYllVXgwzk2VREZ73qpxlqJ
	 /7s6YWkNlNE5XqAd2Ocqmu+mKHOUCn5Gd8h9UYw2zsr99/pdcqbvwJ6kQXI2FlaUszA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347791;
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
	bh=zYdSjp2utcokW4StSyjM0RPfWhdYDHzh5UXs8e4uyhM=;
	b=zF+Exmcle29uAUFD6OiC5K+lS27oEcPg/0+sauWZ+T700kWth3oKUOrWaKHARFU1PFZX
	 Y9BGOkQJdKrfDDZbI2kUroxlXquUF0xp9LsfHGt41WrqRH//NZ6hzj0ztfmpTjVySXI65
	 4/tFtaC2IAWr8D6BHauyp+Q4JYhVPEEevGB3GIeIG1GCTQ1s4Nzt0d+cMcbQpQflkhDpY
	 VmUrNgiHlkDj2IhtQMBlcXvZI81TtklI6DNnC4CDTUARHgpBn2O/oiZ+tDGIZ6LPgUdfB
	 7SELxKqFOE7R2dGyY2OR5nlwd5Aw8FpUSYDoVp89PPHArPVBneXYU1bRsN0xir1mquw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=El9L2mQq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.22
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AC606C989;
	Tue, 10 Nov 2026 21:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 356AC606C989
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=El9L2mQq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flTr5uF7iHu2A8MF12w8QRAnBA7CVa5TIZt8vxXJ8+ma1Kcb1g+xBWefBB9uHbJaNEZYPgGikgrTvysoncj7IK8pwxgGhnpOZKvNGYCA0HqS+WBjjldMMCQrz1PIaROzIL1dBlQtrxiITfrCl9dyHeIEHCMMR6slHWaAsmMtxiCOvT/TjcGO8uXe7zrxe+tFYoditJUvAiA7p51+AVRS4Xj4Bif+zSRZ6VKnxOeyia3JCXLnqyJJ/wm9q/sdz85T1QVhOCx6fjaUzRv42RoAqeciM2Sqm4uVKnDzo6GYlCsdYCzTwCkCCTC+1ZkPxk5glfB8eunKBIs8CHbHq4r58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYdSjp2utcokW4StSyjM0RPfWhdYDHzh5UXs8e4uyhM=;
 b=ylNhkBorIXTeUryRQSIcR7yAiibBYm4iO9SJzHozr0B5MGKLN9PeDWnas2kJzvjOehgiAURkYGktNA6tHtzNmnZXSWE38mgWzhJwhOWW8F/EPGygAzNAwnSBybs5UgcI9Xj6dXyWJ2E6qOkxUKCDdJQSqd9a4xs9bpegbxGiZsXX5NOTDWgnTmffBL8V1sdlbdAm2mHm+XYKB+8iHh/FXWvs3A9BkQMDrmg4zqYV+vcXEslmjnIkSvXIw4VDf1nhacbJhwkwp3dz2uY/NciIuskQiVwTwoMeQGqbGrwjbp/b1oEucT/v2KsRbJKkWVI6CU7EWvnTU1vI6hLNbR5thA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYdSjp2utcokW4StSyjM0RPfWhdYDHzh5UXs8e4uyhM=;
 b=El9L2mQqa7oq+rNy20JiX3jF9cbGuIY5Sm2VAZNULBseHIF4xAnYXOIHu08ROiHRTA9S5EDK2HnydXFhN8RpjPDoEB5d0hjwIAj4TXYj4MQmHjoIHnrJso6i/faH67DSOgO1xFkEdC29RsrSEYHIBIDEOSuJaJ0SMo3D1ujEL8Q=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by CHAPR12MB999225.namprd12.prod.outlook.com (2603:10b6:610:2fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 21:56:26 +0000
Received: from BL4PEPF000003F0.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::62) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Tue,
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
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 1/4] MAINTAINERS: Add the AER sysfs ABI file to PCI SUBSYSTEM
Date: Tue, 10 Nov 2026 15:56:11 -0600
Message-ID: <20261110215614.3931232-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110215614.3931232-1-yazen.ghannam@amd.com>
References: <20261110215614.3931232-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F0:EE_|CHAPR12MB999225:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e76f49-03d7-41e0-75e3-08df3f75777c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|13003099007|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bY3LiqIMOd+FQNtljpW5dYMT69//6HKaGeEt5KcaElS1seO1RyeqDB1EYzFbP0/QFFN9rxlqyDdldTVJpOhxw213czaQtR3ZnFh7jj8sAKw0H9QAW9HML90euo071xTgTnLEv9cJOj0SF/ePhqwErsfKX2tusw9223wsR5XqtkcBhqQwnT9nxAgcMnl/kY1fC5Zn5k9iJ4QyaPlZcZyVNOgVeXJ7c3/RoI2GS+TiTHUSloM3/SyepcDfpsErqPn5bB1TloqHfa5Wvn92vXzuP6j3sD33EE07b2gnQif/V6KjvMFYUkGbbnB8+Zai0fY2fCw9iBwetFRxtnwXnoZVTSXmgfPKxiA7uMprD8ffFtgsooLQuM0AKeWtlXRnRmgP32s9YFFdlq+zotdKue6V+65i2kiuxS6ej1i41X4n26mhFGI3kaa5OCQTPRAYnUVsvJa3gzPVCCgB9GO3OB3KPpp3FysCiYno+IPgkBOG5ZpBOcu5IfLBB1LaLxtfSR1bHMkkRUTRLzIAfZRJiKf+Gnv45D7FXFKUgs93O5vBFgSRHep3CIkNLDtuAls6xXveUMkb+Ir2JYUSXaZ8xV6FF303daLZngSWkxmEQRCwD5ynZEWYdBuTxZoRV0f6lwaVuwT7MaqAmeVXLlxbnJ+Gjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(13003099007)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3U+bh5girF6maPhi+BiAAPJVj6glqMfxqM6VW6K36AI/i/N1D6J08BNj3BXM6L1GJHGd14EbxNoCiCjMXX85MWaD3JL9wFNZw9pd4JlU6fbMJ7MdeCMV9s06Ofr5RIvLMuNMsiCEU4DPW9zX184/xeb7RxH3AOOSkPdQEI+gTIWaQzN5W8bHWBC1QQu+nie9pUSCSV7sRygRiWUqmtPYKxCfSvzt9p73Jn8XZoVIfZ0ypMImNM2wumUMHDNdO0WxWoGqq/w+QY1WOPqEo9aYC3khLFgZRXC+6aYE7WhAeft5F3ujMCNl4MRzUJuTH/4z894Uo2iQ4vfZXr4zlJNRdYKVeGrSI2C4tBavCxVFbhUSgvTlP96GA2SPdJO9UHsO0AW+VkfxFbO8zaI83ky9vSBwdk9xxZ5Oas9Nfy7FV941uxNzFCI7Jajv2DpfJv7H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 21:56:25.7826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e76f49-03d7-41e0-75e3-08df3f75777c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999225

get_maintainer.pl returns only the LKML catch-all for
Documentation/ABI/testing/sysfs-bus-pci-devices-aer, so changes to the
documented AER sysfs interface do not reach linux-pci.

Add the file to the PCI SUBSYSTEM entry.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..b109c9f8aad6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21609,6 +21609,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/ABI/testing/sysfs-bus-pci-devices-aer
 F:	Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
-- 
2.55.0

