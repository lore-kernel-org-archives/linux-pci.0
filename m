Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD838B7B4;
	Mon, 24 Aug 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570052; cv=fail; b=riWFRYul/rSMHhbWgzCFVcQKcEhUgYuRSf1dG+hgMELADsoHun5tslJBhUnID/j4nnhDR7BwgZW1z7oDC9DTSTxK+YasehGPVjfGocFNsXVVUhTbIT8FYNTdMoyBk67+WE8Zybh10ruxcNrI0wXTyfIgAGB1k5oLvhozgGzGD6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570052; c=relaxed/simple;
	bh=1XZtQPRL91/vzUxBvZwta9ocrxqrIYbz1jFhL4aa7ho=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=oQeH6NYaHG2pTSzuDylocK+thkiDQGWLlOWnEwF4sDPRin8tbIZMRIMRZu7qi0jw5m3qW+ixZuwF3djff21s1c2mygttoCgiodxHO5T3eV7mxqmp0kxU+CHZjmTDpE/mDo5M5jjRCKomcOceQT1N8GJvtNl0I5wgtfQo4XAJp5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S9zQxgqh; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S9zQxgqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKs1+t8fIdP8GhL9L8e6f9zjApVrpW2K4P01Q6uXRnpI2PgHWqPga7TnLeXFVOrUk3vXPTSUlkvlkD5glv/7n8Aibml70ewUU7i6arLSk17kB9v7zSokVmIosmUkDe2Qns4oXwxycBc1yR1bdRdZ1lUGsLys205L2krUCFF2Gsax0QZjIjARBQPe2zlfYTj2sa9aOyYhhVg/RULmAvYAYWw6Q+iBpISDzCUYfCH3xlRKLTD9W37G8ZjFK0B9L7+VeK5izk4/BbqjClsrzLhxG8Nt10iIBFfrS0Ilm63LUZ3dgPvrmQOzKAqDONjsK237uKMIuT//sEFiqYHbqfzovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yneOwXftQbPrMXtkkVx+5jS859Z5IcpqueVUJ1sSDHM=;
 b=uxxQMfOw7G1jBMaZCegLYk18e3k+NZwZApsnUYWKlakRzv1CUC/SUd3MzEMaQ2WnpN38SfQ7KtWMTB71gaPtEEXtGWi3oqgX6RwJtixlGS/J7LnOSjzkb0k4yyY73fs5rO7+Bl/3V0k1g54cMdcEBq21eHQNI0O6zBjSBe8CD6lTdg/PHjePT0/XVX7Z8CDyF0LoS0lPBTf7htO/zw/ICaID8ba/I2Ph1hyavtBxPFL0fMY1ccpjdzWzYr0bPhZfu2w0a0VpC5Mi1K1T6306swTRIrWF0XsfiNX5QOPg0FFsdZ4RAI8X6rVsT2+SJRjeGosLd3y3haz6UuAaSEhD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yneOwXftQbPrMXtkkVx+5jS859Z5IcpqueVUJ1sSDHM=;
 b=S9zQxgqhRNyl68fKm9a9M0L00cVi1p1w+09ekZchdAFIRfPDdkpT8RWLa1Hi6ahsV0V5zqf2wQudYig/YIATdYP7HIfAcfwM8D9gsMRjfYaMm4fAB0FzO5VJWj6SZP+D+LxdNJSq7g5EMOx+CAus9bkvwBOvMqX0LvJBk88sF6XwINZmyVFUhFumHMBs3TRyi6GimFaBYI/ncmZgG9m/3WP9jjwiryyo1KOigKWysBZqMHObnGlUxKs0JYaFEQjFWvqTAz4TSCqn9NTauPtfX6rBTwvjSkdnoaEw1dx51RiGohlO7sNkj1Pk4Ws1jCKeI3tq8SPiG0cv81kcidwIlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:14:04 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Mon, 24 Aug 2026
 11:14:04 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 20:14:01 +0900
Message-Id: <DKX4P05VHT0E.2O8M39SOVBVP2@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
 <DKX45Q1J5M9O.27TM3TUTQH761@garyguo.net>
In-Reply-To: <DKX45Q1J5M9O.27TM3TUTQH761@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:378::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ed34a1-ea3b-4c69-b4fb-08df01d0ce72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10070799003|22082099003|18002099003|11063799006|6133799003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wSHcogze9Viob6Dafzw+Fr2eRaXUOALx5CcdNtdruwTew6YZWvuNFVvir23M660OA1aXGZUzI6xMX1ZxgkMzf+6CghOqHmNbhBTQdo0XxkVbSopmfGztpmuJxX3hAkWsGhJ7oWwSs/GQkLgunkR96LOIc2mBcDRpxM54WUJ9kv7cllOzjLUrCJd2YqXg8mp/WSyO30j7ARqbdsD6X59s7osRrJqhdviiJ+7ArAUK9n8sL8ENgHPubMbefoFki2nJO4SAMUxbMf0D+qQQ3bMCrK9InSChyi5FoKF+5kPvC0emfb57mMKM2i9f2CiGLr63njmWKTchCNeSARI73irjL6AwrNCs8UBuC04l6ro/nTlhmu3a9UtVqk/xy+iRsLlU8NbhzhodCsvZMwxtgE4M2qoAPaKwZxXAULu5MH7+/b6SOzjpH5CZ8SDmjBsUUGdNITLbXZBagS0FFImK0pqzr1htKtzPTmJ+j26/8PEB7C7kKVuDZXfpRjacGSeBzc06exFVyc7xOplze9YvohiadhS8St7yOgzGeJeaTBvyQqqfa878OFsW8ZkiMRNG9Ca512r1Ts2Q+8XnPgVz71DYjYHcyzYuDl3igPOsbvoskgniH+UF/0gtSYtxdgb/cXq1efm1v/CC1/FeAUBUx9YFUBlqRosN8S9EfgqzgfUhWR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkxsM2wwc3dDTUJuZGcyazhvQWt0V05LMTRVK0tCK1FsVjZoTGx0WjNmQitw?=
 =?utf-8?B?NzlYUG40RFYvVWZnOE9uTGZjT25SZWlFRVdka3ZBOEp2UG5sMUhDb2IxZnUx?=
 =?utf-8?B?VFZNQktnbWtjZTZkQ3pPSFpjc0VQb2VYOUQ2cFV4WGRLSk1ocE0wcHEyRnlZ?=
 =?utf-8?B?bkJDMnE3bVBrdEF3dDEydUNJVHNQVThJQTVtSlJGSm1iN081Rm9BZUVwUUZy?=
 =?utf-8?B?VU5PR2Rud1VFMXpXVHM5LzdUbHQzZEtKOFVMK25ibWRrY0NFWU1yL2o1bVB2?=
 =?utf-8?B?TGRYYkNwMzZ4aUgvVzIybFgwVGJJZUJkbGN0R1hiWjk2VVBZTVdiQUtoTU5H?=
 =?utf-8?B?aEhtdzRzcWtPeEFwTVVNZDhDSEVaNlZxSEZoNmtRUld4SDhGV2UzNGEzdUw4?=
 =?utf-8?B?SlNrOEhkcml2M3lWR2pXYURpRzRQS2lIOTNZQlV5U1pwNWVvaksvWG1KM016?=
 =?utf-8?B?K1gvTkZqNldKbldyajc3dDMwMXNVMTg1aVpCbWxac3htTVVQdllTQ1RCOEtX?=
 =?utf-8?B?K09OTnkzazg3T0xNRklJME1YU0dORkFETFdveVI4cEU5WWd5c2JjWndJRVI4?=
 =?utf-8?B?bWpXaHpvSDk2aGdxY0draHpQRXduV3BqS0dvcERtUS9VZUhieGdVaUU4NzZV?=
 =?utf-8?B?R2pKQmRMQkVCamt1aDZUN3IxSnVDOFlsQzRLM1BKYS9NUG45ZmlOVEtmS1lr?=
 =?utf-8?B?N1ZjRzJFNlRQMnFOeTB1YXRoRkl5Y0NzYU5ZNG9vQTRwcWJjeHlFWGU5VmNs?=
 =?utf-8?B?bnBoUHkwa1Rua3JzQm5GazQydWZJd2hGb29pZ2tGWjBFR1ZpVkZOOHZ0bnlB?=
 =?utf-8?B?eExqMHlNZnNtb25HWWtWbVc2YmpSQVFmV1d0SXd1eVQ4SThFc1BxeFVwcU5i?=
 =?utf-8?B?a0Fuc1M4akk4cndKbjh5ZzJlWWYzalFoU0MvRitHV2xROHg4eUFUc2NCcmNC?=
 =?utf-8?B?OG44bURjVlZseHlSZG16U0V1SnRGWm9KOUZPa1hqdnRFQko4N3cweEcxeTg3?=
 =?utf-8?B?eUNvVnhqWUlYT3JQZDIvazJlOGFoVWpqcE15Tjg4V2JaLzRaZXRNVVFESHZC?=
 =?utf-8?B?SjVyVUY4elRZWVpKUGFySld1RWM0cUxzd284SVdzclNaNkF5Wmg2MU9QSDBy?=
 =?utf-8?B?bFNEMlhSWUJOZW9zYkNOdzBmOHJUZ2krbHlXaStXTWJnTW1QSkRHY0Z6YmZX?=
 =?utf-8?B?UGRsNGtYM0g3c1QrM2dkaHAzdUZtR3JYSXAzZUJ5WFByL2w2ZWtpV2wrR2Iy?=
 =?utf-8?B?UEdOK1RZbUxSR2hpQkhVeE9QRUNTOVVTUUpkZUdYUjVIR0ttbUhLL2NVdTc0?=
 =?utf-8?B?R1p3cjcvY2hWVFNaL0FHR2FsOHprMVRHcmlQRkJJM1hQTFZFa1ZWNE1wL1RK?=
 =?utf-8?B?U2Z0dUUwc1dKVmhCRkJIdXJzc2dLdWhtbnViNnVNME8wTkxxYXFOT3F5d3pm?=
 =?utf-8?B?OUg0TTVoMG1sT1FFeVM5YkRXUFhERDlRZmFaMmFPVnZjQVFrK01OOXlFWHlD?=
 =?utf-8?B?ZUE5eUVmcTltcXl3U3lxa0xJTVNaK0E5dDdFV2pZV2RsYjhYMHI1ZDV4Y0ZC?=
 =?utf-8?B?K0dGWjdNenFXZlJCbHVyY2FZM3FIY0NhNGhzdE9XVUgxRFNIN3dBYlNNT1pk?=
 =?utf-8?B?bEZPUW5EcW1WL3dZWFNRLzNldFJzZ2VuZEhmZG13SUJHZFE2Q3FpbnNHaUpq?=
 =?utf-8?B?QTBkVUtXZXpmWGxBM08vSkozOFdFSU9na0UreHJqZTh3WnloZ2tVc2gzQ2NU?=
 =?utf-8?B?ZWFEZkRyM3IwUDRZV2RYTFdYQ1VMbFg1WXo3ZXhtZFZMcGxuRTB0NGtqUzBB?=
 =?utf-8?B?d2oydXVIY3NsVjZTM3h2QXlhTVpWYmZmSDhtbEdRSDRxeGlrTS9NTU80ZkxM?=
 =?utf-8?B?QWpaSjQydVdiQ0xubHFpSlBvVTFlZjFiM0p2dTJpYmtqTW5vMWZKemJLUkJP?=
 =?utf-8?B?YXpSYno5S2I3N2VBTXFLTjBOL3VsOStsMHlDbmNXbHhyNnQ5UGlrWGdSNUt4?=
 =?utf-8?B?cnNKSTJadG9uTXdCR2NUVVdiWjhDUTV6M2FRMDV4RlB2SUhoWWR6NXlyNDlq?=
 =?utf-8?B?SGY3aTdweEhPN1lGbDZmWS90TnNDR0NYcEtWSENuQlRXTUIzMHV3b2o5VVF3?=
 =?utf-8?B?WU9wSUk5RXluRGdNekV2TXFhQzVWckJVMlpla3JHaGtXUURKcENLaWtWWnFm?=
 =?utf-8?B?OFRwSk9VNjdHZ2dqWjQzNU9lbkhBY0s2dVlNZVdSN2NjUlhrTmtrTW9oOE9L?=
 =?utf-8?B?RG50elFHcVorYnczUVVFMzZzY3NvZWR2bXRWYjhYNXJRN1A1by9MOWdnOEQy?=
 =?utf-8?B?WkN4akYzenRRWmRURkc0Z1Ric2pNRjRmMmZyQkRiTnFDQjM4aHVNemdMTGJl?=
 =?utf-8?Q?o+1y9UzYvMqubvAhv1ZnFmx/OJxHTlPJT/AZmLzv2Vk+O?=
X-MS-Exchange-AntiSpam-MessageData-1: ecePaH2CUxv1/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ed34a1-ea3b-4c69-b4fb-08df01d0ce72
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:14:04.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpxfCthJzwntFl3DGTBehhFRsfzRaC+ZwOF4X2GtgazE8gVhzCNvZG+KFS4CnSBA3Q+uih+Kc4NrahBYzy/w2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

On Mon Aug 24, 2026 at 7:48 PM JST, Gary Guo wrote:
> On Mon Aug 24, 2026 at 9:12 AM BST, Alexandre Courbot wrote:
>> On Tue Aug 18, 2026 at 5:46 PM JST, Zhi Wang wrote:
>>> Rust PCI drivers have no typed interface for locating and accessing PCI=
e
>>> extended capabilities.
>>>
>>> The SR-IOV extended capability describes VF topology and VF BARs. Expos=
e
>>> this information through the Rust PCI abstraction so drivers can use th=
e
>>> existing typed configuration-space accessors instead of raw bindings.
>>>
>>> Define ExtCapability to associate a capability ID with a register layou=
t,
>>> and add ConfigSpace::find_ext_capability() to locate and project that
>>> layout. Bound the view at the next capability or the end of extended
>>> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator tha=
t
>>> reads and validates all six VF BAR register slots up front, yields deco=
ded
>>> BAR addresses and widths in logical order, and keeps the raw
>>> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT()=
 is
>>> a function-like macro, expose it through a Rust helper.
>>>
>>> Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-zh=
iw@nvidia.com/
>>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>> Cc: Gary Guo <gary@garyguo.net>
>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>> ---
>>>  rust/helpers/pci.c     |   5 +
>>>  rust/kernel/pci.rs     |   8 +
>>>  rust/kernel/pci/cap.rs | 329 +++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 342 insertions(+)
>>>  create mode 100644 rust/kernel/pci/cap.rs
>>>
>>> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
>>> index 4ebf256dff23..b946b14d79e4 100644
>>> --- a/rust/helpers/pci.c
>>> +++ b/rust/helpers/pci.c
>>> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const stru=
ct device *dev)
>>>  	return dev_is_pci(dev);
>>>  }
>>> =20
>>> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
>>> +{
>>> +	return PCI_EXT_CAP_NEXT(header);
>>> +}
>>> +
>>>  #ifndef CONFIG_PCI_IOV
>>>  __rust_helper unsigned int
>>>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>>> index 9f19ccd5905c..008c2770a3f3 100644
>>> --- a/rust/kernel/pci.rs
>>> +++ b/rust/kernel/pci.rs
>>> @@ -32,10 +32,18 @@
>>>      },
>>>  };
>>> =20
>>> +mod cap;
>>>  mod id;
>>>  mod io;
>>>  mod irq;
>>> =20
>>> +pub use self::cap::{
>>> +    ExtCapId,
>>> +    ExtCapability,
>>> +    ExtSriovCapability,
>>> +    ExtSriovRegs,
>>> +    ExtSriovVfBar, //
>>> +};
>>>  pub use self::id::{
>>>      Class,
>>>      ClassMask,
>>> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
>>> new file mode 100644
>>> index 000000000000..ddb3fd73e195
>>> --- /dev/null
>>> +++ b/rust/kernel/pci/cap.rs
>>> @@ -0,0 +1,329 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! PCI extended capability support.
>>> +
>>> +use super::{
>>> +    io::ConfigSpaceBackend,
>>> +    ConfigSpace,
>>> +    Extended, //
>>> +};
>>
>> Let's merge this block with the one below, i.e. using `crate::pci`?
>>
>>> +use crate::{
>>> +    bindings,
>>> +    io::{
>>> +        Io,
>>> +        IoBackend,
>>> +        Region, //
>>> +    },
>>> +    num::Bounded,
>>> +    prelude::*,
>>> +};
>>> +
>>> +/// Number of VF BAR register slots in an SR-IOV capability.
>>> +// CAST: `PCI_SRIOV_NUM_BARS` is the PCIe-specified number of VF BAR r=
egister slots and fits in
>>> +// `usize`.
>>> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
>>
>> The infallible casts module is now available in `master`. If you import
>> `crate::num::casts` you can now turn this into
>>
>>     const NUM_VF_BARS: usize =3D casts::u32_as_usize(bindings::PCI_SRIOV=
_NUM_BARS);
>>
>> and remove the `CAST` comment.
>>
>>> +
>>> +/// PCI extended capability IDs.
>>> +#[repr(transparent)]
>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>> +pub struct ExtCapId(u16);
>>> +
>>> +impl ExtCapId {
>>> +    /// Single Root I/O Virtualization.
>>> +    // CAST: PCI extended capability IDs are 16-bit values defined by =
the PCIe specification.
>>> +    pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV as u=
16);
>>
>> Same here, the `CAST` comment can be removed if you turn this line into
>>
>>     pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PCI=
_EXT_CAP_ID_SRIOV }>());
>
> This looks horrible. I'd prefer `as`.

Looks are subjective (or so I like to tell myself), so let's focus on
what isn't.

What is not subjective is that you don't lose a single bit as long as
you use these functions, and can do your conversions without a `CAST`
comment.

These helpers were merged precisely for this use-case; if you want to
remove them and use `as` instead, that's of course open but also a
larger discussion than this patch.

>
>>> [snip]
>>>
>>> +
>>> +        Ok(Self {
>>> +            bars,
>>> +            bar_count,
>>> +            next_bar: 0,
>>> +        })
>>> +    }
>>> +}
>>> +
>>> +impl Iterator for ExtSriovVfBars {
>>> +    type Item =3D ExtSriovVfBar;
>>> +
>>> +    fn next(&mut self) -> Option<Self::Item> {
>>> +        if self.next_bar >=3D self.bar_count {
>>> +            return None;
>>> +        }
>>> +
>>> +        let bar =3D self.bars[self.next_bar];
>>> +        self.next_bar +=3D 1;
>>> +        Some(bar)
>>> +    }
>>> +}
>>> +
>>> +impl ExtSriovCapability<'_> {
>>> +    /// Returns an iterator over decoded VF BAR register encodings.
>>> +    ///
>>> +    /// All six raw VF BAR register slots are read and decoded up fron=
t. A 32-bit encoding yields
>>> +    /// one entry; a 64-bit encoding combines two slots into one entry=
.
>>> +    ///
>>> +    /// A zero-valued low DWORD is yielded as a 32-bit BAR at address =
zero; this method does not
>>> +    /// probe whether a BAR is implemented.
>>> +    ///
>>> +    /// Returns [`EINVAL`] and logs an error if a BAR low DWORD does n=
ot encode a 32-bit or 64-bit
>>> +    /// memory BAR, or if a 64-bit encoding has no upper DWORD.
>>> +    pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfB=
ar>> {
>>
>> Since `ExtSriovVfBars` is private and we are returning an `impl`, I
>> think we can get rid of it altogether. Combining with my suggestion from
>> above, here is an alternative version of this method:
>>
>>     pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBar=
>> {
>>         let slots: [u32; NUM_VF_BARS] =3D
>>             core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[p=
anic: slot]));
>>         let mut slots =3D slots.into_iter();
>>         let mut bars =3D [None; NUM_VF_BARS];
>>         let mut count =3D 0;
>>
>>         while let Some(low) =3D slots.next().map(VfBarLow::from) {
>>             if low.io_space() {
>>                 return Err(EINVAL);
>>             }
>>
>>             let low_address =3D u64::from(low.address()) << VfBarLow::AD=
DRESS_SHIFT;
>>             let bar =3D match low.memory_type()? {
>>                 VfBarMemoryType::Bits64 =3D> ExtSriovVfBar {
>>                     address: (u64::from(slots.next().ok_or(EINVAL)?) << =
32) | low_address,
>>                     is_64bit: true,
>>                 },
>>                 VfBarMemoryType::Bits32 =3D> ExtSriovVfBar {
>>                     address: low_address,
>>                     is_64bit: false,
>>                 },
>>             };
>>
>>             bars[count] =3D Some(bar);
>>             count +=3D 1;
>>         }
>>
>>         Ok(bars.into_iter().flatten())
>>     }
>>
>> With this you don't need `ExtSriovVfBars` at all, which removes a bit
>> (almost 50 LoCs!) of code.
>>
>>> +        let slots: [u32; NUM_VF_BARS] =3D
>>> +            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar=
[panic: slot]));
>>
>> Can't this be `build:`? `vf_bar` is sized by `NUM_VF_BARS`, and so is
>> the result, so I'd assume the optimizer can infer this. Not that `panic:=
`
>> is problematic here but I wonder whether you chose this because you hit
>> an issue. To reiterate, I'm fine with `panic:` here, as long as the
>> alternative has been considered.
>
> `slot` is technically variable and you'd rely on optimization pass that i=
s not
> const folding. I think `panic: ` is better.

Yeah no strong opinion on this. The use of a closure makes me a bit
unsure that the optimizer will catch the hint at every level of
optimization.
