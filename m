Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794831891;
	b=g/AVM2iEmQ+xlwfQVng6isNojRPdH4U9SMIktgpid5a3YP2JMVCU633LKd9e7t6Yv1jp
	 4Cq649n/ud6tdW1tc/S36VqMQBWv+s8G8GRCv8mRC/hGjEfyJGEA+Wf/l/8+FibkR/joO
	 ABoHl05+xWQU11EFJE+dS8sfa2L9rU2EW3/GGVuPbBPX9CWe2fkV2DUMPQoS2voH7ohD8
	 WJ6Oqge4vh1T9YeK80nO0mAaAa4xLjXXN5b8v634ttHRkuPugTelUmPDkqWz4idPN+eHW
	 OWW+cpyY4616ewZNSNvVKvSAWru1mcYG76zKHtYrxHvVPrI+ruNOhOARObqEKE7bDrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831891;
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
	bh=HpyVNsLv/2qC/PjcrahQ/S5wITJOT7W4ewRdiNKiDbU=;
	b=d56kaunN3qR482CkfUc+6J63TJHOIilXOB3ynAlE3+6zrXrq1i+Vu5M9iEGmirn/MQza
	 c7lKq23p6Jc63488hMqn9H0BPKEPFK7/UKvVGgkkQeJ2wjL7snYZteOuq+PipZqz219W5
	 1452cFilCMlsXrDn1D+34YU7YbHOLF3u+US0v3UrDbTQmIJ+xRtLnH2MMDdE7lODnmoos
	 30K5a+SJSlxQUECKRTj1KQr93X5WmFLGQgvyfgwRCgQvvzic/2qoIIYr4FFdQsPkAMYrP
	 4zxo4SGqB2SJP8lQPzAyfeawGxSSvoXBpDU1IpODcNlxQ9oY7rBUgDLVijgv4GKUqlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SI244iQj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.19
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E9606A31C;
	Mon, 16 Nov 2026 12:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED8E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SI244iQj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG1gqOpazyvm2mCndG944EzsAvClR7TGvMjs4lvJ8AgpPDKGWoyo6POBJ+74fVgsPZx2RAIqntWbn668eZ5K8UWktzcvz6TOfJT86ahpMuj3RpkkuP7ClecZ1MWOZkGoyPVl/Uj+ujhu9DOiqnc0Cm7iHI8HRz9lfD/r9mH7tLQnikZNDKIbAKcltr/kwnsD5B78M3hkrP3hL2uls+WBHeeD/dqm4F1DqOS/fND6oUxOY/RzRJ9WZ/ZbjeNKzF4Vv1y3k1PdVnnfjNHhG3dhSA8kqo229qGMpaVYUBNQzzeO+mun14Z+eFYir91nXAAThkJ0aBfd8RVA0M+ArYrh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpyVNsLv/2qC/PjcrahQ/S5wITJOT7W4ewRdiNKiDbU=;
 b=R6oJ0XstGW9ffDYsgXDOLTpisZpkOH/fEVsXyK3FUndDbMyQ1Bl88Vn0t1FM5s4DbbfuKmb7xuyF97zyjUFKkBkEALvhhYrkA0Gu8yoVyFnPVcKSWDj0bON7L6ODhXazghqoEk/xfsnZ6BkDsBWI/Ammq2mY7vnEPGFcsGU53LtqsOfI3FZxG9c8pB1ZaOOKER3txZGCah1PWLj7q+ODMw86qmtJiNaDj6BDLympuIWsKgqz1rmuOhriCoYMrXsSxL1tmPgL3KzbP0gzmLqSU+DB06zU19Ez3SEgyJ3wscovm0QrduxBRJzweJlyv2TmQYNLjTSAcEirvni9vd09+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpyVNsLv/2qC/PjcrahQ/S5wITJOT7W4ewRdiNKiDbU=;
 b=SI244iQjjWeedeHpaWLsqzy2hcTHzwtCdPClpVTqmm+VsquKdYDc5ydHKQurW2YYb9ivaUDHt6XI/YAQQOk4v60DP3rD0E4ETqHCq+uuZZV/pjKcVv+fLYpc8hRisV1luIsoBQ6/+Z+PtQykx8Lh/0mPm94D226h3wITAFC2fAk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:24:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:24:46 +0000
Message-ID: <b0682da2-9f4b-4674-995f-ea2c35ac5cfc@amd.com>
Date: Mon, 16 Nov 2026 13:24:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] drm/amdgpu: Catch register access while GMUX
 keeps the GPU off
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>, Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-10-atharvatiwarilinuxdev@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261114160731.3756-10-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0897d84d-ba28-4d9b-fc6a-08df43dc9995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XZB7P00+By2d+cEKfJ9I8pTE6/IjDq/N4bS94D02mrxmGEl85wPWv4VxSXzNwPLD5MxLIl236nPYV95xWpoV+B3Rjpy5QkG1dJviUKzjb7Nsdkr93Dy8K06ofkZB23PIR46n4OBWNkWDbOCWbuwuYPQuXMmDB5q99P9X+7hK3MbLXZP4JpQXPJuBiZktFlGFbMCz95d9W1/DeLFeTSC0Jx83wKyQQrifcPd+f/jceINZGn4rxOUpvkdQyJH0BlPCb+iZ1pMIFLyCzvHcjTwDDgAa8fD6oclMbYU6ZZ+JV7ZmnbtkkM9R0xbqx2qBGRLI0PmIRiBi6Zjc5Bp1IhTy+hmpPo5OGdp6pzq1TST1IoY9Js8ltnxsETlJhGRl3wIdDkJdLBQyHkFjUPZ6iVkB0bchIFPkXS70c8ErIfp/5FNuGtgHo9Yinwc1IKGdZrM4YHajBcX7TQtk5CCWAIW29gL7G49ZgUpWh40hoonnARkZOUvMA67W3ijVLq8rTDcGdy+hMnEjmC9DfBugAwpS40P8jfZQz7oAz5XvBBNc3Rgbjas8KbBiwbF+rfLEjphD0y/SF6zoS4H+bVTSMeFhfEAnErt7thgotuCDmefMzz7sRNnq5wqHrBghOf6FgoTh/sT45RNm5yU79I0MWgSIMAIHLo3o0P/X8U5zqVfcc4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3RQNkg5aDZhMkFpbUgyQVhGODR3dFhFMU4vTHluWC9iRCtYVFU5NHZ4SUR5?=
 =?utf-8?B?bFZ6TjlUak05YmlYUGRTaGdzOVJkRktSeGhFbHFieGhpZXJoOGNrdCtVdWo3?=
 =?utf-8?B?Yk1ZdWJlNjlJdy9GUWt2U2duNHRGVWtqVFZIQVFHYjFRTlVqNW8xUnRJbVUz?=
 =?utf-8?B?Tm5qeEMzcE0vM1F5ZkV4czdjTktrS3dUVnNhYXNUSXdLMDRHY0FCWXcrRE1n?=
 =?utf-8?B?MDFYWW1EZWMrbmlBZWVpTVpNeHRVZld2V01qa0pLQ00zOEdkZzJqbjl4Y3V6?=
 =?utf-8?B?S0RWSEh2b1orUDcrRzZsSmlRT0g3ZmphU3haeTJyRmxHcDV6TUJ3cXl0MEdS?=
 =?utf-8?B?QUtoeDNQZ1lXakdNTHFYUTA4UUdILy9yMDlJeUpVajRLUzk4SzVmSUVzM1Nk?=
 =?utf-8?B?anhML2JTc1NlKzhjWkpnUFhQUGpTRzlvcGFId1hSZFk2Q2wyTGVvTm8rTWdH?=
 =?utf-8?B?NmVxWEJGazBvT1NHQ2tDbVVmSDdTNmNFeGt0NDVOTWpiUzlvMEl1Z25UL1RL?=
 =?utf-8?B?RnZYNTIrdmMybnFpQWZNaXE1S2xqRElCUENCK3ozaWpmUVpDWFhvcXZWalBz?=
 =?utf-8?B?YXpiZXRmMTA1bGpuZ05QU2NaN0tOOVdqK0c3WTNvOTlyMERvWWpIckhIb0VZ?=
 =?utf-8?B?U1NiU3c0RUtXQzdlM21TcE9tUHEvL0ZlY3ZQMDRWWnA4d29GSlNQTGxGMjNy?=
 =?utf-8?B?Zi9PYTZpTzVZREIyVWhXNjU2djBCS3FDcHBUQnF1K0J6L2tTRTAzYU5SemxV?=
 =?utf-8?B?eDdJd0E4ZWxMNnI3dlFvellMaE1PQ1NlYURhS09qTElYbnNGL0NnaGpuNUFv?=
 =?utf-8?B?Mk5BOXZJa1FQMDl5QmhRNzAzZG53dUloQmsrRXdGODk0Qkc1dWUreXBPWTc3?=
 =?utf-8?B?eTVGM0FQVUREanEyZVZTRExNbno1d3JIMVJwRVlmYmJobnJ2N0lGY2dyMmxl?=
 =?utf-8?B?Tk1QaFA5eDVzdG1sQ2JXRUY2bWVwOXAvbjVRa0VDVmlSUHZpUXpTY1poZmhI?=
 =?utf-8?B?MnY3bEc0Sm8xVS9Zd1RlRktSTS8yLzF1TSs3WWtWdStZbkpkZEo0WVpncjkv?=
 =?utf-8?B?a1NLVU9TZlB6eW5FdTQrMlc5Qkdid2VEcVBNR3FjQlcybEdFbDcwTmNvQlc0?=
 =?utf-8?B?TnB3K0RvZXhiUHRNVVlKRHdOeStOMzMrYTdaODc0dHdVdGVUS2pJcG9seXhS?=
 =?utf-8?B?YVFrZkRFTFplZkliaktYUEEwdmFsc01iSWFsQS9oU0xLZlBtVzJwRHBMUVRO?=
 =?utf-8?B?K04zR3Nab080d3F5TjhEWElOdTZxYWxVNzAxT1c1Z0tZaXlGUUtUMGhJbGpU?=
 =?utf-8?B?bEY5TnFZUDFNbC9aekxzYkhpTmdRcGhVRDN3Wk5pY2dZYkJ0N2xIckxQNXgr?=
 =?utf-8?B?UWFzRFZDZVFDSlU4SlNIZk1qcUtsdUtDanllSEJUSEhLY2UwTFBxOXA4azNo?=
 =?utf-8?B?UnlsVFduMm9kN3VtQ1ZPbmM0MHZpNDNwRlFlWXQvcDNIRXRua1F6b2hNUUJD?=
 =?utf-8?B?T1gwa0p5aEJuSmlDM2c3dDNOSDFFajk3VGlZUXN6NFJqOHJEY3k5VFpVTjV0?=
 =?utf-8?B?NFFzYXROSGM4Z0NrUHovMFZMV2dWVm9PcVJUY1hTcEJ6MGd4bEFxRTBPZUVi?=
 =?utf-8?B?QWJlaGI2N2kvMlZmeWV6M0E4bUpwd2lubEZHTWZRYWg1RGoxM25iWHdoQkNT?=
 =?utf-8?B?My9CaXJYaU9PVTZsek9qVnBCeHFqWW9PU0ZZV2xiUVo0ZkM3UGNISk1pdysz?=
 =?utf-8?B?dUgrZFByaklsYWllbjF0WEhuYit5SFBQVVQ2QlkyNDFDQ1JHQ0tpcWthTGZT?=
 =?utf-8?B?ci9WRFhZUHAzaEFBT2NJTmRUNWVJL0FoalVTa1hrNVVIMnlmZmtsQUQ3UFhN?=
 =?utf-8?B?WFBxcFpUeVljaVNqYkVKeXRxZHZTUVl3WmMwN3hPaEgzcjFWbEUzb045WGFI?=
 =?utf-8?B?RmNCWjd3WFpFVXFLNUlnckV6TFdWOElIeGo4a1gzNmw1Zkh0RUhPU0RqdVZK?=
 =?utf-8?B?NlBEU1gvbHUxL1pqU05aVTBJRUxVZFRsWW5scmhnV0YvVjNEeElLOU5qNnVP?=
 =?utf-8?B?cE9wRGd2SngzUDJuRlFQM2NNdFBadWZFRmZuZzFtV01kejlOdFNGTUx6czBp?=
 =?utf-8?B?bkZaWDMxaHErRWcrUVYxc1ZXV0NMQTVOMEkrYlV4T1JrR2RPRHUyZERyMHVi?=
 =?utf-8?B?OUNrRXczSG1MaGZkTnJsSmhlTVlyUTA5V1ZQNC9yOXhjTFVXOGovazdwaElv?=
 =?utf-8?B?RmlVcGRFSEZaZFIwenArK3RqNVV5MTk4UWVGMVd2dnFPR3dNTGxqb09TQXR6?=
 =?utf-8?Q?x1Wesvf9wE/EcnqMvc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0897d84d-ba28-4d9b-fc6a-08df43dc9995
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:24:46.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5YiAfKxrUIeE/04jlvlNp8CihA/vBnh4NBRZ83pkKy2aI4TsIrv3I1wmHbGYhL7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

On 11/14/26 17:06, Atharva Tiwari wrote:
> From: Andre Eikmeyer <dev@deq.rocks>
> 
> As mentioned previous any access to the GPU when the GMUX has
> shut off the rails results in a CPU CATTER, skip and report
> any register access after the GPU was runtime suspended for GMUX power-off.

Well absolutely clear NAK to the whole approach. That looks like a not throught through approach to me.

In general the driver requests runtime PM support based on if it is in use or not and *NOT* based on the GMUX status.

What the heck is going on here?

Regards,
Christian.

> 
> Tested-by: Sebastian Zygadlo <szgit@icloud.com>
> Tested-by: Yossef Osman <yossef.osman@proton.me>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
>  4 files changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6fd607587..9938ae48f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -881,6 +881,7 @@ struct amdgpu_device {
>  	/* enable runtime pm on the device */
>  	bool                            in_runpm;
>  	bool                            has_pr3;
> +	bool                            runpm_active;
>  
>  	bool                            ucode_sysfs_en;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ac336594b..ed205352f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -947,6 +947,10 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
>  	if (adev->no_hw_access)
>  		return true;
>  
> +	if (unlikely(!READ_ONCE(adev->runpm_active))) {
> +		WARN_RATELIMIT(1, "%s: register access while powered off\n", dev_name(adev->dev));
> +		return true;
> +	}
>  #ifdef CONFIG_LOCKDEP
>  	/*
>  	 * This is a bit complicated to understand, so worth a comment. What we assert
> @@ -2029,6 +2033,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	amdgpu_device_enable_virtual_display(adev);
> +	adev->runpm_active = true;
>  
>  	if (amdgpu_sriov_vf(adev)) {
>  		/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3978ed284..d1b0c6c73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2935,6 +2935,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  		amdgpu_device_baco_enter(adev);
>  	}
>  
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
> +		WRITE_ONCE(adev->runpm_active, false);
> +
>  	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
>  
>  	return 0;
> @@ -2963,6 +2966,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>  	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
>  		return -EINVAL;
>  
> +	WRITE_ONCE(adev->runpm_active, true);
> +
>  	/* Avoids registers access if device is physically gone */
>  	if (!pci_device_is_present(adev->pdev))
>  		adev->no_hw_access = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> index 7468855c1..64eba8a97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -594,6 +594,9 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev, u32 reg_addr)
>  	void __iomem *pcie_data_offset;
>  	u32 r;
>  
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
>  	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>  
> @@ -617,6 +620,9 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_addr)
>  	void __iomem *pcie_index_hi_offset;
>  	void __iomem *pcie_data_offset;
>  
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
>  	if (unlikely(!adev->nbio.funcs)) {
>  		pcie_index = AMDGPU_PCIE_INDEX_FALLBACK;
>  		pcie_data = AMDGPU_PCIE_DATA_FALLBACK;
> @@ -677,6 +683,9 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr)
>  	void __iomem *pcie_data_offset;
>  	u64 r;
>  
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
>  	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>  
> @@ -706,6 +715,9 @@ u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev, u64 reg_addr)
>  	void __iomem *pcie_data_offset;
>  	u64 r;
>  
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
>  	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>  	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
> @@ -762,6 +774,9 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev, u32 reg_addr,
>  	void __iomem *pcie_index_offset;
>  	void __iomem *pcie_data_offset;
>  
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
>  	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>  
> @@ -784,6 +799,9 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev, u64 reg_addr,
>  	void __iomem *pcie_index_hi_offset;
>  	void __iomem *pcie_data_offset;
>  
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
>  	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>  	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
> @@ -832,6 +850,9 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev, u32 reg_addr,
>  	void __iomem *pcie_index_offset;
>  	void __iomem *pcie_data_offset;
>  
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
>  	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>  
> @@ -861,6 +882,9 @@ void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev, u64 reg_addr,
>  	void __iomem *pcie_index_hi_offset;
>  	void __iomem *pcie_data_offset;
>  
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
>  	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>  	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))

