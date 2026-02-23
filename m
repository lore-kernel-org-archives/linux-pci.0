Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CC339875;
	Mon, 23 Feb 2026 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872395; cv=fail; b=HnSrZAPmBA1ly1IHd57/XMsHWs2klIDNUzYUn/BmBsxr+SUUnUFEjNf1lQflPVzp11jKlJdoBAyPwoxs/joAy9WiyEW5AbF3x4C7IC68LsFDCxNUvYvjIXmpf+ExResG+BVl/00p/MV+VkunCcvSmHkzs7sEQuhpO5F2QSiwZVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872395; c=relaxed/simple;
	bh=eE0W2XsaAScbibZJMVEsldJPNVfSuxczJOSsDRM05ow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h7GAEbvjQohOyqIwJ91AguMM6xKj9mZZfxw9LL8HGVKGAbrJSHBjl4dGX3VDNQX9EwQqjQfE59rj7Y8lYHTCwtEeb4Xpfz+bfHxVnxrQXjeAgEEiN/ws9pzMK6N+DJnRMBuAFPmg3VTMRJOGA4+9rwmEuSdBnGEbzZd7WGz2erk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vv5SGvmj; arc=fail smtp.client-ip=40.93.195.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vv5SGvmj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l87YgbFRkfDdvlhDA8bdO4pHUtsGzrN5cexXwtDdYBfwQop4cwTxKXZSssCPd8WiLomMTnuOjtBiHm3AemXN3v0+iMHCLAniEtbU3npSbSH9DefXTGQwwyTFCx9SG8Nbqwkq1srUeB/j5EoRXnHOvSYeKuYt5PV1K37YuQG82eZnFrLpPGYErqLlL7MgtR/HXU70htdL2Uy7L5WLQ+R1+NcxGSDFwTXEzT8XqPKIaoh9x8EjT2XvvXvmwmpa4wnnqsqgq9KrsbnVTHT92h/VJS/nNiPl83HjMBTHITdL23Flgbix6NlvUgO3jF1QTADUEKBKWKfBYLcR6Nh2DJrUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuzofrG4Eihh29prvUPmOZo/9iYZeepA57UfO7WqHKg=;
 b=vGCHccZ0gkbuy7o1BuQf8ZdT+S9jWslrCW/8ivRE46M1aO0RIyUvDgvjjK4q0kJ3srHYkHGDdD3HQo1FhwA/fRRgz2evXy3pj1e3A5lYP18FRGvadjbZl13hdyeX0uQ+Q8heDKy35akqnHSTs8ipuHvpJbKDfB8t+VNNuz99jUnNnRbJYmJlrzW+yXL+WqKqCSvovuR00b9YMhrSWX2HSFEGt98jPVeF2gTtgujIOV5jXfgnL+gcr8T7gyMu9R2RruvhPin9pE9P5ZXiV5P5iIbjeOJjq5X2ts2to/U9gMs7XTfp4wR9PEMzivmA5/vVE52OEw6Yk3VEy4G77KT1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuzofrG4Eihh29prvUPmOZo/9iYZeepA57UfO7WqHKg=;
 b=Vv5SGvmjyOL33bAxav+X7g6kU4kYEktZqTJ855HXX//SkfWuM8w93i/43IS3fHit/Ae19M1CIn2IGTWsE4VV9Kda30SARX2mcwOnNOlDbFF4mseY0Do0jnS7HUIkif1WR695N2i29gel30rdtE/PJt0uIVMJ9EjH/7cZIUAfWwsEBY6sDURGM48pCEArUP7lR0Mtn13L2/Ou5+xQrG6FjbYzySBG/MbDUn9jmT700x5xDQu5dbFlQudrcnIubtgAOiN629nCpgEjB95kV1/yERkF9Wr1qHBoMq15HE5TYRzXPupRhdZjneARHB0BF19ebuucLisHjytxidxMzJC6KQ==
Received: from PH7PR10CA0002.namprd10.prod.outlook.com (2603:10b6:510:23d::28)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:46:26 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:23d:cafe::3a) by PH7PR10CA0002.outlook.office365.com
 (2603:10b6:510:23d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:46:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:02 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:45:56 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v6 0/9] Enhancements to pcie-tegra194 driver
Date: Tue, 24 Feb 2026 00:15:29 +0530
Message-ID: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 18177b8d-4c59-42cd-29d8-08de730bd92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2BWJbTEbIukeuNffkOUVURwctASewRFuQMGl008mwT39u36f+Qt4SMAWF1a?=
 =?us-ascii?Q?SBpuSnaqH6Dw3sIhuzhXN+XqPDc7K6sK7B/85wedcKpSxeNFMNLPAiPnK8hI?=
 =?us-ascii?Q?DIEDNFSsYQJtCKrvnlU3ClHl+z4U7o3EPfcR+iKH1sGL6dfFGUXrJagtf5Tn?=
 =?us-ascii?Q?1JeSOKBKN/pDe/T+lTx/BuUCRZQZJq348IBajd/8tSs27STBpiDaLQVA86Dl?=
 =?us-ascii?Q?hA0VD0tEIqpF1LBjENI4xGrOfK7GnyQ6JKLsya3vfdHdcN++vRccOBPMrRXS?=
 =?us-ascii?Q?TQ63KmbttrbCIXrnptgP5rl75Mh724ksNSWyJdUBkTdfObdk6i22E7K2eL4S?=
 =?us-ascii?Q?Lojz6RafgMZavnzJ6jJxz6OKBSj0EhVmG2Gc5pmmhpfyH12U3zly+9iwBclB?=
 =?us-ascii?Q?N/QSEEtvp9Wa4/8P3J9hbGfuyRQexpX0DiM12fVPq1Fe8zVt9dgPQkTVhVOT?=
 =?us-ascii?Q?r5ViJFFkFQM9qA4osr8/ee3Cf9Terc7CWAqfgaN+5EnfvOf7O0eobjlCuF6v?=
 =?us-ascii?Q?B9yGWpr/tHDwP5npRc0c+CkYH1icgbPOudOg+wUaUaA/SpSMIQyvCCjW0Gbd?=
 =?us-ascii?Q?F5K2Xmb9tzF3XmC73z6T1cWprxH5z/ydTzdwYhzvpvEWngYBjXj//tXJX4t9?=
 =?us-ascii?Q?zB3bk41WqCpJrsLnQoxZMdMDREGwyGfki8LPZaKSTQi2/LS4IjHZxrh2pHBT?=
 =?us-ascii?Q?RrQ8vNd/n05O9rTyGwDpSaH11Vkf8CEZ8IKBB/Gs4gvk0ZYnbj/Kr+MaZlPI?=
 =?us-ascii?Q?hoFgiVMgQmxe1J+LnOeXmbFynRzPQ1DecaxNPa09B0CSJg7OOi+aqncn6viI?=
 =?us-ascii?Q?BUBCUhL2sEib/C7/z91ZKTy1+82dweXNrA8MTPby28O3urMPUBgR37wSsPVB?=
 =?us-ascii?Q?Yb/8bO/n+TsQMywZ5eUs966ZH2F4BLVO5a26ERtqgTRvHvJoFYt4Y7nqK4XQ?=
 =?us-ascii?Q?mI0oEv6vKFqobbcCIfyBXiaFE3W5BNkecbBjK2UJsS1Uuimn2EmcR0yjGH4v?=
 =?us-ascii?Q?LSvvSQYWE6mFeI0RqozpeyDv70TQxk61iDzvdir6SLQk6rjf/oSKgJpZ7LkD?=
 =?us-ascii?Q?eswTPwFVz64ZRDzV4nGY9hiMmbJGZ6F/J21Naxpx9wZaf4uV86dZ3J+8LtPs?=
 =?us-ascii?Q?t8BJZsQPB4gU99UfCwhWrakxXer+9NMjL523Ay/5Msa4Lz8Isxqw5ZU2X6mc?=
 =?us-ascii?Q?2dkf/CHdAuM4Qgqj6oT9pexqVi5x3U6Mv54Sj2/0a64O2U8akB1HtKAUTllt?=
 =?us-ascii?Q?9h8SropDZ8OB06EbltZ8g38LQJnOaCwb32YuBQr+lHlbvzwtm94dWUg9Yxyc?=
 =?us-ascii?Q?7Dd7R0vYAnB2IyQD8rIKEy2/fAOL3A0Y5tmn87OCFJTL1ZC1f3qYl3eg969E?=
 =?us-ascii?Q?BzLrSbD9HDmKuEcTnevyO818eDMNxn8e02iqR3T1xsGZuxCmyfR4YaNuckKv?=
 =?us-ascii?Q?E5mjQSpCgX4/9t1hiwFUgwAJcKCkT60DJ+AQwmIziPVkNkPZf/g8AJEKxw2O?=
 =?us-ascii?Q?Auc2h02EAP0/jyU1Z4EcvJ//qTr6seqJeb/sa8zQVoNdPPvPmb70PFuY5Cqd?=
 =?us-ascii?Q?qNPmnzjcJlqty7wvH6GRpVyCpHohpokwWswoaHtXXGJtIOplBNY66GSvJww2?=
 =?us-ascii?Q?sgY/C2+rmtaYw3UAG6SxTbjbnKKKyEdWT3Niiwc1xP9dMBrO1y37uDYAPIrz?=
 =?us-ascii?Q?L9lKgzJroR5eo+IXrAG2J67WSrM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6CBwoAIe3GLGHh0Ec4AQ2KL2joQATd9uffpwf/nSODmZG3DNXwJLrJojBOP/flwgP+IeTLGUAfJqcucI78GOP11H/vVH72mGoN5Sb/pyk874remVhiXru+PGHgszV1KLKBn/tbPENpMM7GoKs7QbjGSVZhrNXUkXK+J8jqNnAMHJpF8kJWxSsqej/StoctRbmt8BHUZcb8zfS64+YvvszzrUG+stpU3Ps+jqYvoUTdaJvZ34Bk1reJjqvir2WWsGrXkXhf1/8OfQv3sUaf81xD0iqYM4N+jXvQ3e+Vk0aBPR2bEXF+BDx0IfrhUYkuVAjWm2uYfjLGTrMaNY7dUkKyFRwVwXJv/lXT1KFtWlmXD2LwCMc/Oq1oJ8IH8o3c7/8raC1fmfMlOpTgqKgd/TJna4CmXwVK/GPZ09Kq27I0RlrNiISR5IzdpB+r2oDmSR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:46:25.7905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18177b8d-4c59-42cd-29d8-08de730bd92d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186

This series[1] was originally posted by Vidya Sagar, and I have rebased
it onto 6.19.0-rc6-next. I addressed review comments and split this into
two series, one for fixes and the other is for enhancements(current).
I verified these patches on Jetson AGX Orin(Tegra234 SoC).

Disabling L1SS capability based on support-clkreq device tree property
is moved to common DWC driver, so I reworked below patch to disable
just L1.2 capability on Tegra234 SoC.
 - PCI: tegra194: Disable L1.2 capability of Tegra234 EP

I added below new patch to tune the ASPM parameters, commit message of the
patch has the details on the bug and fix.
 - PCI: tegra194: Add ASPM L1 entrance latency config

I added more context in the commit message for below patch based on review
comment in V3.
 - PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration

Rest of the patches are same as the original V3 series, just rebased them on
6.19.0-rc6-next.

I fixed the missing PATCH prefix in the subject in V6.

Verification details.
 - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
 - Basic sanity Link up, configuration space access and BAR access are verified.
 - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
 - I verified suspend to RAM tests with Endpoint mode.

[1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/

Manikanta Maddireddy (1):
  PCI: tegra194: Add ASPM L1 entrance latency config

Vidya Sagar (8):
  PCI: tegra194: Drive CLKREQ signal low explicitly
  PCI: tegra194: Calibrate P2U for endpoint mode
  PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt
    registration
  PCI: tegra194: Enable DMA interrupt
  PCI: tegra194: Enable hardware hot reset mode in Endpoint
  PCI: tegra194: Disable L1.2 capability of Tegra234 EP
  dt-bindings: PCI: tegra194: Add monitor clock support
  PCI: tegra194: Add core monitor clock support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |  6 +-
 .../bindings/pci/nvidia,tegra194-pcie.yaml    |  6 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 67 ++++++++++++++++++-
 3 files changed, 76 insertions(+), 3 deletions(-)

-- 
2.34.1

