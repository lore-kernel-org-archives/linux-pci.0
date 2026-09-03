Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EEF4A0F19;
	Thu,  3 Sep 2026 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437359; cv=fail; b=NUHFJLA7yQO3jeYuTkHdSoi05bw9aCDnrxYn1iKdHEbWTLXpM6eTNy4i/AJtic9bMcOIw05+ZKAQrtkIVPa8HjySg1LYdE30YfPww6QoLNShH67EIV+jQvLSejKnqDmE1Z7bCIrGGnp3Js/1NbltVUTHcK/8kMOM7WfTN11fVNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437359; c=relaxed/simple;
	bh=V0qgE4Cg9Q6lADsnWWN6wG8uks2XUSd6TeAiBniY728=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BEUbpgHUDyMCOgJuiSCWy7ubFfMcrK0y4/I31rNeabe7yNht3ur3s0rLlMYa0S2NnGkkj1FvMFZXqRd3DWUHouA33cCXOyR5uqGBJWjj1ZL7eZ1EzH92yDwrF8YWUP0dQ5M45zL3B7MLdt9vMuSS84Id+n8IX29lK0yh3VEZz3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xY58r+XZ; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xY58r+XZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl25N3IFwjSju+R7de4NEs6CCWcNlOxKrgmcNOvNA4T2NTYw0MjAWeGyqYLYR+AenqLQ1vb6UrkeVdVuDA0JWdilk76JOeOHMk329WV5Hmd5J7IyhWyonWomrVf0kxcN8kyWil2vI/tlZjduUrRSa+9i+lDqV6UVKzTDDOuZh2LqiyrNqsSq7AcEG9HRSxA/Rm6Z4ZDP2+n2K13r7SjlM8j+e4/S/02gNwmoaO5gxZ0bU8aXHOG7uhCBUQDhzJTuefEzC+hLOeWpOUbYaoXn5Hq+89E91OUHM2cCnhUOx19MPfearcLBPv2Yz8Ym/mg9XgNOzMM3EfwPJGEk/WLjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmfTvrmGVdFpZagr8ArJgp6Hpn2EOBA2Y6CLoMdg4U8=;
 b=TWuKLDXbneZHls/5wLacV1g3OMSJ7tfzvFpT92cIzzgHexSGXr2+oz9jUuicqNHosvJTspoeykRcqYQYgBezA93a/zs1Wr3Dfpg3qxb40ZXBM4xltUytuORzBoVuXqijEvoUtasHNdDcI1G7Zfezp8qV3WJ2rsMAjXOsmmg+h3yEgwwh7GjULhl2aAEHknl6XW08t+1Kz3QbuER/wknM24UXRg+ASwsDGHniw2PLVFYnSOZzPg4f0WObd45wmsyvYSlx6iyOj784XdL3zlOGFTaALUEWm1H0N3/woys/HWdMuDDtnvSmzlV/m2yYsLSmdLme2YWF5c06+bfU/2RZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmfTvrmGVdFpZagr8ArJgp6Hpn2EOBA2Y6CLoMdg4U8=;
 b=xY58r+XZZIAOfWqVUUggpbEuW6k3mgmJAW2D5GGCjnChMegCTcI4nzer7lUQIrlUIIzXaURK9uU663skoWk1XWAp8bryXSLzj5az8yCKVsyFxuOD74PpdbMu1Bz5yF2KduL3aRKQaVPGVCyYh6Pfpf+M/tzwbGqqufvfUNkM0ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 12:09:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Thu, 3 Sep 2026
 12:09:12 +0000
Message-ID: <ecf98a97-a5b6-4829-92e8-0d1f47c44d7f@amd.com>
Date: Thu, 3 Sep 2026 14:09:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Accept AtomicOps already enabled by the hypervisor
To: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jerry.jiang@amd.com, haijun.chang@amd.com, andy.zhang@amd.com,
 Nikola Prica <nikola.prica@amd.com>
References: <20260903121218.4955-1-nikprica@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260903121218.4955-1-nikprica@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: ff455715-8467-45ba-51b1-08df09b42a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|5023799004|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yJ5BKk4aqh95NlunOGx30MGpE8dC2ddv/1/zuoIdtNXKqhZ9vG7cDOGa5U1VeO9s1RPvnbu5mM5FblSVIXbKiNnffSOr/5WVsnCPpiRPVU/NJgFhpsU59l1ylS5AScADi1TKE8qYEfnGzArwNjIvyTYXkxi4htZ2+geuRxhrnxNGJ338bj2q6HgSXduYREDmJfCA6opVvBNh+FRxjQ0YEf7ZSOR14V8F+uLX9uicI8Rn1XgsRKS0LriyLiX6JvJGUmN3emlbZY0jUNvF9VwQSXiyeR8tODCdJ8QrtoZKUZgkipbCVxt/OsCqRp1MEC8BRbmYQ8rjCRt6e4XXIrSAgYFYnrWKiuudO7RrmpYNiuS6FiLb7ngp6LTPV0taJUlwWdzAX8VX4spSSDTwNrus0QPsJC7oX7q3zlecVJrFSZd2XREqynlybHiwAtRIIQJ1uBRyD7ql8SurlyVkzBqmNi6AGP2sQETPUcTYaiMKykhEcvlfdnzfoFEVr4S2MzQRyAdRCBqtQeRW3Up+WXeWWsN3wU20Qs4ivcqenC1uN0Y9Fcp6YYqmze3itp+4Jyth12sSTlq3bWQxBQSTd6z3fY/wWOftJCxJ4+3QcaXjSJrte/2TiNbVdczUB5qVSBpoHzYgOlfQw/0N8ax7CsuFRkfdth6olkZejIrmDwgA93c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(5023799004)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmtKQUJRN3FaVzVBQ01wS1QwY3lmWUhYbGVoRnF4bGE5bkdMZmZVckJXczdw?=
 =?utf-8?B?dVBoMmtmNndoWUNHUTFObFI2cXRjYkR6RDYzanB0TE1hQjBWeXN1MUx5eWpP?=
 =?utf-8?B?WXMxQ2Q2bzZWWkE2TVY0MXRKNzVXaVVUbEE3WldhaGVjc0ZUZjRRSHdOZ2t6?=
 =?utf-8?B?R3JlenpPeVRjcHlKYVBMckxGMU5TZE1yYUZ6eURUN0drQU1NUlMxMkY4L0R0?=
 =?utf-8?B?V1dMdFl6R1M1N0ZESXZiWFFtR0tzSjI0SkN1dVFqSktyM21QdGNnMFh0bThw?=
 =?utf-8?B?T0xtUkVPREdjNVhmQ1BMWlB3cUk1Mkc5dWlPMzBld1pOVGtUaitZRUt3MEdo?=
 =?utf-8?B?Nml2QzF1bUdXK3A4OTJzcGd6Q3lLR2xCM2taekRHL3JJMHp1V1AyK29KREs1?=
 =?utf-8?B?RmNBNkJGZGNITGliSU9NelRMa0tnSjk3dlNCeVFBMXE2ZWxacndSaVFFb1Z0?=
 =?utf-8?B?T0EvMGNzSk4wNnpBbnlibGU3REFYQlZrN3JhM1BnWVJNUHVZaURiNENEclBI?=
 =?utf-8?B?NXlQTUF3MzYzaWp0SlJtQldGbytjaXVFSDNpRFk3OC9BTExMb1c3eHFMS2F5?=
 =?utf-8?B?eEFObVhIWUNFeFBrTCtnZ0RXZGxBaUxTSWkvcFg2ckJlZDhsOGgwb2x3MGhz?=
 =?utf-8?B?VGh2NVhMd3E3VjYvOXFBdnRaV3RLelZVMDRlUm13d1VyUjRLRkUweVVxbElv?=
 =?utf-8?B?dE92QjVJY1pSdHdSYTR2STVjMDd2REVSQzdrNmF3KzRXVzNQclp1QURyMUNs?=
 =?utf-8?B?eURLMW03WDNmeEd4a2JQeHNNWnlLZVJJUTJGMHF3RmUrOXphNlFRdTFJd0x1?=
 =?utf-8?B?TERXaEo0SlpnWnZqeUMxWDFVc3J3T3pRZ3ZoV3BFVnBKd1lRMzNYKzJ6dGdz?=
 =?utf-8?B?eWg5WmVEd0UweHAwRFJKU3NtR2JJMG56bGUwbVY4UUFYdGNCbktsUEpVc1B6?=
 =?utf-8?B?dzBoRXhZRU9rbFBIU2IxRzhudEFOVytUaTZ2a0NEVVFpU0dFbFNXUmo1T0hW?=
 =?utf-8?B?OTZlS0VHVXF5NEk0UVpaWlVpTFBlYWxlaFQ4V1JTdFd5a3hIV3phUXBIMXBI?=
 =?utf-8?B?YlgybG5hdGtoTldpRkIydEJ1LzdjY05qN1lXL1JsR21MSWdjRjVpazhhL290?=
 =?utf-8?B?TWtqU0RhejU5QWM2bXF0WkV2V29XbmxFb3piTm5VSkdidWdGVk5IMEZ2ZGxw?=
 =?utf-8?B?Mk9oZ3RsMjZhTksvcTN0elZyZ0FFTkZlelNZN0ZaRXhPYXJ6dUZyNVRmaVJC?=
 =?utf-8?B?R3BlMkdQbExwWm5JTWxWSDd5QUp1NXI5d05YeVlrYWc5YTEvSTV2TUFpS0pU?=
 =?utf-8?B?Z3RteEhPTE1KTzRnMXpOWktVb0JVWk1HS1FlTG9uY1VuOWpMcW1vOSs4UVVW?=
 =?utf-8?B?Sk1HQXBNRG45TlA2RnpHTmFPZ0REMEdHYzdoS3UyOWdyZ2x3ZDZxZDJ3cmhT?=
 =?utf-8?B?Ly9PaEZkU3ZBNjRuQkp6NnJPRlRGdXhmZy9aTWorcHQxSnBKK0I1MWhlUDZS?=
 =?utf-8?B?NituUUJIeVdWWFJmVnFQRFZZS0FKSEVqdnc1ZVNnVFpqZnBnamFqcnRLZENi?=
 =?utf-8?B?UzcweGJnbU9yK1VwOGhuY1BZOGszdTNiT0diZUFzM21KNkdJRHE5aGNRMlJZ?=
 =?utf-8?B?TFpsaTN3VUpPcmJVTk92SW83aUxuSTd2aWh2MTFmM2FyYUptSkpSelVqQWNX?=
 =?utf-8?B?a2JYaVhzTS9OcFNwS1ZuNGd2V2pMWkRWUUNnMzhCSGw5aHZrY2N0b3NYZ0xx?=
 =?utf-8?B?NlNKSFJyNG9Wc3JsMDVnT3VoY1ZkeHBnQmYzVnAxS0RQQ3gwNDU3M2FGRWJo?=
 =?utf-8?B?aTFadGpNNTdBRy9ZaGZOcWdXazVWM3BYSzlOb3dsdERLRm1YYjlTNzlQY1Zw?=
 =?utf-8?B?TGRWMjJkcm1kdXhnblNjWjk1RGNhcTFOaDlZNDNkeXVQWXNIR2wzZzlYT3FW?=
 =?utf-8?B?L2hXRzBVdHg5d3VrNTVhSG1QNmwwNnRkL0ZwTXNUZGpLOVhJcWd2SmVDdnYx?=
 =?utf-8?B?V216bGg2MmpGUG55UE9OMldkRjlNM2tHKzBDSlM1bTMrdlpRVHBKNnE5bWt2?=
 =?utf-8?B?NHI1eXl3anFTR2ZvZW56d0IzRzVkVU1WMFkwM05EZXJDVlFheWdaRGx5UnJQ?=
 =?utf-8?B?TThySU9zVEFnd04rNHczRmltRGo3K3oyRUNOSGlDMDA4ZVVKTjVIbDMyVjNS?=
 =?utf-8?B?L0JRaUgzbXc3SjZwMWxiVGdRK1JsVHU2MUFUNFJDeUdGT3FObENCK1VJTFEz?=
 =?utf-8?B?MTQ4UDI3cUtEaVJTU0hZZTRPbklZcEhHR0ZMUmNEdDlPd1pSSGFGZHlQWUdj?=
 =?utf-8?Q?UDLWIc/BCWuYlSK5LN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff455715-8467-45ba-51b1-08df09b42a5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:09:12.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n93w5r/OAVAqcmdRGDxESAQmTde2BR6zbW8RDtO5WkBWJLvCoKKS4qlSyx1jMp8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

On 9/3/26 14:12, Nikola Prica wrote:
> From: Nikola Prica <nikola.prica@amd.com>
> 
> pci_enable_atomic_ops_to_root() currently fails when no Root Port is
> visible. That is common in passthrough guests (ESXi, Hyper-V): the
> endpoint is assigned to the VM, but the guest topology has no Root
> Port above it.
> 
> In those setups the hypervisor may already have enabled AtomicOp
> Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
> treat AtomicOps as already enabled and return success instead of
> failing the Root Port walk.
> 
> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..7c62c7f31757 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3768,6 +3768,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Some hypervisors already set AtomicOp Requester Enable.  If it
> +	 * is already set, there is nothing more to do.
> +	 */
> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
> +	if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> +		return 0;
> +

I think for a bit more defensiveness we should only do this when we can't find a root port. E.g. under the if (!root) below.

Apart from that looks totally sane to me.

Regards,
Christian.

>  	root = pcie_find_root_port(dev);
>  	if (!root)
>  		return -EINVAL;
> 
> base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04

