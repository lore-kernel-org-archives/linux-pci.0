Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021072.outbound.protection.outlook.com [40.107.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D642874F5;
	Mon, 25 May 2026 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690698; cv=fail; b=P/2H4xvjPMDxuEdIvG0UpFEBbP9/L5tDeqL6L8o2jQD0eup1x0ytuoAbYfNuaDylTH52AfnjE6aEh5wyDrbzBxey2wWrWhs1tA5CWV+wIqDipBDsIUqx3DG01jN+5jghyLURDUEQxD8okDKMPQWFHHTFR9HBK5RC9Y9t66Pv40o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690698; c=relaxed/simple;
	bh=NDXVM7MIOJJ5PNfnO5fcHM0INrRGO7IU97xXv8SAi70=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FJ+KMJtHdoJ/5vYTBW31RdxzhQzGXPsrpDMssspbkIB0ecCGpvsQjGkADQ6Lfwm7/ZictGUVfnCdGiNGSvNBLLZQ9lnRAOfe+yM1/Wu/5R10d4gbwWZyE0zYYZqjKgoMrl1iSR3xl3py6fDBFRwXdf6KPiYtQrANsJrSkYQluGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TnnyRZ2J; arc=fail smtp.client-ip=40.107.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TnnyRZ2J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFLAn0Kh+vwoJbRoMKzsxIyaU9WulAYMAjFxfu1Jk+DoZEVpMQhvqGu2gFZywwESGjm2AJDA0JexmAR3LbJAfxdgPKkZG7YjsFgkJ30IIlAZpaiR2eChutReVZcFxitWSJWo6LPaZnNH+wpiW9gUhJjo4NUPtjNkdDr4tnWifmFTfJcRnsKOGDVNsxcZyip4LR2nLZ1bWhnudFyiOePZlIBTZKXalwU768H/NoDtp/fVTpX9Ojr88bfnenlB4i3wlkiSsBDDiojjPrvmvfRhI58jZpAybshQ1lPr5W3Ycj7FN5pqY+U5EwIvIia2PwHG02sQITS37ptBOrMS/ycl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YppE5mq0UfpgjlB6uxsmX/+NGzD0X7myMWFvOObRcXU=;
 b=fNLLxDvAVv+k1BFGLSIduNOdo0zZp0evfTOOXztMUOgyqZcdrxT2ZoVlioxEuUtd91AHO6bnALLIM29NkZRlNWapVB9rvSnhuedhRXoNtWwniiFGGlp26KfdKLfmrMS556WmCK8r2QVlTDJmVWLGVNmJU/ak1F90zalNeS6OBlm8PBpVLcN375MbTFBsnIsBH4DAGryyemUvv8+jQl+CgQj9rmXPMJ50gzrhmKL0LwVl1n3pRcpZorXKxHgpiU5cbEdkZOk0n5q33xmR38tSwvBPZUJLHhe4QmsMrtT9mtRIbylBZ0hZpHtWiYQaUkQKs59wcpVfGrHFckCdJQwgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YppE5mq0UfpgjlB6uxsmX/+NGzD0X7myMWFvOObRcXU=;
 b=TnnyRZ2JYDls/Nn9NixkqDellvKzxZ+zhw8qFcHqz8znv8eZmQBlvKeF//uuBp0SBMOPLuYZgRsY2uRVsk+lky/odLi6iuc9FafGs529fjoMIiB8T32n5nm4jd0i+5EVOQD8d6ITh01tsou/+4dIsErOSKspWPcZa7EY8SgsY1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5843.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:31:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:31:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/3] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
Date: Mon, 25 May 2026 15:31:26 +0900
Message-ID: <20260525063129.3316894-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0231.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 1396a734-7c13-4eca-6e47-08deba274388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|6133799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cLGTsvvZqIdWc/JiddA7QC691LU2EI3mq2T68mCvunptLbR/uxs9OIueSdWSB4Jsiagt7/iXnG3WYrGfBxDHqUyOjvfCBihC446BRtzfWxzpDDzsiHXTp4fQY13HZfO0pK9QTzI5JqN87U1vfhLXqheitcwOakttO1sx4VN+ZamyMNNwbF8rIfZDQ32W+pUfm332Wah0WTRwiBkz7b8MRD4aYB1AvpaTio9HhDCheVWPESyz82wBxR6FOyUZaDQHdl0gOq0SAIFONlQhHC/X83TN/sklF/tUeZcjb70FfE6nmKV+wfa04mnt2MNNUitYx9DnPXN0BEVQXyyU8q5PPuXssndrQOkRrJJIoxInLsNL/TM2QesNJzz5NLKcsN8S9MUpuLqViI4zHmJtX5nEg1v9qQo9sZC6+eNx2n+410sfZUJUtk73uibzPrNeZf7UTDErjShKigViYhwUmlaQW9+NzeEmEXd/YeOh+ZXZVsFkR0brqHsYcvpNnIanZSdQRuVBfzcW9yKbCkgxEEdXjpOpnRwGqv6l7zFGaH8X4+1HFr4fZQahQeS6w3WRCx3d+gMvDKvoCb2bvnHulAiy7dXdA45xuFkWiSW2BOs6EJAOyGTWicgccfIIUq4mX1xinzzgrPwMgPYpKLKW9krqIUOyC+cfZFD2iV7XxE/HnDx/bJcHiMKOsg8JNIfIlANoSHHmzVtU0M2GDTc8cCbDEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(6133799003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sCNZM5gnyhTnX2ZpMs7DbWVihaUgbuuVb6rzB8B1AxY8JqEm+G6ndgjA+Vmy?=
 =?us-ascii?Q?ZH37FpW5ekdsz/jzYA30XnQKRSVw/dYTdPfE7xdrBIgD44XAAzdQ0fdt8fgv?=
 =?us-ascii?Q?RrfejdVxEfXIjsZHHbhiRi3Ck+C9v43KF/j0osqBMSOsfH4RQR3mwcKiVRom?=
 =?us-ascii?Q?juj9OmTip2j5oJJTNYocIeB17t5+uH54Y0XqtTa66Hl1j6YRlCrEbbqNczqy?=
 =?us-ascii?Q?LFRjsAHJy2TKiLyQUsYYyjzRiGze9srBUCG2SFb+MgZm8l/eP/dtjviTLzEd?=
 =?us-ascii?Q?KRR+yp+BA3Y3bbd71Aa0PZ8EMI/czssX+ZlbpIA/cP8tfeCX7ORqogZRAl55?=
 =?us-ascii?Q?wBvhZE5y74je3EPhIkeiMFdXFAhTnypU2Zy81sd2a6Z2j03VTzauhTfz6LKR?=
 =?us-ascii?Q?dPRmttPzJEswbPF0dno3xwHpPkAPQKj/V4XHL2Thy65Fzk7LXxAGIle2XKV0?=
 =?us-ascii?Q?3PE42tAAV6I5/121Mh4hdl5RZzbNsfdJCBVWfdbYG8WqMeuOag/NTjdGx6Av?=
 =?us-ascii?Q?rIy5ZXs8haqo82y2xhTHC5qZusqPK+iHnlbOR8pFAbKEMsN+wpUUe/DAqO+6?=
 =?us-ascii?Q?rtsCtszFKCvXeXeTxhkWTgBHmcMAugVJCrSqKbpkY+AKnDV9ZWZf9yrxAypb?=
 =?us-ascii?Q?5LbyQ6QhNXBio2WYlesUYxMsOg2VDPmurYiHdJd7QIPKvPnzsYsluXeMBUsP?=
 =?us-ascii?Q?922JUbRHVBB9PaJ6Yg2X7fAvM18TplUGN4qHICzVErAgNHtGScE4o5l2db1c?=
 =?us-ascii?Q?f1wgv6iGgL1bIZ+1U9CHj2ifHvJpH5f8HCAZG83zxxJROftQckJUKjFTFA4i?=
 =?us-ascii?Q?ugaCYOtjzhsLV9Twulew64Xp/ONUDhsUQEht8R/b8V0xRm0fv2cBQyzuARvM?=
 =?us-ascii?Q?Qdgteq2VaYdDdK9tRJPEeuE3nKcILVaKEpTSMrL+9hGMEgphPZYEO2r7EPuZ?=
 =?us-ascii?Q?hWl0lTu2wGX1UEXLAz5pEGSS8Y+LgN9N/wvMEOpcqm/UVwo2ndDKUdkp6XWO?=
 =?us-ascii?Q?fU4UCHx9we/uEf0I3hzFoNEs0wStLBkp1Ux0WT9lz3vHS671CQQynabvMvTm?=
 =?us-ascii?Q?pi3n6PAv41/1Q9tOmEMg5ELzwespYyZQgSQRk1sO7daqlK98KKZXU3eQqZGk?=
 =?us-ascii?Q?RiH8FFrTCVTYXt4lQFcmhuwfgdJ6GpJXs0kkX4sBv+r96TY2TN2KBpi66atY?=
 =?us-ascii?Q?gJevJ66R5fLUhz5f/qJrzbDDJHOVyFHF5HHgZ1ss/dnqm/N9EAQzGkqqu4gd?=
 =?us-ascii?Q?iJjXS/VmCGD8AqmTQ7Az7DXxrHJMIOIQ44qsSN82WNSwYpYZntCGCojiQQC4?=
 =?us-ascii?Q?iDyaUqU6x7Dgma76cfJJmLcO7LqMpQiW/O0JDDGKC6IYBIC4HXY4kjm7bx4p?=
 =?us-ascii?Q?Yq5QMw8JU9cNehL88ne1iOuLNAsWJ27qQU60gGIZkqr2lTfKXn1ZTxEU9O/Y?=
 =?us-ascii?Q?8v4w9OupLjN+LBZ5DpCeGKqMNKp7Ks/XekCqge54CCPDEscQDOHacJtdw1dU?=
 =?us-ascii?Q?gqVyIm+BmL9/5Kjw7P8XV86ZOuNeU3Od3m+CJ7M27yVfanPnfyQQ+6KF7UGO?=
 =?us-ascii?Q?kNT8Z0ajIuexV0bWmzdp/R9Rv9Ss8pQiqh/l2Keh5bxjFp80OoxW1pZg7UA5?=
 =?us-ascii?Q?8SumHbmtfg952IU3nTo86bECXzBI2zpYpJwfntSpNHDOTBT5tMKHcO0r5N+3?=
 =?us-ascii?Q?RYZK96LYiaUtXK2uqyXGYuAVt1kq9GyVzWwfM0Nx9D9Fm+iBrw5ZdWUVKREg?=
 =?us-ascii?Q?qBh9376JY6qsiCPNZ/eehd1nTJoJesIwjQrsJvJNLHEDkLJjKwj7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1396a734-7c13-4eca-6e47-08deba274388
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:31:33.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eF612DOwy1ac3XEfHk2OdF6b+/SujbIJiXQjrintuHOvDuEn8lUeVLD0zb0GoXaTipWl+GpZcZoOQOBgHJhe7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5843

Hi,

This is v2, part 2 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series adds the PCI endpoint-side pieces used by the endpoint DMA
function. It defines the BAR metadata format, extends EPC auxiliary
resources with DMA-specific resource descriptions, and teaches the
DesignWare endpoint controller to publish its integrated DMA resources.

The metadata lives in a normal endpoint BAR, not in PCI config space. This
keeps discovery independent from controller-specific writable extended
capability storage.


Dependencies
============

This series is based on pci/endpoint at:

  f5aa97125491 ("misc: pci_endpoint_test: remove dead BAR read before doorbell trigger")

It also depends on part 1 for the dw-edma channel filter used by the
DesignWare endpoint resource provider.

  [PATCH v2 00/12] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/dmaengine/20260525062420.3315904-1-den@valinux.co.jp/


---
Changelog
=========

Changes in v2:
  - Follow the part 1/3 v2 channel-claim model: EPC DMA resources now
    carry DMAengine filter information instead of raw DMA channel
    pointers. (Sashiko)
  - Update the DesignWare endpoint resource provider accordingly. (Sashiko)

v1: https://lore.kernel.org/linux-pci/20260521063405.2842644-1-den@valinux.co.jp/


Best regards,
Koichiro


Koichiro Den (3):
  PCI: endpoint: Define endpoint DMA BAR metadata format
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources

 MAINTAINERS                                   |   1 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  91 +++++++++-
 include/linux/pci-ep-dma.h                    | 163 ++++++++++++++++++
 include/linux/pci-epc.h                       |  44 +++++
 4 files changed, 295 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/pci-ep-dma.h

-- 
2.51.0
