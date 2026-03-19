Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2618AE3
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935132; cv=fail; b=Kmjk/4uePOIHx7Gz3rMiiRYoTLrFpTlJjZkWiZqoM1dpffiJY2ZSvJCnUPS5RVzfx7foTmHo/6CLPI5783V6pGIn8f/wDNqGq68gm8PtAVLSh/FkRsy41SlhPBg9Klzctcb87gzDX8Bj7c5ESUCwOWuUec+JsmpI5ctJNqgkZw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935132; c=relaxed/simple;
	bh=4k+Ix8ebtjECz3uwtVw6ihwVHN6npEEWB0P/2tABhHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DvPCRtv9q8K48fSF0VcyPkbN4odQw0sPonT9m7G6vue9wfHEFNrGK32ntlgmrhGLw70ff8SnndIp22lhCM6l1ZCmYUgeBaZYZ2TdzKL5F+XdchY71UmArZvxn8uQtCCAiengYtTClm7VBT45Sy8fn0gYnv05wm1DWOgixtLPa0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=acJn9kYB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fx/xlg6A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="acJn9kYB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fx/xlg6A"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4pa4T1776366;
	Thu, 19 Mar 2026 15:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wXHqzJZjvBAAyRZr47deY5xFudmrDYDPJ+VuGNkGUiA=; b=
	acJn9kYBK3ToNb273S/CjKbQyt8GiPLUd3wXCId2aeyFppBklmCxzlMGMyRl8Cqi
	ugRlxJOpeOie/NTElGOycjdvwR34e1yQTFgnaEVg5QMPvxWIgAkFiAeWUy2B84OV
	U72zCvNQ9t2YdTfEk8CKuuNRCK0no1FVghgJeH0m6lYvCxmqDBrcGUwzeFwZCqgT
	LiIaryYEwjMPmYBhs5tyxCXuEpc+oOSUM4hB5xJLKy0lcIjmGY7cSgSx9XY99+2t
	D+2/jhvCQdw9bN1aMc8dc0zgajCN5U8p/+biIbkAkba2A8FUew7TXfV9agdxPui5
	HADc74dCL8YqS/m6Tdd6Ww==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8g8r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:45:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JE8lHh021357;
	Thu, 19 Mar 2026 15:45:18 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4re3sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFYwDbIwOV24tSj8nRPbnbqz6KuQxokStIHzeEzJqZrwtx0prpNTed7Nn+r/GnxlOAVcHyAnSiDL49Z8xG0sEI5M0upHXamyYVEw+tyNae9jJJ5wWLh2TVdjTbsvPh3OApn2CjL3oHvB1Iy7iDjP3FnsquNWjuBw3b1nJySaZUYRnAeNsSK8SGIFIyhanz/yjsrHVtY7uwxSeXEwORxjzaXLzYgD7NXMnZmwJQQn54tqTVSsHTrk6mtzm5mb8vvDnFOR+5LISGe8sDjOA1TFfDuVD6Pa+DVwig1IHi0lMmoZWm+OoH+dGsSaOQzaQ9zLg98Gsszx1r7PLA7PQV4YVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXHqzJZjvBAAyRZr47deY5xFudmrDYDPJ+VuGNkGUiA=;
 b=W6z0YOmJk3IKAkuV8FCEF0PnbB3o7tUQ0GZrgFuK4tY7Yr9O61QIpSsSF3MdGe9bsp8/AZtZGjK1xxdEr8PucYyEKyR0/+bjgB/gcN5BTZmZH8/IFXNj/tT9CmUcZcaC4zEul3CR7Vpis1EXCkGL0dKMmQOCmE3qOa0r++5+1leq9udnfS4utw/cZyawuBtbizoQ0gLVuOc7ojHpnxsjc1SCJIiav89nk2WoNO78hnqTQMqzU0uD/L+1O+KBgqT8J0Nb+FZ3VVQvJq58qMXhoXdNI8f5wKzZtkeSziShAiPfncHwqgfU2NBG3SSCgjFXa5jkXVAhBFhn78riPxcOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXHqzJZjvBAAyRZr47deY5xFudmrDYDPJ+VuGNkGUiA=;
 b=fx/xlg6AQfIfB0pAn45xPqHQJHntwOaHORza4a5k8rf1aA8xil/FeNkZhjn6/NQ1lWzcTnnP5pixiTE5ysbw4zOb4m/OFL1AAvOjXfJxJFAjJ3sMssxUhQcIy+f3sg5vrM2T6XFn5yBGRLjk/90hwpqKgFir8c5xFC3/xGAit0E=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 15:45:15 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 15:45:15 +0000
Message-ID: <b9062c53-afd6-4cc3-a78b-0f05b08475d6@oracle.com>
Date: Thu, 19 Mar 2026 21:15:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix incorrect retval type in remove_id_store()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        alok.a.tiwarilinux@gmail.com
References: <20260310160347.GA680013@bhelgaas>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260310160347.GA680013@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0046.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2203d0-3f97-4767-4ad7-08de85ce8355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dnTQzBA8BZmOrLXsUZmHMqdVTkgGsm9vjNzT6ToxY2H7LkpoT+pTTGlU14Gmao/nMec5Hdm21qArvhnbCKiNLBs9lBx+hTXcwtTuV+G3eDSvv5OOBLpSmk/G3RmyXC61jNCCy7nstRJbLRkiOQDQ//UtOGTZ9ja5ofMhNJwyTaEHs1GLYj2EclAf4QJ1qx3kRvpHWIcIQJzH9l0sl29E8IiPFx6wIB7+pkvC7Lpc1tpEbiiYhLBnxp2HI5hjOecwUPLJfKIrmjMJQbdtrDgcaQKAeK3tjPo7+cHFk7KDm+8eirEzHyoK8Y9pfR9xx/N5nPbqD7crjEE7WFI3pa2PYLvoAAuN078E3+n+FWwhPzb7NLWnqRqBnMK7jk0D0Q/V8bZptCA4b3cEsft+a+uVbprlv12pn+ebqrXHn4vKurulZe7u/ELYaNBOUtnkxTYxOAfohsHRpNKLielTAIWUCo+1Xk4OrduusZv5FHVcQE9tOGVYHXribZlnSy3XkB4LBsiunE78gpDewvff+CqgiQtHkP9BjTmIc0xrLCDQg5/i7PbWgCkc7pNqNHX83LkBqddTdPTned7/M1xvrr5qFWIK9nHTnHNEJedSrQP5bGGh4UmpTgcELpmJ4ekTTyDjdrrLdzG8yeypc3PXsMbeUnMnvlymq5wDzzpYozTFGSCyD8m5oqvckILV0fbTrcpjN7X+MKFlzI+IDcCSGwZ7y3IRUCYAS60X28XxfYO2D2o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXZ6dTgrUURQam8vMnF6ajdkeTBpS3hFU01sL0tJdmQrMEZFWk5zcUNyWU5Z?=
 =?utf-8?B?Zy8xQTVXZmQxYU9zdEJWRVFJVGxsQ1hOK0RvRFY2ekQ1NXRhQWIvVU5pbmtF?=
 =?utf-8?B?NkdkWUpyY0s2SmNmR2JyQXF4WWU1VHc2THlvdVpiL3dYaFcvbUpySjdlOXZ3?=
 =?utf-8?B?OGRxbnBmeWhwWVpnVEJKdHJkNFBSYTk2UDBNeTRjdHpmUWdVUGs4ODdMaXhi?=
 =?utf-8?B?dHRjeHhOQnF0dis5bnhMeEJwVnd5NEZwdmRUVzVYZXNGZ01JZmdyeUVVR2ZB?=
 =?utf-8?B?U0dHK3V6a29jM3JTVlRMZGQrTGpPUG5nQklURGlJaTlDMFhaNFYySW0vZDVw?=
 =?utf-8?B?R0thajhWbUxscTJhOXh0T2RQR1RESXA4MFJUdDdDMG15TytDcWZtNXlsMkZr?=
 =?utf-8?B?SXlHcDJrd2NvM2x1T0tENXhITFZLQ25rc0ljVGgwazBnUE5GbDRKRWt5VWgz?=
 =?utf-8?B?T3hQRW1SRlcxM0RqVzNFRGUzcStkV045WDVVdyttbklnNkVpSFFyMHhROGVa?=
 =?utf-8?B?eUdMWEtXNncvdTA5aDF0ZW50VEJKRkQvMlZhcUV2Znpqa1NPMTgrZHBVdEp2?=
 =?utf-8?B?L1JBZXdRZ0hkekJsbVBjODBuVSsrSEtIZDRmMkJxOWxveExSdDFCZEhHUmJY?=
 =?utf-8?B?VWhENmttNEhTbWxhZUQ1NngxY2NCcWtUdUxyS2FlWFhDSG85TFU0aUQ1WXUx?=
 =?utf-8?B?T2pEZ3lwell5Nk1jMElKNVlVWG43VFNySTEyd29lYS9MOWhOQUh1cVJkL3NX?=
 =?utf-8?B?emVoUFh4M2ZZVzVqandkRVJUaDE4b09hV1JkTys0NkdLK0NNUVExZitMNmQ2?=
 =?utf-8?B?N1AxRGR3NWRETFNIeExIcjNNNHRrcC96Z0Y2UFhkRnVXSkVGSnBDTTVvME5k?=
 =?utf-8?B?dmppRnczVHJHdzB1TXBUWHRTTm9mOGszUDJudEM1WlArU3RsZ0FSazl3ekZ6?=
 =?utf-8?B?OXowNy9naEc1SDN6OUtOVVJWWlkvK0J5STE0QS9BTnpzcE9mdjE4TjNOcGxz?=
 =?utf-8?B?dlV3L1VFK0dPTXE0STdDTmVORlI2eXJZZ1cyRll6TmVRaDB0S3g2VUhZR294?=
 =?utf-8?B?YWNNVS9YbW1ZenJQY2poNXZaTGtZcFZUdGdObE55ME5nTms5cFpEdUVNeVho?=
 =?utf-8?B?RlNsMm8yNHZlQUF1ZzJSWTVQV0xMcjBEMjc4emhkOVkrZTRPdHRKU29YRGJh?=
 =?utf-8?B?M2lwbS9DZlNHNm8ycWVSbm5GdE5UNjlPdVU1cjQ5bCtTd2d5bGtRTXFGOWRF?=
 =?utf-8?B?ZjRER2tkbE9vY1lTZGJLLzhWTlRvNXd1eDlRdjNMY0RXT2ZwOTZPZXZIT2VF?=
 =?utf-8?B?Zm1vTjk0YjVOUkdzL3M3UUtVbFZGdVJwTzVyT1drR0g1Tk9pV0hoM1JKNXBK?=
 =?utf-8?B?dGU3cHluaUxZaHJUK3F2RkZCUkVhUEFrYjlOMDRSTFBMbmZtekVoSDlzdUMx?=
 =?utf-8?B?Z0taM1hQZG1XS3JjbllUTjluSThuQUt3WEsxZGNDNnlEcHdFWGVqWFpyOWtz?=
 =?utf-8?B?alYvcmNSaEZLZy9LZGJ3djYxRjQ2UWIwaXJ1YzdiNzRmSnlpVUlwSDNXcUM1?=
 =?utf-8?B?NUZSbGdRM2tkdFhFS3BzT3BZVzhFQUt4aFNvdGViRTRIbC9aWHJoNW1pajZX?=
 =?utf-8?B?dXdVZzVxbnhGNGhxSDhnRkM3dVFWaEhOOG9sa0o4aFpvSllEWWVva0VWcEg0?=
 =?utf-8?B?SW9UTGFVaDlWRW9UUkdqQW56QUtPTnJoQWlBQmZUUGwxdTQyYnRCdEhVR0VI?=
 =?utf-8?B?MTZ1MzRMbytFa1Rwc2tVQ21ucEN2aU1GM2RuNWdKU3dJaXJjbDYvZDVBMEdD?=
 =?utf-8?B?VUVFeHFocmZWTktLTmlWUHNGYUNPMHlMY0VtTUszTHpyOXJMR0kzMzFLR3c2?=
 =?utf-8?B?U1VtSC91dkszT0xzMzUxcEFBSm1EUDJXeEhYQnZaWEw4OEZONXh4d2Rsak5l?=
 =?utf-8?B?allEUGxXeUlkNlFZcWpJcmVNY3dYTVY3VWhFdHAyODNqS3B2TngwQi81RTFK?=
 =?utf-8?B?SXNja1c5SG9wamZXZGpYVlRva2NISUpsdm9jZWZqNDdSZHVHMlFQK2ZKVFhL?=
 =?utf-8?B?RmNPVkdHVGt2cXE5Qkh6VXloaWFsL1JES2FWSXZqenNaL0xLQWlXczNTeGVI?=
 =?utf-8?B?bm1EK2E5T1NMckdaa0R4ME1BdmduSlA2cWpDQStDUHgrRWRyaExrellrYXF1?=
 =?utf-8?B?bm1oYUxycHptL0pXbE51WkE2VkRkQVp6ZFUyYS9vVTRPUXR3RW9PRVRtZlRM?=
 =?utf-8?B?TnNVZExzeTFva2dkQ2lOdHlkNjVINUJvQnBablJWczdSRC9Yek5RVWdPMmJi?=
 =?utf-8?B?cTBsQldlSUxLMkJGcnU4VGx3Sm1BMm1DWExyT25LbllqRml5cXFoSWEwVDVF?=
 =?utf-8?Q?5dY7dyKUBFVeVZ4w=3D?=
X-Exchange-RoutingPolicyChecked:
	c/Jdhqcn1qMOUGZxZa7UqZGeyBoX0pNz1CJiniBfDIWAJZv/2gpg6R6dL68cjAiGdnkMS7FBjszuQZuMsZkVkZ71gey5IbevDYuMKJRc5Go0mPveq/TCcjurOowE30iD/SjSSGZq8JdoUuPgX6wIdJoRRCLU4fji5/cFOJ+yF271XKf6N0T2bWQdHeD+8Hr3dUpQS8lX6FycgLpWuComH2d+itjps7MFW2YaYDSJ8EzX/9TObJfE9STXuJMFTNgIKZhn3Do0MDJZ8uvniigyAdUeXbGZN7ncNjhGevohNFt8k9mqd+3YhfyYjFhTojUZVDxFsIvXJd/hfRSzKF2ecg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7iLMLxYvS1L3Dgra+r0mk4UqckIn+v8QrtmII/fjJ8NKFG4LLpMFslw+/JeC+M5J8mFHNRU9zZzQ+8fl3nlErhVKbhBvwFlgDXE0kDgax95lG50jg/VPaKfngAZFoVUiG3H3//xsDr+ocFncQSah/u1MV6UV85kmRhrV9t9QsWFmWW22+xHONdTeQsLVnkf8Iuk4i0IYg5v2gWaN2lBlysgYK4rKcZoeLYIBB8Tkqv1nxAI+s+fYo/A7JoBpeLno7l4Gz7AzeANjfi1jGVZ3O4GwnHRlnoqBQtckP1EKw5dA4+ln2kG8XMb0HXKBYgD29hHBGFJow54m7IQ7mp/t6MQu2OmG0MGcT5JKcolcRn1UiuUOg3RY2mw3JZUdMhLHaVsvo7i5VcvW1lOW96CcVKhRfDM9TL3tQreMifVQ4Iih/ougClG16ldtAdLhQmZqKyURckBqgWOELBLf5Es0hL7HPiFd/+uwzog4AL/L547BDCHpSvzSoWKzDXUjNrsw30cvutr1MXP0VN/pxYj2XrWMrj6lZsDOU+UsALYyv56sgjxb/38zeIgtjbx/JMfxqeQSxB/2BIbZTwv3VcL0S/rMU/20BhJrJiZ9Hp9ihCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2203d0-3f97-4767-4ad7-08de85ce8355
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:45:15.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e259+K2KgrSrX0FIlX6JsBdK2ljKiwEuYmv1BSNKGwl7mXNDGgfqTvjq82y+AKBEeb8XmPNoOZbXMhEerXcxoodlQg9+WqnehHDWC6CUc5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=765 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyNCBTYWx0ZWRfXyLdGmUE2vI0F
 xy7gmeqiQYYbVzJIqD/SSbpNz0uNDsAsKpi83K+jUU757pZ5x7LOfnh7xtKDoO2P9V8eWL+2H3r
 tx9hqL7PjG3i1jsh19tAvtjr4TBweqyymrUuUfqDfRRSnp4oVeJmsQSKE2Z3bAgPulDH/iKPUOc
 qG5ZBVX2vIXbQXqTnZXnmDZBf8rxxpJfa7zh/t4BsbBZPwSWYzMbb93Vw2tD7TsPw7rrkcdXF84
 M/RtH9UktGeQa3LGccTCahQiRO8KcmXhGgsgKBE7ITkkVhmY++qu+envMnUGuoGRMfPbkRheqnv
 umndUfsKzQtP1/yYJ/Nzg6tMsNq0crZoR2m4bDCQlQNJrPyfJUwgO/2ZLjh8J/F44QH3U3cyY3o
 DUNd3wByDqDQhgItoJGW5I1eorEcez0SC+BKwQudtW86saBCmziwsNKPDWvQNclttdp5U/BMpNF
 00wx49OgFvOy4F4IPojWSAOzktwQxxkyIfubQ4kk=
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bc1a10 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=02JMGbV0qwC1VbUCpXYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13824
X-Proofpoint-GUID: n8jI0S7IMJPgGWNgzMYA7LxOjYpFnefx
X-Proofpoint-ORIG-GUID: n8jI0S7IMJPgGWNgzMYA7LxOjYpFnefx



On 3/10/2026 9:33 PM, Bjorn Helgaas wrote:
>>> Does this actually cause a problem?

No this doesn’t fix broken error handling. The behavior is unchanged

We can note: "No functional change intended."

> Can you answer this question?  I think the patch itself is OK, but I
> don't want to claim that it fixes broken error handling unless there's
> actually some way to observe that broken behavior.


Thanks,
Alok
