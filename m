Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC215FA81;
	Wed,  8 Jul 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521691; cv=fail; b=HgXXjya3nHzX/EZKVyiaphtLVe+mxZOK0p4cZcUuKyB6K3zEJq+U77wYqMogctqq6oLuoEs/B9TNVuDlL2yoUzBCHQjF6cQ/QCfPkkvQtHRTlcNAjgQVFOhypAMTpL4zHM2fDq9bkqf9fzTRmTfZKDbMWWmdomEkEinXZc5dNgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521691; c=relaxed/simple;
	bh=9PryjEXEKXAlLywex62SYbkvZPeeZme6bTBbHR3KFZ8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MV3aCsrbaBzef5wZy0FmGkFPUjc7P2HlRJaugABUUX+S67FeMR2k80Rqn8Ye0zgw3Fpdc6WpdLgNqZZW5YGqvC999E49HF0nBf78wseDyJpvIevWXeV0D9JWli56TAJtmTWU9vMJHrxh7z4ngn9jWHRJwALxMNR1Kgu77bfCUlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SMbBzW/7; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SMbBzW/7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh1q8JT/KsTryeYLJiZaTpde3pHYolc6pjMXd2BG9D71xg/QNKO6z4Ece0mVNL1yMvY/HeTF4/HHZBHctbb+JrFsE6zW5pXMbYarAkC+ApvxV9wLI3740Co33ifxi4E+ICtUueKpPNkNja04uh78b7X9oHTK8w5Sy8LmHoryhDrrIMFfthlVXlF1aB5pOSGfZusJLZSkJiI2PQkSlL5MUs3SIUoQgJlI4j/RBlMQJf0LxrLHE4/cz21Xwh5eXKXDG+0NAM7aCQu3/tlPvC40iVoYewRgqst5I8T04UPSZ5GAXqlv8rl5hZbdbw0W7MsozL1DnlmyfXP0xMneSDS4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhk4WbM40zqNVhEYHzOwEpuba0ev3T4zHVGsVkT/hyY=;
 b=IteHyRVXBLyUW5nOc6MiHGUCJzgjMF8CbVS+nCWX9vAp7N0mP6URFkRD+LMpr4vvNktMT4q0kLABdS/nJKjje2tUEvPYad6Z047+SMd1bIbrT6q2ovKX1RJ1izeXrSMAlA9STIMn109qfAwxR/Lcn3sVgsTwFS+4UwvWSxygTZkI5Z175zp+Ui41YHoy5127L5nl3qsbQVAjJf9NZ+aN0YOReG8wD+QtktcbsbLTf5J9POX9f9p+yVUg4k+Pt2q9xroi4v8Xmmc5v1bQi9GnUBMcNaT9Xe+az1QB8mRCO6s7Ivl8BwwEB5AmBCBKz5UImuDncj6URXNLlE5QmL/r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhk4WbM40zqNVhEYHzOwEpuba0ev3T4zHVGsVkT/hyY=;
 b=SMbBzW/7AmtPl4CmngztWZooKsIV/F0OE/7BAnNSq4NHOHgxC6XTO1L7NAh9eCE3ZaDzaLfM9nQVXtFzLAfS02w9JdTzIyV+uaUVENn3Jkgd6RQQwRXkhWx2agiVSACZbx0zUVw7UaPkMw3t8Nq8EHpXjTGyikgmfyY3MJ1MOzw8W4+zaWhLfQtRTOUJpzalSHHwSslwnDE9HW5Nt4KVdl5j1Kx+HA/0Hx2vaoqJ+ET1eh7KRiQfqwImb9jf1tjA0r8/mZ2GYQu5muLYuY7HAUtwvWQF+eBjrh9JF0Mdsg2cl0tt4AKGjqc5ZjjtcrUxErow9PVO80nSo1QMtpNZxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 14:41:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 14:41:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 23:41:20 +0900
Message-Id: <DJT9O4W3W1E2.159ZIBHJLKXF5@nvidia.com>
Cc: <dakr@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "David Laight"
 <david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] rust: pci: add sriov_get_totalvfs() helper
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260701062622.3499033-1-zhiw@nvidia.com>
 <20260701062622.3499033-3-zhiw@nvidia.com>
 <DJT8V05POUOC.1F5BQDTMHCTLF@nvidia.com>
In-Reply-To: <DJT8V05POUOC.1F5BQDTMHCTLF@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0bfa41-9d68-4bcd-b3d2-08dedcfefbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|23010399003|376014|56012099006|6133799003|22082099003|18002099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	135d0X6iEmYQJuzZ5VrmiYRVGHccMxo9WfH1jkLFmwMqHYs26uY3TtDNG+KeVXq2Fp5tHZgzHFbyQy59d12GTfVOCZOw/F3Gc3yAKRSugTcHuL/OhZSeFBn80g5P1oYG6iEiC/QEH0ApuLTZ0kHx55lsxoWbeGyYIA7DVAGhyEf5Zk+PSorYvzHGrAkqEPSWbmZcXCrxM8WFbU/k1ecS5e8GkTe7d5My90enfMWZ0MNLRxXNQhkop9wnhKa4aP/hYPWmD+2QT6RmNT6TVSJwp5Xf/ALqmdfke/jFF4zFcfXcZSMWba2UAuNSRUBAj+xXDSEfrvFAvOp+fhPWRzJ7NDSW+8/6Oyk6Pt8imDS8GifSIKQl6bm+xHfCn4oIcWeoqG40csFnCFyQCShKJFn8GZ9ShMGJu0GGxqg4r7UvQR3U8XaXi21UUkic/wqQJ8nChh79oAvCy6R3PV23rv3GG8gJNty8XprdYmaq9WJadTPD4sE51A4cl9H3sJqJIW5p9zAuf8WmSJkQlBs67VKqLklp3cycQX9y96CBFdBI+WlaW7lqOleoW9Fin9eaUo4PoY3h+64uEPdarYPTLwSftq/CdwPvpGFp3OesyGyedHtGj2scGXdhsA6OqGA/2OeZaKW2feLE6UpfSPE3PLLdBn7o1nY3tn1v45ihYuz5uMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(23010399003)(376014)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHErSzIwK0djbEtjM01HbTM3bFpTV1JsaXM1WGpTME43TEdRVWJhbWZka3Rt?=
 =?utf-8?B?bjVkRUcrZWt3K3hMQ3NVUkJRaXN0ZzFGWXVIaVlzQUZNbFFtK2MyajZ2VjZT?=
 =?utf-8?B?U1lhMnRkWXFQQVJTV2ZXTFd0UGF6UkNURkFwOHpONWkwb3dMRUdHNURJcU91?=
 =?utf-8?B?WGtZbmI4WHprcTRyMG84RDdlajA5UE42bFFmSzQ3N1lNcEJiWEtEYzg2UW5w?=
 =?utf-8?B?L1kxeVp0MXpkaUd2NXlQU3dqb21GODZTWldlT2l4dzdKNkwvNklxU3FuSjZo?=
 =?utf-8?B?SEovWm94Yk9HM1ZHbzFvbWNEUjcrYWwzMkRFMEoyMG9SNEFwZlNQRlVDbmdt?=
 =?utf-8?B?ZCtYVXMzNVI1TkVzd1VKUWVncStuMEdQOFdHN3d3MWpnVE1XdVNTQmF3SEMy?=
 =?utf-8?B?NlhYYjNlcTQ1aDhYUElxNG9aeFZvSGVBanBQTVdrWjFiK0JyR2o0V1V6eUZx?=
 =?utf-8?B?MStRaGRETXFmNzR4aEZmVE9ib3lpMjBXUk13QkpRd09BRGtrOFVoSm40V3lo?=
 =?utf-8?B?bjR2QmllaEJxSFNOTXpwaFNaWXc0SnlWRWVEdmJaaFVWT3crUjdENmVlS3pG?=
 =?utf-8?B?dlloZ29qNExnaWUraU9jeDJKMVRxYnFQR1RNdUU2QjZXQThFN0hjV3BHeXgw?=
 =?utf-8?B?V3hBRkVqVDQ0ZjhGZ3g3dW0zc0V3T1FQSnRsVDExcnl2SGRBTjFjNDAyM1BW?=
 =?utf-8?B?bjNwSnJsNjd4WFJYTXhxcVVLNU5OUkR4ODhVRGdNREs5R3FlcHJOZXYwMkJx?=
 =?utf-8?B?TVNwT3B6MFk4SnArNmtlczZ5YVhnd3JIZXpkV2V2bGQ3LzRidUhpM0QrdExU?=
 =?utf-8?B?ZkduaWsybU5YcFBKVklFYWg2UER5RTJBWnlBOTV5cXpET0w4bFpKOEhuZ0g0?=
 =?utf-8?B?Uk5KNFEvN1Z5WDFrVklGamE0V05kMCtjSmhQZzA4TVF1SjlQTmJkeGZTamNt?=
 =?utf-8?B?eGdsOFpmNW1YSU4wT0pJMGpYeE8rR0pLWnd1TUJxc09lYkhMc1VFMDZxTmRr?=
 =?utf-8?B?RWttY1VzcEcwTldYUko2RFNUQUdIQ3lNMEltcmRuckhyaHFwVm1KYlpJamdu?=
 =?utf-8?B?dC9memowcWtFL05ROG5CYXVVZVg2dTJ5VHkyUzB0UVlPQkNKN2ZlbmUwby9Q?=
 =?utf-8?B?TFVMSkg5ckVUd1EyM2pkY0J1MndxU3NDQ1NydWZMNHB2ZFRJNmJ3TDVhSkZN?=
 =?utf-8?B?Vlg2R3FSektrenRzb2h0R0h6a1NoMDhRMzdPcFpGZHhmYnNlUHZIRzRQNW9w?=
 =?utf-8?B?S3JkSUQ5b21SMEoxbFNmaFNDWTZlaVE1ZWZ3Q1RUWkJQNytVbENrQ2taZDZU?=
 =?utf-8?B?ZHg0VWVNZUVPMy9rL1VaUTBSN2llZXJrcnFUWitmREtzcmlaM0o3QjA2Z1ZH?=
 =?utf-8?B?WnRmaU5RaW9mS0pUOTErakI1cmFCMUoxZm1TM0dPRGxPTVB6STJIVXNDbmg0?=
 =?utf-8?B?Und2UXUwcGNvU3c2ZFNmYVJwY1ZUVWxCQjVIeFQ1TlBsdElzYStoTno3S2lo?=
 =?utf-8?B?ZjVpRnBsZVFYZm9ManI3NklnaDhZYkd2VWs5NTlVRk5OVW94UTdiOEpMWWxV?=
 =?utf-8?B?U1FQNzVKSWk0eVFITXRJcVBRbFg5N242YkYzdnlhdk5VYjRQZGVXTWRLRDQ4?=
 =?utf-8?B?MVFvRUtueVRxb3dCOUFuVEszVFZjeXJpL2hCWHlzRWczdDhRam1iUTZHcGlk?=
 =?utf-8?B?VkJiYmdPVFRod2J6SEE3OGJWYkFWZmdLQWs1Z2s2SFF4eEk3Ym1hYWptUkZm?=
 =?utf-8?B?NlFjK3AyRUNacjhNVTRLaGFiN2g4cDBFa1ZDYVJRVkxHZUUzdzNRQXZlWXRj?=
 =?utf-8?B?OFlUa1QvWVRrMjdSNUhXRHcwbUV5RDlVZDdRMXBIOWxVUXN2U0RIK1Nhb3pS?=
 =?utf-8?B?V0d2NXdtRHFZb0VSMlVFQXN2R1k5ci9tTlZtZE01cmo2NDJGL25LRHZuK2Jw?=
 =?utf-8?B?UTRMa2F6TmlGUENPWnZmZlh4aEJyc0FoL0NsMXhOeCtEQzM2eTBsZFdSWGFk?=
 =?utf-8?B?NVhTUGxrb0pNSGFZOGt2elprTE9URDRmcHJWMGZ0MEFLR2hWNEthQmIrSDRK?=
 =?utf-8?B?SDI2Q0VtNnZsbi9zbURQYkpadDYwNERDeUFTeWU1Tk5LMDZ4cGEwNXNINFpC?=
 =?utf-8?B?RVcrU0NCdmhXVjdIa21SVWZqK3R4NFdldGdoeCttbDFJRzhsVU9vdEpGRlZO?=
 =?utf-8?B?U2gwLzlyejBRa2V0RzhDTWFOSlI5M0k4cUdDUmxyM0tuR1VMdVluakdCdE9w?=
 =?utf-8?B?aWRuZ3o2WHp2V0dreENOS3lKNHhPa2hnaWRwdmhrM2gyU1RJWnlTaVMyZnMw?=
 =?utf-8?B?OVZ5bXkvcXFqZEVCU29vNG9UZ21wem9XWXR1UWsycFdWU1BsOWRhY3M2bXlI?=
 =?utf-8?Q?qNzQBZsD+hzQS/AfYA1mg4Z8Tp3unJ0fW/SmL3AuArk+a?=
X-MS-Exchange-AntiSpam-MessageData-1: 0KbGAPO0Sna3nw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0bfa41-9d68-4bcd-b3d2-08dedcfefbc4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:41:24.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjLZbPevQ6wNeEthQJ+EKtzF4GFry71o/HWLq8Tr0AlDvtb3y4TTokYjvuRI3sDL883FlCKR9nmozMDf9+yANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

On Wed Jul 8, 2026 at 11:03 PM JST, Alexandre Courbot wrote:
> On Wed Jul 1, 2026 at 3:26 PM JST, Zhi Wang wrote:
>> Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can query
>> how many SR-IOV VFs a device supports.
>>
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: David Laight <david.laight.linux@gmail.com>
>> Cc: Gary Guo <gary@garyguo.net>
>> Cc: linux-pci@vger.kernel.org
>> Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>  rust/kernel/pci.rs | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 5071cae6543f..21c51981c02e 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -450,6 +450,17 @@ pub fn pci_class(&self) -> Class {
>>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_de=
v`.
>>          Class::from_raw(unsafe { (*self.as_raw()).class })
>>      }
>> +
>> +    /// Returns the total number of VFs, or 0 if SR-IOV is not availabl=
e.
>> +    #[inline]
>> +    pub fn sriov_get_totalvfs(&self) -> u16 {
>> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_=
dev`.
>> +        let total_vfs =3D unsafe { bindings::pci_sriov_get_totalvfs(sel=
f.as_raw()) };
>> +
>> +        // CAST: The C helper returns `unsigned int`, but the value ori=
ginates
>> +        // from TotalVFs/driver_max_VFs, so this cast cannot truncate.
>
> nit: "from TotalVFs/driver_max_VFs (which are defined as `u16`), ..."
>
> With that,
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Sorry, need to take my tag back. :( Build is failing if `CONFIG_PCI_IOV`
is not set:

    error[E0425]: cannot find function `pci_sriov_get_totalvfs` in crate `b=
indings`
      --> ../rust/kernel/pci.rs:458:44
        |
    458 |         let total_vfs =3D unsafe { bindings::pci_sriov_get_totalv=
fs(self.as_raw()) };
        |                                            ^^^^^^^^^^^^^^^^^^^^^^=
 not found in `bindings`

Looks like you need to add a helper in `rust/helpers/pci.c` as the
inline C function used when `CONFIG_PCI_IOV` is not set can not be
invoked by Rust.
