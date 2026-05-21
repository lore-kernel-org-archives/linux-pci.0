Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020080.outbound.protection.outlook.com [52.101.229.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F42609FD;
	Thu, 21 May 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345258; cv=fail; b=Bx+7zVsTZ7Dy916uTggkqVOU0wP+BzsK1al0iMgcqH+R3ICX2lmSCFyPtk4WMAY/SYOnUqMhtr3s+nl4Acrg8b7rRSZuu6ZHpWZHaYGSDRM4kUbmezHMi9twIGcsrbqI8hJr5gL2Utja0C7IgGnoqqfn4DqqdQdYSUh9rYz2gJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345258; c=relaxed/simple;
	bh=6euQejS0kf53duDE1FWvOmjIzxMXfdXbli1teBBJxo4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=baVlRIYR9zJ5PfD6IOcbsZTnN0TNu2vJZpare54y2Xhyf9rj6iuYqawweDnElHA5kMUco0/DKuYFebQSioqBH9wY7gH1Z63Wv7gNiHdaZUl2s9X/oVWNApItSvs0eSFRlE4VsNDb2mxyXuVHKS2eQ9PQ0nlMWb3CWPrEyj1fQuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uZQ+VrBO; arc=fail smtp.client-ip=52.101.229.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uZQ+VrBO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWiT/EPq+eV7awmlXjWLFmWQIh3moxfEDhzc0C5xnpOnjTblSPhZSj2lhnMNW0OG4+TT5iwsh/hl109L053dYErvHk95eQkItLt/WnBYJovqUylR0/CND4B3R9WVId83p4pUA5sKzjDHlFiIXRpOwVe/UJt8IVaSgfrQb3HKrmjpnBuYngAWTDgk7/5HDn3c3zgCWBYS/WiqfqGdKwNxGtPyKHhxaI/UVhRxKPr+r3R7YldZ99oBDsk7ZWgGre6IMzKFRNeBcIaKc2i6c3uRxtbaAnYuB6xdcs82hQzbB/ZewOYC+3QP/GPKdy6Tplj7AhrNX33ui7iIU+uAXry/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n491aW76ceXuwOrheCErE/gyQvLL8THleAvd2nVvOlQ=;
 b=PP0MPaOOGQev/g5fK2Y85u/zad8NjdIQ2lINccERnCUQT1eF7GycG9YqEkXnIcdCl5yhkcLVKbzM4UTcvWjWARW6S0cEQSAWgI73KrvToqbn8yh2ErULwI5mqu0PC/XFj5GUZBIHMtJSdFpBrxdR1LLfoTMaypHENlPPWJez1Z6c8wL15RpDGsN9z0MB/qMA76lQAzu67NDl3bMM2+ttNNMBJMFBWndGCRLsHAnzionUHLctaW/Tdfek6GHTuda0XGSKicp8VnjOiG42IGD8ZO8NyBRM/8cNVHR8g8FvxEjhwWGg8EceLmoXw+rNDBG1z6ZM/jR/DYi4bZalAcHtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n491aW76ceXuwOrheCErE/gyQvLL8THleAvd2nVvOlQ=;
 b=uZQ+VrBO41g0as+4sJM5w7BD7RoA2is+eODinwcWrYA7/ow/1JJDqZHWRtf4sdQgntWf9ImnHm5v5iUjZMGUsNEU3v9SaMNsFJt3goZo7cDeLhI8LFK/oZZBpy7r9+sl89U8SEIT35QWJLUQF9Bt5Wk/fBDfrJ8TRw6ctObmuJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB3955.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:34:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:34:13 +0000
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
Subject: [PATCH 0/3] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
Date: Thu, 21 May 2026 15:34:02 +0900
Message-ID: <20260521063405.2842644-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0118.jpnprd01.prod.outlook.com
 (2603:1096:405:379::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: 307d9fa9-dfb4-4b46-a606-08deb702f973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mxl6rAs9ar37mBOW52sIl9KHkoUQiaQQ481mbXlaDuw/QzZ6NJTaKrjDeUJruclpWgsou/6CECkIyram0i9OyaCBhKnedD1oCpY/b9EIltVxn7EXulRDnFlWh6GrhSlu9Wu3I/aEhqUqOkNXY4OsculjQTamLBc9wvOyUV2Y1z1UCGyrmSsjwETOgw4Nv16IZhUueWJGnurZScAywpe7lsqzzLNRDFKv7c5TbKPVBXxbOVJ1ivXsAFUjAqLfhC6vXcFclsBGnemrDznXNuThtrPOivccs/6alcZ17tW9IMurRQKikWDmZ6jlJDW+ivgsqrraKrzUJBPPG3Jlt4OoDBty98lKdp5O5wG9PEGYDlnpBSfQAWLDiRv3VvLQtvDrowdVvPkIXVa9I0fBNgxv+fQolpOSt2cyf0Mg1Ru8om8QJdh+cX1Nvm27mjZBLz2FV9xFTFLNtQTbgt9yK+ZErO7FfzXb+hHPFZpnhTvLSCuHroZPtjuaGiiEsQ7a/FDK8upl7+J+iNgnBpFbTpEi+HABMcVoBznbtlBsKRziaiL6Ds4HVe7FN1nECGEWFopooVrXGNQ0d3SS0mi8RHJ5aUuK4AMK7FHiyVUKH5GMhf3RvdokZZmEaHvonneqcN+H4lM4+vnuK+wgetC2p6EaPN0PBA2RQDY1n42CSTDBCQDf0G5Ei6Vx1qCuleET85rf0cyAw4vAWEvrUfV+NH1ZAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(56012099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTH98PQaAmS045bqvB0X0F3qrMjKij8qF9Fu1NtTfgA1XCM8/fsPt0XlWdI1?=
 =?us-ascii?Q?BA5fjVdi4GAFmE9yKZs38rsou74LqmIWMVDnC8omVsFbc4S6GZw8MpgW8tBv?=
 =?us-ascii?Q?dU+K3j9jTT4b6BvCUNp6YQr4a5GXJV0NBaETMdhycUhYNizpuI/c+V6BLZxE?=
 =?us-ascii?Q?CuuHLGQf1fWEZrL8TURqmIC3ba+KPea0CzaT2urg4ZAKoWAJbAKvPj+4VZt6?=
 =?us-ascii?Q?/MVmN5mlnaYt7dozr2wxqKJck23oULKF75Rl4DxojZDYcbKhhcqM45CFZV7Y?=
 =?us-ascii?Q?7tEW6lbgksTNPkcGlJ1SmmsDG6nJ89Gmw5vWwJdY2t8Dm/umelPBbFUA1cKU?=
 =?us-ascii?Q?4mTlPWEYckS+Q79BJeA3VlUdF/h2RgYWrddWrl1Am3BT1iBmOTqVHPDtmfL0?=
 =?us-ascii?Q?W1kwJqOLexWdFRtmqTeKeikucnDUPFOrisCCfHwUCD/qZiOoE4v1OHbqsBIU?=
 =?us-ascii?Q?MiSNI8tMm3Kbzl09CoZr7IpyINlNdiLmbxGOuhuEJI4Z9L1vu+rOmi/kvao/?=
 =?us-ascii?Q?L1dxRdI1c7gtT/+OR1BVXksIAPt8ZNl71pRVsJpIN4521fgzxDpNxl/UzqQ/?=
 =?us-ascii?Q?ieu2xE4wbIS6aloAd2PMBSucgwrGgw7gblmveR4oPWv/6SbBT8GDqIdl1TY4?=
 =?us-ascii?Q?rFx0VMufxBg0VFtzyCNPK/csuOkffZ/kCL2GCBVKQujuNO5rrRVvqD9jcz9Q?=
 =?us-ascii?Q?R4YEFXRTw44aK10saRDMyQYQGE6CfSKfvDx4S2R6BMWg3SPh8hsfdmtV0d03?=
 =?us-ascii?Q?H5StsMKEJn+fiHmtBS98q3249aqDjWKCHozZ2llFyPci7jduqVWfXOgmKj8x?=
 =?us-ascii?Q?AhOICynFw1ZptlO5Z7VaZ7zn1yOvgtJH4p2nvxozFRLhbwgiyIisdWXR/Yas?=
 =?us-ascii?Q?nmG61RtfF0GGVUczYelZbTRh7x2vkwfjsUi/C72emSSE24vos8jPq97LsO4M?=
 =?us-ascii?Q?yGLrM/UrfExpSErRvT6ASS9ul/3mHtcPJCHwpwuvjFj4zpGLzr2+zXGQCuUf?=
 =?us-ascii?Q?3+CNhKIEUycBvr5KQfR+Y8ltIbb21e8XzSQAUhg2qI3Mfd/vZEodBQeYAIxW?=
 =?us-ascii?Q?wJs6T5jDjVl585S39OwG9wp6QJZ/TPHnI+J3gtYHdWDxbyZDqlss7TL0YZgv?=
 =?us-ascii?Q?8KTz9JekVMizGb4e7AIdV3rfK9kV4BBrOYPQ+NQnJO3AkKE/YoVP481yrOP5?=
 =?us-ascii?Q?zQVbb2k1WCjMNE7+pj2YcDyoSmqyN4pW++45Ylmy6g6Zg4lewu/9TYRwOWyI?=
 =?us-ascii?Q?xCNBK7xNKeEB3LiAoGz+Pgnz+QeBBDvzGh3bePbqFPaRr8QBQqIzdJXASJcU?=
 =?us-ascii?Q?HmCo5LCAMJdkX7c3C9VOxXwcjl0cURTG6I3p0ohwl32YXATkSpuPLiciBUoF?=
 =?us-ascii?Q?WnXqFp3EFuU5tzQqH2dX/Pyciprvj8yUOfkkZCIJlpUGl4HaTegzptJAQ9jM?=
 =?us-ascii?Q?8Gi6eCH+MmodOQq7aC+mbsfMhGVLM74C1ficwezpFD6RfaOmOIk0qe/17yAF?=
 =?us-ascii?Q?smoq9ka/6IoSJSjKcHa325qfxe4n4Masn+0cqXQnoBHOcaPFJc78p9n33E9S?=
 =?us-ascii?Q?LXAWmJg++txEmB7tB5liwBVcu/gseJ4G0N7ivWNWo9TmhVEBKD0FvIRRy50S?=
 =?us-ascii?Q?5N1PCT9ynpflfcqK9Ayq0x5CxmamKqOegCG4dYeUBbJNFLFmEREGBUmS5Bp/?=
 =?us-ascii?Q?siTIWH/c1G+z47KvyjAwpupDAXjuowkouhKNIqYUM95XKnVDMy5fp1w6y3Ru?=
 =?us-ascii?Q?zBRw4ecdSBbTyPjmrNokycKTpNQxJ/pL0YBfgyWtWGbHUimz9LHS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 307d9fa9-dfb4-4b46-a606-08deb702f973
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:34:13.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B/uSogVK1WLBKiRAXBQOgqcrSJ3GqSu55uPBjAJSggyMaGLEjk2u3nT7NFsbQBFbpeHd5WCK+R4ISb0Lthcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB3955

Hi,

This is part 2 of three series for PCI endpoint DMA.

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

It also depends on part 1 for the dw-edma channel lookup helper used by
the DesignWare endpoint resource provider.

  [PATCH 00/12] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/all/20260521063115.2842238-1-den@valinux.co.jp/


Best regards,
Koichiro


Koichiro Den (3):
  PCI: endpoint: Define endpoint DMA BAR metadata format
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources

 MAINTAINERS                                   |   1 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  77 ++++++++-
 include/linux/pci-ep-dma.h                    | 163 ++++++++++++++++++
 include/linux/pci-epc.h                       |  43 +++++
 4 files changed, 280 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/pci-ep-dma.h

-- 
2.51.0
