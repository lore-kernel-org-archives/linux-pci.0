Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B22BD0B
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220095; cv=fail; b=POZnl/4QMj+AV3XcwzeKXD9TnDesakoam2GAOEvFEMmMNVDdZYDVK1G/xXFsBJFJee/t4ByxBO141UwOjZAMoWtcJ4tjfZinqf2e6yg8G1O+WosvSfprgeS4kdinPTtsLlvPihnc25Nzl5kiievfCC5DaFLZhZiDPzHJ+oKIasA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220095; c=relaxed/simple;
	bh=pJjf8jb1osRDcN5t0r25vP1jFGOxb0dL5YlGZILsbGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JDgz1DBbvNeuXSxNOjhpass8Fzd7qkyOuoH/pY7NxvjMKqCWBA4MsFVDUs2pEcY9hmQ3/WDb4MOqV9wxqREwFKeF0/Ha9quc9+Kfc44yYQtkhTs8e/hnVm6N8ij5Q/ZZeEe6UdvBlCmncEbB2ejR9BoaRMtjBKh6AGUjlAl9OOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ymFQMDRp; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ymFQMDRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5DAIh9y6082qcMPzSAgkvm3s9YHeLF2TrPxunJ3Z0UVqAflmSksBkm0ahZSemy+AS0ahFAD4pdqsMAHMdwJ8wrlLeD1sN/all988Ho3wUBu4lW928JNAF8QBQh2Jj8ADEpqVuiuI1ceE/jT5k72Dr9XewLj21/62hUqQ9dMv+1p/ASvQ5SOWnKdCQ6HT9yCIzTsbPbQ8NbCm/DJSDsRrTqYMzDMnlalFOUV1GVNNQiIzXsnxeOWVUZOTutXxiKCH50ZgSMr2O1l9Hov9dYeAeNLXnrlOWBeTHSTV2SWbsnhfgdOWOEEvimPp55YuaOAz5qigEOwkrJskRW2RvqviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ihiek18iA33qiJNpBt+4r6yiFsJWx8Ps9GfyDxCSGhA=;
 b=ERme+zy1UVDpSIYkmI9Ksl+9LFXsPJcS42aN2n4y9l47bEnDyAF7d4te9sS73E7QX0P4RDdTzqACDU1fJW39qrL2q9+oXutT4jQ01IbncI9m+mJuzkjrX1OPCdmpkUXMI4AoUcwWUS1+heCTE9D+R8dOdGX+JzIAozg0JSkiPHi1443PI+6gHbfzso/QGLcw35D1smRjDMKFzAhQBR8t8C+EnGezY1+GqDF9efZyBXcn+GfgH6xbunO4J2qVJTycXxEwSVeuhv3JrmWZcnDbuvJmvWRCAj106ao1bKPqj9iCL4f7+/oWtVfYhzeUB+8W93Da8y2/yjv+6b+dnMzr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ihiek18iA33qiJNpBt+4r6yiFsJWx8Ps9GfyDxCSGhA=;
 b=ymFQMDRp13wC+0XHfzRVXxLRhOsA+v/OjVmcNkN1eAd/czet04fytdG79Ex8PbRTT11Ug/u5tZTN5jPCjE7JWI5daoozE3iwCgScjnzTKC8o5/QeRGsqWE+DMfadCqmATFelZYwPdSVKXwD9IcakHaEBFX4DMmjQGUWoMvtZxtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 3 Apr
 2026 12:41:31 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 12:41:31 +0000
Message-ID: <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
Date: Fri, 3 Apr 2026 23:41:25 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
 alistair23@gmail.com, lukas@wunner.de, Arnd Bergmann <arnd@arndb.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org> <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
 <20260330114902.GA310919@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260330114902.GA310919@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0143.ausprd01.prod.outlook.com
 (2603:10c6:10:5::35) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc38b39-ed8f-4a80-cf0c-08de917e5519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z4iexwIxDguy1lkzvOuc4+FqdEOAFJGYuI/0xYRQSpzZtARXxyjeGar+Zv4vsqgrDihC/E7WdtwgBPRu0aG44stEh5ScALb1hY3LHKvZH80qIRg6vwWXXWr31yz6yO5b5qsAw4jKZkWnH1mWuvuYUUggaWgYWszuqsTBCo4c2TzVHErmgUXvSaPf5TfyBrKWguHz2bHJezIn7EDfXg4yD+8ZTjhphZPlDjAdma1rW87QTbMybFXMbh6Uh+sBL9ukXIu+XAkfVJVeoJz5b52N5l0CJWUQ/jgrWRaXrOS4zD0WIfaAK7l7sDbgjiMGs0oqWOFe++Ldu2Gm3qmgq4JDC3aoaKav9VZqlgTB2wTCqGliAkyGt3sW4/TS4yZuk3NXx5hYY2lup8AdyKvp7XrRiP7Dqx7D8GguSwhuIQ4ilPXzRU9F93qrBpFWPHOgMGOco4s9Payh5kWjZeN/RHAHFSz/G8kn4C0q2UwTFd0q/bRJvksWv5wkzZaK+fl4Ww0SY4JpjSC1f+ZqgqmaCQ7bCFAyyWTOk3lnvrUQcxw4GAQDIx/EEC21lrUauSwHF+d9v60OGSEe+3RMwiwFBPM9vot9/QjhRuvrYf9RQm7fZ8WJfoHJJnqvAw8Oxt2MaHEvvM/IptokFwebcDm4MPFBlf4jyLRgR/hkwHJb/xDEpMCg/eU/EBnuutvl3uQnf1OQD0WVCSGEdpUCDZoyi21Z7Jq99OG5O3I/L1KMfb75hY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTVCNnNzNHp3blhCSGNNbVBsTzM0Q0h5YnpEOGN4dWtYRTRSS21PWWVyNWlm?=
 =?utf-8?B?WENHeVMwRzNadHpVTEhQTWpGZEFjMHRwY3dZelA4ZFFyd1lsNGZlYUR3NG9N?=
 =?utf-8?B?SFlYZXBaZFJmU2NHWGlWODNZMkowL0c2aU9QY3ArSUNmUDhUZXFqcndVM1hU?=
 =?utf-8?B?aS9IRWtnZEpDVVRma2pqQVByV25VUW1QSGZmV0RiTk5KNUxGa2tDL2RYUHM1?=
 =?utf-8?B?VFdZYWxBSnFKRng1c0lZN20xYnhnUTdUQjdOL1FWWnhlaUlhc3N3NlpURkMx?=
 =?utf-8?B?ZThIK3paR2VLSU9hSUpINE1vY3dGRlZGZkp4MWlSQ2JyQnJIalB2aldMSDA1?=
 =?utf-8?B?dWk0UHdYRVpXekpDRytvUHBJaTFUVmJIWnpFcDgwNmYzb3pjVFRIL1RlWWxX?=
 =?utf-8?B?QTd6V2x1bGc1WGhHdGZvZDVEMjN2ZERHSkZwQVdmZ24vVHJJaUtGbFc1TFBt?=
 =?utf-8?B?TU5PWC9nNUJnV21tRi83bk9SNnRlM010N3RGTGZXaUZmVWhUKzB2NCt2azRi?=
 =?utf-8?B?eTV3elVNMXI5WEUwVDNBdVc3MXg5V1ZWU2dmalRlZGZ6TFA4SllmLy84YmVD?=
 =?utf-8?B?OFVtbWtUeTJqeFpUc1NuREVqZjNxT3MxaEtYVm90RTY2alRqMmZrMnVOUUVQ?=
 =?utf-8?B?MTdkbmFMbjVUYTgwYUdJTitFd1A0U2tYV1pwNEF6U0JSYVhqSW81R3hRQTVh?=
 =?utf-8?B?VVl5eHpUQWZiZHdjTWZEeHdzYkNtV3QvMzEybGpEcThZMzI4bmpsVlpIVTBQ?=
 =?utf-8?B?Q0M4ZnowRGNXK1J5dTRUL29jNzNhSWJxSTVwb0ZJSnZxeGgvQzRBcDdmMzgr?=
 =?utf-8?B?VWJMZjUydTYvYjNEZ2pzM3Qxckp2RzRzR1JVUVFDTk5UMDhqUkttNEo5M3No?=
 =?utf-8?B?ckdHRElyT2pFY1ZhSHptbGdWeHlpOXFjRjdEL29WSjMyTGFuV05zVUNvMXJG?=
 =?utf-8?B?YmJZeE4zdHU3dlBJN1NqYjg5NjF6eFBVZW5ySzZSTjU5L3lRTlVPRFJNa2ZW?=
 =?utf-8?B?cnJuTVkxK1B5WHNnTktoaUN6eHAvRURTdk4zcW5oR0RONEpnUHRGaEgwU216?=
 =?utf-8?B?UDNYa0JtU2tja2dmcFpZQ3hTbjNNeW43TW9UMzUwWmJqQkhFbSsxQmxKSFFL?=
 =?utf-8?B?YzhOWmE2Njc4dFAxZEp6VTFKMkw3NFJHRDNnZzArYytkN3Jlc1NTNVFuOFZY?=
 =?utf-8?B?WE1LTytjMDJQUWpKQ1BoNHR4Tk0xd1JWelB3SVYwZHBJR2Jmdkp0cGRYZ0FX?=
 =?utf-8?B?OCtNRGpTTjZzZHIxZkkvM0xpcjJEWWR6VGV0TEJ0Um5MTDZZenVvc2NJMHh1?=
 =?utf-8?B?SHQwN1g0K1g0REZrREQvbnVLZ21mRzlLVWJjaUJPOEdQTFRLanFFVjdBKzkv?=
 =?utf-8?B?Z1p6b1dqblYvdmtnaklSUXR6cCsrcHRrWGpHMGFNSkgycGtTdzd5OXFVMVZF?=
 =?utf-8?B?Z3hwSUVFOFljTm1WdWRTdURmTzRrL1FaNmszTVAwUk85akQ1enVONjk4Vm94?=
 =?utf-8?B?Ty9IV2dTV0dKYXBBMEsrOFVyZ3dsaUNMMTcrWFJLRXZzbXF1TUR2eTRVa0Fr?=
 =?utf-8?B?SWc2Kyt2QkkyRksyZThRcTlabnJoYkRJSjZOV012MHB6bWFkMWtqQnpzeCtG?=
 =?utf-8?B?UVg0QVlMWXhFdGhUNG82NTFBTFVNOHhlRGtuL25hT1MyNmg4QnVYWnlHQnRi?=
 =?utf-8?B?a1ZzL3NGZHlrSkoxeFZpendMNEdIcnVnZVZ0Ry9xbEpCRTBqbktzSmNLanZJ?=
 =?utf-8?B?QTJrS3REb0hQOWJCNjRaRENiMlB3SVM3d1Q5OTdJRGIzRjRLTUFXS2kwc3RX?=
 =?utf-8?B?WHprdWxwNE0yWDVZNTVHazVtR1p0clVVS0NqZmc0Nk03NXQyVlhkTGg3WGFx?=
 =?utf-8?B?bTVReXp0bytBc0dIR25EYUZ4bUtoN01iY3NXaFNjTDhIaDFVYWlJY2NOUUxT?=
 =?utf-8?B?eEhDWTQxRTBZcmpybjMxWjBWLzJZNk51ZVphNnF2cWlNK0d3dy9tTHBpRjk1?=
 =?utf-8?B?TVdJOTd5OTVxMjBNY2tnbHFaL3pzbmpxWnppMlE3RE1UOWRkaXBGRHY1dG43?=
 =?utf-8?B?R3lwTkF6bEdtQi9Nc09SN1JqSTNjK3R6T2lnQnVuRkJQbXI2cXZxcFJka0lO?=
 =?utf-8?B?U0tNSzFIbHk5TE8xNk5DbEYwOFl3bVMzUExNWTR4OWpyang1NHFCQ0dJSCsx?=
 =?utf-8?B?TVBqRnJYTVF1aE9ZMVkrYnJXb3hBK2xSL3FSY1UrVXRQS0MrQ1NmMG9VSFlo?=
 =?utf-8?B?dUNMbG54OGEzK1U3Qys2SDRPN3A4SmF6UklRdGVJcGNKY2tNdUVaK3NiVDRn?=
 =?utf-8?Q?i2whOkWLX1GdyYe3gG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc38b39-ed8f-4a80-cf0c-08de917e5519
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 12:41:31.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmg3D+2u4TfRCV8eZ+OaxLm2n9l2baszGcE+rO5y7PyS6LsyMmG3W91uNI3xVJZssoaOe/O7hmuKR8jyOIjxKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281



On 30/3/26 22:49, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 04:47:44PM +1100, Alexey Kardashevskiy wrote:
> 
>> What do I miss? Thanks,
> 
> You can't tell where things start so there is no way to relate the
> offsets to something the kernel can understand.

Reported ranges have BAR indexes and start addresses (with the reported MMIO offset added), and the first reported range starts at the first 4K of that BAR. And these ranges are in sorted order. Enough to calculate an offset of a 2nd/3rd/... range of that BAR, and this is what I am after.

-- 
Alexey

