Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26132C957;
	Tue,  4 Aug 2026 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814747; cv=fail; b=DW/A7GPPG1hiP3OuYl3O84HfG1U1MghW0h5azLqYAfthcJraut5Xg/Q6RCim0Iy+SNN1vUqH5TeDX2hFEYj12VOZTdkQeb2IGBtm5LIFpCFdlNCTXYVzO4T2oaLLZLKI3aDuB1GW/bgs4E9zy86b6G+QMzW6UkmYzC2COb3mc8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814747; c=relaxed/simple;
	bh=Q9IkmL8jgj6hbYce1LS30ovZOhS0jCAB2fW8t87IzxM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s/gWheaJ7IV7g0OLkf5RG63bVjvosgXozx/aStHQlQithrToQI3gtIIhQnTju9G8Q/Gn8Iia5+gORvSH4iuVvN4UY4OhXN+hn9uBjapqjuvmAS9IvHigmborCvSusU0xfduiPomPVi/iY0eLdE1VIn49/CAkXRoB8X6VM8jpV3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=l6kRAu0n; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="l6kRAu0n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEMuFVALlhZEp0QvLx1j42cT07YT+pUNwA8TtpvVSfb3HKNKKllKyVxo5Kh6Uww25rM07JLK/5h+31mDQKtmKg2cTcezfJLQocRPQGPPXgTJLL+nKERVKHcZy4X6917DcL9Ucp41YOTj6/ZwGS7Ti+ckQt+pFkyDAR5t/K/SPQ7Fci00dTmUUxgCsIiLqPaNv3f8XrFlf4xWPMpZDXUfsxsQghDPIf3FANnzXPQe5QVGE3Jn29raRTz/MJh0wSi+9Kj7a+sP0RsqkVGbTVubRIIrpXAziISZXwu/n5Av6H4NHMQs/sybqdfmxiHe8qjn7OGtAvhUKYWybr7rPX4c+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTC8FWI7WiNkxdx64WD0rFc3pDgfcnz6qzw33vV5BVY=;
 b=tdDXlPS4v0WIkg1ZsXtfRwT56uX9r//2yIGmkzrnarM33jy/y5fDrKnLihHNjYAdUObcMgvcHFuJlL92meDBfZQcOfXpMz8rb8lTNHAbKT3aMlco5x6x6TiS/yrlOjAqp0f4TtKjqboChqyOr3Nt2ZZPilsEnmGgvLaA1Saw57Y3NhtUUkduBn/3o5YL6OzAIDT97UaW0UMRVHM1RvIoIFwyUvBgapucrY95FXZibsjQWxCzV9/IYDId0dBG/e5jnqKjAHvRHYct5l1HlaqfKub9RkZEJe3teAvFUVWaRaTnn6T/mS31xF7bKjmWlGaICD2E70ENLMJFTquQvddlJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTC8FWI7WiNkxdx64WD0rFc3pDgfcnz6qzw33vV5BVY=;
 b=l6kRAu0nq6lKAonC2c9f6Nu6ojdkRHfonaanxwe9eOKHSXoTDk/R8zMf/D9TrUJR62KgHgYEVLWgyWGSIFr7GsJtrFvoo/isD/hD22/H4wNJcu2BaXZp0BGF9BgLHVyzq7oqwZY3iLcW1IwcS+64KpVHEy2RTvSd97g4uLI4i18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7598.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:347::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:39:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 03:39:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
Date: Tue,  4 Aug 2026 12:38:49 +0900
Message-ID: <20260804033855.2115817-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 081ab09e-f527-4c6e-0b0b-08def1d9ebc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|7416014|366016|56012099006|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FJ+1R7C8Qg4eBnfWAD85eqllpMvPsgoAIP51Hs+R14Yzol2Yxo5mzoZnU4bAQ84XtKLcKVmn2wEb/AsU7BJweRalgkhJDeyLcmZe5gJVoUvaDHbPU1PNoQJLVdMfsY7PpDAC1EYEQ6PiirLEny0u2p8pf+/1L4ftMM3Q3Sac9OxUZItOtdRLHXrxJkJZWVl3AtPFS6KSt3RWEfWgw3mRi4vB79hXEJBeMxNLrRAun8oeuB5uw3Z7OhUUQqjf5+ZH/UDYrVw5esvvyp26eEFEl6rxAgBD4JxJEb8SEsXAEPPXsaMlCf+B/OSwPegnXKMSeU7qFfr0BslU0Msjk+XfkcgT1D6JkOlkO4P6QffXUViitjbgFrP2UTdCI3Ue7+3F2wh9AHoQtcQfKRtui0RyDDFcTL31LQcTcF+RkZcnU0GsmDrVvCOH3JY7y7YIn1tQaPbES7y1kZfkVJbjuqkjEirRQfuemrRrI0UvdtQLmDzUXd2NBcn8mgK0p+8mix1aUJD030cTo11XbSDcNBYbF7l9XfbjG2Rz7z6X0ewja3gqpAY6lAbW/QoXHtkdOy/0W66f/XVHKoprCUZf7asG5b+3BB6gc20wnP62/kVtDa62yUgsTWk23oHMT2cw16GCG3L0NXNB1c7VaZUyTy2D44FRFIlmy3jK5ceYzkj/MHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pxkFkq3CDYqHUCBK8zfIV5YOzo1lCdc1Z4nGUBXLyj/W19yUk8A2cBuFf0Vu?=
 =?us-ascii?Q?DedfcX8teiAVCtF4dV1Z+ju49+raUrPALKibyBx+Gk0DEnvvgfOBgDofxH60?=
 =?us-ascii?Q?L9hin7+vPSCWYh54p5TkEwC/H2QjviDxzMrpCEjCRTHchCBEASHRmNobtnI+?=
 =?us-ascii?Q?arQwDNrk1inzXNWE3J0o6YkcybC7QI92fdBPyaj3d5R95QRvLvcsKQvz4LJg?=
 =?us-ascii?Q?OOiyK03lTu8G5K4dohxZkQ2yRLKRxqSoqUj0MsIZt7kmZ2K1YQ22mEuUaoHj?=
 =?us-ascii?Q?MomTu/bUEC1yEewqz1/D9rMlmRQ3JCW2mJr1i3psSoDKLV/oHzyf96p4/7vz?=
 =?us-ascii?Q?UowCa6XJnd0T1JttnuGAsSjch0M3ONMuguIWiPlfTrRDdWifs0u0B3W4qUyF?=
 =?us-ascii?Q?uwh95ok1LREYucg7RhxKIS3qNDiqctYX3tSkLJEpOYukwNrRuicvPCv3Jb+q?=
 =?us-ascii?Q?Fq5zZZ/3YIAwN1FjvMAc2AK5ApUFd9PXr5cDBJGVR3fPWx3U1+nDhoBCL0Wj?=
 =?us-ascii?Q?zH6HGSQO4iXOntkq/RdRq378mQvnYL1tIaN7XlzDNEEYSYv8NboGxB1HGv1N?=
 =?us-ascii?Q?oZjtIjCIdtNtGtbP3EnPGne8mfbtuQW1m+IY5iDOiJoFAv7YwKOGfnYFimLv?=
 =?us-ascii?Q?zA0LTeut4Mm2gA4oEz/gVXfy/NhmrSGTkKDpuBUl3D/c9CiaFQoOIkVr2vX7?=
 =?us-ascii?Q?ZQBeWkVe+l5nA5p4LnOcDCXFs9nAv3Y1YWuVTrfcVQPUV25orhLwMQK1d/jX?=
 =?us-ascii?Q?zP4NVigV1n1NvFY290EJal5WjHWMYD16vzQoVPHZjUo1i2uC/haIj/2gMA/5?=
 =?us-ascii?Q?3s81KaY3AGzeSL0HI9kgS/edIEh5UDr7PMvHKK6kG9mGtmOhogNYdQKcSmUp?=
 =?us-ascii?Q?i1cNmG1i8uuKat/t4bXPv6Bd2WoVE7gC7VcLSm17UIXhMnyMD8QSyTT6RafQ?=
 =?us-ascii?Q?xzhbsM/0KfcpmCTu3iFKG/Mdf1NLKV+wXcL+RoW6oipkz+5s1fHVPfBwJF9P?=
 =?us-ascii?Q?jv4OobbXHfkJSU4wbIDZEFaFMOvJRFMmKDzzZ7lAF4NbP5J64SfHGTmpk4no?=
 =?us-ascii?Q?cYNKaR6vOA+3KOnCYmUngZ884osLaBk/QqxwFS6nv+uoFxU/8a+rD0bbC/ES?=
 =?us-ascii?Q?DJH0zEiZ+1GPud4J+OtoKFX4BFk172AITU1mbQtrquxk4tX0RUeDgVOAinfG?=
 =?us-ascii?Q?gUSKbRKyYENnXBV5I8X1f7xB7ZKFTqfa2ZLf/Tmexd7+jcF08ybUIagm/5P4?=
 =?us-ascii?Q?G7tmw06hpBZPaLshAofJBFOqZ1ryg9mxJDXldgooR9C5H143ewsN7HO3uXyV?=
 =?us-ascii?Q?LHP9d1TdS/M+IwBBK8RDyOv3c1ueNMl6Xtsa24XK5U375XlDUwmuGJl4KgzC?=
 =?us-ascii?Q?+Xd0K8BC6hQmNjhErQU0mKNvpdyY3uX3sM1wN5iCMQ9JFvZQof6yGosXJEjn?=
 =?us-ascii?Q?CJPpdtm+Aa2jv/suDEoq2TpwdpVZYkN7n58udv+EnkRwWLhKzjlW3+Ti36Mg?=
 =?us-ascii?Q?NXvxAKnLguQ0LHUvlR8IAAhZkRKRp/ie+gJATnAPS0/B7yvB37B/ioLgezIy?=
 =?us-ascii?Q?ZigLm5Ox1I98OlcA/S7JMhZdcPWN2/ZNNFcr0/+J6Er83DKpswM35lpCMYcm?=
 =?us-ascii?Q?ruOUP1NFlAijh+AKThNQ5xXMtBPpyJ/83tZ8tRU2Opej4sXbvXF3DWr0mGiI?=
 =?us-ascii?Q?NLsJscqGZZr5w/VhYxzCn/2rG3UOBOZ1evMSMk3gH28QWUXe02JK+o31ZVx7?=
 =?us-ascii?Q?0jFZu2EohJN9pM5eb8d+Qk/OdQJ6rUk389t9xMVm34yPMfUw/MeV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 081ab09e-f527-4c6e-0b0b-08def1d9ebc9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:39:00.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y0DYGZMvgDhNuog0GMVH0PCWzqm44kgm4+JQnTFbPfFf8I1MKyIO7U/dqAvFgcELlDLAtRzeA20V28iiF5GGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7598

Hi,

This is v6, part 2 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series defines the endpoint DMA BAR metadata and auxiliary
resources, adds EPC operations for DMA channel delegation, and teaches
the DesignWare endpoint controller to publish and delegate its
integrated DMA resources.

The metadata lives in a normal endpoint BAR, not in PCI config space.
This keeps discovery independent from controller-specific writable
extended capability storage.

Part 1 v6 has landed in linux-next via dmaengine/next:
https://lore.kernel.org/all/20260721062815.4117887-1-den@valinux.co.jp/

v6 is rebased on next-20260803.

Best regards,
Koichiro
---
Changes in v6:
  - Rebase onto next-20260803, which includes part 1 v6.
  - Use one DMA resource snapshot for bounds checking and array filling.
    (Sashiko)
  - Move DMA resource exposure after delegation support so every advertised
    channel is immediately usable. (Sashiko)

Changes in v5:
  - Keep reporting a standalone doorbell when linked-list DMA resources
    are unavailable. (Sashiko)
  - Serialize irq_mode restoration with channel state updates. (Sashiko)
  - Clarify the provider-defined sharing-group quiesce contract.
  - Use guard()/scoped_guard() for new code.

Changes in v4:
  - Rebased onto the new part 1 series.
  - "dmaengine: dw-edma: Add delegated channel request helpers" moved
    from part 1 into this series, next to its only users; this also
    resolves the undeclared-functions issue reported against v3 5/5.
    (Sashiko)
  - Lift the v3 PF0-only restriction on DMA resource exposure and
    channel delegation: part 1 now programs the per-channel requester
    function number. Delegation to PF1+ therefore requires part 1
    applied on the host side.
  - Move pci_epc_function_is_valid() up to avoid a potential error
    pointer dereference. (Sashiko)

Changes in v3:
  - Decouple logical DMA channel metadata from descriptor memory resources.
    Logical channels now refer to descriptor memory by resource ID instead
    of embedding descriptor metadata in each channel resource. (Sashiko)
  - Replace the v2 DMAengine filter-callback metadata with EPC-level DMA
    channel delegation/reclaim operations, keeping DMAengine provider
    details out of generic EPC resource metadata.
  - Add the DesignWare EPC backend for DMA channel delegation.
  - Limit DesignWare endpoint DMA resource exposure to linked-list channels
    until non-LL metadata and host-side parsing are added.
  - Suppress DesignWare DMA auxiliary resources when the local DW eDMA
    provider is not available.
  - Reject VF DMA resource and delegation requests because the DWC
    eDMA/HDMA register window exposed to the Root Complex is PF-only.

Changes in v2:
  - Follow the part 1/3 v2 channel-claim model: EPC DMA resources now
    carry DMAengine filter information instead of raw DMA channel
    pointers. (Sashiko)
  - Update the DesignWare endpoint resource provider accordingly. (Sashiko)

v5: https://lore.kernel.org/r/20260717050635.2145014-1-den@valinux.co.jp/
v4: https://lore.kernel.org/r/20260710082156.2395844-1-den@valinux.co.jp/
v3: https://lore.kernel.org/r/20260620170438.3756593-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260525063129.3316894-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260521063405.2842644-1-den@valinux.co.jp/


Koichiro Den (6):
  PCI: endpoint: Define endpoint DMA BAR metadata format
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: endpoint: Add API to delegate EPC DMA channels to the host
  dmaengine: dw-edma: Add delegated channel request helpers
  PCI: dwc: Implement endpoint DMA channel delegation
  PCI: dwc: Expose endpoint DMA resources

 MAINTAINERS                                   |   1 +
 drivers/dma/dw-edma/dw-edma-core.c            |  91 ++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   | 205 +++++++++++++++++-
 drivers/pci/endpoint/pci-epc-core.c           | 105 +++++++++
 include/linux/dma/edma.h                      |  14 ++
 include/linux/pci-ep-dma.h                    | 170 +++++++++++++++
 include/linux/pci-epc.h                       |  62 ++++++
 7 files changed, 640 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/pci-ep-dma.h

base-commit: 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec
-- 
2.51.0

