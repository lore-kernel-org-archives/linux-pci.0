Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020085.outbound.protection.outlook.com [52.101.195.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F8305968;
	Wed, 24 Jun 2026 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782342667; cv=fail; b=ivOegwjZ7ii73CYan5fsSHdRONYRG4ej0+W/5NBBrsdoUoOfXYlXCS6fM06vD2eq2drYAJJOKgA87BHxwYsSqeZYt5fFewbLqDYs9/f5rAqmYRPv6iQFVGdNzGTsTxq2M3vY9ElCUHTkqwoaMnJOSLSp2Z/O5TSveWO/GI9yHJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782342667; c=relaxed/simple;
	bh=Xylh+RIF6uDUoxIhVmTA71P65JMreA4SCyEpSq5esqY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=JntUKgrCtuG3GEE8pjStTbqVINNFPMFeafdhBiIcRDEmPDDDXXRy84QB3NLt+x+U6xfxyppDMlj9bv635E7LXxtyD+B1OAr3xdklzB1QSTdimgqBGnFFaURojfqBwx2u3BWX9e5V+NCxy3S2n+2jdmSHYG4LDh4A7KFeU1+yrNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yEACzRnW; arc=fail smtp.client-ip=52.101.195.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="yEACzRnW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtW8eBFuWrIPmPLIYY7ZG7DJDcy/KXTmZ24qWQkPg2Mt7VOF2VaERdNHYmXT2dAJIcIHKhUrSzqU1CluzNkZP16GiBiMuEWyH2zYrEa8t8twrqtmkS8S09RDDKLOvKllsz+x/5SM5HGMzF43bQWkg0Lfl93WKe9FGxohUVvxZKjnijewPuBvAIqRh0a+9MUCX/Z1rNKx0fB3XPeDh/tpFx18sK/dl8SUpaZjAhG4Hrz2xD5HLHGMCijp91cY9qa0aBf/GPPlI+Iqdr68mt+YRPxPEG2+dPwtQbB4bQZvs/Q066Rfz03zHMZVuLMMpVUKA1k8duvmFduUU5Q4wNCh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laIox3EvhiHD+AlTCBymapBaquwpCi/XngnICWInJqg=;
 b=Pyf+hB8Eu4ZrN4J/BPG14KAb4psvyTfE+uvimfpFqJ/ABUXUm5t9y6tEy3ifM9GqUyo8oVbLjVSib3AwH0XA+CrkcRGrMYnO9S6TmtMiRn1hm8j4MGWFYd667KP1hvbodbwdEmBIZqA+EdjQV0EvxFSygZ02r/IDF8trPDp+5CmIPMAu2/K5nY5QqQnh03lhy9fvLXWpzLFp6J0ktmI5RuSVyxVp4y89gxWoAq9z4hvE3MNBCeUi4p+n34u5z7l7SEE3iyTq6imAAu7sMa5S0WS9OOi7GHEDrWJx+Q6m/yA+30nB/k0dtS+asaFuk2puySqVRxS/kL0NlPoFO6wGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laIox3EvhiHD+AlTCBymapBaquwpCi/XngnICWInJqg=;
 b=yEACzRnWenBKMFs+92YxDPq9GWVozAkttfVapLyzR/LK/WB7wyUtjYkam75oR7yF8mFcsQFawx4Tb+vS6y6ofhxfoGgAvDBqw+2//s8P2H6oFwammU+GDx7OGIPW51OHG9lO7NySSEl+sQuzlDhXUdFeHLNb03pvCygyfe/aAzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB2187.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 23:11:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Wed, 24 Jun 2026
 23:11:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 00:11:01 +0100
Message-Id: <DJHNQRALREG5.37R3M4GQ2A29V@garyguo.net>
Subject: Re: [PATCH v2 1/7] PCI/IOV: Return u16 from
 pci_sriov_get_totalvfs()
From: "Gary Guo" <gary@garyguo.net>
To: "David Laight" <david.laight.linux@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <dakr@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <joelagnelf@nvidia.com>, <apopple@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260622194353.1308872-1-zhiw@nvidia.com>
 <20260622194353.1308872-2-zhiw@nvidia.com>
 <DJHAC9W05615.19MHKPF67OG2T@nvidia.com> <20260624143937.50499c29@pumpkin>
 <DJHDAQZ1AASK.14ATT70HTI450@nvidia.com> <20260624203851.7f6c7be4@pumpkin>
In-Reply-To: <20260624203851.7f6c7be4@pumpkin>
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB2187:EE_
X-MS-Office365-Filtering-Correlation-Id: df988f75-dd2e-4659-354e-08ded245dc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|6133799003|4143699003|56012099006|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	mOotN/Ceb8fgiiyxatGqXsCs9ZiSvrKjs2B4n19tXDhcx5j5vz6OmEVGgUAl4g3qJD/oJkdyboO8X6FKtpQCdmZGi3xjl2OuCK4z4vl9+LZVClQolcLfPM5aGEIt7S0cIXrZ6A/2JPuGyRZ4Vt7qp6/rNKdXjz+QD1JjY54YQ58WvI0bA9sJdcKJ6Ibbz8aUWGsOE4atMAkLNPiTQ0KegRn/BCoB85kWO6JR3sdf/qYl74RJdSJZ8iYEIRVzafSxk4/zZt6fCxArhUsBXR725kslK7id55RhrIOBgMXs7cnU8KctYrM5k0Hs3QuenD9FOtIucuT8hirgditjpYbMt332wrpN2R4iNg1ezB9G763djcvQ72NnZ2y4kTsgaWMEZ+R/MGAuW1bKv7RuUaHJa/dWa38imBn7ea7k2s2hGg7BfkRzWl65/FXCjrt0GV59Ee/LBwqg9h9NAYB1YxehzF8bS66WcGRq8EQPqNDxke2RB8xdUT8Wy+IxEU7YDKp0GgWxFZlIOi5Taav6rHLUJBG5eRnfddLeixn3uHk/+Ju4GOAs3xmqmEOn94fy+7VW4jNv+vmtHLlDGXx6k4HMofelzlhgAWnM1MU8viPdG1pYL8+Bs7BAgnA6fclQFW1s+rTWC7OVm+J4jHD8NtjtRBmyLGffgSlI5/CLp0kSkBw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(5023799004)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlorK29UL1FqVENRSmw4a2JpL3pJL3ViK3ZEd2t1OG5ZcDdNY3RKTEhtbWgy?=
 =?utf-8?B?aDNtY3VpUjc4UVFEUjdRMzM3T3pFWUkyMklNakxLZmRzMmhBREJhWEFFcld6?=
 =?utf-8?B?cnRyTW9jQzQwSmhDMTMybXU0bU5mWWNjaTNhODJLT0xPbCtoTG1aeGJ0NmFL?=
 =?utf-8?B?eVAwTmNmaTBNd2hXQ1k5RlY2VFJIS1BSVnRRZ3ZwMTJldnNSZmw3MWpSRnQ2?=
 =?utf-8?B?YS8xR0NHVmRybitZMkc3M29JUFpiL2c2ZnFHMnJpKzNnSHQ4K3B0bHNaekdZ?=
 =?utf-8?B?Uzc5dFo0a2pNR2h1alFYaG53emZXTVh6L0lpV1g4QUo2UTJ1RFN0RzIwK3V3?=
 =?utf-8?B?NWdlZkFZTittRFk1d0lhOXExTnIyMHEyZWh4UVVoeWNYMTU1VytySjhMM1pi?=
 =?utf-8?B?cUhCV3VnL1J4TmFwajFGRkFRYTIwWFAxbVFFMWE3V2NPcnpDcit0L1AvZkpL?=
 =?utf-8?B?ejdPQTlqeDJjeUFhTmxYcU9TMi81bDM0VzFtd3hEeVpJZHJsNlpTU3BXZENR?=
 =?utf-8?B?bzJYeXJFSHBKMGgrK09DY3k2d3NGYXZjT2wzelhKSU00WU0yamU4Y1dCUHNR?=
 =?utf-8?B?aWZjS1Z4YlNLdkRnZlJxS29WaGNOZElnWWhHNmc0bjVlNzNlQU1SWHFFS04w?=
 =?utf-8?B?N1FWbGQ0b3dCM0JkV2ZCaWdlVG5pMlFUMkVseFdxbStxK0loMk5LSWowV2lF?=
 =?utf-8?B?N1FmK3pGcjFpcmhTS0Q0K042WXQ4YWVBM2RlTXEzdzFsQUlkeHgydnJqaFli?=
 =?utf-8?B?cnMwSmlVVFBlSjcxeWVwVDd6eUlSd0xPRWpnSzFTRkpiejZyLytTMnN5YnlD?=
 =?utf-8?B?WVRQQVU2OW12YVNyL3BBSVhzWnlCc2MrVFlYL29UNzhNdlZucytUblZwUzhC?=
 =?utf-8?B?KzJEQVB6bzFHNnRkcjJ0Q0JQQWdQcDNyMHkwSDBCb1V5NU1YbDFlR1I5YkZJ?=
 =?utf-8?B?S01aWFZpWWFtajRoYjRoNHI5Q3MzTEtpWGd5S29qdzcvalNQR1h2UkNZY1A2?=
 =?utf-8?B?bmxMQ3VXOW1PcGdEaDJ2RHI5UDhVR1lqbmtQNEg3cUc0UDFmVjh4UFlsYVdj?=
 =?utf-8?B?bXBkUGNKYXpyU2s5dGt4VzRVLzZKRlVneEFQZ0VxNEJSM1MrcXZDZFJzWDNn?=
 =?utf-8?B?U3grdDhpTnZRVlczdjdsYk53MUIzSWpTZkdUMTZFZXY3K3dLUEMvZWlqMGxw?=
 =?utf-8?B?SEJSMEN2aHI2K3VxdVMrb0l2akx3MEE5WU9IcVViYzZkNUF5NmtXOUVHSis0?=
 =?utf-8?B?MGFaK2ZndTdwYkJFTlk3Yjh1Um9taTFpa2cyNEhxZzlEaEtQSGhYZm90eXl0?=
 =?utf-8?B?bWNwOUJxNnRidTY2ZzYxYUwrMFgyU21TcHM4OEZ6STg5czdJRlN2WHR0VTRO?=
 =?utf-8?B?Z3MvT0V4STM5ZXNNQnMyaHZpMXJhWnA0dUZ2L1EyS3BVN3krV0sxbEU5WHBV?=
 =?utf-8?B?b1owQU1NVk45bDBOZ0JkdmIvRU9tUTNZdkFqbFV5OGYzbnhCQWxmdXZFOFBp?=
 =?utf-8?B?dEExTStPeHpxWGxYbmZDd0JMRVdiR0E3aWZZV3orQVFCQXZ3WWY3c0VIRnpE?=
 =?utf-8?B?VjZ1NUM0SEpMd0VaSFl6UWpmKzZ5MisweWtyYlNqNGozcy9LOWxmdGJ2S0I0?=
 =?utf-8?B?ZzdmWFdDNzhXcFNZOEtuc2Z4Q3gxU2QzYXJLYlNvSFlvZndrOXJaYlF5cEx1?=
 =?utf-8?B?SjlaSUJOZUIwaUlYSGdmcXRtbFVtS0FvOUxYOWNkTFVGY1B5UjFwSmZ6RVQ0?=
 =?utf-8?B?RmN2b3B2SlE3Tm8xbC9Mb01ZMURNdm1zWGxtN1hDejlZQVA5MlVyUG1oSDh3?=
 =?utf-8?B?RUJqRTlrUWZMYVVWdDdZRXNZOXFtMkIwb1dxVER4M04xK0NST3VwZW81Rnkr?=
 =?utf-8?B?VHprUno5YnMrQm94bEhzMDBXZnB6dzRiMjV4QkJ2WmtpUGdQSHU1aHZMa1JO?=
 =?utf-8?B?SXJRWHRZSUJkcHRNWCtZdWhtSlBBL2NGMmdFVDBvKzZLY3BCMkFsckdOSFQx?=
 =?utf-8?B?bGFjWkc3TFRqQVNiTGNNNzE1dzRId0FrUHYrSHo3V3pINjBtR0dGRFcxcFFQ?=
 =?utf-8?B?T1lRSlcyZlh0UWRrTzR2b1g3MUFxLzlweDRFa3Nwd21zVC9XU1F0QXJzNUM0?=
 =?utf-8?B?eGxXS1lLb1hLcXExc0VhL2dWNHU3enZTWDZGWjVnQ05rZ2FlMVRBSWU4S3Jt?=
 =?utf-8?B?aUdKN3R5RDhOaVdLV2VQVllKSnFFUzZQbWxXN0lEUDlqUnFMcUdMUnJnZng3?=
 =?utf-8?B?VVFINk9RK0FzcDVLOU0wU2M5cThCUlFtSG1UTkczNFpQd2ZXbUFZallidXJj?=
 =?utf-8?B?OW1IZWs4Z29Md0pkVXJpZ25zODFiOHRManVZNVlobXNhMUlnZmpUdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: df988f75-dd2e-4659-354e-08ded245dc66
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 23:11:02.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3RlOlXhASSGBOLMvMs2TvpTvObv8GqpBBfq0832SIxNBxjgyOc27CLmrjHxK6icJNxKvWPCBLBRZxfeQM/rZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2187

On Wed Jun 24, 2026 at 8:38 PM BST, David Laight wrote:
> On Wed, 24 Jun 2026 23:59:56 +0900
> "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>
>> On Wed Jun 24, 2026 at 10:39 PM JST, David Laight wrote:
>> > On Wed, 24 Jun 2026 21:40:52 +0900
>> > "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>> > =20
>> >> On Tue Jun 23, 2026 at 4:43 AM JST, Zhi Wang wrote: =20
>> >> > pci_sriov_get_totalvfs() reports a VF count, not an errno-style
>> >> > status. It returns 0 when SR-IOV is unavailable or the device is no=
t a
>> >> > PF, and otherwise returns the PF's driver_max_VFs value.
>> >> >
>> >> > driver_max_VFs is stored as a u16 in struct pci_sriov. It is derive=
d
>> >> > from the SR-IOV TotalVFs field or from a driver-provided limit, so =
the
>> >> > implementation cannot return a negative value.
>> >> >
>> >> > Change the declaration, CONFIG_PCI_IOV stub, and implementation to
>> >> > return u16. Update callers to store the result in u16 variables, re=
move
>> >> > obsolete negative-value checks, and use unsigned format specifiers =
where
>> >> > needed.
>> >> >
>> >> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> >> > Cc: linux-pci@vger.kernel.org
>> >> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>   =20
>> >>=20
>> >> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
>> >> Link: https://lore.kernel.org/all/DETDILPA1GFY.27WND0TEC5352@nvidia.c=
om/
>> >>  =20
>> >> > ---
>> >> >  drivers/crypto/hisilicon/qm.c                   | 8 +++++---
>> >> >  drivers/crypto/intel/qat/qat_common/adf_sriov.c | 6 +++---
>> >> >  drivers/gpu/drm/xe/xe_sriov_pf.c                | 6 ++----
>> >> >  drivers/misc/genwqe/card_base.c                 | 6 ++----
>> >> >  drivers/net/ethernet/cavium/thunder/nic_main.c  | 2 +-
>> >> >  drivers/net/ethernet/emulex/benet/be_main.c     | 3 ++-
>> >> >  drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 3 ++-
>> >> >  drivers/net/ethernet/sfc/ef10_sriov.c           | 2 +-   =20
>> >>=20
>> >> I believe that you can avoid converting all these drivers in this pat=
ch.
>> >> The implicit `u16 -> int` conversion done by C should result in the
>> >> expected behavior, and it will be fewer Acked-by to collect. =20
>> >
>> > The generated code is also likely to be slightly better if the functio=
n
>> > return value is a 32bit value.
>> >
>> > Similarly you don't really want to do any kind of maths on local varia=
bles
>> > that aren't 32bit (or 64bit on 64bit builds).
>> >
>> > The fact that the domain of a value fits in 16 bits doesn't mean that
>> > it is better to use u16 - it is usually worse.
>> > Pretty much the only place u16 should be used is to reduce the size
>> > of structures.
>> >
>> > So it is probably correct to change the return type to unsigned int an=
d
>> > remove the error return checks, but nothing else. =20
>>=20
>> For C, I agree that unsigned int is the safest type.
>>=20
>> Rust otoh does not do implicit integer promotion, and making it return a
>> `u16` carries useful range information. I wonder if we could have a
>> private `__pci_sriov_get_totalvfs` that returns a `u16`, make
>> `pci_sriov_get_totalvfs` promote it to an `unsigned int` and return it,
>> while the Rust bindings would invoke `__pci_sriov_get_totalvfs` so they
>> can expose a `u16`?

There're no value in having two versions with just slightly different promo=
tion
behaviour. Rust side can still use u16 by casting from unsigned int without
having to expose both.


> That is getting silly, something will end up doing the masking to police
> the 16bit value - it isn't just the C rules, the ABI pass/return u16 in
> in 32bit registers (even on x86) so one side (or both) has to mask the
> value.
>
> Your rust code has the same problem. Add 1 to a u16 variable and code has
> to be added to mask the result to 16 bits.
> You won't see it on x86 because it has 16bit alu operations, about the
> only other cpu eoth them is m68k (I'm not sure about s390 - it is based
> on a very old instructions set).

There's no implicit integer casting (extending or truncating) in Rust so us=
ually
the setter and getters for the same property would be of the same type.
pci_sriov_set_totalvfs takes u16 so I expect the pci_sriov_get_totalvfs
API binding in Rust returning u16 too. That said, this can be handled by Ru=
st
bindings as mentioned above.

This is not hot path and just have a handful of users anyway and I wouldn't
worry about a single masking/sign-extension instruction.

Best,
Gary
