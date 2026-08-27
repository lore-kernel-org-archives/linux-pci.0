Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769321FC0;
	Thu, 27 Aug 2026 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854821; cv=fail; b=oCv/+5NP/dr/Z0eONNJznFOQx6eWgvBlQE1C03hjvcFVxoXwBu5UrhUf1j+FomNghCL7kyA0TNavXl+vvM8X7IO9NJdn5si3c0x3m+CBagaqymaW0j55Cq0bzhmm+L+k9zFvnLAoeLkSyK7PGU8+nLc5U2UQii+Kq9M+d6BOsiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854821; c=relaxed/simple;
	bh=Eb0WS7xauodEiwC2j+Q1ows3QncPjHHsDqlMgWM6l30=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CVkF6Wlg7bUnXnIeGFL7Zb+kEbgNyHDLx94KDP21KxafemKZYtZXrXiT4wxYDBxLbjCc/Kj9ROQnxtxZ4csio/M7f+NZ2rsfdNwCnDQKo/whGyEHldEXOcAaeex0HCxz2qbR8teEQ0JXSxY3BqQlo5c6+zWF+Z4/E4xPbO3wB+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cTufV9/k; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cTufV9/k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yxd6xJ1yV4iPey3i8JWgDZwzvJ+0tatUd4hirVvhDBzQv0MtW9JTCRP84lDbHd55ENbcZMKLWCNVm9kZ9G8go0+rcDZc4zADakDdRavBYuB1bLNWTyvEsQH5LGas2eOIQDY8EWdPLZkVqQJEe5PF9dXQSh9ESPVMTiVITYa99EdCQ44OvJkt5SEovjF5xKtX+b7h4KjUpGkSy6jo9CVoouj/siR+hmM/nY5KRsgc5wVnRwB1luvsaoxQNzvTuSFvD0NlhFRefBA3f3J7bTwEtHCv9WkI9lzO6NoUIbxk3H0s+chtIiCOC8Eq/B+o/ylUL1bchDpa+aY2RWQSn5yaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Amk/g69dKSZ62AmVoLw01upQSeTzbEdoBFyVAy4PZG8=;
 b=nVZ8Sj1qJol8cvF5+yFKPvnM2FyrQ7OWvaks6WkU7nrAIJAS0l5PjKR1ss8LsT5D1XLB0c4WbsLykIgd2nO8x29F0PnN+TtlqvNeT5498nG1nsGGs9fuB43dKGXd5v/LvDPPUBJHqnmd0t0EaoK5W6r5H/v6W9ERHM6Ap6FRTX0q5ZZeHi4CJ3LKiPNY9LlX6q4hjwu1m9MzMSd2EQ5O7nsi02GKegDMMW4h2qr27LgieoKvl4asF7jB0PHGf7D6IXI/uZE5sU9P/i/h1OOtmUeh6P9LgzrCXXqaO8kAsXiYHUmpZ0yquocE0Y687C26o5zb3etI/Rk1Tu7R6fSJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amk/g69dKSZ62AmVoLw01upQSeTzbEdoBFyVAy4PZG8=;
 b=cTufV9/keon3UgciQgOHLFYO4DrvlFThJnO83bS1eLzgxp1AiYtqBMKSkbENZ0IvOW1FAxemoVSa77tzmena0RxLKdzqdv9/bnXGCP4kmHqct3aWzdiNxkY+FXqc3ULVtf/JMyJ43kadSq4AFwfObdltYDFivmXj6si5zlXf0Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7058.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:20:17 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 18:20:17 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Aksh Garg <a-garg7@ti.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	ntb@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI: endpoint: Support hardware-owned MSI-X table and PBA
Date: Fri, 28 Aug 2026 03:20:09 +0900
Message-ID: <20260827182012.1984960-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3e38cd-fcb2-41ac-773a-08df0467d89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|6133799003|10067099003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	PrQ/CiwxFRII8a5kSZ3FcPbbMcPfFwS0Q7mj44quei+mNyb+D+M0m0Fbz8l/ZU4lqNEP1t+Hk/4ySk0MZgzVh11D7e49MVCc31tGx65481UGxLELlunJUdPVJqu7MY82vSHki85jZSP+VB/iuiOrRlJ3QPn+ytvWtvLiwmsKzBbAAb4t1VcUY/5DLZU4kzFsURUYOLwPx66OV86Vkq40QXLy4E54m0auJlcKwGDs3mPpUY+l0aIfZe/XNUUVIu63eGsFfm49KUzWilzzXcwm1eMKjWZ4cZkM33u9r7Y2Qmcuoq2oHGB+ln8gzn2dTdNDPbgSCCbSCV58hVpx/0mhrTRpg1m88SE8dIPsq7XzZZyxLkrkf+C6/3hoJaZ9zfMgILd+MQaebW+VG+xPfAfioOpz9GjUTD9YtbUicFQT7wCM+P2HP1HpTTedGh92gcbB4rFxDDB4qN3kQ1MafzbmCDFxAop5NKp+1LTH03tqWzTHhwOW9ldocOLk0Gy1Z64MTgyY/whPuqO2E/vCbn0YGB3nwR+URt9JTubc0uXWlpIOHtXe1a67bSnw+IYDfiENidHa1ma9RX1IowrhYRkwM3hkKy1RGEDXuJbneE8B7YQARDyXz7K46xmCg/Eem3lHEaU1svZ4wegckQbFhF1tf9Xh0Z05WlqXo4kiXpt4644=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMX7YSbnpc++CMHWmq+gCL8ZItYZ2yIuSk/0UmebCQdgofo2W3stNn9EU4Z5?=
 =?us-ascii?Q?n7Rh/bvKMpneCKwejSME96zt7Mh0dY1hw/NzhnnXl20OkTf9kOZHZkdxbIpp?=
 =?us-ascii?Q?0qboLy/8XGVTjg1hvueEgPQO7ZJ9jXAiTQsSRI2pzXVJ81FI+L0AkKb+IfH8?=
 =?us-ascii?Q?CuZrv45ghUkG4AREn3rDHLnurDxNXFY0PsC99cRKn4oYMj6PgH0k3N8A2Qsj?=
 =?us-ascii?Q?YsKNGrOzwRPsJM3wU9FzeUlBMgsWH/WREWoY5+94gIt7uG8tHD6FcwXZQzen?=
 =?us-ascii?Q?OujsAotR6hjiMlIdse6XVw1OZbgVwlxjWXdiCJn1R7fLJPgj5cHUHmIN1fOp?=
 =?us-ascii?Q?rppb7hY/SvN4aWp5rkAEiBlVX2vCXqHxBUGaUwQWJbq3x7JQIdbavLViUnSs?=
 =?us-ascii?Q?VlYzsVyiT5GyqXQwkWMC9Y1w6tUDI7/CFr5kfdWEfia7n6+EYt/F7ByHGoaw?=
 =?us-ascii?Q?eAroKAAXX1IoktQjgKgPnjgUbjydABCqDz7khYsU6q2Q6DOJQT88xx04ba+p?=
 =?us-ascii?Q?xxXIZ7jllJh5XM+EemXgllwoSPr86dznrFkWMB7j8yhTlRsDX5bneyN5l1WI?=
 =?us-ascii?Q?5JDBAMfUMtHdZWnqzzmDhCrvX+MZ2fo4vhbbDyNc/zHD7YczA+k8BUOKbOAX?=
 =?us-ascii?Q?1wL1fuwa+J2qJ3/gJ0Vq7CxgAtwdjgj4yHaS2R1CbcTeblmcPoOZcmxy2r2+?=
 =?us-ascii?Q?hmAls791JIcvsDt8VkbnvQp/HqAXIoyzOBIlzMKNuXTTaww1EWDY/pBSSYey?=
 =?us-ascii?Q?HTLCnRvPMQd7y1JCfS73im1E1rDNOld8fJgHMWYSea/irJzJXVzES2G4XSDu?=
 =?us-ascii?Q?mdMPjxe2231t+NhhnLIe9fJTfGjdR5WVQLVnKBBfA07fqyUL1fTrI7EgBf3l?=
 =?us-ascii?Q?ewOEoSqhesTWKy1By9GeCFrHnVuisxcqcWSOAXcvhKt4NhQWisTuwOBhp2Bw?=
 =?us-ascii?Q?U7hRdwp84Zhw8wJFKt0983jNyK9/Pa4y3kKtHqKgtf8pTnZ9DyekdCIUJqQq?=
 =?us-ascii?Q?yLyASprkdSgbyyWMziBLQwshhBAJNKe/CKfFPw8LK4cnnaARnqFq77Gz6jVI?=
 =?us-ascii?Q?G+5VZ1TVNwIu9zw+vVInUaVH9wFbgAhLkbTlXLtHEiFy+FVsGG4ALnaK7U3b?=
 =?us-ascii?Q?pwhE8QZjb+zb88ETzLSziC5FwnNqpyNap38HuHOh+iC2kSKOF3aF1OTSLDmS?=
 =?us-ascii?Q?y1y4iuAXJkfSfEej4rGc0N4egpnJJ1usMhra29PZ/J2q5Ha7NGhcg76qnwXK?=
 =?us-ascii?Q?ebwzKbfP7rkyA+fclLP+M3/cl8vx53j+rkhrM07ySylW40lesvUxeSeMUHu4?=
 =?us-ascii?Q?Nv5NRyS/oJEJ1a5gzR/W7dJrpiSJ03KVOvBsVjwHCbElzwH4hICcEnpLTBXu?=
 =?us-ascii?Q?tho8Y+OOZYLNM5sw5psWWdovMJCn6kFDK2FdJX5F4C8c1KyXfpsqUPhQ+w52?=
 =?us-ascii?Q?DH5Vpk2ZfKSP6+oBo9njAS29dqIAuBKiWQKCam2v0Ty5T12xghkS1lXKtcIM?=
 =?us-ascii?Q?gM63wFOmvDSUuNgqJfF6Ts9WUzicD3yvmMkcZDguAx3OSxJDbg1oawpfOc+0?=
 =?us-ascii?Q?EbyWmP+I4K2zxMocsC14kG4FwDkvLceuMUnUSRDZpxsWXKL+8Akaa/kSep/C?=
 =?us-ascii?Q?agFIqiu6n1Zn2VxVNQ09dtZzS9GwZcEgdXOnVEyk5nlzqjcoR5H9n73QUtBA?=
 =?us-ascii?Q?kzPoaowqEtHpefwrpSB8loUZtUbLYusnz+lhSxRthjFlBZ2wcN7e74pPM3sa?=
 =?us-ascii?Q?hCVl65DMh8pBOKJBs7Oa4fLn78Jyelnx6ki9e5+lmIacT8fxcmZJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3e38cd-fcb2-41ac-773a-08df0467d89d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:20:17.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAmSSqjsnD4+IOuXqIUSTTXxBeIklR3zkK6HucBWxs+7uCmc/eGH0K4/mIhi4jhImVMnfzA7fKaYhY39BnvhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7058

Hi,

Some DWC endpoint controllers keep the MSI-X Table and PBA at fixed
locations in a reserved BAR. On RK3588, the MSI-X doorbell uses this
hardware-owned layout, as discussed in e.g. [1].

The reserved-region types for the Table and PBA were added with the
Tegra194 description. The MSI-X setup API, however, still takes only the
Table BAR and offset and assumes that the PBA immediately follows it in
the same BAR.

This series passes the complete layout to pci_epc_set_msix() and adds
pci_epc_get_hw_msix_layout() to expose a hardware-owned layout. The core
does not select it automatically. The choice stays with the EPF.

A hardware-owned layout is not a direct replacement for every caller.
pci-epf-ntb, for example, reads host-programmed Table entries from its
own BAR to set up peer outbound mappings.

The series also fixes an interrupt-type mismatch in vNTB. ntb_hw_epf can
select MSI-X, while pci-epf-vntb currently configures and raises only
MSI. On RK3588, selecting the fixed BAR4 layout also selects the DWC
MSI-X doorbell. EPF-owned layouts continue to use the regular path.

In short:

- pci-epf-vntb gains MSI-X support and uses the hardware-owned layout
  when available.
- pci-epf-test, pci-epf-ntb, and the NVMe PCI EPF keep their EPF-owned
  layouts. This avoids unnecessary changes and reduces regression risk.
  They can use a hardware-owned layout later if/when needed.

[1] https://lore.kernel.org/r/aY2q80zeRKSRO21H@fedora

Best regards,
Koichiro


Koichiro Den (3):
  PCI: endpoint: Support hardware-owned MSI-X table and PBA
  PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
  PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

 drivers/nvme/target/pci-epf.c                 |  16 ++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |   9 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  28 ++++-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  28 ++++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  30 +++---
 drivers/pci/endpoint/functions/pci-epf-test.c |  17 +--
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  67 +++++++++---
 drivers/pci/endpoint/pci-epc-core.c           | 102 +++++++++++++++++-
 include/linux/pci-epc.h                       |  25 ++++-
 10 files changed, 266 insertions(+), 57 deletions(-)


base-commit: 0a6f72eda328c773324555491e1ad7f0b0153155
-- 
2.51.0

