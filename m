Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF53D5640;
	Fri, 14 Aug 2026 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738660; cv=fail; b=iFwBiQGlkvGR5sC+15AEZr7tFCzQfQyJv1KxSPXyhLbczA1FW1uCbOj13ezODqAUpfQNKssUdic4MWCmmafC6Bjztj1KWaZh2iLx8Z86dYeG/gDB6Xq5kW+ktQDDz+FyJgv5uZbH5+d4x1bv2brpsqFLb31lHj9Om2tiEIPy3DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738660; c=relaxed/simple;
	bh=zRUG35zJtjsiCbQiXeVWlom4HwE/gGFJrIYX20IV5u8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZo7rTA5NQCrs34A8tzfbGBiQUw2b8nz6On43aZpFq2bxdXSlfPtsS+nknjReGGGSX12gc9O30QrZ00Z6ekrs2hY4A5Y3OFegxbncV7TajPJdfU4R8a0R/CyJqXmdcZtUP1xtl22EsxjxG2gv3eKApILhvpPbvFNZhoCXXlVb0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fIGWLXUF; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fIGWLXUF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAyVwmls9xBzROyrKBCE3LgE7OfFAxPdGu12jczEEf547EfzGkJyAngzTYnuNbMFfkPqjXNx90+/JCRjGX4B3sMgarYYk8LbCvzOyV/5q8xYhI9WqH53Vs9WTd7hL176hjbW17fe33l13UQQBS5gshx5xZdlK974Jo2V4Ke1w6Pw8xDuH3BFURc/pHtf8TJOaPQ/JfEuXWcVMpc/YPwZpiA4dq7MSNcGgvlT/wcx1QgU0LceJKf1c2b3Z9kFknpYck4uPghxsWZtlfLnWKXldkEP87tzsLtbOPoeK4I8trwkVTkrIPVfNpufSo5nSS/dQ+sAEUmRNqnRNgXJ++Zn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqNvPXt1XP3oh/sQm6E/mwydaZjEgoTL1/bduyLRZTg=;
 b=FyRihLqLH1UV24Pjuq/+8VBCxw+CqcAu4j8xi+nXOlwot3PmSaoXGUVUn8L9OOwmH3CcMtb7XQXkOjT+5ddXpcGC9rU8/tJRpPCq2AwL0YDiFkuq/1mPHqrxKp8JDX5H/BW6GhmjPMjyi95g+0BKEbAVDxSqnequ85GtSR9XwCvooBYzINX4hv72zkIRiq+8yFAW0pqAiDDe10/7Hn0pGHodmaf+A0mYfN9WUveJjOC8oYJPlknE+p5jsgehmJMnBz7bxgPoe+9L7iuZeHuhXdGbs/Rg9GmYT5frDiTeNaNd0DGnorJioiDxTJaMfoOomWc2Apo/kNlJwFQy4HVHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqNvPXt1XP3oh/sQm6E/mwydaZjEgoTL1/bduyLRZTg=;
 b=fIGWLXUF77pHpCOdJRgYobLTIwVotj9cPyyVGlHEKUzc16eg1WvykynXDHo5rKSbnm+Yb8BoNdL/BLcFUsvwYnQeu8NoswVTbir51BplzDToVG+BPjpnEk1nQVY3cfVHLSSPqsiYr0qebtFuxfqXFKDM4qQj/UsEDnXGOmb06V/mpolQRm8cKWcdnMrIeeMhgplIBNgRxlLlpMA+GpNIzeGOVfxNt0KPyoqZsR9n19nVYBjJMpBuNp44mtGrsGt4GoBerzAaewMqoyDPJEnTzM9ETWxiz17+wLhr59Wvp5bWFVdNXvwNrYUrDacCbxdq0M2tvN8znW5HoW6C17K13Q==
Received: from SA1P222CA0102.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::10)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 20:17:33 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::77) by SA1P222CA0102.outlook.office365.com
 (2603:10b6:806:35e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 20:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 20:17:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 14 Aug
 2026 13:17:11 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Aug 2026 13:17:08 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V3 5/5] PCI: pciehp: Clear stale 14-Bit Tag Requester Enable on hot add
Date: Sat, 15 Aug 2026 01:46:21 +0530
Message-ID: <20260814201621.2281245-6-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7302f7-43d4-4685-24ab-08defa411356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|3023799007|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UscdpYk1d0sZzNwjbzbdCPFm38tHHeLsG342dW9bU1u9ogoSFEkUdFy2pf9g8PO3mXQyn2Q2tE+D2FVHa7nuXkHc/co4e8zxsD6rN9NbjGmDzp65+YgfhovFFO/6qYRpaz5AZzqap+h3nuRSfiF1SRzU69E/ykvtPLyrubhf6WqIb+j/zsmF9NaV6PbyaGYhZx06SwaXdTvBRnGihtm3lFb0L9nqk90kGQuyg2H4z+td9d7pSPpEvhAbTQ4gsjiSMmkPCjFWQCO+2/FpBPvsZahScCbuu+auOQQD/OXox2Ti9vit60M08lOp1frvd4W8t5YHtDBA/YN7xIV88mpE8USTO56qgpRDR4x4w3KnT+lid9Z42ln6uorqqGTgtXL9RVDRaWQlo7Ybjc5ywzf0K5ITia0kGeAgivVEWh7F4C1Q0Fnj3CKp5I+1feJM7fzG+e6bz4kLfJ7bKOScTldNSOQcJNxAR1c4PsT0C+jUESesYmsa5p7KKbx1spB0YQhWUsRbiPwrCbld2O5BocCcJjuwJjcMS/mdLnRlHiA2OexFLwOCwVr+Xv37INEwJyT66BElPntll8Mc+NPNjHupRVFJA4Ozy4XO/wJtUAS6Iut6dWz8gGy2aejSQQyTMSLPtR70Vl05q5mgYri47kPzUc5rm/I8AQ0xMQmP/pSPhLU9yaf7/viF/zfT3qjzzvUGMHAXk8RnEEQBtKT/VbDCdQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(3023799007)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sjugHJmh8DNLCDJL9nLKNGvpcyu2ib4srEK6B8nOk6iFs2JDONcMUf8MclRCcJp+m+xJ8zhgixN/EaBzEJ31XqHQijCUB3d8tPkThngrZv25UVIvg6783+w4SDahs/e/HILgfeRz7X5t7xiyYYGLO8TOZK0T9y3IYrRYuLK1eXjW/TiHNfX+12tCJcHbS3bcUV7TKxKNiiPqQ500y9a+xioU818Mffl7hFBUliHyymOuaTGjIwKIG3g8qzJP0F6y1j0QMpzfXPcYez3vK7UFHzaRMcHGWFHP8CJaOSulcvT2M24NGDIc9G2nhY4DHWKDL/8cgM5A04+fulm8uZn4hcSBdOrCYhAHux32SGu54FIOxCAKwayEZeKA9dyeRdymiK6YFLA/8HmSIbNe3/tQjqYj4y2ReNAYf3fktx/eZPL3U35G+oaqCn4MfCqR7vcb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:17:33.5972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7302f7-43d4-4685-24ab-08defa411356
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

pci_bridge_refresh_14bit_tag() runs from
pci_bridge_wait_for_secondary_bus() and from __pcie_update_link_speed(),
which between them cover every reset and every link mode change the core
observes.  A hot swap that changes the mode of the link reaches neither in
time.

Take a Downstream Port without DPC.  A card whose link runs in Flit Mode is
pulled out and one that trains in Non-Flit Mode is plugged in.  Nothing is
reset, so pci_bridge_wait_for_secondary_bus() never runs, and the new card
has no saved state, so pci_restore_state() does not run on it either.
pciehp does reach __pcie_update_link_speed() from
pciehp_check_link_status(), but only after pci_bus_check_dev() has polled
the new card's Vendor ID for up to a second in 20 ms steps.  The Port is
the requester for every one of those reads and still has 14-Bit Tag
Requester Enable set, so the card's completions cannot be matched, each
read times out and returns all ones, and the slot is reported as empty.
The card never enumerates.

Refresh the Port's 14-Bit Tag Requester Enable in
pciehp_check_link_status() once pcie_wait_for_link() has confirmed Data
Link Layer Link Active, and before the first config read to the card.
LNKSTA2.Flit_Mode is valid at that point because the link has finished
training.  The subordinate bus holds no devices yet, so the subtree walk in
the helper is a no-op, which is what we want: the new card comes out of
reset with its own 14-Bit Tag Requester Enable clear and is configured
during enumeration.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* New patch in this series

 drivers/pci/hotplug/pciehp_hpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb4..95f9d5abdec2 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -302,6 +302,14 @@ int pciehp_check_link_status(struct controller *ctrl)
 	if (ctrl->inband_presence_disabled)
 		pcie_wait_for_presence(pdev);
 
+	/*
+	 * The link is up, but a newly inserted card may have trained it in a
+	 * different mode than the card that was removed left it in.  Drop a
+	 * now stale 14-Bit Tag Requester Enable on the Port before the first
+	 * config read below, which the Port issues as the requester.
+	 */
+	pci_bridge_refresh_14bit_tag(pdev);
+
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-- 
2.43.0

