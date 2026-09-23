Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FE566C60;
	Wed, 23 Sep 2026 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188652; cv=fail; b=eHgyk4NE0JogKEhDrKTOyegvhbp7Fwuhj6zhdUtmkin/IsTMxhsaBghmMFDe0xp3Qq5muxDiTVnccoA5rvA4ItrLPaWHZUc0euSL3D0c6PaM6A0+QNhQN2yrTV7gEYW8B0/Y0PzsOdaOBOQKAPJIZ9piwzK2tNVQ4ZtOwGxQSQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188652; c=relaxed/simple;
	bh=BcEr/cxcScdiU7VGdHua7H3pm+VfBSnHawpXrNUw/f8=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=F0m5WGEqetymNhYHWblfDLZDREXFithBHEIAWTx9klVasJLZ/9Z7C0lgJ5AMiqrzWadi1XAMmQSPrYaZwL4kb2EKwx/jOlKkflzIZo+tLg5FVjKhyj7y6Q7tsmfoOb3PCL93BY87QqVpEnVElT3gCN4VOsY5aZSZXRcI5hKU9jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dyw0e0lW; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dyw0e0lW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCmrFmzh9owBrx1XODSBvfKQZjWsMjVnfNPUN3n0RG1kGccnxW0PYWdDh5yeQO8MYQU8FgXMrRdK3kJgCSNIUQcEYnBT5B7ZTSL7r+fb3MT2iRUMqqw8ml52gxR/IOcXh3KbTu2rtD6+IbaCxHQ4LaMk3rwfeL6wRJoUNMbpIvJEQtCxvsyaowumLjXAuR4RWHqAimycoxbFon6TWsKeZF//1d2jRsSaDY63BWKgeaKZKwVOEy3XYC+khOfEwwvnG6V7LLyv/wJ2q24V7IUnpWuTp9bIpz9E9cTa5xgBbPANHKUxUuTTdMcZ4uxy6jMt7qUx05EYwyihzPa+1YAyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJVvaQc0RjCVZD+k6uSuShDdvFi9eEPjLbIuWUDiee8=;
 b=hhyDmlqM0kFh6bTxG4VvvDDsu0CdnWABx5rgC1RSGnezKPghp9XfwlrJzgcvD5anozZ0OmwquZuY1H+ZMtR4ZQExE/g8GSVXVDwdlle4AUe59qeS41NhvjTFOdleccyHhj6GkMETaQ4nmIE5IIdB5nksGuW9wONsXUOYRL63iaGyyJYzGolQa+6JQ+lOgEa+sMBFDsSvLWSPKLPwD/BZAJOU9oeK7p6FKcQye/4INU4tAJDyZn7JPkki6MsosWj2WnuZw9pprGdNLqteZCmrdNjkHFEmnJh9gtJ1eIXxVls5xapPu3BIaYyaIImTwOm66JBqfGor9nhgj6B0EtyRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJVvaQc0RjCVZD+k6uSuShDdvFi9eEPjLbIuWUDiee8=;
 b=dyw0e0lW8XkneAeUJMWSeG0akHZ8qQqNRNjWIFD6BgiFytWQaW6gPtgh6/NLUlkq/lZDddsB7y74Jo4KPdMDWXOWYEoZbcqYq74Qq0mgzuw22V73IUIuHK59jXyTCevbGbaRQeiubBizKWSzAn9yXXeK1kQSW25VCK3Rb0TRZ68Ydp2pkIB7fH+jnN0OTWdVcVS5eIs5hGRxZvm930/IyPVQPFf+Rn4siPTXu39ellpodE7SHgZzefWIEWPJisLCKNLeHHXD8ugkq+XyqGigRLJv5iQa5XbFfUb5d4UUFrTaQq+74rDdVn13o1N+8EtbIo803WOiskZNytc/W2jZ9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:14 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 07/15] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP
 for IOPF event
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org, 
 bhelgaas@google.com, praan@google.com, kevin.tian@intel.com, 
 kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com, 
 Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com, 
 bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <45d72c3be850a5dc29f7695b244ce0da97f97f9e.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <45d72c3be850a5dc29f7695b244ce0da97f97f9e.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862539.3334538.7687027019477095209.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN0P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::17) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ed8fad-e3f8-489f-5b1d-08df19a1ae35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RYyfJUfBd39+VESXaD0foPKKrJ9hySUKxFwQsdzQIgbXPgrIYgnEpgXVFa00qf1bG8rYNRRDNxSldcDtJfsukGjrE0C67eomiSu3mD7O7pkS++FIqj+kTw9Oa+EXM2p7r3p4AKvBu9gcrsXSuvo8bbaEiPJqf0FLFK1KRv90ES7+IcD8HDmi1ZwmVdXlq+rAGVHdAqttLVcknF0IC3/Ye73RJdHaj1s7YLAaqCxn0GkVuqRwASe4qi5l8fSgAQRM8XIf32ApVEmnf3kk6pkmaaX3LY8e3qVJ0PPhPaJnb+Iwb7I6GI5DxZwS+ANvCtyThcVlU1H7BqHC1uDOy+MSCPHTPoC4Yy/kf6IAY9ubob5H4y3JPVwqSuanvxhp7cpulQiPCbUicx1v+6B2h83JktlpKYZssycYw6ukVEngEgl+g+qWU4M2u3LC9Dtka5HIDo2UoJr2kERLF304CDS612f1Ie/zSwN+FBpRnymZN0Pfzs2lTW0J8p9enirzjPBbCuMztU3biGuWu7IcvOBNJj/iebxX0baRwoVgjy5GEx+Am8mlFcn35azDsabJDgaGFbadWwOALrPx+bU+2eL01sqsSnd5mecr0QpfZ2egrGXCYu7mnJUlon1EkQQR8ruWzDt0bYwzltjUoir7OhV58UE2qMu4sL5ftUOg2Y5SpM0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2Jub1dqbmx4T2Q5ZDVVUDZZam43UklmM0JHemVWWXNyazQwNXBETG1GWE5U?=
 =?utf-8?B?TGxkTnAwZHh5ZVRDY2tXYzFYS256ZCs5WTNuL1M3ckFsb1E4UnlueWNybHVI?=
 =?utf-8?B?Y1RZOWcrc0s5Q1NPdjFjQnVLZ3lzQmRDTER4cUI5WDBJOGQ0NEdLYUxlejZj?=
 =?utf-8?B?R1RQZko1WkJUeGZKTE9QUHhsdU83NTFGVGpLQWlsZGpxMzd5N29yU3N6N1NP?=
 =?utf-8?B?VHI1VUw1cm1aWitwOG5Pa0dkRjhWY3doTS9CS1IvQ2hNODFpb3NlYVpFR1Vi?=
 =?utf-8?B?cTZheUlsSFRjOWhCaTErREc1OUlIQlJWenlRMHBIMkRFdUMwZ2p2SG8xZS9R?=
 =?utf-8?B?akVPeUFVRGUzRTVXVkJGUTM2K3AwS0JUaWdYTFEvL3hGRFE0dVdsdmNuRHR6?=
 =?utf-8?B?Z00wQ1A3NWJsOEZjTzBzZ3FUMitzMG1SNGY1cHRlcWltMk5pSVNFd0drb05T?=
 =?utf-8?B?bzRBTVFKemUrZDc2ZDMvZUtrNjlycWtQM1Z4QmJ0M3JSUi81aiswbmRzcWx5?=
 =?utf-8?B?Mk5WbGxOUVQwYWJwamdXL3FaSmlNNGR6RHluUkh0eVBvSjVxNGwzNVg4UHpY?=
 =?utf-8?B?KzgrMm5GWG1SKzdHeFUwZWtJRHNTYzdHaHNRYzlHTkJhVUNaYnBrSnFMbDlW?=
 =?utf-8?B?QXVDL0tFbE9VM0dETXJLYUdldnZRNXFkSCtESldDWFlRdUJMRFg0VGpxR0FO?=
 =?utf-8?B?c094Q1RLZ1VZZnVtKzhzL09LZXo4L3M2SGY0ODdVVnBTVlNqbTFBQjd0Mk5O?=
 =?utf-8?B?Zjlpd0l5eWtyaWxvSE01RktCVHhMRGFBTzRJZDhSeG1lT0N2K3MzT0pnSUdP?=
 =?utf-8?B?RXdtcE5meHFKU09DamtwRzFQZ2YvZCtXNndtUGdVdzRrbTdpWXpSWnBwdVZE?=
 =?utf-8?B?YlQxeE9VVTZsQUdkWVdPM00vYzVwdEZsYUZub2c1ME9jUVJUVWo4ZnN4UHUz?=
 =?utf-8?B?OVRqZG1DcHNyVU83ODMvN2VpcmtsZmxqSkdrREZBVVB0QWlHdldHOFFqdXVR?=
 =?utf-8?B?anpNdU42NjQyYU5MR28wSzhPd1R6bHBOSCtIMi9DZlhKTFlNSGJkemYyZ2hE?=
 =?utf-8?B?anYwZDV1MzRSazNYaHRTM1c2eC8wbFpZakI5a0o3WFcybHRTZklSQnc2aUs1?=
 =?utf-8?B?ekJRM3pYa1d6STRRTlpuRExPMFhZY1diVkFrQVg0MUs4SmN5Yk9SOUZrNm50?=
 =?utf-8?B?d1BxMDlIdEdVcGlJM1k4NEE5bkNWWDh2VXBZSkRtZ3dwNTRTSnk5dlhWZWNv?=
 =?utf-8?B?b3ROSDIyWXFMbDBJd3JVRTJEMkZKZU5qZC80ZUNVa20vK0NWT1Jvc2R4YUp1?=
 =?utf-8?B?Z1pVYzlqdGV5VXVJaytrNWdKMWcrb3NhQ3krYzJ0bmtmc3d1Q3IyTEs0KzVv?=
 =?utf-8?B?bVpVZ1hYMDhXbEVLdHJtRHI2Qy83eUxSSmlTZS90c2NaMEhlaFpCeGZ4dlhk?=
 =?utf-8?B?YXFFUVF0ek83a3ZTbEM4OFdFb01aWmpKYW1aK0Evcit4UnJhOXFXR1V0bmd5?=
 =?utf-8?B?VS9wNHFCWnVndGRac3NRbjBLNWQ4Q21DWStlVlVrSGRqdXoyeTg3OEhXTWJy?=
 =?utf-8?B?aTdjNTc0ekplQVYwOGtkdVVnOUwvK2hHL1I3R1BBL0lMd2w0YzRaU25HTndI?=
 =?utf-8?B?RTRmV3BJNGFkOUplWTBnNjZ6czdHcUk2SzY0SXpnaUJDZEhxNmpackw2Vmsw?=
 =?utf-8?B?T0w0UjZ3NjhyM3lSaFArRWM2M2RySGhBNUQ5ODNjNG5SSCtma0N5cEhhMUxs?=
 =?utf-8?B?dnB6a0lZejJGK2JtZ2xmbFpHZkx2ekFaSzlsM2NRcWQvR0RCdFB0VXRhamNl?=
 =?utf-8?B?MzdEczhNNG5XNEF2OUlLeXh1UU9HWjFkYVZXVzNMTVBDOTVTVEhqSVRxaHRP?=
 =?utf-8?B?Vk8zVlZkc0Q5bkRBOTZobHdlNGRpY0o4Y3ZHcWtLL3A5VUxUQ2VVUzFRL1Js?=
 =?utf-8?B?TWl3ZFVSR0gzYnM4bEpUOWtEZkdFbDQydGNNa2FYdjZOSnNtQzNObUJxRXd4?=
 =?utf-8?B?a2JJdENXa2hGUmhRRlI2dWVsbk1jWFNmcFp4OUtFaFEwN1g4OTM1REFxZlV6?=
 =?utf-8?B?QlpMOTMxM0I3RW9xT2M2NytaUzFOSnZVSG9oeXBZRlVmLy9GNEs1RThDNm9Z?=
 =?utf-8?B?NFF1RlhuQmF6VVIxL1Z1RDhSWlducGlGSnFONmFiZCtuNGY0OHpqbEQyaElP?=
 =?utf-8?B?UWtTTFVHeWdqQXNjQjFEeEM5d00vbUR5bCtYZksxa3NINzNoUFp0cVBUMGhx?=
 =?utf-8?B?b3FIaENMUW9GUDhwRTQ0cXJsNjQxS254Vk5MbTltZEVDMWlUVEg5RFliRnht?=
 =?utf-8?Q?2LaqP5gT9vs7Kq7Wqm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ed8fad-e3f8-489f-5b1d-08df19a1ae35
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:11.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GN8o7JfsA2ZQXLmF4NT793Q1dngP30HUZqVtb1wS9aYT/5liJFTgwP4XEy04+bAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

> [ ... 66 lines skipped ... ]
> +	/* IOPF is gated to num_streams == 1 in arm_smmu_enable_iopf() */
> +	sid = master->streams[0].id;
> +
> +	if (master->stall_enabled) {
> +		u8 resume_resp;
> +
> +		switch (resp->code) {
> +		case IOMMU_PAGE_RESP_INVALID:
> +		case IOMMU_PAGE_RESP_FAILURE:
> +			resume_resp = CMDQ_RESUME_0_RESP_ABORT;
> +			break;
> +		case IOMMU_PAGE_RESP_SUCCESS:
> +			resume_resp = CMDQ_RESUME_0_RESP_RETRY;
> +			break;
> +		default:
> +			resume_resp = CMDQ_RESUME_0_RESP_TERM;
> +			break;
> +		}
> +		cmd = arm_smmu_make_cmd_resume(sid, resp->grpid, resume_resp);
 [Severity: Medium]
 This is a pre-existing issue, but does hardcoding the SID to streams[0].id
 cause the wrong stream to be resumed on multi-SID devices?

This seems right. Stall mode should encode the SID in the iopf_fault
event, maybe in the private data and recover it here.

> [ ... 20 lines skipped ... ]
> +		default:
> +			WARN_ON(true);
> +			return;
> +		}
> +		ssv = !!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID);

No need for !! when asigning or casting through a bool type. Compiler
does it automatically.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
