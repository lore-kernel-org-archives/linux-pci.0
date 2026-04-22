Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3D35F60F;
	Wed, 22 Apr 2026 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854818; cv=fail; b=rJARGy2o8rEBRHGlYUhxCf9rFQ3zRLA57pCBGbP6o7q2wKtBBwu4dgaJEqmRaOQat91UgCbkIA+LVApLtRSFbS0wlIXBLGiMVvu3L9v2bQ1B1Ap9sqAZyct+tZvR88GcO/qYJeibvLxvH+rujAzrYH+iVRf6L1P3mqWBNdPiBU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854818; c=relaxed/simple;
	bh=e/LKZAbNcArdHnw2haUzZZJzS9HB9s+MmV6T7hilUoE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=dZ/+tXXVH1RtC9IUXPhRJ0JOKdgWuAbrH91nEBTIcZaBPFGjV+xqrCUqOfMHjNK4/WNilswR8yyMARlo9Ie50nW0b8wVj8HuzDaYCzZFoa6Z+n/G7G6F8CEDNb3TA/Z3z80n5DE5lnIpUTLfYEdpotIW5I/z4SISUaM8eE8rhhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AcrR8Qyf; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AcrR8Qyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqPlxGwPCYmLxo0JwnvXqTxK7ldIaNquBbeuw278DAj0X7OTTkfGdiJmrs7kU8lh/cvgjiy1lm7I+OHxtWkinxER9dwPq12zWR6mrHnrPVqJrVZXks4G9KKulsyg+t+s3Ys9gUXq6k2qfE/NmRDfAWG8J2KHnJ2gJ960HxozF+DXGMyJNY1byd2LMZjg+IFLHldGzwqBwVNyi2Q6yW6Y7KM9gZgyKhVvIprc5NACLTwj+ZWf023SFSBRue/uIci1/x+nKejjNqN9u0+jLBHfjhn0MKSVJcTn5xuZRftwX3il8BcwOIzKCt0zYaAkaNypxDDwB8TM25Y8u6nrZ2DNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnDCQHN5BFwFDqL7Jdd4gYiXRITXN6FHp/DhQESc4kA=;
 b=Na6RNDEyzNYFspwO17tkCntFyal92KmzNZ3btQMjrt8tt1uq1w/LLmD29Z0kwUCcXpzCp6yhzAlUSKS/Usf9cjhuSs/o7Le1icaNTnYRU4+E94eNBIK6974O0PDuZ13fKSj2nMTvVzDlJVgMAf6k6vsby76TPi0vPCcqiAdmzMXz15L+iXtco/iJFwMEjeece/IsnaGJMhXl5s5zS0XqPTDfqlhteXsTfkvBgqErV+gNyJXrZvsoy7dz4RTG6WF0cU1ppHf9OTQzRirwlY8CfXdd+/2zVz6DevKzX1NLLAd+L7m9j/IuO/VI7h7eteqBof55R4AUI0z+NVM3CU3e6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnDCQHN5BFwFDqL7Jdd4gYiXRITXN6FHp/DhQESc4kA=;
 b=AcrR8QyfTxZMNMFGT1Bs0NTe/ybXj9eCnrHHVUE1vjI2eL+x5MrbDQWx414DTHg1i0hBPviCYeWukf4/0UiXlWdn3kT8jJoi0+GQBEP6TZo+HeYqnYXBI/dJX6OWZxmt88Km3kHl23fpBRssVwFc+fCOX6zFFo6GhsSnQ1BwyKW+mwwV6EgFgls6aXWrrm7OAIVc3NTQE1zo6GY45Rozc9UUuk4buS/OOyLy3CPDZVcWevHZYKJoo/c1w3pG561N2SrDKFqn3YdmW373K0+gYNgnkVdZc3uc92I+reYk1+O2G3bXx6kobRMjbTWcU5zzPgQ7MiZ2zwDHCtFAMdWWBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 10:46:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 10:46:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 19:46:41 +0900
Message-Id: <DHZMGJ0XY7EM.KFGGA9SYO74Y@nvidia.com>
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
Subject: Re: [PATCH v2 5/5] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-5-2fe54963af8b@nvidia.com>
 <DHZGE2KGUBJB.3LDRIKUMDMSRN@nvidia.com>
In-Reply-To: <DHZGE2KGUBJB.3LDRIKUMDMSRN@nvidia.com>
X-ClientProxiedBy: TY4P286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 370a57be-7260-4c3f-d9a7-08dea05c732a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|10070799003|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q1MbUYFjKdAziwMFYa6dcYo/YWRWjLrG8N/oxXQNBW2EqtMvVB4zjDBEWUfAAoRLn98cDk1xbWmsNx5Ls8cHY/sjOyxUWjbOofRN4+vw84UgpNuD2MSEVPHLzkxWYuax8QX4uVFUctG8VEFufJlic9dBZaSlnWBdX2rmjqYKqR3Wlf4JkcXjj3p0Ian/7M7vajr6l0GiAUucBfAfIcCQAODlIF8K4tTYzhhL1YfB0YrtsyUsv6MfVsU8Tl942lul5nCQHxCTO2BLYtmFcHiqFXqVAMp/OBUqBUYYiuvLDEyeE3M+oZoShQdndKH/q0xYuSlacENG6g5QZoz999DTFQSM+5t0MT98F71ur+tuZuwqmsRLlFFDI8FZM0VUh7n34s5d1pHMyeNDXZMFQ2mFaYoierRuVL+feAu34yRQEno7+xfNnQ/sNZ4qxcqLnr1sLhLLBlqDodUDSBXZmUI+dHyVsnKaX9o2VXVpvqjadTwJgkVTkDRT2V6827cq1uWl3bES+pEe+9/vB5QMGrPpc0cCCusVp1IrMoEBMoBhEe2CJroenJXZNeggFn8ihoodgrnF45589gVmusqRsf+M/AKTI8KuB+otCkXxtZVX3m6vFwcdjL7V9xqn6e1MtaQUD+N1BRoLsufLm8Zv5lXG6rM6/PEBb2qCankVJ9MQSOqsbk1QZ3cPE41YX3mjOOENeFpgqjW0BgV2VUQ81qmFaTZTcm7D0+xqNXkO2dKhCUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(10070799003)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVl5Y0Q0eVBITDdodUJ4SE15M3JqenZ5aTRNRGZJR3ZvQUFhaUFjOFRMTXVO?=
 =?utf-8?B?WFVqaVg4RW9ZcTczTEdheVZwNFo1dVRvbmtWRUE1NGZOK0FBU3FWWGcxS25W?=
 =?utf-8?B?VWk0QVRnU29FQ3dQU2hGZG9QSW41enJHM1d6TUZpcUJwVWcrMWhZaHE3bkRU?=
 =?utf-8?B?WkJDcFRQa0h4VFlrbzUyN3RiRnZSYzBGb2NWOFEwdi9RSVZsR0I4aENaK1Jq?=
 =?utf-8?B?ZmkwU0NUVzU5MUhWZ1d4RHhJREVNbUtvWmNSTmQxU1NzcitIVTBIWXB0dk5o?=
 =?utf-8?B?WW1ZUVJlYmtxc3VLM1hlV0YxUEhYWGZBN0FKcUVEa0xFakEyV0ljbHF5OHEx?=
 =?utf-8?B?ZmZiUHlqb1BMdjdPNXp2c05mbnBKRVYrRjcxOGU4VjBjaDJXK0NKTElRZ2N4?=
 =?utf-8?B?ODJKZE1kUys3VmdwencyZ1hERVJQZG1rNW1FU0l5OGQwQXd3bEordUswSWEz?=
 =?utf-8?B?VkJoRXpHcHgwSmFobEJBaUVVS2ltUkozSkltNmJWeHJrdFNxVVdrd0QvUFpi?=
 =?utf-8?B?eVFhVFEyMjRuT3A1ZzhJQXc1TEJXMnNCMk1vdm9NUGVXVmJwWUYvVkEvcWxo?=
 =?utf-8?B?cHhRM0VlbUFicWZ0dnlVOXlLNWVUdmJHK2hXUUZyMDhOVGY0ZFVoYUNFWUlk?=
 =?utf-8?B?Y2l5RldDMCtwa0kwNXdESkhUekQvOFNvcjJUYUpkOEJGckI4MW5vUlQ0aUJ1?=
 =?utf-8?B?WjBVOGFvUDRweWY4OEhiR0F6Q0c1QVhPcmJGdWtXTDFsTmFXNFVSMkdGZmh4?=
 =?utf-8?B?bFNIM01VZkhTNnhsU1dKcURFb0hkdVpSaWVyWVZSbjZTOHlIVWdzRENOeHlG?=
 =?utf-8?B?Qm80cDFadnVTYmNuZVpqN1pUbEJ4T0NmVUwxdWJZTE50M0NzcEN5UVJ6U3Va?=
 =?utf-8?B?blBDa3ZVMTMyQWl4TnZ1UkpGWms1Tmt0MFo5ZStVYzcyd0ZpcFRrTlpVbjFp?=
 =?utf-8?B?dUxuVW52K0lYVkRPT2xnajk0c1hNMklZS1NnTmJoQjdHU0pyT29vb1hNd0NB?=
 =?utf-8?B?ckYwaEJMT0xoVG9pcjh6R0R2WkpnU0NMNEZxT1lWRmh5Mm9JRDZnTG5VT2xU?=
 =?utf-8?B?WkRDYlNmYk9uTHozL3lpSXRpN0poWnZCNWJhVEh4ZHpDWnBxampzZDFmVkkw?=
 =?utf-8?B?NCtzVHpIaGVJbU9DTjEvTkVSQ0pRQjJHc1hkYUl0Mlg2UkYyUVlNQUNvY0dI?=
 =?utf-8?B?VHpPMHgybnR5OGlqT0kvbHRhaG4xblp5YTcvNWlrcTJQT29XNXRVUVBZSHRn?=
 =?utf-8?B?MjBVcW5ZbktGS0hsMVhObTA0eHRzMnNSMm53am4yM3NsNkhUOXc1Y0M1ZG10?=
 =?utf-8?B?WlhmbDduNGtMbFBibFdxN0JyY2RkWktzWG1hN1ZjVERxT09KM2NqYzBvSWJx?=
 =?utf-8?B?SVJUbGpFdUtnc3dNL2t3YmY3RjF3L1VoNFpTOWJ2QmsrVHgyTXMrbEtFa1dz?=
 =?utf-8?B?Wmk5bTNaWE9uM29aUVVXTEVmR1R2SVdoMlU1WWh3dFVSSDdIczlMU3ZhYVJF?=
 =?utf-8?B?VW1OdlkwWGRMZldQNkpMaDV2UFI2bExIYmxtUmRLdUI1cnZqL3lxSmZSZ3l0?=
 =?utf-8?B?bm1iTHNBWVEzMXI4U3k3OW1jaEQxTEZkcG40ODNiNUovdjFIMzRwUWMwZHJ0?=
 =?utf-8?B?ZDNzYmg4Y0piRHZXZHZMbEc5YWFoODMxLzc2ZUtVM2haU2RLdEtuSmEvaWdQ?=
 =?utf-8?B?RjhUNzVyNnBZenRLUEs0OVlkWlhlNzNwdzdSYm42b1hsbTU5TVJnbDVpOGFk?=
 =?utf-8?B?MG5EZ2ZCdFhQZzNxNDM1cUI2a2FrWGFMREFldEpWcGxRMjBCbnpIZDJyTEo1?=
 =?utf-8?B?cFZ3QmI1dVpjNjd1Q00vWUREcFc3K1JmOTNreGNxSDh0bXU0bm5LUGVXYzBQ?=
 =?utf-8?B?Sit5a25DNjB5bDdoQVN6L3dieElkbGpFREt0enZJUEw3UFlDWTRMNWE2LzFR?=
 =?utf-8?B?NDlQYXMvRVlGTlJvcVA2Z0hMajVaUkpHZkNQcmFwMFNCNjBkL252ZVZoRWNP?=
 =?utf-8?B?RHh5cmZ5SE5lT3c2VS93c0VtcmhWMURqckh3V0RvOUYwWnBTOHdYT2RVa3J6?=
 =?utf-8?B?UWJWZjNDUy9pWWtRNlRXSCtIYVd2eVFVQ1dRSkVWSEtKdGtacnRTSEVuamRQ?=
 =?utf-8?B?THhaR2xldEVjaUM1ZG5EaVhvelAwUUpuWnJxREtEZlE0dXVMNnRaaUM4VzFy?=
 =?utf-8?B?NnZNNy9GamUvNUVESCtodGhMbkFmZDdnL25PTkJMSHMxd1dyalI2WDdBVDZT?=
 =?utf-8?B?c2s4OG1QakttUHB1dFYrODdFcHRoOENZNDdaSUUrNW9iUnlnSUNDSUF6T0ZC?=
 =?utf-8?B?UVB5bkM1RE8xR05yaTNaMmNraDFvcVpzZTF5UnEwMHgrRUx3RHB0K2NvWEd2?=
 =?utf-8?Q?xSfSKQ7j7wRWgcde4hnRkIU1JQtbGbaFcaVidv2E0N3bG?=
X-MS-Exchange-AntiSpam-MessageData-1: +tlDVOUc1Na6VA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370a57be-7260-4c3f-d9a7-08dea05c732a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:46:46.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B6xLj3RlLvZSToxvNS5aS71QeRpMxKpmgJbDzvxGSgn/okbfD5gZrVoyuAX7cuNBssE1u0AyhnRXsBLltpBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

On Wed Apr 22, 2026 at 3:01 PM JST, Eliot Courtney wrote:
> On Tue Apr 21, 2026 at 3:16 PM JST, Alexandre Courbot wrote:
>> When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
>> memory region to store the GSP firmware, and the Booter Loader loads and
>> starts that firmware into the GSP, making it run in RISC-V mode.
>>
>> These operations need to be reverted upon unloading, particularly the
>> WPR2 secure region creation, as its presence prevents the driver from
>> subsequently probing.
>>
>> Thus, load and run the Booter Unloader and FWSEC-SB firmwares at unbind
>> time to put the GPU into a state where it can be probed again.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/firmware/booter.rs |  1 -
>>  drivers/gpu/nova-core/firmware/fwsec.rs  |  1 -
>>  drivers/gpu/nova-core/gpu.rs             |  8 +++++-
>>  drivers/gpu/nova-core/gsp/boot.rs        | 43 +++++++++++++++++++++++++=
+++++++
>>  drivers/gpu/nova-core/regs.rs            |  5 ++++
>>  5 files changed, 55 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova=
-core/firmware/booter.rs
>> index de2a4536b532..771b018ba580 100644
>> --- a/drivers/gpu/nova-core/firmware/booter.rs
>> +++ b/drivers/gpu/nova-core/firmware/booter.rs
>> @@ -280,7 +280,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
>>  #[derive(Copy, Clone, Debug, PartialEq)]
>>  pub(crate) enum BooterKind {
>>      Loader,
>> -    #[expect(unused)]
>>      Unloader,
>>  }
>> =20
>> diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-=
core/firmware/fwsec.rs
>> index 8810cb49db67..4108f28cd338 100644
>> --- a/drivers/gpu/nova-core/firmware/fwsec.rs
>> +++ b/drivers/gpu/nova-core/firmware/fwsec.rs
>> @@ -144,7 +144,6 @@ pub(crate) enum FwsecCommand {
>>      /// image into it.
>>      Frts { frts_addr: u64, frts_size: u64 },
>>      /// Asks [`FwsecFirmware`] to load pre-OS apps on the PMU.
>> -    #[expect(dead_code)]
>>      Sb,
>>  }
>> =20
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index 8f2ae9e8a519..37d0e4587ed3 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -286,7 +286,13 @@ pub(crate) fn unbind(&self, dev: &device::Device<de=
vice::Core>) {
>>              return;
>>          };
>> =20
>> -        let _ =3D kernel::warn_on_err!(self.gsp.unload(dev, bar, &self.=
gsp_falcon));
>> +        let _ =3D kernel::warn_on_err!(self.gsp.unload(
>> +            dev,
>> +            bar,
>> +            self.spec.chipset,
>> +            &self.gsp_falcon,
>> +            &self.sec2_falcon,
>> +        ));
>> =20
>>          self.sysmem_flush.unregister(bar);
>>      }
>> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/g=
sp/boot.rs
>> index 3f4e99b2497b..e00cfebe5d11 100644
>> --- a/drivers/gpu/nova-core/gsp/boot.rs
>> +++ b/drivers/gpu/nova-core/gsp/boot.rs
>> @@ -267,7 +267,9 @@ pub(crate) fn unload(
>>          &self,
>>          dev: &device::Device<device::Bound>,
>>          bar: &Bar0,
>> +        chipset: Chipset,
>>          gsp_falcon: &Falcon<Gsp>,
>> +        sec2_falcon: &Falcon<Sec2>,
>>      ) -> Result {
>>          // Shut down the GSP.
>> =20
>> @@ -275,6 +277,47 @@ pub(crate) fn unload(
>>              .inspect_err(|e| dev_err!(dev, "unload guest driver failed:=
 {:?}", e))?;
>>          dev_dbg!(dev, "GSP shut down\n");
>> =20
>> +        // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
>> +
>> +        let bios =3D Vbios::new(dev, bar)?;
>> +        let fwsec_sb =3D FwsecFirmware::new(dev, gsp_falcon, bar, &bios=
, FwsecCommand::Sb)?;
>> +
>> +        if chipset.needs_fwsec_bootloader() {
>> +            let fwsec_sb_bl =3D FwsecFirmwareWithBl::new(fwsec_sb, dev,=
 chipset)?;
>> +            // Load and run the bootloader, which will load FWSEC-SB an=
d run it.
>> +            fwsec_sb_bl.run(dev, gsp_falcon, bar)?;
>> +        } else {
>> +            // Load and run FWSEC-SB directly.
>> +            fwsec_sb.run(dev, gsp_falcon, bar)?;
>> +        }
>> +        dev_dbg!(dev, "FWSEC SB completed\n");
>> +
>> +        // Remove WPR2 region if set.
>> +
>> +        let wpr2_hi =3D bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
>> +        if wpr2_hi.is_wpr2_set() {
>> +            let booter_unloader =3D BooterFirmware::new(
>> +                dev,
>> +                BooterKind::Unloader,
>> +                chipset,
>> +                FIRMWARE_VERSION,
>> +                sec2_falcon,
>> +                bar,
>> +            )?;
>> +
>> +            sec2_falcon.reset(bar)?;
>> +            sec2_falcon.load(dev, bar, &booter_unloader)?;
>> +            let _ =3D sec2_falcon.boot(bar, Some(0xff), Some(0xff))?;
>
> What about a named constant if you can think of a good name for 0xff or
> a comment explaining why we need to write 0xff into the two mailboxes?
> Presumably we don't care about the return value here since we check
> success using the register read below.

OpenRM also does directly use `0xff`. These appear to be sentinel
values, as Booter Unloader is supposed to return an exit status in
`mbox0`. So if the value of `mbox0` has changed, this means that Booter
has indeed run.

Let me add a constant to actually carry that intent through its name,
and also add the missing check that the `mbox0` value has changed upon
return.

Also the sentinel value is only useful for mbox0, so let's skip it for
mbox1.

>
> Thanks for working on this, this will be a great help for avoiding
> reboots during development (since pcie reset sometimes has issues).

Yes, and this only happens on Blackwell, which you have kindly covered!
:) Which is the whole reason for sending this patchset now, so thanks to
you!
