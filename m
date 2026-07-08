Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199A44B67F;
	Wed,  8 Jul 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519999; cv=fail; b=SkRVwvI+Dym8BGAWnWFVEOTru5v0APLkDgL6Wyz/U3hzf7VkNzFphsCoQpnWA8SCzzpNN49JGvjI4PBPLCTjdBN9yq/G0M3xVH1Kd//2op4p7NzW/YA3Mx9n5f4xZjHRq8xzSxUVd7Z3o+Wn8dnZrGpsY0mxoujFPORXsCbDTGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519999; c=relaxed/simple;
	bh=Q9Oz/3VC17e074Feow4UtcQqP3R3U7mehBH6/Y/6UtI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WcBWmYMpuLv777HbxUl2W7IVE/YmaYaGrQtYrdsHR0M0/XIzDYa9+GBahVGibqUWD9UGTW5knfzbZ8mg5WHJ5XWHewVYM8KyunKnDKr6w9WLKjfQ5rawwsb9zWw7bOkMU0PSFLWF+vkPjgbHwxVbGvnjGTUmfopPqgXUS3ilXGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GqUtIzV+; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GqUtIzV+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2aP/0M9LqK+3s+zPkSStzFPmeQeB3EqWrrWSKlrg87jPNS7J7hAIYVhx9pxq2PpTfpUXjOy1LZ0VTbBeWspgZk+BpUQHonmbKfQoRWUW9IBjLXe/K2nOzoZz989ylTnnnNSebUJZWLgiPD/5gsO/7ik1NCsrozmiDy8eR5BxsOM/Xyn3FFzK/nff13GcO4Zea8qBNbAJBPT+woZ0uTEotV3Uy6j7/QZtzce0cX56hgidF5Z5av0BtBh2+T6D0DADBgO9gNX05VDVinedDtDff04Uqf6lGbFtT9MqTgpHhGwghOgg4qxTtDMIhHlvlNPm5erlOCk776bSwQNHwEz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLR6NxvlQd1kuCn/m1Jev6RhPOucr2q1B4vaE1UqIaU=;
 b=LnmPKHH3Q8CZ67mkvUCE/etEaHT2cVRVopJjPF0QTKrglyJN9Sw50+fmHmt1+ThkCdNo1Q+F3VGOvmJJvxlqrJcU5d9zcLMHaWFkF7gqMCjtMNl6PHTABtld6S6mt+lK5n6l2hXkkvOic+j8+GZou6QtCPGt6ITBSQd4TypMNQydOVAls2eCkV/kiqc/yjMVjhUhJmCNvhQS7TuHPePrBScUTDqFYz4LYUYoFgjkxZvA/wmsoz59Q6/E94PIh5bIb8agBt3j4FLNjuTVukrQ7a1J8vpxM2Zt8qMPQ72QiN5l/ilzT2R0EQri4uypsc0wXmd77rLsSowKkgwgfGnE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLR6NxvlQd1kuCn/m1Jev6RhPOucr2q1B4vaE1UqIaU=;
 b=GqUtIzV+AaKsJLuBcd2FQqtQEy+ujd0S/G4GRC+bgb9hHb1i0K55kW7rq7oe5WteuLg1vk1HLhsviSJHaahdQuavgjf0GvZYYrNYUgTFuB9vnNvVrlyiHOM7UFfOngTJtqrMhWacozDxgWKFHv9Q0VIqWiviVoqAfRIbuJLuScLhL71wF/4yG7ipa/Qmfew+ol/NH2S7Ru2ixBv7fV14R1yNCOqobbWkRvL0RFGeFHYLnZ4Ru+y8a6bf2cz0MRBbW96rSK2P3GDKdVcuCMhLmxnoFdt3OhiERXKY/Eg2HK89LWS+TLD3OHOmLQukAiLStRmCBNnCZeFV368rQ8n59A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 14:13:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 14:13:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 23:13:08 +0900
Message-Id: <DJT92JKN4D9E.24W84LFKXLWDK@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: f4217523-4898-4297-7cf5-08dedcfb0b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|7416014|376014|11063799006|6133799003|56012099006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ET96G7ySQE/WUhxXN5iE4j4MJw2gmBigJkZoKRGGYRmcWQT5HfEYxoMtVWiioZd9Nq129gFEAHfOB+LvarPcbnMMGxZC12XAecn61lLN+YcYFxDbvB1uW0Bfh8MM4B/NRg9NDfh/KFn8s9qBgaD1JQFxVZ653rFxe6pWWAWJCwu/MUc5q1wl4rrs2N9cnWk6VJpP2ud0cpH2eMuup/1VD8+4INUPGYP2RO0rbgTqUpJOQs/JIVk/VduiML4nVd0HeiaRh0h68gaXyBkwN+vCTRj5gvcoNdaTPW2QWjnNusJFUk3/nhGngYSg5Xw3voi+kPdL4hTYiBMdaf4UytPeUmR2jQKNp9dqZJlY4tAfWERYbmxlMo+7lwtM8LA8yvCLkyhgjaP5NYa6f3YLMbOq0Hr6FNGh/ib9rZIUL96fk3HM90dWJVIyE4xKxK+YG0PRrIMXlriYfrWe57JLOE489+frRQXBgtJRlHuvq3Bg+R993XzVfkd0h1qXm/8HwTzag4uCKLei4ryoZGD3mEspLu9wOgpAl3iCccYfhbjVCiHZ9/KEWkHe+5jyut1ty9IUKNgYAiHzYocg1QlKbDYglYZz2SStzqdtYcF8QBoAjgzeDpAVcGJigg2pBybMXpka4/4mwJnK21fIvtrViHfHe6CMGN/bYvJvpNsb7ZzUadI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(7416014)(376014)(11063799006)(6133799003)(56012099006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFDSzNtRmJ5V2xDeHNIU2FXaHBGYThPYXh3STRqUVJDLytBV2ZTTXFyUU1O?=
 =?utf-8?B?WW80Qm9GR2pzdTM1UWdxR2EzUC9MdXBWTFV6dC9yemF1Q1UrdDRHM0xoeXdP?=
 =?utf-8?B?TG5JWGRhS2JXNTFoSHh3cVh2V1J3eTdTTTRHNzJXb0dxUGFKV0swVytRZloz?=
 =?utf-8?B?ei8wS1hYSFRNd0hFVUNFVE5lR3hRZitzWmhNQmFFSkpNUTVtRDRLRFNPWk9p?=
 =?utf-8?B?UEZST09ZTXFHWmZYaVN4cWk3VWNBYlFqQnJEUGpkMkt6UDFwUEcxbnVUNmNE?=
 =?utf-8?B?bDRmNzFFMjlYK0wvRGIzVVJNMzdvcXdSVFBiMlFJWituRUhDYWwxL1ZQaGdM?=
 =?utf-8?B?ZXNNa1diNzVKVUhCSUJsem9xem5XL2xOSEdOeE5lQWtWSUFWTGd5ZW5hWkcv?=
 =?utf-8?B?NlRZTmM4dWlpVkI1L3hkcEFHdGpsWHVVT1VOSU1naDBkM3FDOFNzSDB6dUhk?=
 =?utf-8?B?OC9XU0VjSDg1Z1hjbkRFS0FlZGtJQUhkMndkSThwa1luNEh5NmdkRGkzVXg0?=
 =?utf-8?B?MGErNHlMRFJQUXFubWFOOEFOT08weWJKbE9TeDZ2SHdHeXkxNkdGNTlTdEFX?=
 =?utf-8?B?V3Q0bUw0MVZ5NGZrYkk2TEpoYjgyaDFyRVNpNno0RHg0c3dXdTVJSTZSMkFB?=
 =?utf-8?B?ZDVOdStZL1BaemxuNG00N0Q1MFQ5cUtlNG9TdTF6YXRyQ2RWZVRKL09HelI0?=
 =?utf-8?B?dDVia2RGRWwzdGxodC9PMUdsRm9xNDRnOEMrNTlNQ2JxM1FCS1ljNEZKbWkr?=
 =?utf-8?B?Mk1GR25WK212cXlTRmpaZlVjZzQwak55MG1OZk12Zi9CRjhJcG1VUW1lN0RC?=
 =?utf-8?B?VXVqdno2UEphTjF2MVNRaGM5WnE2M2x3K1owdVZadll6UzFlME1RenpVaVBH?=
 =?utf-8?B?ZC9zdENHVFgzaGZvd3ZzbnREblRFTkNWSUtmUWxDTG81dXd5NUtkK2hHQitQ?=
 =?utf-8?B?Vk5nZEo4NGFFOFhaTG4zenBVNExnSEtuNVFzQkE0QVVsOVJ2M0xzVWcwQTh6?=
 =?utf-8?B?RVlXbXp1Q05nY1hFTTlSakp4UEFRV0huT1NpbVVLTmFmRkhqa25GeDgwaDhC?=
 =?utf-8?B?dFp6ZFNqeVU0U2t6Q1d0MC9NVXc4a3hBN3lvckVWU2Q3NmwvUGFncEh6Zk9M?=
 =?utf-8?B?Z3R0NG1takk4S0NWV1NhN3Qxdmw0S0JxZ3E4N25keEt4eDhLalpyc3kwRk5P?=
 =?utf-8?B?NFB0TXZpdkJNbnprR3c2alBqaFNnSnNsL0JvaE5oUkxYeTVsWmJMaWJYQVo2?=
 =?utf-8?B?NTRqbTFUejk3ejZUeGMwbDRNUHhQWTdlYURxT3QxZW9JbjRCY1M2MlE3VXNn?=
 =?utf-8?B?WnV5MnNlMUd2MWJCYjNhbjFNQ3p4OEQ3c2daSllSRDNJNXlmTGEwcndXNmx6?=
 =?utf-8?B?SW04UDFlbUpBeitGSTUvRklObVZmYzU5Y09Xc2lGc3h5d21vWDArWW1IakZh?=
 =?utf-8?B?UFBsbURxMkF4Z3B4eVRqSzl5aE1wZDVOdjAyWHhPSHRkT09UbUQ5UFdZc3Qr?=
 =?utf-8?B?MGx2M0N1OG1RZlM4bThzc1V3UDRBa05vQUd4RC9CcU5HaG1iQTZpZ3lpZmwz?=
 =?utf-8?B?NWJvangwZVZoVmxmTU9vemE0M0hkQndmc2J4U296NzREakdJenNXaW9adVpJ?=
 =?utf-8?B?b3NLSCswQ3BXT2tFT3BGQjRpQ1FyNWo3MFRDWmRiVGF4T0loTW1kY05rVExp?=
 =?utf-8?B?SnFKUGRmTEtpanhIMU1zTmxGYStHaHgyZEZ2a0thOEV2Tk9XUWdHc0lRRUsz?=
 =?utf-8?B?YWh0K2d2WWZTWERiRzB5YkNjK25EcXAxbld5UFN4ZkZOeFA2UWFJWkdXUk9O?=
 =?utf-8?B?YWJEMkhUeHFWR25jZHhOT0EzYlVuKzZPYk41L1NuMWpHMG10N3Y2eU50NW1q?=
 =?utf-8?B?UVN6d0VUNUJWR1NEOHFoWmlpcFFib3grUy9VWVdWaXNDLzdEV1phNjNGL0hR?=
 =?utf-8?B?RlBtcEJ4TFVMSFJ4KzJsMm1JTnFwcmhublEwT1hSUzI5b1ZmRGFmVldVSzIw?=
 =?utf-8?B?aElHM1hwcno5OWk2NUNtSHdYQUovTm5LUXp6U2JqU09rOVFqMm1lRDVvblRK?=
 =?utf-8?B?SlpXa0prb3B4c3pSSXlhY1Z2VGhjTU1XcnZkOVpYQUJYSzZsdmJJUTZQR3k5?=
 =?utf-8?B?WkduL25uNVVSVkJSajVxdGpKZ2RvRFB5UDEyeFF2UFNHUmI3Z29ZMmlJQzMy?=
 =?utf-8?B?TnZjRUJIZnBLNXI2ekxNQTRMa2hDOHRFdFpWR01heHEweHpLYXFIcVJ5NzE4?=
 =?utf-8?B?bHUwR1JqRXRlWEd2UlpwQ1hTR3g2dFkwNHdDZ2ppNkpwL0cvc1c4UDBIOUlS?=
 =?utf-8?B?Tm5ZVzR2OFRpYUluYU9OOThXaWUrSUNvNFEzbVRCNDVlRzNrTTNyeE0xK3Z0?=
 =?utf-8?Q?Ixt/m7r0BMUjqpD6sgSatozn/UrdjiL6bQly3qUl/cnOK?=
X-MS-Exchange-AntiSpam-MessageData-1: fi5qb9nkQOsVtg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4217523-4898-4297-7cf5-08dedcfb0b42
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:13:11.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc63J3FuhgcYHeASCRpfQEtOy2GHmAZTJbvU4w4vL7T4c+5bIPGxEBwja8dPK2CE/PEftoNc+yYnsarGBp46vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

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

... with an additional item for thought: in a previous revision [1], I
had raised the question of making the return type
`Option<NonZero<u16>>`, as I think it better encodes "0 if SR-IOV is not
available" - callers are then forced to consider the dichotomy of the
result, and not interpret a particular value as having a special meaning.

OTOH, for all practical purposes 0 VFs also seems to be strictly
equivalent to "SR-IOV is not available", so please take this as a
nit to consider, not a blocker.

[1] https://lore.kernel.org/rust-for-linux/DETDILPA1GFY.27WND0TEC5352@nvidi=
a.com/
