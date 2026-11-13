Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576590;
	b=a8IIWKUl05YAZxZz0TTPdJGIaQRKF3IKmIdQTUwrTNaJzllgjE56z4SihZnfqq2H7Vw9
	 jDMy7w9DtNMsfXR24geUTxCZ2Ti9ypSz33Lu5USOVUtqk65zx4e/Z9fKqts01ycGmm/iV
	 E5TutEik0jWHI3h8q1i1kSF88JfJiLv125KhdZZfmjhLUM63UfN2fnBUGp/VQgvFDNKfm
	 aGmPkI+raV/g5ScuD4dNGOARmzCW3PbHyK5eMyEXJJbKVjDmWYOZKr9FmQtyNj3v1cMFu
	 iFS9gMMWOwVSnNNIl4iVNgxwbrdMBGwy/TXLdXonOW1FXD/J7lwXHI+PsAJc2NQcAaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576590;
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
	bh=7yU48FPOFaevu1uexbzumO/rFodzXKxvk8/XSLXpNhI=;
	b=ydMkTtX/kwAOnfOdlx22O2phj0y8kXnlP1OH4fRoP60riBzpyqOXLmncM6fDG+Fl2jYM
	 +OnUoVnc+9baeTF0v5mGi9VHpyZc7nR3gS4READCX0rfmq3ot34FVIU0jqrvM1trcPai1
	 86l4yjiHUl5L8eTR/RCWAyDR894ryJuWef7FToJCN8Q6q4kB0/NYJOnNRsc3c/7QxIMzW
	 Ef84PvMO0Y/0wbKepFD11m+N0aBb3XYvU8DWimlMZYjRuu6Gw7mYXiE4WDjZzIytLbSHz
	 +FWq1dJjP9GSONkZRTOT+/ae9smyNnzhSwRQweXwedBscNhPdHv5UFo560Elm72QvFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="ptEi3/tv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C9606A8A7;
	Fri, 13 Nov 2026 13:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D8C9606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ptEi3/tv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8b+V7GyuWf62wnDmxdUsXjFdlMBi7Q87CjVrKLXN4nn+mLWY5FXA9mi3V5aeYF06E1JABvAX+fX54dZA6ayaJdt7xTydM7qlJJLA8v1xwFKPTMq5gg6S1KwmttgboA5V4CUznyrB71mQiqQgTDTCIhUzV/cal0oQd9NTovzAo9hX9uV7W/blBlFghETzyg7Mrbz2qUAFnAgvLRIaiVNT8OLC/rWI1iby2+MALYVjj0Z/rKdcQ1G4OdFJo4FQXjcx8pGjg5C2kVhCTkKutAw0djFmeqxmCRGXqYqvAXtqcu71jt2JN2nyFrfeG5OZbkXAnWVyw/T8luP7R8WLHnz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yU48FPOFaevu1uexbzumO/rFodzXKxvk8/XSLXpNhI=;
 b=TzUIUcHk7xlqLbnjvJZ9AMwvsPhQuUxjqoLTyh9vFTu77PMd/0J5PUt2kcxgTtAV0Oe+C7R29Quk95bx3o3GFiox//SxWP2gJZQ8SFIU6O7B6Lpa1Z6dV9IZsCOd7arxvik/58Gys4vHPtdlfysUdBDQPGUr48QlpDSQmLrUjWOoQ2pkJ3tXJ5S0IevnbimkeQ8PHwqQ1o1mKRp0ZSCtn0e3dHEwYoz5pmW+K2zhyRmMN7kQD5vp/r2SV0UKTMQZXjoPwNyGhqGRSDOpYbwb14SRA9kInxtmfZ+65Pr16Y+P866szysBTtEeQteyRY1mrjXGzV3cdYYgWmBexTwwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yU48FPOFaevu1uexbzumO/rFodzXKxvk8/XSLXpNhI=;
 b=ptEi3/tvfWvbhK9NP6+4K4aoKqlrT4EH/JC3k4viG17JEqKyIaPb6seNvBc8XtBK/xgot2+9d/dkfUuWSA9sWg6nhHEG6l/h7hxX+1mmVA+M2KD7cDZ6x9tVwDrdQqNfgrCj32nBrOBEa3Nx+ykd3PfBdqLspMtagtKR+owMjtw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:45 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:45 +0000
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
Subject: [PATCH v10 00/10] PCI: endpoint: Remote DMA support via vNTB
Date: Fri, 13 Nov 2026 22:29:25 +0900
Message-ID: <20261113132935.4152566-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0369.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b22bff-f18b-466d-0c56-08df418a2e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|6133799003|261009223027099003|56012099006|10067099003|261102123227099003|261102130727099003|261026135527099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	SITib0vPzG415bxL3WaAAWh07aVoBVQTySrxYHov+O8Q7pxjdeIY5WQI8yR7tbhIpv96SmaIzAKkZzLDVnAXauJDJ80kgSQyk9ra2SQILp+BQON1Ubr/KLpPqEbwf0VdEGmIz4K4/ihGpAj4NkxkdYKujQASastbzMGi/y9az6sNCgW/93226ib+r9lExQer0pMUF+8W47UaaVkiFX35qJjrSQjKGSRYLLFWZWTZlFyrQR0n0Ni9h2CBWqM2s1d2xaUrgiFgtWKMYPIBK98s/rt/NsvY6HZGjDoSbBbAPyQWmgwYM5HZ/r2y+CskExqomRhruMSsFJEeVu/mAkOrGVeELlTmTlYkSOAeugrB+Bl5bMvcpeoPNmAKDw7PekZGtR1dWzFDj1FhvqFu2CkzLxXQIbH4NcEalYqynAZIgiHq+X7pEPuTmiY7ECEdOY/j9YnnRxHpSOSbhpOnjhr4zq4LXTHrC+ljzSiimjAHWoHRnajzTLVM60GGPwqaMcEFfKiMAvD9QGxNmwbszy6VUhVh6HqWQ2KT5H8akdCGgy6qHtW9hpMgGd1oHIGZoAtdKBCWmEhWGETUPl9DH5+cJQjhawSh71GLlb0pm32mtVZreoGBOn8xzsG28Dp+EE5l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(6133799003)(261009223027099003)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(261026135527099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mviduP2oFEJZDagGvBdyZosXCAWK42dyQrg+0tbYZvuIx2pFzfvs/obPDKi?=
 =?us-ascii?Q?rNXizYqM1wQqcUqPbcjTCyodAODbWToQjupULMaEJAziWqUxy271Bo4t6Rw9?=
 =?us-ascii?Q?m5k1A3U7sjq+0PUbBNRA1xLcubaAJmvJwXLdf3QvZJkpwlyORnXLKYn9KK0X?=
 =?us-ascii?Q?T71pw8Qb9/rlfyjowepZLQDP5LxD6G/mnGmHnmLvad5Gk4HDVc6goQUktbzn?=
 =?us-ascii?Q?0cxk5tHMEOrOiXdZDFQfJCy5sV/mIIZUwO+1O4Hsph1vcy3EPnh+2Rc/zwol?=
 =?us-ascii?Q?Ax4uvYFe6JvtHGOAcNUovSuctn2X6UKjHb9SrldnpzHTM+2JfoxHkj0feKQT?=
 =?us-ascii?Q?/isyoCf1wkFubF/J3SvTVR82+cBrHYccTFIBJzcqLyDfGfa4nbeiPgUJuWgV?=
 =?us-ascii?Q?51CXtnd0PNBRqHPmR4VfD7GPXlH8B7XPcClMTE4Cs4fu+foSl9kF8vUxel2l?=
 =?us-ascii?Q?wVcP13ETIrTDcY4SRgL23QExJXLyTxr0xGFvYE6SNNWLtR8PtcqGaVLimaOx?=
 =?us-ascii?Q?vkJDBDI0LJSQ8ew+lAiEX/is460CBWPvP+hKjSZuugY6/vZnT9krg7iaEdl1?=
 =?us-ascii?Q?Usj0Vgw0p/ZS0PkTolvWtVKmN7VU4qPndk7bZ+Skjp3kMxTI9lxsU8pvlpD4?=
 =?us-ascii?Q?Pfc5OBYTeAwtzqtkkhh+hOI49dm+SAWrwtH5TjaYT7wM+ulOM76N2bAH/U76?=
 =?us-ascii?Q?L7DB+wdIY+5oWiQm0a4OunJfNcQ0Uhua8KElM7OfrcOdohM7+cHHxI6Dy8qz?=
 =?us-ascii?Q?st8gDtX/eb2LvSNcI2DIYmiLGbpNGMES9VABlZPcREDDxZ3Q+IO8AOn9XIBO?=
 =?us-ascii?Q?6aqpHTQDZLR8j+Ae8VIGqzi6ESOY+JntRyUKYVZaFpl2yZpME25L78yW68XM?=
 =?us-ascii?Q?zmbpu5mojCuRwVbqjaJLC6dksVnGBpUCP1r9Pyb/84W48SEzhEIvm0yjlKmo?=
 =?us-ascii?Q?MnRvvQxiK/WBzDIjJjkFRhgQiiISYdmMKpuJOn5EpoAbgNNv/x2HX7+1EJI6?=
 =?us-ascii?Q?SAjTvJ09zBLRYvgifVTcoYb4r2wqvm4RXMrslWS+3pm086hQsn3l+fpWw5TQ?=
 =?us-ascii?Q?fDIk4Aq/GvHnAoKQsbN0U5JxK6Kb5jjNmyzRMY6j2njb6/qdZS+ASTaBkg4B?=
 =?us-ascii?Q?WmtWPyxplehui1A+IpYuFCiCQbk8UXfAivZrj15JmBmTDHCOmnRY/Jg0xiM6?=
 =?us-ascii?Q?Sy6ICVKK9MtQVc968lsxZt+FwwA5tm3wq6zVRi0cx9ADRDKXtfqkGHcPqbpO?=
 =?us-ascii?Q?ql+n/YuYguPTWcjWzWlrGhIvgLBfaFVHKUS/8old3Ocj7cc5hJUdZAJkvxO/?=
 =?us-ascii?Q?LVySBfcPsaRA846yNUOvf9vXyxoY835O7P/0ob23Utnm8pBvPiz2szXiFmad?=
 =?us-ascii?Q?zVuSJq0xBs1az1kCDxLxRl+Sww3Xr5O3421vryIxsbnsJcCzf/lH/1TWPROr?=
 =?us-ascii?Q?gcz7O76E0XIvBtCxMyRwcRfZBDxFG4CRaoqYfCKKaYXIM5jQo8cDYAw098hy?=
 =?us-ascii?Q?Hfi7CbXvdJmAo8C7uvo/FgM2XFVxgvPJs6cXi50bQbIsXEzo9/bUcTSNFEYr?=
 =?us-ascii?Q?57o3HFdZOu2lAkJnrYl2POvW3uQJLx5mf0aEDXbFcMl9ZJ9shEE4XnNhNaFY?=
 =?us-ascii?Q?xtnBdyz77n7NOiF55D5jlJPRSFvBE94pEciuO7Ab49BQKXR8JYCnsiC2qeVl?=
 =?us-ascii?Q?rKBZGFAhhFlymV+CKFcqOmL/JPInLt/OpDa4NZnY5yEUvKzI7L2j4EfZGfQc?=
 =?us-ascii?Q?L5bYR8/TEf8fT54Y0TAa84q3QIedIEEnYVF/sl5ZQZdSIUFT+319?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b22bff-f18b-466d-0c56-08df418a2e6e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:45.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7Ku0m2XR11Ob+uLPU22msTNC349kR3fpbJWVrrYm2t4HP5hZEpxALy1FBBF2E0i0LB2uusmL6GZWwfVRLpaYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

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
growing too large. I plan to send a follow-up series,
"PCI: endpoint: Support native HDMA for vNTB DMA",
once this series is acked or merged.

Setting pci-epf-vntb's 'dma_bar' configfs attribute enables DMA export.
The default is -1, which leaves it disabled. pci-epf-ntb only switches to
the shared control layout header and is functionally unchanged.

Based on v7.4-rc1. No external patch dependencies.

v10 uses the previously unused IRQ slot 1 for DMA, so enabling DMA no
longer takes a doorbell vector. EP behavior and the wire format are
unchanged.

Patch 9 needs another review. Using slot 1 makes the changes to
ntb_epf_init_isr() much smaller than in v9.


Proposed merge plan
===================

Patches 1-7 are for the PCI tree, and patches 8-10 for the NTB tree.
The NTB patches need the shared header as updated by patches 4-6.


Compatibility matrix
====================

"Old" means v7.4-rc1 without this series, and "new" means with it
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


Testing with v10
================

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

The ntb_netdev tests covered all matrix cases above involving a new
kernel (i.e. everything except the Old x Old pair).

Since this series includes no DMA consumer, the tests above are
regression tests for the existing MW path. With an out-of-tree NTB
transport that uses the exported DMA channels, I also confirmed that the
slot 1 DMA IRQ works.


Best regards,
Koichiro
---
Changes in v10:
  - Share IRQ slot 1 across DMA channels instead of taking a doorbell
    vector, and remove the spare-vector fallback. (Sashiko)
  - Add Frank's R-b tag for patch 6 and drop it from patch 9 after
    changing IRQ allocation.
  - Retest the compatibility matrix on R-Car S4 and RK3588.
  - Link to v9: https://lore.kernel.org/r/20261110082459.1798763-1-den@valinux.co.jp/

Changes in v9:
  - Rebase on v7.4-rc1. All prerequisites are now upstream.
  - Fix shared-MW size and alignment handling, and validate the shared
    BAR at bind time. (Sashiko)
  - Reject SETUP_DMA_BAR when DMA export is disabled. (Sashiko)
  - Retest the compatibility matrix on R-Car S4 and RK3588.
  - Link to v8: https://lore.kernel.org/r/20261022082230.3164834-1-den@valinux.co.jp/

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

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  33 +-
 MAINTAINERS                                   |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 396 +++++++--
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 840 +++++++++++++++---
 include/linux/pci-epc.h                       |  34 +-
 include/linux/pci-epf-ntb.h                   |  90 ++
 8 files changed, 1311 insertions(+), 275 deletions(-)
 create mode 100644 include/linux/pci-epf-ntb.h


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.54.0

