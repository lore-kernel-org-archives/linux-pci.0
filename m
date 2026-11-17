Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954841;
	b=AidA4FcjWcvs1OU+Sw5VLU6keRD1hyGDpxcFLUgyYJpv5aPmVARWfBgQM1BzVNvWheg3
	 xu80PPVBQF5+aFzqNDvU1E1RwjRbsFVJDykl0kvmv89mNQD0u9RVlj0i6FaxWWm5ybn2K
	 tZb+pP4EADuyf5u3c28x3qgcEh3vk+D+YPqQLJi/7EcVP0VskXyP+oCVfOgdKrTScNDHd
	 UhFR+IBKzghs8FtxwLZbB2F1gsofGHxGZheWGx8V34dBJvkARqDdYhjN565fu9ZiSE72W
	 WNd/PXVl7bTtvnM8YYnfoC8FD9gyNvbFsHJvAJNC9/7NZN9F2b6TGh4/dwfuCstb7dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954841;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Nw+0WIfUgndCnT+pjXEsK3ANB3Hr23P1oewr/xRXiSg=;
	b=ct+jyp6Pf5b/Gu+5jXXbb5u9/DuojoQ+i82rcS+yxlB6KePU5DcYKwIIzx4/sAsPGKxR
	 ODt3sFH7bnpLQaWVDqN2lY/uZXENanAZ9ps9VHfOtOJTXMMb/lTwnsYZ4rq3t6Ud/550q
	 TbCrO8I7//neQDV+vZ6R1sqAcU55KRpSLadma90aTUmjL+mAglWvE3PIQocsqwdJwKoSD
	 fgKiul5uoViD9+djNRuXdcN+7T763mzf2qwXLZHFqv0ipc5X4NW1aebFkMMao1l42qYpp
	 KdiDrz41hg76dsWIE50kIeEH78B06cJUM/KLt7Uv5QhMBmOIY3FSJXcHhYA2/pqdujw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t7VzV9ye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.6
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD6606A880;
	Tue, 17 Nov 2026 22:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75AD6606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t7VzV9ye
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5a740qSZnl4HRL5w6vCeBwl0g8JUspTnny50mdvEPZ1Rf/XkwlnKo4TJ15a/s/orD8ITLPNYZzOVQneav/4QNKmfJk9M4KILGRj1YNxLcVaI4qGCzGMjwRHTQgdNhZmQdYeZqze/fbj+2MmTkpxLNIGCTUaHMLEdDDPD3Jm+5E+e0qzusoRMvfRNpe2pNtuYhx8F5auG0S08SotQHkVeg9760DFvPQNqh3NL2Qyky1qehMuqqrgqGc5DpdjHk23fQ5zq2vAFccU0zt1b2J3Eg0Z85Ll66gj69uwJF2BctHlTywNSRHcOwM4m/0wURuyPpWWjTGrvLDtXueZppPESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nw+0WIfUgndCnT+pjXEsK3ANB3Hr23P1oewr/xRXiSg=;
 b=sz6VvECASK6VKG4tkbsdkw4+HHRLnwPWQn4NN8k+qzS/Z7IpLrTZghsFyozKlPrszHh0ybt3b1gF8GTEG4YNpcOGkQeDT8o9NcmAZPKXcAXVOvfVxTUaysyim0dL5ilqnkc4Phah5pwXI+YXc4Jzi0cIbAlz7cAZ8ppZuW+q2rAwZS8VqmWaLb3UW1iTnpirkhoMALzAG9QRuicMNW++9YLfTgzHNBSutVTiuCIfbJl8mTslrjZaUW3JCr3ITmhU82HfUYuBGz7nrvd71W4uqnWP7ZCBpEqgQD/dgoW+/OHF/WHHrgnbnkYXiQI9UlKfoHvJVXKCQ2+WKMonCK8VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw+0WIfUgndCnT+pjXEsK3ANB3Hr23P1oewr/xRXiSg=;
 b=t7VzV9yeTATj5M1xmZmLsUaXrgF8ylHgnh7VP2oCGhpW57BheXvI611aCPn6AlAfd+E3Y/L2+HeaKkBgSc6nO/ev6NJ3Yrajsmk3EHMAaWUphgNvr6Rs0cCae9G3nW6UAjhtnwP2RjzKButXK3U+NzQBEwPvBmLXWyY2LkRSeaY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by MN7PR12MB288644.namprd12.prod.outlook.com
 (2603:10b6:208:636::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:33:58 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:33:58 +0000
Message-ID: <d48476d5-327a-4f69-bc77-8e5361c4a72a@amd.com>
Date: Tue, 17 Nov 2026 16:33:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/25] dmaengine: sdxi: Add descriptor ring management
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 John.Kariuki@amd.com, Jonathan Cameron <jic23@kernel.org>,
 Kinsey Ho <kinseyho@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-13-3668ccc7aab8@amd.com>
 <avdAHZ2ZmupYG2Dh@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <avdAHZ2ZmupYG2Dh@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:806:d3::20) To CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|MN7PR12MB288644:EE_
X-MS-Office365-Filtering-Correlation-Id: 796e431b-a7f8-4bd9-df8d-08df44fadebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|261009223027099003|11063799006|56012099006|4143699003|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3dqWn2sZ95OZpGfdHfCZdNlmPULpHMvvWINb9F9/lqfZj5vEQQDmiryt89Y6GaubV1zJQwXWpJP+2wV2Bpokod4xzS2bJw/JA+tpO/CYOhopKdgPmZiu14YBf6AWyKBqDZmR1RrE01auLzJZ6Lo26CK+bfOT7PldHs0ohzYx7SNZ5vj2oMIZbSIQIVNuMvdN1CBKL5dVnHVE3RrKrhPoygIzOxKSWPrZBQ9FFsNBVm+Edpko3YVtdqG1vlkvwTE848iGdnTv1GG6KTCrk+uSLraYmXD6rtpxcLRRO1eoJnx8f14qOBK3U2BlMoJYnipvK7yiafaZPUxMdD8mVdTUbw+q87TN3H6lUnF8Aynvo2+haWicU/4B4HdVTIC9MW1t9t+1K3D/bnub1zJknyeH4Ufj5VBgndye8aHpzLkAmr2LAgbez1LVJmHnfxwhxKn/PIf9rCzgvPKJv1rWGeJWlIUNqMgDhjut3bj6XaFEFxOIsSbO/H7g9tkuHL0AcaoTYSdCS0pdUsWP+LfZcodg/Fv+wObVN85wwaAU63zg3ufGBBTmD0/dBgC4qa2g6bhBE8ON/dS3Oa5virXjwUWheeTRvobtAPpBAWyv512TLeJOEgaqzfSFZo80ZfXIctFRkhyPkON0/v+HIeB00URlsWs0EyKsdq1emcKVXeOLJaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFjaGUvNjBkWDV4Y1FmTlFXSWppdWdtb2xzNy9XaUhMVFhpVlhiZkVZeHRP?=
 =?utf-8?B?SmVEY1dmbzJlTkZBUnRRa0o3QTV5LzZZM1JZLzdrZjRLY1Q3V2MzNjB2UHFa?=
 =?utf-8?B?SUJHVlZzWlRXQWxrTzNhVFhOQzB3OGZWSkZ2Zzk2ZlpYdGVRbUZzSjlvbWhi?=
 =?utf-8?B?U0pBUjJLWm0rTTM4eTNaZTFnbFkrWFFOQlYzcW5zK1VRbU5Wbnk5bXBxNnU2?=
 =?utf-8?B?SjgrSDhmbnUxY1lvdEs3UmlodkFMcTY4dDlodGZrd3l0U3IzckY1RG40Q0o3?=
 =?utf-8?B?RElYR2NWVGsyc01hcTZpZWZPeFMxdXJXM3N3MHBvLzRpcjNFTzdTVWVzQUsx?=
 =?utf-8?B?dWFJN0VnVTVKeGRjRDBoSlpjalVFVktERXlQSUNORTBqSUw0YkhZaWhWNWdH?=
 =?utf-8?B?UFlPM3d0NG9vR3I3eG5GYTdvTXJWQ0FDVXlTYnNENjRlcm9DVWZDSncwVGtv?=
 =?utf-8?B?OSsxZmpmUkNzb3lPRnZseVhTQ0tkRFpTbGNpT3duQUdXRUZMam1JaFRMa0V3?=
 =?utf-8?B?OFVkSzUzbTkwMW1uTldUNXpic05OWktXaXhOQXFYZEkyaVlCZmcwWDllcWJJ?=
 =?utf-8?B?U29xeldkU1E5VmxDT0pTeGZLWWN5NXY4bFpNdEQ1VE8xMHQ1UWN1VlJGTWJv?=
 =?utf-8?B?Mk1GcVdxcHpTbHhONGtBZ3U2ZDM3MWFuekNybnh2NVA0Yy9EdlZ0VXJnMmRS?=
 =?utf-8?B?UjluZy9NNEdoWnJtYmovWFRVdTFzQlE4UzZVbVY4U2lQaEsvWmdIcFhleERR?=
 =?utf-8?B?MklnVzdKUkQ0SlVpSVFNVXFjZnB1VmsvZ1I3eXc4R0VSUWM0V00vL1Z2ZzNx?=
 =?utf-8?B?Wno3bW40a3FWN0xOZ095OW5QcFJzQ0wxSFlKcXQzc1JHRUwzYi9lQzhkb29Y?=
 =?utf-8?B?dUFkUGJmZk84Q05WZkgwc0pWNkF3NkFFUmlYeG5DdW94aHdxL0lYRFIxaXdL?=
 =?utf-8?B?SWlDeWMrQ0tRQkZRb0htK1F1a1RuZUZ3TkxQVDgzWDlOcU1iR1J4NGhmOGFw?=
 =?utf-8?B?QTl4TVpHUmxrV1RYZjFZRDhrelNCc3pxalhRZHB5ZGFsaDlYT3pmaHd0dXBS?=
 =?utf-8?B?Kzg2bFJST3NUT0MyN1hFMVhyUWxzYnNiSHhWSWpBZnNTRURFY2RnNG9YWnBR?=
 =?utf-8?B?emFFQU9rbjNkMGhWNllHeWZjTi8xbWxqUnpoYlV1S1JmWXBxUWJORTdjZHJm?=
 =?utf-8?B?c1ZJNGkyYmd3OUFTby8rVEpOU0dvY2hZazUyZVdKNFY3UHJpOVRQZFoxM3BH?=
 =?utf-8?B?SllNK0NHL2VrbjRFalpFZzFMRWJQazRsZi9lWDRKUUJYL2JqclRDWTJic2N4?=
 =?utf-8?B?ZjJMQnBKNjdXNGFnVG5iVGYvNnVuSkowM0xNQXJmaCtSRm9DemtZOGllcGhx?=
 =?utf-8?B?TlV2azlBbHJwaUpKdlgyamE5MVhBUnlrYXRLQkxxeWJOL0xNcWFDb0pPbjEz?=
 =?utf-8?B?am9UOEcyRjBuc2VRM0VvaTh1cVVmUTl4dFhwSG5WQTFZSXFhNE8rQi9DOFJR?=
 =?utf-8?B?TW5QSmdKZ0tuRzNjWUtlZXJhMVBna0FleDB4cllqRHhEcTNRMVJ6dmpqUGFI?=
 =?utf-8?B?OFVzdDNZWUt4ZkFSamE0NUZGa2k0bWJYWHkyUndSYXpaTzN1UWtEME9TNjBZ?=
 =?utf-8?B?OVY5d3hpTGVhSU1rb1RGb3hna2U1L3I5M0VCRnRYcDFJd2JNSGp5RE5nSU1x?=
 =?utf-8?B?Q2pUTTNiZEM0UzlNcDVpOUU2QmwxRTBaZFZGeWhmdEc2c3hyMFh5dElTQjBz?=
 =?utf-8?B?V01yRE5TWEpGNmpHYnFQeWVZVGFFWjFmU082S3dUTi9SRVlBdXFzNXFyaDBR?=
 =?utf-8?B?aFdRSkRNRUFWMXU1NCtXMVR0NzUyY1NjY0FKVEFZS2hHUVdyRVFTM29IOGV2?=
 =?utf-8?B?Zms3YUdrblpLS2N6cXArNGRDd2ZzbW1vZDRLS1BBZHhpeG9nT3JDWFVHdHpO?=
 =?utf-8?B?QVpUYzRrbTd6VnZUTm5IZGZkeEQzaGhreGg5WUE3VDd0cEEralo0N0hBQi83?=
 =?utf-8?B?bXNvcVBFNEMycktwNituR2ZMSE83TEM4MkhYUzE5ODMxRnZTejU3VVZsQkhx?=
 =?utf-8?B?bUdoU1RhYktVWE5VUUgrL2pXVmVtMVpRTGljU3BtZ0prOGFtZzZ1bG04blJz?=
 =?utf-8?B?dmpWREFMSkR1ak9uNXV1REt5N0JWa2p4c3hhOFUxZzllUklJQ3hacTlVb1hh?=
 =?utf-8?B?b3V0c1M2UHVtRjlSMnZ5RytULzUwbGpPRTFkZGRhU2FaWHhKYmZwT3VkUGJl?=
 =?utf-8?B?VW1NUXN5bDF1VzVXc0xqMEVGeGQ0WlpxRGN6VEo0TnNkMWR1Wis2WGVRRlUz?=
 =?utf-8?Q?fWdMXqTPtKUQmuqOih?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796e431b-a7f8-4bd9-df8d-08df44fadebf
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:33:58.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OELGkOZDk1dcGZykrLjZ4xbusV45EY37WwBlv20nfgD6TDvAuqvl9kQESlNkc30DF+FemGt5clfQuZ5RTvINvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR12MB288644

On 11/13/2026 10:51 AM, Frank Li wrote:
> On Tue, Nov 03, 2026 at 08:49:54PM -0600, Nathan Lynch wrote:
>> @@ -72,6 +74,10 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>>
>>  	cxt->sdxi = sdxi;
>>
>> +	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
>> +	if (!cxt->ring_state)
>> +		return NULL;
>> +
>>  	cxt->sq = sdxi_sq_alloc(sdxi, DEFAULT_DESC_RING_ENTRIES);
>>  	if (!cxt->sq)
>>  		return NULL;
> 
> Is it possible embedded ring_state into sq or sq embedded ring state to
> alloc twice memory.

cxt->sq is a DMA-coherent allocation, so it shouldn't be combined with
ring_state.

Maybe the ring_state could be embedded in the context struct to avoid
the separate allocation though.

