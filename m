Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9F1FD4;
	Sun,  6 Sep 2026 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788657888; cv=fail; b=N+378wH44OWkUqXQNKaMoR9Qrrl/6zm2ei9GBWBwQKWn+OO8NwLZ6cd8sAY4P+pGez/w2Peepgcm4KhjI+9BSPzJa1CT7+UqKNMS6HFRhpZkp9Fxq5pm1p1MR0YilO7NwRDDDhZVdYKjPStYDl9BuxPlPlwdR9N4dGrfiseq2v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788657888; c=relaxed/simple;
	bh=ruqMbTcFnSmUQN9PeWqi2Cyp7L3t8Nw+6GqOsrjZd+w=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Ueob7GoaZ2qL89oQTItQi62o5PXNQwaUYu1nnhoUzsp8TXLd4dlkyW8bugcQ7d6DD2lYCEdaSC5ktZFlDieOuFBB72Ooid7Lz5K5hIVwHSDfUj6a/JwnC4PGjXBpg7gcBJRMKAN+ReBMPfJs53U8tLuiiRLmGk2HRgp11GJI01g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZgjWsHL; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZgjWsHL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7rPwP7cSBUX2a/RAH92076UiZb9cBzqqSyvosH6MbBkQzzdNSt5FKNxHyfmlc+oVYlWPGFvwsmpGgMk3+g/XQ2hVNVulJwVUlagJ9OyiIQK9QqYQYcPLpfDRxD6Ii11p+waz5z66NvtwmKmmlRHZYg1PMvC5+H976iaI7ufB6AGU4S7hqENEFps5kM1HJrf8lQnXIttp8yve0XNlAg01mLG0C480vYlmDNCnss0WUcN+RBH6PS9DuPF6BT9a+7CcwXvyCg6EeU8lRcjGRytcKWBBwkqMEtH5lXvKa58kSFLmEqIOrRK2UATKAPrNHYevmigopVYg49ODksvTdCLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruqMbTcFnSmUQN9PeWqi2Cyp7L3t8Nw+6GqOsrjZd+w=;
 b=ed3BhPvGb3VVPxPjfiFANxLoHMfY5L5BFAlurIkvb1BvUzEHfCBkMV5+zQxCcKCiT6G1ZDFXLOU6A1h+P9pwqSMIDnBRc3t4v+TEqWRXxY/8ymaxVBvxxLkrcxkBGzz18n057770c5GWBqfY7o6pECERybOan6aCNA5sXiCa61ro7h3uTHEYsihYw7VYA5Oi3OlJLUhlEg7IGDH8ishekFAdC1RAz1cCnRCW6g5mRDP8ljqFS/qky1q8lPcKtJhh3D3tkVgPMq97MRGj8d5h+DPyvrPEzCbQh6YfAuYj1//Aw4hreaHJL5RhJKo3xzyq+8IQJIENOawPQKHLoT/1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruqMbTcFnSmUQN9PeWqi2Cyp7L3t8Nw+6GqOsrjZd+w=;
 b=gZgjWsHL0kAYeTvqY/UvQQPPh39hruQrsiViPbxWox53f+hfbE8uoF2/j1MJGf9jJFuE0usRebd5LAQ9O60zEwfQ23b1JcFnXLkdTofYI/6ryU2KZ1jtPJH93oQqMq6Xjs1ubdNVZ4JCMkZWtPTOnwcG1X3OwGTxWRgHzC00j1SkuGnIEwtG+etSal9iOfVWcQfs9XHcwSm5t+b1Cb2o6foEm0FrFJDL5Btgk4es1lsKCnAXw+seiCiV1KafBlLhNJQ1gM9vx7/A6R3SDdomrhkquOdKCt7sPKFvPs1BKsWRpfMdIR7EBvarP/xRHVkzEOUPMGjU7qhTAXNxVeBVmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 6 Sep
 2026 01:24:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 01:24:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 10:24:39 +0900
Message-Id: <DL7UAU8JQMJP.JBZ591QQ7LPH@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, <joelagnelf@nvidia.com>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v9 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <cover.1787830828.git.zhiw@nvidia.com>
 <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
In-Reply-To: <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: aa26effd-3e7e-4323-7845-08df0bb5a0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	oARc0/DsPUBPuTDkPuiTMEqYlMyOcOmgeOnK1adbXia23XFaAbCg2CYc+ZQe05FUvsp0cpaiZkgbTDR/IpxT3S1+v5RfpYK2ssy5yrghgmyzJWnfl2fv9qsdyi9WDBY4SZDP9sdQYc9quliCuJZheumSr8xb4Dy+jRuYRQPTmXfkpybFOZey7+Oy8NQAvJ6DRhJzbxDFcQoAarHUIZLfwzEINZLncax4iCX+/tcQJqjecSRoG4bIhxNmJhooU69uOSOSJIaK8OfWk3d73c/LwmvNYN7Q0TQfQdAUMef2XK/ihPnU3eXpXKSgNS2aWO34DBAllHGe9eLJHAuNeQkIxATBiKHNbRF24XfPRTYE0jOm35MP2eJR7AnQC1fC5ApB3TOplILoC7zl9tTfgmkblvN34LicRkcn9mGIQJhbyxqlBuJxuvimI6zxbg3u7xb64lns4sXg6CBLOolxTJIhmPEaVI7bHFCkl1VZXaTNi95Bx6sjrR6JTjG9x+M35UH2aVZ+ibFehRLx9i6Bqg+t7fL0ctmAmpJ2ynGdNXWMhut2tdyyrsFbXneVucpC+3IcZo4nvxOyeCHsL40YSW0Dax7qHmgcasGOlbvr0KE49t3i8cMxCbeF+1tb2JZtZ+4CLsRRSJRNWrT2CnbEADP9eAFLBxZxVSLsM9TpVGp/XNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmZGeVpOT0hPNGo1WXJVVUZRQXVBU1hobm1paUtwaDk3ekFWdTNCWHVnRlhk?=
 =?utf-8?B?ZGllTmM1T1dQTEQ0OGtWRXRjck95cHp2cGw2UjM1eVdKVnZDSDdrY2I4VGtr?=
 =?utf-8?B?T0QrMWlMd2JwdWZPN0ZrbnZPUU81Q2JJY3NaTUtHbVZ3VnJ2dlYxV2xFT1Nh?=
 =?utf-8?B?c1lPWUV6dFRVRTFzR0s4SFNscThEaG9FcFBVZDJ3d3QzdXRqMzkvc3JPUjJ2?=
 =?utf-8?B?M0doQjd3bWZDU3ZGUFk1dFJsc2F0T1doVTBxNUVEVVNjOEt3UXlOSmZ5RURr?=
 =?utf-8?B?NUtKc1VaYzR0ZnhQVWRNeitQenAxNFdvbkQ1NStrT2xXRWVjdjZBWnVDK2xC?=
 =?utf-8?B?OHNuaXJORHY5ekJlQkJYWjJjbjB1NENkT09LVjZPZ2FrU3BJU0grQVVWbERK?=
 =?utf-8?B?WDgzaGsyZ3E2SERGYVhydVY2QmZBcVk2ay9lc1RtUTAzNUVENGdHSlZPK1Ry?=
 =?utf-8?B?eHhEWmkwU0N6UUNEMXZ6Sng3NXdxd1ppWk9UUkpMdTIwY3NEUml3M3RoQWVJ?=
 =?utf-8?B?K1Q2Y2VUaFVEeU9zcnRpeU1MeXFuMHBLN0ZZUGhyMVU5ZEZ6QjhGZjgwTUtW?=
 =?utf-8?B?eGFFcjlvd1lEenlIUUVxYk01b2xINE0vc0NhY09CcnkwQzkwWHdQQWV0STV5?=
 =?utf-8?B?dnNiMWQydHpZdnEvZ0pabDVaa3RhUlJEMC95ekErY3h3TEh1VUwzdW1kMjZ3?=
 =?utf-8?B?VjZzU2todzZXMG1RQnFTUnU4NzNMSjVpU1BTQjN2U25jRVpwMkZ6RmJzTGZF?=
 =?utf-8?B?dFJlU1BDSXZpVTlLSlZlMS9hUlpuTDk3ZjJjZlJYZlAzWlU3Y2RXdjJybnZQ?=
 =?utf-8?B?ZXNMMjlZWThXcU1IN2R2cVU0MWRlWEM1aHBlb21HQ2xXM0VGeW13SVZFZXhG?=
 =?utf-8?B?ZkhmTEpQZnhVRmhYN05hdmJDbGliY3BsZjJ1bjdyamdYaW5OR1N2b21uMTNZ?=
 =?utf-8?B?YnZ5M1BtUG0wZytaem1iaHJ2Q0llM2w5NTdLVjlvcTg3dG5rTnJDcnVCYWF5?=
 =?utf-8?B?VktRckRBeEVEVW9MTHl6TytXV2VWUmZnY2JGdnJqRFlSZU9OVGNiTXd1MzZq?=
 =?utf-8?B?ZExrME84RnlVU2ZFRVc1TkpEZXJpYmV6dzZ2Q2FVVkVjRGRFS3ZPNEtQUjRn?=
 =?utf-8?B?ZW9TR3ZyaXFqcEhZUGNJL0tjckRLaEViVjlQRU1VRm92Mm5VYzlzNHFLWkVQ?=
 =?utf-8?B?NWZiRU9jSWhVU1NjeU9EMnpGWERGNWJlSGlVMFM3amxnQ01TU1BvTmpCTlYv?=
 =?utf-8?B?VVd2YkcremM2RDQ0NDVsRHYyd254OXhqeFM5Rk5kSGJiYnNQcXkyOFRYSWE3?=
 =?utf-8?B?bHFjTzBSejVDd2F6TEJrbWVOdDByY1JuakhqQkdwQ2h0b093T2MyMFo0KzNJ?=
 =?utf-8?B?OHZMdnE3WVBuR3RyRk96K0hpcVM2cDY1ajhaaTRWK3FBL0NTdG1SeE5sczRw?=
 =?utf-8?B?REZ2MTA5NVpEdTRsUHRaRWszeUtFeGNjWkF0eEtNMjhBbThHcVRTcWc4UnVD?=
 =?utf-8?B?SHJYYlFnR0x4Si9PMEI2aFh6Z2R6a1B3YlZGV282YkxKY3BMM0ZLQzlYVFdy?=
 =?utf-8?B?UmkxUnEybGJKNXhSdzdxWHVoWkIwK1dORzZXRWx5dnVvdEZ3MkdnbnZKRDYw?=
 =?utf-8?B?RDdBU1IvQUxZMlRkRXNPeUdqTFFUT2YvUkJWSTNpMWRrZm5rZ2RmLzRLVGJr?=
 =?utf-8?B?U0VaTTZUWnFERzFsY1ZTUTBZdTYwa0JGSWpGUWFxVmVLcVc2NlNrQXloam9B?=
 =?utf-8?B?b2hiV0EwVGY5SEQrZHZpNlRiSXFlVTRtcWJtNFY5cTlEQ29BWVVIOXlzTzlC?=
 =?utf-8?B?ZGhPaklzQTlPaWJaMnBuYnRqZHEraFF4TnY1YlYxamhPMElqK0k1M2VjaUoz?=
 =?utf-8?B?V0NEWDg4a3VmaEF4RXFGQStBQXY0SzExUHhmQThzdFRFS0wvVml3WWI2SFpk?=
 =?utf-8?B?bEFTRFZLNEFhdzg5dEllbkR5d1g1TldDYmZZTjhqOVZ3SzRkUHA3YUFxUlg2?=
 =?utf-8?B?Nzk0TktaeE5lWEZKZVZqeGFudGM2ZDd5ZlFxZFdtbWR0dTA0UDBOQlhyenh5?=
 =?utf-8?B?L3lnOW1kZXY5RHh6eWlmZlJJY2ptVlBxS0lIdm9wcm9hdk9RS0JueXVwbXEy?=
 =?utf-8?B?Um5CK1pyMlRJR1E0VGJvaDhVRlBFaEZOMFo3R2pZVTFHK1dub3k3blJkd2Zo?=
 =?utf-8?B?ZFZSS3hGUXMzL1c0VkZRZ2EwNWk1c1daamF5LzhtdVNFcm1UNEh0NW5uZDBP?=
 =?utf-8?B?djAvWUVqbmY4RGZyazZQamRKYkVxdnI3b3BmQndXc1M2dzZSaXJuOEdBeTZp?=
 =?utf-8?B?WXI1dE54Um92RkwrbVhuRUozMlNKZnl3T3FOKzd1WkdGK2xNWkNrM0E2QzVa?=
 =?utf-8?Q?dpoibflFokWro1orHP30p8dj40PBf0urt9CfhgVNAIPPy?=
X-MS-Exchange-AntiSpam-MessageData-1: Ll/hmJZTXgkQ8g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa26effd-3e7e-4323-7845-08df0bb5a0bd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 01:24:43.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTQ9OoLYLoe1yV5ra7ECUK7RbzTpPr1R9d7y+VjjGFPI5r0ska8Ftfev54RtdcGW0jUz2iTFj3JRrb6fnqj3tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937

On Thu Aug 27, 2026 at 9:18 PM JST, Zhi Wang wrote:
> Rust PCI drivers have no typed interface for locating and accessing PCIe
> extended capabilities.
>
> The SR-IOV extended capability describes VF topology and VF BARs. Expose
> this information through the Rust PCI abstraction so drivers can use the
> existing typed configuration-space accessors instead of raw bindings.
>
> Define ExtCapability to associate a capability ID with a register layout,
> and add ConfigSpace::find_ext_capability() to locate and project that
> layout. Bound the view at the next capability or the end of extended
> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
> reads and validates all six VF BAR register slots up front, yields decode=
d
> BAR addresses and widths in logical order, and keeps the raw
> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() i=
s
> a function-like macro, expose it through a Rust helper.
>
> Keep raw SR-IOV registers private because PCI core owns their state. Expo=
se
> the current First VF Offset through a read-only accessor because the Nova
> GSP ABI needs the raw 16-bit First VF Offset in Routing ID space. The
> pci_iov_virtfn_devfn() helper instead returns the low eight bits of a
> calculated VF Routing ID.
>
> Link: https://lore.kernel.org/rust-for-linux/20260818084633.1673214-2-zhi=
w@nvidia.com/
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Gary Guo <gary@garyguo.net>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
