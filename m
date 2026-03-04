Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021103.outbound.protection.outlook.com [40.107.74.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83D364EAB;
	Wed,  4 Mar 2026 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593833; cv=fail; b=d9ki0MyLzOLU2d3gHXVjso+zDd8ZXu20ZWT665/Lf+rzQr4JSxDPtAVcMybTt7RkgHMbNcS/Iim4BNNnv11eZEcCoLN5evsfzpOr0FZlxWBRkXwS5ZSYE8yLWprmA+ffqZTj82eAKhL1BPQHFZcsZpgPZByTtYBI4UxckmAhSWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593833; c=relaxed/simple;
	bh=OIbDofnQITaDdhrKlw6z97OoTahsCSDot2kjrVobVco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gOYi47saYb3s5BtrGPQg3MPRn3YxMAdT4j351Zw1tnq3BH7S3RMLfdLX4OdaRqrjHIwcDDcG2tRGuvjNSNW+bbK0PHFbJpaC3KbISGkxQH8ZIO7e06XmEehECN8ZKFyupAzDor9toTuNf6NoWg3v1Bvl3q3BUnAbSTDGsO/MXgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rfM3GBT9; arc=fail smtp.client-ip=40.107.74.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rfM3GBT9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdARTqg0XXP8LRvyeFmWomnwemaUViPz5tCgQXj1N2NBmLPP0PzoEOa0L/P+cYScjSs48el/d4IIqiQt6GtTBRrxUfhSabuJkTvLLt/CAK+IrD6FJBkOfyc/YpVnCG6gnwkW/J8Wsk7wgJH98w6tPKy+5LmRsN0njDelIl7Xalvv5ie6FIzDHgnkv+T9iFdO0OnTDL1tYGlAmtlETNqZLeQCoQ4Nf5+9tC1PdPnVfj0UVG7pbzS3n7UCKIgNC0Z98AlU4gBG3/4ISjMaKvoWb7KIv8tLtgnkDRZoqt0fbO8/FXlv/r3CSdp8Pg3iMBClI1Xw0RmcZMpjOfHfIJxGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUT9LJ0RzUOelj5P5L5PhKSyzWuUYnlPhsRSXnvN6Ow=;
 b=T4lCHawHN/yybQv67MkwGEtWkhoxSYfgEdUgX18hEHe3SFiC2RgV9HgS+T4BEfebJBAIOAA8A8dGPI/1WOoPJLxTMrGueyH/cDhUGIPwEl4RCoHrlIZ97yeVvNgeNxH6OQo9zcE5IjD9QGq7zz6DLZOHzL7IdQR1GlveOX8xHyqRaGUKXDXo9Y7oI8gU8fSDbIpqX1dnT9ZTiwMxs7pNr3O4Rv7xF+8BmnSZ7f2PInwrGxa+QDI6omz1Szu7EArNvvTM8f1jZJ9Y90qh71U0wyIICDIYKuUoI+HF+0zbaL08cfixV4hnLn1uKlgjO/ruSMCxWldACZRdUfGRpNcn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUT9LJ0RzUOelj5P5L5PhKSyzWuUYnlPhsRSXnvN6Ow=;
 b=rfM3GBT90D1HnYBFWVGZ304jX8lJ4Ht/+Ammf3kAprHVcP/EkZF2APG/woFpZtnMToG7iWbv+Fj0khYOaNPDqlYvCIzxcR/e5jKseoWwLd5JokaV7uKCcN9iv82FbDGLlGIWg/Jv+C5f04OsOcZrH5c4dfDJ+RGWGKhEJxzkWiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3779.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 03:10:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 03:10:25 +0000
Date: Wed, 4 Mar 2026 12:10:23 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, kwilczynski@kernel.org, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ye Bin <yebin10@huawei.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] PCI: endpoint: pci-epf-*ntb: Harden vNTB resource
 management
Message-ID: <urqlfeqcp4grwqia5tu5am2qmzvbkiqubyxtl4pijlceidlelz@jm3lrlpcg3rp>
References: <20260226084142.2226875-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226084142.2226875-1-den@valinux.co.jp>
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3779:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fb48b1-a998-47d0-7677-08de799b9458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	Dq7le2oov8142+9JQMUTEdW8hFbdFG0+6fw34qfIIx5W3Rpc6OSFB2G9MCmov7Fqws5XvzwqciywTcWQXeUgoQaa9X3BqhLfXvpZ84IoZT/osS+mJd5Rw38SgbXwNYVVpKuycxlLxr3fJcplkzT9Z0eXLxYTClcpvkXcecYkTFH1AvrHLHZQYlVXTjJv3aini0FEtfbHBodqr1A7H1PYpzkjcl9ugIdlLkkUfrE5bb5fNIEeUQmc4sDsygsB8J0sIR8E3NBC95bTBydpzBjXkTgjTWHQKOZEUV4VgBbi/kXcWfyIh6K6zSCXTG7iZgCfiCpuur/DYkxApoGcKETQoNithXHHS+o4G3iDawW9nthSCdXiPrM2677Lpgzrjjf4DBJOO0UYsQmfFw9vl9KIqqInbB4lo+yj7dl+3TroUlipHLnj4SLlwIWgLVhXvJ2IYzSmiUgHD794PNgsVTt579vYzI1PLqDSwEfXUSYEdMkpA99KYKxSc2CQEZWgwDeSMb5ka9r3u2YJ0X2dQwUXtF5uMyjCRCFtDxe0xWKLlNQnqb7wU7HYgIuouMpKWYXqkKzYORCRCH683E6crj7rqhImgVmw9CNqA0kVBHKvVQtdHwr3uwx7pVcpEPZIlDhwLhj/HLydSfvW19PtWdFar5waWakByx2Pjy9XoIT5tRO7pUgdRiWOXe09KNfvTKiJOWyTtbArOFixIzSfE+eY/SADZ/882HVvVBPEjGYQUkWp8Th5Q4mF39HWvaew7By9ev8WweJ/pvZQG+mFz49ypLjgjS2R3/EtKjns03gHa6s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44hxdqQWDw1H3eIU3XsfItn2uc/RV1eevAsoAijx0m0Y7KZYLVLl4zHYLDIJ?=
 =?us-ascii?Q?B0Z4GMgI5T+4x6JqG9QMt7Ay/duBYxLyq4t89hmeAEIRY5L/tKLFZjnv52NY?=
 =?us-ascii?Q?wyChQCzpDenvuD2HAHBnDfhYEQ8AbOsuluyyh2HD518hCz1WhoFG4k4rz+kU?=
 =?us-ascii?Q?hMO6F7E3EPc/xDQsnRQzagq612fFeaS/L+PhTmJwhNMgvHiP4vLGt0q6s4u6?=
 =?us-ascii?Q?sQPqoKZouvpazp3JqzuDF6RGjoFgvEZ2m6rkxNCx1S0Dqg7EUDm/Q9G8RRyo?=
 =?us-ascii?Q?GDy0fZ5iJCD3/5eBDtAGaF52ODuNgEWR4zn7JUjNyQhnhsowucsMm/thP65f?=
 =?us-ascii?Q?GbIg1kcW/HuLi51tVnpMB3gSL1U8JixKy8jka6dfwcQ9/UZbMCVNs7VYqMDg?=
 =?us-ascii?Q?MIPIXkZEDDvKrz2i77QNWVSSfTwcsIOI0WzCtIR8CVB0i8uGFfRvmeuq1dR/?=
 =?us-ascii?Q?jNpeN9TjEJ3v+C//zPWTf+0KQ49Wvc4e7Rth80qhMiek8+m68bcXN8pkAxW2?=
 =?us-ascii?Q?GYx/kljvSjPY8zjDyk9g3oRMZanUNoB8KYLrprcO7RbE3eVQ8BugaSz3dpAi?=
 =?us-ascii?Q?m26PTFQ/EBmh3Dl6PBY0yRJN5dcmfqpKde7toqoYjad18DIR1rnMIpQ2eAqD?=
 =?us-ascii?Q?KVxoXgJc59FzM1sl6ClbghhGKlFPBSDmu7q+TrsGWkZrz2PdnkeicMTdOeed?=
 =?us-ascii?Q?0dmU1WB6tH7tL23mEjuxXMy+D6WEgYN4nGSjDXY2NCBb2P4388grf7WFJ5tb?=
 =?us-ascii?Q?XnIJCNLDEp28do+4GVjZg4JL/ycehfJS7NvREW5KqclwTchUP81Dh2OhNCya?=
 =?us-ascii?Q?fTqRuTg0q/VV1qtJ175+ddbLSPK0QhGL8GhRaYwiDZYGvbVl0iuVJ2uQNCCc?=
 =?us-ascii?Q?aOoVrgR1gsC2FvqBKR5zUPJ5PJ/k/LAHFv/cP72/LBbK4CioDRPczAyQ+WvM?=
 =?us-ascii?Q?F1sHOibuylVaOdaKx9mOWmxzmmwNc/3CR3f7lZxUodbD3+sVH3PH0GAWjh0U?=
 =?us-ascii?Q?Lh0xOfjwYUlTjcmUeP+zM1ZE+bphe63siJkQJ7o4Rxt7jlpVSWENubu0Hyzx?=
 =?us-ascii?Q?Rq/728+cNUw/Vxo86KkceuPD7CL9lLVy5vTNShGNblZeLyD4sXfM1aypdDx6?=
 =?us-ascii?Q?Xt1gZKtAE3pRzFng7R8Tme8gQtgjR6YyyrZFj/BjVRUGOxAvvalepzBZpbRM?=
 =?us-ascii?Q?R8WwZ6MhgiTncKw0IvKkcY1VHcKE8Hv2m95arIcBP4fM/geMpD637cgNmPzS?=
 =?us-ascii?Q?9Q6yJ932sky5ClcmWERWl8n7n7UoJgsQoHQFvb5BMLQPNJsLNTsgqRiN1+d2?=
 =?us-ascii?Q?cdkJotkpEHRsiChSmt+MYRMBletIIpeHFtV+DiV+RusDH3FIdzp3z4TiZ0Pf?=
 =?us-ascii?Q?XlRmz8lErfD4XexJfw3BX2RkFWQY601bXBMHsxCKbb/wO9jJxdT1tRi6lZCE?=
 =?us-ascii?Q?RralreS4G2pwoiWJ7bjbdTDma8wW5kDxa720u4G1IEfeb9QdrCUs2jK0O3R0?=
 =?us-ascii?Q?0LmNM48qAyQF01xzvl/GENM+QEtao/Q9MjxRdqKtq70fKqamDM3xtJtt0nN8?=
 =?us-ascii?Q?qdrjGWk1GYB6dcEQ68/4m21ntK/La0zcKznjmoBJWd/6crKbfWoxqMOJ7Ee2?=
 =?us-ascii?Q?inTTgdffj22DR1vtCfNfRqyFaJp1pDd7xB/Ug+1lvQYsExWQx/4UiHE+mFzt?=
 =?us-ascii?Q?LtgtLH5bsy+jrq49xpjNeT/ny8lxr0nnHr9Tb0WHTOg7JjvzdSfwWUk7vMTU?=
 =?us-ascii?Q?waAZ1Pp6Dhcm0GYP4vdrixLn21yFOu5YBueJGm5s9BruR6rshooK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fb48b1-a998-47d0-7677-08de799b9458
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:10:25.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BofherVBf1YClXHVGmkxSxEyaTjW5THK6IiFw5FktFbqZxPKXQsfFHLTdBvS5Ct0akyDqfDyV+05NhDr7IufhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3779

On Thu, Feb 26, 2026 at 05:41:37PM +0900, Koichiro Den wrote:
> The vNTB endpoint function (pci-epf-vntb) can be configured and
> reconfigured through configfs (link/unlink functions, start/stop the
> controller, update parameters). In practice, several pitfalls present:
> duplicate EPC teardown that leads to oopses, a work item running after
> resources were torn down, and inability to re-link/restart fundamentally
> because ntb_dev was embedded and the vPCI bus teardown was incomplete.
> 
> This series addresses those issues and hardens resource management of
> pci-epf-vntb:
> 
> - Remove duplicate EPC resource teardown in both pci-epf-vntb and
>   pci-epf-ntb, avoiding crashes on .allow_link failures and during
>   .drop_link.
> - Stop the delayed cmd_handler work before clearing BARs/doorbells.
> - Manage ntb_dev as a devm-managed allocation and implement .remove() in
>   the vNTB PCI driver. Switch to pci_scan_root_bus().
> 
> With these changes, the controller can now be stopped, a function
> unlinked, configfs settings updated, and the controller re-linked and
> restarted without rebooting the endpoint, as long as the underlying
> pci_epc_ops .stop() is non-destructive and .start() restores normal
> operation.
> 
> Patches 1-3 carry Fixes tags and are candidates for stable.
> Patch 4 is a preparatory one for Patch 5.
> Patch 5 is a behavioral improvement that completes lifetime management for
> relink/restart scenarios.

While I'm updating Patch 4 and 5 to address feedback from Mani, as well as the
concern I mentioned at [1], I noticed that if [2] gets merged before this
series, another issue may arrise. With [2], the DB IRQ may become a shared IRQ,
in which case the unbind/remove race would require additional care.


Mani, if it's ok, could you take Patch 1-3?

- If so, I'll spin the rest (Patch 4-5) into a separate patch series starting
  from v6, with some additional commits.

  It turns out that Patch 4-5 are a bigger change than I initially thought. Even
  though Patch 1-3 were originally written as preparatory fixes, they can be
  applied independently at any time.

  The code in Patches 1-3 has also been unchanged since v1 (submitted last
  October).

[1] https://lore.kernel.org/linux-pci/mipdls67csyyrugf4rjx3qqtbxes4sjjtluy3psecnadcgcs7k@rn42d3m6ggsf/
[2] [PATCH v10 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
    https://lore.kernel.org/linux-pci/20260302071427.534158-1-den@valinux.co.jp/


Best regards,
Koichiro

> 
> ---
> v4->v5 changes:
>   - Rebased onto the latest pci/endpoint (2026-02-26).
>   - Dropped [PATCH v4 1/7]; will be reposted separately via the NTB tree.
>   - Dropped [PATCH v4 2/7], which has been applied in a different form.
>   - Corrected the subject prefix of [PATCH v4 5/7]:
>     s/NTB: epf: vntb:/PCI: endpoint: pci-epf-vntb:/.
>   - Picked up a Reviewed-by tag to [PATCH v4 7/7].
>   - Resolved a conflict in [PATCH v4 7/7] due to commit
>     dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support").
> v3->v4 changes:
>   - Added Reviewed-by tag for [PATCH v3 6/6].
>   - Corrected patch split by moving the blank-line cleanup,
>     based on the feedback from Frank.
>   (No code changes overall.)
> v2->v3 changes:
>   - Added Reviewed-by tag for [PATCH v2 4/6].
>   - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
>   (No code changes overall.)
> v1->v2 changes:
>   - Incorporated feedback from Frank.
>   - Added Reviewed-by tags (except for patches #4 and #6).
>   - Fixed a typo in patch #5 title.
>   (No code changes overall.)
> 
> v4: https://lore.kernel.org/linux-pci/20251202072348.2752371-1-den@valinux.co.jp/
> v3: https://lore.kernel.org/all/20251130151100.2591822-1-den@valinux.co.jp/
> v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
> v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/
> 
> 
> Koichiro Den (5):
>   PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
>   PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
>   PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in
>     epf_ntb_epc_cleanup
>   PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
>     pci_scan_root_bus()
>   PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
>     teardown
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 88 ++++++++++++-------
>  2 files changed, 57 insertions(+), 87 deletions(-)
> 
> -- 
> 2.51.0
> 
> 
