Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223A43F084;
	Fri, 17 Jul 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311236; cv=fail; b=J/vsdeE4Sce9jwsmdEFXCaKDRk0u0sapNwEXigdH53thk9VAlUjrcbzhkCKJw8IHYSotqugK1jgPBsGbh67lWoUXDCFjj+mJ2okjgMN/ilYEZPt03gCWZ7dlamYxOQbtgpIuIrru8Rdj6SNxMumiE/6Da7uNuCbXf8dgfFH4uRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311236; c=relaxed/simple;
	bh=M44n1ThFUecN5o9u3CFL1wEehdNMM7BTttdf8cEh7Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JiJjo2mHJ+DyVEqYkQAUlnfkR5+Wb6q/FJj2xS17hHemOksW9Gwvh8oy0IEKb4I5yfK0o2haaXe2vsKDS6bCHs2qSru5Q5yUu232hEJzJn4W1gRyheCodsCTHDBe59YIgLjCefSSyouM0pj0pxqM6WTXiaGmG02WNbg9lSaGjd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=RCqxFTHj; arc=fail smtp.client-ip=40.107.200.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="RCqxFTHj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0296BL7a10Q4PiOKNdbmS7nw5MVHzsqx6mYfBPi+cVCTx8jxXk/rJJCx5a77PCSyZnrV6sygUfo2jdb8vDLhgbnLWHaOtEm83xBC/VHPoORZ2c/3o6ROqeX2XPgtICVvKdNHN7h1vU4PJzGoOhGTH/6I1SfQtpOjL02pxrxBOwIVImmQwWV6CDv6VOvv3ZzaXoo6LvkgrNCgolvHsjtYVTe4AaSiGCta6RX5NEhKO06sTcE20mVTjm4WsAQ/SPheM6isMNZrqJUXusUfNKv0e8Wj/1W3qJAZTAagyIM4SJAG/u24dC+NStd/KYhzOBWOCXZdJqUfAO6d+foEL+OcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtTZpZZzWXtZAl2vyvEglR/4RWVlk8ynSbJg4JnrliU=;
 b=E9I0d6EDOTBgPNpMHIxFqpFG8HvIYQym8Nsp579tVbjWQ+pi3PUfuyhvVl+iAZa983hzv/QEuPKqArAm+0peSR8uyAhdoNqRIZy/2yO6T0cDwJWO67BB/ZoZKFylYklXjVO/i52iV/5pc7ZLmFJ1ZeINrsTlJ01QVT5iu65d3KaIlcRjXGYejADipG/nXyb6EK4eLhekL6ISGHObbs81k3a5ApUhaY1in8BIkBu1QS5E63GQtRJ1iABHa6KkKRXR+jkOKGGF1tw0RzDyaypj3/gcLFqB61x8GKwLo4udmwMyfRpwZdVA4h2T+HRLZkE8gSWIcbdZbAkncXjUiGaCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtTZpZZzWXtZAl2vyvEglR/4RWVlk8ynSbJg4JnrliU=;
 b=RCqxFTHjT9ZRMQ5tofVU66VPv6c5sOx23ax4TX3y6qKUhwOwi8zD97E50xifTM5V6soaW0FS5Ha8NnkzyIqtzry52MIgoDvnjOAjA8YFNUr8XCjeS+ekhp08883+TgQyRzoYWQVQbrrP/SYddo2aeMQL4BHNsBmwIDGzZmjZHdLYQRpsqIvNdnjy6dXh0vmdfvIOC8FzWfqckrG1D+YRSGvvnWHY60DMZElmhUgBgTHrmsVZ44evlT5uGTvXEHbHM6ItjSg5l8Ziae+gLlbj5wf+B+LAszPhd3+OqTVPc9EJvg0Ux8tXuO0ylr21BNkpMHwtvCL8hjFYYxbiIkjVPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by LV8PR08MB9415.namprd08.prod.outlook.com (2603:10b6:408:1ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 18:00:31 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 18:00:31 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Don't report fully optional resources as assignment failures
Date: Fri, 17 Jul 2026 14:00:29 -0400
Message-ID: <20260717180029.1829888-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::28) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|LV8PR08MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: b4573709-fecd-4f68-55c3-08dee42d4afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1I5aOpVaXrMg+z8nbZPOjJztY8i64JN6g4/xr6pEUbbwGLJXeD3xusZ/uuHtU5wWJIJSe78vFlkuY6l+96KdKfTu5u8pluBU2bKbzGKmNVT+4I7a1yfSn0ZkbrGMmiUcte3VU43j7sVJUFxTFMCDebMghd9gfIt4CYMWL4vy0dX4Vi2DOnmZfZ4A3uOSdVReD6RV5QhzWs4EeG/o+qk8xMnBDarxH09rNiHsjmdxLKsOfnyp3wsrnmGM1bhfyrA9yW7t8cimyBuiLAYTrVxya8tcGFp1wsrQjfb5KaSvVR0OiWKGuk9cGJdEg8aixRzElXXC9DuDyMkjcK1WRJQ6Ke+qdIOtfxR/JR8FDTMcVUCdF1Axh2JmlMcx7A/+SMXdPsMxfeN9fTprib9TFO4dHW4d7qVe0anR+6Cc1/xquvRQniEWaUmlShVXEiT55ZwA8OJ9PkRlwvdBD+w3dadjiZTrPck194bhI59s4y1yCflzuMflszyIwDjMmAfPTBCn8e0BBuhZ81AFprtrHIQRfwdtk/ab1TYalOzCJRogSxeHG3zoM2DWKDkJp5yo0W8Q66prHtshW2k78IrpKJTXdAxB8YHY3T8M5AtthcT4MXLFMzvGuCNoqllVo1cs0LrGETgvgaC90Dn5+OfygFTLhP4oR4N47f2+mbsHZZ6iqmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nSm7s1uGMjGGiE+gZjYVwVco4wA8M2NAFs0veJC+pU7XUN0oLnmfE0IVRyRk?=
 =?us-ascii?Q?CylSI8KUN3UawosrUKcZPov2P8kKim+wy76e6j4KMj+hJLEChcPOYpY8z2aO?=
 =?us-ascii?Q?4za4nynNOSyBVN5nfFKdEmYwT6SVdCJbpNnyEm0z5loJDDR6zzvs8TArSUOt?=
 =?us-ascii?Q?7lpoA5+rv01bRrsiKhAs3UR4AwLw3jl0gL+NVG1FyPVaGfo1fCC9thTB7ddl?=
 =?us-ascii?Q?s3g+fB2tCN1H8NbEG/qMmmxBq1OgPSve93RXtwDKCwGe/rhRT2SNa8mOxaZa?=
 =?us-ascii?Q?LBRwBK9SzodTyCqF6NztX0VS8IXU0Bav6GRRMiJugYyqMHN8/Z0U1HP00G1l?=
 =?us-ascii?Q?n52ej2NvsYeMkanQW/GBKMMQX012ztSSKjXTmd8rEnnU4j1N4f9A8Bxqw9Ns?=
 =?us-ascii?Q?7QkWsF4W6DeoWbngO71uDaJbiTt3kiaykWEuofKvAPoPt1lPF+G9IBe5cImV?=
 =?us-ascii?Q?lzTUjkloGg6h6oeauyGsc2RNtYkiYQc/GjDl/EGXIpkdijNjLqcqD5FgnWeG?=
 =?us-ascii?Q?3LSUG+5fH+IVbe++6WI/XipcYPGAu47AXvKglILdg6qazW96jSX6rHbDuDEY?=
 =?us-ascii?Q?xtdH/T8cR3U35n6jnfVHyGY4lE/3xsZEj+IRIj4Do4dsl7ljThzPJjH6E4zK?=
 =?us-ascii?Q?HXd92W35mIwlRe80wl+EdLdgARczWGPuGxQCFzFVrFpNFSw4yRGSiqLPBoMS?=
 =?us-ascii?Q?oLeo7oblElaS8EaUiyiDPR3tfEzK3WLX+mkhbW8sthr/1UILNoiLm7gsetRu?=
 =?us-ascii?Q?lyq25cP/dvE25wq6ETfab3E3QqIpetEYPtKnlTBlNYDMSj3ieskXdg3T+veB?=
 =?us-ascii?Q?jnbmMkHNqce+s8ESUKQNLGNg3PSwUdEEswB7ZnU6K7WaoWg2qI0fsuvQFF23?=
 =?us-ascii?Q?2FnMP3/Skh3snKuErHqxrKOL5f9LUhvbEvSSe6skG1q3qghWW6a6p6isqney?=
 =?us-ascii?Q?tcqml/RuSB8M+MZqPiFCxVc1wi7I4FqMYgIvJtmt/ibd7cWF39oU6Jnp8BFE?=
 =?us-ascii?Q?PLDHri0CggA9Fsrzy1omoX6ePaO5wZmFzI1kfhaRefuVZCEFp4tBIIKbvYPB?=
 =?us-ascii?Q?QHjmfXjLTVHRaStYCEfATXu5LmWaXQLO8FiRbhSshTy3YI0tLa4nn01PUMHR?=
 =?us-ascii?Q?ojZ3Mjf+/ealWuIFy/wshPylC/MOCFAliiL+QIwcgPs4mh19IwesjgpHWsFA?=
 =?us-ascii?Q?5PoAnqA+okJZB7NKR3Ta99tCDGy9QtLCvQ0rK92i6if39KWpKQuSSDDFnR8k?=
 =?us-ascii?Q?P8qyQnS0MgQzlU9WmAkmAUk4r6tsM427Y8a6VK1XvK0WAEj31Y/zpXVRI2fB?=
 =?us-ascii?Q?823rtJUtaQgB6tuaXqJv2uUaefC2wibBo92EIvcyM5wF8YJXkX9nEbRBPexx?=
 =?us-ascii?Q?5zWPbi6mtDTxdqJAbg+HlF0RjK1hzx/vA/toWsVfqhKLpZQlCe5qDZrbgvUk?=
 =?us-ascii?Q?6jbiLmP+Wi3pNbj1W2UDOmeakRUfNMcLDfJt0V5hskMneRtrEaUVzJpFV9Qg?=
 =?us-ascii?Q?FHaxzs0PN7bfodofHB09IA42YnF6MVh1FS/2eHhSYwLONo747YWzJetc57uq?=
 =?us-ascii?Q?8MbMi2/cIFEmg0iGilQ8baSWgNGWQcY3r9vD0tBGqTSeNPzRzz+SgCFi1J4+?=
 =?us-ascii?Q?UL3QL9TmVeZ1jxAA73kznVd9/2ebA37QevZQVGFZy/PxS6ujwwG1rieCDs9s?=
 =?us-ascii?Q?9F2ROPN4XL23/Abkh136QF2htW9gTaBV+ZVG2zSToiIG2tgA0Cq6ydfYi1st?=
 =?us-ascii?Q?IVanRYLxKQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4573709-fecd-4f68-55c3-08dee42d4afe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:00:31.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MM7nY8WPAip38ylP6FsKUZWjfg4Rt40ve3m43UHGUnp3lugUNZcDj83iU/KaZYOHH2cCz0mydTdPYLoVNrSSqY3rqPUkatpBVwPLGyfzWPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9415

A hotplug bridge may request a window with required size 0 plus
add_size headroom.  For example, the PCI core speculatively requests
a non-prefetchable MMIO reserve for a hotplug bridge even when no
downstream BAR currently requires that space.

reassign_resources_sorted() temporarily grows an unassigned resource
from its required size to the required size plus add_size.  If
pci_assign_resource() fails, the failure is ignored because the
additional space is optional, but the resource is left unassigned at
the enlarged size.

Since commit 96336ec70264 ("PCI: Perform reset_resource() and build
fail list in sync") and commit 2499f5348431 ("PCI: Rework optional
resource handling"), the __assign_resources_sorted() out path
unconditionally adds every remaining unassigned resource to fail_head.
The headroom-enlarged window is therefore reported as though a required
resource failed.

pci_assign_unassigned_bridge_resources() interprets the non-empty
fail_head as grounds for another assignment round and releases bridge
windows with whole_subtree.  On a system whose < 4GB root-bus MMIO
aperture was already fully allocated, hotplugging an endpoint that
required only a 64-bit prefetchable BAR produced:

  pcieport 0000:00:03.3: bridge window [mem size 0x00000000] add_size 200000
  pcieport 0000:00:03.3: bridge window [mem size 0x00200000]: failed to assign
  PCI: No. 2 try to assign unassigned res
  pcieport 0000:00:01.3: bridge window [mem 0xe6800000-0xe68fffff]: releasing
  igb 0000:02:00.0 mgmt: PCIe link lost

The endpoint's required prefetchable BAR had already been assigned; only
the non-prefetchable hotplug reserve had failed.  Releasing the sibling
bridge window removed MMIO from the active igb device.

Save the required size before attempting the optional allocation and
restore it when that allocation fails.  A fully optional bridge window
is then left at size 0.  In the __assign_resources_sorted() out path,
only report unassigned resources that have non-zero size and are not
otherwise optional.  A zero-sized resource has no required part and
does not represent a required failure.

This leaves the speculative reserve unassigned without triggering
another assignment round.  Required resource failures continue to be
reported and retried as before.

Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
Fixes: 2499f5348431 ("PCI: Rework optional resource handling")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
 drivers/pci/setup-bus.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c0a949f2c995..c16f0a5f9456 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -450,12 +450,19 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		add_size = add_res->add_size;
 		align = add_res->min_align;
 		if (!resource_assigned(res)) {
-			resource_set_range(res, align,
-					   resource_size(res) + add_size);
+			resource_size_t req_size = resource_size(res);
+
+			resource_set_range(res, align, req_size + add_size);
 			if (pci_assign_resource(dev, idx)) {
 				pci_dbg(dev,
 					"%s %pR: ignoring failure in optional allocation\n",
 					res_name, res);
+				/*
+				 * Restore the required size so a fully optional
+				 * resource is left zero-sized and not later
+				 * mistaken for a required failure.
+				 */
+				resource_set_range(res, align, req_size);
 			}
 		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
 			res->flags |= add_res->flags &
@@ -743,7 +750,13 @@ static void __assign_resources_sorted(struct list_head *head,
 		if (resource_assigned(res))
 			continue;
 
-		if (fail_head) {
+		/*
+		 * Report only required failures.  Skip optional and
+		 * zero-sized resources; reporting them would trigger
+		 * another release/retry round.
+		 */
+		if (fail_head && resource_size(res) &&
+		    !pci_resource_is_optional(dev, pci_resource_num(dev, res))) {
 			pci_dev_res_add_to_list(fail_head, dev, res,
 						0 /* don't care */,
 						0 /* don't care */);
-- 
2.43.0

