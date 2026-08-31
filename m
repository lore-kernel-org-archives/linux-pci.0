Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3F3D1CC1;
	Mon, 31 Aug 2026 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166604; cv=fail; b=ZXBNxhhKG2y1B3ww2Xu/iI8mFQavwgVFRlQe4Fq5GLzr0mOuMU5PFTfmTN0jw6J8Let5DhiF25cv3cXOMrwzStfw9NbUT4I91yK+VFsoSSjKRYOtpAgmW0oFEZ88w9hpxU87T3Ze2mHtnf+OpY37rH6Tf5LbU5MdYQNrz4mjDRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166604; c=relaxed/simple;
	bh=ZLdTg3L2kbCoeVwVHjgxA21zD/uGw7ooWAx1F6XbmYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZMTAjL7dBCRaMtNfuL0iKyr5u0LOeyWw1iaaTN1OH3z136NRsVPafwKrqXeoJwheQorKRkzNE/bdNnIPhp5Z/grgXz9PvrZAqmlPtw89SyBYPQJ9XhFrBKQgttZ6PI5PxkEFR3l+Hh8CBmKkHAPmDlrM/0K8urFF5XhuoX6Gn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4IpoVOE+; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4IpoVOE+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS77NGOT3iQx/PP58ozP2qxb2rYbUvPGY5YLpehZDl7Kw3afrf7TtalsQhG3E+C0DrjSFXCiGpiNjPuTX308LXK8md4yyLitjM++0RM4DHuScmeLDMMczk3hAKy7GQp6iXgWPzibkTDm286CZGHMgaEz5xgy95QtpcROU8CpuZq+HKd5AYl51mlyhW7F77RonW633uyECXZV7XONz1KTnpDi4wil+FSmK9IK272WL46nmO1VDew3DROAGROORafq8RG1+mxnO34uuVYuE9XVFesCZsUZ+1dV6wH1HB/4u4skOG/nnJtJs703W44JDcwQNMLrBNLO6VYcOLvJzHyw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO2LUcaRSCuKgeG52/WCr9fPnH07c9M6Y7KYiiOp5Ps=;
 b=u4TJwNCoyWFaAVmAIG48kAcE5QRSb9c9sm1lv28JwYutFuoLQEued9gIkwdP9boiA9AGD5g/7Gefrrv72hQSX4oApM8hykhNm72qSGejrDd7lsvR12ViGFUV5aj5luQwr+n493EGvR/Awhks05hjjA18CSqimR15bRhDGRhd6c7ozHyQqv0qlbpavN5pu8USCVY3ngm8QQIshLUr1GW7WmxEAth8Ad7CUD3rAqdGt/nIap3lCE+Q2odwXNmpHoQeUhpBeAOAOBbtKiQvlJ3JRfM7TwUDMat4V+MkI8KZD8YfuouZcUem6xo7Wd8Be1qgVo/HdzYDDfycvndCQY8phQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO2LUcaRSCuKgeG52/WCr9fPnH07c9M6Y7KYiiOp5Ps=;
 b=4IpoVOE+YSLxR0DuakVhyMZltxogGNQSiKXGRwR89b3tdWsIzW8YwTAMRzmbolNbUitl3Ogdq3ZWH2q36OXcy2DibQZS+xStv6IcRzntEovk1Dz4R9/ZFlU9C/Rqm8PZZhHPCHL6emh62F6KIK+fSatBUpkJdmiov0YOIhCJUFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:56:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 08:56:34 +0000
Message-ID: <afb19db0-4154-443c-9d39-f905e7d17806@amd.com>
Date: Mon, 31 Aug 2026 10:56:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] [PATCH 2/2] dma-buf: Document how exporters and
 importers agree on mapping lifetime
To: Leon Romanovsky <leon@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
 <logang@deltatee.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
 <7f13dc482e5ea2d22ddff75fe30c03cd8df42fb5.camel@linux.intel.com>
 <20260830075828.GA24140@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260830075828.GA24140@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 472b54cf-18ec-4c12-7547-08df073dc1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|6133799003|5023799004|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	+DbfUYq27/P01ThqqVkI/uGMLxRLym6vAC1cuZsEXUKv1Yr6r69w1fmiFAq/oE2I4N31pHulnznAdessMEnDgDKA3AB5bAqgp2Xu0rQfkmO8akNdLjSa/WB0+4ojNusYiGLcOrQcP5MsQhniNQgXmcsEw6F5NwNqeh/dkM253S1zYzl00zoqOnAdhaf4xk7RigUdZ8ppbQ+eQKOj84lXKsZYmhTy+u3TjUm+Lol7FH0pBCXpMJ3KJB4GDvmgPRgZWVWIX79ndNj+6rjJPoXXkCvd0NAUcoS38ziYk9itdqfVuPffyKjV/u9H3IeSnbLDUrF+O7MgtyjwJF/S0Hy3hrngnGoi+TuM6mEVG6ZcqKE4Q0l9nILy93gmgjg5rJaBJ8ApFCOPqaxdOfNiAsmkdiwxd622W3R4i7xM3GXVtkg1mztIxfHB1vhuiP4CTcY2iilIjY24UQv1s3w7520ryLUOOb5iMrj6vENW0vXMkrt4IkcKJAgtlmSA1NXzBlM3aDVZYTLe4DuodcrYmWocamPnnDUU1+OMH0Ob8XOBBCB4zYEszfIGIyDbN13jD/Lv8GR8/86b8hjVwQ4VqgtlptyUBXAT46KayLjELmSRpYuSkiCTbIr96WWL17RG9lS4iq0t7XJ5zLL0KT3hhUyIzU1N2wv/lJhJnv8M+xVLKFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(5023799004)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG9mWFcyOU44bUR1WUJyODRNa3NXa0Nkd2Z1RGNmQlRUK1Q0YUxGYThucGhD?=
 =?utf-8?B?WGFNYjV3cGI2UDVEKzBld2NzVzNRL0JpMEQ3UU92YlRkalRvS0UvTU9BY0JU?=
 =?utf-8?B?VlNpMkwvbjBIUXNYTVlPT3NXQ29KdEJldmtmc085Z1psL2d4RXc0bWQ3RG1N?=
 =?utf-8?B?RjRjM0I2cE52VHBhdFloQ1hmM0g0ZmtCTGZSQXNFTzJDb1BEd2V0alhtUmdQ?=
 =?utf-8?B?cy90UHh3eHgwS1IrMlBEckl0WFNPOWZESnFtZ3cxVE4zUk9yZ2UyQzdjZ09n?=
 =?utf-8?B?czBkOEZuSk5IVlR4WDhiVnhDaFpKQURBSE03VlNIaDk3bm5qZzlLMWNBOHpB?=
 =?utf-8?B?aXBkbWk4WVJPcVc0cnpuUC9YYXNHemExSWVRajdtRE12R0lsNGhlSlZwVTJJ?=
 =?utf-8?B?ekN4WDNST3NiT25QM1ovWUt1Wktzcy9ubnJFT0RXMmlzNEtDdEhIZkRoQzZ6?=
 =?utf-8?B?dG00RU90YVNSanlCckhFS0h2Vy94R3pZMmpxUXQ0OCttMytkQ2kxZCtsMGpY?=
 =?utf-8?B?VDlCanV3UGhWeUd3UnlnNTlWYnVVNGFvbWNSVU01SG4vLy80Wm1oUm1WUjFk?=
 =?utf-8?B?YUFKM3dUR1FCQmpSTkZ5ZFlwUEJBZlN3ZW01M1ZtVnFVTXhrSzNJZTNTNTN4?=
 =?utf-8?B?bURJd2UrSDFnNHNoazFxRld2L3p4eCtBOGMxOWlicXNwdVQ1U3B4TnMwUVZU?=
 =?utf-8?B?eWdLVkYvQWFxNk83dXJJK2w0a0VVNUtSRkxMN2J5QllXVkpkZElrM05tb3F0?=
 =?utf-8?B?QzI5U2JvOWk5MnRkN08rMlZ4NHVOaFpOMnRha3RzVnZDanVPai9aeUlQdnR1?=
 =?utf-8?B?Z3NnLzE0OU0xTXd0UU81LzF6RTAxVGx3TFNLQTJPT3A2MmJNeHVxTWU2bC96?=
 =?utf-8?B?cFpOSU1KKzZTMTY4REl2TFJubUY2eTZPQldoNWNEaTRYdi80aTRCUWVLcUgr?=
 =?utf-8?B?K0xrejlOTHJ1VmhhRm1UQnBuQkg4dExEdkQ2M1JiK0Y3REFZcVNzZysxb2tV?=
 =?utf-8?B?UWpSclZ1UVI1bkEreE1URWtEYStudWhMRVZwcWtuc2dGQ0NyUS8wZVAxa1B3?=
 =?utf-8?B?NFIrRUNTSk9OcGtVZ2dYRFFYVmRwUU5UaTJuSU4zNVlNNWN0eHV5WFFLQkVy?=
 =?utf-8?B?VHM4d0Ftei9QRHJ3WUx6b1YxMTd0OVlIL20wTjNBWHlNMHN1bzNyWGlMYkdn?=
 =?utf-8?B?UEE5SVZpQlpncjIzTDVYa3F5YWtUbFZ5cm1wQWtyV3Vsb2krRmIxSFRKWHVV?=
 =?utf-8?B?VEt2Ui9QL1JzN09IMDdlZXJUQ3FGTVBLN0sySVI1UUZHZGJUcGFBQzBZUkxh?=
 =?utf-8?B?SFJOMi9qeFN5NGhJZlNpbWJNTzhSUllkWmFzN1dLNHpUdDd1MlpNY09Rc0o4?=
 =?utf-8?B?QS9XWGQ1SXF2L3FrU3huZWEzSGdFREJQSkZnSjczY1NOQ3AwNlpEeC8xKzZt?=
 =?utf-8?B?WUlCTmV3dkV3U0VnZFpqcVBPdmt3V0ZpcVVDM25OemYvWFg5dksySTlyTG56?=
 =?utf-8?B?ZDdyQ3B1VDlLNDR3L2E0M1kzbDdXMWdsOTduVUhId05uM0gyc2ZGakVQWWhv?=
 =?utf-8?B?U2FXTGVKby9yZDhFcHNNelBxcktYckJGd1ZXTkZQbWd3amxoU2p3VGUwaVdz?=
 =?utf-8?B?NnM5S1RTNXArT283SnB6Skpja2tHWnRzelphUmF4OS8rOEVYQzRwZUQ1V2JJ?=
 =?utf-8?B?Y1VaWENlT1FmZ0FIVVF6N3RFdFhPanNvenZ2Q3JvQVZOaFRkSkNGWC9PQ0NS?=
 =?utf-8?B?bFRjeFNJUjh6K0dURGo0TDhjR3NUVGhXM1dhVDRKOUlReE93QnpaZXBoa051?=
 =?utf-8?B?bC9JanVrWkxqeUNJTWtBV0JJWnI3ZnlYQW1mMnlNMzFQbDhsZERPQ2l2ZW1G?=
 =?utf-8?B?TVVVUzRoVVRYYTN4ekw1d3ppOFF5NHpsUVhZczNDamZwNnEvZExaQWtGbU1z?=
 =?utf-8?B?S0VGR2x0QzRkU0EwT0xHWHNGT3I4OGMzemtlVFpKYlp2VVRJMFpacEhrV2My?=
 =?utf-8?B?MW56RTNUVTJndjRlZ3BscWFqTUdiZzFhcjlFY2s5U1Joa2ptZTJCTmk5U2hs?=
 =?utf-8?B?OWV5Vlp0RzBVdEpoakU1Q2JCRE4zRHl5bEp1bkNXc0tLdnRkV0lMSkR5b0Rm?=
 =?utf-8?B?MWpxNkhiWGViOWRweDN3WXAyd0UxTUhBTnhHaEJzUVRpUEZtTFFJQ3pySWhT?=
 =?utf-8?B?ZVFnV2VXNE1CNHVDbjBuWWNEUnRVeEdRZ3I0YXRDSGZ5Wi9OajB0ZEFyenBY?=
 =?utf-8?B?bzU1Qm9yU2NNU3o5bG9VeS94T1AzVmFDNFl6b0duSy9pZFl3Qk9ibjRKTFBv?=
 =?utf-8?Q?AjSwsfKiZjtYCilqf7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472b54cf-18ec-4c12-7547-08df073dc1d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:56:33.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFKXcsO5aHjiIXm+YsdT6NWMhxcmcBidPmAqmlPGl+D8KnKSXGilhxQlcIWgKaSD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

Hi,

On 8/30/26 09:58, Leon Romanovsky wrote:
> On Thu, Aug 27, 2026 at 09:18:29PM +0200, Thomas Hellström wrote:
>> Hi,
>>
>> Some comments below:
>>
>> On Tue, 2026-08-25 at 09:28 +0300, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> Pinned, revoked and movable mappings are selected by which optional
>>> callbacks each side implements and by whether dma_buf_pin() succeeds,
>>> not by any flag or enum. Nothing in Documentation/ says so, and the
>>> rules are spread over the kdoc of dma_buf_ops.pin,
>>> dma_buf_attach_ops.invalidate_mappings and
>>> dma_buf_invalidate_mappings(),
>>> so a driver author has to know the symbol names before finding them.
>>>
>>> Name, per flow, the callbacks both sides have to implement to end up
>>> in
>>> it, describe dma_buf_pin() as the runtime negotiation, and record
>>> that
>>> the pin is what tells a revoke from a move.
>>>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>> ---
>>>  Documentation/driver-api/dma-buf.rst |  6 +++
>>>  drivers/dma-buf/dma-buf.c            | 85
>>> +++++++++++++++++++++++++++++++++++-
>>>  2 files changed, 90 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/driver-api/dma-buf.rst
>>> b/Documentation/driver-api/dma-buf.rst
>>> index 2f36c21d9948..39c201f38aa6 100644
>>> --- a/Documentation/driver-api/dma-buf.rst
>>> +++ b/Documentation/driver-api/dma-buf.rst
>>> @@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
>>>  .. kernel-doc:: drivers/dma-buf/dma-buf.c
>>>     :doc: dma buf device access
>>>  
>>> +Mapping Lifetime Negotiation
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +.. kernel-doc:: drivers/dma-buf/dma-buf.c
>>> +   :doc: mapping lifetime negotiation
>>> +
>>>  CPU Access to DMA Buffer Objects
>>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>  
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index d504c636dc29..30afec7365bc 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t size,
>>> int flags)
>>>   *    reference acquired with dma_buf_get() by calling
>>> dma_buf_put().
>>>   *
>>>   * For the detailed semantics exporters are expected to implement
>>> see
>>> - * &dma_buf_ops.
>>> + * &dma_buf_ops. Whether the exporter may still move or destroy the
>>> backing
>>> + * storage after step 3 depends on what exporter and importer
>>> implement, see
>>> + * the mapping lifetime negotiation section below.
>>> + */
>>> +
>>> +/**
>>> + * DOC: mapping lifetime negotiation
>>> + *
>>> + * No flag or enum says whether the exporter may move or take away
>>> the backing
>>> + * storage while an importer holds a mapping. Each side implements a
>>> set of
>>> + * optional callbacks, and dma_buf_pin() settles the result at
>>> runtime. Three
>>> + * flows come out of it:
>>> + *
>>> + * - Pinned: the storage never moves and is never taken away.
>>> + * - Revoked: the storage never moves, but the exporter may take it
>>> away.
>>> + * - Movable: the exporter may relocate the storage at any time.
>>
>> Perhaps add "even temporarily to locations that are not available for
>> DMA".
> 
> I don't know. "Not available for DMA" defeats the whole purpose of dma-buf,
> which is intended to expose DMA-capable memory to other peers. I imagine
> that "everything is optional dmabuf world" this is possible, but it
> looks to me like a partial version of revoked flow.

That is actually a very common use case.

For example what can happen is that the exporter moves a buffer to swap making it completely inaccessible to anybody.

As long as there is no mapping and the exporter can move the buffer back when a mapping is created that is something perfectly valid to do.

Regards,
Christian.

> 
>>
>>> + *
>>> + * Every exporter implements &dma_buf_ops.map_dma_buf,
>>> + * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release.
>>> dma_buf_export()
>>> + * rejects an exporter missing any of them.
>>> + *
>>> + * An importer reaches its flow like this:
>>> + *
>>> + * 1. Attach with dma_buf_dynamic_attach(). Leaving
>>> + *    &dma_buf_attach_ops.invalidate_mappings NULL rules out
>>> everything but the
>>> + *    pinned flow, because the importer can then never be told
>>> anything.
>>> + * 2. Call dma_buf_pin() under the reservation lock.
>>> + * 3. On failure run the movable flow, or give up.
>>> + * 4. On success the storage stays put. Whether the exporter may
>>> still take it
>>> + *    away, which makes this the revoked flow instead of the pinned
>>> one, is the
>>> + *    exporter's choice and is not reported back.
>>> + *
>>> + * dma_buf_attach() is the shorthand for an importer which only ever
>>> wants the
>>> + * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf then
>>> pins around
>>> + * every dma_buf_map_attachment() and waits for the
>>> DMA_RESV_USAGE_KERNEL
>>> + * fences on the importer's behalf. Peer to peer needs
>>> + * dma_buf_dynamic_attach(), because
>>> &dma_buf_attach_ops.allow_peer2peer lives
>>> + * in the attach ops.
>>> + *
>>> + * Pinned flow:
>>> + *
>>> + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to
>>> hold the
>>> + *   storage still on request. An exporter whose storage never moves
>>> implements
>>> + *   neither, and dma_buf_pin() then succeeds on its own. An
>>> exporter which
>>> + *   refuses to be pinned implements &dma_buf_ops.pin and fails it.
>>> + * - Importer: nothing more. The mapping stays valid until it
>>> unmaps.
>>> + *
>>> + * Revoked flow:
>>> + *
>>> + * - Exporter: answer dma_buf_pin() as above. Call
>>> + *   dma_buf_invalidate_mappings() when the storage goes away and
>>> fail
>>> + *   &dma_buf_ops.map_dma_buf while it is gone. The two waits which
>>> complete a
>>> + *   revocation are described in dma_buf_invalidate_mappings().
>>> + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap
>>> within
>>> + *   bounded time and drop the pin.
>>> + *
>>> + * Movable flow:
>>> + *
>>> + * - Exporter: call dma_buf_invalidate_mappings() before each move,
>>> then wait
>>> + *   for the &dma_buf.resv fences. &dma_buf_ops.pin and
>>> &dma_buf_ops.unpin play
>>> + *   no part here.
>>> + * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings
>>> drops the
>>> + *   cached mapping and has to lead to dma_buf_unmap_attachment()
>>> within
>>> + *   bounded time.
>>
>> Hear I would want to see the exporter being allowed to force unmap the
>> dma mappings and reclaim thestorage when the fences mentioned above
>> have signaled, but the importer has not yet called
>> dma_buf_unmap_attachment(). That would allow importers to call
>> dma_buf_unmap_attachment() lazily, just before the next map_attachment,
>> which would allow simplifying importer implementations. 
> 
> How? It will move one piece of code as is to another place. In addition,
> both exporter and importer need to stop HW access to same region.
> 
>> More of a related idea than something that needs fixing for this patch.
>>
>>>  It need not stop the hardware, because access runs until the
>>> + *   importer's &dma_buf.resv fences retire. Map again before the
>>> next DMA.
>>
>> A successful map will mean the exporter has placed the data in storage
>> compatible with what was agreed during attachment?
> 
> Yes.
> 
>>
>> Thanks,
>> Thomas
>>

