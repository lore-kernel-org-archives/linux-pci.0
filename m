Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021141.outbound.protection.outlook.com [40.107.74.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5EC28A3F2;
	Fri, 20 Mar 2026 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018530; cv=fail; b=eBao9/97h9YHBkP+c4Ww8KWrpBU+2ISO0ouI0+DsvyKBKf53FvdKs8FR/C8uTP3FchToll/1cu6sSYwSpyaXN4/zTnU+7Ce7Yap8sBOyFBxq5HyAhT8vrJTfx2VWnTfgOn8Ke4iFMQ7Til7Wgcr6xkhwFNHFgcJCCD1gnTiHNYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018530; c=relaxed/simple;
	bh=gtXS5QyL5Y2X+w+hbFrGxzHJU9YrFrkWQGiez++KPd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ulVRzTOsNMDgS+Ko5teNRkofsUq7ITEAaX93mBigWQR4CGy+ZNo3Fk1jCNZb0DlBFjUQYtsaY3jRoguqc3t7tjDBnzgRx8BtsaqlOq7Z4cmeiGTZ8M5kAFqiS5cwMG62wJvVX2FROEmwft3Gjnsz/vVQnWebDt38jAOpna3gk+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LwvK5FjM; arc=fail smtp.client-ip=40.107.74.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LwvK5FjM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX0AQrtgCejZFguQcPGy6HXcO/+exQv02KE5RlOazyXt50mAFWnxPWvDR9euNoBoRvVqlSkd4dQxautzye0MqEmN5PseU7yaMV8u/Qm45Ku3TTWoOlOrfEVI4jBPphNsMwYxJXC059jSHBEVtD1+e813nVjqxQcpxNsHRdwU0eYZ11p5ZD95gSm8kF7eMPrT3+dXwMQ8LERmrPyh2LcxoAU7aCfQZ6NuuqbT0etCMx1sZcN5z0LoHI2UlU0La6HQEsPZrxFEe5eQZ+99SB0Urj7xBy6aa82UuoITPz33IcX7QTIERvJUoOYu12IWYLCVvC0ebP7W6ZtdqQ+jNkFiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qobEInOqGKayvMZg4ODPydLNZY5IA1OXIwxx7BAVmFo=;
 b=qGCt1Gk++Yd3Lhj/mbGVbYDgw2uaq0q0b5EqMa7FnalVlQLLmosjQ30kKEQVkTTSEa9/YVzpO5pXDURElndNYiPKx3kZ+3UJxzKzN/PlBt+FqeyxnH/JiP7eG3yWcSN4qqgw39ZIv3AGvT3pIXXl7vt+uNa3MJK9pTUw5wAoBdA68iJGQFVHVFduLGMiRzm8oVAkwa4tNW1q6y9PKT7NWBUfEvFNi34q8drf8QFhuddhL9/GO/ORdBU36RBHIJzLm5ijxbKKh54z9XHToelPucwFqXCuFGsG/HokdNot9JkIvTu4PEnzWeXv6FVF+gVx/f5V3yIkVaZPeqW6u2n/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qobEInOqGKayvMZg4ODPydLNZY5IA1OXIwxx7BAVmFo=;
 b=LwvK5FjMAo/9g6pb5rF0yvLTqasZqE8P/TtyrdJZUnIHZzVO/drgu3l2Ch8Rd9yDf0rvU65u+/WFFNNLbYsJJF963sysyFMk/EBpwLicU73NLEXIg9naD6HYHPb8et6iIHojhnxMZtKQXZDR3T4vjIVF6brqj37HBuDKODJW1o0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6560.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:344::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 14:55:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 14:55:24 +0000
Date: Fri, 20 Mar 2026 23:55:23 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>
Cc: Frank.Li@nxp.com, kishon@kernel.org, allenbh@gmail.com, 
	kwilczynski@kernel.org, bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org, 
	linux-pci@vger.kernel.org, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy
 MSI doorbell offset
Message-ID: <e44ccisq4hnmy3lu3lroxc7ou6ssbr25bawbhr4tiud4pztxbw@spzprrgonwq7>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <jne6ovpgukznu36lopk7aydv7rmcp3tl4pstn2fo46r6rt5jom@zxz27fgjom65>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jne6ovpgukznu36lopk7aydv7rmcp3tl4pstn2fo46r6rt5jom@zxz27fgjom65>
X-ClientProxiedBy: TYCP301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c360f7d-f4ac-4c17-ad61-08de8690b77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2KNzIepdONGqqO6aFIx95JYUMFh/8wQr9S8MHr7HgZrBnFYx7heviBJqqR7gwMOBMO1MMkm5hJTY4VZhfvKgC735gmOgOBWJy8UD/8v2wZ9hh8/XYCfSStvSXKWOjxVZbE7SSxQ24+xk5RBc55ImNKMXyddIX6k8DNWSBm6RVSMH5HUz9nfW5NQ2bnpfMJae2yPI5iG/Xpu8rX+XVofFYgl6NJLCWwBSUNug1j6aECIrquTi4mrgk1kPKzid7TmTIsunHpKMiPf9ZvuKIr8WKyLcSZ5q38bFiXqK5rbooiadgdnRURI3B/qhwRcophnATCife0zklvo8n5jBkSh/uunRxXybF5vzWXGaTU7fOzd/2asgmv+t5qVeRWnXbwSlu8oqPZqQBdmSKPqbn+8vkdTRIevA9KeSkw/tV163TVqJML/kWrWElFlpmHDgRGC6EPKf1kaH7qPUupCh+YHkgouLXkbt3WCRBXS7NL4OCIzXgAdzcPJxXIccEd7ujlJigrN9Ys3FEPhEioDVVxV9gqCpsQ+ICgLsvUy4UtmBqhy53DXX5gA+WQ/uuorS1bHpUYO4l7pHvB4ZJscdO5T6UhelcMzWpqVHSGi07+wvOGT8GyF5hIfXaArMvGrBnKJ4D9daI3oRko5obpE4i4UB2hV/ki2IO/0ubJJ07Qenmq4O7PS9VKeXlXdXKQynanJENaU6UmbuFF2o/VS0Zgv2kC84UAftSlcdNUAIqIop8mY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/DkxxPB+UJBv7jBZ3cvrA3y9MA+9cESsbza0DC857PtHwrfM3hqerbmiO+b?=
 =?us-ascii?Q?HzoSHqyDdgnUDg0fCaORx9VUe+ulKFNG0BUWsaZEPqRo4sUk6uVJkJxc3nP9?=
 =?us-ascii?Q?3dbMfocVsUd+vxKxz1nAeHlEvSgBmUstinqcB9tlsWUoNwLejAV0fGTNKzrN?=
 =?us-ascii?Q?9svg8gjMr3C0U100MAxcNy3NaCyv0RDakLMcVeINHIJGjY0sg9aTuG+n69ob?=
 =?us-ascii?Q?ouKI9t4+aJB8PeRwDJJjBkClArx3WFi0qvku8uaVFXDNP+1Qb8FxR7o6Yyog?=
 =?us-ascii?Q?kegohyE0l3YckRQYQM3dRllLSr4xy2Jv6f75WbB/q+9ZYYhDYf7x7u4Sl7B8?=
 =?us-ascii?Q?TuxJFi5uwu69IK1O+/UcILSjz1AyOzRuI4hTLUhbcrdqYCQipeWSzi5eEyTx?=
 =?us-ascii?Q?OU73SU2GnUMyiBDOBy3GQ+vB2e7C5B1v/bHPwVrvsyw07nm99zDRVG+GnxsA?=
 =?us-ascii?Q?a130KS0xQpWlso/0R9XGY+6Ug3gHV6MHgOSmICTf51E9zL+uxhuMVddvBQXZ?=
 =?us-ascii?Q?po7jGG6Cz+Jcs3ugORwYBsPJD1HK38HWMR/qEnYMY6JhDoPZuXY0TESadrky?=
 =?us-ascii?Q?iJdWvhEaxXv2tj3m896fynpLvHww0pvKe0GFkneeASm2og+A4IpBLQMq7Rfz?=
 =?us-ascii?Q?sQD+XCXNOnuSD2EURzR+rHChLuGJ5o4XibAd713hV9kTMNCNAn68BSTYs8qO?=
 =?us-ascii?Q?ZL6zFWDtf3ipGF1gy7Kj9+q5bLpX0qxcfFyJsyjSAGi8+q0dH53ChQTHHGE/?=
 =?us-ascii?Q?T6WiD11hfpZK5gWXgIynyRqOeiiiZRc+CExei4lK5vXQZvFQYiQWsMpomy2S?=
 =?us-ascii?Q?ubcfwwXwTEbGOhzTLyIH9RS094DedwOTlQk3fQzcjv5DvQ2g1jP6PR3OnHnZ?=
 =?us-ascii?Q?gkw/MB6x5Z//zBBgRvrn5cLkzKJWJY/8mssdNFJom0x9907MGpVgINl3j9eG?=
 =?us-ascii?Q?DpdX89BuLQEvtEN3NaeRGnZ4jJh7WX/7iXa9YQIonOV463byaU+YosloFz6u?=
 =?us-ascii?Q?xgv/lOfcERaNpTnWuStFpC00PQpbFT/lrJHi5JjJcNrAzQRGJutlaH/XtDLJ?=
 =?us-ascii?Q?6BRzpJUk9B3ZlPyIwI3ZQJrcSxV1WDI7DJA7UAGq7znixqcBEAYkVW//kl9O?=
 =?us-ascii?Q?yjNDdLBs/NgjDSb1gFaBTvGI4Dmzt3DYbapP05IOfYX0hR/yo6aBCCvKElKD?=
 =?us-ascii?Q?TOXZSOOg3eAy7akjtSmNMFfRQQleL0Ddb6MhcI+qQmUyZzzmwolTIcknsIzb?=
 =?us-ascii?Q?x7PBNUxHZC0XhLiI0WaAnH5vEQxfhb2G956S1q0AgaKsVP+16isjP3ydBAyE?=
 =?us-ascii?Q?BVgQLd/uGSLyJxLkwYmSruTa4sbxKlPr06l+N6Edxr45M0nH9mErq9bITbLe?=
 =?us-ascii?Q?lWezb4g9y34+XX4Byj3qVVaCXRaRkqGOgQJkncgMxALGZjunlI5jo9wpKDBu?=
 =?us-ascii?Q?3uvLCmjjMTDA2oO9Q8tReM7yiVSWCznsVSt0VmSEIxRENLvuwPbtyIU4X7MY?=
 =?us-ascii?Q?WNsMeIMc3v4E7W/gzwI3NfodwkPFRpBQghKGmhZ/bPEKiZ2VXkXMZ5tAaWkm?=
 =?us-ascii?Q?pmGJ3s/uW9yXych4nist10yDHFvjYH6/inRlazr8dWyEeSBzzpyWKsDDn+/t?=
 =?us-ascii?Q?jb+HKuX6wnyzQmLdaBLvw+JwI7IMcPGhuJCP+i3Jd1Hpt+NQH+MrK+xD/GbQ?=
 =?us-ascii?Q?qJCOdVOuoMibpPS8JzX5noY4lw5RkCWcaMBp9rYkBF3mgUE0AutFj/Z9U6+0?=
 =?us-ascii?Q?AASwThLKHU+8WwHzrz/bjfwVfzEG82T9N3fWQe7N1ny5f+RO0zw0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c360f7d-f4ac-4c17-ad61-08de8690b77e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:55:24.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2RcpUuet1lysnEOjnkLkDiqwc2PgzE1IYTsRfQSbumHK/8RT3d40omxBjHRAe9eJJtGHOy4yCy22LaIvHqvhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6560

On Fri, Feb 27, 2026 at 05:57:40PM +0900, Koichiro Den wrote:
> On Fri, Feb 27, 2026 at 05:49:45PM +0900, Koichiro Den wrote:
> > This series fixes doorbell bit/vector handling for the EPF-based NTB
> > pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> > per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> > without changing the on-the-wire doorbell mapping.
> > 
> > 
> > Background / problem
> > ====================
> > 
> > ntb_hw_epf historically applies an extra offset when ringing peer
> > doorbells: the link event uses the first interrupt slot, and doorbells
> > start from the third slot (i.e. a second slot is effectively unused).
> > pci-epf-vntb carries the matching offset on the EP side as well.
> > 
> > As long as db_vector_count()/db_vector_mask() are not implemented, this
> > mismatch is mostly masked. Doorbell events are effectively treated as
> > "can hit any QP" and the off-by-one vector numbering does not surface
> > clearly.
> > 
> > However, once per-vector handling is enabled, the current state becomes
> > problematic:
> > 
> >   - db_valid_mask exposes bits that do not correspond to real doorbells
> >     (link/unused slots leak into the mask).
> >   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
> >     expects a 0-based db_vector for doorbells.
> >   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
> >     it directly calls pci_epc_raise_irq(), which can sleep.
> > 
> > 
> > Why NOT fix the root offset?
> > ============================
> > 
> > The natural "root" fix would be to remove the historical extra offset in
> > the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
> > Unfortunately this would lead to interoperability issues when mixing old
> > and new kernel versions (old/new peers). A new side would ring a
> > different interrupt slot than what an old peer expects, leading to
> > missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
> > are implemented.
> > 
> > Therefore this series intentionally keeps the legacy offset, and instead
> > fixes the surrounding pieces so the mapping is documented and handled
> > consistently in masks, vector numbering, and per-vector reporting.
> > 
> > 
> > What this series does
> > =====================
> > 
> > - pci-epf-vntb:
> > 
> >   - Document the legacy offset.
> >   - Defer MSI doorbell raises to process context to avoid sleeping in
> >     atomic context. This becomes relevant once multiple doorbells are
> >     raised concurrently at a high rate.
> >   - Report doorbell vectors as 0-based to ntb_db_event().
> >   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> > 
> > - ntb_hw_epf:
> > 
> >   - Document the legacy offset in ntb_epf_peer_db_set().
> >   - Fix db_valid_mask to cover only real doorbell bits.
> >   - Report 0-based db_vector to ntb_db_event() (accounting for the
> >     unused slot).
> >   - Keep db_val as a bitmask and fix db_read/db_clear semantics
> >     accordingly.
> >   - Implement db_vector_count()/db_vector_mask().
> > 
> > 
> > Compatibility
> > =============
> > 
> > By keeping the legacy offset intact, this series aims to remain
> > compatible across mixed kernel versions. The observable changes are
> > limited to correct mask/vector reporting and safer execution context
> > handling.
> > 
> > Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
> > applied separately for each tree. I am sending them together in this
> > series to provide the full context and to make the cross-subsystem
> > compatibility constraints explicit. Ideally the whole series would be
> > applied in a single tree, but each subset is safe to merge on its own.
> > 
> > - Patch 1-5 can apply cleanly onto pci/endpoint latest:
> >   f6797680fe31 ("PCI: epf-mhi: Return 0 on success instead of positive
> >                  jiffies from pci_epf_mhi_edma_{read/write}")
> > 
> > - Patch 6-10 can apply cleanly onto ntb-next latest:
> >   7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link disable
> >                  path")
> > 
> > Note: I don't have a suitable hardware to test ntb_hw_epf + pci-epf-ntb
> > (not vNTB) bridge scenario, but I believe no changes are needed in
> > pci-epf-ntb.c.
> > 
> > 
> > Changelog
> > =========
> > 
> > Changes since v1:
> >   - Addressed feedback from Dave (add a source code comment, introduce
> >     enum to eliminate magic numbers)
> >   - Updated source code comment in Patch 2.
> >   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
> >     Thank you both for the review.
> 
> Sorry, I accidentally used an incorrect series title.
> The correct subject should be:
> 
>   [PATCH v2 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
> 
> For reference, v1 is:
> https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> 
> Best regards,
> Koichiro

Hi Mani (cc: Jon, Dave),

This series has been sitting for a while, so I'd like to check how to proceed.

I'm thinking of the following approach:

  - get the remaining acks from the NTB side
    (Dave already gave Reviewed-by for Patch 6/10)
  - then route the whole series via the PCI EP tree

Does that sound reasonable?

If so, I can prepare a v3 rebased onto the latest pci/endpoint.

Best regards,
Koichiro
