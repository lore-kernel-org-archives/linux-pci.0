Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBB23AB88;
	Mon,  9 Mar 2026 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071295; cv=fail; b=q1PCkhWfuS+RPCQs4Ge6azfXVIwYjRutKc3GHRZOQIbmXdHcX9xaVwkPRuTelsAKsPLqcJgGtcpgarbdY9mqKNzxzFBg3g4kYVik30fYL2Nr6hrgJgW5r8wqz1MtUWmkfMddW/vkeMwxsCbLalO7dtaIpNi55gcjhfM3vN5jCgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071295; c=relaxed/simple;
	bh=plZ3LGkphCkaAamYvCBK4VO/mWtCTHIifAGhYH1NbPM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/y+Nl2QXKq/Axh41WaeaN5lEZylaQRA9I3h27U8Q0VME1SD6joXJeO+eR6VxaLsW5ELqfXrJctmlDG9yzFv8iC9NYSaooIMy/+ZXJHhpnJAd4v7YJ0I/vX2RSX+F623TyTLr7wFuCBl5x4gpqerapIW+WxFLHMNaQGktQwxpME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GI4aGPkL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mI473ZDF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GI4aGPkL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mI473ZDF"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298vOGr1358582;
	Mon, 9 Mar 2026 15:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EShHuYw/QDew6MtA1k+excDsSyI1p1rgsowOh3w0/0U=; b=
	GI4aGPkLHHlgL9jG0mMTq6pFAV40FPRVH8d69yVNhFGLUm9lV5ZtmB/svkT9i6dS
	JVODZiUqHdL81bIuSGdTKlNG2bqPCLlubOSYgsapWH2HGVVn0zToIOOKN6qSA2Ns
	fKNNEWoIS0pkGgS0m7F8lBTJS8mWLO4MfeMXs3ogil4VR7iAYi6J2UigNefHA4kZ
	B1NlRA4gKjwlS0pTuhBF8LyvQQOBWqR0j5ll4YE6NEkEzXj4e3FKwzyo7Oq9VX48
	QVkdE8F6A/KJbssi4rdKgTQsQ+CvLKmcFDrq5YAgVoAcnNZR7oa5oNtJk0YAkiho
	lEUc7c6qoqL2Q6z8rH1Miw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmma95pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 15:45:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 629E24F8014858;
	Mon, 9 Mar 2026 15:45:49 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafd42ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 15:45:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmDsFtqmIqAX+dpQwdxtv8BfsPOAqNu4hVNY0miOvgQPlrGS/JYvUl3Uobzt7UPq0igKD2beSyzOeYZoQoCL9vPGorY3LP24LFrC8pFHadCmhKPZShVYElCuxeJOVoWr2ffs14mvWnmYXVsX+xtEN8PfDJD7kF/O4osGuFE5E59sxUDiNv04dEuyIN+CuAClfrN8mLyT6O3pkmgaXVtSE8YZaV0AO5lZwCgDja1hqT2GK2lWyS26DYkagvBMhHAX7r8x7CDn/GWZXSJmEvPaBd0qaUNkE6D41wevk4xhgdtbhf4EC4SxhRJORiwF4qWsrr9S5xL/QbLpZL+eJ/Txmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EShHuYw/QDew6MtA1k+excDsSyI1p1rgsowOh3w0/0U=;
 b=l7eart7S4ZBNRqJoBN59M89sJmdl8GHd13yiujoLdwQyVbAJP1k99s6YWZwe1CluNVM5SBGKmFXCFL9lEf/mLMz7kvgaKB5gNEhzBN4xvCvx0ejSn4T7pIPNQHNvQlEsSTL/udfsKeHzyUegD420Qm1Obfr1mWR+l23NygVohlNK5LcWIaA4J3MmrTC7vdbyOdcuzfln7NUiN47a6RBcKsAT2otinVigv1nofk50D9tntf/ei/Usah3RwHYazKTHIPoAFrOFRhmpaZFrTXtUAsKdk3OG3Kq0tgIP30VN4mwQwL/BRmSPpuiiDnRg7A3FU9BX3LnxGkv2zRmuARqeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EShHuYw/QDew6MtA1k+excDsSyI1p1rgsowOh3w0/0U=;
 b=mI473ZDFpocCrht1eHafYD9byezf/Zextkc/84py52u15UE0fRpowY1YCwG9S4Chx5/Z/sroIZduttmMTtLGlLhuOIusmpSkEJGQdsqemhKhdjqJnMO4vKzFgGAAlk+KoMLhvkpfXWU/dsOVD2wrfCyZbWb5d0y2cfUR07ffgXY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB5757.namprd10.prod.outlook.com (2603:10b6:806:23e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 15:45:44 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9654.022; Mon, 9 Mar 2026
 15:45:43 +0000
Message-ID: <177580ff-8c1c-4b80-9e02-43b375920983@oracle.com>
Date: Mon, 9 Mar 2026 21:15:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PING][PATCH v2 0/3] PCI: Always lift 2.5GT/s restriction in PCIe
 failed link retraining
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew W Carlis
 <mattc@purestorage.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com,
        Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com,
        ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
 <alpine.DEB.2.21.2602041709010.12532@angie.orcam.me.uk>
 <d6d04a8f-5845-4627-8cf1-a6875cb21fbb@oracle.com>
Content-Language: en-US
In-Reply-To: <d6d04a8f-5845-4627-8cf1-a6875cb21fbb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0451.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f313c4-7363-49f2-9e42-08de7df2ec31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	IKOYMgtD+7oW3F0pUVhbKmBlS1EnqaW00Agt75krJaKeziBfj4F3lmFyrNdpJF90ovUO4iBr9zHTJw+sXoK+vpOcISZfeJ/gHcYG/O4VaruJAgw99qey/sJa5GjM7/X09GE1QY1pg2sozS9lro0WkHAiatGoASTv9WykdoQ/WkoXS8/LOoTQo/e/+ukzprIBAJiE4271DXFvvYJIPQ5CSIPJpBqkrSojOOPBCnjjzx1vi+z3Owrrh7D2CBSS5g/QKyb0H1/KBasC1u/y9UDXqHz/Ir4ku2oxbg8OmJh8+skU5DDePJB13Vq9qRms0Mvk/Lo3Ldo5C018Oq7sT6HvbVdXoRLjyqIye8YiKXNA6J/htQ551R3kV7djQVz7ixouD5SELJX77uaF9aaxnPzlNNPjSKW5Ll6Z+v7o7+UbW6eEpsWvpezj5LhJZRjGTTAsfAsHZeFKTG41o80NAUEJiEYQ8kOMSZGTnV2Hi/GtMDUQGWTAFdojNCQ93A+PklOiaS64cny76VsSlocVQI/faVvGQvQdZEs780BUxaK9MP9h7m+2X0Ub0KbgUf0QSzSDj1pqRrYppGHCLNbC4O9NJQAy4J1UHgup30dU9RTO8rn89slR1SJRGm2mmGO0/ISlPO4HJp/ONAy+RwjNkkhNQiAMsN8tnP4dY5zojR2zID2AujtGbpoGZ5jg5S5vSEwI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZURNUDY3RjFYTFJUNXJPMkk2ODRBSmsrMW9WSVZCRFIyRS9wYUFBV3IrTlZE?=
 =?utf-8?B?bysyK1NsM0ZGVXo3VXhZcHJWbHN5RzNvNjNXeEtiYm5Sa0lKcFljU3VvU1RY?=
 =?utf-8?B?RHVLcDBvb1BzYU1pV3ppQXJzd25XYzhsM1N5OUhiNitkcm9Udk9wNmIvTkRu?=
 =?utf-8?B?RjlYVk92RDFKVkVEbG81MEloQ3BHRmQvUHJhdUdpZnRKSWpvemVtbGJCZUtR?=
 =?utf-8?B?WXUwTTBrUytiZDJNaXlLNkV1TG9nUkh6aFdjTlRBUXVYcFU1ZGxMVlVFaGpE?=
 =?utf-8?B?MlA4dkFMdS9qQ1ZhRU5VbTFIUW42c3I4VjJ1MFVBcTJzQUV4ck1LQm9nOUdk?=
 =?utf-8?B?cTJQSFBXZCtwV1NlOTlkUWN0VHp4Rk9uS3J6SEdNTWx6TU16dUUzdjBQMERP?=
 =?utf-8?B?RFFBN1Z2L1BLSlRlRXM5c1h2NTFEaTg0MDJ3am1XYlBpbCtqWWNmd0hWcUVU?=
 =?utf-8?B?Nkt6MHNCRGF1blpkTkN1eXpQWEpMV09HdFBwNHZNYWJaRU0xejZUWjlYMFZG?=
 =?utf-8?B?eGRXVlZ6dDQyQkcyNWdYNnhQNVNIZDZySnlDcTNudXQ2T0FtU2R0alQrcVQv?=
 =?utf-8?B?YU1BMXFyK3RTWjZSRnp1V0J5dnUzaElsZWRpTWZVWnRYd1J2OEQrYU1ZOVpR?=
 =?utf-8?B?bTRoNGgwOVNCdHBvc3cvNS9yZHNFeFZSZXZYZzdqdk52TzliM3hLR1g3WlFC?=
 =?utf-8?B?YU9ObGZ0bml1cWxDM0xNS0F6NExkTkl4TUdRN1dSa09oNHhaTlM5ZTlWb3ZT?=
 =?utf-8?B?cFdhd2QyQklyOTV5aG5KYlUycksrZFZJMmNHeEE3aWI2bERVOGN3Y2JpeGx4?=
 =?utf-8?B?dHd6L3FRVzlrOEdub0wzaXBDWUtNa3JWanFZVTlxRDl6WjNNaUdyOXFGbUFW?=
 =?utf-8?B?ejhYWGEzYXlzY2cvT1lsZi9TK3ltVDJOWGJFREFLNDZVeEN0ajd4VjViNmY5?=
 =?utf-8?B?RFFJRUNjUFBZMWoxdGxUUjZtZEFrQ1BDYW82YzJoMGI5cHF2aEJZT3pzS3VB?=
 =?utf-8?B?NVJXTnJ6dzhoZ0FWT3A4UzgyQUxvcmFYL1VTZDd1ZlhWNzR4M1MwYys0NDRo?=
 =?utf-8?B?Z0VWSDNLK3Vmc3hBa3N3Mmg5ODViS3VKejNZVUlDUXhNd3JMRlREYmd4OUIz?=
 =?utf-8?B?QjZLWGFrclM5ZW0yNHNCOHphM3ZsVWFJZEVRYXNacUtoTU4rNDlMSitHdGs0?=
 =?utf-8?B?Q3JlcWhIdGtNbGZDS2wvckdQZm5XQ0d0dlphWUlCM00wdVZvVFhTeXVWeEVH?=
 =?utf-8?B?K00zb2JCSVJOSGw3a0tNck5OUzJNTTQrclJPdkV3Ym1Fb3Y1Q3pZU1JCZnMv?=
 =?utf-8?B?WVYrUWJ4M1dOT3hBYlhOUzBWV1lLV3RCWUlpS2dwUnJUMHF3VVlCdE93ckxi?=
 =?utf-8?B?NGFYdG4wcUFKbi9ZSWlMNmMxc1JqNjZZVmJNc3Z6eGVkeG15NHdrbHduWkVP?=
 =?utf-8?B?dUtYTnR1UnFhREx0M2svaW5RamhLMmxQV2ZvdkduMkhaZVJEaUt2U3lYb3VU?=
 =?utf-8?B?c2RHQ0tRVlBsTCtBWURTakFKcFhZN1I3RHZIU2NSbDdHZURDVGxjRTFvNGI3?=
 =?utf-8?B?QkFEVHJOTTZ5TEVTd0FYSGVlZm14N21YekVsYy9YcnNJQ3JJYUdhekNQczBS?=
 =?utf-8?B?UzRoeTlCc24zOGI4NW1KQW05ZU12NFRMbVdkdk5BRXI3R0xNdlVOMkc4SURh?=
 =?utf-8?B?ays2Q1JudkJPZWJwcmE5SUhMZEpvc1pLKzc0NkxOeGxBZm9pN25ST3VEVWJ5?=
 =?utf-8?B?NFpNZkxWTHppWDdSOHA5MkV5K3JHZ3VqWkxRMncrTFhLVERWWTdsMnBzcWhl?=
 =?utf-8?B?OHJuLzM1OWVJQ2JIbnN3QU16M00xTHoya0NHODBlZ3BaTHAzTjZVR2xQRVQy?=
 =?utf-8?B?WnovbG1ZTE1CdHBTNVNHaUhUL3BrWGxIeHJDN3hrRGhoZEtUci9EdUl4TWg0?=
 =?utf-8?B?ekNnMnhwZHM3M2FJcnFhRnVRbHV1NEV5aGJGT3FvVzRvSWZ3TThLTStUcTZ4?=
 =?utf-8?B?U1orNzBaelY3OFhCYUx5cUdqZjA0ZXk2U2JCdXpkN3NLSnJzLzR5UnlvcWQ0?=
 =?utf-8?B?d05aL05RUi8yK0lZMzFpRnplY2V2RzlTTFJEZXJSUEZ5R2RPM1MvV3lIUitN?=
 =?utf-8?B?Z1BqVGxFQVY1QlVVOXdRTW5mcVJxNm5PYVBtUThHRkdPUTNiRTB0QzBGR1dn?=
 =?utf-8?B?S3pnYXBDOTJNYWU4eldMaW9Bc0NnNnk2bDdiNFNwUVc5TUxxOFpNZEFYZjBx?=
 =?utf-8?B?UktsdVh3d0RhSUc3QWp0MGY5M2VzM3hOU1daR2hUQjZNQUFhaXcxZDJ5TnFq?=
 =?utf-8?B?ZnlRMlpPcDFZSTl4Zks3S3JTWjNneW1xS2hURm5JT21BczBuczN3UnZMZXNV?=
 =?utf-8?Q?DdtxRdpDiB8PSQP4=3D?=
X-Exchange-RoutingPolicyChecked:
	WwsU+LyKcInLhGXr4I6kXrSehYlViMdMs+Bv3/zqy8/wxVXz9ZG0EFhOzlcLcx2OpDStP+HY6eLMtfJ2lEwEt0kgo70FQ2zAMACNx6PAPfdiypqO6hZlnzSzOqtcEoB/RygAbYDSUIDvMuZDf1HAVf0nvm7KidIkSRg09WM4zwB/c4/LD6EbwRWw/wbMByGE0uz3FoT/QyPjaLYuUWV+rmg3a5NNTxayx9NIuFBYCvFTWXrGov94vIsXCEjI3qEL+5fOO4+LHEBF39od/XpwSDY+JutLwBiTjA3MjKcZlao2EB2g/g/XsJEPj/xG1VHeTvXtAUvAtxHyRv4pQ4NyzA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7xOPsIPwtHfBkgbZW0wqnwKyKrR4MiNdfN8wl/qgkIt3y07MWPyHTneahWr4GuuB2KZX9nk3lsJLWnzE4B25hTiR0QaUeZom/8DbPeu0m7WV/9HufVPWAOQ4tl8qhw095zuXgYmsfldLOP5U9D5Qv3hEEi/tkxqLpYjfE4cBM6HcuXk3kXHhlf5E8zz4Iui00DKPyTmLtZVsiX+p4c1/J7/FOv8H/0bTMNtuzos3Mxbr2y7MM71b0fPg7zSlPsR/0GU4V4metA3/OBsmDJOuasD6IAeLIXygB+3jy8qtN/Y7yqbARKZH0bpJ2gRFx4IHF7XWyxiO4T+2GHX8CwsY2oZMryQvivdLRMOTjiOGUThjBiursZ4srS670+Wz3xp8BjT4fVdVqLINrPCJvM4qX5uCdIgPuytf9zqfOyF9CcJ0codsFnZeuBIyi2WQ0cUs4oNFB4trvzHOxOXSuRoHkaykzJZcLoMs+/MUUZPRMB2l/1ifwpU9WyjemXLCIh3jqxp4T1f+t/uvRMaYFztbNyknBP+rDAI5u7sxMi3OTgYO3aVbGRXasHYS6tR1V/GWqtt6k9yvqB2fabIVmQWAH1XpocNGHBLBVPjBrDK4eec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f313c4-7363-49f2-9e42-08de7df2ec31
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:45:43.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5haY4aovN46VnJAnSuE0wNE+ZizXnQLtySUKMDUUyhS50gHkTKbByS1QnOkojJ2JLQopqqaia+Fn+YHq/9jYd7RItZW2ypkrstuYXsDPCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090142
X-Proofpoint-GUID: CeNzJwNhyw2O6QiE5lWuf4nyp54xpXd7
X-Proofpoint-ORIG-GUID: CeNzJwNhyw2O6QiE5lWuf4nyp54xpXd7
X-Authority-Analysis: v=2.4 cv=U5efzOru c=1 sm=1 tr=0 ts=69aeeb2e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=uherdBYGAAAA:8
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=WhnQeso1W3NqwE-DJrQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MNXww67FyIVnWKX2fotq:22 cc=ntf awl=host:12267
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE0MiBTYWx0ZWRfX5s4/H9LISNqg
 RzGRG7IQh2CAZwKZCgxpoaUt0VSZmTrgZbCxopt+WgWxQoxidBZ960ygKYmzsRb1n5y5aVLeRRF
 8/51O91YECyBx+IDxJv+410TPdSsQReAXOhfUWvpwqz9Mw1xT60u49QLirKEdFXCry7tdqKb89K
 iUp0VuuHZy9DoHbUKRo8WcqAo9MOprfx0WN0nrk4P5lzU2mE3IleqL743m7f80PVtKXAAoYMLCq
 pU6LqRy2/evWoyDjWuMZeLYmTZQLRKAlGFnv4jrpvGmonit3VckQDHJWgfnVP/QEhT9VrelYhYe
 tX41+XE4t4Z6NNj9LxWofZREhp5hxyxCsTr1672xduy7m/LLitiAmxdpLUubhaO61EgeFQeOx23
 U4yhm5u3RjBrrK6KoP8ewm9iZo1jM5cT0eQ+wQAmQQH9IVtQJK1QVYMxxeH5g5iOix8Tc1+bbBF
 B6fAseZVZ9peIN8kjrtI2e/duHOIgVbtnCr8x3F8=



On 2/19/2026 9:12 AM, ALOK TIWARI wrote:
> 
> 
> On 2/4/2026 10:42 PM, Maciej W. Rozycki wrote:
>> On Mon, 8 Dec 2025, Maciej W. Rozycki wrote:
>>
>>>   I've figured out that backporting will be less intrusive if an 
>>> update to
>>> use `->supported_speeds' is posted as a separate follow-up change.  
>>> So it
>>> is now 2/3 in this series, after 1/3 comprising the original patch, only
>>> trivially updated.  Then 3/3 moves the maximum link speed determination
>>> earlier on for an early exit in the PCIE_SPEED_2_5GT case; maybe 
>>> unlikely,
>>> but essentially free now, now that we retrieve the speed anyway, and 
>>> makes
>>> code a little simpler yet.
>>
>>   Ping for:
>> <https://urldefense.com/v3/__https://lore.kernel.org/r/ 
>> alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk/__;!! 
>> ACWV5N9M2RV99hQ! 
>> OAfq9yiKnpdaetDotJN22sQQSGBYwwgga65vyQgENCufGjXofXKzxK_fIlCshhI- 
>> _EDkeOuLzjgvx4I5zng$ >.
>> Re-verified with 6.19.0-rc7.
>>
>>    Maciej
> 
> We’re waiting on this patch. Are there any updates or plans for it?
> 
> Thanks,
> Alok


This v2 patch series looks good to me. However, there has been a fairly
extensive discussion on the earlier thread linked below, and we did not
reach a clear conclusion there.

Hopefully we can resolve it soon.

https://lore.kernel.org/all/alpine.DEB.2.21.2602252156250.34294@angie.orcam.me.uk/



Thanks,
Alok
