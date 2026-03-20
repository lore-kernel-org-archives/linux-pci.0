Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020130.outbound.protection.outlook.com [52.101.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA313B895E;
	Fri, 20 Mar 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019494; cv=fail; b=Vds7vxfn0suAh4E0MgKENyfuhoDcJLOKaQtGRP99DOb8UyblOHXzVc/6HP6IVrNroYA+fxFnO33v9WLtComn+26uz7pYdUTv/OdOqsGuTSaZ4LL1eoiJSe3MnYX0A2mk4suzozmFishDmS93/0aAEtlUidgodi3+lXAjydsoRBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019494; c=relaxed/simple;
	bh=iYDB+NQ+lE50MEqoK5AqfBobt2/hMaa2DSXIK23TydM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=noygQvHtO1ongQ04hArxyl1ksxpxt399IbxuC1JhM8c3VteXn84AA2g87fHzufuBOu/dTInHXRghi/gtPkJxxXYZEYOYmNIdGLr88j2pZrZPZx6E0d40D+8kJne7ctHBks8KpAlOE+pnPjTbUldPu5/3+tvXxsLwTDCKT5et4Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Tt00+EKZ; arc=fail smtp.client-ip=52.101.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Tt00+EKZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMXRmgPuKWbWpvRdY6zu3RDz5Matg6K/Id5YgCXOPPMVHxu5L/TE9rtg0UlnLh7Z0beul3rFJjnCbQXnasr/Qz7HDsOkboymK/BmsceQKAeuuLhqZcP3RwoCfAAl7PA+ZIBdLwv3wcMgwobisolG73VogM2AWg71s0TITTOR69s1PN8Fw4jRUwpr02N0uF75VpGV/N6JvY4QwcEK3cmS0N6HlB2dedc9w6QuVTKc8sXmxWIs76/K8IsBSp4VZU5/tq1uDIbSkSXe/5uX9nisl/5TuVmKoo5sbgoaIYM3cQuofNkJN3XOqqVl6f9OhKOkqkAYK13MlZNTMxTuXyqjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvQB7dkTzhGGDEihjUhsIXE9edBlvCn0x8ffP8roVe4=;
 b=EHo3t8Q1ULnc5uG/B7yOOzgydJu/WQhZcjiTevVjXlXaxiv3Vy8RHQMMV628uNk+OfqXQ1+jfIlAUkewU1r3BAiK2slgLvRCPZxlJJ0wznHAtIrMXwuvIC/bOm7XJ1ZZSWbwYp7jKJj/+zD2Vie2IOD4Z5ge1HChtKBk6JwYkPvRlJiT3CUw6esLWpoMJZSuL+tQuKdHY24HopJPxO/aMM9VuotW7WWbIE5jEsI+GP+wXnjmpv5KKCeExOhQYPwod0hO4eCCMMfg6zdv9kzo3329pl6u272yyX6LuaI0p9b9ozHaNbH9gln/r4ty4AHbE7NDGm4dptKKuQHO9CPQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvQB7dkTzhGGDEihjUhsIXE9edBlvCn0x8ffP8roVe4=;
 b=Tt00+EKZ3yNB9zCKT9RQ8IWU1RZ6CpgZA9ZHEicTQJ6NbR7SkwcM/jUVLmUGUTscJbLjNXwmpYGPTuHppnJ6excNLGOzkMrDZNeIF8uYj3uUAVsiPkFSvp3kbCy1kBoFBOwEMgVNndw6P2jnIE8Pynwpf67PtMcJgu3AAk8OUWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB6167.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.22; Fri, 20 Mar
 2026 15:11:29 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:11:29 +0000
Date: Sat, 21 Mar 2026 00:11:27 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>
Cc: Frank.Li@nxp.com, kishon@kernel.org, allenbh@gmail.com, 
	kwilczynski@kernel.org, bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org, 
	linux-pci@vger.kernel.org, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy
 MSI doorbell offset
Message-ID: <mr3blg2vsr5cb6cu2kcbmsjdhuge5kjc6vrr7wnb6et5ifqpfs@fbjzzo54k6yf>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <jne6ovpgukznu36lopk7aydv7rmcp3tl4pstn2fo46r6rt5jom@zxz27fgjom65>
 <e44ccisq4hnmy3lu3lroxc7ou6ssbr25bawbhr4tiud4pztxbw@spzprrgonwq7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e44ccisq4hnmy3lu3lroxc7ou6ssbr25bawbhr4tiud4pztxbw@spzprrgonwq7>
X-ClientProxiedBy: TYCPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:405:1::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae0ef5e-5af0-4a85-2885-08de8692f682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JgGPSH5KkLPKLUpXIeVlZLiqUDJ3nes2GqWNyq9K8Oqh8/ziGnEjMuk0FeslwgJNf4nZfdG5Q/L0btfjYCzijPMBwFnxK3Ryua3Pr3EMDkEGMZpNVhzWwBa8Yb4IJS+OVL344xTAxPCPEDWWTlIvbbmQveuOfZGhy7ieYshlMMd9iObPXQ63dMEVkZR1z1w6uTe0wIxtASYp2QIBiLwZehM4+7ltC+n+pyx0HtDsnEswoF/yo6SqeMPhx1kk6vV7CxzXJRe/83+La6qWdsA79Dg3OR+M6inNUeBXbuCQ8D6ddnOdDMai5iYZjfJ5Hx4FfPSX6PiVYvbZBmwaKborZnfGxVbndhUfsaPTPxX+PAjWCp50X3W6I8YIg932sXSpGY3fx0i13FsJhYZz8lq2h8BfmESYOT5N/yhjUkKXfMgNPLioaLM6DLK+PAqRS4sGtbMuNj1115T7GPOMjNuerm8fKqNglhNK0OLEkYcdsPUy03jTb8T3ZaJhlkrX3LLX3DRDZvaNcLIbk4aTg0+sDI/mePtsCyJ0HbMCGXjiE5x6OPDVL35zxmfCU6TpKp6KtnUiNzrRk6EpMbfRv4SvlZYvP0MV295114W2ztgzkiwjYszB78Unfq0d7wXl+Xr/++gs6shAhx91gHp2TNkx0We0ul8OorQ4Ctp+I9Gibqoe7Hb0NB/MbWUca1PzoWdnQUVZ5pnzDEHHZailJMvdlrwoIKDFZ05ewtKzYt0Vp5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yKnoDJBUWu+tsa5GE2nlJdrHfQROIMUNMT2iLyQmv62OTHvC0Y1SRKqoDo/b?=
 =?us-ascii?Q?S4O/tCjDBvzuxfrE/NMTSiJ/a/TBtfFuJ0tVaiADCRX6AS5YBkGiYGipjRT3?=
 =?us-ascii?Q?kHPigy5r/CnOyJl3C+Y9OmZJEQCeXpcwBooB2IL7O5wdpmHKnB0gtRU5jfs9?=
 =?us-ascii?Q?QYEyymeYqYqafAxKLi/+kzobRUIy9HmhZ9FjKbv4R4yceeHpAS3aGZc2QViC?=
 =?us-ascii?Q?mx7Y1rKVS/BbGop1bbpfNiUBo8CCJ3PueSNnxBSwPQUHxYOqNXY4EdTd+lEE?=
 =?us-ascii?Q?Am+awKNLBwvgnzoh4q13AZKpqxIks3VY9GzQWCsiK9IxNCNZhBcgLc/B69os?=
 =?us-ascii?Q?qOPZw7eCfgQNI+j2oDgPOVmbEKut01zcAX0bqJxcdeNC05UpHfskvOS+7+KV?=
 =?us-ascii?Q?rIYJGnm/mtRsxl2QRMRUVZLkZdGduzd/+AlWehk16RjVxPpY+C9jWLvyxLL9?=
 =?us-ascii?Q?QebDZoRMed3kOWPGRt9D4150HgOfAl6VwtMYmdp7cKp2QQYxyGKGXQaR5T6Y?=
 =?us-ascii?Q?iwBI43g/DzRv7C/+FdqgOm/0AJVTEDPEpSeljhJGIsdl24hwj8twm4StP+RN?=
 =?us-ascii?Q?bl/wI+TyHg2rY3ZybVTZhRg3tRfCO/LEp/HCxo8a8Uqie5fPSZuQq9VTLWAO?=
 =?us-ascii?Q?SW1p9tLfh2Rs78yBILlM7jcQbF8dE0ohCtzpecIGJoHoR1Wt8PdeJMh4TH6h?=
 =?us-ascii?Q?BkOfHRRhJo9YgG1+/6QmJQWidYL0odgJ+honElVkqH/d02AzaTQny4Hydlij?=
 =?us-ascii?Q?GtVleM06RbAJOgDjAO5NPwZQvXi6+ehevvQddV1xNrC0PeJ5PO78hmWuI/Ex?=
 =?us-ascii?Q?+i1oRmunqVhAWSA+a/9fV/OyLWtzHhxj0BdmrJQhXVUbcREIiYGq/sMy21Gq?=
 =?us-ascii?Q?oIx/PY74bd6dRSwZf6Pot8UJp50vXZqz9snbXMdZBY1BcKOG2Ts1xholGf1Q?=
 =?us-ascii?Q?iCZnE/on0RCfoYn3aZteQHxHOanrzguIG8d7DCQ82c/WDTYS87GY5whMNibw?=
 =?us-ascii?Q?mraTf9e9On+D8aWKtvtyDzI9AmH13PhkdGSbY48xpFPFlNzOMIZH+z66IGIq?=
 =?us-ascii?Q?e+VvRZfKMRaxQ0rHFGUpFGSve7G1XCJAdTvBzekkCypxdyDmYZTh0G1lv14Z?=
 =?us-ascii?Q?fvNFNR5HJ+t2bVY4lVLo9jqofby5SRNzUl6Wzt6D9AaSrqHfchSCaU6YEfiS?=
 =?us-ascii?Q?ZT9/8XVl6zC7tte2H/PK9x/Luvq1VqduBi5bzEviMzRYFtNYP9+Wr2QYbKsk?=
 =?us-ascii?Q?Xs7PUsEQGFynFhRsk6r17qruix/+wf18vV5dSakpmxu+RarvWHDqLzXBRaV4?=
 =?us-ascii?Q?yP6htWt793fOvesce3Yts7/8swP6AhNaBhTeojBJEjCrow+9GsBrq3PBZGh8?=
 =?us-ascii?Q?IKtaZNhk7VfpcDdpB0Y1Iu3h3VdLAPYSaoiR8fsJbddGZAw1GV1M1XbKBNnr?=
 =?us-ascii?Q?HJL8ysnlI/K9JwppKfqZEX+GDiN5PkUWDjP7nptHLDHCVljsqwmcwMrrTUXj?=
 =?us-ascii?Q?k3sZMbR8Td2kAs7Lz+cHgkCHXE+db3/O7kDZM5AP7ETksqgKJdeClzG7/Twt?=
 =?us-ascii?Q?2m5P48B9Ns/Wu2b+d897+TSkpJ7QiGVCXF84uFMMcK0221f+cm0+2A/VbvdU?=
 =?us-ascii?Q?li28+ubhkQYIXr/2YpspA0dMlY0FagAY1MFUYYBgSVYs1GgkFRERdzfxaDRA?=
 =?us-ascii?Q?s13IOZHlP+bdQtgs5H+lq+Np6ufYZSjveTcDon/NL28mXOZJumQCTE8BJHK2?=
 =?us-ascii?Q?giF00ATtzi2jWnB5LUfRQ45T0YFVtTWdnkdajPA5Mu10MFhgrQma?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae0ef5e-5af0-4a85-2885-08de8692f682
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:11:29.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff08LkUAwHkeqie9KCe2z815VnvUoSZuYk3yNbA+U1L9SAIjH5vxtX8cBPhEVfWJ30Lmz94wFf3r41X81qjiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB6167

On Fri, Mar 20, 2026 at 11:55:24PM +0900, Koichiro Den wrote:
> On Fri, Feb 27, 2026 at 05:57:40PM +0900, Koichiro Den wrote:
> > On Fri, Feb 27, 2026 at 05:49:45PM +0900, Koichiro Den wrote:
> > > This series fixes doorbell bit/vector handling for the EPF-based NTB
> > > pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> > > per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> > > without changing the on-the-wire doorbell mapping.
> > > 
> > > 
> > > Background / problem
> > > ====================
> > > 
> > > ntb_hw_epf historically applies an extra offset when ringing peer
> > > doorbells: the link event uses the first interrupt slot, and doorbells
> > > start from the third slot (i.e. a second slot is effectively unused).
> > > pci-epf-vntb carries the matching offset on the EP side as well.
> > > 
> > > As long as db_vector_count()/db_vector_mask() are not implemented, this
> > > mismatch is mostly masked. Doorbell events are effectively treated as
> > > "can hit any QP" and the off-by-one vector numbering does not surface
> > > clearly.
> > > 
> > > However, once per-vector handling is enabled, the current state becomes
> > > problematic:
> > > 
> > >   - db_valid_mask exposes bits that do not correspond to real doorbells
> > >     (link/unused slots leak into the mask).
> > >   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
> > >     expects a 0-based db_vector for doorbells.
> > >   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
> > >     it directly calls pci_epc_raise_irq(), which can sleep.
> > > 
> > > 
> > > Why NOT fix the root offset?
> > > ============================
> > > 
> > > The natural "root" fix would be to remove the historical extra offset in
> > > the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
> > > Unfortunately this would lead to interoperability issues when mixing old
> > > and new kernel versions (old/new peers). A new side would ring a
> > > different interrupt slot than what an old peer expects, leading to
> > > missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
> > > are implemented.
> > > 
> > > Therefore this series intentionally keeps the legacy offset, and instead
> > > fixes the surrounding pieces so the mapping is documented and handled
> > > consistently in masks, vector numbering, and per-vector reporting.
> > > 
> > > 
> > > What this series does
> > > =====================
> > > 
> > > - pci-epf-vntb:
> > > 
> > >   - Document the legacy offset.
> > >   - Defer MSI doorbell raises to process context to avoid sleeping in
> > >     atomic context. This becomes relevant once multiple doorbells are
> > >     raised concurrently at a high rate.
> > >   - Report doorbell vectors as 0-based to ntb_db_event().
> > >   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> > > 
> > > - ntb_hw_epf:
> > > 
> > >   - Document the legacy offset in ntb_epf_peer_db_set().
> > >   - Fix db_valid_mask to cover only real doorbell bits.
> > >   - Report 0-based db_vector to ntb_db_event() (accounting for the
> > >     unused slot).
> > >   - Keep db_val as a bitmask and fix db_read/db_clear semantics
> > >     accordingly.
> > >   - Implement db_vector_count()/db_vector_mask().
> > > 
> > > 
> > > Compatibility
> > > =============
> > > 
> > > By keeping the legacy offset intact, this series aims to remain
> > > compatible across mixed kernel versions. The observable changes are
> > > limited to correct mask/vector reporting and safer execution context
> > > handling.
> > > 
> > > Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
> > > applied separately for each tree. I am sending them together in this
> > > series to provide the full context and to make the cross-subsystem
> > > compatibility constraints explicit. Ideally the whole series would be
> > > applied in a single tree, but each subset is safe to merge on its own.
> > > 
> > > - Patch 1-5 can apply cleanly onto pci/endpoint latest:
> > >   f6797680fe31 ("PCI: epf-mhi: Return 0 on success instead of positive
> > >                  jiffies from pci_epf_mhi_edma_{read/write}")
> > > 
> > > - Patch 6-10 can apply cleanly onto ntb-next latest:
> > >   7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link disable
> > >                  path")
> > > 
> > > Note: I don't have a suitable hardware to test ntb_hw_epf + pci-epf-ntb
> > > (not vNTB) bridge scenario, but I believe no changes are needed in
> > > pci-epf-ntb.c.
> > > 
> > > 
> > > Changelog
> > > =========
> > > 
> > > Changes since v1:
> > >   - Addressed feedback from Dave (add a source code comment, introduce
> > >     enum to eliminate magic numbers)
> > >   - Updated source code comment in Patch 2.
> > >   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
> > >     Thank you both for the review.
> > 
> > Sorry, I accidentally used an incorrect series title.
> > The correct subject should be:
> > 
> >   [PATCH v2 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
> > 
> > For reference, v1 is:
> > https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> > 
> > Best regards,
> > Koichiro
> 
> Hi Mani (cc: Jon, Dave),
> 
> This series has been sitting for a while, so I'd like to check how to proceed.
> 
> I'm thinking of the following approach:
> 
>   - get the remaining acks from the NTB side
>     (Dave already gave Reviewed-by for Patch 6/10)
>   - then route the whole series via the PCI EP tree
> 
> Does that sound reasonable?
> 
> If so, I can prepare a v3 rebased onto the latest pci/endpoint.

Just let me add one more point: in addition to fixing the issues, this series
also enables higher performance for ntb_transport.

Some results and context are described here:
https://lore.kernel.org/all/20260305155639.1885517-1-den@valinux.co.jp/
(Note: the ntb_netdev series has already landed in net-next)

Best regards,
Koichiro

> 
> Best regards,
> Koichiro
