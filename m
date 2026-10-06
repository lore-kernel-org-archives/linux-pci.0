Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FF3C9EE9;
	Tue,  6 Oct 2026 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322926; cv=fail; b=V+H+Nv6a2BhIK5JWClAvdV+0Oyotyhh0WDcMRLZxC2GdKen+mC3rm3JQV7KEkFRnusjzBDD6/xSfegMZKZJSSnwCysDcvpLYfvsIzXflSqtDHRGyayugYI1Vu7de1RcFiTAJ+E1TGoui4CZyPlboBYfhWWmdAL7G35OhdzQoMvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322926; c=relaxed/simple;
	bh=3hPmAA8H6dr3A0mZY5xYjOpC21uQiaX2xDgGHXVKLl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T0nNs8g7eabed4wOZdFmXlFzINPCt5WyJJpC0u9XpK9hIA1IHyAHvbWt05iGNfNas23QWvv17j0SdKI+84YlSbTi6yJhwgabq7sJrO4zk2zM7ODF/BrhGBvqV3eqLCf9PALslAAOvQ9odls3nuzFf7YcKEscVPkGPjSTZflni9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KNBZlx+S; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KNBZlx+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rd//gvzuOvGTHlt4m4AvUlZLQtBZupsjtjwCUUKWHunLK1mhySLEADAKFNlBltRYNIYp2e7l9Z+w1GuGWm3dJYTG/9Lr7MGlh5BfOfVaThyZ/b5Ylfz/631PNm4Gb8FckRC34Ij82erZaXQMJwkMplIEIPyQv373dE2eIqcyq0Gh8+mrVkiAKt4EbQ3Ni+Y6g7Hzx73TUUQKWSDNWtoJJi6NGuawEKYZcnsOKKAP7yo4Bv72cdhXr3Bmty07yBD2lea6bFP4DDZmrCj/9gCo6/q2zYEDmicgqgkYAQ57T7Ct/ZJ0NtVoVrHIky/ueLGucf15mMvADHz/Cwk/ns7zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pytksxkxqTH2grt2d1rWoEQ4zYtdvAWDl0YakIiRR40=;
 b=bE0XIHS2QXcCDaznUtAZQffWm0GuyoIky0+eAxxW+DgZbubr0u4b1euHSQ8D+aOP5u9WHtbbAzL/r9/oRCQKcEnJJym6pEerxwI+1jZYZpazbUcn7TUOYdCtrW/tKWPdd1i7uUrMRNbn5LlPwD8G4nxGz7U9nDmgKGthfGEVp4sOCsSu63IRjUYTd5n04JzjCB5L4rFe04Hw6JuV9gme3tEEmn/rks3fmQoPkovPKVb7jbPEuUjxD4JDgOcZ8ghb0Slw4D2Go90NhnvjpDwG+ZtUZGzURoe0OqU81j1+7A6Js2aH9GoHDF6BiEyptXgBAFmUR891Vo2UxmV4U8yZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pytksxkxqTH2grt2d1rWoEQ4zYtdvAWDl0YakIiRR40=;
 b=KNBZlx+SeXfbyPySGIX3VTpXW/z+dYWK66DEefPi1NeqNwmgB2xf9IkN2lo9teEQEHLzq8EqY2cukUH6MyTFGpByKnTfsVhVl3xJ1ZNkR8YFrvVHqQJnEKlIN1/w7cEC5tfai8lZNGX20cxvCnQWg5KgEHNujsjntKR3SeVV8XuUzvMVtN/l66eizfvoBoT+mpaCbojkbaQFYodY4TxmcT5NeB89mHb8r/NOccARLc+tYhA2evY62zQ7XMGPomKrEcGISRviY4s+313Viqgcto+GQ2u6vlf7vXxKfc3MAvX/maZacnoqmoTx9r+R0of4BDfvYBrFda8qDX+zcYa7Jw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 21:41:58 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 21:41:57 +0000
Message-ID: <47f14e81-06bc-46cd-92b8-42a617694a26@nvidia.com>
Date: Tue, 6 Oct 2026 17:41:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] rust: vfio: add PCI variant driver abstractions
To: Zhi Wang <zhiw@nvidia.com>, dakr@kernel.org, acourbot@nvidia.com,
 kvm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: alex@shazbot.org, jgg@nvidia.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, jhubbard@nvidia.com, ecourtney@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
 ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, linux-kernel@vger.kernel.org, zhiwang@kernel.org,
 Boqun Feng <boqun@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 dri-devel@lists.freedesktop.org, Peter Colberg <peter@colberg.org>
References: <cover.1790764573.git.zhiw@nvidia.com>
 <0f2f28a9457330ac4264e24db8713ef5e7998742.1790764573.git.zhiw@nvidia.com>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <0f2f28a9457330ac4264e24db8713ef5e7998742.1790764573.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To CY5PR12MB6549.namprd12.prod.outlook.com
 (2603:10b6:930:43::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6549:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a065111-d006-4c71-5e89-08df23f2a503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	92hs984rhqNixvEaP1w/SklVivnKsLRaN3FSVQz/9uTctCXcncpO1QYqgv3djq1N+Am0KtgOVNkkQ0kuIClsDAXeteMOMyD8VPSN61PHtOQf54oIIKEsYE4FW5phlFoUl0rks8nev3v99387x0L49CjjkC3XUUrP5MVBXclV/G4fd9l223YaM3YmhLx4vY030+iXf6oy982dtjl4A27rPJTBGx91WtHHG1QMPcZKXoX8j8JTztdPaVofoAH9Ax2fnOZuUniqRLBIULIdrWNq0sp9zAfLWhQjesN/Ow0WKkaM929fS0669rCq8kSKXS65P4oK0hxkXCbjaj+nWDNGveS03kZFGX4ZYq4v3g+9EA0plw5ilzNd1nKQQ0/V5s9o47nLs43zKZpLNWjZWKkdENJkATKWAnMs7sDNNxbK509uI1Kt12gk+rqrV1V5q84LFXg89TbpNhOf9SPRrzh6VnNNy8cpAZ2V9xk9uantsc8rUv1fIO42S4TBfPA4Sm3+Ndau5z/Kdw72pDCTHqFOF3CdqjW9H2bnb0pAzaIhlrMGyc0udctwYxL6d3NMK4gD+kXqqxhmNY9ak39zJkFMAE/896IKUJGHLOpFwSVT7sl6ven3Y6AZHtpL0TJJmP/YN2jC2ZNvxe/IlT7RzoPgIDmF0HCojs5FoHiHt0e/02A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmZOU1lDM3RZUkRMSGE4ZC9sRWxjc2RRS01DMFpuZVoxNUpDRTl5Nkd1aGsv?=
 =?utf-8?B?TjVtd3RwVTZIWWZZVnZENCt0WWFqeDZNTHNCeCtCZi8zaTJwejg4QndteGV5?=
 =?utf-8?B?eVp2OGcvVXJ6YUdoQkxWeG9ObVZxbm5XV2lEWHVJRzI1eHhmR1U4b1hJV2JW?=
 =?utf-8?B?WVJndnpsYjN6YSsyT3NmOCtvRlBqTHlSUnAxbjc1K2JrQTN2eDZ4bVBoOW04?=
 =?utf-8?B?YzU4NzBNdTVyVWdHVkRYaFF4WFgvNWoydE92c3BZY09VOEpkRTd5a3lQdTlW?=
 =?utf-8?B?Smk4d0RjTG9pWitmL2oxdUxWUVdmYzN6RnZhVmJZOHA3NDMxTHlOemNiL1hT?=
 =?utf-8?B?Sk5CRUt2UnFxMmU2T09xU1ExdjQ5cEduZksvUldNbEp0djY2cUg2U1dEWTNQ?=
 =?utf-8?B?Q25oK3VNWnM3SmNndHBGQXF5UWhON3FsQ1ZzaXlJVkpnOVlUMXNRN2ZPQUtB?=
 =?utf-8?B?a2g0NmVYSFd5QVZuOWxYREV5MWZWNUZRUjFnMUo3ZWQ1Q1crMmpRL25XSmxX?=
 =?utf-8?B?RmxqanNiMXp4RFJwNWFudUo2SXRlemZLNGU1aEc1TUFmQUhCM0ZsN0FHb1h0?=
 =?utf-8?B?RkNoaXJCY0I0eXBUKzdSaHhKUk1uNVBwdE1TWlFQcXJ2L0NVUEl5ZEF0WWZu?=
 =?utf-8?B?VlRuZ3RuQ1NDZ05xVjBBTUVQYzVCVnZaN0oyZGhVc0FrZlp0YWJYTjlhUmxq?=
 =?utf-8?B?M2pQKzRpQlJjWUtXeWJFSWx2UjNuUzRiOENWSTIwU25qczh5STJnOGs3endI?=
 =?utf-8?B?QmlQaTVmY2ZINkdQellPMnJJV3Y4OWVUTDhjTkpMcHVvcjVINUhzVjlwNWRo?=
 =?utf-8?B?ay8raGpSNUlOMkRtSDAwcHRSeHd3WEdQZ2hKRmJZWU1ydk9sT09XdlMyaEJJ?=
 =?utf-8?B?NDg4Q3FZd2NuZnlHOExnMHFvQzE4ZEF6NzNuSW1lTjdoWTFzMGpQdXlxbXIr?=
 =?utf-8?B?Q21rZW5jR21VZWNnREp0U2RBZ1VQQzhlMjBJR0kzQ3c0TDJjUmxHRFlqODJp?=
 =?utf-8?B?NExPOHM1SmJjZnJiRGQ3ZWVRYzA0cmpBbmVTS3ROYmQrWXVsbmhrcnpwNy9x?=
 =?utf-8?B?RkVoc1lmNjMxYXo1bEdUQms2QVBGNmhPZXMyRkhoLzNLRDYxQm1BdG1ONVkx?=
 =?utf-8?B?Mi9KWnNiMEF6bzNGZDZ1ckpET0YrNTB0SFlhbHJFUW5ocTVyUDUvZHQxUUZK?=
 =?utf-8?B?WTVBdUF1RHIzdXNRT2xmUHBIeVBwR0U2ZnhsU0hmelY3eEcvUzcwMDNsV1ky?=
 =?utf-8?B?T1dFaUZ1dG9IYzArZ0lhU2RqZ0ZueXJJMUNHeEVUeUo2NEVWeVExM1krUHI5?=
 =?utf-8?B?S1VVR1U4T3hlb0FKVm5FS3FWRUZ2M0hGYWdxRjBmR0ZLSUttUVAwbWpBQXhz?=
 =?utf-8?B?NTV3cUUwa1VRclNVa0c2K2lnbzB6ZFdUclo4VVRSTzBqeC91WFRuUldLTHBl?=
 =?utf-8?B?MTlYaGc3Mm0xeW80cXB5Y0FWR3YzTHNxZzFGd1BnQUF4MEE4d29raVVJaFB0?=
 =?utf-8?B?QmV0bGNaVndXcWhxcWt1Y1hHWElFcTRFZnFKYVdkOW52OWx3NHp3TllRM1k4?=
 =?utf-8?B?U2RnTytna2R6TU9jWktzQ3lvQkN1SXhxMGdjNzQ4NjM3emZCZjJrSFloRmxs?=
 =?utf-8?B?WkhKRlphYzhkeG5iZ1hITUpQaVFzcU1ScHFxdmloNCtRQUlaNUZYQklIUmJs?=
 =?utf-8?B?MUUzMnlIUDA1czBUcUxTQVZpOHZYdmxvYUFmMVl5dWlJNmhBYThXS2NpVFZO?=
 =?utf-8?B?cnExMDVpZ2JGQ1F6VzV3VFNvMVp2ZHBHZWh0YnJYNnVzbktpUUNHejRLOWJP?=
 =?utf-8?B?YTR6OWU3MEpabFlCOVpHRUNXTW96N2w4U2llUlA0alBZNVBYVmIrUG52WTV3?=
 =?utf-8?B?MTh2Rmw2Qk0yWjNjd1R0SGZ2WnArRlJKUnovSlF6aXJydVp2L1F0S3BjVUUv?=
 =?utf-8?B?TkhPdUdqbXNzdW9HcTRlODhCQ0xQVlIvSFVzblVJeGNYY25zMndBVXBiSzha?=
 =?utf-8?B?bGJTVG1jM2RnMzkvN1RYTkhxclIwNHNuU0MxeWhYa3FYZWtZUlVDbnlFbTFW?=
 =?utf-8?B?MFVybmluVHlNcEdSa2NXbHNWa2Q0bVNtYVBuR3NjU1M4MGxQVW5IUHRaUFBH?=
 =?utf-8?B?KzRzUklwcitjWS9pdE5UMlJSR2tPc2tvZ2pDbmxQd2w4alVScERJNWdFNUxm?=
 =?utf-8?B?Yzg2R2p1OWcwWTlGa2Z5cy9NaWh5Q2JBZTRWQVV3NVE1bXJRd3VBSnhrVkZp?=
 =?utf-8?B?VExaSjlBNEFRaDVrK3g5eFRSZ1NsYUJxa1Vad29wSm5rak8xY3c1c0FXamMv?=
 =?utf-8?B?bnN4NTc5Z0ZSSGdTejFSMWZvWTBNcXJnMnRZb3NBWWN4Mks4Q3VjZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a065111-d006-4c71-5e89-08df23f2a503
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:41:57.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcRoRFxFprRHstfIGr4oSzc63UnTwgxjkpgk/tJj9EDGj3k2UGlTZzLQ22lShJJJTIBtfsNeHYhTb7k7xjglBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541

On 9/30/2026 6:57 AM, Zhi Wang wrote:

> +            bindings::vfio_pci_core_register_device(
> +                self.dev.core_device(),
> +                Some(PciCallbacks::<D>::vga_set_decode),
> +            )

Hi Zhi,

When rebase this series onto v3 of my VFIO core drvdata patch, please modify this helper with only self.dev.core_device(), the vfio core now select the VGA callback internally.

See the V3 changes here:
https://lore.kernel.org/kvm/20261005184236.1946167-1-xinmengs@nvidia.com/

> +        // SAFETY: The registered device owns its error notification state.
> +        unsafe { bindings::vfio_pci_core_aer_err_detected(reg.dev.core_device(), state) }

The AER helper now takes only a single argument which is core_device(), please drop the second argument here and in reset(done)

> +    const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
> +        runtime_suspend: Some(Self::runtime_suspend),
> +        runtime_resume: Some(Self::runtime_resume),
> +        ..pin_init::zeroed()
> +    };

please also guard the PM functions with CONFIG_PM to match VFIO core helpers

Thanks,
Simon


