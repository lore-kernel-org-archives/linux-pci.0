Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC0377A8E;
	Fri, 14 Aug 2026 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738630; cv=fail; b=df+LS1atsNJpByvKpIkKCby1mHT0SugHqKtRfFEMGrcTI6xIJubbAPBUDzTfeIjahske/YslMQa7Rt4mNGq7s6lO5I0lQMChVLPiJ8r+kZR8YPfBTPIZJ1GfmFkYQHVpay81F0ZPz8ss1sfeP4dAJ1z6SBPh3yBGvdmjiObHy+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738630; c=relaxed/simple;
	bh=tlsupdXxxLlp1ZZK0sxbObDu2EoQCFDoJBRJn3oKay4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVTa6QLYTfb78+XQoukwCprd9bXIEqzavvLoKE1hziJJF0Rv9t0jBj3poO54AlmZZztXfflzPVOrTKVrcBh+NnuKJxv+BXtXHgX7UWwvEiDkROujp/6FiFYDhL1/IuDGVzIA4NQXU8XTefQd4cixbLHR+YcBq7AFNmrOZ9Gy0gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PlZM0yDM; arc=fail smtp.client-ip=52.101.48.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PlZM0yDM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEeAod+vcBIqdX7Lwj+nYsdzO81vl7kgGmzIkmGK9pXeEw56DhY0et9aBRtpAGVi33Abrqg8zP4wedEA5Z6h/dzUs8182xUlUtWn3qhV1oLsHdRpa0SGJbblkEB3yKzaaElieU/xgKXnGwmwBYbpKJrLPQDFH9JUQv9zVGqEiwb5tFdrqs6zzA0WJV2WEFgBLFiHkNN1xrojlaCTLYJS1m7Hl7aMbW8Mechle/wCyYlv8/to/tG0nvpDYkDnywgdBYsq8bfMeH7k/cJmrH7HfcZhcupF6Jj8dD3WvKZlHyduTzDD1PhUEWKKadG/vZVHtDmuV5ZEsszUE/3I6g/Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+6d7NdACKlYCCJBAe2eR9//Eq1Ml5l2qM3poug0m9E=;
 b=Jt0iNIOi4XdL8rrvUtDoUH1qtiMmobKc0jDxMvP70z2D+zhOXYDrBX4ApPaQrRduaB+g2zA72xtZA6H98VxJveAi54QYSOvnukXanx7FFym+wqMH0352b6soSW1gJhsb18nmdBD7m9VUDr/x8FTRshPyCBErmyxrv3kpTG+4jNbVd+yKA7hMJXPGGvhZW1fpsoH5XnpHGCe9Lb2YLQxQ3MzzZCE9IkquMtDz6LWdwpre/37Z6oaPqOxDlHhPrY91s8SL773vnDKOEdu5hDy0wjg2R7YaYJDo+6uuppNYxk57p7BNlAE9vzwDiEyTqKq7BYBDAejGK/7my5IFRtWYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+6d7NdACKlYCCJBAe2eR9//Eq1Ml5l2qM3poug0m9E=;
 b=PlZM0yDMJPvySzHoOATxE/Cowa79eyIAaBbilnFiyzPoEF3GWgj/McX5Kvgmj+iahnQsG8cwVKS1Ip0SZomJ2q8cj7vaRVCgZ4GVC/fMfDh5NFSZhkgr7hvjcyQGUrSOQdZSB1DgDcAlZYJgBdIGJDj6h9dYFGey/UaOkVK+Wb/sfcLlpRrfAIcj/+4rGKXU0n4dRpbM2V0UeoOtk5CLoxX5rkvUJ4qsgHtkVDwdL7fTaqFL97bKY6NYVjVSDkFBCKAxS+EGOGEHAqC9zjtcuRki8vYYa98rPhKd9Gd6l99JOOYzSS2BTpwY6p16rLxwnbo+8Hm3wvUbQjbL4Q1Bgw==
Received: from SA0PR11CA0042.namprd11.prod.outlook.com (2603:10b6:806:d0::17)
 by SAWPR12MB999291.namprd12.prod.outlook.com (2603:10b6:806:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 20:17:04 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::69) by SA0PR11CA0042.outlook.office365.com
 (2603:10b6:806:d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 20:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 20:17:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 14 Aug
 2026 13:16:40 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Aug 2026 13:16:37 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V3 0/5] PCI: Re-evaluate DEV3 14-Bit Tag Requester Enable on link mode changes
Date: Sat, 15 Aug 2026 01:46:16 +0530
Message-ID: <20260814201621.2281245-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SAWPR12MB999291:EE_
X-MS-Office365-Filtering-Correlation-Id: 67114266-cee8-42e6-448d-08defa4101c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|6133799003|56012099006|10067099003|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	2OyR4Kf5evhaE1Z76xWYYrN4ap/V+gF4FZv2OqJymoMvF32aDHg859L+qsci1G0BJnUxy5Fkksy4qVneVihJRpNwE4rXxAc4MK5AP1/fvomXEaLJN4+Iv7OmG7XHHr4mEbSGm342mx5JWXfwQ0rBaaRN9IAwDVKZ0k8A9bzxKNF7rFyoMMU/IMimXT9g43nuCX0pbcFhBWFipyfZ8GrVfvSwmrcwSfa6xoaXkb8dutFTUFvrHlUJ2cNWEtnS9RMZXqEIfd6TpJVjIcS3smP29e+tw61JIch90O0z/D8OFch3YkDB9FNUb7WKTGm0g2yO2/Gd89J+onThXVpWfzIRJqtp/ycrpEyVKUAMuFWoztwyCH4oOVW1qfAA0kEKuNGFCnhSih0KB0GdAcF/vEBv7oScSVxOSKwXU7clC4+Z0ZXg5j670yBdE86glYI2wIjz0leKUHx+grZFVgBMRwksnwPoOBmMh8FaFpPdrshfqZPkjT401fYLEG0GOVJAhoB/7dpV4y+TPkt/uLCQw+ckJejpil4LVEqWkB+pAKJWezDh/udrrWS9GEgaKooeXe4vCw0+KKj1xKUMVNUU91uK7rrzJm1xRbEs8UNetJ25nPm9jzv/groYh/ZnUHngwPxApLVSYI9PCF1OW6zG3s65S1eJBS+boy0naefqRpq40cVgrtSAVbHdSIxOgj90iBRbkWdjve51sI79fZF9cqDM+w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wKkUlwqHywovRcQfKIzG5q2cvyKklr+kQo/gIXcEJOD/98OqziLMk/TY1hTwFhcJGggVSl9+zIG7th0i8o7/Xx1FMeKUrCmuKa3tB4sT5jHvO/9WgFETzs8+8vQ+fmNUdQq1QvRemhCaPDSBxVO0I9aG74ua4y+rXBkxHsOlLgVcmytrLHjODv2+kyvkbVqwjhec1BWtLk5YE499EjMBvlAnXA3dtBDDhcurAbJQ6XKljp1nAfk0r0vSUy18W3sioLdb1sC35QkDn5oZgiRuSQTkPKh6TZSgKhYMRtnPXU/8nhvbpKqMdmOkz3jBD8pibsX38AwwiD6bd7RdZLa1bEjjph6/cuzReQQzE3MF2l4dVa7Z7qGpqGo8ax7+HxypFoM04bxW1qbjXlNFNul14QqNxGl0Mma8vFPKuB8rsR8vkxflHA4/OBbkuq9W90Tx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:17:04.0667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67114266-cee8-42e6-448d-08defa4101c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999291

DEV3_CTL.14-Bit Tag Requester Enable is only meaningful while the link
operates in Flit Mode.  In Non-Flit Mode the upper tag bits are not
transmitted on the wire, so a requester that still has it set emits
requests whose completions it can no longer match: the completer does
answer, but the completion comes back with the upper tag bits zero.  The
requester therefore logs an Unexpected Completion for it and, once the
timer expires, a Completion Timeout as well.  The completer side needs no
handling, since a completer only reflects the Tag field of the request it
answers and the spec accordingly defines no completer enable.

This happens today on the very first config read a Port issues after the
link below it comes back in a different mode, and there are two ways to
get there: a reset of any flavour, and a hot swap that replaces a card
whose link ran in Flit Mode with one that trains in Non-Flit Mode.  Two
things are missing in the core:

  - DEV3_CTL is not part of the state the core saves and restores, so its
    contents are lost across a reset even for the devices that do get
    saved and restored, and

  - nothing re-evaluates the 14-Bit Tag Requester Enable when the link
    mode changes.  This matters most for the Port: it is the requester for
    the config read the core issues to the device below as soon as the
    link is back, but it is not itself saved and restored on these paths,
    so it keeps its stale enable.

The series:

  1/5 adds the DEV3_CAP.14-Bit Tag Requester Supported and
      DEV3_CTL.14-Bit Tag Requester Enable definitions, both bit 2 of
      their respective register.

  2/5 moves __pcie_update_link_speed() out of line, which 4/5 needs.  Pure
      refactor.

  3/5 saves DEV3_CTL and, on restore, drops 14-Bit Tag Requester Enable
      from the value written to hardware when the live LNKSTA2.Flit_Mode
      and DEV3_STA.Segment Captured say Flit Mode is gone.  This covers the
      devices reached via pci_dev_restore().  No other DEV3_CTL bit is
      modified.

  4/5 adds pci_bridge_refresh_14bit_tag(), which fixes the bridge itself
      and then walks its subordinate bus, and calls it from
      pci_bridge_wait_for_secondary_bus() (before the first downstream
      config read after SBR, DPC release, AER bus reset, slot reset or a
      bridge D3cold->D0 resume) and from __pcie_update_link_speed() (which
      covers retrain, bwctrl and hotplug paths that never reach
      pci_bridge_wait_for_secondary_bus()).

  5/5 calls it from pciehp_check_link_status() as well.  A surprise hot
      swap resets nothing and the new card has no saved state, so the only
      thing standing between the Port and a failed enumeration is a fixup
      before pci_bus_check_dev() probes the card.

3/5 and 4/5 are independent of each other; each is useful on its own.

One deliberate asymmetry: the helper only ever clears the enable, it never
sets it.  That matches how the core treats 10-Bit Tags, which it also never
enables on its own, and it means a Port that has been through a Non-Flit
link does not get 14-Bit Tags back when a Flit Mode card is plugged in
later.  Restoring that automatically needs a policy for checking every
completer below the Port, which seems better left to a separate series.
The saved DEV3_CTL value is deliberately left untouched in 3/5 so that the
originally programmed value remains available if we do want it back.

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

V3:
* Add patch-5 to handle hot-swap scenario

V2:
* Split the V1 monolithic patch into 4 patches

Vidya Sagar (5):
  PCI: Add DEV3 14-Bit Tag Requester register definitions
  PCI: Move __pcie_update_link_speed() out of line
  PCI: Save and restore the Device 3 Control register
  PCI: Clear stale 14-Bit Tag Requester Enable when a link leaves Flit
    Mode
  PCI: pciehp: Clear stale 14-Bit Tag Requester Enable on hot add

 drivers/pci/hotplug/pciehp_hpc.c |   8 ++
 drivers/pci/pci.c                | 211 +++++++++++++++++++++++++++++++
 drivers/pci/pci.h                |  17 +--
 drivers/pci/probe.c              |  36 ++++++
 include/uapi/linux/pci_regs.h    |   2 +
 5 files changed, 262 insertions(+), 12 deletions(-)

-- 
2.43.0

