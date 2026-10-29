Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793278889;
	b=FRtvsMXqCojYtTS7z/E5mJWmoGb5UAon6CKnlcoeTBzJj6l6EMSFOJmKiUSEbKMqkJtx
	 AypbCggvaaTH9CmI10L22NixWra4eOONyp5iyjx0Z2xzfLRY97grP1jCfSLfD076+uUZz
	 C/vw8+bLGaWYMQhln40/QFSX7oT9HdBz3Tqf9cNugIIgYg1lz4AKt+VkuF26OKjDdMiRV
	 iEiLNT5uYH5/TBFtW1K6vBMVtbDZcBX9sdKcC9n3ayUPwy/WqYpLpsYjjzvYFf1vxE/JJ
	 ERYKznz/RdQKdDTuCdr66J8/0fCxJpMcdKUniQC2vgTI//KSt1LVL/oEQ05xMeLEIWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278889;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pGL36HlwN1k+w+419NuZ1hy+7P6yE5rxCQ3PsoCFGcU=;
	b=2gOnOnqDBqzqESeoMM0oAo/5DwJazRG5N4iPJSSRUJLazIOneUlKR28tAmG09MPq8YQK
	 IHV60ogQ/UxYGV23DEOsyxrPuCXwOoKY2hptbUAKN40fWfueJ+ODPBwTPJQbXC0lYwsPs
	 qQQXzpNjxyCR8PQaLyRRqZLVyPDy0AHj/Sp8vbs3+uMvrC5Iv3V/APJVHX9MVyAg3ajXk
	 WsGXiOuOUgXJCACMYDqf2BF+kF16UFnkp2zcOsyXxi8qb4ADtW1yv0R6+sg+yGLspeIKW
	 ywHTo2Y8bkNbtC+Ddi2zVo916oTxMXPKsXMeBUflJlV6xU/GFl56jOGJkaZoSoOEwNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="m15azft/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.24
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E1606A321;
	Thu, 29 Oct 2026 13:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E75E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m15azft/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwmR/YC1J7mvrUDJ6sLgPgE203B/B3QE9chJN0FVIU9Ipo59JPx+Rf+c70z545UqNGbI7zklaQtuu78z15YQ5l44Y0ggwwtMoRjjIggJZYLMylWYDjUH/zWakOL9tvbsYJikz7JIaYAw++QE+FU9qbDnkAw1TidWI9UYeysGuO2JJCy1qRP02Azfkm6UysuxqglEIyJlj7bsmcyM2mQwpCoQ1gzM6vAfJ8Bs/0JHRek0UHCYl0LvonzUh+5BESg2dp3kWeWcI677B3VaHGqjBK3+CRZDNVqFR6SvGMX60HgIs35dM3GPSTh/NakpLzYGApO1pG0ItkjE7uHgK1w+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGL36HlwN1k+w+419NuZ1hy+7P6yE5rxCQ3PsoCFGcU=;
 b=Hcw9UXjWSP/IgvuPxSC+ExDIodiTObFgauBUHnDMrrhLQhHJRSTK11Yp29b5LI0gDbRhFrDnzeh2lktkNfhbPouMspfhC7M5VmlazMnTrkAcY3x15Xi/QxdIDxj9OqMqFnlMDj5GxMpF/ickDcGSztuxBp8Q5AWo4Rn1dCTa89ylpd7hhsuDoW3qTF7EfXHQcLFUC4Y1aS4FmN9mZEa+8HvzRTBKoLcsVT9gm/UkeasVKknHhrk5P+grwfBJtogzVfKBYJLwTMvMfYolKORvmIdPgOzhEHqplidTkAJabQeO3x8CHlOcQMaDXz6gWnXeDd0o922NTVJLqZsk+xqDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGL36HlwN1k+w+419NuZ1hy+7P6yE5rxCQ3PsoCFGcU=;
 b=m15azft/W9jtgt2iKMMLpw+AfchZAJhbHW4CAKX45nSQWCLO2Rq4tFJTlcUs28Pv1se8le/uFHUmXt6hWs0e2dmYRKAPJPDr2vQ4/uc0SwLYOD91CZsjq6R23OYPp3rusXZ1es3pAiiKYnpZUPP8qX55U5oqM54hvNfblN00eZZFE0pzMHm8jXgSIdh0E9aKFVGo/5VM6//oBAw3cl/8g1mq/m412iPJvItFyCYpO/9PvjxdozZAmcqd/qGbu7oo3g1jzR0x6Tx3E6m094w/XPBZsG9YmuiY6wIKbl/im/pEzCRIVrE9va/df0HzHI4IMwd7iNdW/dMIdXx7usawDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB8806.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 29 Oct
 2026 13:01:18 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 13:01:18 +0000
Date: Thu, 29 Oct 2026 10:01:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 10/16] iommufd: Add the vdevice TSM request ioctl
Message-ID: <20261029130117.GH3040767@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-11-aneesh.kumar@kernel.org>
 <179321444123.2412245.6955528563980811144.b4-review@b4>
 <yq5a1p98c0f5.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a1p98c0f5.fsf@kernel.org>
X-ClientProxiedBy: YT4PR01CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::26) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c6c65b-a8f8-4045-56ab-08df35bcb8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|10067099003|261026140227099003|261028144727099003|261022113327099003|261026130827099003|3023799007|261022115727099003|261021135927099003|261021130227099003|261021121427099003|261026121527099003|261021123027099003|261009223027099003|11063799006|261009221227099003|56012099006|261022105027099003|4143699003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	QVNpMD8U9SHu8boUvehsGOgW9U60Vq4WLXpoIE/Hp+Mbckyz7S+qbWfR42lU5QAwVU3XVUfORo7hr/LyWPtCBiNHopmgkEQFMpmSwKAtRC1MADPu2Q4SHunT1HHeESIln+Bya+RPDqkbFqKh4vlUK/pAVL/H5xafKie4j0xk4ItK6lAxpMRRMXN37w5p0H4JUVckWxZ8hVV3ptozofdP+wJLv5nOokBCYYC0q1IUWDzKkAPgklhQi+A3kew+HSI4z+J4fdblEknS4hxwESi+BXc9MmOP1H8LfyK10LrRJHHb+7Kf9HMuftTcqw/AOllM4+juixf2tr20/bHkMkn/Kb9Ux/XpFTUptWDGIpRjRZRHvokEH55GV+eIvK487sFhiWMr1sPxccyGmVddIyFqLSH5BixuKeIhNcIlWu/VLz9FsJdHKgI6AJgUUUzRwEuii70s1Byrr4O0oniNSt4eieTKJANNW1xyKB/O9iJ3S/yhxZn2QSThHXU+xuvjdBq7hFfRNekzCLLRhbdW9ZLNw094in05dFuZOPTqADXy2+Oj48e2Z3L/WQh9qgNa+UfKclq/aP9tiq4IhY1PrJNIhy36JBMTMPku6lvgKsPBgHo8FpEKu18PebmqlQZu5ajYbOfYFWloKquYEULMTQ9PtQSobO6bZJJKeO7nVLpHKZM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261026140227099003)(261028144727099003)(261022113327099003)(261026130827099003)(3023799007)(261022115727099003)(261021135927099003)(261021130227099003)(261021121427099003)(261026121527099003)(261021123027099003)(261009223027099003)(11063799006)(261009221227099003)(56012099006)(261022105027099003)(4143699003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLeuEOMewFu6Bzasd9Rh3uMkTBUhIr+L9AwN7G+H9bImjtk8238jiOlMwroP?=
 =?us-ascii?Q?WYN4NsnpbJXjTXtmL7Sweu8+sSOxb33Tdvbg8SoLLbJqvUv/uKqgXFNurTb5?=
 =?us-ascii?Q?QQXN5ESf/XL9buropmOcueBNy5Jsqe5v/3UeON+J352QrMCg/pQIx7i6RSW/?=
 =?us-ascii?Q?StJy7YpmdKqUaCW5JZPJe5cLCGP74ly0wZvX5It/P1uk/j/+uWuB9EmKcm9/?=
 =?us-ascii?Q?d0xqFQhEXF674cavJWN9/f4b4Vf3qUUPhpR4IM90v0I89PhAAtQBX2Bf2jl5?=
 =?us-ascii?Q?KnE29eA2PeO/w4ol6VHWlAGlTIn9jx8mxXocRur1us5zkK8gY5ItPdgJtJUS?=
 =?us-ascii?Q?zl8H/Wk4N2ODtF4MPCyNHSoEdm8H+DMSaMJMZFzEfuHa7tjd9q/cKZ7Jkmu/?=
 =?us-ascii?Q?h5tTjNOFdAUkToFUTso4/mbGOdY5pUNXegZExaxSi62BQVhrLDmUePXLF9dO?=
 =?us-ascii?Q?lEJZAEPx5m1uVFnABdAgvoQ9YYp0dh1op/tVTqjWWzo+9UrEED5JDQnsJB8t?=
 =?us-ascii?Q?x5rNn8f5lpsl7r72uOl7wtOXeahCLPkilgHm3zJsqdRGEPxsQvzWMWDvq4n3?=
 =?us-ascii?Q?AvY5ZCGyIPEVb2EH5UcczNkXuk3JTQj1XNZxOHUSBmoD4hRZbpFQK7l7mfVp?=
 =?us-ascii?Q?1VAnE16XaL8hPGtbvQ+623nysPvhXq1syyYRoIFtZryIejuUSLKssoPfGOUX?=
 =?us-ascii?Q?5PUXdHch3zhDBYdBsy1pSOQkn+NO7kohRA4sxJyVDo+shEPFRZlMsZPxeCBJ?=
 =?us-ascii?Q?zoRcl3H9L8IOz3uIzRgCDfIK+lDMBsmKUl2EDX/k2uuRGercfkirCNzS69kz?=
 =?us-ascii?Q?0DV6AptWLw21RSQcihMdLAKDWR0QOXnFBO7/Ec+iv3Y/i3z35oM3X+FxzmfT?=
 =?us-ascii?Q?K8OTWzYIMTtvk/IP1HKB6Rk8cr/dWiXbKerS/Fl+P9FA6w37UTODrzcAVyxR?=
 =?us-ascii?Q?uYmGmFlbDeU3X8PnnPya7vHRye+w3YRgi4M/aKJNetN2RFEhjsTAJJ0zIC8o?=
 =?us-ascii?Q?ehnhcgH4WC7q2b0KWlHCeHe2YB/4ioi8WLtAI97rGnUzR04bSUL2eMbGoOJ8?=
 =?us-ascii?Q?LJtsWULBsNQhAmZ86JJuLjjILWvGUTuS3yjW0bf6ZSxyaeFNcSZ7RNoMYZvC?=
 =?us-ascii?Q?Ipk5rHa8PNUSeojpkQas7Y2BiR8aVPnPqgb3jIbUX0q43dLYRcLUSB9pow9M?=
 =?us-ascii?Q?ev2y049b55kkiZRxGhg/fPOEKhd+u48+qQ4m0BtXREc66cCC3HPwxhQz9NqZ?=
 =?us-ascii?Q?19cZIOQxjyGuCC9IRgIJ8KBqsdsYrNtdJePAnuB5/pia86fMxyPJd2AYZX3K?=
 =?us-ascii?Q?KrVrptXc1OG8tVg6oHhySvy9N9JI6z2Q3mjp7l+JJHybiV9HG2Cdl9Un4cSI?=
 =?us-ascii?Q?R69ee5bwuqf7btrPgmmzfHUEqmhLQR4G/hnKhDCoNq5IHjxoYclpodaGrriB?=
 =?us-ascii?Q?wZ7IzGC5+tIYhEcgCeGMvz0lCqpkmrj2KiiNjdGqaqE3QnpCULXhUJtsqw6J?=
 =?us-ascii?Q?P6e/E4Be2QPt46FMMfCLms+2SF+9MbE9xs+StGui4cNzOFdJPugftj95sPPF?=
 =?us-ascii?Q?LNNx0b+LNs+293FnVdzPc9tLK1hZ9xBmW9qa4NEZTQkxa0gUET9gQ2Lds/pP?=
 =?us-ascii?Q?rKHNAEzZzfJxvBftQ4MI2PubkGikjlE0rnRknBKiobo4wO9Bp/Jkpl7PzUhf?=
 =?us-ascii?Q?1anP87jbPHuCdFEtl15emQZEUcypJ/ecrM8b6HkAQSfGPzxX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c6c65b-a8f8-4045-56ab-08df35bcb8bf
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:01:18.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT4Vsu+6unE8074pr1Ce3YrdZSmiJwwAmlpdVyXupuGFufnClLNRGjSQyKdtEDvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806

On Thu, Oct 29, 2026 at 03:07:34PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> >> [ ... 300 lines skipped ... ]
> >> +/**
> >> + * enum iommu_vdevice_tsm_guest_req_op - Guest TSM request operations
> >> + * @TSM_REQ_VALIDATE_MMIO: Validate and map a guest MMIO range for the trusted
> >> + *                         device.
> >> + * @TSM_REQ_SET_TDI_STATE: Transition the trusted device to the unlocked,
> >> + *                         locked, or running state.
> >> + * @TSM_REQ_SEV_ENABLE_DMA: Enable DMA for an SEV device.
> >> + * @TSM_REQ_SEV_DISABLE_DMA: Disable DMA for an SEV device.
> >> + * @TSM_REQ_READ_OBJECT: Read bytes from a device object, such as a certificate,
> >> + *                       measurement, or interface report.
> >> + * @TSM_REQ_REGEN_OBJECT: Regenerate a device object, such as a measurement or
> >> + *                        interface report.
> >> + * @TSM_REQ_OBJECT_INFO: Query the size of a device object.
> >> + * @TSM_REQ_MAX: One past the last request operation; not a command.
> >> + *
> >> + * The request payload and response format depend on the TVM architecture.
> >> + */
> >> +enum iommu_vdevice_tsm_guest_req_op {
> >> +	TSM_REQ_VALIDATE_MMIO = 1,
> >> +	TSM_REQ_SET_TDI_STATE,
> >> +	TSM_REQ_SEV_ENABLE_DMA,
> >> +	TSM_REQ_SEV_DISABLE_DMA,
> >> +	TSM_REQ_READ_OBJECT,
> >> +	TSM_REQ_REGEN_OBJECT,
> >> +	TSM_REQ_OBJECT_INFO,
> >> +	TSM_REQ_MAX,
> >> +};
> >
> > This is still no where close to being well defined enough.
> >
> > Everything here must tie back to defined spec references, listed in
> > the comments.
> >
> > I cannot guess what data is passed over any of these APIs, how things
> > like "REGEN_OBJECT" select which object to regen, or what the format
> > of those objects even is. The formats of req/resp are never specified.
> >
> 
> The request and response payload formats are specific to each CoCo
> backend. Since iommufd treats the payloads as opaque and does not
> validate their contents, what would documenting those formats here
> achieve?

Well if thats the case then no, this is entirely inappropriate.

iommufd requires every single struct to be documented and
described. We do not do undocumented opaque structs into drivers.

So figure out exactly what needs to flow here, give it driver specific
names for driver specific content and document everything.

This should be done patch by patch as the drivers implement their
stuff.

If the data passed is different then it gets a different enum
value. No sharing enum values for different structs because the
drivers are different.

You can say things like 'the content of the RHI message defined in
XYZ' as operations.

> The limited validation is intended to prevent this from becoming a
> general-purpose multiplexer ioctl. 

But we need that for other viommu use cases..

> It restricts the ioctl to a defined set of guest-initiated
> operations that the host forwards to the
> firmware. The path is essentially:
> 
> guest -> vmexit -> VMM -> iommufd ioctl -> TSM backend -> firmware 

Yeah, I'm not adverse to this, so long as it is fully documented and
understandable how each system call maps to both the guest and
firmware interfaces it is supporting.

> > The comment for this should probably be *enormous*. Every arch should
> > explain what they do on every one of these ops, and it should be
> > identical if it is structured like this.
> >
>
> That would require documenting a significant amount of backend-specific
> detail in iommufd. Could we instead require each TSM backend's
> guest_request callback to document its request and response formats?

It needs to be in this header, that is the standard.
 
> > My guesses with no information
> > 1) VALIDATE_MMIO why would the hypervisor ever need this? Guest
> >    validates MMIO through secure communication to the secure world.
> >
> 
> With VFIO PCI BARs backed by guest_memfd, the VMM can validate that the
> IPA and PA values provided by the guest belong to the VFIO device.

Why? Who cares? It isn't a trusted validation, and there is a RSI that
duplicates this?

> We previously also used this operation to ask the CoCo TSM backend
> to map the device memory (the BAR regions). I have removed this
> operation from the latest series because that responsibility is now
> split between the VMM and guest_memfd. TDX and SNP still need to be
> updated accordingly.

Right, it should happen automatically as part of lock.

> > 2) TDI_STATE I thought at least RMM did this with an RSI?
> 
> CCA uses RHI. The RHI reaches the VMM, which issues the ioctl to
> complete the request.

And then the seq numbers check that this went through OK?

> > 3) ENABLE/DISABLE DMA, see #1, must not be done by hypervisor
> >    See my reply to Alexey:
> >    https://lore.kernel.org/linux-iommu/20261022123058.GC3008132@nvidia.com/
> >
> > 4) READ/REGEN/INFO, what are the objects? What format are they in? How
> >    do you select them?
> 
> These objects are cached by the hypervisor. For CCA, they include the
> certificate, measurement, interface report, and VCA. They are read in
> response to guest requests. The requests reach the VMM through an
> RHI, and the VMM issues the ioctl to read the requested object. REGEN
> refreshes the objects/evidence at the guest's request.

> >    Does this overlap with attestation subsystem? Should attestation
> >    subsystem be used to access the SPDM related data?
> >
> 
> 
> I had hoped we could use it, but I could not find an easy way to
> integrate the two. We need a simple way to read these evidence objects
> into userspace. I am not yet sure whether evidence-get can be used for
> that, since it does more than simply read the objects; it also updates
> evidence.generation, among other things.

It should not do that, the generation has to follow the locked state,
not the evidence collection.. See my remark to Dave

I think the bigger issue was it had to use the VDEV flavour not the
PDEV flavor of RMM commands, and it isn't obvious how we switch from
PDEV to VDEV mode on the hypervisor..

> > I think this is probably a fine generic API, it should probably not be
> > "TSM request" so that the other viommu people can reuse the transport.
> >
> > I would probably try to stick to exactly like the other APIs do with a
> > single enum. Two enums for op/arch is saying already that the ops are
> > not well defined.
> >
> > So maybe strip this patch out to have no tsm stuff, define no ops and
> > just give a command transport into the viommu driver?
> >
> 
> Are you suggesting one ioctl per each guest request ops?

One 'u32 op'

Jason
