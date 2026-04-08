Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505039F182;
	Wed,  8 Apr 2026 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636631; cv=fail; b=unN7A5IT9gGbM5mbZXT5gC+xvCcY2Vxn8abb5MoOHY4/D0H1GgUKCJNNaNCJ86t7ukQylOD+FERW0D5x8pyNSrAnicDVoBqHLBFcPMWTb04YX2L0ckd8AZKCZWg2VEjMcScwJUEHzUnOf2N5EXx692BRpHg4fsIxyBeGOSPrAqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636631; c=relaxed/simple;
	bh=DR9Dw6E7fB9cdGI3STFls7Hu9u5W0Harsgl5zsDufpI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CpEigL09qIY1Bz2Dyyvkrolw5UmCg0Kjg8vM+Xac7+5JTZc62dwHC3D20nfVe+rld4HHq0Rt6gokC5YOaH5AJlph7QFcMEOR5libcCwwGQQqpHspEDFDm8aYRYmiJ3cMPNPgmMU2ZLtsaljrqcHfuHXTJFzqqGueqZaLXnIt+a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pus9zqqu; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pus9zqqu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXxuvE4lGs/MKrMP/IESGw4VJxp0swVxZnQp0BSXKXZ/nJNO2LnDLfR4sRFRLnB3hNuuX0k0JtVl9Etx1LzgsASPhJFmwN/xrQpW96yAAQzxsVvoYDR7zuAXsZKa2qudkb1VNKt+dWCSuotiwTl9lSykgTABhrryDAm4L5zdvQj+F5AT2l0fr2OPDODcS/Z8JrBPdL/1fcwQ+m+mZFQyY1B8hrhyfs2E6x5iZtZpA67C6TDmDPW8QsmIQZlNPN/E/sj25iLJuNzPGQC7R995QuICUsBX0HHNVF3fkALlYDSORX7Yb3kT9Fa1E3CMccBJNvE1tgr1ZH0k6m+huLXc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YHQldOidZVcmBCMFwzfGK3flV9oZNcKEwvgygB/Lz0=;
 b=OTp27cGCs9KZp5KKET3Fs+Qaruqnx1KINE18bCkmVwUaESXgOLdgl9SRwceI1/MAJZ5GVZIVduCvWczERRz68T9i6/fiQW6ZkxlxYmlNXmme/kU4TlApVvzALRom9eQJggMYtjs1p5hOl4rUSVj1DKXNk2HdR/4zSNDdGdl2ry7b7qwSAwM/8xJM5IqXahhHpCNc5YwDtUFhANqBDtEN8fxJNBe454O6N5TBA5pS11GDsksnN9ifLts0k2CaKVf4pDlgWN95X/wMW676D3nwxCHwnbij4zCTH2GhxlKDezdm7FCvmtf0fpQyBramw5Ll2SvxYOgqjxpx2cpMUyQkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YHQldOidZVcmBCMFwzfGK3flV9oZNcKEwvgygB/Lz0=;
 b=pus9zqqufu5IBS4LDy/C1VkyCUNr2DUXtc13YQIHAJN72AFFgKvhU2y69Dancoqkl9mLYFHHkbXMt5mf/gkCuyQYgqPyvUs/jjE/uxCyZIyye/dKA6yM+7cTrbw2feAomqALo6Rgye5bsv7GNuTgSIQEczfePuOTOdlFpUDamfFh3HVdj4PBaTa+01nMEFiKnax1a17arL8TAM3KOdX6XgDBrYt8UBwcggli4vcMgW0zj+JTMwsRXHzLMH2QUd7yksd8xrl4sf+5cC/Z0wKDW2NZqNYRTj4iK/Vk+cS4B5DVVHTIQ3/luvcX0LuH5YI2H4EMB7l/ZULwaAGuoZX3iA==
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18) by PN0PR01MB8944.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:11d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 08:23:43 +0000
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4]) by MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:23:42 +0000
Message-ID:
 <MA5PR01MB1250063E305B83699BCFB3DC2FE5BA@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 8 Apr 2026 16:23:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: cadence: Add flags for disabling ASPM support
 advertisement
To: Yao Zi <me@ziyao.cc>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Hans Zhang <18255117159@163.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manikandan K Pillai <mpillai@cadence.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Han Gao <gaohan@iscas.ac.cn>
References: <20260405154154.46829-1-me@ziyao.cc>
 <20260405154154.46829-2-me@ziyao.cc>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20260405154154.46829-2-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18)
X-Microsoft-Original-Message-ID:
 <06ed06e0-5236-4bb0-a69c-1c989c56abd3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12500:EE_|PN0PR01MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 638f7ada-4ebb-470c-f205-08de954824fd
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0QdkvoStqqmjQr2HVGJRMKouj/Z9vMF8JVNmMf04ZPhc/hOL3ShDv/2WMxf+mc4yWvaHHuGrfTq7HjVPaSPlwRhgAPyKMz51d/1RNxNsL09gDTKCX1L+eLsmyOZT8LN1cQeeKsQSobuIFAPXgG0v96DemX2B63RE55A/12pqUOGTnUGJg4xUMVeTX1xC08eE6essWpXVehBGQ/WfRBTRg8uIBNbhSKrGhlFGz+50zsMxfwe7Kb4ZzAcyDurqPjN6lF0fNJxC/+oiwrn6DM8ZewiXFuIfBybIgVLaeXB6WaOa8WT55OEQakFDi0DoWZgCT/ahjn0Lm41jAdYAnWv2oQPd1f7qVL5bSOH2N/0SGYTrgaikkMaMnk2AZyjSgaDq1oQQ9ZzSJFaKLoytIvQv7zcgzdxV1mDJxoQ2yb9C9Nm2c3tZ4zDUWKLYGQE5/kaGDLmAXUVjYNKPAKk83Tbt0RLQjzzZaS3eBegITFOxu67MHWWoqOXKj4Einz5eCTf8QtV1v77+vrtLm1O36ImfIY5jJAYzG7smyyD3K9sYM8b43XmIIrZw/E4qc51AmIuUnqstmJkzQQQyHxnMBnZlEZl2Jkc5gMiAZvi9t4zCN3nJbbRZTfqw0CukJYqatpqSWvyHmV4D9DNewFuTFYaDi6nuHbsaxvrCJ/cqxAc3OCwCP6D7CupO9nieTrcPZXFNVdaRsuAYnqJLEflyMqiD8aoJOy6v0c9I5Xn9RXkw4DQs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|22091999003|24121999003|51005399006|25031999004|41001999006|19110799012|6090799003|461199028|5072599009|8060799015|15080799012|40105399003|3412199025|440099028|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUo2OVpBek9QZ0lCRzZNOTZtQU9GbUJ6UW1vKzdhMUN2SGJOZFgzTVJnNXhL?=
 =?utf-8?B?MThrN0Y1Q2tFb2pJSDA2eGhBS2tYRlZMRE9NcXp6NFhKRlBvd2hRV2U5KzZF?=
 =?utf-8?B?dTJ2UkFoQk13MWJ0KzQ1Q2NOZzBnUSswU1E4aVlUKzM0cVNvNDFWRzBSRjNB?=
 =?utf-8?B?ekNKeVZ0VzhqZnNsVm5HVnlORExMbjZuOVdsMjZZMGw3dkxiTWxWYmlLaHMv?=
 =?utf-8?B?T2YwMkhXYTh4M2QreVpJcXlhSlJYZmJPeUlVSTRhWUY4SHRuOStUUTR6ZXFT?=
 =?utf-8?B?ZHFnV25Jby96NWlZL0g5YXFaV29GNU1xa2NkNXZNaVhlRnVuQ1NZOFM0cTRl?=
 =?utf-8?B?bUwyOERzcWF3QlhiUjdqTGZxZGJvZzZTU2RDTU14ZVcvMThoS2NSSlRwOCt6?=
 =?utf-8?B?RUlKYUtrditnR1RYMTluYUFySk1LUHBIanhEL1U3YzJQZ2xlUDJJZi9kL2Jh?=
 =?utf-8?B?d2ZzMy95NGM4TkZneHpPcTZFWmdpU3pIR3ZZZHRIREc1L2ZDYzhURXBZSytD?=
 =?utf-8?B?dGpsV2NTOVREbEgwdjZLWFFMQ0g3Q011bFRpRnY0MnM3cEk1d0gyQUVUOGRI?=
 =?utf-8?B?K0w5bGVLNjNuVElYTzlHbFZ5c0taMG1XbHVROWtvTUJ5THpFMGQ1UVdlYzg3?=
 =?utf-8?B?R3pweXdpalJENGZCQm0zNlFaOVhMekVWUWE1Ym1SLzVFUVVEUFR5ZTBuZi9Z?=
 =?utf-8?B?WjJqZ1dROUFGellNTDJMYnlmVENmN0dvRUlPN0RRbkpUcjc5SWUyY1VEUnVB?=
 =?utf-8?B?MkFPaWNRelpOaVUrVUp0eGVzOXEvQzdXd2hkNkZBQStNQTdZdGJrSVJCMlkv?=
 =?utf-8?B?L3lZUGlSenF4MGdkQWVKdFZmSDJSSlJhTCs4R0tTMGQ1R2hkV2dBcUFhbkMw?=
 =?utf-8?B?UGpEQmw4Vk1GcFdsK01BYlQ1dTQ0N0JWUktKMzBhZWxQcGc4b0Y4ejc5anAv?=
 =?utf-8?B?U21mbUM3eWVpTFlselFCUWlNUWFQWTMwRUFCUURVSzdKUllmekJydEc2SWVO?=
 =?utf-8?B?bzArK2M0cWUydkt2ZmZSODFWa2Y5TzJwMmdFWE4vVG55T3Nvbkh3NXdXbUpi?=
 =?utf-8?B?QnZVOWZNTjJjbFJ6eEFFbmQyRnE1YzhIblNhU095YXAvUjhLbnhYaVFBQm5N?=
 =?utf-8?B?eWY3SWdOazdESkNjbVM4TFhQekJxa1VCOWJMbkp4RXhqdEliWTNxMnZ5dmtq?=
 =?utf-8?B?VnpPSDh6Q3dpYWRGa2NPSjBFYnlmZjNmYjI0QjdtV1prYVlZMG8rNXlLRE5p?=
 =?utf-8?B?K0ZXdVRUYWJ6OXdadXZibzlDRzZZMS9ESm16N0pBempaZDZxeWY2NldDTUZx?=
 =?utf-8?B?T0xPOWFISXhialFyQmVzZ2ltM1ZKUVZvY1JLc1Z5aHptVzlaZzhiTmI2TU9o?=
 =?utf-8?B?cHZpR1IvdzgwSEluTHo1SFU5RTBQcDQwenZyWUJKWHhOdGt3WWV3Zkl4RzI5?=
 =?utf-8?B?UzVma3hRUUZzbkJ6aHlqb0lRbk1CRkEvWW9tRnpVOHZTYUI2MXFPdGQyczg3?=
 =?utf-8?Q?FTfUnA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmRicWJ1SGlPOURPUXVNOFlHZEpnWUxEeGlEczFxS3daWmx5UlBOODV3SzFq?=
 =?utf-8?B?UXNBeUhNNVo4QXl4Y3R6RkVFcndZSkFDZ0VVTFJHWXNsRVdJZU9qTW9nMnJW?=
 =?utf-8?B?dCtmQUkyS2lsU25Ja2FSZjF0NEd6ck93VEwrK3hlNUQyNWFjczFha0hia3ZX?=
 =?utf-8?B?WHhOWGNreGl1ZTNQcFpkbjAzN3hLM0hzV1gzZENtWmNXYTJKMXVseS9NSGw3?=
 =?utf-8?B?bzl0b0VrWVlFNFNyWXJKYzltMlluMnVSWlZqek9GVlUrN2pUUEluYnQ5WnVj?=
 =?utf-8?B?d042d2VvSFJMTUt0ejFaSFNiYjZFOE45RjVKNDZEVnBsLzBQb0FnZFBwcHQ1?=
 =?utf-8?B?T1I5ZS8vSUVjWXNCTi9aMEE3ZmJnb05zTjV6RTNkUy9uVWpFTEdPMWJ5d0Vq?=
 =?utf-8?B?MGdaTkFFUVNpUS96QXYzTmVYVnBxN0hPK0toVTJESmVxem5MMDBUamVHOVJS?=
 =?utf-8?B?NlNvWXYyRTVpTzlJbkxIUHlCejlyZDNYa1dSOFplOXZ4eU0rRDZObkdmc3o2?=
 =?utf-8?B?RFRXbGh2bE00SWM0cER1bnRPRVJDaEhlYUtjenhLcFV4YVRSL2k2WExSOFhK?=
 =?utf-8?B?VUg0Q3l6RkxZSjllZWhpOU1UUjdUSHhsbHBML2pKTFVjeVpVNTFYZityNkkr?=
 =?utf-8?B?eHdsVG5EZVVzZDlPblVYVEM2aHZ6NHloOWl2QkUvVmRuNW9Sd3FxKzFrM2xP?=
 =?utf-8?B?cy9QTVR3alVGWlBGSXU4bXgxZjVhZVV1S2VnbmpicW1BTjNhU3hISDRZbUF2?=
 =?utf-8?B?RDV1djhGR3VMSXdkTVNBak9vOEZ6cmRRMzR2OGpXdzBnalZ0WnZsOThLamVW?=
 =?utf-8?B?UjAwYTFiTDNTcG9HbjBjRHc3aEhxVUFONDE4RWNHSTZXRkhEL1ZrQ1V4eVVr?=
 =?utf-8?B?RExCNnVCMlE0UFFyenJJOG0vZnQ4cyt1SEI5N3hiV3pVcDdjMXU2ZzJVTHRr?=
 =?utf-8?B?ajNDNHptTlhaS2lvRy9OV1A3UlZFWlVRZHlhaVFsWTcrSUhXMmZVTTF1bHY4?=
 =?utf-8?B?aEpGQnlicDdDV0pmVDFMQlBXQ2REU1RqWWJrWmtIVE9SMnhSdG5zbnVaaHFT?=
 =?utf-8?B?Uyt3a2NVM21yVDBHVmZ5QjZENEhSN1pUZHB1cC9CK0xnL2FvdFVXMG1wL2lj?=
 =?utf-8?B?UHNvTkFqVjhnRlZrR21zZnB6U3JlMjdkbXg0N0dZcHcrQXNDUDBlQURzNGxD?=
 =?utf-8?B?SkZLZ0NBeUdyMTFIUmF1RzhTYXRlelV2UFd6WFltYjNrbmEyUmdoczZzaXUz?=
 =?utf-8?B?Smo2cFhNd2lwM2NvcEVCbHlBV0tHbHFYY2l4OWlUNE1UR3ZuMlA5aDZQcTFL?=
 =?utf-8?B?V1pYaHl0c0NYLzRuMkViT1EyeGZSNnFvNUlwaFM1SG9MZ0hQNnhTMG9TeC9y?=
 =?utf-8?B?eGJDY1l1NWxuQWZGZXJtWXhkdkxHVG5tWXBmbHZmQ3B1R3VMNEl0VWRmdjFT?=
 =?utf-8?B?bzFhYzRDU3pmd251WFZFVU9iNlUyRDJPN1pLclhuajRNQ1o0aWR6NlFOcENw?=
 =?utf-8?B?clVaOEhyaWU3MkhRTnBNVS9BRi9tQnJvbjloTDhidEdBZEROQkpGK2dNQncz?=
 =?utf-8?B?V1ladE4wY2draFVjYWxENWVCNmNkVkhUM2tRT0V0RWsrMkpBSHpEcXdDSHJZ?=
 =?utf-8?B?eVlPZjhXdUdSL0xRSW0vQUtlMC8rNVNwYkd5T2lvR2ZnNjlRZGNTWmZkQWNi?=
 =?utf-8?B?TmtXN1hDQlNSSUhXdnVsRjY3K21kcUg1cVVkVDJaZUFwei9vajFmOUttWnNX?=
 =?utf-8?B?SHRPQlcrejVUQVcya3JLSDVRenoxVDViZXBiaHFBTUhhWDVNV2lMSHIycisy?=
 =?utf-8?B?ZjFDZkJuWjNsMmVzK2JQT0I2YW5nQnk1bHBJVlF4YkdBRE44YW0wSWlOUVph?=
 =?utf-8?B?TWZtOU9yMjZyNTZTZ0IyU1pHSlg4dWV1bFVxem5sZXYwOGo0LzFzR1h3Q1NV?=
 =?utf-8?Q?5wHqMZBFTCmYcuQbJSTBWbwI4Qoh/sjR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638f7ada-4ebb-470c-f205-08de954824fd
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:23:42.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8944


On 4/5/2026 11:41 PM, Yao Zi wrote:
> Add flags for disabling advertisement of ASPM L0s/L1 states by clearing
> corresponding bits in Link Capabilities Register through the local
> management bus, allowing ASPM to be disabled on platforms which don't
> support it.
>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Tested-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>   .../controller/cadence/pcie-cadence-host.c    |  7 +++++++
>   drivers/pci/controller/cadence/pcie-cadence.h | 19 +++++++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index db3154c1eccb..0bc9e6e90e0e 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -147,6 +147,13 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>   	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>   	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>   
> +	value = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP);
> +	if (rc->quirk_broken_aspm_l0s)
> +		value &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> +	if (rc->quirk_broken_aspm_l1)
> +		value &= ~PCI_EXP_LNKCAP_ASPM_L1;
> +	cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP, value);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 443033c607d7..32a5666204f5 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -115,6 +115,8 @@ struct cdns_pcie {
>    * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
>    * @ecam_supported: Whether the ECAM is supported
>    * @no_inbound_map: Whether inbound mapping is supported
> + * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk.
> + * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk.
>    */
>   struct cdns_pcie_rc {
>   	struct cdns_pcie	pcie;
> @@ -127,6 +129,8 @@ struct cdns_pcie_rc {
>   	unsigned int		quirk_detect_quiet_flag:1;
>   	unsigned int            ecam_supported:1;
>   	unsigned int            no_inbound_map:1;
> +	unsigned int            quirk_broken_aspm_l0s:1;
> +	unsigned int            quirk_broken_aspm_l1:1;
>   };
>   
>   /**
> @@ -344,6 +348,21 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
>   	return cdns_pcie_read_sz(addr, 0x2);
>   }
>   
> +static inline void cdns_pcie_rp_writel(struct cdns_pcie *pcie,
> +				       u32 reg, u32 value)
> +{
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +	cdns_pcie_write_sz(addr, 0x4, value);
> +}
> +
> +static inline u32 cdns_pcie_rp_readl(struct cdns_pcie *pcie, u32 reg)
> +{
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +	return cdns_pcie_read_sz(addr, 0x4);
> +}
> +
>   static inline void cdns_pcie_hpa_rp_writeb(struct cdns_pcie *pcie,
>   					   u32 reg, u8 value)
>   {

LGTM.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Tested-by: Chen Wang <unicorn_wang@outlook.com> on Pioneerbox.

Thanks,

Chen


