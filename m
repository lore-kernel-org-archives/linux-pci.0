Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5A3EBF1C;
	Thu, 29 Jan 2026 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769662710; cv=fail; b=eZbXp5j2al7MaGukVm1+aDFS1nqZhaBdNvWyUQrOMaWzwIVNCvdEDa5fxAPRaE8i4kNyFnYACyymvRHKQoMiXnFaVmPlv6Y98W/ivn7PtRwLrWnEibnJVOJ+hkU2f5T01W024JU4Q8iGGNfr9oEWdrWthailfMig+4uDF2s2t6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769662710; c=relaxed/simple;
	bh=1HHZSoBVfqOKx7VbquMI/dYRgOK5wy2hpaqTbE25ogs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o/+ahbVuYGNqrkQD9Z8EFdHo/cajhKzr7qnZEQML4q1uDxn9PKKcWv+TlknZtvMa4X5TZ5BDs0+IZ2/n7JxQbK/4SJPfPLsGAg0VLxHSoWFYUb2S+wLonOOMf8DrsoSFhb0pqlwkiLDq83z+A7Ow4DR2S6gdZ03ZRAKna2epB+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GWcbai4X; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GWcbai4X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIqCPX3hYEVkENUDyjAkLvlcqCu7zsHU6cSNPFkZ6GwgxSl5ynDSzz31gYc34QP8H34cMt52Yn7fu2jXA8H/2A1fqc1Or862yN0m2fr5keYculkVqcSwhWgNCzlovcpJRa+U5NxrIGIqVhEEjcyn2eMTz0Ww8rH+cAT+eYr2CuC+FRBW2zMKM2/GLbE6RtJVHLVWg2liRb2/O7wpC9iuCbFbtq3EE1ZicDzoXH8+7dbTcSa+GuuxtudOfDTsidkRYhpEGN4AQreEzXPze0Dx/g2K1xixc7DF6tg02MxC2oNgKO4dQVpIcTf6k9YcdsEsrUa+7irwiWJISe8u2p+QdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGFzU6pPnJMeTAhupJuZ02nnZLJNvGW56qfAYy3Su0M=;
 b=F8SjxAoQXRXWQXiDJFPoPX6Z6M5oqlBjLYNJyeokBr+7OeQqnVDVYRmu0PRK3qWRVg9DZHCiD9+Saxi8HiamBUZ8Hsls2eTbAhaqk6PygqOxDfSm9bp0wjIfugO8yIFqpMpvwhSrkmhgcVxBIBcSxFGF1ggIgEFHm4a+Ddln1ayMLdctH38PdV9ayZc83oVxNMxCNEjHRS5orsKeT3EhDjZuKXv9CLIt9cbslLG0ox9/705dkfUCmbiZeYO6tT6popb+xsteN4/PliqMclnHxhYaKwdMFhfWKs9oHi8LlCwW9iPqJumuAL3T54sxxuuT/bu5AoQ6x4uB9gZmMo/Oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGFzU6pPnJMeTAhupJuZ02nnZLJNvGW56qfAYy3Su0M=;
 b=GWcbai4XRv4jEqultlSxGklsHgvskjFM+PFZhGX+P37AvRD26SklLDmNK6Y3T4br87/6XhDx/KrDd1x/eOLZRYvBzTb/to7BDj0wAG4PdSib0hz7FM+0xYL8+O7RvzPAReXNnmznJLaf3VNlzUz8DTE6QIhrCDU/cw6EY/5ISGk=
Received: from BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13)
 by SN7PR10MB7046.namprd10.prod.outlook.com (2603:10b6:806:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 04:58:26 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::30) by BY3PR10CA0008.outlook.office365.com
 (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Thu,
 29 Jan 2026 04:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 04:58:25 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 22:58:25 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 22:58:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 22:58:25 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60T4wKKo3155901;
	Wed, 28 Jan 2026 22:58:21 -0600
Message-ID: <f7076d4d-8def-43ad-bd54-97f8f464d3ff@ti.com>
Date: Thu, 29 Jan 2026 10:28:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] PCI: dwc: ep: Enhance multi-function endpoint
 support
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<xiaowei.bao@nxp.com>, <gustavo.pimentel@synopsys.com>,
	<linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
References: <20260127085010.446116-1-a-garg7@ti.com>
 <afcd6jugzxcxt44ock23hqrotiyv2j3jpofembuper6v4php3p@q5abmqfrku2t>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <afcd6jugzxcxt44ock23hqrotiyv2j3jpofembuper6v4php3p@q5abmqfrku2t>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SN7PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b9af60-37ce-48d1-8e47-08de5ef30956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekMxNmI1NS9QWnp0Wi96bGw1L3lPY1B4YTByc0FuMkUwek5MOU0xZ1hFem1C?=
 =?utf-8?B?amRHajdUdXE3TllwZHdXSVp1S3JlaTVwKzhrem9ZYWJ3TDM2dHU3M3NzbFp2?=
 =?utf-8?B?SWNGSHNLdGMrY0d0VHpGZXNRbjhZMnN0NEZ4QWxmYmE1b1BySXRpaWxvM0lL?=
 =?utf-8?B?d0lSd01Pc09Vd21RWnY0RXVLZm4yQ1BqRkZoNGhMTkRlY2luL0xOWHN3ZHFi?=
 =?utf-8?B?QXdyeUcvbEUyZ0RoYUtKbUFGR3EvRk1ZbzVyRVBKVzZGTUNmSnB1SXF3WXNK?=
 =?utf-8?B?ZG8vUUM4OEJyMUw0Q09tZ3MzQWNzQldUS05aMFlnU29FZXQ1eDh5WGJwNWV3?=
 =?utf-8?B?OUlwV0p1MGZhVnpMbHdMd0JjanRtYTY0ZVF3QXh1emRYMjROY0hsYUlWVDZu?=
 =?utf-8?B?WHVvKzhvT3pKb2dycll0czhrUkkvOTZiMktxM2VtTWNFY29KTXJpNXhZTjk0?=
 =?utf-8?B?Zmg2SGNjd2YraXJpV21jY05SMW9kb3MvUzZKUFUrbko0aGNMdG1ISU00ejdw?=
 =?utf-8?B?T0M1ZkVHVEx2TjlGeXY1WTZCcUpIR2cvZTkvOFNkWFZISTUvb0RVeXcxa0tt?=
 =?utf-8?B?UWNQTklSY3ZsVFkxNG5QYzBLK1pnc0srUDRkQUdMV3VhQWNqU0hLODNMTW5V?=
 =?utf-8?B?elUraG9oajRqdjVYU0xhWVgxN1FyUDlVSE9MaklvdzRmSVNTUElNdHdQOGRG?=
 =?utf-8?B?ZkQrbUVpejBOZXVpWHBlQjVyQ01mUHNOOEV5a29LRWVXS2FQUDFqYVY3eWVP?=
 =?utf-8?B?UFhzM2tMbVJSekVndW9kM3pnWFlCaldZS28rd1V0VWtOMkZmMnh5clRTcFFD?=
 =?utf-8?B?U2FJaXBXcGZwODZWUDcxazNzb2NQeWh0ZTJjZm8xc3Q3OE5BS3hBMVVhUTVa?=
 =?utf-8?B?Tzkvb1h0WTM0L3p4ZHdpeEw1dm1FcElpUjk3NnZQWGlMU2RQVG1OR1ZQSURE?=
 =?utf-8?B?WTljNFV6VU5Qd0o2eW1OcnR1SGJVTDJndHk0T1I5UWlkbWNNR1llaEkweGhS?=
 =?utf-8?B?UmVVV1lubDRkSmRLWHpTY2NsemNjY2VrV01TWTM2YS9WSkU3MFVLNitQOVFE?=
 =?utf-8?B?UEZTK2t4SXNsNnVRSE5hcUIyaEN0OGRWeC81TmZMcUpMTXREblRUSUhFT04v?=
 =?utf-8?B?Qnd4djMxeVVhMlRuWGc0WXFaZVgvMEl5QUp6b25PTzRTNVRFbktDN3ZEdDNU?=
 =?utf-8?B?TjZYNmhqWDJpMzU0N25DTE9ObW9NYUJKMldHcTFOQ2lQcTI1MkZDNGhvaWlv?=
 =?utf-8?B?UXpDaThCemdLNHZoRkZnNjl3RDEzYUt5WUovMTIzcTFWQy9odG9ibzArbkZG?=
 =?utf-8?B?TSt2d3JxUkFJa2NyUU1jV0U2U2VPVzcyNC9jaCtIcTBvT3FtZ3M1STZra0gy?=
 =?utf-8?B?ZnNaKzZ0S1krM1pTeFNkMFZwQWZESExtVkdwUXdUNW1JTWFGNm5NR3BiVzUv?=
 =?utf-8?B?WFZ0L3lHQlZhNzM1Z2VUQmRMOHJ3ZkQ1YWFQZEVYTHUvd1ZGckEvM2wrRk5p?=
 =?utf-8?B?MUZMUThNektUYnRCUmVKNThEbDRHWkMxMllkRjRKRzBNM1prL2lyL1BKZ25T?=
 =?utf-8?B?RVdJdVhCcy9xT01zVXVjQmtWc3QveDdoejVSeGVRSDdIQzZnM3RVamYvcXNG?=
 =?utf-8?B?WDFmOXRBM2JXR3ZQdHFZdkRiL202U0pNWUl3MFR1OFBoeWQ2eGpnRWFiaDJ5?=
 =?utf-8?B?WDIzdUlvckJVT3FyYlZVK1d5Slo2K1NGendSbDFsUjBwbXZ4c1MwTVJzR3hh?=
 =?utf-8?B?b0d3eFB6blREdDlmWS9Ga0NHT0ljR0xUY0xuSVZDZkcyUVVSYitjc05aYVFQ?=
 =?utf-8?B?SzNJTWpIS21rWVdmcUFFWFYvUVNISjA3V1JpQy9UVWtzTkQyU09kQzdLNEo3?=
 =?utf-8?B?ZnV2T2x3UDJLQUZtVXRUOXBXWWVwb1dtMVlVTG9NOHNOMGdVRzAzMkhSM0Na?=
 =?utf-8?B?em5ZdE5aaFlKemJReXlKZ2wvMnYwVXhuenRCTFZGa0xQLzdTN1k0UDFxOFJP?=
 =?utf-8?B?bHZlREgwVC8wdGNkV3MzZW9pb05rQU4ycXg1bjRaM05FZURDZTVEN3B4aVFK?=
 =?utf-8?B?bXV5VHpZdWpHTjkvZm43Nkp6SlNIcU51bzJhZ2dKQjZEemtLYVJNTW9qL2JV?=
 =?utf-8?B?M1FqSlc3bDJWQjdnODg2bFF5TjAweWxsOHBSeU9zdzk3TlFxRENDN29OYTlv?=
 =?utf-8?B?L3ZtN1VsT2ZZV0VnRnRyV0thams3ZlpLWFc1ZDV1TWRtMHdwS3FBWmkvMyta?=
 =?utf-8?B?S2I1Ync3Y1dxbDJFb1NEZUFwSjJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 04:58:25.8643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b9af60-37ce-48d1-8e47-08de5ef30956
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7046



On 28/01/26 19:26, Manivannan Sadhasivam wrote:
> 
> On Tue, Jan 27, 2026 at 02:20:07PM +0530, Aksh Garg wrote:
>> This series addresses multi-function endpoint configuration issues in
>> the DWC PCIe controller driver. The changes enable proper operations
>> for physical functions and enhance the multi-function endpoint support.
>> 
> 
> Can you rebase on top of pci/controller/dwc branch and repost?
> 
> - Mani

I will post a v4 patch series for the same.

Regards,
Aksh Garg

> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

