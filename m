Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBA3624AE;
	Wed, 12 Aug 2026 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525299; cv=fail; b=Haug+Qvl8lYvpOi+cT/Mg6cCaAw7WjfdUlzXOVSnKsAk8bEUY2Y0UhQPW9J+qHtpAFrAUGeUqs5ZW2nLjqbawidCpfePboGcdrM0OQInCOl0AE51jqO1nqkbvqHFNqYkYJROqZmQLqjlkoMngJNMAoy0jcNOqcXq+VnQWyiN/SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525299; c=relaxed/simple;
	bh=kTpo4gKHUN69yuuquIUypcMri11jB+skOEEr8v5OEB4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WNE68PKm2ms/4qvAcsVAR5ySCtscQ/1CkrtGkaPhR92n9llmLn4Qoxmt3n7HDGLYQrorx/xYgtPtQC5Via6La1w8D7CoDdvq2LeRMkDf2Rd7hBgcgb3F8oFJMUFn4KNASo9MTpyvTIGQ57zQR1HKXbInJAunFqFPlYLZXBRGMrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ePa/vIfF; arc=fail smtp.client-ip=52.101.61.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ePa/vIfF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ68vSMAnhhG8qnjV+thoWisDD+HdBRf7M+ENxsmhY8ikDTSYp+fqPSlhYXNanENANkDW/Kkr4zp/8fBienizeUsv7SJzLU8pcCuMnZm7QEJJywvqF7GZwopsuA/nYnm2VKnLk3xgUh9E5f00y3aZgxt1wXI1yFQ52ZUDBXhWPL8/HEEhfmldwMHUAAXI3F0kc2V5okUVEjbtKBbLn/dJ+KVrcOhNyxNouWJcWyZG1ZxjwlQNWdrejH2Smgh0JnkeR7D9pn7SKmsbUj+R9Ipbrk3f+QJx3h2Ait372Jl5st6gQbUlWB2w0m4ILFFOFbuUZNg0ZuugDuH8O++jknm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY0ICeScknViGWhpoaSm7l2fHf5PoyGk8q9X2d5xeQw=;
 b=OznDcobKgYq9QIAxgPZjVZJpZEzy6Q49gCnT4w2HDf3bZJelbEjfHYZb1IiJnX2UB6aouN6z3vTSkQUIOLrtMPZLMRdHSExF7HgfKp3Nehk23ofkptRtE6shMGPAExbAqdw5aDcdWwCCMKCvPsRGkrJOApv5c8c7rdGQgUpquqVWqpcTutovQnRP0TZBdY91lEbBQwRH7mXYQ4wT74bviWmFfEXIA4C9yorWJjC8hvWu0zDsEevD5GZWbdufXQV3FeeClp+xBNEo5ZrY9PVvc/QCJE13AoxFmrK3scJhQLU/pgo9dm32fV2etvxi3U5gRcNyich1HCRwC8TaygyMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY0ICeScknViGWhpoaSm7l2fHf5PoyGk8q9X2d5xeQw=;
 b=ePa/vIfFx3mHWTr6Iw8+K7SVQ0R3gnWwoARav+QL6z3H+pq74lurzimqdRqb8tcGyVyxgzHwz3JMIm9dr7FzhFc5x1CBI/LnX095SSs9NNKnYiHPlkwufHpZrkvBDH5aL5NAm5wX8Qc9xWn+MypqqF9iLV9mGqB4g6IiuCw2hDRfcVj7e1vIEhgeGpDezF/f/PcUIk/qxBjgq94YtUb8iDqA0kjS5dpU3JaoXOPu+ZR1f5IVZVEjHxh07SJOVzw+9Ii7s4sepbugd7NhP2DUAZtaBeX2gj2akT3mTINdzDIn+qEUsnMAuL57B3IOE4CEcuLUADr7Wws7tMlFvtaqgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 09:01:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 09:01:29 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 18:01:25 +0900
Message-Id: <DKMUCY1KB8AK.3G3Y11P63DFMV@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] rust: io: register: support fixed offset
 register without bitfield
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-11-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-11-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TYCP286CA0278.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 91256f6e-b379-42e1-5179-08def8504be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|5023799004|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qpr+Sve27yPg2lXgboIAwQtXQUyT3WhQOkKEuO8IO1TKVDNt4NY86nXuedA66eZbrtiSBzMFS/jCU07LPvL07H4TXQHLlIazmdlz/7OtNEG+vNrnxMA8/qPvrYrQFKWYD4UZVvZsx9LGlt0Yklv3Oyi6KI0paxYrP7JAbZMyFPdcm7Y326nbvzla7WGzQqps/mNOhhIENkUegSOPZPRTFQhNzc8mVEUx7RfmV/tsVX3TKoa5OF5NQ94aKwE4Svl2/BdXBCHif1mfHmmb23HTwLxwB9MlmyFwY8X7y8vBRTByX5nbDPH9hM+lF5gQpcOs1W0mL4gRVs1CHvUmTxMsNiK9taOk/QnhFBtodTho1CFAS9z0I7fPpNv8yFGgd6x7fIRstll9hqA90sfvlCjM9agsK4p2q5Zi8ks42L8Oe2CakSJYQzZHP+lnkf4BVZK2R9GTWmPuYoDCXcHZBETKF0ZwiIaer4m7zEf3XPFnzZY3mrMW1/7V9YjNcUYllwMVbSZZ7ghMeLlAnDBRS6BZo395bjXZvj1eb16KFDAtckJ0thmhqRZIL9eeFbY74zY80HZPpEKheqcsvY7nAD2pMwLeDZXD52gtPCFBVsDQZR9l4XuqIid/Q0utTJqROZg7L/X4FYSQArn9yPmaz0FsB0G/8fxVygy6yNgII7xveB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(5023799004)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUl6UDdlQVg5RE9vcXY2RnRBbUMwc08rellUZGVNQ25Ec2dnanNzbGhXWFdO?=
 =?utf-8?B?WHl3S25GdXRtUzZsbUh3cGE1RlhNdVlLaFF5K1BaZVVkTEFKNk16VWdGUVg3?=
 =?utf-8?B?alFPVFNMc2t5em5Selp0MVFrUkNlVUQwUkt1aVp5c3BwNzNqTkxUQUM0ZElK?=
 =?utf-8?B?RTcyUTVJc3QzeWRPeDRrcmx3T2oyZzVzWEtaaDJHSFA4RjhWZU03UURhZk04?=
 =?utf-8?B?OHArTHl0UkhTQlArcGw2b0dJaXRXS3U5TkdRL2hzNDBIeEh2YWxnVE5nRVo3?=
 =?utf-8?B?TkZvYjJwa2J6YlJ2OXFLM3dKT050bUhDVWJnSFdqU2NoVlM5eG9xU05vZnhU?=
 =?utf-8?B?cFI5WjVWTnptLy9TTjhLVW04UEd5d25iMzJTVDMxUTgvOStJaStBZm1GTnBI?=
 =?utf-8?B?QjJhcjBFc2xvbndqUUswVnhnTmk0NTRoRC9EaWdPZzFjcE5iSDN5OGUvcVVm?=
 =?utf-8?B?eFlWd0VnNXE1V2tmbUVJWDZnMHgzMXdaSk41SXhYbWgxdWpLeE16Q0xkbFJk?=
 =?utf-8?B?L3NWdTVpaVk5bjBjRUdwT3pFTFh2ZGpMeFdtLzJuU2ppVmIrS282ZzFRTDZj?=
 =?utf-8?B?R3B6M1RtbWlnOUFlRkNHbE94V2U1NXUyWHNyR2laK3ZIeDcrbHRKUWRRQXBD?=
 =?utf-8?B?TWk2TFJXRjlnUHRBQ2gyMmdIYi9ZQTFRV3E0U0Ixa1JobmxPT3RUYVpQMnNk?=
 =?utf-8?B?bkJlVXJKNGZGQWJVZkJhRndPQ0JsLzhCM1FIQndvSzg0S2RpK3VkWk5ONFRh?=
 =?utf-8?B?OXNzYkhEQ1kwOWxqT1FYanV6RFZJWlFaVFVOMFlHUW9Yei9zZVZ4UzN0MmZw?=
 =?utf-8?B?WkcwbXBEaEZzc0VxbmxWaFM2TEhPc1FrcHN3K3czdDVqeWtYckd1TFBuTSt6?=
 =?utf-8?B?eTJyVmFEbE90NXROK2tlSXlrQkhzUFU3di9JRXMzZEVQTUVHZEtjQkZZTVZj?=
 =?utf-8?B?cnBpR0YvWk42N2k0NHJtc0V3aC9NODRzdDdoR1h6R1dhekxNZjBuUzlub2g5?=
 =?utf-8?B?STR3TktROXc2L28zTUNIbWNPYjdMckI5bHdabFlRckIxQWducVFrWkJFaklF?=
 =?utf-8?B?SURtcElTVnl4L25KekpUNUQyZHFrcGpTcjQ3dWJmVGNMYlRGNmUvSjlJbzFY?=
 =?utf-8?B?TTlsbXF4Z25aRUJYZmQ3RWpuK2hZUVRCL0dTWnJMWCt2Q2xWYlBRVjZ2L3I0?=
 =?utf-8?B?RGRGK1JEVjRoQitELzNURHJFQWU5ZkNRWnRzVzdEUWNOTStkU0JndmtuUlgy?=
 =?utf-8?B?dGRONGpIUFIxMkVyK0dMcDJqK25VbHNSaXFJOTFjMVp1b1I3UlRJbVdBRDZl?=
 =?utf-8?B?NG5PK01Oc1hHbnQyUktIWmhVVVdwWUZWT1FLY2d4MDY4OHZSL3dUNnFkcFQy?=
 =?utf-8?B?V0hxS0REYVZXSDR4Z296ZUxEVmw1RUZHTWdBK2tzUUdFZ1o1cE9Pbm1EV3cr?=
 =?utf-8?B?NU9ZV1piYXNVNWNFOXlvWkdEYzRURW1ra21xRmhoTnhpNG1JZVpHMmh5Ri9i?=
 =?utf-8?B?MEFhU1ZlWDJwYXhEU1RTNUJJNVFpSGZuYVR1UktJcEh4UHBuREhHTEdGTGcv?=
 =?utf-8?B?bjNPZVBEZWVuMXBjSjcyc3dOTGdRT2t0UDh4dllXVnNCR01RczZKNjdLeDI3?=
 =?utf-8?B?Qk1ZVFhOeGpDaDBKREVUSGNSL01oRFBJVlMzLzUrQS9MWm80d0doT0Zqd0tD?=
 =?utf-8?B?eGxxZWJ3QWIvV0JEaVQ2RFdINWhLL3F4Mm53UDZWbzRQQ1FBMmd3M0RCaG1D?=
 =?utf-8?B?Ty9lcG9EVU95UmJYMU1WVTFnWWI5Rzdsb2RCeVdFR1NhYnYybnlCVWZqb2ln?=
 =?utf-8?B?c2F5MHVXSjZiZ2F1YS9SZDZYRFNZR09ZU25jZHMza0ttcmQ2ZWszMmU0VzN4?=
 =?utf-8?B?d1JJRWFLN2NXdTJFaXFuWGlyblBTNnFsTzRJMytoYUR2dHAzbGRZZEIxb1V1?=
 =?utf-8?B?cThKR3U4NS80T1d2ZC9sejU0N1VKeE1QVnFVQUl6MkpSZFJOU09scnpITTIv?=
 =?utf-8?B?QkxKZm9FTlk3ZkJ4TFRLUFBPVUJucWc2ZXpoZ2psKzhXZFZIYlVFQ3hTYVpN?=
 =?utf-8?B?YnlTbHhVU21VQXZpT0pWVlUvS1pkMnhPTERlbkpGbzEvdSsybnVBNEtxWG9v?=
 =?utf-8?B?bUdZOWErdnhKTGwvMGYrbzBkU3E2eDdpSklsR2lSaDFRU3ErV0Z0OWx3Y2tD?=
 =?utf-8?B?U3NlMUIxemlWdk1jYWpiR2hSTkVyenJ0dUx4dGlHN05mUHBiWURpWms2VjFO?=
 =?utf-8?B?RWlPUjR0dXRZUDVLaTdON0pFVmorR2JyTlh5Um5sazdMWUNucHNJeVVwNjNw?=
 =?utf-8?B?eXRkY1EvNk14MkE2cHNWTnJ6K1pRdmE5NWhxbFBpYUtLcVRRTXRqRnVRZktm?=
 =?utf-8?Q?k8r2nVZve0Md9QE0qLchNoNCK49cg/MHQB2D3mtEyfe77?=
X-MS-Exchange-AntiSpam-MessageData-1: /8LYTBJA15WEBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91256f6e-b379-42e1-5179-08def8504be7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:01:28.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LeVB7NleNbSnY3ygSLZGsEiJbRY8JklBkHf+1pWo8JKWUFQduVcdsJtGt5z02N4cZmpOd3yIIQIKbPf81IrQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> Add a rule to allow creating `IoLoc` in `regiser!()` using an existing ty=
pe

typo: register

> and not create a bitfield. Add an example to demonstrate this for FIFO
> registers.
>
> This rule is also going to be used to create subregions for registers; th=
e
> example of doing so will be added later when relative registers are
> removed.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io/register.rs | 47 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index dc800fc71172..49a61da106c7 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -182,6 +182,23 @@ fn offset(self) -> usize {
>      }
>  }
> =20
> +#[doc(hidden)]
> +pub struct OffsetLoc<Base: ?Sized, T>(usize, PhantomData<(T, Base)>);

Even if the doc remains hidden, it would be nice to have a small `//`
comment for those reading the code.
