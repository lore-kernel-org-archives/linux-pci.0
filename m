Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012050.outbound.protection.outlook.com [52.103.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37F306746;
	Thu,  3 Sep 2026 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407205; cv=fail; b=Cbr0Eqx/2ymdU6o+tzeYByqOxrU99XnoAZanEOoCBdibl8S/F5iwHUyIqh7cIs+7hV7zBT7MovC14gMrItZqq+wSoKWzI2d5tJPlFaUNZM8dxbub2csjApeF6nRU+e83RHnemAtB5Q7DfelZzsZiSIYjZiBqOwYNS6xnjxBvldw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407205; c=relaxed/simple;
	bh=BVUy4ike6K+g4BvLLECfxLwF5teic4XhyF+gQCq+rvg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nkx2nE/E2BWHpo7O0AjlhqfmqgyoW8bFzHf7XX+tcUCTJcAASV4OBNG/3qD/IFbEG2MaAb8SIMSPokOVd1nY0rA4NO5mwy3fpDahz+2RQxY43MUCLQ/95PDRWxkoQVyyJqDS0YjzUes+81uUhRsdKrKcHrOjjg1ce/FQew4pOlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ZLASvJaG; arc=fail smtp.client-ip=52.103.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ZLASvJaG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIPMlr6LgElWCymFs7CCzF56RwcSwhboiZ3l51PvqQTUf7JvKiWK7ssz3S2YxAZUWsoRTN8oIvviNv4DbOaS8vVPB90LbvFKkaJla57VqDUZJtz63Q3xI2Ha/HrYzPQXfEroV8OC0ql02cir13GuduDffVbVylgdS+AGPFgmIkIqvgOlJyCjn2e2QarTJjkbTuU2+ojZK0aHcRJ0OG4gIgjnrhP4zODD49oRoV4h2kuHYSPT9ZD26gLNuJHnHx318RjbKwS4x6v/qsAAXGu7wBGnfkoy+1H3IlAyKCiW5y6GuOziU/qO3XFgdQ596AteUNHFPuwu8WxRowcoCEEeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jvv5yDVgXvEDDl2/9ynstEtyiJ84k/r4fmGg+YskOw=;
 b=nNWmXCnZkOyG73E5wMLD9SiYc4G1/1hZYZKifvhpf1BTk5TLyNBI/sLcytyYuPm1Zmz51sv4uvPjl/1NXbwJXoDP8Yx+LSVDrqf6LiouWgDVeyULX9zlqbpXcUuCjlkmsKl6IJvkZfGH0yvTt9FmXr3xgW9d4zIOLX7kR1LehEhi4QVXrFphj7TIlxgx6EdT0yfJjkYIBFdc1szwp4FU48Y7KiUJj2w4dkGzCTP0Lu/HYd1Or7bFzCTPL6vgdbNXCh9EPAuPdafyfNMLBsSqr67hFPj7YVx34NM9xQmbmHd7nZrjOyEPFYABrP+AIL1TH5PDBGPQd8zJvaZNVzAKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jvv5yDVgXvEDDl2/9ynstEtyiJ84k/r4fmGg+YskOw=;
 b=ZLASvJaGwEI5npJLiA5HrE+28cVtrk1X8amU84IY2eSTVq38uUhsOg9I2nR6aix+pIeUifga0lk9SHmjdzcOwhs5xmh6FVaXI04GtbyRYShOWReyzvAG8n/S+e5wT2yj+reUOj6I373EVOjEaIbpUNoyhO57xnAbJHbyV3I3UZqYqwURh94d1Pt93o4QkQAcwQUpQCwHO01MecUmHtQSSb2spyHpreN04B2lT+SBKpeFxOx1TkQsTus33hJCPZ67yTtPWwQV22ouCVku/f5yOiEvNa1LW/wqfA0eL8WTR/FyYK+2QlCirlDr8NXA0K005BzyNvqT8SKBAL5Af5PKNg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4733.apcprd01.prod.exchangelabs.com
 (2603:1096:101:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:46:35 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:46:35 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v9 0/6] PCI: Add support for ACS Enhanced Capability
Date: Thu,  3 Sep 2026 11:46:12 +0800
Message-ID:
 <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0092.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::7)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260903034618.1100387-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a394040-2379-406e-35db-08df096df2c3
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3j4EGtrWC76yZtYjXYOkK33sCW/llI+kFfygYBALuFDhQgMiWr3DnWmwY2n0AxH/1oCN2inHfC5qnnt8MFbsXX45HJN3CuE+86QuCiIlwvJlO/59Wii7fdOaYqLkOHekxFeanLB2ujalwHRAVD8TFiU3gqzKdKNMhOaPr3fEaJJ2OuNrUPmg5rjJBvhMUv9b2QhOI23f0sbR6uQOjxowu31e5fm+iPr/Z+cdrFigqtjWEc0IadECEJ9amaCtTcWvUVpaM2lmH12q270PiLmpa2Z9vmQQOqvUZ5L5rxJ+axnIzDdnc2sQ8TvrTRO91n2HCtXdnc88qfHwg8p2Vkk0bJADSPS8qjSlD4gfDpPwI8sLCvZrZLtEuk5lgGeTTMnGUMc1OsAKTfsAuCfZx20exVuUutbrYC1CNzBIAIKo4ArCuSztwU+SLkBVGhaeEb4pe313cbHBlJsvYDplO31YGJpz68j3VDoMPR9OcrCpRyssuOisVCn60A26ZiTcMKw9/iCJchSJ6h1FZCeiDr/4LTrK5hr7dDezT2TgQ2x1nd1dY0Ym7qP8WlP5IMjLWw1iEFNnwWdOTObddicvep4g58EXp9IvF9A3e87G8XndiIK+fyVFAKJ87llrppaRGJ4sFjnB49NPkLG0/cSJog8u1QaeVeqZQrcxoac5Tost3+8Px1h33D1RmSA5iKa3fTYAM7S18+P0uDMk6INrVOSzb0M4Ab16SatvVhIgdPst1MyidzAmRI9sp6D6gp6BoPn7z/cF7msTo3KtZ1pbLqo6OLEukYslm2OMfA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|5062599005|41001999006|6090799003|5072599009|10092599007|19110799012|4140399003|25010399006|23021999003|8060799015|37011999003|45011099003|15080799012|51005399006|17081999003|4302099013|440099028|3412199025|1602099012|40105399003|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGE1bDFjVVBUYitkS3RCK0YzcFJIZ0ZYT0tNajQ5cHFoV3VyQTE3aGMvaW5s?=
 =?utf-8?B?MjFYbThUODYrRkFmYW12ZWh0dUZ4Ri9SVGcvOGxDT094dldubGNRemJ2T2R1?=
 =?utf-8?B?aVdheExKa1VKMW1oS25hMDhNRm1CSjNsdUFXZW94SXRlRWliOTA3NlROVzRK?=
 =?utf-8?B?V051RGc3M2pWV3VEaHBGRitZKzdNK2tKVkNVU29mL1V4NWtuRUMzNjJwSzgv?=
 =?utf-8?B?bktWWmE0UXhMeWZ6YkczeDdESXp2YVJKbzJmb05WWUZpOHZuQks5ekVkNVFR?=
 =?utf-8?B?SVpiNzJvSyswV2xxUFhYWG5tSGZQcnJIZ3VOZkZVQUJtNkJrNWphclE0VUl2?=
 =?utf-8?B?YTMwMWhQZGdRV0ZXMnQzRW5hT0IzUXdIUDBtcUR4di9sb0pITHpNNWtHeHBR?=
 =?utf-8?B?ZTJuK3NyRDl2MExQQXJwVnlwSUpzd0tVYk0zeGhKRk8wSElHMzZJSng3QWhK?=
 =?utf-8?B?clNCVFp4bDB5dWFUdG1aaksrd3RFdU5iZytqU0hyVEdXRG1PNzZLa09mTTlz?=
 =?utf-8?B?bGlxUUhUQUk0ems3MFZPZ1hMMHNmSnREZi9aekpNSDFJQ2lpQTFud0NFbFBr?=
 =?utf-8?B?bG5md0MyR05jVDVTZkpmMW1QRTUweUVyUU5IRDI5Wm9BK1RKcllUaGFSL0o0?=
 =?utf-8?B?SWZqSURoMmNtcmZoVFVEOFJCQWxibDZzUDd5ZUdMdjgxZ3djQ3QvTmdSb1FW?=
 =?utf-8?B?RW1aVHRpZkM4MVprUVhFK1dFYWlnVFVxc3RCUjJvN2JPQjh6VDhNRHJjOTVp?=
 =?utf-8?B?ajJPYWE4OVNqMWt5M3R4enFseTU0ZnZQWU9PKzF0ZkVDckIxdkFhWG5GVkdH?=
 =?utf-8?B?Y3VOTnN5QUVYZmFDMTI2VVlyOENLWnNucjJYZFJpTzFla1gyMmRYemlrL2Ir?=
 =?utf-8?B?U0hTcTlmd0VUV2hkaXVwcmpQUTFqWXFBNk83c3BPWVdEeWxrMGIrdWhUdHZT?=
 =?utf-8?B?N3Z2enZPMFpiaWhVM0Y0ZW12NTNjaXhid0x0TytPVTl3eGFoWE1tckhLdVNR?=
 =?utf-8?B?SFJlcDk3K1hOd09WdVVnUFZxUjVxSjYwNzIyNmlFRE1JcnZjRFhSdlJ3cHRS?=
 =?utf-8?B?Rk9zai95dnNaTldXMlF6T3o5SmNaNDYya0pUM1Voc1RLRlUzWDR5UnQ0SXVk?=
 =?utf-8?B?NThZeG0za2FsNThiNkxNclZvU3FmTXRnaWZ1VlUwVENjZTIvQkZtdFdTajcw?=
 =?utf-8?B?UXYxQWV4STg1bzVDS2JtUGlkbWJ6ZVYySnhhdlVEWkpreEZtcGxvOHArc0dJ?=
 =?utf-8?B?dTMxcVhROFk1bi9TN2RJUGhURGRZU0V4Q1dhRzRDaklwVFJKYXIyNnhSSFo3?=
 =?utf-8?B?cXJTRisvem82MEhtV2Q5M1VYaVFrTURvampEVFltMGVZUUNRZTFwWGtUS2hC?=
 =?utf-8?B?YmUzYXV5NVAvbVZ3eHZOMjAyb2ZXUjBia2NZNDQrQVdJSFhBMlhFV01FWlBx?=
 =?utf-8?B?ZThFRzlXU1o3Ry96eDdFaUdKYzZuZHFCZEF6eHkxNHNYZHp5VmpEUVlPUzNr?=
 =?utf-8?B?M2FtNXdmZU1PRmJBWHdpT1d0UFhTd1pXN2hIUkR2NnNZL3NPbm1za3VHTUtq?=
 =?utf-8?B?VWNaMzNXMjdCeGJSeSs5OWk1MWZmMFprS1BUc2h5T2NvUmFnRW9qTXZGWmRD?=
 =?utf-8?Q?MAO3fMrj+oNnmJr7bHRRSzzHIuBOgQvECteiN3eNN/iE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVN4L0I0Q1BDWEVUb0tJbE5VYlVTdVQ4U2dzV0lKRkhXNzE1ZmNmQzBUZVdH?=
 =?utf-8?B?Y0lTd3B5eVVNckxJTXF1THNYRkhyMDJ6MkRBa1gwNnZlQ0lEeFFIWWp1TWlP?=
 =?utf-8?B?UUtXcDZ0Qm1UcFdMc3BmTlNSeE8xWmtOM3VFNC9odmZjYmZNbXdRdldQd1Fn?=
 =?utf-8?B?Z3NOWHhKaEpaMnQ5WlJBQ2lrRHJKSytQQm16T01pRnhmY01BS2hnRy96cnBi?=
 =?utf-8?B?M1JDOVdQY2hjd0Jhek5Wa3FrYStVTmxBQitOZ2U1aEFEZ0ZMcnVBV1RobkJG?=
 =?utf-8?B?aUpPSEhXTjRZM0wwU0xlZ2c4eXR5N1prQnBYcG0wM0ZpK2VEeGV2RnJ2cDhq?=
 =?utf-8?B?NlpOTnNQQ1dJcG1rQnIxOCtoTDdLa0Q0YTlpRnZhVldpeU1NdGZLR3VaQTdW?=
 =?utf-8?B?NE50bkIwMnNvdk1ONXVlNXFsVFd5Y0ZwQjVFakViK0tqUmxtTkw1TWkyMVpy?=
 =?utf-8?B?ZjBHaEowd1pidXZJclFIRmsveUd4ZkdaWkQxa2tmMmRNUWpwUHM0WWV3a3Bj?=
 =?utf-8?B?a01BMFVnV2V3ZnM1MmY4bCt2Rk9LQnNoOWJuamhNcCtRTDVObnZ3Z3QyTTFa?=
 =?utf-8?B?aEpSZHl1bjgvYnZtb0RCNyswTnc1T3djd1VEamFkeityV3hDb0lObjJNZEl5?=
 =?utf-8?B?Z0svVjJHdzcyYkc2eDdJc2dmZHZtQlN6ZlZ2aWVyUVJLVGpTcUdQcExHSy92?=
 =?utf-8?B?WG5CdjBSdDhNSk82R2NveE9CU0EybzRoMEthMXZjRElLU1ZmZzZ0T1A5SG9S?=
 =?utf-8?B?R09wT2hmYVZOMzZOZnQzZXdFR3BCZHhkZkxZcjI3b1RpNmc3Z21IY2QweTVK?=
 =?utf-8?B?WUxUclZ3RDZLWU1pZU5nbDhlVlgyRkdKU0FIYjIvTUpmWHZHTzZGSXNKaFNh?=
 =?utf-8?B?aFFNQ284UDBYTHdYemZ6dnFLcGlaVmFpR2E2S09HSG9GNytsQ2FHRHh3Q1JK?=
 =?utf-8?B?Q3hVWVB2UmpubFErSjd3Q3pWU2ZsalFMK09xdmxFVVZiNTUrdDM2d1Jrb0NY?=
 =?utf-8?B?dVh0ZlpQTmhiVXRSRFhuelVkTklXaGtmbThNYnVIOVZpMVFoSVVVTEgzazd0?=
 =?utf-8?B?ZDNJVzIySmtTeDMrS1J1Y2k3V3BKanJIUHliTEhMWlVoRlV6WG9RRTNQOHd2?=
 =?utf-8?B?NFR0MkM0aWtzbmZzcmdmbSs0RVVrSk1QMWVhcVpFZUVuS1BhR3ZxNHFFVWJR?=
 =?utf-8?B?a3VqYnEzZ3RidTB3dUNKb1BBcGR0Z0MwMVNrYUVEakN5WmdDaGdSWlpabnJQ?=
 =?utf-8?B?cEhnRFFVTVhYZkZNVzhhMTlIRXhDMjh5a3hWaXlrU3h0a2poWVRUZ2VLZk5s?=
 =?utf-8?B?YVVZN0kzV1BVVDg5MXMzL0hkWk1Mdkd0cnhteEd5QmhlbW9iYzhwMWVsUEk4?=
 =?utf-8?B?OG1OZmxDMkdhdnhRZVczRWJ4MjhRdFJzL08yb1UrSXhFbU84a0FNWDlnd1pp?=
 =?utf-8?B?MERxQmFGMm9LMlhSd0pNcUxKTnNGSG4rT0V1dEVyeHpMb0ZKZ0ovOWtnT1lh?=
 =?utf-8?B?QXJzdXpHRmxRTE00bElKS2V3K3FMTS9QMGpDaHRxcHU1cHpCQncxMmtVQUY2?=
 =?utf-8?B?NEVKM1RmVFpBZk5kZ1N1ZFJUSEFNSnc1Uk1LUy9vTjhrOEU0bHJDWDVCZGQ3?=
 =?utf-8?B?QU1VcTRjZHFteGsvL0xsc3JRbExiK3BMSnNkdlZFcEIvNkcwNFR1YzZLcVlk?=
 =?utf-8?B?WVE4VzBaWXpveDJVR3hJc25GUjl3cjlnajJiWm83R0VwNHZGUWNWcTFoMWJz?=
 =?utf-8?B?QzlxUVJhYXg5WmZ4cytSdXBKa2ttKy9Gd0k1YkFhRG9NMTgvejBlT0JJd2Jv?=
 =?utf-8?B?Y25NcklDTzhseElDUDA2TTlRNDFMNEE3RTV1VmptOUhvTDBSbi9qcDNmRjN1?=
 =?utf-8?Q?iGH/Z6wXNFvJR?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a394040-2379-406e-35db-08df096df2c3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:46:35.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4733

This patchset improves the core ACS implementation and adds support for
the Access Control Services (ACS) Enhanced Capability, introduced with
PCIe Gen 5.

Improvements to the core ACS implementation include:
- Validating ACS enable flags against device-specific capabilities rather
  than generic kernel masks. This ensures only supported features are
  enabled while safely ignoring attempts to disable unsupported bits.

- Consolidating delimiter parsing into pci_dev_str_match() and returning
  -ENODEV when no further entries can be parsed. This removes duplicated
  logic in callers.

- Refactoring ACS parameter handling by splitting the intertwined
  disable_acs_redir and config_acs param logic into dedicated functions.
  This improves maintainability and robustness while optimizing parsing
  with better validation and readability.

- Updating the config_acs kernel parameter documentation to include an
  example of multi-device configuration with distinct settings and
  advising users to quote the parameter to avoid bootloader parsing
  issues with the semicolon separator.

Support for the ACS Enhanced Capability is built on top of this improved
implementation. This capability provides additional access control
features that improve device isolation — particularly important in
virtualization scenarios where devices are passed through to different
virtual machines (VMs). Strong isolation is critical to ensure security
between devices assigned to different VMs and the host.

In Linux, device grouping assumes that devices in separate IOMMU groups
are properly isolated. To uphold this assumption, the enhanced ACS
controls are enabled by default on hardware that supports the PCI_ACS_ECAP
capability. As with other basic ACS access controls, these new controls
can be configured via the config_acs= boot parameter.

Support for checking the enhanced ACS controls on Root and Downstream
Ports has been added to pci_acs_enabled(). On devices that support
PCI_ACS_ECAP, these controls must be properly enabled. To maintain
compatibility with legacy devices that lack PCI_ACS_ECAP support,
pci_acs_enabled() simply skips the check.

v8->v9 changes:
Patch 1:
  - strip unsupported bits from both mask and flags rather than aborting
    the entire configuration. This aligns with the existing command-line
    configurations to have the supported bits applied at least (Sashiko)
Patch 4:
  - Preserve pre-refactor behavior for the empty-bitstring form, e.g.
   "@0000:01:00.0" in config_acs, which resets caps->ctrl to caps->fw_ctrl
    for the matched device (undoing pci_std_enable_acs()). Also restore the
   "ACS Flags missing" pci_err() diagnostic on a missing '@' delimiter.
   (Sashiko)
  - Two other comments from Sashiko were marked as non-critical and
    pre-existing; left unchanged for now to preserve the current behavior.
Patch 5:
  - Enable Unclaimed Request Redirect Control and Upstream Port Memory
    Target Access Redirect for Downstream Port only (PCI_ACS_ECAP is set
    in pci_acs_enabled() for root port and downstream port).(Sashiko)
  v8 Link: https://lore.kernel.org/all/SI2PR01MB43932642FC4DD3D075983B1FDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v7->v8 changes:
Patch 1:
  - Validate against dev->acs_capabilities & GENMASK_U16(6, 0) rather than
    the raw dev->acs_capabilities, as the latter may contain fields (like
    the egress control vector size) that do not correspond to bits in the
    ACS control register. (Sashiko-bot)
  - Gate the new capability check on !acs_mask so it only fires for the
    config_acs parameter path. This avoids breaking legacy
    disable_acs_redir behavior. (Sashiko-bot)
  - Validate both enable and disable bits (the full mask), not just flags.
    Reverts the v7 narrowing to enable-only.
Patch 2:
  - Remove the leading '-' characters in the documentation examples to
    prevent copy-paste confusion for users. (Randy)
  - Recommend using double quotes instead of single quotes for multiple
    devices to avoid potential shell-escaping issues where single quotes
    might be treated as literal characters. (Sashiko-bot)
Patch 3:
  - Move the error reporting back to the callers so that caller context
    is included in the dmesg output. (Krzysztof)
  - In pci_dev_str_match(): enforce stricter boundary checks on successful
    matches (see Patch 3 commit log for full details).
Patch 4:
  - Move the pci_info logging for ACS modifications up to pci_enable_acs()
    so it prints for both disable_acs_redir and config_acs modifications.
    Introduction of kernel_default_ctrl so the print only fires when a
    cmdline param diverges from pci_std_enable_acs()'s output (not on
    every pci_std_enable_acs() modification). (Sashiko-bot)
  - Drop max_shift; bound the parse loop by the u16 width (16) and rely on
    the existing invalid_bits & ~valid_ctrl check to report out-of-range
    bits with their bitmask, which is more informative than reporting the
    parse position.
  - Drop the -ENODEV "no more entries" signal. *endptr is now advanced
    past the delimiter so callers terminate the loop naturally via
    while (*p).
Patch 5:
  - In pci_param_config_acs(): when ECAP is supported by the device add
    the ECAP control bits (GENMASK_U16(12, 7)) to valid_ctrl.
  - Validate DMAC/UMAC reserved encoding against the prospective ctrl
    value rather than enabled_bits alone, so the case where the user
    enables one bit while fw_ctrl already has the other set is also
    caught.
Patch 6:
  - In pci_acs_ecap_enabled(): Add a defensive NULL check for the upstream
    port before dereferencing it. While standard downstream ports should
    always have an upstream port, this guards against kernel panics in
    malformed topologies. (Sashiko-bot)
  - Remove the redundant pdev->acs_capabilities & PCI_ACS_ECAP condition
    in pci_acs_flags_enabled(). The preceding bitwise operation
    (acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC))
    already guarantees that acs_flags will only contain the PCI_ACS_ECAP
    bit if the device actually supports it.
  v7 Link: https://lore.kernel.org/all/SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v6->v7 changes:
 - Rebased onto next-20260505 (based on v7.1-rc2)
 - Picked up Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
 - No functional changes
 v6 Link: https://lore.kernel.org/all/SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com/

v5->v6 changes:
- Patch 3: In pci_dev_str_match(), explicitly set `ret = 0` when no
  matching string is found. This resolves a smatch warning that `ret`
  returned from sscanf() may be 2 or 4 even though no matching string
  is found later comparison.
  v5 Link: https://lore.kernel.org/all/SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v4->v5 changes:
- Added significant refactoring of the core ACS implementation (Patches
  1-4) to improve validation, safety, and readability;
- For USP and DSP Memory Target Access Control, added masks and enum
  values for the encodings and explicitly rejected the reserved encoding
  (0b11);
- In pci_acs_ecap_enabled(), removed the use of 'is_dsp' variable.
  v4 Link: https://lore.kernel.org/all/SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v3->v4 changes:
- In pci_acs_ecap_enabled(): Check the pcie type for
  PCI_EXP_TYPE_DOWNSTREAM explicitly.
  v3 Link: https://lore.kernel.org/all/SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v2->v3 changes:
- Drop the warning when a device has no support for the enhanced
  capability.
  v2 Link: https://lore.kernel.org/all/SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v1->v2 changes:
- Enabled all enhanced ACS controls by default, rather than just Unclaimed
  Request Redirect (which addressed the primary issue we encountered);
- Added checks for enhanced ACS controls on Root and Downstream Ports in
  pci_acs_enabled() to ensure proper enablement when grouping devices or
  enabling features such as IOMMU PASID.
  v1 Link: https://lore.kernel.org/all/SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

Thanks to Jason Gunthorpe, Jonathan Cameron, Dan Carpenter,
Krzysztof Wilczyński, and Randy Dunlap for reviewing the patchset.

Patches on github: https://github.com/wei-w-wang/linux/tree/v9-acs-enhanced-cap-and-refactor

Wei Wang (6):
  PCI: Validate ACS control bits against device-specific ACS
    capabilities
  Documentation/kernel-parameters: Add multi-device config_acs example
  PCI: Consolidate delimiter handling into pci_dev_str_match()
  PCI: Refactor disable_acs_redir and config_acs param handling
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         |  30 +-
 drivers/pci/pci.c                             | 313 +++++++++++++-----
 include/uapi/linux/pci_regs.h                 |  13 +
 3 files changed, 257 insertions(+), 99 deletions(-)


base-commit: 32b6ef9a5d0eca44f9cd91f52f4faa89f145a0de
-- 
2.51.0

