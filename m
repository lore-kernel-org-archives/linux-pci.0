Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461235970C;
	Thu, 22 Jan 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070358; cv=fail; b=IoHhWJ1eeoOY3bww6/qy9yO6Ljs36JNseb8Yoi0ViPfHNN609R1h6/Cohzo5ayb114b6fbr6wY5n0OX5ZTKkJblnNF556kiuite8lo+A35wvKKyX+U3X42HBOdI7/v75bCC8KK6ERHgrxDesVL7AVQTcOx3W6OXkXXv9t/r79Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070358; c=relaxed/simple;
	bh=i8j2mtNQyXT3MwjovMzzRn0Vkjz5WynoSqX9MW3e5yY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X2ncvtLCu0kkzr1VBB5jagOEwp3ulOu5YfSXogBbsiysOengXZeCapdoTl3nrYt7E+tA6QeisNfg6DOOZ2jZFLbS1BkbSfnweeU+copDDguaFO/0LYKrf6Qu6SE2aOaf6AiPSORWh87zPScfy64pXQywKc+AFGbnJrTvwYIW930=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ppkHIm5f; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ppkHIm5f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxS5Hz4NMooeOJNcvJtqqiMdiyjtDOsQ8WLNgKi6V+JjlkefJfnWHsWy/+8e0/rAAZGnK6+Kk2P0pqCd12TaNqOxyqJYZ4/lM+hq1K6lxFiPWUx5U0AwflV6kZVv8EPRGEok8SrWbkfcELCLsqO5lN0oYH3y9k6vmYXZoGcm2Yfay5A52EuSyVICTTsLH9P9Hpex5IOiBiVyJ0KWcpyNsbE3e9aDodcAiR7mApc9VPZJWz4sHch1qUckzxxkriAxIWCdXRwA3vHa8QWE4DB2HQkjHb9uKYR3QCaTXYdmrwL4O4kSYSMH3h1G/hOGxvfGF0GGycfOjLLvG+98YEuQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQhMA9ife8fIfeK95HrxTaeyZDgacK4Xjs+1ixsz68A=;
 b=Xp8SFhnuytd4zQEWrbIFFHT9qmV8pKnZMDW5Gr/pvaV91lSVecKCSlK/JKEfqyi3qPjY5xcSG+KX/abFGuyXqG1kS47b+nXfLN/2+qnUvM5vgiiH4uIXfAIqUu0UYdJEBHhsVIyEO1km4mIP09l92Aoae2LKsu7wnsaRFvOBTVLOIV4gq6KxdMcRYZ3IWwrG57OVNCu+3XiLJ7yteam7fciedrF5RNrfK4VtY1Q1VFyzCvEjKL9aDz/xNF75pOuKTD7X83v8n5XHS++fwKB/kIjNDx2P/BjvR77OAAHeG4LhSaaE6WMWXo/CQkq7M2eFdWaSfa4z58tUcf0NpJkn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQhMA9ife8fIfeK95HrxTaeyZDgacK4Xjs+1ixsz68A=;
 b=ppkHIm5f/JuPN5epAc7+xGWOSTYj38cAPwpXUmiLINfwqRGhYcxDQtwfebBLNWA3vsQg/e/TFDzWGNOxtPjsU+nyAwHvWKDH9Qw9VDQUjoBNaeiTA+14Dwgx+cknTQ6HtWYBNaXWy1dYXw5jBZ7mOdgFRjlF1CIhZDxwGkTc2/k=
Received: from CH2PR12CA0030.namprd12.prod.outlook.com (2603:10b6:610:57::40)
 by DS4PR10MB997771.namprd10.prod.outlook.com (2603:10b6:8:34b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 08:25:53 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::6b) by CH2PR12CA0030.outlook.office365.com
 (2603:10b6:610:57::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 08:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 08:25:51 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:25:49 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:25:48 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 02:25:48 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M8Pi0F125446;
	Thu, 22 Jan 2026 02:25:45 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v2 0/3] PCI: dwc: ep: Enhance multi-function endpoint support
Date: Thu, 22 Jan 2026 13:55:35 +0530
Message-ID: <20260122082538.309122-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS4PR10MB997771:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac09b90-99b1-46e3-1f3e-08de598fdab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jbNfRdPgtnp68kXgXgTbZWf1npGH8/og+5fFEPEAld/GVQgY/BPl55eL7jMq?=
 =?us-ascii?Q?Cv/Z/VzT1uXPQwrKU/GkG1pe16l2jOqnYr6yQJNkEk+LPXO5UHScBNKFusIU?=
 =?us-ascii?Q?ejkhPl7mcGhQMRSTXD3i/4n3qWphQe6QKG856p1SaNdHr9ePntvrL/rHcVjP?=
 =?us-ascii?Q?1KGC8lxb5Kl8YgybhQT7CezBW7hLGfl6ZHOnuH3xlsGv9XPKouQi0iRBdKdz?=
 =?us-ascii?Q?/SyUZLToCF2p05ZwMIFNISzklz40dCCb9G2gtBjSm94dEcQpmJa4H3YxpgZY?=
 =?us-ascii?Q?e1HoN9SAPwwlgT6MAEcZ1IpHf9JdhVYEJQIgRarOz+5dYzoPVvvSaVeyzh7Z?=
 =?us-ascii?Q?hEUnUjtgCnG3tpggXqshuogAOS8ww4at8+s+FAs/RZHInzZjeRy319pyz5ck?=
 =?us-ascii?Q?EsWV1fozh+xZhS/NIWX6S7yl4oJ3XTy2q168etWdbbR6ovGTjF6yy3Purzkc?=
 =?us-ascii?Q?ktwnXIV5WvVZq8ugcT0NSvqzU1noVLQE4a9VGSbvCNuGiqir5+gaWBGAQ2n9?=
 =?us-ascii?Q?1XuqdLwW2XbKHbKVr67Mms2JmVGGWWE38SmdnK1BRTgOUjPeEWz3zsgrwxOs?=
 =?us-ascii?Q?I0NidL7P5kjrOgBVXq7pGvo4DaW0iAIdHJWrlGhpb2nUuPoHkuEjDaIzQRlQ?=
 =?us-ascii?Q?AK4CVcRtfN/MU2++GMhXrWKPUIGAXxpvAEAOt095TQl+WEtqOSZQqKv3vjk5?=
 =?us-ascii?Q?QLFo3LedpesBPkBph1ccdmOjtfCpeMkyhiPyDh5c7uIaxZB9DEOBBh1Xb4g8?=
 =?us-ascii?Q?GyWvuTyi+HOGLL2g2Gpz8BZ9gmE/l4xQwnagimfs4/SlyFJbA42+ZIGIZZ6G?=
 =?us-ascii?Q?bD+67DsEChfKgK+gq3DvFmLxIy976qeJb/fONBVSyCLXRXXaEN0sGU9CphMJ?=
 =?us-ascii?Q?BBLbl3Od6ws3MeLzn+VM9tADM5GgVqxYpK3v3gsOX4GUVPQbb5ezgMVAAcvi?=
 =?us-ascii?Q?RxNauacqlpG61gliyCQ/QXNZuafpJGAXDM6ZkXemxdvcP9kb8lY/qG+oJ3yZ?=
 =?us-ascii?Q?ciByQDWB0NxXRdddxmi84EXpEw/V1W9XDwU4CJ5e7s42WlTE/bEpNw1UWdjo?=
 =?us-ascii?Q?mfP110R6H5VzR3xkE5iYzMA7dCN0yS3QUYk1g1ZRu3tbDkA+VLMYc08I0+5C?=
 =?us-ascii?Q?fP5XNEe4RDHZze5KgaxzWac+zNrXO9o3Wn7mgjvGw+06LXPlde+EozQ4PYyJ?=
 =?us-ascii?Q?rEAjfd3QNWflnXFfVzu00gh0gxPKhlfcQzktMX4aZr4s+eDE/tbRr/IrHCy2?=
 =?us-ascii?Q?m99fuG1Xb6ymfmuwPP78tfpHQeOajgg7W+DW9B5k05fcXuuyJkmeR89clZZN?=
 =?us-ascii?Q?LRMhaaO2x0/KMdPfuRwLbBnqohvCcWHG6yb64pmus6oR88crc+kC2IdnnYjB?=
 =?us-ascii?Q?7MVIZLo3+ATnCWUAsL5U/yIDTpLXrzwRQSAFI0EZoSnfjeIA9Oj3v+IxjQHN?=
 =?us-ascii?Q?/sIDAh6RY3eYIvWeewa9bQLFg8EFF4cxyGOtd6fr8G97wxjWaiAGvlBlVmkv?=
 =?us-ascii?Q?s0XFpCKuisH7UfDfRiaxjdYkvGnYQBbUCKM7T/lDHqe8/vDez1ECeLS712Bm?=
 =?us-ascii?Q?ohdSTfzidXVRdn7IvGuBXd1qQWXsMPwA3oxQQ68N0PeHAvVTvC4g39Lqfprh?=
 =?us-ascii?Q?fdh+HIfBvpRGU+cg22A4MI80c3F3lxYMEywnkPydHSjXn57oJHW7/RPyqB3H?=
 =?us-ascii?Q?3Lr00Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:25:51.6913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac09b90-99b1-46e3-1f3e-08de598fdab9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997771

This series addresses multi-function endpoint configuration issues in
the DWC PCIe controller driver. The changes enable proper operations
for physical functions and enhance the multi-function endpoint support.

Link to v1:
https://lore.kernel.org/all/20260121054214.274429-1-a-garg7@ti.com/

Changes from v1 to v2:
- Fixed the minor nits in the patches
- Added a new patch in the series to address PTM capability access

Aksh Garg (3):
  PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
  PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
  PCI: dwc: ep: Add comment explaining controller-level PTM access

 .../pci/controller/dwc/pcie-designware-ep.c   | 103 ++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |   4 +-
 2 files changed, 73 insertions(+), 34 deletions(-)

-- 
2.34.1

