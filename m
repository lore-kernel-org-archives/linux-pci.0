Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795083265;
	b=4WgRtyUmkmvpPouCDmgjOjT/a48kIwRzLK9wW7P9VxY5ygDF/3jYf7BJjX1TgN6I7t2q
	 KJs2W0b2MU9qOZ8QafwnEJGducjbn8YqYYCp8/IMo7Y9x4FRGRjnXKoH9eHdMXTD4OQf5
	 TVEUbqYZ9n6m8PX4ofm00epncLdqvr2Weldptzd5yNiiaGje/G6SjJYK6p2DvtWDdvlzY
	 Vc+NUt5aCxn+8yUBuEDcA6kFzXp8qzV9ytjmd7NKEIbeKsYpiLQQRUIlwjkpWFDpJgjXi
	 fHrAZ3xVff3Tiz4R+6UbgGHqmdKz9OJ0Q7Pq0Ac33UYT8O3tIAvNZsr75w0J+K+/tIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083265;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-NVConfidentiality:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ksOX6doNP59GQgUFxRxhES0lF8Jz6uuU2ZiF1x8fd/w=;
	b=QFcgijIFZ6yaEe90Psvqy643g3QTLIw+yAEcIkeWNSoVzGHpKqek//PRnJL2vxha27ER
	 V3fcBpStcadB6AMwfTKsvtbjRwDM9YkwcWaMZ0PZF4eB3JYSGHhJ56j22oWfMrdlGRBKY
	 jJaDQUkprXB42lHhc+7sU4rNRBMDvcPZgxXUuIKOsvabTveQTNA3wnEEfQXWRA58THhpd
	 7BkTQCgDoBMx+cNn9C9a9YKdrdPTSQ7wSrpjBnlXLY4BIK8bRGtWXvSY3X4OereT+utSg
	 pz0W6MZFLvgpZBL4KTmFCoKm9r75i6VYfxrmuCpWVmJemDVX5kr9KMlJ7wzkHM/3/Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JoCnALUT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.28
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACB606A324;
	Thu, 19 Nov 2026 10:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0ACB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JoCnALUT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg426+MGhTf7XuYSxCyJQ/M8vUQ3RPWgm3m3WU4DNXcuY79SjSruzPH5HiMxKq2UVKe8JbS8QXC6xwusO81/5kU8RsIW8wWre2JPr+6uicnGVG5oCAlqsp+dFQjerJc6X5aNWHDsmvahfNPD4AgJf1c6ebeOC/qaCAemQ1erIcb/5YfUw0LqSv6mTvKyKEBrDMkWQiG8UpFhcNbqCfIxm1g2Hcdd6Kae9Dh8Pv29Tg6jS2gxN/DrhpASjsIxnpjA4JnkTYqrL6G0w2ka0BE1479nB4+1tA5CLBxoDm+JGZpsQCGuo0ic9EBuE+3N0cJLvMTmYSoNmmHjkTY3ii+EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksOX6doNP59GQgUFxRxhES0lF8Jz6uuU2ZiF1x8fd/w=;
 b=g5Sjp+doCuP6Jgc4uJwvBAeRP3aKwuqcFYkowKm/7KrHPjXV/7pbVQDNOucG9vNuxQM67ca7c1ud6oAED+GOl1jw4w1DtWrEm0b/LCY9cHugiG17eEVMMXsvVg1sRbD0lsobmRQrTiU5HB9HTIwyyUREKkfUMG/rEZ4X9k/w7e2DvujJmCfL5ml5ixfGqjEqhanFu4SrKTast/o6JtHdcJilNAAqy1z7zpBB37eQq3qUM/rjMQLI9dDGNpM8Chwn2jb/0DQrkWXu6IdFunqI+zdaoU4hCpkKoz1yH9tOsgVOTGiKSiyaZ6cwdAhLZ5oN6fWzRj6xlWE7hwQ6z98XyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksOX6doNP59GQgUFxRxhES0lF8Jz6uuU2ZiF1x8fd/w=;
 b=JoCnALUTGlVOxhaSfJSmv6goYmYJKvczDkVb9CJiDlFF3u3er/o5CN7+5UEZ41r4mspEnX6pb73xWLKdX/YHAHJ5pKsHbcnM35GfQsyhjfGurlvgxsxreShMX0aFaxM4lhepVxeySmexEKkYguIwANU2eq8O+jRvRP4nYtiwmBeTWcXyMKS7SGkXmr701SasGBENoz2J8WwA5YO2/CM4KY8s4eI+Ev43ATYbbmzg7a59T7SSkpu1kFf+RzUYWhrySwmMpcj3z7AYTOEjc1250phDqg2BY6YYtiy2JYUSHJCf38rr26zLZVp2ISrftgpujwJcy/nkjKJRd3i4dRFOhg==
Received: from CY5PR14CA0028.namprd14.prod.outlook.com (2603:10b6:930:2::29)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 10:07:15 +0000
Received: from CY5PEPF00000E88.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::1f) by CY5PR14CA0028.outlook.office365.com
 (2603:10b6:930:2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 10:07:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY5PEPF00000E88.mail.protection.outlook.com (10.167.247.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:07:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:07:00 -0800
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 02:06:54 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Joerg Roedel <joerg.roedel@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, "Nicolin Chen" <nicolinc@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
CC: <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
	<kumarahul@nvidia.com>, <sagar.tv@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH V1 0/4] PCI: Don't list reset methods that can't reset the device
Date: Thu, 19 Nov 2026 15:36:24 +0530
Message-ID: <20261119100628.1948990-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E88:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a509b49-e7b7-4d9a-64ba-08df4624e33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700016|23010399003|261022075727099003|261021123027099003|10067099003|261021121427099003|56012099006|5023799004|11063799006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	m25vWXnn7+aDFOffmCrZISQZETb0P3sMEoeSLAsfWwRyKux9zErhzxOcgunxZ8MsnokHvHXnxhExdIegAwBxQ8vJFjIYmTtsbsas0f5mJMxvzeRdZz0w76/43nIwpOfXRC2FoieSuP7OHU3LYbULJcDXq34AHF7mbw+P0kkCSio9/k69W0FQNqGA43sY0vq4T7GqspDd8XqKQ7XOIGbh3Wq3PV7pGh2Pwu75Mf9DaY8o8cBY4AsunV5y3EsljI0MNnOrl6hNbN3ym3ocmMn6H3DyvBZR2k01qU0XhyKRfQUykqIL0uO24FKeK/cqzXgcRaJf9x2L/sN3U6yzVkSMbP0Sh4uL5tj1kNpfIsrZUGJHNBH36aRGpuBGASENMTQawHpuYrZ+rnuIY6egrvnJxIb+/+VQoz/3FhCwJ+IvcSaG3N/wvXBp4a685mcQop6uRrXRgbtGt/4O7Ct/giW96GvYtWKcetCJSrD0vqi8TbEaKesHPP2fhqAQn7fhAER13YhbxWgHKrzvctrTC2RFbMvRibo/rhNFbpPOKAiySnEk04wQm10mltU5vztpvDW89vMhB+3bn73Qm23VyQMu54tcI543ZInPaxEUe9cSGXG096eukDuEOyylKZeXMlYecW4vtY3vAWlGkNOjyn29i+6xCjgaalUeJXsv9RBSdSoCpGCq2kEL7QDH5gVtvvInWWrdDZphLP8/rEU+/iOHzw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(261022075727099003)(261021123027099003)(10067099003)(261021121427099003)(56012099006)(5023799004)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MjhQeZUu7zo5GNlF4cbVoQu8BYe574eADx1fbyAFBToi5CUFfXrybR2u9nzcyeCIOWG6+k39pU/XZDJ8lcnAi5HB6OJus1t2Av7KZ+nrMNer90nrDReXdJnJBZzFuIiSEMS86xn9zK/YEdQngXQLj+n+yMS93AVuRBudg9prke+XVtruGgbAQSddsksU0avVfqVgk2kf6xysPi2ARe9BesUrcM17yW6pTNxmfxBmWhEsrBbLM5e134y5/dzG8RUK/RxvOE+gLSSXiDP4b7Pvs1WHSyXJ/W1oTWUxWZ3tdOFmDuLzAhc8m0m81BMCdYXpcdydR3FCLEufOEgAm0/EoYgfm645v+4XjX4fBQO+WW20WuNG3iEyJJrbCqZ0IsS3GGBaauVwq3v2E09xyVuFe7tNCvScIkV4Di8M1N3qnpU3LCNxDfUtwo/MzXcYdR2f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:07:15.4052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a509b49-e7b7-4d9a-64ba-08df4624e33b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E88.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775

On a 4-function ConnectX-8 below a CXL-capable Root Port that has no
hotplug slot, "reset_method" lists methods that can never reset the
device:

- Every function lists "cxl_bus".  It can be selected, but every reset
  then fails with -ENOTTY, because a Secondary Bus Reset of the Root
  Port would also reset the other functions.

- Function 0 also lists "bus", which the kernel then refuses to select
  ("Unsupported reset method").  Its reset methods are probed while it
  is still alone on its bus, before the other functions are scanned.

Separately, probing "bus" or a device-specific reset runs the IOMMU
reset hooks even though no reset follows.  Reset methods are probed
again on every write to "reset_method", so on a bound, ATS-capable
device behind an IOMMU each such write blocks the device's DMA for a
moment and, on arm-smmu-v3, sends ATC invalidations.

Patch 1 offers "cxl_bus" only where the slot or parent bus reset that it
relies on can reach the device, i.e., under the same conditions as
"bus" except for the CXL SBR mask.  The probe uses the same slot and
parent-bus checks that the "bus" probe has always made, from the same
callers.

Patch 2 skips the IOMMU reset hooks when only probing, as pcie_flr(),
pci_af_flr(), pci_pm_reset() and pci_dev_acpi_reset() already do.

Patch 3 takes the device lock when "reset_method" is written.  A reset,
which already holds that lock, could otherwise walk the list while a
write is replacing it.

Patch 4 re-checks function 0's reset methods at the end of
pci_scan_slot(), once the other functions are on the bus, and drops the
ones that no longer work.  By then device_add() has already created
function 0's "reset_method" file and sent the "add" uevent, so the
re-check only removes methods and keeps the order of the rest, rather
than overwriting a list that userspace may have set.  It holds the
device lock, so a write can't land between reading the list and storing
the result.  It needs the first three patches: without patch 1, function
0 still lists "cxl_bus"; without patch 2, the re-check, which runs after
device_add(), would cycle function 0's IOMMU domains during enumeration;
and without patch 3, writes to "reset_method" don't take the lock.

Patches 1 and 2 have Fixes tags (v6.10 and v7.0).  Patch 2 uses the
helper that patch 1 adds, so a backport of patch 2 needs patch 1 too.
Patches 3 and 4 address long-standing behaviour and have no Fixes tags.

Not covered: "reset_method" of a device that is already added is not
updated when functions appear on its bus later, e.g., VFs or functions
added by a rescan.  Writes to "reset_method" and the reset itself still
check again and refuse a bus reset in that case.

Testing: all four patches were tested on the ConnectX-8 above, applied
incrementally (patch 1, then patches 1-2, then patches 1-4):
- Patch 1: after "echo default", functions 0 and 1 list only "flr".
  Function 0 still lists "flr bus cxl_bus" at boot and refuses both
  "bus" and "cxl_bus", which is what patch 4 addresses.
- Patches 1-2: writing "reset_method" on a function with its driver
  bound no longer runs the IOMMU reset hooks.
- Patches 1-4: function 0 lists only "flr" at boot.  A single-function
  ConnectX-8 below the same kind of Root Port still lists "bus" and
  "cxl_bus".
- Patches 1-4: 100 remove/rescan cycles of the 4-function ConnectX-8,
  with a udev rule writing "flr bus" to function 0's "reset_method" on
  "add", a loop writing the same while function 0 was alone on the bus
  during each rescan, and a loop reading "reset_method" of all
  functions.  Writes landed before the re-check in all 100 cycles,
  function 0 ended every cycle with "flr", and there were no warnings.
  Writing "bus" instead left function 0 with an empty list in all 100
  cycles, i.e., the re-check kept the written list minus "bus".
- Patches 1-4, plus a temporary 200 ms delay in the re-check between
  reading the list and storing the result: 100 remove/rescan cycles,
  each writing "" to function 0's "reset_method" as soon as the last
  function appeared.  Every write waited for the re-check (203-206 ms),
  and function 0 ended every cycle with an empty list.

The analysis, the fixes and the changelogs were drafted with an AI
coding assistant (Claude Opus 5.5), working from logs of these resets
and a reading of drivers/pci.  I reviewed all of it and did the testing
described above.

Vidya Sagar (4):
  PCI/CXL: Don't offer 'cxl_bus' reset where a bus reset can't work
  PCI: Don't run IOMMU reset hooks when only probing reset methods
  PCI/sysfs: Take the device lock when setting reset methods
  PCI: Re-check function 0 reset methods after scanning its slot

 drivers/pci/pci-sysfs.c |  3 ++
 drivers/pci/pci.c       | 65 +++++++++++++++++++++++++++++++++++++----
 drivers/pci/pci.h       |  1 +
 drivers/pci/probe.c     | 16 +++++++++-
 drivers/pci/quirks.c    |  3 ++
 5 files changed, 81 insertions(+), 7 deletions(-)

-- 
2.43.0

