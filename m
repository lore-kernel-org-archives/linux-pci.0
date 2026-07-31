Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F83E168C;
	Fri, 31 Jul 2026 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491871; cv=fail; b=SEKJCAa/IF/DzsDugimXmzaVe9JJTL176lInJE81rQG6a9eNN2Wou/71mjGX24MN93hj7CIvBh3z4ARCU77c85iGXu2/fJuECJiMGQjSalQUpRqUY1ds8xrCSR6FGrLn96bVOP7dScBVWKo5XVynhtabb9vLKj0Co4FGtgAuKLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491871; c=relaxed/simple;
	bh=zMO/6dVfzhWQfnufQQPUrw0aR/X3MNu4AR53vZQ2DMg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mqXNvhStjHJt3PHmu944Qr1lR/M/sIz2ie3mi4pGXkPe81/QLzea6Syt0COjKaXLhEPcmiS0GuZ6JgS9wS1jkxBvfXKUJXckIFkGQyE5dLERpMEDSCQwgt8tRYXDOuE4Z+rfjbunMprkEottwr+oGOyU5S9HdT/LdnMDTItuCag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jdTNHU7L; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jdTNHU7L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwWrAVIsf31l+TIUZjZfOquGNn1843Y9cYXtd2iK1WJu8+sNtXcGmd/ccusRpFQ72oE54idFYchiHqwuQx9lEGZAAsuzTKxKI7Xhu+HpTZ5SGTa7VmJAeEgx9WadEXHaOD70SP394uWDj8uXiyemF5p0Uewe81R67+fHM1yn7kNOTbCJJUo4rua2JwHs9bwWv0ESXVBM/rhXD5lA77yWdiBnz9i/HfZvVDI1mF3AjBm9vOVL+1V5agrNnys9owRfulGlTh7PVWV/+5TXvch+QBumUpH6sBWR3o7mAFLNFX3ivnCfGUpOSUcirUJksF1YlB6KNlTlpSL67bCVhHLrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlMJgPQpS9H+b2w/BMNvkJzZf7jZYPL3GQoa0J15KAY=;
 b=ByRy15EEB/8++i3uithiEXQQxBtKjZG6AW8yVw3AXDrGwfOHq+MarnAlRBDksX4QV9+SrR5ahBtB892iAVmjvxpUdEqBx/Rjstvu3QgLRD09+0JRXP9PTaO1oj4MfdREbIOn6OZPqOMiF2e7FE1Hj9zs4cOEBmU/LdItQsch+cm0e8naQzFpzQBiHkAdY5tLB94UOeVSYzX1tp7vPyOe6S2aVqSt+jI1cjrJ0oJVSdqSyoQbkkieF2GFw8E/j1QUBgrmo63wBOHRpGx1l0scXVDOe0+Yl5Xn/HoQZ7LLfNQ9xmxT7tVeEyyvApyr46IrZleB1+uaA4H6RH9SEw8tKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlMJgPQpS9H+b2w/BMNvkJzZf7jZYPL3GQoa0J15KAY=;
 b=jdTNHU7LoYRhavWKj23zRakCa4Bzwughv4ymcCCmbpSbVSx1ERxw8gveWSYXQkxt2l4CjXK3j8ZjyP0nMkZrT2fBe702POS6ao1O7/uTdg/S2/qKmwVAtjyL6hZMX5qiGqAeHvXINDkEXQ5srNpCOMsxZrUfFpDEbYTGyHVpnMi8Rs4rq+4FnN6BAvs2aQ+kx6yeY/PbBGKDxAZS+l0OK5hY04kNjxFvMvpRy+e3XqOS/Skgp645Gs7fCMYkN60JFuHlaOjWdp69cjQcltlZkYC0g3p2/HxJ1c0pHEjc19uOuFMf9pzGyqQCEj/9IKl9pJ9jOlBmjzF2Vm427llFhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 09:57:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Fri, 31 Jul 2026
 09:57:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 18:57:27 +0900
Message-Id: <DKCO1B3HUGD1.1IP1J7ZZ5MHCH@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260730182954.783568-1-zhiw@nvidia.com>
 <20260730182954.783568-2-zhiw@nvidia.com>
 <DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net>
In-Reply-To: <DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:405:378::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f75905-2936-454f-c443-08deeeea22dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|4143699003|6133799003|11063799006|3023799007|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	kyz/ZPWKkmACmEOSMJs7XFAmKKsgrKH0tjbi+fdz8a/E6gk7HsG38VugJwke4jxecTu3/ikCdIojDJnNTZLCG8NiSTDyWarbrXkVVJWD82IHS3UPGWJZXwZMPkyFijlQH1CfnI6WQPs6dcCKTH+oChyWJmbRB+BkN6PfDER6d9nO0MhoqMUrX+XMV02llyfSREowZTMtoxLP0kze/vXrHKQNeQleDX1eEcM0Q8/TzM2lKQR1rkpYVnLvUovazw5wMhVzOqhU7k0zKaz9p1e9oybCIbQov6IlxD/LTYG7/5e57MWkWb0KzVqiImbcL1dLlwoHjFIKcJBDybLO+xaLsOcbFZYKaRjDCj8CznFu1xDQ3n59ZWJtm9gsl53uMhS6+s9mq1qGLZH+J1OmA3ifs4dMpyu3ixT9f9ZDE9nD9dmPrtVQtaJk0AmOEamfJNDF/z4r394HZPRLs6RJx/WDkg2QX/jgE348eysIc9fiNTx2QHvVDvA3PJNT5jOPqIa5Mv+WZtDXhithIOgSL7/6YLWwv+ytLcOrtVA97AKeH0/Lgg5ie3SUXpwY5CbKsJSAxpXpk+Ld2TBjtd2BS3dzhS/eFEw5G39OXX3vRPpb/83a9kGFgC/ba+sA+s/y1t8wPoywWmv3SKJhznuOvaHeRPMZSUW+nClxGS3hcurSuc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(4143699003)(6133799003)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjU2ZHU5MVV5eFBVdi85S3E0OHpBMW9WalNvQlpQR1VxVkg4ZktKL2lranZl?=
 =?utf-8?B?RmtzWXpDalZHUytrU1htcU90emhZNU1razRwOG1TQWdROXk5VjhmbmZWaURn?=
 =?utf-8?B?bGdzanArTkM1dHNmNDM3NWdIbHJGeVBCTUpyc3A2N3A0cFpPZlVzWmI3MFNO?=
 =?utf-8?B?dWloVElxdktnaXBDZEprUFpmQUFRTkVFelBGKzdFZnpPcEtuLzVKK3hZZzBr?=
 =?utf-8?B?QWRvelN2RzNZVGFOanpCZzMzOTNVK1ArZjdtNjZNdjAxVWRXbGhkNEhLRDMv?=
 =?utf-8?B?T1kyM2tIbmY0NlExSjZyZTMxQXRFd2NWOVFUSTRSV2Y1WGNveVFNZGZWVWVj?=
 =?utf-8?B?cENNbmFUVU1Pc1R5RWRVb2FJdnUxbE5MQ1ZyZUNiTFd6VUsvKzd0RGR0REZS?=
 =?utf-8?B?WGl6NHN2NkZOeHB4Z2NLejhlRTVjdGxwZ2VGcW9aa3FGZkErbDNJbWtKUTF0?=
 =?utf-8?B?R045YVJtejltYVN1cHViSkwzMEM5bUNPMnV2MFFxNDJkOTI2UmdIZHUyTmpX?=
 =?utf-8?B?bW9UemR6cXdvdS81cjdGR2RUTzJkbmF0dnlYYlhtVzNqZG1abmF1OUtiY3RW?=
 =?utf-8?B?NVQwRWpaUkxqTVE1dDFMaEVHUnlKNURucGRTQ2laMFN6TzlmK2Y5VHBFSzhz?=
 =?utf-8?B?ZDQrMXhXK25MZ1BZU3NZS1RTSFpCdzFGWnlBdFVYcjNwRHhYVnZhVTZBSStI?=
 =?utf-8?B?TTZPdGNNL0VCTUNBZGFRd0xCbHRaMjk1Nm9yWWxnMTFZMWJFN0QySzNoUGph?=
 =?utf-8?B?dXhweGErVVJ6WTdmeGp2am1VaE51anBiSlM4dHRBaERpbWJQWlVBZG1zWitG?=
 =?utf-8?B?L3FLN0cwdEhtTVl3VEpCNGd5Um44YXZNK08xVGhQaWZ5Y1ZDVU5Zd21tY2dS?=
 =?utf-8?B?N21yVlcrWjEvYng1OE5xeE5BZy9oL1BsOFN2ejFDeUxwdFJSTktrVWxnYjVO?=
 =?utf-8?B?WVN5R0pPTVJYOVBzaEZtSkZVa0NFVXF5T1YxMllLdVRIenJDZjlNN1J3YjZK?=
 =?utf-8?B?MFBRUEh5WEJCWUlhWWUwOEtsRE9Ma2RidDB3NkNjRGdEaVhBRlcyc0tYaTMz?=
 =?utf-8?B?dXp4QnFNTmJrMm9rQWZXcEV5RnpUd2FEQzhUYWdXU29CWTZ2VXIvSG53SS8y?=
 =?utf-8?B?VUhWeFprUkRUZzJUZEpLdG5kLy9qVHRyc0FNUWRETmtsSXdmZU93WXFQOVVa?=
 =?utf-8?B?Tml0VlhEcnl6K0dWRVBBbjRZTXM1UmVNZUc5dDBHaGsrai9CS3A1YytuSVlu?=
 =?utf-8?B?YkxOWEFleFF6UHZIYUUrY1JxQUg4WmdrcldzTDZYZ0NUa2hsOFJVRWRnZW44?=
 =?utf-8?B?UlJOUnB4bU9taGowbVV0R1dYQ1U0eTFpWDVJYW03TC9TV2U5R1prU1RSUllH?=
 =?utf-8?B?UFlJcjc1eUM0SDhadUJaZ0xJeDlLOHJ3V2lQVDFBSk43S0tMeTcxeXE2cXRz?=
 =?utf-8?B?VzhtSC8xdnBWY0RjM1B0ZnhLSWorYmVaVHZxcU1pRTlOOWZocGNQcjBLQXNh?=
 =?utf-8?B?N1FkSytqWlFmMVZya2FoZUNZVFJiNzZLemgxNTM0cU5GWmVnYmY5Q3J4akxw?=
 =?utf-8?B?RXpUWGVKWmo2OVROUlRaeUViTXhubzU5bE5oTnNRdmNsVGpSdzZUdjIzOU0y?=
 =?utf-8?B?U09BNTI0UVJNdnp0WlNjRWs1M3loaC9VTUkwOEVpQ25SRkZ0dlJUUDYrOERp?=
 =?utf-8?B?cVZESUcvRk1nQ2x5NTg5Yng2WHVBT203dU9jU1BmZWMwZjdONU1rdzVGNll4?=
 =?utf-8?B?YnhCVGRKRmoxQ3RGTkdhUlYvaDJqYkVSUm5FRWZrMWJNQmlLdE1pQThZdkI3?=
 =?utf-8?B?WEtlMUkrNFRldUhrZTJZYmRqRVZkSmc1ZnFuNWFETEpVeGd0Y21MS0lGVnhq?=
 =?utf-8?B?ZHNYbHl1Tm11Q0pkekRsYXVzOS9WTWpGZ1p1cWExUE1FeExvbVZjMVoySGN4?=
 =?utf-8?B?WUpqZE53bzVWM054Q2RhdjF2M3htNTFOQXVvT0t4Z25VVkdTMWp3akhSYU03?=
 =?utf-8?B?UmkzTzdsdXNaUG9mZjl6NDVGSm9KUENMQUpRcnllc0JHUU8yaTNUUW1Cc0xr?=
 =?utf-8?B?Z0JKdm83TkdwV3VCN3NKaVJhMlBGUFhzaVV3YVREdzF5UU9VNm5HclBzQXRQ?=
 =?utf-8?B?TGViSW9IVDh1Q0RtUFpCcVA4K1VJQjJ0M0VrNldoRUROdXQzSStBUmx0SXpK?=
 =?utf-8?B?dU4xYXV4Q3BhQzFvUXZWU0lnOHJYc2VtSzBFcStZc3NxY0NIaFdrb1M0a3Ux?=
 =?utf-8?B?SDA3cDd0Z2dJajY1R0x4a3g3OHlTbXhaKzZFMFdxNkx1Q2pRV0VLdk01cnd0?=
 =?utf-8?B?azh1Q0NpZEpoU1RMV0F6OHY2QmhLY3VXcXVsQnc0ZDUvdmdyandSQkFWZkJk?=
 =?utf-8?Q?SuhRF9iQp2vnDh+i3TnBFE3yHda2vex+Q90bB74OYRnn7?=
X-MS-Exchange-AntiSpam-MessageData-1: K9wCrV507mAi/w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f75905-2936-454f-c443-08deeeea22dc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:57:31.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gqy8RCp6uJ1FyO64qgNhRoGF7Wpltfk2EMW6Ii6h5WmEkgR6rgpwhMBaI9zBW2Z2+6dA28ZaOvH+AHK5G2Razw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610

On Fri Jul 31, 2026 at 3:45 AM JST, Gary Guo wrote:
> On Thu Jul 30, 2026 at 7:29 PM BST, Zhi Wang wrote:
>> Rust PCI drivers have no typed interface for locating and accessing PCIe
>> extended capabilities.
>>
>> The SR-IOV extended capability describes VF topology and VF BARs. Expose
>> this information through the Rust PCI abstraction so drivers can use the
>> existing typed configuration-space accessors instead of raw bindings.
>>
>> Define ExtCapability to associate a capability ID with a register layout=
,
>> and add ConfigSpace::find_ext_capability() to locate and project that
>> layout. Bound the view at the next capability or the end of extended
>> configuration space. Add ExtSriovRegs and a decoded VF BAR helper that
>> returns the address, width, and next configuration-space slot, using
>> PCI_SRIOV_NUM_BARS for the number of BAR slots. Since PCI_EXT_CAP_NEXT()
>> is a function-like macro, expose it through a Rust helper.
>>
>> Link: https://lore.kernel.org/rust-for-linux/20260730180349.771719-1-zhi=
w@nvidia.com/
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>  rust/helpers/pci.c     |   5 +
>>  rust/kernel/pci.rs     |   8 ++
>>  rust/kernel/pci/cap.rs | 236 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 249 insertions(+)
>>  create mode 100644 rust/kernel/pci/cap.rs
>>
>> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
>> index 4ebf256dff23..b946b14d79e4 100644
>> --- a/rust/helpers/pci.c
>> +++ b/rust/helpers/pci.c
>> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const struc=
t device *dev)
>>  	return dev_is_pci(dev);
>>  }
>> =20
>> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
>> +{
>> +	return PCI_EXT_CAP_NEXT(header);
>> +}
>> +
>>  #ifndef CONFIG_PCI_IOV
>>  __rust_helper unsigned int
>>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 9f19ccd5905c..008c2770a3f3 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -32,10 +32,18 @@
>>      },
>>  };
>> =20
>> +mod cap;
>>  mod id;
>>  mod io;
>>  mod irq;
>> =20
>> +pub use self::cap::{
>> +    ExtCapId,
>> +    ExtCapability,
>> +    ExtSriovCapability,
>> +    ExtSriovRegs,
>> +    ExtSriovVfBar, //
>> +};
>>  pub use self::id::{
>>      Class,
>>      ClassMask,
>> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
>> new file mode 100644
>> index 000000000000..08c044bedb70
>> --- /dev/null
>> +++ b/rust/kernel/pci/cap.rs
>> @@ -0,0 +1,236 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! PCI extended capability support.
>> +
>> +use super::{
>> +    io::ConfigSpaceBackend,
>> +    ConfigSpace,
>> +    Extended, //
>> +};
>> +use crate::{
>> +    bindings,
>> +    io::{
>> +        Io,
>> +        IoBackend,
>> +        Region, //
>> +    },
>> +    prelude::*,
>> +};
>> +
>> +/// Number of VF BAR register slots in an SR-IOV capability.
>> +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
>> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
>> +
>> +/// Attribute bits encoded in the low DWORD of a memory BAR.
>> +const VF_MEMORY_BAR_ATTRIBUTE_BITS: u32 =3D bindings::PCI_BASE_ADDRESS_=
SPACE
>> +    | bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
>> +    | bindings::PCI_BASE_ADDRESS_MEM_PREFETCH;
>> +
>> +/// PCI extended capability IDs.
>> +#[repr(u16)]
>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +pub enum ExtCapId {
>> +    /// Single Root I/O Virtualization.
>> +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
>> +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
>> +}
>> +
>> +impl ExtCapId {
>> +    fn as_raw(self) -> u16 {
>> +        self as u16
>> +    }
>> +}
>> +
>> +/// A typed PCI extended capability register layout.
>> +///
>> +/// Implementors describe the register layout of one extended capabilit=
y. The layout must start at
>> +/// the extended capability header, and [`Self::ID`] must identify that=
 layout.
>> +pub trait ExtCapability: FromBytes + IntoBytes {
>> +    /// PCI extended capability ID for this register layout.
>> +    const ID: ExtCapId;
>> +}
>> +
>> +impl<'a> ConfigSpace<'a, Extended> {
>> +    /// Finds and projects an extended capability into its typed regist=
er layout.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```no_run
>> +    /// use kernel::pci;
>> +    ///
>> +    /// fn probe_sriov(
>> +    ///     pdev: &pci::Device<kernel::device::Bound>,
>> +    /// ) -> Result<(), kernel::error::Error> {
>> +    ///     let sriov =3D pdev
>> +    ///         .config_space_extended()?
>> +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?;
>> +    ///
>> +    ///     let total_vfs =3D kernel::io_read!(sriov, .total_vfs);
>> +    ///     let vf_offset =3D kernel::io_read!(sriov, .vf_offset);
>> +    ///     let bar0 =3D sriov.read_vf_bar(0)?;
>> +    ///     let bar1 =3D sriov.read_vf_bar(bar0.next_index())?;
>> +    ///
>> +    ///     Ok(())
>> +    /// }
>> +    /// ```
>> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Confi=
gSpace<'a, C>> {
>> +        let offset =3D usize::from(
>> +            // SAFETY: `self.pdev` is valid by the type invariant of `C=
onfigSpace`.
>> +            unsafe {
>> +                bindings::pci_find_ext_capability(self.pdev.as_raw(), i=
32::from(C::ID.as_raw()))
>> +            },
>> +        );
>> +
>> +        if offset =3D=3D 0 {
>> +            return Err(ENODEV);
>> +        }
>> +
>> +        let size =3D self.calculate_ext_cap_size(offset);
>> +
>> +        let base =3D ConfigSpaceBackend::as_ptr(*self)
>> +            .cast::<u8>()
>> +            .wrapping_add(offset);
>> +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base, size)=
?;
>
> The signature should be=20
>
>     Result<Option<...>>
>
> where the result is usually handled via `?` and `None` needs to be handle=
d
> explicitly, rather than matching on ENODEV.
>
>> +
>> +        // SAFETY: `offset` was returned by `pci_find_ext_capability`, =
and
>> +        // `calculate_ext_cap_size` bounds `ptr` at the next capability=
 or the end of the extended
>> +        // configuration space. `ptr_try_from_raw_parts_mut` verified t=
he region layout.
>> +        let capability =3D unsafe { ConfigSpaceBackend::project_view(*s=
elf, ptr) };
>> +
>> +        capability.try_cast::<C>()
>> +    }
>> +
>> +    /// Calculates the size of the extended capability at `offset`.
>> +    ///
>> +    /// The capability extends to the next extended capability, or to t=
he end of the extended
>> +    /// configuration space if it is the last one. `offset` must be a D=
WORD-aligned offset within
>> +    /// the extended configuration space returned by `pci_find_ext_capa=
bility`. If its header
>> +    /// cannot be read, the capability is treated as the last one.
>> +    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
>> +        let header =3D self.try_read32(offset).unwrap_or(0);
>> +        // SAFETY: Pure bit manipulation, no preconditions.
>> +        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), al=
ways fits in `usize`.
>> +        let next =3D unsafe { bindings::pci_ext_cap_next(header) } as u=
size;
>> +
>> +        if next > offset {
>> +            next - offset
>> +        } else {
>> +            (*self).size() - offset
>> +        }
>> +    }
>> +}
>> +
>> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offs=
et).
>> +#[repr(C)]
>> +#[derive(FromBytes, IntoBytes)]
>> +pub struct ExtSriovRegs {
>> +    /// Extended capability header.
>> +    pub header: u32,
>> +    /// SR-IOV capabilities.
>> +    pub cap: u32,
>> +    /// SR-IOV control.
>> +    pub ctrl: u16,
>> +    /// SR-IOV status.
>> +    pub status: u16,
>> +    /// Initial VFs.
>> +    pub initial_vfs: u16,
>> +    /// Total VFs.
>> +    pub total_vfs: u16,
>> +    /// Number of VFs.
>> +    pub num_vfs: u16,
>> +    /// Function dependency link.
>> +    pub func_dep_link: u8,
>> +    _reserved_0: u8,
>> +    /// First VF offset.
>> +    pub vf_offset: u16,
>> +    /// VF stride.
>> +    pub vf_stride: u16,
>> +    _reserved_1: u16,
>> +    /// VF device ID.
>> +    pub vf_device_id: u16,
>> +    /// Supported page sizes.
>> +    pub supported_page_sizes: u32,
>> +    /// System page size.
>> +    pub system_page_size: u32,
>> +    /// VF BARs (BAR0=E2=80=93BAR5).
>> +    pub vf_bar: [u32; NUM_VF_BARS],
>> +    /// VF migration state array offset.
>> +    pub migration_state: u32,
>> +}
>> +
>> +impl ExtCapability for ExtSriovRegs {
>> +    const ID: ExtCapId =3D ExtCapId::Sriov;
>> +}
>> +
>> +/// A typed view of an SR-IOV extended capability.
>> +pub type ExtSriovCapability<'a> =3D ConfigSpace<'a, ExtSriovRegs>;
>> +
>> +/// A decoded VF memory BAR.
>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +pub struct ExtSriovVfBar {
>> +    address: u64,
>> +    is_64bit: bool,
>> +    next_index: usize,
>> +}
>> +
>> +impl ExtSriovVfBar {
>> +    /// Returns the BAR address without PCI attribute bits.
>> +    #[inline]
>> +    pub fn address(&self) -> u64 {
>> +        self.address
>> +    }
>> +
>> +    /// Returns whether the BAR is 64-bit.
>> +    #[inline]
>> +    pub fn is_64bit(&self) -> bool {
>> +        self.is_64bit
>> +    }
>> +
>> +    /// Returns the configuration-space slot index of the next logical =
BAR.
>> +    #[inline]
>> +    pub fn next_index(&self) -> usize {
>> +        self.next_index
>> +    }
>> +}
>> +
>> +impl ConfigSpace<'_, ExtSriovRegs> {
>> +    /// Reads and decodes the VF memory BAR at configuration-space slot=
 `bar_index`.
>> +    #[inline]
>> +    pub fn read_vf_bar(&self, bar_index: usize) -> Result<ExtSriovVfBar=
> {
>
> Do you expect people to pass in a random index instead of 0 or next_index=
? If
> not, this should be an iterator. Otherwise it'd be possible to index into=
 high
> part of 64-bit address.

I made a similar suggestion on patch 3 [1], and I think Zhi kept the
index for ergonomic reasons. But given that not all indices within range
are valid, an iterator indeed sounds safer.

[1] https://lore.kernel.org/all/DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com/

>
>> +        if bar_index >=3D NUM_VF_BARS {
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        let low =3D crate::io_read!(*self, .vf_bar[try: bar_index]);
>
> Given the bound checking above I'd use `panic: ` here.

Or better, one could just remove the `if bar_index >=3D ...` block, and
keep the `try:`. That way it will be used for what is was designed for,
the bounds checking will be done against the actual size of the array
and not a constant that also happens to be used as the array size, and a
dedicated error code will be returned instead of the ubiquitous
`EINVAL`.

>
>> +        if low & bindings::PCI_BASE_ADDRESS_SPACE !=3D bindings::PCI_BA=
SE_ADDRESS_SPACE_MEMORY {
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        let is_64bit =3D low & bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
>> +            =3D=3D bindings::PCI_BASE_ADDRESS_MEM_TYPE_64;
>> +        let following_index =3D bar_index.checked_add(1).ok_or(EINVAL)?=
;
>
> Just use operator here as it cannot overflow.
>
>> +
>> +        let (address, next_index) =3D if is_64bit {
>> +            if following_index >=3D NUM_VF_BARS {
>> +                return Err(EINVAL);
>> +            }
>> +
>> +            let high =3D crate::io_read!(*self, .vf_bar[try: following_=
index]);
>
> Same here.

And here as well removing the `if` block should do the trick.
