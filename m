Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B03377AB2;
	Thu, 24 Sep 2026 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276653; cv=fail; b=nrcPmPtgViQQ8l5t4FCGAzqmeAEtJbRIwI1XKEUVx1nmk/ak0NcpHFeMQjBnp9gLUo0H2IHFNas1nS4MV/H7HjPmQA5Wb4iMvKjFG4r53q9hGx8u367W0B1CA9LtEyIKjG4Hj8zBqd+Kf8IcOF0N6aluAjegsMX+rlRCHa3ziXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276653; c=relaxed/simple;
	bh=A4H9CiuhQPTw0EtbVbcoz6Iw0eB21V/9tLjZlVrT6qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHr9qJBOXZmtha85snUKSsIxNzc9YMol/NCyv16n/D6SDjWKEQ7dFwjqwHaqpdz2oiFxiHRXK3mqEjafeaGJnLW8Re+xcZ2rrZ07ootJhi7CS08hKoXWvuFjQ7R9Mk2rZZ5fR8Dsy1qlkYFBcV68cykkhZ5BUSo+TWQSNFUIouU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QWudlwjn; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QWudlwjn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cmc9DKmuVbl5LeDae4yX4n7L/HbRBiWrhokHiulyHU6VtfQ3En2M9BqH4FIQROKQDbeh5iisg1MDJp+gyouvJqNFJVHxb7btMrkLo7wx0BTeiih2nLzbvZbc5wmcGFnGgZZXR/gkiy7TJIeekFjoqsRTneUJ3kR0BqozxRlRmV8HWcjNc+15C5ynfxHjlQfnYisgEqM7jAzqeFkG1xI2s/j2zCw2MT5lBzCkQlsAPOYaSqkDfq/d1HFjSXZXU5+usDK8gRqtHfePkcIqZdbt13B1wdTk39ZS0PaWJZkpwngHU4eDaSeoH8reqo3mD76i+PSS1g77tEEQrmXwmpgfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShDmf1jHZoyQ/UH4L8M/3VDcFpjBYgJfnkSaMpj4gEs=;
 b=iTfyrfvd+eWhO8sBcikVCxCLnZgmX+Mzwk1jv5fXG7jQbtW+bxrJfRvVgKiqGThZltjkSOa+QHBKcapX4GR0geShjduk3kUGnGT/5jr1JKeAKIrKB2/VB/hvDisH8gOuacmJTymudP7TcSiZgzfmsM59bzGJm6nsPzX592E54UMIiGWfOERuyNQIrlCH35aSSYDlbnUPvoB6CEM8MQPcIRWFlkMTxJAk8skimP2i4m3GR6Jcj0TcQLv2OZqxTdA8bf1LxMq5KD1ZbxAlJzxfyFLM5m63CU8SXfZjJJJh34fdixrgh1XFUkhdIyu6/Si+kutmWP0azo0L+49VpebEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShDmf1jHZoyQ/UH4L8M/3VDcFpjBYgJfnkSaMpj4gEs=;
 b=QWudlwjnvCi1mWRcHeapbJxcJkV/oaoTNPqXLz9wnHlnOYj0mmDgOom/6sRp2vDTHloFUvPuGsXKe6DYgqO2CTub8kKbhuhhLLPJSeF+oc1UpiFIZxtGl7PsVg/nIKI16jemzYMU6HtSroXyZvAz2XX6fyQYtC3e27to61dwGDkFudP+tPvfbHCydYfcJ5iRWQcuY+XmNiu6VdifTkj9cL/AmkT4gjxnyWDXV4ON2CZDYjO2PWMtwcrtFh5wytjoaZ5jJhZDk6RxJA4Ad8NIHs7vetDKFwtBS/l4gZ/qjRXIHjcVAjL0xBIoGzrNcpIyi8Zm/zjZ2iUZZ4d+PcVK+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:04:00 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:03:59 +0000
Message-ID: <caceec40-4ae4-46ed-8ff8-594fd4046ab2@nvidia.com>
Date: Thu, 24 Sep 2026 12:03:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] rust: pci: make Vendor::from_raw() public
To: Alice Ryhl <aliceryhl@google.com>, Maurice Hieronymus <mhi@mailbox.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-3-5d0b5594e52b@mailbox.org>
 <ao2Lef62ZvkP9eWI@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ao2Lef62ZvkP9eWI@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:806:122::17) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: cb37c020-0ddf-47ff-93f3-08df1a6e9727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	nv5xEmsN9/oSo2Be+kdYcC3weUfooc33dBl4uijrZDC7QO+mVvvqwvx/JnaqA6mVFEMV+DOsS3mE2JgTSEzih1N8B60eA6pqSbpYB65IDGMiNVGCOkvPmw9U/wS4Bom3yHLJd5wQbjn5AUC/83IH1RqbE7ExKucQkwdRa5/lZM05T0OKNd6+dQOCXuTpD9eJ895QcX3au6pluDZIBrW7e7IlTV8jXOSMhnROY3S76Xxx6C2ubjvfqHjYAUhfxmsYa7m6s7lVQidXZIRTgwMfpzfz1x4oAayaYaiCwZvqpWrcSoIFwaq4mmvFyWQGc7bxCv32wyKhPTasgidpb9lKvXs0yhgPcVGXQmMUy0Bsy+Qu1g1n1LRDi3PcFYAoAXA7NgRA+FgqK5HAFau91rWiUqKaZvwwdVCnzKce6zzVJtV4Mt9XSmubentirIfn94E8ljDzZ7qBGQmIdYAKIQdhocoY4qKUlABBli00Sx6O79NFmiWEdrz/bL2l8nUnAxKwvN9TVQAOc99gpBfMQqHmUhV+C3d2j2iIF1UlE8b+wU44VADksZkj4+VqIlC1SSV36njXDSFJTXx6p0VX2cG8jKhe6yzifIUCOejX4AZyd/NVUhcksoyb+htCAbeUxC3Nvcf2hlDIFraTLWAO1x8NStCTycglVqhN6OB/CbX3EE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEFOaDlkZEtTVjVIU2JjVTRyYnhKRWNseXhmRlM5Q1dxVHA5aEZacmtiMzh4?=
 =?utf-8?B?emEwL3lQL25reVdVMDd2bGFDcTFDbFl0ZFpSZnh6RjVrVVNNdE51QXIvMmhE?=
 =?utf-8?B?ZzNrdXgxazIzOXVFTER6MVlXVVZXcWlqNlBhYmlrZUVvUmtoWEJOTENkQ0d3?=
 =?utf-8?B?ZTJCSGV6MWxaaGxZd1J4d3VJRm5TRlk4SzliVmJwaktCVll1WXJsbldGcWlO?=
 =?utf-8?B?cER5SjBycDFYT2hXTStsVVQ3ZVhFMXk1NUx1ak9DZFp3NE9KenFiVzA5R2Iy?=
 =?utf-8?B?S3dLR2o4NUIwRUxVaWZFQmJlNUwwdGhCelEydVpRUDlSemVRRTI0YllLb2x5?=
 =?utf-8?B?Z0dKVWNzWHNsMVJNNHk0Z1M2U1VRUFBEU05TVWZqano0WDN5c0grS2RYRkhF?=
 =?utf-8?B?TG91bTUrZStqenFMa29PdjJNLzZ0UEZuUnRBMUZremhvUmg5UU5GTG95dmdz?=
 =?utf-8?B?eitndzloQ0U1QWgrYmxUU2owUTRJR056THJncXFGRk14b0crS09VL3NDRkZo?=
 =?utf-8?B?RjJZZG9udW5TMldtVG1Ud0pmU0V1a1h1bE1aQlExbnRvdzlvT1ZlbzVLTVcw?=
 =?utf-8?B?REdpVlIvVml3WmtoWXlLVCtzc0NLQTlRTWFrN3I0UzlKLzRIZERnZkFZajBJ?=
 =?utf-8?B?VFdNWDNJY0VBTE82dzRRMk5YWEU1T1VlUzZlZTFPOXI2QXRkaTZZQkUxa3pE?=
 =?utf-8?B?c0g5NFIyQWI1cmdIVW1QeHNWVTU2VjB3eU84QVV3S0toK2pSMkJaN2JkTGU2?=
 =?utf-8?B?ME0zS3lDcHBSMlFiam9yeFhHTEp2RnJsYkRndEJrcUpvcjNXWTVsVVh6QjFE?=
 =?utf-8?B?RWtBNUFrY0NSY3ZPWVZzTzJuUEhxTFdIWFBQbDJaamZER0l4c3YweEc3T3Rx?=
 =?utf-8?B?YlJyVFUxTURWQnBuZFJla1RTNnV5Tnh0UFNXYStSYUFxM2pXaDcxeTN2eWI5?=
 =?utf-8?B?WkNVa1MxVThBWkdIeEtwbnM3VE5zZ0kxdVdGd2ZSRWN5STZsVW4xSHR0djBZ?=
 =?utf-8?B?eXl2bzlkRzlhZFliUjFISVdXS21iVDJiZzhQVEk1UXFpazl5cVNMYW9yRVdl?=
 =?utf-8?B?WUF6bWZxYnFuY0pvNGp6N2NJSEU3c2I3VzQxWGUyNSs1bmhYT1Rrb2c4MnNX?=
 =?utf-8?B?SDB5NlNYTnY1dThXSFNhN3lmZnl0TlpOMXhMV0dWUGorbzhMNTQrWGJDNEN6?=
 =?utf-8?B?aE5EMWlnNUJtWHl2R1dJRVhsay92bTlJN3pVWFFCclY4ZXRJQjNyNVMyV1dm?=
 =?utf-8?B?Z0JjTnRhV3VmemFJMlBnTXpTeWpQcVdCZHpGVWt2cEgwQVl4eW5SS1dDb3JW?=
 =?utf-8?B?NjNzZkoySGlQWUdVLzRUT2pMRDdKc1pIVWNiZExwblZzZnNxZHVBUkFGYjRx?=
 =?utf-8?B?SjNHbStwbVFmVmNITjdkNVYzUmVkSUdQWVlveFJOaStMcDAxR3lUc0xyZGtF?=
 =?utf-8?B?Uk90RVFuUS9MeXcxSzdpR2JBa3lwQUw2U1JieHpDbm0yb2U0VnIzcjdUNnJP?=
 =?utf-8?B?akVpa0twMmtzY2xwV0FZZVBWQktySHA4ekJKYzZaNm9GblFJNzJ3bkN1UTFD?=
 =?utf-8?B?Rk1JTHNRL2dDMzJ0YTR4NzVzODBxdHlsc3RsZWYzdjJRUkRWOW5nczdlL1JM?=
 =?utf-8?B?MTNRRlVBVTQ3R3VmTGhnMUp3R0RHM2RsYjY2ODd2VkZwc0ZIVTcwcllITG1T?=
 =?utf-8?B?ZmtSQmpnNEl5TWlCcnJGMjgvMElnczF0Q2xFYnRqaHhOMCsweC9DU05SbitP?=
 =?utf-8?B?NGQ4UC9WWERWU0pVWDlNQTM1ektyQi9wZGJVL2pWOGhFSk1UbXZMVmg2TkFz?=
 =?utf-8?B?Qm9ybWw1M2U0YTF2YjV1bTVVY0xRT1NSYXl2NFRtVXd2ZkczMEV4dHJPd1ZI?=
 =?utf-8?B?S0ZBOTRqMEUvUk1Ta29YME01UVkyeXpDQ1p2UmM3MitRSlg3NXZYdG5PRnZy?=
 =?utf-8?B?ZStDaHdXMzNBd0RHYW9kc3JESVU4a2dQV1NHRVF0d1JycnRCWXM2YndUb3lQ?=
 =?utf-8?B?U2hxbmNHdURyUWx6dnYzcW1IWHhOTS9hYzJvT0tVN2JzcmltWE9halBVUld4?=
 =?utf-8?B?NDVvdXJua0FpSEVqOXlPbmhQcjlocFl0SVZpTFE4SmY4aXBNZGx0VHpLd0ZP?=
 =?utf-8?B?NnVjbGxIakNFMWczM0FyQjRtWDAyNFF0YUFHZTRzTlJYaGZDSXZVMGtTTUpp?=
 =?utf-8?B?cUxTVm10VHNUbnBUVklWOEhRM1AxOEp3S05TWnV3MUxidUFnWS8waW9Bcmcx?=
 =?utf-8?B?NXlGUVJEZ1B1SFVEZExnVkpHVStRNTRzOWpDc21sY1Y1cW4zN1E3SzJRZnhD?=
 =?utf-8?B?SUpTdXM4R01XcWhyK2dFYjg2TFo2K1FUQ0I5cjVFZGVwUFJhWWtEZ0lPWVkz?=
 =?utf-8?Q?vra9V0oQPqMdWZ5A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb37c020-0ddf-47ff-93f3-08df1a6e9727
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:03:59.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqlxl6C2MZU4KJJkz71WNnAjFGuxuIVtBnGR6AbmL4KphP34hiMuxz2a2O97YoLxAoNzxEbn3KfIU9t8uahzfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777

On 8/25/26 5:32 AM, Alice Ryhl wrote:
> On Wed, Aug 12, 2026 at 09:52:37PM +0200, Maurice Hieronymus wrote:
>> `Vendor::from_raw()` is currently `pub(super)`, so a Vendor can only be
>> obtained through the named constants generated from the
>> `PCI_VENDOR_ID_*` defines in `<linux/pci_ids.h>`. A driver therefore
>> cannot match a device whose vendor ID has no symbolic name.
>>
>> Such devices exist. QEMU's "edu" educational device and the legacy
>> qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
>> `pci_ids.h`. Per the policy stated at the top of that header, IDs are
>> only added there when shared between multiple drivers; a single-driver
>> ID is expected to be open-coded in the driver instead. C drivers already
>> do this -- see `drivers/gpu/drm/tiny/bochs.c`, which matches with a bare
>> ".vendor = 0x1234".
> 
> IMO we should just add Qemu to the list. No reason to hard-code it per
> driver for this case.
> 
I strongly agree. There is no need to break the nice type system here,
just to avoid adding an "edu 0x1234" entry.

thanks,
-- 
John Hubbard

