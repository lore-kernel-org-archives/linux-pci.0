Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C983E0257;
	Fri, 15 May 2026 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828925; cv=fail; b=IpMRXF3GfLsHUm82n8tLCld1nGdRbNCPCLcXsvWNz0a8ewqtNwbTttqU0m17/FfOFhDZH54vgIzolX8fZAwUtxEw03Wx5Lh57u+5XLAMQ473H1UQ6d19xTsrPrQ5Z8G/yD04DRRrtxsvCJKbFXL7NIwUq2CmjFmDHF/zHeDlDt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828925; c=relaxed/simple;
	bh=Q5NGTSvEq3GrFjF1Z94ZBza13X4bnVlIYUUK1TUebcA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J8olNBJKs0Z5XROlXyJwvzsCo0+bs2crpDqA1vBmjdhVAod0IFZLeTYkEB14BpPjR3c6kocOuBTBu6nUdnQkhmA4eZtbYjiwabGqKjrl9O2iOw0TjlDGTnpCttFwcNj0IjpnkkRFP62AN1kwCin7c8KDCzz2dvJR6XzJeOAgiqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QW5MtuDw; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QW5MtuDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP5xYQxJI9GIbz46r+dVMfLer3endOP5wvExlk5paQcHvUQ7iIcrisDe2Tydyng/xGZjkmYekHVSB0depWMlZ0eo/KmyXQzrbdRtjW3XBQ7dGeJnYEjyAiZVlU+6ZOpDISWujmvXlYzEXajE1EEJrhMKC+2oE0yiN1WRA4q029RxCvgNMX9z6kfqFtSjCzbJtL+F9el3AKsY3VUlnBg2C1pclzFNJ06e3Rrd2qh5W8O/HOU8in0zk3nhcNmLFOgQOMimjQXW3Np2T+QZ4DSDGyDdiyePB6txHYOEQOuQqBzYzgQPTysgIggHBiXbypNywREbP0M/gdTuuoL8+ttvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4laBi1LKyn8Z/hLB9W/4VE3TFeYSxDwCtBgDfW/ysxk=;
 b=mXh9UFE4+TmWc/iGjWM7WRNWGMf0ebDsABcBU7ZE9D+By3Bonndo6vQK4y2UVpcjW9r8nhKmC/LQW90O6+lfi60TJ+RwDjFqMPzHcEWE0Hq1bplyFYvT3OvNAR69hLt5f2pvKhjIPOBnLvihMT6NsvkYe86ctpwGyygEoMS6Dwbq1OjQLu+N2JwdfvRvxw2BEvB0t5KbdGjrkUAyo865SJFTOHQxSXomdVujyTkNTUo+vSpwKcB6GK3faIkN1WQmeWQgJ+tnApvyezq+WS6C1+vW/vdJEX+5NtoY63VjuoIDdXdna30E6zTRunjP/aFoYWktaz7XWeHzNO3Ad7N0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4laBi1LKyn8Z/hLB9W/4VE3TFeYSxDwCtBgDfW/ysxk=;
 b=QW5MtuDwDbKN9PUurqiJexQ+hEUo/T+Bm5l3zoJUSFXInXddjDg9Y0Lcjy6rJbX2k7zjphX6Lvr377Nj2tLSzX4TW3aNShb4E3+RCxVB5ncujWQHLUrDfQLdBfz1DfZPyIPjkCdgoykA71fgCxtlt5ORRPpgc/Dzkk1wyQYG9v2JuovUCoEqLo5ySYAgh+hCKPIe+BGfezQS6wr5UweQTjNkXNvtfJVnNMRcvnlPsY6ZdSVMHvNU1IiCa49S/kkTI7Q6MTbA4yBW0RbdQegRBvOWjO//AW/JuwWIPemJ1bOplrhWCea9TaIwU3Wtlx+bU2SSQHzg3mosmr5gtr7Egg==
Received: from DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) by
 PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 07:08:36 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::83) by DM6PR03CA0018.outlook.office365.com
 (2603:10b6:5:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Fri,
 15 May 2026 07:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 07:08:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 00:08:17 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 15 May 2026 00:08:10 -0700
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
Subject: [PATCH v3 0/2] PCI: tegra194: ASPM L1 entrance latency from device tree
Date: Fri, 15 May 2026 12:37:51 +0530
Message-ID: <20260515070753.3852840-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 547c9b00-996f-4053-7414-08deb250c860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|18002099003|56012099003|921020|11063799003;
X-Microsoft-Antispam-Message-Info:
	fdOurUt1Ku2rihoSipUMVe1bm06k1Ll1kYTQk+gWt4C6jwtbJKrOi3oeS3JmKbsf9DGhRhtOUczHi+5lnVPVxk+6zPYdlnvVgzFpEUxKi8NXCHmd7kPgqmyCEoc+P1nxfejPzbrleWjoHsJAQez67tjUDdfQf9HTKiXsj/oR7QxVpT7wd/otwmIZrh1rE0LNuUmyEdtt3qJBIbSAl1Tczjw/K7+UyYzq47xDgwzAoKc3rvjLc1mPuWlL5aQ5gZdMg3wrQgvtpFfMkEaQcjgIF3aH31nNqk9iN8qLKZKo6sdA+U32yACMJKZRfrSPWq1gHvfBYjJ/OOhmjIOM7oqgOtU7XqgnnAmNL9+7oodHBdKkM1iV/apnfMev9PKUeTkDX0OuZgN56wrUUhQo17BsP3fTwyptghP9A5kR6BHIrYFOXF3WJiI3QmMUV/Q0qdkhGfM2rcz8dn49qgLoST5yYCG+SVBEq4DUXkpVF2kIWsH2wc+PURBBX4hdghuOJUXt7MYJXowhoPXsoHvxedFII2RPeWVP1tYiRibz1ixdW1ANP+1iUJXaiua9RPxy3+dV0Ef81FbVxcBzDqV5C6tSUUmcuFaTUolz5BHxNF+S3FnOeo8MdTjJD1QNvgPiZwtThZGux921rA6Ir+4HMU7IdKo7MIfERYwDWADrWyO11kfAt4I65FQ/PpbM/cUnbursALQABzXe3CJ8knJC1rJFnqnYF3wDP16svuVIAhBnrPiPRYJYwjjUgv94pQhemiEYSuIy32vy9jkvy8Vwf8Ni0Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(921020)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FYfvMSfZBXMBkQuv6NqJ61Hn/6Ji/iL82rD+JOtyOXSFQaue5pHkylAjUM38b5rgC6xLVsjQ243GkNRFX/LaqAevMxDvMQqlfIROoDuv/M9qurjQeMT+Yrd4Vns6edi+eOJp9R3wu51pvf6KINUKBrcSFHdJgtbOrs1qC0CkpS295b0ru+eIBS/C5oDXyM9AvxDhwN/20tx59JiDJwVJkOcHV4lLmS4xMx4/1bFXqTDPGF2d1ewv4DeCVEZYhQpe7Qus5bxw7TqToaXYMqMYcYNGWEGfQFqUPW1AWnaDTVqy4moZ43PpzJdnGCDuvy2EbfUilDaKzm28ZvKo6ebYAG06BW3DOO7G3H+wS2+Ovhh4lnLeIwIrjZ+Mv1o7Ty6JDNBIcUZbkKE5mMggdn/1goJOWjbO3YaOzHZ1f1AY5rYW15UWIj0g6d7cEk8DoaSC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 07:08:36.0641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547c9b00-996f-4053-7414-08deb250c860
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352

This series programs Synopsys DesignWare ASPM L1 entrance latency on NVIDIA
Tegra194/234 PCIe controllers from an optional device tree property and
corrects the default nanosecond cells so the PORT_AFR field advertises the
intended latency buckets.

Background
----------
The controller exposes L1 entrance latency in PCI Express PORT_AFR (DW DBI),
bits 27:29.  Software must select a 3-bit code for the maximum L1 entry delay
the platform can tolerate.  Patch 1 reads aspm-l1-entry-delay-ns (nanoseconds),
converts to whole microseconds with ceiling division (DIV_ROUND_UP), and
programs min(order_base_2(us), 7) into PORT_AFR during ASPM init.  If the
property is absent, the driver keeps the existing default (code 7).

PORT_AFR L1 entrance latency encoding (bits 27:29)
--------------------------------------------------
  +--------------------------+----------+
  | Advertised maximum       | Code     |
  +--------------------------+----------+
  | Maximum of 1 us          | 000b     |
  +--------------------------+----------+
  | Maximum of 2 us          | 001b     |
  +--------------------------+----------+
  | Maximum of 4 us          | 010b     |
  +--------------------------+----------+
  | Maximum of 8 us          | 011b     |
  +--------------------------+----------+
  | Maximum of 16 us         | 100b     |
  +--------------------------+----------+
  | Maximum of 32 us         | 101b     |
  +--------------------------+----------+
  | Maximum of 64 us         | 110b     |
  +--------------------------+----------+
  | Rest                     | 111b     |
  +--------------------------+----------+

Patch summary
-------------
 1/2  PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance
      latency

      Add driver support described above.  v1 and v2 could not program
      encoding 0 (000b, 1 us bucket); v3 uses order_base_2(us) so values map
      to the table.

 2/2  arm64: tegra: fix aspm-l1-entry-delay-ns L1 latency cells

      Commit d60ed99f1c9e ("arm64: tegra: Add aspm-l1-entry-delay-ns to PCIe
      nodes") added 4000 / 8000 / 16000 ns cells.  After ceiling conversion
      those are 4 / 8 / 16 us, yielding PORT_AFR codes 2 / 3 / 4.  The
      intended advertisement is codes 3 / 4 / 5 (8 / 16 / 32 us buckets).
      Double each nanosecond cell:

        tegra194.dtsi: 4000 -> 8000 ns (all Root Port and Endpoint nodes)
        tegra234.dtsi: 8000 -> 16000 ns (Root Port), 16000 -> 32000 ns (Endpoint)

      With the v3 driver mapping in place, the original nanosecond cells no
      longer yield the intended PORT_AFR codes; doubling them restores codes
      3 / 4 / 5 as described above.

      Fixes: d60ed99f1c9e ("arm64: tegra: Add aspm-l1-entry-delay-ns to PCIe nodes")

Testing
-------
 - Verified device tree parsing and PORT_AFR encoding on target hardware.
 - Exercised boundary nanosecond values with a temporary debug patch.
 - Built on x86_64 (previous revision exposed a tree build failure).

Manikanta Maddireddy (2):
  PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance
    latency
  arm64: tegra: fix aspm-l1-entry-delay-ns L1 latency cells

 arch/arm64/boot/dts/nvidia/tegra194.dtsi   | 18 ++++++------
 arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 32 +++++++++++-----------
 drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++
 3 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.34.1
