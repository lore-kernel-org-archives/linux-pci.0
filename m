Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953431;
	b=eqcd3x13hkyXVvUDpCdBJ103QMX6CBnhP2qMLtoWVHw5n5YNSQHTakil/sNlLsXTBTfy
	 vTEQ7NvshbL7MskEkyA/uxHdUA8ap4toebMDBQzfdW5Roq4ytOMzPvBOj3Veh+mis2uIo
	 0u7Uqf907xUSXcd7nE8vHmXvc6LsojRbG8/PJoGaDQfloJ5eKADNEVNX819uId40HSFJ8
	 3z98ZyCplWuURsamsS8vhiy9IQo2+I3vE4cL2fQlAUK7j+raJoNyKaSuTTopYOEWsAPGo
	 tvVfDmkMZroIMTg2K0M2II4SmGz+kNGIKPNxWeXPGiQn7uJD/SvLr5XFcqz1uy5A6Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953431;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=clLknSTugmcNLolS/Ma7g54pX3B8g0LK+fK5oV6evpY=;
	b=3pvTofSxBETFNz8gY9YjEyKUbwSrzHH5ySJUFQTRFq0bS8JMSFdB1Wv0RnMmHnqV1nvV
	 j+Tt6dYDp/Evdc5L1QbiU1dNwqScNRUqoHntZSkjFhe97UiIZ6/q4iO9Az2y6/rwpukxk
	 BxBcrb6SlyjnKNRMJbqDVQyTKsRab0Pyt6vvpwPOlLUa2q4J0R7i3rrZxyNyda2SAiXRW
	 TukEdmRupJJmge0sJ8QPVApeT6+F73Rn0pFzA5mRACS7+vXWhzRjHujq3KUOnqqRdyC7f
	 308Htoa59N8tUcbUbm4y040xATdvoPtYjMlBTNrRIrg7IpydKIg3jtLSzSiG9IpmwdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QtgweM7V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.11
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FD606A31C;
	Tue, 17 Nov 2026 22:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QtgweM7V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOEoGS5KkSrnaZ+ry2PqVc9cxNAjUekqNCURsgnS9jgnPDlJV2mfz9WG5GUEd8UCqionjLtOPxARU6kDmVNDL+OqkmZAuR/f6pUIpxVEFizQDnUH7J05ttOSAPvVNGUUYeqNxrGiA18GHSwBd+oOzYuWX7/vSJ4L955p+2IvYjoKjmTasPcNa5ceBSdy/C3g+UyuvdIitZn3j9/D73VNnzpd4+7+Z7jk0cZm26uhNO6aLfIeoKIAJ097Xbp95q9eSgv7E9/sSFpUHzsiFXawmupsOULB9eNeqJsW77Xtujayh8+/lcQJ8b+ImYZ2WtJ7yedyLPo9h6K606l2/aRdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clLknSTugmcNLolS/Ma7g54pX3B8g0LK+fK5oV6evpY=;
 b=bBto0in1AGaHYdJVP2SdHLGuqaT0MoHGQV8KWUeWFCCdTBwfx3eOWtI9r7Mkbg381OTttZzdMd9QKJ3G/m58LSr24b/Irux9w2dhpr0BQRcjvJJ0BKG3lFkt8p/Xn3Fan+GIWlSv7vmDd5/CybL6rRDYimwVpIMISd8zThDXE05qp59ORsLz2qexh73y3b5OtLaYmS+1bj0/PLhBhRFDNqZ22YfDWhq3gAVNWL9+bOHwJtD1PKj18rsRULTKooCUVT903v2at+45mCgvo643Y+Ff9r29f7L1irfGXdFtlbRmtQOUGtpGLmOFQCvLHYJsnUaROuAp5QYsxzFadsPR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clLknSTugmcNLolS/Ma7g54pX3B8g0LK+fK5oV6evpY=;
 b=QtgweM7V/XDp1hV31WF8aKsftaSfOe5H+5BP1/7eHQx5yagl7qz+nD3/euU/yLXT0Bs//M139JLqzMkrg9Q0op79OcMIfyCBTYrmN0oSdklwxOGZzZKbMwv7PmlfI7DtRseGGjoWyXTNQmdL6/1HlzaCL5a1SHMX3xJBmdcHUYQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by DS7PR12MB5981.namprd12.prod.outlook.com
 (2603:10b6:8:7c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:10:27 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:10:27 +0000
Message-ID: <44b0ea6c-5fdf-4b78-a5d1-43b68a715cb4@amd.com>
Date: Tue, 17 Nov 2026 16:10:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/25] dmaengine: sdxi: Start functions on probe, stop
 on remove
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org,
 Frank.Li@kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-11-3668ccc7aab8@amd.com>
 <sashiko-outbox-196576@kernel.org>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <sashiko-outbox-196576@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:806:f2::12) To CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ce93f1-c694-4eb9-110e-08df44f795ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|4143699003|56012099006|5023799004|11063799006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YvKpLxiXWxlhknWj1RcoV0glfrfAFoY3z/yQ2cPULeADSgVpC4fcnIqlhV1/SClVwn93bB/Ltc4QI4A4bU8F3ohdC6t2+5TrZd/AmVsS0EMlIzndvKn5S/MMqclXeXXd4exXUIcTPLWCUuqyUM/bGdPAhaUOzVUzjfGYLhJ9L0BBpsIjuFLRJ/E1Q9bZlgsEmwUydtUZa44qWc01xoq6JNKFFC9K95uS9ps3ZTEwHm3c402zHV7zqtDoJzhWWyQZdS/IhC02KxQEGgb01Xsh7C7IfL2zXMKTGcwqYMwjy3FhAnhIBkWj0CReGM3rhWRcegCIyBO33HKyWswU1M2jmj5CnsLtu8N8xpjr84MmoGMzeppI7cjindPwxHSx1lev9w4h4tlru3JodXFoFMb9JRWjRqT7BfU0meAv9Ut/SGVqgT6tUH0XprDeOL81M2FwzZh69wM453Y4jxaRHADT8OezDScMHw5syqyqQTG1xvNqFAZzjQzvjgxOpffp1/UtSLRE8QmJVgLuCn2DSUVO6RdFPO1a71LYZq1Xb4bxPaQNjWxngVQ4MjxwNZ4vm75oeBLuntLLhlGs/U1pn2kiFrDjJov88eHgbB0bdf7CjMvMod7kKwLFa6zMOgYjibqNA9ts6RUKA2UKkRw7xcorRDPPJAvbQ9cXsYpOiRQQlN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(4143699003)(56012099006)(5023799004)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGlEOEgwc1o4d1VieEdUV0JvNlAzRSs1UkxBakg5eldJdi92OGMxeVkySVBo?=
 =?utf-8?B?Vml5M3BQQnFpSXRadS9kZkhQUWxtL1RRbThQS0M4RENwZVQ4N3VNOHpGN3pj?=
 =?utf-8?B?U2t0VkcwZVpSU1hBN2RvcGNKUFlQNUhhY0hXVzMvS3I1NkU5TDErYjJaT0hN?=
 =?utf-8?B?K2JZelRDRERCeUtjTFU5MjdYTzlEdG5WOGdyNEx3djlkakp3cFFvOHovT0lq?=
 =?utf-8?B?VG9hOEJ0TmI5YkRjbXdIL3NOV1dqUGpIa3NOZVV3VTRGSXM2UlNOQlNpcG94?=
 =?utf-8?B?cWZEalM4Z2RoWEpQZEZCMzV0SzB3bWRKZWhZMWF6TnNBTUFzWFBBZmJJRVBy?=
 =?utf-8?B?Q2NUM3dHSjlpL0tvaTM3NldGZHVvSWhKR01oNkQvUXVvc3pzMytIKzRlcnVw?=
 =?utf-8?B?VjZtcXZOekxPL2NJZzBaSGJCaWQxMmUwNnVjTXFZS3NNc0dNL1Qrc1V0bEc5?=
 =?utf-8?B?RWZodFhTOWZ2SlFjZWhxaGZXbTV0S1V3YUxsTlBDNDJ0c1RqSzZjakNRNCtL?=
 =?utf-8?B?ellRci8vS2toVWFBcHUwY1g0ZVFENkdGTWx5ODdIbWhwOW5PZnlaRTNOakJI?=
 =?utf-8?B?ZTBaY3hFNlRQeGZuTnpRS2JWb3J2dE1BNjdDM0FyamQ4eUpWVG8xeGNGZTdk?=
 =?utf-8?B?NkVUZndjN0IzZlZEY1NxbDRpQ0YxV3dsdkdMYVlqWUlKQldTcFhaUDk3TXQv?=
 =?utf-8?B?Q3ZCSmtOYzVTTk4rdVB0WGFldEswdEJldGlrSlRuM3dQdXhnMCtUU3QzWUxk?=
 =?utf-8?B?ejlGUSt0c2xmWkV1cW5qdGlWeUJvM0VxYmJHdTkxdFBlQUE1T2IrcUxCWGdK?=
 =?utf-8?B?Mm1KYXZUeVFBUWJWajVrcmU2SFd4VDViRDF2VXFla1BTODRQYjl0WCtyNEhW?=
 =?utf-8?B?VUNsWm13T0E3VXlzMlN4TlBYaGphYUw4L2h0OC9jWFdtMHdWUHhsbWI5KzJI?=
 =?utf-8?B?OCt2TDBPRHRPVkNUaVEzRndkbUkxNFhUM1VIVlhDeGpsVWx1QlQyb3Z2Z1RB?=
 =?utf-8?B?ckphMUZGakZhb283b3djT1dUemwyNDJaY0hjVWVQSUlNSVRVUEgwN25saTNt?=
 =?utf-8?B?V0tyL0pDT2Qzclc0YVZNZmFpaEtESFE2RlZaRlpKMEVEUFB3SW84cDRMeDJo?=
 =?utf-8?B?T2pUVFJ5Ylc2OU5za0VHWW95V01Oc0kvc21rK09hWEdDM1owZ1Q3S0MrN1JQ?=
 =?utf-8?B?bjdPRTVncXZmaGJrMkFtdCszYnZxcGZvZzhUa2w3aVhSak8wY2ZMMXhvay9U?=
 =?utf-8?B?b29hdjd4WC9BSUMyRm5DQkV1S2NpZE1tY0Z0dFVZdzFxVlNVaUorVkxSV2tl?=
 =?utf-8?B?Q1FHbWl0UWJWZ2FQc0M0RXh0TGJVTmFXQ0JhTUE2bWNZRjc0dlRHR0tuZ0h3?=
 =?utf-8?B?NkhhRlY3cDZRWEd1MGE5Z3krVDd5TDRSTG8xWis5aUE4djZxRHorUCtFczNT?=
 =?utf-8?B?ZVJZakYwWkd6Q2Nianh2ZFFndlBJL0M1SUxIUnlibHpMb3BQcDRGZHZiRU8x?=
 =?utf-8?B?cEhBbFpvTU55b0JhV0IwL3pSck10enF2eXNtaDdhU3NnYjJwbkNJYy9Zcnhh?=
 =?utf-8?B?bktVSzFVaVBYYzQ3aFNHRDJGRFlBc3NZQ0VPY0lCQlpuTGdVTm02S1hreEcr?=
 =?utf-8?B?czdLWW5QN3FsVDZXUTEzL2xKUFVXYytQR0ttY3lOc3A3N2wvUXJOaWI3UnBw?=
 =?utf-8?B?VzlRdEpaWVNKeEpFWDJHUzE5UUx3NlZubk9lUGhaZVA3RVNqV3VMbCtPZVF5?=
 =?utf-8?B?S25vVEVOcmxocEpobmZYdy9iZzBmQkE2dGl4dVJsOGlOOWw1RU9kZTczWHIw?=
 =?utf-8?B?ckVGaUpSekxDUWxFNzhHYldCUUVydVZhUjZ4WCtXeVcxU1lPRmxhcWV5blRL?=
 =?utf-8?B?bURDRVBlbW1IeXhXKzVxUGZKK0hZb3RLZ21JT3BTZHNhdmJyTG5MSkNSWWZL?=
 =?utf-8?B?RXhHWlB0K0V5enNST0RucmJYbUhIbWcxSVhCUWh6bmdWUnA2bDZwL1hFNzZX?=
 =?utf-8?B?R2hLV0FoT1o1L2NSKzE3U2dkZVNmL21NM09iY05MOEdrcTRDeU9UZjJpVWMx?=
 =?utf-8?B?NU1HVjdXZnp5UzZPa0p3V3g4NnVVUC9mazAvbnBrRHZ0SXpvcXRmd2NNTWZR?=
 =?utf-8?B?bmVPMzhaaGUvR3BIMnFKalQ2M2Uya0s3R1hDaFY2MGZNa1NTd1cxNEdJb2Zk?=
 =?utf-8?B?OFFpazZsdzNjcXNCa1ZHR1pUZXkrMDg3RDFlRURaSzZRengrSFpFMlBkcWdn?=
 =?utf-8?B?K29uUzcyVnpTSE9ZWEJFeVZkVTlRYWFwZTZxa2Jmcmx0OTdpTTBoRmYxODha?=
 =?utf-8?Q?3AWWTahlKjcjPZRF9h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ce93f1-c694-4eb9-110e-08df44f795ca
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:10:27.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ap+fLCRVrwxCovjwcd4iM/l/VIiQsPNmvCIllkRNTYc0DSXW/y3W4l65Vs0WSD0LkPNwPsQEC7TDNvvgYePLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

On 11/3/2026 9:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] dmaengine: sdxi: PF stopped before pci_disable_sriov() in sdxi_pci_remove()
> --
> 
> commit 44d5d7973859c1db8741ba90d53413150ded9a60
> Author: Nathan Lynch <nathan.lynch@amd.com>
> 
> dmaengine: sdxi: Start functions on probe, stop on remove
> 
> This commit activates the SDXI function during device registration by
> setting MMIO_CTL0.fn_gsr to GSRV_ACTIVE and polling for GSV_ACTIVE or
> GSV_ERROR, and stops the function via sdxi_unregister() on PCI removal.
> 
>> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
>> index 6a293db69199f..d196ab5cf6f1c 100644
>> --- a/drivers/dma/sdxi/pci.c
>> +++ b/drivers/dma/sdxi/pci.c
>> @@ -99,6 +99,7 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
>>  
>>  static void sdxi_pci_remove(struct pci_dev *pdev)
>>  {
>> +	sdxi_unregister(&pdev->dev);
>>  	pci_disable_sriov(pdev);
>>  }
> 
> [Severity: High]
> Should pci_disable_sriov(pdev) be called before sdxi_unregister(&pdev->dev)
> in sdxi_pci_remove()?
> 
> When SR-IOV virtual functions have been enabled via sriov_configure after PF
> registration, calling sdxi_unregister() first invokes sdxi_dev_stop() on the
> PF while the child VFs are still active and bound to their driver instances:
> 
> sdxi_pci_remove()
>   sdxi_unregister()
>     sdxi_dev_stop()
>       sdxi->bus_ops->reset() -> sdxi_pci_reset()
>         pci_reset_function_locked()
> 
> If the native MMIO stop sequence fails or times out, sdxi_dev_stop() falls
> back to sdxi_pci_reset() and issues a PF function-level reset (or clears bus
> mastering). A PF FLR clears PCI_SRIOV_CTRL_VFE in hardware and resets all VFs
> underneath their bound drivers, and pci_dev_restore() -> sriov_restore_state()
> then re-enables PCI_SRIOV_CTRL_VFE with uninitialized post-reset VFs before
> pci_disable_sriov(pdev) runs to unbind and remove them.
> 
> Calling pci_disable_sriov(pdev) before sdxi_unregister(&pdev->dev) would
> ensure all child VFs are unbound, stopped, and disabled before the PF itself
> is stopped or reset.

I've looked into this and consider it valid. Will fix in v5.

