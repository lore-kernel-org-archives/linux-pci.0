Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E4412BEB;
	Tue, 11 Aug 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466851; cv=fail; b=qmb9mAqgUIlurFG6n+L2OA4XxHAc/BZMVliIqslljWuDV1W6LAbysofLeU0JtCmPAJjxxHI9Jkn/ZSe7hnR0ImWtPTRENqxWfA2HMB+CDiNb3ct+eRNaGl7x5YCeTMNH1kqaGvwgdq/3RL8pJIDWJIRYghnyBE+e5jdT8KxOIco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466851; c=relaxed/simple;
	bh=aZnmndxY1T/5paIrCGmU605FRzD41uw0+JkZJ9q/WlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBEJk8chfAw7iKIAE5H4QvZC+eyt+0+5LXOsuq6ibl9a5efxbuxs02aUfvRnGPTQQkHdyGYlOD8JHdejX/gIUUT30cMEKBtglNBQBjpASyvhgh6kNf/iAYmcf8aAk+tp9VssRDHrf5KeYACjLAOVqK320wbkuctjbceiBh6ZgKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTsLw3EG; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTsLw3EG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH5yGxes+fvx3VNauLMDJkUy/Lr6MRL24bD7YSIZb1u6bQPJOd6qs9CGS8oAIJoRdOUro/kj9IWoYfFs537+GltgfapCufqfjXMlLFJkrWu8t49NMCZX0X+EcX9L+O4MYGFqcspI64E0IpbJmBpEYdpSzuynKpvjM3nEJE8PwvZ8kRtq7WyvSBZ5WqGYVx1jGLwLnbGTQj2jJ1drGk73mW0433imRmgEhYwnaCBvQh33YShvpFvCAlNr4Tk4RbyNdMvxcrbrLpmqL96WC5hZmrMQSLq4G1SAnQEax93vB0N9RzcZ+oUt4fZJQg/bBIRmwzHBfIzsIwzKo7GTIr1qUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAdOPX+HEJIIYD6FXK19M09YjuxR/Q8+dzrVAhf6Ayc=;
 b=EiDbXaKLmau2B2CtDBgan6WGkeDm12XtG10VO/S//l1GYusBVNgJKFHJiEEearw4evIbwNvNMtbA8xWpkEv7s6bjQ0dGEzQHnBJ7cdeIYlSB9tSoVxj95JOVFKugayLcxn1su+lDMG6/LyXodK7vtCoAsjiICVYyod59OVArlx+33Z5FmCCxRy8Z8VLa4MuC+SdSGet9R5BelPjs412IRJLGO/N5FEGtQ9P/B0SVxz7YqZE8KH1AMpOBaMF+2dAI84MmNbEx74XooTqYtNraxJkyTfGvlCEeQ5QjiPDeMKnUR3sNssc5NsVLfvDLENJ7KJgyINNtHXR7JSa0PTfeuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAdOPX+HEJIIYD6FXK19M09YjuxR/Q8+dzrVAhf6Ayc=;
 b=BTsLw3EGLPK0xJVRXy9hzZMmEeFv0gSpoTuWn/b77O50STCJPH8wxFE/tr5uYz3ksvhWnsugqq7FXyyg11AONIwXUDdyIxaj6CiulTloIgZS2AvAx3sy2WaLLnNH4AWpCH/3OMXbeSEfGXUjWIQppeyaZW/BmQuF0LhFl980O9xTM//vbRXVruAOEuqe+b4Y05SRyggZTdP0/vFD6UHd4Q5VSf+EH0TLa2ZZL+NMVtQXpaxwFoIlD5RUAy5bQzAz8ZOTBnSfe7pmNQGP0U7PXau0ixMm5BFKt8enmqpfnFM0zrAcUDaS2Bl3OhzDY+WZ2bu0sVU0omxfDXkT1CV44g==
Received: from CY5PR22CA0020.namprd22.prod.outlook.com (2603:10b6:930:16::19)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 16:47:22 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::41) by CY5PR22CA0020.outlook.office365.com
 (2603:10b6:930:16::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 16:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 16:47:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 09:47:00 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Aug 2026 09:46:56 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V2 0/4] PCI: Re-evaluate DEV3 14-Bit Tag Requester Enable on link mode changes
Date: Tue, 11 Aug 2026 22:16:36 +0530
Message-ID: <20260811164640.587078-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512163012.2336191-1-vidyas@nvidia.com>
References: <20260512163012.2336191-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dbe823-e997-4437-edbb-08def7c836e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SKNgchQ8t6QtoACwnMHXiRA/gtaY6LpjAACcDGTkGEEIx9GD+ggalhHYlnu4xhwMdGbDNyYWO5xZB9jeDI+5U6nAY4b6PsOy+qRg/N9Xby6Q/cLk18b/74qENaQChMLBtmdxU2a0jxL9IsU6nzqEyR9geowM66qSiqk1UsNBg39xk7nA7Cp2v5hbTXH0+1Eof7yAMC5omFHjzl1rlECWOkOlP289IUfQfe6tOWhFLWYdr7zxsoNTei2KVqyVjnammx723zT+QooToy05Hig1bBOjaxLDPSgePgy8TN8RkHAF2vRB7tUCfCOVG3pUNb4svdvh6q4JG69JykAm0Xm+hq9uNqll6GbFDmlOem10OG6f0N3kr0BRLInDP+5nqPj4SmRX5+94bUbIXpWk9wmDDwbVmdhOQFsZNJsmhPEdb+FVoyK/W9aP/soslmmCTUlepIVtSpuGKvBQ5MeD/4YE0TLtyWu+EsYzf5toDvqlH/VIQHk9dRVCM16j2Zs6eMArNRof0RspHep216MHr2Z9cbmBxYytVldnzA8jV9PK3202qGsq5mm9xVy9lAZJRh+QDUkXIEdymF0tbFAA/65aH9jlN/h2evoKb2Ezv/AXfu/MHG69FTz73zJj7vGlfyPKXJ+Mc9ZKA889o3X4xDZWJeP3JIaFioNGMSX8FbSScCxGQ899nU3+taJ7P1/s6VkayekVGl4yaerIqC1B2h4w4Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c5nJL+c++RmzelpZW1IU4L0c5S1Xl96x/vuqGIgSDbZ65mrzEGWWX3PCxe5ORgY2Du2gOZoRZWu0ot7oQisUXyO6EtZuU0hAW1t4LmcbjT6o4Zy4pdycUdGx83YEf1k71QdVAGNNP8JpSdDKZRolxDDg4F3Es/H5xFy4r7pmD0QGmciW+ItESoq46rQqixCJ8W76zV+nOMG3FHBpBNlVVhzjpBdtvLATcM8PElRm+1RyoTkxjbtONq48W47ds2M8b+jLTdd+igPo95FvsiEeZiO33W15dz54F9ebPGVo1LNETVQ0h73c4DwGGnWg8Ghg1jP1fDUfvzVLcuN88nb91/CHbJDaqHiWoSKZiXcZaRKKZbF0RrgmmHAD7QsvQJ+CPfXxx89jEvVJRJC4eXoHkqEQmahko1kYGFAzoHIuByy7m+acU8S8HxPehD2u66p3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:47:21.8699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dbe823-e997-4437-edbb-08def7c836e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622

DEV3_CTL.14-Bit Tag Requester Enable is only meaningful while the link
operates in Flit Mode.  In Non-Flit Mode the upper tag bits are not
transmitted on the wire, so a requester that still has it set emits
requests whose completions it can no longer match: the completer does
answer, but the completion comes back with the upper tag bits zero.  The
requester therefore logs an Unexpected Completion for it and, once the
timer expires, a Completion Timeout as well.  The completer side needs no
handling, since a completer only reflects the Tag field of the request it
answers and the spec accordingly defines no completer enable.

This is what happens today on the very first config read after a
bridge-mediated reset when the link comes back in Non-Flit Mode.  Two
things are missing in the core:

  - DEV3_CTL is not part of the state the core saves and restores, so its
    contents are lost across a reset even for the devices that do get
    saved and restored, and

  - nothing re-evaluates the 14-Bit Tag Requester Enable when the link
    mode changes.  This matters most for the bridge: it is the requester
    for the config read the core issues to the device below as soon as the
    link is back, but it is not itself saved and restored on these paths,
    so it keeps its stale enable.

The series:

  1/4 adds the DEV3_CAP.14-Bit Tag Requester Supported and
      DEV3_CTL.14-Bit Tag Requester Enable definitions, both bit 2 of
      their respective register.

  2/4 moves __pcie_update_link_speed() out of line, which 4/4 needs.  Pure
      refactor.

  3/4 saves DEV3_CTL and, on restore, drops 14-Bit Tag Requester Enable
      from the saved value when the live LNKSTA2.Flit_Mode and
      DEV3_STA.Segment Captured say Flit Mode is gone.  This covers the
      devices reached via pci_dev_restore().  No other DEV3_CTL bit is
      modified.

  4/4 adds pci_bridge_refresh_14bit_tag(), which fixes the bridge itself
      and then walks its subordinate bus, and calls it from
      pci_bridge_wait_for_secondary_bus() (before the first downstream
      config read after SBR, DPC release, AER bus reset, slot reset or a
      bridge D3cold->D0 resume) and from __pcie_update_link_speed() (which
      covers retrain, bwctrl and hotplug paths that never reach
      pci_bridge_wait_for_secondary_bus()).

3/4 and 4/4 are independent of each other; each is useful on its own.

Tested on an arm64 platform with a Root Port whose link comes back in
Non-Flit Mode after a reset.  Resetting the subordinate bus from sysfs
(reset_subordinate, i.e. pci_reset_bridge() -> pci_try_reset_slot())
previously left the Root Port with 14-Bit Tag Requester Enable set, and
the first config read to the device below failed with a Completion Timeout
plus an Unexpected Completion.  With this series the Root Port is fixed up
first,

  pcieport 0002:80:00.0: cleared 14-Bit Tag Requester Enable: flit mode no longer active (DEV3_STA=0x00000008)

and the reset completes.  Note that DEV3_STA.Segment Captured was still
set at that point while LNKSTA2.Flit_Mode had already dropped, which is
why both are consulted.

V2:
* Split the V1 monolithic patch into 4 patches

Vidya Sagar (4):
  PCI: Add DEV3 14-Bit Tag Requester register definitions
  PCI: Move __pcie_update_link_speed() out of line
  PCI: Save and restore the Device 3 Control register
  PCI: Clear stale 14-Bit Tag Requester Enable when a link leaves Flit
    Mode

 drivers/pci/pci.c             | 208 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  17 +--
 drivers/pci/probe.c           |  36 ++++++
 include/uapi/linux/pci_regs.h |   2 +
 4 files changed, 251 insertions(+), 12 deletions(-)

-- 
2.43.0

