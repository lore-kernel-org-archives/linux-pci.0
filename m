Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82003D3008;
	Thu, 10 Sep 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028803; cv=fail; b=qC0t/Dl2592BEgdPPqHMlPirnjftn044r2j/ZHxWNXbSAyVNcEhd+EBVFkBWhl+1IBJKB0IlEYC/UT5rNnuWhtaUjTgs0wx7Yn62TKnZbsH23QBPeoJjZ+CrEecfJak+NfLcy1BxWjqa0KGaMHvcel2h9XkzhWCm9sfJ38BrsJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028803; c=relaxed/simple;
	bh=YBTFWDdM0Ug1vH/DWsq+fiLSwM6dRVkz6+OOaB/10lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xfgy8DOsqBLhucjYEthDWJ2hGEIcXU1nygkNblxm3XtW0xDPOzD3FrZ3Qbx3w6NUFMX0GYQNsPUcxWpB02+xw2m4UUzOhQVNG89jTzieBB/LTdb0L7qKniaUmRut+KBjD4O2e5qoSgqEtamw0T7TkCYiPagbFMhys2pyGGZ9V4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FXUy70+4; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FXUy70+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRo87NRmvcyFylxJisDd9QH815agu2vI9uHfUt+Lwyk8cr+vRK+yDjfEBWVAc3k0CXhV7OTJt9pCo9tPtgea57wY0yJ99Uyecf1WYJkItqlZD3lDgetqTdyf/8QI3sWKuK2W/MlcbMPDDQLYmlLKZdHE9FxYrx6xWEE4s8aIUoVuNIxR0jIr83J5UvILaOg6em8QiKDhAWeUK6WsF3JjQnirdeSv2IQ0HxmRIoL0ewz9yBSH4L7gNBfRqB7F6zDDnJlLkxT2YoZPwhJGLFBwSCtnHqt5klYdkTtJXvhWd4fJbT7TrLx8Rn2PrDXy90mTlsI0LlbX80xUVl1HMYGOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYZcwdGQsAZtb0gD/NmHArV9uTZVnw632S04QvNsBMQ=;
 b=gRTtQkhEj4XIeFbjSi4SXPq2X2q1OKJNiB8ndZlmynhAx8q2begxPlSUV4igGyJmJsTLjgcBouXug5RYOEMU3QsPd5BOUmVeUuvSGsC2n3cEUp6LugXXJeBPvx87/gvGL8YjeSLNsJ7FlJ2sJrKzZ0/kiHZgYlAbhwdtYYTovp25Qcv4Eyhd+XtZcUPHVcoRBMFv0FKTR5ktcBzFgDal6hALDCspyX2Tz1/FuVvqq+EQZ8qplGrgjIr3gnt2zDKGZtzkqCvhau2qLefoo7MXUv381tbWMM+eM6DEaDvGcdPfEaVUbwk6jArRm+3YzgFHQdW7sYFw1Ti/HgNuMeyccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYZcwdGQsAZtb0gD/NmHArV9uTZVnw632S04QvNsBMQ=;
 b=FXUy70+4Yy3b3NW0bb/v8fPgzAs+7XTF3EzekLuwOdQsfC8tk5kp8zk/+0nM5MWNOG2Z0e4uFKW7wJSRpijif70cAd12wdmywL8MUap82XDVdFdeY9VJ4Ld8vqqMbKbgDYFsGGrMRuX5rPAC5vwYh+JsHcoE7B6MbBi1loDmLO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7096.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:413::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:26:37 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 08:26:37 +0000
Date: Thu, 10 Sep 2026 17:26:36 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Message-ID: <25ktqvok3be5mkth552png3nvhaxgdoop4kqufs6zensgfnbm3@fhrd447at2dr>
References: <rmso2szdpfjy4qoqalhhpf3zxzn2te25m573qmwmpmoilk5jz2@arvvr4hdzbbj>
 <20260909160949.GA216221@bhelgaas>
 <sbmyv6wgmdtow7rg4m7vkfpn42ts2xobqwvzjdh7japgyremyb@p5zmzskzcdvc>
 <b4mtzimdzlk6r3yihye7f3gkdqbk7gi64ymdrhf5twmn35zej7@s3n7bqe4g6vq>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4mtzimdzlk6r3yihye7f3gkdqbk7gi64ymdrhf5twmn35zej7@s3n7bqe4g6vq>
X-ClientProxiedBy: TYCP286CA0197.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e9c6e3-6b76-4a67-b256-08df0f153b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|23010399003|366016|10067099003|6133799003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nti1EAEkaYG9ie6O8RYA9G7esypcML3HTV507JCQnLlSRcFpWABB0DZG0lpCEUXZCUCQH6G30OpdZHyaTkfUhNpaIWB4ha3RoxMMVAGR51Z/XifkQnuc324+R26bRmjpkaFue9oETNyMq9JXzmH2Cc9ZSeLG+jrg3cDoEjhygOh/MkTU/tN2p7e86Da9IRycR0XY7oKm/uJpsUlBkJqWVSOa0sNvmhQpJoYtmeqdxXYqKU5qE8FKmnIFij43cNVuGbg4RwZrBibbO/rq2UBFNJsk1PjHHQc5KA6yAtvMfsWIV9mtFHx98nEp7d6PL9PkhguYlsBoVXji/bRHbWSh08BxZx1+zWk9TN/W5H4ZHe0OxV7CigmR1PJhiXxAQcTDPsXKqcZFzql9rvliF5HT9XCdskYvG5QjiCR5Ql00b4tDaywGaccNPFS0esYC97M9j5S+waQKrem2ndlzIbxloLAGLnnSpzaueptTjRWltobiOsBF38FlgvtxaehrW9jHWGCNNP++TQ5eyer+u4USm/zgjlef9SWUrpxMVI9QLKrrO/JYb+9Lj2USUm4nMpE/1j8CQECj8/9FYEIJFoaKkShtlwYiaUS3CVKEcQOhNyeHTkxniKLKEmBPfl3TRvYz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(23010399003)(366016)(10067099003)(6133799003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFZSFJONTZVbStPYlU5N0FyK1RCbU9XRnE0NlhxNkR6SkJ4MTI5ZGdTemZ3?=
 =?utf-8?B?UHVGM0xrYkYxSXhIc1dsdGJXaE1SU3ZSL2JEdFNpMlE4MkdvSC9IVzNCWmhZ?=
 =?utf-8?B?bkJrS3FERmQybDN0aDNLUVJoc2prT3FJTm5BbVRJL1Q0bzhwWUJENHYxcUNH?=
 =?utf-8?B?RXBzTWZVdTFxSWxham94VXJkdmlmbXJCc2MzTDVGSmd2TXNrT3N3ZXhGSnpB?=
 =?utf-8?B?M1FrR3daWTJqMXd4UVJGSkdNNFRpVEVZdlJpVDV0U2JaUTNnQnZDRnBqbVBj?=
 =?utf-8?B?V05kanlTR3Jralg1cTJ4SWErK014dUpNQWZlcVh6Z1Ntc0VNdUdHS3dEajla?=
 =?utf-8?B?eThFMVIvN2lOcXFVcDRRNWpXT04wTzhUKzNTL0ZFaWZDNG45ckZkbW9CRmI1?=
 =?utf-8?B?MCtISFJmQi9YOFIyL0ZBSGRUNXFoNUVnbXhZZ0lhOVZvUmZUTUdLTGpuQW0w?=
 =?utf-8?B?MjltSzZlT0ZNVWNWd1RCOGhGQUd6NmpJZnFHdjhDT3ZnNmxleHpjMmhzU3JL?=
 =?utf-8?B?MFlTblNqSnhDNVo4MzNLSmVCbUlDL1lUNEFMcHZxMkZZcWNNT2FSMGExTFc1?=
 =?utf-8?B?WVZDMXIyMFMrQzMzVG80eGJFR3R5dWFoZDdSSmUxYkJieGQ5bEE5dzhzcWc1?=
 =?utf-8?B?RitMZ2YvdzRJQkFsanova1haa0tIaEduT3k5aXhRb08zcEJFWU5vL3dmUklK?=
 =?utf-8?B?VXk5aUhJbjFTRzFRajN2Y2k3VnpqM3U3eFRGL2lTV2paVzJ3YWtwbHVwbnZa?=
 =?utf-8?B?L3JLMVhSMzRIVTlGaHhNSzk5NWQ2UHR0bSs2a1lVY3lHYThMVDNtaUMrUkls?=
 =?utf-8?B?MlZaQjV2WUhOR1o4V1FxUlRBZTVCNDQzWE5LMDhPTHJqdlVadW5yNStQRVgw?=
 =?utf-8?B?S2tEZHJES0U0V2s3UXZmTEd1UW5JZkRjSFAvNHk0bmlDVWkyd25ISVJwdGpU?=
 =?utf-8?B?Z2taQkFNb3RLdE5sZ0Y2bS9KM1N5VzJjbnRxdVhDK1JkcGV4ZFR1ZVFZM0Vr?=
 =?utf-8?B?S1QxT3hya2lFOWUvbUpWM3RNRXl5VXFSSkh3SGN5ZWd0ZEZucFZvclhqTkU5?=
 =?utf-8?B?QWp1U3JVaGRhKzBPS0RwTFpwM3RTVWx3WGdMMzBlVEhMZ24rZjFOKzdkeFJo?=
 =?utf-8?B?ay9tQjJOYlZQL2NDc3cxY1JScDlSVEVodC94ZkR6ZTJ6RXVldFR4bk9jMzdK?=
 =?utf-8?B?OWxFMHlTUHhZRFRzd2tCVDJMT1NaWGlwWGdGYUNjZ1gzZUFrczVZWDAyUUtN?=
 =?utf-8?B?S2NmSGh4bVZTeFJYak5WWk4wY0xWa1RwYUpPMmhzOE5YWTl4UVEwOTRyUTdC?=
 =?utf-8?B?RnZKSDY2aXQ4TTM2S3JCalU3cUhpMFN5UWx1SW5rekZYVGt1WG94TVIwcWNs?=
 =?utf-8?B?ckJTamdaN1d6aFc2eGhlMUFrV3kxeXVGQnF5S1FVUy91bUZ0THVObDQwSTNG?=
 =?utf-8?B?dnE0ajQwdWVoWCs0ZkN5eVQ3VnpydlBQVGltS0VDdTEzK1BuKzdqYUxIcGtT?=
 =?utf-8?B?NENoa0ZmQThFdzdiTGQ4QlJtWDI4N0RlOEV2MnBDMzIvd21qSGZsSUhabTVK?=
 =?utf-8?B?bzJQYVJieEI3dm53U2RUK29EOGZlRjlMTkFBaTgzd0hNd0U1OG4zUlNrL1cx?=
 =?utf-8?B?RmdrMGtyZzVSQkdSdGdYOUFXeVd1MC9JcEZ5VzZ1VHZQQnlZd1VyRDdOT21x?=
 =?utf-8?B?cnZQL21PdWhaWEhzZkhiM2RuQytXU0NySm9GL014YUN5VlZibC9BbUNONjJw?=
 =?utf-8?B?K0trazFjWVVqcEZ3Y0x0NmNLUG9SM05rMkV5UFA2cFQ4dU5mK28wNEFXTHVr?=
 =?utf-8?B?K08rc2hmV3grZjdtSWR5TndZQlkxQjRubVNzQng4Y0pXYzQ3UG1pK2c5LzJl?=
 =?utf-8?B?N0RJUFdPTkZscy9LeVhtdTQ3WlRmc0RudDU1a3o5b3BJekRMVDc1U3BkV2Zr?=
 =?utf-8?B?VFFYNjA4dkpGTGcvUnBQbEEvcVJtcDZYTStsYmhsOC95Vm1DdmY5WVBPaHRw?=
 =?utf-8?B?STE4Nzl2YmY2SGlpenpNWTFrQ00vaDRSV0Y4QnIva1lzVkJWMmdOR2wwOWxU?=
 =?utf-8?B?MVhHK0JRSTRyR3Y3M0RYQlZtenVIU1k2RklldUJGM1krZW9teHZxYTRTcUp6?=
 =?utf-8?B?T0hOa29NQzlCZm1JVDdwVW0rZytjMUhrR3hOYmU1SlZVZFVZd3JReEFOcEEz?=
 =?utf-8?B?SkZVMHVUMmZSWnFuNktpMlVjcXZCRy9sNW5vcmduQS95eVl0WHF3a2tzRkhk?=
 =?utf-8?B?ZTFvQzZTMEFVeFJBNExRakRJVzV0MkFKVko5SkdNMnFPbC9KV2UrcFIxRFkv?=
 =?utf-8?B?Ym8yWDZSSkZqdEV1ZHpLSUxNSXBWbkxQeXhzaEJiMEgxaUVxM21vUlF3SDhT?=
 =?utf-8?Q?bByUnm6lYhqur7/KIddVsdnwukKajNBWx7d7j?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e9c6e3-6b76-4a67-b256-08df0f153b3c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:26:37.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tR7Ug+7q2a6h+wH0VY5xKY642l8eYF2F1RP/3i2qTneTDHvdTv4JUqMGdkmiLsWLbYccvwYwm9nE+dTWosv7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7096

On Thu, Sep 10, 2026 at 08:08:10AM +0200, Manivannan Sadhasivam wrote:
> On Thu, Sep 10, 2026 at 01:56:53PM +0900, Koichiro Den wrote:
> > On Wed, Sep 09, 2026 at 11:09:49AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 09, 2026 at 01:53:53PM +0900, Koichiro Den wrote:
> > > > On Tue, Sep 08, 2026 at 09:23:11PM -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Sep 09, 2026 at 11:01:48AM +0900, Koichiro Den wrote:
> > > > > > On Tue, Sep 08, 2026 at 11:53:15AM -0500, Bjorn Helgaas wrote:
> > > > > > > On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> > > > > > > > vntb_epf_mw_set_trans() programs the memory-window BAR through
> > > > > > > > pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> > > > > > > > lands on the wrong function whenever the vNTB EPF is bound to anything
> > > > > > > > but PF0. The other BAR programming sites in the vNTB driver already pass
> > > > > > > > the EPF's own numbers.
> > > > > > > > 
> > > > > > > > Pass the EPF's own func_no/vfunc_no here as well.
> > > > > > > 
> > > > > > > We're referring to these as "PF" and "VF" in the subject and "physical
> > > > > > > endpoint function" and "virtual endpoint function" in the
> > > > > > > pci_epc_set_bar() kernel-doc, but I don't think these have anything to
> > > > > > > do with the SR-IOV PF and VF concepts, do they?
> > > > > > 
> > > > > > Not in the specific case that motivated this series. But AFAICT, the EPC API
> > > > > > uses the same (func_no, vfunc_no) pair to cover both ordinary functions and
> > > > > > SR-IOV PFs/VFs scenarios. With vfunc_no == 0, func_no can identify either an
> > > > > > ordinary function or an SR-IOV PF. A non-zero vfunc_no identifies a VF
> > > > > > associated with the PF selected by func_no.
> > > > > 
> > > > > Now I'm even more confused :)
> > > > > 
> > > > > Are you saying that a non-zero vfunc_no always identifies an SR-IOV
> > > > > VF?  And there's some dependency on that?  I don't any mention of
> > > > > "iov" in drivers/pci/endpoint/.
> > > > 
> > > > Yes, that is my understanding of the current in-tree implementation. You're
> > > > right that drivers/pci/endpoint/ itself contains no explicit reference to
> > > > SR-IOV. E.g. pci_epf_add_vepf() just calls it a "virtual EP function".
> > > > So my saying was kind of assumptive, but I still think the same because:
> > > > 
> > > > - The support was introduced for SR-IOV:
> > > >   https://lore.kernel.org/r/20210819123343.1951-1-kishon@ti.com/
> > > > 
> > > > - The core rejects a non-zero vfunc_no unless the EPC provides max_vfs, and
> > > >   Cadence is the only in-tree EPC driver I found that does so. For example,
> > > >   cdns_pcie_ep_set_bar() calls cdns_pcie_get_fn_from_vfn(), which uses the
> > > >   SR-IOV First VF Offset and VF Stride for a non-zero vfn.
> > > 
> 
> Your understanding is correct.
> 
> > > Thanks, that's helpful.  I still have to work hard to change my point
> > > of view from host-side drivers to endpoint drivers operating on the
> > > other end of the link.  The fact that there are several interfaces
> > > that need (func_no, vfunc_no) suggests that callers really do need to
> > > understand what's going on, and maybe we should try to connect the
> > > kernel-doc and abbreviations more closely with PCIe spec terms.
> > > 
> > > E.g., if "physical EP function" and "virtual EP function" refer to
> > > SR-IOV PF and VF, maybe we should word them as "endpoint PF" or
> > > "endpoint VF" (or "EP PF", "EP VF" for short).  If
> > 
> > I personally agree. That sounds reasonable and would help clarify things.
> > 
> > > "pci_epf_add_vepf()" adds an SR-IOV VF, maybe "pci_epf_add_vf()" would
> > > be descriptive enough.  We already know we're on the endpoint because
> > > of "epf", so we probably don't need another hint in "vepf", which
> > > includes a "pf" that doesn't mean SR-IOV PF.
> > 
> > True. But I'd also like to hear what the PCI EP maintainers think about this.
> > 
> 
> Fine with me.

All right, thanks for the comment. Sounds like a small refactoring task then.
I'll try to pick it up when I have got some spare cycles, unless someone gets to
it first.

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
