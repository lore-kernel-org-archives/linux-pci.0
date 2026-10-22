Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657356;
	b=jaEX9I2j1CuN3TIz89+z3qyr2FT9EfHEv5fw6adRsecDUCZ26XdiIjCsKVlefYLVBt8M
	 PFjQSb88v3E0j1wX2pkQHDMXdgmj+xY+P14QpmA25Je0XNBBXcTpBktwC5A4d+9PaLijd
	 bt1vxc21liNcrGqw8xWU8bm8Znf+VvMfsTt258iLrxy9LcxYxR65QnJfAxsYAOmDwoRMO
	 oxpiJ7dLzzJ5Huxx7O56XgpAJE0u5uJY8d2j2fgONKErlqwy03Maf4ptjTNj05cxWEVeC
	 NOjOQgvHhfm+epb1lZyQ21t6ONpqW0+fnbpEalsAB0qRJDlwKoE/fVvlslbkY6931bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657356;
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
	bh=bUlrYIl8YkaAmq6Vp9xo+/oYMPzAZQdQRqM5rWh23wo=;
	b=yjZ8r5dfTAWlSGMfaCwvQnHbFm5c3nj5gUo9TlnPOQhwrEnivlimx1NjRgC9Siyg33JS
	 f16Hu4v5+15obzzyx494cqXaKlRvpTwuTsM3tqAY+aBz1KIF5GptpBg6H5+AQEVJR3S2z
	 UyAh4XOJRrMhB473MhPdMAoJkY/MMFP0itK8+IrRu65nJ8KnMZUO3NEH4haHNoTrFyW0Z
	 Y56y8x5Qv55YMrt206L2sT5yuxybk3c0wTGnzhDmMk3PFjvARpI2rxfU392U6bQhLqQ/S
	 ekaduV/aHGGy8nAIblZGQJZvMhM7kKTll9sNG9MqwHfxbZ9Z4xE9CinIYh578pJtQKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=fCuHr81O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.110
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021110.outbound.protection.outlook.com [40.107.74.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37A606A319;
	Thu, 22 Oct 2026 08:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE37A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=fCuHr81O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFaUQvs6xrc1/I2iguRfhcK/O1yGHACztHXYxzhR7yt7Ag5as/yt4JwIu/m/DvS+YWiYnO6ulJzfhsfgvqQJBOFVOfb6QJpt5vUkqWV8fLqHi9Q3+X2DMpFxHDTPOLeVcPLASJUz2xaQKNBO3vjI6N6Ahb8D90UPdM9eCz0aDnapun9e3GNVEBGXx+wRgP2kpbQecIvbLqbQz108hOGoUnRNLCXiyeg82j5O0vlWW8YpoT+/04oZ1dGvGUKephfEFPSB/uicUv9p+M5xHBUPu7jsW6cYNjxmIR2rGRXlVw92m9iOdblAIsFzf6L37Of3f8KrOfnf394g5FNwJjDP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUlrYIl8YkaAmq6Vp9xo+/oYMPzAZQdQRqM5rWh23wo=;
 b=xocVbxiAolHQsoSWvxG9ia/SrV7sg3KC0B92nQzUQXe92egffBkioRHbok5JPng3hY44yCNamL2slURaJbFAT9ARL9mV532tJXbdQtp8iiF2FVy+Zuvg3WDT3ZNYVH1PiTBiMgQ46w8W4+fFQ2koFLYmsNrMPIKHXHWLH17Oqi8ToCDycaBl3V49pCJ1OVNTkOQvN7l5lJGJ99Ixf3VObf/SVKWnBXmYvSzOqeDRRrZUAtLvIriva25kns0epK2BN8UqEEenesSbmuD8W78i8BkUnQi6QmL/VJ+FQ6Uj7jg8bjTEOZZyXKJP5MjQikiZUBjwPcnNZzIZI5nVOzpbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUlrYIl8YkaAmq6Vp9xo+/oYMPzAZQdQRqM5rWh23wo=;
 b=fCuHr81O8bv9wrO31FrzrMtmsR8UXmIvIwgc4l4Xw6psq8mBxyljAQ7QE8XlXr90n6bNxxyesCX0StyvQ34XvxtrNFOp64Dca+eFe31HUa74yV0t8gqrBXnlh7OsPDYp/FEa8VZ3SXtpgUoIL0UUF7umosCoScIWTh4O+nf/5mA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:33 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:33 +0000
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
Subject: [PATCH v8 00/10] PCI: endpoint: Remote DMA support via vNTB
Date: Thu, 22 Oct 2026 17:22:20 +0900
Message-ID: <20261022082230.3164834-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 3346d00a-08dd-4ab4-1850-08df30159eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	btlt5mnWV7Bbjz17anPBITTWQhXm+g7KmIhnWNMD8EPKVzlI/v6qJp3v3yOuEksBjoaS2aAJ3uD4UfzMi6wSIj7MNgCm3Uhofd9PhqmO9JpD3rxb6fRdq0qEum2Ty5Xjj9eGwvaYnfuaEVeo1g+M/gAZMlbpSjD1lQuqp+fcab+qtSmoppfgT0nRFELaJ9QKFV8FWitR72UjEW7MkLDdS3mMB+HsQTAvGnlGeAbn8vxmgfneqEctDKO66dJ1okMygz5HNggG4YfWoXBZphVCQuJv4E3Pxu5ZBQpYoSwdW2QVm54lt2cWNp/eP2tOiJKD9coTpaU9EYQICP23efP6RPeyMPtkDT5z2XL/0Q+3nGmhTaXf/LwejqBbIR5JhiV70rYo961ODIaSPoGc7nqrKSEs8Yx7jFiuuHTSI1IotjjA0xDahWHJQz+BgTUrognFHwS8ghuNXJazpkCEqlLUfa314ISF2qB/LymUgu6CwiKCs0NzstpTTYnWv8eR9RymsrWArXeigZEiahs4AmHmcr8w9uOCTDVsTyDHbv8I3tLqsNb1qM7M1bHIiZwtet74NUhaX/faphhuQJE0g0Gt5ILwkfwSVFcIGElmLyDhaDqOLQ4x7S2dkTXrDh9hOGXq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0jZogoa+C77pAlWab11Njz9QthRUP2kU7sNx7fNesmqWog4ywpMDx4zQmT3?=
 =?us-ascii?Q?9EFsE9iNHE5TAZtY67i7fbyZrSucfm1LR9BPlm/MsIPku6qc3VYk3MWDC7zS?=
 =?us-ascii?Q?veUTvPR99q+XRp/PKhVgvyLmaSB1UCoPDO8XIBtGNG/T+udALuvIZVgdstl0?=
 =?us-ascii?Q?VJReRGVijuIFZ9lC4aOUBZGkGRVcDWcpKm5MvIypKiswZS+d3XcHnhQ7MdvX?=
 =?us-ascii?Q?JbzZAY9G4yE425FTS3lUkJWfJHJ318Y36fFjqhOTWL8hKcj9unqwPm7C/ihl?=
 =?us-ascii?Q?Umk2FwQH7cqjNqFlYy8gJiFAzABsv/ucioBLR+i3jYpFP9v4G2DeqI5A/etY?=
 =?us-ascii?Q?xLj/kT0aESPWG++t3XviKUW/5TZlnk/I5COX8s35So9QZ/gGIWRiyOO0H/QW?=
 =?us-ascii?Q?fp+OuZlHD6EIl8Uu35fqjRYcaNIvJV2D8j/hWfj2bTL7jwNxPBdErgEXT0wP?=
 =?us-ascii?Q?xTREL7MuMxb6Eer6lRUlH94ofCEYxbQowHRTJyafH6EFv5fWPmQbG9ggnS5k?=
 =?us-ascii?Q?9zDMHaHjHwiPgfniy73Yb3HtoM6bRPELWgwff0zp9ickCy9MLq+8s1fBZn6A?=
 =?us-ascii?Q?IUvqxmMhrDcbUrQJYsHpKKi1besKO5XuxC7RfbfLZytfFCNIRCUD29cUs0N9?=
 =?us-ascii?Q?Xl2NSkm9IWL9DVBsQzZU8XT8ajEfrjrxDx1th1kuQYVMdUqa6fainFUiV3bl?=
 =?us-ascii?Q?sa143L6UKMJvxe4GfFTP67Y6a0Y3rVwaoVWAv5K8HvOaHlrVWC+bmF+zPgon?=
 =?us-ascii?Q?WiZ0MxydWr8NBP78eLkZ0WzrQMGGHRkIuoe3iV6gkPUGU6ZqDFNljZbJaURg?=
 =?us-ascii?Q?cLV1OCLSXKOYVzLjwy91x8dWdQRISKf15W0ETzTg3iSjmKfdHAp5O01O9P8h?=
 =?us-ascii?Q?LhsjhWey6j4t+IXBCO3wIIgAZPzLNcmWObaWYzf4sFnkh82rcrSO83xH75kD?=
 =?us-ascii?Q?vPMGIzpBt8HsI7A1R/mQZudUTHtdZJndogKG27rAWsj1QNqbRjR8JhSNHraJ?=
 =?us-ascii?Q?rijcSmV2wUIk52YUoOGMXGulE+v92M3PVTNQv1jcG8cNt5g9LFoLI6C7GuoO?=
 =?us-ascii?Q?wugg/D/TwGB48ox94gEZWV+sbupa+KGqRK4w/aBunhc/7GSsNs3yB8u3xWWx?=
 =?us-ascii?Q?74WqpDN82/vuXE2r/Vf1Vyqkf57Sx6mCBEqZpwH+bj5OTNUEGonNpVOMGavl?=
 =?us-ascii?Q?x9aza57bONePi3UynvpleDH2vfs1SnsAp3R+HnUJe546FriAOUd88rszLKE6?=
 =?us-ascii?Q?nijKkwZ9yA+WxtsGMsg5RCgQGDw9Bk0tNEUpNDQ9vE7sa+x/BwYpWAdHJTmm?=
 =?us-ascii?Q?6kFVyBDwRj7fS9TRoO2cCvAp14+G7wb/++ASr29aPc3BNp9GkzGdET7JQXj+?=
 =?us-ascii?Q?cmT04JH6Zf+2gqL3bKPKpp8ylie6fBuTM56LrTCtnqQP4912x2IM/VekCASq?=
 =?us-ascii?Q?/IYQ9m4c41ijDzH/03acZHxHL0mfOOFnaHSA0ZzGRIVC0pEjhXRyhEhTfbdq?=
 =?us-ascii?Q?29PeADiJMLuwQlY1avrmvwTlPpMbZ8m27lK1V/DN5NiuO/dmcle//zWEB8tY?=
 =?us-ascii?Q?0uqm1JCPPoaV8Lj34dZnJHi/Xyfjr1T+93A1I6uXjvVp6kajBczB23Cwj82y?=
 =?us-ascii?Q?7hCwr0Tk6eEePo8uhxtgRGtA8r1/ObTH11AaPPBTMTBVTj6GzbMFSfgupUIT?=
 =?us-ascii?Q?/HZegMCLxx76m3jSHojdvEaGLOfxoreTanUM1p2GJ47snyqzvg56vt4+w12b?=
 =?us-ascii?Q?edpctUuB871QLOOYnEZqo6vJqPvz99AmfVpF3mB77+JKEfK7qY/l?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3346d00a-08dd-4ab4-1850-08df30159eed
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:33.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDd2UCi+52nHCcZE108AnQcyQ+vLwgr5AWmlRj3xLdHJn6rsHwxNktbYzhaZIltNFssL7CC8l9H72vOONaDs1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

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

Based on next-20261020, which includes the following dmaengine series
needed to build these patches:

  [PATCH v4 0/3] dmaengine: dw-edma: Prepare channels for remote use
  https://lore.kernel.org/r/20260912174023.1227397-1-den@valinux.co.jp/


Proposed merge plan
===================

Patches 1-7 are for the PCI tree, and patches 8-10 for the NTB tree.
The NTB patches need the shared header as updated by patches 4-6.


Compatibility matrix
====================

"Old" means next-20261020 without this series, and "new" means with it
applied. The table describes expected behavior.

  EP                              | Old host     | New host
  --------------------------------+--------------+----------
  Old                             | OK*          | OK*
  New (dma_bar = -1)              | OK*          | OK*
  New (dedicated DMA BAR)         | OK*          | OK
  New (shared MW/DMA BAR)         | OK**         | OK

  *  NTB works without DMA.
  ** NTB works without DMA. An "Old" host treats the whole shared BAR
     as an MW, so the EP falls back to that layout at LINK_UP and the
     DMA ranges are no longer mapped.


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

I tested all combinations in the compatibility matrix with ntb_netdev.

Best regards,
Koichiro
---
Changes in v8:
  - Fall back to exposing the whole shared BAR as an MW for hosts
    without MW/DMA boundary support (ie. "Old" Host), instead of
    rejecting LINK_UP. (Frank)
  - Link to v7: https://lore.kernel.org/r/20261021042229.2280937-1-den@valinux.co.jp/

Changes in v7:
  - Split and reorder the patches for the PCI and NTB trees. (Frank)
  - Reject LINK_UP from hosts without MW/DMA boundary support when
    a BAR is shared. (Frank)
  - Link to v6: https://lore.kernel.org/r/20261020054948.1218370-1-den@valinux.co.jp/

Changes in v6:
  - Add a prep patch that moves the control region layout to
    include/linux/pci-epf-ntb.h, shared by pci-epf-ntb, pci-epf-vntb and
    ntb_hw_epf. (Frank)

For earlier changes, see v5:
https://lore.kernel.org/r/20261009045949.1109871-1-den@valinux.co.jp/

[1] Superseded approach, PCI DMA EPF, v7:
    https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/


Koichiro Den (10):
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources
  PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
  PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
  PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
  PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
  Documentation: PCI: endpoint: Document vNTB DMA export
  NTB: ntb_hw_epf: Use the shared NTB control layout
  NTB: ntb_hw_epf: Discover vNTB-embedded DMA
  NTB: ntb_hw_epf: Support DMA and MW sharing a BAR

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  32 +-
 MAINTAINERS                                   |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 410 +++++++--
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 838 +++++++++++++++---
 include/linux/pci-epc.h                       |  34 +-
 include/linux/pci-epf-ntb.h                   |  90 ++
 8 files changed, 1320 insertions(+), 277 deletions(-)
 create mode 100644 include/linux/pci-epf-ntb.h


base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
-- 
2.54.0

