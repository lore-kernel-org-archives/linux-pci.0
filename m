Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020106.outbound.protection.outlook.com [52.101.229.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546A2C3252;
	Mon, 11 May 2026 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480463; cv=fail; b=AT6pgS6IrtU3vGL9SCJwJuvGtM0Y+J+Tzm5zVvHMRLlNDRUSyqumrF09cH1anVtsC+OnjD7YJ/ysY4BCOLkR+Gjdfkf6u3LkHvLT0HJES1d6SgCD5oh4teJzEBuBCsOgizzzYFNV7CCooh9ZhI7A3Sy5ygscxnJgLX9cHJG9z84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480463; c=relaxed/simple;
	bh=tXyC3SQCSgcBRGQAj7mNrNdBI3urAgGkqfbcx4x7yus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PHh9Ld77nQyLNJj7GQBQFOQcPCHjhhVat/qQ3hqMCxJGtLYLAml+VzEU/s4/jVQlRK+PwY0iWs+7VK50dCcE2g98FF+fq2+PZKmYn2JRaiTPD5/1+H+Jzj9tCTqgp2TeRS/VpsJVsMQErtFDk6veu05dTlkOILDJhyOBrnyzmmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FEwhnVzK; arc=fail smtp.client-ip=52.101.229.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FEwhnVzK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQdJX96mlfTq7mPPOCg1CCJ9ZgnuyR6cqBHnYXZLNp2Qgjl0BReTvt6+b2VXSgfp2RxvAgm91NxyQPJm27ZuTyenOZdhPWYTW+efMANM2/D0zYgnzMlp2R0U6b6qv+Of3nJ1N+zCYGEYZLK/bHZZh3isdr2M/P/gWe0G+YnRTv1b9jwTItQYjy1fermya1yHAKYcJtHchtInOiK2Sr1GauKqk7j3U61e5yRMq0rD02CFuxjyfFgpNuIl+79a/hRd2Ar836YQahuguU1mM0RtcGv2grPfT1sDdozw671vTgCDDy3zt1K1P3Hvk29agvKmI/Tdxbdpyiua2ClCEh4Tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsYJveTtW9dJH9frMRV3h3s7jAVaULd7Bmcu3yW1qtA=;
 b=DLmpBGli5NmUCQrh+eNhkdtsqA4FK7j8QRW8VxLTwqw26u3WqrbB8aFqbVrUVZ2PfjNDnUiigfM35vcnwO2W/XWR42WNmnIUlQjn/HGGwVJqpR8mdmWYjRU1Ai2MEFdZ+auMdcvFMcptcPDC93DsiYWa/wIG6RyQlO2IAMYKiSoQsDM6IxMmAY17uhOvuLRKHjwlcTmYV8S5hh4nP0TehRNYJ3d9aSMypzTf4qtPw1pOOwpCVpvmK+4KhqUxMSRUeBoapoa051RedZHajD5ow42BOYCqZhUKEoO/JXoQGvk2VdCFZAPdxQ+o7Ha/k518fSGWT8hg3vVuA43DMosc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsYJveTtW9dJH9frMRV3h3s7jAVaULd7Bmcu3yW1qtA=;
 b=FEwhnVzKRDWEnStLMLTGY7fYVQuNPPYeMASDcx74mglQr4z4lOkDOfBfUqdGtWeo08CSwJm1os5KT/Lvat1T6tUmAF0diPUWAswITjbAe/SmtGAlqUXV055z89b8Kx6FOHVxYmBjCoX95G0ApoBZQmmBqe/rGKMqBxfsKXa2It8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6632.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 06:20:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Mon, 11 May 2026
 06:20:57 +0000
Date: Mon, 11 May 2026 15:20:56 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>, Max Boone <contact@maxboone.com>
Cc: mani@kernel.org, frank.li@nxp.com, allenbh@gmail.com, 
	bhanuseshukumar@gmail.com, bhelgaas@google.com, dave.jiang@intel.com, jdmason@kudzu.us, 
	jingoohan1@gmail.com, kishon@kernel.org, kwilczynski@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
	marco.crivellari@suse.com, mmaddireddy@nvidia.com, ntb@lists.linux.dev, robh@kernel.org, 
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v14 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell
 allocation for new backends
Message-ID: <pkmknt6mv2elsbqn57siflbvi3zbihh2e3oahuwrmrp3qzqnze@4sbu2ojbphry>
References: <2F694A6C-23BA-4025-ACD7-2751595982CB@maxboone.com>
 <afHQWdn2rmG4mAA4@ryzen>
 <BEB40AEB-7A22-4BED-AC00-E3C0CDE72510@maxboone.com>
 <afIbHeXFomp4a8QU@ryzen>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afIbHeXFomp4a8QU@ryzen>
X-ClientProxiedBy: TY4P301CA0072.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f744c37-12fa-48af-824e-08deaf2576df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	wAjQ5FxgdFa+Ex0ATmeUkd1Cq15YbJcEVHHZD3L+ZmjP9K7gagqppZVaGCTm2RFR51oiuHpo02eH8adELomuDZgpeXdMZ//u0ZmtbwGRl6St+FCaHbTerPhMthCKmj45lqBexb6PT6l5hy2j3f90FKnZ2KPY0E88W5H3VdOosxd+sMiErM73/ERJ5CwdMjoH1gy+/jro8jMINkxvuhy2Lz5Uusxks8lofFEZ0Ex9zif68zGNEs/LS8lBu8XdrRuZ6lTHKLycU2NJQ1av0rmfblSsMO5SnN799SlDMZ4INWgm9yeA1lL0WPZx5F+YPv9gpmwcWmat9hspp/ihICszjc4rO0J+nzYMBmGZAp//EUNnRwFVix59NEommwvS9vv776NzoXnmzCGPB6kPsUvUw3ravL7SClYrN3OJQbI1Ix/ozfpdoZKBe6HcffbS0hF5bc+iBtXfyJJA0GTV4FqIP3sv65pk3amvmjQZoNd7E+3HHG/6/Okys0V221y3vP5LJOj7RkReaiP25GnFg2ZBS670juluekli+lHTYSvlnIxfVzCoArmnCehCrF2+vQ+M5zXGeaTAWdfeMAezFgvSCuYDIqkBq+0jdQ+4fuKw+8l9kwQ24mnk3viyDmtcFNtfIlfxsS38udwx2JVwkzqkYTiUjwvikLQOGcVARHd5KoL+0MogL19UoZf583oTxGabpgG5UVb4ZaNOJpb6BY3WMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVhYN0J6VlY5ZXNzMEVjaHZnUjNHV01uYkdWMGZndVZnOU01OWJGVktSbmo4?=
 =?utf-8?B?alVXTEthZFZ4Vi9iM0FNTTU4bGFpVVRqMmhQWVpMbHJBMEZmTEJQNzd4VFBI?=
 =?utf-8?B?d1ordGU2RlhmcDF5Z1hJRkxBZzBzbUYzUjZrVlNSZjJ4clhka0xhVHNSME5C?=
 =?utf-8?B?VnlaeEtVcmViL01kNGY2SUZIVXV6RWxSOUtyaVRPUmFyMmRpM05CUHJOMFBS?=
 =?utf-8?B?Yit3UGVlRmhCTEVaR0drTE9rTmNZd0E4MDZqNlIxUHRZL0pRRHY3STByUjdp?=
 =?utf-8?B?RzlUSFQwL3J3c1RzejVjZi9Xd0RBU0l1VkFyZXdLTFlWYzZyRDkxVmR2T25O?=
 =?utf-8?B?azUyRlRVYlh3eUp6ODY1RkdNbVB1NHRRWHFDQU5IOWUwSXlRdzNUTEY4Y3lu?=
 =?utf-8?B?a0J3eFZIRUNKcVdEa3dtMXhNNEJPTXJ0T0g2OGI4UHhOYjA2TzBmSEVQWWtn?=
 =?utf-8?B?cHBIdGtHNGRsY242UmJmRlcrUmJhMkVvL3NFbHphRXFnRTFjQUlVK1dJZ2Vt?=
 =?utf-8?B?VjQ0WmpJQzN6OExZZzFzR01mcVBZYUFJcjlFUmZxRkxJcUp6N2VuK0pZejIw?=
 =?utf-8?B?NHNTOUI2WWlXY1lrT1JBa3BtSnFUUGZxb0ZUaDJYSzN1VE9kMXpnQjdCRitm?=
 =?utf-8?B?c3Urb3RPYXdHUlE2ZkR2VWs0QXNPTHZoS1pxMGJVQ3hvSjJUNWpxQm9URjRE?=
 =?utf-8?B?YjdUejBTTTVEYUF6TGxIY3NrdGJnVGU4aXNvM0F4dFRPdGY2aWJrekVwSDJ6?=
 =?utf-8?B?RjFXL3ZHTUd5S2lwa2hHY0FmeHd4QkdXRWhlNExtRGROSXMyd1cxell0b2hQ?=
 =?utf-8?B?aXQwUUlyNkJOVUpJL055dkNaRW8yaEcrczlPZlJEOUZOV00rcjRRR094U0Fv?=
 =?utf-8?B?UDMyZnlNcitla3pva3RCbEl6VTdQclZUVUpvQ1dSWGE2N2NIVGkzNFBIeFhH?=
 =?utf-8?B?b3JleDc4bWF2VHNaTFkrS0ozeG9TQnFpR0tvRkF6amdpbU8vTTViT2diYlY5?=
 =?utf-8?B?UWMrRjRhclZ0YjVsVEM2ejBNZFpYSGJGT1FaZnN5NzRHRDJEcWRxUlIvY1pQ?=
 =?utf-8?B?WEp0WWpqSjFjMkE3SytQczhkaVZFM04reVRZL3lFeVZIaExYd3d5VnpMOVhj?=
 =?utf-8?B?NzFrbzFyemRiak0vNTNmZWFUMnkvb0huL0RDODVRSzBvWllZK1pvWmZNczBJ?=
 =?utf-8?B?ZHdqd1ZBVkN2bncyeWNhVE1qV2ZtRmpMdTJ5TGd2RVpuYTl4bWVsalhNTTk4?=
 =?utf-8?B?SWJ2UmVLcE9WcjZaZHQ0NndSTlBNeURKaGRGeThFVVRFQjQzWDlKRDNIbGZs?=
 =?utf-8?B?QlREbXlBbVpNL25PWi9QQVphbER0UU1ybWdEWFFBZmNENmZRbHBxQ2M1eU14?=
 =?utf-8?B?Y2NkcTdOVmVYekkvbjczNUIwL0E1SG5WVy9hcXJ6L2VRU200YXQ5N1BGYzRC?=
 =?utf-8?B?MWltdEx3N2wvajl6SUdtUGNzSVYvVVFkOTdTLzNVbXFIcjhXckdvdlRlZ2VW?=
 =?utf-8?B?ZnZNVFlPb1o3UWlsVXlDOVpOd0VhM1VYaVVqVVpIMnR4RGluU0tuSm1sL3gw?=
 =?utf-8?B?clpURXFwaFZQdnRMeU1Pb1k3aWNpWDNuWEcvSGszL0J5Ty96ZE1ZWWZINC9Y?=
 =?utf-8?B?WThwSnRQM1pvWFJQVjJjSlBLcDdoRGUyTVB3VFRoZFk0ZFdWZS9ZbjRxak1z?=
 =?utf-8?B?OU5HUEk5SmpqbGdtMWovZTh4ejNwTkNpRm5sbWMrMllSUTh2MjJjTWZXdmll?=
 =?utf-8?B?WmF3NVBRMmk4ZnBPN2FINWQ2VzNvdzhrN0ZJa3lFZVBRUHNRTUQzUFl2V3VT?=
 =?utf-8?B?clY0K2tPWUFwQTNmZDdNMHU5M1hTRTlsWlVmbzZzN3JxZWViMnc3NnNKRDJF?=
 =?utf-8?B?WFd3VnM3SDZZZlBHYXpDNzY5bGFoWWtNRk9uUzRobnRkcUJMSEVZZm8zRFlI?=
 =?utf-8?B?aTdzbCs2STVmczk4U05lbjNGTnlYUlhjL2Z3emR2VlpXSnRXZnFwKzZQRHBv?=
 =?utf-8?B?VEtlMVVhTjJQU1hINFFlaXo1QWhWMjg5ZkZmMWl4VmdXanNmVDdFaWMzSXE2?=
 =?utf-8?B?VHl2dVlITzNENWxDa1FNbGFzbWZleTBHd3ozY0RTUVErT1Q3Ykd3b0xOMTJm?=
 =?utf-8?B?WFdHdUx5ZXpMOGV0ei9nM0xPMkRVWW1KK1EyWXF5SXRJNU8yQjBrY1NFaWJU?=
 =?utf-8?B?K3lVVjdSMjhvMDFDa2hrVzNlU3hTOXRHZ2NaNUZaclJsOVAzcEIwWEpYYkF0?=
 =?utf-8?B?M1dVelZoSzFXenU1YnU2V0hJUmVaTkljdHVCcWFoLy9EbUtQcGRSSkx4d1dT?=
 =?utf-8?B?bHRZVjhtT2o0SFlOSlUrTmo0eElWQWI0d29XR3Z3T2V0UGtpcVlLL1RCYjVm?=
 =?utf-8?Q?jYRjACbiFrUoM0xYhMDvcZrIfUe5S8rVpGXa0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f744c37-12fa-48af-824e-08deaf2576df
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 06:20:57.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed0+pcsXhFhsTy3+TUSkX6CkJ+dD7HA6eOTHYWVO/HUnZYlh1Agrbso8ZdyWyVLVSc2LzR7LXLUuANc8iFuqXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6632

On Wed, Apr 29, 2026 at 04:52:13PM +0200, Niklas Cassel wrote:
> On Wed, Apr 29, 2026 at 01:11:12PM +0200, Max Boone wrote:
> > Good point - looking through the device trees I only saw the msi-map / platform
> > msi set for the imx95 and assumed designware was the only EPC supporting
> > this (also because the code uses that of-node specifically), but I indeed don’t see 
> > a reason that other chips can’t use this.
> > 
> > I’m a bit confused on the configuration, fwiw it’s probably me being unfamiliar
> > with PCIe, but it doesn’t seem right to configure the MSI and eDMA DBs through
> > a kconfig option rather than inferring it from the device tree and/or having the EP
> > driver enable the capability and expose an operation to realize it.
> 
> I don't see anything that is configured using Kconfig options.
> 
> But in order to enable PCIe EP doorbell support in the vmlinux binary
> you need to build with CONFIG_PCI_ENDPOINT_MSI_DOORBELL=y.
> 
> 
> 
> To make use of the GIC-ITS MSI support, you need to define msi-map defined in
> device tree. I did send such a patch for rk3588:
> https://lore.kernel.org/linux-rockchip/20250908162400.535441-2-cassel@kernel.org/
> 
> But, AFAICT, considering that the rk3588 does not have any way to map RID to
> a predictable SID (which is possible on e.g. imx95), I don't think it is wise
> to add msi-map to rk3588.
> 
> It is similar to the problem why we can't run with the IOMMU enabled when
> running the PCIe controller in endpoint mode.
> 
> For more info see:
> https://lore.kernel.org/all/20250207143900.2047949-2-cassel@kernel.org/
> 
> Basically, the problem is that the host assigns a BDF to each Root Complex
> on the host side, and then assigns a BDF to each Endpoint it finds connected
> to that Root Complex.
> 
> Thus the PCI Endpoint controller will have no idea which BDF the Root Complex
> will have.
> 
> The Requester ID will be that matching the BDF of the Root Complex.
> 
> But the problem is that the Endpoint side cannot insert a mapping for this
> Requester ID, because it does not know which Requester ID the RC will have.
> 
> I guess it could theoretically insert all possible Requester IDs in the IOMMU,
> but that is not going to fly according to Robin (ARM SMMU maintainer):
> 
> "Yeah, that one pretty much settles it - we can certainly expect host
> root ports with nonzero device numbers, so that's at least 13 bits of
> the StreamID space to cover, which isn't going to fly."
> 
> 
> Note that there are some PCI endpoint controllers that can run with the IOMMU
> enabled, by using a look up table and sideband signals, see e.g. imx6:
> 
> commit ce4c4301728541db7e5f571a5688a3a236d9e488
> Author: Frank Li <Frank.Li@nxp.com>
> Date:   Tue Jan 14 15:37:09 2025 -0500
> 
>     PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
> 
> 
> 
> I'm not sure if it is possible to configure a LUT on the RK3588 as well,
> in order to keep the IOMMU enabled also in Endpoint mode. If it is, then
> it wasn't clear from the RK3588 TRM.
> 
> (Having the IOMMU enabled when running in Root Complex mode is no problem,
> as the Linux driver core automatically will add/insert a (single) Stream ID
> matching the BDF it assigns to each Endpoint.)
> 
> 
> > Check, thanks for the write-up, this is also what I’m looking to get working,
> > coindicentally on the RK3588. I had imagined that it would be possible to build
> > a sufficient API by passing in a base offset and stride for the doorbell allocation, 
> > but an alignment param sounds better. Can we program the resulting doorbells
> > at an arbitrary offset in a BAR, or would we waste the first allocated
> > doorbell that’s going to be located at 0x0000 - 0x1000?
> 
> I'm not sure if I follow.
> 
> If you use subrange inbound mapping, you split the BAR (BAR0) into two.
> 
> The first range, 0x0-0xfff would use one inbound iATU and would have inbound
> address translation that points to allocated memory by nvmet-pci-epf.
> This is the regular nvme registers in range 0x0-0xfff.
> 
> The second range 0x1000-XXXX (depends on how many I/O queues the nvmet-pci-epf
> allocates) would point to a physical address that is used for doorbells
> (the address returned by pci_epf_alloc_doorbell()). This would use another
> inbound iATU.
> 
> Since there are no NVMe registers after the doorbells, we don't need a third
> inbound iATU.
> 
> 
> I think we can use stride == 0.
> 
> Another possible way would be to use stride == CX_ATU_MIN_REGION_SIZE, and then
> use one iATU per doorbell, but considering that most DWC EPCs have a very
> limited amount of inbound iATUs (rk3588 has 16 inbound iATUs, but some SoCs have
> much fewer), I'm not sure if this approach is the best idea. One iATU per I/O
> submission queue, and one iATU per I/O completion queue, then one iATU for Admin
> submission queue, and one iATU for admin completion queue... I'm not sure if
> this is a good approach. Stride == 0 and one iATU seems better.
> 
> (I don't really see any advantage of using one iATU per doorbell. We will still
> have the problem that each address returned by pci_epf_alloc_doorbell() needs to
> be aligned to CX_ATU_MIN_REGION_SIZE anyway.)
> 
> 
> > In any case, I think it would be preferable for users of the alloc_doorbell function
> > to pass in what kind of doorbell they want instead of using a fallback mechanism.
> > It seems to me that the alignment and possibly a larger amount of doorbells are
> > possible with the eDMA doorbell mechanism. Or am I misunderstanding eDMA
> > here and is that bounded by mapping / size / alignment of the GIC ITS?

Hi Niklas, Max,

If the normal GIC/ITS-based doorbell is usable, I do not see any advantage in
selecting the embedded/eDMA backend explicitly. That is why the embedded backend
is not exposed as a selectable backend and is tried only as a hidden fallback
since v5, after the v4 discussion:
https://lore.kernel.org/linux-pci/avey4i3lwcqt4wsy3y2wjlx7ixo7sqe64hngj2ne6vubl4mjzv@kaksbjkspifd/

The current DWC eDMA interrupt-emulation backend does not provide multiple
independent doorbells. The aux-resource currently exposes one MMIO doorbell
target, one write value and one Linux IRQ. If the caller requests multiple
doorbells, pci_epf_alloc_doorbell() just replicates the same address/data/IRQ,
and consumers have to treat them as shared "kick" doorbells.

Note that the per-channel status fields in DMA_{WRITE,READ}_INT_STATUS_OFF do
not provide a separate doorbell vector slot either. They are real DMA interrupt
status bits. The interrupt-emulation feature only relies on the fact that a
write to the INT_STATUS register address triggeres a local interrupt, while it
does not set the Done/Abort status bits for that emulated interrupt. Therefore,
the write data is not usable to distinguish doorbell vectors.

So, from the vector-granularity point of view, the embedded/eDMA fallback is not
better than the GIC ITS path at all. Actually, it is more limited: the GIC ITS
path distinguishes vectors by MSI data, while the current embedded/eDMA backend
does not expose per-vector distinguishable address/data pairs.

Also, address-wise, both the GIC ITS-backed backend and the eDMA interrupt
emulation backend are effectively single-target-address backends. Therefore I do
not think the eDMA fallback has a generic advantage for alignment requirements
either.

> 
> The GIC-ITS MSI way will return a physical address by pci_epf_alloc_doorbell().
> (This option does not really seem feasible on rk3588.)
> 
> The alternative is to use the DWC eDMA hardware itself to emulate doorbells.
> 
> For the DWC eDMA option, there are two ways:
> a) The PCIe EPC controller was synthesized to expose the eDMA registers in a
>    BAR at a fixed offset.
> b) The PCIe EPC controller was not synthesized to expose the eDMA registers in
>    a BAR at a fixed offset.
> 
> For case a), we will get a physical address that is within the DWC eDMA MMIO
> space. Here we will need to call pci_epf_alloc_doorbell() can set up an iATU
> for inbound translation to the DWC eDMA MMIO address.

Just a minor clarification: for case a), pci_epf_alloc_doorbell() still returns
the doorbell info, but the EPF does not need to program another IB iATU for the
doorbell. It can just reuse the pre-exposed BAR/offset.

> 
> For case b), at least when I was testing, setting up an inbound iATU that
> translates a region in e.g. BAR0 to the DWC eDMA MMIO addresses did NOT work.
> Feel free to try this yourself. I don't fully understand why this does not work.
> 
> My theory is that when the DWC EPC was configured with the eDMA registers
> exposed in a fixed location, e.g. in BAR4 on rk3588, the hardware has some
> internal fixed translation for BAR4 to the eDMA MMIO addresses, and because of
> that, setting up an inbound iATU which also translates inbound PCI TLPs, from
> another BAR, e.g. BAR0 to the same DWC eDMA MMIO addresses, does not work.
> Again, please feel free to try yourself, perhaps I missed something.

IIRC, on RK3588, adding an IB iATU region that maps the eDMA register block to
e.g. BAR0 seemed to break the original fixed BAR4 mapping too (i.e. the host
side no longer be able to use the register block properly even via BAR4). That
looked to me the most difficult issue, and I still have no clue why so.

On Renesas R-Car S4, where no fixed mapping seemed to be present [1], I confirmed
that we can expose the eDMA register block at a BAR/offset chosen by the EPF,
within the usual IB iATU granularity/region constraints, by manually programming
an IB iATU.

[1]: while RK3588 looks as if it has something like:
  ENABLE_MEM_MAP_UNROLL_DMA_REG = 1
  MEM_FUNC0_BAR4_TARGET_MAP = TRGT0
  UNROLL_BAR_NUM  = 4
  UNROLL_DMA_OFFSET_BAR = 0x0000
  UNROLL_ATU_OFFSET_BAR = 0x2000
R-Car S4 does not seem to have such an arrangement.

> 
> Thus, for pci-epf-test, we simply fill in DB_BAR and DB_OFFSET with the
> BAR + offset in that BAR where the eDMA regs are exposed, rather than using
> an inbound iATU to translate the inbound PCI TLPs to the DWC eDMA MMIO
> addresses.
> 
> 
> Regardless, for the DWC eDMA case, I'm not sure if it is possible to support an
> "align" parameter to pci_epf_alloc_doorbell(), because I think it will always
> return a single address (a specific address inside the DWC eDMA that can be used
> to emulate doorbells). For GIC-ITS, I think pci_epf_alloc_doorbell() might
> return different addresses, for each time it is called.
> Koichiro, please correct me if I am wrong.

AFAIK, GIC ITS does not allocate different target addresses for each vector.
The MSI target address is the GITS_TRANSLATER address, or an IOVA for it, and
different vectors are distinguished by the MSI data rather than by different
target addresses.

So address-wise, the current GIC ITS backend and the current embedded/eDMA
backend are not very different: neither backend allocates a fresh arbitrary
target address for each vector. The difference is that the GIC ITS backend has
per-vector MSI data, while the current embedded/eDMA backend exposes only one
address/data/IRQ tuple.

I also think the alignment requirement is somewhat orthogonal to whether the
backend address is single or fixed. I am not sure that adding only an "align"
parameter to pci_epf_alloc_doorbell() would be very useful. With the current
API, how the returned doorbell is exposed in a BAR, including any IB iATU
subrange mapping, is up to the caller, and the caller can already look at
pci_epc_features::align when setting up that mapping.

For future users with some fixed layout requirements, I agree it may be more
useful to let the caller express the required BAR offset/window or other layout
constraints, so that only the backend that satisfies the constraint is chosen
and allocated.

Best regards,
Koichiro

> 
> So, my suggestion to add an "align" parameter to pci_epf_alloc_doorbell() will
> probably only work for the GIC-ITS case, unfortunately.
> 
> 
> > Hrm, I think I’m misunderstanding the eDMA mechanism that is proposed in this
> > patch. Is the fixed eDMA register block (e.g. BAR4 for the RK3588) translated to
> > a space in the GIC ITS MMIO area - or is restriction specifically on adding alignment
> > to the platform MSI doorbell implementation?
> 
> The iATU alignment requirement, that the base and target address must be aligned
> to CX_ATU_MIN_REGION_SIZE is always there when using an iATU.
> 
> So for "GIC-ITS + iATU" or "DWC eDMA + iATU".
> 
> The difference is with e.g. rk3588, pci-epf-test does not use an inbound iATU
> mapping to read/access the DWC eDMA regs (using the DWC eDMA MMIO address).
> We simply fill in the DB_BAR and DB_OFFSET to point the BAR which has the eDMA
> registers exposed by default. So we read the eDMA regs from the "fixed resource
> BAR" (BAR4), rather than setting up an iATU mapping in e.g. BAR0, which translates
> to the eDMA MMIO address.
> 
> (And because NVMe has the doorbells in a fixed location, as long as we can't set
> up an inbound iATU that points to the eDMA MMIO regs, I don't see how we will
> get nvmet-pci-epf to work with doorbells on rk3588).
> 
> 
> Kind regards,
> Niklas
