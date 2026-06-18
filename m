Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FB33D6DD;
	Thu, 18 Jun 2026 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809544; cv=fail; b=bsKWTfQMnyIkq9a3rlotXat0+AWl+NlXhwK7vNTmQTobv9nq9AdAvYiSICO/uI9fgyMl2TCUq2d55lp055EGxqAW1GwP0UtAzNrPkQhjCJBUX6qP4jC7Lc4iT4oQiwcPLscBCBUMy3oVQQ5RDo6fuIalY2CGjrsi6IsWK9quCrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809544; c=relaxed/simple;
	bh=C+9uVlNvnn5IW9PQiKXreFOK1IhA6fT36Ljx2AV3lFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5EA7VvOeMgUZvR2WqSvsapnwbPuu0qPb9/7/2Eo7aKjoS5cfGfX52p3X4hRL/7fsPZW6y9OUgQilrF3y3o6Xd56QlZc/eN9tEO1B84zOebCA7/VEy9zZOs5CURzx5ZbAbsX20t76KQSweY0ORqf1ilvrwGi8HWFNLjxXWk8pBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vRarZRZu; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vRarZRZu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIiNtZq7NvYUQn2DupJhATOiGzmOihMG8OLlHKb1EkUymKK6XgWzCjYtAhes0yCVJlh/YtcC13KC0/KqlbvZ+sa9uRF4/f/H0hEOD/oI60x3Bu6Nsq+cg1R/bFiRiwrjoIsEN2458CfEerY6/gZn9wC1PxYCS1Rdqs7fcoPvR/OrbFIf2IowX8hwnHE5HhondwwuyPcC7Bnp8EMTU5+tdUMbgeUdYWvLRu+tLIj6GutztcPXKK+VwXhpdfu9OhS9SS8P9awZkE150t3+y3DeoB5n1lFN8QcQmQwDTElbY6rvF/U7YGWW56QKP7HSswxQeWlZjh98XXaruEo1dykENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyesOy7cMQpSqPbSHWRcZcy2a5lDIJjQlTTbmrNQsuo=;
 b=e9fCML+ZU4wBy3WFA3PCu7Ig2TsnJ3K1jnYRrxvxMk6Fg4JcPWLPpcEOszqZLxoIfSS1yX0NGdvQU9mGZxkbNmFbaxKL3RL0M0OI7Bym8sHweSCeAJaQGC9JCdJZ7fanqVuGZPu3v5fLg17X4QAPtv+qgE9obvIlVsWZCyLHYPqIPSMrsgV1KtWFkNFieSGEdzZQGx+yq1gWWFB1mG2PB3be0z7Z0odgAl8ntBJiToQEW4GSCCmsPNMdI9zqwLH6jNbKhPvI3lxtp4I36CZJ8BAh1oklxP+B4NbxgY4Klx4I9PrGL+OSe/NzFIEnr79ZAb/q/0MN+sTL/cKez1ObjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyesOy7cMQpSqPbSHWRcZcy2a5lDIJjQlTTbmrNQsuo=;
 b=vRarZRZuXAimuniLuxDMQGNbD1raeL+MDaTOdyBt68/4r2sE4LnGonwRZxlI8NhGD0q3QXaPngTIyX9x0EhslUBJFcchVMYaJdgPtx+tIUlW6X/9NLjPjaUDToG2Ui2YEoWHjUlQrrSxOF/OG3RToPJyp82RwZ9GVMrZ/MBM/Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 19:05:38 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 19:05:38 +0000
Message-ID: <5c12d5db-15a3-4669-aa94-61583b1265e1@amd.com>
Date: Thu, 18 Jun 2026 14:05:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] PCI/CXL: Add RDPAS support for CXL.io
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, jic23@kernel.org, djbw@kernel.org
References: <20260618170723.2010490-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260618170723.2010490-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::28) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bb7502-c4c8-4724-7cfd-08decd6c95ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WpM/xEYYumao+wQoJe/lPets9WOK9Pz2X130VvzHmzWB4LSe8L4AluNZwO8pKDky32sYpCnx8dIXkH6GLAvHYp2PK0DZfNaALfoFxlZq001E0eJ+sBDWwFaiKiorBblUJ9RYupiD1PYbiDIFjh9s6dnkahXehU+DSjH9JPqDin3Wtzu+Qmcbvzw1zJbShVhNzHl2vppk/oquyGsXcBLuuAClOje2npf14p1TOMoqo0xL/RpIM+1lhHUF85VvgcqcCiG+m9yOVkgmhv9UujbK2fuN0GF+SMuCY1o4p8oUef94qV7R9NGKFEpF5xJrRMSl8hIaxQMDeFIADEUmd96n+Hn6ApqaEYwuKUniLWt238UIE8wve644ircVbez6ebXokQH0xExZDCoFlKY3wlZhQ71frqvoNeqIwx0gzbJiiCPFA8D08LRLb2MQrqJPelkDH/uBc1y4nX0KxNrdxD65/rF+kEp75rDvV8rYW3zC9NsFWssZDgBvvcZtOBR268Z4yuVMHl7EJoQEjDF6mCNQp67jj2HWcND0yttj+DtlNvkZ8lJGSCYUTw+voxfsvAprQmSqiKeoSFOSfrlBCrBE9NezuG4EX1XKHvi6hULj70aomuyJTASMyT1aU5cObw7FPbE8MBvVMTYEK40Ec4h2L/d0eXH1pOBHf36Iz/7TNwtityJYpKyGWMc+rYoOoi82kX7hfWoQHfGsO5opGkDj3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmFMS0JOK3BNOW0zWHIvSnV4UXZadjZ3VFM2NDlEQ25nS2pxYXI0VnJjekQy?=
 =?utf-8?B?OFFuR01zMlJjb3FwVjU2QzVQM1VYejRUc1d6TUFRenRvWXA3V1Z4dVpnTjAw?=
 =?utf-8?B?bG1Qam1hamI2Q1V5d3pyU3QrL1dvY05TWmhoUitRNU5ITS84UWxrQ2pXUS85?=
 =?utf-8?B?VkkvUHRIUndneVpocFdzN1RqbEU4V2ZsUkxqdjlMZU5heXV6eGNZc1lUM1Rh?=
 =?utf-8?B?c3FJVG5MRGVBYlgyTTIzUlV6ZzhZOTVNTHhMQmIvRXdQOXdMOXVvTkwwZlZD?=
 =?utf-8?B?MEhudVFXWlJjYlZFbVJ0Y2Q4Z1NOTFpyRFhFdHlCT0NkSHo1QW95a2VDY0NU?=
 =?utf-8?B?SnlnQmJ3VkhFeGkyK3JYRFl5OU9RZ0lkNGNka3pzaEtndWN3SjZMQnZPbGI1?=
 =?utf-8?B?SmVZTnY4aFlVV3ZOSnNRRnI1dlk0cDdrSklUaFpGQTdQV1RHRUZOU1RBN0FY?=
 =?utf-8?B?TTRIbUlzc2ozWTRLazk0UUZGOEZ2OHE4ZW9OWXBWbGJVZ1NPR1ZIZGhtMnoz?=
 =?utf-8?B?bWNxNmtlRTVPZmpUWDFScjRjSzRZbHpNYmNQZXhvTXJhZmFoQnhnRkVlSTg3?=
 =?utf-8?B?bFEvd0hidUFtQk0yb2NOZ3Y3Vmk5VEJWWWhJRkc4bkNqUHNPejVpWFByNkJa?=
 =?utf-8?B?Sm5nNVVmNVZlSzlyVzdtZUM3dkthZGJHaFZrNDQxMmZiUG5FTzRSUnpkRkJ1?=
 =?utf-8?B?U0VEcEdzd0U4ZFc3NEs0VTJlK3c2YUw1WGdZNDVjeFBqTEZseHNLSlFVMlNT?=
 =?utf-8?B?SjYyMVM4YlpxNDNEdXVaRWRReUlGR0o3NTcxMTF3bkxnZ0ZLcUNqTTJnNDFu?=
 =?utf-8?B?Q2ZaeFVaK3p4Y0lOa1ZpS3JnV3FXVVJWT1hOMzhIVlQwSkFqZEVxOTM1R21s?=
 =?utf-8?B?TUVRWTRST0FtY1dtM0xxbWpsY25tQVl4WHdzUTEwTmNDbUVad2MyWHZRaE4x?=
 =?utf-8?B?bDZINHBIZGRuUnFlYjcwY2NPMC95NFZUWVBNQnAxSGlRajhhUHVQZU1GbHQ3?=
 =?utf-8?B?bHUra00wR0w1RkhqM3lkbU0ydGhadnFXWko0dG9FaEZ4d0hRaERvcFVKUWNH?=
 =?utf-8?B?NzBmd2R1Q0wxdWdmaERZNVB4YkZQNWhjMW9DTVIrNW1hWWlFVWNZeWVHK1pS?=
 =?utf-8?B?c1NmcHJWdFpobmtWOVhSWERwY3UrK2pPZHF0Y1ZLMUdxTFRMc3kzTSt6RFU2?=
 =?utf-8?B?MlZ6citLZTZhTUJDRFBXUkNZRThXcjVCcmpUb2VwY3ZUcFZzK21lL3lBMWpm?=
 =?utf-8?B?ek5rSzc3Sk1lRWQwalVpY1R6bjdWVktObzNla1dBRXdzbERBQ25Xc3NYbDRV?=
 =?utf-8?B?dW1scHB4c2JzUElYdU8yZW9ZOTAyTkdXMUtFTXBhUFlEWXZkNnQ5dk5ORXdt?=
 =?utf-8?B?R1NkeG1WVHdsZithdHVvU3BiZmpVTjdsWjhVYVlQb1h2YkhxT0lVU3pkTkJm?=
 =?utf-8?B?cDJPRmRnNXY5VTUzYTVhRVpXejlTNVdPaURIbDJ1TGhWSDFQaEpYQzloNDRU?=
 =?utf-8?B?WS9ZZVAwZmlFM1BSWHN6ZDFCMmdYazIxZWNFMXNLQnozQUdUenBZMFQwZkRh?=
 =?utf-8?B?SHlXbnRvM04zZ0IrRVdnSlBkM3loZUJDSGJuTktSTFh6c29HNllkeGZUK3Vz?=
 =?utf-8?B?SXk3SmpJcG1TQnk0M3VDczduUTcwU1RTRVRidXlSQ25SaTJjbU9FbFZGdHhW?=
 =?utf-8?B?TXJQak9OUHdrNWRGVzZxMy9yU0hyU1MxanJpYjVDQ2hMU0ZxRWVRNHh6RnRP?=
 =?utf-8?B?LzdvZ05lVmlrc2EydFJDT3FYbTEvbVpaeUdPY3FpN2tOb1hCcDFPVktlU1Zp?=
 =?utf-8?B?UHE2K2dpbTNsS296UlJrT2loSkhmWTNIbTFnU3RKR1FBajQ5cVF4SE1tbVB2?=
 =?utf-8?B?c2dWUjFwUmxBSnltR2RjVWwyQ3ZGRGNjMHFqd2FPb05CNkI1WHJlY0NtREVK?=
 =?utf-8?B?VHFsZFhmc3grcDZOWnYxYklrYTg2SDE4RU1pS0Jya252OHNOMXlOTlZhMVVp?=
 =?utf-8?B?b1RKNnlVblZiVmsvWUZZNS82ZXhSV2hQVzV3RjFQbnFlLzJ3cDVFQ2poQm5D?=
 =?utf-8?B?bjJaVHBJblhXTW1JWklta1lkcitoaXFod1QrclZPc1BpYjV4NEh2TXZnbEhT?=
 =?utf-8?B?Q2gvZmw0dUVOZndZNVllTzBMK0R4Z0tWK1JyL1g5dGM0cEFmTEhFMWVmOWpB?=
 =?utf-8?B?VVBwRGthcVFHZ3JZaGhVU3A0RDI0Q0kvNXNSMXhCK1ZOeDhKTjBqWkZtazJM?=
 =?utf-8?B?UUozeUpQOS9tRUVFcXoxUkovbEQ2dlhhWEc1R0ZaTWwwWHQva3g2UUpSdkhB?=
 =?utf-8?Q?IxmmqwNy0NRCcijY7f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bb7502-c4c8-4724-7cfd-08decd6c95ac
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 19:05:38.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HNJxssmuH5/ZtZC3Gnytgmu6FiUpX2i/t9azmpYWK5Pke92M52nwdEDAZZZLcqnMUG++YXfhjyTmtA812XLtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584

On 6/18/2026 12:07 PM, Dave Jiang wrote:
> v2:
> - Added multiple DSP per RCEC support.
> - Added boundary checks for reading MMIO
> - Addressed issues raised by shashiko
> - See individual patches for detailed changes
> 
> The series add RCEC Downstream Port Assocation Structure (RDPAS) parsing
> support to CXL.io. RDPAS is an ACPI table that is part of the CXL Early
> Discovery Table (CEDT) defined in CXL specification r4.0 9.18.1.5. It
> provides the mapping between RCEC and downstream ports. With RDPAS, the
> error device can be directly found when an error is reported on RCEC,
> without walking a number of RCiEP in order to determine which one reported
> the error. While CXL.cachemem is supported by RDPAS, there is no easy way
> to discover the source id of the error and therefore finding the Linux PCI
> object for the RCiEP. The intention here is to accelerate the discovery
> of the error by directly locating the error device with the given
> information.
> 
> This series is based on top of Terry's CXL error protocol series [1].
> Looking for comments on the series WRT if it makes sense to add on top
> of Terry's error handling for RCH/RCD devices.
> 
> [1]: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/T/#t
> 

I was considering whether this could possibly be reused for other RCEC–RCRB use 
cases and lifted into the AER core as a generalized solution. However, as far as I 
know, only CXL aggregates RCiEP reporting using the RCEC SBDF and leveraging RDPAS.

I think this will provide a useful alternative to walking the RCEC’s associated RCiEPs and
should improve performance with scale.

It may be worth clarifying whether this supports both RCH and VH modes. Also
consider updating the problem statement to note that the current RCEC RCiEP
walk processes the RCH downstream ports of *all* RCiEPs associated with the RCEC.

-Terry

> 
> Dave Jiang (2):
>   PCI/CXL: Add RDPAS parsing support
>   PCI/CXL: Enable usage of RDPAS to shortcut error device discovery
> 
>  drivers/cxl/acpi.c             |   5 +
>  drivers/pci/pcie/aer_cxl_rch.c | 271 ++++++++++++++++++++++++++++++++-
>  include/cxl/ras.h              |  18 +++
>  3 files changed, 291 insertions(+), 3 deletions(-)
>  create mode 100644 include/cxl/ras.h
> 
> 
> base-commit: a558d1571c0b3bb6b4a830cb2cd8f128cc5ef3e1

