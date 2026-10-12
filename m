Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022634A796;
	Mon, 12 Oct 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794319; cv=fail; b=shbP3kdmM/7bbzJjZ4VQNAwNO7DWJ3vpTDcCbIOhzhnBdLvLnsmAtt47+/uRrVjqtLp4bLHQGOf9EqQpA4qGUAxdzetp9YabiIKp0l9zJtWqPMh4GfbFDw1Vo30jiRbz9qvd5gQ3UtIjwNrkmd080tudQnfqyEt1GVBGLhlXMT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794319; c=relaxed/simple;
	bh=dnfSD6NHHXGAin7Ome4XQuWRgzRlzs0AwstzU0JpN0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TJ7ZR3LHDuoxf4COWJIvvcpZm5itWy+AuhMghaERkG0hway7Svb2K/UkjxpRrxnzbcfE7D0N+XzPv+d1TZjvhilp9sJJDscj0c3WdA2Ik2rKrvHO7fVGQalgkzH93bAW0MmVcAlEKKaj1nnp0cJssrb8xz57o29HOBtpHai/ce4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ozd5M2ii; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ozd5M2ii"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuZCyTeMPqaheDkWikXxAwPRPeS+C+4bn47zK6JNCyJoeK8zienXGV4nArAXEw5nXPZCqMGTzRJyJz1ipSbcP7HYzgjM75fWQJRKtkixj9+EAk+j6Aq1Uf8swlJJ8ZLb5FfC95Rzn722/EGhYX855W3ECrXXDquAXpsoSEek5SsKuf3a5HpfFFLNsgNJ6HQJesJDFBW9wr0OZgyUwFIrFLQeNfZGRiGP8pF/IGsxoVug7DJiHjBbxJLABfmtb/zIUeTP7Htg4kJozzp97z5xeZyyWsMoPRm5akPhXtls4iDyPPnRx4+xwlQhnA3Mcu6am474IFNhws3qYb1D2pTQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KedRzG/35RV/0hoRDxnPbAYNkupMHxmW/veSvrdjJXI=;
 b=L0Anh4M3YDQIUCr3IAH3svXeLLz4lHPCIBQTrhDKIcBbtE3pqbT6xd4hzc9PatIXPJ5nZHR8DLZ8p05udjn51BNE2i4+TUCF3Z55aeURaJQBc6KtD95AUXEtmvDukmbxJs9Llgc7r20R1CBEz03CFTXs/+HRvpLK+kWzrRBH3JaF0Ej0okDQPtLWSKN6dEs87jOd0nOjgEfE6/ygrC32sRiMAQvt9KgcIa+A7wrdBLLcE0UkZr52TcVzLUUWmLX3jOgTfPwfyIP+1MLYFMG7uDDevzXXDvoL0jjyXgtnVwZp9GYL6evtjl0K6e4WwWs/YZMuhAsYIPHAuKEeXymsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KedRzG/35RV/0hoRDxnPbAYNkupMHxmW/veSvrdjJXI=;
 b=Ozd5M2iiGB0Dp6KttwTH2Z7L69qzQhAVXua9mcRyQ6+GJ7espogylExktrzbH9WbcPlZIw+19zOW+jFj4ySyPHu+eT03ih3aVu8I57tRHAdX6NiWhO7NArSH/qC/GWScV9W8ILacpHlijNoUnq1uhehr0pBtxeJZoZ+e1uRzQbejdorPLrOKczYNoz1m1oAuGMQ9V22XgpZBvG0Q8Y1cKBIAzR8FZUao0DwqmEB09sTclcQfEw6hPnDIpicB4pyrw/cekg6P1Uopbx+uYIifJDynbvN2dmHSK6amt83ilYjjxokTg7mvaNtWb+Mx73eLjD4DDJzWHZ+McevcoPJa4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 08:38:35 +0000
Received: from CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3]) by CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 08:38:35 +0000
Message-ID: <126200fa-49e0-449a-afac-cc08f4a9ecf3@nvidia.com>
Date: Mon, 12 Oct 2026 14:08:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: tegra194: use dev_err_probe() for PERST GPIO
To: Bui Duc Phuc <phucduc.bui@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007104847.507776-1-phucduc.bui@gmail.com>
 <20261007204638.GA785135@bhelgaas>
 <CAABR9nGNoaO-CmTcRvXuMMmGbVSWybKZVBRRZmzQCab_N1EzZA@mail.gmail.com>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <CAABR9nGNoaO-CmTcRvXuMMmGbVSWybKZVBRRZmzQCab_N1EzZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::17) To CY8PR12MB8244.namprd12.prod.outlook.com
 (2603:10b6:930:72::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8244:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 005ff612-c1f9-4514-ee78-08df283c3470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ukmrr2YpDWRo1aOfLL53SAYJrrBw8geRyWx0vdSXTkOOSAWboeLh1MTSgvIPReIWpmIFz0oMgEFPBer5475cLxqlmt9OfnItNVi4aLpzzZA5XzZCYohw/V6PXNhC7yFjHqB9xNpts0wjXqqFeMNquXAzc6z/DF4VX0nbmjPW5oiIpGEaifSgxEFgBuLE0f8fz3v7/dTBNhKogZnJNsUk4RFEPq5oqoJvJDmAv1+1CkQ1BBOR2vvNA8iTipWaNzNytB7iskyk4Ga/a9IL3OlAM6bqICP/LR4hmwhoimZb3ij2vAuY9qTksgfH6wGqs9iuhClLeuuTpohmeBXoV2DHvlNbPDR1L7/FsbmCe0VC5DSYBqlP/jDHn2Cy3zRMp8roj2ZZ+WFVtwf7MJKKjQrWbKaAVi2Ee1yQhgLYYA8HTkyOOR4l0TuKVM137sc6rcGU+esjFAKKULF8X4ZJP6hOCmPOJ/2cKAz/OoYI3Xo6L+LwYL4Qo+5tBjD9qfNlkScPIdk0sLcTvAeVgNhPihpcU8wbGq+eZ0NdWS5i6+Bg1SdPH07UxFJrcgMV16UjwO6WM3D7ClynbKiHGMoZaK304I7czEMw72ZtXJPThnVZLgqaFP1FCoALsGVva/axUiIC4p/EOt4YtnA5saXZCra4gYOhjOVgurOrJCgs7K8ARrc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzVZbkNhRDlDY01wcTVSL1k0U2FZamhhcmZ5dDBoNFhVeDNRdmtDUzFjbHJr?=
 =?utf-8?B?VUs5QjNwYUpraWRUZWpmdUorSy9JVWpySkZRRGN3Tm9KZlAvOU5GbStQSFdV?=
 =?utf-8?B?UjJ6NkIzbUo2bE5md0k0RkZEa3piWXVQcVdNWmJtWExrU3FVazhSeUlab1BM?=
 =?utf-8?B?REtHMllKZHlsQWlKczdMekNkODNNTUFqbExtaEJQaGJYU08xSlZSMXIvakQz?=
 =?utf-8?B?S25NSk9UcTN2VmNhMUxidzdEdEs4VGcvNG5qc0JCaWJiWVIrL2s0cXF6SXhn?=
 =?utf-8?B?ZXpTZGZ5b0lwZVc4UmFFLzJ4N2twVENhT1ZRaEtTUUkxSXptUlYrUk8wMkJL?=
 =?utf-8?B?UVRxYTZNMjhSREQxdEpUYkI1aWRNZTJoVFpKYnlvSlF4cHROclgwRDM4S1lx?=
 =?utf-8?B?THk4amg1TFlRa2NjNEFNYS9NdGRIZ3IxSVhNQmRGSzdhZkpBZUNmSTRJbEhJ?=
 =?utf-8?B?ZGx1eE1YTzAwL1JOblkwRDlkYUZ4VkgyWFo1dkxnU3VDNDJYbXNyZkNubWR4?=
 =?utf-8?B?UmtZK3RQZVg5eGVzdnRuQ2FYYlhmRjNWQXBiaUFTYlhZOU40YkdlRUl1aXow?=
 =?utf-8?B?RFpMLzcyWFVJZzJDVzBvbm9zcm11eU5LeHVBNUxuWGtUUndnY29EdkRKY2J4?=
 =?utf-8?B?alhPVzlRTjdvSW1SL1l0cmt4ZVBHR2RTWXNTRVRjWlViNzByN0xhT0FOQ00z?=
 =?utf-8?B?NUxEa2hvVDhtbmZqaVZkUGUrTUdlcmQ3MGZWM1F0OTg5bEdlWE9XT1VlcThn?=
 =?utf-8?B?bko1YTkzWGwrOTRqeEx5YS9OWVpMQmpRQm1YM2FobWVIMllYcTJSWmRHSTR6?=
 =?utf-8?B?Y2l6NWdBTStDMG1rbktXYThXa3JsYVVkaEFMamFRWHFnRjM0N205Z1FSbHlX?=
 =?utf-8?B?OUpPSTZhdVJrdlFwbm00eFNBeUU5OGlDME9CMy9OaGQwVFpKSk54UnNhMTU0?=
 =?utf-8?B?SitnQW13K3BYcVF2dTFIQWNPSm1DV0I3ZWprRUpLZzNVZGpuTjUxdzd5Q1hz?=
 =?utf-8?B?WmVOQXZtbFJ2aytJNEZvRTZRVy9KS0lZYk1jNis5d0NUd3NmVHoyMEhnUU92?=
 =?utf-8?B?bDM2OUNEZXBIU0FIY1Npbit0Y3RDN0J0YXdIdFk0RXduSS9hOXdzekxEczlT?=
 =?utf-8?B?RHpDQlI4cXNZeVlKdnJPZlNqS05FSStFaEUzaVZBWXZ3RkRNUWdxSkZIWlRE?=
 =?utf-8?B?NDRPVkpQbE9Bc3BUSzVIT1dHbkIrQlBTdzU2Z3kyMjFaNWI1V0ZsNm1DT1gx?=
 =?utf-8?B?MTdZL25mQllSQ1FMSWt2bHpyN2QyQi9lR2MxeVRtdk9kMWJtdkpyMVkrU3cw?=
 =?utf-8?B?dmlkT2pXUVFyaUo4bzFiNENWWkhpTXdQc2lFMkNmdHd2eXdGKzEyMEZGajVD?=
 =?utf-8?B?K0cvN0N3cDhJVlhBaFcvLzhLOHluOXBmL3ZDTHFyZE9BTHBTU2hJaXg0K2FC?=
 =?utf-8?B?aWxydTh3N1BQV1Y5d2hsMUp6ZEk1WGdNc05TTUhtMkZ5bmIzTGFldys0SDRF?=
 =?utf-8?B?eks1NUVvK2VkMHZ2RkV2RXRxdzl3RngwWFNDK2hTMTdRT1BGdVJRR1ZDQVBQ?=
 =?utf-8?B?Qjd5SlNtMU1aQmVLOEF4RHNTUTNaNm1JbTh1bjJCZTJ6ZlA2UFNISXpDYzVF?=
 =?utf-8?B?RExQUHhuUHZOUFpsUnhCNGo0OXdhZ3p5WXVzdzFVYkJNOCt1WkRNQ2Y1NXZa?=
 =?utf-8?B?UCtXbFljWGlhbDhPNlJTbEZycm9ZWWd5c3ZIelY3ZklReFFzYzlkMVdYTjVC?=
 =?utf-8?B?VC9kQ24vbVZWT0hYcFRqUnZLL3lNOEhjKzg1Y3J6VUJZTmtjTER6RVExTnQx?=
 =?utf-8?B?UkxDdjZ3c01YQzA0NTRQTzJPN0VHOThkb3ZYdDJPbWZGaXJMM1lpdTJBQXM2?=
 =?utf-8?B?YTNGenl1MnRYaG0wMWdmbUtPZmJxNllNc0JaYzY5NlBmaHNMU0xzWjdkVDhN?=
 =?utf-8?B?YnBqbUE5NzdBNW56OTU2MjFGR01rVXltRytqdUhQL2VKMlN1aUdrL2YzS1Rp?=
 =?utf-8?B?SWZicVMxOUVjODFoWTRlTXd0NHlGMU5uNmNKQW9zRjVZeVhMKzBrdW0rbkJl?=
 =?utf-8?B?R0Z4QytoZnVObzlkU1FjVTliR2NiMW1oWEY4MjVIU1VzbmFJNG1hV2RTNnc2?=
 =?utf-8?B?V1pUczRYeS9PalJIWWxra1VTbmdTMkFwcHl4QUhFdHBkMjJUTlF2M2lxYS9B?=
 =?utf-8?B?dGdKMnpjTW92b1BSb0dmRi95NFBUWGx5Q0dXM1BITmc0QnJiOUhjTnlIbURO?=
 =?utf-8?B?MXY4YkpXSGZUZXgzdWhjbUFlNTNqTmxZb2FnU1VvL0x6M3FzNStyaGdzMStZ?=
 =?utf-8?B?aTZFQnhGcEhHRUQ1ZmRqSTdYdkplcTg1eER1dXBqN1J4bGNXZUV0Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005ff612-c1f9-4514-ee78-08df283c3470
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 08:38:35.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JH4cSrjtVijKDum63b29zLSvLpHUnLrdJ1PiJ2B2vzz0mm5rolmPemAgS9d/82gfxTfIAGgkUjdyrFmVpTKR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512



On 08/10/26 4:38 pm, Bui Duc Phuc wrote:
> Hi Bjorn,
> 
>>
>> For future posts, please match the subject line capitalization style:
>>
>>    PCI: tegra194: Use ...
>>
>> And style as "PERST#" in the subject, commit log, and dmesg text to
>> match spec usage.
>>
>> No need to repost just for this; we can tweak these when applying.
>>
> 
> Thanks for the review and for pointing this out.
> I'll keep these style details in mind for future posts.
> 
> Best regards,
> Phuc

With the subject line capitalization and "PERST#" style fixes,
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

-- 
nvpublic

