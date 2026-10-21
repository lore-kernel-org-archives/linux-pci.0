Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.96
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556561;
	b=qgqr1QUGwUjrDzu1ngULYcyZJdRnp+oF4Apz46b3xqIxMe94l6hZ/FGQtklAu8J5pS/8
	 YhERPm5NX0lY56nY/LjFhWDOFhhdbHI2t0avyrb3anmQh86hB0qb5zkJh+GSG5ro8Nmri
	 wJH9fUL9cJE+x0LmHNcOUNu2LBKX2N/vny4Tp6feI76MgahMOH6n+ujd8weOC1GyxagY/
	 nM8GQ0xfWsJ4dq1XXmZWYDdZ1rqDM5pY6cJmgEJTqADh66GoGmticJxWng0cX/Z/MMsGk
	 gpqiNt+2r0maKa9n0ESLYkQEkaVsAPe8PlfWRFMH9HxBZ/khhf4CNUuxtz8nMUWtcOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556561;
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
	bh=YtPvspNOvm3SIc7NpGLLK6Z4260uWc+6kpi5pVuCzI4=;
	b=I1cQ+k8VCglCucIkbvsWEsRipNLDlH8VDPnA+rA2JQQwAEETAQ9XtIe6E2soO3kibzAM
	 Wk/MLzU/8wvnaM7q7h/Wrpx5gDNC/g7oaBJ6RSk6KxuctJzD7II06GIPzC5tKdkonhbnr
	 YbTSWJ3vWagqO9JxJqXNTozjubyZSWKbalmhnVjl/zqDGhRcURXCOZChE0Z6VCqGQfF5O
	 qu6HdOYUvQfDCE2EiVP4ASuxpK013WWhqRVbnhPpJU+UHIMeuxIrFlOSPjzNiwahevNVr
	 wIgo6vJGqBGNVqS9tERIqYjfq6Khte/ICTqtR2CajQGph5dq6HZgEWXidkO+lhoStVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=LaCFAFCG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.96
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021096.outbound.protection.outlook.com [40.107.74.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA25606A31A;
	Wed, 21 Oct 2026 04:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BA25606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=LaCFAFCG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHdW7yygpVlbEfD7NKadNX0M60CqmCc/gwpKdJ2LSOvGZErlA5cL0jLMDWcInT2NMMVsO2Fd6MFIOHWzktcAO0kpt08btLJN0QuzGnLnSGhf1ECWMY18UUCtMKeILrebAwZv+HlHBkG2kwvLx+Tz9Y5lkKLX5zGjqFXnUKT7KE1isyI9YjwQ3EbuGQQYyzHnQL1KD3zuKlGzZM/8SRTTqDNXgEnkqfx617qqo7e7mS/vk3MhBmKP9TNdUQmKs/ODpdm0hz0WD0C7/HPNAttIPXZ8i3rO1Cb2NlyVcc2U/7UZuB5sn3wpvkDPak0eBAvj3UNWvAzoXwlEJuTu8xnjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtPvspNOvm3SIc7NpGLLK6Z4260uWc+6kpi5pVuCzI4=;
 b=LC5WU5QmqAfqTQcXqwqsgmsC0fifbqSMyCRRf7tS6r2Ur0Mqziz4ho6voQbLZzcbMnD3HTuHLJm/OCGeg1vd77jahXg/gnXnH97xmhejeQphMsUPsVsN92ghoH4HcQVZ0zMWoNa56YKnZ7UnWxDPK2wVlIluXq7/aqxADctR6GRoFJRRv4IIrflMejVzr9/QQolZHgUsIRqy4N8DapblRmfvYIeGzzewcuDhFIshT84Zp1IKjIt+OkBdcmnQxoHFI8g58fL/551oQYAlsAaEB7QFdBYAn5hwomWbnewF7oUmQTG41aL+TCROH0+z3OF6et7ePteGjK6ZyezwtKkDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtPvspNOvm3SIc7NpGLLK6Z4260uWc+6kpi5pVuCzI4=;
 b=LaCFAFCGlzchLysAofBDZK3zf3NoCyVg2/jXXYeTtHvYgpYPBtphc+Cbgn9PaAChoihuK3Ahwg/d5f4K0JRKDbM/LXre1FHC3GnkOSbsaXiOlMKhuuJU1ayRUvmlJVsMDCqz+LfKOe5cRiaqJ3rEwrrvIF43U5RH57xc6GaUjDo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:35 +0000
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
Subject: [PATCH v7 00/10] PCI: endpoint: Remote DMA support via vNTB
Date: Wed, 21 Oct 2026 13:22:19 +0900
Message-ID: <20261021042229.2280937-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad8d0fd-0608-4b2d-f77a-08df2f2aeeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ASSHnX/UejbyLar9sGsy/aC2Te6R3x9zhxIPTZ4l69jvoWiJJwU9O4mSlIKOr3i5YGiVt9tDJJxzbvSwU3WhHEjDuwHVB7e5aYL49JUDNHOxkxzBXu4OW6XgJ6YpOg7NoW7gzX3GB8MuQmxhB84BgGOylqlJEn+U2bD9lrMFuL6E1vv7MlBwfDA2j0ZbPCvzFFQqsDnYpfDCtIPNYkAPdld8t8LZsArJQ9JPXzi6f+ddu+jtrXxtvR+B2f5l2Mul9WCsG0uShBlfq98Py1cE4uu7636NiLkLJ2HPDQUAWuV2urUgTZ2NNcr/mEw5WlClsadKbO1WO+8njev8Ut91C5ZyVC25/Kpuv2QbiR3kuGZvPcFE1SBFldo09a5ULquQMVsDRUYuxnflg/UVKENVHbOE5DAwWdITYGK3BfAT4wD5GFDCeIf7lJLCs+VIaKyeJ9lMko75Zu0hhHXVQEovlLikQo1e4Bqk7VFYNGkPjwQfj1gon3QZIywAUfPIVSamn1dKXe83EruK+75mlkc4wYxtWO8xllazQw5cscYJ/NzveumTaazbziAD0v1Twrs0sdEg3AB69IH83FFbTPEUZEngGV9CB/KRTdY0eutQMP3CK+J7yN8J+9bgb5t1PBhB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/n4/xtyoWj/CFxpVXxfUEKDFhhHbmAD9Tr8bC5/K9L/wzukuKZ72Op3dSNi?=
 =?us-ascii?Q?MkV+scO2IuEn0CIXw+bsMjyIWYNHQDW0H39kNHldvPu1Pl4pAM+P+HrprA8a?=
 =?us-ascii?Q?DGsbgGB+8MzrVgN1d7CiuD9y3gbafuHqcxBllGWc+JUGd18vndwD2Gy46Ydk?=
 =?us-ascii?Q?+Nn1iT6mBQHDrl6jYS0B4GT98bFuN5+ZK2HCviL3ISZJ8vpxAmlpSDXi8AlJ?=
 =?us-ascii?Q?XoCMOCAmGfr5d4EihtGmPoCXJsGAVxFACHM/KZClMpQGSYrvQubcmSps219C?=
 =?us-ascii?Q?ey7MO+PBymoQrlTAUTC5oxgAW8fs/J87n43YntIPJAEwD6SlLm7Dw5zDZruc?=
 =?us-ascii?Q?cYcQ2L7dqvlCZLIa4LGLyly416xU11AeWX4FPk+Rz+7QAbDrMwdIdYHF1KAq?=
 =?us-ascii?Q?D56ucaPKB2A05c1QbMI3THYamFR7px+/gsNUzF9c5yhOjmzKTY1FbYihUJhr?=
 =?us-ascii?Q?BnLlQCOjhyWlMx7D7d7ivny8s7HFOFfzmfgcwaiNYLKRFvxqOi85oEKyMpWo?=
 =?us-ascii?Q?iPPn28bft5TCKLKXF26nyUfvQBAImeMFeCZ9sVWq4zxNu1n6Gp8ukDpwXjZs?=
 =?us-ascii?Q?WVu3GtzPYi5kOLfsSMcoW6LZtrJPhxfRfKLw1rRypR/LEADF6Zc5aJ7JgXWN?=
 =?us-ascii?Q?Su4njhYCQxGrdwdWibFtDAk2jfdmu4oh8yk3BMTK3UhPI6DjSsezHLUOp+xO?=
 =?us-ascii?Q?fEt73AhEmTVzKTSIPI2QuIgm7U0FEU7Vh0wo9QIQp27xC3mIEjvN42S5OpF9?=
 =?us-ascii?Q?5nH5VQxZrbH/ItMisetfwoDbmLlIqUOr6Lxmih9FZ3O1sFQZ1RsteFgg9XvI?=
 =?us-ascii?Q?7Fjcq+42N0ZT4uXkvPFPP763RH4HnH9QIKDWbp67H+pKMlDCIAZ/8LeyfV5d?=
 =?us-ascii?Q?LmXma+Fwq+sE48GGh3eBjRaRNMBA1cdjjMkZsrkjSufXOAgLvVEbXfg9Vgar?=
 =?us-ascii?Q?5UevP4L8Osl0KvuvE8wJidxLkINtc4s3LF4HT2yeT0oGax15RfJn6jQOst+B?=
 =?us-ascii?Q?4vhc5C/0yjePyPV2jCnFOstSX4IYriVMf4C8jaWHsRFohiZdIEzqReAAAfNj?=
 =?us-ascii?Q?Kj8rcD6ddB5vpaAA+mrFyXK5nqpMHOtEVH2JMsdmnP6KSuCxLG+qM3CfwbTd?=
 =?us-ascii?Q?5gfehm9/dOKFDgaWV4z6+lBigdv6pCj9Lzh7/jDojZOr0IlR/NRY+7KwQt1C?=
 =?us-ascii?Q?J16GtG92iVs/lZg1xRvjHlSiadf7Z3mVahtkkJyjF1SkhB7dAC4KUlWKRUs7?=
 =?us-ascii?Q?3J5P11LJHKpwB1L8bkTlrPbdSSMWvitPjQ/jWDe0P/fcyCR/mwlEacSTrxYf?=
 =?us-ascii?Q?492v1Jgvun19XnBFGDg8HMPJ15JGyPjRfe5NqmUZw2zsat6pC4uhrXks9ACG?=
 =?us-ascii?Q?VM4zwRqMTBWl1rHv1X18oB1Znc0NJhbseU2oQfqSlDayog82RZR0UFn6gPCn?=
 =?us-ascii?Q?1tIld9rFNDcUNp9+ZSAfHpPL8K/glB2obpJjifePU4L6qVHmW84pGZ8/Brf/?=
 =?us-ascii?Q?qZbj9PfhmHOpiIlCP/3V89XROhh933Bu+obgV88rqgRSBh/pVcQLREcZ34/o?=
 =?us-ascii?Q?/yF1yTtQPtj8jAz4PzzqNs57NDVwapVtFykZb3yM03NcIw6Z+k07iNuHm9lS?=
 =?us-ascii?Q?OYLb+lPkwRWF8SNg2Lrw5C4enU+POQ0NLSQhTvNXhydCBhpZbpL7WNg/Dezq?=
 =?us-ascii?Q?JZHycZNkgVI+7+kHD+FQ0rtj+RpYOOc1Vr7Ocwgrvi6ma7gMvuRFDrAAt91C?=
 =?us-ascii?Q?P0LSCnEfBNyZzBzpdz+agLVS0sY/w9SktP3dJqxSX3FQsRTTpkh+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad8d0fd-0608-4b2d-f77a-08df2f2aeeff
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:35.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQe514xB+tSKy7440NzrSusf9sNnohjwZ1ph2btY7+3YkjufFtJ9zl9x1Tn34ZjGfV6Y1I4w1+EUxza1Hnbr9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

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

(Re)based on next-20261020, which includes the following dmaengine series
needed to build these patches:

  [PATCH v4 0/3] dmaengine: dw-edma: Prepare channels for remote use
  https://lore.kernel.org/r/20260912174023.1227397-1-den@valinux.co.jp/


Proposed merge plan
===================

Patches 1-7 are for the PCI tree, and patches 8-10 for the NTB tree.
The NTB patches need the shared header as updated by patches 4-6.


Compatibility matrix
====================

Below, "Old" means next-20261020 without this series, and "new" means with it
applied. The table describes expected (and tested) behavior.

  EP                              | Old host     | New host
  --------------------------------+--------------+----------
  Old                             | OK*          | OK*
  New (dma_bar = -1)              | OK*          | OK*
  New (dedicated DMA BAR)         | OK*          | OK
  New (shared MW/DMA BAR)         | Rejected**   | OK

  *  NTB works without DMA.
  ** LINK_UP is rejected with an error message. In v6, an "Old" host
     could mistake the entire shared BAR for an MW and overwrite DMA
     registers or descriptor memory.


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

I also tested a v7 EP with a shared MW/DMA BAR against a next-20261020
host. LINK_UP was rejected with "Host does not support MW/DMA BAR sharing".


Best regards,
Koichiro
---
Changes in v7:
  - Split and reorder the patches for the PCI and NTB trees. (Frank)
  - Reject LINK_UP from hosts without MW/DMA boundary support when
    a BAR is shared. (Frank)
  - Rebase on next-20261020.
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

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  31 +-
 MAINTAINERS                                   |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 410 +++++++--
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 790 +++++++++++++++---
 include/linux/pci-epc.h                       |  34 +-
 include/linux/pci-epf-ntb.h                   |  90 ++
 8 files changed, 1272 insertions(+), 276 deletions(-)
 create mode 100644 include/linux/pci-epf-ntb.h


base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
-- 
2.54.0

