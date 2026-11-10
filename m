Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299119;
	b=zCV65Q5kBRN1ycEbocmAnAs83XiN5cVADFWzY1z0EKb87LrDjI44ZRjjEt2KJBMci1H0
	 Kfg9+D91pfgfGZOJmlNSOVYOpKa0C6NJ8XBEykCzxCYPVi1HXGwTPTmrQUhjEsUKCUoB2
	 9miXrDjov/FYypE0pmN5Zxi8r6nfVwIFNo4+ztnZRl/lOZrHKSwGgiE7vv9XIs6n8NPmJ
	 RF8SIuu7S+5webCPiPLJ9RlsdRF90d2/JsnA7RDeTBe/1shf7EpdjDDU83+nWrAewRtIU
	 OtuE/L22rVLk/k+6V0zsqvAKOjw74aCz3nbac55+9/GT88032CrJMssa1rLJkYAIB/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299119;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LP9b2oJdCUu1Ah78lMGxvn3NNedkRjuVCA52+lCaPcw=;
	b=4dmmzmzzrv32+hLRZ3ccHoQGKaCiceqpTHqJMs7w7VhZDkDcIfSXtZVximLa0zRHpnYd
	 2A24ANTpKG8kaf8uOTnoy9/Ai8/IYY7lc3btTUKJHsNu4Qx/ChNlnpFD+jmoFl50WRfHc
	 odzpVzMi3BFj9whp1SIrXX9b8Ecxc8KB8dt0oeKxIyvd2NfejgruwQFCrvcYKvKNTf7l3
	 nSfuiGUTtJZVbeUcdqClU19WIR0+D4iP3cz3UM9xlzkGlY6VpA+EF3RLHNelr2oIVuDLA
	 ggIfCPRortInf9nHPeXVZPTCHvBMM2Q/jXkNgYGTTho/epMBkOwQLlcLHGbBHmTJgJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=WJXajnLk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7F60A380B;
	Tue, 10 Nov 2026 08:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE7F60A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=WJXajnLk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFumZ8zqO/ryp7NmSRwu0OB7awz+HSd2b76sFf14kSImh862Oo/zzWwa9DjjbIUFy6zsUPIKmiuWv4VGL6mZeOMPQYAMcQjCR52c3HYXJEjcTdkLfm1oNFMZpj9g3oQnGZ/qlFYu/JXUUDr5ae7Yol+SeP7laLcwOZFVPEhJ33r6y1JaLcL9j5BAzxBe197xLNx1abnREGIMp5JkY/o+IpZiK90BbYeyTwLUdHBpXru8MxfWxE5bZ1iKuYTWF3Cqyx9GwLxQH6DRzCfS+sgxIC4GXcLThv9CHUIx0b5CmXRIwW1l5C8NI9Y6eo+RDsRl6xt71cSPIujTELdXsc09ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP9b2oJdCUu1Ah78lMGxvn3NNedkRjuVCA52+lCaPcw=;
 b=pn/rahCY6jBQ1y7q3OEecizCHVpo4DroNhcqe990PfOYHXedaVeUW2jONmTMTlIa+YXZYHm+GtuqcWP8vfJNjG2Tb7O++DHEJEhnstqw+dRK2Q0kSg9tLlHO2Z9Gs2L+0RW4nPXpA8+gSuUR1+bgaC4L5w9o7ZsoAaHJQboUtAgqeM/GoRi+oojhwCwtm6iKHLbPpxidjGDjDgAHi0Q6xoU8pDYjp5+JHEPDPnRp/32+WwtOLEh1ATfmS8JPaERBZu0aO5ydSIKrHEq2iauRkdlAXEeCjBU/4zv/2zYXUDrImkljR8yKbZrw8hNTa+tbfNPIMS8dvbSuYsXtj33KRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP9b2oJdCUu1Ah78lMGxvn3NNedkRjuVCA52+lCaPcw=;
 b=WJXajnLks46tLEjYPaC+0FgqXgWXBwO/0+L1PBPmiYyLEpR31cB1+Kma7dkbES3aetVNsCsvtYrfaVqdwy/EbeGE0Djm0XXK1JUb2hi+Kg0EtN3gw8UzSUFNAp7W7vHT7U1U4I2zEMOi1eikHHKwX3x+Ff77xFX4CWY3U2YCiEk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:11 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:11 +0000
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
Subject: [PATCH v9 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
Date: Tue, 10 Nov 2026 17:24:55 +0900
Message-ID: <20261110082459.1798763-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB3015:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd4a643-fda5-4035-b023-08df3f042335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026135527099003|261026140227099003|261022115727099003|261028144727099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3tlttL2o9N/AunboTcUsLjiZNE0QzjLNDYCJU3pqcbc006IEEBZJKmRIU6Y5alsoEvTpo1S7HWPCccpejTOocEEitP/iQfkcTVe8TRQyttTIlQ8b8nUU/ojNrBml+6GN9KPKryI8t9v92w21NzWt5BQIUGNFTtSdCAWxd5KDc+FgvqMl205LgLS4qozHvyPGWafC9N/OdkdqvwBQN8yFd/Q7pYXK+9IH3tu/RDYP5HA9HKM5/kDqyJCiXU+ziSeA77GSHTIuF/rOTgvgGdwhfIKTiibfNlCvqe8fQ/F/6Sp9WSB77r0tZnm4489T6B0tABLR/8EhSTtYMCl0+2JhUn0EZlXtsglt97M8Y8/2+dVf7xSG2y6TZZSaaPC2aSibKZiNA8Wlw4Sefj5sOGBXYo0TNDWxjEDbwhsVPI4cXf9voNYxQI8rQ/Uh32om91hdSOKgd823rbpCihYo7JpbGhZT1dCx34oonzMYaOTMVN0iIdzdH4bBu8bCZNFfSE7C0uvqKbLcccFYW8e6ZeAx2FhFCTll6Xztk7V66skhCyePQMW1E6u/nR/+ZhjfGJ+WY22F2pyaRlEYL4Ulv0JrTWZbm0qYB2dYimbi1iODTkkazli6qZUEreNPHDHFhytE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026135527099003)(261026140227099003)(261022115727099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p/aot0HkDuq8gYfOFrkkRUkxzEyIzrSY7ln/XuQZIs90Q6lAr559k+sydoxB?=
 =?us-ascii?Q?FwxtK1bq4ABLkIxtyG+iNhUhXXfxG02WotbaRk9LCcmzqjIbgx52BJRTlh8c?=
 =?us-ascii?Q?xiTT5vPY4p+g67uFaIWf6D2uOzj06+wslfApbPS4C8d+DHPTAaKVR98r/OM9?=
 =?us-ascii?Q?eLjgtjz91tVqpr4oePx2yIuJN6tlKQKUH1nvtN3fH/j1OlWwps8Fo8uXuER8?=
 =?us-ascii?Q?6t9WhGohAOkkR9HQDj5Zg3DAPiIV1gDNxomnZIjycBscvQLdOnkOEaOPOEa/?=
 =?us-ascii?Q?2Ed+M0EuSXQW6RgTh8bC4zStDUwBFIJq9i6vmHXHgBRCyrdss85mmFz5h8YE?=
 =?us-ascii?Q?AuJ93DgrQQDGnWTFLUJ5yfMFkXxVu0JSnS7qfu+DCK2HlVNGw+qcLOEZ8bAh?=
 =?us-ascii?Q?D2FMLX/r5U3TcWesxF63ovXJYt/fE3jDBfIoaS9aY6z8bxebJwgj89qZ91Es?=
 =?us-ascii?Q?tlTFxEeyiCOlLYA6uqNfNHn6MO5GJP6My2iNnvHuRj2GiKeo8yFvqu7PlZXB?=
 =?us-ascii?Q?GaiqtBh5bPLWOkhuIOyFa79yPUJoiXS9bN/i1gM7oZKU7R481mkRnrnElkDY?=
 =?us-ascii?Q?RaOswhkDNvAZoqrVEDVsIA9XrTfDNJtbpYk7IxDlfrm+7/ozrnSU9VeL8laU?=
 =?us-ascii?Q?A5NqaObWaAccmJlksgReNKiCNHluHgRB7X6otSWMaFPCZLVM+Z3EvK2AY4AV?=
 =?us-ascii?Q?wNBPzWfV1KUTL5U3Qx/TNiY+rHihL7fl4LPRY1a21uGZalR6PSXWNltma+Af?=
 =?us-ascii?Q?Oj9SsJ68in75KeJ6fOuhu7rXii3+Vf9sNkFX2RoJGyLj0I96bzgHLziguax3?=
 =?us-ascii?Q?qWkCzEHT7IgHGvh5GEf3dKpxGAY6nUPDEXimW9JPBj0tOmncJB2LF08qlRiC?=
 =?us-ascii?Q?xCPvi6JjJ//8UxDs6JID3QPeERvKGIQB2oDpXDjbfutb7Ql7OByuD0ghZ+DY?=
 =?us-ascii?Q?fh3GxB7dXMzm8oOp+gXDduz9f2EbUJvufl5Mk8dm0pxVrzFUp2VyZD/5Hf/u?=
 =?us-ascii?Q?7waVksVxXnVDkTtX4ipp5q747X2eo5co56a6xRCEy7NnAepLrg8esrQ53zbF?=
 =?us-ascii?Q?pSy+kP6l4zsDvFgrVWzGA+qTq/rhladPwnnnJnZ0NTQBr1yzbzUrH2C+PNeO?=
 =?us-ascii?Q?N0F60CsBa+Dxm9Em7yRbDjE3H6la1kQ4T0m67zNPgmaZfKe/KPU2un1HflKi?=
 =?us-ascii?Q?eQtA8JmoyqMcj7fnW9Fs6XjsqC+aIHbklF59Ju7xfSX8Z73quSdJtDidcKEm?=
 =?us-ascii?Q?gNqQ6MfnHoxsBJk4qMSt2YeeE/Z5Wl3BU3HIjE5+PR+AdHkJSmYUA+wFBYw8?=
 =?us-ascii?Q?H5JN8qrP/dVoAGiogFJIltxxs1vJXFGZIWes4jm8dIFySKeP4WlHoJY/5t6t?=
 =?us-ascii?Q?M55jJNkiPPMipmQyPGEN8xPQ4Cwsz00BoorjehjK0exq9e36Hj8/kHK1tE3s?=
 =?us-ascii?Q?4eqT6N0hn+G2nMZKYXfEQzgVo0dAfxKAmaFdtPOsATtEIq7yeITrnkZpG8ye?=
 =?us-ascii?Q?SfCsUIJc98lyxaPr7qlGiUHL0ieqra+aBJDKzSWky5qON2naqujVzT8qk5uD?=
 =?us-ascii?Q?tSnb8GsF71bmYi1vph5LbDHV9rNa1khsy4bMCcGFP2DColNk5gkhyeqGsOxE?=
 =?us-ascii?Q?M9Qah/Bf27Jn1pUhMWS83lOPGESIW5xPpWPdHe7gI+i9n0pfOIbWOgzf540B?=
 =?us-ascii?Q?pr2mDI3RLlkpW3Sizi3y138TieFQgFSEgAnmT6mIuJcTYNr/SmhL3RMtQ1jw?=
 =?us-ascii?Q?MIBt0g3ZfXqfjUVrca0YY8qeO6l9srSSAUrRDxZdQxzZCxGev0zN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd4a643-fda5-4035-b023-08df3f042335
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:11.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iD4K4CwwC87X+p+RBOe4FcAWekq6B0xGfJTgUZZnrBvOt3onFsYShQSjYb/1ImW9lZfPBI1wzqbPZ4WENOXxbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

Some endpoint configurations have no spare BAR for DMA resources. Allow
dma_bar to select an MW BAR and place the DMA ranges after that MW.

DMA submaps have fixed BAR offsets, so a shared MW translation must
cover its configured size. Keep the power-of-two restriction used for
ordinary MWs. The size must also meet the EPC's alignment requirement
for the following DMA submaps.

Older hosts treat the whole BAR as an MW. Fall back to that layout when
LINK_UP does not advertise MW/DMA boundary support, so that NTB keeps
working without DMA: the enumerated BAR size is kept, the MW spans the
whole BAR and the DMA submaps are removed.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v9:
  - Report BAR-sized address alignment for shared-BAR fallback.
    (Sashiko, #1)
  - Reject partial shared MW requests without letting ntb_transport
    round them up. (Sashiko, #2)
  - Check the shared BAR number and MW offset alignment at bind time.
    (Sashiko)
  - Drop R-b tag due to the changes.
  - Link to v8: https://lore.kernel.org/r/20261022082230.3164834-7-den@valinux.co.jp/

To reviewers (esp. Frank):
  Compared to v8, this may look like replacing the size_align change
  with an addr_align change, but they apply to different paths.
  Let me explain for clarity:

  M = configured MW size, B = full shared BAR size. Values are v8 -> v9.

  Path                   size_align    addr_align
  ---------------------  ------------  -------------------------
  Non-shared MW          1 -> 1        4 KiB -> 4 KiB
  Shared, DMA submaps    M -> 1        4 KiB -> 4 KiB
  Shared, fallback       1 -> 1        4 KiB -> max(4 KiB, B)

  With DMA submaps, size_align = M could make ntb_transport round a
  partial request up to M while allocating a smaller buffer. Returning 1
  lets the existing full-size check in mw_set_trans() reject that
  request instead. Supporting smaller MWs is left for later. I doubt it
  would be worth complicating, just to support max_mw_size limitation
  for such shared BAR cases, which people may not use. Addresses
  (Sashiko, #2).

  In fallback mode, the mapping covers the whole BAR even for a smaller
  request. DWC requires a B-aligned target, so report that alignment.
  size_align stays 1, so smaller translations remain allowed. Addresses
  (Sashiko, #1).

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 220 ++++++++++++++----
 include/linux/pci-epf-ntb.h                   |   3 +
 2 files changed, 178 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 875a7a9e487f..ba2df2ee991c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -84,15 +84,17 @@ enum epf_irq_slot {
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
 
 struct epf_ntb_dma {
+	struct mutex lock; /* Serialize DMA submap and MW updates */
 	struct epf_ntb_dma_ctrl ctrl;
 	struct dma_chan *dchan[EDMA_MAX_RD_CH];
 	void *bar_scratch;
 	dma_addr_t bar_scratch_phys;
 	size_t bar_scratch_size;
-	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
 	struct pci_epf_bar_submap *reg_submap;
 	unsigned int num_submap;
 	u16 rd_ch_cnt;
+	bool mw_fallback; /* The MW spans the whole shared BAR */
 };
 
 struct epf_ntb {
@@ -229,6 +231,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	unsigned int i;
+
+	for (i = 0; i < ntb->num_mws; i++)
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
+			return ntb->mws_size[i];
+
+	return 0;
+}
+
+static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
+}
+
 struct epf_ntb_dma_filter {
 	struct device *dev;
 	int chan_id;
@@ -353,6 +371,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	unsigned int i;
 	size_t align;
 	u32 next = 0;
+	u64 offset;
 	int ret;
 
 	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
@@ -371,10 +390,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	if (!is_power_of_2(align))
 		return -EINVAL;
 
-	if (epf_ntb_is_bar_used(ntb, barno) ||
-	    pci_epc_get_next_free_bar(features, barno) != barno)
+	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
+	    barno == ntb->epf_ntb_bar[BAR_DB])
 		return -EINVAL;
 
+	offset = epf_ntb_dma_bar_offset(ntb, barno);
+	if (pci_epc_get_next_free_bar(features, barno) != barno ||
+	    (!offset && epf_ntb_is_bar_used(ntb, barno)))
+		return -EINVAL;
+	if (offset > U32_MAX)
+		return -EOVERFLOW;
+	if (offset && (!is_power_of_2(offset) || !IS_ALIGNED(offset, align)))
+		return -EINVAL;
+	dma->ctrl.submap.offset = offset;
+	next = offset;
+	if (next) {
+		/*
+		 * submap[0] covers the MW prefix. Keep its temporary
+		 * target at address 0 until the MW translation is
+		 * installed.
+		 */
+		dma->submap[0].size = next;
+		dma->num_submap = 1;
+	}
+
 	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
 	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
 	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
@@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 		chan->desc_addr_lo = lower_32_bits(dma_addr);
 		chan->desc_addr_hi = upper_32_bits(dma_addr);
 	}
-	dma->ctrl.submap.size = next;
+	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
 
 	dma_dev = ntb->epf->epc->dev.parent;
 	for (i = 0; i < dma->rd_ch_cnt; i++) {
@@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
 	if (!dma)
 		return -ENOMEM;
 
+	mutex_init(&dma->lock);
+
 	switch (ctrl->u.dma_ctrl.reg_layout) {
 	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
 		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
@@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
 		return -EOPNOTSUPP;
 
 	barno = ntb->epf_ntb_bar[BAR_DMA];
-	mapped_size = dma->ctrl.submap.size;
+	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
 	/*
 	 * Submaps cannot be installed until the host assigns the BAR address.
 	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
@@ -607,23 +648,29 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
 	memset(bar, 0, sizeof(*bar));
 }
 
-static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool use_submap,
+				      const dma_addr_t *mw_addr)
 {
-	struct pci_epf_bar_submap *old_submap;
 	struct epf_ntb_dma *dma = ntb->dma;
-	unsigned int old_num_submap;
-	struct pci_epf_bar *bar;
+	struct pci_epf_bar *bar, old_bar;
+	dma_addr_t old_mw_addr;
 	int restore, ret;
 
-	if (!dma)
-		return -EOPNOTSUPP;
+	lockdep_assert_held(&dma->lock);
 
 	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
-
-	old_submap = bar->submap;
-	old_num_submap = bar->num_submap;
-	bar->submap = dma->submap;
-	bar->num_submap = dma->num_submap;
+	old_bar = *bar;
+	old_mw_addr = dma->submap[0].phys_addr;
+	if (use_submap) {
+		if (mw_addr)
+			dma->submap[0].phys_addr = *mw_addr;
+		bar->submap = dma->submap;
+		bar->num_submap = dma->num_submap;
+	} else {
+		bar->submap = NULL;
+		bar->num_submap = 0;
+		bar->phys_addr = mw_addr ? *mw_addr : 0;
+	}
 
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
 			      ntb->epf->vfunc_no, bar);
@@ -631,8 +678,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 		return 0;
 
 	/* A failed dynamic update may have already removed the old mapping. */
-	bar->submap = old_submap;
-	bar->num_submap = old_num_submap;
+	dma->submap[0].phys_addr = old_mw_addr;
+	*bar = old_bar;
 	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
 				  ntb->epf->vfunc_no, bar);
 	if (restore)
@@ -642,6 +689,51 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 	return ret;
 }
 
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+
+	if (!dma)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&dma->lock);
+
+	return epf_ntb_dma_set_bar_locked(ntb, true, NULL);
+}
+
+static int epf_ntb_dma_link_up(struct epf_ntb *ntb, u32 argument)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	bool fallback;
+	int ret;
+
+	if (!dma || !dma->ctrl.submap.offset)
+		return 0;
+
+	fallback = !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
+
+	guard(mutex)(&dma->lock);
+
+	if (fallback == dma->mw_fallback)
+		return 0;
+
+	if (fallback) {
+		dev_warn(&ntb->epf->dev,
+			 "Host does not support MW/DMA BAR sharing, exposing the whole BAR as an MW\n");
+		/* Replace installed DMA submaps until the MW is set up. */
+		bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+		if (bar->num_submap) {
+			ret = epf_ntb_dma_set_bar_locked(ntb, false, NULL);
+			if (ret)
+				return ret;
+		}
+	}
+	dma->mw_fallback = fallback;
+
+	return 0;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -780,7 +872,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 					     EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	case EPF_NTB_COMMAND_LINK_UP:
-		ret = epf_ntb_set_link_enabled(ntb, true);
+		ret = epf_ntb_dma_link_up(ntb, argument);
+		if (!ret)
+			ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
 			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
@@ -1269,6 +1363,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool shared;
 	int ret = 0;
 	int i;
 	u64 size;
@@ -1278,22 +1373,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-
-		ntb->epf->bar[barno].barno = barno;
-		ntb->epf->bar[barno].size = size;
-		ntb->epf->bar[barno].addr = NULL;
-		ntb->epf->bar[barno].phys_addr = 0;
-		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
-
-		ret = pci_epc_set_bar(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      &ntb->epf->bar[barno]);
-		if (ret) {
-			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+		shared = epf_ntb_dma_shares_bar(ntb, barno);
+
+		if (!shared) {
+			ntb->epf->bar[barno].barno = barno;
+			ntb->epf->bar[barno].size = size;
+			ntb->epf->bar[barno].addr = NULL;
+			ntb->epf->bar[barno].phys_addr = 0;
+			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
+					PCI_BASE_ADDRESS_MEM_TYPE_64 :
+					PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+			ret = pci_epc_set_bar(ntb->epf->epc,
+					      ntb->epf->func_no,
+					      ntb->epf->vfunc_no,
+					      &ntb->epf->bar[barno]);
+			if (ret) {
+				dev_err(dev, "MW set failed\n");
+				goto err_alloc_mem;
+			}
 		}
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
@@ -1310,10 +1408,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
+	if (!shared)
+		pci_epc_clear_bar(ntb->epf->epc,
+				  ntb->epf->func_no,
+				  ntb->epf->vfunc_no,
+				  &ntb->epf->bar[barno]);
 err_alloc_mem:
 	epf_ntb_mw_bar_clear(ntb, i);
 	return ret;
@@ -1331,10 +1430,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
 	for (i = 0; i < num_mws; i++) {
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-		pci_epc_clear_bar(ntb->epf->epc,
-				  ntb->epf->func_no,
-				  ntb->epf->vfunc_no,
-				  &ntb->epf->bar[barno]);
+		if (!epf_ntb_dma_shares_bar(ntb, barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->vpci_mw_phy[i],
@@ -1936,6 +2036,28 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		guard(mutex)(&ntb->dma->lock);
+
+		if (ntb->dma->mw_fallback) {
+			if (size > epf_bar->size)
+				return -EINVAL;
+		} else if (size != ntb->mws_size[idx]) {
+			/*
+			 * The MW submap spans the full size configured
+			 * through configfs. DMA submaps follow it at
+			 * fixed BAR offsets. Supporting smaller MWs
+			 * would need a scratch-backed submap to fill
+			 * the gap. Let's add that complexity only when
+			 * it is really needed.
+			 */
+			return -EINVAL;
+		}
+
+		return epf_ntb_dma_set_bar_locked(ntb, !ntb->dma->mw_fallback,
+						  &addr);
+	}
+
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
@@ -2134,15 +2256,23 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 			resource_size_t *size_max)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	resource_size_t aalign = SZ_4K;
+	u64 size = ntb->mws_size[idx];
+
+	if (epf_ntb_dma_shares_bar(ntb, barno) && ntb->dma->mw_fallback) {
+		size = ntb->epf->bar[barno].size;
+		aalign = size;
+	}
 
 	if (addr_align)
-		*addr_align = SZ_4K;
+		*addr_align = max_t(resource_size_t, SZ_4K, aalign);
 
 	if (size_align)
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = ntb->mws_size[idx];
+		*size_max = size;
 
 	return 0;
 }
diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
index 5cc0f0badae0..8131ed4c6ac9 100644
--- a/include/linux/pci-epf-ntb.h
+++ b/include/linux/pci-epf-ntb.h
@@ -24,6 +24,9 @@
 #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
 #define EPF_NTB_MSIX_ENABLE			BIT(16)
 
+/* LINK_UP argument: the host honors the MW/DMA BAR boundary. */
+#define EPF_NTB_LINK_UP_DMA_MW_SUPPORTED		BIT(0)
+
 #define EPF_NTB_COMMAND_STATUS_OK		1
 #define EPF_NTB_COMMAND_STATUS_ERROR		2
 
-- 
2.54.0

