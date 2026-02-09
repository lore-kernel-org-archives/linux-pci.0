Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020115.outbound.protection.outlook.com [52.101.228.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B24126F3B;
	Mon,  9 Feb 2026 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770615618; cv=fail; b=sjsP7bELKnrtzJ/+dAIJRbFkIDUSfZ/fVUyLRGbNj7+lmUp1PlrT4Cszw/l7zo34UwHPKgSvZUo4+a2Rahv6c7qYjPcWtccnQ/43vEU4nqPXToFU8+HmxA5c0CAx5f9AxXNwdcRhgTEAT+TxzgXdhDycLIztu70fXsExXopJTaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770615618; c=relaxed/simple;
	bh=v5fEcvxtowe8HeoQZB1XwoQ53KjAmSTXMPAtTG3Dmxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ddv9HnCOW7yaSEbvIDT43LD4d2EQXdu1a1EePehZrTmz1m3jcNv2HMGOfugfBm1EyGH5RNklJ8kxglraBxl42Csg2uMsJX/5pDoADDmtid1n0HtdwpNKQ51tUxa0F4qJbgVbGKIzJy0XEj8RojpLQRFHesvmJX/OreVO2b7o7Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=R95KFa8d; arc=fail smtp.client-ip=52.101.228.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="R95KFa8d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPEcLEmFX0ozfA8v/gOK9d9PWmIe4yLdpxiZp/rI7BTPlHLI6GjVBwe23HVKFR2/BrIUj7sbcwgyr06MoGDrMIuwp8wnOavHWVrfKbNkJTdCHuqj6Mkrxm8Ypsw1j9DXjrO6rWrDrLUXDK5z/rwAq2w5uHPQzWSY5pfXosP8R/afJj57Mv4f8hMU6nhFzv+gRxruBMz3CpNw7IWihE08jxFfTDtmwZJxRYK0pe6GimdMYWNA3xeuLFrnhBTY2oVzaJxikW22wavPEDoRAW9818udv9OfZC9Rvv/GSE4VJgpbulZ1KNmgxH6loioYIA7IwRE0ukaJ+dhewM2Cl/4ydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ2wNZ9Qs/Di3isUeFgtMYYNZ/ZINW8nNC1A6tmGxYM=;
 b=dmeZqroK2NDWgvxGlQGdzH3a9+rN46lJRPj1hsVe0adQmQjI7v9NpqDMLlvJm9cvBfMswFMfbgV0zF3pp0jjPv9Ts+ySwptrVO5plhjDdFJs3Df3gmaKj40kcOwDYF1uia22DzNXWHCW+QYwkR8RCl1N+iKRLnGwhr4lGtyvOoUjOCR38IsAyLnR3K24GJKaHKDWhBMGGGinvmXevRKeMml2z9X+c+JvhygyNdOuPmS1Pws5CO6/xs6fozbTLpsq7zcmZxgq511CJcKheph12LuP5kPDgSV7/peF/QamXxqMkMyjSIlwWtJoRYDYTPy8RGyZsIRgyGqPp8JjGGeEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ2wNZ9Qs/Di3isUeFgtMYYNZ/ZINW8nNC1A6tmGxYM=;
 b=R95KFa8dyOj4Gw9kli8eG0QGVnOJcaWRVkBsF6AbWH8VPeOp5ob70MofGBUOr2HzTjOT2bH5nGxX6ljSX0t/WrgLaAeMMhWTCCaqplGbCfADZr6CpYwqJnJSMqA/gfXdYnpp913mQeBhH5O44MRIGsnuOyknxB38QhTxYfLMFH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5965.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 05:40:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 05:40:15 +0000
Date: Mon, 9 Feb 2026 14:40:13 +0900
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org, cassel@kernel.org, kwilczynski@kernel.org, 
	kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: dwc: ep: Fix BAR update handling with
 in-place epf_bar reuse
Message-ID: <vgqd74pmc6av25d2zy6alfm26sjir5nyhxjisisebuawpeqcor@gjxevxzjnbbe>
References: <20260202145407.503348-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202145407.503348-1-den@valinux.co.jp>
X-ClientProxiedBy: TYXPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:403:a::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 41848f96-b4ba-4f8f-54f9-08de679db35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FF624ksoCz9Zpe8KS7OKi1dPa+ps9dam21/S6YnYAMhueVO82Uw1ehQaCDWq?=
 =?us-ascii?Q?1/PUf4gwVnGK1hCs5JT2VAjC1OfZTlUdfL0mrzBAev1O670DkuvQ04+LBQF+?=
 =?us-ascii?Q?I6O/Px5Dg6/ccUaSGQbo0jVP6QFIGVapnXWWt/H0tZsxgOVz24NJTCpJ0qPQ?=
 =?us-ascii?Q?F7QNy9jg+QSKtN258P1eXRr6pTXX/hunAtSSzaQAwvEcBOB8sz5jKh7vAKY6?=
 =?us-ascii?Q?dvc1SpUelY/MibTNmSPDWpPv/oxbfhXiOpyZPZVGoktiCIgkXVo4BUaM3l9j?=
 =?us-ascii?Q?fSsxed7iL4aMkZguSuzXSyBS/XZAhfhUm4HdGkviTLZCh+yIq/0xp4fFqIly?=
 =?us-ascii?Q?nu820U4XQ9y9CUboRawoI6ZEM5MJg9M+mcagEP2zD50RNKqmvjhE5xlHlWKw?=
 =?us-ascii?Q?h+3whxNi7QGiDqdx0jW+FR5oLu9rR2G5hgxiXefiuTEX6wTp9vw4jsNs5zCF?=
 =?us-ascii?Q?fEK3aijoo1xSdJLAh24nBqEgS88ZS3EXqKB3KM+Dfd2rL6YfeY8KiKAiYHRu?=
 =?us-ascii?Q?iKkRdGh/r3JUv/5MGDgdSnh1roacxJlpMfUYYXAsCTrljOqKXnnIH86ntTg8?=
 =?us-ascii?Q?hLnZTiyyg5BST3lWydfhOX7xEbXztohQ5b0VdP7ZJEOEa+q2/VVetHKKUUDV?=
 =?us-ascii?Q?6Cji5PEtLcFLG6Wz3TyVbeI3znGe7G27GD9OY5iu6CfjV3BreGURHvJuEICx?=
 =?us-ascii?Q?fnlml3fqpKq69amYJi1VegycKR1WB3fVgclTri8hzi6EmLXUyqbK4mOH15DF?=
 =?us-ascii?Q?kB7QCVFnSf2Mcy0qhczWRmN07betSOTMZcE7Ya6h7lxu8B0Cpd0lb1LwuZMX?=
 =?us-ascii?Q?KUFB2L5lrSg8MUX1qKD6WBe0s6q7s7AK7L9wNG3Ylf2Mdx/uWxYJu/9Eb2/7?=
 =?us-ascii?Q?t4RTmffvQdZ3FuqwzmIdZcfHwEz7TtBxIv/h7K+mSTz88EVFRistSVwRfyh8?=
 =?us-ascii?Q?qgVrqODq7f6GNHDu+ejcrycxrcO/NvhEWrBGuy2I0T/hm+MDu72DiJjg2L16?=
 =?us-ascii?Q?XAUBCDxMyKnpOOjHMhXljh/N4q2dDmlV5ZCTN82y7tobQdwdcpsFfD10DKNv?=
 =?us-ascii?Q?FBBnTDTFVevf8PnPOBc8m694CQiqrU77CYOpLr2zmx1qoroJ2I78zAphevXD?=
 =?us-ascii?Q?ZfIXzBE/1j4g+4tNZA9T7iM/p6EC4ogsLbhxglmw1D4oQPAcBVfkc0v/B7l3?=
 =?us-ascii?Q?j9B831sYmZkEsMzUKVVBprsd1YyOMukqiGSEhU4wrxgWxtDeHCzLE93Eho3b?=
 =?us-ascii?Q?4mjO187yZYNNhE6odg+CBlu6pjxgq3QHuHlGfspNd6hMtGujOJkiPr+3PSK/?=
 =?us-ascii?Q?bQtQjn91JR00GzQx1Ia3M8Q9ucLjKheHKowZWxhhgfflwYqiS8KIPktj94dQ?=
 =?us-ascii?Q?WEYEaUG77R9+KFvJ7tqxRAangEonIdedXsAZpl71/ycG72xeMbHGMMYdqKTy?=
 =?us-ascii?Q?ZnGWSe9SIAfjUzW5/79Y8nw9HBDXWGSCJPoJue05n5gr/sY2+GHcKTqY/4EF?=
 =?us-ascii?Q?VpXjGNTywB7RQ4U1ZE6DPElKFw7AG3QOpzGeO0vfcxUoRxcV8vSNZ2d/Sf3r?=
 =?us-ascii?Q?nHkRSZpHpc4juAx2UZPdRf3JQxF/8NUnHlRqkhznAuNpdOFml/vmHCooc7gM?=
 =?us-ascii?Q?PnD/ptT+sho2ZT8YZq0j7PmgGSlX0QIxF5KmueMWLNxE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nH4TFVURwHfGS1VlcwV8HaDU2CB9lGVT8WB1a69mBxTwtjDfyvqpHiigKk7Y?=
 =?us-ascii?Q?XEuYnolliyeXnLhZ+OPeCoVDQaKHTdankyePqSVej6QSFSiHp1r8k+zTbD/s?=
 =?us-ascii?Q?/eWtt3xBmMUKkx5kre4m8BVPwbUhEB1lMnd9qURTjhfDgXSR+OrxWA9gfKDg?=
 =?us-ascii?Q?04dM7ixMaBKl9cV5SPQBXgGTZCdJKbWpyKbct4VvMIdDvXWJb1FI1fv7+z+o?=
 =?us-ascii?Q?6UWUNeH1jGXBSP52kamJc674YaEZnqHwJkGxjwByv0iB37BLmN4tKQAdoaT2?=
 =?us-ascii?Q?hRfG1udUmkC3ZK5BUJkqyTnrwyCYatKkeJy1PXyeKT3sgX2kYSzRUnqJJWZL?=
 =?us-ascii?Q?2hB5Oy+Sxo1eTnmqRJrxT3M/IPfCfRMAFSNZpnB+zTFu1jo+e40/fskOPopi?=
 =?us-ascii?Q?KCGYueZaQU1XG+0h2k4p+vckgV++pOm9tDJ9ZlLfS6P+uvKxXDuhpv+z/Si2?=
 =?us-ascii?Q?AJx+q4Ior9MGyLFS8Hel2WGkce9waovrqWXZxeq/k+o+rih3GN33IN6K1qyC?=
 =?us-ascii?Q?iCMnTl/yaH3vNFDwEz7BvXtS+BchROuvlQBfppdWKnl+9v6IV2ObaTnalkS9?=
 =?us-ascii?Q?3zWocwjcDwU9yLnFF4+CaOCLBQtQTwZGAsXHQ8fASzH9JGK8QqtA88Ei9uZN?=
 =?us-ascii?Q?tjOQ0hXl/PqL0jhAZZe9YXH4wp2Qo4HX2PEomtUjTt9DYY8dLoXPrQPMijP1?=
 =?us-ascii?Q?1XtlcTL3zBKdIvP1taH0QymOF5IgJCuMNgOyNecfAmp/oM/wLsFqVxfpkNdM?=
 =?us-ascii?Q?eorIIhKrTuDhE7w2FWIqKH8tKSWeZRRWPaIq7mvGAOoc1UjQvqkoW5rrsAYo?=
 =?us-ascii?Q?c+Ifq4rhT0udBSSP1pfGme3S2B4cQVs/x02tygF/FNmXm4O5pmkyyfQMefyz?=
 =?us-ascii?Q?ysJffjDIh0uPfjq8coRjtuc5dzoJl7ZO0y6Y1qu3hcvZeM66Kuj6Mhlfn8UX?=
 =?us-ascii?Q?J35bOeU4KRYQfKqJcLnELZ+sMqsAQ29QM66W3hnG/wDz6V+4HruYywT4ZHIr?=
 =?us-ascii?Q?ooeiRY+i4zzAYvu+gPIUIdeNLpVASaEdZIZO8yu5lSi1hUpqaHmZgXrdtd4M?=
 =?us-ascii?Q?c75PzdBCoRph+lIYtk4WET9Dh+t5sS4jSZJlDzCSsYs0674AhyGoPxiVPxOs?=
 =?us-ascii?Q?sTt0hDQKoBiAXemQztnEoVEzX1V/VRYHjZA0S4/mfsEO3tcd4kPbhYMc5DOz?=
 =?us-ascii?Q?2AmVsT2b4HiGCRW5OOYFUnNyua5d82rVB789K+TXN7tBisSoIXhM8a8sO90M?=
 =?us-ascii?Q?78H57e0lx++mbqJ9LgzzxGzAOKxGDfxs4VezV9o4MpBQhM5pFovEqB34HCHT?=
 =?us-ascii?Q?Q4I5HyOnYQvb62OfwkZjOX69n+RktdA3OV2etPIBGlsKRMY+TbrDU0KeOYhE?=
 =?us-ascii?Q?M2eU/tCwRIFqG30M8Vi6/FUJ64iDTu6u69vwWGnuZfzou5YseZqyPqpbvhuq?=
 =?us-ascii?Q?AsJqYXdU0awO8aW/oDEH8GvGiBmV6HIZXWGKEAbJnJuKBDe63WJTlVp/wyHu?=
 =?us-ascii?Q?iHxKAb8tf7scX5QiVLFFiszfiSHZBwbxucxwXnOq2r23lOqzs+J9SDcBPr3u?=
 =?us-ascii?Q?oI/8CgrVx7K+25oBy2xivi50JSwM2cmiMRXrF8u3PVw4DClNkWXS8Y+sNAUv?=
 =?us-ascii?Q?e31abd5CQUXiLJqFJAqJOtBRm7iNMfPAt2JOhIQ9ADm8tUrP9D7psZNbc2pw?=
 =?us-ascii?Q?eOihZc3mNigzSmDgis3CrLeDL8WFs+x9ghiL9aJGOfT+u+9IOH1KEsM6W36O?=
 =?us-ascii?Q?6hQhPAuuGzj63YunaqTdNHkxeDO3lYJXXY3MrqaOz9ENu+xn/M2j?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 41848f96-b4ba-4f8f-54f9-08de679db35e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 05:40:15.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qIQQ8t2RFlQmV10BpOAC+MM65Ai63PEzNgn8JjLJLwV3k4FzWZhXSe0L4+C0DMHCa775qfdeQ3KddubAd9xIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5965

On Mon, Feb 02, 2026 at 11:54:05PM +0900, Koichiro Den wrote:
> Hi,
> 
> This patch series is a follow-up to a side discussion that started from
> Niklas' comment at:
> https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/
> 
> This series:
>   1) Makes BAR Match vs Address Match teardown in DesignWare EP explicit
>      by returning right after clearing a BAR-match inbound mapping.
>   2) Fixes the dw_pcie_ep_set_bar() mapping-update path to run
>      dw_pcie_ep_clear_ib_maps() unconditionally, since the driver cannot
>      reliably distinguish BAR Match -> BAR Match from Address Match ->
>      BAR Match transitions when the same epf_bar instance is updated in
>      place and passed in again.
> 
> Base: controller/dwc branch, latest:
> commit a24149881558 ("PCI: dwc: ep: Add comment explaining controller level
>                       PTM access in multi PF setup")
> 
> Changes since v1:
>   - Switched from the v1 approach (Y) to the alternative approach (X)
>     that was proposed earlier in the discussion.
>     Details of the v1 (Y) vs v2 (X) are described at:
>     https://lore.kernel.org/all/sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p/
>   - Changed the subject.
> 
> v1: https://lore.kernel.org/all/20260131133655.218018-1-den@valinux.co.jp/
> 
> Thanks,

Hi Mani,

Just following up on this series.
If this looks fine to you, would you mind picking it up when you have a
chance?
(Niklas has also commented here: https://lore.kernel.org/all/aYSZxCtACmQyC0XT@ryzen/)

Kind regards,
Koichiro

> 
> 
> Koichiro Den (2):
>   PCI: dwc: ep: Return after clearing BAR-match inbound mapping
>   PCI: dwc: ep: Always clear IB maps on BAR update
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> -- 
> 2.51.0
> 
> 
