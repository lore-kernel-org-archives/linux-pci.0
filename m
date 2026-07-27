Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E13C141A;
	Mon, 27 Jul 2026 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181062; cv=fail; b=J8752ZnPjTDUDPH7GqZ6cyHqK1co4FyBQuVFoSG54n/n31CR8NCgUUi8t3hmfOy5ny4yLaDZBMrcQW1Do2QlJv2dtVXxvZsrN1p0KaG4J4pyxYjhZp0Poy9BcCEHoK+0LRj+3oEAbOs3Y7SGyOTmhjG63X4bFK/UPXaRtvUXZpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181062; c=relaxed/simple;
	bh=WY0C3o6uhJCvq8b17c1kn5hOdmbO31G0h+/t47VChpU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LxCxBAGx7zJFjFZ+3vOhFFOnV77xHiK0wFXnkz8UGSyuYgg+uWZjKhUscM3LMPyn+XqsTCgQS7zWWLHf86SeO0Fzpn8+Wo0rsA80lrPM9L5MmOcGRbxRNmiTqqqmDHshqSwkOF7oPUFn86RTZ6IGDtMoOdabQwtRNQc3BLEa7q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=b/G+E+Ae; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="b/G+E+Ae"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiltKAVDSvZXsTM07fppCPTfxYlplzcZP4P8Xp9RCEAAgcZ/BO8Gj87XC39wFzpdaajvDcXgnl7aMEzJZjeFI7H8BERTIGY8kZsIzCyxH6EZrDmbWiz9z7yLlyn1MVoZNhTQsHi294lIhGy0+6V6oqx7HfYXB5A8gs05SFizWmxILEUMYbZdBX7VHaQjeGUcovLRDCDGAk3/zYSDs4bLZDMhfUTR4wpgAF0H5oaiIfR/ZtHvl6K90DagLI7QpBr5pxiJVMsfTpBPrixmIvDJgryk5qqqkQFmBjQST43Ciono3Zl5uA9CZ0bITDsVbUzcWXTwtrpIk9966WJOjgSPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm7HhKDKTnFena6pGq8VKM/YiKMc4ssjUfHS792t9Y0=;
 b=LRjP78r+Tok2nuzaaq90RmDIeL8I82sQ2Pp0ZiYN5SBudk2f/wT+fSR8jHmpXRwr0a7NE6Lvh8Y3IK9H3IRB9cO/k2OHZ+DWJFPDi6EVebQeMcSJbU6eiMo7YB5ss/h0AvYGgKsV7hvZcl7KBLjidjpYCBSF/o3hIcpWavZM/XRNZsDo51h2ZKZTx0fdXQrBr2OYuTZqnJ55iha4fp2mRym/ePXy49BOIsWB7Kzszz8dGghzDRVkC2DkadQrDfvXibspx/hDYYSe9Mdhe2NJrc9eU6qIKtGB61dvsMakD1usRc2mUmak8mXVdLL2KBAf8fSF26MyJj3Z0Nu2Y5U7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm7HhKDKTnFena6pGq8VKM/YiKMc4ssjUfHS792t9Y0=;
 b=b/G+E+Ae+eixaGHaXfeNxf97D/lx5huHLvfs3yKREfxABsmXAZr7M2A6abuFmqD+LDZYF3olYGXm5bDbReGiABXAOUNoaRHEAO2nu8R03jrGxXdEmPuHldMZnj0ASOXKXbBYgRfgiPRy4/P3ziS8V/8hPo6pKv2IzsSRg6CpMjafeFjBckCd4dvjMbrweWCxFupLAVKuvOVT0n/HOOEbfz7f/bTcjfReyIcZ7hsvk+YntBJ5+ZfuWoRPOPJwsPl1RCycIhu3NsaNQN0B77wUKG1HYtGE7DqYQi8rKQYnhBh8UbNg4Q1cBApKRRHUFRPj9rWp8oCplaB4G7MyLVOamw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by DS0PR08MB8726.namprd08.prod.outlook.com (2603:10b6:8:163::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:37:28 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 19:37:28 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Don't report zero-sized resources as assignment failures
Date: Mon, 27 Jul 2026 15:37:06 -0400
Message-ID: <20260727193714.598562-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:610:51::25) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|DS0PR08MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 619a0f78-a9c4-421b-d331-08deec167dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|5023799004|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	tBBXwpMdHWo+yZrkRqX25DbBDeGEI+UNRJ2ndO1JjPEOyd9C64DK5ueIC1VYAK1sVXO0f1AUvN8+em6w4aoC8yadoiG/LRNrMs6XSur3nXP1rgq99peDkRCAB8Jcy6GXWaXJRC4Ej/BszRWLOPzUCSjljzAN2vSK5eLz806O36qIQk4uq5pwTBnmtuUOQjwHllkw/mAIDrFMN58xFRnCBqNiepZpE5s7YRzJ+CZphif11XqpsfrN6EddneEmbiE7WrIg8DZQ4qIsm+j5yE8zDkL7D/TnJ1vatCMY3OdFFJ4ErMAk1aaF6ew2NeD9AyON9FQAw4zFBKxT2EtI0Q/ze0kQGV6/tbT0lGvewF1CHrMbQiyJnFqqcWbDR3kMBdKkZfHlN8JosBR27XMF9RGqsMLQaG+uxbb2lLHtkGLYRrgNqwvdkUPQijDjEm+ii1iwT+XgpO3+ddyEodRDX/a2L3gUW0Itpvw+nJqd7uHxwh8qakyul+GPrx3kb4ZBHZa8tibtBuv+ciW9igJjh4g74b7F59nKtnMmC5l/d1pcuL7anXqtIAIUcr3R5U3J0eYEtQ6V+xt9XwAlBp9GIAD4JdiQLWUO8fOUpn2xMFdSOB4RLD120MZQeGj3QpVTFz/N3XQXmIvHDsIa4KMJc+DbWax9uSYolEO0+5TbZ/uAppU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(5023799004)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nq2gMLBor9JVa76h1enato9xMU4vrPTh/b0lYN2sP+j63q0q6HHzvv9+zD4G?=
 =?us-ascii?Q?8d7KCZqTxclr0Es4g6BxQvYKcwhrDElhMNRmmfYLEL4wopl0up4sSCtvSZb5?=
 =?us-ascii?Q?cR9Dlyw+gmaPwJr/U8Hm3aCvNkGoaIOSn+9nG06iKvK/kbOzsGdlmCH+Vs6V?=
 =?us-ascii?Q?v6lZVheZU8mrkEUfcc4IXp8E/Iqi679HG4VdDKn2b0GFYXOFh1gVpzcZyAer?=
 =?us-ascii?Q?sIAAerMVQW3VBFMm64i0EanmZlXS1bCLFp+WA2r0V7FKJxpOiEcemTvEthOG?=
 =?us-ascii?Q?mPbc350lvdXziZsURPsFszGolDpmCB/3sG6pCg/957AZtAPwJFreVYYXzXvJ?=
 =?us-ascii?Q?7gMcWp5DQy6YEtWcz4EqD1komoF+k79YnVFFTUj+ZSpp3C0sDkcZGhWCpByF?=
 =?us-ascii?Q?dXwhS/zqE3Fgpgla1On5tVZZJGhPPisPa2oSxBNd4bqu70kXft+me7fJGZrt?=
 =?us-ascii?Q?ePbC8eRbQ1ksyKxstxLU3p+C5RGM8ffCzjqWNLIAcfea1wAjicwRcbe0rA3v?=
 =?us-ascii?Q?M37S/ajcvg+dJL03+eWeu9/n+5EOuac/n73sXV/ZAqa0rkFHYTSLj5L9NPWx?=
 =?us-ascii?Q?iY0uPniUoF+u0l2xcY35uh9D2X5COpdREEnyOsstY8K261gjHPSw+eI1hm6E?=
 =?us-ascii?Q?uY4F3ujGrEnsPCBf7yzqfDa9PvUvYu0MEphaE1RIB50C83JnYCKFqaDYdYQg?=
 =?us-ascii?Q?Np40B+zs+0yOo4xYZ8eiTx1eG2OlaMfmgv3SX2YAALtKnnSFPq+CWhL18B1P?=
 =?us-ascii?Q?H7vb2YYSaQJjf9hZ27si8lSjH9kIlST3AmzQHg4XEwJ82Cdc+w/um8b5Hess?=
 =?us-ascii?Q?jo0wXAiGw4WqgsdFDF1HIlWeUPNmfBSpP60A659Q4z1tRC0uqXcOsfxsrCgM?=
 =?us-ascii?Q?gZxOCkw54F/m79x/o7acbjmFB+AKnsj7d9dq248NzK3ZSrBYjyZkDPwgnQWj?=
 =?us-ascii?Q?cDIFG/C+Zd8Uflqgm0aqSw0eJhQR2P+X9RVKVbd46WP/3eouYda7gdBUqJc/?=
 =?us-ascii?Q?Xi4MyPBwIF1jPL9QKORXPZ/dWjMP0n/Zi5HUZxXxEgBeaofyI7xytSxCnmBr?=
 =?us-ascii?Q?ObO3QEJPYZfSafV1MeuzDI6hhbo+GogcAhlf8DJzpaKftMgkdQ5x4VbN7CAl?=
 =?us-ascii?Q?WX48l78CDs2nEo9jcuRJdOWu7k2uUkx8NoWUq4j63H72e1QKGCZTxUXjrUiL?=
 =?us-ascii?Q?IGphPMmoH74T5XP1AfB5bIwgH8NJypp6f61laeJco8Gk9U1KVCz8o+V230g/?=
 =?us-ascii?Q?WDyy8/SK0/jdunGOvvvi340K7KiPZy49IHLi7czLND18Fi/1WqsDFMOXRGvu?=
 =?us-ascii?Q?qujyYACWMTufA2xZDEAXUBCggtKGqfsZVDPwd5JMxPSG7uJ39jjdBZggbD+a?=
 =?us-ascii?Q?5SbQRN3zyb2cgEG3EY3Fmpy3wz2bIqB8xUq+YC/wKh0bl50JLDPpAowu2+a8?=
 =?us-ascii?Q?5ut8ctOt8WkNHdJzugR3dMEXMWBuVTNsPqnYOg0GRerKzIU0E1fg0mfgxL9S?=
 =?us-ascii?Q?P/P7nCTIKuan95S7wfpaHBjz59c/lHQqSKRD7Dmj8b7wk31XmwTQfCSMv1Jy?=
 =?us-ascii?Q?RtemLVG7uaqe453z6l9WKbWLrOUYTCu1lSPw3e1jQKI3cScwuy4TdtikCyeT?=
 =?us-ascii?Q?9Js5odWqM+ET5adtREZZsTD2qNevmfV2we25kyN25Ig7EosrAZE1vWJqoT9G?=
 =?us-ascii?Q?gKfG6NermxtFRz4fH7e53uynikIPFJY4SXd3nVq9w5iC1N+RCdp9MYUiKeVE?=
 =?us-ascii?Q?R8J5yNDRCg=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619a0f78-a9c4-421b-d331-08deec167dd7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:37:27.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5GvqP9+jXEOfnPNyXZfJyGapkaiHQnvBbsaO46x/qxWznxdUg/SQ/RhCKOJWf8ioPF+M1cNOR/ApNkyGVCwBLcbqT/D6o6sDeFe1oaXXZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB8726

A hotplug bridge may request a window with required size 0 plus
add_size headroom.  For example, the PCI core speculatively requests
a non-prefetchable MMIO reserve for a hotplug bridge even when no
downstream BAR currently requires that space.

reassign_resources_sorted() temporarily grows an unassigned resource
from its required size to the required size plus add_size.  If
pci_assign_resource() fails, the failure is ignored because the
additional space is optional, but the error path does not restore
start/end, so the resource is left unassigned at the enlarged size.

Since commit 96336ec70264 ("PCI: Perform reset_resource() and build
fail list in sync"), the __assign_resources_sorted() out path
unconditionally adds every remaining unassigned resource to fail_head.
The headroom-enlarged window is therefore reported as though a required
resource failed.

pci_assign_unassigned_bridge_resources() interprets the non-empty
fail_head as grounds for another assignment round.  On a system whose
< 4GB root-bus MMIO aperture [mem 0xe6000000-0xe68fffff] was already
fully allocated, hotplugging an endpoint that needs only a 64-bit
prefetchable BAR produces:

  pci 0000:08:00.0: BAR 0 [mem 0x00000000-0x7fffffff 64bit pref]
  pcieport 0000:00:03.5: bridge window [mem size 0x00200000]: can't assign; no space
  pcieport 0000:00:03.5: bridge window [mem size 0x00200000]: failed to assign
  pci 0000:08:00.0: BAR 0 [mem 0x700000000-0x77fffffff 64bit pref]: assigned
  PCI: No. 2 try to assign unassigned res
  release child resource [mem 0xe6800000-0xe681ffff]     <- igb BAR 0
  release child resource [mem 0xe6820000-0xe6823fff]     <- igb BAR 3
  pcieport 0000:00:01.3: bridge window [mem 0xe6800000-0xe68fffff]: releasing
  pcieport 0000:00:03.2: bridge window [mem 0xe6600000-0xe67fffff]: releasing
  pcieport 0000:00:07.1: bridge window [mem 0xe6300000-0xe65fffff]: releasing
  [ ... 30 further child resources released below 00:08.1 ... ]
  pcieport 0000:00:08.1: bridge window [mem 0xe6000000-0xe62fffff]: releasing
  pcieport 0000:00:03.5: bridge window [mem 0xe6000000-0xe61fffff]: assigned
  igb 0000:02:00.0 mgmt: PCIe link lost
  igb: Failed to read reg 0xc030!

The endpoint's required BAR was assigned in the first pass; only the
zero-required-size reserve failed.  In the second pass,
pci_prepare_next_assign_round() selects the window of the failing
bridge's parent bus, here the root bus, and releases it with
whole_subtree.  That drops every non-prefetchable window on bus 00 and,
via release_child_resources(), every BAR below them, and
pci_setup_one_bridge_window() reprograms each bridge so the MMIO stops
immediately.  Bound drivers are not notified.

The reassignment that follows is scoped to the hotplugged bridge, so the
released sibling windows and BARs are never restored.  The pass does not
fail: it succeeds in giving 00:03.5 a 2MB window that no device
requested, at the cost of the running igb.

Save the required size before attempting the optional allocation and
restore it when that allocation fails.  A window with no required part
is then left at size 0.  In the out path, only report unassigned
resources that have non-zero size.  A zero-sized resource requests
nothing and cannot have failed; assign_requested_resources_sorted()
skips such resources rather than attempting them, and releasing
upstream windows to make room for zero bytes cannot help.

Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
Changes in v2:
- In the out path, drop the !pci_resource_is_optional() check and keep only
  the zero-size one; it also covered IOV BARs and disabled ROMs, which have
  a real requested size (Ilpo).
- Drop the Fixes: 2499f5348431 tag; the zero-size window was never covered
  by the ROM exception that commit removed.
- Show the full second assignment pass in the commit message (Ilpo).
- Reword the commit message and code comments; no functional change.

Link to v1:
https://lore.kernel.org/linux-pci/20260717180029.1829888-1-anthony.pighin@nokia.com/

 drivers/pci/setup-bus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c0a949f2c995..7dd662941e67 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -450,12 +450,18 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
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
+				 * Restore the required size; the failed
+				 * attempt left the range enlarged.
+				 */
+				resource_set_range(res, align, req_size);
 			}
 		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
 			res->flags |= add_res->flags &
@@ -743,7 +749,12 @@ static void __assign_resources_sorted(struct list_head *head,
 		if (resource_assigned(res))
 			continue;
 
-		if (fail_head) {
+		/*
+		 * A zero-sized resource requests nothing, so it cannot
+		 * have failed.  Reporting it would only trigger a
+		 * pointless release/retry round.
+		 */
+		if (fail_head && resource_size(res)) {
 			pci_dev_res_add_to_list(fail_head, dev, res,
 						0 /* don't care */,
 						0 /* don't care */);
-- 
2.43.0

