Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021137.outbound.protection.outlook.com [40.107.74.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB23C3FCB18;
	Thu, 26 Mar 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537070; cv=fail; b=D6KoVyWCrgfxQ6ApxNrgKEH8EBbzqZCZoFaxPov7QhaNAGoMBYuFuaU5op5adrSfXe3vPxekpZOyox7Kf5oMWAUSx3Qh/ArSTZxTlOSOwkmc4ISHSOUWAutsLQ4fCLCT5obgE+3FWOzBacZ/hk1tSqqw8vPbzSYVRxF+5h8aOHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537070; c=relaxed/simple;
	bh=1LuGSTMCZkk0Ht9ov9C5uBCO5bFvOx+IbuAvL0NBnzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EQ5vRybJ9STDVebxHyP0jpMfvzmgA1OjlIdGynBenBlEuinxNt082Woim+mjihorzOv3lj9FfpF0FHHCUSmvCRRsOTDy2445tXJ2WmOLTLPhnWGl/10s+Ybfi5UP73lJ/RPGgp+0Ef0aSC/L1VGl2d6QgAwYY+CSSlRXacoJ0cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WbLJw1Ua; arc=fail smtp.client-ip=40.107.74.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WbLJw1Ua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhzEqDbNOEN0lyM0QfopXPtGXIbUoB49iP/cE0aWl85ld98Swo2FNreoAfYsFfDUWVbPelDINEIHDU8+uMnoUbwYwgZtgOy6BSPlavvSFJNTAo3EVDaIp1h2ktgwgSwIPWbbcEJU7AquC3jnaD4pi/QEOzpOeXgMRt60bVN3g8aT9CaIhdLeAH0CAX03x4KpooJWGKlzwdNZnA2fVUknkyY3ZrNsczJQJ8AsM7tbpaT5wQfO1ArDX6TCJIKB7kb4uuYL4qMBRscoYr+Q0zwiXAvXir3xCIbmxUex9SnnRPs3fijW/gMmg+9VPLwL+iRGr/D7/Uktt8XqiHO5hSkkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+9sWrUj222FQYE6B9KAoQdvoki3zek7K03ya/Z7nOM=;
 b=GqePOCEpJyiLRKDwbIkEKSFRiaVZ3dGUa3qP+laCBscxrX40Yw0BgLOYuBMxwgwfo56OcG4xDesWh01QxLdxknfX8UGOv2uXkjoN9g6bQcDL+DdhAgL+dmN4eUfvXX2MAuWS67kt1usng7IOyW2U2bD5D5YNjgyLgRxhocckqTfbz44fBUYuNCkRAJKSuoNkzU+xuIJYfoDaLCsvqXDzCOeTdBq/Byj32IeGzRY5rPH0h8yQgb2PV/tEQbJuBozexPDyHRT9dj5UhpH7eCxTGIw2xBicQ2UEUQz3af4haqg7SXYfwMs/2EE+0Anx7h836JQVSEJ2u6RTasEANZBFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+9sWrUj222FQYE6B9KAoQdvoki3zek7K03ya/Z7nOM=;
 b=WbLJw1Ua5+mzPSNr1yaV0lGzPgzmkFMWJ6+BAFey3zz9xbMQz4azGdVVqldon7vctcoy9BaHGcDDa4L4HS6IDgqJ9x32keAhsE2dV5UQqv33JT1nrzY13f06H8t22NpsNM8Pbtji6XYUpqH0b0dAMrB7HT48w2cmRSllyaW7t2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6558.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 14:57:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 14:57:43 +0000
Date: Thu, 26 Mar 2026 23:57:42 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v11 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <f4dm2eh6bqyjwpioowwhr6nist4jdhciiki5fxt7a6xfuarbc5@tpahp2ylqg5l>
References: <20260324083728.3744734-1-den@valinux.co.jp>
 <20260324083728.3744734-2-den@valinux.co.jp>
 <57ci3l6eyyvqdkscfrz66d53onpiolox5lvtjzn4nufkyqzmk7@6ltweu5hckwk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57ci3l6eyyvqdkscfrz66d53onpiolox5lvtjzn4nufkyqzmk7@6ltweu5hckwk>
X-ClientProxiedBy: TY4PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: f01f11c0-6438-4b65-377e-08de8b4808cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nB0IDZsrgi6uJSmlcBWh1MWUUcYq7DIHNo3GANM/2NM9YluT69SA4BY2+QgRgoFwBRYtwqUwhuDOPDbgRJhBUnynsLOwnF9BW3oLEFlANuAG+RE8jXbRP174+tlI6atP8Q+oEuJjD8Nv48X30N3P/2+KvFcAM0h0ZCqRoE7ZdNbYE2cemmtYBgpUC3B+gpQ8cdfKAhY7nQn9dWBCuYqbqRYeuwb0hJgY6PZk7gpw8i8IBT4/YN10NCLIdKbaBHYyxegpQP9K4lmEqFwXxfF88t0PWPh1LTARgd9wUofzAY6RjCVCqpABUHdUoBeyfdXzC4bZs/1x1vQGzt3RCn9JHkMzUDIfLwJpG68Y6swIf5jWmEL+6Wjuc8K0x8rZBXB1CnXLelO9qw9fbXbBRC1jVC3MjJJpuq1BhK+JjtDYFiM1PpRNMJyMkoZnzr+IRiWlNmS6eVxJog8X2fhb4l30sNpdNPKmmf5teacgU7TXlF1nP4CfkAFlPm54UTnmJlRNsjfdeB7gDt2aibBcQ3LocjtPR1/cO2L0c34KDiw00059oshmKBf9F+eF9xJfVB7srBoyauJ5d58EzOM4CS0tawzMggQEr+e3EETnJAUEqlMSDK+b/qBAiqi/iPH1Fqq0uqzjqtkt6DsDZubVdSA3i2/gWUNANlftKdQmZioojVwZKPAYpAFgLreb5qVljcUewX+fU20KMeXLA2yvCR1HenO4gu95Sq76JzsIQ4w8pJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djgzaDJ0N3pQZll2VTc1YVV1aWpSekxKeDIzQnMvZzArbE5CY3ppZUVjUFBB?=
 =?utf-8?B?cWpYL1hPNDhxbEZnbUFEZjlnaG81Y1I3S3U3a3Mwc1B0dVZqNUlwejNHZVdB?=
 =?utf-8?B?am44MkFYTllUWnVYM28yRENtZzc0Wm8xQzdZYXZuR014QTUyVjVJcXBYMUJr?=
 =?utf-8?B?SUZvbnRTcmo0WGtIUXZKQnAzNXIzeTE0NTRwSldiaEkxQmZLc1UxeGVlK3RO?=
 =?utf-8?B?SityRW5TbG85b3V4YlNCUDZXTWxCWTloL0FzdHNjQUZWTEozbVdHU0QrQ2dh?=
 =?utf-8?B?blpXaGZZQUJGUlc2QytRdXdFWlFBSXJoVlJNZ1NEVG45RGlFSFRPTTJjbWlk?=
 =?utf-8?B?dWNKdGFsOVNCZEdWdmVmVWlpOUxTckJaY2t0aytzQzhoRjBPUHhzSEV1SDhw?=
 =?utf-8?B?WkhLdi9MZUFWYUFickhrb2Vyc1c1cWdLVDdJS1hXdWxnN2laZnU3OElvc2hh?=
 =?utf-8?B?akZieGdCOU1kczUxZ2N2LzZDaEtaOWNYMFhsZWZTOG55R05xYTN1ek1RR3h2?=
 =?utf-8?B?anZFODMwcVpyUUs5MnhZSlNHMEswd1hiYXFKUG9oZmpaUXZxN01WVldWdzdi?=
 =?utf-8?B?UEJtYUdmUDJxMFR2ejdtbEkrNGVNNXBZOE9xWjdSTjJabzN0czBORnV2ek5s?=
 =?utf-8?B?OEJKcjI4NTZNLzNQcHJjcHQwZ2VaeTNJUUZRRExqR1lkQXdwdE1udlNkaW9o?=
 =?utf-8?B?Rk9weGhxZjg5bGRlNE9Za05HQlNDK09KOUFWcnFEKzBHRUJpOUxSK0pScUNT?=
 =?utf-8?B?aXJzT01KWWJ6MnBaQ0hxbXI4SVBrK241ZDEvUE1xUkE0eUlRNUJhcy9oOXpN?=
 =?utf-8?B?NVJuTXJpVjZGQnRmZGJzVkN2NDd2YTB0bEhSYkdWOFJMLzI5K29vWWVxZ2ln?=
 =?utf-8?B?NEoycUpnTElScFVwbFhlc0FkMGsycU96Lzh6ejJSdTJsdit0WHZqYVdVcmxQ?=
 =?utf-8?B?NmFFV1ZhaE5VQm1MSVhGRk55bXUreDJlM2VXWGMvYzFYZmc4SjdDNytpMmQw?=
 =?utf-8?B?YnpxejNQand0bEF3Y053MHY3TUVxZ3NENENqM1RmRlBSR3h4cGFBN2cwaVlS?=
 =?utf-8?B?cGhUYjFTUXVmWTBrbTVDWHE2TjF3UElwU29pNG5WVXpiaDAvaU11WTYrdmor?=
 =?utf-8?B?VmNvUW5CVjlvMHlSNUtMZjJKS2U2V2dqSFVHbjFETkxKR2VoZlZKdGJxbkdF?=
 =?utf-8?B?QkM3ZmtRVzlDTzUyTnRHc2ExSVA2Z09NK0lKclovTyt5QU5mRmY3OVZ0TENx?=
 =?utf-8?B?bjA0ZkNMeHhxL2ZpdXZjSmwwdUM3Z2lCYmkyc1U2LzI3eWRDUFpTOXpEYXZx?=
 =?utf-8?B?cTNZZWRmSzIrWFV3RzNiUWtYL3NacFFTNlJIL2NpY29DRVdMb3RuRUs1RlFQ?=
 =?utf-8?B?R0VTT1BlOTZpN0xDYkU1a2NTajBDaHNIa1M0cFF6UkhaN1MyWVZzT0F2cEZ3?=
 =?utf-8?B?MTlpYjdHNk1XNG1vN3lNZUxLNWpsZHBpdnhQNzZja0ZZaEZpZkxQSkMzQjlO?=
 =?utf-8?B?MVhDL3pCaW9PeDdaallsOHBKbWp0MmtKMzF6ME1HOEs0QXlUanljNTd3OWU5?=
 =?utf-8?B?bmdsTVdsNk5zSktzMkg1dXozTjd2eUtDSmZUUXZteGk2MFhuYktFREs4b2l2?=
 =?utf-8?B?b042Q0pEdzlkTDlNOXY1dVk0UWVhL0hSamZDc0p4RGlEdzVSUkl5VnhTanhI?=
 =?utf-8?B?UkNQNHh5emlCbFl0bHViRkg5Sk5TNWhPcEhhbFNTSFFvOExBVlc1Z0FDeDJT?=
 =?utf-8?B?S3gza0ZVaWU1S0RxeXVIUjg0UjhtZlNPdnl6bWhuRlpoa2UySW8wUktieUg3?=
 =?utf-8?B?MkRVUnZIdXJUQXBaMG5zMGhxMjhaZ0hrdjUxMkY1UFlBenhmSU1wbXh4aUo3?=
 =?utf-8?B?YlpYWXIvcFowQ2plek9yRFBKalZqSzdIQTFPM3VIR2dNbDYyK3h2UVZsOUg4?=
 =?utf-8?B?VGJtaHNodGlmRjZnYjhja1JhdmNlR0lsT0lTQzFVeTlsQmltVnhQUkxFRW83?=
 =?utf-8?B?SEkwMGFJbmg1aVF5WUpudFVXcDNuRnhjK1k5Ym5pR2hRL0ZtcmNPcnpUQ1lB?=
 =?utf-8?B?RU1ER1dtRFNOcGxJR24wMWFXRlFmRTUwc3NWZUhsWEU5MTM1b3VXNE41WXVO?=
 =?utf-8?B?VmR6RHhxcWtmbUdWZmtwbC9HMXRPbW11MDRKbXc0bXloSThCNWxCYWd6NkF0?=
 =?utf-8?B?WXBZamxPdWRqckxCT1gwTlFIcnBNUkxhQWJudk0vUndUT3J6c2M3Q3BiMGpR?=
 =?utf-8?B?am10SnFMN0pCUHNzcmhjM25yMkhvREdDRDFkNjJZVkJDMmcyVzBPUStWK2JZ?=
 =?utf-8?B?dlEvY3Nrc2tra0EvVEpsc2FIdDAzT1BkN29nOXRZTm5wNHdxV09ReUlKTWZQ?=
 =?utf-8?Q?fdeaA3WUnA/vVri1ZM2cPW8RnYbQMaP3p2yK0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f01f11c0-6438-4b65-377e-08de8b4808cb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:57:43.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bjSwJe6PDTt4nO/pbmQ3AD0lI81lX/RhyUL8aXhBrtT9ZvEqI84WMdORiZxunkgO8WKbKUlTqgSTjdwlcAmMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6558

On Thu, Mar 26, 2026 at 05:47:56PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 24, 2026 at 05:37:22PM +0900, Koichiro Den wrote:
> > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > engines) whose register windows and descriptor memories metadata need to
> > be exposed to a remote peer. Endpoint function drivers need a generic
> > way to discover such resources without hard-coding controller-specific
> > helpers.
> > 
> > Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
> > get_aux_resources() callback. The API returns a list of resources
> > described by type, physical address and size, plus type-specific
> > metadata.
> > 
> > Passing resources == NULL (or num_resources == 0) returns the required
> > number of entries.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v11:
> >   - Drop PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_CHAN_DESC from
> >     the generic aux-resource API for now; keep only the DOORBELL_MMIO
> >     resource used by this series.
> > 
> >  drivers/pci/endpoint/pci-epc-core.c | 41 ++++++++++++++++++++++++
> >  include/linux/pci-epc.h             | 48 +++++++++++++++++++++++++++++
> >  2 files changed, 89 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 6c3c58185fc5..dc6d6ab4ea1e 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -156,6 +156,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> >  
> > +/**
> > + * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
> > + * @epc: EPC device
> > + * @func_no: function number
> > + * @vfunc_no: virtual function number
> > + * @resources: output array (may be NULL to query required count)
> > + * @num_resources: size of @resources array in entries (0 when querying count)
> > + *
> > + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> > + * registers and/or descriptor memories can be exposed to the host by mapping
> > + * them into BAR space. This helper queries the backend for such resources.
> > + *
> > + * Return:
> > + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> 
> This feels like an awkward API design. This API returns 0 as a failure apart
> other error nos and wants the callers to do:
> 
> 	if (ret)
> 		return ret;
> 	else if (ret == 0)
> 		return -ENODEV;
> 
> I think this design comes due to the fact you have a single API doing both
> resource count and resource get. This also evident in patch 7.
> 
> You should just split this API into two. One for returning resource count and
> another for resource get.

Thanks for the review.

That makes sense. I'll rework and introduce pci_epc_count_aux_resources().

Best regards,
Koichiro

> 
> - Mani
> 
> > + *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
> > + *   * other -errno on failure
> > + */
> > +int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +			      struct pci_epc_aux_resource *resources,
> > +			      int num_resources)
> > +{
> > +	int ret;
> > +
> > +	if (!epc || !epc->ops)
> > +		return -EINVAL;
> > +
> > +	if (func_no >= epc->max_functions)
> > +		return -EINVAL;
> > +
> > +	if (!epc->ops->get_aux_resources)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&epc->lock);
> > +	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
> > +					  num_resources);
> > +	mutex_unlock(&epc->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
> > +
> >  /**
> >   * pci_epc_stop() - stop the PCI link
> >   * @epc: the link of the EPC device that has to be stopped
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 334c2b7578d0..a6131f1636b0 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -61,6 +61,47 @@ struct pci_epc_map {
> >  	void __iomem	*virt_addr;
> >  };
> >  
> > +/**
> > + * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
> > + * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
> > + *                             controller register window
> > + *
> > + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> > + * register windows and descriptor memories into BAR space. This enum
> > + * identifies the type of each exposable resource.
> > + */
> > +enum pci_epc_aux_resource_type {
> > +	PCI_EPC_AUX_DOORBELL_MMIO,
> > +};
> > +
> > +/**
> > + * struct pci_epc_aux_resource - a physical auxiliary resource that may be
> > + *                               exposed for peer use
> > + * @type:       resource type, see enum pci_epc_aux_resource_type
> > + * @phys_addr:  physical base address of the resource
> > + * @size:       size of the resource in bytes
> > + * @bar:        BAR number where this resource is already exposed to the RC
> > + *              (NO_BAR if not)
> > + * @bar_offset: offset within @bar where the resource starts (valid iff
> > + *              @bar != NO_BAR)
> > + * @u:          type-specific metadata
> > + */
> > +struct pci_epc_aux_resource {
> > +	enum pci_epc_aux_resource_type type;
> > +	phys_addr_t phys_addr;
> > +	resource_size_t size;
> > +	enum pci_barno bar;
> > +	resource_size_t bar_offset;
> > +
> > +	union {
> > +		/* PCI_EPC_AUX_DOORBELL_MMIO */
> > +		struct {
> > +			int irq; /* IRQ number for the doorbell handler */
> > +			u32 data; /* write value to ring the doorbell */
> > +		} db_mmio;
> > +	} u;
> > +};
> > +
> >  /**
> >   * struct pci_epc_ops - set of function pointers for performing EPC operations
> >   * @write_header: ops to populate configuration space header
> > @@ -84,6 +125,7 @@ struct pci_epc_map {
> >   * @start: ops to start the PCI link
> >   * @stop: ops to stop the PCI link
> >   * @get_features: ops to get the features supported by the EPC
> > + * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
> >   * @owner: the module owner containing the ops
> >   */
> >  struct pci_epc_ops {
> > @@ -115,6 +157,9 @@ struct pci_epc_ops {
> >  	void	(*stop)(struct pci_epc *epc);
> >  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
> >  						       u8 func_no, u8 vfunc_no);
> > +	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				     struct pci_epc_aux_resource *resources,
> > +				     int num_resources);
> >  	struct module *owner;
> >  };
> >  
> > @@ -339,6 +384,9 @@ int pci_epc_start(struct pci_epc *epc);
> >  void pci_epc_stop(struct pci_epc *epc);
> >  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >  						    u8 func_no, u8 vfunc_no);
> > +int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +			      struct pci_epc_aux_resource *resources,
> > +			      int num_resources);
> >  enum pci_barno
> >  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
> >  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> > -- 
> > 2.51.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
