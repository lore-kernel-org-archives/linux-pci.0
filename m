Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6973343885;
	Wed,  2 Sep 2026 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314789; cv=fail; b=bbvazsDsaEN8VPLFa+11F0UMmi1QQKgHFvPdnmaX6IqqqtlqEDTJd8+COAmBpuQcxPmh/J0oMRzYg0OnpDBuXTbtWfH1+ELZdcECZr9tHfl6VWOgFYgnW2GfdSVf7S3zoI1lVmzVdISEthqkNnMi1cs1nu5R8MfBuNjN5eoj3Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314789; c=relaxed/simple;
	bh=y40GZ2yL6CakBUKs0pyp55BdmAf4azP0emTIoxIrh6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=npDBjFCeH3xreMd/JixmAf7KpqvBxQMyW8vsbfZPbZp+lZ4MciFWqFLMK8dj1HYcBWkpHx5xZSa1axKy1ZU8JlXzyGOXyVXDPG6huBBjvZX5gP4ZZJjNplXn5p6zEGaKOFmNfSY+THmducqFrM4HtnyTNdJg1QHsfP7VH+sxscA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjX/+Odc; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjX/+Odc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdIfdZPN4zoFudNh0j/uonDbSYVR2HymHkgm/hYsQ51oU1mBSK5BC8/sdvxi2JuwBikJ/YZoslOn1qbv8rJOBiALP2JcifFP7za+6jS6qPKGqKMuO4Z43KecCzblAqXFZK+ZBYeiNz+9zGBa/Q6rUqV8AONPfCrMVXo9yys/8iZHSaVxT0Ircz5nz2rnmUDum9fsed2BzohZC81uQD21CaVuduow4Eou2slQeIZLFwbECp7Ukx76I39w38j/ZuUk5fFJiV20lBe7P9MgcgyXa5iDbrtN39RtSc/i11C9EUIlEfrisXyEHK4tY86TT6+6vjplWm73MFsoRPnoFO+iTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDL8KdAjBE+4ZP9plVrAohc6IfPvGJHZXiPrS2QvEnY=;
 b=GO03K2reu2ehdsGQY6A4lSzwFMBQlvc/gK4ANJHecTG3wk/dEsso+F1o5ONsDf7ZoK2SZiEcOH8jGsTSmOYajiqCcQK4wQ3tD6A0s4HpVocKaOaUdfghjMqsW4ieFCwtDLaHUX5sBEPVBCKLaykvu4GqUXwexCgKKglVWq7YDXNBgOCQ1Bc+J0BWng8NOotgf6oiYKK8SCF933qZBvXTNpfkDoeoL/mC+g3R0s5s/hQrYpTyd6zNvOag2qxlR+M8nODx2cVuO/IPJA8MXCSvYlGBNSZRvHieOwygKAQCI3uKDasyDks5mS6GcFeVImnVQOEv7knQ5jk0gie8bWsK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDL8KdAjBE+4ZP9plVrAohc6IfPvGJHZXiPrS2QvEnY=;
 b=mjX/+Odc9tTv88NIbbuWhAPKdv7VxdCV492XmUx3yI/pVFHM/+fOsyx0oAqHfoVaYA6TxWXFTgxfWcrMZP3dwf0hFpXVsrlKBuKIZgIkf6YZcq7F76CCvsIPZz0YLhufEfv0iPUoTqlySsHcSbFYx0nHWmt8TYG/SEoBafnz4PN8Fqw7dg0I/kuM5e8UHX15kS+ssOKFRIv3m5g0MSXhF6PnSfqMqNX8FsL7gvpUMcwUsWQubIbSfGcfi8M+gVeLxR/VBXutqi4dd3mCD4Mt/T+8GxiFSPA1al971po+s/5EAyenZJuWMweWcxn7queyx3BWuH0HgkjOttFG9i5iSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:06:17 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:06:17 +0000
Message-ID: <cc6ac9e0-8f2b-4e4f-bb9f-3badd46e9499@nvidia.com>
Date: Tue, 1 Sep 2026 19:06:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/12] cxl: Share HDM decoder decode logic
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-4-smadhavan@nvidia.com>
 <37454d24-5a79-4162-95ba-74ec709a2c11@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <37454d24-5a79-4162-95ba-74ec709a2c11@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:a03:331::19) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 989872af-2877-489e-7b9f-08df0896c5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|921020|22082099003|10067099003|4143699003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	02vrEwSOv/iXrzO1Y9MHLHlgykPLYMRfIzyrJbXcEDtaELTDjH8qI9Q82zFjrUt3H2GK53/+TUY1ft6WLgt20TmSGXYeneEU6nnbowSbfQxhSvrz6zvUBDvQ4QWVl+5w4JLlJf8ps8yOfHx97FOfuZxtpbSvBRhtyVp6QrkEySI8xs075IfNYsVS7zDTuO4n9lEXxukkjFulIj64TISSUQHL1aI5QdenOMqIk4vFkytm07eoeusV7m76498u4it3+Zn+5BUFnTw9WBn8b60M5iYcVB+wMyTZ+ZsAx43dFN71SH4D6ZmmbMT0B+5nWjbHr9k3jJxLkyXemgKZ+EZBcvBVanWZWSMtLK98Mbb2zPgXYGTVdkSVw6rTbaV8TVz3mGyR6CQ6ok5nghy11ioD3tWfkwaUgyhbBrB1xtM4nmG36w0Ny+gvu2OD87hD+ZEo0yLjsHahGgRD/YGixNTyb62dDGXSL54jMMixlG7RJY8/t5qcouI+0KPsPcve4cutmLstDsc68GjSHk/Y/luJzAddZ6kkWDLaJG5+ZEvQ+Ui8dLizkgtpXi2P76jUnVI57pk2c/drKEgBqcmoySe6XmT6P5iZ+9xpSraI2/zU7UTnty2AaxgcNH/hJcrdqAtoa2/gJASy6TA00jl13Zj4c32ta1dEMK5t2R/oxJFeYxEIGkNt4XvPRv3U7yNtnLr3nLuZkF0tZlmrMUJ1NGuHbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(921020)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzJVM2sxdTF2RXA1T0pRRUxhTGx5clZOUCtKSjBZaSt1STNxaFZlWWVUU1pC?=
 =?utf-8?B?UG5IWndBbmppdzFHbWRFa0dUZldadjFxTU9wQWQ2QTBlWEFmZi9xSythbUd5?=
 =?utf-8?B?VHJ1Z1FhRkFxeDdzWm1yVEtsUEFLNEk3QTVVK2JhY3dlaGgrVGE5T1NBS05j?=
 =?utf-8?B?dE85SFZoZUovZVBjVGFIYzc5V1h5ek54YTFnalhZcUJrVHJjWDBPZ2h2b0xp?=
 =?utf-8?B?bWVLamgwTFJLQVh6THQzaUszZmhDZjBBTDQ0am1UTS96UENUb0IwbEwyR01w?=
 =?utf-8?B?TW82U09GSWpXSHgweVd1TjhXNmcwWVFWS1RlbkVnVG5CVDRVcjdwalgxdFhF?=
 =?utf-8?B?WFlCaGVQaGgwUm1xaVhyeEZvV0U2dDd5VHNuTjlzMkd0UFRoNlRaT3ZrelN1?=
 =?utf-8?B?YTlaZlVXN1V4UG81bUlsUEYxekJvSFdXZHdVS2Z5TG5GalFQS09iS0hsRXBz?=
 =?utf-8?B?MkxqSHRjc3hNS3dDb1h5VTBzeS8yRVVQNndBL2l2OGJPdnpmSThqZVpLakgx?=
 =?utf-8?B?dTI0eXdaVm5FZ3UvMWk4Mm1BL2N0T252MXJZQm9yNm5SMEF4S1ZkeWlsclk4?=
 =?utf-8?B?ekZ2eGFKNFdSSGI5OUtBc0xRRXNlUUY2T1hFZFFSMVhCS3ErejBqM1o1S2ZY?=
 =?utf-8?B?TVgzTFZLcUlsSzRUbGZCQllJK1lPL25GVW1WUlBwWmlRT0ZXTTBQVzdVNHlM?=
 =?utf-8?B?VG4vZmxLS3FwVEtTZFJzR2VUTlYxa05oZkRkaXB5RURsQ1RPZkVzM0tMTVIv?=
 =?utf-8?B?aWQ2c002Sy9HU0s5aTlKNkhKcGZQVm1MRUIrMkpNWGlpNGpWakh0eTZzMHhS?=
 =?utf-8?B?U2dBTmNzaGx4L2RaREJ3bnFQdFBjbkhzajlKYkxOWjFMdmc2M210UGpnbXhZ?=
 =?utf-8?B?MXc1ZFlDL09CSXVEUUVveVFJOERjbVdITjBrWkNYdk8rNUI3cEdFNmpsUWpM?=
 =?utf-8?B?WkQwV1NVSGZJbVRBSWc5a09lS2J1K2JKSEl2QlJyMHhOV0JGc0JvUGhEai9u?=
 =?utf-8?B?SSs5T0U3aExhT0lBN3FiQmhlR2YrLzVtcVBQUkZVZWd2TmEvdjErTllrdE1r?=
 =?utf-8?B?T2dPK01PUTA5RDhleFpNdzFweStlSzFQZUlQRlYweTdUQkprVEJxWWIvZzNM?=
 =?utf-8?B?Ykx3amNId0dUN3NqbVVZZWY2L1NHTEdWVTczdUFwdzFtYVA1N2pTM2VtOE90?=
 =?utf-8?B?blhPUnlhMlBsOGNzY0FHK21wRWsrdVpyUTZ5blhkRzVFUnM3VzFsT2xiN2Vr?=
 =?utf-8?B?cUNUR0tlWGpVQjhORXR4eFc5VmRSbE81TjJncHRWblBHRHZXc2oxUTNYem16?=
 =?utf-8?B?V0RjaVFEL3Q3VTVjckRKNVpFbytrQk9UMkVPVTBTY3NlSmNHenE2cENRakRw?=
 =?utf-8?B?dUhLS3BudW9SK0YrMTNJSjFpcjNadWFCYTIxOHZuc3NaRmwxb0tSTTBKTE1O?=
 =?utf-8?B?UUVoWW1JVGRuYWhQdm9Gc08vQzlyUWpQTVJmcFkrUGphTzFyTGZ0dEJPZnBh?=
 =?utf-8?B?a1NtendNcnZUeU9TZjZPdGQ4RFZhbVVJQlNMYXN2dkJsQW5vSWVSS2JFWEVm?=
 =?utf-8?B?SWtoOUtsbytvQlhPdCtOTkgzc0hsMWowN1FOcXdOd040MDBiUVZuRk9OTzUw?=
 =?utf-8?B?TFlaMFZLSEFYSTBhWEdYdEY2NGFnNWpmQVRKQlJVbkFiYlFHMTdZV2FBVHZl?=
 =?utf-8?B?VkhqbU5KNloyMFdlREo4RzZRREh5blJENmtDNVQ3WW43dEtXQ1Y5UHBIaEFY?=
 =?utf-8?B?aUE2MVJVZXhNMFVBRzFTampKZ2thbGpGbzZweWdRTnloRGxNYWRGT2Y0MzBt?=
 =?utf-8?B?RjVKRkhuOWd5NmdObFNZQ3ZrQUhqaDBJbHJ6Vkwwdi9SNEdUWlpWUGZ6Q1ho?=
 =?utf-8?B?ajM4YVFpWjl5cWczZzJkdmcreHdjOWdhK3dpeUJ1dzZwZ3AvakpaRjZTcWpK?=
 =?utf-8?B?TmlyeWZYdkd3VjZoQ3pSK3EvRGdlN0N6NHFEVkZLS1RTZUJsLzBKWDRleEU5?=
 =?utf-8?B?Z0pVY1dJZWhhVHp6d2Fsc044dElkaW0wSHZCNDNJUDM2aHFsUlB4Uy8wa3VX?=
 =?utf-8?B?QkYwNk5RNEs1RWxYenpwTXhZTnBYVzhmdkhHTGRsb1RPNjVobklzdzFtaXd4?=
 =?utf-8?B?OGdjSlVJL0JoRktrVDE0WUNmNEtwNkVuSTdaTWY1MzBDMDFpek5RQjdDKzZ4?=
 =?utf-8?B?WVJKazhmZkgvekVSZitIMDk0dGx4d05sTmZRcXNmcUp3OGhYd3ZySytISm9U?=
 =?utf-8?B?QmMxZWY4Rm9FL3hCc2ZCd09wSmdldHBpQVhmaWw4NjFUY25aNDdEKzI3VXk4?=
 =?utf-8?B?TCtSV09MQkpOWjYvU1YwdnN6K1lrL1FFOEk3aTBzNGFSaUVTNGhXZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989872af-2877-489e-7b9f-08df0896c5f7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:06:17.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OPUghP+oj0y/HzcV5mYQUxDMcfegP7ucHkv8FrVWEnhRVCboDtrRXiaP22Bp1fVzar5Yh+F9XnxntTBrTP2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

On 8/20/26 4:25 PM, Dave Jiang wrote:
> I'm concerned about here modifying cxled->skip without the DPA write lock. Should it be:
>          skip = settings.target_or_skip;
> 
> And leave modification of cxled->skip to exclusively with devm_cxl_dpa_reserve()?
> 
> Also this change isn't mentioned by the commit log.
> 
> DJ
Thank you, addressed in v11.

   - Changed the decoder-count check to return bool and renamed the 
internal and wrapper helpers to __cxl_pci_hdm_decoder_count_match() and 
cxl_pci_hdm_decoder_count_match().
   - Renamed the switch helper to cxl_switch_get_target_list().
   - Renamed the cache update helper to cxl_hdm_save_decoder_info().
   - Initialize the settings ID before the enabled-decoder check, 
removing the multi-line else.
   - Added a lock assertion to cxl_decoder_snapshot() using a 
lockdep_assert_held().

   After the refactor, the snapshot and switch-target changes now appear 
in patch 1. The PCI HDM cache updates remain in patch 4.

-- 
Regards,
Srirangan
