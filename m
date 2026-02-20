Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455AA1DFF7;
	Fri, 20 Feb 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600522; cv=fail; b=gyXabMt53z9MiK1sP5WVmRhuG2FNWE7eIHF2Tie0gIVvrQNKMttSawr/PTJ+dLVAKUSzO61mfqlcTVUhxtp1Dq20Z79LPJVkejpFLHL9J029UVr7VoqQMbFXmC4HMo0yMCUEZZe7pg71Q9DD7e479Dts40hqKwmzwASxRFTpvNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600522; c=relaxed/simple;
	bh=KVYuptDyIeisBTFAbV+z7QUp7jfep384ymiL2WElpx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OJ4RpAW08a7/ehSPTjE4xo2jIqUJiCXMfZQInKVE5OJd+fZ+KVC+pi2zOZ6a69dQonyScrFkIZAnM61XXrfApcyEhuC6bk7S7QlINA87sSaxaP3OpndaYUhJOE3GNeAwjidmv1Np74IHfOn/v6Ld1YFxEHqhJMIlIPveRgvwZ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FFK+D/Rq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dw8V9x5v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FFK+D/Rq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dw8V9x5v"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDsJcr1378433;
	Fri, 20 Feb 2026 15:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hFO1m90j50UWX1rwPADbo5glnkXQ4yWyX0acyuxRZEw=; b=
	FFK+D/RqOOJFNf3xuXc2RN7zWOA7kpf4NNvnMa9Khpld77qiQbCIFAc/JQdPBqZY
	Inpiv6oDT38tK01at9uqZfES9fFHaldpaFywpBX4TguY9Q0nkwpjWl6fd66L4PJz
	ZMgN4aX5FuiXnXIL7GrwNJIiomAK+VSCeorn7VDEyp3/GP04NWnqwCR/ywoalcqv
	dsPb+FCeRmvlgxatCn9NLUK1SXv3qROyXQQS3VBu6tg9HWpVQJhklU+sRfGs6kZs
	yoQVQR03NK614bNjB4HV0YGSjQEKXKCGVPwZnbJiPvuur4e5nAATAW5OJ11TC1P2
	XIGWo710AEgK7fkWGKF1LQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0wsfum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:14:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEa2kb010013;
	Fri, 20 Feb 2026 15:14:56 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2cvybf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnb2GqcZcl7JkKqYIg3+Ntm5pBvPKI5QigrdLVEuOS3EdnXOpkoEBw+oxS+N++lrGKISzJjnsYupCbgZKQWXVdwjE/9Xq8B1LeSrBzsMcvXweSxxtElOk+VqZXLc65g43lbvn6ESFG7GL7mTmxJyCDHkcY8MxsdrnZjJpw4/tuABalr9xes/DHrnQUpNBVwZZriPynXj1ZcC0KA48Zv8/+JeP+ONvzO0ZMaKNdwrMBpuoKCg4RDWE4JdocPoAsEg0ulCA4q1m8xcF7pvTc1PltZrNg8POIPPDvA59ZLNu21F9NagrEztsz+0EP8H4KWSzTEZsktjTstdm1IYAYsk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFO1m90j50UWX1rwPADbo5glnkXQ4yWyX0acyuxRZEw=;
 b=v2gigiV4BSOdI+JMikPZ1ZBsBG/SGQhks/CHFi3+SfcFsaxy1KEBvezoLHs7AY+GdRupbAOOngYFuO2uwIiB5b0/kfMqmj1al/WaoAkHtaYCIb5gGKeEySlIJJ83emqTikEDc4l2CxiaIQacdkUPW9189oiwubZJ+trLLEIJAo4e3wB9llDlS1gJS9Gd8FP8npwYIzxHn+pRI97vyJh6xcyQ1xPXeo1H/j6s4ZkYOoUGX0B1rEtsNPfktY6UlzzvUDQ2k9mV8zi4fsUSuPeeKp1RNlJrT9oyP56XgoO8O17ZASeKitb0Vwx1foxB5jFlR3kwcgA9+uHQcjJxFKUnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFO1m90j50UWX1rwPADbo5glnkXQ4yWyX0acyuxRZEw=;
 b=dw8V9x5vcZeM8ceJFmW0rC0RR+KQB7ykuZ9d8iSI5N2dKqONiYX3VrpOFToGSI/UDQGNeHdhHIWWgWqLNsIukB6oqexw1NBWz8Pym/GlI8jax5EiroQWpP6QrgBW0fgMOKC4kxS94rshzBMsFZKG3dkmsaGPK694VaD3pribci0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 15:14:52 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 15:14:52 +0000
Message-ID: <29b6e603-5bf7-47ef-b2a5-51ed557a9ad9@oracle.com>
Date: Fri, 20 Feb 2026 20:44:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, cassel@kernel.org, Frank.Li@nxp.com,
        shinichiro.kawasaki@wdc.com, christian.bruel@foss.st.com,
        mmaddireddy@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-6-den@valinux.co.jp>
 <9067af7b-9794-4313-aec2-98c2c5e018b2@oracle.com>
 <4hn7xbjltx6z37j5foj4mikuz5t5wntf4pr4hxiy577ebuw24w@efke5jakhhjh>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <4hn7xbjltx6z37j5foj4mikuz5t5wntf4pr4hxiy577ebuw24w@efke5jakhhjh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0072.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f87d9f9-dc50-44b9-87ec-08de7092cbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzZxVHRuOUFrL0NyRERLczBxVWVTMHVOUjdRR05VOGVxSENRUnNWYUlwS296?=
 =?utf-8?B?RTdDSVBqa3ZtWTc3V1FnK2RuYURQakU2SXhjc3AzY1dYWm45a1FTQ3VJVDNL?=
 =?utf-8?B?MlMzK1NmZWowb05RUWpvVFpVSVU5NVdEZFBUMGkzcUJYbDdER2VwV3RVOFk1?=
 =?utf-8?B?VFFWUmFOTmxlbGNwNmE5ZU5WK1c5U1F2TXNoSk5lb25uUzJPTEljN1JlUFBn?=
 =?utf-8?B?S0crcDNBY2RDdy9wdGpyWXVuYmQxUytWTU84MlR5Tnc4ODVQcFljclBZVisx?=
 =?utf-8?B?Q2lEb3BkWHRDQ2FYUEtqblgrdkNlQTV4VlIvN0xyMktwOHZJTWQ5OWFUSE8z?=
 =?utf-8?B?QWxGQmJ2QzErby9OUVZSazRmQlJLMGExMm01MzFHQldZVk42RW85Z3F6VTBa?=
 =?utf-8?B?MWhmdlpSSFI2L1Vsb29rT1dPS3ZhUFJXVmQzLy9EcFZlVzVnVkdBTGt2VFh1?=
 =?utf-8?B?UlgxMG1BZHZsZHh1RTRwbm90ekVPTWVJUDhqbUdmcmI1cHRWbFlPU1pLeHhN?=
 =?utf-8?B?cW16SFRtNXVCdFdYd3FuS0E1alh2dE5qMnR6M2ZHT0FScy83eS9ibmZOdzls?=
 =?utf-8?B?eUFZOVk1RGlYOHZzOUF4WDZkaVBkYUV4N2pPMitjcDRPREFTQXpPWmV0V2xO?=
 =?utf-8?B?ZHppS2JGakQvcG4ydHdaQ0JuM3RjZEY0VTBvam8yM1h1Y0VxSSt0VHBZSWt1?=
 =?utf-8?B?VGVuWi9XZ0w2NXF2THgwNWtYcmdzU2xaMGhXcHhPQUJBZERrOG5QMlhPYzNP?=
 =?utf-8?B?N2ZOc3dHb1g4Rm0yV0YxQ2xLMGkyYkR4eStpV1RVbW15bzJoNkhmTEhCbHBl?=
 =?utf-8?B?K2VyMHh6L2kyczNmcittdjh4Zm5VVjJQeC9jK0o4NTJHOXo5SlJhZ1JFMGZu?=
 =?utf-8?B?aUs2OElqOVRjT2FpbitmV04ra092YUFnZ211OGhNbWJqTVZkbWVObHRwSCsz?=
 =?utf-8?B?ZFlhTWxpbUZwLzVEQ1pzOUFudk45Q1JIT0cyUVBCd1MxbzNFNGtDYlN1UWVS?=
 =?utf-8?B?dGVUN1I1TVZXSk5QMGRyQWNyVEpxZUFKc3dlMVNVTEN0N1FseDIxbTMxMmFz?=
 =?utf-8?B?Ujl1YStiMFpEZUJJU1BhdHJ5YWh2bFp5azhDWmFrQ2UyaU16Sll5Nnc5SGln?=
 =?utf-8?B?cmpXZ0ZVMEtYcHh0dUVWcHdqalF2a2k0NDlRcE5mNXJhNURYU09lVjFNcjN4?=
 =?utf-8?B?T3g0UlJCb0wxRjI0ZlM4bmhjUmhrQk53UHlvRUtvU0htQm9FclJvS2h5bmRp?=
 =?utf-8?B?bnJ0bE12c1RLemxQRXFiUjVRRFBBSmwrWGg0eTNDR3ZMREdLRC8vMXFlclo0?=
 =?utf-8?B?MFFCVlMwQWlvNHNPNzlDOFVXSzhTa29nV09jTHZkbHZTRkt2ZHdUdkJKbkFl?=
 =?utf-8?B?M2phcGo5WGE4OGV6bHJXL3hUOCtFOEQ5V3ZMamRsN0YwMmFVZFZlV0trWnRH?=
 =?utf-8?B?ODBJakltamJWTmwzQy9lM0VGY055VU55WnBQbndZbnF6UFV1VkprTmZETmU2?=
 =?utf-8?B?ZnA3WElvZFdXelB6N2dkak9zSU44RXpLTWpZL25XQ0dnd0FFc0RXY1NCSnQ5?=
 =?utf-8?B?anZYZzFaL3l1RFI3ZGRuUGZ4TDZFdGlFV0dZeTJMYTQxUW9MTjN0TzVRU2s1?=
 =?utf-8?B?SGJtWGo0WGlPSUpUT28zQzROZHhrZGl4NkZ4UnVCN0dlMURrTkpITFM4UDBu?=
 =?utf-8?B?YkN6cTBoYkF1QUdmMWZBQXZJNVRaazZqeXNxR3NLamp6dmxCa1M1Z1BCSjBw?=
 =?utf-8?B?L0RrMFVCU1BZTlErMFRsY3Mwb3pWOEJSZkJnS0ZOU2VkalNGVVJycmIvMmNG?=
 =?utf-8?B?SUsxclRHSC9MVk55aVBNQWxBOHpLLy9PekJrU2s1azM2d0Z1WTdqdlhnS0Mw?=
 =?utf-8?B?ditkaVRtUVlycVJIQ0pIUXV2TEZnLy9JaW9haTR1akFWT3lsYzBtVWhrTDBX?=
 =?utf-8?B?aTZiL1NjYzByTjFkN2hQRER3cHE0Nk1lMmU5OFAvQ2lXNUlSUEpIb3NzSGh4?=
 =?utf-8?B?ZytIdG9nMUg1enVnUG1wdVFYUDl6K1JPVWdCZnYybm5QY1hHM3FNUGFXazg2?=
 =?utf-8?B?bzdEMkZEcWJ4c1F0L255SklTQnNROGZjNkE2L2M0WEpaMzErZHo1VmFEdm90?=
 =?utf-8?Q?0i+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJVWlR2Ty9xUjhvbDV5OVJSWDhOR015ZWhlVTBDUXJMTEU5WE5iNHN1N3Ux?=
 =?utf-8?B?Wm14dTdLR1p4aktzTTAvRnRrMjdPMldaZit2aUJSR1VPQ2NkdG9GRHd1SjB2?=
 =?utf-8?B?am1NbHhadXZYVEQ3MDROZVlwMmhFSnpyZGl5VVAvQ3VBOXQ1a1AxajM0ZDg2?=
 =?utf-8?B?OGNMZ3NZT0o5UmdKamEyS1dSZkpMaHpDSnFaWXlqR1o1UVltKy9meDBHbzhM?=
 =?utf-8?B?aFN4d0kwQVRXL0M5RzI5T1ZZUzRQd2dYb21rUXJwVCtqcjVENGI1VGhacCtj?=
 =?utf-8?B?RGFSMTZlZG96eDdwMjZHeHBxYjcyUmVad3UyWkVXaVNpUEF6akdhbTdJc0dY?=
 =?utf-8?B?V0hNRjNUNldxTXJsVjkwQUxiYWdLSGhOU0hBOVl3M3JQT2JGcllzbVNRbEhs?=
 =?utf-8?B?dDU1ak9TRU1hMnRXRW9OMXMyTTZ0YmQwMGtwN2ppQUFNaUpQY1JsVXlzbk03?=
 =?utf-8?B?Uk1KcjRXM1pROEI1K1R1bHpYdkFXUmxUandGNGUyOE9Fb3FVYmJON1ZPV0lo?=
 =?utf-8?B?QXU4U2VobktpSitieUJZQjdDT2ROMmNpZmZDM09vY0hOMUJEb1hJWVFQa3JB?=
 =?utf-8?B?VGFKWWxkYzlzY2VnMkdSUThOSm1hRlpaVmd2Vk1CQ3ZtdHdCdWo5UzlqMkVT?=
 =?utf-8?B?K1RDeDBHalNuT2FBVHBBN3FDVjJ3dnpvYy9DazhFRm5jcFo2U3FVZUlQdFl2?=
 =?utf-8?B?Yjl4RUJtdk1OMys5Q1BDb2lDeHY2VDMyWmRUSU90R1M4S25Ib3hUQmZQMmxN?=
 =?utf-8?B?dUpxNUVDamo4R3VTa0UyeGNoM3pCckhxdG1OWEdXVGs4TUtVYXVTL2xpK2Rs?=
 =?utf-8?B?UUtOcTZpdGxONTdMVFU5aDRwdk04L0IxM2hldFVwZmFocXZCSVZ6V0x3UWU5?=
 =?utf-8?B?QlZ0NWk3WnNkVTBtNDVaN3ZUNXpndmFtN2NBM3R2SWM0RWd2dHAxWWQxVDBT?=
 =?utf-8?B?SmpOc0pqTDhzR3gyRUQ4c1JGOGE2cEF3T1J4WTNGTWJha0pkdk1RdkF1RVJ5?=
 =?utf-8?B?Lzh0K0p2R3dTMjk2VUtpcmtYblVLRUswSW1GOHN4MlBlS1Y2SVpuZ3dSRWR4?=
 =?utf-8?B?UkZrbTE1eWRIYXJMdDZMdzVoVlBocjZubVA3Q1kzeEJzaW5lQXVQOHFpK1NF?=
 =?utf-8?B?RzQxT1pFTHNEMHhyV0sxdE51cEZSZHRQeWsxMEVQYWpidzh6L0I0bDJLVlhG?=
 =?utf-8?B?V0dISmFCa1VFNEI2K201ckJUYVpRTWFFUk51N3lCblBGRlF5TWlYaXFRMFRw?=
 =?utf-8?B?WTlNTHBlNnQ2V1I5STVMbE5EWVlLeCt5YzZYblJxTGlWbUVXajhCN3Bxa0lo?=
 =?utf-8?B?TGNXVVJaNnFERkZoMDN5YmJ3RC9JbTBsOGNvZHJmcW9mR2gwMlFIRHZ0YUZq?=
 =?utf-8?B?ZG9JSmFXc09QeVFQSnVTQStDRk55dHJMem5rQkVEUUE1WngxRHRFK2p4WGJZ?=
 =?utf-8?B?VURtL3BBVFo4aEIrUE9rTVZtb293UlN2OVhpRDZxVnpTNW1acjJDYStkOFBh?=
 =?utf-8?B?MjVFQ2dMU0NPK2VwRmlIc0MwTHEwdWZzblVqNURDd1VDcFBsUGhoZFk2MEx6?=
 =?utf-8?B?OE5VNWF4dWFLdjR1U0NmbzEzUys1TzBTaHYrNVR0NjA5SWh5VUdNZndvU21a?=
 =?utf-8?B?UFlNTEVkeGFERG9jS1V5bE9OVG1kNHdzanRlYnMwR3FoZFhpR21UTStHMUh1?=
 =?utf-8?B?NVdPRC9hWU5oYUlMNTRmT0xWTFdLYTRvdFdyNE1STDk1VTNITG1ra1Z2N1Jt?=
 =?utf-8?B?c0c1SjVHTUwvVnlLdURyQVR6Y2tzSWNsbTExZ2E4RndZR0tUMkxLNFZ0OU13?=
 =?utf-8?B?a3VCMjNJc2NGbDZkbTU5R3pxaGRvb2QzOGZEeTZGWVdnQ3JsMW5zTDgzRkdk?=
 =?utf-8?B?dE1NM2djb0E3UHdabWt2Ymptam5OWmx1dnc3QjVzalVjOUxqYjJFb2kxVitI?=
 =?utf-8?B?a0hVWTFxNXJhMUtVdzNHb09WakMzd052T2VrQTU5WmNDZThTaHcyQlo1K2M5?=
 =?utf-8?B?NTZzcXVrbUtTWEtZN3VKTy9wblhnSGRhcFgvWTdHTFJ3dmY0OS92UlRCMyt2?=
 =?utf-8?B?U1FtM1ppZ2tvN0dSb0lmaTdxaHA5U3Z0NnQ2OGVCRDVzS2VUbkxPd3lmaDJC?=
 =?utf-8?B?Y0xGKy8wYSt6bUlBVitvUC9aNDdrVVRKUWk0b3VWZzlyamRieVR3UWlSTFUz?=
 =?utf-8?B?TXZEY2dGa01nMElrbHhRdHNNcXhMZUYzMFBlRGZJUEVnazErc2ZldmRSOFV4?=
 =?utf-8?B?SC9EMUJvWC9yU094WUVTSmxEKytqbjhWMTFFdC9HeUtTc0dTR2dud1ZSTk1o?=
 =?utf-8?B?TW9SMk5VMWZmVVczQ3JQV05FZTl2VUJZVGlJcjNHbVZXMlM2NlFrZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W9SNDHFN+bD6WxgOZHGMxccbNihc87h/ufd+EKG7Lc1Ulyx+QKO75iyvZJEdlzJDk7mt2JgHmgLfB896bQQRjS2/9jPPfj7BC/BKvLIsyPUPzTXKXOmxhGO2+Bidckanyg3g1GuCUSpZeP6t4o4dRhsiKH8fgrU0+CQrmEEjI7tmFug26WK/OjRBxnwPMTK2xdJouzt0HZ6W0B/zFAljAElxBuoxIEg5FC+S39FIbzRsXnUCjZMh/AIYgTS7TNXwO7TRLvoYq/j25V9CfwPzRWH3eIF4yHpJ3fjzEvOdja2nM5MvqGocnGI8f/lt/7Wpt9u50vJe/QtnoVYrYvQ5S7ypVOaITs9qLKkskm4GADft/l7fbdYyZDvFueNHVNfHVOrbXyZNDOq9VE5LCyvaa865wK8W7kGLgM7V560w8U97qcebzV+9UnsB3v6z9w7lbypQwod13exOayLOuhByoQM7UuPqMPzpWg+pJdm4DwGEryiZP9gxmXPqRXRhj2n+sChPKm73Cz0ep/1aAVK791FMNPPAy/Zxs0TmUBw0VvJ5ACbRUzPz+LqUqVcmn/6F8ui/Th4xec7/fhZvSEwy814YT2hYNVbLmg2MIJtPYqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f87d9f9-dc50-44b9-87ec-08de7092cbdc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:14:52.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdIkKCv76Bj2RG95ZcyJVj6pplQD8Nrn+Fbq+Uw3rUf7lKiu04P1jPpd9PBNK+EClz5alONMzEAoW6VwztTADYQrQsh6QUg+IWLxc9NF2nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=666 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEzMyBTYWx0ZWRfX2BOaW23NEmz2
 WZtQOoIOpfQ/yOS8LAglpoQNnYYh1L7SB3PXhPYixsQz4gFpNq1bopvFcLFgy+lfHDuMFYj4OQf
 MlA5i0vbiG45HhXBtfn1rW4XRX6KOeQW0LMAnVwP6wTIf2VodEi9WZYAW+d5Eq0Y7kcGVvOibyc
 Bfd45G/6UoqzkZBhwY36H6rDjI71geZl064cdC2ZduBKdBqw1mA/6KH1JkSa0s5v0L8dZfsoTKq
 xMBs5hNKK4oO1RXniHvtnQU5pgKx9GHXnQ84D3hUqRCCqlygC4FM9EVdIjHM3Bel+eW/KLRzD0z
 M7bXp5K8xl6Oic0dOqlReOvMFljXyZQhuf2Ch5omN0KHDzYVsh4/g4cQSfZg5NZ6RI7xarpWTSI
 wBCld+sSng9rCvy4gzkXC5m1rF9Of+3cPcLW9a0xbO0IerLoUr6SmmKWFCau+48CBO7xkj+1al9
 fAWMfPgDt8HOlbjql1EemZX0QZgUQVmrdolNlWCg=
X-Authority-Analysis: v=2.4 cv=ZMfaWH7b c=1 sm=1 tr=0 ts=69987a70 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=05INzhmssZkLyEGVuQAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13810
X-Proofpoint-ORIG-GUID: 0MKAgJ4rF9RvbTxX5A_BrdMDHTBTZwc7
X-Proofpoint-GUID: 0MKAgJ4rF9RvbTxX5A_BrdMDHTBTZwc7



On 2/20/2026 9:05 AM, Koichiro Den wrote:
> Since this is independent of the doorbell rework in this series, I think it
> would probably cleaner to address it in a separate patch.

Yes, agreed this is independent of the doorbell rework.

> 
> If you are planning to send such a patch, I would be happy to test and/or review
> it. Otherwise, I can prepare a small follow-up patch (with a Reported-by tag)
> when I have a spare cycle. Given that this is pre-existing and does not seem to
> cause observable issues today, I do not think it requires a Fixes: tag or stable
> backporting.

I will send a separate patch for this.

> 
> Best regards,
> Koichiro


Thanks,
Alok
