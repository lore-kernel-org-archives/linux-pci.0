Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023091.outbound.protection.outlook.com [40.107.44.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79403186A;
	Fri, 13 Mar 2026 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381795; cv=fail; b=LXLNayTA6XXHjgykdCobGcSigNYxfK1rU+6IzOwLmMT0FJGs8AITBgWvFwDMy7jfZoINguo5+3hCFBZwQGw44uVicIKHdDCBz8VWESwFXzQdV4WDnCGfrHO7T4U8BXrSbRBSZjygxGTElocdFuXZbIwk3WvfKCT+do++tcfnX8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381795; c=relaxed/simple;
	bh=hGlsyFstBE+E+SKhU/Z56yxSpm2Z45KdavgTwNaV3+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+rkQ9T/eMxM+7hCF7OYSyDptEt/7aKiUDhL5AjnpD2llYeFpMIyvK5IIlmI5w24J2A//bZZEB1T6Oh1V04Xr+TgKa1wvIm+SCt1y8Hl1AHOrXMN72+bShIlNFvoPtL3wwpmOTAE6Vniqds70RpQKjeKRxwpe47Pti/n2DWXtms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYOGaojCNLQCz0UtKdT2VOIcOHyApObU+cAK95xeZYyhvB3IGunp6IzgA2wnbGqhsrgwrpVOjyXlvmH42l6J5MaRYlauKTIH4BPgiYE8l6fOMPvWjgeBZvH8gT3uPenCvYEvdnHhE0hq+W5SxeUloyNjaOk0mnrAAR9ToduHP5luVIoFXKKq0A1qtFXEo3aHYUpGpRN7G524BmXNWkzs6qCrldyQCghwExiggZ1iiInL8ARKt6h6jQpH0/ap4KkWgrqjwULZubVsg5QBZXF0y7vPvmrjNw9SFd2DTQwIhLX3y2RiNnZ06ZLYUNq51UfT5MDdp95xw0YcM0b7ldxbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjYX+W97cRDDa2kO+CrUbS9Up1wd9PYuT7fIp0yZtSk=;
 b=VC7jWb15j/zyciJfWjjUbSH+p1cFJvOFuqs9SnwrRhd8owSWXpN7/EA1OKlXPLUI7Na3npRoVRDRwAHz/EkQBVT7lshq5YvZ7bu2jdNH+Tobr+JCZiEbxcLl/O5oZBvK6Q/I48qbf/c1FQ/RFaOndXaJPJlzV/SwkZaCpd9tn6w9NgRAIXB0HUSqXrYC4y7wYcTpH1zTZUvGJXmgMEFt9dE9T1U0tcv3RRWyDuGIDJZ6dyIUvDPuvMb1s75k50kA4b9pvqV+U+z9dcw/+HtwFC4547Q2r8P9D2j6VQh5GphMwYhAKRYSYEGgreRYGNZgbNcMavVStc1iiRnQcFrqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS7PR01CA0270.jpnprd01.prod.outlook.com (2603:1096:604:255::9)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 06:03:10 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:604:255:cafe::bf) by OS7PR01CA0270.outlook.office365.com
 (2603:1096:604:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 06:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 06:03:09 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id ADAC24126F8C;
	Fri, 13 Mar 2026 14:03:08 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.chen@cixtech.com
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: cix,sky1-pcie-host: Add power-domains
Date: Fri, 13 Mar 2026 14:03:07 +0800
Message-ID: <20260313060308.1300518-2-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260313060308.1300518-1-gary.yang@cixtech.com>
References: <20260313060308.1300518-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|OSNPR06MB8468:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46aa8b3c-704b-4311-5b6a-08de80c6341d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eJijjM1XmYNZ1tMHd/Hj9DVj6JFDxQ4lHLTQteddAwazLHgccPHqc43Q4fHXA0xxm1C7kbSFNeCxZkkTGvAxldyw8yzFwXTkEnOq/RtE+/Nc7jBrhUFXyiXI3Zq3d/pdbsn4Sm+BFcMh4XWwLClnUrynC3Re0BqPks18iwwPpdwIDfGPaGx1OXFV0VZkiSFUiA1TRYOXGyVrBxBgywPqcrT99jusODdxbuvLSlp9m8atOZnkR5VDNomITy73YJJ1iaHeqM9kC0M+kupxqN/2HSjG6vFzKOxH1vgvE1Q8swRBREwQYoTV9/c/IFY11pLJc2oLb8lCB5IdEqxvqkveA3Iyb4Vf+NroLkc9KSgs7hZ1ZrtWNOALrmjFln2bBL27ofiFlGOeTr73xUFez9TRXOsZh5M9l2Zx/G5zyJrPQI3N51DidTt306fDLXYT/8Si41iuPawgsGPcnJuObX99WD+nJxswdZPbbCd9xleF4uF++KpE2hCKKkzVsj8+olQyYD/zaIALrZzGQUH1DPl3uTzZJtZYP4dj2rTRoB/MNMyQ5xoHemAuxxjh1QXqQIbbLynOOHK/PPM5LOjOvh1zErxzTYaQNPmIAuY/G0nsk2oDJMI2ZDaIVE9mXbol1zX1dLori0NascghI4RIOdvYtLM5HVaMzIxtRBOBmbfsixe3d1roPS4KlRIrRIU4M3fRhLmVEpLYjPnWKlqw+b9Y3VT6wUlWVGGE8QA+JsdZB8Q3NiAz6WCbnL/bmB3VhivzGrHCF7lPGQxx5WBUZJO2OA==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4j79iUDLr7mtBqtcwCXvbBrU6rWNCdCQZvu0ksw4++H4bUpfTrPv1tMEU5CYoQfWB/5QXop8v7/QztGlAlUwXsU/91V/C6P789WB9UobLQsnwMCralymTlVWpJdEK0roRMxXE9sI8CENX46ogEjwIKV4DwxlsbUIqzQsIUvDXFTB08sYII1lbFcoJ5JszkrAhhuO1NETTdN21C6YTe6GmQOnerHz8JB+cObvYZ4wckABOgcnV1a5QY2JUn6QX7S84+lQrpI6MInOSKIrbKl9iZyPl6Rq/EfiMro+K72IB/YXcPtY2PtFDcMdVx8F8QeXmRrMahir5pOG0gBJfaZny6VCLDnPHft7b4po83FSW5cXMTWJSEIZnvLLhuiMLWGBe0TbUSbXDvgG5UBCc5TlegdovAqf90+tNVor/yAOfT/qiuDjFxOWCQYfKMQURz6z
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:03:09.4096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46aa8b3c-704b-4311-5b6a-08de80c6341d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468

add power-domains and power-domain-names property

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 .../devicetree/bindings/pci/cix,sky1-pcie-host.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
index b910a42e0843..6f194319be52 100644
--- a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
@@ -38,6 +38,12 @@ properties:
   ranges:
     maxItems: 3
 
+  power-domains:
+    maxItems: 1
+
+  power-domain-names:
+    maxItems: 1
+
 required:
   - compatible
   - ranges
-- 
2.49.0

