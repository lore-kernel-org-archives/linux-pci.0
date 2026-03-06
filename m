Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021101.outbound.protection.outlook.com [40.107.74.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889034A788;
	Fri,  6 Mar 2026 03:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766917; cv=fail; b=SIrdM3nfPD19MacA08pJDp39mPidx2Jc2bNMDTFq+1AVOYujpA/nD4tUOv5bMZo/0XxGTYpgoiG7FCpY16abWDzUnUc8uWdjoyCZtTjOex2dflqxJdf8GIdiEdYFvQlf8FxlNs0KE5YNjRMIIF1hqbY81dnrn/uW5lXxHys1wy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766917; c=relaxed/simple;
	bh=ARZgVPdL7tJQNcMq/M6Elv1ShvwY+Cb1VLn7icoh8ks=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J16eXnOdsOvvOLHeT9W72LvupWyjXLaIhAiF2qIDhwcGygfovDl8iv3dL089Kx0oeDAsoytCkJnLQCn7skxTPE2gunLaUH2VkZX8VhOzvQBPI793nlQwCaurOwzma/fMBXBtmkc0YD/aKfuZ0Qs93tjoi3+LHWdlANi4+fYQ7mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QEyvWNYG; arc=fail smtp.client-ip=40.107.74.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QEyvWNYG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJsK+U10PVKw+zdOu3tCjTqrg/C3eB9QsaHQ3EW1PP2IWTpWEg7sVpznVzCIT+6MbBJgB6CE8ZxvaLYsb/JQR+OAJ3GHvfH34erTHzqzGjNKEzm2pR0pxZzpmGpOUgPX2q5NgekaqhFdyy0VeaSe/EHfadzXK9158fRFKRi7N94AR+RD4GKLTboi0hz4N0PyshmQpCHP1dYBZ3/BLQBYbapQe+NmRKsw6wmEAgR0OAd+G5HbbGH8bvbBbxedUfkElfMhnORwJ2rTJw8RFL83m+wXgqKioes/etGwcmxSoLF4NL+IrJVuyDtnRpXQ/O9Lc29KuJZEORgoTnfqwMpwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ga8hEKDmzSrVZoOwrQaF8sPRS/f9/C4sJMks/8uknc=;
 b=FTH6im62pnTCA8oa0pmmeyEHO6eep4kPPxFQO3x+6GDS2EZRmSEiIeidRgMWNi53nqUedS+dFM3yJ28Cxg04W0SXXbUVO1MWkt+vZJFqyOKRJ7vnSVLK7MwTV/ByccSpmWPOqKq79HE659NvMDJfdvx8VSsM2W6XObdKALpp1oeJp4+5ijGCRZgzzOP8jwB3dKX9shWAGLzSXEUMPir+fADq91OZg/tmS2Q8DGZBpg1oyKiPvPKnbwww3F8butJT0XYUIz6TplGIOJFDZ1KRjlvKoKCtMe1az1Y/2X+tAiXbFEZYmsBVmCzVAwZtjA9guI3QUK9/SD+qnqtxoh+qAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ga8hEKDmzSrVZoOwrQaF8sPRS/f9/C4sJMks/8uknc=;
 b=QEyvWNYGAUPvMxcSX+Q9/X/fWp6l1aVTcUgUuN93y2/u0RPInz12I7ePYV76IzTZy4RumK83BDJxULKm7NJfeKYIUEczWa5FgnW837GWAJRNiaGbWbq9ioak3ZCxrN0rjr8H3kV48qHLucNOiKQg+9LijIsWrIAx3KjnhSboDMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6428.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:15:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:15:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/3] NTB: Allow drivers to provide DMA mapping device
Date: Fri,  6 Mar 2026 12:14:40 +0900
Message-ID: <20260306031443.1911860-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b23983-0a0b-417b-a8fc-08de7b2e9356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	NBbsfPvuiWX6HJr7/C+Qf3X10hypzG1tz+inNxJegnr3OvjC9oX+EsF9rk/4WcxdwHWqISUHivgkneVfGdWOkhpbc75vvv00N8KHymuZGE6pV7VtozzFdn9vICBY9VROQMDp4IJUWfyFpl+2VvIF6yAbduUqnC9CeLbCgBeXRJ4xSpkmTAhSLMdDYtJH29E0C3MYVHbkdcWqEUkshzwA3n+AIBsJkGY2/6c5uVHhy4JA8vO0AaBo1sg4hxraHOzrp0MeKYe6zSRDX9V0ZlIALk4GbsqYwzQPVv7WP8iG0k9Jr+PHYn5orYSovXKgVVvEIgkdamwm12tgiTqiA/5vEvJOznJAY04F15QaI4yrhOGcEyuV+izy43qf/u/xxFO+vcYJNpAtFeQoI+xswaSYGsUWd5Bfg6/DiwAnnGF8FUlbGQkhwiEXgrFYWSkrWVo6Yu8YJiDPB2Ew7jTQ3rczJIjgtzS8sa7mRmk+3ZRjsMBs72secF2xXmp2QfI0wznquLDCSvjltazKxlUKZqsb7oqxyHSVVVHCn3CCTppG+Ea2X0h3JIpCP47teQV0/w0q4y9g0qRS6xAL9H+BdVJsBmC7nPlbYw3bmMhs+pxEue+4R718+GHgci8oekTDbBzMzpTrJiv8LK7A4tNEAkTA4gb/tZO7JpD8itsEFwcaUM0u7xj+45MvSw+koTwCPq4tmOr9Demyj+mjwnDSm0yIx+qKuXbOa1YhF4GRDmz7ZgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CC7DeJZUFFvdAOOrTyjfM+EB4e+lKcKRYG3Cks3OxrH5mXI1ZhL85QFjYgkE?=
 =?us-ascii?Q?PH6b/aunq0nMdfhVKXfD0ZjV20BKYV1TGzht3nnGha/Xo8DzBvN/h8wyVy0e?=
 =?us-ascii?Q?LZX8Ve2J95xyF17YEe4Nn84V6pcSOPjPWOyqiW0h+Kt3VWnZ8IakdTLif/jk?=
 =?us-ascii?Q?pnERYS1d8n8aNZKD4Y6LkdlDRkFWOaRgi3OXZLOb98Nz9c8jbZriaqFPjGhB?=
 =?us-ascii?Q?GryHPNWk0wMpPK1NObM5zz47ygQ/AqTC1kAijuQ9yRM1NyvEb9Ipm5XzijOk?=
 =?us-ascii?Q?CMZ8NesSgqSDYT664XYDzqArgjfos/ldpjrekej9a0739DIUPlm3zCdEFZZw?=
 =?us-ascii?Q?3HZvFgPnycQEhAtoKR70ch5H7nkUky/bioNL7TqbgO961i46U7O76fseHvEp?=
 =?us-ascii?Q?saSz3ZDpZwkBexzvzVadBA7Ga//qoETH1GaZxtpeWFAT3Qmr9NVqhej9rfiH?=
 =?us-ascii?Q?UN1PJggGPeC9VzRVLUSURARO/5cRPku5YXxihkd7w/Rg37odnTNF465oslL5?=
 =?us-ascii?Q?DCLldavcW5dunrC6SatiEDEzegt8ZP3Nm0zM0wM8jBctGzOlffVWA0pOM4OD?=
 =?us-ascii?Q?Cc7h21iK9OPrJr0316rkE1OtQSCpMuUiLUNY55ActllV9LBMnIDguEoCt5zr?=
 =?us-ascii?Q?mxtghLdVNT9Kuy8cDLlIFd0ZJLRP+lefODCE4O8n7yH5Bq8DFQ7xZzLAIFTb?=
 =?us-ascii?Q?iuf797STbdC/mHC5w1Yv2vhsh1kRRhNhdjtLMNQvjA1vG3GLOJ3c3OIGzRPl?=
 =?us-ascii?Q?vHPJnyVv/vHFIAnZN16katOSdh8ejuu8P65tTgapIB6wfOPoEWKJ2bBKno1S?=
 =?us-ascii?Q?A2Ow2ouGi90Y+Ie1WYXWGiG86a/OH9M1K4dbQAJH7kLV7sDGtaSKni/uOB6/?=
 =?us-ascii?Q?BauF8OLgcDi6CgCK/2Po+Nhy9ix75pgdNB3tNh7pvOx9vou5YvDLpKXQ/uVH?=
 =?us-ascii?Q?K60v/vcJTqQ3lTCEYfGkeT05Pm7SCD+G0qu/r8WJcJ76tRmZs5VRuXQ3z9Cg?=
 =?us-ascii?Q?erDGBRoP+GrVc8zwhSE88o/Owal08gKknug+JkfWs4H1ofLeBK1UN0ffZj/7?=
 =?us-ascii?Q?8fT5TTzeeJ5peG8MKUj31fi3o4qNdAzvQYexwk+wqpUN4v/PY35PpJgriOSi?=
 =?us-ascii?Q?t+tok+ksFPOpKhW80JR2Td8rMxSr610tcs7yV5X4cFDtUzV54ktgDkqYIpdf?=
 =?us-ascii?Q?AJ/8UVEV+if7E9XLuriJNsB0ki796lYoFyvTU4PLy0f5phnM7DMdbatOFl7c?=
 =?us-ascii?Q?0LBTjZ1xTnoZ0rVvHgaN7tz7Ui75QTnnW422EaPXqvD2Ndsqgc36hv6lj4Sz?=
 =?us-ascii?Q?SLaz9KdIj6hU4bs4L/pjuQzsMnAYS3AYwl6hGcLAzgAzfmq1VetlZ26mDLP7?=
 =?us-ascii?Q?ttHEIrn3WT7KBNQI/5rBW8yqh2GkxbywXPlQ54SrTUPphYyX3SqF1CU0b7fB?=
 =?us-ascii?Q?lLuMJnb542FMVFoVeCXaeY0Xt85pKiylBZNM8Aqq6/SfpiVonJr0i/4LjaPt?=
 =?us-ascii?Q?gQD+XKke5h8EBDOelJo8bdLpiJv/By0oCGC1ny26d/E/cnJXDq+Qh6k3k3LB?=
 =?us-ascii?Q?mBn5kG/0hmwIMC1iD5WZ9c2SRBQm/jKyU0UsL0LowkeltAOPpX+3eFXawoZb?=
 =?us-ascii?Q?xZN8vt0gBOA50Fi1eXu25M3AD1fVL4qGvs5KWePuExK0aWdcCMbUz9Id/PAz?=
 =?us-ascii?Q?QxdwZxsohPQrBOVUHZcoZy3zHomeoIasL8W88yU0gkTpHFElYR27mu2+HriJ?=
 =?us-ascii?Q?C1GKPA4DvYu5tEc5qjCttZZ+Dfc+KbRhKeB8zpC5wVZ34g7MZIvl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b23983-0a0b-417b-a8fc-08de7b2e9356
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:15:10.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz6RTObySnp1FbYnYWPOOj4FhKTeip4F+lMa1rOmYEp11VcnCarf578TGJq+eou33vxyHttdRKUDmT4bOJTQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6428

Hi,

Some NTB implementations are backed by a "virtual" PCI device, while the
actual DMA mapping context (IOMMU domain) belongs to a different device.

One example is vNTB, where the NTB device is represented as a virtual
PCI endpoint function, but DMA operations must be performed against the
EPC parent device, which owns the IOMMU context.

Currently, vNTB on an IOMMU-backed EPC does not work because the
"virtual" PCI device is used for DMA API operations, while the actual
IOMMU domain belongs to the EPC parent device. This series fixes that.

Note that there are two related but separable DMA-mapping issues in this
area:

  1). Selecting the correct struct device for DMA API operations used for
      MW translation setup and coherent buffer allocation.

  2). The existing RX-side dmaengine path in ntb_transport, where the MW
      source buffer may later be re-mapped against a per-queue dmaengine
      device ("double mapping"). The current physically-contiguous
      allocation workaround is about that existing issue.

This series is only about (1). It does not attempt to solve the larger
initialization-order / per-queue dmaengine issue behind (2), nor does it
change the current behavior of that path. In particular, this is not a
series to eliminate or redesign the existing "double mapping" behavior.

This series introduces an optional .get_dma_dev() callback in struct
ntb_dev_ops, together with a helper ntb_get_dma_dev(). If the callback
is not implemented, the helper falls back to the current default
behavior.  Drivers that implement .get_dma_dev() must return a non-NULL
struct device.

  - Patch 1/3: Add .get_dma_dev() to struct ntb_dev_ops and provide
               ntb_get_dma_dev().

  - Patch 2/3: Switch ntb_transport MW buffer allocation/free paths to use
               ntb_get_dma_dev().

  - Patch 3/3: Implement .get_dma_dev() for vNTB by returning the EPC
               parent device.

As suggested by Dave at:
https://lore.kernel.org/all/17cdfa38-16d5-49cc-ac61-20b606a4308b@intel.com/
I expect patch 1 and 2 to get NTB acks, patch 3 to get PCI EP ack, and
the full series to be taken through the PCI EP tree.

Best regards,
Koichiro

---
Changes since v1:
  - Reworked the series so that the actual user (vNTB) is included in
    the same series.
  - Clarified in the cover letter that this series only addresses the
    DMA-mapping device selection for MW translation, and does not
    attempt to solve the existing RX-side dmaengine "double mapping"
    issue.


Koichiro Den (3):
  NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
  NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
  PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()

 drivers/ntb/ntb_transport.c                   | 14 +++++------
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  9 ++++++++
 include/linux/ntb.h                           | 23 +++++++++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.51.0

