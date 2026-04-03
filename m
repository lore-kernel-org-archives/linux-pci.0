Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020082.outbound.protection.outlook.com [52.101.229.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2A35F603;
	Fri,  3 Apr 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238047; cv=fail; b=eVZ/OGjMm9H8VUC2xxLj2jfReiIv0zYaEBy/eiDsqQR3/eVQxntlYAEWnTViBg9ZLStnNBY23vntSgAJ7BYhvPe9xIEtH+Sj6sg17wE5BuXQU5TBmy8cXtDGiVVU09bQHeykaFvgchYFYiq/EjS+AWAAITl3iK6KOwXw72Iwkho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238047; c=relaxed/simple;
	bh=KuWrDOctBrpNS6f6pyRYYxWGa/gStZLmz2I7gsfDJww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bH0Xah4bNr4NnCaEKEc3ZFGsR9h0SXZIt4KOOB+IGGT6P3IOWT5rK+j/29ibhK7i0jt52I1/Rgu76Y+UeBfjNuLiOegeo6ftFf/vja3iDyt/AYAv3qrrxEF22dIZQSLJwcTY/tmaEFSZq/Sk5bIXu5vY6BjQBEglJVmzVK99x9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GANUkoNZ; arc=fail smtp.client-ip=52.101.229.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GANUkoNZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xy1OTBf/cVv2+bX5wWWtpjo+75AKKqOC07wXFhZUGKoVHBRk0vxrg4vhE6ewarEEh8qnXSvq+1yFFho3pSzAxksAzMqSPbQZdBB+qWk4A2N5V/fmeqvsgJw3P0RQ0H07zEYSMvZvQXzeJeqPRhSr08GJeZpBFS42lMYX/eWfJJaSDRbcnbjPSSZYsd1ODy0yQXqhqtsPpSpNK+EWrbH/bh5t/0K5wXxcLmNbAGVJt5jAnVD24tko6Wu4tnASaZfDbciBUBq5TGW0HBrkWicEHQDhQiXuqCKwnu9PzsKQlcF5db//1lYuicxs3p/njtv/vC3kwAQe3tzMHxntQV0TyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/H+G2V7BX6jXMpod+ALQgfNjQiGnpMLoj/GWm2aCO0=;
 b=kISpDaecpA0eNQgaPH/vri4bjyy7n8dux8b1++ctUN178SpJQF/6piIV4pqUyXYV5egd5piGwQd5cRaFo/cJPUJmDb4IcbduItSlDJYnwmo2kXnjNWUbGWK/diJ0U7O6AKz2BNnr+LFNkeX7UlyGAq4lOBVGvxSF1OGUVi5DlvzeNkRHkTj3IoBsByC3EXfihJgpktskGbXDqL3mJUF7qZibOpHSpy817+aWCWeQ0zaTh3ucK1b86aTJ8ZSynbPU2iQdUOuPULapicfGqHZ/wYdos/V/cuI5ySDA7PWnmcTO6M3qD2X6xAwYJ7ipYGT3klzb04wEsxiqjEOoHihHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/H+G2V7BX6jXMpod+ALQgfNjQiGnpMLoj/GWm2aCO0=;
 b=GANUkoNZpWlowLLth5sRQXF+kHyUiscMVsznQAnASvapXi+v7rIIcaI+Od8tgH0Nwlsvz8ZGuxedxWiZ49jP7yWCU9OVHZivDhPaQh6270BRmrR15ADDrHNIMzZAjPhZ/IZISSHc4jJNjgWEscj1ke3v01yQXAgtkMiVgm34jeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYTP286MB3503.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 17:40:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 17:40:42 +0000
Date: Sat, 4 Apr 2026 02:40:41 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v12 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <xsgnfqmov2oebpqjud3eeb37m4xymglqmpfczardlz6dubsj6r@5tcsj5ywwdmv>
References: <20260327035422.4020455-1-den@valinux.co.jp>
 <20260327035422.4020455-2-den@valinux.co.jp>
 <acawzbj2s8P95YKi@lizhi-Precision-Tower-5810>
 <zzatuxxzrg6yuqprvhgntwspsrg3igk2wqqqamx7xh733ksgef@mvwzcseqvjrb>
 <acvVmM-nk73ntNj5@lizhi-Precision-Tower-5810>
 <vwhptrhnwiraim446o2asoz4orpbadmqwbjykz5yzq6ivuruvo@27nqiyszlb2h>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vwhptrhnwiraim446o2asoz4orpbadmqwbjykz5yzq6ivuruvo@27nqiyszlb2h>
X-ClientProxiedBy: TYCP286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYTP286MB3503:EE_
X-MS-Office365-Filtering-Correlation-Id: 43141590-5e6f-47c7-6374-08de91a820ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FihDqNlygCI8Mc5VrPi/1J4DkHq4v+pICQyCOqUNQWM+nOlYpoxDkz6xPM8XjDMyQ90Lzp/PySAsFVyZcayliIfEwoKBgWIVwidFRl+mztMDUlhuAdJEdc5dhcCPZQX9fy4FjAbE5BNMgT9xJAN3kZ52I4r4Hs6r7UsJ6qrntvxm2N8XKa1s0tIzBIG2q+sDmxIcEtVKtda8atm5mEclUCLqWRS/PER9lS3XKcN3ozDuzJHjzWT4YiXkHMEjlF5C+dZld6KWZWpG2irq/FySrKW0fXYdXOv6UZc7V4XTYFEgNbxp/ijiD13Lp4NxteOGxU5T2jxfJ8HLRHIymuPJDVBoR/BIZr0BlndYWDFojZjgYkJ3pHCJg6tEgnjUDqHAmYnsxJ0GrNoW6a8jFBULXXyurTWW3B5H3/G5D1apKaCGIyb9In7ROQj3ecjD8vzpUnONbUfYRStAw6rpDz9E11N1xH7CUMVxW6x+e11+WywYKsztrEXgyXiaJU9iAfz2oxS68Cvsd+Ihn6KD5tbanvdifsng7WAToa4quhSb3iCVHhkUbSo5tEyHWvKy0sIrsAz8dO44ZCq/MMXFDN4kPDdpPjskQUdHS2XaQbiiev+JYe1Bp4BC8PRG7iXoQLP3Pg4443F4uES37TZGs3rv1Tij+cbdI0EEM+LTK22RlQFQpwGv0WRNJgQIvLaLIAk+RJZ4VGbHCoVtiBSVgYE1safIy7f1AU3hsnSK848yXqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlBrbFVCSnVKejh4c3hPOENtTFZEODg5d0ZmSDh4SU1wUzB3eTFBV3Y0Q3Mv?=
 =?utf-8?B?SWRuNklaY0JjTWN4VUU5L1dsbkVnZitYY1lMK2ozTEI0NjlmWWxyZGpMRkVH?=
 =?utf-8?B?cStQVWFXOVNGb3V2OGx0bUdwMFptdXIyS095VnZ4Z0ZhalA0ejdkRzRGUDNn?=
 =?utf-8?B?UkZlWGU5b0FJd0RTNUVEODJCS0crM1B6ckowVVlkQVoydWZmVTkyRGVLdG4z?=
 =?utf-8?B?ckRkUWdUTEVYUlp3QVRLcWtSZkJJOVdnNkplUkZ0SmtPbVdLU2x5b0JoQ0NY?=
 =?utf-8?B?b0hRWEFwUCtCbllYbXpFYnNjNHhEMDhnb0twUkZhR0dmWXFQeTFEeCs4SFJ0?=
 =?utf-8?B?VytPODBkN1RUYWEwZHBoTXMzQ2NvOHpITjlEMWprVUdjSldMM2dBUVZIS2ZB?=
 =?utf-8?B?M1dPVVFrUWs3TE9pYzl3MVY5VWw1N216Q205NEFTYUVPMm9pVExQOUpjWUsx?=
 =?utf-8?B?eml1bXV4bDRBd3hzOWc0YTllTzRsQW92b0pnZlQzUGN2WS93OXovTkM0NW9W?=
 =?utf-8?B?VEx1bEpEZEpEZVFaR2EwNGRWM21STHVlVmdrVGxOT0p6aC83WnR5YmhQOGsy?=
 =?utf-8?B?K1NSY0EyNlA2R2RXVUlQV3pnNDdZQVovWXRuWHJrekJ3aU9lTnduSTByTmFZ?=
 =?utf-8?B?L2RBMVBmcCtmSVUyOEhsQzlReVBWb0Z4akcyTDk3VEF6cW93VDNmdkxYVUZC?=
 =?utf-8?B?RlBOT3JnTlNDM3BLMURYUElnVWlrRlY3czlpcTlkeVg4dDY4bEdRNS95VDVw?=
 =?utf-8?B?bWRXYlhXVjhSeUhqTlJ4a1JFYVRNRVBZbWNENnlWaEtyREtKUEUrdm1GYTRp?=
 =?utf-8?B?ZmpOcEM0MG9vay9hQmVkU205T2xramYrdUJJTWg0YXBoQ2pkWGZNWXpSWFQz?=
 =?utf-8?B?clc3NUpEcTBuYVE1M2s5ZWdlZjduS09kak9RMXY0K3hpVUtkN2J2eUQyWnhQ?=
 =?utf-8?B?amJlWGdUM1RkNzZ6UlJrbWFFblVXTnV2czJpRXVtWDFEQ09Fa1BuT25zd0Vq?=
 =?utf-8?B?UythNkZsWnc0cVdObDI4RWcyeDgyR0NZa2NPV3BwRUZJT2wyODF5c0hMVXlk?=
 =?utf-8?B?aG0rYzQ5Zkw2V3NGNGxWRW9kUTVrU3pCSkQ2VXBSWElnRGxiNmVzckJLc2Zy?=
 =?utf-8?B?Y3hNRWxvOU9JMVF5NFpZYkJSaFZIRlQ3RVhDdlZibmt2N3VQMHZkdDFOa1hU?=
 =?utf-8?B?SU5OMEFWT2lIU21nNTlWMk1kRkNtU09QWVYwOUFhSzlGTWR1RTlTWXVUR0Rx?=
 =?utf-8?B?eUVaeFVlQ0htZWU5RkZsTzJicmhvNTdlc3B5aW14c0dLNkFpUU9ZeGxTMCsz?=
 =?utf-8?B?bE9zM3huNEJEQ0NUVWRyMmxOcGsxRk9KSEhFcHdJTFRDRExRNTBvVFlmTmJM?=
 =?utf-8?B?dUM2WUVBcmtySDBLQXRCUTdka3RWQmlLTjV4K0JBaE1tdGc4QzhPREJiZWZ2?=
 =?utf-8?B?Uk5mZVhqVEEvKzhkbHRiR2sySjVPeXVpYTgzb2VTQzhsa1ZheStMaTlTRFY3?=
 =?utf-8?B?WTRXbVRFSko5MDVNaGV1aHhQNXhwZE5Db3FkRUh2dXpLUjlsbEJYMFY1VFFV?=
 =?utf-8?B?SDRhcTIrS3VKelk1bElhZWhhMUpMZVpZamhwQWZPVGE4dVgvN05GYUlMMWZz?=
 =?utf-8?B?VEQzS2ZvSy9Gc1dOM2NpQ0JTVkYwOEtFc0hrRGJBR1RVZG12Q1JjZlhBY0RS?=
 =?utf-8?B?aCtqUUdYWHZaV3BhRmdXbjZLUzNacFdja0FUTXcwTmpTaDFYVWQ2OVBpWTB1?=
 =?utf-8?B?VGszZ2l5UWRDVFBYaUJ0b3JFdEI0THlXQ1VrVXNFYlNqanlLcFR5ZmtkQU1a?=
 =?utf-8?B?VUVlcHRnNDVuVmF4L3pYUG5meEh1UWZSMTZnUVVvT2hvSFgyY2VaOFc3YVU5?=
 =?utf-8?B?WlI1cWJ6YXRubndhc25HbkwyR1IzaE1ETkJYZysvTDNXeUZlemxZbEh6VXcv?=
 =?utf-8?B?OTlwamhzTlIrWlVlN01VSEVsMFJXN2VwSWFIdHdlTitiWk1HWmlrbUxZTHRH?=
 =?utf-8?B?VWNiUU9zdDJWNkVCbGZMWGx3VjBYU21zTnliaHZmR0pqSnBwOTdRMTMrVXJj?=
 =?utf-8?B?azlFTXFIN2Z0YmVXcUlCUDBZdTF3VG9rSE80WUt5TllzSmZkb0dPeXlVVjhI?=
 =?utf-8?B?aWRBdmJkZnlpYTYwVGdaNk1TbU55L3JaRklwMmRYWDNlZjBZTitVL2FXSklO?=
 =?utf-8?B?Nk91eDVCQ1Vad2VqWEtnOGN4SFBJcjhtZUszWS9xOHdHOFRuOVZDbENvMmxZ?=
 =?utf-8?B?U2JaTDNEVDlxZjFvRnBDTGF6UDhHd3lKblk0dmdVMXZndyt3TTF2a0g2OUls?=
 =?utf-8?B?K2FFYTVYUS9OdXZrUi9aaUdxcnZidS9RQzMvcVdyaytLc2RZSWQ1dm5aR0Er?=
 =?utf-8?Q?gqT2MqVcmCYirWmNR1lxgezsJU8Th7esFtGOr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 43141590-5e6f-47c7-6374-08de91a820ba
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 17:40:42.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4X/WAnXnltB33ZpoFtfPbma15qAIoKt+Kp43AYEfFUGOJkgFoebsU+t0DC0JAEFnHiaWikOciSEXRxiuDzThw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3503

On Fri, Apr 03, 2026 at 10:25:04PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 31, 2026 at 10:09:28AM -0400, Frank Li wrote:
> > On Tue, Mar 31, 2026 at 10:56:34PM +0900, Koichiro Den wrote:
> > > On Fri, Mar 27, 2026 at 12:31:09PM -0400, Frank Li wrote:
> > > > On Fri, Mar 27, 2026 at 12:54:16PM +0900, Koichiro Den wrote:
> > > > > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > > > > engines) whose register windows and descriptor memories metadata need to
> > > > > be exposed to a remote peer. Endpoint function drivers need a generic
> > > > > way to discover such resources without hard-coding controller-specific
> > > > > helpers.
> > > > >
> > > > > Add pci_epc_count_aux_resources() / pci_epc_get_aux_resources() and the
> > > > > corresponding pci_epc_ops callbacks. The count helper returns the number
> > > > > of available resources via an output parameter, while the get helper
> > > > > fills a caller-provided array of resources described by type, physical
> > > > > address and size, plus type-specific metadata.
> > > > >
> > > > > Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > ---
> > > > > Changes in v12:
> > > > >   - Add pci_epc_count_aux_resources() and pci_epc_ops.count_aux_resources
> > > > >   - Use pci_epc_function_is_valid() instead of open-coding
> > > > >
> > > > >  drivers/pci/endpoint/pci-epc-core.c | 83 +++++++++++++++++++++++++++++
> > > > >  include/linux/pci-epc.h             | 53 ++++++++++++++++++
> > > > >  2 files changed, 136 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > > > index 6c3c58185fc5..fded71a19d71 100644
> > > > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > > > @@ -156,6 +156,89 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> > > > >
> > > > > +/**
> > > > > + * pci_epc_count_aux_resources() - count EPC-provided auxiliary resources
> > > > > + * @epc: EPC device
> > > > > + * @func_no: function number
> > > > > + * @vfunc_no: virtual function number
> > > > > + * @num_resources: returned number of auxiliary resources
> > > > > + *
> > > > > + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> > > > > + * registers and/or descriptor memories can be exposed to the host by mapping
> > > > > + * them into BAR space. This helper queries how many such resources the backend
> > > > > + * provides.
> > > > > + *
> > > > > + * Return: 0 on success, -EOPNOTSUPP if the backend does not support auxiliary
> > > > > + * resource queries, or another -errno on failure.
> > > > > + */
> > > > > +int pci_epc_count_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > > +				int *num_resources)
> > > >
> > > > Most like such kinds APIs return count directly,
> > > >   < 0,  means error.
> > > >  >= 0,  means how many resource.
> > >
> > > I chose to return 0 on success here based on Mani's earlier feedback on v11:
> > > https://lore.kernel.org/linux-pci/lfbv6sjevz4xtjr6zt2hl3wap3bfwkvigqb6fdztqmutxgcvld@3t4x5gstr4nj/
> > 
> > I am okay for both, But may request Mani think 2nd. Most existing kernel
> > API use return value for count of resource.
> > 
> 
> Ok, fine with me.
> 
> @Koichiro Den: When you respin, could you please rename the API to
> pci_epc_get_aux_resources_count()?

Alright, thank you both!

Koichiro

> 
> Reset LGTM!
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
