Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB753AE712;
	Fri, 14 Aug 2026 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738646; cv=fail; b=q+x6wvi8DPieUQJY32bTBNu7XqO1BSnEJ6Ph/LhmFA7a7SKQ0bGaywuTR9ptvV/hvSBCzGlVclP8tRVY/K0drpjdfgKH3HKaieVHo9J+NstRK0HWo0EiIDE9Wkn7SfPhC1ceNXMyuLJaunDaibcgrRnknPvbxB1tsp8I4Kn/BPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738646; c=relaxed/simple;
	bh=65xxzBe0kCkyixIZh98+/JzieepFs8qa8YN3I4V6IbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/4jVwZtdvfzn736VDBNSqcasDto4wgXWB3ZvCgmhT3JKacPZak/nUg9gJ5pUT80j6ueG3vTV34fTQ3uEXJzBff6IsvDgc1zaDocCv0Ug5R2ge4t1prUN0Ouh2KBYqN73FSs5aEl5IIY09gMEna4CdlaiY1ljN0h8pW94gxUj28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZ1Uggug; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZ1Uggug"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGsXMY3fyalfLSity6+b/OOIVAOqvq2smWWJmOYqs3Fk4DzRXJmubn9BE9zE6gYJ5dr+DvoFfutt5Bo13f1fDZdZbcWH8+i9HgZgltY4f/T+WqWFnbSlZ2lBd+AWcysc64C1RImaoJR3mnjfAZI8rSy3lDEPV41JUVCFCmONdrP0MVOTuTXnbg4XNiyEBTWeHsulLlrBrY9lc7FQuE73pJ8cBMxZ0I+/n+PfbHAC7kS3fiTJsBeGbfquYpReSsKpSgjjxhdcypZV8ULgfdfADGC0lLHVpCxVDPfNoDfFRADNfgeJ4zns4TqUOXgKjQUU9gLlQAt77IlzYzSdtDwQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k15YpeD1tSEMSJ+OcHGdxP1pHSzNO51XX3lboFFOX44=;
 b=WttVRNLjEqpfmeDYpH5DjfVo6zerM3LHxVmz8qBpMydMHng1m18aUcYSwt5FSOs29lFOLZJhZlFKuFIRGPdj2IrqHseMSpjlXwCL7OF3LN2fmSk2WYKxDn394zUzw/qIc3zgdzoeTKej+roP30D9HWUo8wUtEar3xwQHCDkd9AWmqdWTA3mU+YNMlk8HRgOhz+/DUUkXNR26SEV1iSzg1tdwfEaa/s7z8hlIoFf7QWc55vDPMKQ+exD3kvKDBRRGraQ/qw2eQweRqjsdqVndAnyJYx9tn+7XSDJIU02IgC84EaScWELw+3nKG3GHjKx/h3EBG0JiDEmAG4gfOoAKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k15YpeD1tSEMSJ+OcHGdxP1pHSzNO51XX3lboFFOX44=;
 b=AZ1UggughC+sKvAddEUpcLJ+c88era7cqXf8oRHKds2Vo7hkdjD7o4veIhG0uipIf9XUimTVTzKGbo/deHhXado+s43YGgUhamvQMIyxNBxOwcLmWL9cDCb1tVZ8HzPq62kNd6uetFPebPO4XuNXIv2HjpxSaEyWkK4RZV4Yx8vQSIAEsN2BHalxv+WWYmVmNe5ITe5vjbWjkKVzxrwiw9Id3DegssXcDmm4fJBq6TDWhn3ymKQDX2JEUQyHKvsywusGX+Wz4dMGql0iXhK6v+pdTVW5G45jNw6lpQFzhg4LmlCOlFneeXsqi0GZJAC6WkrqMBpmo8yXUMXv8pZ62Q==
Received: from SA1P222CA0171.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::8)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 20:17:15 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::ac) by SA1P222CA0171.outlook.office365.com
 (2603:10b6:806:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 20:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 20:17:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 14 Aug
 2026 13:16:50 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Aug 2026 13:16:46 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V3 1/5] PCI: Add DEV3 14-Bit Tag Requester register definitions
Date: Sat, 15 Aug 2026 01:46:17 +0530
Message-ID: <20260814201621.2281245-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814201621.2281245-1-vidyas@nvidia.com>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 094f94af-6766-4479-bfd0-08defa410890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yp64mshYgUbGmixbonoAC0jlnGNS7vPI5lxdmtpNjfdZc+xIKISnMAF9NeeM3Hs2qEfoliVWkbt3L+Chuwo6ijAhPQY/Jo3UrsKEkdJILLOHDijjz01HfvycOFLSKHAVp8nQ28d2T/Afk1squUhqSZqJwo9T5WPm9LVhzYji5gKaH0xTZeAxhVAT0tieKuIWwUibbDZGmVNWSMHM38+X2zXATy0EfbD3Pbgk2Wb4rR9QAzgaTvBA2xjvQPPFOB/iOkY/JgWiYsgpiuopfQHgUQRyeeSSh1yTJd+Hvh3momTiQ47SWOXlZ+9vTiD93WnmsNoMyQfkYw6xTlSFaXhEzEwenqYdV7SUtUsPvvJJr2WIC1f6YtuojmEsO0N5gfXctug/Dt0u2SIbtVFA0D/G+KeZ6d4bpqqY7uRU93cg5C4wVEhPG8eSNBHnKBtygbYG/tQS2HUhloHYPkN++nsZV3YsSU6qhdajgSijX3/ckF6bHCyA/xEHz0k5IU8iGUVbavD7RqjfuqvKdUTAsn4zw2ZkY3QZwPj6lMvJ6eBRAA/MKzcumLLH0DJiLPqC0aLasp69AnBpimCPKVcIU8AUcVXVQ834ERjJC0oBG2iYNAug4XnEl3dFCUKKKbXhRcsX8Km4kFsA2M9zPSQw1OtI3YpyV9nhmaFiTggzSAYifDOSVQR/X3YDY3luq1qxXGNxXE71VcmkJJACO3ziFsMs/A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O1I74BCP7QlfRsq1Fs7Tlq7RUTm5IeBEb6K8/BghTTrAStOcU4hXBqo/auqQu4McYCMvde2caVE4TM7bXPQ4VyE2XwWSAqcdvRqnSEOJfk7RI9whE92Qg2vhic/VxtlEVVLi+Otp7SYjaIHvFjKG3huqHVM8iGX5e7hj3pmyVLSNdtYU4zHnirnc/BMjjgEazqriNMiJPZ5u9S4Ar2fVf0P6HSDXXL6k0oV7fqQrgUMJWa6YKGfN6NlPSBePycVM5FuMcaN/0VE9oDKxBFAD4aHeq3rJ9hwHfWgHGQ5eCMF6eDgUNeJ2DVKA2VMyb3TO2+meqhfx3gptOx2HV9yGeYZupdxQ7XKBzBYTMBjAOrrdqXamMb0zpZ9QgORZMb1uHBhHpBwRNdSLnDi1FzPD7IZpDJ3KX70XwK7kS7hoGC2o8wdEeZlzVDoERjiIQBZj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:17:15.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094f94af-6766-4479-bfd0-08defa410890
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

The Device 3 Extended Capability advertises 14-Bit Tag Requester support
in bit 2 of the Device 3 Capabilities register and carries the matching
enable in bit 2 of the Device 3 Control register.  Only the register
offsets and DEV3_STA.Segment Captured are defined today.

Add both 14-Bit Tag Requester bit definitions.  There is deliberately no
completer counterpart: a completer reflects the Tag field of the request
it answers, so the spec defines a 14-Bit Tag Completer Supported bit but
no completer enable, and software has nothing to program there.

No functional change.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* No change

V2:
* New patch as a result of splitting the V1 monolithic patch

 include/uapi/linux/pci_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..b2ba5c2642f0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1254,7 +1254,9 @@
 
 /* Device 3 Extended Capability */
 #define PCI_DEV3_CAP		0x04	/* Device 3 Capabilities Register */
+#define  PCI_DEV3_CAP_14BIT_TAG_REQ	0x00000004 /* 14-Bit Tag Requester Supported */
 #define PCI_DEV3_CTL		0x08	/* Device 3 Control Register */
+#define  PCI_DEV3_CTL_14BIT_TAG_REQ_EN	0x00000004 /* 14-Bit Tag Requester Enable */
 #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
 #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
 
-- 
2.43.0

