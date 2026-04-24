Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4C3009CB;
	Fri, 24 Apr 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024173; cv=fail; b=k6MOnRAEoWgI4CCZHnsrvoJ4tqWkcqd1bZynwTGoLzsH5iIEscHnS5HGJMDz7WkilhQv3NqcKN92DrK4Fmb95TtscUoclwtRe7y+PhAWkGj2p47hKGklTHIh29lkKFo1wteRZwihrZ+je6aPE+t7Yl8aD+ZDGfSH2nhTrDmTSXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024173; c=relaxed/simple;
	bh=mgDW3OszFvmj+ShexVkPK3w68uj5oEbSM+suaf0+6d4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rnpm9kWl7Fw4zUabcbM0VzZUqW2KYkt0a/rn9fSHmlB9wehuLs/5PsFsSTF9bYfjyHOLFIe9js0KH91H66sweLboI9cCMQouqPjh5a0IUIO5h1b49uiX7CsrsnLNsppNpS/KQ1wdKJqe1h+HSZyCUYkfrHfFMtL7TMcBDBCDFmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kP9uXE2G; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kP9uXE2G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpPP0p+pvKc+GSNmZ10E1o0daOl96x4oHRZXSfeTOMJ0rTJ0qeRQ5saSTu7NItRlNaAyenl6taPDKIK3ZB/IfaoDWEsxD7hIwJP3e437f7dtDhnGYH1umTZtIZD7PSFPWrStUfccsTMKvZuIcpSh/RPgEstoVpqjrub5C9CFbQf1axpKX4qVsrylJG3UmUgk27uYJ72PYiOvr09CdUVaPYCfyZWUu3GhUU6CrStepYp8OFi1O3hv+C/fl84tq290190Z11XJlT9pcvg5FG5MlSrXNMbVnO/EKXda4msmLCHe8gkhwfxOA+OCxo9SaMjZrNbD93IW9P3IFBty5UhvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0reCs67zh0alHTML9PFnSvh7jMcANjWEKk6Q1YXgPY=;
 b=DnHReahmlDFlCSIbhG9Y0JZlKDjG3P0xlaGVeIwnj1G5P87QhcFhBms0wEhnSrb5yeKNwq/NiJRo6ifGs1Neo0/dFgYLBkY8t7uxEH3XGyp2mds2+kTGn8zt0cCxAl1543Pv4vxhJd8npZWuvTmBBzjlKJBMMXK6YsCpj54brZgSk0hR/gOGCwk6ZKxTKroUBTwaPQaXw0eOoOzK96bsJzdCgtEpmExgMzvBzDQeD9x1H1AlNNwY1FEsA9v5amXbvVkfJdx9RqZW0KwTxHRUMFFoogS4ZXDRn78K2VfIB1O8z1+nnTRglhBZHOOQXxEV016VVeUGX1d5kBUIVFcRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0reCs67zh0alHTML9PFnSvh7jMcANjWEKk6Q1YXgPY=;
 b=kP9uXE2G/ItDzDRxow6+Rxbm38VpOHAfWE8UAvCkiRg3HaABjc0DxD16iwNZ6tMVmiTfUS/KvF6Lgi2CgE7RqkrsXLu8NYZb65Y7DMr2dZrUpGF41yLVFrOrM/JI6kYTLpKJX0NdVq32fboKX6tNlP14IB6bLBTdB/qO2aR9QpP4rVW9yamQnP0li92GIpZVm39dq2CHvKcR/KlGwfC1V/qQjBpPeOkoDHQPLVcO3DpG1jmZ99IcLEn4T0zSas5y50uB31zJvQF5HINKl/7sOMIkkWx4V6wn25peznD/P8xQfx9k99XRhorzorcEJc0IuGoNtARF3JbWTUcntyJgrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by DM4PR03MB5982.namprd03.prod.outlook.com (2603:10b6:5:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 09:49:29 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:49:28 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: joyce.ooi@intel.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com,
	dinguyen@kernel.org,
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Subject: [PATCH 0/3] PCI: altera: Add Agilex 5 PCIe Root Port support
Date: Fri, 24 Apr 2026 02:49:10 -0700
Message-Id: <20260424094913.522123-1-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|DM4PR03MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdff407-c34c-4226-d2bf-08dea1e6c6f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	048l80FESAfdXqz4PfeiJXaMha7AikCYLvHRiRVJsrQTziwQAl5DxCgyNik0EDqUNDIDIoFGlN1yY6DGVZdkVZ+qMfond0swFul78R6sRhRh7RWrWhK16EDAOV3WXeT6sjF1hCz+WQ3saQwJwyRfGkE8bmVaSAljQgAxiDq+V1CRV7c05wCNdLorE3ovljdcEji34INm6wZOn4VYmY1KrbskVHF1hjEpx20O0wf56oYPqjB+WaYz0gx03mweGEF243Wtu4B0eqmLP8SiQomBWKhaDVocBFr22hPx6Kmro6pq5zKil5/1sorvLe5gR3usp1xU2yGYbASg/WOlIMkBroImGeOn+8ekwDL55PBVcVjKRmtmfItF69rJ+MSVMqaO203l2qFMmkX7d6XLYopFPfprStcIHcK+T5isrz4DH9w2+c4vbQD0Szgo3RSM5dzr+S61/qohXNAdOWjiMClDwAvB4VXpoKBzGMIfev61tEHXmKU/fWmdTQGCoKzXbyvIIiKXt3/mD3kMMoNmDk0HTjYh9xlhCJ7D07Ppkj6wG410yLdmYzagOVQ8AkFEP4MnoIUeDIrSOvK3aNTcG04VC2LcWBuQDRnBymcyCF68KxZrSonC+Xi1aEH/6Z6ExV1kKsroxmdEMpWVtB6JGsh9ll753QxYAm09B7sZyabzRYfgc7YDnwmVnOUpgruoNV4atgKgS5sm2VEX7K2hGHlcZM0wzlhu2Q+1BqNbIFTq+iQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2izHpRqsLn4l3iDxcI1ghnfIN2pZ5wbfaYAu6FClMrT1K7SsUobKGB+/Lzkt?=
 =?us-ascii?Q?lj9Wou5vTMWhMZFDN5527AOQDQ9QHMLMZ9rB1HhPRIacTbTR+NIE/zCTSVFi?=
 =?us-ascii?Q?cxCpkZGDRC33yB/mCyM76xcpr2s1SpYWwLmedDOypnW3rku1j5xBKyhme/9z?=
 =?us-ascii?Q?HCQLBNPg3zQ6g93Mf59orQ2kWr0agYu/JMc6x3M0nOXnafI9ilBj4T0HRwWX?=
 =?us-ascii?Q?dtWfPHWj6Jv1p2qv0R6kUykFYIPIn46+mPuiNESkjeyDG9mj2vnA4s3hCV8f?=
 =?us-ascii?Q?Qp/tbgoVISPod1fP98ck9MUMbjucK0iTtMVc0P70ptpZIC2R0J8NnFryqurG?=
 =?us-ascii?Q?Tl9F4PfN9F3J1cSKY0i78hopsTUsCgdWxR++goLBbhkdq2t9Ye/fhkaxoGZJ?=
 =?us-ascii?Q?TRsaVgvER0IMfZpFlY1wqBoBC1GmwpdSWRDmzzNBGOGF6lpzq6Nz+MYd7siM?=
 =?us-ascii?Q?z7rI27SncGWiSko1afkh0cgL0ITMLUXhOJg9LI4RwIkmpLK19HKFm5vcIL1E?=
 =?us-ascii?Q?FkrHSDGq2SnAYe/IAOCblchWdTyT7Pstar3pIznVPbWQeFCrE+8WpaLqHXgv?=
 =?us-ascii?Q?Bg/+4P7Kzn4RXyvYdGa4zX022NX4xK0dN4tjy2hbnuGCBV+sVYzg+57PDAeo?=
 =?us-ascii?Q?kU8wPr2WMGK4fsRLPyZENpdEnSM1ed0EZuWjrlnIAx1L+o7ntnGgLMD1eKC8?=
 =?us-ascii?Q?3t6Ry3PsSuwacfAeh6gzxnnsBudfXNQQGUfFYP++QHMBiZuVH/Uo1AwLUTxd?=
 =?us-ascii?Q?RGkGXUajHLU6OHgX5qOmURYRwVTLIpCrVD1TaFMolhQ0Ec1Sdm0czAX2pKMT?=
 =?us-ascii?Q?1MPlbws69RR1qBpiAoxruWtn0hy7ljh2mGSD276kkwb2g6fWlH+QDmvQFW6F?=
 =?us-ascii?Q?atg9p72kobk1L7QzUoyBR3IBnssmQm5nr1/J8qATRSN6ArDwh5h2UKXVisYO?=
 =?us-ascii?Q?XbMPDPFA+UYgFnL9bJnJdbd1kRLLWH7/MgICDNBZd5y0qnID/wOtK1qPNsSR?=
 =?us-ascii?Q?ow8wsfNyhi4WlDfJDcaHvgo/afnAVCWIPXvC41z9gCjSakjBKTrAy8Nsy4yt?=
 =?us-ascii?Q?fg2xEortRxPaXyvAtxcVf7zQR+1jYkbj0iKbVogEW4DU8WLftiFfA9mKn8s0?=
 =?us-ascii?Q?+B50WuandCbCz2ag8eqB02BZoq4Dw4ZCD3bwgGw1JV4pO+bBtr6yYxfWxueo?=
 =?us-ascii?Q?BBYv1s1mgRYJTyh9YEmgkIiCt6dKtLTknREa+LJeZJ6kMnSPHkmg2XuUzv8J?=
 =?us-ascii?Q?u1E5E5vaiC+qfPWKVOUJtQRWBQlvufTpUkc07n6opMe/LX2sFzMUY4ibs3QU?=
 =?us-ascii?Q?iRg8PnYTIyOZ43e/J9qTL+k9bpjPBhvJ05raQWv65lOlju6Q4v5zkxcupOAr?=
 =?us-ascii?Q?TrhDN4D1Ttr5rDdyyMiM0jHN/yDQsuBVHTe877WPSnF1nUyfop7QNnsN3MP2?=
 =?us-ascii?Q?ijKLALIiDS6cvx89sS5F8lBR2BOkznLVtwnuyW2DdQVUkGimfx/0JJHEUcc5?=
 =?us-ascii?Q?/x8p5kVx++3yMCx54Yaz8VvlOTHyXw6vTRj7JWqi/NwnejGqNeXhSijYNp4i?=
 =?us-ascii?Q?bOQRTxY1MkRT75YYe1enePp/56g0AcqcSYqQxkB0Sjjl7vZfZ7pFZWf5rpOD?=
 =?us-ascii?Q?Adc84WJZaKbKWzNttphXN4+wEe42QdX0MgOYiQW4AAXslJGQsfcMpeWECUou?=
 =?us-ascii?Q?G/otfuiqXtgv96CpLb0HiW/AX0AYLUmd/JhtdIcz31Q1h8ui8Uzrro9lT2cE?=
 =?us-ascii?Q?aW+kSCraFlI5HIwjRWEdsqQSgNdlC90=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdff407-c34c-4226-d2bf-08dea1e6c6f0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:49:28.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nSqsVNF03/e5vN36vq8T574d8/KZwSpQwFPDr/x0hwvl7g9wDOWDVHKFzETc4I6LwGGKt1gCyBexfK+tB8uNBUn6nCm4XAasLuz+LZQWpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5982

This series adds PCIe Root Port controller support for the Intel
Agilex 5 family of SoC FPGAs to the existing pcie-altera driver.

The Agilex 5 PCIe Hard IP reuses the same config-space access path
as Agilex 7 (V3). Root port and endpoint configuration reads/writes
use direct MMIO to the HIP and CRA regions.

The difference is in the HIP port-level registers (IRQ status and IRQ
enable). On V3 these are directly mapped through the Hip MMIO window.
On V4 these registers are only reachable through an indirect access
mailbox (CFG REG IA CTRL) in the PCIe Subsystem AXI-Lite interface,
documented in the GTS AXI Streaming IP for PCIe User Guide.

The indirect access sequence writes the target address and control
bits to the mailbox registers, polls for completion, then reads the
result. Since the chained IRQ handler runs in hardirq context,
readl_poll_timeout_atomic is used with a 1ms timeout.

Tested on an Agilex 5 E-series Premium Development Kit with an
NVMe endpoint. Verified:
  - PCIe link-up at the expected width and speed
  - NVMe endpoint enumeration and binding to the nvme driver
  - NVMe read/write I/O via fio with no errors or timeouts
  - MSI interrupt delivery observed via /proc/interrupts during I/O

Patch 1 adds the DT binding compatible string for Agilex 5.
Patch 2 fixes pre-existing resource leaks in the probe error path,
        which the Agilex 5 support patch depends on.
Patch 3 adds the V4 driver support: indirect register access helpers,
        the chained IRQ handler, and the platform data.

Mahesh Vaidya (3):
  dt-bindings: PCI: altera: add binding for Agilex 5
  PCI: altera: fix resource leaks on probe failure
  PCI: altera: add Agilex 5 support

 .../bindings/pci/altr,pcie-root-port.yaml     |  37 ++--
 drivers/pci/controller/pcie-altera.c          | 173 +++++++++++++++++-
 2 files changed, 190 insertions(+), 20 deletions(-)


base-commit: 4224e91fea5695a89843b4c38283016616946307
-- 
2.34.1

