Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC31917FB;
	Sat,  7 Mar 2026 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843861; cv=fail; b=CoaPTgKUGjb1y4eFgqFIReDsG9KhQsuLfe2XwLAlgh7nJ4ixZMZB8NhMQqWHaIoPbUFkxShaH3rPlaZ6sMLpkg183WBVqXPkGQuVLO3wbXx1aU3DcOfyKBhH3h024WIz4HIKTHu4mkvWocCzbWBX/fD+lPSyqKG4kvMBtDLCpgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843861; c=relaxed/simple;
	bh=0gt5kVdhN1lOPqmr45qAmiPyTQ4b3hdrrt0vFiie2XU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDKYk+DWB5Ue1qKVECpyyQhzYG5CseKID7/JnrhjjudiVLS4rNfbAwptOEScVJ3hqLVrwsFko4w/Yvz/IjQ7cTd9eakoKsymsQL4nPhNhyJDxweIvaD8zPCThKtHlgp5KzB6D+uwVUTVcgdzAp3IE/r3X0RTvxazgSVZz3vf7ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnQaCo+Z; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnQaCo+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD2sO/eVaP9cpE9cAC71qDhb95XipFVtvZ868eg0I8UApIQfq/5qBHuPJGkaQ6wtH6YsnBKLDMZ1znKaPCj7p0UYvYizdJ7AquHLXVGcsxC4Q0LN3Kao+FtaowM34hdtZL5t1cLlKqLb26X5g0qP9+FJ95cdMu93pk+xVzUpBMoVzZcMLLF9B9L76w0M95AGPq3qlUtRn6kqJhnIeU3xfInrbpFOtqmzEoWBH+vUsrYf/LySikQwuUk/tqcCIDZOSMIhJlL2QJG3DADHW9akrontwgeFyTzoBPqinDf2kd4B/GJjMTQ4GskLAsQKjIYY8kF1F/TnQ3nexN/aeJ0d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3gHxRExaOfey0ht3f7DvnG3kbJNtrEnVVpkFlMucYs=;
 b=w0GBR1JZzDbBUH81nPcqnkiUZlTWqtEcLM55KvixitnuXxfGnQ2i7kfjjqS3RSeCFZ/JjpfGkb274knB3Dr7zltbYgu0sZfhEWmwmusHr7LR9NtpFtSWTjVjQbk6GbnKve7GC7iFyqCMpkCdhppmvGNdJBf9En410F51QsncwA95cS2oIbvwZDnAfV38+6AHlQd5tgsRvkgl587BCCpyw/yYTXuvzh5PmDWplOcnvliyLiyKNy3dVKM4kveVOrvD4p/9gj60y8kOjNAIX7wQ8/pno50O5g6QktKnJUxcchg7N45rWR2pzv4EFq04NzAHrV6SnsFgVftDcoQRgsPq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3gHxRExaOfey0ht3f7DvnG3kbJNtrEnVVpkFlMucYs=;
 b=nnQaCo+ZYi7AZZg/Qxuh87CJl4aco2HqD6OoHDIOa6lhXKmIxkkYnK5MGpOBK6HlS2VEMggQUA+mHaJCBizowf5p63+VxwPtT1zHIhkSOpOsgxdghyAJL7Jh6vYi2H7CxL3rM0H6M3kPSKhbfia5lSqyR3l+e0Y5uZj7zFgtZtuaQ+gkGIS8kk6T0W4jYkxkZxgvFyu2keL8r8a1NZw8FbYJWLGgFnCnG9cw06YKi9ucf+dcBQtK5oGJUQpLxUXcTp2iQlwbJBrBSKtJkr5GogswYqWAIYeJkYrdQEo1HMHGjkTrQaDkc0fsAjwqoiPdRrfnnRBmnqsnakhOZd7/6w==
Received: from DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) by
 PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 00:37:36 +0000
Received: from DS0PR12MB7725.namprd12.prod.outlook.com
 ([fe80::4581:d771:45f5:86cd]) by DS0PR12MB7725.namprd12.prod.outlook.com
 ([fe80::4581:d771:45f5:86cd%7]) with mapi id 15.20.9678.017; Sat, 7 Mar 2026
 00:37:35 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alex Williamson <alwilliamson@nvidia.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>, Jeshua
 Smith <jeshuas@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Sai Yashwanth
 Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Jiandi An
	<jan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Derek Schumacher
	<dschumacher@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range register
 definitions
Thread-Topic: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range register
 definitions
Thread-Index: AQHcrT9cf7JuOZChUEuQ4bUPdDJo3LWhx46AgABy564=
Date: Sat, 7 Mar 2026 00:37:35 +0000
Message-ID:
 <DS0PR12MB77254B619966924AAC1922A4C37BA@DS0PR12MB7725.namprd12.prod.outlook.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<20260306080026.116789-2-smadhavan@nvidia.com>
 <20260306104531.3bb9c16c@nvidia.com>
In-Reply-To: <20260306104531.3bb9c16c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7725:EE_|PH8PR12MB7304:EE_
x-ms-office365-filtering-correlation-id: a8b162d3-8baf-416f-75fa-08de7be1ba6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 boJJA9E7ToqvwlohrxcLeZ6DCr83AFG1dLQ+XATbcw+7u4sjMpZ1qvL970WzLhgQttbMAvu02rfjgINico7PEvc8U61LhPfOQouM9lCObv815a7GkNh6VHOD0dReDjh0uWtdWu9icYnnmCaFbwAveQZO1NNBYBNJCekUGU65bXryUrWU9APVQSSb/5XJ3Y6/jSSrORMDSkibPsOIPvO6858FQoTXD1HNegA70skjl3C8JsMM/IC+6LP7vM9h0bIzFyCdJ2ioVAUN2KUmzI+9+z1cM5JIqWc0tHcyjiMPb/evclC2X1PH5U9aGzyd7lnMmRjDg30Z7e+zHluUY41oXaoE5pE4sq+YJYXYUd7z5fLlA18Ic5vq1Mhp8QIQBzfQQkl+rykJSoOt05gBiJjiyKTaF2i2scX6Pfvg2mFFfQob+e8H12hFRyllZ/8I5nhtoupdzfSvG5iaHGxPd3mjWhaWxjv73QKhVPHeKJOdW/ojFhugwUm6UXV2/zesvJRxrlA++0pjQRFwkWOp6e4C+r4svYJWHkWW60VJb+kJ9AGg2+F335dwNshNlewe1VKA+Ha/pw2UsfHuBi3xoDnLACJGUD8SvhLDGIOVbAyY2lQoh+drKhcVRQDKn79R/6W1PfxbwwzgcIg0Fm5gpU/6Ewm8TTXWXSXzAIPbA7ONv+yLr5oK5Ik2c2uWDhtcXbLEIUwuwU13N+yX5eksU/9o8KD5xss+df1J8EGhIZqceq+Duw8TPVH4tAYeVkUVZWiTZpyWljfM5GZYVUrKmQ5qnCvDp6xoVbjzYAiFzxigMFg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7725.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9hlOWu25HWHniXPjqAwI8Hn7FIl33M9ya6p8KSILVI7mtAPYyIZ2hmUesML+?=
 =?us-ascii?Q?/JORxhiPVjkreA36+IO6kbyDoH6dbv+wxY69pl47LrUY8Iyq31Y7aEFf5YDm?=
 =?us-ascii?Q?SI5YA8r2Bym2AS/iX/LQAATLWYVGadErZAtO0vUEp6ohpjCprbiul94hmENe?=
 =?us-ascii?Q?lPaluzSdoyOBbWzkz3zR3AQYtrnrgDIX8HXmUCJM6Qq7ErVvXN2+u7va9Dr4?=
 =?us-ascii?Q?SW5Bpbg43DMbDJeaCq4t0uE1KPLyy5LxqhefC4vhvOP/VFqQ+aGRqLETVu0o?=
 =?us-ascii?Q?eMfq/8+hzSb0+plMY3HyZNNzL+o/APIZ456WQdsbevqC8ld73QoP3a36gSTt?=
 =?us-ascii?Q?ckiwp5CY2R4EH8Ri66rQvmpR2trFFY87jn6e3cvYhHXmQ8fIO6zza+O9/kgc?=
 =?us-ascii?Q?Bl2lF11uX2fsoHMDKHQ3enRYz4+tw6lr+7L8zXB+3HKlijdtk3PZbhEIz4+l?=
 =?us-ascii?Q?1drzUhA6RAkK4TcyrlTNJ9DtJ6UYSwQneyqO8XGwD+Wvt+N+z00RY2+r1rnV?=
 =?us-ascii?Q?BhoL9cNDWsuzNo7MJk29/1K9B1fhM0UWLVhjdfMOXzlfwuS/30pAmTSYc+Bg?=
 =?us-ascii?Q?Y989dZ5sHBf9r+Mvg2VSi6FzAAV6R6tv3FLq30W/VgXsLFyU6VEfEwXTQwpM?=
 =?us-ascii?Q?O6NA9YBmNMd7Fo9zydwsxeCKfN91jAi6mjw9euOm9M9D2choZ3smI6xN+C7s?=
 =?us-ascii?Q?CyC7TyNTNj9CagMwZ1uZOWyiXjGHVNMYw+BrP8lj5rcq4lGQkWBF6k+RxOe0?=
 =?us-ascii?Q?klhmP4/Xw+To10h2LpA/bbcaRiA9Csy8wa9bNuiNYgipH54P28aKuXgR4XAb?=
 =?us-ascii?Q?qVTRbakFSTH/Ogryw5aT2pX+bWwsYVPSD96g9DOhNxdWmVzNDB6MeNKgmz8d?=
 =?us-ascii?Q?jx5qHS4qYl5GlsfZaXVmFo/zQHzLaKEaizjP1q4QTyAMA51pIUCnMzvKqlyt?=
 =?us-ascii?Q?OsSdb9wx25hPR4G+hp0bv5wrpeyOg2cFio+/rl3nv9c4VBDYwcR9VjPd1iE7?=
 =?us-ascii?Q?ER1/t7+MGjuneeVsI1andpNt8mabCyhYMukWgDzKNf0a3OYleJRbgF0C4Pt2?=
 =?us-ascii?Q?wTN/jdyFKRoH59GeNfin1wCbmSKsPu/bmrqNpy7Py+cHCVtsPdPhpvvbchO+?=
 =?us-ascii?Q?Z8X+BIO+jsfTS2QZZUTg03lprZk3UBMe2Znd4nLMt8AbyKZ45pzQ4LMwnzyj?=
 =?us-ascii?Q?/trVfE6vCttba3l5UBBuq+wuZyOW5lmSjiTjrC7HZ+lGoo7bCJDSQKmFzVOg?=
 =?us-ascii?Q?bYKRkgPF4lJ8F85li+ayfkqfxvxMHzpQ6fmRtFSU4xaBph9PyJqnwN40Sx2w?=
 =?us-ascii?Q?WoUvT+xBZW16u7sT0PTXivEgFE0Vzj2zPeFGuRL1L7TZGqEK6ssNbunyrlVA?=
 =?us-ascii?Q?8dSxX+VzZJjbvctdlJqCkMKpKUgkF/vL+t3VGsYfAsCrxKw4CuVnppsC5ZZ4?=
 =?us-ascii?Q?PWe0tWtuOQtsUW4g8pnEVhAhfJ0dHyvXdw3foD9NmNJgje1sNQonlaZjlDb4?=
 =?us-ascii?Q?1zl8VAeQVGSEqqsYuGNisI4z6rGeaB0AmugIqLZrsNLC8EvmfarGB55mk2Kr?=
 =?us-ascii?Q?JDp6AQi/Z3sQXhWVe/8cn4vnHKgQcg6DYBBS/znZhLd6WM7M14n8ysrrNswq?=
 =?us-ascii?Q?waaGQ3v9updRSzXg5h19TbKHL+Hq2AGaMnXr4dQbnoAXL5ikYBsofEEebt1q?=
 =?us-ascii?Q?HXvawf2qmfgz5NCFX0WZJkf4lbL6dzBPa1qqVSY+kXYv3FcR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7725.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b162d3-8baf-416f-75fa-08de7be1ba6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2026 00:37:35.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZN5zlfT0IFIARBKUgS7D6klbbqa+lT2HwE6julbBDDdbe/mf2cDUiV19goyjfOnPdBp8Gc5GOzP+fUDlg2n8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

> These RWL defines really seem to be more kernel policy than spec
> definitions.  Do they really belong in the uAPI header?  Thanks,

Ack. I can move the RWL defines locally to where they are used.

________________________________________
From: Alex Williamson <alwilliamson@nvidia.com>
Sent: Friday, March 6, 2026 9:45 AM
To: Srirangan Madhavan
Cc: bhelgaas@google.com; dan.j.williams@intel.com; dave.jiang@intel.com; jo=
nathan.cameron@huawei.com; ira.weiny@intel.com; vishal.l.verma@intel.com; a=
lison.schofield@intel.com; dave@stgolabs.net; Jeshua Smith; Vikram Sethi; S=
ai Yashwanth Reddy Kancherla; Vishal Aslot; Shanker Donthineni; Manish Hona=
p; Vidya Sagar; Jiandi An; Matt Ochs; Derek Schumacher; linux-cxl@vger.kern=
el.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range regist=
er definitions

On Fri, 6 Mar 2026 08:00:15 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
>
> PCI: Add CXL DVSEC control, lock, and range register definitions
>
> Add register offset and field definitions for CXL DVSEC registers needed
> by CXL state save/restore across resets:
>
>   - CTRL2 (offset 0x10) and LOCK (offset 0x14) registers
>   - CONFIG_LOCK bit in the LOCK register
>   - RWL (read-write-when-locked) field masks for CTRL and range base
>     registers.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index ec1c54b5a310..6fdc20d7f5e6 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1353,14 +1353,20 @@
>  #define   PCI_DVSEC_CXL_HDM_COUNT                    __GENMASK(5, 4)
>  #define  PCI_DVSEC_CXL_CTRL                          0xC
>  #define   PCI_DVSEC_CXL_MEM_ENABLE                   _BITUL(2)
> +#define   PCI_DVSEC_CXL_CTRL_RWL                     0x5FED
> +#define  PCI_DVSEC_CXL_CTRL2                         0x10
> +#define  PCI_DVSEC_CXL_LOCK                          0x14
> +#define   PCI_DVSEC_CXL_LOCK_CONFIG                  _BITUL(0)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)            (0x18 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)             (0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID                       _BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ACTIVE                   _BITUL(1)
>  #define   PCI_DVSEC_CXL_MEM_SIZE_LOW                 __GENMASK(31, 28)
>  #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)            (0x20 + (i * 0x10))
> +#define   PCI_DVSEC_CXL_RANGE_BASE_HI_RWL            0xFFFFFFFF
>  #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)             (0x24 + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_BASE_LOW                 __GENMASK(31, 28)
> +#define   PCI_DVSEC_CXL_RANGE_BASE_LO_RWL            0xF0000000
>
>  #define CXL_DVSEC_RANGE_MAX                          2
>

These RWL defines really seem to be more kernel policy than spec
definitions.  Do they really belong in the uAPI header?  Thanks,

Alex
