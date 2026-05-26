Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020110.outbound.protection.outlook.com [52.101.229.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74538D3FB;
	Tue, 26 May 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811004; cv=fail; b=l1AvaVRxLXsFFoN1RNlAZ9HeKxnnrCrrN3qbXtPtyTcV3P9fy4vtuaGYPwxa+GTPoPw7rwRCRYi+LE3pyXg2n7bApn5Lo/c6EdLteytw1C6PVvLRFkRuB39dy36G+cWwm6LdcwBV7UajRLO/Em6sLRYkOIkg5+aBFJ+EdSQlzAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811004; c=relaxed/simple;
	bh=bSH73J6uJvrM7S2u85KpJRLCVqg2qJgd0bjWzN1tg8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uno4mU93iazPEpNfU0/nVktewuxZv2qdoyQcn7nc6BHFHEVKwN6zRm/jJv/azDsQEwTEpl09HB4U3vwhotVy5EbGcviYwKlyEcotN89mzhFlNArhx1+7Nh+OmPrdfw1au4YIA9ZbxJfhlLhIRMFnuqIzPnwhv3slzkC+N4HDZC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BhLqdaCp; arc=fail smtp.client-ip=52.101.229.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BhLqdaCp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0Ti3E2oJaUSPxilRIMWmj6lCljFqvVtnNsN0u7bjkDyIKtEt2T7OW/Llc2REtm7DBovmU2vjfiZ85O3pnHzbhK4D8cRfAJ/h2M6kNNkdzKu0WWIKynGNIQgHz1JTqa7lvUOsTNYy0MOoN+tjRxvbqkBtV6ZT1HD0BrfSZbyTofzsU0eKV/iCY+35qdAoX5Z2J+xFnhD1ufJmXKms+sJv8+IEvOI1cI969Q79HJCJF7F/dxFwDPKMgEgmg3bmi5APHguxyOFBlPM79LHEF6qypfwBapxw7xrIvJxu+lN0EgUQ+/A/HJvTZM0Fv2qW5xsYtCtmYT6gAbk+Z6O8QLgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhPcU1UeaEtUg3TETsk3Hajmf5zzSm+dDGSYKIUkGbY=;
 b=Y2mO+3Gcf6WOdV5GROqIjvQsgbEZ/Qoh+7ySJZlndvkv6wEagyGQAzU7EyVV/U4DZ/+P1n8aNTNjt0sawte6whxbh02ozbo9jZwiTY4FDSmEhtaWNvFB6fncfuvCfktVSAcNc+Lfw3232orpA4Gtiirk4WtRFL5EKLZg9WmAGVCJWOlAVS2OIuhYU6sOnrWPAbc9hjZvV423u0+1wRCq9LL9WXTHBjveW2e5R1dOMQRyIjJW8WX7XWVaIPxGYyJO9JHl5KDhPxgwsGfENFh0oaX4PFacL4NPAQwjXWSR9miLJqluAWTJM0VXUIw/Z52h6HxwpknngAzV8nCNBFCP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhPcU1UeaEtUg3TETsk3Hajmf5zzSm+dDGSYKIUkGbY=;
 b=BhLqdaCptMF1y4hCdAaqvHerNG+/7eNibOI5G5H0FWXySFWa78h/mpNh19hZYvFphBPvFUB8/r6c5pn1ep3dwC70LtlYrOaZr/brtAi5AcpTM9uMeaLRpCFVFcuGFqJUY1w5FxYtc8WZ4D2WpqCMq0CSIsRP/5DKqiozzjSZx0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5150.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 15:56:38 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 15:56:38 +0000
Date: Wed, 27 May 2026 00:56:36 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v4 00/12] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable
 per-doorbell bit handling
Message-ID: <hl4pg76tbwashcacn2c7gbhvvqdfz4jr4z5vqldvt2iy53uc4n@6s3nspwjtuto>
References: <20260513024923.451765-1-den@valinux.co.jp>
 <923e522c-c288-4ab1-8206-9b7654ec9919@intel.com>
 <zgleppcjdym7hhoifhk3icze2ptualqwaalcyd45iwazmnwy4q@56dqc5uphi4w>
 <00a0beca-3213-4286-8e6d-72a310664792@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a0beca-3213-4286-8e6d-72a310664792@intel.com>
X-ClientProxiedBy: TY6P286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 23968a28-d995-4386-c503-08debb3f5eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|18002099003|56012099003|22082099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	qjsX2QgLZysBI6fmITqUm1Lf5RIwY68HN/vFM0VxbbvySL8WVEvlZJ+TEBQRkZGWSwxT4NR7Uqkjz/6XNQdjiEan3AWMTcsFsADoDhVeiFQDxJSwKwc96m40Jl2LmLIyy3rh3StJX4dSJSA1iBX8ic+OocOp4AZOZgy2Qc3E6yve32lYHrnQB/VdkwXuUxrNvmk0KzA7ySe/sq6qafcO051gnMl0FlnurB/2v1til8TbPJnuneeVC1xhiQrzvf71adD2ki3EFMfm6wjMZ9Tjl1XJpKmvzYsUxiCrpbyhLcm1EDIyRyaYbPaMi8ceUHlq6zCu7RqMf+RudytFWwNy84T9/A2fCB+gGXNVvTiM7c1HRmdwdaHpWo8Eul85e9nSSOOeBCLFe6JURVYdndhfGYV25Z6/43oRHBmPNxkHx9UtQ+O79CA3ANk1KSLgS4CRvqWD21vjGadXqLV508HKHX3Dgurjy+7LLlgMHjSfERbO1ZmR1ul5me9SyntzCNUe2CSdwSiEGAb3jJXtIzDmTlENvwUY1T9V44ebhfjdKaVEdCE2gT1qTfxAtozL9+U5K9KF8hNC5trnSP30yB+PixSYyFY/zCPRSC4lvQQImvd7RhKVeNHZyhDGWU5rL0waRDXxg14sTc/fb2U9Mcb67A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(56012099003)(22082099003)(6133799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5fTC4opofGThvAGEquzKkSx8HASCq3hdNZkfKGEnnBLA4/5jOvwTy0vw8IF?=
 =?us-ascii?Q?CdHbL4ePMX6GAgiw+sTg02MJpbu/n2KAgHMOBQxF2VaewZrdxxudEc/qapd1?=
 =?us-ascii?Q?vTwH/X+Ptc2KbNCQybXdgng8ZTBAAflU8zW1VRshpL2cH32MdMETe6Zqtgoi?=
 =?us-ascii?Q?OYr97wzoXzGoTXiq2OJd0q6tsYRleK3rBPUzDchJM8JiRNuvXK0vu+94JbIp?=
 =?us-ascii?Q?DBM1GP3Ly+zQvRqSmldkCScXh6dEBGbX1kyoz5vZPd4pY/IiHePSFdrSMqzO?=
 =?us-ascii?Q?tk/qR68FxiIJ5m3SwQh7V7cH9QJ+Dmp4sA954ADSz/OlqstUhvJ7WJnPKG4Z?=
 =?us-ascii?Q?JCKqWwngH0P1/Oq1LV062jtiAD0JPB5XQFil+1v08LdKzoxSeKMkxekErLfo?=
 =?us-ascii?Q?Br2rFfExj7lJzx8BRuh/GGnX1gUryrMoIbe4saM8RPrWBhGBwuApcLFlJqrL?=
 =?us-ascii?Q?TtRG6/ZHT/5EVQAnTfKzm6zCJ+u/0QifwTWXN7JFz+p4iOXaGvqt5FEFDyce?=
 =?us-ascii?Q?ezBvhTkAH2qST93bJLhVX5zXYnO44SNPu76R1NvKTQmCx5u8rmQ931zHkTo8?=
 =?us-ascii?Q?AwaEvsspX1PPsFBpa1NYzOx/15at+qPr3oyuszl9IdFUd7DE5nelaTvzP+u3?=
 =?us-ascii?Q?41L+sneNi0/wb9NEAN89pdro8dzSvoXF2vJ8TQ2PFdwikdPMwYkhWnopy2d1?=
 =?us-ascii?Q?cnM4pt02oOB1QxYaxmHkrjIwmd55EYyPLhq4Kxbc4PHKJ4K55w0to21qcH3J?=
 =?us-ascii?Q?IXN/0AONDG6+xdi0O8heO0ISwhPAsTG2Ny8ZHzRVQl7oKbT4PYTMOLuvDxX1?=
 =?us-ascii?Q?ToA1jy2oFm9lErnDpAXpFDpHHrn+8o6JzPziIKJkMpi1kyhukfuk9D3Tem9e?=
 =?us-ascii?Q?S69tvH6pfflazQrB5FyFR/AHCI3qZVmTp5tGzpVWDLL8Vy4d2UWMAsRxj1er?=
 =?us-ascii?Q?RPHyy/7rBE2M7REB9zrisyxBzSs8I/JwhAWpUwNwrEY9aXX/L6XwUJ8ZE8T0?=
 =?us-ascii?Q?6zI+DUlmEOMAV5zt+cTk3KtPU4/QNJ3fNSrX01Su0IYLg5H3j1Jnim4bqF65?=
 =?us-ascii?Q?1CHKCw5htAqsGDiaUZGfG3r6iKnI9aiiZn6eJxXDo+5jR6WkuqzVZ7qhu4eF?=
 =?us-ascii?Q?Mqz9N9UdwnJoROmeqkLXuqozs5jN/Ddbrn+wYu37Ywi18n2RFo0oxSr19ljw?=
 =?us-ascii?Q?yMq4UQspLxk/P9szOgkfO7sl9Nq/wqpJsoTD4S6fFsAWh8Vc6Wyao4mY3W7r?=
 =?us-ascii?Q?apk8axGz5noEuF1OVSg3RsvwVk9X9TMbAVxAshdRD0RfMFtHDauPPFC97Xn7?=
 =?us-ascii?Q?/6t7O+zloXvQ3jvHbyi7vkL2ZDHL4QEF5UYUsaIWJwulWruvE7fNjlUNTxAl?=
 =?us-ascii?Q?z3iDAJhMzSCp8qvldnW+V5F0T4krbX1vZ4J/wIkkPB42q5uHUyYQFjoKI++S?=
 =?us-ascii?Q?LIigh45KhTYBQ8YSwKHhGFe+ahHJG1+t8NuFzdOih5eqdkmDjH+ShQxj5QbN?=
 =?us-ascii?Q?3mG2MPzSPtx49h+aJqnnja5Cya/ugJWnDiDFmYJdgpilFvYCNOg93IZLRYmp?=
 =?us-ascii?Q?DzCHaCCFhlE0mklaqPHHqVXxxnoQZu/p9W8vMibw1JYneiID73bKvNbJ6uQ0?=
 =?us-ascii?Q?OUnU7JhjtgApdXNVafRZz54tiOU2PHBMn+qYrKAV9nbcVRfCQzIIoIeRq+N+?=
 =?us-ascii?Q?/Bp92V5FolI0MVZ3egB75JsWa0Ar3lT+bH8bL0zrU+exSPBg6/JVMk3cYgmA?=
 =?us-ascii?Q?SGqEzsiIKcV+lOCIv4IV7jD30OxTVRGfQUsiNy6uEj3c/em9jaQA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 23968a28-d995-4386-c503-08debb3f5eab
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 15:56:37.9899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICjtUoX3FN2a3J8zrSKs0sDM/7nB4f/EnfwSTq2JGowMWR0eEHwaLyOvqKnyQrs+qs2IUbI9rdYikg/4L8P5WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5150

On Tue, May 26, 2026 at 07:45:11AM -0700, Dave Jiang wrote:
> 
> 
> On 5/20/26 11:29 PM, Koichiro Den wrote:
> > On Tue, May 19, 2026 at 02:29:51PM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 5/12/26 7:49 PM, Koichiro Den wrote:
> >>> This series fixes doorbell bit/vector handling for the EPF-based NTB
> >>> pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> >>> per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> >>> without changing the on-the-wire doorbell mapping.
> >>>
> >>>
> >>> Background / problem
> >>> ====================
> >>>
> >>> ntb_hw_epf historically applies an extra offset when ringing peer
> >>> doorbells: the link event uses the first interrupt slot, and doorbells
> >>> start from the third slot (i.e. a second slot is effectively unused).
> >>> pci-epf-vntb carries the matching offset on the EP side as well.
> >>>
> >>> As long as db_vector_count()/db_vector_mask() are not implemented, this
> >>> mismatch is mostly masked. Doorbell events are effectively treated as
> >>> "can hit any QP" and the off-by-one vector numbering does not surface
> >>> clearly.
> >>>
> >>> However, once per-vector handling is enabled, the current state becomes
> >>> problematic:
> >>>
> >>>   - db_valid_mask exposes bits that do not correspond to real doorbells
> >>>     (link/unused slots leak into the mask).
> >>>   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
> >>>     expects a 0-based db_vector for doorbells.
> >>>   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
> >>>     it directly calls pci_epc_raise_irq(), which can sleep.
> >>>
> >>>
> >>> Why NOT fix the root offset?
> >>> ============================
> >>>
> >>> The natural "root" fix would be to remove the historical extra offset in
> >>> the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
> >>> Unfortunately this would lead to interoperability issues when mixing old
> >>> and new kernel versions (old/new peers). A new side would ring a
> >>> different interrupt slot than what an old peer expects, leading to
> >>> missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
> >>> are implemented.
> >>>
> >>> Therefore this series intentionally keeps the legacy offset, and instead
> >>> fixes the surrounding pieces so the mapping is documented and handled
> >>> consistently in masks, vector numbering, and per-vector reporting.
> >>>
> >>>
> >>> Dependencies
> >>> ============
> >>>
> >>> This v4 is prepared on top of the current pci/endpoint:
> >>> commit f5aa97125491 ("misc: pci_endpoint_test: remove dead BAR read before
> >>>                       doorbell trigger")
> >>
> >> I can't seem to apply the patch set via 'b4 shazam' on top of f5aa97125491. Trying to set it up for review.
> > 
> > Hi Dave,
> > 
> >>
> >> DJ
> >>
> >>>
> >>> plus these patches as contextual prerequisites:
> >>>
> >>>   - [PATCH 0/2] NTB: epf: Fix ntb_hw_epf ISR issues
> >>>     https://lore.kernel.org/ntb/20260304083028.1391068-1-den@valinux.co.jp/
> >>>
> >>>   - [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
> >>>     https://lore.kernel.org/linux-pci/20260407124421.282766-1-mani@kernel.org/
> >>>
> >>> (These touch the same code part as this series and would otherwise conflict
> >>> with it. They should land upstream first in my opinion.)
> > 
> > This series depends on the two prerequisite series listed above.
> 
> They don't apply cleanly either. Do you have a public repo somewhere that has everything applied? That may be the easiest way to do things if a series has complicated dependencies.

I rechecked this with a fresh worktree based off of f5aa97125491:

  git worktree add /tmp/f5aa97125491 f5aa97125491
  cd /tmp/f5aa97125491

  # 1st dependency
  b4 am 20260304083028.1391068-1-den@valinux.co.jp
  git am ./20260304_den_ntb_epf_fix_ntb_hw_epf_isr_issues.mbx

  # 2nd dependency
  b4 am 20260407124421.282766-1-mani@kernel.org
  git am ./20260407_manivannan_sadhasivam_pci_endpoint_pci_epf_v_ntb_a_couple_of_fixes.mbx

  # this v4 series
  b4 am 20260513024923.451765-1-den@valinux.co.jp
  git am ./v4_20260513_den_pci_endpoint_pci_epf_vntb_ntb_epf_enable_per_doorbell_bit_handling.mbx

And this gives me the following commit log:

  git log --reverse --oneline f5aa97125491..
  # 1d1465542cc0 NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()
  # 94bd43a9e435 NTB: epf: Avoid pci_irq_vector() from hardirq context
  # 3cab4db0f647 PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
  # 5449f10512ae PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
  # e3dbdcceb2fd PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
  # e1c167a58888 PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
  # 6c54fd0c9c9c PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
  # 28a30b79ff03 PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
  # cb5fbd37bdc6 PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
  # 9ed0f4db85b4 PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
  # 575bd3aa530b PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for doorbells
  # 41f26aa279af NTB: epf: Document legacy doorbell slot offset in ntb_epf_peer_db_set()
  # 6b2e2f80a61a NTB: epf: Make db_valid_mask cover only real doorbell bits
  # 44d1bb070521 NTB: epf: Report 0-based doorbell vector via ntb_db_event()
  # 4e4d37b4c2a8 NTB: epf: Fix doorbell bitmask and IRQ vector handling
  # 1e5829682361 (HEAD) NTB: epf: Implement db_vector_count/mask for doorbells

I don't have a public repo at the moment, sorry. Could you try the above? If it
still fails, please let me know.

Best regards,
Koichiro

> 
> DJ
> 
> > 
> > Best regards,
> > Koichiro
> > 
> >>>
> >>>
> >>> Practical benefit
> >>> =================
> >>>
> >>> This also enables ntb_netdev's multi-queue performance scale:
> >>>
> >>>   [PATCH v3 0/4] net: ntb_netdev: Add Multi-queue support
> >>>   https://lore.kernel.org/netdev/20260305155639.1885517-1-den@valinux.co.jp/
> >>>
> >>> Each netdev queue maps to an ntb_transport queue pair. With correct
> >>> db_vector_count() and db_vector_mask() callbacks, ntb_transport can wake
> >>> only the queue pairs covered by the doorbell vector it received. Without
> >>> those callbacks, the NTB core falls back to the full valid doorbell mask,
> >>> so each doorbell interrupt can still wake all queue pairs. See "Testing /
> >>> Results" section in the above link.
> >>>
> >>>
> >>> What this series does
> >>> =====================
> >>>
> >>> - pci-epf-vntb:
> >>>
> >>>   - Document the legacy offset.
> >>>   - Defer MSI doorbell raises to process context to avoid sleeping in
> >>>     atomic context. This becomes relevant once multiple doorbells are
> >>>     raised concurrently at a high rate.
> >>>   - Report doorbell vectors as 0-based to ntb_db_event().
> >>>   - Reject unusable doorbell counts and guard configfs writes after EPC
> >>>     attach with -EOPNOTSUPP.
> >>>   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> >>>
> >>> - ntb_hw_epf:
> >>>
> >>>   - Document the legacy offset in ntb_epf_peer_db_set().
> >>>   - Fix db_valid_mask to cover only real doorbell bits.
> >>>   - Report 0-based db_vector to ntb_db_event() (accounting for the
> >>>     unused slot).
> >>>   - Pass per-vector context as request_irq() dev_id instead of deriving the
> >>>     device vector from Linux IRQ numbers.
> >>>   - Keep db_val as a bitmask and fix db_read/db_clear semantics
> >>>     accordingly.
> >>>   - Implement db_vector_count()/db_vector_mask().
> >>>
> >>>
> >>> Compatibility
> >>> =============
> >>>
> >>> By keeping the legacy offset intact, this series aims to remain
> >>> compatible across mixed kernel versions. The observable changes are
> >>> limited to correct mask/vector reporting and safer execution context
> >>> handling.
> >>>
> >>> Patches 1-7 (PCI Endpoint) and 8-12 (NTB) are independent and can be
> >>> applied separately through the respective trees. They are sent together so
> >>> the two sides of the same legacy layout do not drift apart, and the
> >>> resulting code stays easier to follow.
> >>>
> >>> The plan is still to take the whole series through the PCI EP tree once the
> >>> remaining NTB acks are collected. See:
> >>> https://lore.kernel.org/linux-pci/rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6/
> >>>
> >>>
> >>> Note
> >>> ====
> >>>
> >>> Most v3->v4 changes are responses to Sashiko feedback:
> >>> https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp
> >>>
> >>> Sashiko also flagged a broader driver-unbind lifetime concern around the
> >>> vNTB PCI driver. That is real, but it predates this series and needs a
> >>> proper .remove() path, including NTB unregistration and work cancellation.
> >>> I am keeping it as follow-up lifecycle work:
> >>>
> >>> https://lore.kernel.org/linux-pci/20260226084142.2226875-1-den@valinux.co.jp/
> >>>
> >>> This v4 only clears the deferred doorbell state added by this series around
> >>> EPC init/cleanup.
> >>>
> >>>
> >>> ---
> >>> Changelog
> >>> =========
> >>>
> >>> Changes since v3:
> >>>   - Rebased on the dependencies listed above.
> >>>   - For Sashiko feedback on state added by this series: clear
> >>>     peer_db_pending around work enable/disable, mask peer_db_set() with
> >>>     db_valid_mask, and use __ffs64().
> >>>   - For pre-existing issues made more relevant by per-vector semantics:
> >>>     stop deriving ntb_hw_epf vectors from Linux IRQ numbers, pass
> >>>     per-vector request_irq() context, ignore the reserved slot, and
> >>>     validate vectors before BIT_ULL()/ntb_db_event().
> >>>   - Added adjacent hardening: pci-epf-vntb db_count range/configfs guards,
> >>>     bounded db_vector masks, ntb_hw_epf mw_count precheck, and helper guard
> >>>     cleanups.
> >>>   - Dropped Reviewed-by tags from patches that changed to non-trivial extent.
> >>>
> >>> Changes since v2:
> >>>   - No functional changes.
> >>>   - Rebased onto current pci/endpoint
> >>>     e022f0c72c7f ("selftests: pci_endpoint: Skip reserved BARs").
> >>>     * Patch 2 needed a trivial context-only adjustment while rebasing, due
> >>>       to commit d799984233a5 ("PCI: endpoint: pci-epf-vntb: Stop
> >>>       cmd_handler work in epf_ntb_epc_cleanup").
> >>>   - Picked up additional Reviewed-by tags from Frank.
> >>>   - Fixed the incorrect v2 series title.
> >>>
> >>> Changes since v1:
> >>>   - Addressed feedback from Dave (add a source code comment, introduce
> >>>     enum to eliminate magic numbers)
> >>>   - Updated source code comment in Patch 2.
> >>>   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
> >>>     Thank you both for the review.
> >>>
> >>> v3: https://lore.kernel.org/linux-pci/20260323031544.2598111-1-den@valinux.co.jp/
> >>> v2: https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
> >>> v1: https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> >>>
> >>>
> >>> Best regards,
> >>> Koichiro
> >>>
> >>>
> >>> Koichiro Den (12):
> >>>   PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
> >>>   PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic
> >>>     context
> >>>   PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via
> >>>     ntb_db_event()
> >>>   PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
> >>>   PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
> >>>   PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
> >>>   PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for
> >>>     doorbells
> >>>   NTB: epf: Document legacy doorbell slot offset in
> >>>     ntb_epf_peer_db_set()
> >>>   NTB: epf: Make db_valid_mask cover only real doorbell bits
> >>>   NTB: epf: Report 0-based doorbell vector via ntb_db_event()
> >>>   NTB: epf: Fix doorbell bitmask and IRQ vector handling
> >>>   NTB: epf: Implement db_vector_count/mask for doorbells
> >>>
> >>>  drivers/ntb/hw/epf/ntb_hw_epf.c               | 133 ++++++++---
> >>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 210 ++++++++++++++++--
> >>>  2 files changed, 296 insertions(+), 47 deletions(-)
> >>>
> >>
> > 
> 
