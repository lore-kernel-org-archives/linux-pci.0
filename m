Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022078.outbound.protection.outlook.com [52.101.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70A3B7757;
	Fri, 19 Jun 2026 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889167; cv=fail; b=SWJWtSLrrTABPve4++4j+Ktvb2l4FUGuKCT1RS/qiljAOoH3EDuErbipdhEHD+Q/ZZJfw1fBSYQcrNTBQ9EVT7JsgN3C97ScdiWkpV6Z+2BWtOT9NOy5Y4gAEYWOLtE4w1qCA78x0FdbP6URUyAr+de1H0Ah7J+ioKfCmahWqnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889167; c=relaxed/simple;
	bh=arkVJKIiGncq0V5xzrfIDF2xC85Uy/GvDHezLIcAu0k=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jSYrRUE7dHS3C4kiIGBajA2Vum++IMFXEZqJsGbUXnc9r+RzzJ2sl/SLTqyj5DCW70vaobwP9vFHOgS/1PwY1v3bHHzL/PysQX8Y7nZeypls3NTB2TkGlKMI4V9+SjhnUnRuYd+eVmtg5Wv3sO9oRsJrPVbTukff2d/lhm8OuV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tvx/ldno; arc=fail smtp.client-ip=52.101.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="tvx/ldno"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojQVaMju1ZuAoknrcAOhHkJeS4QO7RbiLHosh6Bo2XFK/Q9FP3uHGCgQvNTsAHmlox7n2NpjZ66eEaicV36wB4amcMDS6cBIo8ZfiAOMkdYUhicSode/QEM+D4cuUfE2BUlEDh+Qywb5zpc1/Pu5WVSSMjePgpbpdhyk4Gzy2xYjlzsUsvt3z0erOWyhSI36t0Up46o+uulCseSVxrzsP9Ma+axkWrb/4Q7MdF5KMggeZGjC8U8mv+KW9FhBih+UPUcojMB6TbtdVNlFalzMEhpVPVAX0QSL9P+0Iu9wXrgj4Xp4YX+wCQ8PQJZuct4peSQ+QkDvlZu5jFvg9uR9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BHY1upK8RJDNw3uKaE3rPb44wbRJKVD6YnQi7IB5GE=;
 b=xItbpj3Sjk1ptUHDcH6+R2TvwOuI4zW1+DKkI1vFZM16VFne4eUsnTMmGKF1FVwIWyyHANmvkJo30+OdPFEEE+MMw3E5wN+6CL3i9f1i5GPeN2uFdZtxefWpRnB3kDADASW8roqTc0/4JyZUwGOTYCovuWiNWXhuf4+4BZiJOqGqUqfZwDxpS6T/zAN9BTPM570ZMDt1IIBxqV8w4IFN7aELXqwLP2zHyba2GLJNsgzjCuiBmXr6M+PvFt5SCyrisWRz+tOwXoC3xoJA6yS9JsxVDca7Cxqyb3QA63prDSE6raMeF7mOhqWN7cnGl76+UqbD/T9wrnapWUErVztd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BHY1upK8RJDNw3uKaE3rPb44wbRJKVD6YnQi7IB5GE=;
 b=tvx/ldnojh1rSoOj+kcTrx7WPZRUYdw4I6Jy+n1ON8aqpk/hPuH1p4NV/UZWGLUWT5PzpncGtG7RSsfl55l4xUBtAYPRbZa9CuhBRJ0J9+ZxEEx5XZZc6QvSqhlwoY+TKWC0JaKYfilpzJNJjeTnhA0fp2a3sn1lv0aNepyxwrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB9284.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:47d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 17:12:42 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Fri, 19 Jun 2026
 17:12:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 18:12:41 +0100
Message-Id: <DJD6ZNYG3G4M.101HSCYG8Q7HQ@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <conor+dt@kernel.org>, <robh@kernel.org>, <linux-pci@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, <ojeda@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH 07/10] rust: driver: store pointers in `DeviceId`
From: "Gary Guo" <gary@garyguo.net>
To: <sashiko-reviews@lists.linux.dev>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-7-96af1e559ef9@garyguo.net>
 <20260619170508.8E9351F00A3E@smtp.kernel.org>
In-Reply-To: <20260619170508.8E9351F00A3E@smtp.kernel.org>
X-ClientProxiedBy: LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1ba150-88fa-4624-20cf-08dece25f8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|23010399003|376014|366016|6133799003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iVqKZSQOOb+4SFH34Sgc2QXNUE3PB3245CnaBg3voZzDrLiMKRIE/1C/snCAuFwEZzQuVJ7+WxglTyGfhdZa3i8dhzhuzOJ467S4FtMleU5Kg6qxa89Z1qc5jsilRtHGLIp8BAEq8BA0ePJQ+kjgV10lU4zyZtJHlWpBcLO2/s1ALN2+EgX9Ha6wJyQ+CSae0tTJbRz7U5PfE8Iyvh+SwHsYZQVO0Dhd11a97EfuV4gjc4CFmdpi7rjN8BMqltmvJcxXtPpbwWEK3i0CSPL2cwHPYA/DxbP8Sgo68onUSVD2/2shV+Ay61LtNZQmQfpiP/HwFHx1TfwhmVRSqgRx5E06bUfrhOoo7TZjVvFQlZLum0hwxjuQ46NaOKOzNvMn8r1EDmFQAmo2gxn51h/eEXK8odxNZHzu3+q2hQZTQWJZ+fUlvf1dGsj6OKeOeGgI6dTck9vYN9IVEx4UQma0ze3+2wdpNd5WXNfbPfwDXFz4AnkQzkdaObfkg3a8Pv/6uzqyRwFD5KTzHLqBvvE+y88rpeMboXUIHhyRFFkTxwIDAgrucFrwYFTER/TGsWm0IYwrNYtj2HQiWI2K2oXG6B4aQqFbYmXHahXWm21pXVaUj5qRf5hFY97+EkcD4t7+4cj6j8xUEtJYFGeM5TTt2vLVc/5buy0CxQiVGeF5z6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(6133799003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2E2Zy9yYmtvK0Z1OG9zam96ZUxRR1dZMjBTZDZDTFVHZkJiUlI5ZVZYMk1B?=
 =?utf-8?B?Viszc0lmRVRXem11WnJCVGxiMzFEM2k1c1ZQYWpvZWlCNnB4My8zaDR3SHNQ?=
 =?utf-8?B?MldFM2IzOGlBMFJHZ3JMc1B5ZVpCMmdTWDJtckhhTStXMm45a3pqYmpZdmFs?=
 =?utf-8?B?NEJ4Y2NBakRGejlqZnhJejR2QmJ3aXloSm5CVUwzdk56WVFDMGVuRFdzUmRR?=
 =?utf-8?B?akRVeVdDTE5CSVo4dWtzMmZtbnRQTFM1V1o5clk3aWh3dEd1T3EycFVYT2M5?=
 =?utf-8?B?N2ZTSjUzenBiYlZxT0FvL3B1d2RJWG5qQXJxNGZjUzlmR2NWUXl3UmJtZ2Zw?=
 =?utf-8?B?RHkwQ1J1UUFsRzVLMVdqZWlSNnowYnJWajI5MUtsWWZtMTc0Vkh1bk44aTdq?=
 =?utf-8?B?Y1FNdS9qN3dNM1UyODBRWEl0ZzRIbXV4dm1qVUc0M2ZhRmpSQ09ubmZSYXlh?=
 =?utf-8?B?NEVTL3FzQ09LK3hCbjhCN25INmNkL2lhNW9od2dvcy9tbHIrSEFDenVnek1m?=
 =?utf-8?B?azgwR2hkNzBzQjJrb2NrRFV0RkNLQzQ4TjVmeURFOEZEUGVPQzFRVi81UHlN?=
 =?utf-8?B?UjFlQUhLaUludEFQNy9tZXJLTWdrU0pIQ2E1bmJVQlNMckJGbHF1STFrYjY3?=
 =?utf-8?B?Y25iK0FJcURUaUZMY016UElET0tuQjMwYzZvbGllbEV5K0VJMCtXWCtnclRX?=
 =?utf-8?B?aXJzengzbVFxaXR6emhOeUJqdjV3aU5MbTgwSmtIbTdZd0pkenlvdHRLdXBN?=
 =?utf-8?B?WlE3a2FVajgrYmJPeGNOVjRmbG9xVGQ2UUxUUmFuRkJCK1l1QW85dTNtbXAv?=
 =?utf-8?B?WG90ZTVGOWo1VUJsU1FCbWR2ZzZrOC9uREdvZlRwVEluL3NBcTBxd0JIdnVK?=
 =?utf-8?B?MU02cVJvMk1Ga24xdit3U2ZyV04vTFU1dUJHN2Q3NUUwOWkxTTBFQzVMenN1?=
 =?utf-8?B?cG16MFVoNlgrSlVRWHFWSmJCeWYzMjVpTDhhVUVNbXNIZENEdkRMcjdWbDI4?=
 =?utf-8?B?RjIyTmtubXVXaHZSTkFJeDVpY2N6d3Z3ZWpKMlNLeFpRUFR4RGJUNUYzZWtk?=
 =?utf-8?B?RERDQmJibkxyT01vVXVpSDQzbTFpa2p0Zi9TZWkzS1JzenpKcnY0SVgzRWhk?=
 =?utf-8?B?aXFjZEZGU0hlOG1LRVA0dmhTVU4wOWFvcVNrQjd5OWhiNTl5dUEyQkZoejNY?=
 =?utf-8?B?akZoN2E4Y1hHT21uRWp0T3ZlaEd0enVGSW5wblFRWHZuaHcxU0NPbVVYKytm?=
 =?utf-8?B?RlhQOFFrb2VJRDF0dVRocTdub2M3bnJ3UHlKenJzQzZDTUFkTkV6QnZYOW1C?=
 =?utf-8?B?dWhiaGFnNC9VZDlnRktxTlk0SFlCOVdwa1g0Z2kvNzNJTTNMU01WOVNQaGh3?=
 =?utf-8?B?Nkp3UWpPTG5sS1FSK2ZXdUJYalpYd2ZNUngyenpMUW1tcEFFZUlqNllaVGRl?=
 =?utf-8?B?UERHcllYQ2huMW40NEE3QzQ3NEdMUTAxZ2pVTDJISTFYREtia2tFQnBiaUph?=
 =?utf-8?B?VlhaMlBYWWdBbjFXamRsR1BoVUxXMzkwMmlIdGR6emlpc2tvN3pYVUx3Ynlm?=
 =?utf-8?B?TnBVaVpyck9xbU9rWkpJcExaL2gvOWNXRE44QUFrQTNFN2xJbzFac25vakZm?=
 =?utf-8?B?bnNCbk1Id01WRzBVd1p6b1FXb0YwalI2N2Y5ZE1GRnlYNS8xRjhzTjhTa1lY?=
 =?utf-8?B?TlZZYjZBSnJFTTNNSng1TWdKZDVOZzNPMEdrQzFuakZBUTVOeFNlQVNKT0xx?=
 =?utf-8?B?TFFFb0Q0VS9kU3pKMFNrbVlhOFliQVlHT1VXUlIrNlQwTFhYcXZJYWNvVlA5?=
 =?utf-8?B?ZHUvdTVrQVY0Y0J1UTMyM1ZLdGpqZUxrcmY3eWhLMlVrSmhzTFk2c3E0N0pk?=
 =?utf-8?B?RXJ0bSs3WmdXKytFckNoSkRzR1hGNEQzOEVZTUJ6aXpobjZ2UG04VlFDNWpZ?=
 =?utf-8?B?RDhKcUM2bEFsUmRFRzlkTVgxRDZuR2Vhczd6K1hwQm1jMG5tczN0Rk5CY1VW?=
 =?utf-8?B?SWdiZE1NVHJRYnJ6b3hYOUVhVzBlOERqblVzT3pRenJUSXhuYmxBcHVIQUVJ?=
 =?utf-8?B?akFZQVFTdWFuNFRlUjhlQ2NuVVdySHNMMGJCMHBTOUpSeGxXZU5NSEdYZXJZ?=
 =?utf-8?B?MjYwSTBpYjZIaHBQb3dSTDI5U2xWRkZZVFNVMndjWDRhOVVURjFWdy9ZK3FY?=
 =?utf-8?B?RkwxcVN4a1NJREVyVVhWZzZuYjZCdVpCOWpvN2w3d1VkbVdaWWI1TGU5V1F4?=
 =?utf-8?B?NmJ5c0IrQnBmcysrRXptS3JvMXZQcUltWnFsTW5YYlc3L0VtcHhiNlZUOHNZ?=
 =?utf-8?B?SXZubEErdCtNN3RKT1lRZzNzOEFCQXJrM3FXNXBvMjZQeTdMSFFGUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1ba150-88fa-4624-20cf-08dece25f8dd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 17:12:41.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1uxbWzg6liCV7irkthg92VfLNFuimNnhgxIbNuvGoO672NSIGpdI1dOdT7E/+xAJr6gnwOyFM54p+9PVBVtbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB9284

On Fri Jun 19, 2026 at 6:05 PM BST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] Arbitrary Memory Dereference / Privilege Escalation via PCI =
dynamic IDs (`new_id`)
> - [High] Undefined Behavior via unconditional null reference creation whe=
n `driver_data` is 0
> --
>
> commit 01871465d12a97f7be006ca329ebda24f458cf1e
> Author: Gary Guo <gary@garyguo.net>
>
> rust: driver: store pointers in `DeviceId`
>
> This commit changes Rust device IDs to store pointers directly in the
> driver_data field, matching the behavior of C drivers. It works around
> the limitation of missing provenance during const evaluation by wrapping
> raw IDs in MaybeUninit.
>
>> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
>> index 84852a2d9ad78..59453588df0e7 100644
>> --- a/rust/kernel/device_id.rs
>> +++ b/rust/kernel/device_id.rs
> [ ... ]
>> @@ -47,15 +50,48 @@ pub unsafe trait RawDeviceIdIndex: RawDeviceId {
>>      /// The offset (in bytes) to the context/data field in the raw devi=
ce ID.
>>      const DRIVER_DATA_OFFSET: usize;
>> =20
>> -    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of =
the [`RawDeviceIdIndex`]
>> -    /// trait.
>> -    fn index(&self) -> usize;
>> +    /// Obtain the data pointer stored inside the device ID.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `&Self` must be stored inside a `IdArray<Self, U>`.
>> +    unsafe fn info_unchecked<U>(&self) -> &'static U {
>> +        // SAFETY: By safety requirement of the trait, this is `self.dr=
iver_data as *const U` and by
>> +        // the safety requirement of the function, this is stored in `I=
dArray<Self, U>` so is
>> +        // convertible to `&'static U`.
>> +        unsafe {
>> +            core::ptr::from_ref(self)
>> +                .byte_add(Self::DRIVER_DATA_OFFSET)
>> +                .cast::<&U>()
>> +                .read()
>> +        }
>> +    }
>
> [Severity: High]
> Does this code create an unconditional null reference in Rust if the
> driver_data or driver_info field is 0?
>
> Creating a null reference is immediate undefined behavior in Rust, even f=
or
> zero-sized types. This 0 value can occur in paths like:
>
> 1. IdArray::new_without_index() leaving driver_data fields as 0.
>
> 2. When userspace adds a dynamic USB ID via the sysfs new_id interface us=
ing
> fewer than 5 fields (omitting refVendor), USB core initializes driver_inf=
o
> to 0.
>
> [ ... ]
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index a3dd48f763532..a630c7fc6a853 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
> [ ... ]
>> @@ -110,10 +110,13 @@ extern "C" fn probe_callback(
>>          // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `s=
truct pci_device_id` and
>>          // does not add additional invariants, so it's safe to transmut=
e.
>>          let id =3D unsafe { &*id.cast::<DeviceId>() };
>> -        let info =3D T::ID_TABLE.info(id.index());
>> +
>> +        // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdAr=
ray<_, T::IdInfo>` or
>> +        // `pci_device_id_any` which has 0 as driver_data.
>> +        let info =3D unsafe { id.info_unchecked_opt::<T::IdInfo>() };
>
> [Severity: Critical]
> Can this allow an arbitrary memory dereference or bypass kernel lockdown?
>
> The PCI subsystem supports dynamic IDs via the sysfs new_id interface
> (drivers/pci/pci-driver.c), which parses up to 7 arguments, the last bein=
g
> driver_data (%lx).
>
> This allows a privileged user (root) to supply an arbitrary pointer value=
.
> The code here will blindly cast this integer to an Option<&'static U> via
> info_unchecked_opt() and dereference it if non-zero, allowing arbitrary
> kernel memory access.

False positive because dyn ID requires the data to be matching one of the
existing data.

>
> [ ... ]
>> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
>> index 500b5e0ba4ea9..8aeff50117552 100644
>> --- a/rust/kernel/usb.rs
>> +++ b/rust/kernel/usb.rs
> [ ... ]
>> @@ -89,7 +89,8 @@ extern "C" fn probe_callback(
>>              // does not add additional invariants, so it's safe to tran=
smute.
>>              let id =3D unsafe { &*id.cast::<DeviceId>() };
>> =20
>> -            let info =3D T::ID_TABLE.info(id.index());
>> +            // SAFETY: `id` comes from `T::ID_TABLE` which is of type `=
IdArray<_, T::IdInfo>`.
>> +            let info =3D unsafe { id.info_unchecked::<T::IdInfo>() };
>>              let data =3D T::probe(intf, id, info);
>
> [Severity: High]
> Does this code trigger undefined behavior when the underlying USB device =
ID
> driver_info field is 0?
>
> When the id is constructed using IdArray::new_without_index() or when
> dynamically added via sysfs new_id with fewer fields, the driver_info is =
0.
> /sys/bus/
> This probe unconditionally expects a valid non-null reference and creates
> one even for 0-initialized IDs via info_unchecked().

Looks like I need to convert USB code to use `Option<&Self::IdInfo>` too, l=
ike
what I did to PCI.

Best,
Gary

