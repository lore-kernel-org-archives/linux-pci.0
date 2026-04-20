Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFB205E25;
	Mon, 20 Apr 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691262; cv=fail; b=iVMxWCtqOY8jgAoC2bhza9eEb78/JpngOSapj6gxlW+0rnhQwVayJND8bE9Un/y/eZ/hjrqAx9sxfkx9A3zOMF1q3vowA6trXTL9pZ1ndmDvCQuorii2sHOJMtM2JRyLuer/Al7BEr0GbsO5W1iyg0MoM5I/5yZiPTlQHsbsw1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691262; c=relaxed/simple;
	bh=2U8RjlkT9o5pESVkNtx6K3KrWZ3eic8qVQJFToRihSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9FjpQEVEaYUlfQ6RJtn780O7rDtRjTqgkEqFI2wzrTfAsid724kabE/0PRIX+NmtzpZvu7sa2/J+JlmzNbxW4hAg15W11T06xWU8IYP1AMyUR9zfS5ujXCmzcYlSlv2nRW0q1PD3mwjd+R4Yz5C+CFp1fG1JBYT7qzI+rNbreE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cSajlonD; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cSajlonD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO2TVCwLB5nWB+0Bk8cS0smFHBZVx7UQK1ZWzpaCrP9mIsz5j9b3sfswWZmpQxW7IXmN6E1LK5bPHMryh7ed1HkSW+Ei/wNsGnpFJN+rrM+JUZKezjnnsffdiX03FgSHkaP0uE0D8sezV1RTrXa7cSesdFl7+TRQ8046D4hyuP0tUlotPrz2PFWzpCJ+K8E8KfW0Fit4Ef6iAYjrb4WqtQtce4C+YbW9QOtGZ7V7wwgDIZaKcPcsg6VscrfTkgy8QJAdtzlLLPoHcglmzA0v0L5oeAOUMI2HC6LN+tT76gl8/mIWJMGUwL+oDRjO6Ql8Wg37mi7kGyb2673L+pmLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U8RjlkT9o5pESVkNtx6K3KrWZ3eic8qVQJFToRihSs=;
 b=sXvwG2vTCYUORzwzCmTroJZTy0Sxc6osFJDnnmhjXY/MnIZ0OunvpT2wMMPpTFZ197PXmMJpCbAMAMyEF8sc7wAvtK9Z4XT5Cc3XqF7012abSwac6mdZDaa1moWREhVvpXRgyK13UlnuaEoDJByEu44ot1drDMzFUuV3NBLBAPTAy8BEZRYkAzK0eJlizkCM7TDqRfhWpi/lchgi0zNyzBYqnrvFkmPBRhGLlilr7jzml5bL4vmHiXqFwquvVDxTTV+ai4B6/FjLF/vVcEocgxE9Gk5T1L1UD1Y0YXZjoxJaxFNlYl1U0l1ehRyx7m+/YvIxPlWOmo2bfe/3JhJvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U8RjlkT9o5pESVkNtx6K3KrWZ3eic8qVQJFToRihSs=;
 b=cSajlonDYShrINs6JXFNSNVwWP7IT+R/kHRsNgNt6SOrazR7Zds2cHxEQT0fC1t76ne7yYa6AMWHoGI9P81IQzYJLTDMXCZlL+7DOhp/+oG+2gL4Z79R4o6rZWnNlaR2sT+htofDEdBBlrzqYPdhpohQb/iqjKAdWLSPwkTkEn3Zy75loAnk3JTy0xPAWj1fAUXrttOTDFPlmnmdvqKvc1TrlRjSqw+y14/toKase7A4mmHTrmUEWl2ERXU8YbUrF6ChNRGkue5DhAWU74Odqj9zmSr6iWYuMS+9ut/pbOLMYgkXUH8vqXgFZcm/auoc4k1eJsFNm1nNRhZmCWK2Fw==
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 13:20:57 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::fb) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:20:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 06:20:33 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Apr 2026 06:20:32 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: <ankita@nvidia.com>
CC: <alex@shazbot.org>, <bhelgaas@google.com>, <jgg@ziepe.ca>,
	<kevin.tian@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <yishaih@nvidia.com>, Nirmoy Das
	<nirmoyd@nvidia.com>
Subject: Re: [PATCH v3 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Mon, 20 Apr 2026 06:20:08 -0700
Message-ID: <20260420132008.521631-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416014504.63067-1-ankita@nvidia.com>
References: <20260416014504.63067-1-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e9238f-c145-43ef-8f45-08de9edfa7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oP27FdlmuhaeCoeT3+I2Ng8FRlR9p4NGWnV0kkGJDJg+SSWCvHvdj9wYu0tcdUJr8LmhIxg77Dy/gcwEFYdGm5v5kMFN21x3ZOrowgY9c5EBW70r7Q4j73FeTakjsCCfL1rFyMboq4vUVnq+1Bf1amfxEoxzwQrqz4s5vD/OWTSlGIAd8X5kCqTwSx2yZE8jH6OQA6Xp7ptpMJ+NCoOkzr5vcqk9qRLWsmkaJNiVio94xKebTrvHm6YGNtV0PyaKNTJ8cur2W/Je0VDDf5IzXD9hWchMGIccf4zus7EpQ0HfvfCbP1bBIMQA26LofP7BtRjD2vJuDfW1oD+roYO2LeyJtJtbBMphhJLkqBlBcB9/Ohqf34c0LGDQxMd5ps7Xx4y5EAUvtFdTX6L0Pfoy7aC4assBMeLlvQOURhwFPaNNtXdfyKKu62GcDH6MAJTOFz5sgaL00XJ9Gr0ud3cWYzKrClcZBXZYv3iraoJt6zrBSVPhP9SgmDpcFFjv3HMpoW6EkMRaW8mMjp47uc14Yrj1DfKfvuLY0HnuqtK5vF1vpoExn2u22h0FFGU/hkTg4AqpXvabCRsbp9mlw+dyZTtHhEa4Lk26R+ogP0WcABwumB1ZjdX2Wx1yn4ibhLdkub0g0HezlJekxT9AagU3hEzASKp3oNNwV7puXtg/fNRwXV8+IfDh2BvHsOOScW81TW5OmxTbx5x1I+G2Up+xAB7/V5FKxoIElfFtcmr7qjv5qVGZ20yXYuzMLGCDHIJrzhTX+QeIh4IhQdB4CeuFOw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1i8ErW+6m9EnCGKewreepWtDLRM5z21juXiCX0taQ2fIQ2q9nf/SqFFz/xdo/2dfonccLB2x+yGoN4OLeRSTu9pAPcAmzfTWSJmjLxOEMZ9CJictIeApYec5gsXi0ulTlgJo7wmb77HNRJmI+fOkH0ledUgPLINvA8ca3lJ2nN/SgXLIrf/vmRKH+9LcoACNAgm2mmX9G+ACb3qAEEzRdHO9NUnphpxe5TMFp0XjvLl0HzItypRgtwLBIyZVx0fe1/fS1/dngW7i4Fcpi52848d+5v5tDWFtmLUimDTRQf0DXl4GwGEMFyWfoPnHNJGrrhPTOObW9Vr5szh3KEncCsuAG0sNn4OsH+p69FxnsiycacLMRQxciKCjvwfbbDgztj+Pm5+Rv1AEHI753WVgIJAmlbbXzXlcu45ekpwm0gDr41KnbqThShyq2lmXZg4+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:20:56.4946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e9238f-c145-43ef-8f45-08de9edfa7eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817

On Thu, 16 Apr 2026 01:45:04 +0000, Ankit Agrawal <ankita@nvidia.com> wrote:
> Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
> the existing legacy BAR0 polling path. On probe and after reset, the
> driver reads the CXL Device DVSEC capability to determine whether the
> GPU memory is valid. This is checked by polling on the Memory_Active bit
> based on the Memory_Active_Timeout. Also check if MEM_INFO_VALID is set
> within 1 second per CXL spec 4.0 Tables 8-13. If not, return error.
>
> A static inline wrapper dispatches to the appropriate readiness check
> based on whether the CXL DVSEC capability is present.
>
> Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout
> field encoding.
>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>

Tested-and-Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
