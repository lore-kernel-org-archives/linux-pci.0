Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B627CB35;
	Thu, 30 Apr 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562879; cv=fail; b=ZALy/aNrm17gPuhs5E4q7q3AkYbjs4phgjkRzY9zFb9CcUnGUOXpzIb/yRsUxtWX+II+tBZKhZ8dXEBwlKIzH3A+e/VCXXS74+n5OOysMRGNrhi4cKlb4ecuotE8dOP5s6aWIsmw2VV1k22J/iFYHZ57/u6uaRskz6fwxb9LBjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562879; c=relaxed/simple;
	bh=DKcv0Yl//Mrz3ZcCSm3PUcZa6b5U19G42CdJed/zrGs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sflMO9DyNPMepw1ZL6J8LRMCjnw6DZhTExVQheRXf3/57ZASZ8gW1s3rCf+TCLVUhR+XmmgdWfgieU/6EWM9V1ZzdeNw6ntLOeZB2KpefKHBOeV2yBSLVK88pokbW4DSBYxovnsOvt2GilUVvz2DcjFYDd6t9s/NqANjq6TXdbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ny4Qbf2W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k44gqoB9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ny4Qbf2W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k44gqoB9"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UCfPRK1072241;
	Thu, 30 Apr 2026 15:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y9In1WygENSEOSFDGPmXvI08zSUHiXuQ7lWqmlVvjB8=; b=
	ny4Qbf2WTEkFw0e8k6Y9PLuwIiramPkMBOWyas2JK6py7hb3qIK8+bxMLX9lKroQ
	EJK9Uwg0uD/ods8QGLxa2/D0TXMVvLnEASkAbJq2Mbi2oLT66UEQ9+46psnz4gjA
	xabgAyKRwyQbV7A2n1T0EKA3EhIHZTvypADlrqFIpPDMzRJmOmFlQCJtrJ8x/Pq4
	fVzz7FUmMCE4dcWDg7otSJhtxHRQ+C1x2aH5zpJ7jApTKk+DuHUumJBL+JLMktcG
	HL8POZ8gDd+FcQOChSEVL7DgnMazW6CVrX/94ogHKxHJjgs9P65r3H84lNDp0TO9
	KeiSOlRattBGWjD+R+vuUw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drn7tda3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 15:27:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFQOMH027556;
	Thu, 30 Apr 2026 15:27:31 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2fn44g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 15:27:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hThCy578dJsjozvCnsaP7Wwp3t5DfwA2bM0tz375ustMbvn9CX5PnurX15UZ4y8hb9p4lkadU/fgOGW8wJZ5n0OSko7beW420L0A9kpz8QJqYN+QIMAD3u/JJ1BFWsEQZGIyorIhikrWYUJam2Q69QDojKWonScCKRyfSPAVmxPjWK3tRyAma0P8f+O4lbJaiUCCL1oWATPifSnmePpgss0Six4mnyLFSxmXii0z2f3L6h/9alzYKUGBZAJig9xrolo+fo/1qOsYlJ08VubzwIOfdX9CcglCdhgLmT/LFHGv9MVwAf0UcyBFAXsXkNHL5ZNkkc2ZFoY12ra7DXre9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9In1WygENSEOSFDGPmXvI08zSUHiXuQ7lWqmlVvjB8=;
 b=vqCJj/kHsfplF5YX3qREoQuFD7GLsEFzHqRcJQLhleLy7gtR6SrbFVmKhtkcvZxNUJiI59aj1nmbKjEHt/VHeQI6pbXNQSNoCrDVu8fLoVZJIF1ev7/r6ttCFJuBSn2KIbzOqkPXTZkBG2XeiSU0rtVK8LSdcE7RCwypTAaYkJfQq87BxnjsKZc2Y5rNkSfswS6fWPNjG6Ce+4fe4KpAAxeVKb9VjLpY24Nk2ab0sxVZBcWIBSQ0Eas5rOTAdmkZt+cFCBSlY/wdgdXhH/WsrfzndTrA8Li1I+P9zxgYsnhOMSuX4XZpd7qskuMQEMfmsVKBo+I7pqw9xtE9wLLVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9In1WygENSEOSFDGPmXvI08zSUHiXuQ7lWqmlVvjB8=;
 b=k44gqoB9FcY1jBZGOcjFVk+3Zvg+8GlW3u67r6QQX9HXjDSB76l2ns7okGVIBo+yWbCZ8W3jrd7zTxQta5oTJGiBr3yZpWm+Pbslfq8E0Vrvch9xJlgdi01Nn0xM9q8RLLbo8roN8/Q8YIdHq8x6kjxtbS92MqmsxZ2vNseDt2Y=
Received: from IA0PR10MB7667.namprd10.prod.outlook.com (2603:10b6:208:48a::13)
 by DM4PR10MB6158.namprd10.prod.outlook.com (2603:10b6:8:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 15:27:27 +0000
Received: from IA0PR10MB7667.namprd10.prod.outlook.com
 ([fe80::d970:9174:bcc4:9b75]) by IA0PR10MB7667.namprd10.prod.outlook.com
 ([fe80::d970:9174:bcc4:9b75%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 15:27:27 +0000
Message-ID: <781bd57a-00ad-43d8-9f23-23b5f64f77a5@oracle.com>
Date: Thu, 30 Apr 2026 20:57:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: ahuang12@lenovo.com, ashishk@purestorage.com,
        Bjorn Helgaas <bhelgaas@google.com>, guojinhui.liam@bytedance.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        jiwei.sun.bj@qq.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        msaggi@purestorage.com, sconnor@purestorage.com, sunjw10@lenovo.com,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <alpine.DEB.2.21.2602231829500.46231@angie.orcam.me.uk>
 <20260225014119.10047-1-mattc@purestorage.com>
 <alpine.DEB.2.21.2602252156250.34294@angie.orcam.me.uk>
 <b1645e3b-21f9-4d12-bcc1-27740e2231d1@oracle.com>
Content-Language: en-US
In-Reply-To: <b1645e3b-21f9-4d12-bcc1-27740e2231d1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To IA0PR10MB7667.namprd10.prod.outlook.com
 (2603:10b6:208:48a::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7667:EE_|DM4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bd0129-dc07-4343-a187-08dea6ccfc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TPUmCENQVCP1jK2Q8GYUUO/KgVPuCITWxwnIxI55t4vVAf1886/lzUF2rCh7Acd7ebLGtxEColSxjUwR6gRq3JSY2dx7ek1pd+RXqTgIrL7TfHxtDiSKyU5j04rspHJxZPXqXF+7XyIooPgVB6LhsyO8+rEIj3fmlRxlVU6BLHgmA6WZJGlwpunLh7GSfxPngdRwiPSezVcwhPmHQ9f06ZQD6ogvftClRk2dR63xmhOjm51KqTxw7oUbAGd528nx1elipPuxY23FEe7DXZZMhO0GW7C0NDS/s/8kDWAskpflvu34RDXzP18Bdi+krDS8XhG4tePKnlC/+ehLro2T9qgUiYAQfjEIvQSzad4sknUyRDsgSg9pZXdmiH9Ve8O8rhXTnDYYiqOrEZaq1fqUMZnCMwV7uotpauDmQ1PZS5KaSlOmyKjbCX6EdXYkHLl6fi6nsGmaTVhuE5um/YrDxjjXGOc08R4rvEb7ydYLNIrHSsX/o9+8fJ+yTDGLJy/y5vbCq8cOzINhHW8iXGgDLhcWMc3nF+acIGCY5q/ygWLfY4ZC5lbr3EGt1o2/OA4trSh0OWcMpJtPyK45Af6CEKAuhl/1W1D0lshehyDrKdtqTS7mRa1iZTCJTbS45Qwd16FKs6mr8Ez/oMlfcS8l/SYfWiHdM2FFQ7qyFTB4ouMDOBFa00smCzplms1aCrxdVKDo21WYLU+TcKhnNvUo6uB8W2zq3Uv01Q11otLzuvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7667.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHFjWVZBNGFYbVRTR0tuanQvR29FdUtwRDJ3b0FraG9PUllja1ZMNlVhYWxR?=
 =?utf-8?B?N3o5TlZHZENVT2lYRXU4N2VSbUExNEI3UVlvaUxZT21QRmFPY0JRa01zbnNp?=
 =?utf-8?B?dlhUblNOK2NCcFE3NlJaYjhLcHlWaFB4eE5EdnlCOHRFaVZJL2tOVG1GNHRL?=
 =?utf-8?B?NFcyTjM1dUJoTjF5YjFOMUlVNkJ3Ky9PL2pEb3QvZXRTNGdiTHk0V2lGdHlB?=
 =?utf-8?B?T2hJcm9aam43R3lTcTFVSlc0djZZMUdnZ0JKTXMxNUk3czNicHZXZDVDNkE4?=
 =?utf-8?B?QnlPNVNaWGtuMURBSmNYTVRKbHJtcHM2aUVHMlR4RjJiYVMzN2wyRWFkejdY?=
 =?utf-8?B?NkQ5Y3Q3ckhPcHY3QnhGRlEvbm54cExvSkhXeVVDU1BIQ3QxVXBWalhFYkky?=
 =?utf-8?B?ZzZLeVJqZjZDeGNWOTd2R2c3eERlRnJJM29MQTd2Z29Rb2RhMnoraGFNdmdD?=
 =?utf-8?B?RjY5RW5XbERrTlBvTWhLZm1KSlIwK01nZytyUDBSZFFBY1praWdGZjhNd2JQ?=
 =?utf-8?B?TnFOaStQdEdwUG1MN3JZc2UrcGsvWnBxOG1IK2xMeFZMcDhqQmY5cUpCWDBZ?=
 =?utf-8?B?Q01oaFl2SXE1dEllWGpqUmVaK09qU1h0Znl4c2c4R2JqVldiN2ZUWWwyUlhM?=
 =?utf-8?B?YUMrYWFNVkw2YzNzWGsxa3Z3NFI3SGlNV2k5L2xSNWhvOTl0aHUzazNTRzgv?=
 =?utf-8?B?c0JaWGQ3VXJySXFOUVlUN21iN1NqYmo1TTFDYjFtZW0wcUV1VVp6WmJoTUlD?=
 =?utf-8?B?NVBMYVV3WTE4dlh2TmdVdFNFK3ArTERwdHFDVnZZWVhnV2xJZmM0SzJaVTJQ?=
 =?utf-8?B?S0IyMWJwRVUxRFNHZGpxb2czcnpYTEVQd240UlNyV3psTjczbUdZZXhSaVBS?=
 =?utf-8?B?c2ZqTTNTclNUbzN3UjVsWkUyZTBaNjdNWXZvaW80dWUxTGNDRFRMbXZYTTNW?=
 =?utf-8?B?Zzk0QVdOTmdPZ0FPQms0TWdIYStQcHUzRXBBZnVtQ3dDRTlWWmVUZEw4c2Y3?=
 =?utf-8?B?UC9kVHd2aExTN2pXZ0JsS3NhVVY3bVZTbzFiaktMazY0aVdPMlBRWHBEenI4?=
 =?utf-8?B?YjJqK3lpM1F2TE1aTVJDcUY1K3ZsOFJmSEExYy9OU1ZlQnNTNnJMWTRBWFFH?=
 =?utf-8?B?Vis1Zm5UNWNwUTVCWmN3VHp6VUhUL3I3Y1Z1RVRhRU9DQnZGTjN1V0czVzhx?=
 =?utf-8?B?OW5JTElQa2I4L2U1MWFxa1lNWGlzZ0RlbDZ5MkVNdXRzR3RCRDVzbnB0TSty?=
 =?utf-8?B?YllteHpJSzVwMkRrSnpJeXJ6WDEzdmNMRU5sSW4vdGpXWjh3R1NVVU5tSGUr?=
 =?utf-8?B?UldUSUsyK3BBSFAwUis4RXVYc0xSNFNsV0pkL0h5aGw4TnhZRXlTOGFmbEVB?=
 =?utf-8?B?ZG43d1M4NytxbmlOMHVyWEdzVm9TekFlNm5WOUQ2bmtTcTVYd2JnenpOL25O?=
 =?utf-8?B?SEpSYklib2VpcDNjZzJOYldoYU40VFpDeWRWSHdzMk43Qkw4bzdpVVJjNFdC?=
 =?utf-8?B?bkZMeTgza3lEUlY0RzhickVwbWMzZU54b0FyUHAyZzJxVlZaNm9TTTdheng2?=
 =?utf-8?B?YUFrcHR2algwT2FsZ2F0SHJLT2VaVXdGQTE5RGhhMUFmbFhETnJCZ3ZJcEU4?=
 =?utf-8?B?Q2d5M3lzaEt5di9JS3RsK3lUNHBzU0pUNEIyM1o2cWE5dXlURzRmQ0VSbVVm?=
 =?utf-8?B?Skh3em1VbTVSZ3pCM1VsM0VHVTh3QnRaRExiTHRFbWhXYjEvemIxQVZJaU9P?=
 =?utf-8?B?cUZRVkFVVWR6WWlUbEJDQ2FOZ0dDWG1INERGY1FScFRUMTlLdEdDdHlSRVdy?=
 =?utf-8?B?aGp2c1RUcVdnbVVEUVhUaVJ4ZXJCbmVYNkM4ZVhXeFpJdXovdjNYRGQyRThU?=
 =?utf-8?B?NWRTMlNhemZxQ3NJY3k1aHRsSmk3WWZ0KzY1QmhDVjZya1VFQys2VTkraklm?=
 =?utf-8?B?NFVxYW9UUS91VmtGdEpCcER0YlcyYy85TFc1eXlaREZtWnNUaXdzbEhpMTFZ?=
 =?utf-8?B?TjV5QW5QTlUyUlpQZGpLbmZ3c3I1M1l1MXdnVnFVa0RnY0FFT2Jnanp1L0Zj?=
 =?utf-8?B?WUpROE9UVzdQMnd2KzhtdlN4NkZJTUVhK0VSR0lIbG5MUFNoblNaYThyZ0tK?=
 =?utf-8?B?SHNialc0dEdsQ3A2bWhQY2svSnlUdkR4NjJ4aE1QVG5KbFFqQ05WYy91WmlN?=
 =?utf-8?B?NW1xejRDUGlZbCt6L0hTck5VaVhjMnU0Mm5DSkVxbXZzTk5ESm5YckFYYm1S?=
 =?utf-8?B?VGZ6bS9sWlZHYTYvTm1lekVSbnA0TU53aS9Ha1M4Sk1wcU1FUW00UHN6MFF1?=
 =?utf-8?B?YTA1L0g3YmZlN3l3Y0crY3JMbU15ZThVZmZaQmVCamkxem1pZUdkRXBLQ2NV?=
 =?utf-8?Q?7iclwb92BiVr8CM0=3D?=
X-Exchange-RoutingPolicyChecked:
	TiJAn9WGFbkQrptIJcZa99BLvPP8KK7XRiZLNiY3OTCl9F6jTMAN37P7Lwjiv4RYNlf9za6Vv2Cz0XF0vrYoJ3xKKK820QyH3RzHvU8SgRfK/huNO4urrh27FJnZ7beqXomLUXJtK3vbN3VERuBe9LVnDGPlL5vzzs4otPFls8rNMuLUKnLnU9wtlurr6/PDAUB5Ct2nG4oIoKDD3YCjLQKRXZZrkZ57bQN+1/ZpymjXeA+q7S488/epmFrqBhbK83tGRsUR8pj6C/S7nkgMICJEtd2zqI2AucupTQreu8ja3reZTUId48mt1c37pYavJAhy7xvduIscZj9cJ4aHyg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x6EHEJEGUabpX8/RE31DWVaLEG/3c+ig0EQHYAnqLndWKoYJqI68C6o0qXeUuGLpHOyT2Vkcjh3U1fnPcGIGKjcr6rQUgQE25NKHa8OY+2xAQZiXYuh8gYvJ0BG96zc55p+kiHIc/f5Bi/zm7w6FkXt4EBfn994ooDAY/J/eXdmkrsXOmP183V81bSJ8svww9eRs0QA3nO6Fo7bm5adVmQEZBCKv04VNQDDMdecgPqTF/iVlHrLrKEA0RVC6LkR9tZlvyRnowMoe389zavjj3d83WBJi4wBwEqhfwLsJm7qWkrnIBlWlMMVCQtnOTID4fE8vijWwS0z/ex1l7ZGY6hrH2LUj5tt2a+pjUsb/kumJ0UFIUrZSKlqHLhlWwmySLzSwSiC9BBSMIn2CIQPVIfkmm7RvKb6DGhb0OqGWSd4AieviR0OyrGcNKiFv3vbGpjPROAtqDu3l2PDsRJGZRAaH4yVV2bmB4M/Cbe8sYQlOy0vC3FPMJhil0FwhBbQGD+8wZ2qd2yIUvmfb7tT+PiYEPI0hZ2dmJHR3P1/me/+wg8hZkmXLjRO+UWm9xSP7J+gp/W++Ehr7B+aPepZlh5gY0Qn4R9/ZdokfaNegwsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd0129-dc07-4343-a187-08dea6ccfc29
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7667.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 15:27:27.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dns1bQCZVRK0kCB3dP7aTF4UYVbg0T4MMTCRbaBvTn4qiNrbKyILPwfr4q9qJbFPCPcSFn7zJXO0d775rX9u6wD+TFVLV1ASOwIqBICBfXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604300159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE1OCBTYWx0ZWRfX6cL20qe/zVoy
 lfxDXJqdGZnmpAFTH3iN9F3AEqe+c3GqfqtxdRxAYHzWlYsbk5zrzpdTR2WVcyzbY30ISZACC4D
 CxYLUav53H7fsPQCMnL/ugI3vVi+fpJa0NS15JwuGN+HTHvFv3MHW6P+uMO7DjI8ChHp4z0Me7q
 A12ZxMvRd+OVAGOVyXlI8Ed0pwIo8zImZrAXZge8AIWbSxmYgVt1lnaJAiJnzy/NrfMFHhKbBnM
 LccjADmLV3i704kbwtkDQZ7CZIlf4VdVP6Gqg0uif6Xz2I4UgJO8GVPnIEWlu3UytMVpjIBW7hd
 UwV8FwUSAekqGbO8z6z40JX3JrFEQjyHhEut1cLabtODXDtAM0ox8Y9v3Q5wnDR+AsMH6fWfjTU
 /u8iAQrvUQ5d3rZb1hmqq22liAgSc4T2dHUP4bsdUEJta0VOX8MRFgyUJIdB5yfS9gmPzfE5j4x
 m0igdxZJF7yH8uUAVYYHkhJLW8h2B9QA9x9gLhdA=
X-Authority-Analysis: v=2.4 cv=QO5YgALL c=1 sm=1 tr=0 ts=69f374e4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=g1Ut_H662eXyRgUhhDEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13844
X-Proofpoint-GUID: 4raA4JyB-afUspYIUMnEX6W_7siJGmtv
X-Proofpoint-ORIG-GUID: 4raA4JyB-afUspYIUMnEX6W_7siJGmtv



On 3/27/2026 1:22 AM, ALOK TIWARI wrote:
> 
> 
> On 2/27/2026 3:32 AM, Maciej W. Rozycki wrote:
>> On Tue, 24 Feb 2026, Matthew W Carlis wrote:
>>
>>>>   I argue that by applying this change the issues with NVMe hot-plug 
>>>> will
>>>> be sorted while keeping the configuration working that
>>>> pcie_failed_link_retrain() is needed for.  Win-win.
>>>
>>> I don't think that what you are saying is true there is invariably 
>>> going to be
>>> some other consequence of this change.. Its hard to believe there can 
>>> be any
>>> changes to the pci drivers that won't break something.
>>
>>   You're being sarcastic, aren't you?
>>
>>   While I sympathise with your feeling, may I pretty please ask you to at
>> the very least give my fix a try in your test environment?
>>
>>>>   I note that active links are unaffected, so to say it's meddling 
>>>> with the
>>>> link on every device is I think a bit of an overstatement, and 
>>>> reports of
>>>> issues are from a few people only...
>>>
>>> There is no discrimination about which device it can be invoked on..
>>> I'm looking at a fleet of millions of hot-plug'able devices.... I 
>>> don't really
>>> know if it matters how many people report an issue, I think what 
>>> probably
>>> matters is making the right change. Initially was there any other 
>>> reports
>>> of the quirk helping with other devices besides the delock 41433?
>>
>>   No reports that I know of.  Please bear in mind that the failure 
>> mode is
>> such that you need enough knowledge of PCIe internals and the spec to
>> actually realise there is periodic link training activity taking place.
>>
>>   In the absence of the quirk for the average user there's just no
>> communication, as with a dead downstream device (and the upstream device
>> is sound as anything else plugged in, including but not limited to NVMe
>> storage, works just fine).  In the presence of the quirk the downstream
>> device just works and I expect hardly anyone can be bothered to report
>> seeing "broken device, retraining non-functional downstream link at
>> 2.5GT/s" in the log.  It's only cases like yours that bring attention to
>> the message.
>>
>>>>   What outcome would you envisage had I taken the approach from this 
>>>> update
>>>> right away with the original change?  My only fault was I have no 
>>>> use(*)
>>>> for PCIe hot-plug and did not predict the impact there.
>>>
>>> What I'm seeing now is an overall confusion about whether a link 
>>> failed to train
>>> to gen 1 or was recovered by the quirk or recovered on its own etc... 
>>> In my systems
>>> I would prefer to NEVER invoke the quirk under any circumstances 
>>> because I expect
>>> my devices to work. With the quirk it becomes more unclear about what 
>>> the cause
>>> of a link issue might have been or whether it was even a real link 
>>> issue in the
>>> first place or some weird timing..
>>
>>   I can see your point.
>>
>>   However from your description I infer this is about a test 
>> environment, a
>> development lab so to speak.  And you are a highly skilled professional
>> who has access to measurement, test, and hardware debug equipment, and 
>> are
>> therefore able to figure out stuff.  Conversely, the vast majority of
>> Linux deployments is in the field, where no sophisticated equipment is
>> available and the operator, if any, may have basic technical skills only.
>>
>>   I have been taught that in the field it is more desirable for equipment
>> to operate according to expectations rather than to strictly follow the
>> relevant specifications and consequently fail operating.  And the quirk I
>> have come up with just follows this principle, letting unqualified people
>> use their equipment (this is similar to Postel's law if you know what I
>> mean).
>>
>>   I realise that in the lab you want strict compliance as this will 
>> verify
>> interoperation of the devices you design.
>>
>>   So I think we have conflicting objectives here and I can only offer a
>> sysfs setting that will switch between the modes according to the 
>> specific
>> user's needs, as the intent is not something the kernel can figure out by
>> itself.
>>
>>   Please mind however that throughout this week and the next I'm away on
>> holiday (a proper one, as in alpine skiing), so my availability to 
>> respond
>> or work on stuff is limited.  I'll appreciate if you give my fix a try
>> meanwhile.
>>
>>    Maciej
> 
>  From my perspective, the current patch looks like a positive step and 
> seems to address the NVMe hot-plug concerns without regressing the 
> original use case.
> 
> That said, I’d really appreciate input from other maintainers on whether 
> this approach strikes the right balance between field robustness,
> 
> Given the concerns around hot-plug behavior and diagnosability, do you 
> think reverting (or partially reverting)
> the behavioral impact of the original commit: "PCI: Work around PCIe 
> link training failures"
> 
> what is best way to conclude this issue?
> 
> Thanks,
> Alok
> 

Hi Matthew,

Given your earlier concerns, do you think the right direction would be 
to (logically or partially) revert commit a89c82249c37 ("PCI: Work 
around PCIe link training failures"), or would you suggest refining the 
current approach instead?

I’d appreciate your guidance on what you think is the best way to move 
this forward.


Thanks,
Alok
