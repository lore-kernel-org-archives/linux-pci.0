Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B1368264;
	Fri,  6 Mar 2026 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798166; cv=fail; b=EA+ISjKmRC3U/KO3Pu1fiRkCiyESK1RfBTmLvsAEz5Nisi0tA8yLqKySeDbza366vS5oqWjiEpaINYiNQipM/uYu1jmQClGidGDC32POF+FUtqX7mZkN+zrA84iknTdXTVWluQlATsYTriNnMyfKyszqCvhCS91zEHCd5mexmzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798166; c=relaxed/simple;
	bh=wgh3U3pp+wIT7z4Ud6q11nbWOasaB8eiP7+4clGQsKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oly9IvTGcNGhRNyQV1JPmma/THqESgb/RR0n+Ju9enkC4rPEdRm77KMNry039zN4/sxGBzkkbwBT+V4KRpVyhJPBZIjqHdySUgR9cNn/kDlkbriO0Sqkr3F2YF3XmUq3HnVGf+O7IhgQGd7MdicliqgUek18UueIbC7WiDZcjcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qQzzKxSQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O8XSPaf+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qQzzKxSQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O8XSPaf+"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626BIUJJ3124087;
	Fri, 6 Mar 2026 11:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8PgoLijGZir0PdcFRCaalT79ld/40uCBDRKI6Keu0qE=; b=
	qQzzKxSQX79F/QRoQnQzz57SsmUR/VTQGwcEJgbj/lkYkRWrRiZpKDRgBpfw3b2x
	Ekq+YT9iRt6xUVajtGq/vr+XK/SthKJKcOKDgmvo/PgsU4DdPPGkjvq6fmvu7dvl
	I6jMnKvfrNMgdH4stCMmT0ppxNY3o8nFw58UwwCDuAzs+ukXXf4xi6zm4OLmYAiD
	7LYDRQbfq1K/5LB0IukQWo9ep3+YS4vuBafQ0DJgaexZVg8bF8imlXSb4K8pW+1o
	SX71Df3wIDVgo/Q1nZzIi8nPLJIWclqYuo3PfuSfOHMJoB8sCaH6DWXnNWuCPKrl
	C5whX7VIVjARiFuTXo3x3w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqwx8r12n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:55:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626ANq6r027324;
	Fri, 6 Mar 2026 11:55:59 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptebe7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLpeKjLYwUXJkox0LMkS4u9IoSASqlMRcqcHOj45X7sxpo1mwTydpN3pBPLaLUBXf9o/xr9Tx/4+lDnTQkogaA2YOF4DNEG/iiv3JHiVA3DYJ3Cu0EBNTym68T5ik+ztyZv7xoOaLslsGZApBJjs4u1RzAvgt2TxhRLDQ22NvOH52MTlW3/gvKxzNMKphpbqx7GcyfZh5PVEYa5lhK/FpOT1ASoiE/UkJgKDf+03NQrGpp7OiSEJMgAOPUm9MisdLHfW3ICp4BtL5VMJ0DPih/KC9RYNOFD6jWMmxIIvMId7w5E04wZen2syMfkC6KE/hVC26gs7kY7810EhV3h6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PgoLijGZir0PdcFRCaalT79ld/40uCBDRKI6Keu0qE=;
 b=b/scQ9Q/18sXZ+IdDNzMp84X4Knpczln+AbUfMhCr1muB1QVU7mH0CgrZYPA5w98ulIcK0RcpJny3bhTjfeB9tMvBDSQjLBOK/K3K3Ds5s8FluX95r5oQFv5tytnhhFabkfx/EXw6fxBNuzF2DooUTpyCeWTjpKAdI0P1J3F/8vMcH8cXUnNOg7ewddlDIMsrIUoiNGmOpPSFuti1K2p7urgusN/l5jwjLj/Tf/TCCoLY7YTLTQgJcALLPhkkXWf4sl4Yl+QB4Q2Jl7B+YegWqo8mJzT1A80kXIl6A9Dw9HMyZmask2OO0v1gU/QnqJ5qJwkZwZgaxlzjxlmzVNjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PgoLijGZir0PdcFRCaalT79ld/40uCBDRKI6Keu0qE=;
 b=O8XSPaf+w0tfHGRUoQfdsh2vO/oO0Bb8BxYBifBZ3wdYb25rNE3mJr7IT9fbPJNAfpreIJ8XfF6z0WWJVU8Xk5M5/eSUqUP8/vfevQ9g23TNH3/pTaBRVUSkwEAJfEbPHJzgshrgKIoM7x8hGg0skl7N+eidjjkD6lGmozGIBhg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by LV8PR10MB7941.namprd10.prod.outlook.com (2603:10b6:408:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 11:55:56 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 11:55:55 +0000
Message-ID: <11354ba8-b7f1-4d84-8326-046c89d25a5b@oracle.com>
Date: Fri, 6 Mar 2026 17:25:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: endpoint: Improve error messages
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        mani@kernel.org, kwilczynski@kernel.org
Cc: kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260305071236.23792-1-mani@kernel.org>
 <20260305071236.23792-2-mani@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260305071236.23792-2-mani@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0423.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::14) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|LV8PR10MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: bb259f12-5171-457f-8d14-08de7b7752d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	gkaK7cYYyzvnG4mf+XcwAyyFpGO8Hi2xZ5nrGthW5QzCH7RKL5GNScNImOfh+qGJclIJAOteV0C/THBZkmLJhJz/MSTPkJzfaS1ZULBBBpbxZzpFODd2j2Nnh6vVxwhw7tjB1Dabc6ZolRnJL3RuAug0TwdE/4LSIXBf3xQ5L24RmZgrIdMMGwvqvqFMkwMLkPy08LNjlUgeakfVoxkMxnbqziZAz2gmK0bD/cP/oddFIN0ArLMa9SLnNociQ4/vLcwau+6pUFquqxg5kAMYjXmg8TIVURfxOfuth4lnWboKqaSVzjZ7PEbGLdZ7im3Zgp9asiGScKPYn5wSTXEadINl95tu1bv9w1DxGDo0nr6dKhjl5akPwycFQg/+l3a4aAvTpaKnoKY5eqHylvGxPbTNN91zW7B6yKhB1A3UpR1SY0ZYZ6TkTigLgrFqASNHwWynVOeqUQuEElcCewH0tR/luxnOqZkLxX9m4sq54PnJJIuQ8ZYX89zivM259WCK43KWcjJsIW2SJ1gG9xleRqn16y3PbCQi1wrMLmMHMmJfKfvMiRWABDJCZ5FOSYvbr3OS8sx4mmsXNt7P/aSvfy3FgPMfz2nip2x4w2CHo6B+iZLd+ChHGhssRVDFYTRhHmp8XKJwMC2Tz6kFdXNdR2J02N9bGO3pvTnWsz3haJh0V8BG24h90PAQAGtV2isCOGZIvMcI8sE5etFwbvA2e2JnhiIGwG089KuOWN9vSDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzAwRUIxeStlMm9MSmVMR3k2d3d6bXVldkFUanN1VkwxakVnQ0Z2SlpnOHZD?=
 =?utf-8?B?OHVkWUFMQUZ2VkhrTXM3dnZOZ3pFV1RNUkNVcTh6ZW13cCtBakFkMmxaUlJX?=
 =?utf-8?B?MFhkWWJWZXVTOTJDb2VyamdkQkc0ZFBKQmxMTFI1TitkRzh3cGg1enlNTEFJ?=
 =?utf-8?B?OFk1c2FDR01NQWthOHEzZTYySjdKRU9PcGdpMHowb3czY0Q2cmJjSVJMR1Vv?=
 =?utf-8?B?ZXRxUjR3SlcyUUlsTUFFUG00cFpFdEVrSkNialQxVHNVUjYwRExpOEJzYVdZ?=
 =?utf-8?B?WGF2cDZuRndwRHVBYTVUVC8rK3JZUDl5cWk4cWJib1pVTXlOcUZUUGNlNGFZ?=
 =?utf-8?B?eVFaVkpSbkwwWXkwdThua04rY0dkNklTSGNTbWE5QXdKRVN4T0ZhVStrbXV4?=
 =?utf-8?B?ZEV1cE9GeEQrM2QrS3BYWkVZWFNvd2dma3QzSHRKYzR1b0E0TzM3MDNZdWt4?=
 =?utf-8?B?Wnhhckpyc3IwQWcyc1ArVjZNcEdOVXFSR0xFSitrZk9xOUJwSWNsaVcyMk94?=
 =?utf-8?B?YUNYV000dzZGbnFoYXIzTmtubVQxb2RMY0w2MU9BYjFWdHU4WG53b2lzK2FI?=
 =?utf-8?B?VmszQTFyelRKbXhEK3VPeU9GNE02VHRqRmZublMzMEtYei9JY0gyVXZlUmpK?=
 =?utf-8?B?cUlRQWIvRzFGZUdraENEd1RkcXRXYnh2Z2pJNnYrRHdIMVpvUVpia1NLQ2h5?=
 =?utf-8?B?RlN6NFdocUNNak5SV2t4eE52MmNOdjVNZEVYZVpGZW14NG91UUl2dE9SWldr?=
 =?utf-8?B?aWY3em5tS0dBTUNram00c3QyRnkzcnZNSDVrTVEwQlRkdEdzV3k1S1IrOU1E?=
 =?utf-8?B?b2lSQmFRWWU4ZGF5TWp5MXJHMWVWeUkzZXB5UGUwS1BQWXFQMTBoYzZVRHRU?=
 =?utf-8?B?SzFlRHY5TmNwSUZUckRkTDIzZ1g0SjNVMWx4RkJqcnhGMXQ4ZG5TVktNcDRy?=
 =?utf-8?B?TWpqb3BSWXJrTTUyeWg4VndGbE9MQ05TOWk2SWUyZElBMjNIa0JkZkl1b3ln?=
 =?utf-8?B?VklXY3VDTXo1WENlNEV5MDBYb21Fc3NhcXVqVW1rRC84VElDYThCRlpGZ000?=
 =?utf-8?B?TXNsNlUxQXUraUVQQTVva1pjd2dpVk9pc1ZtR1lWOTVoRGxoV20zS1J0SFlG?=
 =?utf-8?B?cnJFeHIvTzUySmhTb3YwSDAzeUtKUGpLbC95TktpaC95UmdaRDRWSGpjeUVM?=
 =?utf-8?B?L25PQkFWV0NmV1NmV2RMUUUxWkpBREhiSWFTKzg3QVVYTDlwakExYnRTUlU3?=
 =?utf-8?B?OEpkSCtKL2xENmM1M2Q4RllSMzFRWDltYTI5SzhvRmdEY3FXcFlmRXRIU0hs?=
 =?utf-8?B?L3VnOTJRdG1MUlNyRmNhOUN5TGthdmVqNUx5T3V3SkR4eHF5cUYydmJEd2hx?=
 =?utf-8?B?ak9QV1FIRC92UVRRVXppQWYzWkZicGhybEF1SzJ4aDErQnBJdG4rOHdHampL?=
 =?utf-8?B?K3ZFWDFNc0JuRmlLSFhidjBKb3dTU0doOXY3L0twUGNCOUlUOEUxdXAxcFJ0?=
 =?utf-8?B?RDUzQmt6cy9FR293K3hweUVva1BjeHd2VWduMVZ3MTlrV2d4S29lTTl3TTlF?=
 =?utf-8?B?aUJZYkhZSzNtMklaQmQvbFRWNlFncFNnYzhZSUxtN0tMazE4MHZ0bU9mMlNw?=
 =?utf-8?B?UmhUTFNEYXZCNEx4akg1Y1dzdXJDSzljdFpDUmRxSlpqOVJDUGVYTXJYRUg1?=
 =?utf-8?B?SXZ4S3pmczRDVFNIRitxSkhSSW9uaFdEZG53RGhmWWV0VnB6TXMrVmVneW5t?=
 =?utf-8?B?bHJsN1ZCVTJWZUp2eGZLTUhVQTQrcTBPaUhGK3Z4d3hsTUlzOHNidWVYM2tz?=
 =?utf-8?B?RGpoVUNLbnZjZzZlVHdnOXhqSjFjWERscS9GUFowUmw3eTVZTUs2Qm1vZnZY?=
 =?utf-8?B?MWY1SjBxTlcrTWEvbGdvN3FQdGJTK0FHVEtkTS9OcVcwcTRTK0h0UzhhYWFW?=
 =?utf-8?B?bHJjeGRkcGNxcU5acmQ3QVlvZ1Y4d3hzWnFtcjhoYUltM1ZXRkhCWmtHNDd4?=
 =?utf-8?B?TDd2YlZVcUxsaWlzNnVueUliU3BsRlF3OEt3bGp6KzF3TEVHWGxRMU9YSjgz?=
 =?utf-8?B?SlVqblM5SXF3OFQyVUlHNnpzNlVGSm1vU0VJcGozT1Fqa2tnMS9pc0hOamNN?=
 =?utf-8?B?ZHdaMXBRM3N2MUNLU0NiQ1NaeHg2NzQwV1FzY3JTZENKeDkwUWtiajVwd2VZ?=
 =?utf-8?B?WUorMi9HNDZENkk5dFZaNW5EaFZQZXY5U3RXUnA2SnlMNlBxMTV0U0V0bWFt?=
 =?utf-8?B?MVdXNDNMbEh1N0N4VWMyTHQ5NXgxN1I2SWt1L25hU3hGY0YxSmYya3kxQ1Nz?=
 =?utf-8?B?bytTaEtMZGFEbU5GKy9JYTNKOEYyWHFFbW1qY0gvVzJlOHpsYWpldkZwS0t0?=
 =?utf-8?Q?h/g+RjpwEd/7ZK1A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	47Lef55+BrTVFsdYm6TzWKJWNB7l4QVZuKC9CJOh+1J3u7fnwWE9wNZETeAlO99gTitSt3ZA2Nk317ksWEOBoVgRZ6fXtcFifhfQM0gYgR5lGkWDVDWQPmLcgoyULQMCABImXR1ZaEY81hS4sPRB7LkTmg2X/x3pXOs61PjkQTHW3OZHb4r0tM/EERIG9+uw40dYQu9mKmIvAGkWODvaHHu8K6MZw1hUZwd6pRPQzmhR74Hn6Ecif/vcsreOiVTvJiZHPW1vxV53rNZExCrYJsh2migfHY99tnqvwPjI8sW4E4uXTVkbIeSw3QctbgBx4lb9oxZkvJVjxwRH1qCbcuWbVRDmSnRVvdvunz1s/BLUvv0KGBM9ISPjWhumVM1OvzgSx0ccOUSKz5fX2qfE+8uCy3eBk1oMOYFtNr0PnOZYBta0ztQM37H2J2Q9rHrU8u/fRowXIv0qM9vsToqXQf7EYoxmXvE4RyN62S1cYmu3sdAu1FOvV/Qr6uErgOJpfa8RPEmRJSKnFTkM7CvI+4RZBO6cYUozfFmlIVtK6UiinV6fciuZVNcYHRxqdSHhVx1dBjODkKAGg886Pl4meK72HKHuKLvQhpCiXjut04U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb259f12-5171-457f-8d14-08de7b7752d8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:55:55.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo3D5IVJrVVgFiKT3logYx3KtLlG8odqFlW3VJQ6zuj9dC+jYH0JqlHaBlzPxaawYPQ7n9tceBooeJihl9ho8CBTJpw09RV7T06nqsQl6Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060113
X-Proofpoint-GUID: Ui3JvPWeV7fpaz4Weyst4S1McexgCklp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExNCBTYWx0ZWRfX+0TX3PnB2QPj
 7JWMH7yjMxHIrY6efpWMYRFFM9YeCG8z9ySZ96UeVs7AyeBjwzAbQyBtqBwrmPmyC57rGrtqR5m
 8X7cuuaMOaTAsycAXQ7r0Aq0AWjAlK00IG0U0yYRYVW+2anQs8D+Ee5LTbH8G7pFRBRXuo9OhrW
 PGzQHOkdVZMHOSyKMVSaUTKtC3fqN+101CetSM94zbTDLUs6cDvG3mXIXZfV9PWZVmV4QNNUURo
 BppRn+vBIAlZR7WbKM4l6P4gptVq6r/5N2D6zsbLjAmpnW4qtpzMBSCYA6CC0VKrnl/BFplBZLE
 fhp+VxYlrvDFBX5YCwYoQsqlKjzvCXX/nwOOtaQwfUektfv1WVd2yDdPa8kGFZ9etwTiVX5pYqP
 UYCcWARzEloM6GB0O+Gg9yI7lzAvfjX6YiU1YJpdGvrfR7zWWgtz7q7t9yx2Z9CEsOb02D58j9Y
 a9j71ZoXx1aNc4Ky1Wg==
X-Authority-Analysis: v=2.4 cv=PNACOPqC c=1 sm=1 tr=0 ts=69aac0cf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=EUspDBNiAAAA:8
 a=CWr_k0t0nb6Gs7HCYPMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ui3JvPWeV7fpaz4Weyst4S1McexgCklp



On 3/5/2026 12:42 PM, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam<manivannan.sadhasivam@oss.qualcomm.com>
> 
> Include errno in the error prints and also use dev_err() where applicable.
> 
> Signed-off-by: Manivannan Sadhasivam<manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/endpoint/pci-ep-cfs.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index a19db22b7991..2d2efd444b02 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -565,7 +565,8 @@ static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
>   
>   	if (IS_ERR(group)) {
>   		dev_err(&epf_group->epf->dev,
> -			"failed to create epf type specific attributes\n");
> +			"failed to create epf type specific attributes: %d\n",
> +			(int)PTR_ERR(group));
>   		return;
>   	}
>   
> @@ -578,13 +579,17 @@ static void pci_epf_cfs_add_sub_groups(struct pci_epf_group *epf_group)
>   
>   	group = pci_ep_cfs_add_primary_group(epf_group);
>   	if (IS_ERR(group)) {
> -		pr_err("failed to create 'primary' EPC interface\n");
> +		dev_err(&epf_group->epf->dev,
> +			"failed to create 'primary' EPC interface: %d\n",
> +			(int)PTR_ERR(group));

using (int) not wrong but it is a bit unusual, in this case can we use 
"%pe" instead ?
"failed to create 'primary' EPC interface: %pe\n", group)

>   		return;
>   	}


Thanks,
Alok
