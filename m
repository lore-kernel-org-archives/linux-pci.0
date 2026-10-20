Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.228.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792475396;
	b=bbrQLhS/SSLujSqxn+gVCt5vD2syBhMG95x5jKyZ0pn20D5KFqSyVVrM4L1fpJNmpY7z
	 42XNRwk1Q58u8TDsh299ZZabdVHK8KXJa8qMP8GNUMk+79GsWk03OgRJRf+qDjxU27gk/
	 OFz+Cy2n/wzcuqirjaRUyoKpLgKPB1jD6AB/JGIZ1Z8YkeY3Iq4DZpQzgTx+oSfWzQaRX
	 fplKVvTeZHj0WAiGU+00PA3PZnReATBu+CPmeIbkQxtmcsfq5i303ZoFTud69/smqRlmF
	 /1kv8DPGtzP6bS6wAQyK2W42NbWVIrlHgY7BB/r2JIcJdEfvV9SDTI3sJWhmPhIb9NA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475396;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=swPpbO9zfhDB9UTz0y/UOvxRdHzvnPbk7cH+OcPh3Gg=;
	b=WoiTcyi9hzLPRTEyjEwg8vb0pzKQYxQAvbwxosSyFVSEvW2yT8YlBtdbiAINmw3jr6Fy
	 NxrTDqB1XbbVdhql+H+ai3PtJMl9As950eX3thQGX0EhLD9R76wXwT62Hzn5vg7M+wKtJ
	 mTuYX+DIBE+8Fyy4zp7MHHrvViBui8sOgGhLwwXy9QzQpV8N/3XlaGrOu/wq941N9PRNO
	 Vh3FA9dVAfRAUKbe0k1oYjmHsTwmgxwLCf1yWSWaML6u2gRF9EzCuAHa3KojOikexMv3j
	 f3CQ2Q5pfmpXc7A4PhPItFm/+F1J2S/lQ6PHca8XieSFkmpH4dITo4bmjZBPNYbLzOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ogJzpUm4;
	arc=fail smtp.remote-ip=52.101.228.89
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6A606A31C;
	Tue, 20 Oct 2026 05:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ogJzpUm4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIU34xOsQlfosb63P+4WY3X+d6shcPtmuZbae+QL5lUEu1XgmmemsyC1M9WFCBqCcGCivSbSxCg1X/WSesmx+yGMUJdlMKncuexs2VxAWAVx8iHvFXus6nCMuBecVQVCrBb/a612Zn8pRfjDjKNN77bTaiwpDULpS6dDTETf7SgWr2xHn8ZJ+dVkYXgMclPLXdOsF3sh/Xu2Yf7QGh8koBOAortyGAmzeqF8rsxx8h1XudCtGtCN9RBxi6SILShFdPPKc5q3vwd6lc3ORybSu59Lk50ng+HN0hbYw8vn6ZQVeTyNZAQNOg8MuibaCn9+Vf94C3i7CXUtKZ0TRkB3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swPpbO9zfhDB9UTz0y/UOvxRdHzvnPbk7cH+OcPh3Gg=;
 b=uu0lloCdbwI2cXBG+WuE8hitNzQdlsx9rPDgGuCQ+N6HAs18HZ3aZp+GCoqexa+eqEfkrdhSIC1SIPT/aF7xQzPJGnp9pyL38rDnWd/Ew+BNpj5CQY7F7DgAiHemSMxvUvuOzEPuD48NRuI0Ti/0qmh/3LGTu3otMEXktcYlPnhijO+cBfcJr0tPMvF3YcjEuKld6EhtIJwvxkvzyxnVNGQJgsZshS6sLmw2+r/jLzhxOtwxHCGz0RHybYYv+A4vE1fICsvxSi6dzzrmpVYbFYipagMC7D8Qa4l9F3OyJaUt8OdklpNlFLTBnqwxM8tFf9Yxqxm+vjdsxxnlo6uNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swPpbO9zfhDB9UTz0y/UOvxRdHzvnPbk7cH+OcPh3Gg=;
 b=ogJzpUm4gFNRPkx8vttObvabFlmJcRGMnsm6slT1bXukLaDL4yKIgbEbAhYrpUMrmmf0kouFeV1PX4OAinGulA9q5Q9SQ2O862ekeVpq7hScvblBLpgKNSmml4k3eTrGjGBOilqPBR2J8PJM50uyJNYk9aAqOPbopZkm2okcOQw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB7913.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:49:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:49:52 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: [PATCH v6 0/8] PCI: endpoint: Remote DMA support via vNTB
Date: Tue, 20 Oct 2026 14:49:40 +0900
Message-ID: <20261020054948.1218370-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY6P286MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 060f59c6-f36f-4829-da9e-08df2e6df5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|56012099006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QPczHA8StLzv9SGbx7DDVWpbiSkHyN59LELDTkvzQwuOffrsT2wzTmumgrOYN7g1y0xpHSPsfNSJWK4jCltwNu1O4FJ0mDJXH6Fn/9VlpamNAjKS2JGClqCFqhBaqkgiInKPvccmYuXGA/xkvS234g67tAw1KUjguPkn2ZcYmjy3Gz5JlQb3pZp/4xf5lNv1kb0uNGGnRIaP33hAQanyMbhs2kbQzCnNjjSopJVaBYEfNTY1zV2u6Z2J3wLlcjETNnZIHgu2HunWgCRRrOydNt+XohQoo/xTq0poC/Wsay4oUpBmNnMeAuMfwrOTTRM0vYK2j3+PGdhlDWEMv/hcBwpdS4aO3o8+tDsrxcmKuMFW3pPmg946VrHZMSqT0huM5OROUDEvnNuNbwiyoglvY8yvr/uQOXDCMCBXiL8n6JLumBZzrSUFj3gkg/p5DEmJAUB3IwRJm6QaUtWCCzPpKYtKHu2o0a/q5OSOdYQcBIUmIOe6GW+M+ezpiKy7XHtjsuPVlSs8ptd6IW3aGaWue8XNe213AQ4v2AnT7IlUg6l0POZ4w4i4nXZPUUoffnexkUothqUdmrON62gelX1a8tS7fDTutbFTug1vswCyDie+cQjZEf2vVSHRUWwo/VaE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZzEBMjPfDniOWGM83Y/4MmqsszTfmGLGaZ8FbxaoP0LE1amekAdkiUCDqN30?=
 =?us-ascii?Q?gIl3TJxr/b8Wk7OfTqpNfoPLbZWZMGBHSzedbJGkKYr+mbki0Jhmvi0K8Y9R?=
 =?us-ascii?Q?u0S4U8pRx5dJbe7NE4gdZge3KcCuW1Bz9YS1wUmWoXdAb3wrAgJ+8KWzYOCq?=
 =?us-ascii?Q?rB1yDf09n9EA019+vmIviAgWbf9EktNIBTPV+I61Z1nIKx9PWpDNFiFU+DKO?=
 =?us-ascii?Q?9MIwXcI8Tily42x1MY+00ZAmRjJNIZ5BHdEJawYO+jSR58No5ihQYxmCSDtY?=
 =?us-ascii?Q?ft3xRgAKyupOkpHXRUa/HKfUcxRUYp+u5qT/n+mzidx8CqzxgtdfMryIv2zq?=
 =?us-ascii?Q?i3XBAAEQzDRt6F05iqztBIePoF4MoPXdIXncKwWfS9I2DSHmOjEHxhAPwMC/?=
 =?us-ascii?Q?1bQb0bvUk6Sb5CifU0p+60+IDYFVbTknRYgXBSg3w0DUTxOoQmUQzxxPhOgs?=
 =?us-ascii?Q?PVwZk/CBq0AwQ6H2qOhHQWn6P0JWTZ3P9JvCebLGOLkmPLNAFVeM4cRCUru4?=
 =?us-ascii?Q?ExE67Uz6NxVDzTsrVzofJruvG+yqtGlbkjdJIuy/HTqaaGk9mxPUwzMG4q33?=
 =?us-ascii?Q?zZJovRUg8LmAPUAY22/edONRPYcsKahs9B6G2tN8AqYVpBWuxOTKITKndLI+?=
 =?us-ascii?Q?qU7xBCa4CoEYOiEibvAbal3KZwaCmjQwOcsL1FBO1sYHHF41wfZ9xVLdr7II?=
 =?us-ascii?Q?vk2F4zVkOw4mjee0lKSOdlHf2pQOITw6wiAJ+XzwfKFr0TLI6KRgtlqsKQ4V?=
 =?us-ascii?Q?gxyNvDlN2vWBRuGl+c1Dd5sUtBmZq4aYY0vfLU/7wcZDbCuGXnZR0U/lewLj?=
 =?us-ascii?Q?5/frVJqBKGyLFzAgrua5+0EzM2c/nCZcFDFYOvzOGIpqLGfpSZvQ7RnrTyTk?=
 =?us-ascii?Q?Gojw33UyLiENSeEWo08fSddhELiQ6JlnBnZEJC9IFR7LV/ABICJaelH5eLyx?=
 =?us-ascii?Q?0SddoQmdnBg9cL4EH5uZWyR+aoC1R6ygQ7iqvdel5bhMpGY4xq0rIeITZUyj?=
 =?us-ascii?Q?xqMK4G18i7YmvO6EMYLTyUuzdWENqu+CHktnKt/TH4RCFjHyN6v3yAzHTJOd?=
 =?us-ascii?Q?mRNQWCVwhV5DTNh6XjTZ0GU3mxBX9qJH4Bb7YucEAGgQSao8VGphoHmntZYk?=
 =?us-ascii?Q?PwXVcSnirQnz+Geu0XaWhqan6oa/SxtiTA37dkW5D+BJaM/qQxisHEuiAH+s?=
 =?us-ascii?Q?fwvOPDXfRGnwp17t5BYZYzEQDWMa36dr+42UKnjHPNKFaU1N2SWbQU9J7hIv?=
 =?us-ascii?Q?80ZhEUPZGezy/3n7bbIwBAaahtfv0V6wzi41bjUrg4SFYvpvv6N6uJ8C8j3n?=
 =?us-ascii?Q?xadK1E3hzJuzjQaJ6re0TDq4faUiQ+iWiHVVQtUdzXlLY7Rg4K8C9Hcah3r5?=
 =?us-ascii?Q?qMAMIcd6KxjhiB82u6YFNtEW4DBHUTaf9U8mgldhtkMX7R/67dX2Krs1MpZb?=
 =?us-ascii?Q?NKNvaSs9LEbfyHpYvn5PYVFrW9I93eUb7SPf+uqbHUDXoWDQj8k2uClyPOSd?=
 =?us-ascii?Q?ucRcWdoezx+TnOx/Xa/3fgsDjM3Xwk6/kr6gQfpN9XPnJp4+puIckTCojppp?=
 =?us-ascii?Q?J3n86Ej0Xfj+C/AKRFpDS0N1KULaxppMq274UfJKqVU0zREUH3H9CQ1uFwqO?=
 =?us-ascii?Q?dpCgNGyUTm3jtbE49/PdO5gGGf0edYZUX5nrAg/OQh/A8LU/xIqT2+HQ1WyU?=
 =?us-ascii?Q?eQH78ba8RaMRiFBhd3CMoDhI6Rz6x6Pzxhw4AFvkD2myXyK70i/YbBOAHxwO?=
 =?us-ascii?Q?TbW3+KjYCey1IJnFmMkN60KiN41/ha+boMoGMMN7KHo2Tp/7qj5c?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f59c6-f36f-4829-da9e-08df2e6df5b0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:49:51.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM/1Q6LFROVbrRlTpU7c4AjuTLervoOlLcuYNWZKRoJDCIQXYxuqIMNjvKufcIPZEuh+vluJ7UbVlS+0sqWNWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7913

Hi,

This series lets host Linux use EPC-local DMA read (RC-to-EP) channels
through vNTB. I also tried a separate PCI DMA EPF, which reached v7 [1],
but came back to this vNTB-embedded approach after discussion.

An EPC-local DMA engine can use host DMA addresses (IOVAs when an IOMMU
is enabled) as PCI addresses to reach any host buffer mapped for the
endpoint. Letting the RC side drive its read channels also gives the RC
a direct path into endpoint-local buffers.

A major motivation is direct TX in ntb_transport. Both sides could use
the same dmaengine-based TX path (ie. symmetric), sending directly to RX
buffer DMA addresses supplied by the peer. This would avoid MW bounce
buffers and per-transfer MW remapping for payloads in both directions.

This assumes both sides trust each other. The RC side still programs DMA
over PCIe MMIO, so this is expected to pay off for large data transfers.

DesignWare eDMA is the only supported dmaengine backend for now. Other
EPC-local DMA engines can be added if there is a need and they have a
suitable programming interface.

This series does not include a consumer for the dmaengine channels exposed
to RC Linux. Native HDMA support is also left out to keep the series from
growing too large.

Setting pci-epf-vntb's 'dma_bar' configfs attribute enables DMA export.
The default is -1, which leaves it disabled. pci-epf-ntb only switches to
the shared control layout header and is functionally unchanged.


Dependency
==========

This series has a build dependency on the following dmaengine series,
already in linux-next but not yet in pci/endpoint:

  [PATCH v4 0/3] dmaengine: dw-edma: Prepare channels for remote use
  https://lore.kernel.org/r/20260912174023.1227397-1-den@valinux.co.jp/

And the following two patches already landed in pci/endpoint.

  17c4115cbe99 ("PCI: endpoint: pci-epf-vntb: Use a local epf pointer in interrupt setup")
  a5401ce3ab23 ("PCI: endpoint: pci-epf-vntb: Honor MSI-X selection")

Therefore, this submission is (re)based on next-20261019 (3d229ce89862),
with the two patches above applied on top.


Testing
=======

The existing MW-based ntb_netdev path worked with DMA export disabled
(dma_bar = -1) and enabled with the following EP-side BAR settings:

* Dedicated DMA BAR configuration on RK3588 Rock 5B:

  ctrl_bar = 0
  mw1_bar  = 2
  db_bar   = 4
  dma_bar  = 5

* MW-shared DMA BAR configuration on R-Car S4 Spider:

  ctrl_bar = 0
  mw1_bar  = 2
  dma_bar  = 2
  db_bar   = 4


Best regards,
Koichiro
---
Changes in v6:
  - Add a prep patch that moves the control region layout to
    include/linux/pci-epf-ntb.h, shared by pci-epf-ntb, pci-epf-vntb and
    ntb_hw_epf. (Frank)

For earlier changes, see v5:
https://lore.kernel.org/r/20261009045949.1109871-1-den@valinux.co.jp/

[1] Superseded approach, PCI DMA EPF, v7:
    https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/


Koichiro Den (8):
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources
  PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
  PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
  PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
  NTB: ntb_hw_epf: Discover vNTB-embedded DMA
  PCI/NTB: endpoint: Allow DMA and MW to share a BAR
  Documentation: PCI: endpoint: Document vNTB DMA export

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  31 +-
 MAINTAINERS                                   |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 409 +++++++--
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 783 +++++++++++++++---
 include/linux/pci-epc.h                       |  34 +-
 include/linux/pci-epf-ntb.h                   |  87 ++
 8 files changed, 1261 insertions(+), 276 deletions(-)
 create mode 100644 include/linux/pci-epf-ntb.h


base-commit: 3d229ce89862b8e82d71a9e11d6f840ca272a6d6
prerequisite-patch-id: f58157e3e05c3723bf60a1e42744c2fbea7d4da8
prerequisite-patch-id: 9e6690c769a60159d50bd9f0a7b66dd269104856
-- 
2.54.0

