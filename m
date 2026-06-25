Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6E221723;
	Thu, 25 Jun 2026 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782348368; cv=fail; b=gh9SP4qBte0+2K5p2Cq/JMsmQ7d2+CyAfa0fG7CmsV8Eok+jllCL7Oymn0uxLRZ6ws8nkCgnzdjXsQl+qDSoqyFxuTPj1qWDRe41lnLxnTWDBrSsAB9OlYSzKBX1lumWLG1lJ9Og6fYFLUldQ3u47za75fu9+CioOfyvsJES3DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782348368; c=relaxed/simple;
	bh=idavrytWJ9SidYwVLno8XcQwzC6dYLjj1ABDdc2EMoY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=O3aTLruvv1qWvgE90Gjc3Ose3inHmGUyDPIyXPLIV0opz55PWZNQCnqBtNHhN524JaOpygb6tjomZ+xAI80TNGNSPR+KHiFmc0IzPbPsIJR7yP7hv36LssrMHan9hCmoKclb/UvYBJ5ncAz7NLdkvWl/jfHJsgjyuz6tlo1fFP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rQi6URa2; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQi6URa2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLGmQiwPN0Vmwv9rrv3wYqIzsI9/zJPGL/ON0pjPVaYJ566VBN9OoPOhCP8SXMHQUr1sXsFe/b6WpVZaXTj7PxHD3ssSdrYamJVRCW1cUo9DnLx9y4IYcqhMDz9yqkXdeLvOiA3tG1Wj89Uh7n2oUWdzbbJSSjzc1ue9ZyOgmLWLsRzxhYiAf3qfHJGh3IfPEYMt43KbUSRrX0b5YWv5IgudCxWXnsS8CSdtVH8ETBJgiMxAfMQObddSlJSNLxu6eQshy3bR+notVDePmv8I1S7co9v0QtiM+ad+OJGrawtKr8FsVbrQbLbzXWIzxzW++1jbtO9QZCMkEwSkh9p/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCsTsuQX80wAWmFprRxnfSKHIznvffc8lNWzX3fpwps=;
 b=L4LB9NP3M+Fz9wSUCc9Bne5YWXeyuBD5JyOZLG3bFnSwKOoQJrDPcmAUgKOnxZiyB/ncO84ef9g+30cqVlwSabg7BjYwFtJZiV1ScgPTu9n+1TUnGeZzpoiskxsWVvKjN+C2i/pli5n1vmuDzAmzNCiQteNnauCtLPg4zr+xtmc6lhMy78V3IX/9rp0eQbm3pZ5r9/g6qPdjzmeykOy+cgCvtDuZRnEpGPNOHT78kM/RqacJTJludVjcbRfSnIKAAwnufbavXn/lHA8a7wrY9sYckmjmz/fm87HSEJfcJfWF/z50cIP/EHymW7mzOdQ/ZgIcBdW9oUVSsDTDo+ZL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCsTsuQX80wAWmFprRxnfSKHIznvffc8lNWzX3fpwps=;
 b=rQi6URa2NtLdFpl5WEaxapEZugX1tO5tdCDo3Cw+c49LRGFsrP/JYutoqzE+emHuobFVKjmZAt9q5zj49XwQjEJiBetQOlWfoEpgM1oDL+uDtx2PdX7bJJ7+8N3pTj71pUMZLFhKjaeCioxAqfwdpJZuB+qbYLcP4wHMcaHxU2LmBDSsSLYfI8sl4+vAXdARyliXuXIhpW3DPS2/W0l6nLvNI/n0fdSSqzrXD4WPPOrEGSvP3ZKa/FgDz9uLDhAsPArQ58gYLUXBudL7YowBgB2LUr+DGUKk4aqgXjDv4CySnWMPA0+vD91yB6YvfjrZwZ7Q9U2l0/xMYQJDLAXakw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 00:45:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 00:45:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 09:45:53 +0900
Message-Id: <DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com>
Cc: "David Laight" <david.laight.linux@gmail.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <dakr@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] PCI/IOV: Return u16 from
 pci_sriov_get_totalvfs()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260622194353.1308872-1-zhiw@nvidia.com>
 <20260622194353.1308872-2-zhiw@nvidia.com>
 <DJHAC9W05615.19MHKPF67OG2T@nvidia.com> <20260624143937.50499c29@pumpkin>
 <DJHDAQZ1AASK.14ATT70HTI450@nvidia.com> <20260624203851.7f6c7be4@pumpkin>
 <DJHNQRALREG5.37R3M4GQ2A29V@garyguo.net>
In-Reply-To: <DJHNQRALREG5.37R3M4GQ2A29V@garyguo.net>
X-ClientProxiedBy: TY6PR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d89bf4-da7b-437b-ac02-08ded2531f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|10070799003|1800799024|18002099003|22082099003|6133799003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PucO8Ve83NSbSpeAL8lQQ9tFZTC8H8v1d78Mup8JHvQlbxlLy9mravzn+bgyviRtzgtIxqfN0JC/OOyExWIryin3tFyi0NzDSsBhu4cMcMID09sWBKjTehJuIE3D9Y8vucdnQvKeFrrf5j9RBrf4GGTZfiWfD4BxEU/X+2SE0d/T3GMJTzE/d4FTH5YIo1/Av3yqxW9m7i7m5e+qrfrAU6BL/Y5GQymAmzIpIG4QQnP9kkGIYdkv+pUsfnuaw4xS8bfW4k7ybTF5f1e49yG6fDFr+nMYzGiKMhzIDPqbe/fq+dVBvQ81Q7JMJqb88Oa1h1Q1qXkEVyycnbhkLXWai8dY/aOoTxPx5OxRMuxKippBJNurJdyFAlBSAYyXXkVtQOMAXym8WBrdUV64w6BuvuBmcckXJ5lLeD5lAKbOhk0X3fWTk0Du10xD66BExBI6JnslsoSmm8vq6hiwZVq6p+D6BUG9Bfp0hFNri+dizGC/a5UaM0SSrZ7BaYqsPCa5KXCIfuQaDIwS+KIU0AJh6TlB+UB98X5JnX+kEVuwXlAc8s1qymHxBTgzAmQN/TNSPgr+Dln/SpsA6w32GKjWAcBcTJ8pmupfsGsI4YykuQT0EY8RI5lG9z+azgYpagaUpYNq1ZkgQjHzhAIYuVFzMmFlf0VFgFZKetgPO3HztRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THZ3WFpleFA1MXNFMW80OXdXQWQ5KzAzVmFDRGRHOWxBRDlMZGhZeXZqUHFH?=
 =?utf-8?B?RHVsVnp5RHZ6MGtTeGJJd0FTU3ZyaCtSK0QwM0grYzlhSjJKRlB3YzVkTVY3?=
 =?utf-8?B?UGpTMUM5Qzcrd2I2ajIrS0tMRlJEYVRJR3dqTngwNTZyOVh4MjNCRXFRY1Jw?=
 =?utf-8?B?Z0lydWh4ZkdsSWl6Zk4rbTJ1Q3FNZGl2MWNucHBobitSN2JNQ3ZDbUhBb2NB?=
 =?utf-8?B?c2UzamZReTkzYUZSUnMyM3hHb2VPTXBpTTl3cHNBa3lNQjY1VTB0czl0QTFU?=
 =?utf-8?B?Mk42dTVDdWlzNGZETCtjYnJIK3ZjRXYrLzVVMHV6MVFBSXNYMWV2NXFQZEh3?=
 =?utf-8?B?Q0twUmU0b0cvZXFub2MwWnhPMVVWck9YbHAyT3JkRkdaWExIdnNHemNaN3A2?=
 =?utf-8?B?bDRzTzZGUnk3YzZKdGxvd2t1M2dzTnVMVy9uZko0TnE0T1NXSC9aMW5hNTc2?=
 =?utf-8?B?MmRabVNpWmNOWkpUSU5yWVhHbmV3TUd6RHR2dVBLVTlxejhReHFDNzd6Nmx0?=
 =?utf-8?B?MW9IZVh3cXQzcUJjbG5JMWNSRXFnN0J1ajQxQ09DUHZPU3FYSWlqbjlFMjlW?=
 =?utf-8?B?VTF2T0VGMnYrNVZaaDN5amdvU3cyZmlTbUY0SzZjRUx4MnN1MklnM2JVN1U4?=
 =?utf-8?B?T214azVsdWZNRitRdHA4MEJJMWFnc3U4UHhKZnpEaEpLc2trYWFFdG9YL1Rp?=
 =?utf-8?B?cWtjUTFQQXhzc0s2VkNOcnhjZGVGaWZKcysxamZXVVdTSEFQN1hINjhzSW9r?=
 =?utf-8?B?Q1JqNm9NejZ0bjNqM04rQkNPeS8zTithY1FsOGZwL0hJQWtDMUhabXdpOC82?=
 =?utf-8?B?eGgxcFc1TUhqZXdJZlA1MHE4TlNZVmJiRUlDVlZ1YzhUV2FYV2F4OVBUNWZT?=
 =?utf-8?B?SnFJWWNtOVkycXVKUG5XT3VvWmVCbUtRN2RocFRzSDAxcTFZRk95ZlFWMTNE?=
 =?utf-8?B?ZEJOUU5sTU9vcmE1bFFSVjR3Y1MxUXhiSUwwbnI5MXdHaFlmMCszMWFvcUJz?=
 =?utf-8?B?U3hjOXBTTnZDQ0ZLNmN0RGZQR1FzQnRtRTNqTHR2b3hETU1yWCtsQUk2SmZQ?=
 =?utf-8?B?aTQ5cWxYQ1ByY0l4VXJ6MEZaeG8zWk4rcENndHJHNjdGMlFtTzF2RHNtVEFM?=
 =?utf-8?B?aXhKejBKN1RRYTJHMGk3TVRRVnlyUG5CVnZ0N2pzZDMrdDMydlF2SXQraGo2?=
 =?utf-8?B?enZWRjF6OG93Zm5VV29aYWxrQ3RiQ25CRXdBZmh6SmFRZDQvTm1GM3ZUNXBv?=
 =?utf-8?B?dC9kc0pJa3lUOWhmTkVnQmQwZTRveHQxNTlNSkJKdTJaNldQRkNYTTZzeEZV?=
 =?utf-8?B?OXVnYlkvc09FUEltbm5pZ0ZQOUVYWTAreGJNRk1HZEFJR2Vtb2tsTFZxVWVp?=
 =?utf-8?B?UjdUWHlMemlmTXd4anB0ejVRMTE4bVAreThTclhjbVlqL0JtdTFJTGovU1Fj?=
 =?utf-8?B?c1NFeUViOFZ0WTRtQmV3bW9NZjFsZzRzK3MzT05qSXpyaTBRLzhLVFdmd0l6?=
 =?utf-8?B?dFhKSXZ6K0JoT1VZMUUwRmw3TFVPbTlCNW9pTlVDVTdBTHZDOUFHaloxTkFW?=
 =?utf-8?B?a3Y0alJQRGM5U1YwSnFrZjVpWTZsYnpwNkR3ZkMyYUlUY0tDR3hvK1JwQTI5?=
 =?utf-8?B?NWF6bXV4T0o5Q295VEk4dkNEMi9VOGZqUlJyak1HMXRpZ2lMUFNqaUxna3pN?=
 =?utf-8?B?bTNrZzhkTmhBTjRybTJZbkcwT3ZvK3B1clV5Q3JJWTFoQUhObGhkbkptNHFX?=
 =?utf-8?B?S0VLVUJMdm5ReUVuUEVCbmEyZmNiVkcyUXpQM1RpTFhLY3dFMENpWElqOURQ?=
 =?utf-8?B?MTVsTkR6RFpwNFB1VWVSWEJPUHN4YXJVajJHTGsrUis2Uit3cENhSXk0bGp6?=
 =?utf-8?B?ZmZTaGYwbXpJNWtxRDVzRkFBL09panFScHBaREpjcjZzaVNQclBnK210YzMx?=
 =?utf-8?B?Y2lwcjJWTUw2TUFrMWtLS0g0NW9TcGZYT1hvQXBrN29nNFdFRlRBUGdua0xU?=
 =?utf-8?B?Q1B6VENUTWcxeDV3aTQrME0xcXgwOUhIbGR1NnViYU42ZGE3RTMxTGVHN21W?=
 =?utf-8?B?a01DaldKOHc2VThqdXBWaVpiT1VZL1l5NEdKRkhjb2VkRzRZTlp4b0pUYVl5?=
 =?utf-8?B?bUk1czA5NGRGdFhnVi8xODl6bHNIdy9ieGVKY212M09oNnUzc3I5R3o5VGpX?=
 =?utf-8?B?bWd1RFFDNE5VM0ZTenVFQ0gyQ29zeTFJVWc5dnRUSlJDenZPaDcwT1BKOWFF?=
 =?utf-8?B?VjlrcHFTYlZKNFFudks5OWdqWGdWdTRubkE5S0orajBEdnl0YzZDdERjNlV2?=
 =?utf-8?B?K3hYYk9naHg5ajNGM2U1cGI5NlNiZE0xRzVvekFkOGVaUWFLY0dpV1VYMFRL?=
 =?utf-8?Q?pYNjQgAbdcUPPc2Uge8nHAGOwBHH3emqk2Dk0YIodRbeF?=
X-MS-Exchange-AntiSpam-MessageData-1: 9FbAnDGTvElIow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d89bf4-da7b-437b-ac02-08ded2531f36
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 00:45:58.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUOPagfJvjPkMRn+z7lTISVXUJzt0736adQ0COaNiFBMGmIH5Q+yn1OMgy8wszQj4uG3+0eZyntheNnMsP5Zxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

On Thu Jun 25, 2026 at 8:11 AM JST, Gary Guo wrote:
> On Wed Jun 24, 2026 at 8:38 PM BST, David Laight wrote:
>> On Wed, 24 Jun 2026 23:59:56 +0900
>> "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>>
>>> On Wed Jun 24, 2026 at 10:39 PM JST, David Laight wrote:
>>> > On Wed, 24 Jun 2026 21:40:52 +0900
>>> > "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>>> > =20
>>> >> On Tue Jun 23, 2026 at 4:43 AM JST, Zhi Wang wrote: =20
>>> >> > pci_sriov_get_totalvfs() reports a VF count, not an errno-style
>>> >> > status. It returns 0 when SR-IOV is unavailable or the device is n=
ot a
>>> >> > PF, and otherwise returns the PF's driver_max_VFs value.
>>> >> >
>>> >> > driver_max_VFs is stored as a u16 in struct pci_sriov. It is deriv=
ed
>>> >> > from the SR-IOV TotalVFs field or from a driver-provided limit, so=
 the
>>> >> > implementation cannot return a negative value.
>>> >> >
>>> >> > Change the declaration, CONFIG_PCI_IOV stub, and implementation to
>>> >> > return u16. Update callers to store the result in u16 variables, r=
emove
>>> >> > obsolete negative-value checks, and use unsigned format specifiers=
 where
>>> >> > needed.
>>> >> >
>>> >> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> >> > Cc: linux-pci@vger.kernel.org
>>> >> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>   =20
>>> >>=20
>>> >> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
>>> >> Link: https://lore.kernel.org/all/DETDILPA1GFY.27WND0TEC5352@nvidia.=
com/
>>> >>  =20
>>> >> > ---
>>> >> >  drivers/crypto/hisilicon/qm.c                   | 8 +++++---
>>> >> >  drivers/crypto/intel/qat/qat_common/adf_sriov.c | 6 +++---
>>> >> >  drivers/gpu/drm/xe/xe_sriov_pf.c                | 6 ++----
>>> >> >  drivers/misc/genwqe/card_base.c                 | 6 ++----
>>> >> >  drivers/net/ethernet/cavium/thunder/nic_main.c  | 2 +-
>>> >> >  drivers/net/ethernet/emulex/benet/be_main.c     | 3 ++-
>>> >> >  drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 3 ++-
>>> >> >  drivers/net/ethernet/sfc/ef10_sriov.c           | 2 +-   =20
>>> >>=20
>>> >> I believe that you can avoid converting all these drivers in this pa=
tch.
>>> >> The implicit `u16 -> int` conversion done by C should result in the
>>> >> expected behavior, and it will be fewer Acked-by to collect. =20
>>> >
>>> > The generated code is also likely to be slightly better if the functi=
on
>>> > return value is a 32bit value.
>>> >
>>> > Similarly you don't really want to do any kind of maths on local vari=
ables
>>> > that aren't 32bit (or 64bit on 64bit builds).
>>> >
>>> > The fact that the domain of a value fits in 16 bits doesn't mean that
>>> > it is better to use u16 - it is usually worse.
>>> > Pretty much the only place u16 should be used is to reduce the size
>>> > of structures.
>>> >
>>> > So it is probably correct to change the return type to unsigned int a=
nd
>>> > remove the error return checks, but nothing else. =20
>>>=20
>>> For C, I agree that unsigned int is the safest type.
>>>=20
>>> Rust otoh does not do implicit integer promotion, and making it return =
a
>>> `u16` carries useful range information. I wonder if we could have a
>>> private `__pci_sriov_get_totalvfs` that returns a `u16`, make
>>> `pci_sriov_get_totalvfs` promote it to an `unsigned int` and return it,
>>> while the Rust bindings would invoke `__pci_sriov_get_totalvfs` so they
>>> can expose a `u16`?
>
> There're no value in having two versions with just slightly different pro=
motion
> behaviour. Rust side can still use u16 by casting from unsigned int witho=
ut
> having to expose both.

Indeed, that occurred to me only after I sent my reply. Since the
register this value originates from is 16 bits, we can justify that a
cast of the return to u16 won't lose any data.

Just making the C API return unsigned int is fine then.
