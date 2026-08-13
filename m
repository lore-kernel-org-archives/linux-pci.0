Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4192F7F1F;
	Thu, 13 Aug 2026 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603089; cv=fail; b=d1j4J5hO7AfR8So6zUEgVe55QqXSKD9fNB2kM2HwjXraEb1+n2CiVl2rhsMl6vRz0WAwNhcfd2zuIAil4PsfxwnTaRMHG+uNVWGRL3YrHr+YnJJSOABkg3eL84LCAmfYSOmUaCVwXs7ZKFOq+RF0crs2Kz07VKVHgiTyIxC/Tck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603089; c=relaxed/simple;
	bh=kxGoKsTIJXFnNoPbEFoSR5Z1lZDZ8sbzDWuSU1FkZXs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eR4LOaN2H536RihjXWEeCU8qAZv4qSFbBp07dMbQ7Cx31Aa58DcTxtNSydP+q4hAXG3VOHbYjSDrJW/fb9DenTK69ImyRK+mDTRlXug2+mw/H+jIX6JvDhoXUl22oBn+lPv0h9RwUG2vX4rCvpTCZ0yN+KRs4hOb+H/uAxI/oww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=k2YJeOLj; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="k2YJeOLj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Frk4WqNKe5sgBceyjnLYGSDBbZtB7Jta609ZdTRcXu0S2EwwP7OndI+uUl/U2ui7qthwL3rwguWL+XzkokyJM6sMEyeyYNmxIdljXCNkLNYCkc0HnkQr90kb6OOLum2RBEylKU8j0/8ZGah9V6PF01kM/BV4fO0boMDokO5JX3c0hYs9XW6EjN4e+69toaXfiaVHhn+XnVXugE/aX6UxR3dnrdQVQu4CKkWJsWO/DUJ1SvAb9hj0nZyY4WbM3naHxwXiL//U2XWH41E8zwEeM7/o7xPKFGMe7mAYdmtQXm7Ct73igHnkCowyLgz6BDS8I2lwrZ+GC2I4UcMthKc7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRmMQ7vLXHWFsMfFBUuIVScyQ4736GeRzkHNUAbfI54=;
 b=Yr3HhJznqPnVQmDqoumdkf0tUjGCUniWliF1YRAUY+ghrWkD/nUacKDO7SGjuXz2zLrvsEQvEqbf5Gm6US4iT2FSp9+75/HbAZu01RsUx7pkYNREQk/1jJkhl0gZtAGsgxPduXHAPbX3cV2BwMb1Dc/znl807T/O5Bo7KSyt0QGP2PZfn616qNJtqhJS50JKF7Zf0/O9RE62BuV82IRi8wbWZ931GLz5ZvR8NQx8c7oH+MWiRygSWuck6+zZH5YCfvoNmd/R2jMqEE4NAiQS6Sow7L7XwV9svRYWbja3b9REHfHPdgpIZiQ+olY/inzH2ZSvw3bORqx+Bn0xlTXiOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRmMQ7vLXHWFsMfFBUuIVScyQ4736GeRzkHNUAbfI54=;
 b=k2YJeOLjcEPZvL5EecnMhyME8jbMhOC02ZeQNOZu8J/U2DRR85M9gZULksoIYp2VQ39JG/5FSg0G1kOQnlqunybwBIozlRJIzNrz/BrDKa6wHHwBl8G0+H3C50doSJsdmPbJVpBlT+0AdOyQf1/bAL7FIIBgk04zKzMGEcX4rrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:03 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Date: Thu, 13 Aug 2026 15:37:47 +0900
Message-ID: <20260813063757.3131865-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::10) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e716917-b0ff-409e-a11f-08def9056cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|56012099006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	ffXaq00rtqZ1bDkxTZSC+PbCo19QSrdOnJ8D3IvLI6IT6ZObuNlxuQyuSJNadPysZvbCKxRWJ7S5A9xldIBrQoUDVXBIB1R4eQyh7XkxcIoR252ZanH3RQkwITZ0vxt5LzAwWeh9/LFEM0jo8L1XW0KvZJZmu96R6JhMIzSSAH7SOP8iLzLS0YKX7Q+SWpO1XpePueLS1+ys4y3c3KR74SrGJH1a6Fa/G+j8s979Y6LK+U37lQzXh2XpBNpLSnGQPzr+vK83uGLpIsqrBgFL/PA9I4Mm6HHSo32KChNatJ1zdWCk1PaOE8WOv5Zy4W+Z/qhr88gP9BZ6OMN9lUZkYZP2DguPIwVHQZS5RPRWjqtFNFmjLw9pOat5o6ZbjbzriMwinkcKYSIhpQFQzn7LVt65hO/BJljrlqO/plz2rpUfKwAiFrdkjs9u2d/JE7byXFpLCvAO/2tffEDdiU8MnhLacN0/aTlEmecAeKDz5tKVgc/+pA05sXGNAJ6smMgHaYM/jt0Ppe6b5BrLFimCejchmtvUrV+M6O4LkAfmqN7f9fbwBhG+aSIJVZA8ewh24zxoEDgaKJseIKd6BUIZfr4eIf0oe8vlxCLzgK0fDWejMSlkCyAPzTpKzFK8Y9uk6zKs/2xGEzJih2Hqq5uW5fRH69DL8vZCUqPGauYEg+YLn8bjY44d/8qJWwoCZs13+BcJaJsLT7Pc1BS9itubPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Clh0ngEdUE8yiGj8mLJb8AVtTZg2tsTWI8KOQEJUBsR2oAUTO0M0Q/NcaVuH?=
 =?us-ascii?Q?UbA1zj9jYf4rv7BmGZ9YnZ0BgYZSzKy1mGC/uGTSLwAjGfO3a2Mk3gdzkm6B?=
 =?us-ascii?Q?LH3Nz5Np1jHTBu1Ae/GDoOUS95IOJSGGQBBiZW4rm8HBWFeLVQo1mKhmTc7F?=
 =?us-ascii?Q?1XluURd9Ed6CF2YcPuuwTO7FgdcQcjxgdsg/P33xVdYbgXItIfN2zMpdx1pO?=
 =?us-ascii?Q?XtZl/gFq9JSpqayw2jnQN6QkI134xwyvZgn/Ft/xZ3PjWroXdKfTmMheCV7X?=
 =?us-ascii?Q?8ddydobTSx0Dl03JliKSOBNhuoh9Npt040hcj9iTHLTmyv2+hPN3B9w9Bd13?=
 =?us-ascii?Q?T8Sx9TbEqOhofH81DWjYTMcGcAFRCHGpScQwYAouzO8RsGiXlHATicuEwZLm?=
 =?us-ascii?Q?5dRoKUQwIWE9s35JEY1tEuFT4CLOVidviMU5HMwRzYLg6Ifax3eKX3jonngj?=
 =?us-ascii?Q?3zgTiPn7njoJ7FL458d/51JmMV3thGkU9Q9w6+e3mhTjuP4y9QDslV4SRU1G?=
 =?us-ascii?Q?rtEJAeEhrqQnCaJDOC2BiXROXy+cl3E3c5iXMh2mexWJY+1zxsRXv3qNC6/f?=
 =?us-ascii?Q?penVV1vs9ik6Y9dkKASXPEjfipcFYeix5nuW8ztR3AMQgkd1KyDRiEVSOMr1?=
 =?us-ascii?Q?mH1wTKwwkyWAdap1PlUmgUPvtBfSp2y+XTl9qgxQ6vyLJKA0bVx30gQZ5GBo?=
 =?us-ascii?Q?qYsqfVacGlTP/6GEV/YPhJMck5P59VfxSBf8ZX0e4DoYgIYX971HzYdm7bu5?=
 =?us-ascii?Q?DHDLr7ZCXWlMkXdmh+mtqiu6gfYJtY/tIArctJVPBKYTJJ+58+mUUsTLGWKk?=
 =?us-ascii?Q?E40TkgtiAxcPStNSo4uLrl8pLL5wjBp93gppG+l4L7tSiW7jB4Rk8YKsatzE?=
 =?us-ascii?Q?hHEiBO98JmsE+HNCJ7nKiO8togtt9fwU3V7EmE4pO462ah+6nuo3/uEn8lTO?=
 =?us-ascii?Q?1y/vCjX09a/D1DspbWiXn5r7Hl1K1euVKAOPMwl508gXw/naV2FBphqOhkq0?=
 =?us-ascii?Q?fe6DKcBVO6G2BkYvgDhCmOWUz9RxstJ4M/s0d0bggPqKbo8iXSvcuAyKO+dS?=
 =?us-ascii?Q?8UEU66MhkvFC42K6J+R3qRFc6KGIrwC7UnY2g2wwtu5Olo4ZncdCe30oAQf8?=
 =?us-ascii?Q?lGYDyjxhdAGfvWWLMOvbkek1tf0YLacwsxvQrNRGUOwXf8E+sbnbp8lXw5YR?=
 =?us-ascii?Q?KoxfHFXjSMUVzEtoGGQhu8098DOIgLUGE+Z9oZ9w18JB1BNIna0oFnT4qbre?=
 =?us-ascii?Q?1SJaYdGPIXO1uh/rCW5dCYFydgA4l3VrObhgNKxmC5FSSfqhHR7Os81iLZmA?=
 =?us-ascii?Q?j6EkuazBA83gNfVMr8gxiN7DCc9Nxs3qEieO7i2Rxd0co9Xu45ufk19Vora2?=
 =?us-ascii?Q?x92OB5ygQjjCm8vBiytp6BMyKhuDOfGS1qA8If72Z++ohTK8rSrz83H5j6JM?=
 =?us-ascii?Q?c7PwPz2fkTmxezG5zas8wYmJI6zgSn/eI/5kP9umrkEfYe5moQlYiuI1K4H0?=
 =?us-ascii?Q?N++w/wJ4LRE09Dklp+iMIZlqizAYo5CAnBwTvRizW+v+bDwd5kEfU/2sJzby?=
 =?us-ascii?Q?8q3bLQNMMw4hYj5AbE2d30v4coelsTv+E7pFm3F7/SLsYI34u7GTXCGrvNL3?=
 =?us-ascii?Q?bVnNI+m8GkB4D3ion5vB+dVhdAaebIzPHMZbm+1EKFgzu1pW5MJiFczumCiE?=
 =?us-ascii?Q?01Ojvt0+XQ720bh0giXcMxdGw0dEHESY840XtnFYU8hP7bAE1RmCkPMJ7wuF?=
 =?us-ascii?Q?l/Q0HIfvmiFCuHYN1CgeaDjd3LOABly4qxMFZ3KD95oZG4dd4IIw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e716917-b0ff-409e-a11f-08def9056cb3
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:02.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wvvIcxdqttYE6T80jY+kN9jqKEwGWk1PGGe6Nmj12T0+/uuwySoaUasANPDqkm6ErLipNnmNIm9Wm23wRceqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

Hi,

This is v7, the remaining patch set for PCI endpoint DMA.
Parts 2 and 3 were merged per Frank's suggestion.

This series defines an extensible endpoint DMA BAR metadata format and
controller-neutral EPC auxiliary-resource and delegation interfaces. It
then adds DesignWare eDMA/HDMA as the first implementation.

The infrastructure itself is not tied to dw-edma. Other endpoint DMA
controllers can use the same model by publishing their resources through
the EPC auxiliary-resource interface, adding their metadata-layout support
to pci-epf-dma, and providing the corresponding host-side driver.

The metadata lives in an endpoint BAR rather than a VSEC in PCIe extended
configuration space. This avoids requiring endpoint controllers to provide
writable configuration-space backing storage for an EPF-defined VSEC.

This series adds the host-side metadata parser, the pci-epf-dma
endpoint function driver, and documentation.

The endpoint function exposes selected endpoint-integrated DMA channels
as a separate PCI DMA controller function. The host-side dw-edma-pcie
driver discovers the BAR metadata and registers the exposed channels
with dmaengine. The endpoint function keeps the metadata BAR stable and
uses a separate DMA window BAR for resources that need dynamic subrange
mappings.

The endpoint function reserves each selected local channel through
dmaengine before asking the EPC backend to hand its hardware programming
ownership to the host. A new static channel-ID helper lets the endpoint
function select the exact channel without exposing a controller-specific
filter.

No fixed PCI ID is assigned. Users provide the PCI vendor/device ID
through configfs and bind dw-edma-pcie explicitly, for example with
driver_override.

One open question is how to support endpoint controllers with only one
PF. Keeping DMA in a separate EPF requires multi-function endpoint
support. Folding it into vNTB would work on single-function
controllers, but would also couple the two implementations. This series
keeps the separate EPF model.

I retested v7 with:
- small out-of-tree dmaengine client that uses delegated read channels
  on SpacemiT K3 (HDMA).
- heavy load on delegated read channels on R-Car S4 (eDMA) with:
  https://lore.kernel.org/r/20260810165136.2292436-1-den@valinux.co.jp/
  Note: the entire read direction needs to be delegated because it's eDMA.

Part 1 v6 has landed in linux-next via dmaengine/next:
https://lore.kernel.org/all/20260721062815.4117887-1-den@valinux.co.jp/

v7 is based off of next-20260811.

Best regards,
Koichiro
---
Changes in v7:
  - Merge parts 2 and 3. Part 3 was last posted as v5; no v6 was
    sent. (Frank)
  - Let DMA engine drivers assign static channel IDs. pci-epf-dma now
    reserves exact channels itself, while EPC backends only perform the
    hardware ownership handoff. (Frank)
  - Put HOST_REQ in a dedicated host-request metadata word, avoiding a host
    read-modify-write of endpoint-owned fields. (Frank)
  - Restore automatic BAR selection when an EPF is rebound.

v6: https://lore.kernel.org/r/20260804033855.2115817-1-den@valinux.co.jp/
    (part 2 only; part 3 was not posted as v6)
v5: https://lore.kernel.org/r/20260717050635.2145014-1-den@valinux.co.jp/
    https://lore.kernel.org/r/20260717050953.2145851-1-den@valinux.co.jp/
v4: https://lore.kernel.org/r/20260710082156.2395844-1-den@valinux.co.jp/
    https://lore.kernel.org/r/20260710082727.2397253-1-den@valinux.co.jp/
v3: https://lore.kernel.org/r/20260620170438.3756593-1-den@valinux.co.jp/
    https://lore.kernel.org/r/20260620170844.3757241-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260525063129.3316894-1-den@valinux.co.jp/
    https://lore.kernel.org/r/20260525063456.3317509-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260521063405.2842644-1-den@valinux.co.jp/
    https://lore.kernel.org/r/20260521063638.2843021-1-den@valinux.co.jp/


Koichiro Den (10):
  dmaengine: Allow drivers to assign static channel IDs
  PCI: endpoint: Define endpoint DMA BAR metadata format
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: endpoint: Add API to delegate EPC DMA channels to the host
  dmaengine: dw-edma: Add channel delegation helpers
  PCI: dwc: Implement endpoint DMA channel delegation
  PCI: dwc: Expose endpoint DMA resources
  dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
  PCI: endpoint: Add DMA endpoint function
  Documentation: PCI: Add PCI DMA endpoint function documentation

 Documentation/PCI/endpoint/index.rst          |    2 +
 .../PCI/endpoint/pci-dma-function.rst         |  188 ++
 Documentation/PCI/endpoint/pci-dma-howto.rst  |  201 +++
 MAINTAINERS                                   |    1 +
 drivers/dma/dmaengine.c                       |   13 +-
 drivers/dma/dw-edma/dw-edma-core.c            |   40 +
 drivers/dma/dw-edma/dw-edma-pcie.c            |  394 +++-
 .../pci/controller/dwc/pcie-designware-ep.c   |  184 +-
 drivers/pci/endpoint/functions/Kconfig        |   13 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-dma.c  | 1577 +++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |   70 +
 include/linux/dma/edma.h                      |   11 +
 include/linux/dmaengine.h                     |   20 +
 include/linux/pci-ep-dma.h                    |  175 ++
 include/linux/pci-epc.h                       |   63 +
 16 files changed, 2938 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c
 create mode 100644 include/linux/pci-ep-dma.h

base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
-- 
2.51.0

