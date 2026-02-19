Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B43EBF2E;
	Thu, 19 Feb 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518656; cv=fail; b=tr5HhAzJbQ4G75mwswxgf4dftb0EWdH838pRv5bQH5aOicnx/fsvA48FCpm5qxg6UvVEMb5DvXanvpb/9fiDv1CGI6B8MGAbVH2kisRoeukBkqegdhnH+2Pue0tNDtQFb2nc060QkqoPrq+E6AfruaHGJppZaW1MYemD6Oj4usM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518656; c=relaxed/simple;
	bh=Frb8pAliU8TVEflEOIuxEIYKBuJNblnmdjnC/rc7xak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lk1K0QAmEYInBoSPocFRZpyMOl5QcRhLuLulCWboOqIZnllO3NMxUXO83BGdo+qhNeBcnMTwv/tbWCkw2KKUizAbHkEWam6TG9P2zwpeXFsPVAFHAkZtls8g9b2NY4HZ21vIdkWBbO9JwNw3dkPRDbsH6By7Pl5kMKXnegglGHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pil2sJW2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RmWGx/fj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pil2sJW2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RmWGx/fj"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J7csRH066038;
	Thu, 19 Feb 2026 16:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2xGij35bYJOsfx0AvS1nfnTJcCn0JDDqCo6ygg3w8Qw=; b=
	pil2sJW2p7bQME0Y0zdNYakDgnOSSr4NHmHnwx+U67YsabppaeWSaQ8n3yl6hJFu
	u6PDxWHNlVZBgc+S74vuFZx9+eyLVOW4B+64wGv0lteI//ImXzxpbcGdnsc1rxZl
	jSrGrh/pxdyHFzqJWgkGYjGuE8q0JJ3pLGoRD9lzYKgClwSNEppwyHx6udpoYHo/
	sn+6akh+JVnxCDo9h51hlVBo05AUMg3tA16HjC/5RsrDlWXT6dfRPQ6MlHMIqjWm
	eR91/36sAH56+Px2nLhkEK+k7O3Lj2IQZdBjw3OalxJpIeuZP7Cgq7dfOnBAEBvN
	cxE0jjJOfnuideHaVB5r1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj047q13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 16:30:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61JEo5NS022969;
	Thu, 19 Feb 2026 16:30:33 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2f5kqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 16:30:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSAU+Qr915ZzCn39MXFLJq0Z+XWNyoxPGqd8biWjnQxTfBtMXiOl7Y2Zk/pS40yMaa5QJS4QBcmbPw6fvKD/njMarzl9XY9pcS81qRGxEYn4S1xbclOa5e9ABWkzZlBLRMeTyCc3gZrzrQwaJ1A9+7VOgeu/eSY8Nx2pkFPycChP2AaigDwwcFYW17vsJ3KHN/r6GCwOz29h7ZM5VDkhCdM6fp/QCfMVOv63U459+KWBVSSY2Ikxj+Ca2yoc8lIw91wIm9CU2AF+zs7s/gJ4jCoBZ6Kk4qex5K5FfGmpVNIGeR1z6/Re1y93GBlWEwsxT5kncplKwm9aJ7s3LF3wBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xGij35bYJOsfx0AvS1nfnTJcCn0JDDqCo6ygg3w8Qw=;
 b=MuQ66jvceDy7dSv9aed/XPq5Llzg2kB0iwK5YHatZ9SG6ISolkJPDEh0+y6smqiASiWjusqKRjG5f1ViZ/sDxiCTmPKlv4ebp4iknOhT8P9Fr3PwI+L9BwRrqzrxG0mI/hTUBtgs2fFt3xeEzuL8HGzQQQu/hWwCb0AhIg4zhlJDs1pEor/dkAQc2P2DLJCNakoNt20Lq6ma+IKOMHD1MIL2QuWutAZu9c1L4lyrYaSGXbzn/VjGq0QNkryuV+KEsJKboLKcT9QIIVXQ+6rhaiu8Y295h5SEZTLh+siL5DouseMtzriWEJo3DNgg4kLlShewwzh5j7p4e16LAEV6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xGij35bYJOsfx0AvS1nfnTJcCn0JDDqCo6ygg3w8Qw=;
 b=RmWGx/fjHLLKVwapHUgQqdkcJK4lZZ3LjCsKzVg4Wk3JxxrKpJd+T0yY1CTdd9tbEZQYYrVedkcVO84QH3DFAE95ycJ1n4zGQZeBqyCiq7YpvJd3V975YZwsnpCZNERDdv7oY8eadAA3A5NSt6NTRdrs1be+KJzgflBi/gTHrzY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Thu, 19 Feb 2026 16:30:28 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 16:30:28 +0000
Message-ID: <9067af7b-9794-4313-aec2-98c2c5e018b2@oracle.com>
Date: Thu, 19 Feb 2026 22:00:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
To: Koichiro Den <den@valinux.co.jp>, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
        Frank.Li@nxp.com, shinichiro.kawasaki@wdc.com,
        christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-6-den@valinux.co.jp>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260219081318.4156901-6-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: c05cac6c-37b1-46cf-6dea-08de6fd43132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDhhdFlEd1F6L0NWdU1xNjFmUHlQSDYvalo0R3pySGpyN2NIRTJtL1hjYitV?=
 =?utf-8?B?ZjN2Zi9kakljYkxSQStJdDYrOWlnQVRSdER1cHd3ZkNZTU1UWUQwYWlHR2VF?=
 =?utf-8?B?TG1GMXZVYkNnMll0NG9md25TK0JsSGZHWEowYm5kYmhkS2d6THJXWDlub0xs?=
 =?utf-8?B?K1V0OUMxMXJVYWZaeFdWWm9DM0hKQ2QxTlgrL1Z5Y3lFRkJxN3BsbXBzKzBs?=
 =?utf-8?B?RzhESi9sR3FqTGNFT1VKS0QxWUVySEFGb09CYlVvMXdZWlZhL3FYaVpxeTNi?=
 =?utf-8?B?L3RqeGRVblhQeGNSajBSdG5EWmVGUHN5MFRtVHdnWWRRc3JqcjFXb04vcTV6?=
 =?utf-8?B?ZVNOei9VY1BETUhJWUVwL21QWk9IZHRqVlVSZ3B1M2RDc0NQZFZNaVVEcjJN?=
 =?utf-8?B?aWVMdFhEbmlkdlluRzBFaGJ3UjdiTFh3Mm9RZ0Vkd3QzSXVIZTk0bjlFVEJw?=
 =?utf-8?B?N2VuN0dYK3FUanF5WVREMlFiNFIyc0l4UjY1cHp2emJmMVBmK1NmbDVlSHFl?=
 =?utf-8?B?bkNJWFJMRDVTNGh0bVVuVGUwejk4aWlKS2xkRndnbEJtNlovY1lGWTQvZFpm?=
 =?utf-8?B?N3h3U1RNOVdQYWltNDJyZFptYVdBU3V3RXRCbWd0YzVwcU5SbXVaYjJwcUNx?=
 =?utf-8?B?dWxnbkpmUzVtY0xGbXlOZy9nUmJpQ2xSTVlSQnlXZ3pNTUNVVWlPUTVUUklB?=
 =?utf-8?B?VkxqcHdGaUJ5b3dZZUFmOFR1VnlUaFkzUEFsTTZuRHFNMWFnMGdiNCtLUHAw?=
 =?utf-8?B?ajRRWnRqNnhwRnZKcUxmODBFdDZib1E0dHB6MUtXT3ZaTUo2U2Nkd3ppNlBo?=
 =?utf-8?B?QnY4eXFNNzNGeHgyblAzVjhxYmhhSkFlc0dKa21lNXRHT29wbGJkQ3VSRjVS?=
 =?utf-8?B?cC9PS3Fwbm1pUXVoYWFNMm1NWlpGcHFXTXc0RFhpN2JOc3p1RDYwaWdpNS8w?=
 =?utf-8?B?V3VtK1IvZm5yTzlST1RhVHB1aVg3TlFBaFdPOUdIK3RmOG1IdEVGTEQyQmd2?=
 =?utf-8?B?NGpnZ0x3RUFPU1JoRkZubmEyWnBmZTZrWk50UXZ2YlNBVjB0WFE2TFFjOU53?=
 =?utf-8?B?d3NyRmJMaW5zaUhzSjdUaUtOOGtKR1hYWWN4YjdodlJXYnhLMjRYUCtGRGJq?=
 =?utf-8?B?OWVVdjRobW14Uy9uU2FQQUhPM2RsOER6YjZOa1NEN1QzRW1rRFNHYTl2aUx3?=
 =?utf-8?B?WTRnK0Z5MnhMSU5xazBHb0lJbFJ1cHRwbWRtQ2pPelNET0lFV3g1TERkRzhq?=
 =?utf-8?B?dkFnNjFzRTB6cVFReHZFMFZKYU1Ba1YvbTd0a0hXQ3Zqakw2bTJaemN4VlRK?=
 =?utf-8?B?ZkNsM2RremFJQ2hoSllqendqd3hFdzg2aGFJZTcrSTM2ZDk3SHJwdVpQb21Z?=
 =?utf-8?B?Y3grRlBFNG84U0ZJc3pMWkUzWTljZmhNVFlzS3FRMVFFOTEyTlRpWjNpdm0v?=
 =?utf-8?B?OUJiZGtEcm5jQlRncVBGSWNlbmR4Y0N3akJXOFQxSGpsY0dBQ1hmQXFJVHli?=
 =?utf-8?B?VDRaMU5pQi9CczdTN1p2S1lqS1Q2Y2NLZ1ZlZ3J1ZElYK1piVUZSQkNURWJD?=
 =?utf-8?B?M1RiVmtvSllFek9ub09PRDlKSTBkSmFkY3pjMkU4R3pXRXNqZE5SVVdzODZR?=
 =?utf-8?B?QUdZK2RtTVp2TjJNd3JrTTNTRzVQQkJIazV3b2t6ZU1IZVBoTWJLOHFKUVA1?=
 =?utf-8?B?eGFGL2lYOXp6dyswNkhXZWpqM0tyZG5la0FZQngxcDFENk54VkIvMk9Va0lE?=
 =?utf-8?B?ekF3azZ0Z2pVKzcrMHlxRHY5aXFja25sNUtXcmNyOFVEZDlQUjhXTkhVRitS?=
 =?utf-8?B?RjNzNk9mc2craEk0TXZxRS9xUU5hSWI4WWhrdURrNFVVUzhXYnQyWkh1NDhs?=
 =?utf-8?B?NEtvS2N5dFZoYnloaUp2NHhhSC9BK3RFb08wSUt0bGJFWG8xVDUxYnVTYXJR?=
 =?utf-8?B?ZmY1ZlVzTXVQWldRdEZHR1ZWNUhBRXZ4ZVlXcjdHOGc4elkvWVJlbFhaMm9o?=
 =?utf-8?B?RjR6ZkFwNC9oT0tqbmZGUHRldE9CbGFocXFqUlpaczNCVlhkNklBY1ovSGx5?=
 =?utf-8?B?bVp3U0dmcnBZL0VTTjd6OEp1cWYvbjUwMHhha3I3bDJUenVGUkR3UXFqVmQ4?=
 =?utf-8?B?SFB4REFoOGdzeWdHRFZwYklFV0F5bWxsWlY2STZjRllSRDZrYXdEMWR4emFo?=
 =?utf-8?B?MXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1pNUDQxUDczRHB5VnJFblJjWDFXZU9ZamtpbHdxaHVsK1NQcTZsTkJ3Qm5n?=
 =?utf-8?B?ellLSDJsREFZa29CUHhuTkdIT2RFY1NJaGE3TVVldnJUeWx6R0pBOE5YZGNu?=
 =?utf-8?B?TWJqNnhKdXBscHVremxGSFhHbSs0VEczNHFxOGVtK1lkU0lRRFFQTXRxQTdK?=
 =?utf-8?B?dWxGSUFXQXlhR2JEaEFWSFNwYU5HRlU0a2NOaVQ5NnV5Z3JjWkpqVFJ1ODlF?=
 =?utf-8?B?ZUtEU1IrWnh6YndMcUkrait0dGNROFIvMVY0ZU5UM1RNVnk2b0xkbEFUdXI4?=
 =?utf-8?B?TkFiTXZUaVJsMC9FbkpxSmh4c3hQOHFrSC9UcDgwYkRnQ1o0K0kva1E3cllm?=
 =?utf-8?B?QnVzOVgrZDY1bXBxbEJOZnhkTFZNRzI5cHVFbWoyN3d1RWVTVlJ6dmZ4bTBw?=
 =?utf-8?B?NUh4cXNZb2M5VXZNRWJyandIKy9YdDBXUWVrazgwUDFSVkdzdUNrTFlNYTRI?=
 =?utf-8?B?T3J6dUdmLzdmTTQ0a3lQaGZOMzhRVCtRdUtEcVpsc2ZrS1d4bXNXY3BoOVQx?=
 =?utf-8?B?VTd1Q1NBM3NPZkhZRzgzZWlRclp2YUVCcWFPa1JxVDh0RGxXREVrbjVhSGJ3?=
 =?utf-8?B?WStQdmJYcWlwYzlRR05hc0w1ekpmVXh5OW1LN3U5d0J2WDh0cnJQWGY1eVRQ?=
 =?utf-8?B?ZTB2U2syeXBmb1JGWEJQbzdzOEJZdWFOUUIrRS9DQ2k5alVTUFF1YVIxL1Yy?=
 =?utf-8?B?NkVNcVIvYVQzbmxObEJmRFZxMU81eW9BbVlQU2ZFRnF1Vk5BQXFDald5Sm1C?=
 =?utf-8?B?Y3RVYkMwNnl5RmJRWTIvM0lpbVJhRGk2cXRwbjBRTi9RZVZuQ0JST2tDZU1U?=
 =?utf-8?B?dHNwbEVZZUVhVFNvaGRaeFdHbG1TT1IzS2c2cXB4MTd4MWR4WmxIYWZGYXk4?=
 =?utf-8?B?c1d5MGdPQWhGTEpnS0tXTk5SMU8vOWlVcXpwUS9la3FBNEtqVTZ5NVpqelcx?=
 =?utf-8?B?ZGdkQUV5WTAwUy9KUU5jUWZIbnlJR0gzOVhBV3A3UEowL2tHWlZyeWRZWWFY?=
 =?utf-8?B?L2kzVTg5QVJyVFhiU3RkTklDYUN6cmJmNklqbWFmWmMxMmlwWGtWbU5sZXEw?=
 =?utf-8?B?YWcxN09qdUluYTVVWU1DbHBmOTUveVhPWW1uQU40SjBYYzh3SnUxVE9XQWNR?=
 =?utf-8?B?UjNLNERvUGEra0lJclBRa2h1TUgrRUc2YWR6YmxoK1d2TXEva2lOMGd0MDBD?=
 =?utf-8?B?Y2RzYUdsSVdGcmpSbHZJbjZ4MU9FSFJyazRYSjZXOFFxYkoweVh5MCt4T2xk?=
 =?utf-8?B?RnFlVmlvOVNIdjFtOUlDandJbllmdW5uVkd1a3Yxd3RVRDV2MnVmUkJ4TGUy?=
 =?utf-8?B?cHlvOG0wUlhmeEZicmtlT2JZK05YQXF5dDBYVUdSSW9nRlo4R1BYNWg0U0h2?=
 =?utf-8?B?NHluZ3BEM3VraHVHR0tSblI2MzJYMDQ0ZG01ZFcxa3NZSWlzc0RLNit6dmVE?=
 =?utf-8?B?S0psSFhqUHRLbHNoazdWYmp2Q2QxK05YZWl3TGk0UG9TVVpnRXg0bFJUYWZ0?=
 =?utf-8?B?b3NRWDdPZktvUHFMdmh2N1ZVSXVXWHE1azVYSXNxNk52MG52cjBuTlFLNUIy?=
 =?utf-8?B?S1hnV3ZJSDNhU1NITWRTOUozdlZ2OE1LQlFibHJ0NzlEdS9mYWlYdzFLV0E0?=
 =?utf-8?B?Ymg1ZUNyOEt4TGZLc0ltZ1JpMG5lTlg5MjNiKytEWkJpbTFYVE5JM3FwVG5P?=
 =?utf-8?B?M0xuamZJUFJteEVHK1dpdWo4OWJrQkRUUUJGM1BSMkczdUlKMWp0UU1kT3ls?=
 =?utf-8?B?c3kzT2N5MEdzbStDMXZKanhaZTduMmpsNzZrVEF4WVp6UFduS01PWm9Vd3h5?=
 =?utf-8?B?bEFjYytJY2srSWpJSXZnK2V3ZGFPQzhNUkJoT3RYRUlUYTl4MnViNzV5TFRt?=
 =?utf-8?B?T0l1NmhpMDMwZGRVby9qdjJuVE82dTNJQ0taV0MwKzlZcUVIeWlLVDFRT1hE?=
 =?utf-8?B?cFBvamc3MWxTTmRtWU1HVzZ2SUpwMUs1MGt1QTFud2NWaENtNkNYanB2UmRP?=
 =?utf-8?B?MzNXYjFMMlU4bnQvUjlsRW9SK0FxY3R5Q1JpeFBMK2NPYmdQalVlbDd5TUVX?=
 =?utf-8?B?eDc3KzM0b1AwSGMyWVJtVEt2YUN3MXZ6MmhPdStpbzlkY2tIcFo3UXh4RGVL?=
 =?utf-8?B?b0s5U1Jmdlp6d1V5ZktpU1l0ZFdXdlpiMGxFUGF1b3hUUXY3WEdYMWd1Tksz?=
 =?utf-8?B?Vk1SQzFuYnJzNlBoeVIvRjRnd3d5a0RLa2lwVDNESHlMU25LVGx4bkM4ZU93?=
 =?utf-8?B?alBBUnM4V25hWVBmL2RuTUFteDdwOWJ4NUowU01EVEREc0pWZUxjUDgxK3Ro?=
 =?utf-8?B?NlBxRDJFZzh0bWdxWVd6UUxhNE1laGNSTnFtUUs0T3YwNzdPcHlDZmh5WHU3?=
 =?utf-8?Q?6Lmzjq/gqwcNxOOU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FpnFEw1mabqYkJBG2e4ubTfkVWG4Zk52YCl/nBbLzEG0HErg2TSH0JYuQvs2qjnHhaWTGubvbt6CUVPWuXJBrBpxeopIXXTxGfe295jPM+ko572Xb0BegVaF1pyHWq87ppEa7z0kdbpBycRKEgf8K5haBNlN4yV897vYo2TeYcWGFspH145MljmE9qqbniJbXnkgsWvMNMqQRmanR+q944yFl9tN8AOWgtM2obx60BM5v0WCUpNo2SYh5mOtXwrfmQKLYYbrrzj2rVBBOzl+Cj7Ku/dNnHFM78UvHiR4kbR/RDjGQ4lVKpnVHOIV8qbVh1FVNizJiAPkkbmoKJVxux/asfvY8kSNxPQ4SeiU1pOMn7OEMoJ+xj/qI9nZDF6zSxbnr/X58pR/YzduJhHyGuanpDTjQ+AWcV6vEWxlWBkx0q4xyf9Crv4GPpugiKpC8LRA5KEt1elOvGhO2OpuEqmZ8A5MyIk5OhqQAjQQFldsHga/Jq3LQjYLPRlsJN6lDfARIqgcDE4TDFL4aSjKbcKBGgGdg3L9+rxjocXKRr/uIi53Vqv1r7L3CQIqecu6f8+fVaobLWDmRV25rgjOOsl7bAvKPbzLwbqjsw9mawY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05cac6c-37b1-46cf-6dea-08de6fd43132
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:30:28.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrAshT6SlEhZs9OWnMkOioTR86GL0OBBSXdPP8J6jHT0Yp9Uxn0YyneGJO1LEVOcUc0FKDV6bFrRMMnKemGgXUoC7TMXn5xDPfqrjUoUTEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602190149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE0OSBTYWx0ZWRfX4KIZWgO1HnhJ
 mRZedPI/+W4QKSi0gWJCcCbjaCwHD6bWEt90wyNpuHHRL3Fe9I4irlOrGM/2MzcNqR7W50j9fEa
 OYwlhWpeMoRwexLdutrpz24OOH/iKcSAeAEuU+z1ydZx5Oxudfeh7Z65+lO6POiQ9dqnq4YSUp3
 cwkK+UMgeXVQrGX9F+2plPp1c0ICCy8K+nOhoKv4ag5ZIOiBVYROwbZ0kQEltmzSHeplNzx14lf
 GXJTZ6gLn9YKYvuwnukC5wPCRA6IsZFh13XcfODKbaIaKjZIr/SCN6VcqnVmEGlJOHEpDpBs5jP
 ofw6mkw3AKFNzXR2OUIU2RyLtnnBCarBYiGy8B3A/5Q+IpafzXTtIM9AvD48l/oC+J2ftfIzBMd
 PaOEIUTPo/Dj/nds/nLovzThnclpzXzn/E+lEv7THzDMnXJtRXnGgUUFHX5AThbwcAX9yavDoK3
 PMQej2aEjMTLyNIWGyM4FtrDY20dYYXlvYZetr14=
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=69973aaa b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=2X-62Zmk3Zl4tbC9StwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12264
X-Proofpoint-GUID: d7L_KZ0R2_mByNjsCZtwBi62ZMhvyxmw
X-Proofpoint-ORIG-GUID: d7L_KZ0R2_mByNjsCZtwBi62ZMhvyxmw



On 2/19/2026 1:43 PM, Koichiro Den wrote:
>   static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>   					    struct pci_epf_bar *db_bar,
>   					    const struct pci_epc_features *epc_features,

The return value of pci_epc_get_features() seems to be used here
without checking for NULL.

Since this function can return NULL, and other EPF drivers
(pci-epf-test.c, pci-epf-ntb.c) handle that case,
is VNTB assuming that epc_features is always non-NULL,
or should a defensive NULL check be added for pci_epc_get_features()?

> @@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * The doorbell target may already be exposed by a platform-owned fixed
> +	 * BAR. In that case, we must reuse it and the requested db_bar must
> +	 * match.
> +	 */
> +	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
> +		ret = -EINVAL;
> +		goto err_free_doorbell;
> +	}
> +
>   	for (req = 0; req < ntb->db_count; req++) {
> +		/* Avoid requesting duplicate handlers */
> +		if (epf_ntb_db_irq_is_duplicated(epf, req))
> +			continue;
> +
>   		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> -				  0, "pci_epf_vntb_db", ntb);
> +		


Thanks,
Alok
