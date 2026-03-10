Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACA34C130
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112006; cv=fail; b=Run8hOLU7oY5l4b3Q7smgnsdrKXc2ZvH5QaMqTbQ+SLcON2Z4W/SPrg3pfUq6L0meKRg+lv6D3OgxJLaTm+VV4OsY8SbcijwgDk9hx1bZwybxIftC2JLE5FP+VIISHpG6tDWPxGJSakaxQDeq4bUxRMN1PvBFUDNxS+qlehDgqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112006; c=relaxed/simple;
	bh=pdVnSW4yftvSaMueRIcom/RKqEpBla8ExEXAaxnE/Co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FmNn0NBgwSrf1NUDyTn426gOTY7KjMWZCYQXXlvlhBZufg34UgsD1XQHeca6/IhCnI6qdz9cMhMpcgqwiCrZcfXbnNRDjgc2+OFtwM+s8ks5etRt1rRqg8mssxrfdKTU5pN2dBz44kxLantPOYPbkhNAI00fNBaZFwj1+WbVe+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PNRg+jCu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sUE1Umz6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNRg+jCu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sUE1Umz6"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629IMkmv094073;
	Tue, 10 Mar 2026 03:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C3uh1DSD6+k6DQQONsWYVIIgOImgEHO9JMnYht/8R6I=; b=
	PNRg+jCuKAdh6/EaFI3NnLj5IrNZW6s2FhsRS/tYXqYmprDU1Jfz3oeI+85xLYXm
	KmAZjkuPBkit4X84hNQDiyRlSO90e2H7iysS+JZu4HfdyTucUds9m4nA4eN1CBr0
	6RMmdqBhGK9ANPoJ/+p4MvhzRyHT/tv6AHIE6kCCz5u8a3iS58UJwAZmA3D0JZUV
	I67K+YQp8dwpdD7kte2MH412wPtPIslodLsWl3R6Mvnv/1L65RfXWd1goA2J9SOn
	SrEYqM14lygfFMkY/l2Ut/nEQjMMpXfx4+Ii2XMi0nxkB1dr5Lmhe6/jAOx89r8e
	Wk6PzKNKJoZmXUcw/THU3g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmdkj3h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 03:06:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62A0H5lt039594;
	Tue, 10 Mar 2026 03:06:39 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf9htuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 03:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naHHE1VoOXZLaZAqVH4fd37CQVQUEdVsjAs4zK/CAXCiqo5Xzni+gQoS0t9hHBKSekiCvjnPU4Z89eUecCos40v/hQ6zT5DqS9Ggwuc6DFkKHBPjb/ahSQurQhWiWFKd3hsvYTQfPPpqhdCzZEFRv8QszDGg8SZc7wuiwiTsJIeDrJqJUSs8gt/g1VVRKTq2t0+8U3RGm71U8r1LGeIkfkMN7g7bDV8CMrTP6xMlSiW6xi3eXwYStJwRpvZ+lyIuW7c3CDuKWDg1WHCpD8q3EnMjm+LXUtJZd5fLLkPxordKmSfrw5NUuN7HxmzpDWVDafWpgOG3T+QjJZ7aQJIVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3uh1DSD6+k6DQQONsWYVIIgOImgEHO9JMnYht/8R6I=;
 b=EHNyE+RfagUV3P79KcLAZSDqiim6so+Oe0Bp22BAwT3U5BPQlEv+F87btDwhsHxbi3yDI3EEjGhOQrN/04ge+61AcVSJ4UGJOgcgGetPT2nG/mWga/F/IM7KeCMqlPpz7UDunYSu5Vw6MEK8YvCZ8DroV7Zl6b08EG004Ctd0xSLv+gZwn+TgkQ+6Wjmy68P8khX0LnEDSkk6seGM9LGDFWknKkssGfPXVMGF7PR9nDRsVc+h2opWuepMfwUNaH7HK4265kLbDzwLAawGWkJfZmMTd6Q3WgyBIzOwOw3y3pBABEiz2ZioGG5FIC2/1+M55BwGyS3P+czlbHW7/2JkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3uh1DSD6+k6DQQONsWYVIIgOImgEHO9JMnYht/8R6I=;
 b=sUE1Umz6KbGTS+STBhO2bdoMb7pAAHmfH3n2ZDp/5LLoIhXApBvt1p7QNrcdGSrRhfBrskJAjIhzRn6CGeSudijhgKm6fl1456hixY/BSXWi5gtWRJoZcpwv1osQYgbtHsyCFreq84MIjH6uU+OCvNJVz+dm9vM2WZiRAqv5hkw=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 03:06:30 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9678.020; Tue, 10 Mar 2026
 03:06:29 +0000
Message-ID: <3ad69182-8e04-4a44-99d9-c55e2fabc3b2@oracle.com>
Date: Tue, 10 Mar 2026 08:36:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix incorrect retval type in remove_id_store()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        alok.a.tiwarilinux@gmail.com
References: <20260309222040.GA624676@bhelgaas>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260309222040.GA624676@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 216df9ed-c468-40bd-c26e-08de7e520686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	KRU/t6sUdZvE0W28ixBho8aUec+nfAlHp7bVZYpCFTCKu/QQSrpp1aLYvS7K78nT1/Qm9/1ciTU5wjIkqnGWVNgnBphVPbLlGMmuNuXJ/66WmsP1cAfSbGIT7YhoR4CNz5WZUCZG7Qt5U9Z8i0TtkuoqlDf0qzE8O8K5PiZ7+gneV/3uSXGEvYacM4d+aCPc0rKJg7FDIqqClGc8hQPI+0mEnsEFtqczpNoebxtVx0tyaWAru9dE4SfIrkll2S4yWk2JsABR3mwuWyPUM5cAcxvPu51fHnyiIVieAWnK+h8zawj+/K7ksTlnGYezlAbmhUx0D1ORnLvfTI4+GQ7Tj1KoncP/F9Xy5wTKCDpGygACAou7yzjZR5wl6rQAKwKtN0h7ypop5vKBCgxI6kbgIm1IJVsf/bItxu9vHP488Qg3J1R8D1v+Vb8qU1X6CB6I7o7dAtMp1nnZcUO7Ht6y54ugXrxJ38Kg+5r6FvkwcwYM8FqJdjrKntmuR6VVCJpSnGqEQDOYKfHMpJFZaKUliO3MRuIrlBM/HRxk6z+Hzl1t9ODQtvsAS3zpN5QpIP0aOtHCf7/Mz1sSriZNPBroDhbTouHURQfYixeMXgXx1lw1YlVozm3thm7OErP8cGvXy7iqFv+GFQvkHJT8HV39BjFDwez8uS7lu8kUlwKkt35Mq+THK/TYACy+AZmO4XZ8G20i0cgHj7cE/WLL8cDzxygRooMgYn8qKNP3w72nbwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2xLY0dVVFZLRmNQalNBTExkaUVDMzQxTi9nMzJzZ1VISk1NcnU1bjlXUmJt?=
 =?utf-8?B?YUpLc3ZLa05PRTRKMDVOOFNOVjJTMjBTaVh3SGEvdnRwMWR4RUErL3draXNL?=
 =?utf-8?B?M2FtME5NclhVdWphdTdYR2lHQldQZmpWYjZDRjBCRDBsUmFJMXV2UWZzdVdv?=
 =?utf-8?B?NW54cTN2SWRFMThROEN6U011TmJBdThrRElvNGpkMkQwOHVMZHVBcVNVSXoz?=
 =?utf-8?B?TTRvMnl6U092YStFQm1kaHhGT3NjKzN4Qjk2TlJFNG8xMzBub2IwQzhEek5Q?=
 =?utf-8?B?amNSb3BYaXU3UVZmUWJzYjRvMWpuaFpaVDFsYU1icWZ0eDBXdVRjeVgwdnlJ?=
 =?utf-8?B?dE9pUlhZMzUxMVpGY3JMOHJqR2s4Uzg2NmIyRFZIdFZmdWZDNklkN3U5QkRw?=
 =?utf-8?B?MVRBSy9sVUI0U1hYU1hNSHRhbldwV2NqWWhIekg5VXY1eGxDZXhjZ0ZmYkdP?=
 =?utf-8?B?dUtGbS9KUjl2K0kwTExGOTBUU1pyK0pJcnp5aXI2dTJIenRSNW9oTXAwRXhU?=
 =?utf-8?B?QkhVcGdwejRlOFJpblRVM2pENWpSUW1nM2ZuVFZLc0UzR0FKRG1wZ3FCT3gz?=
 =?utf-8?B?ZHloZFpUWldVc21MeEtGQW5lcFhmODZrNk4xUFp6UUhjSkh6RnNCY3MrVkM5?=
 =?utf-8?B?djQvVEI4QkdydjNjUUZwUWg1a1JXL0hJa210dkNFaGIrbmU1UmFsMGNUcUVi?=
 =?utf-8?B?QkVoeE43SWJqQlJnYzRROGFCc1FWaGZKa2ZNTHVJVEdBY0dib0lqYWU0WGpX?=
 =?utf-8?B?bzNIbDIyb2J0OEFIQzJ0aCt3TjVzdjNrUjZ0RE5qR0V0Y29lSWRCWTdYKzFH?=
 =?utf-8?B?d3lKUHRGNCtpMHNDbTRURkU3SmZLT2dYeVJnU0pUN2cwSmlPenBPd2ttdEwr?=
 =?utf-8?B?dGI3N1k5YnhkK3gxWVJhUzhmcHA1ZUlic0NIS1h2eFl6Zm5UcG9NbUpKR2hN?=
 =?utf-8?B?dXhoRGdXRzR1VXpVVEN0ajhnaXZWQTRXT3l6MGNwek1uODhRZ3RvdmJrMlQv?=
 =?utf-8?B?cXNLMXFDOWRSMDVCSUUyeUsycUVmV1A5KzFFS0o2MXRvNnRMSnh1eDcyVEtP?=
 =?utf-8?B?MXRqZm0vV3c5Vis1STlQVTMzU1R2c1F4YWNUdHdMSFlaTTVlRHBWcVR6a1Fo?=
 =?utf-8?B?dDNwUWtHUXFtSXR1QTRqZ0QrbDZFUk1IQStYeGlKTnk1NS9Fa29ock1yTHlk?=
 =?utf-8?B?T01HanhteVlnd0Y4Qm15aWdSVnY3Q1dkSVl3VnA4QkdlMnpFMHh5a055c0ZS?=
 =?utf-8?B?dGE4enQ2MDhxYk05a0NyTlYvOTdNUjFDUUlBaGNGSDNKRlJtdTNITkI2Vm53?=
 =?utf-8?B?dmtXbkJMRUVUM0hJeTZIbzdDN01meFJudnpuWjFLMjB0VGk3eHl1ckViczZC?=
 =?utf-8?B?TDR2SGJ1WE5BVkZKSjAyQTFPdFl2NitYbGxvRlJxL3QyOXEzTGFMcFhGS1hu?=
 =?utf-8?B?ZThmZllyNFVtSnAxdnhCb1V4ZFI4S0RjU2cyQTVkU1BHV3dadWFtWFpGRWgr?=
 =?utf-8?B?clhEbGgzUXY3ZFBKTEtBSjBFWE96TXlQd1dqdlR1WkgrbnhKWjkrS0Q3RFVz?=
 =?utf-8?B?VHM3NXY0aUZLSDVWZ1NRZ0k1K2lhMDAzUG8xNDdWOFJhc25BaXFEVVl2Nkdm?=
 =?utf-8?B?a0pWSGZOTkRMbTBhWTFCWG5LVmVXRTRHVktJWU9vanlObXpYNTIyVEpGd29t?=
 =?utf-8?B?TWl1SHlLUUE2bHpMMkNyUlBTLzhrb1NpOTNNbk5wMEdaM21SenhzZ3NhUWFO?=
 =?utf-8?B?YzBXTURyWloxYm1MWHllZUNVdHpzQkRXcElBR2VsYzlKREkxQkIzMlFINTgw?=
 =?utf-8?B?TWNpaFpYeVA1RVhJdW9FU25OMmhoWVRRTE5Xc0sxd3c3UnF1OUtaMXNrQjJ2?=
 =?utf-8?B?WUlNL0owYkI0cy9zbTlwQS9KQVh0Qndla0hCNXcvMlhlTWVZanFjVnNEZW80?=
 =?utf-8?B?TDRpV2M2bUFpQUhYZ1hiS2pJQXdrV0RwekR4eWNnQWJVYjIrUi9PNGJ5NENi?=
 =?utf-8?B?WlkxTlVZRm40WVF1dHZWQ3dqZTEvUnNxSkh0ZnFqcWhKRFhQUEdLdnQraGh0?=
 =?utf-8?B?UHlCUTFVNWNTdElHNnpjUU5ack1Td0lSZFh0d1FpQk1nWUJ4azBXV2lhc2ZC?=
 =?utf-8?B?cFFoWmxsSzNnQVNmYzZCYnhLc3VpL3hseVJDUGIwNDZvK0RzVE9FRHAzdE14?=
 =?utf-8?B?MWxkVDN6eC9uZjk4MnRLOG55dTNsNldGZ05pRm1mT1FzUUkwUUZJKzV5T1d3?=
 =?utf-8?B?T3I2c3prcVNsc1ZJbzQzVm9qNXlsd0pWVEo1NmNHWjhjL3pJL1RteUx1d3l1?=
 =?utf-8?B?NVdvN3BCOUdkc1NwMEhNOExmUFJ5UnhuaTEwYWZLRmFQMy9wdEhBRWJEK3E0?=
 =?utf-8?Q?XKn7TbIObBTnfgNc=3D?=
X-Exchange-RoutingPolicyChecked:
	OWOJ7ukMfUlHbzwHNy1HfUv3h0JhFtk7sGbAI52OxzRDUbvGTd+bJl4wKaNYa38uMcVrywnGNpr7g3XiEEvbeW3O02vokQENeliW9u90M1W+2tY23FTtJm9qDWevDtrhpZ42SVSBTKaS4+sCEsVUqhMBYizMPyiiyVu/SVRuGpwCn/y94D7dpkGfzwHqX+6rCkEPwILjiAF7zfNf3JgGo4LrDr5z0HxVsilWEuxoXkBoqz9SkTrhRpYARuH8TP9D8+EAwyGxKTsjiFVAanoTvK98otYYDozsgK8/459xwjlGeA4lubH/ziEZE9QWm5WufCC6kbiPBu2yz8VuHPxV6A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZxjZjwPS/4KjJVovoG8IVomivclDMpkTPQqzMGnD9Ih09gEB/nKAGM4XBck+QdZQJ9nm9o28MQNTol5r0MM+9FhzvTkCmi0wziC581Ax/FNrkRSmGSfddtuwhp70ZgAtx4VRCYttKkGyT/P3aGkiQ/D48lCAMwShWAA1CQRvibkfh/X5IJSshbwlzumomtmtzEhCv/elke6nlj7F2IvxsNY41a96ams+cibKMetgNKOZtcqMDEO0KLNIfC7O0QXXQFvbr0ZcUAgbHHkoUszdr90EHd4yCWMVKZ075B/3SdZhX3m1eSPP2geXgo5I/ZEBfa62pi+RZuUyYqTiLvRmQeiWIwLUjZrri9CW1Hwhcg8zftKHK4Ia2zDvCFMjJF69ZK9HEhxVdpvs0cfWl7pkJvW7p8rdwk9JvwhRomkUHarLyy8fAyRagCyMFv1QnFCAWdSiYLM+XXpbNP7r/WpuJV/lLu5B1KeSzkD8FdAPkjrZI0dpKdWvSebRqNnZqN3kjD8qIe7AZL2qsoJPEbosADK1rOcJCLIVwTeF38yogrKq+sbu4yMIYU3TGwsETeoAQbiYBsvQ5uGzOc2+ypo0fUdhYZJuTf7qS+Z3Q+y7TgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216df9ed-c468-40bd-c26e-08de7e520686
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 03:06:29.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8iQJhoBwTI0+Qo9pW5sVnwzZXWN/NUTXIZ3Z34P0+Mz9dhBjCse/+4RyNi9XeU90Sewb9uH6s8y084nkuPT29sQv8vmxRMJpK/smCIK2bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100022
X-Authority-Analysis: v=2.4 cv=MuBfKmae c=1 sm=1 tr=0 ts=69af8ac0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8
 a=zmLHyIsKeKUPndm2FNAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UR7JClGyYG7aXUdBdDRFrqWwKYlmFLhH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAyMyBTYWx0ZWRfX+F83PPemTio1
 caSGAp5qLe6pSXXYOK99N6M7/Q6wSy6gIlNl/gQsjrQHW90Ne2HIruFhQGFFYz8SNSoAEcNMLtb
 zpyIzYPzowGka64gp+sgF//UVSp0VqpIBkFdAiOCv6xZdyCKGlTSlaauD2tUzZAcqjtu89xfYFz
 axmiwYWQ779n7/U/LvJvQlyPux5m21xHRAbMb1FYvagSkeWJxC3K4hd+hCpbZdFI7bbT/grhctu
 a1nMrPVVeRYtgEIXRbKYllAoEt1ZoZh0l8bA3aQ8jraSdqubqWuLLhxuB77xNIPbn9i34X5tR7q
 KaPOzGrVKKu+DjuPZ9l7ziXvc0ptviYb21GxSqY3LAgOcqEryPz2La3bzydTK16gGVCAHzmxigu
 anVLaloTBSSEX9E1CJlVyeiQVIHsJhK7Bk5e7Y3Byqa0SQFxkDH9QYS7WOb+gcBeT6gV64TctCa
 RADkQMjz0wgMdyMCV/w==
X-Proofpoint-GUID: UR7JClGyYG7aXUdBdDRFrqWwKYlmFLhH


Thanks Bjorn,

On 3/10/2026 3:50 AM, Bjorn Helgaas wrote:
> On Tue, Feb 24, 2026 at 10:14:29AM -0800, Alok Tiwari wrote:
>> remove_id_store() initializes retval with -ENODEV, but retval was
>> declared as size_t. Since size_t is unsigned, the negative value is
>> converted to a large positive number, breaking error handling.
> Does this actually cause a problem?  size_t and ssize_t are the same
> size, so I would think the conversions would end up with the same
> bits:
> 
>    (gdb) p (long)((unsigned long) -19)
>    $1 = -19
>    (gdb) p (int)((unsigned int) -19)
>    $2 = -19
> 
> We have lots of sysfs show/store functions in pci-sysfs.c that return
> size_t values.

Looking through pci_sysfs.c, the sysfs handlers consistently return 
ssize_t, and negative error codes are returned directly.
When intermediate variables are used, they are typically ssize_t or int 
(for example, driver_override_store()
uses int ret, and driver_override_show() uses ssize_t len).

size_t seems to be used only for byte counts like count or buffer 
lengths, not for storing error codes.
So using ssize_t here would match the existing pattern and avoid 
assigning negative errors to an unsigned type.

> 
>> Use ssize_t to match the sysfs store() return type.
>>
>> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
>> ---
>>   drivers/pci/pci-driver.c | 2 +-


Thanks,
Alok
