Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021087.outbound.protection.outlook.com [52.101.125.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77047D46C;
	Mon, 31 Aug 2026 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192681; cv=fail; b=QjPq64vmQvJml0qtCqWBitGv01g4WlgLUzqu/Lkb5mCLaXtnxJAX4xUsxcKo5ZZzu5SwJoBZat943HIYhSylRrU0Qz6HwC0osyp4a9MrFlFGfSJ/RmikbeI40fQPo0QlEgCnFQ0wnVu1ooOP67c7cYMsyT2fOEyiz3s8RG611PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192681; c=relaxed/simple;
	bh=/jvovHECkWG8u+vb+mIdwKgSWvoBO+6p/8cwA3RmkLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UJMgtdBmdjKbSih2x9//p+1obwnjKWipJLxbDnNZA2fRuEymL51Uc99ZEuvcjS53myL9lG3PP94yCVjh4oHDt1AzadKfL+nSlvdm3HMhM/fsPRfGrEhyId3I/Z7Rp00InSI29OMqdm7yLtMN77KEe5ZfvlBfCfqlAESouQp4ftQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=trOfWhAI; arc=fail smtp.client-ip=52.101.125.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="trOfWhAI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSgqILIF4DyaR8opYPOy/4dtQiLXOrd9JTgUCAOKOrRqGFTkjeGelUgq3DcQPp8a2A6QmTiAy0oGxfQLqg1lZYVn1wJZRjfD0aio/1/ApevMi35hjK7Ltmf4lcpNwZL1v3P1KVfuLPBOCQ+lR+TR9B4CuFgKZ9D/LcyKIw7gaPTgG2BRlcViegjfIk33Mi12paWTdl+pPw9fCPm8EO2RKK0g1mlihnHf69P8DxqEMEtfebtNL7Tvm+zbhtk1BaQSiFmX5hPstPH/0F389p5flC4dmXATq7202tFEOU2v+ijvtzyEDNeUqNC1afn/IW5cABXmCBGdPGWf5wiGw3aqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HLespaaa6W1UsF0Xw+tSb3nI9cRJGC8HaYzeOGpxoU=;
 b=NNvHQP6jyy9D4S0d1/Le1kuLTakPH+02aPjvdpDkSVaWH8Xwr8JNFR9dAbTsT6uq6cPO4VoX5MEAFxj+g/HWQSjEUTUtLPprAck8/A0eRfRPDi0GJemy71dAAC6NvdJmtvIdHenNizICERkPcDEg5ozhPYCsAa7qf0oDeXmn6PfUdZ3F/G8iPohNKPjSeFLSu/Qm9etn2Auw1xbnMShDedkWTFhnqBvTYc0jr/FDxqiNOoi/TpVnjbTo/tra0Nq98hVvEPYeCwHcWR/4ks6FHssDqV9bfwttb+kuIKE9JjNC7ocsqWvVuwClD8u3gjSyaCaFYhqXrYy8C3Dmdn9z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HLespaaa6W1UsF0Xw+tSb3nI9cRJGC8HaYzeOGpxoU=;
 b=trOfWhAItQjsDk2IgV6LJkoIkcHND1kcAZhnieeO+RqFJJ8iTIT7jzD5pJrIKrqLXcV7dtDly3/9+E7XFQsuBrb0qAvS37Xlz8hGxQUMgugKVcsQ00k0fZBjiy4EOmtcPfYM5SvWjwrTis7qrCY4Kzt0FjInbEV8jSBt6xjpic4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6085.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:26a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:10 +0000
Date: Tue, 1 Sep 2026 01:11:09 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Aksh Garg <a-garg7@ti.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
	ntb@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Message-ID: <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <apVWd1u9JjTKQczu@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apVWd1u9JjTKQczu@ryzen>
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: b41eb1f4-e9a2-484e-5933-08df077a7905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|23010399003|366016|6133799003|10067099003|56012099006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EIQIzVl4VN3VzAijZOPJz0JYAZXK5eR+QuCquGw3d49d9Zo8Jc7sO8fERm1vwp8WBmH8ckN5pBkTQnNutYDElNIPmvbJrK/HV4oM6siPjRQHyKHCrvottCqXCpL/H9AJfOMNMbjfMREMxriyul+pd/mKuQwx5qjpBwjAezISF6W50qvR1kMelO4FqTg5mJiIIUIXBHkgNztbaR2H6aK/CroRoPAVbV7vxoYO8HoIrJnI8t8U0vNIganqiwoyQlATA+KLaQ+yMxemqefRAx7ILWDLH/YUYvCZg7PKZ0lQYauDYJher4wnlWrjOxFsDq/rwcWGhkYBrwjHFCkaH7IeYmUXvmVBPkma111eMvLp6Sj6fbUM5QGELiXL+bIw5jpOjnKBtr8TsPIz2fe8AiYkPrXLKUvSG6GOoVQRa2EFH7YkeFz3cj2mwHgkP5PdVp1eYFzm0JNd2We6aU87p3JD4iOM6YViTemcoBnvcJQr4unC5W4ChLLq+/MOxp0JNzmZ5syA/vz5fBLsRdAut3oBgn7NfOJbyFddoZ86w2z7eCNSTC3TC8w5o8KdBuAjovuh8tc6n5IlIjuJBdv5dB3ceQtLtRN62raqJPdaqGyU5GByIixr86hK6VJxt6wh32Tl69adx45nf8nZ+Lc1H5X4D4UiNB8+ju31VaoMJKuCTws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6rfSuF5oitl8aigYrS6dugE5IIKhXE5nTmHmWvUhLmdxfZ1unUKlW5oOBHOu?=
 =?us-ascii?Q?RSoshDYTD40WG/pd7SdnVVLK9GyvLXHfhCObRqjZBtye5Bkjy4EJ1sK7L2Tj?=
 =?us-ascii?Q?0Q5qc0r97jy4PEyQuA8r1xRjsghnYu4CwJXRK4jq4Fb+ZX8mhEDKFn5M8LMr?=
 =?us-ascii?Q?fwuUQSKJraVxuFB1gJdrg8aXQphDGgWYfuLNPHbawyv+ByRTTBqOoNL4d3ps?=
 =?us-ascii?Q?7xO7OZEY7uYy3V2u4DFuskmBZZEysKpaQL6FRQ5CcZuiG3empBaeo2HJEGee?=
 =?us-ascii?Q?VF55iNibwL/xH+ZwJSZry1TGUM5EB2ScT6+EE8vXM1wU9zwCvXnZ2Sb/4Y0d?=
 =?us-ascii?Q?SQO6/hq7oTTH416VRZgT/SRasF13/r7oXh6EglD/JbQHVodbID3uAF6TnSkN?=
 =?us-ascii?Q?LzZODHAjVgTpVRdxh0H6upV+RfftpiGwYf6jRdlAY4Jb8ducpWe1Ft1K/ky6?=
 =?us-ascii?Q?VUtC4217lK7khCVUCPYH1GjvnomMV2SkJS+lseDMOfyBORSlnaDTEOppUCUp?=
 =?us-ascii?Q?ZBzrGxmZxA2MCtJzWku1RNnqffTAC4WZ/wTDOKjLww8o1t/hUugPcF0NkqLT?=
 =?us-ascii?Q?eNT26Qn/oG+FMS/R26Pizy+fehw1MikoPh9NjsIqQsEh2TxL+FqDqB1klLoV?=
 =?us-ascii?Q?Bn8Lba4ArvKr5v8zDgtzjGpSycJLufUGD+YjGLjMljbH6BrkPEkFZZPwACWX?=
 =?us-ascii?Q?2Edfw3M1BOSEVR81+rq6oFx0tvGEW4yBQUmUEHmey385j74bJAQJRCgaHNNI?=
 =?us-ascii?Q?yaFqHIooE1QBZvLoTlNxIwQtyY9C5TwVEvUJVIV+dxwJggEqV7UtV2ZO5D7a?=
 =?us-ascii?Q?OfuHChNF/O06HsJJA990HX3k5XG5FwN59DICPsoHvhADFWpn2Y6lauN1OjFu?=
 =?us-ascii?Q?ZvGqzs5xvZrB0J8mdvExjQKgaWrFpP0Sjdl/VZA50k1fMEAuVcfr/OzojmM8?=
 =?us-ascii?Q?frg/CMZx46M7vIeBLkO/fIKIl3LMexulKc9awjt/2F8P039gDlIEYE0JffZN?=
 =?us-ascii?Q?iTmYo5RBJ7Mzx6CW3E1v5wC5x6LVuZoP321KuEbwy9QSI0x+jTUc4aFuCU2z?=
 =?us-ascii?Q?o6TqRrY1RLgxcPse2J4fd7nSmK2QSpnhsMyP3Wcj87e2sFI4kNKvaTF92mXK?=
 =?us-ascii?Q?xSNef+EFetoGt57b8/Om3ycFOTSAM3G3CFV6ZQtiXFPomGLqusXFNnA+KMqf?=
 =?us-ascii?Q?ISHPPlZQkMszacwexpciSwptCQppPIgmAyVjKNcR27qzqkf+TW+OWzj6n9Mt?=
 =?us-ascii?Q?CX4njMFAGq+Nuwen7uLTvZ/41E/pmIayGsE3nKim25JAUTKZrTbFuGVJQ4ZG?=
 =?us-ascii?Q?IIJ9FMZpb9T1F/JM7n9pg97FoWWbiGXnTCuX7hXXor6BwkiPhQ7elmOCZaoU?=
 =?us-ascii?Q?RW98AzYg4gI8hz7eZRq1V14n//XT2Nm1LD4POGIBMCvOw443XvxB3OqrAjYv?=
 =?us-ascii?Q?yKhqm1c/R1eooDxdnuEI8QEV8xHEMn4KcUA7PSLi20imP8hi0Ts9wh5R/PLo?=
 =?us-ascii?Q?Flm+Z9/ZF99vwkjKQPeztA+qtsT3vqsy2FuAio4OrkxxM3earmJyyYr3h4KZ?=
 =?us-ascii?Q?22anEfQtpz3R2CNeeAUwmCQ22PLvevSrK/Sc90TddfH5ckRDL+6/EDdsgC25?=
 =?us-ascii?Q?ocJS4yxRfQ/081XrA2UwwUZBfWtCyTm3QeNknSNZP0LLA19xc6GKaOdrbTwO?=
 =?us-ascii?Q?L5SN88zv5fg6WFV5LyaE015o9PYFKdWNuHii9XZM1ihhAZ2Wiva4y3GF3ysc?=
 =?us-ascii?Q?ahzJ2lfGY6yO4EMwKncxxfajdz4RJQP0UwkPsSsaA36A79btqZyT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b41eb1f4-e9a2-484e-5933-08df077a7905
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:10.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph0CgJbLzpQPZsLZ9oGHwdOf+W37lyOUqahT9SuiEvN29dZt/OUXBcY0FxmosMVOEYQQsmaDaYMSMkGtsNc03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6085

On Mon, Aug 31, 2026 at 12:24:55PM +0200, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Mon, Aug 31, 2026 at 12:19:45AM +0900, Koichiro Den wrote:
> > Hi,
> > 
> > Some DWC endpoint controllers keep the MSI-X Table and PBA at fixed
> > locations in a reserved BAR. On RK3588, the MSI-X doorbell uses this
> > hardware-owned layout, as discussed in e.g. [1].
> > 
> > The reserved-region types for the Table and PBA were added with the
> > Tegra194 description. The MSI-X setup API, however, still takes only the
> > Table BAR and offset and assumes that the PBA immediately follows it in
> > the same BAR.
> > 
> > This series passes the complete layout to pci_epc_set_msix() and adds
> > pci_epc_get_hw_msix_layout() to expose a hardware-owned layout. The core
> > does not select it automatically. The choice stays with the EPF.
> > 
> > A hardware-owned layout is not a direct replacement for every caller.
> > pci-epf-ntb, for example, reads host-programmed Table entries from its
> > own BAR to set up peer outbound mappings.
> > 
> > The series also fixes an interrupt-type mismatch in vNTB. ntb_hw_epf can
> > select MSI-X, while pci-epf-vntb currently configures and raises only
> > MSI. On RK3588, selecting the fixed BAR4 layout also selects the DWC
> > MSI-X doorbell. EPF-owned layouts continue to use the regular path.
> > 
> > In short:
> > 
> > - pci-epf-vntb gains MSI-X support and uses the hardware-owned layout
> >   when available.
> > - pci-epf-test, pci-epf-ntb, and the NVMe PCI EPF keep their EPF-owned
> >   layouts. This avoids unnecessary changes and reduces regression risk.
> >   They can use a hardware-owned layout later if/when needed.
> > 
> > [1] https://lore.kernel.org/r/aY2q80zeRKSRO21H@fedora
> 

Hello Niklas,

> 
> Perhaps you could improve the cover letter to more clearly state why you
> are doing this change.

Thanks, that's a fair point, the cover letter does not explain the
motivation clearly enough.

> 
> Some guesses:
> - Better performance. We avoid the need to map + unmap the MSI target
>   address using an iATU each time we raise an MSI-X. We also avoid the
>   need to flush posted write before unmap.
>   Is there any performance difference? If so, it would be nice with some
>   numbers.
> - Allows more concurrent I/Os. By not using an iATU when raising an MSI-X,
>   we have one more iATU available, so we can have one more outstanding I/O.
> - Less waste of BAR space. (Since the MSI-X table and PBA already
>   always takes up space in one of the BARs, it is wasteful to have
>   the EPF drive duplicate it in another BAR.)

This is not driven by a performance target, so I do not have numbers. The
immediate issue is correctness. ntb_hw_epf can select MSI-X, but pci-epf-vntb
currently configures and raises MSI. I want that MSI-X path to work on RK3588
with the controller doorbell. I will make it clear in the next cover letter
that, with this series, a doorbell sent from ntb_tool on the pci-epf-vntb side
of RK3588 reaches ntb_tool on the ntb_hw_epf host side when MSI-X is selected.
I believe that is the simplest E2E test showing what this series fixes.

For pci-epf-vntb this is a new MSI-X path, not a change to an existing working
path, so it seemed like a safe first user of the hardware-owned layout.
Honestly, adding a new MSI-X path to pci-epf-vntb while allocating another
Table/PBA in an EPF-owned BAR on RK3588 seemd rather odd to me.

So, avoiding the temporary iATU mapping and duplicate Table/PBA is good, but for
me performance was not the goal for my RK3588 case.

> 
> 
> 
> Personally, I don't see why we should only change pci-epf-vntb to use
> the hardware-owned layout when available. I don't see why we would not

I initially considered making the hardware-owned layout automatic for every EPF.
pci-epf-ntb (not vNTB!) is the reason I did not. It currently reads
host-programmed MSI-X entries through epf_bar[] backing and uses them to set up
peer outbound mappings. A hardware-owned Table has no such backing, and the
current EPC API has no generic way to read those entries. I suspect that
supporting it there would require a broader design change. Also, I do not have
hardware for the pci-epf-ntb bridge configuration.

pci-epf-test and nvmet-pci-epf should be easier to convert. However, converting
only those would not remove the per-layout handling while pci-epf-ntb still uses
an EPF-owned Table. I would prefer to handle those separately when they can be
properly tested. This is what I meant by this part of the cover letter:

     [...]

     layouts. This avoids unnecessary changes and reduces regression risk.
     They can use a hardware-owned layout later if/when needed.

> want to change pci-epf-test, pci-epf-ntb, and nvmet-pci-epf as well.
> (If the EPC defines a HW defined MSI-X table + PBA, why not always
> use that? If there is no HW defined MSI-X table + PBA, let the EPF
> put the MSI-X table in any BAR it likes.)
> 
> 
> I understand that you introduce dw_pcie_ep_msix_layout_is_hw_owned()
> because you want an EPF driver optionally use the HW defined table.
> But if all EPF drivers always use the HW defined table if available, I think
> you can avoid introducing this helper, and let rockchip_pcie_raise_irq()
> unconditionally call dw_pcie_ep_raise_msix_irq_doorbell() for case PCI_IRQ_MSIX.

Yes, under that assumption I agree. With the current mix, however, the Rockchip
callback still has to choose the helper according to the selected layout. That
is why the DWC code records which layout was selected.

I will update the cover letter to state the motivation and this boundary more
directly. Does keeping the layout choice with each EPF for this reason sound
reasonable?

Best regards,
Koichiro

> 
> See e.g. drivers/pci/controller/dwc/pci-layerscape-ep.c which already calls
> dw_pcie_ep_raise_msix_irq_doorbell() unconditionally for case PCI_IRQ_MSIX.
> 
> 
> Kind regards,
> Niklas
