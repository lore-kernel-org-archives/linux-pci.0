Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B23644CB;
	Fri, 16 Oct 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136480; cv=fail; b=rB9txXpsz9vrkIzYTAMOkAsKHH9nZtS6ciktG/JY3/LZxo8pUAM9AEdEmj6e9laoFNiwbB+sXGKXR+9XNjCXNE48vzjndMf7WtLEMzxp+3KmrJNI5YqP/lH0ZdQvj/VDJlGZnwFg7rahv6VktbgW5ZVgH2M1v0FeigOA+VQ7iqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136480; c=relaxed/simple;
	bh=QWXsTICIQKlOjW+bPtCkGpRQ8Tpv/UbA+aWssv3UItU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFRFxwAE13yGzDN++IJMB5/2EjlPfPN8xqaikn6NNNxXYM29XJhkmyWTovNjsNtmu8smc4/9VJYA9bK4sa53KVLHc+YtBtCCSkNANk4rt8rkPAmIn+2+7Q8ZQtb0dqe1tUEa5ToZxAX+Cz9Vkuuvl/7xb1Z2pBiukHOdDVX4a28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TE+Jgm4S; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TE+Jgm4S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXOgPzHgM2LwO6FFdOsdvYvB4h2nxOMfslBB2yb9Jfhwb5IoxsGO5lWCkHKW7r+UTPPS+hxmVOig+pJYLLUVndog7lT8B+8vAhnFK+9bRc4yiNXAUjRartgtukm9MnuHPc9yTl0vE561Oymb+fNeQTEIqsIWGRrVhBGBW1oBfjyKxvKup2H2Zd75tUDINMNrbVS+XSTqaS/8qTshmzPZLMybUBOQ/Pe/uo4WMDgnpC54V5l5RPprMzydpI+cNgqC/d156P5LhT8nOVYbBHvsCM4A+awEvNHzncYjxqz2O+d9tyQxd7lt/+0T/1NoDzfQE4Gnki7p4E1dVrVczecpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqYIqU1gifRENm95TWoP7rcRWuWLK2NCl5966J1U0XA=;
 b=G0D/u8/7WrR3+B6dOJAECHiuEqj1kj8SeJ89sO6LHoT12DLhrI6T2214s+3Dfiehh+I/3N8kGX6RPEAqIBu8BbtiU7X0MBoJ0Pl1wUkNnwAiNgy7Ir54m7MQrXOPZt3hBHOlIaAVw9sD9GpkFMrGDKUTU1QC7XfGLSamvv4kR6cBe5uaJW1dAa90Vlz1HYNsCQGu2cZp3VtXB6rTVby6lAhfuJgEmlKScyQZpgsgiK6NOk8HeBgBJfitp8es60sm5V4vukDKlkCN9f+5kY2oWciojcDqhP3JC45fJwpJ1C7Ti99h3JGQ3XefmuW/a2NPwoZran5f8/2mv+yqGKwWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqYIqU1gifRENm95TWoP7rcRWuWLK2NCl5966J1U0XA=;
 b=TE+Jgm4Slb3MTPz+6dBX/hSt3TpN68fmNAHL9DvB9knCd7FSxFEOkTC5bAZiEdl/mWdsny6BrUqOGUeUtejDk4NzfXCMmW+mjngn5mSkVCLQK9h0vJ8oDdzne/hIiwrJ5V//ZTENqwMNWwfi7VhsA69E9UbCJNOJiIEsrnvAhoHsFm2lJaPnLbYuMrzGLaFaEmVSGElIObOush6z5CtAAsoOBv7xknpVeHkHfSCABQbnysfA3Hb7mA/otSJ+B0ai00VFx6gRoUUc2/h07JHV+woMbbXjcusmzRsx4wtjyPVXaKU9yts6XwsXxpXigFO74xcNBay0SR3QXF1r+ZqRtA==
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:41:13 +0000
Received: from EA8PEPF0000000B.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::a5) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 07:41:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 EA8PEPF0000000B.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:41:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 00:40:50 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:40:45 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 1/5] PCI: dwc: Add RAS event counter field masks
Date: Fri, 16 Oct 2026 13:10:22 +0530
Message-ID: <20261016074026.564302-2-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000B:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c4a7aa-fd86-4a6a-313b-08df2b58d8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+RGOMbWCeJsOMInkmJICBKWRQH7mj3D79x7j+X5IQurcZmr8E1GcBmaM3TowKglpZhlyPPwtjyP5Q16ysH+LN+T11HjprU2wCcysbN8K7Hnlh0qOFFe7i8GQRj3YqXkJlGOQURCRAPTqQ6wm65aXZAV/BGXO04xEwG8JuVerYLpa9ly77XYfdzcJvTiY9va+hpw4fAZUbuBppu+0NaVEfY5okOCj27L+4RwExZBw2uDw4hZbQul7nt+noPRhyGCuxOAYBBmPF+0Eyb/BD4XSnfEoewQ85kSonrkNpXpzBJz/lGBOvC7hyUd2U7xkqx46gPBFu6ttPPjgzWsgmzcict9GJwZvgx5pbgEbKDYEBSW8zM0yI4ApGSpHuMF9MmzeBgq/U4k7Ni/g8BhR+HgRCKHcA0sglOmOMVogV/Sysor0KEnsyYhII9MCgm3l8orwG/gZjVOMkYmm1sSWMW8nGKAkVvJRbKKXAIT/vzRgJ0P7nYo22r7+ivz9ZCJ2Hulp6pITcLVHIX1H2HAh8FUPytSVF9e30sRK0NWzSGgDLu2GEtqeY35LtoCkCCywuMPiEz7nYpKMUp5dsxfZORrPlKak853VoNbGUIWF/YtzpYlGyUMFPgnYrd6j8rokrb/w4mHM8dv1ONBf6AzmOQdWini2QHFPdlPg3H+ED3kotFk79mFcFlczlmER87KKipaESNSKbrSshGmQSvbB1LKvHg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wr3ciKLqQssni1FRJHumNIDEu6b1lL1u6iBr+kJQqzCGXbWnDkAW5UJdIx5FOxZTerFI2n6CZMbAZ04OmA7rAoSKqOWTngL6NYvvHMpv53OyTMzu5Rwly2wJXRMFm5oiBQBCArTKcd6ANtNEo7j8JpLEDU35OL79cuTAWFB+tyJNN374v5MV38XeY5kMnVebNXTqn0azp+YTN+DJ+ZOFb+0HPk+aO9MPcnhRxvllPWGw8icBEwH1h4Hx/39kdRSfIfYSliFg1ujFstCkvpRtU3w379rSvt+gwD2mylCF5gTm9Pz2MEX6oSvW4ptIcdDtDS4i83/QU/JCATcOcm1aXTpqEJuB6rdbfbvuTrpA0cxh/yu3uTWlTiaPz2NVAyFjHabNP75B7+6Hxr5msMG/NiBNr/wbdVwgGu/XIo9y0fz+MSkkybGp8APkNLBJHHj9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:41:10.3881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c4a7aa-fd86-4a6a-313b-08df2b58d8d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF0000000B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656

Add complete bit masks for the DesignWare RAS-DES event counter
fields so consumers can use FIELD_PREP() and FIELD_MODIFY() without
open-coded shifts.

Keep the existing shift-based definitions for now so current users
keep building until their call sites are converted.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 61e9c4e979af..fa51c81f315c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -280,14 +280,17 @@
 #define EVENT_COUNTER_ALL_CLEAR		0x3
 #define EVENT_COUNTER_ENABLE_ALL	0x7
 #define EVENT_COUNTER_ENABLE_SHIFT	2
+#define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
 #define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
 #define EVENT_COUNTER_EVENT_SEL_SHIFT	16
+#define EVENT_COUNTER_EVENT_SEL_FIELD_MASK	GENMASK(23, 16)
 #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
 #define EVENT_COUNTER_EVENT_Rx_L0S	0x3
 #define EVENT_COUNTER_EVENT_L1		0x5
 #define EVENT_COUNTER_EVENT_L1_1	0x7
 #define EVENT_COUNTER_EVENT_L1_2	0x8
 #define EVENT_COUNTER_GROUP_SEL_SHIFT	24
+#define EVENT_COUNTER_GROUP_SEL_MASK	GENMASK(27, 24)
 #define EVENT_COUNTER_GROUP_5		0x5
 
 #define RAS_DES_EVENT_COUNTER_DATA	0xc
-- 
2.34.1

