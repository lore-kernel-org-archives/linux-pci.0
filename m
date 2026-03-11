Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D912BEFED;
	Wed, 11 Mar 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241412; cv=fail; b=Wdh70T7GE2b/W4cg8QbEv8kt4zPU3BE/YSpfy0ZdEGzdQjozgN9PEqzE697OKtIn+JVxudwpPp3ViRYugc2eNxexYXbfDHE6BuGNRi5/QACrfHx2kHHnhdMwVEiveiu77t/oq6eUJGJxm35vU/eGHdlkZjazoGx9REVb7p9LPUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241412; c=relaxed/simple;
	bh=GP2U3qn26EMn/pJWxBReT9+Ak22DXjd3/Zz/m5KIuBQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1Uu54QZkU8fevWc1WuRYEm0OP8gpFefjMDsRQsWtGxKqTIEFy3w75L+WCVU1eSl/CLpWdVhm4dZbX/t3kv4xCEupzQAtERPjNwmhcs7iRf8yFIy0q1fCiBQq/oWU7w2xmZrep9NuJdSxKIsvfbHYLiIz6eswOhQP76SXtcq7CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sETu3ws3; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sETu3ws3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB89SZRLPvCkB/Vz1qQpjDlCP/jXlsE7PbqKc1GvY+EaYsDYWK4mYps47aHyZyuGl6ktBoQ7SXGG7ECIOBJlKzTA2+hYBEmJykbcBd5leO1mt59F76Flt2FjijgVPsgxwqmma5+Z58u32nv2aZnt6iUe++lgOr58cN46IXCN1tLe62sBRJ2a+656Wo36EU4x90l7MjO/5219kcHO8xCmvVjnBU+nabD4Wd8eziGZbJj1Sax+fC+BJce2cwX2szRWjquuCv2tYUwspPki22iGiAGZEUzyKC3CA092E676FKarqPEF9CyD2VSBDYqYYdt66fQltFkLNot1oa0n8hLWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvO1GFsJFSs2mEkELH3P87hybzT3e6/tmrXsLDPhvMw=;
 b=UiKsSrBYTw6lp/S9XkXARTK/Ay83gL5KsxYzh49qqpbzuHEubCkKXOHL69/v1wUaDcMUg6jcK/7x7vn2jDxxTHUcAb7cD6zE/XQkEKKE/aMsc2m+tsl7blVpEC0RZK9JM2doRHyE5tbG2fSypeVfyag0Wh0rtG+FSTiXdwznuO0CVHinHHf1u0rMMCooDK7ZqoDITW7VTbQcVLg1YDsvkVuJNxvjz/jtYYiFNT3ab3SvGK9Jmsn3B6e8KxrzBHeSx4wec6wtLnSvt5orvVC4Y7W2EzYiAFbT/WtyWEb3txndVddtT3I8nq9qF8Au/CBnrgrvDhZc5wLJ+YXd+YImmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvO1GFsJFSs2mEkELH3P87hybzT3e6/tmrXsLDPhvMw=;
 b=sETu3ws3FDhoGynJUGECz4ftqEAtTA1XWuoWNp3/vAAxQShAYY8/I9KgtszAYXvxTp45a/59uTammP3I1+TL3qN+KEmHbOgF4RR9GvdVaL/t+0AV1N78tT1DO02+MO2sYvdn/JnPzWTw0+VuS2Y5nbu8ftGI6N8tYnXp7owO8gY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 15:03:26 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 15:03:26 +0000
Message-ID: <efbb52fc-96c0-4603-a803-c2a757f88ee0@amd.com>
Date: Wed, 11 Mar 2026 10:03:21 -0500
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH v16 02/10] PCI/CXL: Update unregistration for AER-CXL and
 CPER-CXL kfifos
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-3-terry.bowman@amd.com>
 <20260309122751.000025ed@huawei.com>
Content-Language: en-US
In-Reply-To: <20260309122751.000025ed@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 1988068b-e52d-49f0-a23b-08de7f7f58a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	GjskFto5oI/g3VBzwc1xgLMAAZ9MhHD7jGkKIx4112yYoEa65RHka+sBpYxYWDX4WQzB0cnGHS7XKgsBALJGsvjUX+JYs28yXiA+TY0QmzteJza9OKwuVfe7+w18oiQ+G5wU8dUWdCxLGezb+Ci7LKo7KD1RbVTFD1nES3kaVecFIDdd5SPKiazGMMTeYVLhRUDF5/dRdm10UyHt6rC3t8AiQqHtFT/ocMv79kQXNcEqEDCdPu3vxNBxRg/oAvTJI+3/rynZzLIKRpFLpYAwWgBWx1T6+t6PICHIie6kUGUNxIeE1LSsrhToJJJzksRYecBTn2tdtuH/YGeJI+ctUBE+/XmbgU1Kf7DuMcmDMs1ZO8DOUOhSJnQyiPKzJ6zQ0RK+pLd0/bp/TZwH+RiAvECuee8XvCr6a8jJyx5VrV44FmjiA2SOUTOE6javzBz5m1uDNyD+pJVnze/B1SvFAoognmqTMtYzSr3nZ5B5B7bvgGT44pNy2f9kEIJUImXANKDrovAUNV+aOVqwMYWANqNDhJ+Xn3U4BChJsuX4N3aKXsAfL3L4k1qH/JFAiSzPUxJE+REvsyoatkAZwjxv7UR6qgXjQC//kogdlogOOucuYh2FdTBwihiyxa+G6G/CRv4evzFTqolZx0itYErW21h+XumpRQw/eMEpu5qXnl8XFeLqr5tXKVyACTdN4JsT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRqS1FVb2FGWUVab3k0Wi9GRmNaUlBnM2ptd2ljSk9XeVoraVdTNW55RlVy?=
 =?utf-8?B?UVhKb2MvQ2xsaGF0R3JxNGRsVStLRzdNZk9rZTN0eGU4dFpjNVV4OGR3eEJZ?=
 =?utf-8?B?UDcyR3Fxd3c0dW42Ri9weWR6aUwyYklnT3hyanA3WDZXY1dPU0ZHTG1ERWlY?=
 =?utf-8?B?Z0xOeGk0RXhUd1ZvRGYzMDJvS2hOaTR3WFJLSkdrTnA2K0s5M0R6MjZqNFQ3?=
 =?utf-8?B?M1hCaHh0NVJPOEF4Vk1UUzBFWVRPZS9uZ2N4dklTN0hHUW81bjlkclM2WTJ4?=
 =?utf-8?B?L0FiZDhiYWp6bUYwUVJkWW5qM0h1NGhPR3lWcXhhNllQRTBMQ0ZLVjRBang0?=
 =?utf-8?B?RDE4ZFNFaDZiRHVhNzJ1RWpzRUplWDA4QWMwbEJmdTArbHRjMDlocXI4M0xa?=
 =?utf-8?B?a0QvRlNnRG1vM004ZWJ1RTJTZnIzOEkzdFRZbkJILzMvdlNsWU9LcFZNRzZV?=
 =?utf-8?B?T0JFYm1ubnJlZlkyQmVHZEdvT01OSXN6WEhrN0N2anFRSUkra3hKekVNaThm?=
 =?utf-8?B?amlubVIvTDRKN1RFMDVRN1lqbmVRK2g3YmJqRG42eWV6N3FFb3hwK1g4RTBk?=
 =?utf-8?B?dHR5V1RWRW5OMzQzNFpvWTMvZWEvVy9WbTFjMUFLVkZ0UCtiZldGYkdXNHEr?=
 =?utf-8?B?cnJqYng3QkFIQmpKNmVnMGk4NVo2ejRyWjBVQTVkYllVUXVLY29hK1I4Sm8y?=
 =?utf-8?B?RU03Ris2dTN6WXZqblB6TkJZbWRyb1k1eVZUdmoxZjM4SWVOWk9QU09rK0RC?=
 =?utf-8?B?SkFIWEt6VGUwckFsMmJrV0JSOFh3YTU2V0liMVJpWVhDVC9mUVBkNFJnMDl0?=
 =?utf-8?B?TjlnTi9rMG1UNE5peFErSDR5Y1JOY3pSNEdnNElRWElJc2I0M0syYThsMVU2?=
 =?utf-8?B?c016RkR0SnVTQWtudENnYStpcVF5bkpEMThRZlFjKyszQ2ZYVVlxejlKR3A1?=
 =?utf-8?B?VGhmNmt3Z3NlbDhuK1QrTTJvNFRHNXVocXpjbk5sOTlZdldUc1NCemlTSURD?=
 =?utf-8?B?K29wZ1BCSXJHQ2EyVFJtcm8vZ1ZYYXBjRjBqVE5hdW5LNEtmS1NlQU9PYSt6?=
 =?utf-8?B?VWNqYTA4YkJsUHdsM3ZxWGhYeFNtYUVyb2pKUE0zeE5pbnpFbm5sNzR5Uk9W?=
 =?utf-8?B?ZnV2SmlQcGdLeXVvSzA1MC9zR0VPRGpyaHFLUHhHYWhSaHRUR1ByVlFVck5Y?=
 =?utf-8?B?SVowVEtzdFFUUkMrbDdWdm96VisrQUptOHNoMDM2ckNiVjBpL05mVXZDZnN0?=
 =?utf-8?B?TGVqR2dLTlZtbDRXUmFhZlpjWVdyN3hFcUZxU1I3Zzg0aDRvWVNSZUkvSzZw?=
 =?utf-8?B?M1pzejZwaDdqaUZFWDR3V09TbTFmdkRaN2lhU2dhdXhKOXVmREo3TFZyQ0pm?=
 =?utf-8?B?cjAxbWp5QlJyM0pXSVNiOElYMUx1OU9tendjcXdwWHhnNjdQdy9ZV3Q4aVRC?=
 =?utf-8?B?b3hweTNyandOelJKRkw3RG55ekpuL0d2WTU4dm9pZ0lrSTdlMjk1ZkU0dUxK?=
 =?utf-8?B?dkhpVERoQlFhL2JKQkVBQ0pKek1LTFFjaEprcWw1cG5zZ3pUMi9aeHhwZk9V?=
 =?utf-8?B?bVdFeHpCbllmdVVTV2VxeitZSHFCdnpndzZkYS9qTHkzOVRqYnZBVWVNaEJw?=
 =?utf-8?B?ckxvWHphbForTEYvUk9YU1lwY2lrQ0VPTHlzNGNpSWN6SGZLZnl1MHZpb29J?=
 =?utf-8?B?eUt2UytTZHUxMXVmblZXTjlERVczZ2sxeHBYN1NERWFmL0V2VFo5Y3pKWHNx?=
 =?utf-8?B?ekRYeFJuMURoS0xTd0ovcDczWUtRN1pMbXFVaHNwSnNkSkw3L0lCL1lLR2pq?=
 =?utf-8?B?M245a2R4cW1UK3YrSzhyWC9YZEN6QlFBejZCbEZvUURkWVpyWEZua0FHeEJI?=
 =?utf-8?B?UTlmeHRhNXlsMjkxc2FXMGx4RVByQnR4VXFpa0Q4dlJndURNdnduTi84b1Ar?=
 =?utf-8?B?SzdnOGFSY1ZmMHRQZ3FCUkwwaHlsMTlSTy9BZVQ1NDd5K2lWSFBwUDNxcGw4?=
 =?utf-8?B?SU5OTWxDMUtSL29nTWF4RmdqVUhTT01wL1BKdjdqZDJDbldkL0ZMS0xrbGlC?=
 =?utf-8?B?V1NBcE4xNTBYZFRSSFJ1NGk1cUI3WDg3TmFKaFk5SlgwZWx2K1c2UEgvczg3?=
 =?utf-8?B?bUxVZk1WTjdvaER6RUZmSFBiMVh5Mkord0RyREpxNHVXbnZzQ21RRzBSUmhr?=
 =?utf-8?B?TEJqQUV6b3FjTGJ4Q2ZYd3lyS1BUTi9GRVZEV2Y2dUlncmV6ZVgyRklVUGxW?=
 =?utf-8?B?MG93M01pU1JUMkpTUnpMbDhaV3JZRXZaMVI4c1dKTVJWOWZTT2tQODU4R1hL?=
 =?utf-8?B?OUZ6WFhGZGorcTEwNDUvcDBtUVUzOXh6eUN3V01BNzRFVU1Yemd5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1988068b-e52d-49f0-a23b-08de7f7f58a9
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:03:25.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siakMYErUKomSgg3o43zD2WkvHN3tNYlf/t2utZdFusyZdQU8iNJq5mkcw9tqNNE+2e6ILjUhs7Um+pJq7ClUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163

On 3/9/2026 7:27 AM, Jonathan Cameron wrote:
> On Mon, 2 Mar 2026 14:36:40 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The current AER-CXL kfifo unregistration does not cancel pending work after
>> clearing the work function pointer. In addition, cancel_work_sync() is
>> called on behalf of the CPER-CXL kfifo in cxl_ras_exit() and should be
>> moved into the kfifo deregistration function.
>>
>> Add logic to cancel the AER-CXL kfifo's pending work in
>> cxl_unregister_proto_err_work().
>>
>> Move the CPER-CXL kfifo cancel call from cxl_ras_exit() to
>> cxl_cper_unregister_prot_err_work(). Release the CPER-CXL spinlock
>> before calling w to avoid deadlock.
>>
>> In both kfifo unregistration cases, add the necessary synchronization
>> to enforce proper lock ordering: protect pointer updates under the
>> lock, and clear the work pointer, then cancel any outstanding work
>> after the lock is released.
> 
> From that description, this feels like it's walking the edge of
> being a fix?  If so should call it out as such. If not, make it
> clear there isn't a known bug being fixed up.
> 
> Otherwise seems sensible to me
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 

I'll add explanation detailing a call to cancel_sync_work() will prevent the 
possibility of using the work routine after its unregistered. 

Thanks for reviewing.

- Terry

>>
>> Link: https://lore.kernel.org/linux-cxl/6982ca54e094b_55fa1005@dwillia2-mobl4.notmuch/
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Assisted-by: Azure:gtp-4.1-nano-key
>>
>> ----
>>
>> Changes in v16:
>> - New commit
>> ---
>>  drivers/acpi/apei/ghes.c      | 6 +++++-
>>  drivers/cxl/core/ras.c        | 1 -
>>  drivers/pci/pcie/aer_cxl_vh.c | 9 ++++++++-
>>  3 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 8acd2742bb27..de935e0e1dcf 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -776,8 +776,12 @@ int cxl_cper_unregister_prot_err_work(struct work_struct *work)
>>  	if (cxl_cper_prot_err_work != work)
>>  		return -EINVAL;
>>  
>> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
>> +	spin_lock(&cxl_cper_prot_err_work_lock);
>>  	cxl_cper_prot_err_work = NULL;
>> +	spin_unlock(&cxl_cper_prot_err_work_lock);
>> +
>> +	cancel_work_sync(work);
>> +
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 006c6ffc2f56..949d8c8ecdfe 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -124,7 +124,6 @@ int cxl_ras_init(void)
>>  void cxl_ras_exit(void)
>>  {
>>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>> -	cancel_work_sync(&cxl_cper_prot_err_work);
>>  }
>>  
>>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>> index 7e2bc1894395..ebca1112652a 100644
>> --- a/drivers/pci/pcie/aer_cxl_vh.c
>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
>> @@ -74,8 +74,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
>>  
>>  void cxl_unregister_proto_err_work(void)
>>  {
>> -	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
>> +	struct work_struct *work;
>> +
>> +	down_write(&cxl_proto_err_kfifo.rwsema);
>> +	work = cxl_proto_err_kfifo.work;
>>  	cxl_proto_err_kfifo.work = NULL;
>> +	up_write(&cxl_proto_err_kfifo.rwsema);
>> +
>> +	if (work)
>> +		cancel_work_sync(work);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
>>  
> 

