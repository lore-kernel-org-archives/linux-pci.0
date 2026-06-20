Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021087.outbound.protection.outlook.com [52.101.125.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95799275870;
	Sat, 20 Jun 2026 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975098; cv=fail; b=sD2bJALlacH9CRCqFK/ujw/2ZjhtAXNW9JLJjBJFmgmmkGX2dCsHXWvfd4gq1J9OrRl8GHhjnQ3cqYihHnZ2fVkZddaKalbI7iKtM2IHBFWla7U/bbwoZb405qVxiHrVuSQ+somV0/GiunRpmddmPyKX2AhUgPxHAXnQP2Nczh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975098; c=relaxed/simple;
	bh=NnmQVhindLlL5QO+YmFUjlP6609gkkHRroFZCT6Aa2A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qBJN/8l1h1l4JOK8xcMBK83k0LbrbyHMn56JWRIrslf1QzGzgM6E+nXofiUi/t82AleMYef3IX0ywSKLLaD1gnE7535KwnNhv7p3JFZjJmU01az2ZnKK84NXBMn+AE6YLumyylVyhrCt/IXpRHThMFPElY/D0n2GLcki+MxR7jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=j4E8iWHv; arc=fail smtp.client-ip=52.101.125.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="j4E8iWHv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAHoweJOTstfXviYwYSiOZscq4bgF4h0PkJtFZFBxEJgD5ZMBuDLKmCgUYwjB8MocfgL7WssUw8+mX8jOcBoa7dEB98egzJSge8A5PjiLyFiq3kxv6Z7VqAAUR5G3or/4fwbLnf1iWzgVrGNFGprpwL/W/l/MS7Dh+B/uLEDFxRmXetC4deRsT4R5QZiSlEn7BPkonf4YDhAHX8imC7FpUcyvH75giIqQk4N02A5YZa/DsNdGK2LINIS9f+LcVu6FKodrV478zf995I83TS78Y4Shz3eI0ysW+2lBt/quukMbzwVXQEqqyj8tFqNYwOoyAJoAVTne2aRx3wPY93PxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZXdccyS0S1d6YQC3GqmaXhFE4C9jQ1H99vd4f3uN4M=;
 b=gU86wyUYgn4t6f6dyVqXPt/JeV56wVyWDvRsEqX252621tv/c9o5D47vtdFtJxdNARGrwiVMXRSCD27mOkSwtbwnynVp5HDspKMk3bkMLa6hA3pmlf0MsOLs2mTqSD4Kf9mGvfHFPoP1dn+yrKgufwHOnaElc2kzFWJotH1kvK9d8PVQeJW/Vp9ssub+Ja50Om2oaNI9wg0OuYscsQ6SmIVBPZMa+v3mkEIVRQFE0/PqCZAbvnY85G/0ZVXRRFMKKkIl2kDAHKlyTuHS1hT3B2/qIcnTRCMD3Ri0aJLkKP7Y9gTPXh0ESgIo7SU9tzDrXVxDeG43ReOGNrn2bLqqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZXdccyS0S1d6YQC3GqmaXhFE4C9jQ1H99vd4f3uN4M=;
 b=j4E8iWHvje3S0DLWrXVEXTQ/5s4YbpoctTdpSi+RrDhRY5l+8HFHvgeaXpBc4F1RlcmImEmYSQImC6bq81pKeuL4xA4OLQEx965UU4qKI2iZmDpJ7Y4QrEU+Tp5w5HytGH4WTUNVpnG4TRMU+mdw3cGXsIpke0KTiv4tk+y97hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:04:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:04:55 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 0/5] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
Date: Sun, 21 Jun 2026 02:04:33 +0900
Message-ID: <20260620170438.3756593-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a6dac4-ac85-4ea4-866e-08deceee0d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10070799003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	27YT9iX80+caEyV4wSGARn1EMkVJ49pYgbqVmut7DbzApsREFsNd1bICLOM5GhICpguebYM8G5NzEhvf9l0IzZEQlIMRxgw3a1HtB4nXv65CpPfb6fFZP6NmZL/4ncBFSfd2/aNVid1I2oeJkBNKArTkkhWOZqHx0IQ9X4BqxMoaVYtJGpXOx/+wifP5lMwm+ALWbbjgktgWRcNZGt1VE00Ystl9Ovvuq54m8g8y3OUJuyEBowNxUx3RwoZ/nKcFxKg+mEThr1V/7pu/RhTNfEc6Z7cB6J50buStcDLtpO/CvCUDrHsE+DJyHPg9mnyknN+4TsyAblMztbjR/vWAt3xP39LxKQ80U9R2CfWUT9I0UGsYqg9KOFkFjxd9BM0Vvycg5sVKxUnhMbVItncHkdmWREYoJi+MjjPP4a3qBrlxxEjmEdzBu2KRNXV/fqJgO5nZRnpE3SA4eNzNfnbQmWRfA0Xgg99M+5BfbvWkAPp8MjkHuQySf55Lx3hzURhpogehBvA37WziTRBQFAswE4CejdeLM+Z7mLqf8nOyWfUiBsgURaH7HsXd5t+wTrsdr8IF/YBK815WjB0jwMfRtggbCfJn8CxOey2IQc2gT4AFT8C5rP2jM0bjROBWy8fwyTKwRC0Ja88YvSxPIm0cPR0YIUnl/pQXE1ZJB1FfhRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4YL5Pq6MqQSmJAR9jQcz8nrBX3icGl3kunvPWH59YX+Nuc0/XGeZMTtH1xwm?=
 =?us-ascii?Q?iENLn3lBrs3MilJsZOtozn6l10bGGI4y1DvuGIci6e47UcMfVSvob3gnMJ8V?=
 =?us-ascii?Q?8cV5YWlSLgbdRFo8RGIgqnnVh0BjOuxhKiMqaP3LWbEsS6y7H18iQ0oSpNgI?=
 =?us-ascii?Q?moTTsy/ig56D2WEBBGG+2qWUJo2sNp37k0nQWl24vcxZyRZwNdsvZwA9/eoJ?=
 =?us-ascii?Q?huFTVzVyz1hluSaq2F6h0Lfls4Vmgg7+TTmc/XFP/4LCFY0tsvLd3vDhdfub?=
 =?us-ascii?Q?3pCD3MAUXqgxH1NwJtQ1THdPLpRfPdF55agJ9XgWhkD19k5f1IZJyk+6bStY?=
 =?us-ascii?Q?Uzdw8rrF/Qffrf/oM1UOcO63OQlOf5WVHusFLxXIwosx0nSjuLgd/SAJyMo+?=
 =?us-ascii?Q?sfAw8lWw3sHFWypzX8S/I/h0dGAOBisPY0gxl7Ugb3/+A7nGEOkI9nCRw7b1?=
 =?us-ascii?Q?C+0kLGmJbW9dw7WZzQGNMjYmkfUkzqZ1/PmaT0fCClyO7N0b8rmq0NzA8hiV?=
 =?us-ascii?Q?tchkF8CNeIO6oa39VJIe4bGBdqJzndIaRICZXiI4FlaJjPyY+RIA9M3duOjI?=
 =?us-ascii?Q?8/56Uwd5Rz3VUuhwkh+ZwBH6mP5/Hg5PnWwb4OqQ6yLYfomsy4MlrXpFFGFJ?=
 =?us-ascii?Q?YZtPJMM1gJn/uzd03DJR6e3BBglepPvHhLpJOCXBSWX/m+c+tZIaBPl5RG/s?=
 =?us-ascii?Q?qK5EOY0rqZekbdcPJvN1+TZsOKmSRQws5nL7drwAa41lkSJuITdR0O7pX7ux?=
 =?us-ascii?Q?KCvY3hYtF2EfMEBZlMJ2gXKZ577pM0G1JekYxsUAGZU1glY1ELHoLC9vCDBm?=
 =?us-ascii?Q?8bS8DzBecwvhSZu+a1yxnLcpAWrIaAeqxccW2yLk/V7RA5QtQrvQ3Dhc2LrT?=
 =?us-ascii?Q?r/UflFsOvXX30WJ1W7dqmw9wnZ5QqiIdxsYJDgv29TXwusg71wXg0LwZScrh?=
 =?us-ascii?Q?5zjoJctfArAIT6uqBB5KDfE1Nto62DrRZ3C/6NlFM6DaovLRgVFKg/1oUWPq?=
 =?us-ascii?Q?8L2y/LXupH90m++kMY7tnCcf7AF/mLFktA52Tf4DSQ7aXiG8R/d35cftZsgu?=
 =?us-ascii?Q?GtMVzrzIYObk+mFNdAjIqwlwlrLL8CNdLF2xYDUPv/OiulqqNpbWueZPGHDe?=
 =?us-ascii?Q?ldxhpxMoFxhFjjom7gBO3tvKCFcj99OfszafqCVHN5kqJNG9qmFtrxU1D/uR?=
 =?us-ascii?Q?r+ky4PdwrFao/Y8AbRs2f/gnC9chV0AhHXYBs92IS9RSmydOKvcMb4Me24On?=
 =?us-ascii?Q?kXRowyxDQUuGrE7PiS6HBaKZYSVJ5ZpN5RuKbrznUYMho2Hsn3tfB0HeNvt7?=
 =?us-ascii?Q?Mvid0P5ziVUPrpHIzCvkraWjG4A/6AXT7OuXJEAHOrj8lplDkfqtPZa4dSwr?=
 =?us-ascii?Q?gYbXvBM/G6A4Bx2Ayk1K6GaxXCV7y0EaklLJ8pt6wgOY/WByc5GosnXb67tN?=
 =?us-ascii?Q?uKOAt1xGTkdmb8b6z+VkuQDdA8Lwo8tuLBr0cmc4sraYzgslmAdfRp4v6+Kc?=
 =?us-ascii?Q?4cF8X0sFaCp38Klf/7I2bpYY+R7WjRbjwc4n6LAmBfO5ndG0Hflx9wmx0r6a?=
 =?us-ascii?Q?vzONsZDlz2IKNFzwuhPng851sFZg62mm+IddbBv/XeYQRu+yAVCAZ9GYfIbY?=
 =?us-ascii?Q?IVbNtGMFLaqQNi5pOePl5BPh2/diFdnIgeet/ZKXqEzfPkqQnXbXLwJSLhfJ?=
 =?us-ascii?Q?Ey/XhsUtelKctlZlHQ/1yUjbM2Dr6fa0DhLOwC2iR7Ur0sHkF5xu4V1o0SP+?=
 =?us-ascii?Q?kwn3LGgCRkuFuKjjefMnFye4ChQAOIXsMCEQcF33ZnsO7Z9HHMtc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a6dac4-ac85-4ea4-866e-08deceee0d78
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:04:55.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/yIvbzCAGYvZJJEGO1PYhFNT6be32DxCfXMRHRKc0c3u8bbFpDW8UY4MG2dSftLqSvHdmKrUWOhYl0k/Xwn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673

Hi,

This is v3, part 2 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series adds the PCI endpoint-side pieces used by the endpoint DMA
function. It defines the BAR metadata format, extends EPC auxiliary
resources with DMA-specific resource descriptions, adds EPC operations to
delegate and reclaim DMA channels, and teaches the DesignWare endpoint
controller to publish and delegate its integrated DMA resources.

The metadata lives in a normal endpoint BAR, not in PCI config space. This
keeps discovery independent from controller-specific writable extended
capability storage.

Dependencies
============

This series depends on part 1:

  [PATCH v3 00/13] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/dmaengine/20260620170040.3756043-1-den@valinux.co.jp/

---
Changelog
=========

Changes in v3:
  - Decouple logical DMA channel metadata from descriptor memory resources.
    Logical channels now refer to descriptor memory by resource ID instead
    of embedding descriptor metadata in each channel resource. (Sashiko)
  - Replace the v2 DMAengine filter-callback metadata with EPC-level DMA
    channel delegation/reclaim operations, keeping DMAengine provider details
    out of generic EPC resource metadata.
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

v2: https://lore.kernel.org/linux-pci/20260525063129.3316894-1-den@valinux.co.jp/
v1: https://lore.kernel.org/linux-pci/20260521063405.2842644-1-den@valinux.co.jp/


Best regards,
Koichiro


Koichiro Den (5):
  PCI: endpoint: Define endpoint DMA BAR metadata format
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: endpoint: Add API to delegate EPC DMA channels to the host
  PCI: dwc: Expose endpoint DMA resources
  PCI: dwc: Implement endpoint DMA channel delegation

 MAINTAINERS                                   |   1 +
 .../pci/controller/dwc/pcie-designware-ep.c   | 192 +++++++++++++++++-
 drivers/pci/endpoint/pci-epc-core.c           | 100 +++++++++
 include/linux/pci-ep-dma.h                    | 163 +++++++++++++++
 include/linux/pci-epc.h                       |  61 ++++++
 5 files changed, 512 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/pci-ep-dma.h

-- 
2.51.0

