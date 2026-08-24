Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020084.outbound.protection.outlook.com [52.101.195.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3B4964F;
	Mon, 24 Aug 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568542; cv=fail; b=OjT98THfNrLivqX6V3Gz38lNlODOBVkFxjoVPpm9QTd+26NNyk8shtZRV/7Jx74t18l5Yny3N56++Apmu6ODL+GSMqf5RlQ6HyPZye1gRz6PdyN5ChF9zPk1b2+E+RFw7rh7Dlc5PW39HblxfQ+yAnSS0+ZWHNhrnQsEb7wwY70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568542; c=relaxed/simple;
	bh=bke8+grBf1HJMjJ/TXbAyTy1ohxwPWQENs4X6iYYglM=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=OyhL6C7LkC9mn7p8tzPqGH6YX3iE4n/BBBXhRbRgcj4sSTijwzXXv1wXZvaNp8rpU+HONFDfrHv9j8LReqwmEYIp7ZR344DbEKEdUGoOuSXTtEm/DAaIweRJw3XEit4a99FDciZ+Xd9YHxuCDWyuL40sL65ey0tV4ckgRBLmCYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MVDxWYvb; arc=fail smtp.client-ip=52.101.195.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MVDxWYvb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bySD8hj1edB4d3GH3vi4hhYyGe2bzW//Pgwa1U1sD5PIb/UmEk9j1aohUJqPbtVIg8s6MjKPl75eBDpB4iev7/wIYxIVNgbGUBWHnB9IVzFFuybOezldRLRSzujNN2xvH8KX5qsz4lOboKucrzH8PDAIH0254g2rvGdhUFertzwB443+RHki31AasqGbJf52o77YUEMSKteEm0LDPAE8R5br99o/bUrPeNLWhdWVdTQjDle+em7Ta/tHmQ0Ei/n1DM0+APK8ATFsiaIIzCZ4EJECZjwBrtTj6LjDTQdC/i31136vjFDNsYCGqL68gvwjF2GlSRChhcmE9xA4U7bokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUfwrjgx3I0WEKxMcd1tfqTMlx2bWo78bUqicrn9t6Q=;
 b=C+gz/NbGwyAPd/a6X4w93A9IgfufUjkQ9INsPNJriZDy7P9JqYcpxWPH4sOiXW0UBcDDb6mUOsguHCT6U5BYAaD6WhE7oDQKkYyEbHvKf3f5MJWVYvAAo2LTlPapDWi64/8Udp61BLQ4f8g2aVAZyzGDdeRyzzZ15znrQe/fAYupr7j6hVA4/xQuTZHPx75LDjKHXhnlEe3X9dwwwy58lNkjRyuPSvQzhOZOCg/jxu8upU8kQ4PizIsOqIcAAnC8Geo6PpuMnOrFhpS03srJjvlcFd1uCrEvFvV9vuJOwpP4JaFCc9BhF7BogcIjav/8udvL8VOdr708PCu8HWrANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUfwrjgx3I0WEKxMcd1tfqTMlx2bWo78bUqicrn9t6Q=;
 b=MVDxWYvbd6QDm1KZ728wNrZDO66QbW8rP8iMJ8mWMi2FFtLnZry+zVT1WV8i911VBU2mMvGmd45/1RQWFN5O6IiubPw+rH8hEDhs973flcvc/ljP+WLjCSNiGEW8fQnE2uit0m+dm6DLFn1IBgAS6RthCggRU89dXltNWsV6h/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6045.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:48:55 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:48:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 11:48:50 +0100
Message-Id: <DKX45Q1J5M9O.27TM3TUTQH761@garyguo.net>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
In-Reply-To: <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0e0c1c-1c14-485f-4333-08df01cd4ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6HwjtUmsKunxkKpHBH349B1Zk4DcFN/YUi9gbyWzTvP13ZcAGTl9PSf8yrKqZC8H6CoWrsibjkY5UpDNDYh2C1fgTFT4nV3f18MuIQUFF5nhDNfFSCSPGWOfNzRhtcHMon/ARv+yRdbyOKQUygCgTT4ZpZcswUuIhvNFgQO9hv+mUTqL8dPaSv1mOtGxB+6KsEXOT0P+T9r1SDVvhBPnnZhn68TErawOowkgUG5HY+sY7uZkkZprdYr9GZ1XYNd72Z/qZK4BMc/65jyKW0/iWaMS2AqtScXktz5Pu4Z3UbsFs7IZdoRAjcA5edPkKUunRvfYuwff0LOwA6I5oprUrxv4lc88mtC5et6gMNlRWkmK5gg8Y+mN+6GRNy4kx5VwUerfNzY5fxPlynEZn5KDox8ULyqrTRWSjjm/fzWjjOKPZDFnqdJbLRs/kbEMzagPgTkl0n+Y7oSLFXY9FCkgtmnoNAqeZlsFW+NzWBWihdcAGWyYu3zLKnTwrlbi8E/tSIYczCnFCiY2rbNhIzT6wfV9zCPZ9u9aThZInWvBT4eHO3FZ1wkm7i4cX1oodarobE8aChPk78qSnmuw8kqMZ2YWdq1hFqVyBao4JXHv5g8vNkCnx1lwAQWSrkwE8MgWbjngd1yWuJeEGJM8gz6uloQA9r3w3uyk6DPWNgoRJL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXBnR0dQdlFxcDl2aTR0TDdpamtBSVg5MUVCQ3JYUXdsaGpBNEo4QlVjZEhu?=
 =?utf-8?B?WkNGM3hTcjQ4SzQzMFpCbkhzOWpEVmpFVVpKQlErblZXSm1ZcVl4R3VZZ3Z6?=
 =?utf-8?B?djMrQ2xzYklBZURGSk0vRGxTcndmWVB0Y0tObTY3dGtNcjVWZ3pLaGtwQUJN?=
 =?utf-8?B?TWFVRk9VZUoxUnBSUGxHTG9SbEFqU3NrbS94VDJTMzlOR3RlUGJhSEFuU1hl?=
 =?utf-8?B?c0RaWFNkYk9va2lpS2JvaEw0b0g5Q3hSdE8yS2tCc2VFbXVVQ1JLTFM1aW1y?=
 =?utf-8?B?TnJuZHFTQnkvaTZ1ZDkrakZ6WXhBcUpmbU1vQ2ZpOThJYmowSDlkUjc5ajZz?=
 =?utf-8?B?b2RvU25MZG1mU3BnUkNJTlFoMVBIeWFoME1EcG9mbC9wT3J4T1hwVlZGeFVH?=
 =?utf-8?B?anl2WlA1a0V3N2NJOTJRU1NtakRVZVhwQVFBYjBpWHBTV0tFeUg0VFBLUTlK?=
 =?utf-8?B?eTZZdkxWZk1MVkRFb0Rnai9Teng1RUIwbjI1K1BreE90QjlDYmVxMGpPY0xC?=
 =?utf-8?B?OFl6ZjJ5dWtUcExtdFQya2VlM3NFMnViZFV6ZjgyYjhyOFkwQlgrN1dSMU1R?=
 =?utf-8?B?VDRQMUgxdVozUW5tY0Y4M2RFYi9WUWhuWWlHczQzYjFPTHBzWU93V0g3dnV0?=
 =?utf-8?B?ck1tVUpyZ3o4L3Q4bnJoQzBlRFk3MlFWMFpxT0pOcTljeUsrTXlvYytXT3A3?=
 =?utf-8?B?MFRHZmUyL1JlTUZiRjJ3UkxFWlNVQnRDbm0xSkQ0b05uU0ZyeitQbXlCTzBr?=
 =?utf-8?B?emw4N3FYTmVCOExxalFGVTNVeUJYWjA4amJud2ZXR1UrVDlqNUNqL2JTeHBU?=
 =?utf-8?B?RnlCZCtDMk9yRmp3Nkw4Q2gvanJzM0JhV0ZZckRpeFJjKzFtVktXdWhFNjJY?=
 =?utf-8?B?N0c5azY0cytUMzBCei8zMXB5cUcvNmZPWldoOSswekxId2pRSG1vclY0V2xK?=
 =?utf-8?B?ZlF4QlBmQzN4K0VOaUptdWF5aG5BOUZncTlKM2ovdzdsc2IrV1QxbHhWQmgr?=
 =?utf-8?B?UjhaZU4yT2xsaWllT3BCYnpVbFpyYUZHUGE2MHNQWjg4OURZKzZId1B6NzdT?=
 =?utf-8?B?SzQ1TnZRTzRIU2JnRXFHMFVpOGJCczZMKzdFN1ovQ25rSDVaS0pxcjg3K01s?=
 =?utf-8?B?WnZUVk1nWUtDd2hkWDJRZnJrQllkUHVLdXU5Tkd1OUhTU0ZRT3VzeklDQzd0?=
 =?utf-8?B?WjJDZmtkdUhyYXpkOHBlR2gxYmtWN1BqYlZRcFIrYUN4OVo3Q2RQTFNzak01?=
 =?utf-8?B?MnVmbWRndUFNajNFVGo4dnUybWhlbVljQ2gxVit1Z3hvaW5VYlM5N2dxaEtp?=
 =?utf-8?B?VlpkT0JmOHNMcmp1UnNMT0J3ZU8wcHE4cnY1L1hWUnNRcXFrS0I5QnQ2bW0y?=
 =?utf-8?B?bkZsYlhyejFrN2xETGpVelM4alBLV3o2NWpTMm80Q3JabDBSSHFxWnNaVkdD?=
 =?utf-8?B?RlczRExXVHErWERqOUM1bXF5NTZqOGdONXRRREJiTU9vZ0NDbmlDQmh3bTVs?=
 =?utf-8?B?dUQrVDFHT2IxclpCUWprdThFZGtGZFZoRWU2WkxXVGhsSVh1VDloV0ZVZTlh?=
 =?utf-8?B?eVRiSEhPbVkxcmFKMkhMajlrZjloWXJXZkMxajd3c1BrcHRkZEUraDJ2VVpk?=
 =?utf-8?B?OExOc2NKQlg5S3YrdVRQeXdMMlFHVFhRSkw5KzhGejYxWVdqQ1drV3dva0ZR?=
 =?utf-8?B?RUw5YXJtTW5KQ25PNUNVazFVKzRpYTRqM2dSemZrN3RmK3F6ZXN5V1hhRHU1?=
 =?utf-8?B?Qys2b0dNUXRleldjVzBrZHBwK3pkRGNsWnkrV2g4anVvUWZNU040QVZ4Ykx5?=
 =?utf-8?B?SjVQemxUYkdoMTRSS1hRNDlPdXRKMmgwN0ZodWlhTHFrUGdoa1d1WGdHUDF4?=
 =?utf-8?B?cHJkU21wbjRXUGNqN2VySXhqdFp0Q1d0N1lJL1Uzclg3cmd2MnBsQ2g4S0dL?=
 =?utf-8?B?Z2hzdDhOSXRoaFhkVEp5VDY4YmxZcE5udzExcGhTZytFYVZTM0loSXpsUExK?=
 =?utf-8?B?Rm5Nc29wSnlkb1lHeUNjN3F1VktxbTc4Uy9vRGVGcUVDdHdJSkV4eUphMndq?=
 =?utf-8?B?bVAzd3dWU3BzMzVLWlU3NDRVWlJ4VjZBZElqYm5UZVhlT3BaTGlWTlEyV3M5?=
 =?utf-8?B?U2hQWGIrMXI3MDRtOW9zeUhpVXNqVWh0aERsLzVyMTkvSXV2VWlrTndqRHhT?=
 =?utf-8?B?VFIzcHNXYmtSdG5jQm8vN3dWME93TlJMZFRoOE9uZ2JFYnBVN0hzNVZpSGps?=
 =?utf-8?B?VjJQdFJzTTVpc2tBVVhCS1MxUmFVOWhuYjRTam92VkxUdDh2cVNRMlVNREo4?=
 =?utf-8?B?NktUWWRTVExxU0lTcmVIUll0K1pqRDB1ODJaN2wxUEdNakhWQ0lnQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0e0c1c-1c14-485f-4333-08df01cd4ac4
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:48:54.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qj65vHBp+Sr29pjfgQU2K47LU8Vl7b0X+4WOT1eoQkMbg0PgQsVrrxnO3HoLroiGRp1NHSXenYOdbbaSHhzeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6045

On Mon Aug 24, 2026 at 9:12 AM BST, Alexandre Courbot wrote:
> On Tue Aug 18, 2026 at 5:46 PM JST, Zhi Wang wrote:
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
>> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
>> reads and validates all six VF BAR register slots up front, yields decod=
ed
>> BAR addresses and widths in logical order, and keeps the raw
>> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() =
is
>> a function-like macro, expose it through a Rust helper.
>>
>> Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-zhi=
w@nvidia.com/
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>  rust/helpers/pci.c     |   5 +
>>  rust/kernel/pci.rs     |   8 +
>>  rust/kernel/pci/cap.rs | 329 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 342 insertions(+)
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
>> index 000000000000..ddb3fd73e195
>> --- /dev/null
>> +++ b/rust/kernel/pci/cap.rs
>> @@ -0,0 +1,329 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! PCI extended capability support.
>> +
>> +use super::{
>> +    io::ConfigSpaceBackend,
>> +    ConfigSpace,
>> +    Extended, //
>> +};
>
> Let's merge this block with the one below, i.e. using `crate::pci`?
>
>> +use crate::{
>> +    bindings,
>> +    io::{
>> +        Io,
>> +        IoBackend,
>> +        Region, //
>> +    },
>> +    num::Bounded,
>> +    prelude::*,
>> +};
>> +
>> +/// Number of VF BAR register slots in an SR-IOV capability.
>> +// CAST: `PCI_SRIOV_NUM_BARS` is the PCIe-specified number of VF BAR re=
gister slots and fits in
>> +// `usize`.
>> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
>
> The infallible casts module is now available in `master`. If you import
> `crate::num::casts` you can now turn this into
>
>     const NUM_VF_BARS: usize =3D casts::u32_as_usize(bindings::PCI_SRIOV_=
NUM_BARS);
>
> and remove the `CAST` comment.
>
>> +
>> +/// PCI extended capability IDs.
>> +#[repr(transparent)]
>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +pub struct ExtCapId(u16);
>> +
>> +impl ExtCapId {
>> +    /// Single Root I/O Virtualization.
>> +    // CAST: PCI extended capability IDs are 16-bit values defined by t=
he PCIe specification.
>> +    pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV as u1=
6);
>
> Same here, the `CAST` comment can be removed if you turn this line into
>
>     pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PCI_=
EXT_CAP_ID_SRIOV }>());

This looks horrible. I'd prefer `as`.

>> [snip]
>>
>> +
>> +        Ok(Self {
>> +            bars,
>> +            bar_count,
>> +            next_bar: 0,
>> +        })
>> +    }
>> +}
>> +
>> +impl Iterator for ExtSriovVfBars {
>> +    type Item =3D ExtSriovVfBar;
>> +
>> +    fn next(&mut self) -> Option<Self::Item> {
>> +        if self.next_bar >=3D self.bar_count {
>> +            return None;
>> +        }
>> +
>> +        let bar =3D self.bars[self.next_bar];
>> +        self.next_bar +=3D 1;
>> +        Some(bar)
>> +    }
>> +}
>> +
>> +impl ExtSriovCapability<'_> {
>> +    /// Returns an iterator over decoded VF BAR register encodings.
>> +    ///
>> +    /// All six raw VF BAR register slots are read and decoded up front=
. A 32-bit encoding yields
>> +    /// one entry; a 64-bit encoding combines two slots into one entry.
>> +    ///
>> +    /// A zero-valued low DWORD is yielded as a 32-bit BAR at address z=
ero; this method does not
>> +    /// probe whether a BAR is implemented.
>> +    ///
>> +    /// Returns [`EINVAL`] and logs an error if a BAR low DWORD does no=
t encode a 32-bit or 64-bit
>> +    /// memory BAR, or if a 64-bit encoding has no upper DWORD.
>> +    pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBa=
r>> {
>
> Since `ExtSriovVfBars` is private and we are returning an `impl`, I
> think we can get rid of it altogether. Combining with my suggestion from
> above, here is an alternative version of this method:
>
>     pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBar>=
> {
>         let slots: [u32; NUM_VF_BARS] =3D
>             core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[pa=
nic: slot]));
>         let mut slots =3D slots.into_iter();
>         let mut bars =3D [None; NUM_VF_BARS];
>         let mut count =3D 0;
>
>         while let Some(low) =3D slots.next().map(VfBarLow::from) {
>             if low.io_space() {
>                 return Err(EINVAL);
>             }
>
>             let low_address =3D u64::from(low.address()) << VfBarLow::ADD=
RESS_SHIFT;
>             let bar =3D match low.memory_type()? {
>                 VfBarMemoryType::Bits64 =3D> ExtSriovVfBar {
>                     address: (u64::from(slots.next().ok_or(EINVAL)?) << 3=
2) | low_address,
>                     is_64bit: true,
>                 },
>                 VfBarMemoryType::Bits32 =3D> ExtSriovVfBar {
>                     address: low_address,
>                     is_64bit: false,
>                 },
>             };
>
>             bars[count] =3D Some(bar);
>             count +=3D 1;
>         }
>
>         Ok(bars.into_iter().flatten())
>     }
>
> With this you don't need `ExtSriovVfBars` at all, which removes a bit
> (almost 50 LoCs!) of code.
>
>> +        let slots: [u32; NUM_VF_BARS] =3D
>> +            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[=
panic: slot]));
>
> Can't this be `build:`? `vf_bar` is sized by `NUM_VF_BARS`, and so is
> the result, so I'd assume the optimizer can infer this. Not that `panic:`
> is problematic here but I wonder whether you chose this because you hit
> an issue. To reiterate, I'm fine with `panic:` here, as long as the
> alternative has been considered.

`slot` is technically variable and you'd rely on optimization pass that is =
not
const folding. I think `panic: ` is better.

Best,
Gary


