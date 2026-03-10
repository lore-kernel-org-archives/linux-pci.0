Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022141.outbound.protection.outlook.com [52.101.126.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA033B3C02;
	Tue, 10 Mar 2026 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125633; cv=fail; b=Sg1cq5gG6uZIf75rXG+jWLR63h+xhgCw0bw94I56Imk+D76P1RDxaCd2PXKt3tu80TaUYggjg7DOESCmF+BKg46mxjg8CbOUynzztJC0K3WtG2gGelx3qL0l85wJ2wheRuyFmAajoZk8tokeqiMFOABhRmgGxpN89/OlbHqAtOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125633; c=relaxed/simple;
	bh=dfYZ/vKUfGMcTg2bKMtJAilVTpuyIpGH+BTvFVd01y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQMN3FZYUUajnoaKdpyiWsMYZKBqBe+dQWqgJjJ3GN827zF/jofwwD/iw76AkHIToglnXZ1kcjCuW1brhQgB64Bm6dpu8kpzxA1v9Qbbsz8lW0z3gzy5ya9+kf7mcOQ1PI6n80iGILAaA5qtZSLlyiJcR8Q9ui4sRh9gZ1/G+z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnhoTii0mPHs30zrZSnVTMOq9NMRPLfazm3etVbQL4OInWfHNcMMw9QOAwbunNY4ysZQcNSbbMd0zm9szGntaeVckzaU8Uhu8ukrQJ3MAhm/u4k7S/T0nv5saw9oA4G2FVeYxwij/Ey7qLi7asmgPICy6nmBIIMYrX5sVpoxFWgPsQmCsI+9LV2AS5tWQEGRZITdXY7Ta8mDGeP+kZ0kjAroj6Gb5TCmFJERPr7q6tivoz1tNIl7B2UbmIBcCOdPttsx6Mm1SL8Z2zYqa9hhYWm6b0WE/7pqFISTFVAyLdBzNw+qdFxxpy+Gp766Gep1YUlfl/hNtbWzy+z6+1YHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKQKILFOMyz+BduBovVO3DdK747FntT4dzQdAFZl5iQ=;
 b=XOfqLyCRFVUQML+yOSAEkN0ibUJLlLwhO4DnLMSa4VkKJAyK70OngELKP88n11ppIpXlBRQ1wSu/j+FI6/FYQUNJDErqWUr4QRol02RfaOAz/2yR6FLEyvHkXlmYSB+/HK9PE+GcsOKGZbzzsD8WKNreKiZHWY2MyCarqRlBDAGsZdbbnVLXbY/gSbB0k6Cgz1Py8X2Jf2A0opQYRmDTlcmIQkbDlxFdkybjj30bqr8KfrK5pyEy3RKYSvDdsdgCgZ4G9SJaIWAdijjcMKdBpTDx0rUUSTs+h8T8tpz6Fi8+gfdIudah0hgSG6THy+cuIFcx2UsxLF5KS/khOuJopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) by KUZPR06MB7964.apcprd06.prod.outlook.com
 (2603:1096:d10:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Tue, 10 Mar
 2026 06:53:43 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:189:cafe::fa) by SG2PR01CA0198.outlook.office365.com
 (2603:1096:4:189::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:53:43 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9DF4E41604E9;
	Tue, 10 Mar 2026 14:53:38 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.chen@cixtech.com
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: update CIX Sky1 PCIe Root Complex bindings
Date: Tue, 10 Mar 2026 14:53:37 +0800
Message-ID: <20260310065338.2337761-2-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260310065338.2337761-1-gary.yang@cixtech.com>
References: <20260310065338.2337761-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|KUZPR06MB7964:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 745ae3bc-460c-45fb-1a19-08de7e71c50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	V6aci+cd6WWp96Bi6I4u/g0xpanlGaizyrNMyhvWkBjxE/udDSLDU/226Nl/in/9UBBk1mBPJmfWkBkZublcKa2JUtJpvtj/y03j7Pnu4xwvlIbUZ5mClY2Fv5Wdf+1CNFR1Xyp+V1rv6XfWG9Cac85mqmLjkK71T+2kvBcpoNy7VamqeoEMszStor5UIFHp2g04drTIGFHHQyseJEevoaxMF/siFFMByThnsYEvinoEPNfyBa2+uBtlK3g8Gvg6NvyEkQNYqX2Sl2KeVITRaOIIsYgHInkaOwStn+QPw65FgRKG+YoaSTw1WLEArOcKtccdvRo4J93ZRz21P3H+NAXV8HLOtic1SKoP4QjPg1gYLTBU5URs4pEno0hLuusIz4+8LRKMtix1fwMUU/p0K0HkNyTS2SY4tY5RFQ3hoXMjD+P3MUv/Psj5pxX4W5Y+gyPN2xTIQRTQ/CC95lwQilHz2ob4pMDgoFpANZ00TStBeTZw3SuWDMvj6JH0fNN1bCtLkJFGG9UI/DWwJLgo1LyLTAXvIlFbio5yczQ4EWghTFElKOeWrXlRAKGdpdwQb5Yz3l8Ipg5WIY5pQsVihJeCx6F5LnoaFI2Q2pV0LFcoPz71qWiWROOZ4io7zuQatq5C9jg2moPu+BYgjyBlfSxERimi5Q0iqp199E1Au2fw2plVXkbvRcnOL/gCz45w2P8JWO3PtZuiSMh7EKJyrjvyv5izU50ZQVy8mdTBXuzSG87JzN3VXg1qGkYAFGaNYIk2VbQ9v1YPgmtQIKd98Q==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jaaYeEfMEgUfWD+y0nGi7weXDNQRMTfSSTKBJ23cpK7QgrJRvAXsKpYJyHnr6pMCrRX2Q6LBzOXEFR7lkszuNK1GqbawDqDhCS9mPxiXkI9LXfedW7FLtyH7grF4y/WiWMpilssVD3DF3+xXpHLTafhnxoR1ISOW1h9sCNeGcV7evjeibA9O6ZWk8dvydG9SKHJ8F/SY5pD1GwXw6wolroJA9ZulSYXORLnajfRPy1kcPKVNqK71jlODc1PtuaIPM9BRudwB2ZpbaEYRu7qQAQ+TITONKcfdVclJ/z44q+YEvTZwuvcIpA4grUnlm4tCH7FpOof+qrr3U3RoZFOV0pG/+tsP7ULB4Hd9l3IuwnJXRe/dE4qjuXgzEQzuTXGumemSOUK/tCC8DnlbjDZq3tlikEGl9WGclqvODUkdDOUA32Zmt8CA33CfWFfqf2Bd
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:53:43.3764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745ae3bc-460c-45fb-1a19-08de7e71c50d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB7964

add power-domains and power-domain-names property

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 .../devicetree/bindings/pci/cix,sky1-pcie-host.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
index b910a42e0843..1d8ee8310588 100644
--- a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
@@ -38,6 +38,12 @@ properties:
   ranges:
     maxItems: 3
 
+  power-domains:
+    minItems: 1
+
+  power-domain-names:
+    minItems: 1
+
 required:
   - compatible
   - ranges
-- 
2.49.0

