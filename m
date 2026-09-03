Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020092.outbound.protection.outlook.com [52.101.228.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110F430789;
	Thu,  3 Sep 2026 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423904; cv=fail; b=qOddcwlILZUFUA7TGSh6PhP5N2hSoR/58xzTqEVZ0SLQ7g2nB2ni39rdE/NA7HcSAlpJ0ry8UFMBpUAkBkHWMQuVgsssGosjivhm0z6gdvxaSsu3Op29ea3cbbSLys6yJJjZIAh+oovO+L62RWuhSIBguzzB+DAM++diqNk6HUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423904; c=relaxed/simple;
	bh=8YXf/tCv+zHKxx/4aIHzEnpQ3LN1N1B6gA9hK4ugPRk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NmDeAf4e/DcaWuMbAIglwH6jEqaIl4zMKvsgvktaTN43nm4wd64prQmiJy0OeExQM5mJxN6P3xDRA34VFLEgOFK0KZUn/BFEhdkNIufMbeiOwdlnfzX6v5vvad/v/wOM3xHAqXEqpOC9OwW2Wp54px/v5r7Vx5HDZe45ZJap1+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jEfPkzmC; arc=fail smtp.client-ip=52.101.228.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jEfPkzmC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzTuK6ErEZGChecCUPBYc4kLVo1V+pKOgxtzpNP6RgAJn/UwqM1W3/8MgNeft0vR0JPzpG/rhF+F6RSGmlkh95Ln2idPpZxrx4PUaqghJQuO1QNjRtmWCFJVcGhqje6ejht81AadJyKYnBLt+iXlmzMm1fITwizlcmzq40fE7DpE13tXJhJVnb9x7GbXXydUqdFdG1wlxJU49EnM7FKWdbp7WEX0a2hoFWRAPUran0qSMKTpVWEY29iodZdg32W4ewmRkYYIwwFWPyWxePeOIYzRXY42C24JGELo/8e6f5tCqoB+TwQbBSERLCzwHRHQk2dCBIU2TKIDYe2Plu+pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bydudwosZG12++orOQDtidGrEZgP+5N2ejRqER/LeM0=;
 b=yCOwF1rTsUuZ4FI1Enewq2/Ykw3ULTXe4KxLLnyIw7LgGPCD1olFo2yVQQ7OgLdKQRacux/9uVfr3b9hKV/BJIk/avV7NjZk3PYp9Umo2vmOOdOml3v4n5LWu7cnhVgKjU8ZgdgvmGZDUYnwNzBNX6DvbQdVAvHewy3gcZ4xx3CfqVW/tlxxQNVxp2wDHVs5occ4XKJxLeJycqbm30qDrqg7dlopyjZBi17Y+OIjP6WTnkKYcqZXneTxu5GbSWZXnauTDAF66wJQxFpSbhZjkI+n07bOlmRu/NtWizNiGHC/0YRwYGNEAsfG4Kj3YFw/3BtVBazrcVSX5bbtQfbukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bydudwosZG12++orOQDtidGrEZgP+5N2ejRqER/LeM0=;
 b=jEfPkzmCIzwnlJ7Mdr+hZvbyepmywLrsa1CTDlf3zkFX2imy2WhLYxD3O6r+d0BFJO5SAqpTnldkgPTV3F+smZc0wU/aPHnbc9lTcvD2RdwYrk9aXy92LWFOn/XJRRUZfIDHACiWtpg4WSgAyg3EVMiME4DMKoY/Mx9DFAw2Oeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7060.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:24:57 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:24:57 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 0/7] PCI: endpoint: Remote DMA support via vNTB
Date: Thu,  3 Sep 2026 17:23:20 +0900
Message-ID: <20260903082327.2345602-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1fac03-4a90-4452-2c2c-08df0994d6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|6133799003|10067099003|5023799004|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	p6CTOyLKG6ERDjceHijV8t+0Gb5c63ERbhdlgf37cbYaRuXVGX91p8WOKSSpdRxoHUSzpa2agaXlQCYljrpxnaBGazRsvQz2v+2ahxl4UDsVpLZ5F4wykjKEtgloTOdkUOY/hpObiY1Krt6ncFgBKCxheqk9GmeT9dhevsLsPGWSiNVDkvRa3gQHurXUjhTI08H/5tysnJfGovey+jNMFe9MAhVfZRcBVwNPZdxkNG5AKGh9pp95wYmFqZalQ0Ra9UnfzLlvJkfX8BXO6bHumQOb9pkfjIV8HdpFADt6nnt9lKSFpc4Wfx57cEedg0CFhX+qNe5vyRRfTtsL2si8FxJWmsH99m0VYaV1br7hZDwRVa/e4pufD4I1T8AUiQMyPsPQ3XRB2mZ28yMZk6DWxAX1q8EpKttQuB5atvsICdoAFMKenRgbfilvQ+ew1MXO8SlzsgNMPt4hYGsmIOSfGT9Y28cbE3/BDs7YCGX42jh7mhOilwIizuxQgdTpUMbSxrutDfb5qADgyVHIH/QWoFPEK2OufuB0u48iedoam2WgGdKMm6v7U2qJ8OIDFQNron9hwB43hnlIXwNeV5EdP7NCVz7wYyoEnPsLrhC7ZCPCRLuoskgCKXi5sZOr53ai
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(6133799003)(10067099003)(5023799004)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G3N/jw1BJkVAey2CxAA7updQSr7hqpZ/Ucxn1wUdPxP3wgmohXotbqplJ1Qn?=
 =?us-ascii?Q?3w5yUyOAs7NcXvUmueSKA2jp19XWeH0jRgKNOw/r+nJOeREXY+eggOwhoBWL?=
 =?us-ascii?Q?woXSMgNQeEf6wkypRrckHFDXJAc5dT/OGggCycbSVWFNhKsDmeq1r6AFTrVd?=
 =?us-ascii?Q?UpuwUGa7Un89HEPP6OzvQJprEyLUvfexB2b/+MzyXqECw6X9MpSdBDCBEoBv?=
 =?us-ascii?Q?ZLxEQR+i4f4U0+/M7w26vC7lDbKwUyw2Vl5g0vMwFRGN/qd+M1KU2B7ti3hx?=
 =?us-ascii?Q?H6yBgCL6lS56w8pdDmli68czd2/rwoRuVMOFJ7lXcZAWv7DIUslUqukyolon?=
 =?us-ascii?Q?NwjwMO1xyr49IEl537xx2FzlVT0NRhuoBlQtQD448LtWjnxd27Lu0yclUQCA?=
 =?us-ascii?Q?yB1soeveMjGGhVfO4r1dNMMuB3A/zeCB/ovWiZ2nfqSoIyyy9U+SaRip15SE?=
 =?us-ascii?Q?CJNs6PLwwjdv/ha0n3pSIjNLRXXPQ0N19Yrmi595wiiH7rkNW2bmcIIFK6Qo?=
 =?us-ascii?Q?lwpqvtU7FlhdLm1ZPv5gCNgCYlDyXjkEFtRBMLEkOy1uSAd2u5UPUNf9Mwm8?=
 =?us-ascii?Q?ErrRQVO99MUOkd80F7KVgirPxpxrN32RebOcWEGRlSdM0hdvTaPXG1fdQc5F?=
 =?us-ascii?Q?35JdHQRN1NwH351XP32eGM9XKc5Z4Ts16w4d8nUdkFirteyeXxlLCCFHUHqP?=
 =?us-ascii?Q?7ChzAKw1bE5p37fZpjsoaAPBBl/lA4uQK5hujfKyhRpfcqyXjle3il4+sa8J?=
 =?us-ascii?Q?Eq9CREL3OgX/zhd5Aq7oFfR2F8YoVlcnP+M6b5Sb77nF4KW5YSiAnxNakg8M?=
 =?us-ascii?Q?oU/w7LR6XwgQtlc8rENBIGpkRP433A0wUwS/He33sFluGG3hZimQf0jlW8z5?=
 =?us-ascii?Q?xwjxXi3fuDNNskC/hS4MvMObQOKkaguabEifZAMvu7t4TugZjhHCHUQ9X6rp?=
 =?us-ascii?Q?ltMs1eHaiSGRUWorzaL1DsVqpWKVRmffV2TSQKcRBO/ZlMmYRBdX89zjBE4p?=
 =?us-ascii?Q?yY1WbWveGXQPzBCBH4bGOh96IkmNmlu2A6OYolUHyl/VavIyDudZV3x3KNr0?=
 =?us-ascii?Q?m23cXGfsoMvUrqAjaEWTJK3ZSBK16DCB7WsjpJrGQkiYjr2UnT1qf5Gf4rRH?=
 =?us-ascii?Q?iBKa6j5nzY/NHYLctNcVKO8cVLOBcC/NyfspjqAX3Zwd5/Q1MHktx2zW0vCn?=
 =?us-ascii?Q?C1hQSfAC8feknkoxIN+86qNBWaL9Dmt8GSDFkG+aqT3dSqGRNTrB7JQjuyzz?=
 =?us-ascii?Q?GFDkglfp07mqpVPlHPdRQUqnVpV3ziWfzsUhKhcWguV2ydnPVZKgt+CD7nGV?=
 =?us-ascii?Q?vDsBF2Gpuwjaa0ylDIz0U7FSLd37UaO84WPNc9sI8BvDP9WcJ4FMDGKW3Idr?=
 =?us-ascii?Q?ot958Oh+IzCwwFrXyYLu3RQnoDN+J67xvAOS9d7TFND6EvnxsmmszT/+sTV5?=
 =?us-ascii?Q?DsKT31Qdl4B2FNV+5UbDiWzex2xdwaSdfl5mX13azOroiZgAut5xAyPf+bKq?=
 =?us-ascii?Q?bAPpTO+7Rky8w/pg2ARu5lLm6wPennnVqAlpvmcCCKYMy4dZ9Q7xV6l9dfvr?=
 =?us-ascii?Q?rBj7CjPlNOugzgghmHOiEtRYXIQoi9fKShlpOmx9qoA6D5peA0Kvr8tUbYl9?=
 =?us-ascii?Q?jHle+Z5xZ3iX77ulmOhSqRtS9tgcGqqdoj8xXkVfSqniKA7il8iQPksKcJdt?=
 =?us-ascii?Q?tX7YofLZjgq8TNjbIN9+htiIOXqv8iYUTnghkQ2tYGhF+DqOFRoYfsIWYggM?=
 =?us-ascii?Q?I2GIU50ENkeMYL/OQkxsI9GLuYPcqmomyH+2T0sGJmGpJCETiTNp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1fac03-4a90-4452-2c2c-08df0994d6d6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:24:57.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrUiAnMrA8+D/i4qgoVSjGZKnMa+Oqvte/0Y4faB1q/wd1P9LNywywtZxmGVrUfTNwGnvAZGlzCAj9rS0CRIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7060

Hi,

This series lets an RC use endpoint-local DesignWare eDMA read channels
through vNTB. It keeps the export within pci-epf-vntb and ntb_hw_epf
rather than defining a generic remote-DMA ABI or using a separate PCI
DMA function.

On the endpoint, pci-epf-vntb reserves the complete eDMA read direction
and exposes those channels as a group. This version supports unrolled
DW eDMA only.

Setting the pci-epf-vntb 'dma_bar' configfs attribute enables DMA export.
It defaults to -1, which leaves the extension disabled. pci-epf-ntb is
unchanged.

Base and dependencies
=====================

This series is based on v7.3-rc1 (cee9395acd80) plus:

  [PATCH v3 0/3] dmaengine: dw-edma: Prepare channels for remote use
  https://lore.kernel.org/r/20260903064533.2269557-1-den@valinux.co.jp/

  [PATCH v6 0/2] PCI: endpoint: pci-epf-*ntb: Harden vNTB resource management
  https://lore.kernel.org/r/20260901063238.631166-1-den@valinux.co.jp/

The second series fixes an older vNTB lifetime issue. It is also needed
to address an issue Sashiko reported during the v3 review.

Best regards,
Koichiro
---
Changes in v4:
  - Base the series on the vNTB lifecycle fixes, so unbind removes NTB
    clients and the virtual PCI device before releasing DMA resources.
    (Sashiko)
    https://lore.kernel.org/r/20260901063238.631166-1-den@valinux.co.jp/
  - Keep DMA BAR submaps for the EPF bind lifetime and drop TEARDOWN_DMA.
    (Sashiko)
  - Rename CONFIGURE_DMA to SETUP_DMA_BAR to distinguish this bind-lifetime
    BAR setup from CONFIGURE_MW's outbound mapping.
  - Continue without DMA if no DMA IRQ is available or the advertised DMA
    type is unsupported. (Sashiko)

Changes in v3:
  - Rework DMA BAR setup around pci_epf_assign_bar_space() and submaps.
    Allocate backing only for uncovered BAR ranges. This handles the BAR
    backing alignment issue in pci-epf-vntb instead of adding a generic
    pci_epf_alloc_space() workaround. (Sashiko)
    https://lore.kernel.org/r/nvgnu3enktslxuiv7kdapcotoaxlfqhivar4jbf2tqvrk4otz5@exapzemrq37q/
  - Set up a shared DMA/MW BAR through one BAR update path and simplify
    error paths. (Sashiko)
  - Make dma_bar the explicit opt-in and drop use_dma and automatic BAR
    selection. Split BAR sharing into its own patch, then document the
    final interface at the end of the series instead of updating the
    documentation twice.
  - Validate peer-provided DW eDMA region offsets before MMIO mapping.
    (Sashiko)
  - Include several other minor cleanups and refactorings.

Changes in v2:
  - Rewrite most of v1 and move the dw-edma preparation into the
    companion series. Drop the generic pci-ep-dma API, auxiliary-bus
    child/frontend, test ntb client, and preparatory MW-state
    refactoring.
    See individual patch trailers for provenance.
  - Replace v1's post-registration channel-ID cache with driver-supplied
    static IDs. (Frank)
    https://lore.kernel.org/r/abMcgQOHDD55Yv0e@lizhi-Precision-Tower-5810/
  - Let pci-epf-vntb reserve channels with dma_request_channel() and
    configure interrupt routing with dmaengine_slave_config(). This
    removes the PCI EPC DMA delegation API. (Frank)
    https://lore.kernel.org/r/ao2nHoCwfTEEiFSr@SMW015318/
  - Drop v1's dma_offset and dma_num_chans attributes. use_dma now enables
    export of the complete eDMA read direction as a group.

v3: https://lore.kernel.org/r/20260831182657.329614-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260828170932.2735807-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/

Related PCI DMA EPF v7:
  https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/


Koichiro Den (7):
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources
  PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
  PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
  PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
  NTB: ntb_hw_epf: Discover vNTB-embedded DMA
  Documentation: PCI: endpoint: Document vNTB DMA export

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  30 +-
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 366 ++++++++-
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 729 ++++++++++++++++--
 include/linux/pci-epc.h                       |  34 +-
 5 files changed, 1186 insertions(+), 80 deletions(-)

-- 
2.51.0

