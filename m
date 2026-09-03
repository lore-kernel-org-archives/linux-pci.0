Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012063.outbound.protection.outlook.com [52.103.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262294A2076;
	Thu,  3 Sep 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439922; cv=fail; b=VBOr57Eyqw8v1ahuYlDoMX0IhgvyflKtcuUtvWPmOMp/DLE1S6F3VPpF8S3A7XLzRxeLb1ttR6S/rOZqDnaQxZsWivK4JJjKE3IVv2f6dymrAbJ1vJR37Qc4nM5uDwmrB0Ta2VY9kLohriON5iXL6xbSlivrE4ax2D9L8AOLG7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439922; c=relaxed/simple;
	bh=k/vBSl84K3T/sbiixUy4ZkM1uodXiON33GzVHtIGhLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ab1nmdOC3ze5Z9lhx5JybCDdcUbiepwoz2CAfBL9WUsLkq277eDqb0TfnsNBSlLMiO8thMk1fh/xOALiSZNWAgkMkb4mdCWusPm1mybC4a1oBaM3hpgEv1QFdv1KAOKXPoRG/QKsEYq8M+R71zCurJeHtGRtGc7fLofEs4i8ysQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RRVW/OSJ; arc=fail smtp.client-ip=52.103.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RRVW/OSJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w74yviXlHQtvi3S0AEa+Zd0xJyQCi1LONaRf2Lg8+9jMyzjPetepx0HSUSDt009VnZ7BgDXA+BWEzY6OeeHxH+LnCQfuiyIFmOaq5S2lbHl298hk/j9MjIB8f9l9mnK8SOISjrkvNZ6lZcY1DE0HvgQf/YHvOi86dCHcbQPHqSqOMkmtxrcq9ApIv+DXBaHda6k5hfPxLkbdXhpd9QZWa5d2qMpaqsSzIHev4YaJgYseFbg9iEwthE+08RPeGdOAtiDdavzjFQehsRwJXyxua+TWZbB5ts9gedDvRTHIy8r0enMigWND6yN5VFcpb7FFFqQBU+rLQPsNvwFRcepfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySFSaAbxG7t+10cWXy3sa1jZlzdRrCZ0v2sh8S3QOzg=;
 b=l4uh7bgWSIKbstB0EZFaqsJCb79IlRXmRbGLGmdLHTadsYfPl3vXeokHWXn02mhfjo4IRdcjclyjjg0eHA9gXhv+fV8tq/mQiaGtwbt3IobkbG/erEp/wnmP5Sx0NHKcP/tY00MVdbX6UMHNo+fASonaNMLXcrZxNUoXjUH2SypUSRsjBWw5OyWJiIH14KQAoJXPNi4vOSC+sD4GyI4jl+W7k7Uv5zt0rDE6L40JLupgwo2+5BJkAFDjvZTVVS1CesLY3/oQ2VeURr15C8H2jYNp/jbqy0YMatbr35/NXGkoAFnGc10Em02MKAYKC8RcTos9aabzJHmbX3JzLM2rOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySFSaAbxG7t+10cWXy3sa1jZlzdRrCZ0v2sh8S3QOzg=;
 b=RRVW/OSJDQJ4ryBwCQTRAPkOGdT6NIWwRLOaZiu3VTtqdTKpiMTNLmpONUXpw3XUJmVeOumQIdYbh3jfn83l320eZV3sNzzqxvWsCVckraGtLvGI0Y3DZzky6Dv4xnt7cP7dTtOaoAVxYcyPuRWQc4QYuB0e7mDVORYSJ4Z0ZiYCknFWXYqB8kPVmJZIRTizld4sGOK0oWrMNIzqir0QAG8bR/GIwHRtWSKrR1VggNpi1gHqUYaqmZKzW9LX0ziZFWBYIhpaU4W5KSXmAzmDTIyAUBRulu+ArtN/X4x42a2wdHl39wEoe19k4SLoPm10giG1s9AJGdaXveCv3to+2A==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SE3PR01MB8361.apcprd01.prod.exchangelabs.com
 (2603:1096:101:31e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:51:55 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:51:54 +0000
Message-ID:
 <SI2PR01MB43931049C52CE0D4F1A0186BDCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 3 Sep 2026 20:51:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/6] PCI: Validate ACS control bits against
 device-specific ACS capabilities
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, jgg@nvidia.com, jic23@kernel.org, error27@gmail.com,
 kwilczynski@kernel.org, rdunlap@infradead.org, akpm@linux-foundation.org,
 bp@alien8.de, alex@shazbot.org, kevin.tian@intel.com,
 manivannan.sadhasivam@oss.qualcomm.com, LKML <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43931558B27C956BDBDCE0C6DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <7cab6f02-d557-abcf-63a8-28db43504acd@linux.intel.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <7cab6f02-d557-abcf-63a8-28db43504acd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0129.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::13) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <c4bad5b0-bd0e-4789-9147-397e748f3698@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SE3PR01MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: c57f33a7-803e-4f77-eaec-08df09ba20f9
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHq8QFbWW6Ra03gxaeZK6u4Z68/waDgwLZO2bPV0Xq8Fv90AVxEDvTeHq+Zuj2pHYrDWxoqIrd20jvE24KnOB8bw1RhNBqU7r9U9QLASlKCycc2UwasR2QlNY3haugil5MbO7wy6LChBGRc5nLqFJ/gvks9jwtceqskVeCH1R8BotxLw2ppwIFBEThmAnnJibdGRS0D+Q/CDtgydANhyCFZoQx2MFY1mWwxOXPp8JI2ABNeXJqfxq5TobaeOPjhcMXjQHKqTCyKzrbbPtHs/h1NwyLMhnrVvxvQjmTXFsme5n92tRJ1AqtxgWIdlbD8s2X+jjriZB4TYqQ1TtWXuLTvyGmULn5OFgKkXNd+R5cFoL1Rw6SO8PQ1aoJc/sT6Imj6kBrxwO5X2Zbcelsja8w6EsyzYhKeBVDtr2ZOIgGe875/EmLpq4GRnOlp1ednvQRrqTynP6kk7uErIi8mnkJwuH5Btt5qkBLsrFj7xfMvoHWOAapg/P5pAx31HT+5QLzVBNsFF6SXKb80LdeoOc8o5wyxt2ssiHoYijpDBkRFI9KO+1W1qddDCp8DlJrxQWxOz0Im/uKZJDCg1KdXJS+KfXAW5Ow6oFc54LMXyy9Uv3D1if3RGIeeYCqYOslhM94i/NApJ5aJhM0sW6PuiePanw5Ie/7SsDbmFAikKBs4DEz2e1EoNjcxExdyx1Yrwbd+XaFh2ghYXIBhwt95bl/Jzp6qhKY5Pxs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|2604032031799003|8060799015|23021999003|19110799012|37011999003|15080799012|51005399006|45011099003|12121999013|6090799003|25010399006|5072599009|40105399003|2607281247196008|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWtxOXFRR3NKSmJzMjJOYnhuNlpyWTVqZDlyd2RCYTBiZjJrOHhuKzJudjVT?=
 =?utf-8?B?WnpGTWFpeHM5YWZLVlIySStOd0Q0VFlkalZjUXZpOHcrRjh3Um9wekc2TnNH?=
 =?utf-8?B?SnNHWnB2R2tpdEhqSit0VFdXTkJSNEhnQ0VEeERueXVHWUxMWW9WYTJUL2ky?=
 =?utf-8?B?RDNwZk03cU5Mb21kYUp6MzlGWVpqU1JtWjJyOW9JM05VajdFMkV5Qk1BWUo3?=
 =?utf-8?B?Vy9KMG9QMCt6Z2hnMXVHUTgvL1NrZzk4MEhoQmFnalE3ejNxSStFNmJtenl5?=
 =?utf-8?B?L0MxZlBzRFhISllTblJiSkl4ZlYxQzZld3N0L3hJdG5oUXJWRExLR3J3SGlO?=
 =?utf-8?B?MDdYTzRiOUhsRUwyOW04TGwwYkJRc3BqdTRyVFpqWTV4UnZGMVdPWlFiYytn?=
 =?utf-8?B?SXJQSzB3VnlxQy9CczJXQ01ycG50NlloQzFHenBwSEJMUEpJelpNU1JCT3c2?=
 =?utf-8?B?b1crYlJiU3JhemVubDV6RzQydXUxTDU5OWwrdnFmV2JHN3Y5WmpWaTdvWURk?=
 =?utf-8?B?MGdXcHhXeWtsLzBNSmcyVHljUGNTcVJ1RVhiSEV0SSthWG5QcVdIdzlLOTBC?=
 =?utf-8?B?ZElsMEdacGtOQkUxVjhZcHRaY2orTGg5ckRzdm9scVBFd3E4dWZncE10UktJ?=
 =?utf-8?B?RWk1YjQxS2NQR0pFL0ZqL0dpaWJTeDY3UHp3TFZWZ0xYdURaN0VVTktwdkxq?=
 =?utf-8?B?alNoRXhXYXRIOU1DQi9Xdzlwb2EzUFU1VHhJUnZMOTk4R0ZJSkxDTWhBWWxS?=
 =?utf-8?B?VzM0aS9xQ2hObkxyRGhoTlROeGNWZndNSitVSzhtN05UOU1RQWtaVzZGNWZD?=
 =?utf-8?B?M2JqZ21iakhNMDJnclpFWUFDK1pRZEFmNUozc2hKMzV1SFNIQk9mcHRUZzVm?=
 =?utf-8?B?RytZdFNlT2F2Sno1b1FmeGt1N1FHWHVpeGZXN1k0KzJiVEl5aVA4L3o1NThO?=
 =?utf-8?B?QkxFNGFVT3llRGdueW9CdVFISE5GM3lmcDRyK3ZSTGVhcVc2b3hoUFF6ZDVF?=
 =?utf-8?B?TElrNTlGTzV2cHpFSnIvQldUK0haMXdDTkx1NytwY0R3SjZ6b1dLZVdZMHQr?=
 =?utf-8?B?cDhzNXNZVzlZaWlBMy9zRVdremJrTmZadCs2MGthVnFLS1VDYnhGOHU1cG1m?=
 =?utf-8?B?OWhacTYwL01FTlZDKzVySjdqR3A4RkVkYTlxVFE2cWUzZWRTbGdEbEp1NEZD?=
 =?utf-8?B?UGlwZ0dwVm4ralEwVE92VDhxSTNaYWlTWmk5bVNwYUUrQnV3VXB1UVlCem5N?=
 =?utf-8?B?eVhOMWVCOENEVlpMbDRUeG5RSFZlMS9mb1U4OXF5eHZvZ09rT1FFMllnZUoy?=
 =?utf-8?B?SmdkN0FOMWdXU3dPcUF5S0xaajJING80WHNtRysrbFV6aDFEMGVmZkM4aW9T?=
 =?utf-8?B?SWljbWNmc01sdHQwcWNhUU9vQjRzTk5CREd2aE9PQ3oxYklTRk5WNlpBTm5W?=
 =?utf-8?B?amdRcFNwbExIcW16a2R1REdtVnptMjdWNHA4WHhBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnlGc2NBVUF0YTUwaTIxNnBzTzU1ME1PbnBqS3pSQkVvUmhWRXF1Z09TMlJO?=
 =?utf-8?B?REhoOEVXc0pUS09Na2l6VTBrSUhmSFlIVXMvUXFrRXFjb3ZXdXY0alZLM2I5?=
 =?utf-8?B?Wk9hV1lLd0t5aElKMVh6L0VaRWtwVDhuQVp1Vk9TSks0VDZ0QUp2djZVMy9w?=
 =?utf-8?B?aFVmaTJyUjhNbTBEaHYvRjNNbjJqQks0VVVLajNleklNUGoxZWJDSkJ3d24x?=
 =?utf-8?B?dEZPc0xqSURYd2o1eUM1aDI1ZWtKQUtWd3RoNkdjTnRqakFDOXdycXZCN0tP?=
 =?utf-8?B?VlRJZzM4VVNMM0dmOXV2WEo2WUR3bi81TUxjMEhRWGFLekU0QjRpUzZ2aXBC?=
 =?utf-8?B?QjhROHR1ZzlPNUxpMy92Ynh3SmZSaTk3WENwR0hjemVhUkNCTTAvVndzTHBL?=
 =?utf-8?B?S25aWjNIMzlFNDBxZFl5dWxsOUtQNWpCWkVLbzhLSm9OeGpNaVg0UTZJUUxP?=
 =?utf-8?B?cGlkNS9hL0szTyt6NEg2UlpISmFYeWxtV0sxdzNsK20xalhFYmk5N3RMWjlI?=
 =?utf-8?B?Tjg2aTZzY0FLMExveWJoTENQSEZpM3JTQWN0K28rVmJQMllJTy94YmdoSzB4?=
 =?utf-8?B?MnNSRGJodmNQMDFRL293RVBWSThWVndVVkRQTnJib2hwMW0xRzFjY1ZRSDdi?=
 =?utf-8?B?QlM2enVmc2wzNnBja0o4ci9ITzgzUEprNDFDdXpmbEZsQktPdTZkRmtqMDZy?=
 =?utf-8?B?MWcxZ2xkVHZPLy81VHgyWGxid3ZUMTY0bUZnZGtOY1JSa25xbEd2UnN5VVBN?=
 =?utf-8?B?bTErK0tQR3UzczVEczI4eS9hREt6OXcvYjNWbkNHV3dwbXZXKzVMeGwwUS9u?=
 =?utf-8?B?dWdIbmJLZkNuT1dTV3gvNmVwakRwYno3dk5QdFQzb0puYUZ4RnFhckpQeFdD?=
 =?utf-8?B?RkFpa2s2UndFYVdBSGV3dEpsU2NHOEVYQTlUY0wrR3RXL2p3QWI2d2ZQa2tG?=
 =?utf-8?B?KzUrQ2tOdzJ3MGpWMVhEZnZDdmRNb3NXQlpRNkxzMlhkOXliNERML1hEbW9E?=
 =?utf-8?B?MjdZSkQ4WnRCeDhodkllZUQxSnNZNVFlVGlqY3lnRFRrWlRIVGozUzFpc2hO?=
 =?utf-8?B?cHdNTUt3QUd1R3lWNENYTU5oeWRMaXJpU3BJVGkvZXdLK0hhMzlmblBxR1Vm?=
 =?utf-8?B?TzBCNEdNNFhaUThvY0NEOVpINFJUak5STDEyTENXOGpQVGJPTFAydmN5dEFu?=
 =?utf-8?B?QjJYbWxhcVZnblcxdU45STkyOUVGMTFBczE4NlRMeTl6N3pSTzNpSitKeUJw?=
 =?utf-8?B?aXJiS3F6ejRndFJtOVFOMk9KejBUNDlPbE5PR3FkWnJXVGlaV0RmdjlmL0NJ?=
 =?utf-8?B?ZUhadXdrcENIOWhzNFE0akQ4RG93TXdsN0krekZ0c1ZmNU9WTTNKUWliTmQ3?=
 =?utf-8?B?VkxtYTFTN1hub1NXSmRlcmUzRGx3UXJ5cHRwMnlKK0Y1TG5Cd1FyTFRuU0w1?=
 =?utf-8?B?Z1JhWkJqdWhDdHlyUDFLSThNRGp1UW9XZkVYNTZYVU50d2IwZitFalJDN3hy?=
 =?utf-8?B?bENXT2dRSFZPLzVYcDBmZU1la0d6VVNrendHNE9BVlQ3OUNQRnRvVUV2RSth?=
 =?utf-8?B?MWNFYnhuS2VmeEt5RkZGU2M3d0hiTHVyYStWUzIyV2wwWUpNQVMxZkJGanU3?=
 =?utf-8?B?T3VBWlZNQ0lIZ2wzdktuRXZhTExxbXVCQXJ4S3lISCs5aktvbG9DUVdGZWRn?=
 =?utf-8?B?SnUra3Irb0VpckR2SjI1dUtUNVIydys0Nk9ER2RVTlEwV2M0ejZMd2RwdUh1?=
 =?utf-8?B?bWFRLzFwbjBGUXN6cW80a3NyWHlYZmNLVGw4SE8zZ1RJRXRsWkFUN2xZek83?=
 =?utf-8?B?ZWtJVTlKdXFpWjlUUjBFN21EY3dwaHZ6Vlo0LzN0OGpKKys2TXZmWWdDdEI5?=
 =?utf-8?Q?IkSa05jisIknH?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c57f33a7-803e-4f77-eaec-08df09ba20f9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:51:54.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR01MB8361

On 9/3/26 7:07 PM, Ilpo Järvinen wrote:
> On Thu, 3 Sep 2026, Wei Wang wrote:
> 
>> The ACS control validation used the kernel's full set of ACS control bits,
>> which allowed users to request ACS features that the device does not
>> support. Because hardware silently ignores these unsupported bits, users
>> have no indication that their config_acs= request was partially
>> ineffective.
>>
>> Validate the requested ACS control bits against dev->acs_capabilities so
>> that only device-supported ACS controls are accepted. Mask the capability
>> with GENMASK_U16(6, 0) to select only the currently defined ACS control
>> bits (0-6). Higher bits in the capability structure (e.g. the egress
>> control vector size in bits 8-15) do not correspond to control bits in
>> the ACS control register. Add a debug message to report which unsupported
>> bits were ignored.
>>
>> __pci_config_acs() is also called from disable_acs_redir_param(), which
>> passes a hardcoded acs_mask (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC) that
>> does not need validation. Gate the new check on !acs_mask so it only
>> fires for the config_acs_param path, which always invokes
>> __pci_config_acs() with acs_mask == 0 and builds the actual mask from
>> user input.
>>
>> Also move the check after the device is matched, since the ctrl bits apply
>> only to the matched device.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   drivers/pci/pci.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b2879a6be5f8..2af679111a9b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -910,6 +910,7 @@ struct pci_acs {
>>   static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>>   			     const char *p, const u16 acs_mask, const u16 acs_flags)
>>   {
>> +	u16 valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
> 
> This looks a step backwards.
> 
> These bits are surely named so this mask should be a composite of those
> define names, either done here or through another define (likely the
> latter is better).

Yes, will use another define:

#define PCI_ACS_BASIC_CTRL_MASK \
	(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | \
	 PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)
