Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A72F851;
	Thu,  2 Apr 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152840; cv=fail; b=gs0GSxZDc/Yodu5+pbFOHdfM/WVfBp9/VjOFMez2vIuaboVQsc94ZQQkmdaCpZSrrZizJFu6+WYktudzAq+dxGe59A5/spfU9Vt0vzXLIj8tj1iob0+sepnPjrQGRCwe93Zyo0M3l+qXbN3c9ikDDHJ2MblE9gongkpcnxxveik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152840; c=relaxed/simple;
	bh=1g0QC5fh+e5Ub6vBuarNYcEl2d7jbx8VEghQHSDESq8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+j9voRWzF7uFtN3vXL6ObSva91peGm1gqXWfUHtA3Ufkwprf1FVGhatcR8Pb2Avbcb1pt3DQKl1P2GIUtEAsi7uihx38949y9O9dPSGadvqbTGmyQh/k2syFTrVrCE0h8SOSfO46OBo8cOEQVdeTMHDS4DwPtUz2dwx0cQoVp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FsJBRj7U; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FsJBRj7U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtlh1VsVXvKza05l++qGU3xDpnGQXuTrTUcF/YPAkR3KcHPkY1ey7MO95MwBdUYmvnk6Aak3IoaNaaskUT1hTWGakdcKbs6LpZhyWcR54UAKXdyGIjNRyTN7OpOwJXIp7OJURh0EYMZEn037whBgFSGC5HSDexjWh/UvCkUAXV+7gihWmAYA12mPJUPuuQgt+2+l56FLQ4msOvF3zXcl28LhqoI2U+qLcfBkUc24kDRq8n4TFth0trBAqIWHmGZB2ovkb4Vy5ppUEA5EYci3HMS+jO7wFwchrCNqRIF05Lw/H67FyBM/UeWzTJCGkjx3m+X/8RxUN6EkamEJobfm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLgMj8lDyFRWXHD/N+w40PqSD4ugvdoVIi3ox05aEhk=;
 b=KGihBOk9puNrzmzVQHG9twOzkNBrA2NQshJ4SkEQLUTa5EoiUczqd6JG9hoPyi/L7prUKC6/RgPjTvVwP822LuD1E6NgMtcALBuFR03kRqQF1tW6ETZ/xJPX2ZqaLz2f4XG1IFDzf7WF4DXMTC8yVCFq85RiXUVzidOtHu/Jl9GDB44TwHj7QkyRl5GIp0QpbL9C/pKNoy6k4DZlZ2k3oTRjsbP9I24BQOwJbM0OsyUc6IM2ZFPJx9VMMJA4WWafSQdwxVpgAqVimhACkr+rB2OTMdnYbbWvJXub5H8GkHMIr1KkfJFypA3/YDtaTqwnIfJTIpSotHJc+GFDEiQ/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLgMj8lDyFRWXHD/N+w40PqSD4ugvdoVIi3ox05aEhk=;
 b=FsJBRj7UAhigNq/1Z/jsO1jG4cmvvyLRiax0Oq8P5TRh1pn5BdpYcUauVVXBNXWwuBuw9UhANRRl2WzXb6GUqDXeRItkWWBzNvGBoGhTeAZU0UkdAcug2/OTvI31PmrdQN9E+FqcZq/wLqRRbjDBF85iL1JLl39Fvoczu7E9nCc=
Received: from SCXP298CA0180.CHLP298.PROD.OUTLOOK.COM (2603:10d6:300:14c::20)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 18:00:35 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10d6:300:14c:cafe::f5) by SCXP298CA0180.outlook.office365.com
 (2603:10d6:300:14c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 18:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:00:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:00:31 -0500
Received: from xhdlc250067.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:00:28 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH 0/2] Add support for AMD Versal2 CPM6 host bridge
Date: Thu, 2 Apr 2026 23:30:04 +0530
Message-ID: <20260402180006.486229-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c88a590-6ac8-4e27-4cef-08de90e1bc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7Lg3SpCejyXI6DGrstCi3R+XrFqUC67oNi0LalnseX8RHK021XViE71567DyHWIFy3hPENvrvwr6XslbLlXa4V22ZukhWJsoYv9cES6jksHWD+bSGxIIHLm7eJP+USTQjgTnTEcy3v/u6jEyUOlNThduEWqA+PfPVWbS3qR9Rc2qogkYqve9BrR/erq2vv6sD/KBpWPKbQ49Q6caPH08IA7gmw/bxG5um2b+U9YSL+1F01dbedAgkJ1fZkV4z+FtUskgtj0epjdeFKTnZzoulUlDF7QnaSQeHA2qoHSwxwESGxn3affnzdh8cjzVquhPlDAeri63HOnpjtSEp4o5/ECwWiqd9Vszpc0MH5svsQfsOwCeYGyFwbHQHc8PFlVx2+0fmakTXygHuw5XKV9NgLf8dF2a/jl9vzyidQoshyxZo5+twATZtgT9Y3bvqeBSPMfTeK30BPXvuDR3wOYj2fCAs0RLNghXDt90nJn+bXiZOn2du6lCuUWiBmnMN9bcaSHyEdGjP4Zu00EB2ZldDE6L1qZjyt36lBqW8Zu8t5BPsqzvvtaBVCv1g07EyRABOIlb0sBZFcll7JfPDJkspmPxt1KBNDoGKsTCtTc3HJfFzp+vuS/3l3IanoWLhSwTLkSAic/n+qNGxz5j1D+dewEklYVLH7Dx6ccwibn9PlqNJwn6UsYCyzPFwwclWM77iFYW+ycgm0mm2/UxbKqKqc2yM62mflOXR7q/4Kn5/TM9ChudhTrhq7K4EOl3Ydw3av/esGEohvCgXchvZYgBjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZYjPydWuahMQQFXo8g42v55dq2LY4TT4RtNHICteOpFBcudYKVRzvEHqfUratYWebZmRL8tauxDNHjV+5pDkIfMdykXgA6HvvRF3xWQRaK1qlEpoZ1iYn/8dukoQPh2QA3xvBfjZFDKmgTqvkgeYPm4WzlyMwxHOXhoQK1Zm0G/FIuD4N5MHrxmPbAEa6VeifMzRS53vVPfL7t0DMcU4ufcyGHqBGQ6u4KtxOUkRg08OEWoHvTqDL3h4jeDzXUWpmMptMCSPy7btAWldWr5NaVVRlYOf1BTrIryLQEOE5q/uFUUsGL3MDUSdW+wkWBrC6dWsxckMPBI2vR0PGg17nMPcUOSWq91wYGZPPlLtXeNPG/9qqZWAEXfvFY6ZhXxEzxmreWj/6I7R1RdbjdhCZeUyaZ/YLN61EUJCNx1OW/uq0cJggqAlKDRUMORCIDix
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:00:33.2717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c88a590-6ac8-4e27-4cef-08de90e1bc3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206

Add the "amd,versal2-cpm6-host" compatible string to the AMD MDB PCIe
host controller driver and its devicetree binding.

Sai Krishna Musham (2):
  dt-bindings: PCI: Add compatible for AMD Versal2 CPM6 host bridge
  PCI: amd-mdb: Add amd,versal2-cpm6-host compatible

 .../devicetree/bindings/pci/amd,versal2-mdb-host.yaml         | 4 +++-
 drivers/pci/controller/dwc/pcie-amd-mdb.c                     | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.44.4

