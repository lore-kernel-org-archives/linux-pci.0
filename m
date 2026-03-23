Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021120.outbound.protection.outlook.com [40.107.74.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA714884C;
	Mon, 23 Mar 2026 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229672; cv=fail; b=pt7/LpeJs6pOzBLHX/3OiRIYI2wRLpGduHHDeJUhUkHbipjL4eRU/bMKBFPUjA3wmI8yYbwI+cK9paIwRJko2fqgiQPfU/Q5GWQw4BIicXF66U2iYbtAZI/EaPe8HcHAe5CeLZT677wviJ0pPTOLLBGlyUwGC+GobRX+I3GXgvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229672; c=relaxed/simple;
	bh=QQz1ZH9KV76nKO5qkvNfyCFZNv1nH2gXaV09nxADox8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ce6/0br5/nmoK1UNmI+iqkWfXhOZHOTkMEnIgkKk8FKpxwSAihidYs4kr/JtdXbTv2XB8kwPKpVEusdwesq3CW0nI1BhQjdISsFOQxh/yEsClmae4EVuPV8hmsmIQ33FkKKdsCw8miCG4aGGa4kqMtOyTjOt4ElPMh2AKC6DCQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=vBqacrN4; arc=fail smtp.client-ip=40.107.74.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="vBqacrN4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNQB51I5MHjHeh0wlR4gsJ/R3OFU01dkWWzQWz0KQmAHUEXIoiy7VcoJYHhAdxkG+HfVdAEmB4O6fGn4piFW/i7aIYsuu7wN/F1SRUNWur/x57tTm7M92VQUZBVhYVzX/JdkWUUO8F3VagzoQcSlx2/rtM3KeBDXDdy8NlktAA4crV79IlgAPdbWSxqUrP1SJ8nWkwfZqKBlyxzky9R1OOLtcVJYLaMtPmujkvG7IcLHn0nUydHKsXDB1INRfhS8q6oMlzpHWnaOPxbcSpyFBddVxsyqnyFWF5IuJhK+oHNLygN+Nmu+tr8eu1U0lKKJQvXTGY6esb6bd2HTASi2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F22WaC/Pwd0nGejnGMhUWGNgE1mykDCtu2TUtrnIzb8=;
 b=Et0dRbAhv6F/8kitoVlYQhx4iQknXqQDpsUlWQYyXjT/82WRgRm7qxpl1TmXBqDbvyNROm5l2pre6kUvn1YNW4nDoAdlM9A+ZoYMrrzVh14qmL37C3dIKyOnGO3N6bhQJx6buOdEGVetmERxHadY+eQlhtQyt0e6qe2tdX4tRTtJ00vmwQgBbkxXjNY/23ZvtCs1l0taScEG5q64Sy05MbF0TldaQ3ap5ODMLEG8ybMajnkJHy9LI3rzIukTZKtKBVqfJuZrzaPVxWSO2kgPgaRp/YC6QVCVSOQqO0CQX/26CdC/jEsD5Er/vPYIl0Mxdx8Mm5x+UdiX3OYwjWoVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F22WaC/Pwd0nGejnGMhUWGNgE1mykDCtu2TUtrnIzb8=;
 b=vBqacrN494yZgzQN39l7Bgox5dTr5b2zK6QhIp2v0cneuyWZP+fRBxDtn4AYi1VYm2Vodrp+fMEcrtYwqQy3PwuBbFRyYcVP+LNt3GVwj0eU/4qOfnLBLFW0liE+sIYYXl0xXvZoa1dDxpa70R1e0EL+OdUMLpz215D2XPijZrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by OSOP286MB3891.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 01:34:28 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 01:34:28 +0000
Date: Mon, 23 Mar 2026 10:34:27 +0900
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
Subject: Re: [PATCH v10 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <45yj3oztsa4dpy2nyc32td76umhd6dxxkmr5tsqtqvlgy6v4ju@6o4ov7nck7ca>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-2-den@valinux.co.jp>
 <4why3747pr6avu3e6vqp2ovxtudpjnrhuq4ryb2inlhjnmwylh@yxl44amyjyqk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4why3747pr6avu3e6vqp2ovxtudpjnrhuq4ryb2inlhjnmwylh@yxl44amyjyqk>
X-ClientProxiedBy: TYWP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::6) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|OSOP286MB3891:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd10028-b415-4006-e2b2-08de887c52e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ID30yR2Kob/KsH7mFZK0kHt+TYH+Zq7D7KsagKUCXultF9GEx24TtVLS7ZL9W4dTu2YNXakjllJFw1oZp1eY/lshhOQThBNPFS5SyrmK68+StV9JTf5bJ0ZQmN29gleU+rD/kanfzY5BFu6erl3rR7Cf5RUPj4hWIQX3o5JZEu6wwdAlcStdqhG1lve3RbJ7Jy9oRfUKMVdn090tLnM0hq2H8/8mQBB1bhm05mONKRF9XGa42lARC0y3deW3xwDlj7h6A79EXEU2paoBsQEApzmrnyuxiiSWwpSxgLJpP1ZvVCSeXLfoaSA+0x4M7ebnZ05IboDrUcaCyapDonSRy9AInn6jO+RRg3H4+7Sw92IFNYmGFPfloFgvhAVUKz6rcgkWuQWuNItod60NDzIhyORSo8Iycs7l0TLqtg7W7dYGYxtkXiqiguT6ReDd0cr5rQZ/ahpsGk4gtUJ2D0t9WD+vAnix3jX7WTM4j57AMHpyfke/QQ1cqTFoesJ1znA2ml9bCmyjJOqmNPZfES9ncnRxZkx5K8OHTL5px52+oS1MiPPzDhSfNGSRb+7r2IF1aqIm/mJTiS5wa/9ltQczyteiGd4iYZIB3/WdWlYTssJeuZISCYiH0sNWLQBGtgl2hj0DoMrvJmMH7pbXPoWcy/dKnUL0ueh7W4shkRmJ2cvsxkyJNVptSZ40W54r8eBmGXnO99kh53kWdAdukVwBxN+G0cJrynR1oMfbpN572wE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUNKMm5HTVNDbUpjMllXZXRXWFJweU91R0NMYlovNWlob3NGNlpZdGV6MXYy?=
 =?utf-8?B?eXc3eGs1NVF4Ym5yb25lTUVOcTcvUUZRc2NZb1RIOHl1SEZYcmsveXQzYkZK?=
 =?utf-8?B?TnpFczZqYXB3UThSNHB5VHRJSlZBTU9KY1VnelkrbDdKS0grS3NHS2RwbjlX?=
 =?utf-8?B?ckdwWmZ1VUpXNktEcEJkVitHNXJnTDhaQ1kwRFZrTUN5eUhiMFlveHRvMWR4?=
 =?utf-8?B?ZmliLzIzbDEwZDRBcEJiZ1k4OGZtNDhYTWQvRkExRnBuMGd0eEFsNUFXSWJ0?=
 =?utf-8?B?YlNvV1RQMjRjb3V4M09IRG80RUxjQ0RHbjlHbnkvT0pLNyszWlZTNWdFMjJS?=
 =?utf-8?B?aVJWdGRManVJWDVCZXhRcC9uTGFER0pEYi9TaURqYnd2bU9LZHpFSU9odWRK?=
 =?utf-8?B?M2wxZE04OGhUNmZmWDlFNFk3NWxvb2VNWjJTMHVYMmhRYXV2MWJiRi80S0cw?=
 =?utf-8?B?MXVMNHErUVVyR1ZiUks5VlZmb3p0NDhiaWNyVm9ITHVWdWdUY0pSWUdxZHNT?=
 =?utf-8?B?RmM2MTE4M2wxZ25YZFQyZnE0c2VpblFpLzNuampsb3BrOWhOclRNU2ZRK1Qr?=
 =?utf-8?B?dUNrckF1U1A5c05GeGE0eDQxSEZkY0t1aWlLZ1V3T2kxYzZ1KzA4N0F2VjlF?=
 =?utf-8?B?bjM3b2pjS2lJWkp6MXVaeGRQb1hmUHBrbGJucEJBZVBOaDBiM2taeWRBT3pm?=
 =?utf-8?B?RE00a0NiRUdRdFJTRUM5OGhURlNEK21mTkdIWVcvVmhQY3hmU3FKOHVZd25J?=
 =?utf-8?B?WTdhTTVhd2xTcXYyY01HaDZEMHg4dXNMeXUvUmlWY21pdFRBT1B2aFcwdmVZ?=
 =?utf-8?B?dk56VzZSQnRFdDVjcDA3Z0hBRktQMW51ZWpSVks1UnJXbUs3WlpGOGFiNmJi?=
 =?utf-8?B?cWY2NHdSOUlOcHE4TStlNVZEa1IwN05oalNCSGhrVE1jREdYbEpBUXE1c0ww?=
 =?utf-8?B?MnVWVUE5SWdJUkZVdHNCVmpNbHY1b2VMTE1vWGJDUTVtN0tNSVBOQ3VPcXdo?=
 =?utf-8?B?MEQyUnRGUHI0a3JCMGVDK2RlV091NU9kMWk3TUpISDBFbXlGNmV2cndnS1Ru?=
 =?utf-8?B?NEE4VThlSFVQS05RQ2NHNjkrcDlZYWYvcHU5aUxVbzI2T1VRaEgwTC9KOU0v?=
 =?utf-8?B?Q3lZd1lPaC94MmtoMnZXS21aSWtKZUNDTFIzcTBTdmVwaXBNaUxGaElIL2V2?=
 =?utf-8?B?U2lXN0FpWittZDM5YXJPRDF0cjdQU2JlTjFzY1dGM1NVRFFTRHJnN0ZpMXFt?=
 =?utf-8?B?K2VKeEdQRlJIVU1ob0paMzZ2b0RhWllnOVA3M0htdU4zWnpneDh4OWNhZUFT?=
 =?utf-8?B?Q05GSlJ5RFBxcWhGbzJRYXdtK2EzckhuWG9zZVRrOGhiUlB0WHIwSDlSWEVW?=
 =?utf-8?B?UDAyQlRPWFIzUXdWc01OejdvQ0xIbFZwd3VXZTYrS0plVVJkK0ZiRFlCUDdS?=
 =?utf-8?B?bGIyRFMvd1BKU01hMGMwaSsxRFZRNFUvNUw3NVlBYVRWQ2U0bEtTSE1IdDJC?=
 =?utf-8?B?RVJTU0laVFpnY3Vldk5PbFZJc0Z6czlLTEVMb3kxd0wxOXREcnZncUp5akow?=
 =?utf-8?B?VW91T084TFdQMVh5S1BPWW1BU0dCTkRWUXlQam5XV1FXK0FGOXp4ZTNTUFdT?=
 =?utf-8?B?NmpBVUpOTSttbE1OUGVvNEhsREZ1cThYU0w5T2p6ZjNEb3R4dERtbmdDbDdJ?=
 =?utf-8?B?cWFJcmErbjNYNHp3NjVEVjZUQSsweDl1ZFBqNXZqTGRyMWdvYzhXRm84ZXJT?=
 =?utf-8?B?M0VIY3BDc2MvZHBsUTBkUmhoTVYrY29wQjhHMUZXdXhJbnFWUXJaNUZoR05r?=
 =?utf-8?B?bFpHdjlHU3RZT1pIMUdqOTRhek5XaHFpdkhUd1RPa2h3Q1N5dlVQckw2cVhK?=
 =?utf-8?B?cExiY3lMQjZRN0k2OTZVZ0RoN1NvS0FjYVJkNGN0OFhYUC9yZGNUeUdkdlhI?=
 =?utf-8?B?QkU0ZWJDSmsySCsxK0xJWTFYL1N0U1dUQXY3aVhBcnJ3UnNBaGZKaFB2NXZC?=
 =?utf-8?B?NE1Cc3FNczMyeVQ3R0xtUU1ZSDA2cXBNU0J4d1pMREQ1R0dlcDFzLzBOR2NR?=
 =?utf-8?B?SHVuS0QrbHhLblIzdENOU2dqSjhZQkNIelh0VWlxVnp4MExlT2hSMkwzU05L?=
 =?utf-8?B?Wjk2TVZjbUtoOHJyV01XUDJqL1pKanpaNnJWUG9QVWUwOStXNmpBSUdPM2pp?=
 =?utf-8?B?Ri8zZ1BtN21VRlFwaERBaEo0VU5QdkpzTFRxRVlBSkd5L2JwdkR6TkgvSFcz?=
 =?utf-8?B?NXhsNVFDTWpRSDZRTDJaNzJ3TS9WK3Nzb3V6UmpyVEg1VzVYQjZpT0g5RWd4?=
 =?utf-8?B?RUQ5c290a3lwb2VkaERyNTdHWDhIc3hRd01BZ3cxcWg1ZG1XS0VTL21COVJG?=
 =?utf-8?Q?F700WLQDUiUYQYdBOhP3UD19/RZtssRsJDKEL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd10028-b415-4006-e2b2-08de887c52e0
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:34:28.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B7dwsS8HU61imZkx0j1ooSSYlvyqum7DuinTw9xzmplPR1/UvG26vLnjBJ9nhITWo/uZkGhCwadchzKzKQxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB3891

On Sat, Mar 21, 2026 at 07:47:32PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 02, 2026 at 04:14:21PM +0900, Koichiro Den wrote:
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
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++
> >  include/linux/pci-epc.h             | 52 +++++++++++++++++++++++++++++
> >  2 files changed, 93 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 32cf9a9bc365..d63967622505 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -157,6 +157,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
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
> > index 63a24ebf144c..0827650acf93 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -61,6 +61,51 @@ struct pci_epc_map {
> >  	void __iomem	*virt_addr;
> >  };
> >  
> > +/**
> > + * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
> > + * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> > + * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
> > + * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
> > + *                             controller register window
> > + *
> > + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> > + * register windows and descriptor memories into BAR space. This enum
> > + * identifies the type of each exposable resource.
> > + */
> > +enum pci_epc_aux_resource_type {
> > +	PCI_EPC_AUX_DMA_CTRL_MMIO,
> > +	PCI_EPC_AUX_DMA_CHAN_DESC,
> 
> I see that these resources are only used in [1], which is still in early stage.
> It'd help if you can just keep DOORBELL_MMIO resource related code in this
> series and add these resources when required.

Thanks for the suggestion.

Agree. I'll drop PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_CHAN_DESC from
this series, and add them later when the consumer is in place.

Best regards,
Koichiro

> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp
> 
> -- 
> மணிவண்ணன் சதாசிவம்
