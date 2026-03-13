Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022091.outbound.protection.outlook.com [52.101.126.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C06377EC4;
	Fri, 13 Mar 2026 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402562; cv=fail; b=DB3AQqWOVplPvbG8lwC90wOBWFzda5NH5OlNqxJHNJymdmLPXOxGX2HqS6moEekdz8+Ap2P5Ts6JTJ6LT8+cE5kURybj/NpF/rohPDU9h2aN4y9kKr0j9LOWiv4ZEr8bqYkUpV0UT7sTpZZwge+Vx0VUJ9QkrDxNFquM2bMXFM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402562; c=relaxed/simple;
	bh=0Q0mg4gmy2bK9FsrQZs/oMWi5kwFFuMELC6lpe4SwjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEesXpwB9623OrFNTARoUA/p4F9DCvQ3oGxteTudA/kXcQoOzkKgcR5m2VDYTJDz2lpA1OLoZ1cl4CScRNP8RvEuunid0pCFuEcn6Z9BJIoxsPhOftplhhifQmI88VI441HP0KCcLTSivfmubE55mjoyzZ1Pw5639JXBEihlz2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=webGxCfzsDEi+UgvOYjK9aYRdAoU5XjJBDmajb5k3cHhBWGaNAIblzvm9EjyAtONZfs/G1bSLfLlfb3jetPhr0u6YfqeyxjL9DNKDz3B0yjU9nmEA74WTD9P4xUpBP7hT/Tlt8eaqo4lzqogyezCzKYScg113aMwnh9tTtvvLiv3ftlfmyDg4phhEVgRS7cEnhD1QNfFQJjecGay6PwISQIIpWfFOtXDQApHsM2TekKq5LN6wnXhXYQqcsI2eX33w8kt2Yz1GInWnsIxmUrf+0CECK5/OQpPeurqf/ZLzuXOE2DYpKrWTqfP2Cs+GJigV/UDwj1jFX9b1nVbGjFMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4pxR76JMOqIQBEMiXt7xgkvKZiqrBwwZ0oEQFjBAmk=;
 b=AhgUtvwQSp72VomGLLRcmwCoO19hPNrU/MEgDBTJFjPrxfua5C1bYM4NXF0gel5ERUxCJ2jw2A3ouErv35PoKnE/9+1lXmj+t9gxH+YRRDYc/0KPxxA5v+rMu9IXqc/5p0Us8fao4c9NQwBZgq4qC0PVNj4xyNuJ4T0Z9+JB6mF4yGBy5oA8FjQChp17zBbd60ejRtWfo/fCSzVAa8gGWkOolwHrgz3pHcapmuJ1BP3e0iscOto5dj2pTlTk/xbt6pwVHjDzwf45u6p86nyMhR8D4csiTY2R7rYzhIYxtq92BYPCM5KRyTtO1zvdgMum80GGj0gDTKmsBUYxNIOnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP301CA0029.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:381::15)
 by SEZPR06MB5000.apcprd06.prod.outlook.com (2603:1096:101:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 11:49:17 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:400:381:cafe::3b) by TYCP301CA0029.outlook.office365.com
 (2603:1096:400:381::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.30 via Frontend Transport; Fri,
 13 Mar 2026 11:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 11:49:16 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0A1A740A5BD8;
	Fri, 13 Mar 2026 19:49:15 +0800 (CST)
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
Subject: [PATCH v4 1/2] dt-bindings: PCI: cix,sky1-pcie-host: Add power-domains
Date: Fri, 13 Mar 2026 19:49:13 +0800
Message-ID: <20260313114914.1564115-2-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260313114914.1564115-1-gary.yang@cixtech.com>
References: <20260313114914.1564115-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|SEZPR06MB5000:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6bc40ccf-9578-43b1-cd91-08de80f68e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k6XQPeG+w8wAJSf1eIHI4xviWUvfvlwV5tNcYZxelkY/3TUmCVBPWQNuqdiik3pbfTDIBc+MS/QEAamqi3IuYKneF0FCxKNye8o6cMykAGFwVrcvfdKQ/WNMzfxEXBEj45/1eMqCANSHqhWIxXQKvqwWxqJ3xwhFUOiz4uxoud7PnlZa6PxzCuSHpyVYw+ju3gkSFbAx+DHd4mQ9HdtTslLMmikjgpao1GEOmBX3PMfkxGJHLg1Vmg8dh3lFZYvpWvv5WpavayhNyqaX9CwG559Jwd0C10i3TBNEcN8fi+7w+jQ64cF8O6zgZGV3kJQUQpKkuCZCSkPtqX9Bh5FwQIrj57jFAGDMHqMGqSDkRzMVFgGQwbTYK1qakp2iTlPdDphIuQOFLb3SjoWZN37baCPmfRwhwWHuUFb5owKR1QrRMyHH7fUKd2CSIA3WbU4maeAM9OaSHOugRiUO5gsTaYqULRdhzbVqw9K4YEAMxZN4WVmKvLUGIlK78Nut5RomdTPD3caBwUlP7AvzSAN7ZBddXBF45EaGcEtSOfxA3F7bO8A72TjMAISDF2z8FKU72WAtI+dlNBVzrlFfMib7T8imu1aLuxJ43zp5eFFtmcM45Ua58yfVxEdq+/R4LsqjNBRqsk7oS8WzviBolPEwLtm9Kl0IR3PDrmUzlPTOPBsl5mmbSx3ML4Cgzt1cgrDKm8kGJ3TXohLiXD6MbPT8r4m26HXha1ijWXWth7nL5WwR/iYQ5Uv3LsULl7drvsoXbciQoTVUip9SdfiuyOtjdA==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lv8kwz+kcDf0aLSC6tRx38WRfsb8nTmIYy+t2FsJdcLi3sVLxhes9tUNcsdGM1xAot1qn2chS70tJ3CGIJYqpwMjhy+e4XRs137lBni4BpSAcodTrqh9xf6LUBlCSRpoEfU29I2aVEl2ebqzqUUzMaDA2TJLhse2Djeqa06S7wQOgf69AX+XbeUgXz++2xatqYn4/PuKrui1yj8iCzAMN/pEjbQZW4P0dmDEvJdCX7rNz8JwVuctduyixjC0y6RTiVsZY8oAOfiLHbGUjqKwm0j8MesuqQg5QA+qzGYGwOWLFjaEVoefpdhcAlDCjGGbiZqqxY61gtlDv8dN5Tl6HKzz34ZN0Q/liE0VFVnRIQPuC8U575iRRlKVhX/Q7YZdR0UYJEr0XNXVn7/6ZOffAG7MBWJbUxE/0oU1YjuFLIq19SgoPf6CmszbxGSqKZ25
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:49:16.3913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc40ccf-9578-43b1-cd91-08de80f68e4f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5000

The Sky1 PCIe controller resides in a dedicated power domain managed
via SCMI. Add the power-domains property to the binding to allow
describing this dependency.

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
index b910a42e0843..d55d165f1e94 100644
--- a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
@@ -38,6 +38,9 @@ properties:
   ranges:
     maxItems: 3
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - ranges
-- 
2.49.0

