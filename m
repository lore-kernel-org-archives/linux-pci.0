Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1993A782D;
	Thu,  5 Feb 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289312; cv=fail; b=B578uZhKNsxbWgkOuARiJTU2HHXjs/VxSkvMwr63u75phqR5F+o2ESBHC/NArrqfxgw0l1M88GaQvYbUQq2T5alugD+nT9XaBu/IBUj/jIABx8ytj9nwbpt7H5L8CTCqrLEgSSd4EMqdMlirf2n9BTjNOj2Yv/U4itlB7MuUXKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289312; c=relaxed/simple;
	bh=EikaZo6TyP13ZkjYS2QNWz7aQfk2W3gvl0jVJoN0HzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qe65f+n9R6Eh5+iNK9UmnMdqSHMthNyc/lF3c4gnpXd0Fldvkhm7LJTaxb1lAdtno8v211Y4iDlAS7XLYG3iDpVFqkLIKVCueBCi3MSN8BeWB+FrM0TNybXFLHo25Rd4MOSo76FKP7lC86CtRjeeOibQV6glksGOlx4noZRd2Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tv7gKA61; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TnxC3BQb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tv7gKA61";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TnxC3BQb"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614Ka2El2731313;
	Thu, 5 Feb 2026 11:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=k1HG6JnRR7AD0bYZwlcNLWE2JJywpZNBjOHxlZbkV00=; b=
	Tv7gKA61gScyVZ5y8yhRjk4FaD8wOl+dntMmE1dNK5RJj5CGft57HhAQGLp69cQD
	D7NwUvIcJZCMuiIztBtRg/BCwCQjjbBSAdngRWRWR+4PWtOFgIhjsBpzixP5jlZB
	OWwsZ3INj8bApM+qkrwnGvkH/x8ZAPpCByhX+8Rz+IfzvGz4SKzyyVU3dRn/cVaD
	bB/evk4ta2kpyc1n4nkP6wR6aFXbgK6Ev7v2PcInQ8ty4BNRd8ItXwUoERmozfLf
	5MlhIPUUHiEEMi5f4MXQ85Cgem9amohhgJCI99YsV6Z5zlI1Kdovyu2bgqZk/aR9
	nGYYYjTNFmz1ulcC1wpoXQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c4d9v0ue3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 11:01:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615A1O5Z037239;
	Thu, 5 Feb 2026 11:01:24 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186cyqcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 11:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfyGf5voCGE+7OCmgoSqp0zCfejYbjAQv2ivWw81yslUKSxHbkvMpmw4rXOXWwIVyQKXJXfiMtiOeJ7lKEO5xx7e5T9/EHm3lTB0+vhn7L8J5AqesTot47JacrrfIZVL+t1+IpiubMIS7oVlhE/Pp6BYoipJ+OxlkcMg33JA7rLyvjOGNJW5Hcgas/WKaTpAdNUN+sHv/gOdy9Wv1UZreGrA3U2q9CMi0N4J/w8CQAzLmmWTGzh9yerlACyoEl4fAlKfhxKVD/6WGVc6s0T093Nt9JQiUg+LFAsdxVdg9TE/3l8L99iqr8kLGN4gD04qjthed4gVZ2CN8IYBFOksnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1HG6JnRR7AD0bYZwlcNLWE2JJywpZNBjOHxlZbkV00=;
 b=j2US5innCZMHOU/6G5m3mywDWy6fnN6X8Gfi4HR/w3QAnYTFteAa+z9Or5pXpBMT4P7OMxDDZ6RGEZyyWVqRnXj4fYRnGUzQWpOEAwBN338qJZbEBnrjL5BKPZWXrwLi54lbiD4Pu3PpX3GlmON2P17LzWNFXgf0rx8KN1MXOIrb066ikmOHdGl2rxVrEs34T618v0aqzyHHnYaMPfHA/Sb4TPn4uA8l7nbhcwlLC0jjVT1TOhBNnQ0rSR/cm86AN67YXoQroee77wpRRO/ueTlXFzBxvHCnp8v6cOkbtQ/4D86rlw8k7EORUSWUpwg9otej+aEhjN/jdRE7oswJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1HG6JnRR7AD0bYZwlcNLWE2JJywpZNBjOHxlZbkV00=;
 b=TnxC3BQb/PXVZrxVg+ehZgUXmIXIaBMhcRO8UhNcIAdGB8LudmfOyKOrI6cI1KC41d+4h/Ohi9UBBBgLN2E4ClmjzTfFLQ0Dj0pwX01vg/FFtYwQ4cmO0eK9zsidG9JfURIHfnXq/0zIU50ttq7rCsmO/P5RdQnXJRVKU242U58=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 11:01:15 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::b110:3df0:e927:dd53]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::b110:3df0:e927:dd53%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 11:01:15 +0000
Message-ID: <3f3e55c2-6670-4e63-9418-b2e5c8743347@oracle.com>
Date: Thu, 5 Feb 2026 16:30:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v2 1/3] PCI: Always lift 2.5GT/s restriction
 in PCIe failed link retraining
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew W Carlis <mattc@purestorage.com>
Cc: ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com,
        ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
 <alpine.DEB.2.21.2512080331530.49654@angie.orcam.me.uk>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <alpine.DEB.2.21.2512080331530.49654@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:EE_|SJ0PR10MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c5c42d-56d7-436d-7ae6-08de64a5d83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk81MXRqQ3JCR0lMNGtMWWNTc1k4TUxmV1NIMzlVVWhjZnZtT0JnaVZ5TG5T?=
 =?utf-8?B?aGorcmlveGJuNDNFN1FLYzVsbDJFdE9RRSsvRUw3ZGxBT3M1Q2diWGhscklS?=
 =?utf-8?B?Q3M0N0pxUzlGdGt4Z1BXR1ZTODBQODlqQTdGVG9OSnJYQVJUYldvQ3BaVWZ5?=
 =?utf-8?B?ZU4xbllUdE9NR2cvbEpjZ2wvVStQRm9JdHdJL0ZrZjZYUWY5cG80VGtDMzRq?=
 =?utf-8?B?eGpaUktLdWx1Ti9YWE83NmhIWnY4ZXB3K0VOUjBKQzhvWmVKZDBkcFhxMGZS?=
 =?utf-8?B?b2FUMkdPV0NvNUxUM1Z2T3VSaXRNdEZKSmZaVnFkcWJzb3lTT21nWnRVYUdH?=
 =?utf-8?B?Tk5LUVFRRDYrM3JVS2JSSVVsQmJMa01UYS9JLzVLVGVUOUF4M1M1cVdUSzgv?=
 =?utf-8?B?SUpqYWFZcXhVMnR6cmVGUWFQd1FKNStMM2dlMnQ4cER4TE1UekFiU2hkNDg3?=
 =?utf-8?B?SVFsQUJHMHcyUnBSM2tnYTlGN1U5R2s1UHNuU2VNQ3NxSXA2WFREazdTTExw?=
 =?utf-8?B?OGJqMmxlVjh4cnF1dE5Pcm45dWhsVUU2M0xGc1oyZk44c1JrWkk4RlR3TUFC?=
 =?utf-8?B?cDR2TFFkT21jQ3FPZ0t6YlpaOFk4ckRlQUtiNGdWNDN0US9xelVwRFY3N2Zq?=
 =?utf-8?B?TnlQSzE5WWl1bkpSQUhEeWZxeXBDQUxSTVpQT3BLMmRGaytoL0ZCSHM3VzhQ?=
 =?utf-8?B?bzZ2UWtGaC85SE5EV2FnazN1MnlXS1R4ZC80QmJQVG9tQ1ZVZk05MWpyREFl?=
 =?utf-8?B?QlEzb1RvaWxUTXJRTWhydGUvTjBNOW12Mm5WaDJveHNFdVZRZnZKenEzVll5?=
 =?utf-8?B?OHdzck51cklqR0tyNGdKdTlmZjJlekVQUFdqVDdNSUg4eFBGQU5panQ0RVcx?=
 =?utf-8?B?M21PSHRWMForZk9iaUNLblMvenRWV0p2M0NOV0VBOTBrL3hvbGU5eWZXdTdP?=
 =?utf-8?B?TnMxanA1NXN5bi9NbXpEdG5VRitzUWZ5UDdNc0F4YmR2djFqS29naFh2OGJX?=
 =?utf-8?B?ZlJpa3dxNDhoSzFuMUtta2FCYkZsK01IUFBDd1Q1RE5JcUIwdGRRSHpIUWpH?=
 =?utf-8?B?YWFPeUlaQTZIdS9SQzBsSWhmaXMvaXkvNUN3M0d6V2M4dFdiT0dDSU5hY2lr?=
 =?utf-8?B?TUsyTW5RVmh2WERzZWtzUlJYOHZHdjB5ZlNJUGJzYU9jSy9iOUhkdko5dENL?=
 =?utf-8?B?c1FLNDFQV2RsZnJRY2srY0FkQTZ1YzFibkV0YlZERGhqUWFURnBIVlZQd3cy?=
 =?utf-8?B?cEJpTldjTlRScjdwYVV4MmlScWppVTJ3STNqeW9qaEtmbkRRckZnUDVOZWNO?=
 =?utf-8?B?Rm1qWGRyNkxLVVpVbkVOU2Q4aXJqeHB5THl6U096VndvdldUSHl6QU9peGFK?=
 =?utf-8?B?ZVQwTG53bWxsMVFpZVFiR0FBYzdzYStDMk9ta3FQWEUwSVBncG01RmtpTDlt?=
 =?utf-8?B?eWRUTzdYMkYrQWsxNmV0ZGlDcnNTZ3B6WENhWnZFRUh3eEtUbnpBRFhmdjBh?=
 =?utf-8?B?cUxveUZTTndyT25KczRvS0E0akZLazE4T1VrYThzaXJ3VHFId1BydDBjS3g4?=
 =?utf-8?B?NTNmbTF3TkxwemNjMzBuNElKSE5uc1BjZENhd3dhOW5ERXl3dW9sd0VLWHox?=
 =?utf-8?B?YUxOaGFXTXJLTE1WYTRSZXNraDBhV1FBK3Z0RnE4SVVHOE5CbHBMRUtWMWpZ?=
 =?utf-8?B?RGYxQ0lxUVFmc1hFMnJlVk8wbnBMeFFxcHpxVmExRTlJaGZORTJTOHpSZDlh?=
 =?utf-8?B?SUNpeU5GU3Y3WWUzOVdiY1BXNVlLZ1o3K2V3OU5KOS9EOGVUZ2hhZ0F4bzN6?=
 =?utf-8?B?RHhzbVY3ZjZPZlNQQ2lvSy9yMFhmTDZBY2ZlUDQ1UFk4VEhKKzNLaURzdzZn?=
 =?utf-8?B?ZGxGemZQdWRPOFBoT1dNYzRCRWUxZ3QyelRFcUE4N2ZEY1EwZVBCYUxaT1Q1?=
 =?utf-8?B?bVUwWTZ2RUZMbnlaT2VVWFAwMEtiaTVmQ0pvZjRjcDA0YXhTa2JRZHgwU0Z0?=
 =?utf-8?B?TXN0OCtMbnlQaVF1ZWtFWDg1aXp6dFF6eXFFWVZ5bkhGVU95ZG9IcEtQeDhm?=
 =?utf-8?B?ZHNsVUdqQlI3OUJSR2lZeEdFNGc3UDhmRlBLaitkb21mWmtneDlyWlpjVlda?=
 =?utf-8?Q?Cnc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T00wZkVVWVBpWFJ4dXRhSFNYbVBBbkJkSEVTdW5MRkVLaENBK2hVUXh4bWpk?=
 =?utf-8?B?MEZGeTl0Y2NrUisvZmdCQXFtYmh2aHJqcnlNdnBWY3pmdCsxd1YyZStmWmRl?=
 =?utf-8?B?aVZ4NTkzaHVkSWhXWDRDRmw4UnFTRlQvaHVzaWJ6S0ZKUWpsbmtTb3p5R05x?=
 =?utf-8?B?eStSdVVoeGNUa0hxYXNNM0F5WTIvWGlUa1ZhcHBKMDdVeTBDYTQzSDhZWXMv?=
 =?utf-8?B?R2p3ZmgweCtUZ0VpTE00cUlHbllOQXN0OGJHSnRRVWJZdVZaZnFSeUpWN01J?=
 =?utf-8?B?RmFXZjJLLzFVNXNWUy9GSlVCUkcvVWtrWkt3RGN5bkx1MmpuSFVOQjlmbGxS?=
 =?utf-8?B?VU5BVS9sOUxwNTE4cE5ZZjd1VHl6MkZ5bnRiNk4vRXZJRU12dnMveWI0dVc4?=
 =?utf-8?B?ZjdkWXJZbklETlNRNktERURNRXVtZFN2Y05YelJVZUNRMTRIZEx2MjhoS2VF?=
 =?utf-8?B?TFZTaTlSc3Y2eU9pY3pOdENjam4wNlkxc3R3cEk1d3U1U3E2R2xDdG91c1lp?=
 =?utf-8?B?bDlLaUJpTE04YlFpY2s5WERlQ3VPQW1ONkY3b252eDV1elpWaTFSdkQraEFq?=
 =?utf-8?B?WnZVWUI1Z3R3RWI1aFhibkJHSmhGOXpFbnowSlRnU0ZTa0FRbDRVZC9pNU54?=
 =?utf-8?B?ckYwa1UvRUhIKzRhclUveDl3M3IxRnlvKzZRWWJUUEJjSXRDbXgzNlhRV1J2?=
 =?utf-8?B?MkRwSDN2Q3FJSHlmTXpYdEFXV1c3S2lTcUlQdnl6VS9NWDk2WXhNLzJ5ckI0?=
 =?utf-8?B?VENzc1psRER3NTVUbC9ORVd6UEVVSWJ4RnhudjZCNStUbFY5SHlGZVNrYWtj?=
 =?utf-8?B?Z0QyTmZWNEhUUjRKd2FVUmpDbVhIV1JpbzFId09PU2I2bDBlMEpGZkhuY2cy?=
 =?utf-8?B?ZUJBRU04QmY5VEVyT2UvZDR1RlBlZzFDMWhjWUc1eVVCOWdETXhIV2Q2TUNW?=
 =?utf-8?B?WGI4eXFmaFlRZG8zNDc0MUo4WG9tZDJoQVRTK3Y2ajRDS2oxK2VHTUphTC9Q?=
 =?utf-8?B?OUJoZGJ5aFlXL3BjYjlCWGdRTTdwTitCNTF6OUF4dEdURkhiblVYNmFLc0VO?=
 =?utf-8?B?dTNyVmJNdU5EUUhBeWg3dUVTNXJRZmpsaE8waEtBNzFoQmw0anRFUTE3NFRW?=
 =?utf-8?B?R0tvSGYwazJsZFR3d29RMGZaTlVWUGZhNjltOXE1UHZIUm9oWFdESk5OOHFJ?=
 =?utf-8?B?QUVKU3NMaE8vM3RTMm44T0hFT1QyVENISVhCZTgrS2YwZDZCK1B5cXR6Vnph?=
 =?utf-8?B?dkYxREFmdndwU01mU1I0MW1vcXpKZUQzMjkvZms0M3FkLy91NzcwYVV4U2xl?=
 =?utf-8?B?dEEyVFpEMTNNYjRpMXdHUHo5V09WTm1abGk5cUpUYmFiWXNSaklNcEJ3RzBv?=
 =?utf-8?B?WFEzQTlMQUU3Z0RFdFR2Q2lmOU43RHBOMVJSMGlVREVmamtTQjNFVlptUDJR?=
 =?utf-8?B?TWFzajZMeUV0K01EREN4SzBVSTlLVjgyZVltcENpSEZCNmhJUzROcFRzQUsv?=
 =?utf-8?B?MWJ3TDdxNWFLN2ZUQ2p0dnpjcVhzNXNaUENYMnh2T1dWcTdmQkE2UGk4TVlF?=
 =?utf-8?B?dmlPay9yTnIwd1p2am1JODNnZEhjUGI5UjdUUmpHNS93U1RTVFVDa1BvVlR2?=
 =?utf-8?B?aFlhbFhKamkwZkVPN1FEQnFPbEdBSnE1QXBkVHBTY0Z3TEFEK3UybDRLdm9z?=
 =?utf-8?B?Mnp5RWNJSFdocEhwdi9RM1E3OGZtQjl3Rk4yUU0xRFFTSGRZd0dsbS90WGkv?=
 =?utf-8?B?Ujcwa2hsSDFuVklGbW9WU1JVeG1sM3dJVVNLV2REaWhDVEtVN2V4STZLSFVn?=
 =?utf-8?B?OHZSazQ2eEJNeVBaS2pMQU1tb0YzNzN2THE5Q0VDalNMVERmdlJVb1duL2lF?=
 =?utf-8?B?TWg1aittQzE3WU1oTS9hR1NTd0MrTy9GNU5zWm1xR09Ga3BicHBray9qOVVP?=
 =?utf-8?B?dkpnZGE3YTVYb1VjblkwcDFxSlRrSklBMnlITVVFbjZmSXRUM0FmTXlXNTEr?=
 =?utf-8?B?aUNCLzh4RVlCUzlualRyOE9mM2pMYkl0eUhGMk9HdkFwSVdNb2hFUGdqU0Ez?=
 =?utf-8?B?SG9Pc2pIc0ozZzZMY1lNTCtLMnF3SVRPbkJzSUdvUVFPNTZSaVdtUEtrV3NQ?=
 =?utf-8?B?dkVuR0RyUFY0MzZ6YnFTaVRlbGYwVVdVcGtzYWZXSGVrY2FaR2VKZ0d4ZmZt?=
 =?utf-8?B?UFNobWgvenlBckx5VWN2VGNjVGljUzRjMm0vb2RUa3A0S3hqR1ZhbnFuYWtD?=
 =?utf-8?B?UFJobjMzSldvYkZrbXoxQ0ozbUZiS0ttRXJlOW4vZEFjaFlCb0JjNFpOaElQ?=
 =?utf-8?B?UW02eXJjTVpNaU0rTUNwMDErL1E2c055L01LQ3NBaXllRXdQL3BDUFJwVC8r?=
 =?utf-8?Q?HlmDtOEmmIJRcApc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+AIUOvwV4ri7cEIKmzgMugHBYNEaqdXnokAi4EG04unUoqDOP6DYvPxIDV+EMDplvCuQrt3ri5t922ksEhfM6XrFlHXxEPgIrj7WRCYWImpb0q/OS7zfZo4KyZ+2zKFZJVHF3NveY1EMDt1+Wa0Zvqu1xeuc8v5cpprf1ops7HABwDxQ5q76ogiXPzCFu0LsS+v/pfFXfLGQJomOAZxTg/jcCSQEwmNVbF9/BbWDTleudeYOHbxaQ38kMSs51rI6GWDwE3D1CWt/j8KmNm/rUBJLeLDTQmGp7HN5inZITQRZ3+FMvyPOydZyNckJNzktaXqlV/ooVjexzHv06KQUgeA97jyDf0ElwPfXn1UQxBTOMAh3VeUpDGqqDjQFk0m/bgDTlqkaBuR4kIZ6t8lKBsITpX8p17pFKQ9f5kvcYs/xUkVAC7JeGJqut0dmnM6fpAwWZWwFsIWvO1O9JBl5YH3KBvfXAi/6wYUCbHyTKhEnwelbXTnxQVcHG8vnv9dLYJuroyJDLhjq8JP7IFQ2grveN+QyFk9eXJ4qQ1Z3agmgDvifuJoXNQq63Wpbqf+ZBynnI19HdoNwD1Y1T3CQVctQifAOJfSuhLbBKzIZZlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c5c42d-56d7-436d-7ae6-08de64a5d83a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 11:01:15.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl9pV6X52oGN6va6hXm/qLclF4MREmX86lcIdBDnviu5BrIFasMMwWCXwH3a2/jGfV/CyUG2iqn8MsNOLppi42Ig73YWUzsZ0cSaechbyHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050081
X-Proofpoint-ORIG-GUID: _p_Uv7iqLmMTAfjQ5Y87a29YWa8z-AKk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4MSBTYWx0ZWRfX99Lxp4LEkok7
 NlKYmn6HyoCNMbKqjagQueVWX6PaDKObpzbMcSZ+mD5zytpamupnmTwCXIN+v3iy7HkN3Gy62Tn
 sSDFAgNxNcRfKO6CddO92WUwJRH4y2P3pawhqkJS1bGRcXN0IVRB5sApGoSEPQEGsFqeuIdS3es
 NCJnfsnA94jwBu5fKRE6hpGUxE7aG7b3riqL35UECdhkFWFkHPHzUYfhbN6Kd7oy1L9bvGVJ7I+
 09tVtn+DPWOyG9kl4Qp8HWoKXXQkz7GdxAxB/pZLUrNv9uIA8L9BBH3dkb4FMIqscNV9GV13k6N
 fH9ChY/zmxf1VeuklzfbJvXftaTLMMifK4VsPMI75tZOLYobIXrqKHgnKgjJwT5sO6Cxp6Wm7by
 FmyJBHUu5ETUsBZ0OBIiWwGXszrC/93HSQanUA9DSU9/Kxbxr/mVNz4aAjcChpHTsdGZXXjAqQv
 Gm/aw14hnvhC5qIAzSA==
X-Proofpoint-GUID: _p_Uv7iqLmMTAfjQ5Y87a29YWa8z-AKk
X-Authority-Analysis: v=2.4 cv=NprcssdJ c=1 sm=1 tr=0 ts=69847885 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=BcPKCTjPAAAA:8 a=VwQbUJbxAAAA:8 a=1p8k0wjoEks05fVthh8A:9
 a=QEXdDO2ut3YA:10 a=MNXww67FyIVnWKX2fotq:22



On 12/9/2025 12:54 AM, Maciej W. Rozycki wrote:
> Discard Vendor:Device ID matching in the PCIe failed link retraining
> quirk and ignore the link status for the removal of the 2.5GT/s speed
> clamp, whether applied by the quirk itself or the firmware earlier on.
> Revert to the original target link speed if this final link retraining
> has failed.
> 
> This is so that link training noise in hot-plug scenarios does not make
> a link remain clamped to the 2.5GT/s speed where an event race has led
> the quirk to apply the speed clamp for one device, only to leave it in
> place for a subsequent device to be plugged in.
> 
> Refer to the Link Capabilities register directly for the maximum link
> speed determination so as to streamline backporting.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Tested-by: Alok Tiwari<alok.a.tiwari@oracle.com>
> Signed-off-by: Maciej W. Rozycki<macro@orcam.me.uk>
> Cc:<stable@vger.kernel.org> # v6.5+

Tested-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Tested with LTS 6.18.

Thanks,
Alok
