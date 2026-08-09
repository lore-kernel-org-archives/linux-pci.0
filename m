Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8783793D2;
	Sun,  9 Aug 2026 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242497; cv=fail; b=SU7WFHIhQG0al0fk6WkwAajpley/8jB8Q4jSvO/zjG0UKDuLpGqQweSD5pneSZdb0l5/J0JzJuxfHRQj1KK7qwiO+K2Oq2AIvLa3eQYu8kV6MEY7yMioX7X8Gq9VJEL1baTpsjSsqT7oAsDZDHcQSOdJ0ONZMqz3oylEGpql+vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242497; c=relaxed/simple;
	bh=rgyTlKCja6cBlbtzI0I1hWovnJb2IjoZf2ssj2rfoPI=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=HnmAdCBkbcP1ERrC7YTRkyJFDpqY+cbFdCv4FR6B3thlbvDwHosFjz1a6DZrd3QfDKvORHPVZAHeqneZqpRS2TjGTUYFZUoJ9z9AoSgdRtVkrD8+3DLT65G3l1BWN04hyUYVsiiG0j8xGnuKbZTuOKd03n3d5ivuSqNKskipU4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GMYtaW9n; arc=fail smtp.client-ip=52.101.56.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMYtaW9n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5dxPKWxhqQlzO447HRyXdUKDpyc5AzGqQkzwlgoaxPOopT+5wav0brtjpME/fzdU27uME5BsrCcOrJ8vAblQCoF4QHMXsOM4LypvLpo95Y348cGKUowc4z7Hszi7NIsRQRxBHlkTGh8dynVtMhIw6cfz8RV5BcR6wfFcN/xl6T3hylKsiaE7cAyTX+reBEPcZfsRj6oz9bk2Yn/JGyG+LYGBBd/dklVlKelMKRMAQrx4JeRIryacyMsQFxHnOLPZcQQb1D7V1meYCEtQBSDMMwM17Hn0g6Q+UCtC5Ix6N1K6F0rPk1XQV38orGeZAmycQ/PI8+BJzTQWvY+sIiOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUbehqVJy6M46NEHWFkaLX6BUDElgEbDq5/uAk1gLj8=;
 b=pF1bcdl1k+xVs+6vMuJjYFfvF2H/iGnQMp888aZnK4mwY30RV6rHYm98eNM7zqCO8ul+wTIhLfOOqyFzplM9bmP03U3IEqe7oABSpcuOtirHc24d6+F3SSSEdxyndfHsPN8A8z/T12u1rI1CQRfiF79+gWvI564ui93nsE3NGDdeUkjj939u2/c6ym7Ax+xswQ35GUyEyYvi1DHbddvyv6Hs98KlYe86Ta92sOi/v6oXDWUQWIMn24OR3nX+wUu7KL4P//o/uggj2e2ZRvyj+YpCaSacRHxuCbzz7+zPKffAwAwH4Kso9Gv9ggtqbCwQkTPIWJGwuhKjRpqwnfIgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUbehqVJy6M46NEHWFkaLX6BUDElgEbDq5/uAk1gLj8=;
 b=GMYtaW9n75eQ6zAZGcQH/BVhESwENv9Q3CWKoy87hJBLRpOkk6fzbk/G4tMv4OVMgiIvS9ZAIzLnyPi9qQ6S2C60tcV1fljhozNlu/QMiX/zoFS8/yCK/mmbHmVQs+XM5bG/J61A2zM/LaxpSYdh1OO2JpjsVAgYAbxIvHt35a713SefMdFuMAMY3Mx5T9pJ3h9L3OpzpAoSmsAzfcpjd79pq9kCVvgZJNkQ1vRjxqod81VXmkVf8CqWXEcqMcbJ0gKWyC9qGVDKYBZbv6MJFkro29qLYh0IY/HgvS6O2jfu1P7SWRPAxBFMLhDnmJJbY0ghXhTAHqMfHuVc6o3BvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 02:28:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Sun, 9 Aug 2026
 02:28:12 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 11:28:08 +0900
Message-Id: <DKK246QYKWR1.I2FB90993SZS@nvidia.com>
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260730182954.783568-1-zhiw@nvidia.com>
 <20260730182954.783568-2-zhiw@nvidia.com>
 <DKCOUE9DRG5R.2VAVA78UTVKST@nvidia.com> <20260804121116.23d9347d@inno-dell>
In-Reply-To: <20260804121116.23d9347d@inno-dell>
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 303325db-108c-43c9-be55-08def5bddbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MWMc88a1qCbE/qdk8oKB3bJVn6OZs6p0chmqnnos50Cc26f/1pKHEngcLEaGRG2SuHITIngLjVhZDEr3xi3CTgMd1Pm86wcj1g7oePHYUqdS1P+z3g8ExfJEyYe9NDQOwEN4x2YbRZtgvwHPCVTCCNo0nn7xIG0ji5YHT3ttU/8J2PZGOecm/bJm5N29n5jVv5LiJIXht/492orjyOsP9eR5WtpuypVRLbioncZbtva1gIfxI0KGzmZz8jSne8WBKyoN2ft9Xg60Lggbapv2hVwhW562ocBDXVXmYDoeCwaN+fyfxUqXvKivaJXIXpI4fjz9KqJo1E7v2S3sm+Dv9qWEdItz5JCSssSBdM4Vc2JdFdiwPh/SEXZqxPZZ/S5iYz0HS04vgNoFbSAKL3/fPyrOq+IrVxG+FmFDR95wcMb0gysnakrrvl6E4k4sVq7TVl2oOf/cas9C+6tasOFWjBRpeRJLrCi50D25a0w4iND8peZ3OBiZ6JrOE/gqkFPuYfeFJvTV13HIkQEccZBVfw5CoKtuoKc0jxshYf9UI2aFbbl3XiyNwRY/HsYy+h+kAHGcUnD8Y/8z1xTcCK6pDceQH+YNDCp0jZqZM7SgnACCml8dlIArWckX1e0WBnResonjJbYMSnW/l8aPjTl288qJkF8o2o68zxewGfTyBO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXBSM1FUMHFNRm1Velp0Z0JvTExuOWhwelpmbWpzREdSSjEvTzVRSG4wZnA0?=
 =?utf-8?B?bUphSUtOekYvbnJBT3FrMjR1eDVEbkNUc3RxaHpwdWpRVFZBaUgzaFczZHYx?=
 =?utf-8?B?b2R0Tm4zMzFraGY4OUpjVkJuWVJKcFhDekFlRjdOd2F2ZytKazgyU2pEOFpu?=
 =?utf-8?B?K1ZHT0k2emZFRnpiUmN3WkVzaFNhWXRua1g4Ynd4M3VpTkdZdWdZRzJkRW1C?=
 =?utf-8?B?V2YxWXBMNDNiVjk5YThRS0tRUFoyRUcwK3hXMW1rSDZMRkhvcTZXL2I3VTUx?=
 =?utf-8?B?eGtxb2I0dVcxMFNPZ2Q3WWZKZmUyckhJNVVJbmYzN2xLUmxGUEdjVWl0T1pQ?=
 =?utf-8?B?LzlSTUR1MWxsZEtGN056ZU5DSldvRHUwbkFRNmw5Q1RDRy8vS1picng5M1h2?=
 =?utf-8?B?c1VuaGFTMG1tc2pTWXIvYUtvQm5aSEk0cnc5aXQxOHcwbnRmaDV2MHpkM29W?=
 =?utf-8?B?M2FyM0EyRkJvaGNZQ0lFQnJtTkRVeGVsM3RvNHZWWTFMei9QVFJnb2UySmVa?=
 =?utf-8?B?SDBxZS9UbEx6bVpJcEd4YTlBMHY2b0hzN1dydzdkL2xkY1ExQTZHVFQ5bEQr?=
 =?utf-8?B?TzhRZkxGOGxrT0U3NXNLM2QzYy9WSCtCajkzaEJWUmVaVDllL2pIcy9XVnJX?=
 =?utf-8?B?T0QwM28waGdjLzU0VUFhcTRtQVd0N2pHTEptcjVLaURDSkNDU3Y1TTlnWFZj?=
 =?utf-8?B?SWpVL1JFaVpVVEdXTithRFk0SkRpR0hGbkhBRnhEUS9weE5qeXRTaUZDMERT?=
 =?utf-8?B?WGtxdVYzZlBCWmdzN3dCSkJ4bzRnbmpicGlHYjk2cHJoWGVSR01zWDN1dFpG?=
 =?utf-8?B?bjdWOU1TOGhtcW91NUpVdEVQY0RwSHIwek5nRTdQVkFQaWxxa1RTN2ZtUEl5?=
 =?utf-8?B?MDRSYnFSdDM1UFRKSkpHR2ZWeW9lMkNtZzJMaUpWYmRISzhtZVp5NmRxVUt6?=
 =?utf-8?B?aEttY0V6bG1Rb1pDZ0doVzhSYkJkWFdPL0RRL1VLaFJoVUxHNytFR29QOGJh?=
 =?utf-8?B?SExuRW04bHJVTGRSaS9DWmhIY3FrREhyWXpGT21vdi9iZWlqVy9tNzJEa1I1?=
 =?utf-8?B?Ky9qanVGS1krc1RSQ0ozN1RWZjA2aUZYODFabkR5aVo4aisvSHFyZ2swdFc0?=
 =?utf-8?B?Wis5dmpiRElBUTBwM2ljUytiMnFBTXJBMi9FdFY0ODJ3cUpxb3RLSFQxMGhM?=
 =?utf-8?B?V3FkdTdTN0U4VlRuYXRsTUdyL25VaWhHRkNOZkVROU1NUW85K0FmUS9oSGZW?=
 =?utf-8?B?RHl1SHB0MnZWajBqSWNtR2ZLMERGamVmSTF4em5saXErZzNVTFpLRHRla1Ir?=
 =?utf-8?B?ZXZGZ2FFMlQrRU9UUmFON21paUJjWm13K0hiNTgzMVJ2YlNaN3dRWnRibUts?=
 =?utf-8?B?cmR5UUdOMmwrWDNsZmJEbTZ6Y1F0TTlJSDcxeGVzYUk4akZpVXVTUlRET1lK?=
 =?utf-8?B?SnpQRDV0SFVRdlR6K1BzcnVyQXZsVmNQY1AvYXlOaDZ4TjlhcmJ5OThadkdB?=
 =?utf-8?B?WWIyYUlENEg0SVRPNGpkeVc5TFRNODhHODZCcFFrdTdiaG9XZ0pTcjlJQkEx?=
 =?utf-8?B?R3UzSlRRYWoxajNJbkQ3QXFkV1hReGNLTVdNOExJclNFSjRETEEyMHo4cFhk?=
 =?utf-8?B?QUR5bXpQNFRWSThBYWMzWllFYWVkUTlTQlgwOGV0eGFaTzZEZERvWnlxVjls?=
 =?utf-8?B?ZHRYUVdqUWZWMDRUbkx0RmFrcUlYTW5ob1dTaFJCVFBsbkpicU54bzdWZ2Ux?=
 =?utf-8?B?c3FFSGRJRjNHU2NBNlRNbzF6NThWaWxKa081N2xRUzU2cGdHSU00Z1VldGN4?=
 =?utf-8?B?QXBDdEVPQnJacEgyZC9Xdi8ybjhicXZubTU4OGFQck1ON3l0cEUvSzBBTmkw?=
 =?utf-8?B?aWFubFNzZGNLeS9YZmY1TkhldTVJUDA1K3FHWnJPc05sTDZsNVJ1R1gvSk5U?=
 =?utf-8?B?R3d4NUl4bnVrTDZicno3SGtrL09CNllsM3F3RzRaZFRnS1lNcUh5WXd5RFIr?=
 =?utf-8?B?djVyY3hLTys1WlJVbHpFMGFrQ3JhWkV2TCs3VUdCS3lpY2RZQ0N0RUpyNlRs?=
 =?utf-8?B?alVjbS8vUHZjdGtEWkRxd1RmZGRwMFJhVy8yMGloQlAxQ3dPK1g0eE1uVEpD?=
 =?utf-8?B?ZXdmR0JBc2gvZXFLdmN6U1ZVaE5raFErMy96UDRqRy9TaHc0TWdvSWhMeUlz?=
 =?utf-8?B?Y1hTaUxuZmRZMkl2c1pFNDY2QjdIdDFqaTl1S2hpYjl4VlRwTVREV3JnRTVv?=
 =?utf-8?B?Sy9KMTdSLzZrV1c1TXY2c2RrMHBCOWJkalpmMUlia295aDdWbXAyNWdjbmlm?=
 =?utf-8?B?VytmQkdTN3dzOE5HTkxQYVMrSE5qZXlKK0R0RlhOQXU0RDJ4ZW04cXNHR05m?=
 =?utf-8?Q?a2vEeN0vECqr0QjqoQ/XV1P/nUtSNHfgi4ZDANfzd1DtZ?=
X-MS-Exchange-AntiSpam-MessageData-1: Rm+AhMLhDKVQSg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303325db-108c-43c9-be55-08def5bddbcb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 02:28:12.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PiQkjDTiDePgAeNcpcUbo6i95Mn2l8kxtHcN/KfpFoh9h2FQqOnE2XDw0/oyWTDT3pjHAL/gt0nu+ewasFpFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

On Tue Aug 4, 2026 at 6:11 PM JST, Zhi Wang wrote:
<...>
>> > +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap
>> > offset). +#[repr(C)]
>> > +#[derive(FromBytes, IntoBytes)]
>> > +pub struct ExtSriovRegs {
>> > +    /// Extended capability header.
>> > +    pub header: u32,
>> > +    /// SR-IOV capabilities.
>> > +    pub cap: u32,
>> > +    /// SR-IOV control.
>> > +    pub ctrl: u16,
>> > +    /// SR-IOV status.
>> > +    pub status: u16,
>> > +    /// Initial VFs.
>> > +    pub initial_vfs: u16,
>> > +    /// Total VFs.
>> > +    pub total_vfs: u16,
>> > +    /// Number of VFs.
>> > +    pub num_vfs: u16,
>> > +    /// Function dependency link.
>> > +    pub func_dep_link: u8,
>> > +    _reserved_0: u8,
>> > +    /// First VF offset.
>> > +    pub vf_offset: u16,
>> > +    /// VF stride.
>> > +    pub vf_stride: u16,
>> > +    _reserved_1: u16,
>> > +    /// VF device ID.
>> > +    pub vf_device_id: u16,
>> > +    /// Supported page sizes.
>> > +    pub supported_page_sizes: u32,
>> > +    /// System page size.
>> > +    pub system_page_size: u32,
>> > +    /// VF BARs (BAR0=E2=80=93BAR5).
>> > +    pub vf_bar: [u32; NUM_VF_BARS],
>> > +    /// VF migration state array offset.
>> > +    pub migration_state: u32,
>> > +}
>>=20
>> Side-note: It would be interesting if we could end up representing
>> every I/O space this way, although padding and keeping the fields
>> offsets visible would make this challenging. But if we can eventually
>> generalize this, then I guess we can retire the `register!` macro. :)
>>=20
>
> That sounds interesting idea. :) My understanding is io projection
> covers the operations of the registers but not about the fields in the
> registers. Are you thinking to extend it to cover the register fields
> as well?

Registers are basically bitfields with I/O location information. If you
store a bitfield type in the struct, and use projections to access it,
then you can access the individual fields through the bitfield type.
