Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF243BDDD;
	Fri, 16 Oct 2026 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136488; cv=fail; b=pDfdK8p7qlqjlbWwu+oNdwFYjqEhsRAqam64RXDGW/Q4VFNrPzS7DYh2iXR/y3AX0emaUsjeqs2h2RAwbE8fWyoHw5Gi/PZetbw5aXddJqhUegR5tqUIOHaNj7UTDnRkH9eGN7IJLjprtFbF1fTCNwJ8WVH9qFX2JgnCbnf4rKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136488; c=relaxed/simple;
	bh=ogGL+sDChudriZf9VsPGuFKae+D+YVG9L+LZXXB0fqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1wKCPt9e2kCwXM+gfOF8WP55zaZK9W26HjOKj2Si6Hsw63YkKjRjR2NFKp0zqQnyYBRoFTSJ5dloskhVtPrbsOhhyEyrFgvDvXTKCElgHcpXIuJby7hQLsjlnBoR6h2P25X0dhPBZaQcFg49qVS8BwLrO8ViWHMYtgi9BEJ1vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QzaExV+5; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QzaExV+5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pflh18mBkl4ULcAUghe7hUpllVUkc9ODaBmYt18kIuFiq+Pte3Z1UVX5veK3BTS+yLqmZLea7Mhw+5IF+2myP4hIZ/SAw3oAC7wKfchmseQCqcwUQsab9jS7dMr58jD4Hc1qrfTziCivHVrvF80M+Rb+PmDGL6MsNzlh1ZuZGjPsAkPatOAgbbnO78Ag6FS/ufItXWmBMscHmmCIBFO75Ei3dEUs1ofg0nBL61Y3w7Mg77iW9/Cm1SxNbEBMrRjnm1/xS4ElspvUuCE1GxnPJX6xb2VRg4/0jxMzmxfxSqSN6tvbQ9eDIP2Fc0DDjE3p8H1rHp5/xmEoXQeIPYnh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzNLXQ+ESw7mE6bXw5OGhQNE3KXYHjqvVU8+2FiaTwA=;
 b=j9Sw4cFrH96+1iIT00iOmBiqwjesySvNyXpdSMNuMIANUG2zj5UTBloGZvMCRYbjv83QXRc29xIcVh9wEhKOt4Dz0G0f1jm+S3DARcUOzl9uGzzSDmn4EKhdM8GBQMSbI2cjDh+ZhtxMnT5SOV8YGQVBHSyoGjqN3e3/29ezPepnvCvhImuciqUpnZFw3I4SWRgNA4fHND1kKrTzSGadgU4oJJEJUZEt1BCg2xQj0gGimBm5uoqD+FLEoDIfQjH1Kw2jfr1azQhONlsmkOw4CxgYozwX1BujCT+TOfFmkgkikyWD8Lyoo43LxshGZt8tqDf1auna7jqQNE60WV9TTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzNLXQ+ESw7mE6bXw5OGhQNE3KXYHjqvVU8+2FiaTwA=;
 b=QzaExV+5ZJpiLB8F++StgGnGKEls3EAdK6COmefXSF7Zr/7wHk7j1KZuMuaJMRd0VxfXs+6XUvvzQyrh2IEQd4UXRsrljPYFBC/X+vPlE5vAHsEjLhqJyW7s4YQ3pP9xJC3wO73qpr34VuiEJwLiLURbse8LtdDtuuDt//BbrFtd9h8/MobPoKtDzSvgep7qU+3JVvVVB1YS58c7OaoyZikug8IfQt5tS92YuTca+zQ6fd0+UJiqlWx2vP7ptabN1Ufpnm2FTx5EySB1Ztu6LsaLabvBdHksY3B18z2nD4Bhg0o/vqmXcpBuDElIQLrcRTHUaXMVB26GVu0HmNNTrA==
Received: from CH0PR03CA0310.namprd03.prod.outlook.com (2603:10b6:610:118::33)
 by SJ5PPF816B88375.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 07:41:23 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::4c) by CH0PR03CA0310.outlook.office365.com
 (2603:10b6:610:118::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 07:41:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:41:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 00:41:04 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:40:59 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 4/5] PCI: tegra194: Use standard RAS event selector mask
Date: Fri, 16 Oct 2026 13:10:25 +0530
Message-ID: <20261016074026.564302-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016074026.564302-1-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: 933246f1-59c5-4da7-5d06-08df2b58e049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|7416014|10067099003|18002099003|22082099003|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	sW0oDOM3TwRLlFxgiaCObI7a7HY9YHcKln7VQfNby62bUMtoYugrz3d50StHOFefqe091NkrusjFGDpUlbH46WWs8CzsojPG4I01EkbSq7QPLNbQp51u3UIky/TPj4vc3RYpy9/m1qnEY7XUjR/QKrNveicCj4yRbfRWTgZGqHIun89EW07s1RWIvK7vDggh/D9VY0io3BfX3Kxfq+5CupAvF820lMWvU5T5d9u1Vj0Zc3TrXsIMByAR1qjn7m844qsyaSBPztcUbUaDQM7X98ETlQfKSFkI5BZogxN2JNOgdzOR1iriUmIGkYR/VOK+Zu9j2AYi1YMqOClFCmfmAOD983+NHDr5aSfZOFMvQrvAeqCEuqqkVU68WbpukxMlhyzZp+HrGomVxt/z8yDq7bpUf+SwH8ReIpsIlWDa3W6Y8dZ6Sqbqjwxyf4GFkZrCY0aeZFVat81eH3YZ8BJ+sazTGwiWZyS5lMLqB0fQ0nORZZXh9latZsd2P/lrKFKmbKcFG2rslZwci35VM9zHBiuuMgY6oNxYGrq8Nue4TicErGLd88zG++YJhqb4FeMgRRJvRtGHcobJsQHHfg5q0YXPryWiykx09T3A/UD1BTpiUo8WOP+KWJrsmmrKbk4WmWhuZQBVrTPmefd5hiNKJ7lhcCWshXVCs5dgQiWfe44C/fe95e0hD69Lm4dqThVSdXd4io2/yPFeD0Pcf0Fthg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kia8RKd2GN9V98Clbk8gco081dz+15sNpLkscGZAEU7xoRdljuJgcr1swYR1mVfz4N6NS1c7HyFN34pg1f6mERe+AQjKN8XN50+aM7crZhSKMFhiEjcTZV7Xogl2XEfZYYM7OOTfptezKCTIGUABUEIHZpH1vp76Z6vhwnFu1viaogGcW5+nX7Cgo7xyyp6X0PoutVyfwWX4JLqNi0x5R67tEsvWe9jvrarnbCB/6njXJLKqYBOpENtbjDVcFASZEDWK6t4XYERwOVxmtuqUlKuvqk49S/FKkA5oysW5kQIoqu3C1CBWYpfUM156ZowD+ZFhG1hF1VYRwMJXGSgRo9VCBip9EUF2EjsiJ2pEndqimiMuQLzfmj7Rts2VmWzgLWVYqNyNuzy5rp5A4wprao6Wv23Ihwo6WZjij6jj+NcPmGiWFdOFIrqzKqTbBg5v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:41:22.7959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933246f1-59c5-4da7-5d06-08df2b58e049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375

Use the common DesignWare EVENT_COUNTER_EVENT_SEL_MASK name after the
complete RAS-DES event selector field mask has replaced the old narrow
value mask.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 8e1cddced595..9b349b3430f1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -618,7 +618,7 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
 				RAS_DES_EVENT_COUNTER_CONTROL);
-	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_FIELD_MASK, &val, event);
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_MASK, &val, event);
 	FIELD_MODIFY(EVENT_COUNTER_GROUP_SEL_MASK, &val, EVENT_COUNTER_GROUP_5);
 	FIELD_MODIFY(EVENT_COUNTER_ENABLE_MASK, &val, EVENT_COUNTER_ENABLE_ALL);
 	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
-- 
2.34.1

