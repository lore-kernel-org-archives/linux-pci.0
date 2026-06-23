Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF827FD76;
	Tue, 23 Jun 2026 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196652; cv=fail; b=JVCEs639pIqrGkoJOwHhKmg7G8wg5e+vyl4fusUnQlMimKv+26bjyPJG1V3xzL6FjgmQTu7aicceJ6GOsA1G+7W10N7LUbWCUMaUS/0wK2F3xb6Qpc3k9frUUAxOhjjpYI5I4JLIikrSg2ACLI5AJpQBlD62u40vQ1s62NKEy9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196652; c=relaxed/simple;
	bh=bNsbNPSvhV+kIXMF7ipg/Ml+vFBjkup5oVl+zNrCvx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K2r3nusPBdqhFYmLrmNLp34QNMB1rMlLEcknaK4uOOWuPk8sAn6dFEOYFG5CPyFOBxwsaeM7z5Ie8NdF+1pn7gZrxvw5jTGDTte+AyuUOSBhK+rTSQ+4g2E7Q4IYqQLac4VkTRXyaCaZZNtU6WzGAuBEgsdee+6BaCMnnU/w0a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oldvE2+K; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QyX0AgCb; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oldvE2+K";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QyX0AgCb"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N0hqgG2788136;
	Tue, 23 Jun 2026 01:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=LBa1ka+9ItKnIS16Kj2H+z4OnGmVhYCG1fpp7rsP3
	Ek=; b=oldvE2+KBuLP/kWD28u1QLPfLMhc2nhjRpNf9yHMFakIIHhoTPRo1D1f3
	XfGk97fHNAURluWC1XYqTcrHdvTiv29FXdQJiDTG5T8kv2A/kI4wtTfuAS/mRCiN
	6Hj30pzWHETIwdZ9mjQayXerANmdZWkbXZr8SR2Mx6LlwVPjJwK6Khfj0BxvCGkn
	Gc3dEP3cG6F+Rb2kKPGSSRPHxYWq8OLFxdK02RX/zb6lnT/8yuWdBGIX9xO68Jd9
	JTcTcwYeJcH59adM3e6JQrs2YAH2z1++x65XAX/ATF6IR8964vskJaeurGbP3FvM
	NeTLv6URl62TsxowN5e0nesmnKv2w==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	by m0384305.ppops.net (PPS) with ESMTPS id 4ey42xwpb1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:37:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FN1fxP/6KG+jiKo4B9t0DSlhB9RE+8WmuOto33WeiT0vPh4AmixXczQldkEq67qfElN7sUnoVeW+wC5XnqaM1TFd9hLsLTkDdnurooDCdSx5lLFdTBXFX7PAsWoHTJq1UmuJI56EOykB+EOlpNusnRk6g6u8LyoUGW2MzlTJ1TrRlnSuo81e7fgYCzKXC/+n6CGJhZAvbOSLV49s3X/ss68HWfYdCLmHiYFd59yjn5d4OG8/pP01UUnjJflx3Qmn9irxCQCiBWVD7NujFb0nl/HZCE6RlzOtNZQHT4Nb2keM/YIyeVP3API566ZXQnAYyZK10kIOol5vS7cpItjwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBa1ka+9ItKnIS16Kj2H+z4OnGmVhYCG1fpp7rsP3Ek=;
 b=iKQM7fSdMxTRVltrbLF8z8cCwK9vdgVscXG9F3Tiag0S/9PeVUsoq/tKf5Pz7pk43L1/bKQ2v/plS09reCXK5xVZqJRF/UoRWJrdI7KYEIks565wtwEzeVg71tcIRm/aAN024BQyG3oqvT4ayhrbcTm+K+SQBttuPpFI5szL0Pa7mHmotwKVeHuMtCz2q9PTW0LqmcIg7agy2NOm6h22FJcGKp/d7O/Y9HDq3AEQgQrNdnR5vL7pizEsyDvPE25vtoxPq8VYJ/N8K0BVqPl+pTzFGsJjqsN/B06L2xmHaLAGSuPcgOeBTnITFaZrPFxnmZi6uWOm6nmV9TUdxmIH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBa1ka+9ItKnIS16Kj2H+z4OnGmVhYCG1fpp7rsP3Ek=;
 b=QyX0AgCbaipP34tJ7Gv6XxDQ5Eo4oeXAjkdXuAJV2BOcDjaRMH9Bmi6EUtz96pIAoWN0EAtzp71fkjqlHwfGMWAqhI9hTfGZ0tEQ0hVq4udXj9YHI22/YlghLn/CFnp4iL3TqXWyBoIW77gQZ5XSD8w1zT5Vjl36v4q6OfMsOyU=
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by SABPR10MB997892.namprd10.prod.outlook.com (2603:10b6:806:4f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 06:37:09 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::5) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 06:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 23 Jun 2026 06:37:09 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 01:37:09 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 01:37:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 01:37:08 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N6b4MP2263529;
	Tue, 23 Jun 2026 01:37:04 -0500
Message-ID: <c7ff0976-ef28-4056-8fa0-a6a398fa21c1@ti.com>
Date: Tue, 23 Jun 2026 12:07:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-pci@vger.kernel.org>, <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mpillai@cadence.com>,
        <unicorn_wang@outlook.com>, <me@ziyao.cc>, <18255117159@163.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <danishanwar@ti.com>
References: <20260605071922.1724499-1-a-garg7@ti.com>
 <4lijgllolvtbvmzmluuslhkc7empdpizxhva6ysau7kssuqd5z@drkzb5afd4ba>
 <1ad01870-e2f9-485c-9206-23ee6de1d1ba@ti.com>
 <pocwd4v7iqlixcpaikjo6vqmnwsb7rfjt42qvlmxsn6xnvtrpf@zgch2iwu7itw>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <pocwd4v7iqlixcpaikjo6vqmnwsb7rfjt42qvlmxsn6xnvtrpf@zgch2iwu7itw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SABPR10MB997892:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bcfcd4-759d-428f-eea9-08ded0f1da07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|376014|7416014|82310400026|1800799024|23010399003|56012099006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xkt/TqjbuscrjwZVWjj2sirMDR5Y3aiS5km7xk3adF9WOohWCouKz8ZoyQqyKzxSPdvJpeDhKm2PJoVh5WNXkLHk+JC9RurBx/FSf8JNcIofUT4yrndTi31JjPHXo3tnZOdFR248o3i3QFq0Zxah7uMZ1UVZiH0lCrdoHXtySDH4L9YiPWzHHsYiE8M2wbl2oF8ajWsc9LUxv9iKeJbruNtADRJYwUdCanWqPga1AIJVL7JC9973Pequ8h7cOLgNzSIiWPZWS7g3HF9AZS0ucMqu9xtwua92/1N+zYMAJsbvTriuXZRz2Gri69CJgLabBYPhhyml3+tBoa3mviT1iD2udIB4Ucr4rPS/x1R2EHlxMZ6D4+Yj3QbdSbnrlMXrV/YhcvftEN6vVTROhiZD81Hz8UHKx8r8XRj5PZMN7L4yRHPrpkFAcE1K/XnKPZqO3xmi5TBOwTuW5C9mCrKlEzTYVzupUI7uEH3RSfXot+2U4xsk8E9pnFoDzolF+syQXAv3TV+QcU+Egk6f+DOwP2Ocg2eE8vLSkC4HaG47QcWsC2Zupu6TAnhFrSI4gam0NWrH5eYh0RSBIVind0tV6tTqYppd9DMV4khZnm9gDHERRalzGgha+WxH+iUJ52mZIk4wpcY5ENvSkEZrQ8RCfF/7Q0GxDsrrwE/eXO1MQzKwEe3btA3YdXefSxAHu0FbTWiL0H8baEX8AF5brj1p8g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(376014)(7416014)(82310400026)(1800799024)(23010399003)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/1uupzt6e4XdFz7pyAxZHxQHONQH/i6PZFC0cdjfi74OYCPloIccyKdRkzDL86Ch4Zy+VAQGVpF9SZ/0vvQWzp39Q23Q4A6f9KAUaOyypHKjGk7k0KCMIl4XRzl9QSh6ow5qxuCRfqBSw4nkRclJr81PuFxgDXFNrmhRpvbg5rZ/2Xd5t/EKVbiy1sFW8Pstg9OS3cxLNZfgGbkmDWPFIDBYBpZFm4iCynTIJP7EoXpSctwNmnhltc+ziUfGHAHOmbtKBZXSapvMFDuByohBwuc0rsPqc5K9LDYKLf/EjOFxof8TvOHhCys/hmWhqS8Z4me4OQrtRVJMckpl1zkkkkgbivFbYLetz0IypJBI1Nvns2tEeswf6++TS5c9vw/6GsnBIGg8ABtl1ZyuALfVLbHA+3C1muNM6+UmhKmPPMUma7cSzyInrHa3yaNIH5lo
X-Exchange-RoutingPolicyChecked:
	PSgRxvrh2tz7zHJNcvJRwiaTnUZ80f1YcjpUC2QorxJjpXtbGc7KbNIo3/QbB/SkTo6VbiIuC6Z2+Pv5Io4Nt5hFrVLxj8/UMk2cstHcJGZhlgEsEqWoSl4nInIipNQkyGr9Ya8A2cFAYGQkF5Cm7Y2aiO5cKYrMn/F1itVk3scG6Osbx4/0i529blfL5d6ije6z6oZkyYhMzF1HaGPaSSI2c9+yaPcm5TODVhltjOhf/rac5WL6yh0g2cGoWRoDNiIipKR57lbylSaaCTfVgGvra+ZTuN3JhsAucwvzlF9jCXt+eT2ikasBhNgZse/cDRP19fUQaLXTPsLvKr+HwQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:37:09.5420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bcfcd4-759d-428f-eea9-08ded0f1da07
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR10MB997892
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfXxR7cQY1BlFUC
 5n2mtmgP82gZiF+7Fj+38df9T9eLxVKC5kMEgih0ih8tpJjYCShsUNdWgziNtYxairai9CWpk/C
 e+KKuDblTQ7eEnA/lIoCqvU5uAZpEG8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX0lr6Ie1sIUOS
 cKp/wAlCbDK9JziBY+5FpCap8SEHCckdIb93ieBYqeX31KoD1V3f/x0eWudNvrMOG1QkMaXFCUW
 qhBRaq2aU9tI/gjEjQgg+cu+935IJJawC2rHpivdeVO8Fla0r+0GyzA4iOItTNQLaNdxDkGicTO
 EVkpv3JXIzsbydr2h/LQYk3KzZMJZRYE9hWWcvyPbqZvpZhNzCcMt5ElUUIHqazfX9Obq9mU5QT
 COiN0JFNj+4B7sYKSFoKbtZ3ciHdK1XzDWelAupS0o106ikFedk5MUP01qioGovASCNe0IyDsPl
 khv7KaIASELZkFc6/DBC2TRyZU0F7ulLWJ+2ubftaqEPlCIlIvgTTEFBsmOt5r1F7GtHxKVo1On
 nuccZPMyqM7TH694I0IwKvnf5BGpk2bpAZYCFWXpNzIOe8cqmbBrIogZy/SiMt+znNcDZqzstWn
 QLpymsla6ymx84wpvtg==
X-Proofpoint-GUID: SNMorWXdhPU7wArAfpR_jb5aI-OKw8U0
X-Authority-Analysis: v=2.4 cv=INgyzAvG c=1 sm=1 tr=0 ts=6a3a2998 cx=c_pps
 a=skQXzUdJ1yZbsxdDph07EQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=fD8c270C1u_YCLlD5SoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SNMorWXdhPU7wArAfpR_jb5aI-OKw8U0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230051



On 23/06/26 11:15, Manivannan Sadhasivam wrote:
> On Tue, Jun 23, 2026 at 10:53:48AM +0530, Aksh Garg wrote:
>>
>>
>> On 22/06/26 20:22, Manivannan Sadhasivam wrote:
>>> On Fri, Jun 05, 2026 at 12:49:22PM +0530, Aksh Garg wrote:
>>>> cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
>>>> delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
>>>> during the resume operation blocks the resume operation unnecessarily for
>>>> ~1s even when no endpoint device is connected.
>>>>
>>>> Add skip_link_polling flag to track link state across suspend/resume
>>>> cycles. If link was down before suspend, skip the expensive polling
>>>> in resume since no endpoint was present.
>>>>
>>>
>>> Won't you need the delay if a device gets plugged while the host was suspended?
>>> We had this same concern with the DWC drivers and we left the delay as-is as
>>> nothing prevents an user to connect a device when the host was suspended.
>>
>> Yes, that is true. However, the platforms that do not support hot-plug can
>> skip the delay during resume since no device could have been connected while
>> suspended (only those platform's driver would be expected to set
>> 'rc->skip_link_polling) just like what Tegra264 PCIe driver tries to do at
>> [1], where the driver sets "pcie->link_up = false" if the link is down
>> during the probe and if the controller doesn't support hot-plug.
>>
> 
> If the platform doesn't support hotplug, then it is perfectly fine to skip the
> delay. But you need to name the flag as like 'no_hotplug' or something
> relevant, not 'skip_link_polling'.

Sure, I will rename the flag to 'link_down_no_hotplug' to clarify that 
it tracks the link state when there's no hotplug support.

> 
>> Even if a user connects a device (when the host was suspended) to a platform
>> which doesn't support hotplug, the user is expected to run a bus rescan,
>> which doesn't call cdns_pcie_host_link_setup() anyway, hence the flag
>> 'skip_link_polling' is not taken into account in that case.
>>
> 
> This is not about running the rescan, but about initializing the device. The 1s
> delay in cdns_pcie_host_wait_for_link() is mandated by the PCIe spec after
> starting LTSSM and before issuing the config read to the device. If this delay
> is skipped and if a config read is issued to the device, then the device may not
> respond and the failure may lead to PCI stack assuming that the device is dead.

Understood, thanks for the explanation.

> 
> - Mani
> 

