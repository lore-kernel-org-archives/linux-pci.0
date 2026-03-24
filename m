Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021081.outbound.protection.outlook.com [52.101.125.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB72F6918;
	Tue, 24 Mar 2026 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316430; cv=fail; b=KLXfe4oVK5SMrXXZButk6pvHbTNMdY6jCBcvT1ZDi78Ui9qAuX7iq3JS3FJUTyaONclXrJ3u/t5kU3l0g3qMkWfpCISDDAN1loK5V7Cg+apPyhwNR5H+s4K/IZnb5LcinyzvXQSGGEsA3weXkZYDaUpfIoQvLkZ2pAb48VUa108=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316430; c=relaxed/simple;
	bh=YOoSV4eLd/uD1oAu3IsJh/0iGGu9/rZF+MHFFP/VYvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=shrK8eFzBErTN73gVeVnEi+0PbG7alMLI6eKUpJMWi/swntWQIhi7wCR+k4S4L1EkAnzCLGu2nefyUiCPJd47WKPO/YJYUV/lhgJ+Gs0VC6XQ5yVhJcGv+8Sbve4jBwci85b+HzxujRcMCf1SWcV8wKrB24XZLn1klsV+Mc5ZSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=r9BLjsLd; arc=fail smtp.client-ip=52.101.125.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="r9BLjsLd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpV8qBIAOee/tgbkDHEQ8QirAnabIvJbIirUDGm1BsJuwN6dXFthay0YKNMIiDG21m9Uj6MczW/qbvT6HY8r8M7b5zThfF7g971+qIzT265rZ3EV/h8pO9tNYd8aGpqpFE6dxTjsP+d9PZR0++1wi6yvDDopnvmLWWIOg021QLuZ9qsbXMlU+YlYJsHr6LoMKeVaNgzNFfmrZDlah2Nul3xJz2NIgUs95SpKoZn8OUSbPNlHqdSSLzx2jW4t7mGdtv1EvRZxo+D34h8yeDjdhw4s5Dfyhqa/diglQcCXN9XmF3WbM8WB7i4IhpsmNnOtqBg9tt/hsLvS7jia/El87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdVY0WSEUUInJU/CJ4qMdy9w1SqHKaNeJq8nCretwQ0=;
 b=LFkisSJUEXF5YY1bCBMCJJy7OooqKC6VfuW+tJXk4oabj4eVWWiAZPiRclnvHQTVjAhu7Uij1JaSsi0HqG7ZeC5jmk8+4XsV8yKxAbf+B0HnDVVdvzeMcFA+2EYfaOKsfB9zpqRTmOc7SxNhu5YgOs7GfarLjo/FP5BIfk4bKh3d62f0KAxU7MSlbT21+WOKe4DFuditU9hbK43PYQ89+g42dP2kdg1SuBGJjh2bxOjtRkCTSr3M3yELAWncZ5FmbVk1WisFHRPyc9F/Ef2DYqiYezPN8bVKg44ogaAM597j6f0dUPR7njoPC0gT/f2vTA0dDQo2+Yot/M2Qj2cx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdVY0WSEUUInJU/CJ4qMdy9w1SqHKaNeJq8nCretwQ0=;
 b=r9BLjsLdmPJlUggcHLCkyh1ba/o/0XvmzIXmoS4nihy5KJivyYL3+NMRZtlq/HvUrB7DKIpQTeQYOldySUWIE9darwuUqAzrArk8DbPsvCpLHB/rpLlYU6ZK7M3EzEDjqYTeXvDUYE0a0/3tMTd5fNvRr33pVzvk5me5MBsftrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4206.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 01:40:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 01:40:25 +0000
Date: Tue, 24 Mar 2026 10:40:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
 <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0097.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: d95b9146-44e8-4640-affa-08de89465229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wmsjK8wHYIL0AUiV6E4OY3kpW0b/dEO0lqNnFuFmlgXMIhMqMS1ziXWUm6kSKaj/wykdDf15DkOEaw7pVP3CWoFV+NxRiGOUe6HooUClRnpvZVXatc1T8SfXHrEs+ewSkyi1df9atmcv5TR56MO1Aqvwlnr5H25u7b1Uv1L8963ZXMm3Tsap+cD99NRer6j6EtO6a1yKzg0HHHQjQqdIHj+nUzhh8AgP9F0HxFVP0mYSqs+N0StNEJAbOGAhnzGRCmARpf7Nlqe37YQqHLvfwudMOnkOGcSmQ4c52xwB1jtxfXVgEM4AN6yqLSJCcWEBmdMsh91WHDDPgVpTlzeSCV0aISU2TzCE9TlPY+7SJ2UIW63GmaxaJDOFWLqixBxr4dVtUJE8RhKS99GymM7mknScO9GlJzyTABDr/0qiYuhZ1NRWTnuv6yGPp946VuHChV/5cgUfIJQ/eAHqKiMUmorynqQBFaAioicGCxp+kwZ3o+sF9iTeqkpzqRRZDZu7j70u9j+4DhE7MlD8KIuZIi4JTHdQnYCOOQ+C9T87TUG/pdGyT6spp61ssnro+SttctEP0OJiSWbhZAFZM1uRkHRPQ5zF9rjgWW6Zw1MSo1rCOHcuD8F34/cL8n8k5+cGBFz8fqtwSnZmgoc6z8mdsnruCPzvdRWH9GFVwGYGEeZ4ZFFxLuavuAhqzA+c1wlYD37DZl7epQSOlK9rNShF/LLGdWI4QixlPKOl678E00U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DmQhD5k508gvJ7Vbh4VF7jNACjXUlQat+zOlL/p4VXXB/PmV9Am/IVtUJlq7?=
 =?us-ascii?Q?uHYGSt0CrHcyARJJXEnE6hsYjG3MBrBhbgpHJEpqkyXmS1bOkBSFws6pJbGz?=
 =?us-ascii?Q?ZdAaLVg/I9W1LjMwXfJDRITt2RAjorV4Oj2GQ/Hq9f9S5xkrjfekEI/rhOth?=
 =?us-ascii?Q?qCKhIE07FX0YbAciyZrXkouxD8Gj65Y9vcyECf0A/HYcbkaPp1PctHUmWHDb?=
 =?us-ascii?Q?Yho1H8mbZqYtLmDuPKvRFy1s5IAsg7XbXKbGVZxiFKL0X4J6jNT3Q2OmPLFv?=
 =?us-ascii?Q?zGKtg1gAwUxULLZCrohl5SN5+T9c/Zyw7W5a/E1/lNa9b8+yfrqwZq/pzofx?=
 =?us-ascii?Q?GIH/DQtz8tp4oidHNwOgTLjpAj9sAFQQB1X3vOuFgiy2tND+qyWof1fyq2kV?=
 =?us-ascii?Q?EcaGO2coa0hlNHHxFfCI/3p6po4IKwhe+JP78sZuKqNKSISUh4jO39eRGenU?=
 =?us-ascii?Q?eDEIhs6oAV1pGVrnhV2wPELeRyOVzIa10Ohi9b55xx5QagEiDBs4sPGpw8cr?=
 =?us-ascii?Q?wnfaBH7xuR4mPCYTprKZhJHk8t8wUFDY79pchNT5USnb/LOH1dOy5JNTBAdP?=
 =?us-ascii?Q?n+rIzy0lRe/zcpC6ROhsG6KHlgldMKXEPBQus2uRhT/xtu543sqI7zj+uD61?=
 =?us-ascii?Q?RP0kGveyBg902ceqaW4rV5lZWgtzJwET79M2r5hdzBAKEWFBJvOLqrZez9Ud?=
 =?us-ascii?Q?UgNdlGPSOoEMNxT3BLUOrjdbzjU20k9Q5tsyrlR7pxuqMe1/AE4phTuVqzy4?=
 =?us-ascii?Q?KxKde3retBBXY2Le7Q0NxIaDGxuTYgEh//0WQQEuDQzi38EmtXCKo733iaam?=
 =?us-ascii?Q?xyP9olcndzaLwEJtx6hhLAFuyGRw5H28EkRUma8cjW2hwVbDgcuQ5xC1auUo?=
 =?us-ascii?Q?lryXi+7t2yl4fR5vSh1REYzsIbR2ny6ZzwmT/aVkpzIrUS+tpdm7qyD03tma?=
 =?us-ascii?Q?3E/6byWYlBYeS610OfrcKdnfTAG40+J0cKrzXYR+uxz+wAd+0o4f0o9RyC4B?=
 =?us-ascii?Q?1OLrvsrAnX5Jl3H1DWStFTQVJLSloTwfwAsPMipfvLF206ktUUlsZhQElW/8?=
 =?us-ascii?Q?TUwG4fxFUdxo4RKXuke9C9lwZWIz6X01DvgXAfiroZwtdgJ1KNrJii9vAVGE?=
 =?us-ascii?Q?UVArYc4QZ0QDIdkCgdGUt02s1BWnqsQfAhaRzN6ZbMjQvNFx+fmeJl7aq+LC?=
 =?us-ascii?Q?gVNDONELL02FCdf/Kiu2CGqrrFPipMfFYOKavsF2fPezTFK/bw/pt2R9+9NY?=
 =?us-ascii?Q?DNnl0L/zPwtVNv7Kn1zUvIODpRtQYNgrSEoW5ip08anfwe4rowOM5N2IpgQV?=
 =?us-ascii?Q?co6q2LFWW7fXD09JoARHnLc8oROwEHMOQCrdCxJvLsKAiA7QFAvZCfmgKVFK?=
 =?us-ascii?Q?dolwtximFWyR9YPEezYZW8Nw/yNe/TeLxhxQgSwXOILFAoD/78DYs86LD4Ws?=
 =?us-ascii?Q?q7kIzrwkjpgzpRRaK2wx/AK/flAYFGTKZK0TH1aUy40BAp4sQb4WYqOh2xfm?=
 =?us-ascii?Q?3Fbn2LQbwrJ1Dovt3NhDlScvpwQMJrv8WOADz415yfLtp5jehih7UuJIVZJK?=
 =?us-ascii?Q?udMEMfZUcj5m6YV/1R3G1n1E5/6cpGgOiKN3B6yJx57FV4inC0kY5y+rb2N8?=
 =?us-ascii?Q?cd7xSyFtbxXMln1pxh7ojxhzY8RlP7qCfOPihnvbQMKKbor8mP3USaudGGZV?=
 =?us-ascii?Q?uaj4QZ1Qsgh4Gq5a+YX97cK5n2lstdBsjvWOsBmyaob9oefHM/VP4EQ8OPAx?=
 =?us-ascii?Q?mbdK0szOu8eHKzOkj3RauKgTSlg04UQkeE0KvQhER9qIfVstXxDI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d95b9146-44e8-4640-affa-08de89465229
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:40:25.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISzqv82CS2FLNjZQN4efjVLljZYmjd/osHjx4UxlwaHU0f/YN/ZyY64/rSlM6L5Dh79hIbNu243/BaH99DSzew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4206

On Mon, Mar 23, 2026 at 02:48:10PM -0400, Frank Li wrote:
> On Mon, Mar 02, 2026 at 04:14:27PM +0900, Koichiro Den wrote:
> > Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> > EP-side doorbells. In those cases, EPF drivers cannot provide an
> > interrupt-driven doorbell and often fall back to polling.
> >
> > Add an "embedded" doorbell backend that uses a controller-integrated
> > doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> > doorbell).
> >
> > The backend locates the doorbell register and a corresponding Linux IRQ
> > via the EPC aux-resource API. If the doorbell register is already
> > exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> > the DMA address returned by dma_map_resource() (which may be an IOVA
> > when an IOMMU is enabled) so EPF drivers can map it into BAR space.
> >
> > When MSI doorbell allocation fails with -ENODEV,
> > pci_epf_alloc_doorbell() falls back to this embedded backend.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> ...
> > +	 */
> > +	if (doorbell->bar == NO_BAR) {
> > +		phys_base = addr & PAGE_MASK;
> > +		off = addr - phys_base;
> > +		map_size = PAGE_ALIGN(off + sizeof(u32));
> > +
> > +		iova_base = dma_map_resource(epc->dev.parent, phys_base,
> > +					     map_size, DMA_FROM_DEVICE, 0);
> 
> DB should write. Is it DMA_TO_DEVICE?

Thanks for reviewing.

The write is initiated by the peer (RC) and lands in this EP-side doorbell
target, so from the EP side this is a DMA_FROM_DEVICE mapping.

Best regards,
Koichiro

> 
> Frank
> >
> >  /**
> > --
> > 2.51.0
> >
