Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC051BD9CE;
	Tue, 21 Apr 2026 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781668; cv=fail; b=O5xZzmQmHVUXkeTEbEF5xF9W6Ri3N5Mo9+oEFEeucVJlvqNtYGTwueIIz/ROhsXDZtX8GBQq+YG/CvsXtQbHT+UJluAaqEA/Mfqm46e5WtbVPIZ4edfE1bfkzKtgQjXzCvMZbS8Zax4VpQb8tcZux4YdaPYADKLSEDtQxXqEgc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781668; c=relaxed/simple;
	bh=bHpyvLPesHDbglT4V7i6XGUTvZAml+n1YrGdoYdVYm0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=qCk6PTOwsBed+imZgHqvRTjuYbyHciB92vzI8HyFJrSSxOkw9QaD9zThpw0DODWL/f7UTHPhYJ8S2B02nA2OBh0sRUW8WPRUZbcZBkLm+xksy1fnPeRF2wqVUVA+iaHW9BxH7Epwn9mXcxCxbZG1OjjQwB+3/CY0py+iDPtuSMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mWuJe4K+; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mWuJe4K+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9uVHvhQ2uwSnrWQlYWc7QKzE6mbe0NHYb7l1Hmg8n2TVmqQVgaBfKSL/RwzAtFJsr6oBWw5AiwMWa/wnbE5OKivJcWq/3l8sT3swU2rMYp/fOPx2p0y9aLDVhNbom1dEsR/YHhe0SapUauPc+MR/HikvaLt8Eeoh6d+8x47U8gB2ZWmm5dxIsQjMwXsntSoUnqvp4uYgfJRt3Ogg/xrR00cvZTZjxGCAvVwmf2TRlvibLKlb8KtG3hFJw564lGnvQgpgrT9hxN3vA1Y+ASw/dXs+8jgRxaQn72G7syWc9fVGclhh4VWXxWYW9dDLN9U265Pgd/dlRhCeFM0hvj3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB0Jj/T0Kujz8AGG03SQNUTOv8Vu+AQGlUXDm1kJuF8=;
 b=l0t5vLoX4+lDDQKMFPpbBkmIvTXrKajMpscPPoj++R5F4X5eQEbLZqwsLWs1FVO763cWMf4avIW7rpTZCBDgybO5hShftQ1LHmpXIQcCwWyjgDpCZLXThgj4YDTJ7G029fs4ENa3SEQqnQgbmyTwwFhz/3PKARnDtxR0luF9E8NtQuY48Yo8txemkVQDye8Zvl3UukxPS5kD+LhLbGS5LBhyLjH4BQpy1UuBc9hmAyinGjiiLALOFoxj3cSOSbp0mVp6lOD6x8CenrXC5HMfqEQOTe4D//PPUtpqReFFzV3gp0bN4ZsH9grKULAZIfDk2Lp6nJMDuOqQwcf8oZ0Kng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB0Jj/T0Kujz8AGG03SQNUTOv8Vu+AQGlUXDm1kJuF8=;
 b=mWuJe4K+xIkSV3BkyMxvRMpN7wEC9K+QXMCyoe1tNjy82GGHGx8K3at2PIA5TQjsN5DRgiXq9qqvV+1R7+tNnFHhU4fkr2IL7b595sJhsuFTSn/aG4kiRMu1vFH4FSpizWJTbqUyJGB6gLCHHb2Hg6LWkWSzHclFVMSBQDquqMGO/hlBmnyV0QMBSalQQhTzgCvpMeKiRsGmTX7OlNmRb6zAjtkn8W9TY/PRtOKbqFb2wqxllFqMNq3/oQX8t4ZZP+PFA5ByPhQPgJESVKZqsn0n2tjjvIEFw5ZxOeuMfhwieXStxhJggeTQforkTYdebaFANxaqstyxodnTZ6NYEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH1PPFDA34A4201.namprd12.prod.outlook.com (2603:10b6:61f:fc00::625) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Tue, 21 Apr
 2026 14:27:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:27:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 23:27:33 +0900
Message-Id: <DHYWJ32M02N4.2954OSJXFGD1G@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Boqun Feng" <boqun@kernel.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-4-2fe54963af8b@nvidia.com>
 <DHYQGLYYXEN6.11Q3FQGZMWCJ6@nvidia.com>
In-Reply-To: <DHYQGLYYXEN6.11Q3FQGZMWCJ6@nvidia.com>
X-ClientProxiedBy: TYCP286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH1PPFDA34A4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0479f95b-a382-4047-6a1a-08de9fb222a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ch2lIj7zyTD7Q/IL3RTPRt5kIp43U5AQyU1YfOFiy1UZJtFrXHemk1lsiq5hc8ojFkZbhxaIEY/PNOvv20m8drRyH0uK3mFsW0YC8IugRVpA1C/CKzF4PHKlznqDVJ1mKfWeaCDNk1JpRwAw5tH2LGtnVQjmptfzxfxVVBb3qh6huNl5MTU67NyRLLnCzYHMm9pG2rPBQBbhwFALZUJNNGFNDxsGUVYRlTmUEFuI+UfcqgbP0ig9B7y3BhekL5jszcRTe6FX+JOJdrwrwOXJBc9su3MD7e2pf0rXowEYXcgMST5z0RTjNMK13/JGe6vnJCOOrHezZ57Z2k44CjiwGope7DpY+LBakStOqIoBdPGhVHWGujt0Po3/fQpH6RqsFmuDle3426eTw28uHjHmdC8y++rhSKBwRN4M4e/uE2iwBONC6+IytJW4SWcSQfAlz2yb8fv4bPx0l2w+tfbXF0FOL9tYF7XEuQdcrO9EwvGym5ZvI+1hPaPKK2zfChFSfPFYnwhMkeO1700H8cD/TOyY9PfTcWp0MiaKRx5yO7KB5RlJGieFZ6S4/PXUvlxxr3pHumffZzHT+ipQyfWPejlvTPfvyfpGtIKixpZi7VDUWoJWi0LT9CI4ruX+goyBO6jbB4k3rsKkBITK/x5CAQqu9mmu9EdZjCjyvQUSKWTw6zOz8dypFqkuIUFfubc7bSl5TlSThWuxbzZXph4nW3z9ijV0GXk26ukL8StSS/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVo2eTFQaERPOHMxWU1NbUhSY1czS2Y2RlcrVEI4Y21rWERQSHFxY3EvaEZ1?=
 =?utf-8?B?aGtMM0dYcHhkSUJzSnNEWUxGMGJZTkdsUlVyQmNpYjBCdVlPYzRCQml2ZWpx?=
 =?utf-8?B?dzJzRHBZVGNnSnF0UDRyMEpEWWJLMW04RksvS0ZROURwcktJT3N3VUZMNXRZ?=
 =?utf-8?B?VXk4L3prNmpPeEMwdUYyMXlQQVR2SmxEcmtWa0RNNENTOVd4dXBNVHdzYXZG?=
 =?utf-8?B?Ky9rL2J3ZHErL2JYWHBjTHJlcjRKbmVITUdycXdQT2dSY1UxREtrd2dETWEx?=
 =?utf-8?B?bVhxZXRsUlhjVmVhZkIrRTRJVEN5MnNxc0NXZk9rbmpIVUVKMUh0dUt6b2ZN?=
 =?utf-8?B?aENsYURuMXZ5SHJKMVM2cURxd1hoc0M1MHRjckU3Snhxa2JpeUhBMUxkL0VL?=
 =?utf-8?B?bjA0eUo3cEZyVjl0aWtWTFVvRWtrSWxZSjhvaHNkcTE3MFlybjhyWUpGMytu?=
 =?utf-8?B?aVNIaVQ4eXNrV2pVTzViSyt1VlVabUptQTlEa1NOM1doeU1HZjc3d0l2V1l1?=
 =?utf-8?B?SUlyQXRBTU1sUDFkVUozeXJxOHZBNTFXcXRLaTF2N1NZR3dhaGFCRDEyTitM?=
 =?utf-8?B?RCtROXBERzZOcC9FNm40RzRQVXc5MC81M011QWRtaWtscThYaU44UXF1NUlP?=
 =?utf-8?B?alY4bzFMalBHUHlJa0ZYZ0hGSCthQlVtTU1pN2lNQVhHRFduWGNNWXdkOEM0?=
 =?utf-8?B?SGFDWGFBODV4WWhCOTVjTlVQYmR2dWF0OFl1akROWk8yVnE5bm9MWE5RZXJL?=
 =?utf-8?B?eG1VdnQvYXBjSHpNRUh1bnprY21BK2hPQkNCWlBlWEpEc0NycmJ2UHo5L01l?=
 =?utf-8?B?amkvQWI0SmpCN1doQ2pZcTVzOTBBNVRDNlJycjd4MmFZclQwZ2ZSWGZkVnJC?=
 =?utf-8?B?dkJQWVVJbG42MWVVSk9TL1VHRGkvbWpTSXlBMmdUdTM4enVtZVM4aFdoam52?=
 =?utf-8?B?ZjNzWmUxc1BWSXByMFU1clpiZGxuSmoycUpibHdRV2lwSFZUcHJaNnd4ODdV?=
 =?utf-8?B?T3BGOUFGcy9CMXVOQnFsNk11ek0rNkUrQmhrT3g4bFMzUThQbG8rdUJpTHBj?=
 =?utf-8?B?bldnVkhpRkV5ZkdJUDhSTzFlemt5UVFJZ0RxdTYyWGxyNHMvRGdJYlRFaUxn?=
 =?utf-8?B?c3BPZnhJN1QxRnFDdk5SSzB0UWkvamlpYVV3bkYrL3N4ei9XYlV1TFljN1Fi?=
 =?utf-8?B?bjdWS3VvSEdGbXNDb2Irdy94TmRGNzZqUUhNbEREem55M01QL3pBdEIrUVli?=
 =?utf-8?B?TXpDS0dwWmZPM1hJWjVQUzNZdGRmUDVHQjNsaEhhUGJZcjBJSGFsNjJ4M3VS?=
 =?utf-8?B?MU1aVXFtQ1dVWGZUVGlEZ3ZWZHF6ZHlDVVlVUTBHb3Q0TEQ1VzYxTS96aXlw?=
 =?utf-8?B?ZEFNSTZoS1J3SFVsZ08xV0pVKzVzeDIySDl2TWdWWnlucmFsbi9HSGhSZlJu?=
 =?utf-8?B?dk9rSi81QkwrZ0dTb1pBY0piSytoeTk4RVh1ZWVUdmVVQ2NaNUFKUnQ1dzU3?=
 =?utf-8?B?cWQwR2V5ZGtWNllDSER3VzZFaGNpOWV6TEcwZFJTcTRLSXlqRnJFWHVUUGcw?=
 =?utf-8?B?VFhyTXNIa05uNlRrdE90YURBYlQ4VStKdVQ3akNxVGRicW04K240dzloT2o5?=
 =?utf-8?B?SlBRbjUyMFpEVnErS2VUdFBUSlpaUXlsMk9QT2pYMnI3Z0owamVJRUVQTmpI?=
 =?utf-8?B?empMYk5URkJnM2ZTOEQ0SWFsdFZMZkRONzhmcDRyR0E5M2hndXFDWk1GK1V3?=
 =?utf-8?B?M2JvRGJPcHQ5L0tFRG5yMDE1NGV4MWppNnRNV1M5MkZzL0hHQmJDNVVscWxp?=
 =?utf-8?B?djdVcExkMUJIM21GUER5MFludUZwLzlGbTQ2TFpBVjFlVDFQT3BNZFN2dVVM?=
 =?utf-8?B?K0NqOVR2WFdyMjJ6Rll2M3hpOC9ybFFxR251RDdMeDRiZG9xb01VQnZXUE1V?=
 =?utf-8?B?TVE3V2FhaFA1UDRCREFidWxnNG1NWHpFZ1grdUlRbVlGTk9zK2JFTXFvUldn?=
 =?utf-8?B?b2RwR0RKUVJVVTJJWmJtNkVJZFRib3U3WmkrRkNFU3ViUGRNOWJ0ZGRCTmN0?=
 =?utf-8?B?cFdMcUZ3d0cvbFdPUUh5TkZIV0c1NVc5eWtTUEFmWS9iNjVxYmgzdTBVWHVI?=
 =?utf-8?B?S2lHWW4vRHYxc2JWekoxTU5aaVBaUWtvdElsL3JDUXQ1UGt2QVVSZkxlQXRv?=
 =?utf-8?B?M2ZpUitRVHoxWnQ4Smpha3ZLaVR5TVNKMWh1UkJvRURXUHU1N3BJR3U0YjFT?=
 =?utf-8?B?MU5TL01aOFgvZUg0L0JaRXBNTkRzQ0s1SGJoQnBQVDlsNmNVTmV4VjJEUlJU?=
 =?utf-8?B?YlB3aTFUaEx1YW82ZGpqNU1ubjFLbjVteVpKRjB1M2Mxd1JUU0xtZWpwOXd3?=
 =?utf-8?Q?H04LofcSLe+eibwAlClquIQ0RrCHzmoUAvpuZHii5CAwC?=
X-MS-Exchange-AntiSpam-MessageData-1: ZQvvHxCaftyr2A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0479f95b-a382-4047-6a1a-08de9fb222a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:27:37.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvAcGAbO6AUihVRIOEbGBbXrUUsIMkGXIj2KzrpZGfHUNIj8FfChpmcAct1aygCXlcVTv/TW0++eIK625gDcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA34A4201

On Tue Apr 21, 2026 at 6:42 PM JST, Eliot Courtney wrote:
> On Tue Apr 21, 2026 at 3:16 PM JST, Alexandre Courbot wrote:
>> Currently, the GSP is left running after the driver is unbound. This is
>> not great for several reasons, notably that it can still access shared
>> memory areas that the kernel will now reclaim (especially problematic on
>> setups without an IOMMU).
>>
>> Fix this by sending the `UNLOADING_GUEST_DRIVER` GSP command when
>> unbinding. This stops the GSP and lets us proceed with the rest of the
>> unbind sequence in the next patch.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gpu.rs                      |  5 +++
>>  drivers/gpu/nova-core/gsp/boot.rs                 | 40 ++++++++++++++++=
+++++++
>>  drivers/gpu/nova-core/gsp/commands.rs             | 36 ++++++++++++++++=
++++
>>  drivers/gpu/nova-core/gsp/fw.rs                   |  4 +++
>>  drivers/gpu/nova-core/gsp/fw/commands.rs          | 23 +++++++++++++
>>  drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  8 +++++
>>  6 files changed, 116 insertions(+)
>>
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index 1701c2600538..8f2ae9e8a519 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -277,12 +277,17 @@ pub(crate) fn new<'a>(
>> =20
>>      /// Called when the corresponding [`Device`](device::Device) is unb=
ound.
>>      ///
>> +    /// Prepares the GPU for unbinding by shutting down the GSP and unr=
egistering the sysmem flush
>> +    /// memory page.
>> +    ///
>>      /// Note: This method must only be called from `Driver::unbind`.
>>      pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
>>          let Ok(bar) =3D kernel::warn_on_err!(self.bar.access(dev)) else=
 {
>>              return;
>>          };
>> =20
>> +        let _ =3D kernel::warn_on_err!(self.gsp.unload(dev, bar, &self.=
gsp_falcon));
>> +
>
> If I remember correctly, at least on blackwell, doing the full unloading
> procedure here actually resets the sysmem flush register, so you get a
> spurious warning. In my local branch I actually swapped the order of
> this and unregister to get rid of it (not sure if this is correct though)=
.
> My sysmem flush patch that skips printing the warning if the value is 0
> would also fix this, if we care. Have you noticed this happening too?

I haven't - this patch works fine and without any warning on my
Blackwell card. But that deserves further investigation, so let's
revisit once we add the Blackwell series and your own patch, as this
series only supports Turing/Ampere for now.

>
>>          self.sysmem_flush.unregister(bar);
>>      }
>>  }
>> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/g=
sp/boot.rs
>> index 18f356c9178e..3f4e99b2497b 100644
>> --- a/drivers/gpu/nova-core/gsp/boot.rs
>> +++ b/drivers/gpu/nova-core/gsp/boot.rs
>> @@ -33,6 +33,7 @@
>>      },
>>      gpu::Chipset,
>>      gsp::{
>> +        cmdq::Cmdq,
>>          commands,
>>          sequencer::{
>>              GspSequencer,
>> @@ -237,4 +238,43 @@ pub(crate) fn boot(
>> =20
>>          Ok(())
>>      }
>> +
>> +    /// Shut down the GSP and wait until it is offline.
>> +    fn shutdown_gsp(
>> +        cmdq: &Cmdq,
>> +        bar: &Bar0,
>> +        gsp_falcon: &Falcon<Gsp>,
>> +        suspend: bool,
>> +    ) -> Result<()> {
>> +        // Send command to shutdown GSP and wait for response.
>> +        cmdq.send_command(bar, commands::UnloadingGuestDriver::new(susp=
end))?;
>> +
>> +        // Wait until GSP signals it is suspended.
>> +        const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 =3D 0x8000_0000;
>
> If this can change based on firmware, should it be taken in via
> bindings? I also noticed in openrm 595, this is waited on by checking the
> bit rather than by strict equality (see _kgspIsProcessorSuspended). So
> it may be more defensive to check the bit rather than strict equality
> (even though that is correct for 570 according to openrm code).

Indeed, in 570.144 the code is actually

    return (mailbox =3D=3D 0x80000000);

... but I checked against `main` and it has been changed to what you
said, so testing the bit is probably better indeed.

The value is also a file-local constant, so not something we can get
through bindings unfortunately. :/ But I suspect we can rely on it being
stable.

>
>> +        read_poll_timeout(
>> +            || Ok(gsp_falcon.read_mailbox0(bar)),
>> +            |&mb0| mb0 =3D=3D LIBOS_INTERRUPT_PROCESSOR_SUSPENDED,
>> +            Delta::from_millis(10),
>> +            Delta::from_secs(5),
>> +        )
>> +        .map(|_| ())
>> +    }
>> +
>> +    /// Attempts to unload the GSP firmware.
>> +    ///
>> +    /// This stops all activity on the GSP.
>> +    pub(crate) fn unload(
>> +        &self,
>> +        dev: &device::Device<device::Bound>,
>> +        bar: &Bar0,
>> +        gsp_falcon: &Falcon<Gsp>,
>> +    ) -> Result {
>> +        // Shut down the GSP.
>> +
>> +        Self::shutdown_gsp(&self.cmdq, bar, gsp_falcon, false)
>> +            .inspect_err(|e| dev_err!(dev, "unload guest driver failed:=
 {:?}", e))?;
>
> It looks like "suspend" is only ever false here? Will this be used
> later? If we want to keep this, it may be nice to use a 2 discriminant
> enum so we don't have misc boolean parameters hanging around.

It is in prevision of suspend/resume support yes. Agreed about the enum.

>
> nit: dev_err! should have \n?

It should!

>
>> +        dev_dbg!(dev, "GSP shut down\n");
>> +
>> +        Ok(())
>> +    }
>>  }
>> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-co=
re/gsp/commands.rs
>> index c80df421702c..fb94460c451e 100644
>> --- a/drivers/gpu/nova-core/gsp/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/commands.rs
>> @@ -237,3 +237,39 @@ pub(crate) fn gpu_name(&self) -> core::result::Resu=
lt<&str, GpuNameError> {
>>  pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspSta=
ticInfoReply> {
>>      cmdq.send_command(bar, GetGspStaticInfo)
>>  }
>> +
>> +pub(crate) struct UnloadingGuestDriver {
>> +    suspend: bool,
>> +}
>
> This feels like it only makes sense to call from within the gsp module,
> so I wonder if it can be pub(super) (prolly a few others in this file
> could be too, ofc not relevant for this series).

I'll review that, we do want to limit visibility as much as possible.

>
> nit: Should this have doc comment?

Yep, I'll add that.

>
>> +
>> +impl UnloadingGuestDriver {
>> +    pub(crate) fn new(suspend: bool) -> Self {
>> +        Self { suspend }
>> +    }
>> +}
>> +
>> +impl CommandToGsp for UnloadingGuestDriver {
>> +    const FUNCTION: MsgFunction =3D MsgFunction::UnloadingGuestDriver;
>> +    type Command =3D fw::commands::UnloadingGuestDriver;
>> +    type Reply =3D UnloadingGuestDriverReply;
>> +    type InitError =3D Infallible;
>> +
>> +    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
>> +        fw::commands::UnloadingGuestDriver::new(self.suspend)
>> +    }
>> +}
>> +
>> +pub(crate) struct UnloadingGuestDriverReply;
>> +
>> +impl MessageFromGsp for UnloadingGuestDriverReply {
>> +    const FUNCTION: MsgFunction =3D MsgFunction::UnloadingGuestDriver;
>> +    type InitError =3D Infallible;
>> +    type Message =3D ();
>> +
>> +    fn read(
>> +        _msg: &Self::Message,
>> +        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
>> +    ) -> Result<Self, Self::InitError> {
>> +        Ok(UnloadingGuestDriverReply)
>> +    }
>> +}
>> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp=
/fw.rs
>> index 0c8a74f0e8ac..59b4c4883185 100644
>> --- a/drivers/gpu/nova-core/gsp/fw.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw.rs
>> @@ -278,6 +278,7 @@ pub(crate) enum MsgFunction {
>>      Nop =3D bindings::NV_VGPU_MSG_FUNCTION_NOP,
>>      SetGuestSystemInfo =3D bindings::NV_VGPU_MSG_FUNCTION_SET_GUEST_SYS=
TEM_INFO,
>>      SetRegistry =3D bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY,
>> +    UnloadingGuestDriver =3D bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_G=
UEST_DRIVER,
>> =20
>>      // Event codes
>>      GspInitDone =3D bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE,
>> @@ -322,6 +323,9 @@ fn try_from(value: u32) -> Result<MsgFunction> {
>>                  Ok(MsgFunction::SetGuestSystemInfo)
>>              }
>>              bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY =3D> Ok(MsgFunc=
tion::SetRegistry),
>> +            bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER =3D> =
{
>> +                Ok(MsgFunction::UnloadingGuestDriver)
>> +            }
>> =20
>>              // Event codes
>>              bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE =3D> Ok(MsgFuncti=
on::GspInitDone),
>> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova=
-core/gsp/fw/commands.rs
>> index db46276430be..71c8690c9322 100644
>> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
>> @@ -129,3 +129,26 @@ unsafe impl AsBytes for GspStaticConfigInfo {}
>>  // SAFETY: This struct only contains integer types for which all bit pa=
tterns
>>  // are valid.
>>  unsafe impl FromBytes for GspStaticConfigInfo {}
>> +
>> +/// Payload of the `UnloadingGuestDriver` command and message.
>> +#[repr(transparent)]
>> +#[derive(Clone, Copy, Debug, Zeroable)]
>> +pub(crate) struct UnloadingGuestDriver(bindings::rpc_unloading_guest_dr=
iver_v1F_07);
>> +
>> +impl UnloadingGuestDriver {
>> +    pub(crate) fn new(suspend: bool) -> Self {
>> +        Self(bindings::rpc_unloading_guest_driver_v1F_07 {
>> +            bInPMTransition: u8::from(suspend),
>> +            bGc6Entering: 0,
>> +            newLevel: if suspend { 3 } else { 0 },
>
> Why '3'? Is there a binding that it makes sense to use for this?

It's for suspend level 3 (suspend to RAM) if `suspend` is true, or
normal destructive unloading otherwise. OpenRM has a set of possible
values (`NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_*`) that directly
translate to the corresponding number, but at least they limit the
possible values to the valid set. I'll add an enum and the corresponding
bindings.

Thanks for the review!
