Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6EA313E2B;
	Thu,  1 Oct 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895535; cv=fail; b=AkX/VQeyY1xjjKiqe73KpS6HYRjmWIfEis6AdsGTny1R5EgaD2Zk6kA00dSrMRNJTX69rcJk0K5QTcPvYPvNaCViNqhpn0w5klwincnBnrV1fxJ8xT5CefPTWEQZFbu4rC+PeLW7Ixh9LRWnEmThWBaY21WqVSK5XTuZbUdZscw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895535; c=relaxed/simple;
	bh=Qebu9xEOaiK9VqnUwSExl1BB/Fj5Z4eKfCeMY3FSoKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RU/K495qitGnidetPOXODvX+MaSMb7bkj/9gxxniO4vDJvtrvD5ZO0Ewoo9Ev7hIL8FyDtK//s/wA2cmV+Xdkh6TdBFMchz7p9fEGReRsL1ymZa2cQacq8HfDHYpqJmP81XiN/dRhA7GOrl+g4nMFvHWxFYYtSn07d5aX/Q+oAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mSGHnPeL; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mSGHnPeL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkqQL0Qg0tH9GVzcKI+eb+O3zhwTzUl+17PKOe/5JskbQxxB4oCPvBToIC8rvM1MaUxTnDojrmrtaWlAwRayc9vTumBPGCszHoP124DmV9w7DPnEBz54DfoDssc0BDpBBhcsuVw3Ik/6l2KMyBeXihLPiunumpD+ML8Kbc1Tv6k6FWALxTxZ+3mDJuffO1o/MGldhDXn0+XziWo4USxJf/WgBEydZ6XADlBtyJTVW+DPKpCbzawR17uWSHZW8OhBa5fziRcXp2cgiel4c5fcTQgMottm/Z9rFT1bOyYUqePOgdXEkfu78SJRXQJCXw0XeWuisxJoYnCfzN2dUK7mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdjUd4kYpu7OEqw+ugdJxyDbadliyhxkMbCsrB3irmM=;
 b=f5MvwqGTaQkfas0yR+G1l0y5vAMiYaRW2rFDlvi9rfZ3uZ+L8A+oCvfpG3d/dAj4I57Dl4wrmJsLZLipm/bLe7NtfeAuIiatuplsBTFKxqDgrq1wMdg4l8JDE7OgGIEQpntIi4/PREyTJBBH8kKiSUI+cimWlEd6SB8HNVj8D9r8CiB6LULpbTIy6wXTQxnrA6iv3mNnGujhF8sENExwavVJ/bVXkvSXEpM4xjdck8S+aI3OuiOZZ4OxWgkeVAml+5xjJWeHOIi3OQiEWPiXWkoz+EQ/lGgrHPTu3DRDl3/9fXOTZQLywmH44nhtoYJ++O1/wKGvwClDrEy0DjRyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdjUd4kYpu7OEqw+ugdJxyDbadliyhxkMbCsrB3irmM=;
 b=mSGHnPeLohXv+fSWGE+emxdHMmH5b9FKdsw1A3FkmlmpV+yet0hKAVYbzbgpF5cs4AbKEYu6bnhNunzDCkD3urc7ssvrzMKPe63dP2XFXyPPZdCKvMukoCo63M16rFQwQ5nObcds5hWEhyFgF8eNQbGbdTVRes7VeyDHP9ph9kXfcVKszuXy4DSxMzvFSUG6DwYgdkoXeVEyryH9X3QyE26dZPAPPVuDg2jaZnv2cqvSLbXhjY/UblbMv9gqXq80aYXfKV6dTfs3sZSzc5TdxyMxC3NUzYxbm7PSPeR8o8LZrPTPT2YWBKIYYSVfLaI3DKXnxIOs8Nw81eZW18IFrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7153.namprd12.prod.outlook.com
 (2603:10b6:806:2a4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 22:58:46 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 22:58:46 +0000
Message-ID: <a2026252-44f8-4dcc-83f8-e838603a2ebd@nvidia.com>
Date: Thu, 1 Oct 2026 15:58:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/15] cxl: Refresh cached PCI HDM decoder settings
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-9-smadhavan@nvidia.com>
 <2c37c82b-8db6-44d1-868b-0b98bae57459@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <2c37c82b-8db6-44d1-868b-0b98bae57459@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e423c5-fae4-4215-8e4d-08df200f8cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|10067099003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	PgS1/6wEYIlU2ICatyX/wc9s0pBgwIFrOG8Y5476JJYzNTkic49hq0GtzRuKMi6UtafODBTSY0K4kIeh9NSbSpheF+niokN3o95KZyugvf1xxDeGUVwXZJpVWZE65onnBmn/U0w6M0cikEFBYpXa5dg2HzKoPs16gOoCiPw6eSh1O0Jfmf1xUsZmW7CRORUY5yVr4VqQ/d0n2AR7Efo8PTrReiiLjycdgR2yqxFDXP3pOadOnxiY0+OA/gZC4th55+hWHNZmR4EU+hdPc3GhJMRetonwtDg8CbO03+t2w4sPVdp8+AGotez9S8Tb2FyPoxX+ifIW7XfyUWHpOVQD6yYxc9NDM4wHnCu7eJS41f1jOScM0fYCAV3C+6rkRaQCmixAZiMqJ6T+l4ZZpBlNdpBj0jsv9KW2PBt0E47B1fEQJpHyAX3aqGMJONIFKZhCQMHUnHm53EUJGaFse0acW14xfmiw5nSQHp+iHKyztboiN/uWDt5aiMW6+L/xdYIg4aQJ+gf3/XgdE64mtqISYBo+CPUtj1Vy6flXN/diXooK6YYI559qKTDU+AVxxH3A3qz+fV3bc80IF2RvDXTii6LorrJejjdEkZ5dNfMPxTmbNmf9TDnvaw1Nh/rNMYgBDYwOY/wBO0Tj5xKdEPqGOBKa4sG9DEfUVz+4jmsMMmjbRERXNO2BL6Av0pYIR0eYjxCUNUEwchYAPOZpA0rRmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE1ZTEVXTU1kNk5CaFVVTGEzcUpSM0xoekVXdzJEMHBuWGd3dkUyc24xNmF6?=
 =?utf-8?B?bHRjL1ljY3pFaDBtamRXUzdxNC82cTVJK1ZJRFpCNHRuT3pRZmZ1MVRidEhU?=
 =?utf-8?B?dy9BaDFPbDRkbDlLc2l0UkhwYkR5aE5EVDNFRnJRSGpIVGViN0drWGlMU2o1?=
 =?utf-8?B?ZVZHNU9FWWp3TWdoWjlqdGpTUklyUzROcDFObXhTVWllRjI2d3d2c0JYbUlh?=
 =?utf-8?B?Ym5EM0hMOXo3YysvTjdZOWxiTGFrelVjdklPbFFhbVhJbnl1UDFyb3BKUmJq?=
 =?utf-8?B?MU1LUEIzTFJwVTEyNmdhR1l0UjVlU1BxNnhaWDh2UWhrQWsxaUlJRm45RXdK?=
 =?utf-8?B?d0JrSHR6UGt1QlNvL1U5VVoreDI5RDhTWEZuN3RQOXh2dUwzaVhuOFhtTHNY?=
 =?utf-8?B?MzEvWHVuNExVMmVHUzl4RUU3STA3S2FiQ0ZWWWplR24xN3o5VEpwcHE5bUly?=
 =?utf-8?B?NTlSaGM5YzZxUzNWSUZreFVNem9GWHBQZmw4TXlZbGcyUndKWFBOSGt1OGFI?=
 =?utf-8?B?c3Mvd0hLRE0rTVp5c1YwaFNML2xvekZoY2VCck5uZXhBMXZ5ck5QTGR5dXVN?=
 =?utf-8?B?RXhWQ3J6RG1IOHY0R2FLK2ZTQURrbS92NUZmQnFtWWNvcHpkcktQaWJUNjNV?=
 =?utf-8?B?VEVNSUllMU43ekZYbDdxdzN6dk9jM2o4SWJwV3ZycWw4Wk5qMU1HQUNXNThr?=
 =?utf-8?B?WVBrUWhJdXdiMjZnTy9IWVFLcHJRYnZvVHlyc1c3VXcrbG0wbFlrRndsUUVQ?=
 =?utf-8?B?U092dmZaS0ttNG9EL2R0Z3E5VHNQVWNFL20vamxvOGdKV3ovdVJBRkZ5VGU4?=
 =?utf-8?B?MDNXN2o5RlR5SGhBOCs0V2xZK1pnbFdxZHE5OTVXL2JPSnY5THB4Wi9vMkw1?=
 =?utf-8?B?NjVOeWxISHNOVy9Oc0lWY282N05GWUpOM3B3bXJQZmttallJOUdLcFArVlFi?=
 =?utf-8?B?TjlJUUZGODFMWkVJdnpZM2NUQWJXMWRNbVd6c0VMY2FuTFh6U1hncFBtdFFU?=
 =?utf-8?B?ZWIwMHRSM2FWKzJNSmxiU3I5YnJuc05IWm4wRG41L1dla2tUeEJoV3pLVmdv?=
 =?utf-8?B?N0xiRGtlN3Q1Q2ZjTFZmakpRTGVwRVkxK0dVRlN4eGIrNE1NaTczQlZ1UUlZ?=
 =?utf-8?B?YTVtR1dOM1dpaDI5QlFGbm54c1RESHZLMnF1aCtYZDlHVzFaVWRleEJHd0lR?=
 =?utf-8?B?ZGVSRDU4MDBwWFhWYmtMZUE0R1lEc01SaVBaOGdEZFVWMGw3UEQxWlZ5elJq?=
 =?utf-8?B?b2xDUjF2RmVPTUk5YUs3ZklNcEYwUHl6dlFQMDd6R0daMWM1cW5ZZ2xYQUJP?=
 =?utf-8?B?QmdZaFNSWGtTMTVUeUxKYXNxVXFWQVJ1WjVqTXlFZERRbU5IRVJCM1BqbHBa?=
 =?utf-8?B?U2lxM1lIYmwvZUkyT0VMM1NtWDR6RVFZWjVJdW9QVVJKUWhyUWtXcERWK1Ay?=
 =?utf-8?B?bFhSNjBIZjFHcWQrY2VDZHNrMHZlOTBkMGlaU3cvRWFTTlpYQU5Kb04rRkRB?=
 =?utf-8?B?ald0VlVqMzYxcUEvYWZ6TnI1c2RMd2YwSmxkQkNFQkRvNnFhcENwWndVSi9E?=
 =?utf-8?B?b3hoUXN1NTRYVXdFN01JOERFK3hvallaeVhnWEdhb1pNVkRBZ1NyelVEMHIx?=
 =?utf-8?B?cVJVYjFyeXdjbVN6cmN2SjljeXU1emo5TjFETWw4VnRpSythcXl4ZVZZdjVV?=
 =?utf-8?B?T3oydTBXRmVZcmhqR2VEWnJUNjFWWm43YzVuZGhwNnM4Ni9CUG5FWkpTMnQ3?=
 =?utf-8?B?aUhzclgrdFM4TGV4dHhpUG01YUgzTXJuR1BhQUp3WVdETFBQZUhSNFJnWk14?=
 =?utf-8?B?S3IzeUFWYnowMEUvdWRlSjhKQ1FyWmJBU01rQ1FZai9PVUVlQWoyeWpHZU5w?=
 =?utf-8?B?MElmYkhBcnhZd2tOVUtJUEg4a1ZqbGJGVklGUmZTL0hsZzhPYXk3OEUva3N3?=
 =?utf-8?B?U2RoUW0wUEJyNEdhWkE1ZWNYNHJWQkoxUHFsYkd0VGNoeGtvZGU5TWc4NUdo?=
 =?utf-8?B?Njd3WlIvVE1zVXd4dmJ4RnRIc2Rsd1VUU1Z6NzBkNTlLZGo2SlFCb3NsZWta?=
 =?utf-8?B?cGRyQUlXK2ZRaW94L0JzNkdUVkw0L2I4eVIxN01JYWhCUFd5cE9oMDRiYyts?=
 =?utf-8?B?UWU3NnlRR3lOVnFtWkZGREJQOWRMd0VDTXNJNDR4OW53NkFOWWJUWnQ5MUtx?=
 =?utf-8?B?NXMvWWFsZENxQTE2ZVdFVlRIRlJuUVNPL0RQbjlQNGtCWGR2ZG45MHA1UExu?=
 =?utf-8?B?Y0xvdHREOTVzLzlYcHkxVSs2STZyK2JWN3NKd0t3UGt3a2l0amtGcFRTWDFr?=
 =?utf-8?B?VTJnUUhiRHAzdzVWTFV3UGdXYmU3aFJkdVpiM1NPcHBpQ3AwSnV3dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e423c5-fae4-4215-8e4d-08df200f8cb0
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 22:58:46.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huFTDFvTXVnJ5RzcL3nO2KlX4C0ryDnZa8O4Dv/CF1BhmsR+Njflq52nDdit8rfX9KFn7yMv42Y3kaI46tushQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153

On 9/23/26 2:40 PM, Cheatham, Benjamin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
>> Early PCI discovery creates the HDM cache, while later CXL enumeration and
>> decoder operations provide updated programming state.
>>
>> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
>> so reset recovery need not walk the CXL topology. Ignore updates when no
>> cache exists and reject decoder-count mismatches.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>> ---
>>   drivers/cxl/core/hdm.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      | 22 ++++++++++++++
>>   include/linux/pci.h    |  6 ++++
>>   3 files changed, 94 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 98268e8e15b2..0ae250ea4ce3 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -753,6 +753,51 @@ static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
>>        }
>>   }
>>
>> +#ifdef CONFIG_CXL_RESET
> 
> The CXL maintainers are normally pretty against #ifdefs in c code. I was going to suggest
> moving it to resource.c, but it looks like cxl_decoder_snapshot() needs to also be in this
> file. So, I think the fix is to put:
> 
> if (!IS_ENABLED(CONFIG_CXL_RESET))
>          return;
> 
> immediately after the variable declarations.
> 

Fixed in v14 patch 9. Now cxl_hdm_refresh_decoder() is compiled without 
it. CXL_BUS selects CXL_RESET in patch 6, so whenever hdm.c is built, 
reset support is enabled; the IS_ENABLED() check is unnecessary.

>> +static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
>> +                                 struct cxl_decoder *cxld)
>> +{
>> +     struct cxl_port *port = cxlhdm->port;
>> +     void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>> +     struct pci_dev *pdev __free(pci_dev_put) =
>> +             cxl_port_get_uport_pci_dev(port);
> 
> This line needs to be at the first usage, i.e. right before "if (!pdev || !hdm)" below, to prevent
> lifetime bugs.
> 

In v14, the pdev declaration is immediately before if (!pdev || !hdm), 
so its cleanup lifetime begins at first use.

>> @@ -1089,9 +1136,27 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>   {
>>        void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>        struct cxl_port *port = cxlhdm->port;
>> +#ifdef CONFIG_CXL_RESET
>> +     struct pci_dev *pdev __free(pci_dev_put) =
>> +             cxl_port_get_uport_pci_dev(port);
>> +#endif
> 
> This shouldn't be here, and if you move it to be inside the below if statement
> then you won't need the #ifdef as well.
> 
<snip>
>
>> +#endif
>> +
> 
> Add IS_ENABLED(CONFIG_CXL_RESET) to the above if condition, like above.
> 

pdev declaration is now inside the endpoint/HDM check, immediately 
before it is used. Removed the #ifdef. Since CXL_BUS selects CXL_RESET, 
an IS_ENABLED(CONFIG_CXL_RESET) condition is unnecessary whenever this 
function is built.

-- 
Regards,
Srirangan
